# Load ~/.bash_profile.local, ~/.bash_paths, and ~/.bash_aliases
# ~/.bash_profile.local can be used for settings you don’t want to commit
for file in ~/.{bash_profile.local,bash_paths,bash_aliases}; do
        [ -r "$file" ] && source "$file"
done
unset file

# Load RVM into a shell session *as a function*
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

export EDITOR=vim

# Use vim commands in terminal (not emacs)
set -o vi

export PGHOST=localhost

export GITAWAREPROMPT=~/.bash/git-aware-prompt
source $GITAWAREPROMPT/main.sh
export PS1="\W \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

source ~/git-completion.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export FZF_DEFAULT_COMMAND='rg --files'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
