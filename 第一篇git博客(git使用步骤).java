1.安装git
1.先在github创建远程项目(仓库)国内可以使用码云,类似github
2.在本地git.base使用命令 git clone https://github.com/xxxxxxxx/myblogs.git(仓库在github的地址)
3.在克隆的git仓库项目中 添加项目和文件
4.具体操作如下

Administrator@DD-20150303FPEN MINGW32 ~ (master)
$ git
usage: git [--version] [--help] [-C <path>] [-c name=value]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone      Clone a repository into a new directory
   init       Create an empty Git repository or reinitialize an existing one

work on the current change (see also: git help everyday)
   add        Add file contents to the index
   mv         Move or rename a file, a directory, or a symlink
   reset      Reset current HEAD to the specified state
   rm         Remove files from the working tree and from the index

examine the history and state (see also: git help revisions)
   bisect     Use binary search to find the commit that introduced a bug
   grep       Print lines matching a pattern
   log        Show commit logs
   show       Show various types of objects
   status     Show the working tree status

grow, mark and tweak your common history
   branch     List, create, or delete branches
   checkout   Switch branches or restore working tree files
   commit     Record changes to the repository
   diff       Show changes between commits, commit and working tree, etc
   merge      Join two or more development histories together
   rebase     Reapply commits on top of another base tip
   tag        Create, list, delete or verify a tag object signed with GPG

collaborate (see also: git help workflows)
   fetch      Download objects and refs from another repository
   pull       Fetch from and integrate with another repository or a local branch
   push       Update remote refs along with associated objects

'git help -a' and 'git help -g' list available subcommands and some
concept guides. See 'git help <command>' or 'git help <concept>'
to read about a specific subcommand or concept.

Administrator@DD-20150303FPEN MINGW32 ~ (master)
$ git config --global user.name xxxxxxxx@qq.com

Administrator@DD-20150303FPEN MINGW32 ~ (master)
$ git config --global user.email xxxxxxxx@qq.com

Administrator@DD-20150303FPEN MINGW32 ~ (master)
$ cd E:\Java

Administrator@DD-20150303FPEN MINGW32 /e/Java
$ cd myblogs

Administrator@DD-20150303FPEN MINGW32 /e/Java/myblogs (master)
$ ls
text.txt  第一篇git博客.java

Administrator@DD-20150303FPEN MINGW32 /e/Java/myblogs (master)
$ git clone https://github.com/xxxxxxxx/myblogs.git 演示哦
Cloning into '演示哦'...
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 3 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), done.

Administrator@DD-20150303FPEN MINGW32 /e/Java/myblogs (master)
$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Untracked files:
  (use "git add <file>..." to include in what will be committed)

        "\346\274\224\347\244\272\345\223\246/"
        "\347\254\254\344\270\200\347\257\207git\345\215\232\345\256\242.java"

nothing added to commit but untracked files present (use "git add" to track)

Administrator@DD-20150303FPEN MINGW32 /e/Java/myblogs (master)
$ git add .

Administrator@DD-20150303FPEN MINGW32 /e/Java/myblogs (master)
$ git commit -m "增加新文件"
[master 968808a] 增加新文件
 2 files changed, 1 insertion(+)
 create mode 160000 "\346\274\224\347\244\272\345\223\246"
 create mode 100644 "\347\254\254\344\270\200\347\257\207git\345\215\232\345\256\242.java"

Administrator@DD-20150303FPEN MINGW32 /e/Java/myblogs (master)
$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
nothing to commit, working tree clean

Administrator@DD-20150303FPEN MINGW32 /e/Java/myblogs (master)
$ git push https://github.com/xxxxxxxx/myblogs.git master
Username for 'https://github.com': xxxxxxxx
Counting objects: 3, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 337 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To https://github.com/xxxxxxxx/myblogs.git
   7c56e3f..968808a  master -> master

Administrator@DD-20150303FPEN MINGW32 /e/Java/myblogs (master)
$
