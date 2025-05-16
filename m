Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E323312D;
	Fri, 16 May 2025 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747415243; cv=none; b=qZo3hqizB+hf8JLatcn9QtTd5gGHIA9qO31s/YMWIr5iu2ys06DJsBUTp1uCnR/3fTYFI+W79Uhr4qjzMj1bBs4S5tjgPuQUOZEmZExN8GPJrucC6YAsRUt1ET07QhSNfTESFOghl2CpavEt6StHEX3FrhtgKm8TaH7GuuNciqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747415243; c=relaxed/simple;
	bh=J4/1Jvp96+e8Sa0Uhp6FL/6qIaJEYJhOu3ystFmlTyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbEm54kS70y8cC81Fz0AA0UWB+nkrBGvB6RekOjHze2J4AJdqMHPixcjYQZI5GBGAD5MrJbyz2Ew0sR/jf9NoGm62YZlAKURhjL8HypghEV8t28OJEj693V8MV9pMQWGnLrA1sTe6aO0t5YB548MXFLG/SUVv/jk0x3ED+BL5d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFaFIptI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFaFIptI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94203C4CEE4;
	Fri, 16 May 2025 17:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747415243;
	bh=J4/1Jvp96+e8Sa0Uhp6FL/6qIaJEYJhOu3ystFmlTyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jFaFIptIijlJ0OSLo661WCHHNMZb7gLWSL4JHjwGkAa4/NNRTrqphzXux27KcVtdL
	 H4zAgl1ce9pfebMGgDQWI7Yug/CmV2PQb6cYcLzbP68ixy3GeB1GhBjoZeoM2Y9AxK
	 swAXj5mY85e422ScmoO2P9mVy+a7tEak3JKr3QXiET5+pdJ1PkLIcaVtBZmxIgIkZ/
	 RftQ3U8a49ik6bhgj2VDnP2h96mKCftOMKtWUNPOLDeYmQghIIQ+9Q7HtqkwBdtpWt
	 mvsOglyECExWf/vTmDwsCa6fI3VQBlmdH43L+OY5anJXUVjpPtobbAC6ARHd8v4z6m
	 wSrd79GUIU0kQ==
Date: Fri, 16 May 2025 10:07:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Sergei Trofimovich <slyich@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf unwind-libdw: skip non-regular files
Message-ID: <aCdwycWxRnbbHUke@google.com>
References: <20250505174419.2814857-1-slyich@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250505174419.2814857-1-slyich@gmail.com>

Hello,

On Mon, May 05, 2025 at 06:44:19PM +0100, Sergei Trofimovich wrote:
> Without the change `perf `hangs up on charaster devices. On my system
> it's enough to run system-wide sampler for a few seconds to get the
> hangup:
> 
>     $ perf record -a -g --call-graph=dwarf
>     $ perf report
>     # hung
> 
> `strace` shows that hangup happens on reading on a character device
> `/dev/dri/renderD128`
> 
>     $ strace -y -f -p 2780484
>     strace: Process 2780484 attached
>     pread64(101</dev/dri/renderD128>, strace: Process 2780484 detached
> 
> It's call trace descends into `elfutils`:
> 
>     $ gdb -p 2780484
>     (gdb) bt
>     #0  0x00007f5e508f04b7 in __libc_pread64 (fd=101, buf=0x7fff9df7edb0, count=0, offset=0)
>         at ../sysdeps/unix/sysv/linux/pread64.c:25
>     #1  0x00007f5e52b79515 in read_file () from /<<NIX>>/elfutils-0.192/lib/libelf.so.1
>     #2  0x00007f5e52b25666 in libdw_open_elf () from /<<NIX>>/elfutils-0.192/lib/libdw.so.1
>     #3  0x00007f5e52b25907 in __libdw_open_file () from /<<NIX>>/elfutils-0.192/lib/libdw.so.1
>     #4  0x00007f5e52b120a9 in dwfl_report_elf@@ELFUTILS_0.156 ()
>        from /<<NIX>>/elfutils-0.192/lib/libdw.so.1
>     #5  0x000000000068bf20 in __report_module (al=al@entry=0x7fff9df80010, ip=ip@entry=139803237033216, ui=ui@entry=0x5369b5e0)
>         at util/dso.h:537
>     #6  0x000000000068c3d1 in report_module (ip=139803237033216, ui=0x5369b5e0) at util/unwind-libdw.c:114
>     #7  frame_callback (state=0x535aef10, arg=0x5369b5e0) at util/unwind-libdw.c:242
>     #8  0x00007f5e52b261d3 in dwfl_thread_getframes () from /<<NIX>>/elfutils-0.192/lib/libdw.so.1
>     #9  0x00007f5e52b25bdb in get_one_thread_cb () from /<<NIX>>/elfutils-0.192/lib/libdw.so.1
>     #10 0x00007f5e52b25faa in dwfl_getthreads () from /<<NIX>>/elfutils-0.192/lib/libdw.so.1
>     #11 0x00007f5e52b26514 in dwfl_getthread_frames () from /<<NIX>>/elfutils-0.192/lib/libdw.so.1
>     #12 0x000000000068c6ce in unwind__get_entries (cb=cb@entry=0x5d4620 <unwind_entry>, arg=arg@entry=0x10cd5fa0,
>         thread=thread@entry=0x1076a290, data=data@entry=0x7fff9df80540, max_stack=max_stack@entry=127,
>         best_effort=best_effort@entry=false) at util/thread.h:152
>     #13 0x00000000005dae95 in thread__resolve_callchain_unwind (evsel=0x106006d0, thread=0x1076a290, cursor=0x10cd5fa0,
>         sample=0x7fff9df80540, max_stack=127, symbols=true) at util/machine.c:2939
>     #14 thread__resolve_callchain_unwind (thread=0x1076a290, cursor=0x10cd5fa0, evsel=0x106006d0, sample=0x7fff9df80540,
>         max_stack=127, symbols=true) at util/machine.c:2920
>     #15 __thread__resolve_callchain (thread=0x1076a290, cursor=0x10cd5fa0, evsel=0x106006d0, evsel@entry=0x7fff9df80440,
>         sample=0x7fff9df80540, parent=parent@entry=0x7fff9df804a0, root_al=root_al@entry=0x7fff9df80440, max_stack=127, symbols=true)
>         at util/machine.c:2970
>     #16 0x00000000005d0cb2 in thread__resolve_callchain (thread=<optimized out>, cursor=<optimized out>, evsel=0x7fff9df80440,
>         sample=<optimized out>, parent=0x7fff9df804a0, root_al=0x7fff9df80440, max_stack=127) at util/machine.h:198
>     #17 sample__resolve_callchain (sample=<optimized out>, cursor=<optimized out>, parent=parent@entry=0x7fff9df804a0,
>         evsel=evsel@entry=0x106006d0, al=al@entry=0x7fff9df80440, max_stack=max_stack@entry=127) at util/callchain.c:1127
>     #18 0x0000000000617e08 in hist_entry_iter__add (iter=iter@entry=0x7fff9df80480, al=al@entry=0x7fff9df80440, max_stack_depth=127,
>         arg=arg@entry=0x7fff9df81ae0) at util/hist.c:1255
>     #19 0x000000000045d2d0 in process_sample_event (tool=0x7fff9df81ae0, event=<optimized out>, sample=0x7fff9df80540,
>         evsel=0x106006d0, machine=<optimized out>) at builtin-report.c:334
>     #20 0x00000000005e3bb1 in perf_session__deliver_event (session=0x105ff2c0, event=0x7f5c7d735ca0, tool=0x7fff9df81ae0,
>         file_offset=2914716832, file_path=0x105ffbf0 "perf.data") at util/session.c:1367
>     #21 0x00000000005e8d93 in do_flush (oe=0x105ffa50, show_progress=false) at util/ordered-events.c:245
>     #22 __ordered_events__flush (oe=0x105ffa50, how=OE_FLUSH__ROUND, timestamp=<optimized out>) at util/ordered-events.c:324
>     #23 0x00000000005e1f64 in perf_session__process_user_event (session=0x105ff2c0, event=0x7f5c7d752b18, file_offset=2914835224,
>         file_path=0x105ffbf0 "perf.data") at util/session.c:1419
>     #24 0x00000000005e47c7 in reader__read_event (rd=rd@entry=0x7fff9df81260, session=session@entry=0x105ff2c0,
>     --Type <RET> for more, q to quit, c to continue without paging--
>     quit
>         prog=prog@entry=0x7fff9df81220) at util/session.c:2132
>     #25 0x00000000005e4b37 in reader__process_events (rd=0x7fff9df81260, session=0x105ff2c0, prog=0x7fff9df81220)
>         at util/session.c:2181
>     #26 __perf_session__process_events (session=0x105ff2c0) at util/session.c:2226
>     #27 perf_session__process_events (session=session@entry=0x105ff2c0) at util/session.c:2390
>     #28 0x0000000000460add in __cmd_report (rep=0x7fff9df81ae0) at builtin-report.c:1076
>     #29 cmd_report (argc=<optimized out>, argv=<optimized out>) at builtin-report.c:1827
>     #30 0x00000000004c5a40 in run_builtin (p=p@entry=0xd8f7f8 <commands+312>, argc=argc@entry=1, argv=argv@entry=0x7fff9df844b0)
>         at perf.c:351
>     #31 0x00000000004c5d63 in handle_internal_command (argc=argc@entry=1, argv=argv@entry=0x7fff9df844b0) at perf.c:404
>     #32 0x0000000000442de3 in run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:448
>     #33 main (argc=<optimized out>, argv=0x7fff9df844b0) at perf.c:556
> 
> The hangup happens because nothing in` perf` or `elfutils` checks if a
> mapped file is easily readable.
> 
> The change conservatively skips all non-regular files.
> 
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Arnaldo Carvalho de Melo <acme@kernel.org>
> CC: Namhyung Kim <namhyung@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> CC: Jiri Olsa <jolsa@kernel.org>
> CC: Ian Rogers <irogers@google.com>
> CC: Adrian Hunter <adrian.hunter@intel.com>
> CC: "Liang, Kan" <kan.liang@linux.intel.com>
> CC: linux-perf-users@vger.kernel.org
> Signed-off-by: Sergei Trofimovich <slyich@gmail.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/unwind-libdw.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
> index 793d11832694..ae70fb56a057 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -84,8 +84,11 @@ static int __report_module(struct addr_location *al, u64 ip,
>  		char filename[PATH_MAX];
>  
>  		__symbol__join_symfs(filename, sizeof(filename), dso__long_name(dso));
> -		mod = dwfl_report_elf(ui->dwfl, dso__short_name(dso), filename, -1,
> -				      base, false);
> +		/* Don't hang up on device files like /dev/dri/renderD128. */
> +		if (is_regular_file(filename)) {
> +			mod = dwfl_report_elf(ui->dwfl, dso__short_name(dso), filename, -1,
> +					      base, false);
> +		}
>  	}
>  	if (!mod) {
>  		char filename[PATH_MAX];
> -- 
> 2.49.0
> 
