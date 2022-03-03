autoload -Uz compinit
compinit

# zmodload zsh/zprof && zprof
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export FZF_DEFAULT_OPTS="--no-sort --exact --cycle --multi --ansi --reverse --border --sync --bind=ctrl-t:toggle --bind=ctrl-k:kill-line --bind=?:toggle-preview --bind=down:preview-down --bind=up:preview-up"

# export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

## enhancd
source .sh-utils/enhancd/init.sh

## tmux
# Autostart if not already in tmux.
function tstart(){
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

}
tstart

### user functions
# fzf util for git
function tree_select() {
  tree -N -a --charset=o -f -I '.git|.idea|resolution-cache|target/streams|node_modules' | \
    fzf | \
      sed -e "s/ ->.*\$//g" | \
      tr -d '\||`| ' | \
      tr '\n' ' ' | \
      sed -e "s/--//g" | \
      xargs echo
}

# treeから選択したファイルをvimで開く
function ftree_vim(){
  local selected_file=$(tree_select)
  if [ -n "$selected_file" ]; then
    BUFFER="vim $selected_file"
  fi
  zle accept-line
}
zle -N ftree_vim
bindkey "^^" ftree_vim

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
fbrm() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

function fadd() {
  local out q n addfiles
  while out=$(
      git status --short |
      awk '{if (substr($0,2,1) !~ / /) print $2}' |
      fzf-tmux --multi --exit-0 --expect=ctrl-d); do
    q=$(head -1 <<< "$out")
    n=$[$(wc -l <<< "$out") - 1]
    addfiles=(`echo $(tail "-$n" <<< "$out")`)
    [[ -z "$addfiles" ]] && continue
    if [ "$q" = ctrl-d ]; then
      git diff --color=always $addfiles | less -R
    else
      git add $addfiles
    fi
  done
}

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


## fvim - vim to selected file
function fvim(){
  local file=$(fzf)
  if [ $file ]; then
    vim $file
  fi
  zle accept-line
}
zle -N fvim

function fcd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                ls -p --color=always "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}
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

function to_gifs(){
  ls | grep -E ".(mov)$" | sed 's/\..*//' | xargs -I {} ffmpeg -i {}.mov -vf scale=800:-1 -y  -r 5 {}.gif
}

function resize_images(){
  local EX="png"
  local SIZE=1000
  
  if [ $1 ]; then
    EX=$1
  fi

  if [ $2 ]; then
    SIZE=$2
  fi

  # local ARG1=$(echo \$_= \"\$N-$IMG_NAME\")
  # local EXE1="rename -N 01 -X -e '${ARG1}' *.${EX}"
  # echo $EXE1
  # $(eval ${EXE1})
  # local EXE2="rename -S '-' '_' *.${EX}"
  # echo $EXE2
  $(eval ${EXE2})


  # 2 mkdir
  echo 'mkdir'
  mkdir ./min
  # 3 resize
  local EXE3="ls | grep -E '.(jpg|png|jpeg)$' | xargs -I {} ffmpeg -i {} -vf scale=${SIZE}:-1 -y min/{}"
  echo $EXE3
  $(eval ${EXE3})

  # 4
  local EXE4="builtin cd ./min && minimage && builtin cd ../"
  echo $EXE4
  $(eval ${EXE4})
}



function testecho(){
  local NAME="test test"
  if [ $# != 1 ]; then
  else
    NAME=$1
  fi
  echo $NAME
}

## Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"

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
