#!/bin/zsh

# Check if git-cz is installed, and prompt to install if not
function _check_git_cz_installed() {
  if ! command -v git-cz &> /dev/null; then
    echo "git-cz is not installed. Would you like to install it now? (y/n)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
      if command -v yarn &> /dev/null; then
        yarn global add commitizen
        echo "git-cz has been installed via yarn."
      elif command -v npm &> /dev/null; then
        npm install -g commitizen
        echo "git-cz has been installed via npm."
      else
        echo "Neither yarn nor npm is installed. Please install one of them to proceed with git-cz installation."
        return 1
      fi
    else
      echo "Please install git-cz to use this command."
      return 1
    fi
  fi
  return 0
}

# Helper function to display help message (private)
function __g_help() {
  echo 'Usage: __g [command] [args]
Commands:
  a               Add all changes
  a:all           Add all changes
  c               Commit changes
  c:raw           Commit with vanilla git command
  c:all           Commit all changes
  p               Push
  p:head          Push with origin HEAD
  pl              Pull
  ig <file>       Locally ignore a file
  ig:abort <file> Locally unignore a file
  st              Stash changes
  st:clear        Clear stash
  r               Rebase
  r:continue      Continue rebase with all changes added
  r:abort         Abort rebase
  m               Merge
  m:continue      Continue merge with all changes added
  m:abort         Abort merge
  b <branch>      Checkout a branch
  b:new <branch>  Create and checkout a new branch
  s               Show status
  cz              Trigger git cz
  yc              Yarn clean cache
  nc              Npm clean cache
  h               Show this help message'
}

# Main function to handle commands
function __g() {
  case "$1" in
    a)
      git add "$2"
      ;;
    a:all)
      git add -A
      ;;
    c)
      _check_git_cz_installed && git-cz
      ;;
    c:raw)
      git commit "$2"
      ;;
    c:all)
      _check_git_cz_installed && git add -A && git-cz
      ;;
    p)
      if [ -z "$2" ]; then
        git push
      else
        git push -u "$2"
      fi
      ;;
    p:head)
      git push -u origin HEAD
      ;;
    pl)
      if [ -z "$2" ]; then
        git pull
      else
        git pull -u "$2"
      fi
      ;;
    ig)
      git update-index --skip-worktree "$2"
      ;;
    ig:abort)
      git update-index --no-skip-worktree "$2"
      ;;
    st)
      if [ -z "$2" ]; then
        git stash
      else
        git stash -u "$2"
      fi
      ;;
    st:clear)
      git stash clear
      ;;
    r)
      git rebase "$2"
      ;;
    r:continue)
      git add -A && git rebase --continue
      ;;
    r:abort)
      git rebase --abort
      ;;
    m)
      git merge "$2"
      ;;
    m:continue)
      git add -A && git merge --continue
      ;;
    m:abort)
      git merge --abort
      ;;
    b)
      git checkout "$2"
      ;;
    b:new)
      git checkout -b "$2"
      ;;
    s)
      git status
      ;;
    yc)
      yarn cache clean --all
      ;;
    yc)
      npm cache clean --force
      ;;
    h | *)
      __g_help
      ;;
  esac
}
