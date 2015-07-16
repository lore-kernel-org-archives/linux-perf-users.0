From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf trace: file names, strace groups
Date: Thu, 16 Jul 2015 12:00:14 -0300
Message-ID: <20150716150013.GH8114@kernel.org>
References: <2853551.Qtj9hFrTSc@milian-kdab2>
 <20150715145309.GD3868@kernel.org>
 <239503894.ASNylTKZCF@milian-kdab2>
 <20150715194315.GC8114@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60482 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708AbbGPPAZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 16 Jul 2015 11:00:25 -0400
Content-Disposition: inline
In-Reply-To: <20150715194315.GC8114@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: Perf Users <linux-perf-users@vger.kernel.org>, David Ahern <dsahern@gmail.com>

Em Wed, Jul 15, 2015 at 04:43:15PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jul 15, 2015 at 05:41:53PM +0200, Milian Wolff escreveu:
> > On Wednesday 15 July 2015 11:53:09 Arnaldo Carvalho de Melo wrote:
> > > [acme@zoo ~]$ trace -e file cat file
> > > Error:	Invalid syscall file
> > > Hint:	try 'perf list syscalls:sys_enter_*'
> > > Hint:	and: 'man syscalls'
  
> > Just to be clear: Supporting the strace groups as a collection of syscalls 
> > will be implemented? Or is that not possible, as it goes straight down to the 
> > perf event subsystem which does not know this group?
 
> Right, I'll implement a strlist__new_with_expansions(), to break a CSV
> list and look for some specific keys, that when found will expand into
> other keys, like what is done for strace -e file, i.e. file becomes
> open,write,close, making sure there are no duplicates.
 
> Then it will be just a matter of providing the expansors for those
> strace groups.

Did it a little bit differently, see patch below, needs some more
polishing, will do after some other stuff I need to do now:

[root@zoo ~]# trace -e file ls
     0.153 ( 0.019 ms): ls/26666 access(filename: 0x7fe31a181270, mode: R) = -1 ENOENT No such file or directory
     0.166 ( 0.008 ms): ls/26666 open(filename: 0x7fe31a17fb92, flags: CLOEXEC) = 3
     0.192 ( 0.008 ms): ls/26666 open(filename: 0x7fe31a37883c, flags: CLOEXEC) = 3
     0.258 ( 0.010 ms): ls/26666 open(filename: 0x7fe31a380b2f, flags: CLOEXEC) = 3
     0.304 ( 0.008 ms): ls/26666 open(filename: 0x7fe31a381a39, flags: CLOEXEC) = 3
     0.351 ( 0.009 ms): ls/26666 open(filename: 0x7fe31a380dc8, flags: CLOEXEC) = 3
     0.409 ( 0.008 ms): ls/26666 open(filename: 0x7fe31a379d5a, flags: CLOEXEC) = 3
     0.455 ( 0.008 ms): ls/26666 open(filename: 0x7fe31a37fc6b, flags: CLOEXEC) = 3
     0.502 ( 0.008 ms): ls/26666 open(filename: 0x7fe31a3815d4, flags: CLOEXEC) = 3
     0.545 ( 0.008 ms): ls/26666 open(filename: 0x7fe31a379648, flags: CLOEXEC) = 3
anaconda-ks.cfg  b  bin  lib64	libexec  new  old  perf.data  perf.data.old  stream_test  tg.run
     1.124 ( 0.258 ms): ls/26666 statfs(pathname: 0x7fe319f57654, buf: 0x7ffd15dc4810) = 0
     1.142 ( 0.015 ms): ls/26666 statfs(pathname: 0x7fe319f57654, buf: 0x7ffd15dc4700) = 0
     1.234 ( 0.011 ms): ls/26666 open(filename: 0x7fe3198fb6b0, flags: CLOEXEC) = 3
     1.320 ( 0.008 ms): ls/26666 openat(dfd: CWD, filename: 0x11f2c10, flags: CLOEXEC|DIRECTORY|NONBLOCK) = 3
[root@zoo ~]#

But should we have all those below? And if so, wouldn't be better to use
that criteria (in the grep+set below) as a future proof "file" group?
Anyway, having groups as extensions on files in a dir adds the strace
feature as soon as someone provides me the groups files :-)

[root@zoo ~]# grep "field:.*name" /sys/kernel/debug/tracing/events/syscalls/*/format | sed
's/.*sys_enter_\([a-z_0-9]\+\).*/\1/g'
access
acct
chdir
chmod
chown
chroot
creat
delete_module
faccessat
fanotify_mark
fchmodat
fchownat
fgetxattr
fremovexattr
fsetxattr
futimesat
getsockopt
getxattr
getxattr
inotify_add_watch
lchown
lgetxattr
lgetxattr
linkat
linkat
link
link
listxattr
llistxattr
lremovexattr
lremovexattr
lsetxattr
lsetxattr
memfd_create
mkdirat
mkdir
mknodat
mknod
mount
mount
mq_open
mq_unlink
name_to_handle_at
newfstatat
newlstat
newstat
newuname
openat
open
readlinkat
removexattr
removexattr
renameat2
renameat2
renameat
renameat
rename
rename
rmdir
setdomainname
sethostname
setsockopt
setxattr
setxattr
statfs
symlinkat
symlinkat
symlink
symlink
umount
unlinkat
unlink
utime
utimensat
utimes
[root@zoo ~]# 


diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0ebf55bf20b3..4dc50fdba5dd 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2931,7 +2931,7 @@ int cmd_trace(int argc, const char **argv, const char *prefix __maybe_unused)
 		trace.not_ev_qualifier = *s == '!';
 		if (trace.not_ev_qualifier)
 			++s;
-		trace.ev_qualifier = strlist__new(true, s);
+		trace.ev_qualifier = strlist__new_subst_dir(true, s, "/home/acme/git/linux/tools/perf/trace/strace/groups/");
 		if (trace.ev_qualifier == NULL) {
 			fputs("Not enough memory to parse event qualifier",
 			      trace.output);
diff --git a/tools/perf/util/strlist.c b/tools/perf/util/strlist.c
index 68ae673f9fb6..2e4534a1fffe 100644
--- a/tools/perf/util/strlist.c
+++ b/tools/perf/util/strlist.c
@@ -108,32 +108,52 @@ struct str_node *strlist__find(struct strlist *slist, const char *entry)
 	return snode;
 }
 
-static int strlist__parse_list_entry(struct strlist *slist, const char *s)
+static int strlist__parse_list_entry(struct strlist *slist, const char *s,
+				     const char *subst_dir)
 {
+	int err;
+
 	if (strncmp(s, "file://", 7) == 0)
 		return strlist__load(slist, s + 7);
 
-	return strlist__add(slist, s);
+	if (subst_dir) {
+		char *subst;
+
+		err = -ENOMEM;
+		if (asprintf(&subst, "%s/%s", subst_dir, s) < 0)
+			goto out;
+
+		err = 0;
+		if (access(subst, F_OK) == 0)
+			err = strlist__load(slist, subst);
+
+		free(subst);
+	} else {
+		err = strlist__add(slist, s);
+	}
+out:
+	return err;
 }
 
-int strlist__parse_list(struct strlist *slist, const char *s)
+int strlist__parse_list(struct strlist *slist, const char *s, const char *subst_dir)
 {
 	char *sep;
 	int err;
 
 	while ((sep = strchr(s, ',')) != NULL) {
 		*sep = '\0';
-		err = strlist__parse_list_entry(slist, s);
+		err = strlist__parse_list_entry(slist, s, subst_dir);
 		*sep = ',';
 		if (err != 0)
 			return err;
 		s = sep + 1;
 	}
 
-	return *s ? strlist__parse_list_entry(slist, s) : 0;
+	return *s ? strlist__parse_list_entry(slist, s, subst_dir) : 0;
 }
 
-struct strlist *strlist__new(bool dupstr, const char *list)
+struct strlist *strlist__new_subst_dir(bool dupstr, const char *list,
+				       const char *dirname)
 {
 	struct strlist *slist = malloc(sizeof(*slist));
 
@@ -144,7 +164,7 @@ struct strlist *strlist__new(bool dupstr, const char *list)
 		slist->rblist.node_delete = strlist__node_delete;
 
 		slist->dupstr	 = dupstr;
-		if (list && strlist__parse_list(slist, list) != 0)
+		if (list && strlist__parse_list(slist, list, dirname) != 0)
 			goto out_error;
 	}
 
@@ -154,6 +174,11 @@ out_error:
 	return NULL;
 }
 
+struct strlist *strlist__new(bool dupstr, const char *list)
+{
+	return strlist__new_subst_dir(dupstr, list, NULL);
+}
+
 void strlist__delete(struct strlist *slist)
 {
 	if (slist != NULL)
diff --git a/tools/perf/util/strlist.h b/tools/perf/util/strlist.h
index 5c7f87069d9c..4bcffdfb9f29 100644
--- a/tools/perf/util/strlist.h
+++ b/tools/perf/util/strlist.h
@@ -17,6 +17,8 @@ struct strlist {
 };
 
 struct strlist *strlist__new(bool dupstr, const char *slist);
+struct strlist *strlist__new_subst_dir(bool dupstr, const char *slist,
+				       const char *dirname);
 void strlist__delete(struct strlist *slist);
 
 void strlist__remove(struct strlist *slist, struct str_node *sn);
@@ -75,5 +77,5 @@ static inline struct str_node *strlist__next(struct str_node *sn)
 	for (pos = strlist__first(slist), n = strlist__next(pos); pos;\
 	     pos = n, n = strlist__next(n))
 
-int strlist__parse_list(struct strlist *slist, const char *s);
+int strlist__parse_list(struct strlist *slist, const char *s, const char *subst_dir);
 #endif /* __PERF_STRLIST_H */
