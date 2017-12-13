From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 2/2] perf test shell: Fix pathname arg in
 probe_vfs_getname.sh
Date: Wed, 13 Dec 2017 15:23:39 +0100 (CET)
Message-ID: <alpine.LRH.2.20.1712131520260.9416@Diego>
References: <b6d31ae26f8615d6bd020f4392980950d4c70c96.1513095505.git.mpetlan@redhat.com> <1645592263.12835937.1513095752603.JavaMail.zimbra@redhat.com> <20171212171106.GP3958@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753350AbdLMOXm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Dec 2017 09:23:42 -0500
In-Reply-To: <20171212171106.GP3958@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com

On Tue, 12 Dec 2017, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 12, 2017 at 11:22:32AM -0500, Michael Petlan escreveu:
> > Having 'filename' variable there seems to be more stable, since
> > 'result->name' has recently changed to 'result->uptr'.
> 
> Here it fails:
> 
> [root@jouet perf]# perf probe 'vfs_getname=getname_flags:72 pathname=filename:string'
> Added new event:
>   probe:vfs_getname    (on getname_flags:72 with pathname=filename:string)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe:vfs_getname -aR sleep 1
> 
> [root@jouet perf]# perf trace -e open,openat touch /tmp/temporary_file.zbMD1
>      0.042 ( 0.017 ms): touch/7761 open(filename: , flags: CLOEXEC                                       ) = 3
>      0.096 ( 0.018 ms): touch/7761 open(filename: , flags: CLOEXEC                                       ) = 3
>      0.679 ( 0.040 ms): touch/7761 open(filename: , flags: CLOEXEC                                       ) = 3
>      0.817 ( 0.252 ms): touch/7761 open(filename: , flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
> [root@jouet perf]#
> 
> And result->name is still there:
> 
> [root@jouet perf]# pahole -C filename ../build/v4.15.0-rc2+/fs/namei.o
> struct filename {
> 	const char  *              name;                 /*     0     8 */
> 	const char  *              uptr;                 /*     8     8 */
> 	struct audit_names *       aname;                /*    16     8 */
> 	int                        refcnt;               /*    24     4 */
> 	const char const           iname;                /*    28     0 */
> 
> 	/* size: 32, cachelines: 1, members: 5 */
> 	/* padding: 4 */
> 	/* last cacheline: 32 bytes */
> };
> [root@jouet perf]#
> 
> At getname_flags:72 result->name has it as expected, at least up to
> v4.15.0-rc2+, where are you experiencing problems?

[root@muflon-1 ~]# uname -r 
4.15.0-rc1

[root@muflon-1 ~]# perf -v
perf version 4.15.rc1.g4fbd8d

[root@muflon-1 ~]# perf probe 'vfs_getname=getname_flags:72 pathname=result->name:string'
Failed to find 'result' in this function.
  Error: Failed to add events.

[root@muflon-1 ~]# perf probe 'vfs_getname=getname_flags:72 pathname=filename:string'
Added new event:
  probe:vfs_getname    (on getname_flags:72 with pathname=filename:string)

You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname -aR sleep 1

[root@muflon-1 ~]# perf trace -e open,openat touch /tmp/temporary_file.zbMD1
     0.024 ( 0.013 ms): touch/31276 open(filename: /etc/ld.so.cache, flags: CLOEXEC                       ) = 3
     0.052 ( 0.014 ms): touch/31276 open(filename: /lib64/libc.so.6, flags: CLOEXEC                       ) = 3
     0.281 ( 0.019 ms): touch/31276 open(filename: /usr/lib/locale/locale-archive, flags: CLOEXEC         ) = 3
     0.344 ( 0.016 ms): touch/31276 open(filename: /tmp/temporary_file.zbMD1, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
