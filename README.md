# Git Checkouter

A tool that iterates on your parent Git folder (that includes all of your Git projects),
and checkouts the given branch for each project.


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
$ ./git-checkouter.sh ~work xxx dry-run
'xxx' found in 'project1'
'xxx' found in 'project2'
'xxx' found in 'project4'
```

providing `dry-run` will only list which projects includes the branch, and will not actually checkout.

After you saw which projects you changed for that specific feature, you can checkout the branch in all of them:

```bash
$ ./git-checkouter.sh ~work xxx
Switched to branch 'xxx'
Switched to branch 'xxx'
Switched to branch 'xxx'
```

Note that it's assumed that you have the same branch name in different projects for the same feature.
