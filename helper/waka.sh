#!/usr/bin/env bash

function WakaTermux() {
  echo -e "\n‏‏‎‏‏‎ ‎ ‎‏‏‎  ‎📦 Installing WakaTime (Waka-Termux)\n"
  stat "CHECK" "Warning" "'${COLOR_WARNING}Waka-Termux${COLOR_BASED}'"

  for _pkg in python; do
    if ! pkg list-installed $_pkg 2>/dev/null | grep -q "^$_pkg/"; then
      start_animation "       Installing '${COLOR_SUCCESS}$_pkg${COLOR_BASED}' ..."
      pkg i -y $_pkg &>/dev/null
      stop_animation $?
    fi
  done

  if ! pip show wakatime >/dev/null 2>&1; then
    start_animation "       Installing '${COLOR_SUCCESS}wakatime${COLOR_BASED}' (pip) ..."
    pip install wakatime >/dev/null 2>&1
    stop_animation $?
  else
    stat "RESULT" "Success" "'${COLOR_SUCCESS}wakatime${COLOR_BASED}' already installed (pip)"
  fi

  mkdir -p "$HOME/.wakatime"

  for _rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
    [ -f "$_rc" ] || touch "$_rc"
    if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$_rc" 2>/dev/null; then
      echo 'export PATH="$HOME/.local/bin:$PATH"' >>"$_rc"
    fi
  done

  for _rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
    if ! grep -q '__wakatime_track' "$_rc" 2>/dev/null; then
      cat >>"$_rc" <<'EOF'

if command -v wakatime >/dev/null 2>&1; then
    set +m
    __wakatime_get_project() {
        local _dir="${1:-$PWD}"
        if [ "$_dir" = "$HOME" ]; then echo "Home Termux"; else basename "$_dir"; fi
    }
    __wakatime_get_lang() {
        local _dir="${1:-$PWD}"
        if [ "$_dir" = "$HOME" ]; then echo "C"; else echo "Bash"; fi
    }
    __wakatime_detect_lang() {
        local _file="$1"
        case "${_file##*.}" in
            py) echo "Python" ;; js) echo "JavaScript" ;; ts) echo "TypeScript" ;;
            jsx) echo "JSX" ;; tsx) echo "TSX" ;; sh|bash) echo "Bash" ;;
            c) echo "C" ;; cpp|cc|cxx) echo "C++" ;; h|hpp) echo "C" ;;
            java) echo "Java" ;; kt) echo "Kotlin" ;; go) echo "Go" ;;
            rs) echo "Rust" ;; rb) echo "Ruby" ;; php) echo "PHP" ;;
            html|htm) echo "HTML" ;; css) echo "CSS" ;; json) echo "JSON" ;;
            xml) echo "XML" ;; yml|yaml) echo "YAML" ;; md) echo "Markdown" ;;
            sql) echo "SQL" ;; dart) echo "Dart" ;; swift) echo "Swift" ;;
            lua) echo "Lua" ;; r|R) echo "R" ;; toml) echo "TOML" ;;
            ini|cfg) echo "INI" ;; txt) echo "Text" ;; *) echo "Unknown" ;;
        esac
    }
    __wakatime_scan_files() {
        local _dir="$1" _project="$2" _count=0 _scan_file="$HOME/.wakatime/.scan_${_project}"
        if [ -f "$_scan_file" ]; then local _last_scan _now; _last_scan=$(cat "$_scan_file" 2>/dev/null); _now=$(date +%s); [ $((_now - _last_scan)) -lt 120 ] && return; fi
        for _entry in "$_dir"/*; do [ -f "$_entry" ] || continue; local _basename="${_entry##*/}"; case "$_basename" in .*) continue ;; esac; case "$_basename" in *.tar.gz|*.zip|*.7z|*.rar) continue ;; esac; local _lang; _lang=$(__wakatime_detect_lang "$_basename"); wakatime --plugin "termux-bash/1.5" --entity "$_entry" --entity-type file --project "$_project" --language "$_lang" --category coding --write >/dev/null 2>&1; _count=$((_count + 1)); done; date +%s >"$_scan_file" 2>/dev/null
    }
    __wakatime_track() {
        local _path="$PWD" _project=$(__wakatime_get_project "$_path") _lang=$(__wakatime_get_lang "$_path")
        echo "$_path" >"$HOME/.wakatime/.current_dir" 2>/dev/null
        ( wakatime --plugin "termux-bash/1.5" --entity "$_path" --entity-type file --project "$_project" --language "$_lang" --category coding --write >/dev/null 2>&1 ) </dev/null >/dev/null 2>&1 & disown 2>/dev/null
    }
    __wakatime_backup() {
        local _path="$1" _project="$2" _backup_dir="$HOME/.wakatime/backups"; mkdir -p "$_backup_dir"; [ "$_project" = "Home Termux" ] && return; [[ "$_path" == "$_backup_dir"* ]] && return; local _last_backup="$_backup_dir/.$_project.last_backup" _now _last=0; _now=$(date +%s); [ -f "$_last_backup" ] && _last=$(cat "$_last_backup"); if [ $((_now - _last)) -gt 86400 ]; then ( tar -czf "$_backup_dir/${_project}_$(date +%Y%m%d_%H%M%S).tar.gz" -C "$(dirname "$_path")" "$(basename "$_path")" --exclude=".git" --exclude="node_modules" --exclude="*.tar.gz" >/dev/null 2>&1; echo "$_now" >"$_last_backup"; local _i=0; for _bf in $(find "$_backup_dir" -maxdepth 1 -name "${_project}_*.tar.gz" -type f -printf '%T@ %p\n' 2>/dev/null | sort -rn | cut -d' ' -f2-); do _i=$((_i + 1)); [ "$_i" -gt 5 ] && rm -f "$_bf"; done ) & disown 2>/dev/null; fi
    }
    __wakatime_timer() {
        local _tmpfile="$HOME/.wakatime/.current_dir"; echo "$PWD" >"$_tmpfile"
        while true; do local _path _project _lang; _path=$(cat "$_tmpfile" 2>/dev/null || echo "$HOME"); _project=$(__wakatime_get_project "$_path"); _lang=$(__wakatime_get_lang "$_path"); wakatime --plugin "termux-bash/1.5" --entity "$_path" --entity-type file --project "$_project" --language "$_lang" --category coding --write >/dev/null 2>&1; [ "$_project" != "Home Termux" ] && __wakatime_scan_files "$_path" "$_project"; [ "$_project" != "Home Termux" ] && __wakatime_backup "$_path" "$_project"; sleep 60; done
    }
    PROMPT_COMMAND="__wakatime_track${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
    if [ -z "$WAKATIME_TIMER_STARTED" ]; then export WAKATIME_TIMER_STARTED=1; __wakatime_timer </dev/null >/dev/null 2>&1 & disown 2>/dev/null; fi
fi
EOF
      stat "RESULT" "Success" "WakaTime hook -> '${COLOR_SUCCESS}${_rc}${COLOR_BASED}'"
    else
      stat "RESULT" "Warning" "WakaTime already in '${COLOR_WARNING}${_rc}${COLOR_BASED}', skip"
    fi
  done

  WAKA_CFG="$HOME/.wakatime.cfg"
  if [ ! -f "$WAKA_CFG" ] || ! grep -q "api_key" "$WAKA_CFG" 2>/dev/null; then
    cat >"$WAKA_CFG" <<'EOF'
[settings]
api_key = waka_api
debug = false
hidefilenames = false
ignore =
    COMMIT_EDITMSG$
    PULLREQ_EDITMSG$
    MERGE_MSG$
    TAG_EDITMSG$
EOF
    stat "RESULT" "Success" "WakaTime config '${COLOR_SUCCESS}$WAKA_CFG${COLOR_BASED}' (ganti waka_api dengan API key https://wakatime.com/settings/account)"
  else
    sed -i 's/hidefilenames = true/hidefilenames = false/g' "$WAKA_CFG" 2>/dev/null
    stat "RESULT" "Warning" "WakaTime config exists, skip"
  fi

  stat "RESULT" "Success" "'${COLOR_SUCCESS}Waka-Termux${COLOR_BASED}' ready — edit '${COLOR_WARNING}~/.wakatime.cfg${COLOR_BASED}' isi api_key, lalu '${COLOR_SUCCESS}source ~/.zshrc${COLOR_BASED}'"
}
