# zmodload zsh/zprof && zprof
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


## tmux
# Autostart if not already in tmux.
if [[ ! -n $TMUX && $- == *l* ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | $PERCOL | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi




### user functions
## git diff
function git_diff_archive()
{
  local diff=""
  local h="HEAD"
  if [ $# -eq 1 ]; then
    if expr "$1" : '[0-9]*$' > /dev/null ; then
      diff="HEAD~${1} HEAD"
    else
      diff="${1} HEAD"
    fi
  elif [ $# -eq 2 ]; then
    diff="${2} ${1}"
    h=$1
  fi
  if [ "$diff" != "" ]; then
    diff="git diff --diff-filter=d --name-only ${diff}"
  fi
  git archive --format=zip --prefix=root/ $h `eval $diff` -o archive.zip
}

alias git_diff_archive=git_diff_archive


## image minimize
function pngmin()
{
  find . -type f | grep ".png$" | xargs -I{} pngquant --verbose --speed 6 --ext .png {} --force
}

alias pngmin=pngmin

function jpgmin()
{
  find . -type f | grep -E '[jJ][pP][eE]?[gG]$' | xargs -I{} jpegoptim -m70 --overwrite --preserve {}
}

alias jpgmin=jpgmin

function minimage()
{
  pngmin
  jpgmin
}

alias minimage=minimage


function seqrename(){
  rename -N 01 -X -e '$_ = "$N-image"' *.png
  rename -S '-' '_' *.png
}

## Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


## ESPRESS for ESP32
export IDF_PATH="$HOME/esp/esp-idf"
export IDF_TOOLS_PATH="$HOME/.espressif/tools"



## flutter
export PATH="$PATH:`pwd`/development/flutter/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi


