# Git Checkouter

A tool that iterates on your parent Git folder (that includes all of your Git projects),
and checkouts, lists, or rebase on top of master the given branch for each project.

![git-checkouter](.meta/git-checkouter.gif)


## What?

OK, it's a common practice to keep all of your work-related Git projects in some folder, let's say "~work":

```
.
├── project1
├── project2
├── project3
├── project4
```

Now you are working on a ticket "xxx", and you changed projects 1, 2 and 4.

Imagine you have much more projects, and you're working on much more tickets. Now you want to run local tests for feature "xxx", 
but you don't remember what projects you have changed for this feature:

```bash
$ ./git-checkouter.sh -p ~/work -b xxx -d
'xxx' found in 'project1'
'xxx' found in 'project2'
'xxx' found in 'project4'
```

providing `-d` will only list which projects includes the branch, and will not actually checkout.

It is also possible to set an environment variable: `export PROJECTS_DIR=~/work` and omit the `-p` flag.

After you saw which projects you changed for that specific feature, you can checkout the branch in all of them:

```bash
$ ./git-checkouter.sh -p ~/work -b xxx
project1: Switched to branch 'xxx'
project2: Switched to branch 'xxx'
project3: Switched to branch 'xxx'
project4: Switched to branch 'xxx'
```

If you want to ignore some projects, you can provide the `-e` flag:

```bash
$ ./git-checkouter.sh -p ~/work -b master -e project2,project3
project1: Switched to branch 'xxx'
Project excluded: project2
Project excluded: project3
project4: Switched to branch 'xxx'
```

Sync all branches with remote master using the `-f` flag:


```bash
$ ./git-checkouter.sh -p ~/work -f
Rebasing project1: Current branch master is up to date.
Rebasing project2: Fast-forwarded xxx to origin/master.
Rebasing project3: Current branch xxx is up to date.
Rebasing project4: Current branch xxx is up to date.
```

Note that it's assumed that you have the same branch name in different projects for the same feature.
