parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1='\u \[\e[32m\]\w \[\e[91m\]`parse_git_branch`\[\e[33m\] \[\e[00m\]$ '

source /usr/share/bash-completion/completions/git
if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi
export PROMPT_COMMAND='history -a'
export HISTFILE=/commandhistory/.bash_history

echo "Welcome $(echo $USERNAME | sed "s/\b\(.\)/\u\1/g" | sed "s/\./ /g"), let's build something great!"
