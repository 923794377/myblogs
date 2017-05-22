Administrator@CZ-20151218KCNS MINGW64 /e/gitdir/we (master)
$ cd ..

Administrator@CZ-20151218KCNS MINGW64 /e/gitdir
$ mkdir liqun

Administrator@CZ-20151218KCNS MINGW64 /e/gitdir
$ cd liqun

Administrator@CZ-20151218KCNS MINGW64 /e/gitdir/liqun
$ touch map1.java

Administrator@CZ-20151218KCNS MINGW64 /e/gitdir/liqun
$ vi map

Administrator@CZ-20151218KCNS MINGW64 /e/gitdir/liqun
$ LS
map  map1.java

Administrator@CZ-20151218KCNS MINGW64 /e/gitdir/liqun
$ git status
fatal: Not a git repository (or any of the parent directories): .git

Administrator@CZ-20151218KCNS MINGW64 /e/gitdir/liqun
$ git init
Initialized empty Git repository in E:/gitdir/liqun/.git/

Administrator@CZ-20151218KCNS MINGW64 /e/gitdir/liqun (master)
$ git status
On branch master

Initial commit

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        map
        map1.java

nothing added to commit but untracked files present (use "git add" to track)

Administrator@CZ-20151218KCNS MINGW64 /e/gitdir/liqun (master)
$ git add .
warning: LF will be replaced by CRLF in map.
The file will have its original line endings in your working directory.

Administrator@CZ-20151218KCNS MINGW64 /e/gitdir/liqun (master)
$ git status
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

        new file:   map
        new file:   map1.java


Administrator@CZ-20151218KCNS MINGW64 /e/gitdir/liqun (master)
$ git commit -m "222222"
[master (root-commit) 69f100d] 222222
 2 files changed, 1 insertion(+)
 create mode 100644 map
 create mode 100644 map1.java

Administrator@CZ-20151218KCNS MINGW64 /e/gitdir/liqun (master)
$ git status
On branch master
nothing to commit, working tree clean

Administrator@CZ-20151218KCNS MINGW64 /e/gitdir/liqun (master)
$ git push https://github.com/923794377/wan.git master
To https://github.com/923794377/wan.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'https://github.com/923794377/wan.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.

Administrator@CZ-20151218KCNS MINGW64 /e/gitdir/liqun (master)
$ $ git pull --rebase https://github.com/923794377/wan.git master
bash: $: command not found

Administrator@CZ-20151218KCNS MINGW64 /e/gitdir/liqun (master)
$ git pull --rebase https://github.com/923794377/wan.git master
warning: no common commits
remote: Counting objects: 14, done.
remote: Compressing objects: 100% (10/10), done.
remote: Total 14 (delta 0), reused 11 (delta 0), pack-reused 0
Unpacking objects: 100% (14/14), done.
From https://github.com/923794377/wan
 * branch            master     -> FETCH_HEAD
First, rewinding head to replay your work on top of it...
Applying: 222222

Administrator@CZ-20151218KCNS MINGW64 /e/gitdir/liqun (master)
$ git push https://github.com/923794377/wan.git master
Counting objects: 3, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 271 bytes | 0 bytes/s, done.
Total 3 (delta 1), reused 0 (delta 0)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/923794377/wan.git
   037b98e..e066d58  master -> master

Administrator@CZ-20151218KCNS MINGW64 /e/gitdir/liqun (master)
$
