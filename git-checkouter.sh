#!/bin/bash

display_usage() {
  echo "Usage: $(basename "$0") <projects-dir> <branch> [dry-run]"
  echo ""
  echo "    projects-dir = path to your projects' dir"
  echo "    branch       = git branch to checkout"
  echo "    dry-run      = if provided, only print projects that have the given branch"
  exit 1
}

if [ $# -lt 2 ]; then
  display_usage
fi

PROJECTS_DIR=$1
BRANCH=$2
DRY_RUN=$3

DRY_RUN=${DRY_RUN:-}
if [[ ! -z $DRY_RUN && ! $DRY_RUN == "dry-run" ]]; then
  display_usage
fi

for d in $PROJECTS_DIR/*; do
  if [[ ! -d "$d" ]]; then continue; fi
  cd $d
  if [ -d ".git" ]; then
    branches=$(git branch | cut -c 3-)
	branch_found=$(echo $branches | grep -oP "\b$BRANCH\b")
	if [[ -z "$branch_found" ]]; then continue; fi
	if [[ ! -z "$DRY_RUN" ]]; then
	  echo "'$BRANCH' found in '$(basename $d)'"
	else
      git checkout $BRANCH
	fi
  fi
done
