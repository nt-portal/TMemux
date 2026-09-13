
ZSH_THEME_GIT_PROMPT_PREFIX="%F{blue} git:(%F{red}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{blue})%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{yellow}✗%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

_venv_info(){ [[ -n $VIRTUAL_ENV ]] && echo "%F{blue}(%F{yellow}$(basename $VIRTUAL_ENV)%F{blue})-"; }

if [[ $EUID -eq 0 ]]; then
  PROMPT='%F{red}┌──$( _venv_info)%F{red}(%F{white}home%F{red}@%F{white}termux%F{red})-[%F{white}%~%F{red}]%f$(git_prompt_info)
%F{red}└─%F{white}%#%f '
else
  PROMPT='%F{blue}┌──$(_venv_info)%F{blue}(%F{red}home%F{yellow}@%F{red}termux%F{blue})-[%F{white}%~%F{blue}]%f$(git_prompt_info)
%(?:%F{blue}└─%F{white} $ :%F{red}└─%F{red} $ )%f'
fi
