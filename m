Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B5D1953A9;
	Fri, 14 Feb 2025 22:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739571763; cv=none; b=tQ49u2LRF+rBUq4Qy4wGxpjEj6svog3FZ5YkA47c5/dfLc7G97nkUkfmqu/EdGkfaMztNimvY/DdEHVXLQGVbcpbnCibSEpYMMc390UhTxq76M78o+MLwt5YxE5EPDPaC79Yzv47pMOZTdm1hnBDT1DxtKhO2ZokeI4gszxGfc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739571763; c=relaxed/simple;
	bh=1qa4ZiDvtyQnPCl0OEkJZhX55DItI8n9KYg6kn73BwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jL2EnNc1ydz/BN+ZRPW5OHebk39zFeKPklZIYAG1uy0TFf3iphl0db/gCtT0DKhyvpX/400tpAt8U8jTZXv6Pnj0chsJ4h4ao4j8k+QA0l0wx4jrkGnJSQRXMFwqMTHNDGw8juWr7ddeVpLJhNenwRO5Ni/AqezEqMj1gQFeUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXUMuMAK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXUMuMAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60111C4CED1;
	Fri, 14 Feb 2025 22:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739571762;
	bh=1qa4ZiDvtyQnPCl0OEkJZhX55DItI8n9KYg6kn73BwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XXUMuMAK5eXi66mDnwVzrMQyKKzdOknzQfFWgoTyDdFOYIpEhhKA5IoQeErdIs4uU
	 nbaYv05KTG62QuA7QCrxoBmaJTJOerb3JhbeWVpnsN1Em2MYvFKR1IVfGZ9kNh7ZfB
	 AynporNaOsNwlcZ4WZbn71nqAQvoSLUT/xrkkZtooJkML29ttAYP3sLWhleyOaqv7Y
	 oFUcX/zw7b5Orne+6Bd1gNBp9qQLz+R7bl8Gf7NM0LH7I1OIcWc8fr6OboXGj4GiqG
	 3PDefxj8qjih+dV4OwldIRo3DyAY0HiYDYc0J8puEwX6JIvNePuqGs7s5fUHZhCy1A
	 h8TNx8mpUoTOA==
Date: Fri, 14 Feb 2025 23:22:39 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
Message-ID: <Z6_CL0RpUUvw0lR7@x1>
References: <20250206000137.2026034-1-namhyung@kernel.org>
 <Z60NFEAf2C8cL8Xh@x1>
 <Z60Ndm8VVI4Ao31U@x1>
 <CAP-5=fXw09MM5XyozJMM3FjMANJei1aNVmBghSEQFiCKAtJmXw@mail.gmail.com>
 <CAP-5=fUqcykMdApHVweETg9bp2EVPJhJOj_PR8cByOOA6OyQGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUqcykMdApHVweETg9bp2EVPJhJOj_PR8cByOOA6OyQGw@mail.gmail.com>

On Wed, Feb 12, 2025 at 02:10:42PM -0800, Ian Rogers wrote:
> On Wed, Feb 12, 2025 at 1:59 PM Ian Rogers <irogers@google.com> wrote:
> > On Wed, Feb 12, 2025 at 1:07 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > On Wed, Feb 12, 2025 at 10:05:27PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > On Wed, Feb 05, 2025 at 04:01:37PM -0800, Namhyung Kim wrote:
> > > > > Sometimes we need to analyze the data in process level but current sort
> > > > > keys only work on thread level.  Let's add 'tgid' sort key for that as
> > > > > 'pid' is already taken for thread.

> > > > > This will look mostly the same, but it only uses tgid instead of tid.
> > > > > Here's an example of a process with two threads (thloop).

> > > > >   $ perf record -- perf test -w thloop

> > > > Unrelated, but when building perf with DEBUG=1 and trying to test the
> > > > above I noticed:

> > > > root@number:~# perf record -- perf test -w thloop
> > > > [ perf record: Woken up 1 times to write data ]
> > > > [ perf record: Captured and wrote 0.404 MB perf.data (7968 samples) ]
> > > > perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.
> > > > Aborted (core dumped)
> > > > root@number:~# perf record -- perf test -w offcpu
> > > > [ perf record: Woken up 1 times to write data ]
> > > > [ perf record: Captured and wrote 0.040 MB perf.data (23 samples) ]
> > > > perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.
> > > > Aborted (core dumped)
> > > > root@number:~#

> > > > I have:

> > > > ⬢ [acme@toolbox perf-tools-next]$ git log --oneline perf-tools-next/perf-tools-next..
> > > > 9de1ed6fa3b73cb1 (HEAD -> perf-tools-next) perf report: Add 'tgid' sort key
> > > > 23e98ede2a353530 perf trace: Add --summary-mode option
> > > > e6d6104625a3790b perf tools: Get rid of now-unused rb_resort.h
> > > > 173ec14e72ef4ed7 perf trace: Convert syscall_stats to hashmap
> > > > 66edfb5d404e743d perf trace: Allocate syscall stats only if summary is on
> > > > ca6637e1ea08e6f4 perf parse-events filter: Use evsel__find_pmu()
> > > > bd1ac4a678f7f2c8 perf bench evlist-open-close: Reduce scope of 2 variables
> > > > cd59081880e89df8 perf test: Add direct off-cpu test
> > > > 56cbd794c0c46ba9 perf record --off-cpu: Add --off-cpu-thresh option
> > > > 28d9b19c5455556f perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
> > > > 2bc05b02743b50a7 perf script: Display off-cpu samples correctly
> > > > bfa457a621596947 perf record --off-cpu: Disable perf_event's callchain collection
> > > > eca732cc42d20266 perf evsel: Assemble offcpu samples
> > > > 74ce50e40c569e90 perf record --off-cpu: Dump off-cpu samples in BPF
> > > > e75f8ce63bfa6cb9 perf record --off-cpu: Preparation of off-cpu BPF program
> > > > 0ffab9d26971c91c perf record --off-cpu: Parse off-cpu event
> > > > efc3fe2070853b7d perf evsel: Expose evsel__is_offcpu_event() for future use
> > > > ⬢ [acme@toolbox perf-tools-next]$

> > > > locally, that is the stuff I've been testing lately, doubt it is related
> > > > to these patches, I'll investigate later, have to go AFK, so FWIW as a
> > > > heads up.

> > > Had time to extract this, now going really AFK:

> > > [New Thread 0x7fffdf24c6c0 (LWP 580622)]
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.403 MB perf.data (7948 samples) ]
> > > [Thread 0x7fffdf24c6c0 (LWP 580622) exited]
> > > perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.

> > > Thread 1 "perf" received signal SIGABRT, Aborted.
> > > Downloading 4.06 K source file /usr/src/debug/glibc-2.39-37.fc40.x86_64/nptl/pthread_kill.c
> > > __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
> > > 44            return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCALL_ERRNO (ret) : 0;
> > > (gdb) bt
> > > #0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
> > > #1  0x00007ffff6ea80a3 in __pthread_kill_internal (threadid=<optimized out>, signo=6) at pthread_kill.c:78
> > > #2  0x00007ffff6e4ef1e in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
> > > #3  0x00007ffff6e36902 in __GI_abort () at abort.c:79
> > > #4  0x00007ffff6e3681e in __assert_fail_base (fmt=0x7ffff6fc3bb8 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=assertion@entry=0x7bef08 "map__end(prev) <= map__end(map)",
> > >     file=file@entry=0x7bedf8 "util/maps.c", line=line@entry=95, function=function@entry=0x7bf1c0 <__PRETTY_FUNCTION__.6> "check_invariants") at assert.c:96
> > > #5  0x00007ffff6e47047 in __assert_fail (assertion=0x7bef08 "map__end(prev) <= map__end(map)", file=0x7bedf8 "util/maps.c", line=95,
> > >     function=0x7bf1c0 <__PRETTY_FUNCTION__.6> "check_invariants") at assert.c:105
> > > #6  0x00000000006347a1 in check_invariants (maps=0xf987e0) at util/maps.c:95
> > > #7  0x0000000000635ae2 in maps__remove (maps=0xf987e0, map=0xf98a80) at util/maps.c:538
> > > #8  0x000000000062afd2 in machine__destroy_kernel_maps (machine=0xf98178) at util/machine.c:1176
> > > #9  0x000000000062b32b in machines__destroy_kernel_maps (machines=0xf98178) at util/machine.c:1238
> > > #10 0x00000000006388af in perf_session__destroy_kernel_maps (session=0xf97f60) at util/session.c:105
> > > #11 0x0000000000638df0 in perf_session__delete (session=0xf97f60) at util/session.c:248
> > > #12 0x0000000000431f18 in __cmd_record (rec=0xecace0 <record>, argc=4, argv=0x7fffffffde60) at builtin-record.c:2888
> > > #13 0x00000000004351fb in cmd_record (argc=4, argv=0x7fffffffde60) at builtin-record.c:4286
> > > #14 0x00000000004bd4d4 in run_builtin (p=0xecddc0 <commands+288>, argc=6, argv=0x7fffffffde60) at perf.c:351
> > > #15 0x00000000004bd77b in handle_internal_command (argc=6, argv=0x7fffffffde60) at perf.c:404
> > > #16 0x00000000004bd8d4 in run_argv (argcp=0x7fffffffdc4c, argv=0x7fffffffdc40) at perf.c:448
> > > #17 0x00000000004bdc1d in main (argc=6, argv=0x7fffffffde60) at perf.c:556
> > > (gdb)

> > So my guess would be that something modified a map and broke the
> > invariants of the maps_by_addresss/maps_by_name. It should be possible
> > to add more check_invariants to work out where this happens.
 
> I also suspect this is a regression. If you could bisect to find the

I bisected it to:

⬢ [acme@toolbox perf-tools-next]$ git bisect good
876e80cf83d10585df6ee1e353cfbf562f9a930e is the first bad commit
commit 876e80cf83d10585df6ee1e353cfbf562f9a930e
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Wed Dec 18 14:04:53 2024 -0800

    perf tools: Fixup end address of modules
    
    In machine__create_module(), it reads /proc/modules to get a list of
    modules in the system.  The file shows the start address (of text) and
    the size of the module so it uses the info to reconstruct system memory
    maps for symbol resolution.
    
    But module memory consists of multiple segments and they can be
    scaterred.  Currently perf tools assume they are contiguous and see some
    overlaps.  This can confuse the tool when it finds a map containing a
    given address.
    
    As we mostly care about the function symbols in the text segment, it can
    fixup the size or end address of modules when there's an overlap.  We
    can use maps__fixup_end() which updates the end address using the start
    address of the next map.
    
    Ideally it should be able to track other segments (like data/rodata),
    but that would require some changes in /proc/modules IMHO.
    
    Reported-by: Blake Jones <blakejones@google.com>
    Signed-off-by: Namhyung Kim <namhyung@kernel.org>
    Acked-by: Ian Rogers <irogers@google.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Daniel Gomez <da.gomez@samsung.com>
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Luis Chamberlain <mcgrof@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Petr Pavlu <petr.pavlu@suse.com>
    Cc: Sami Tolvanen <samitolvanen@google.com>
    Link: https://lore.kernel.org/r/20241218220453.203069-1-namhyung@kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

 tools/perf/util/machine.c | 2 ++
 1 file changed, 2 insertions(+)
⬢ [acme@toolbox perf-tools-next]$

If we simply revert this it gets back working:

⬢ [acme@toolbox perf-tools-next]$ git revert 876e80cf83d10585df6ee1e353cfbf562f9a930e
Auto-merging tools/perf/util/machine.c
[perf-tools-next 1ab31115859a0944] Revert "perf tools: Fixup end address of modules"
 1 file changed, 2 deletions(-)
# rm -rf build dir, rebuild it

root@number:~# perf record -- perf test -w thloop
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.403 MB perf.data (7960 samples) ]
root@number:~# 

No time today to try to dig deeper, so just reporting the bisection
result.

- Arnaldo

> cause then the fix is probably to not modify a map but clone it,
> change it and then reinsert it into the maps - the insert is called
> maps__fixup_overlap_and_insert so that maps don't overlap one another
> like the invariant check is detecting. Fwiw, in the older rbtree code,
> invariant breakages like this would be silently ignored, so we may
> have a latent bug :-(
> 
> Thanks,
> Ian
> 
> > > > - Arnaldo
> > > >
> > > > >   $ perf report --stdio -s tgid,pid -H
> > > > >   ...
> > > > >   #
> > > > >   #    Overhead  Tgid:Command / Pid:Command
> > > > >   # ...........  ..........................
> > > > >   #
> > > > >      100.00%     2018407:perf
> > > > >          50.34%     2018407:perf
> > > > >          49.66%     2018409:perf
> > > > >
> > > > > Suggested-by: Stephane Eranian <eranian@google.com>
> > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > ---
> > > > >  tools/perf/Documentation/perf-report.txt |  1 +
> > > > >  tools/perf/util/hist.h                   |  1 +
> > > > >  tools/perf/util/sort.c                   | 35 ++++++++++++++++++++++++
> > > > >  tools/perf/util/sort.h                   |  1 +
> > > > >  4 files changed, 38 insertions(+)
> > > > >
> > > > > diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> > > > > index 87f86451940623f3..4050ec4038425bf0 100644
> > > > > --- a/tools/perf/Documentation/perf-report.txt
> > > > > +++ b/tools/perf/Documentation/perf-report.txt
> > > > > @@ -79,6 +79,7 @@ OPTIONS
> > > > >
> > > > >     - comm: command (name) of the task which can be read via /proc/<pid>/comm
> > > > >     - pid: command and tid of the task
> > > > > +   - tgid: command and tgid of the task
> > > > >     - dso: name of library or module executed at the time of sample
> > > > >     - dso_size: size of library or module executed at the time of sample
> > > > >     - symbol: name of function executed at the time of sample
> > > > > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > > > > index 46c8373e314657fa..c164e178e0a48a8e 100644
> > > > > --- a/tools/perf/util/hist.h
> > > > > +++ b/tools/perf/util/hist.h
> > > > > @@ -38,6 +38,7 @@ enum hist_column {
> > > > >     HISTC_TIME,
> > > > >     HISTC_DSO,
> > > > >     HISTC_THREAD,
> > > > > +   HISTC_TGID,
> > > > >     HISTC_COMM,
> > > > >     HISTC_CGROUP_ID,
> > > > >     HISTC_CGROUP,
> > > > > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > > > > index 3dd33721823f365d..5987438174967fd6 100644
> > > > > --- a/tools/perf/util/sort.c
> > > > > +++ b/tools/perf/util/sort.c
> > > > > @@ -141,6 +141,40 @@ struct sort_entry sort_thread = {
> > > > >     .se_width_idx   = HISTC_THREAD,
> > > > >  };
> > > > >
> > > > > +/* --sort tgid */
> > > > > +
> > > > > +static int64_t
> > > > > +sort__tgid_cmp(struct hist_entry *left, struct hist_entry *right)
> > > > > +{
> > > > > +   return thread__pid(right->thread) - thread__pid(left->thread);
> > > > > +}
> > > > > +
> > > > > +static int hist_entry__tgid_snprintf(struct hist_entry *he, char *bf,
> > > > > +                                  size_t size, unsigned int width)
> > > > > +{
> > > > > +   int tgid = thread__pid(he->thread);
> > > > > +   const char *comm = NULL;
> > > > > +
> > > > > +   if (thread__pid(he->thread) == thread__tid(he->thread)) {
> > > > > +           comm = thread__comm_str(he->thread);
> > > > > +   } else {
> > > > > +           struct maps *maps = thread__maps(he->thread);
> > > > > +           struct thread *leader = machine__find_thread(maps__machine(maps),
> > > > > +                                                        tgid, tgid);
> > > > > +           if (leader)
> > > > > +                   comm = thread__comm_str(leader);
> > > > > +   }
> > > > > +   width = max(7U, width) - 8;
> > > > > +   return repsep_snprintf(bf, size, "%7d:%-*.*s", tgid, width, width, comm ?: "");
> > > > > +}
> > > > > +
> > > > > +struct sort_entry sort_tgid = {
> > > > > +   .se_header      = "   Tgid:Command",
> > > > > +   .se_cmp         = sort__tgid_cmp,
> > > > > +   .se_snprintf    = hist_entry__tgid_snprintf,
> > > > > +   .se_width_idx   = HISTC_TGID,
> > > > > +};
> > > > > +
> > > > >  /* --sort simd */
> > > > >
> > > > >  static int64_t
> > > > > @@ -2501,6 +2535,7 @@ static void sort_dimension_add_dynamic_header(struct sort_dimension *sd)
> > > > >
> > > > >  static struct sort_dimension common_sort_dimensions[] = {
> > > > >     DIM(SORT_PID, "pid", sort_thread),
> > > > > +   DIM(SORT_TGID, "tgid", sort_tgid),
> > > > >     DIM(SORT_COMM, "comm", sort_comm),
> > > > >     DIM(SORT_DSO, "dso", sort_dso),
> > > > >     DIM(SORT_SYM, "symbol", sort_sym),
> > > > > diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> > > > > index a8572574e1686be6..6044eb1d61447c0d 100644
> > > > > --- a/tools/perf/util/sort.h
> > > > > +++ b/tools/perf/util/sort.h
> > > > > @@ -72,6 +72,7 @@ enum sort_type {
> > > > >     SORT_ANNOTATE_DATA_TYPE_OFFSET,
> > > > >     SORT_SYM_OFFSET,
> > > > >     SORT_ANNOTATE_DATA_TYPE_CACHELINE,
> > > > > +   SORT_TGID,
> > > > >
> > > > >     /* branch stack specific sort keys */
> > > > >     __SORT_BRANCH_STACK,
> > > > > --
> > > > > 2.48.1.502.g6dc24dfdaf-goog
