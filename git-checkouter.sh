#!/bin/bash

CYAN='\033[1;36m'
NC='\033[0m'
YELLOW='\033[0;33m'

display_usage() {
  echo "Usage: $(basename "$0") [OPTIONS]"
  echo ""
  echo "  -p  path to your projects' dir. If not provided,"
  echo "        will use env variable 'PROJECTS_DIR'"
  echo "  -b  git branch to checkout"
  echo "  -d  only print projects that have the given branch,"
  echo "        without actually check it out"
  echo "  -e  projects to exclude, separated by \",\" without spaces"
  echo ""
  echo "Bugs and suggestions: <https://github.com/MarounMaroun/git-checkouter/issues>"
  exit 1
}

projects=$PROJECTS_DIR
dry=''
branch=''
exclude=''

while getopts 'p:b:de:' flag; do
  case "${flag}" in
    p)
      projects=${OPTARG}
      ;;
    b)
      branch=${OPTARG}
      ;;
    d)
      dry="true"
      ;;
    e)
	  exclude=${OPTARG}
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

if [[ ! -z "$exclude" ]]; then
  IFS=',' read -r exclude_projects <<< $exclude
fi

for d in $projects/*; do
  project_name=$(basename $d)
  if [[ ! -d "$d" ]]; then continue; fi
  cd $d
  if [ -d ".git" ]; then
    branches=$(git branch | cut -c 3-)
    branch_found=$(echo $branches | grep -oP "\b$branch\b")
    if [[ -z "$branch_found" ]]; then continue; fi
    if [[ ! -z "$dry" ]]; then
      printf "'$branch' found in ${CYAN}'$project_name'${NC}\n"
    else
      printf "${CYAN}$(basename $d): ${NC}"
	  project_name=$(basename $d)
	  echo $exclude_projects
	  if [[ $exclude_projects =~ .*$project_name.* ]]; then
	    printf "${YELLOW}Project excluded:${NC} $project_name\n"
	    continue
	  fi
      git checkout $branch
    fi
  fi
done
