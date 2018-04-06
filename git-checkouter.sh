#!/bin/bash

CYAN='\033[1;36m'
NC='\033[0m'

display_usage() {
  echo "Usage: $(basename "$0") [OPTIONS]"
  echo ""
  echo "  -p  path to your projects' dir. If not provided,"
  echo "        will use env variable 'PROJECTS_DIR'"
  echo "  -b  git branch to checkout"
  echo "  -d  only print projects that have the given branch,"
  echo "        without actually check it out"
  echo ""
  echo "Bugs and suggestions: <https://github.com/MarounMaroun/git-checkouter/issues>"
  exit 1
}

projects=$PROJECTS_DIR
dry=''
branch=''

while getopts 'p:b:d' flag; do
  case "${flag}" in
    p)
      projects="${OPTARG}"
      ;;
    b)
      branch=${OPTARG}
      ;;
    d)
      dry="true"
      ;;
    *)
      display_usage
      exit 1
      ;;
  esac
done

if [[ -z "$branch" || -z "$projects" ]]; then
  echo "Error: both branch and projects dir must be specified"
  echo ""
  display_usage
fi

for d in $projects/*; do
  if [[ ! -d "$d" ]]; then continue; fi
  cd $d
  if [ -d ".git" ]; then
    branches=$(git branch | cut -c 3-)
    branch_found=$(echo $branches | grep -oP "\b$branch\b")
    if [[ -z "$branch_found" ]]; then continue; fi
    if [[ ! -z "$dry" ]]; then
      printf "'$branch' found in ${CYAN}'$(basename $d)'${NC}\n"
    else
      printf "${CYAN}$(basename $d): ${NC}"
      git checkout $branch
    fi
  fi
done
