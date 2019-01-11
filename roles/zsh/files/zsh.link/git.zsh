# Git related functions and aliases

# TODO: Move it to common.zsh?!
prompt() {
    local message=$1

    while true; do
        read -p "$message ?" yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";
        esac
    done
}

log_error() {
    local RED='\033[0;31m'
    local NC='\033[0m'
    local msg=$1
    echo "${RED} ${msg} ${NC}" >&2
}
# end move

force_push_branch() {
    local LOCAL_BRANCH_NAME=`git rev-parse --abbrev-ref HEAD` 2>/dev/null

    if [ -z "$LOCAL_BRANCH_NAME" ]; then
        log_error "No git repository found !!!!"
        return 1
    else
        if [ "$LOCAL_BRANCH_NAME" = "master" ]; then
            log_error "No force push to master !!!!!"
            return 1
        else
            echo "Force pushing to: $LOCAL_BRANCH_NAME"
            git push --force-with-lease origin $LOCAL_BRANCH_NAME
        fi
    fi
}

rename_git_branch() {
    # unify-scripted-account-baselines-BSP-891
    old_branch=$1
    new_branch=$2
    echo '### Checking out branch: ' $old_branch
    git checkout "$old_branch"
    echo '### Renaming branch from: ' "$old_branch" ' to: ' "$new_branch"
    git branch -m "$old_branch" "$new_branch"
    echo '### Deleting remote branch with name: ' "$old_branch"
    git push origin :"$old_branch"
    echo '### Unset old upstream ###'
    git branch --unset-upstream
    echo '### Setting upstream to: ' "$new_branch"
    git push --set-upstream origin "$new_branch"
}

fshow() {
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
        fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
            --bind "ctrl-m:execute:(grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF' {} FZF-EOF"
}

fbranch() {
    git branch |
        fzf |
        xargs -I% git checkout %
}

branch_to_clipboard() {
    git rev-parse --abbrev-ref HEAD | tr -d '\n' | xsel -i -b -p
}

#### Aliases
alias gaa='git add -A'
alias gcl='git clone'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gdisc='git checkout -- .'
alias gget='git pull --rebase'
alias gput='git push'
alias gputf='force_push_branch'
alias grom='git rebase --interactive origin/master'
alias gsave='git add -A && git commit -s -m "feat(SAVE): SAVEPOINT"'
alias gst='git status'
alias gundo='git reset HEAD~1 --mixed'
alias gunstage='git reset HEAD --'
alias gwip='git commit -sam "feat(WIP): WIP"'
alias gwipe='git add -A && git commit -qsm "feat(WIPE): WIPE SAVEPOINT" && git reset HEAD~1 --hard'
alias cb='branch_to_clipboard'
