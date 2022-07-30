# custom git function
# custom function to commit all the changes
function git-cm() {
  git add -A && git-cz
}

# custom function to push with origin HEAD
function git-push() {
  git push -u origin HEAD 
}

# locally ignore
function git-local-ignore($1) {
  git update-index --skip-worktree $1
}

# locally unginore
function git-local-unignore($1) {
  git update-index --no-skip-worktree $1
}
