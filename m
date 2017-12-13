From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/2] perf test shell: Fix pathname arg in
 probe_vfs_getname.sh
Date: Wed, 13 Dec 2017 11:58:56 -0300
Message-ID: <20171213145856.GB9490@kernel.org>
References: <b6d31ae26f8615d6bd020f4392980950d4c70c96.1513095505.git.mpetlan@redhat.com>
 <1645592263.12835937.1513095752603.JavaMail.zimbra@redhat.com>
 <20171212171106.GP3958@kernel.org>
 <alpine.LRH.2.20.1712131520260.9416@Diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751326AbdLMO7B (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Dec 2017 09:59:01 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.1712131520260.9416@Diego>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com

Em Wed, Dec 13, 2017 at 03:23:39PM +0100, Michael Petlan escreveu:
> On Tue, 12 Dec 2017, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Dec 12, 2017 at 11:22:32AM -0500, Michael Petlan escreveu:
> > > Having 'filename' variable there seems to be more stable, since
> > > 'result->name' has recently changed to 'result->uptr'.

> > Here it fails:

> > [root@jouet perf]# perf probe 'vfs_getname=getname_flags:72 pathname=filename:string'
> > Added new event:
> >   probe:vfs_getname    (on getname_flags:72 with pathname=filename:string)

> > You can now use it in all perf tools, such as:

> > 	perf record -e probe:vfs_getname -aR sleep 1
> > 
> > [root@jouet perf]# perf trace -e open,openat touch /tmp/temporary_file.zbMD1
> >      0.042 ( 0.017 ms): touch/7761 open(filename: , flags: CLOEXEC                                       ) = 3
> >      0.096 ( 0.018 ms): touch/7761 open(filename: , flags: CLOEXEC                                       ) = 3
> >      0.679 ( 0.040 ms): touch/7761 open(filename: , flags: CLOEXEC                                       ) = 3
> >      0.817 ( 0.252 ms): touch/7761 open(filename: , flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
> > [root@jouet perf]#

> > And result->name is still there:

> > [root@jouet perf]# pahole -C filename ../build/v4.15.0-rc2+/fs/namei.o
> > struct filename {
> > 	const char  *              name;                 /*     0     8 */
> > 	const char  *              uptr;                 /*     8     8 */
> > 	struct audit_names *       aname;                /*    16     8 */
> > 	int                        refcnt;               /*    24     4 */
> > 	const char const           iname;                /*    28     0 */
> > 
> > 	/* size: 32, cachelines: 1, members: 5 */
> > 	/* padding: 4 */
> > 	/* last cacheline: 32 bytes */
> > };
> > [root@jouet perf]#
> > 
> > At getname_flags:72 result->name has it as expected, at least up to
> > v4.15.0-rc2+, where are you experiencing problems?
> 
> [root@muflon-1 ~]# uname -r 
> 4.15.0-rc1
> 
> [root@muflon-1 ~]# perf -v
> perf version 4.15.rc1.g4fbd8d
> 
> [root@muflon-1 ~]# perf probe 'vfs_getname=getname_flags:72 pathname=result->name:string'
> Failed to find 'result' in this function.
>   Error: Failed to add events.

Ok, so we need to dig further, as, on a f26 x86_64 system updated yesterday to 4.15-rc3 I get:

[root@jouet ~]# perf probe 'vfs_getname=getname_flags:72 pathname=result->name:string'
Added new event:
  probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)

You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname -aR sleep 1

[root@jouet ~]# uname -a
Linux jouet 4.15.0-rc3+ #3 SMP Wed Dec 13 10:14:18 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
[root@jouet ~]# 
[root@jouet ~]# perf trace -e open,probe:vfs_getname/max-stack=3/
     0.000 ( 0.036 ms): lighttpd/9653 open(filename: /proc/loadavg, mode: ISGID|IXOTH                       ) ...
     0.036 (         ): probe:vfs_getname:(ffffffff8227c9f3) pathname="/proc/loadavg")
                                       getname_flags ([kernel.kallsyms])
                                       do_sys_open ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
     0.000 ( 0.104 ms): lighttpd/9653  ... [continued]: open()) = 8
    22.681 (         ): probe:vfs_getname:(ffffffff8227c9f3) pathname="/etc/localtime")
                                       getname_flags ([kernel.kallsyms])
                                       user_path_at_empty ([kernel.kallsyms])
                                       vfs_statx ([kernel.kallsyms])
   850.746 (         ): probe:vfs_getname:(ffffffff8227c9f3) pathname="/var/cache/app-info/yaml")
                                       getname_flags ([kernel.kallsyms])
                                       user_path_at_empty ([kernel.kallsyms])
                                       sys_inotify_add_watch ([kernel.kallsyms])
   850.781 (         ): probe:vfs_getname:(ffffffff8227c9f3) pathname="/var/lib/app-info/xmls")
                                       getname_flags ([kernel.kallsyms])
                                       user_path_at_empty ([kernel.kallsyms])
                                       sys_inotify_add_watch ([kernel.kallsyms])
   850.799 (         ): probe:vfs_getname:(ffffffff8227c9f3) pathname="/var/lib/app-info/yaml")
                                       getname_flags ([kernel.kallsyms])
                                       user_path_at_empty ([kernel.kallsyms])
                                       sys_inotify_add_watch ([kernel.kallsyms])
   850.813 (         ): probe:vfs_getname:(ffffffff8227c9f3) pathname="/usr/share/app-info/yaml")
                                       getname_flags ([kernel.kallsyms])
                                       user_path_at_empty ([kernel.kallsyms])
                                       sys_inotify_add_watch ([kernel.kallsyms])
   850.832 (         ): probe:vfs_getname:(ffffffff8227c9f3) pathname="/usr/local/share/app-info/xmls")
                                       getname_flags ([kernel.kallsyms])
                                       user_path_at_empty ([kernel.kallsyms])

What system is this? Distro, release, gcc, etc?

- ARnaldo
 
> [root@muflon-1 ~]# perf probe 'vfs_getname=getname_flags:72 pathname=filename:string'
> Added new event:
>   probe:vfs_getname    (on getname_flags:72 with pathname=filename:string)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe:vfs_getname -aR sleep 1
> 
> [root@muflon-1 ~]# perf trace -e open,openat touch /tmp/temporary_file.zbMD1
>      0.024 ( 0.013 ms): touch/31276 open(filename: /etc/ld.so.cache, flags: CLOEXEC                       ) = 3
>      0.052 ( 0.014 ms): touch/31276 open(filename: /lib64/libc.so.6, flags: CLOEXEC                       ) = 3
>      0.281 ( 0.019 ms): touch/31276 open(filename: /usr/lib/locale/locale-archive, flags: CLOEXEC         ) = 3
>      0.344 ( 0.016 ms): touch/31276 open(filename: /tmp/temporary_file.zbMD1, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
