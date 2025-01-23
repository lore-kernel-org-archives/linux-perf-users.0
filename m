Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49D1B3948;
	Thu, 23 Jan 2025 23:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737675668; cv=none; b=pDMhRVJWz2eHZeYJuqjt1Fo6PQ3GchfjBfccnBhmij3oAImiDLNw4QjOvlDsxIEc8Ee5c5WOuL4mBp/j3R7iXGwTlpR5iSYbbWP2Z9QQ4egw2uRRf/oa7SvlOYpaCNzHj3MgD/lhfwnE7prLaP2HEKEUDEOuwJol97D1YlIU6IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737675668; c=relaxed/simple;
	bh=X5BaeV9uPbKthuyouWSG6AEp19bnOnn660K8EE/05Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjeuSEqIaAmXzRBgKaS/O6LIHmKrvhe4CiPElmm88vA/LUxmHtSsUG/K8AFOjDXZT7g1xulsmfs+Oox9VPtN/QDZm/bQ+Hbyio/68CFG7GOuwxRYcOeNC1J8RFhB2oKLnbwiuBnxGK9h3ju+gC8h2GeIAjCBsprUeSMU2CEL/JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBOAF9ID; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBOAF9ID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBCCC4CED3;
	Thu, 23 Jan 2025 23:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737675667;
	bh=X5BaeV9uPbKthuyouWSG6AEp19bnOnn660K8EE/05Ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBOAF9IDJYMsNCIQ96yqRFyWlcmINPUqucY0T4jtW8YSohP9J2y64HV45J/dZJTnC
	 LdFg+d7TuhGproK99MPYhsRXUEhH5CaRtUiGkd4QpzwDg8s05yT/OOtkeDrHP1MmPp
	 Kph5v5EGfHqhstK0HpP+an6lLFWgISpR/d1c16X6YuCbpsiD0urN9AyCBMTCzQoxyQ
	 zA931lTkxMvEKffdYyZqpVh9Ww5v4dfmVb9H1ep4t/29VCowyzz+ykrIWyeLWRz4mc
	 UNCv3nh4W+8KQXuCQ5s93RxvVe6oWla+z8mRjiMXLEwAIAhgehCOd6rOyWWY7OYnxO
	 PmCy5Ha54y08w==
Date: Thu, 23 Jan 2025 15:41:05 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/4] perf trace: Add --system-summary option
Message-ID: <Z5LTkVsprlPbG6gF@google.com>
References: <20250114212256.160730-1-namhyung@kernel.org>
 <20250114212256.160730-5-namhyung@kernel.org>
 <CAH0uvojXeXiKWvZ6uZMyauWgHiA7Brf9L0=oxh0D2dO5gX70+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvojXeXiKWvZ6uZMyauWgHiA7Brf9L0=oxh0D2dO5gX70+w@mail.gmail.com>

On Fri, Jan 17, 2025 at 07:07:32PM -0800, Howard Chu wrote:
> Hello Namhyung,
> 
> On Tue, Jan 14, 2025 at 1:23 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> >   $ sudo ./perf trace -as --system-summary sleep 1
> >
> >    Summary of events:
> >
> >    total, 21580 events
> >
> >      syscall            calls  errors  total       min       avg       max       stddev
> >                                        (msec)    (msec)    (msec)    (msec)        (%)
> >      --------------- --------  ------ -------- --------- --------- ---------     ------
> >      epoll_wait          1305      0 14716.712     0.000    11.277   551.529      8.87%
> >      futex               1256     89 13331.197     0.000    10.614   733.722     15.49%
> >      poll                 669      0  6806.618     0.000    10.174   459.316     11.77%
> >      ppoll                220      0  3968.797     0.000    18.040   516.775     25.35%
> >      clock_nanosleep        1      0  1000.027  1000.027  1000.027  1000.027      0.00%
> >      epoll_pwait           21      0   592.783     0.000    28.228   522.293     88.29%
> >      nanosleep             16      0    60.515     0.000     3.782    10.123     33.33%
> >      ioctl                510      0     4.284     0.001     0.008     0.182      8.84%
> >      recvmsg             1434    775     3.497     0.001     0.002     0.174      6.37%
> >      write               1393      0     2.854     0.001     0.002     0.017      1.79%
> >      read                1063    100     2.236     0.000     0.002     0.083      5.11%
> >      ...
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-trace.txt |   3 +
> >  tools/perf/builtin-trace.c              | 100 +++++++++++++++++++-----
> >  2 files changed, 85 insertions(+), 18 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
> > index 2620c4f4601c8701..72f29f82649e320a 100644
> > --- a/tools/perf/Documentation/perf-trace.txt
> > +++ b/tools/perf/Documentation/perf-trace.txt
> > @@ -150,6 +150,9 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
> >         To be used with -s or -S, to show stats for the errnos experienced by
> >         syscalls, using only this option will trigger --summary.
> >
> > +--system-summary::
> > +       To be used with -s or -S, to show system-wide summary instead of per-thread.
> 
> Is system-summary a good option name and is it really system-wide?

I'm afraid not. :)


> For example, if I do:
> 
> perf $ sudo ./perf trace -s -p 2552
> ^C
>  Summary of events:
> 
>  gmain (2581), 12 events, 2.7%
> 
>    syscall            calls  errors  total       min       avg
> max       stddev
>                                      (msec)    (msec)    (msec)
> (msec)        (%)
>    --------------- --------  ------ -------- --------- ---------
> ---------     ------
>    inotify_add_watch        5      5     0.071     0.009     0.014
> 0.022     16.74%
>    ppoll                  1      0     0.000     0.000     0.000
> 0.000      0.00%
> 
> 
>  gnome-shell (2647), 20 events, 4.4%
> 
>    syscall            calls  errors  total       min       avg
> max       stddev
>                                      (msec)    (msec)    (msec)
> (msec)        (%)
>    --------------- --------  ------ -------- --------- ---------
> ---------     ------
>    ppoll                  2      0   136.188     0.000    68.094
> 136.188    100.00%
>    read                   4      2     0.080     0.008     0.020
> 0.038     35.33%
>    epoll_wait             2      0     0.044     0.011     0.022
> 0.032     47.61%
>    write                  2      0     0.040     0.014     0.020
> 0.026     29.65%
> 
> 
>  gdbus (2583), 102 events, 22.6%
> 
>    syscall            calls  errors  total       min       avg
> max       stddev
>                                      (msec)    (msec)    (msec)
> (msec)        (%)
>    --------------- --------  ------ -------- --------- ---------
> ---------     ------
>    ppoll                 13      0  1535.789     0.000   118.138
> 1396.542     90.61%
>    write                 16      0     0.198     0.003     0.012
> 0.043     24.76%
>    recvmsg                6      0     0.117     0.005     0.020
> 0.036     27.08%
>    read                   8      0     0.094     0.003     0.012
> 0.050     48.51%
>    sendmsg                2      0     0.071     0.010     0.035
> 0.061     71.55%
>    poll                   6      0     0.058     0.003     0.010
> 0.020     27.31%
> 
> 
>  gnome-shell (2552), 299 events, 66.2%
> 
>    syscall            calls  errors  total       min       avg
> max       stddev
>                                      (msec)    (msec)    (msec)
> (msec)        (%)
>    --------------- --------  ------ -------- --------- ---------
> ---------     ------
>    ppoll                 17      0  1531.485     0.000    90.087
> 1387.446     90.43%
>    recvmsg               36     35     0.504     0.003     0.014
> 0.082     18.35%
>    mprotect              37      0     0.401     0.005     0.011
> 0.028      8.54%
>    write                 29      0     0.333     0.003     0.011
> 0.051     19.53%
>    read                  16      0     0.151     0.003     0.009
> 0.031     22.48%
>    sendmsg                4      0     0.130     0.014     0.033
> 0.059     34.63%
>    ioctl                  1      0     0.050     0.050     0.050
> 0.050      0.00%
>    poll                   2      0     0.045     0.007     0.023
> 0.039     71.16%
>    epoll_wait             1      0     0.028     0.028     0.028
> 0.028      0.00%
>    close                  2      0     0.017     0.006     0.009
> 0.012     34.67%
>    getpid                 3      0     0.012     0.003     0.004
> 0.007     32.84%
>    fcntl                  1      0     0.007     0.007     0.007
> 0.007      0.00%
> 
> The process 2552 has multiple threads, each with its own separate
> summary, as the old behavior yields.
> 
> perf $ sudo ./perf trace -s -p 2552 --system-summary
> ^C
>  Summary of events:
> 
>  total, 432 events
> 
>    syscall            calls  errors  total       min       avg
> max       stddev
>                                      (msec)    (msec)    (msec)
> (msec)        (%)
>    --------------- --------  ------ -------- --------- ---------
> ---------     ------
>    ppoll                 33      0   524.678     0.000    15.899
> 160.177     50.77%
>    recvmsg               56     51     0.602     0.003     0.011
> 0.033     10.06%
>    ioctl                 21      0     0.542     0.003     0.026
> 0.256     46.90%
>    write                 36      0     0.432     0.002     0.012
> 0.033     12.46%
>    read                  26      2     0.328     0.003     0.013
> 0.037     15.34%
>    sendmsg                6      0     0.209     0.012     0.035
> 0.081     30.35%
>    futex                  9      1     0.111     0.000     0.012
> 0.036     32.24%
>    inotify_add_watch        5      5     0.073     0.009     0.015
> 0.024     18.49%
>    epoll_wait             3      0     0.049     0.008     0.016
> 0.033     50.05%
>    poll                   4      0     0.039     0.004     0.010
> 0.017     29.67%
>    timerfd_settime        2      0     0.032     0.008     0.016
> 0.024     48.19%
>    getpid                 8      0     0.032     0.003     0.004
> 0.007     13.33%
>    close                  3      0     0.023     0.006     0.008
> 0.010     12.89%
>    fcntl                  2      0     0.013     0.005     0.006
> 0.008     25.18%
>    kcmp                   2      0     0.010     0.003     0.005
> 0.007     40.29%
> 
> And this is the summary that brings everything together. However, I
> wouldn't consider it a 'system-wide' summary. Maybe call it
> --summary-total,  summary-collapsed... or just make it the new default
> behavior?

Maybe --summary-total.  I'm not sure if it's ok to change the default.
Probably I need to add a config option at least.

> 
> > +
> >  --tool_stats::
> >         Show tool stats such as number of times fd->pathname was discovered thru
> >         hooking the open syscall return + vfs_getname or via reading /proc/pid/fd, etc.
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index ad7f7fcd0d80b9df..00a20052f676847c 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -177,8 +177,10 @@ struct trace {
> >                 pid_t           *entries;
> >                 struct bpf_map  *map;
> >         }                       filter_pids;
> > +       struct hashmap          *syscall_stats;
> >         double                  duration_filter;
> >         double                  runtime_ms;
> > +       unsigned long           pfmaj, pfmin;
> >         struct {
> >                 u64             vfs_getname,
> >                                 proc_getname;
> > @@ -198,6 +200,7 @@ struct trace {
> >         bool                    summary;
> >         bool                    summary_only;
> >         bool                    errno_summary;
> > +       bool                    system_summary;
> >         bool                    failure_only;
> >         bool                    show_comm;
> >         bool                    print_sample;
> > @@ -2500,18 +2503,23 @@ struct syscall_stats {
> >  };
> >
> >  static void thread__update_stats(struct thread *thread, struct thread_trace *ttrace,
> > -                                int id, struct perf_sample *sample, long err, bool errno_summary)
> > +                                int id, struct perf_sample *sample, long err,
> > +                                struct trace *trace)
> >  {
> > +       struct hashmap *syscall_stats = ttrace->syscall_stats;
> >         struct syscall_stats *stats = NULL;
> >         u64 duration = 0;
> >
> > -       if (!hashmap__find(ttrace->syscall_stats, id, &stats)) {
> > +       if (trace->system_summary)
> > +               syscall_stats = trace->syscall_stats;
> > +
> > +       if (!hashmap__find(syscall_stats, id, &stats)) {
> >                 stats = zalloc(sizeof(*stats));
> >                 if (stats == NULL)
> >                         return;
> >
> >                 init_stats(&stats->stats);
> > -               if (hashmap__add(ttrace->syscall_stats, id, stats) < 0) {
> > +               if (hashmap__add(syscall_stats, id, stats) < 0) {
> >                         free(stats);
> >                         return;
> >                 }
> > @@ -2525,7 +2533,7 @@ static void thread__update_stats(struct thread *thread, struct thread_trace *ttr
> >         if (err < 0) {
> >                 ++stats->nr_failures;
> >
> > -               if (!errno_summary)
> > +               if (!trace->errno_summary)
> >                         return;
> >
> >                 err = -err;
> > @@ -2817,7 +2825,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
> >         ret = perf_evsel__sc_tp_uint(evsel, ret, sample);
> >
> >         if (trace->summary)
> > -               thread__update_stats(thread, ttrace, id, sample, ret, trace->errno_summary);
> > +               thread__update_stats(thread, ttrace, id, sample, ret, trace);
> >
> >         if (!trace->fd_path_disabled && sc->is_open && ret >= 0 && ttrace->filename.pending_open) {
> >                 trace__set_fd_pathname(thread, ret, ttrace->filename.name);
> > @@ -3255,10 +3263,13 @@ static int trace__pgfault(struct trace *trace,
> >         if (ttrace == NULL)
> >                 goto out_put;
> >
> > -       if (evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ)
> > +       if (evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ) {
> >                 ttrace->pfmaj++;
> > -       else
> > +               trace->pfmaj++;
> > +       } else {
> >                 ttrace->pfmin++;
> > +               trace->pfmin++;
> > +       }
> >
> >         if (trace->summary_only)
> >                 goto out;
> > @@ -3417,6 +3428,7 @@ static int trace__record(struct trace *trace, int argc, const char **argv)
> >  }
> >
> >  static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp);
> > +static size_t trace__fprintf_system_summary(struct trace *trace, FILE *fp);
> >
> >  static bool evlist__add_vfs_getname(struct evlist *evlist)
> >  {
> > @@ -4329,6 +4341,12 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> >                 goto out_delete_evlist;
> >         }
> >
> > +       if (trace->system_summary) {
> > +               trace->syscall_stats = alloc_syscall_stats();
> > +               if (trace->syscall_stats == NULL)
> > +                       goto out_delete_evlist;
> > +       }
> > +
> >         evlist__config(evlist, &trace->opts, &callchain_param);
> >
> >         if (forks) {
> > @@ -4489,8 +4507,12 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> >                 ordered_events__flush(&trace->oe.data, OE_FLUSH__FINAL);
> >
> >         if (!err) {
> > -               if (trace->summary)
> > -                       trace__fprintf_thread_summary(trace, trace->output);
> > +               if (trace->summary) {
> > +                       if (trace->system_summary)
> > +                               trace__fprintf_system_summary(trace, trace->output);
> > +                       else
> > +                               trace__fprintf_thread_summary(trace, trace->output);
> > +               }
> >
> >                 if (trace->show_tool_stats) {
> >                         fprintf(trace->output, "Stats:\n "
> > @@ -4502,6 +4524,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> >         }
> >
> >  out_delete_evlist:
> > +       delete_syscall_stats(trace->syscall_stats);
> >         trace__symbols__exit(trace);
> >         evlist__free_syscall_tp_fields(evlist);
> >         evlist__delete(evlist);
> > @@ -4629,6 +4652,12 @@ static int trace__replay(struct trace *trace)
> >                         evsel->handler = trace__pgfault;
> >         }
> >
> > +       if (trace->system_summary) {
> > +               trace->syscall_stats = alloc_syscall_stats();
> > +               if (trace->syscall_stats == NULL)
> > +                       goto out;
> > +       }
> > +
> >         setup_pager();
> >
> >         err = perf_session__process_events(session);
> > @@ -4639,12 +4668,13 @@ static int trace__replay(struct trace *trace)
> >                 trace__fprintf_thread_summary(trace, trace->output);
> >
> >  out:
> > +       delete_syscall_stats(trace->syscall_stats);
> >         perf_session__delete(session);
> >
> >         return err;
> >  }
> >
> > -static size_t trace__fprintf_threads_header(FILE *fp)
> > +static size_t trace__fprintf_summary_header(FILE *fp)
> >  {
> >         size_t printed;
> >
> > @@ -4667,19 +4697,19 @@ static int entry_cmp(const void *e1, const void *e2)
> >         return entry1->msecs > entry2->msecs ? -1 : 1;
> >  }
> >
> > -static struct syscall_entry *thread__sort_stats(struct thread_trace *ttrace)
> > +static struct syscall_entry *syscall__sort_stats(struct hashmap *syscall_stats)
> >  {
> >         struct syscall_entry *entry;
> >         struct hashmap_entry *pos;
> >         unsigned bkt, i, nr;
> >
> > -       nr = ttrace->syscall_stats->sz;
> > +       nr = syscall_stats->sz;
> >         entry = malloc(nr * sizeof(*entry));
> >         if (entry == NULL)
> >                 return NULL;
> >
> >         i = 0;
> > -       hashmap__for_each_entry(ttrace->syscall_stats, pos, bkt) {
> > +       hashmap__for_each_entry(syscall_stats, pos, bkt) {
> >                 struct syscall_stats *ss = pos->pvalue;
> >                 struct stats *st = &ss->stats;
> >
> > @@ -4694,14 +4724,14 @@ static struct syscall_entry *thread__sort_stats(struct thread_trace *ttrace)
> >         return entry;
> >  }
> >
> > -static size_t thread__dump_stats(struct thread_trace *ttrace,
> > -                                struct trace *trace, FILE *fp)
> > +static size_t syscall__dump_stats(struct trace *trace, FILE *fp,
> > +                                 struct hashmap *syscall_stats)
> >  {
> >         size_t printed = 0;
> >         struct syscall *sc;
> >         struct syscall_entry *entries;
> >
> > -       entries = thread__sort_stats(ttrace);
> > +       entries = syscall__sort_stats(syscall_stats);
> >         if (entries == NULL)
> >                 return 0;
> >
> > @@ -4711,7 +4741,7 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
> >         printed += fprintf(fp, "                                     (msec)    (msec)    (msec)    (msec)        (%%)\n");
> >         printed += fprintf(fp, "   --------------- --------  ------ -------- --------- --------- ---------     ------\n");
> >
> > -       for (size_t i = 0; i < ttrace->syscall_stats->sz; i++) {
> > +       for (size_t i = 0; i < syscall_stats->sz; i++) {
> >                 struct syscall_entry *entry = &entries[i];
> >                 struct syscall_stats *stats = entry->stats;
> >                 if (stats) {
> > @@ -4747,6 +4777,17 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
> >         return printed;
> >  }
> >
> > +static size_t thread__dump_stats(struct thread_trace *ttrace,
> > +                                struct trace *trace, FILE *fp)
> > +{
> > +       return syscall__dump_stats(trace, fp, ttrace->syscall_stats);
> > +}
> > +
> > +static size_t system__dump_stats(struct trace *trace, FILE *fp)
> > +{
> > +       return syscall__dump_stats(trace, fp, trace->syscall_stats);
> > +}
> 
> Perhaps consider inlining these two functions?

I think we can leave it to compiler to make decisions on inlining.

Thanks,
Namhyung

> 
> > +
> >  static size_t trace__fprintf_thread(FILE *fp, struct thread *thread, struct trace *trace)
> >  {
> >         size_t printed = 0;
> > @@ -4800,7 +4841,7 @@ static int trace_nr_events_cmp(void *priv __maybe_unused,
> >
> >  static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp)
> >  {
> > -       size_t printed = trace__fprintf_threads_header(fp);
> > +       size_t printed = trace__fprintf_summary_header(fp);
> >         LIST_HEAD(threads);
> >
> >         if (machine__thread_list(trace->host, &threads) == 0) {
> > @@ -4815,6 +4856,27 @@ static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp)
> >         return printed;
> >  }
> >
> > +static size_t trace__fprintf_system_summary(struct trace *trace, FILE *fp)
> > +{
> > +       size_t printed = trace__fprintf_summary_header(fp);
> > +
> > +       printed += fprintf(fp, " total, ");
> > +       printed += fprintf(fp, "%lu events", trace->nr_events);
> > +
> > +       if (trace->pfmaj)
> > +               printed += fprintf(fp, ", %lu majfaults", trace->pfmaj);
> > +       if (trace->pfmin)
> > +               printed += fprintf(fp, ", %lu minfaults", trace->pfmin);
> > +       if (trace->sched)
> > +               printed += fprintf(fp, ", %.3f msec\n", trace->runtime_ms);
> > +       else if (fputc('\n', fp) != EOF)
> > +               ++printed;
> > +
> > +       printed += system__dump_stats(trace, fp);
> > +
> > +       return printed;
> > +}
> > +
> >  static int trace__set_duration(const struct option *opt, const char *str,
> >                                int unset __maybe_unused)
> >  {
> > @@ -5233,6 +5295,8 @@ int cmd_trace(int argc, const char **argv)
> >                     "Show all syscalls and summary with statistics"),
> >         OPT_BOOLEAN(0, "errno-summary", &trace.errno_summary,
> >                     "Show errno stats per syscall, use with -s or -S"),
> > +       OPT_BOOLEAN(0, "system-summary", &trace.system_summary,
> > +                   "Show system-wide summary instead of per-thread, use with -s or -S"),
> >         OPT_CALLBACK_DEFAULT('F', "pf", &trace.trace_pgfaults, "all|maj|min",
> >                      "Trace pagefaults", parse_pagefaults, "maj"),
> >         OPT_BOOLEAN(0, "syscalls", &trace.trace_syscalls, "Trace syscalls"),
> > --
> > 2.48.0.rc2.279.g1de40edade-goog
> >
> 
> Thanks,
> Howard
