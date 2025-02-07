Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA901A3056
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913055; cv=none; b=ibEefnH5sxytfngUUr9UiLyehqJOKggaGa9xTM4OVXSptPmKnscemBP0klkIJwogmsRdvg/UFnzwoz5D22v8g820aduzqlsYH13VLxMJjCM8yEWtWgMEqK3hp2XMZscHY/cO59FQyzRJsLS5JptuVOEa3mC+GaS/FMTyt7aku8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913055; c=relaxed/simple;
	bh=JISDy7apNAejMZAa8FO0CO25crcCy/Ra9WwSJ3yfKT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uM9CuwKHG/9HfPsv8D9PkhHaUmGxMjXKhBK/ZimIvUQPWpyTEj85rjs2hW+dsQ3/0FCtOFvSOrdgVFHgmiYRRBHBH6K7fsaLEbyHARJfCgGEpmY1gA9D41SECV+dYBdNhwsrxAjeID5lrH8P19x87vA11oue57UO69SfgENEbZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5ccoG++; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5ccoG++"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30762598511so17893511fa.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Feb 2025 23:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738913051; x=1739517851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wTT4v2BpOw2Q7OHKdTgmL3H6PdreoNWO8bjsZzdUenw=;
        b=i5ccoG++EpkpQZIcrbue+LIMhqCHO0D02pEus1Cwa2gfeM6RevgOgeCH/XzT3EMd+c
         9ONV4AVA+w7pnh/MirEuuYpqAlS+eS+j5tV2FusNjADB73FTN6E1Iuy6wy8EAvoX3Qdx
         NoyQTZpCVEr+Bf5lH5XHZkhDJQ6g6e70DbR482ZfMXdInKtPjqGdTURW/dbzHLKSyjuO
         j4c6cuPsZZmeJDhhbwwdN4D0In8EMXUu4Z+k6DWLEcsnm3M6RMjTo83rK0P2s8f+UG+V
         rrkeQTQu7Dvf+luhMSuxVD6Ax2TCaZUOrrkxAjTtrAXUs89rKjjdImZ0jOuWfjBaaYav
         G+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738913051; x=1739517851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTT4v2BpOw2Q7OHKdTgmL3H6PdreoNWO8bjsZzdUenw=;
        b=wiXNfTr0clgo3BGIDN/q5IzrjUyCGSaaSqF+0D7wYjGaOFg1KeOQiVobzRBAMv1iAY
         tuYFQitPYdHgGJ1BbmXVToyl7LuEKst1hOkzpFc/jQyGdVuxk1pYDoQvY7YFjS0M0tbm
         iSznuIJuGwwQD3oyyHv2abve2p2wETJkJ9a27FycVFrtOdu/zTdhdAwlBOaHWy66fv1r
         bBnYKQzglR0UJvoFrGhL5G7wTUq52HnjYCngL5O8iwWYsuEaz48u3madtxdryx6JxqfI
         skCB3Z3XTn1bMA4bcJOJlVEUZBQ3U54uh/oy1h5rjWLQKjH7dmhRX4isC3GcdKwbwpxt
         OSnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWom3aAq/7HyaOtmNvX1AW1UP0jg+NVdcp33Kn8+xJm6aZkRVV8rb665MnaxpJ0NHPw71t/9oSZXEXmK6o8frhC@vger.kernel.org
X-Gm-Message-State: AOJu0YxJAIAtYYF8cxDe4kjdJjYwhkrjS99d7LY0pessuGM0m17jVmwZ
	Rwh8ar9sdPFLLSgpr73ylJv9WBYzdUM3fcTTob+OD3zp3J0O/bEo6x7o5KFUEqjuQ4TWD4XvJRI
	fZ7zltPc86FI5HRf5kVql32MB/C4fhEpkHGBz
X-Gm-Gg: ASbGnctdWR5oa/BymuChU/G5I4AvPGE7p+k63iD1l2ak3dqaNkbSWaFphCHyT4o8cs8
	Pma3nbz0PD9nxtcrSW+QMnhV0qjypAtYzrh1On6xaNCOGUQVa8BitGW7XaqcyYbewv8dfyroWDr
	iNn2TmLklQwu/3gxE9gEkngw+6Hxc=
X-Google-Smtp-Source: AGHT+IEjmAEPKHFh1PtxHFJzmpT5dEZOSRzzD7oVG5l4DlR9eZmzG37zwv2QWIpoOiVBv/WBOx8rVgA04jFA934zoig=
X-Received: by 2002:a2e:bcc9:0:b0:307:c829:f170 with SMTP id
 38308e7fff4ca-307e57c8157mr5830801fa.4.1738913050824; Thu, 06 Feb 2025
 23:24:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738772628.git.dvyukov@google.com> <eb32b9b13856b0d508836b61b3e8377aef9163a3.1738772628.git.dvyukov@google.com>
 <Z6WBsruddcx0SFV5@google.com>
In-Reply-To: <Z6WBsruddcx0SFV5@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 7 Feb 2025 08:23:58 +0100
X-Gm-Features: AWEUYZnqrQJOKE9UFcFO-tomn8VxWBzeoUDebj1GCcBNi6YH8fTb4K7mbIwImCM
Message-ID: <CACT4Y+afC5WfTMaKGtg760PS5oXkkurzAyHVyKr9TsPs9RU2DQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] perf report: Add --latency flag
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Feb 2025 at 04:44, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Wed, Feb 05, 2025 at 05:27:45PM +0100, Dmitry Vyukov wrote:
> > Add record/report --latency flag that allows to capture and show
> > latency-centric profiles rather than the default CPU-consumption-centric
> > profiles. For latency profiles record captures context switch events,
> > and report shows Latency as the first column.
> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> >
> > ---
> > Changes in v5:
> >  - added description of --latency flag in Documentation flags
> > ---
> >  tools/perf/Documentation/perf-record.txt |  4 +++
> >  tools/perf/Documentation/perf-report.txt |  5 +++
> >  tools/perf/builtin-record.c              | 20 ++++++++++++
> >  tools/perf/builtin-report.c              | 32 +++++++++++++++---
> >  tools/perf/ui/hist.c                     | 41 +++++++++++++++++++-----
> >  tools/perf/util/hist.h                   |  1 +
> >  tools/perf/util/sort.c                   | 33 +++++++++++++++----
> >  tools/perf/util/sort.h                   |  2 +-
> >  tools/perf/util/symbol_conf.h            |  4 ++-
> >  9 files changed, 122 insertions(+), 20 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > index 80686d590de24..c7fc1ba265e27 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -227,6 +227,10 @@ OPTIONS
> >       '--filter' exists, the new filter expression will be combined with
> >       them by '&&'.
> >
> > +--latency::
> > +     Enable data collection for latency profiling.
> > +     Use perf report --latency for latency-centric profile.
> > +
> >  -a::
> >  --all-cpus::
> >          System-wide collection from all CPUs (default if no target is specified).
> > diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> > index 87f8645194062..66794131aec48 100644
> > --- a/tools/perf/Documentation/perf-report.txt
> > +++ b/tools/perf/Documentation/perf-report.txt
> > @@ -68,6 +68,11 @@ OPTIONS
> >  --hide-unresolved::
> >          Only display entries resolved to a symbol.
> >
> > +--latency::
> > +        Show latency-centric profile rather than the default
> > +        CPU-consumption-centric profile
> > +        (requires perf record --latency flag).
> > +
> >  -s::
> >  --sort=::
> >       Sort histogram entries by given key(s) - multiple keys can be specified
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 5db1aedf48df9..e219639ac401b 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -161,6 +161,7 @@ struct record {
> >       struct evlist           *sb_evlist;
> >       pthread_t               thread_id;
> >       int                     realtime_prio;
> > +     bool                    latency;
> >       bool                    switch_output_event_set;
> >       bool                    no_buildid;
> >       bool                    no_buildid_set;
> > @@ -3371,6 +3372,9 @@ static struct option __record_options[] = {
> >                    parse_events_option),
> >       OPT_CALLBACK(0, "filter", &record.evlist, "filter",
> >                    "event filter", parse_filter),
> > +     OPT_BOOLEAN(0, "latency", &record.latency,
> > +                 "Enable data collection for latency profiling.\n"
> > +                 "\t\t\t  Use perf report --latency for latency-centric profile."),
> >       OPT_CALLBACK_NOOPT(0, "exclude-perf", &record.evlist,
> >                          NULL, "don't record events from perf itself",
> >                          exclude_perf),
> > @@ -4017,6 +4021,22 @@ int cmd_record(int argc, const char **argv)
> >
> >       }
> >
> > +     if (record.latency) {
> > +             /*
> > +              * There is no fundamental reason why latency profiling
> > +              * can't work for system-wide mode, but exact semantics
> > +              * and details are to be defined.
> > +              * See the following thread for details:
> > +              * https://lore.kernel.org/all/Z4XDJyvjiie3howF@google.com/
> > +              */
> > +             if (record.opts.target.system_wide) {
> > +                     pr_err("Failed: latency profiling is not supported with system-wide collection.\n");
> > +                     err = -EINVAL;
> > +                     goto out_opts;
> > +             }
> > +             record.opts.record_switch_events = true;
> > +     }
> > +
> >       if (rec->buildid_mmap) {
> >               if (!perf_can_record_build_id()) {
> >                       pr_err("Failed: no support to record build id in mmap events, update your kernel.\n");
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index 2a19abdc869a1..69de6dbefecfa 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -112,6 +112,8 @@ struct report {
> >       u64                     nr_entries;
> >       u64                     queue_size;
> >       u64                     total_cycles;
> > +     u64                     total_samples;
> > +     u64                     singlethreaded_samples;
> >       int                     socket_filter;
> >       DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
> >       struct branch_type_stat brtype_stat;
> > @@ -331,6 +333,10 @@ static int process_sample_event(const struct perf_tool *tool,
> >                                    &rep->total_cycles, evsel);
> >       }
> >
> > +     rep->total_samples++;
> > +     if (al.parallelism == 1)
> > +             rep->singlethreaded_samples++;
> > +
> >       ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
> >       if (ret < 0)
> >               pr_debug("problem adding hist entry, skipping event\n");
> > @@ -1079,6 +1085,11 @@ static int __cmd_report(struct report *rep)
> >               return ret;
> >       }
> >
> > +     /* Don't show Latency column for non-parallel profiles by default. */
> > +     if (rep->singlethreaded_samples * 100 / rep->total_samples >= 99 &&
> > +                     !symbol_conf.prefer_latency)
> > +             perf_hpp__cancel_latency();
> > +
> >       evlist__check_mem_load_aux(session->evlist);
> >
> >       if (rep->stats_mode)
> > @@ -1468,6 +1479,10 @@ int cmd_report(int argc, const char **argv)
> >                   "Disable raw trace ordering"),
> >       OPT_BOOLEAN(0, "skip-empty", &report.skip_empty,
> >                   "Do not display empty (or dummy) events in the output"),
> > +     OPT_BOOLEAN(0, "latency", &symbol_conf.prefer_latency,
> > +                 "Show latency-centric profile rather than the default\n"
> > +                 "\t\t\t  CPU-consumption-centric profile\n"
> > +                 "\t\t\t  (requires perf record --latency flag)."),
> >       OPT_END()
> >       };
> >       struct perf_data data = {
> > @@ -1722,16 +1737,25 @@ int cmd_report(int argc, const char **argv)
> >               symbol_conf.annotate_data_sample = true;
> >       }
> >
> > +     symbol_conf.enable_latency = true;
> >       if (report.disable_order || !perf_session__has_switch_events(session)) {
> >               if (symbol_conf.parallelism_list_str ||
> > -                             (sort_order && strstr(sort_order, "parallelism")) ||
> > -                             (field_order && strstr(field_order, "parallelism"))) {
> > +                     symbol_conf.prefer_latency ||
> > +                     (sort_order && (strstr(sort_order, "latency") ||
> > +                             strstr(sort_order, "parallelism"))) ||
> > +                     (field_order && (strstr(field_order, "latency") ||
> > +                             strstr(field_order, "parallelism")))) {
> >                       if (report.disable_order)
> > -                             ui__error("Use of parallelism is incompatible with --disable-order.\n");
> > +                             ui__error("Use of latency profile or parallelism is incompatible with --disable-order.\n");
> >                       else
> > -                             ui__error("Use of parallelism requires --switch-events during record.\n");
> > +                             ui__error("Use of latency profile or parallelism requires --latency flag during record.\n");
> >                       return -1;
> >               }
> > +             /*
> > +              * If user did not ask for anything related to
> > +              * latency/parallelism explicitly, just don't show it.
> > +              */
> > +             symbol_conf.enable_latency = false;
> >       }
> >
> >       if (sort_order && strstr(sort_order, "ipc")) {
> > diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> > index 6de6309595f9e..b453f8eb579cc 100644
> > --- a/tools/perf/ui/hist.c
> > +++ b/tools/perf/ui/hist.c
> > @@ -632,27 +632,36 @@ void perf_hpp__init(void)
> >               return;
> >
> >       if (symbol_conf.cumulate_callchain) {
> > -             hpp_dimension__add_output(PERF_HPP__OVERHEAD_ACC);
> > +             /* Use idempotent addition to avoid more complex logic. */
> > +             if (symbol_conf.prefer_latency)
> > +                     hpp_dimension__add_output(PERF_HPP__LATENCY_ACC, true);
> > +             hpp_dimension__add_output(PERF_HPP__OVERHEAD_ACC, true);
> > +             if (symbol_conf.enable_latency)
> > +                     hpp_dimension__add_output(PERF_HPP__LATENCY_ACC, true);
> >               perf_hpp__format[PERF_HPP__OVERHEAD].name = "Self";
> >       }
> >
> > -     hpp_dimension__add_output(PERF_HPP__OVERHEAD);
> > +     if (symbol_conf.prefer_latency)
> > +             hpp_dimension__add_output(PERF_HPP__LATENCY, true);
> > +     hpp_dimension__add_output(PERF_HPP__OVERHEAD, true);
> > +     if (symbol_conf.enable_latency)
> > +             hpp_dimension__add_output(PERF_HPP__LATENCY, true);
> >
> >       if (symbol_conf.show_cpu_utilization) {
> > -             hpp_dimension__add_output(PERF_HPP__OVERHEAD_SYS);
> > -             hpp_dimension__add_output(PERF_HPP__OVERHEAD_US);
> > +             hpp_dimension__add_output(PERF_HPP__OVERHEAD_SYS, false);
> > +             hpp_dimension__add_output(PERF_HPP__OVERHEAD_US, false);
> >
> >               if (perf_guest) {
> > -                     hpp_dimension__add_output(PERF_HPP__OVERHEAD_GUEST_SYS);
> > -                     hpp_dimension__add_output(PERF_HPP__OVERHEAD_GUEST_US);
> > +                     hpp_dimension__add_output(PERF_HPP__OVERHEAD_GUEST_SYS, false);
> > +                     hpp_dimension__add_output(PERF_HPP__OVERHEAD_GUEST_US, false);
> >               }
> >       }
> >
> >       if (symbol_conf.show_nr_samples)
> > -             hpp_dimension__add_output(PERF_HPP__SAMPLES);
> > +             hpp_dimension__add_output(PERF_HPP__SAMPLES, false);
> >
> >       if (symbol_conf.show_total_period)
> > -             hpp_dimension__add_output(PERF_HPP__PERIOD);
> > +             hpp_dimension__add_output(PERF_HPP__PERIOD, false);
> >  }
> >
> >  void perf_hpp_list__column_register(struct perf_hpp_list *list,
> > @@ -701,6 +710,22 @@ void perf_hpp__cancel_cumulate(void)
> >       }
> >  }
> >
> > +void perf_hpp__cancel_latency(void)
> > +{
> > +     struct perf_hpp_fmt *fmt, *lat, *acc, *tmp;
> > +
> > +     if (is_strict_order(field_order) || is_strict_order(sort_order))
> > +             return;
> > +
> > +     lat = &perf_hpp__format[PERF_HPP__LATENCY];
> > +     acc = &perf_hpp__format[PERF_HPP__LATENCY_ACC];
> > +
> > +     perf_hpp_list__for_each_format_safe(&perf_hpp_list, fmt, tmp) {
> > +             if (fmt_equal(lat, fmt) || fmt_equal(acc, fmt))
> > +                     perf_hpp__column_unregister(fmt);
> > +     }
> > +}
> > +
> >  void perf_hpp__setup_output_field(struct perf_hpp_list *list)
> >  {
> >       struct perf_hpp_fmt *fmt;
> > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > index 91159f16c60b2..29d4c7a3d1747 100644
> > --- a/tools/perf/util/hist.h
> > +++ b/tools/perf/util/hist.h
> > @@ -582,6 +582,7 @@ enum {
> >
> >  void perf_hpp__init(void);
> >  void perf_hpp__cancel_cumulate(void);
> > +void perf_hpp__cancel_latency(void);
> >  void perf_hpp__setup_output_field(struct perf_hpp_list *list);
> >  void perf_hpp__reset_output_field(struct perf_hpp_list *list);
> >  void perf_hpp__append_sort_keys(struct perf_hpp_list *list);
> > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > index bc4c3acfe7552..2b6023de7a53a 100644
> > --- a/tools/perf/util/sort.c
> > +++ b/tools/perf/util/sort.c
> > @@ -2622,6 +2622,7 @@ struct hpp_dimension {
> >       const char              *name;
> >       struct perf_hpp_fmt     *fmt;
> >       int                     taken;
> > +     int                     was_taken;
> >  };
> >
> >  #define DIM(d, n) { .name = n, .fmt = &perf_hpp__format[d], }
> > @@ -3513,6 +3514,7 @@ static int __hpp_dimension__add(struct hpp_dimension *hd,
> >               return -1;
> >
> >       hd->taken = 1;
> > +     hd->was_taken = 1;
> >       perf_hpp_list__register_sort_field(list, fmt);
> >       return 0;
> >  }
> > @@ -3547,10 +3549,15 @@ static int __hpp_dimension__add_output(struct perf_hpp_list *list,
> >       return 0;
> >  }
> >
> > -int hpp_dimension__add_output(unsigned col)
> > +int hpp_dimension__add_output(unsigned col, bool implicit)
> >  {
> > +     struct hpp_dimension *hd;
> > +
> >       BUG_ON(col >= PERF_HPP__MAX_INDEX);
> > -     return __hpp_dimension__add_output(&perf_hpp_list, &hpp_sort_dimensions[col]);
> > +     hd = &hpp_sort_dimensions[col];
> > +     if (implicit && !hd->was_taken)
> > +             return 0;
>
> I don't think you need these implicit and was_taken things.
> Just removing from the sort list when it's unregistered seems to work.
>
> ---8<---
> @@ -685,6 +685,7 @@ void perf_hpp_list__prepend_sort_field(struct perf_hpp_list *list,
>  static void perf_hpp__column_unregister(struct perf_hpp_fmt *format)
>  {
>         list_del_init(&format->list);
> +       list_del_init(&format->sort_list);
>         fmt_free(format);
>  }
>
> ---8<---

It merely suppresses the warning, but does not work the same way. See
this for details:
https://lore.kernel.org/all/CACT4Y+ZREdDL7a+DMKGFGae1ZjX1C8uNRwCGF0c8iUJtTTq0Lw@mail.gmail.com/

> Thanks,
> Namhyung
>
>
> > +     return __hpp_dimension__add_output(&perf_hpp_list, hd);
> >  }
> >
> >  int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
> > @@ -3809,10 +3816,24 @@ static char *setup_overhead(char *keys)
> >       if (sort__mode == SORT_MODE__DIFF)
> >               return keys;
> >
> > -     keys = prefix_if_not_in("overhead", keys);
> > -
> > -     if (symbol_conf.cumulate_callchain)
> > -             keys = prefix_if_not_in("overhead_children", keys);
> > +     if (symbol_conf.prefer_latency) {
> > +             keys = prefix_if_not_in("overhead", keys);
> > +             keys = prefix_if_not_in("latency", keys);
> > +             if (symbol_conf.cumulate_callchain) {
> > +                     keys = prefix_if_not_in("overhead_children", keys);
> > +                     keys = prefix_if_not_in("latency_children", keys);
> > +             }
> > +     } else if (!keys || (!strstr(keys, "overhead") &&
> > +                     !strstr(keys, "latency"))) {
> > +             if (symbol_conf.enable_latency)
> > +                     keys = prefix_if_not_in("latency", keys);
> > +             keys = prefix_if_not_in("overhead", keys);
> > +             if (symbol_conf.cumulate_callchain) {
> > +                     if (symbol_conf.enable_latency)
> > +                             keys = prefix_if_not_in("latency_children", keys);
> > +                     keys = prefix_if_not_in("overhead_children", keys);
> > +             }
> > +     }
> >
> >       return keys;
> >  }
> > diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> > index 11fb15f914093..180d36a2bea35 100644
> > --- a/tools/perf/util/sort.h
> > +++ b/tools/perf/util/sort.h
> > @@ -141,7 +141,7 @@ int report_parse_ignore_callees_opt(const struct option *opt, const char *arg, i
> >
> >  bool is_strict_order(const char *order);
> >
> > -int hpp_dimension__add_output(unsigned col);
> > +int hpp_dimension__add_output(unsigned col, bool implicit);
> >  void reset_dimensions(void);
> >  int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
> >                       struct evlist *evlist,
> > diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> > index c5b2e56127e22..cd9aa82c7d5ad 100644
> > --- a/tools/perf/util/symbol_conf.h
> > +++ b/tools/perf/util/symbol_conf.h
> > @@ -49,7 +49,9 @@ struct symbol_conf {
> >                       keep_exited_threads,
> >                       annotate_data_member,
> >                       annotate_data_sample,
> > -                     skip_empty;
> > +                     skip_empty,
> > +                     enable_latency,
> > +                     prefer_latency;
> >       const char      *vmlinux_name,
> >                       *kallsyms_name,
> >                       *source_prefix,
> > --
> > 2.48.1.362.g079036d154-goog
> >
