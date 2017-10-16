From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf buildid-cache -p <path> question
Date: Mon, 16 Oct 2017 11:12:22 -0300
Message-ID: <20171016141222.GC5311@kernel.org>
References: <8594e11c-9aa1-f600-3f04-eb80058c9abf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752151AbdJPOMZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Oct 2017 10:12:25 -0400
Content-Disposition: inline
In-Reply-To: <8594e11c-9aa1-f600-3f04-eb80058c9abf@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>

Em Mon, Oct 16, 2017 at 02:24:11PM +0200, Thomas-Mich Richter escreveu:
> Maybe its me misunderstanding the buildid cache completely, but I ran into the following issue:
> 
> I can add and remove files using the perf buildid-cache command. For example 
> perf buildid-cache -a /usr/bin/tar adds the tar executable to the buildid-cache directory
> .debug/usr/bin/tar 
> and creates the <buildid> subdirectory
> .debug/usr/bin/tar/e54c9946802bbbcb85760ffeb80700a5fd35ebe7/elf file.

That is correct.

> Also a symbolic link from the directory
> .debug/.buildid/e5/4c9946802bbbcb85760ffeb80700a5fd35ebe7 --> ../../usr/bin/tar/<buildid>/
> is created.
> 
> Command perf buildid-cache -a /usr/bin/tar

Nope, command 'perf buildid-cache -r /usr/bin/tar' does it:

[root@jouet ~]# ls -la ~/.debug/usr/bin/tar/4c10f253c0cb8459dd846235c0bc18929e4758ea
[root@jouet ~]# ls -la ~/.debug/.build-id/4c/10f253c0cb8459dd846235c0bc18929e4758ea
lrwxrwxrwx. 1 root root 58 Oct 16 10:50 /root/.debug/.build-id/4c/10f253c0cb8459dd846235c0bc18929e4758ea -> ../../usr/bin/tar/4c10f253c0cb8459dd846235c0bc18929e4758ea
[root@jouet ~]# 

[root@jouet ~]# perf buildid-cache -r /usr/bin/tar
[root@jouet ~]# ls -la ~/.debug/usr/bin/tar/4c10f253c0cb8459dd846235c0bc18929e4758ea
ls: cannot access '/root/.debug/usr/bin/tar/4c10f253c0cb8459dd846235c0bc18929e4758ea': No such file or directory
[root@jouet ~]# ls -la ~/.debug/.build-id/4c/10f253c0cb8459dd846235c0bc18929e4758ea
ls: cannot access '/root/.debug/.build-id/4c/10f253c0cb8459dd846235c0bc18929e4758ea': No such file or directory
[root@jouet ~]# 

> removes these entries.
> 
> Now when I run ./perf buildid-cache -p /usr/bin
> nothing happens and success is reported:

When you do '-p' after a '-a' or after a '-r'? From what you wrote
below, that is after you do a '-a /usr/bin/tar', as it is being purged
as well.

Masami?

> [root@s35lp76 perf]# ./perf buildid-cache -vp /usr/bin/
> Removing bash /usr/bin/: Ok
> Removing dbus-daemon /usr/bin/: Ok
> Removing ls /usr/bin/: Ok
> Removing readlink /usr/bin/: Ok
> Removing sleep /usr/bin/: Ok
> Removing tar /usr/bin/: Ok
> Removing time /usr/bin/: Ok
> Removing vim /usr/bin/: Ok
> Purging /usr/bin/: Ok

In my test it works as advertised:

[root@jouet ~]# perf buildid-cache -a /usr/bin/tar
[root@jouet ~]# ls -la ~/.debug/.build-id/4c/10f253c0cb8459dd846235c0bc18929e4758ea
lrwxrwxrwx. 1 root root 58 Oct 16 10:56 /root/.debug/.build-id/4c/10f253c0cb8459dd846235c0bc18929e4758ea -> ../../usr/bin/tar/4c10f253c0cb8459dd846235c0bc18929e4758ea
[root@jouet ~]# ls -la ~/.debug/usr/bin/tar/4c10f253c0cb8459dd846235c0bc18929e4758ea
total 424
drwxr-xr-x. 2 root root   4096 Oct 16 10:56 .
drwxr-xr-x. 3 root root   4096 Oct 16 10:56 ..
-rwxr-xr-x. 2 root root 425032 Jul 19 05:55 elf
-rw-r--r--. 1 root root      0 Oct 16 10:56 probes
[root@jouet ~]# perf buildid-cache -vp /usr/bin/tar
Removing 4c10f253c0cb8459dd846235c0bc18929e4758ea /usr/bin/tar: Ok
Purging /usr/bin/tar: Ok
[root@jouet ~]# ls -la ~/.debug/usr/bin/tar/4c10f253c0cb8459dd846235c0bc18929e4758ea
ls: cannot access '/root/.debug/usr/bin/tar/4c10f253c0cb8459dd846235c0bc18929e4758ea': No such file or directory
[root@jouet ~]# ls -la ~/.debug/.build-id/4c/10f253c0cb8459dd846235c0bc18929e4758ea
ls: cannot access '/root/.debug/.build-id/4c/10f253c0cb8459dd846235c0bc18929e4758ea': No such file or directory
[root@jouet ~]#

It was purged.

Now lets try what you did, which is to ask for a path that will match
with multiple binaries:

[root@jouet ~]# perf buildid-cache -v -a /usr/bin/tar
Adding 4c10f253c0cb8459dd846235c0bc18929e4758ea /usr/bin/tar: Ok
[root@jouet ~]# ls -la ~/.debug/.build-id/4c/10f253c0cb8459dd846235c0bc18929e4758ea
lrwxrwxrwx. 1 root root 58 Oct 16 10:58 /root/.debug/.build-id/4c/10f253c0cb8459dd846235c0bc18929e4758ea -> ../../usr/bin/tar/4c10f253c0cb8459dd846235c0bc18929e4758ea
[root@jouet ~]# ls -la ~/.debug/usr/bin/tar/4c10f253c0cb8459dd846235c0bc18929e4758ea
total 424
drwxr-xr-x. 2 root root   4096 Oct 16 10:58 .
drwxr-xr-x. 3 root root   4096 Oct 16 10:58 ..
-rwxr-xr-x. 2 root root 425032 Jul 19 05:55 elf
-rw-r--r--. 1 root root      0 Oct 16 10:58 probes
[root@jouet ~]# perf buildid-cache -vp /usr/bin
Removing as /usr/bin: FAIL
Purging /usr/bin: FAIL
/usr/bin wasn't in the cache
[root@jouet ~]# perf buildid-cache -vp /usr/bin/
Removing as /usr/bin/: FAIL
Purging /usr/bin/: FAIL
/usr/bin/ wasn't in the cache
[root@jouet ~]#

This is when --purge was added:

commit 8d8c8e4cb3014fcc51f0e127b4316043306f5bb0
Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Date:   Fri Feb 27 13:50:26 2015 +0900

    perf buildid-cache: Add --purge FILE to remove all caches of FILE

-----------------------
 
> I have done some more debugging and there is something wrong. 
> The function
> build_id_cache__purge_path() is called and 
> build_id_cache__list_build_ids() creates a list of file names located in /usr/bin of the buildid-cache.
> build_id_cache__remove_s() is called for each name in the list and tries to locate each file name
> 	in directory .buildid/YY/ZZZ..ZZZ which fails because 
> build_id_cache__linkname() expects a buildid and gets a file name.
> The file name bash is treated as .buildid/ba/sh which does not exist.

probably this got broken when the /elf, /probe separation was added,
humm, unsure if a 'git bisect' would help here...

Masami?
 
> This seems to be a simple mistake so I wonder if I do something wrong.

- Arnaldo
