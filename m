From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf test shell: Fix check open filename arg using
 'perf trace
Date: Mon, 11 Dec 2017 14:07:50 -0300
Message-ID: <20171211170750.GE3958@kernel.org>
References: <alpine.LRH.2.20.1712081845230.9416@Diego>
 <20171211154312.GC2221@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751628AbdLKRHx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Dec 2017 12:07:53 -0500
Content-Disposition: inline
In-Reply-To: <20171211154312.GC2221@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo de Melo <acme@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Em Mon, Dec 11, 2017 at 01:43:12PM -0200, Arnaldo de Melo escreveu:
> Em Fri, Dec 08, 2017 at 06:48:17PM +0100, Michael Petlan escreveu:
> > Hi Arnaldo, so I have tried what you've suggested and looks good.
> > Patch is attached. Sorry for not posting it in-text, but I need to
> > fix my mail client first, since it screwes some patches up due to
> > flowed-text...
> > Cheers,
> > Michael
> 
> Thanks, applying.

It is not working here:

[root@jouet mnt]# perf test -v 62
62: Check open filename arg using perf trace + vfs_getname:
--- start ---
test child forked, pid 4919
Added new event:
  probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)

You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname -aR sleep 1

test child finished with -1
---- end ----
Check open filename arg using perf trace + vfs_getname: FAILED!
[root@jouet mnt]#

and when I run this with strace -e open to see if it is picking the
right script, it is:

open("/home/acme/libexec/perf-core/tests/shell/record+script_probe_vfs_getname.sh", O_RDONLY) = 4
open("/home/acme/libexec/perf-core/tests/shell/trace+probe_libc_inet_pton.sh", O_RDONLY) = 4
open("/home/acme/libexec/perf-core/tests/shell/trace+probe_vfs_getname.sh", O_RDONLY) = 4
62: Check open filename arg using perf trace + vfs_getname:
--- start ---
test child forked, pid 4947
Added new event:
  probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)

You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname -aR sleep 1

--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=4947, si_uid=0, si_status=255, si_utime=0, si_stime=0} ---
test child finished with -1
---- end ----
Check open filename arg using perf trace + vfs_getname: FAILED!
open("/home/acme/libexec/perf-core/tests/shell/probe_vfs_getname.sh", O_RDONLY) = 4
+++ exited with 0 +++
[root@jouet mnt]# 

[acme@jouet linux]$ diff -u /home/acme/libexec/perf-core/tests/shell/probe_vfs_getname.sh tools/perf/tests/shell/probe_vfs_getname.sh 
[acme@jouet linux]$ git log --oneline -1
0553ba305e4e (HEAD -> perf/core) perf test shell: Fix check open filename arg using 'perf trace
[acme@jouet linux]$ 

So can you please check if the file you're using is the one in this
patch submission?

- Arnaldo
