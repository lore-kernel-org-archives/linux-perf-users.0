From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: odd error from "perf record"
Date: Fri, 15 Jan 2016 18:17:51 -0300
Message-ID: <20160115211751.GI18367@kernel.org>
References: <569957F9.80700@clozure.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51166 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918AbcAOVS3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 15 Jan 2016 16:18:29 -0500
Content-Disposition: inline
In-Reply-To: <569957F9.80700@clozure.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Gary Byers <gb@clozure.com>
Cc: linux-perf-users@vger.kernel.org

Em Fri, Jan 15, 2016 at 01:35:05PM -0700, Gary Byers escreveu:
> Hi.
> 
> I happen to be using Ubuntu 15.10
> 
> [~] gb@abq> uname -a
> Linux abq 4.2.0-23-generic #28-Ubuntu SMP Sun Dec 27 17:47:31 UTC 2015
> x86_64 x86_64 x86_64 GNU/Linux
> 
> 
> I am trying to use perf to profile a 64-bit x86 Linux program. The program
> maps a large (512gb) chunk
> of address space, but "only" about 20mb of that are mapped with permissions
> that allow any of read,
> write, or execute access. (The atypical memory mapping is done for what I
> believe to be very good
> reasons and I don't think that those reasons are directly relevant here.)
> 
> Some of the code that I an trying to profile is on pages that have read and
> execute permissions
> and atypically "high" addresses, often of the form 0000300000xxxxxx,  If
> anyone reading this would
> find it helpful, I can certainly provide a copy of /proc/<pid>/maps or
> similar for a typical instance
> of the process.  As far as I know, few (if any) pages in the process are
> locked via mlock() or variants.
> 
> For the sake of argument, it may be helpful to think of that code as having
> been "JITted" there.  it is
> not mapped from an ELF executable or library, and my later questions may
> have to do with the .map file
> that I am trying to use to provide symbolic information

Right, see tools/perf/Documentation/jit-interface.txt to see how to
provide that map.

> 
> I have other issues that I would like to discuss in a followup message, but
> first:
> 
> When I call "perf record" on a running instance of the process, I often get
> an error
>  gb@abq> [~] gb@abq> perf record -p 18310
> Permission error mapping pages.
> Consider increasing /proc/sys/kernel/perf_event_mlock_kb,
> or try again with a smaller value of -m/--mmap_pages.
> (current value: 4294967295,0)

This current warning is useless, that big number means: nothing was set,
use the default 

The kernel returns EPERM for perf_mmap in these line in
kernel/events/core.c:

        user_lock_limit = sysctl_perf_event_mlock >> (PAGE_SHIFT - 10);

        /*
         * Increase the limit linearly with more CPUs:
         */
        user_lock_limit *= num_online_cpus();

        user_locked = atomic_long_read(&user->locked_vm) + user_extra;

        if (user_locked > user_lock_limit)
                extra = user_locked - user_lock_limit;

        lock_limit = rlimit(RLIMIT_MEMLOCK);
        lock_limit >>= PAGE_SHIFT;
        locked = vma->vm_mm->pinned_vm + extra;

        if ((locked > lock_limit) && perf_paranoid_tracepoint_raw() &&
                !capable(CAP_IPC_LOCK)) {
                ret = -EPERM;
                goto unlock;
        }


So you probably have a lot of CPUs, right? You hat CAP_IPC_LOCK is what
makes it not consider these limits for the root user, bump
/proc/sys/kernel/perf_event_mlock_kb it to a high enough value and you
should use it as a normal user, I think.

> [~] gb@abq> cat /proc/sys/kernel/perf_event_mlock_kb
> 516
> 
> If I try again with an explicit -m argument,I get a similar but slightly
> different error:
> [~] gb@abq> perf record -m 8 -p 18310
> 
> Permission error mapping pages.
> Consider increasing /proc/sys/kernel/perf_event_mlock_kb,
> or try again with a smaller value of -m/--mmap_pages.
> (current value: 8,0)
> 
> If I run 'perf record ..." as root, I get past this point but run into other
> issues that
> I will try to discuss in a later message and running as root is not always
> possible for my
> uaers
> 
> The code in question (and its source) are freely available and the source is
> licensed under an LGPL variant.
> 
> I'd be glad to provide that and any other help that anyone needs, and thanks
> for any help
> that anyone can provide,

if you could provide the minimal reproducer for this, i.e. a simple
program that does the kind of mapping you described and when monitored
produces the error being reported.

But please try bumping /proc/sys/kernel/perf_event_mlock_kb first.
 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
