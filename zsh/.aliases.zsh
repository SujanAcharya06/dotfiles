# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias cls='clear'

alias mail='python /home/sujanacharya/Documents/Resource/Code/Python/Py-Scripts/test.py'
alias mail-log='python /home/sujanacharya/Documents/Resource/Code/Python/Py-Scripts/test-logfile.py'

alias cat='bat'
alias ls='exa'
alias ll='exa -alh'
alias tree='exa --tree'

# For executing cpp program
alias exe-cpp='sh /home/sujanacharya/Documents/Resource/Code/Bash_Scripts/bashScripts/Auto-Exec/exe-cpp.sh'
alias exe-java='sh /home/sujanacharya/Documents/Resource/Code/Bash_Scripts/bashScripts/Auto-Exec/exe-java.sh'

# For storing the cwd of the folder in ranger
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# For rm -rf
alias rm='trash'

alias copy='xsel --input --clipboard'
alias paste='xsel --output --clipboard'

alias fileCount='python /home/sujanacharya/Documents/Resource/Code/Python/Py-Scripts/fileCount.py'

# For git fetch
alias fetch='git fetch origin main'

# Alias for searching files with fzf and previewing with bat
alias search='fzf --preview="bat --style=numbers --color=always {}"'

# Alias for editing files selected with fzf and previewing with bat
alias edit='nvim $(fzf --preview="bat --style=numbers --color=always {}")'

# Alias for cd'ing using fzf
alias fcd='cd "$(dirname "$(fzf)")"'

#For doom emacs
alias emacs='emacsclient -c -a 'emacs''
