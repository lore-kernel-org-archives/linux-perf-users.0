Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444A3284B37;
	Tue, 22 Sep 2026 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082704; cv=none; b=OVO8jTmrKqbl3jmXZDG4RlFHmSadFvyqxI8uuXiT0avshVwwWyLaDk+2T4bDTI/80RDRhutW0bNzUxqxTQTZM2o2zIX41Ta9aXr7sGWgGZnSeGRYqqKQ1YecoETuLfouBEHcMe1WSuCzMI3DsQnFxE4tFQVuZMZPqyJVMAqq8ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082704; c=relaxed/simple;
	bh=33PaNkpNF+y6IDTenB5ywEdxcx1urTTt1YCa/jDXvjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIfeQtKpjIchubTYX5/FEvcmOja8huOd8zsgFlhbWw5SD4fF3tbO44i78wgosup5JddxqbP7h+CZbUofBeiPaIfvsmxbvIhixgZl1oWSNfbiBSQjYCnN/ZEtKxEZX2Tqj53/H59rscj3FU36yi7qN96QNLg7bfNMGkOFbIM3Igo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iChIax6B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iChIax6B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89EA1F000FF;
	Tue, 22 Sep 2026 13:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790082702;
	bh=Pspu0np4+Tp4LALlXTnBNqD2HczdvX92B+DMqOpzuL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iChIax6BJaMqFLD9Mr/zW9vF3tcDK+Hn/dGSlsZedV9ZQBZz5XjnySedfCXY3/4Xk
	 iYHHnzXLcQuIJIkuTNqx6mG3Aywga8zHwRnhmypowAUFnpPOO7s4LfNWq6eGRyqhp+
	 onJhaZO0TEfnC3FJklsocv7eAKMDHD0i1hMqHy7sGwLZw/xv5CyiRyBBPpSVqK1sUB
	 LRXUTsHRprJZ2zDe7BhIeJ8jJ4zQBXVLaTOqk/MJE9w0oQmeXLzKT/0NHHNPpYXqfF
	 XIPf/yBgs9vtpRjiC9Tcdc1tCfwRQCqTA37U303C07SFQVQ9P2cU1UQgupGZ0eApoJ
	 jtlFk1A93d5DA==
Date: Tue, 22 Sep 2026 15:11:30 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, Howard Chu <howardchu95@gmail.com>,
	adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v4 00/18] perf trace: Fix BPF filtering and make tracing
 tests non-exclusive
Message-ID: <arJ-gpzqOHk-gF8T@x2>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918211932.2966061-1-irogers@google.com>

On Fri, Sep 18, 2026 at 02:19:14PM -0700, Ian Rogers wrote:
> perf trace's BPF augmentation attaches to raw_syscalls:sys_enter and
> raw_syscalls:sys_exit system wide, and used the program return value to
> decide whether a syscall was interesting. Returning 0 from a
> BPF_PROG_TYPE_TRACEPOINT program makes perf_trace_run_bpf_submit() drop
> the event for every listener on that tracepoint, not just for the perf
> trace that installed the program. Any concurrent perf trace, perf record
> or ftrace session watching raw_syscalls therefore lost events, which is
> one of the reasons so many of the perf trace and perf probe shell tests
> had to be marked (exclusive) and run on their own.
> 
> Patches 1 to 3 are independent fixes to the code the rest of the series
> goes on to rework or to rely on.
> 
> Patches 4 to 10 fix perf trace. They stop the return value being used as
> a filter and do the filtering in BPF maps instead, fix argument handling
> for the __data_loc internal tracepoint fields that syscalls:sys_enter_*
> gained in 6.19, stop the sys_exit program array tail calling a sys_enter
> augmenter, and replace the userspace PERF_RECORD_FORK/PERF_RECORD_EXIT
> bookkeeping with BTF-typed raw tracepoint programs on
> sched_process_{fork,exit,exec}. A task is then registered before its
> first syscall and evicted in do_exit(), rather than whenever userspace
> next drains the ring buffer.
> 
> Patches 11 to 18 deal with the tests. Several collided with each other
> through global state rather than through perf trace: fixed probe names,
> clear_all_probes() disabling every tracepoint on the system, and perf
> trace's hardcoded "probe:vfs_getname*" wildcard pinning probes belonging
> to other tests. With those scoped to a pid they can drop (exclusive) and
> run in parallel again.
> 
> Tested on x86_64. The trace and probe tests pass under 'perf test -r3',
> which runs the repeats concurrently. Every patch builds individually,
> and the series also builds with BUILD_BPF_SKEL=0.

Lots of changes, from a quick look all look sensible, I'll test it some
more, as in one case it segfaulted:

root@x2:~# strace -e perf_event_open perf trace -a sleep 1
<SNIP>
  262.297 ( 0.002 ms): ptyxis/30654 write(fd: 4<anon_inode:[eventfd]>, buf: \1\0\0\0\0\0\0\0, count: 8)   = 8
   262.304 ( 0.011 ms): ptyxis/30654 ppoll(ufds: 0x55dfa7a62f10, nfds: 11, tsp: 0x7ffc0701eed0, sigsetsize: 8) = 2
   262.318 ( 0.002 ms): ptyxis/30654 read(fd: 4<anon_inode:[eventfd]>, buf: 0x7ffc0701ee10, count: 8)      = 8
   262.324 ( 0.002 ms): ptyxis/30654 write(fd: 4<anon_inode:[eventfd]>, buf: \1\0\0\0\0\0\0\0, count: 8)   = 8
   262.328 ( 0.002 ms): ptyxis/30654 read(fd: 31</dev/ptmx>, buf: 0x55dfa8a54f19, count: 5751)             = 8
   262.332 ( 0.002 ms): ptyxis/30654 read(fd: 31</dev/ptmx>, buf: 0x55dfa8a54f20, count: 5744)             = -1 (unknown) (Resource temporarily unavailable)
LOST 70 events!
--- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_MAPERR, si_addr=0x117f000} ---
perf: Segmentation fault
    #0 0x73104f in dump_stack debug.c:366
    #1 0x7310c5 in sighandler_dump_stack debug.c:378
    #2 0x7f749ea66fb0 in __restore_rt libc.so.6[19fb0]
    #3 0x4c0fa0 in syscall_arg__scnprintf_buf builtin-trace.c:1955
    #4 0x4c2f3d in syscall_arg_fmt__scnprintf_val builtin-trace.c:2632
    #5 0x4c33ae in syscall__scnprintf_args builtin-trace.c:2722
    #6 0x4c43d3 in trace__sys_enter builtin-trace.c:3094
    #7 0x4c7865 in trace__handle_event builtin-trace.c:4013
    #8 0x4c9ab4 in __trace__deliver_event builtin-trace.c:4962
    #9 0x4c9c06 in trace__deliver_event builtin-trace.c:4988
    #10 0x4caed8 in trace__run builtin-trace.c:5397
    #11 0x4cf530 in cmd_trace builtin-trace.c:6681
    #12 0x4da43c in run_builtin perf.c:380
    #13 0x4da68e in handle_internal_command perf.c:430
    #14 0x4da7ea in run_argv perf.c:477
    #15 0x4daabe in main perf.c:577
    #16 0x7f749ea50681 in __libc_start_call_main libc.so.6[3681]
    #17 0x7f749ea50798 in __libc_start_main@@GLIBC_2.34 libc.so.6[3798]
    #18 0x409f25 in _start perf[409f25]
--- SIGSEGV {si_signo=SIGSEGV, si_code=SI_TKILL, si_pid=1097958, si_uid=0} ---
+++ killed by SIGSEGV (core dumped) +++
Segmentation fault         (core dumped) strace -e perf_event_open perf trace -a sleep 1
root@x2:~#

root@x2:~# uname -a
Linux x2 7.2.5-200.fc44.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Sep 11 15:11:05 UTC 2026 x86_64 GNU/Linux
root@x2:~#

- Arnaldo
