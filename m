Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C0201269;
	Wed, 12 Feb 2025 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739394426; cv=none; b=IhHOtgOzfY9Ye6TW/T5WYuf+wbDPKL8jjq7NTQQ3bE1xESxIUciEi4FVlisLNW7gGFCCkVYH/IyP8jSbNKWwCYyoH/pMaLUEtq3TxrnBfWQ9etMm5/AhPyxj0JeNv0pc3J6B0eUyajRhc/COxp8ftWwnkTXnSArvk73MeOQvFdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739394426; c=relaxed/simple;
	bh=wocYZo5gW+t7bu0YpWlDKB7vx4UV/EHEFSUdsgZuovw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HubW/E0QHvT4On2M3xIUntG6mEW5pGFE0iIbE3b+nksgFnJVfouQ4xMh7kt0hApWb9jJr2pNTyXzjT7+43lU1xw81mSV1LJ1qr9qfIv/dp5ndq8b0zHTVeNnIz7/qwn5Gva9Y776wolgyTQcJ1BtF3XB8DKPfo0yvD4MWrN75nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLDTVdpf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLDTVdpf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F48C4CEDF;
	Wed, 12 Feb 2025 21:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739394425;
	bh=wocYZo5gW+t7bu0YpWlDKB7vx4UV/EHEFSUdsgZuovw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CLDTVdpfedNnAB5ZoigALcQgb1ycOUeCaratiDCaa6pPZKTLri3qgZIPZIXUvHXet
	 m7d54WRJYjrTKOo1sxK+lvl2KECi/xF1TiMN4hNd57xADkL8aqgI+pgrhWbIFlOzmZ
	 pOoxdeN6FG8Ib+ReuYGt5NML7tFifhvjRAf07qADr8gHxuMJt+SoZHheVDOU5/OmW8
	 s745Hj2eaU1KlxoSP9YORkPJCcgEEdnw5WFXYByr28Rvsgd4b4xf5ww8clsjXhuuUC
	 wHVfy77e9fyOEYFkwuur8qvxLheT9nl7oHTfnwx6soIzgw1Go1A5JjmUqzSzVYeMvL
	 xeUdVZD/DWqvA==
Date: Wed, 12 Feb 2025 22:07:02 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
Message-ID: <Z60Ndm8VVI4Ao31U@x1>
References: <20250206000137.2026034-1-namhyung@kernel.org>
 <Z60NFEAf2C8cL8Xh@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z60NFEAf2C8cL8Xh@x1>

On Wed, Feb 12, 2025 at 10:05:27PM +0100, Arnaldo Carvalho de Melo wrote:
> On Wed, Feb 05, 2025 at 04:01:37PM -0800, Namhyung Kim wrote:
> > Sometimes we need to analyze the data in process level but current sort
> > keys only work on thread level.  Let's add 'tgid' sort key for that as
> > 'pid' is already taken for thread.
> > 
> > This will look mostly the same, but it only uses tgid instead of tid.
> > Here's an example of a process with two threads (thloop).
> > 
> >   $ perf record -- perf test -w thloop
> 
> Unrelated, but when building perf with DEBUG=1 and trying to test the
> above I noticed:
> 
> root@number:~# perf record -- perf test -w thloop
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.404 MB perf.data (7968 samples) ]
> perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.
> Aborted (core dumped)
> root@number:~# perf record -- perf test -w offcpu
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.040 MB perf.data (23 samples) ]
> perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.
> Aborted (core dumped)
> root@number:~#
> 
> I have:
> 
> ⬢ [acme@toolbox perf-tools-next]$ git log --oneline perf-tools-next/perf-tools-next..
> 9de1ed6fa3b73cb1 (HEAD -> perf-tools-next) perf report: Add 'tgid' sort key
> 23e98ede2a353530 perf trace: Add --summary-mode option
> e6d6104625a3790b perf tools: Get rid of now-unused rb_resort.h
> 173ec14e72ef4ed7 perf trace: Convert syscall_stats to hashmap
> 66edfb5d404e743d perf trace: Allocate syscall stats only if summary is on
> ca6637e1ea08e6f4 perf parse-events filter: Use evsel__find_pmu()
> bd1ac4a678f7f2c8 perf bench evlist-open-close: Reduce scope of 2 variables
> cd59081880e89df8 perf test: Add direct off-cpu test
> 56cbd794c0c46ba9 perf record --off-cpu: Add --off-cpu-thresh option
> 28d9b19c5455556f perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
> 2bc05b02743b50a7 perf script: Display off-cpu samples correctly
> bfa457a621596947 perf record --off-cpu: Disable perf_event's callchain collection
> eca732cc42d20266 perf evsel: Assemble offcpu samples
> 74ce50e40c569e90 perf record --off-cpu: Dump off-cpu samples in BPF
> e75f8ce63bfa6cb9 perf record --off-cpu: Preparation of off-cpu BPF program
> 0ffab9d26971c91c perf record --off-cpu: Parse off-cpu event
> efc3fe2070853b7d perf evsel: Expose evsel__is_offcpu_event() for future use
> ⬢ [acme@toolbox perf-tools-next]$
> 
> locally, that is the stuff I've been testing lately, doubt it is related
> to these patches, I'll investigate later, have to go AFK, so FWIW as a
> heads up.

Had time to extract this, now going really AFK:

[New Thread 0x7fffdf24c6c0 (LWP 580622)]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.403 MB perf.data (7948 samples) ]
[Thread 0x7fffdf24c6c0 (LWP 580622) exited]
perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.

Thread 1 "perf" received signal SIGABRT, Aborted.
Downloading 4.06 K source file /usr/src/debug/glibc-2.39-37.fc40.x86_64/nptl/pthread_kill.c
__pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44                                                                      
44	      return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCALL_ERRNO (ret) : 0;
(gdb) bt
#0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
#1  0x00007ffff6ea80a3 in __pthread_kill_internal (threadid=<optimized out>, signo=6) at pthread_kill.c:78
#2  0x00007ffff6e4ef1e in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
#3  0x00007ffff6e36902 in __GI_abort () at abort.c:79
#4  0x00007ffff6e3681e in __assert_fail_base (fmt=0x7ffff6fc3bb8 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=assertion@entry=0x7bef08 "map__end(prev) <= map__end(map)", 
    file=file@entry=0x7bedf8 "util/maps.c", line=line@entry=95, function=function@entry=0x7bf1c0 <__PRETTY_FUNCTION__.6> "check_invariants") at assert.c:96
#5  0x00007ffff6e47047 in __assert_fail (assertion=0x7bef08 "map__end(prev) <= map__end(map)", file=0x7bedf8 "util/maps.c", line=95, 
    function=0x7bf1c0 <__PRETTY_FUNCTION__.6> "check_invariants") at assert.c:105
#6  0x00000000006347a1 in check_invariants (maps=0xf987e0) at util/maps.c:95
#7  0x0000000000635ae2 in maps__remove (maps=0xf987e0, map=0xf98a80) at util/maps.c:538
#8  0x000000000062afd2 in machine__destroy_kernel_maps (machine=0xf98178) at util/machine.c:1176
#9  0x000000000062b32b in machines__destroy_kernel_maps (machines=0xf98178) at util/machine.c:1238
#10 0x00000000006388af in perf_session__destroy_kernel_maps (session=0xf97f60) at util/session.c:105
#11 0x0000000000638df0 in perf_session__delete (session=0xf97f60) at util/session.c:248
#12 0x0000000000431f18 in __cmd_record (rec=0xecace0 <record>, argc=4, argv=0x7fffffffde60) at builtin-record.c:2888
#13 0x00000000004351fb in cmd_record (argc=4, argv=0x7fffffffde60) at builtin-record.c:4286
#14 0x00000000004bd4d4 in run_builtin (p=0xecddc0 <commands+288>, argc=6, argv=0x7fffffffde60) at perf.c:351
#15 0x00000000004bd77b in handle_internal_command (argc=6, argv=0x7fffffffde60) at perf.c:404
#16 0x00000000004bd8d4 in run_argv (argcp=0x7fffffffdc4c, argv=0x7fffffffdc40) at perf.c:448
#17 0x00000000004bdc1d in main (argc=6, argv=0x7fffffffde60) at perf.c:556
(gdb)
 
> - Arnaldo
> 
> >   $ perf report --stdio -s tgid,pid -H
> >   ...
> >   #
> >   #    Overhead  Tgid:Command / Pid:Command
> >   # ...........  ..........................
> >   #
> >      100.00%     2018407:perf
> >          50.34%     2018407:perf
> >          49.66%     2018409:perf
> > 
> > Suggested-by: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-report.txt |  1 +
> >  tools/perf/util/hist.h                   |  1 +
> >  tools/perf/util/sort.c                   | 35 ++++++++++++++++++++++++
> >  tools/perf/util/sort.h                   |  1 +
> >  4 files changed, 38 insertions(+)
> > 
> > diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> > index 87f86451940623f3..4050ec4038425bf0 100644
> > --- a/tools/perf/Documentation/perf-report.txt
> > +++ b/tools/perf/Documentation/perf-report.txt
> > @@ -79,6 +79,7 @@ OPTIONS
> >  
> >  	- comm: command (name) of the task which can be read via /proc/<pid>/comm
> >  	- pid: command and tid of the task
> > +	- tgid: command and tgid of the task
> >  	- dso: name of library or module executed at the time of sample
> >  	- dso_size: size of library or module executed at the time of sample
> >  	- symbol: name of function executed at the time of sample
> > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > index 46c8373e314657fa..c164e178e0a48a8e 100644
> > --- a/tools/perf/util/hist.h
> > +++ b/tools/perf/util/hist.h
> > @@ -38,6 +38,7 @@ enum hist_column {
> >  	HISTC_TIME,
> >  	HISTC_DSO,
> >  	HISTC_THREAD,
> > +	HISTC_TGID,
> >  	HISTC_COMM,
> >  	HISTC_CGROUP_ID,
> >  	HISTC_CGROUP,
> > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > index 3dd33721823f365d..5987438174967fd6 100644
> > --- a/tools/perf/util/sort.c
> > +++ b/tools/perf/util/sort.c
> > @@ -141,6 +141,40 @@ struct sort_entry sort_thread = {
> >  	.se_width_idx	= HISTC_THREAD,
> >  };
> >  
> > +/* --sort tgid */
> > +
> > +static int64_t
> > +sort__tgid_cmp(struct hist_entry *left, struct hist_entry *right)
> > +{
> > +	return thread__pid(right->thread) - thread__pid(left->thread);
> > +}
> > +
> > +static int hist_entry__tgid_snprintf(struct hist_entry *he, char *bf,
> > +				       size_t size, unsigned int width)
> > +{
> > +	int tgid = thread__pid(he->thread);
> > +	const char *comm = NULL;
> > +
> > +	if (thread__pid(he->thread) == thread__tid(he->thread)) {
> > +		comm = thread__comm_str(he->thread);
> > +	} else {
> > +		struct maps *maps = thread__maps(he->thread);
> > +		struct thread *leader = machine__find_thread(maps__machine(maps),
> > +							     tgid, tgid);
> > +		if (leader)
> > +			comm = thread__comm_str(leader);
> > +	}
> > +	width = max(7U, width) - 8;
> > +	return repsep_snprintf(bf, size, "%7d:%-*.*s", tgid, width, width, comm ?: "");
> > +}
> > +
> > +struct sort_entry sort_tgid = {
> > +	.se_header	= "   Tgid:Command",
> > +	.se_cmp		= sort__tgid_cmp,
> > +	.se_snprintf	= hist_entry__tgid_snprintf,
> > +	.se_width_idx	= HISTC_TGID,
> > +};
> > +
> >  /* --sort simd */
> >  
> >  static int64_t
> > @@ -2501,6 +2535,7 @@ static void sort_dimension_add_dynamic_header(struct sort_dimension *sd)
> >  
> >  static struct sort_dimension common_sort_dimensions[] = {
> >  	DIM(SORT_PID, "pid", sort_thread),
> > +	DIM(SORT_TGID, "tgid", sort_tgid),
> >  	DIM(SORT_COMM, "comm", sort_comm),
> >  	DIM(SORT_DSO, "dso", sort_dso),
> >  	DIM(SORT_SYM, "symbol", sort_sym),
> > diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> > index a8572574e1686be6..6044eb1d61447c0d 100644
> > --- a/tools/perf/util/sort.h
> > +++ b/tools/perf/util/sort.h
> > @@ -72,6 +72,7 @@ enum sort_type {
> >  	SORT_ANNOTATE_DATA_TYPE_OFFSET,
> >  	SORT_SYM_OFFSET,
> >  	SORT_ANNOTATE_DATA_TYPE_CACHELINE,
> > +	SORT_TGID,
> >  
> >  	/* branch stack specific sort keys */
> >  	__SORT_BRANCH_STACK,
> > -- 
> > 2.48.1.502.g6dc24dfdaf-goog
