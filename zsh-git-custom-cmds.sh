# custom git function

# add all changes
function _ga() {
  git add -A
}

# commit all the changes
function _gc() {
  git add -A && git-cz
}

# push with origin HEAD
function _gp() {
  git push -u origin HEAD 
}

# pull
function _gpl() {
  git pull
}

# locally ignore
function _gi() {
  git update-index --skip-worktree $1
}

# locally unignore
function _gui() {
  git update-index --no-skip-worktree $1
}

# stash
function _gs() {
  git stash
}

# clear stash
function _gs-clear() {
  git stash clear
}

# rebase
function _gr() {
  git rebase
}

# rebase continue
function _gr-continue() {
  git add -A && git rebase --continue
}

# rebase abort
function _gr-abort() {
  git rebase --abort
}

# merge
function _gm() {
  git merge
}

# merge continue
function _gm-continue() {
  git add -A && git merge --continue
}

# merge abort
function _gm-abort() {
  git merge --abort
}

# checkout
function _gco() {
  git checkout $1
}

# checkout a new branch
function _gco-create() {
  git checkout -b $1
}

# status
function _gst() {
  git checkout $1
}

# help
function _g-help() {
  echo '_g util by @nguyenanhhoang97 & @thanhnguyen662\n
  1. _ga: add all changes\n
  2. _gc: commit all the changes\n
  3. _gp: push with origin HEAD\n
  4. _gpl: pull\n
  5. _gi: locally ignore\n
  6. _gui: locally unignore\n
  7. _gs: stash\n
  8. _gs-clear: clear stash\n
  9. _gr: rebase\n
  10. _gr-continue: rebase continue\n
  11. _gr-abort: rebase abort\n
  12. _gm: merge\n
  13. _gm-continue: merge continue\n
  14. _gm-abort: merge abort\n
  15. _gco: commit checkout\n
  16. _gco-create: checkout a new branch\n
  17. _gst: status\n
  18. _g-help: help\n
  '
}
