Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C66A33F
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738133771; cv=none; b=MoLRHvSA9SVhASeiibGqoOn8qXGeJCQsSrqS6L1zWjWbQMWj/bmr7K3bBvdt1SBeag+IFTwI2sTjwHFA81I28EQSahL4Vxluf9McpMS/B5DiCzxBZIHPa9xDlxUPrwL8gQEsUujI6Thxs/jYp8KZxQsUO/Wb5yXbaZ/IRjPY4hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738133771; c=relaxed/simple;
	bh=dmxdZFnKgWJxnm5Bhq60k9l6lWNq9P5Bdv8F4VIUR1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaMvKWZn/Ol/bddkPBnZ8fNJiTsnvnKnVqJcvrNAlQgzSmA2tOiCt0BoLqXT6ePibqfnt0Of+TTmUdRiaP63JXgpuXdo2mm0jepJTLaqrkZWsBLja/8kFO0uS4e2+vDM+4QDD5csEDebOx+XqOgaGaB9gHAMCY6OLJ5uPfGRUN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f08WPHP7; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f08WPHP7"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30225b2586cso3808421fa.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 22:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738133768; x=1738738568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VlBvpLFZUjhA2iganhMtP55DBFjGZMRAsZwddXhg9f8=;
        b=f08WPHP7R7yJcvKa1ZE1WWvU+zCikB+qvk/UhU/eHTi0BvhiHxbvmAkgk/BWvQ2ptZ
         gdB1hu7KfbXFJOJINXSzJa/H+JJJu7fnrbdpxaez+38DrdRBPGc3IO/QS63VEScVna/b
         nQMeoIVgwFuBZj7DTSIpAF+UT38Mq/c29hkSUfo4wrzHVrpXo20zf4nK48RAPlW+utUn
         ImPMzcZKrbmJMRuMl6/vOQwDOEErrAkI+pue6Y5EHipO+yKPy9uYzP7/Q6dOjilLvHRD
         Nn7A7HVBILXwG6G42uK3vkIEKZF3zScUK6KvTrMoEfyBVaY+qBFnkpStkvJLKAY9ZjT6
         gyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738133768; x=1738738568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlBvpLFZUjhA2iganhMtP55DBFjGZMRAsZwddXhg9f8=;
        b=LXOVJ0U88vsCJfQ2h578oiPz1pLkE54NfxTiQNoIwNERThJpoUU4BJjaVW5WLOxVE+
         zXnlnJpv/R0U95eHLur3/74wab24lfR46x+lB+qo802CB7qsLZOay4FcnE9O2DrFfZzV
         +ZoYXkrA9pNsJSc7RCFlJxwqL2SHOdJCevqzxPQVEpSqiyDElAP+KCYIAKdSaKZ/lxD2
         NjYFP2yKY1EHoraz1nspfGI8VnrU4b+vc8jQAxN/LZHyc1ZC/StNpmgPaYn/yDRSC5FT
         8SzWr+Z9ZQLj1fvxYYQ2F+ezMZ29p6F51xMSWXXDm8bexhlzjEVyC6fsuUSG6DCuNBc9
         xCrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVoJNc3Fd8BBDEu9hsLn9JuIArg0y2Xle8vphg8zOvqQSZB/PCauChH45SiZYkGglgfpoBlI5R0wah5kd7pW91@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5uVxP5G6i1CmUfr82qmsM+TTI7xY03UFyn6Sny9UxfHwIdKyJ
	RDh3S8Su8mghkJMLfmBmG2NM/HZEY++FZjOzc4XAh1TzvoVG6M0zyzEc2RLu7vxSAzv2u6sZZjy
	J9S9GZasV3UPWnz8VMSDKHo2bXxqJFNX5CD/O
X-Gm-Gg: ASbGncvO0DHtz9VS/nNTaFlYLNWndoP5PI9U8c44APSWSCwTYBMm/JqlJD7vAmAUH2c
	pfxA0Krgu2gNpINc9TMN7GbM+fP/7GBwEbqbLMPoDvMg+SqybM60DSpGr7X3KccGvvrsaZaf4La
	s0ukZyiMMxt5pGiwFeavAib/ELn+bSWw==
X-Google-Smtp-Source: AGHT+IG5jFf67e3Zj7O5thD4hwXlS6ux9GEJHwS95m0wA8O6SInkVDPaFdDRYaZQVvEjo/lIOY5GZqvwsmF/XCTY8nE=
X-Received: by 2002:a2e:a801:0:b0:302:23a7:1ee8 with SMTP id
 38308e7fff4ca-3078df4cccamr22910131fa.3.1738133767604; Tue, 28 Jan 2025
 22:56:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737971364.git.dvyukov@google.com> <e78918ee05f9aaa623f0cb402e3c53e7b8a6185b.1737971364.git.dvyukov@google.com>
 <Z5m1DqB2SK_Cj3iC@google.com>
In-Reply-To: <Z5m1DqB2SK_Cj3iC@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 29 Jan 2025 07:55:55 +0100
X-Gm-Features: AWEUYZmqrU04BMqBRUVx3x1OhdfUqCFFDp0ZN7PvC3qoJnDDngnc_dzWUNt20Hw
Message-ID: <CACT4Y+ZZhPZMtDdkShhJ5qZqG4BR9DBpCuWNz_H1wc1eQ0tFRg@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] perf report: Add latency output field
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jan 2025 at 05:56, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Mon, Jan 27, 2025 at 10:58:52AM +0100, Dmitry Vyukov wrote:
> > Latency output field is similar to overhead, but represents overhead for
> > latency rather than CPU consumption. It's re-scaled from overhead by dividing
> > weight by the current parallelism level at the time of the sample.
> > It effectively models profiling with 1 sample taken per unit of wall-clock
> > time rather than unit of CPU time.
> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  tools/perf/ui/browsers/hists.c  | 27 ++++++++++------
> >  tools/perf/ui/hist.c            | 29 ++++++++++-------
> >  tools/perf/util/addr_location.h |  2 ++
> >  tools/perf/util/event.c         |  6 ++++
> >  tools/perf/util/events_stats.h  |  2 ++
> >  tools/perf/util/hist.c          | 55 ++++++++++++++++++++++++---------
> >  tools/perf/util/hist.h          | 12 +++++++
> >  tools/perf/util/sort.c          |  2 ++
> >  8 files changed, 100 insertions(+), 35 deletions(-)
> >
> > diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> > index 49ba82bf33918..35c10509b797f 100644
> > --- a/tools/perf/ui/browsers/hists.c
> > +++ b/tools/perf/ui/browsers/hists.c
> > @@ -1226,7 +1226,7 @@ int __hpp__slsmg_color_printf(struct perf_hpp *hpp, const char *fmt, ...)
> >       return ret;
> >  }
> >
> > -#define __HPP_COLOR_PERCENT_FN(_type, _field)                                \
> > +#define __HPP_COLOR_PERCENT_FN(_type, _field, _fmttype)                      \
> >  static u64 __hpp_get_##_field(struct hist_entry *he)                 \
> >  {                                                                    \
> >       return he->stat._field;                                         \
> > @@ -1238,10 +1238,10 @@ hist_browser__hpp_color_##_type(struct perf_hpp_fmt *fmt,             \
> >                               struct hist_entry *he)                  \
> >  {                                                                    \
> >       return hpp__fmt(fmt, hpp, he, __hpp_get_##_field, " %*.2f%%",   \
> > -                     __hpp__slsmg_color_printf, true);               \
> > +                     __hpp__slsmg_color_printf, _fmttype);           \
> >  }
> >
> > -#define __HPP_COLOR_ACC_PERCENT_FN(_type, _field)                    \
> > +#define __HPP_COLOR_ACC_PERCENT_FN(_type, _field, _fmttype)          \
> >  static u64 __hpp_get_acc_##_field(struct hist_entry *he)             \
> >  {                                                                    \
> >       return he->stat_acc->_field;                                    \
> > @@ -1262,15 +1262,18 @@ hist_browser__hpp_color_##_type(struct perf_hpp_fmt *fmt,             \
> >               return ret;                                             \
> >       }                                                               \
> >       return hpp__fmt(fmt, hpp, he, __hpp_get_acc_##_field,           \
> > -                     " %*.2f%%", __hpp__slsmg_color_printf, true);   \
> > +                     " %*.2f%%", __hpp__slsmg_color_printf,          \
> > +                     _fmttype);                                      \
> >  }
> >
> > -__HPP_COLOR_PERCENT_FN(overhead, period)
> > -__HPP_COLOR_PERCENT_FN(overhead_sys, period_sys)
> > -__HPP_COLOR_PERCENT_FN(overhead_us, period_us)
> > -__HPP_COLOR_PERCENT_FN(overhead_guest_sys, period_guest_sys)
> > -__HPP_COLOR_PERCENT_FN(overhead_guest_us, period_guest_us)
> > -__HPP_COLOR_ACC_PERCENT_FN(overhead_acc, period)
> > +__HPP_COLOR_PERCENT_FN(overhead, period, PERF_HPP_FMT_TYPE__PERCENT)
> > +__HPP_COLOR_PERCENT_FN(latency, latency, PERF_HPP_FMT_TYPE__LATENCY)
> > +__HPP_COLOR_PERCENT_FN(overhead_sys, period_sys, PERF_HPP_FMT_TYPE__PERCENT)
> > +__HPP_COLOR_PERCENT_FN(overhead_us, period_us, PERF_HPP_FMT_TYPE__PERCENT)
> > +__HPP_COLOR_PERCENT_FN(overhead_guest_sys, period_guest_sys, PERF_HPP_FMT_TYPE__PERCENT)
> > +__HPP_COLOR_PERCENT_FN(overhead_guest_us, period_guest_us, PERF_HPP_FMT_TYPE__PERCENT)
> > +__HPP_COLOR_ACC_PERCENT_FN(overhead_acc, period, PERF_HPP_FMT_TYPE__PERCENT)
> > +__HPP_COLOR_ACC_PERCENT_FN(latency_acc, latency, PERF_HPP_FMT_TYPE__LATENCY)
> >
> >  #undef __HPP_COLOR_PERCENT_FN
> >  #undef __HPP_COLOR_ACC_PERCENT_FN
> > @@ -1279,6 +1282,8 @@ void hist_browser__init_hpp(void)
> >  {
> >       perf_hpp__format[PERF_HPP__OVERHEAD].color =
> >                               hist_browser__hpp_color_overhead;
> > +     perf_hpp__format[PERF_HPP__LATENCY].color =
> > +                             hist_browser__hpp_color_latency;
> >       perf_hpp__format[PERF_HPP__OVERHEAD_SYS].color =
> >                               hist_browser__hpp_color_overhead_sys;
> >       perf_hpp__format[PERF_HPP__OVERHEAD_US].color =
> > @@ -1289,6 +1294,8 @@ void hist_browser__init_hpp(void)
> >                               hist_browser__hpp_color_overhead_guest_us;
> >       perf_hpp__format[PERF_HPP__OVERHEAD_ACC].color =
> >                               hist_browser__hpp_color_overhead_acc;
> > +     perf_hpp__format[PERF_HPP__LATENCY_ACC].color =
> > +                             hist_browser__hpp_color_latency_acc;
> >
> >       res_sample_init();
> >  }
> > diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> > index 34fda1d5eccb4..22e31d835301e 100644
> > --- a/tools/perf/ui/hist.c
> > +++ b/tools/perf/ui/hist.c
> > @@ -27,9 +27,10 @@ static int __hpp__fmt_print(struct perf_hpp *hpp, struct hists *hists, u64 val,
> >                           int nr_samples, const char *fmt, int len,
> >                           hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
> >  {
> > -     if (fmtype == PERF_HPP_FMT_TYPE__PERCENT) {
> > +     if (fmtype == PERF_HPP_FMT_TYPE__PERCENT || fmtype == PERF_HPP_FMT_TYPE__LATENCY) {
> >               double percent = 0.0;
> > -             u64 total = hists__total_period(hists);
> > +             u64 total = fmtype == PERF_HPP_FMT_TYPE__PERCENT ? hists__total_period(hists) :
> > +                     hists__total_latency(hists);
> >
> >               if (total)
> >                       percent = 100.0 * val / total;
> > @@ -128,7 +129,7 @@ int hpp__fmt(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> >                                 print_fn, fmtype);
> >       }
> >
> > -     if (fmtype == PERF_HPP_FMT_TYPE__PERCENT)
> > +     if (fmtype == PERF_HPP_FMT_TYPE__PERCENT || fmtype == PERF_HPP_FMT_TYPE__LATENCY)
> >               len -= 2; /* 2 for a space and a % sign */
> >       else
> >               len -= 1;
> > @@ -472,11 +473,13 @@ __HPP_ENTRY_AVERAGE_FN(_type, _field)                                   \
> >  __HPP_SORT_AVERAGE_FN(_type, _field)
> >
> >  HPP_PERCENT_FNS(overhead, period)
> > +HPP_PERCENT_FNS(latency, latency)
> >  HPP_PERCENT_FNS(overhead_sys, period_sys)
> >  HPP_PERCENT_FNS(overhead_us, period_us)
> >  HPP_PERCENT_FNS(overhead_guest_sys, period_guest_sys)
> >  HPP_PERCENT_FNS(overhead_guest_us, period_guest_us)
> >  HPP_PERCENT_ACC_FNS(overhead_acc, period)
> > +HPP_PERCENT_ACC_FNS(latency_acc, latency)
> >
> >  HPP_RAW_FNS(samples, nr_events)
> >  HPP_RAW_FNS(period, period)
> > @@ -548,11 +551,13 @@ static bool hpp__equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
> >
> >  struct perf_hpp_fmt perf_hpp__format[] = {
> >       HPP__COLOR_PRINT_FNS("Overhead", overhead, OVERHEAD),
> > +     HPP__COLOR_PRINT_FNS("Latency", latency, LATENCY),
> >       HPP__COLOR_PRINT_FNS("sys", overhead_sys, OVERHEAD_SYS),
> >       HPP__COLOR_PRINT_FNS("usr", overhead_us, OVERHEAD_US),
> >       HPP__COLOR_PRINT_FNS("guest sys", overhead_guest_sys, OVERHEAD_GUEST_SYS),
> >       HPP__COLOR_PRINT_FNS("guest usr", overhead_guest_us, OVERHEAD_GUEST_US),
> >       HPP__COLOR_ACC_PRINT_FNS("Children", overhead_acc, OVERHEAD_ACC),
> > +     HPP__COLOR_ACC_PRINT_FNS("Latency", latency_acc, LATENCY_ACC),
>
> Hmm.. two latency fields have the same name.  Maybe better to
> distinguish them but "Children Latency" or "Total Latency" would be
> too long.. :(
>
> I think it's mostly ok since users will see them together with overhead
> columns and it'll give the context ("Children" or "Self").  But it can
> e called with -F or -s option to manually select those columns only.

Yes, the motivation for calling them the same was the column name length.

And, with the default flags it looks reasonable:

  Children  Latency      Self   Latency  Command

The fields seem to be selected based on the names in sort.c rather
than these names, e.g. I can do:

perf report -F latency_children,overhead_children,latency,overhead,symbol

and get:

Samples: 45K of event 'cycles:Pu', Event count (approx.): 10457486861
  Latency  Children   Latency  Overhead  Symbol
+  19.35%    18.69%     0.00%     0.00%  [k] 0000000000000000
+   4.86%     4.21%     4.86%     4.21%  [.] htab_find_slot_with_hash
+   4.15%     4.48%     0.00%     0.00%  [.] 0xffffffff9ce012a6

So it seems to be possible to select these columns as needed.


> Thanks,
> Namhyung
>
>
> >       HPP__PRINT_FNS("Samples", samples, SAMPLES),
> >       HPP__PRINT_FNS("Period", period, PERIOD),
> >       HPP__PRINT_FNS("Weight1", weight1, WEIGHT1),
>
> >               fmt->free(fmt);
> >  }
