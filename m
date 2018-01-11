From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/2] perf-probe: Ensure debuginfo's build-id is correct
Date: Thu, 11 Jan 2018 12:06:31 -0300
Message-ID: <20180111150631.GC3025@kernel.org>
References: <151358211494.25261.16134489192749792799.stgit@devbox>
 <151358214328.25261.6660021248431426149.stgit@devbox>
 <20180104161728.GC14721@kernel.org>
 <20180111213119.b5e03409d6beb27e3f34fc5a@kernel.org>
 <20180111145932.GB3025@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933305AbeAKPGf (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Jan 2018 10:06:35 -0500
Content-Disposition: inline
In-Reply-To: <20180111145932.GB3025@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

Em Thu, Jan 11, 2018 at 11:59:32AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Jan 11, 2018 at 09:31:19PM +0900, Masami Hiramatsu escreveu:
> > On Thu, 4 Jan 2018 13:17:28 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Em Mon, Dec 18, 2017 at 04:29:03PM +0900, Masami Hiramatsu escreveu:
> > > > Ensure that the build-id of debuginfo is correctly matched to
> > > > target build-id, if not, it warns user to check the system
> > > > debuginfo package is correctly installed.

> > > So we look at a variety of files looking for one that has a matching
> > > build-id, I think the warning message should state that the file with
> > > the unmatched build-id is simply being skipped, no?

> > Actually, this patch series came from your request that you faced
> > buildid mismatch between running binary and debuginfo binary, and
> > you asked me to show the message to tell user what he needs to
> > check.

> > > And why do this at 'perf probe -l' time? I.e. at that point whatever
> > > probes that are in place already have all the needed debug info?

> > As I pointed, this is not only for perf-probe -l but also perf-probe -a
> 
> yeah, I recently noticed this while doind a gdb session, where it warned
> about buildid mismatches.
 
> I'll apply your patch, thanks for working on it!

Trying to test it, got no warning for the vmlinux case, need to
investigate, but have not time right now, so, just for documenting it
here and letting you know:

[root@jouet ~]# perf probe $verbose "vfs_getname=getname_flags:72 pathname=result->name:string"
Added new event:
  probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)

You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname -aR sleep 1

[root@jouet ~]# perf probe -l
  probe:vfs_getname    (on getname_flags:72@acme/git/linux/fs/namei.c with pathname)
[root@jouet ~]# 
[root@jouet ~]# uname -a
Linux jouet 4.15.0-rc7+ #6 SMP Thu Jan 11 11:39:11 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
[root@jouet ~]# mv /lib/modules/4.15.0-rc7+/build/vmlinux /lib/modules/4.15.0-rc7+/build/vmlinux.OFF
[root@jouet ~]# cp /lib/modules/4.14.0+/build/vmlinux /lib/modules/4.15.0-rc7+/build/vmlinux
[root@jouet ~]# perf probe -l
  probe:vfs_getname    (on getname_flags+147 with pathname)
[root@jouet ~]# perf probe -v -l
Opening /sys/kernel/debug/tracing//kprobe_events write=0
Opening /sys/kernel/debug/tracing//uprobe_events write=0
Parsing probe_events: p:probe/vfs_getname _text+2601267 pathname=+0(+0(%bx)):string
Group:probe Event:vfs_getname probe:p
Looking at the vmlinux_path (8 entries long)
symsrc__init: build id mismatch for /lib/modules/4.15.0-rc7+/build/vmlinux.
symsrc__init: cannot get elf header.
Using /proc/kcore for kernel object code
Using /proc/kallsyms for symbols
try to find information at 27b133 in kernel
Looking at the vmlinux_path (8 entries long)
symsrc__init: build id mismatch for /lib/modules/4.15.0-rc7+/build/vmlinux.
Failed to find the path for kernel: No such file or directory
Failed to find corresponding probes from debuginfo.
  probe:vfs_getname    (on getname_flags+147 with pathname)
[root@jouet ~]#

- Arnaldo
