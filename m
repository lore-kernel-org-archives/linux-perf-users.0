Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AA61C5D59
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739262656; cv=none; b=tpM698d4Y2VpzpvKuUP9kyyHRIWGwkgTjV9x7P4QpE3yWWufCZgF9Ka9trjW3gTk/GyH+1Aqar1KwZ2lkQnQgoJjb5P0qBNZFenx/FECus58Y7vCPuefcKjRecl/8SXbin1bWuFrOjHy+KFnsR/RCuoMpV2AdMNUs+teci9S2BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739262656; c=relaxed/simple;
	bh=ibheOxOPF5NyMlxpAcCK1HD7tVcYEbx/0evZRvh78So=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E35qzgAhiUFI4gikJCCFSOyUxVwB8/dIZgAwSH0qF26cpUHzDGqGGhSVKM+bDTfDJGaEneBx68uTtaw5oTfbAm+bhRf3pTLYduF+4/aH2VqmGhZzL9xkmiG1g/kFYa9bb8jxwEQfRSXJfTSe0gJ15OUTAaoGOqeOA9lL5iWvOaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ro1GTSt; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ro1GTSt"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30761be8fa8so51826331fa.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 00:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739262651; x=1739867451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OQDr0m846oUUSSE1rGTFoIm7k+JWCw2Rinad5pl0eF4=;
        b=0ro1GTStn8Vr3P2MI0xVJG+X7CBQ5Dp6FtbTvBjjG9oLLxwm0rg7eoUMBg/oRK02OX
         Z8jgwHsxqiDx+1pz/Xrg7QNPBFDeFegC+u0i+JXQrFS5sgIf3Pwt/eEYUlZ+x9H8q//i
         8g6E/BzREmV3romoAO3ce+p+wKE7PAlxZv6boEbSHQkRZkMRdJ4y5Z/zF7do8NulMn6W
         hv4II97V7x3ZeLlCmEZ1VvrU9n+pkqfMv/WcMmsGWQ0qQYL/VAXdJ/uBYo/v52146cHu
         DkwINYIkyg0hRuiGunSap3XgGqyemtjKAwZpuNjahwhEOnUqk/HY8x2VuCbCd74a8dDy
         xHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739262651; x=1739867451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQDr0m846oUUSSE1rGTFoIm7k+JWCw2Rinad5pl0eF4=;
        b=TI0pWVgRuU8xjQlDjfzKZFr41EY38CygNPpya7acYU8D9YvQgDcXfMYiZcihIbm1pI
         Hs/gOxME7RCZw7bgE7+NFy2hjie8AElxgZPCgWQcrPb5uOwQWae8QXRjxA/+qJp1iumr
         QMb3RxqpkUJn4A9bE/0NB6TxW2X9AF2QPCfuUgaALAYd6LeSXId+mSdbLQn/SaMejXcK
         w62P01V7WID0dHIma4GDtKaos/LYd5rqunf4tqAaF8xA18o528aEZOcyXe2j9MkDzR+u
         rNCDRLTusoOlxiiqGUHcwzgcyeBgmi8Gecp7/UyV5DAcaL22BpCsvRfl8KQ9PDQjYWhE
         CAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2nB77NZKOkDQYfzLkADCJPpZStFohFEERyrIsBQIl24YFtqhNz00r6kWf0T/LmSDE8BChAm403yyzhXYC4CGg@vger.kernel.org
X-Gm-Message-State: AOJu0YxTNF+6tdGfmcmB+EdPmsNlUmOd20Ubx0qkKrYNHvGKvssYxrmR
	kyIVJpavS6trI7b44JGkk04X70y8zXCwd1laR06mTk+37LUUZYoQs+KJQnl9FxogCczCqTSLRXd
	/izk5nDF1n3vApEr4XS30XYRv71cbji9D9mkw
X-Gm-Gg: ASbGncsIxdcwIyMM0Wjm0Y0bzBOhYdbp0aF8FQYCUJ0mWdNLenp7O0HEi/rpGSTP5ZL
	3bX7Qytns+QIXhRTd0PIn6ptYkk3mRgRwdtWrYIdan9cvXMeJNC4X+CtvhKyoofXBVt+i/fydQq
	kSpUfJ9YM4MphEdVqldcxQX99aQQXT
X-Google-Smtp-Source: AGHT+IECPtdQP1iqUudIoQ4/LOFGrnngjRkA8q9mZIwV+G6y1O00iqyHUEiz7cs9Uzb4qefMkhnfXEwUQJSAsfi1nQQ=
X-Received: by 2002:a05:651c:210d:b0:308:f455:1f8f with SMTP id
 38308e7fff4ca-308f45521ccmr19828051fa.16.1739262650768; Tue, 11 Feb 2025
 00:30:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738772628.git.dvyukov@google.com> <eb32b9b13856b0d508836b61b3e8377aef9163a3.1738772628.git.dvyukov@google.com>
 <Z6WBsruddcx0SFV5@google.com> <CACT4Y+afC5WfTMaKGtg760PS5oXkkurzAyHVyKr9TsPs9RU2DQ@mail.gmail.com>
 <Z6qhjFs0YOMTzk9W@google.com>
In-Reply-To: <Z6qhjFs0YOMTzk9W@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 11 Feb 2025 09:30:39 +0100
X-Gm-Features: AWEUYZmNDvYzucRT4A5_TRjiMbCvfJ11CFT2DJ4CTqvov2m8ziEF48HrH3Du59Q
Message-ID: <CACT4Y+bsozKqNTesXNTmF8bNj16iibLt2sKCwr-Wj409BswXNg@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] perf report: Add --latency flag
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 02:02, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Fri, Feb 07, 2025 at 08:23:58AM +0100, Dmitry Vyukov wrote:
> > On Fri, 7 Feb 2025 at 04:44, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Wed, Feb 05, 2025 at 05:27:45PM +0100, Dmitry Vyukov wrote:
> > > > Add record/report --latency flag that allows to capture and show
> > > > latency-centric profiles rather than the default CPU-consumption-centric
> > > > profiles. For latency profiles record captures context switch events,
> > > > and report shows Latency as the first column.
> > > >
> > > > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > Cc: Ian Rogers <irogers@google.com>
> > > > Cc: linux-perf-users@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > >
> > > > ---
> > > > Changes in v5:
> > > >  - added description of --latency flag in Documentation flags
> > > > ---
> > > >  tools/perf/Documentation/perf-record.txt |  4 +++
> > > >  tools/perf/Documentation/perf-report.txt |  5 +++
> > > >  tools/perf/builtin-record.c              | 20 ++++++++++++
> > > >  tools/perf/builtin-report.c              | 32 +++++++++++++++---
> > > >  tools/perf/ui/hist.c                     | 41 +++++++++++++++++++-----
> > > >  tools/perf/util/hist.h                   |  1 +
> > > >  tools/perf/util/sort.c                   | 33 +++++++++++++++----
> > > >  tools/perf/util/sort.h                   |  2 +-
> > > >  tools/perf/util/symbol_conf.h            |  4 ++-
> > > >  9 files changed, 122 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > > > index 80686d590de24..c7fc1ba265e27 100644
> > > > --- a/tools/perf/Documentation/perf-record.txt
> > > > +++ b/tools/perf/Documentation/perf-record.txt
> > > > @@ -227,6 +227,10 @@ OPTIONS
> > > >       '--filter' exists, the new filter expression will be combined with
> > > >       them by '&&'.
> > > >
> > > > +--latency::
> > > > +     Enable data collection for latency profiling.
> > > > +     Use perf report --latency for latency-centric profile.
> > > > +
> > > >  -a::
> > > >  --all-cpus::
> > > >          System-wide collection from all CPUs (default if no target is specified).
> > > > diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> > > > index 87f8645194062..66794131aec48 100644
> > > > --- a/tools/perf/Documentation/perf-report.txt
> > > > +++ b/tools/perf/Documentation/perf-report.txt
> > > > @@ -68,6 +68,11 @@ OPTIONS
> > > >  --hide-unresolved::
> > > >          Only display entries resolved to a symbol.
> > > >
> > > > +--latency::
> > > > +        Show latency-centric profile rather than the default
> > > > +        CPU-consumption-centric profile
> > > > +        (requires perf record --latency flag).
> > > > +
> > > >  -s::
> > > >  --sort=::
> > > >       Sort histogram entries by given key(s) - multiple keys can be specified
> > > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > > > index 5db1aedf48df9..e219639ac401b 100644
> > > > --- a/tools/perf/builtin-record.c
> > > > +++ b/tools/perf/builtin-record.c
> > > > @@ -161,6 +161,7 @@ struct record {
> > > >       struct evlist           *sb_evlist;
> > > >       pthread_t               thread_id;
> > > >       int                     realtime_prio;
> > > > +     bool                    latency;
> > > >       bool                    switch_output_event_set;
> > > >       bool                    no_buildid;
> > > >       bool                    no_buildid_set;
> > > > @@ -3371,6 +3372,9 @@ static struct option __record_options[] = {
> > > >                    parse_events_option),
> > > >       OPT_CALLBACK(0, "filter", &record.evlist, "filter",
> > > >                    "event filter", parse_filter),
> > > > +     OPT_BOOLEAN(0, "latency", &record.latency,
> > > > +                 "Enable data collection for latency profiling.\n"
> > > > +                 "\t\t\t  Use perf report --latency for latency-centric profile."),
> > > >       OPT_CALLBACK_NOOPT(0, "exclude-perf", &record.evlist,
> > > >                          NULL, "don't record events from perf itself",
> > > >                          exclude_perf),
> > > > @@ -4017,6 +4021,22 @@ int cmd_record(int argc, const char **argv)
> > > >
> > > >       }
> > > >
> > > > +     if (record.latency) {
> > > > +             /*
> > > > +              * There is no fundamental reason why latency profiling
> > > > +              * can't work for system-wide mode, but exact semantics
> > > > +              * and details are to be defined.
> > > > +              * See the following thread for details:
> > > > +              * https://lore.kernel.org/all/Z4XDJyvjiie3howF@google.com/
> > > > +              */
> > > > +             if (record.opts.target.system_wide) {
> > > > +                     pr_err("Failed: latency profiling is not supported with system-wide collection.\n");
> > > > +                     err = -EINVAL;
> > > > +                     goto out_opts;
> > > > +             }
> > > > +             record.opts.record_switch_events = true;
> > > > +     }
> > > > +
> > > >       if (rec->buildid_mmap) {
> > > >               if (!perf_can_record_build_id()) {
> > > >                       pr_err("Failed: no support to record build id in mmap events, update your kernel.\n");
> > > > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > > > index 2a19abdc869a1..69de6dbefecfa 100644
> > > > --- a/tools/perf/builtin-report.c
> > > > +++ b/tools/perf/builtin-report.c
> > > > @@ -112,6 +112,8 @@ struct report {
> > > >       u64                     nr_entries;
> > > >       u64                     queue_size;
> > > >       u64                     total_cycles;
> > > > +     u64                     total_samples;
> > > > +     u64                     singlethreaded_samples;
> > > >       int                     socket_filter;
> > > >       DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
> > > >       struct branch_type_stat brtype_stat;
> > > > @@ -331,6 +333,10 @@ static int process_sample_event(const struct perf_tool *tool,
> > > >                                    &rep->total_cycles, evsel);
> > > >       }
> > > >
> > > > +     rep->total_samples++;
> > > > +     if (al.parallelism == 1)
> > > > +             rep->singlethreaded_samples++;
> > > > +
> > > >       ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
> > > >       if (ret < 0)
> > > >               pr_debug("problem adding hist entry, skipping event\n");
> > > > @@ -1079,6 +1085,11 @@ static int __cmd_report(struct report *rep)
> > > >               return ret;
> > > >       }
> > > >
> > > > +     /* Don't show Latency column for non-parallel profiles by default. */
> > > > +     if (rep->singlethreaded_samples * 100 / rep->total_samples >= 99 &&
> > > > +                     !symbol_conf.prefer_latency)
> > > > +             perf_hpp__cancel_latency();
> > > > +
> > > >       evlist__check_mem_load_aux(session->evlist);
> > > >
> > > >       if (rep->stats_mode)
> > > > @@ -1468,6 +1479,10 @@ int cmd_report(int argc, const char **argv)
> > > >                   "Disable raw trace ordering"),
> > > >       OPT_BOOLEAN(0, "skip-empty", &report.skip_empty,
> > > >                   "Do not display empty (or dummy) events in the output"),
> > > > +     OPT_BOOLEAN(0, "latency", &symbol_conf.prefer_latency,
> > > > +                 "Show latency-centric profile rather than the default\n"
> > > > +                 "\t\t\t  CPU-consumption-centric profile\n"
> > > > +                 "\t\t\t  (requires perf record --latency flag)."),
> > > >       OPT_END()
> > > >       };
> > > >       struct perf_data data = {
> > > > @@ -1722,16 +1737,25 @@ int cmd_report(int argc, const char **argv)
> > > >               symbol_conf.annotate_data_sample = true;
> > > >       }
> > > >
> > > > +     symbol_conf.enable_latency = true;
> > > >       if (report.disable_order || !perf_session__has_switch_events(session)) {
> > > >               if (symbol_conf.parallelism_list_str ||
> > > > -                             (sort_order && strstr(sort_order, "parallelism")) ||
> > > > -                             (field_order && strstr(field_order, "parallelism"))) {
> > > > +                     symbol_conf.prefer_latency ||
> > > > +                     (sort_order && (strstr(sort_order, "latency") ||
> > > > +                             strstr(sort_order, "parallelism"))) ||
> > > > +                     (field_order && (strstr(field_order, "latency") ||
> > > > +                             strstr(field_order, "parallelism")))) {
> > > >                       if (report.disable_order)
> > > > -                             ui__error("Use of parallelism is incompatible with --disable-order.\n");
> > > > +                             ui__error("Use of latency profile or parallelism is incompatible with --disable-order.\n");
> > > >                       else
> > > > -                             ui__error("Use of parallelism requires --switch-events during record.\n");
> > > > +                             ui__error("Use of latency profile or parallelism requires --latency flag during record.\n");
> > > >                       return -1;
> > > >               }
> > > > +             /*
> > > > +              * If user did not ask for anything related to
> > > > +              * latency/parallelism explicitly, just don't show it.
> > > > +              */
> > > > +             symbol_conf.enable_latency = false;
> > > >       }
> > > >
> > > >       if (sort_order && strstr(sort_order, "ipc")) {
> > > > diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> > > > index 6de6309595f9e..b453f8eb579cc 100644
> > > > --- a/tools/perf/ui/hist.c
> > > > +++ b/tools/perf/ui/hist.c
> > > > @@ -632,27 +632,36 @@ void perf_hpp__init(void)
> > > >               return;
> > > >
> > > >       if (symbol_conf.cumulate_callchain) {
> > > > -             hpp_dimension__add_output(PERF_HPP__OVERHEAD_ACC);
> > > > +             /* Use idempotent addition to avoid more complex logic. */
> > > > +             if (symbol_conf.prefer_latency)
> > > > +                     hpp_dimension__add_output(PERF_HPP__LATENCY_ACC, true);
> > > > +             hpp_dimension__add_output(PERF_HPP__OVERHEAD_ACC, true);
> > > > +             if (symbol_conf.enable_latency)
> > > > +                     hpp_dimension__add_output(PERF_HPP__LATENCY_ACC, true);
> > > >               perf_hpp__format[PERF_HPP__OVERHEAD].name = "Self";
> > > >       }
> > > >
> > > > -     hpp_dimension__add_output(PERF_HPP__OVERHEAD);
> > > > +     if (symbol_conf.prefer_latency)
> > > > +             hpp_dimension__add_output(PERF_HPP__LATENCY, true);
> > > > +     hpp_dimension__add_output(PERF_HPP__OVERHEAD, true);
> > > > +     if (symbol_conf.enable_latency)
> > > > +             hpp_dimension__add_output(PERF_HPP__LATENCY, true);
> > > >
> > > >       if (symbol_conf.show_cpu_utilization) {
> > > > -             hpp_dimension__add_output(PERF_HPP__OVERHEAD_SYS);
> > > > -             hpp_dimension__add_output(PERF_HPP__OVERHEAD_US);
> > > > +             hpp_dimension__add_output(PERF_HPP__OVERHEAD_SYS, false);
> > > > +             hpp_dimension__add_output(PERF_HPP__OVERHEAD_US, false);
> > > >
> > > >               if (perf_guest) {
> > > > -                     hpp_dimension__add_output(PERF_HPP__OVERHEAD_GUEST_SYS);
> > > > -                     hpp_dimension__add_output(PERF_HPP__OVERHEAD_GUEST_US);
> > > > +                     hpp_dimension__add_output(PERF_HPP__OVERHEAD_GUEST_SYS, false);
> > > > +                     hpp_dimension__add_output(PERF_HPP__OVERHEAD_GUEST_US, false);
> > > >               }
> > > >       }
> > > >
> > > >       if (symbol_conf.show_nr_samples)
> > > > -             hpp_dimension__add_output(PERF_HPP__SAMPLES);
> > > > +             hpp_dimension__add_output(PERF_HPP__SAMPLES, false);
> > > >
> > > >       if (symbol_conf.show_total_period)
> > > > -             hpp_dimension__add_output(PERF_HPP__PERIOD);
> > > > +             hpp_dimension__add_output(PERF_HPP__PERIOD, false);
> > > >  }
> > > >
> > > >  void perf_hpp_list__column_register(struct perf_hpp_list *list,
> > > > @@ -701,6 +710,22 @@ void perf_hpp__cancel_cumulate(void)
> > > >       }
> > > >  }
> > > >
> > > > +void perf_hpp__cancel_latency(void)
> > > > +{
> > > > +     struct perf_hpp_fmt *fmt, *lat, *acc, *tmp;
> > > > +
> > > > +     if (is_strict_order(field_order) || is_strict_order(sort_order))
> > > > +             return;
> > > > +
> > > > +     lat = &perf_hpp__format[PERF_HPP__LATENCY];
> > > > +     acc = &perf_hpp__format[PERF_HPP__LATENCY_ACC];
> > > > +
> > > > +     perf_hpp_list__for_each_format_safe(&perf_hpp_list, fmt, tmp) {
> > > > +             if (fmt_equal(lat, fmt) || fmt_equal(acc, fmt))
> > > > +                     perf_hpp__column_unregister(fmt);
> > > > +     }
> > > > +}
> > > > +
> > > >  void perf_hpp__setup_output_field(struct perf_hpp_list *list)
> > > >  {
> > > >       struct perf_hpp_fmt *fmt;
> > > > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > > > index 91159f16c60b2..29d4c7a3d1747 100644
> > > > --- a/tools/perf/util/hist.h
> > > > +++ b/tools/perf/util/hist.h
> > > > @@ -582,6 +582,7 @@ enum {
> > > >
> > > >  void perf_hpp__init(void);
> > > >  void perf_hpp__cancel_cumulate(void);
> > > > +void perf_hpp__cancel_latency(void);
> > > >  void perf_hpp__setup_output_field(struct perf_hpp_list *list);
> > > >  void perf_hpp__reset_output_field(struct perf_hpp_list *list);
> > > >  void perf_hpp__append_sort_keys(struct perf_hpp_list *list);
> > > > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > > > index bc4c3acfe7552..2b6023de7a53a 100644
> > > > --- a/tools/perf/util/sort.c
> > > > +++ b/tools/perf/util/sort.c
> > > > @@ -2622,6 +2622,7 @@ struct hpp_dimension {
> > > >       const char              *name;
> > > >       struct perf_hpp_fmt     *fmt;
> > > >       int                     taken;
> > > > +     int                     was_taken;
> > > >  };
> > > >
> > > >  #define DIM(d, n) { .name = n, .fmt = &perf_hpp__format[d], }
> > > > @@ -3513,6 +3514,7 @@ static int __hpp_dimension__add(struct hpp_dimension *hd,
> > > >               return -1;
> > > >
> > > >       hd->taken = 1;
> > > > +     hd->was_taken = 1;
> > > >       perf_hpp_list__register_sort_field(list, fmt);
> > > >       return 0;
> > > >  }
> > > > @@ -3547,10 +3549,15 @@ static int __hpp_dimension__add_output(struct perf_hpp_list *list,
> > > >       return 0;
> > > >  }
> > > >
> > > > -int hpp_dimension__add_output(unsigned col)
> > > > +int hpp_dimension__add_output(unsigned col, bool implicit)
> > > >  {
> > > > +     struct hpp_dimension *hd;
> > > > +
> > > >       BUG_ON(col >= PERF_HPP__MAX_INDEX);
> > > > -     return __hpp_dimension__add_output(&perf_hpp_list, &hpp_sort_dimensions[col]);
> > > > +     hd = &hpp_sort_dimensions[col];
> > > > +     if (implicit && !hd->was_taken)
> > > > +             return 0;
> > >
> > > I don't think you need these implicit and was_taken things.
> > > Just removing from the sort list when it's unregistered seems to work.
> > >
> > > ---8<---
> > > @@ -685,6 +685,7 @@ void perf_hpp_list__prepend_sort_field(struct perf_hpp_list *list,
> > >  static void perf_hpp__column_unregister(struct perf_hpp_fmt *format)
> > >  {
> > >         list_del_init(&format->list);
> > > +       list_del_init(&format->sort_list);
> > >         fmt_free(format);
> > >  }
> > >
> > > ---8<---
> >
> > It merely suppresses the warning, but does not work the same way. See
> > this for details:
> > https://lore.kernel.org/all/CACT4Y+ZREdDL7a+DMKGFGae1ZjX1C8uNRwCGF0c8iUJtTTq0Lw@mail.gmail.com/
>
> But I think it's better to pass --latency option rather than adding it
> to -s option.  If you really want to have specific output fields, then
> please use -F latency,sym instead.

-F does not work in all cases, e.g. the command from tips.txt with -F
instead of --sort:

perf report --hierarchy -F latency,parallelism,comm,symbol
Error: --hierarchy and --fields options cannot be used together

I also don't understand how you see it working. Please elaborate.

--latency is no more than a handy present for the default case so that
a user does not need to learn other flags, field names, etc. It's
just:

perf report --latency

Then there are gazillions of custom permutations of various flags with
sort/field orders. It's impossible to second guess what a user means
in all of these cases and simplify with a magic --latency flag. For
example, possible commands may be different just by field order:
"latency", or "latency,overhead", or "overhead,latency", all of the
are "latency" in some sense, but which one of these 3 a user wants in
a particular case is impossible to infer.

Also, I don't see lots of value in using --latency flag instead of
latency sort field. It's just a bit longer command and nothing more.
Am I missing something? If a user is proficient with perf and a custom
specific configuration, I would let users specify what they want
rather than try to second guess their intentions.



> Also I've realized that it should add one sort key in setup_overhead()
> to support hierarchy mode properly.  Something like this?
>
> Thanks,
> Namhyung
>
>
> ---8<---
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 2b6023de7a53ae2e..329c2e9bbc69a725 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -3817,22 +3817,15 @@ static char *setup_overhead(char *keys)
>                 return keys;
>
>         if (symbol_conf.prefer_latency) {
> -               keys = prefix_if_not_in("overhead", keys);
> -               keys = prefix_if_not_in("latency", keys);
> -               if (symbol_conf.cumulate_callchain) {
> -                       keys = prefix_if_not_in("overhead_children", keys);
> +               if (symbol_conf.cumulate_callchain)
>                         keys = prefix_if_not_in("latency_children", keys);
> -               }
> -       } else if (!keys || (!strstr(keys, "overhead") &&
> -                       !strstr(keys, "latency"))) {
> -               if (symbol_conf.enable_latency)
> +               else
>                         keys = prefix_if_not_in("latency", keys);
> -               keys = prefix_if_not_in("overhead", keys);
> -               if (symbol_conf.cumulate_callchain) {
> -                       if (symbol_conf.enable_latency)
> -                               keys = prefix_if_not_in("latency_children", keys);
> +       } else {
> +               if (symbol_conf.cumulate_callchain)
>                         keys = prefix_if_not_in("overhead_children", keys);
> -               }
> +               else
> +                       keys = prefix_if_not_in("overhead", keys);
>         }
>
>         return keys;
> ---8<---
>
