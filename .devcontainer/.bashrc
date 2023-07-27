# super basic .bashrc — a cool terminal isn't the goal of this example

# Make the prompt look a little nicer by including the git branch
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1='\u \[\e[32m\]\w \[\e[91m\]`parse_git_branch`\[\e[33m\] \[\e[00m\]$ '

# Make git bash completion
source /usr/share/bash-completion/completions/git
if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

# make bash history work
export PROMPT_COMMAND='history -a'
export HISTFILE=/commandhistory/.bash_history

# Write a nice welcome message :)
echo "Welcome $(echo $USERNAME | sed "s/\b\(.\)/\u\1/g" | sed "s/\./ /g"), let's build something great!"
