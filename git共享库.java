1
Administrator@DD-20150303FPEN MINGW32 ~ (master)
$ git config --global user.name xxxxxxxx

Administrator@DD-20150303FPEN MINGW32 ~ (master)
$ git config --global user.email xxxxxxxx@qq.com

Administrator@DD-20150303FPEN MINGW32 ~ (master)
$ cd E:\Java

Administrator@DD-20150303FPEN MINGW32 /e/Java
$ mkdir mygitku

Administrator@DD-20150303FPEN MINGW32 /e/Java
$ cd mugitku
bash: cd: mugitku: No such file or directory

Administrator@DD-20150303FPEN MINGW32 /e/Java
$ cd mygitku

Administrator@DD-20150303FPEN MINGW32 /e/Java/mygitku
$ ls

Administrator@DD-20150303FPEN MINGW32 /e/Java/mygitku
$ git --bare init --shared
Initialized empty shared Git repository in E:/Java/mygitku/

Administrator@DD-20150303FPEN MINGW32 /e/Java/mygitku (BARE:master)
$ ls
config  description  HEAD  hooks/  info/  objects/  refs/

Administrator@DD-20150303FPEN MINGW32 /e/Java/mygitku (BARE:master)
$ cd E:\Java

Administrator@DD-20150303FPEN MINGW32 /e/Java
$ mkdir kutest

Administrator@DD-20150303FPEN MINGW32 /e/Java
$ cd kutest

Administrator@DD-20150303FPEN MINGW32 /e/Java/kutest
$ git clone E:/Java/mygitku/
Cloning into 'mygitku'...
warning: You appear to have cloned an empty repository.
done.

Administrator@DD-20150303FPEN MINGW32 /e/Java/kutest
$ git status
fatal: Not a git repository (or any of the parent directories): .git

Administrator@DD-20150303FPEN MINGW32 /e/Java/kutest
$ ls
mygitku/

Administrator@DD-20150303FPEN MINGW32 /e/Java/kutest
$ cd mygitku

Administrator@DD-20150303FPEN MINGW32 /e/Java/kutest/mygitku (master)
$ ls
'git博客(git使用步骤).java'   index.html   test.html   text.txt

Administrator@DD-20150303FPEN MINGW32 /e/Java/kutest/mygitku (master)
$ git status
On branch master

Initial commit

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        "git\345\215\232\345\256\242(git\344\275\277\347\224\250\346\255\245\351\252\244).java"
        index.html
        test.html
        text.txt

nothing added to commit but untracked files present (use "git add" to track)

Administrator@DD-20150303FPEN MINGW32 /e/Java/kutest/mygitku (master)
$ git add .

Administrator@DD-20150303FPEN MINGW32 /e/Java/kutest/mygitku (master)
$ git commit -m "新的"
[master (root-commit) e5644c9] 新的
 4 files changed, 799 insertions(+)
 create mode 100644 "git\345\215\232\345\256\242(git\344\275\277\347\224\250\346\255\245\351\252\244).java"
 create mode 100644 index.html
 create mode 100644 test.html
 create mode 100644 text.txt

Administrator@DD-20150303FPEN MINGW32 /e/Java/kutest/mygitku (master)
$ git status
On branch master
Your branch is based on 'origin/master', but the upstream is gone.
  (use "git branch --unset-upstream" to fixup)
nothing to commit, working tree clean

Administrator@DD-20150303FPEN MINGW32 /e/Java/kutest/mygitku (master)
$ ls
'git博客(git使用步骤).java'   index.html   test.html   text.txt

Administrator@DD-20150303FPEN MINGW32 /e/Java/kutest/mygitku (master)
$ git status
On branch master
Your branch is based on 'origin/master', but the upstream is gone.
  (use "git branch --unset-upstream" to fixup)
Untracked files:
  (use "git add <file>..." to include in what will be committed)

        "index - \345\211\257\346\234\254.html"
        "test - \345\211\257\346\234\254.html"
        "text - \345\211\257\346\234\254.txt"

nothing added to commit but untracked files present (use "git add" to track)

Administrator@DD-20150303FPEN MINGW32 /e/Java/kutest/mygitku (master)
$ git add .

Administrator@DD-20150303FPEN MINGW32 /e/Java/kutest/mygitku (master)
$ git commit -m "新的"
[master b219951] 新的
 3 files changed, 640 insertions(+)
 create mode 100644 "index - \345\211\257\346\234\254.html"
 create mode 100644 "test - \345\211\257\346\234\254.html"
 create mode 100644 "text - \345\211\257\346\234\254.txt"

Administrator@DD-20150303FPEN MINGW32 /e/Java/kutest/mygitku (master)
$ git push E:/Java/mygitku/
 Counting objects: 8, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (7/7), done.
Writing objects: 100% (8/8), 7.84 KiB | 0 bytes/s, done.
Total 8 (delta 2), reused 0 (delta 0)
To E:/Java/mygitku/
 * [new branch]      master -> master

Administrator@DD-20150303FPEN MINGW32 /e/Java/kutest/mygitku (master)
$  cd e:\Java

Administrator@DD-20150303FPEN MINGW32 /e/Java
$ mkdir newku

Administrator@DD-20150303FPEN MINGW32 /e/Java
$ cd newku

Administrator@DD-20150303FPEN MINGW32 /e/Java/newku
$ git clone E:/Java/mygitku/
Cloning into 'mygitku'...
done.

Administrator@DD-20150303FPEN MINGW32 /e/Java/newku
$ cd

还有建立ssh
