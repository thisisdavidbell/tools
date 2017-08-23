# Git branch in prompt.
RED=
parse_git_branch() {
    BRANCH=none
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'`
    if [ ! -z $BRANCH ] && [ $BRANCH == "(master)" ]; then
      echo "$BRANCH";
    else
      echo "$BRANCH";
#      echo -e "\\033[32m$BRANCH\\033[00m";
    fi
}

parse_kube_target() {
#    bx cs cluster-config prod > /dev/null 2>&1
#    if [ $? -ne 0 ]; then
#      echo;
#    el
    if [[ -z $KUBECONFIG ]]; then
      echo;
    else
      cat $KUBECONFIG 2> /dev/null | grep name | head -1 | cut -d ' ' -f 3 | sed 's_\([a-zA-Z0-9][a-zA-Z0-9]*\)_(\1)_';
    fi
}

setPS1() {
  THEBRANCH=$(parse_git_branch)
  if [ ! -z $THEBRANCH ] && [ $THEBRANCH == "(master)" ]; then
    export PS1="\W\[\033[31m\]\$THEBRANCH\[\033[00m\]\[\033[31m\]\$(parse_kube_target)\[\033[00m\] $ "
  else
    export PS1="\W\[\033[32m\]\$THEBRANCH\[\033[00m\]\[\033[31m\]\$(parse_kube_target)\[\033[00m\] $ "
  fi

}

PROMPT_COMMAND=setPS1
