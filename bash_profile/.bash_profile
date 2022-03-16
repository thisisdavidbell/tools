# Git branch in prompt.
RED="\033[31m"
AMBER="\033[33m"
GREEN="\033[32m"
ENDCOLOUR="\033[0m"
HIGHLIGHT="$(tput rev)"
HIGHLIGHTOFF="$(tput sgr0)"

parse_git_branch() {
    BRANCH=none
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'`
    echo $BRANCH
}

parse_kube_target() {
    if [[ -z $KUBECONFIG ]]; then
      echo;
    else
      cat $KUBECONFIG 2> /dev/null | grep name | head -1 | awk 'NF>1{print $NF}' | sed 's_\([a-zA-Z0-9][a-zA-Z0-9\-]*\)_(\1)_';
    fi
}

setPS1() {
  THE_BRANCH=$(parse_git_branch)
  if [ ! -z "$THE_BRANCH" ] && [ "$THE_BRANCH" == "(master)" ]; then
    FORMATTED_BRANCH="\[${RED}\]\${THE_BRANCH}\[${ENDCOLOUR}\]"
	else
		FORMATTED_BRANCH="\[${GREEN}\]\${THE_BRANCH}\[${ENDCOLOUR}\]"
	fi

	THE_KUBE_TARGET=$(parse_kube_target)
	if [ "$THE_KUBE_TARGET" == "(us-preprod-hub0)" ] || [ "$THE_KUBE_TARGET" == "(us-preprod-sat0)" ] || [ "$THE_KUBE_TARGET" == "(us-betaprod-hub0)" ] || [ "$THE_KUBE_TARGET" == "(us-betaprod-sat0)" ]; then
		FORMATTED_KUBE_TARGET="\[${HIGHLIGHT}${RED}\]\${THE_KUBE_TARGET}\[${ENDCOLOUR}${HIGHLIGHTOFF}\]"
	elif [ "$THE_KUBE_TARGET" == "(prod)" ] || [ "$THE_KUBE_TARGET" == "(dev1)" ]; then
    FORMATTED_KUBE_TARGET="\[${AMBER}\]\${THE_KUBE_TARGET}\[${ENDCOLOUR}\]"
	else
		FORMATTED_KUBE_TARGET="\[${GREEN}\]\${THE_KUBE_TARGET}\[${ENDCOLOUR}\]"
  fi

  export PS1="\W${FORMATTED_BRANCH}${FORMATTED_KUBE_TARGET} $ "

}

PROMPT_COMMAND=setPS1
