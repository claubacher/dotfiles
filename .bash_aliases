alias mkdir='mkdir -p'
alias ls='ls -F -G'
alias g='git'

# Make directory and change into it.
function mcd() {
  mkdir -p "$1" && cd "$1";
}

function chrome() {
  /usr/bin/open -a "/Applications/Google Chrome.app" $1
}

