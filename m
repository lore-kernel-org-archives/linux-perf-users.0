Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78C7635;
	Tue, 11 Feb 2025 01:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739235726; cv=none; b=crhQiKQbtFkfNYd/Qg68KFxaKnbAiLcmwkeZ1RDL4IRGaOEGwQVAPoe1Dl55olk/8PURrdXdhm5pEpEhB3uV9f5Wr3QzUcU2WTlfaiuQs2N1c07JbvOHuHl86563or1PhWW9Y+blhmSXGqchTuMTe6d53PY1XFCPIeivR7UIm6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739235726; c=relaxed/simple;
	bh=JycsQGpmD29TxPWN55pQimRbTjchndTQXkCYtW+5ZZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckcMbmPuiPRpWfQHaNtaU5RUZJCF6eb71IdtbfhDOgodd4y3BA/qJLjUgfuPQZb7dLX8JEW4CVkjmlLIKguFrIdeei1cwdAzNzOdQyOHCDky3MoLau15qVWQZVyNBh3EUpXhfUllZz+9PuJlAA5IFBMAIw7MD87H7LBOael1Bvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfIOWhdQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfIOWhdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB48C4CED1;
	Tue, 11 Feb 2025 01:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739235726;
	bh=JycsQGpmD29TxPWN55pQimRbTjchndTQXkCYtW+5ZZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MfIOWhdQL5UK9lasaTP9cMACPqvQquD++NXjtYXI6R+wWqaq34upkbzTxn/nfkatW
	 6iQKwYlgZZkL6wj/kvbTSx48ZZoneeXPbqC7qb78Bx5Y2E/D5mpRq+B8bc3Q7jD+DM
	 4N+jVKMQTJwOoMc7FUl54+SuABSOI8zR+YypdP50O+SUqnFNnANOGl+pW6Tju2OLLC
	 xCZKY3GRodJVG/TYlcfpeqJ/UEb/gAfiMHN30jHpOXMrnKl4/KkU3zUCs2dR6h2MlU
	 U/PK1K+EvUbpeNvSkg9SO6/seMcin/yRqXBPVxVr34HzquZTqdkPuSbax9pHak2K7B
	 me9a0XUl2P+8g==
Date: Mon, 10 Feb 2025 17:02:04 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v5 6/8] perf report: Add --latency flag
Message-ID: <Z6qhjFs0YOMTzk9W@google.com>
References: <cover.1738772628.git.dvyukov@google.com>
 <eb32b9b13856b0d508836b61b3e8377aef9163a3.1738772628.git.dvyukov@google.com>
 <Z6WBsruddcx0SFV5@google.com>
 <CACT4Y+afC5WfTMaKGtg760PS5oXkkurzAyHVyKr9TsPs9RU2DQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+afC5WfTMaKGtg760PS5oXkkurzAyHVyKr9TsPs9RU2DQ@mail.gmail.com>

On Fri, Feb 07, 2025 at 08:23:58AM +0100, Dmitry Vyukov wrote:
> On Fri, 7 Feb 2025 at 04:44, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Feb 05, 2025 at 05:27:45PM +0100, Dmitry Vyukov wrote:
> > > Add record/report --latency flag that allows to capture and show
> > > latency-centric profiles rather than the default CPU-consumption-centric
> > > profiles. For latency profiles record captures context switch events,
> > > and report shows Latency as the first column.
> > >
> > > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: linux-perf-users@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > >
> > > ---
> > > Changes in v5:
> > >  - added description of --latency flag in Documentation flags
> > > ---
> > >  tools/perf/Documentation/perf-record.txt |  4 +++
> > >  tools/perf/Documentation/perf-report.txt |  5 +++
> > >  tools/perf/builtin-record.c              | 20 ++++++++++++
> > >  tools/perf/builtin-report.c              | 32 +++++++++++++++---
> > >  tools/perf/ui/hist.c                     | 41 +++++++++++++++++++-----
> > >  tools/perf/util/hist.h                   |  1 +
> > >  tools/perf/util/sort.c                   | 33 +++++++++++++++----
> > >  tools/perf/util/sort.h                   |  2 +-
> > >  tools/perf/util/symbol_conf.h            |  4 ++-
> > >  9 files changed, 122 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > > index 80686d590de24..c7fc1ba265e27 100644
> > > --- a/tools/perf/Documentation/perf-record.txt
> > > +++ b/tools/perf/Documentation/perf-record.txt
> > > @@ -227,6 +227,10 @@ OPTIONS
> > >       '--filter' exists, the new filter expression will be combined with
> > >       them by '&&'.
> > >
> > > +--latency::
> > > +     Enable data collection for latency profiling.
> > > +     Use perf report --latency for latency-centric profile.
> > > +
> > >  -a::
> > >  --all-cpus::
> > >          System-wide collection from all CPUs (default if no target is specified).
> > > diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> > > index 87f8645194062..66794131aec48 100644
> > > --- a/tools/perf/Documentation/perf-report.txt
> > > +++ b/tools/perf/Documentation/perf-report.txt
> > > @@ -68,6 +68,11 @@ OPTIONS
> > >  --hide-unresolved::
> > >          Only display entries resolved to a symbol.
> > >
> > > +--latency::
> > > +        Show latency-centric profile rather than the default
> > > +        CPU-consumption-centric profile
> > > +        (requires perf record --latency flag).
> > > +
> > >  -s::
> > >  --sort=::
> > >       Sort histogram entries by given key(s) - multiple keys can be specified
> > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > > index 5db1aedf48df9..e219639ac401b 100644
> > > --- a/tools/perf/builtin-record.c
> > > +++ b/tools/perf/builtin-record.c
> > > @@ -161,6 +161,7 @@ struct record {
> > >       struct evlist           *sb_evlist;
> > >       pthread_t               thread_id;
> > >       int                     realtime_prio;
> > > +     bool                    latency;
> > >       bool                    switch_output_event_set;
> > >       bool                    no_buildid;
> > >       bool                    no_buildid_set;
> > > @@ -3371,6 +3372,9 @@ static struct option __record_options[] = {
> > >                    parse_events_option),
> > >       OPT_CALLBACK(0, "filter", &record.evlist, "filter",
> > >                    "event filter", parse_filter),
> > > +     OPT_BOOLEAN(0, "latency", &record.latency,
> > > +                 "Enable data collection for latency profiling.\n"
> > > +                 "\t\t\t  Use perf report --latency for latency-centric profile."),
> > >       OPT_CALLBACK_NOOPT(0, "exclude-perf", &record.evlist,
> > >                          NULL, "don't record events from perf itself",
> > >                          exclude_perf),
> > > @@ -4017,6 +4021,22 @@ int cmd_record(int argc, const char **argv)
> > >
> > >       }
> > >
> > > +     if (record.latency) {
> > > +             /*
> > > +              * There is no fundamental reason why latency profiling
> > > +              * can't work for system-wide mode, but exact semantics
> > > +              * and details are to be defined.
> > > +              * See the following thread for details:
> > > +              * https://lore.kernel.org/all/Z4XDJyvjiie3howF@google.com/
> > > +              */
> > > +             if (record.opts.target.system_wide) {
> > > +                     pr_err("Failed: latency profiling is not supported with system-wide collection.\n");
> > > +                     err = -EINVAL;
> > > +                     goto out_opts;
> > > +             }
> > > +             record.opts.record_switch_events = true;
> > > +     }
> > > +
> > >       if (rec->buildid_mmap) {
> > >               if (!perf_can_record_build_id()) {
> > >                       pr_err("Failed: no support to record build id in mmap events, update your kernel.\n");
> > > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > > index 2a19abdc869a1..69de6dbefecfa 100644
> > > --- a/tools/perf/builtin-report.c
> > > +++ b/tools/perf/builtin-report.c
> > > @@ -112,6 +112,8 @@ struct report {
> > >       u64                     nr_entries;
> > >       u64                     queue_size;
> > >       u64                     total_cycles;
> > > +     u64                     total_samples;
> > > +     u64                     singlethreaded_samples;
> > >       int                     socket_filter;
> > >       DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
> > >       struct branch_type_stat brtype_stat;
> > > @@ -331,6 +333,10 @@ static int process_sample_event(const struct perf_tool *tool,
> > >                                    &rep->total_cycles, evsel);
> > >       }
> > >
> > > +     rep->total_samples++;
> > > +     if (al.parallelism == 1)
> > > +             rep->singlethreaded_samples++;
> > > +
> > >       ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
> > >       if (ret < 0)
> > >               pr_debug("problem adding hist entry, skipping event\n");
> > > @@ -1079,6 +1085,11 @@ static int __cmd_report(struct report *rep)
> > >               return ret;
> > >       }
> > >
> > > +     /* Don't show Latency column for non-parallel profiles by default. */
> > > +     if (rep->singlethreaded_samples * 100 / rep->total_samples >= 99 &&
> > > +                     !symbol_conf.prefer_latency)
> > > +             perf_hpp__cancel_latency();
> > > +
> > >       evlist__check_mem_load_aux(session->evlist);
> > >
> > >       if (rep->stats_mode)
> > > @@ -1468,6 +1479,10 @@ int cmd_report(int argc, const char **argv)
> > >                   "Disable raw trace ordering"),
> > >       OPT_BOOLEAN(0, "skip-empty", &report.skip_empty,
> > >                   "Do not display empty (or dummy) events in the output"),
> > > +     OPT_BOOLEAN(0, "latency", &symbol_conf.prefer_latency,
> > > +                 "Show latency-centric profile rather than the default\n"
> > > +                 "\t\t\t  CPU-consumption-centric profile\n"
> > > +                 "\t\t\t  (requires perf record --latency flag)."),
> > >       OPT_END()
> > >       };
> > >       struct perf_data data = {
> > > @@ -1722,16 +1737,25 @@ int cmd_report(int argc, const char **argv)
> > >               symbol_conf.annotate_data_sample = true;
> > >       }
> > >
> > > +     symbol_conf.enable_latency = true;
> > >       if (report.disable_order || !perf_session__has_switch_events(session)) {
> > >               if (symbol_conf.parallelism_list_str ||
> > > -                             (sort_order && strstr(sort_order, "parallelism")) ||
> > > -                             (field_order && strstr(field_order, "parallelism"))) {
> > > +                     symbol_conf.prefer_latency ||
> > > +                     (sort_order && (strstr(sort_order, "latency") ||
> > > +                             strstr(sort_order, "parallelism"))) ||
> > > +                     (field_order && (strstr(field_order, "latency") ||
> > > +                             strstr(field_order, "parallelism")))) {
> > >                       if (report.disable_order)
> > > -                             ui__error("Use of parallelism is incompatible with --disable-order.\n");
> > > +                             ui__error("Use of latency profile or parallelism is incompatible with --disable-order.\n");
> > >                       else
> > > -                             ui__error("Use of parallelism requires --switch-events during record.\n");
> > > +                             ui__error("Use of latency profile or parallelism requires --latency flag during record.\n");
> > >                       return -1;
> > >               }
> > > +             /*
> > > +              * If user did not ask for anything related to
> > > +              * latency/parallelism explicitly, just don't show it.
> > > +              */
> > > +             symbol_conf.enable_latency = false;
> > >       }
> > >
> > >       if (sort_order && strstr(sort_order, "ipc")) {
> > > diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> > > index 6de6309595f9e..b453f8eb579cc 100644
> > > --- a/tools/perf/ui/hist.c
> > > +++ b/tools/perf/ui/hist.c
> > > @@ -632,27 +632,36 @@ void perf_hpp__init(void)
> > >               return;
> > >
> > >       if (symbol_conf.cumulate_callchain) {
> > > -             hpp_dimension__add_output(PERF_HPP__OVERHEAD_ACC);
> > > +             /* Use idempotent addition to avoid more complex logic. */
> > > +             if (symbol_conf.prefer_latency)
> > > +                     hpp_dimension__add_output(PERF_HPP__LATENCY_ACC, true);
> > > +             hpp_dimension__add_output(PERF_HPP__OVERHEAD_ACC, true);
> > > +             if (symbol_conf.enable_latency)
> > > +                     hpp_dimension__add_output(PERF_HPP__LATENCY_ACC, true);
> > >               perf_hpp__format[PERF_HPP__OVERHEAD].name = "Self";
> > >       }
> > >
> > > -     hpp_dimension__add_output(PERF_HPP__OVERHEAD);
> > > +     if (symbol_conf.prefer_latency)
> > > +             hpp_dimension__add_output(PERF_HPP__LATENCY, true);
> > > +     hpp_dimension__add_output(PERF_HPP__OVERHEAD, true);
> > > +     if (symbol_conf.enable_latency)
> > > +             hpp_dimension__add_output(PERF_HPP__LATENCY, true);
> > >
> > >       if (symbol_conf.show_cpu_utilization) {
> > > -             hpp_dimension__add_output(PERF_HPP__OVERHEAD_SYS);
> > > -             hpp_dimension__add_output(PERF_HPP__OVERHEAD_US);
> > > +             hpp_dimension__add_output(PERF_HPP__OVERHEAD_SYS, false);
> > > +             hpp_dimension__add_output(PERF_HPP__OVERHEAD_US, false);
> > >
> > >               if (perf_guest) {
> > > -                     hpp_dimension__add_output(PERF_HPP__OVERHEAD_GUEST_SYS);
> > > -                     hpp_dimension__add_output(PERF_HPP__OVERHEAD_GUEST_US);
> > > +                     hpp_dimension__add_output(PERF_HPP__OVERHEAD_GUEST_SYS, false);
> > > +                     hpp_dimension__add_output(PERF_HPP__OVERHEAD_GUEST_US, false);
> > >               }
> > >       }
> > >
> > >       if (symbol_conf.show_nr_samples)
> > > -             hpp_dimension__add_output(PERF_HPP__SAMPLES);
> > > +             hpp_dimension__add_output(PERF_HPP__SAMPLES, false);
> > >
> > >       if (symbol_conf.show_total_period)
> > > -             hpp_dimension__add_output(PERF_HPP__PERIOD);
> > > +             hpp_dimension__add_output(PERF_HPP__PERIOD, false);
> > >  }
> > >
> > >  void perf_hpp_list__column_register(struct perf_hpp_list *list,
> > > @@ -701,6 +710,22 @@ void perf_hpp__cancel_cumulate(void)
> > >       }
> > >  }
> > >
> > > +void perf_hpp__cancel_latency(void)
> > > +{
> > > +     struct perf_hpp_fmt *fmt, *lat, *acc, *tmp;
> > > +
> > > +     if (is_strict_order(field_order) || is_strict_order(sort_order))
> > > +             return;
> > > +
> > > +     lat = &perf_hpp__format[PERF_HPP__LATENCY];
> > > +     acc = &perf_hpp__format[PERF_HPP__LATENCY_ACC];
> > > +
> > > +     perf_hpp_list__for_each_format_safe(&perf_hpp_list, fmt, tmp) {
> > > +             if (fmt_equal(lat, fmt) || fmt_equal(acc, fmt))
> > > +                     perf_hpp__column_unregister(fmt);
> > > +     }
> > > +}
> > > +
> > >  void perf_hpp__setup_output_field(struct perf_hpp_list *list)
> > >  {
> > >       struct perf_hpp_fmt *fmt;
> > > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > > index 91159f16c60b2..29d4c7a3d1747 100644
> > > --- a/tools/perf/util/hist.h
> > > +++ b/tools/perf/util/hist.h
> > > @@ -582,6 +582,7 @@ enum {
> > >
> > >  void perf_hpp__init(void);
> > >  void perf_hpp__cancel_cumulate(void);
> > > +void perf_hpp__cancel_latency(void);
> > >  void perf_hpp__setup_output_field(struct perf_hpp_list *list);
> > >  void perf_hpp__reset_output_field(struct perf_hpp_list *list);
> > >  void perf_hpp__append_sort_keys(struct perf_hpp_list *list);
> > > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > > index bc4c3acfe7552..2b6023de7a53a 100644
> > > --- a/tools/perf/util/sort.c
> > > +++ b/tools/perf/util/sort.c
> > > @@ -2622,6 +2622,7 @@ struct hpp_dimension {
> > >       const char              *name;
> > >       struct perf_hpp_fmt     *fmt;
> > >       int                     taken;
> > > +     int                     was_taken;
> > >  };
> > >
> > >  #define DIM(d, n) { .name = n, .fmt = &perf_hpp__format[d], }
> > > @@ -3513,6 +3514,7 @@ static int __hpp_dimension__add(struct hpp_dimension *hd,
> > >               return -1;
> > >
> > >       hd->taken = 1;
> > > +     hd->was_taken = 1;
> > >       perf_hpp_list__register_sort_field(list, fmt);
> > >       return 0;
> > >  }
> > > @@ -3547,10 +3549,15 @@ static int __hpp_dimension__add_output(struct perf_hpp_list *list,
> > >       return 0;
> > >  }
> > >
> > > -int hpp_dimension__add_output(unsigned col)
> > > +int hpp_dimension__add_output(unsigned col, bool implicit)
> > >  {
> > > +     struct hpp_dimension *hd;
> > > +
> > >       BUG_ON(col >= PERF_HPP__MAX_INDEX);
> > > -     return __hpp_dimension__add_output(&perf_hpp_list, &hpp_sort_dimensions[col]);
> > > +     hd = &hpp_sort_dimensions[col];
> > > +     if (implicit && !hd->was_taken)
> > > +             return 0;
> >
> > I don't think you need these implicit and was_taken things.
> > Just removing from the sort list when it's unregistered seems to work.
> >
> > ---8<---
> > @@ -685,6 +685,7 @@ void perf_hpp_list__prepend_sort_field(struct perf_hpp_list *list,
> >  static void perf_hpp__column_unregister(struct perf_hpp_fmt *format)
> >  {
> >         list_del_init(&format->list);
> > +       list_del_init(&format->sort_list);
> >         fmt_free(format);
> >  }
> >
> > ---8<---
> 
> It merely suppresses the warning, but does not work the same way. See
> this for details:
> https://lore.kernel.org/all/CACT4Y+ZREdDL7a+DMKGFGae1ZjX1C8uNRwCGF0c8iUJtTTq0Lw@mail.gmail.com/

But I think it's better to pass --latency option rather than adding it
to -s option.  If you really want to have specific output fields, then
please use -F latency,sym instead.

Also I've realized that it should add one sort key in setup_overhead()
to support hierarchy mode properly.  Something like this?

Thanks,
Namhyung


---8<---
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 2b6023de7a53ae2e..329c2e9bbc69a725 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -3817,22 +3817,15 @@ static char *setup_overhead(char *keys)
 		return keys;
 
 	if (symbol_conf.prefer_latency) {
-		keys = prefix_if_not_in("overhead", keys);
-		keys = prefix_if_not_in("latency", keys);
-		if (symbol_conf.cumulate_callchain) {
-			keys = prefix_if_not_in("overhead_children", keys);
+		if (symbol_conf.cumulate_callchain)
 			keys = prefix_if_not_in("latency_children", keys);
-		}
-	} else if (!keys || (!strstr(keys, "overhead") &&
-			!strstr(keys, "latency"))) {
-		if (symbol_conf.enable_latency)
+		else
 			keys = prefix_if_not_in("latency", keys);
-		keys = prefix_if_not_in("overhead", keys);
-		if (symbol_conf.cumulate_callchain) {
-			if (symbol_conf.enable_latency)
-				keys = prefix_if_not_in("latency_children", keys);
+	} else {
+		if (symbol_conf.cumulate_callchain)
 			keys = prefix_if_not_in("overhead_children", keys);
-		}
+		else
+			keys = prefix_if_not_in("overhead", keys);
 	}
 
 	return keys;
---8<---

