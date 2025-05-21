Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F1202F7C
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747844183; cv=none; b=j4x6gntcYgfKuFz77Sct7KzaJrrsJVrbQmnoP7E1T4CaoKagu5xhE4RRtoYsU+sJ/ZlD1YkaOaXV96INyY6fcvQApnke9+rMVWz9D/80O45O6M/e/Kff0ADQk/EqbDX0bYSExwcIT/OkHuhd2JtoAFtwV7TZJ/RyTrncyb/GKDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747844183; c=relaxed/simple;
	bh=w37+fZhPBWglQNVwjleFuAaeC/0//dKTW+ZT0j0JWnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=af36KRC8l8A2AhVqQf8SHiD/sKQ2DV/9N8s7ORv1x0HaZ4Gn89VnXQaLivktdhs6OleA8Uva3xzoDvqRFc/v6FwcR7N889riRkDoVOauHuWUm39z3oECI6kCqeU/pHevdrP0Vgn7EaHgZK50ansu2J1rMNTO+YIgPeHiNZ5QGgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJMT/fvk; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJMT/fvk"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d96836c1c2so992245ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747844177; x=1748448977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJCpgch7Qh9Gr9lPbzv7OjFa/SqUdCi8Z66tY+WUKDE=;
        b=uJMT/fvkstg55x1BTbPL7JXC47uyTf6q464j2KE+ahnZ/2H2pldbXdZuUsFiCfEikI
         ErYRXlpwSxfSg1ZIAy8eNB470iVTpQ2PK8339MUba40CSisY8lYbmtFbF/ANfi3Pg2Hh
         Kdct8NhhYYyaTwonT5DqNmA2/2MBds66W+LzaQqpHulw7PGzZ/slGZX7//y9Mm2Qbx51
         oMf+Qw9VXQdWIC/kV+OQ4XD2t5z1pSlb5nl9GeGk8bjxNpW6Wkw62eElitk+6JM3nTKZ
         a5RZb/AthfJjkjjoExEb9SDyP8vEKEfv8NqJvko+91g1hCympO99z9xVS2kogH7u0Lvl
         JB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747844177; x=1748448977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJCpgch7Qh9Gr9lPbzv7OjFa/SqUdCi8Z66tY+WUKDE=;
        b=IqjgccHsuyVuYcdETlHwkFX8fNx3ZHybwd50uGupi+XNdVIgG+oZlTs5i0leNcScL+
         PQiE4EJ/uM29OHaRnHSUFBrf1ygEDMfdKYx/7l+6lrpq1QNXm0Fy89WXOy1Wz2rmTl1q
         IACy+zvv3084wTJI5In5/dBnj5SR0GIUPEGi3JMSLGZKMBH+VdS9RoTA6jK4ZXGW7n9O
         to502b9PFibHD0a0j8mu+8gkiPm6AkqGJWkyCXarzhRY+SS+mZSDqMoHx77gGtJUoZPa
         nUyQSRE7PpwOL74P94G8/Z/wj11IZzXFMb17/ul97RZ2FixjUHn8218h/CsUSWyCfjOv
         54XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQNuiM2wzn0WpELObolGmVRK7xIXwcVI5ayBT89w7sfl1Ny3mfp6UGlDERteT/jBPHgGdH1F89YI0GLfXh+bvu@vger.kernel.org
X-Gm-Message-State: AOJu0YzBRNLqvwfD370LLExmVF6HNYZnSjUuP3fyXz+mFO+a3X4QUuDA
	r9exFuWVF67aUyBwGGzJuYmokYz/KjeOgFDlveInqoPzcVYNFki0yeqxgkH1KSRo2fRZ9TWFx0e
	s6LoBXiyDYBtYQsZmtUUBAd9igVGx3rDuMP/PdZ71
X-Gm-Gg: ASbGncvCbDKuIQG6o9wIT0XAlb0rqD3xEYSzgQChOS6P90WKdCe7RpCCF8sBpTIuSza
	7/YnVGTTNbH81kvea+D/PikL7puxyFGU6JjkLY5cIXxIzTSYCjbb41uzbjo6LnjihEPsTy1o4rE
	K3FU7xDZfNW4r7D09vahLT4Wo8oW42RU3yyeGg81E3aaMtOnveT51DPaUkLihxREc4YA2rJh/U
X-Google-Smtp-Source: AGHT+IE1BHZA9asSakhZbrnoU268tJRrUHQKSE6NEXokGwYYxC4DFdzwkaVVN6iDIcc2Pmba14udXYcUaB7qMr+Jd8U=
X-Received: by 2002:a05:6e02:1688:b0:3dc:75c6:c2be with SMTP id
 e9e14a558f8ab-3dc75c6c7camr11804555ab.27.1747844176849; Wed, 21 May 2025
 09:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521135500.677508-1-irogers@google.com> <20250521135500.677508-4-irogers@google.com>
 <3e8b674e-38f7-4212-923d-f53626de69f2@linux.intel.com>
In-Reply-To: <3e8b674e-38f7-4212-923d-f53626de69f2@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 May 2025 09:16:04 -0700
X-Gm-Features: AX0GCFthpE0j2TQjt4JMbuVXTzaJ9LkvZKaOI_Xyfn1pA1-2Im45Ae_Ico_9XBI
Message-ID: <CAP-5=fX5q7rDgBdB+cMH6fTyHBBPyiac7tuv9WJOMcg9OFdq5g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf sort: Use perf_env to set arch sort keys and header
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>, Song Liu <song@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 8:50=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2025-05-21 9:54 a.m., Ian Rogers wrote:
> > Previously arch_support_sort_key and arch_perf_header_entry used a
> > weak symbol to compile as appropriate for x86 and powerpc. A
> > limitation to this is that the handling of a data file could vary in
> > cross-platform development. Change to using the perf_env of the
> > current session to determine the architecture kind and set the sort
> > key and header entries as appropriate.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/powerpc/util/Build   |  1 -
> >  tools/perf/arch/powerpc/util/event.c | 34 ----------------
> >  tools/perf/arch/x86/util/event.c     | 19 ---------
> >  tools/perf/builtin-annotate.c        |  2 +-
> >  tools/perf/builtin-c2c.c             | 53 +++++++++++++-----------
> >  tools/perf/builtin-diff.c            |  2 +-
> >  tools/perf/builtin-report.c          |  2 +-
> >  tools/perf/builtin-top.c             | 16 ++++----
> >  tools/perf/tests/hists_cumulate.c    |  8 ++--
> >  tools/perf/tests/hists_filter.c      |  8 ++--
> >  tools/perf/tests/hists_link.c        |  8 ++--
> >  tools/perf/tests/hists_output.c      | 10 ++---
> >  tools/perf/util/event.h              |  3 --
> >  tools/perf/util/sort.c               | 61 ++++++++++++++++++++--------
> >  tools/perf/util/sort.h               |  5 ++-
> >  15 files changed, 104 insertions(+), 128 deletions(-)
> >  delete mode 100644 tools/perf/arch/powerpc/util/event.c
> >
> > diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/power=
pc/util/Build
> > index ed82715080f9..fdd6a77a3432 100644
> > --- a/tools/perf/arch/powerpc/util/Build
> > +++ b/tools/perf/arch/powerpc/util/Build
> > @@ -5,7 +5,6 @@ perf-util-y +=3D mem-events.o
> >  perf-util-y +=3D pmu.o
> >  perf-util-y +=3D sym-handling.o
> >  perf-util-y +=3D evsel.o
> > -perf-util-y +=3D event.o
> >
> >  perf-util-$(CONFIG_LIBDW) +=3D skip-callchain-idx.o
> >
> > diff --git a/tools/perf/arch/powerpc/util/event.c b/tools/perf/arch/pow=
erpc/util/event.c
> > deleted file mode 100644
> > index 024ac8b54c33..000000000000
> > --- a/tools/perf/arch/powerpc/util/event.c
> > +++ /dev/null
> > @@ -1,34 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -#include <linux/types.h>
> > -#include <linux/string.h>
> > -#include <linux/zalloc.h>
> > -
> > -#include "../../../util/event.h"
> > -#include "../../../util/synthetic-events.h"
> > -#include "../../../util/machine.h"
> > -#include "../../../util/tool.h"
> > -#include "../../../util/map.h"
> > -#include "../../../util/debug.h"
> > -#include "../../../util/sample.h"
> > -
> > -const char *arch_perf_header_entry(const char *se_header)
> > -{
> > -     if (!strcmp(se_header, "Local INSTR Latency"))
> > -             return "Finish Cyc";
> > -     else if (!strcmp(se_header, "INSTR Latency"))
> > -             return "Global Finish_cyc";
> > -     else if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
> > -             return "Dispatch Cyc";
> > -     else if (!strcmp(se_header, "Pipeline Stage Cycle"))
> > -             return "Global Dispatch_cyc";
> > -     return se_header;
> > -}
> > -
> > -int arch_support_sort_key(const char *sort_key)
> > -{
> > -     if (!strcmp(sort_key, "p_stage_cyc"))
> > -             return 1;
> > -     if (!strcmp(sort_key, "local_p_stage_cyc"))
> > -             return 1;
> > -     return 0;
> > -}
> > diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/uti=
l/event.c
> > index 576c1c36046c..3cd384317739 100644
> > --- a/tools/perf/arch/x86/util/event.c
> > +++ b/tools/perf/arch/x86/util/event.c
> > @@ -91,22 +91,3 @@ int perf_event__synthesize_extra_kmaps(const struct =
perf_tool *tool,
> >  }
> >
> >  #endif
> > -
> > -const char *arch_perf_header_entry(const char *se_header)
> > -{
> > -     if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
> > -             return "Local Retire Latency";
> > -     else if (!strcmp(se_header, "Pipeline Stage Cycle"))
> > -             return "Retire Latency";
> > -
> > -     return se_header;
> > -}
> > -
> > -int arch_support_sort_key(const char *sort_key)
> > -{
> > -     if (!strcmp(sort_key, "p_stage_cyc"))
> > -             return 1;
> > -     if (!strcmp(sort_key, "local_p_stage_cyc"))
> > -             return 1;
> > -     return 0;
> > -}
> > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotat=
e.c
> > index 9833c2c82a2f..a2d41614ef5e 100644
> > --- a/tools/perf/builtin-annotate.c
> > +++ b/tools/perf/builtin-annotate.c
> > @@ -947,7 +947,7 @@ int cmd_annotate(int argc, const char **argv)
> >                       annotate_opts.show_br_cntr =3D true;
> >       }
> >
> > -     if (setup_sorting(NULL) < 0)
> > +     if (setup_sorting(/*evlist=3D*/NULL, &annotate.session->header.en=
v) < 0)
> >               usage_with_options(annotate_usage, options);
> >
> >       ret =3D __cmd_annotate(&annotate);
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index e2e257bcc461..324368aabfa2 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -195,12 +195,14 @@ static struct hist_entry_ops c2c_entry_ops =3D {
> >
> >  static int c2c_hists__init(struct c2c_hists *hists,
> >                          const char *sort,
> > -                        int nr_header_lines);
> > +                        int nr_header_lines,
> > +                        struct perf_env *env);
> >
> >  static struct c2c_hists*
> >  he__get_c2c_hists(struct hist_entry *he,
> >                 const char *sort,
> > -               int nr_header_lines)
> > +               int nr_header_lines,
> > +               struct perf_env *env)
> >  {
> >       struct c2c_hist_entry *c2c_he;
> >       struct c2c_hists *hists;
> > @@ -214,7 +216,7 @@ he__get_c2c_hists(struct hist_entry *he,
> >       if (!hists)
> >               return NULL;
> >
> > -     ret =3D c2c_hists__init(hists, sort, nr_header_lines);
> > +     ret =3D c2c_hists__init(hists, sort, nr_header_lines, env);
> >       if (ret) {
> >               free(hists);
> >               return NULL;
> > @@ -350,7 +352,7 @@ static int process_sample_event(const struct perf_t=
ool *tool __maybe_unused,
> >
> >               mi =3D mi_dup;
> >
> > -             c2c_hists =3D he__get_c2c_hists(he, c2c.cl_sort, 2);
> > +             c2c_hists =3D he__get_c2c_hists(he, c2c.cl_sort, 2, machi=
ne->env);
> >               if (!c2c_hists)
> >                       goto free_mi;
> >
> > @@ -1966,7 +1968,8 @@ static struct c2c_fmt *get_format(const char *nam=
e)
> >       return c2c_fmt;
> >  }
> >
> > -static int c2c_hists__init_output(struct perf_hpp_list *hpp_list, char=
 *name)
> > +static int c2c_hists__init_output(struct perf_hpp_list *hpp_list, char=
 *name,
> > +                               struct perf_env *env __maybe_unused)
> >  {
> >       struct c2c_fmt *c2c_fmt =3D get_format(name);
> >       int level =3D 0;
> > @@ -1980,14 +1983,14 @@ static int c2c_hists__init_output(struct perf_h=
pp_list *hpp_list, char *name)
> >       return 0;
> >  }
> >
> > -static int c2c_hists__init_sort(struct perf_hpp_list *hpp_list, char *=
name)
> > +static int c2c_hists__init_sort(struct perf_hpp_list *hpp_list, char *=
name, struct perf_env *env)
> >  {
> >       struct c2c_fmt *c2c_fmt =3D get_format(name);
> >       struct c2c_dimension *dim;
> >
> >       if (!c2c_fmt) {
> >               reset_dimensions();
> > -             return sort_dimension__add(hpp_list, name, NULL, 0);
> > +             return sort_dimension__add(hpp_list, name, /*evlist=3D*/N=
ULL, env, /*level=3D*/0);
> >       }
> >
> >       dim =3D c2c_fmt->dim;
> > @@ -2008,7 +2011,7 @@ static int c2c_hists__init_sort(struct perf_hpp_l=
ist *hpp_list, char *name)
> >                                                                        =
       \
> >               for (tok =3D strtok_r((char *)_list, ", ", &tmp);        =
         \
> >                               tok; tok =3D strtok_r(NULL, ", ", &tmp)) =
{        \
> > -                     ret =3D _fn(hpp_list, tok);                      =
         \
> > +                     ret =3D _fn(hpp_list, tok, env);                 =
         \
> >                       if (ret =3D=3D -EINVAL) {                        =
           \
> >                               pr_err("Invalid --fields key: `%s'", tok)=
;      \
> >                               break;                                   =
       \
> > @@ -2021,7 +2024,8 @@ static int c2c_hists__init_sort(struct perf_hpp_l=
ist *hpp_list, char *name)
> >
> >  static int hpp_list__parse(struct perf_hpp_list *hpp_list,
> >                          const char *output_,
> > -                        const char *sort_)
> > +                        const char *sort_,
> > +                        struct perf_env *env)
> >  {
> >       char *output =3D output_ ? strdup(output_) : NULL;
> >       char *sort   =3D sort_   ? strdup(sort_) : NULL;
> > @@ -2052,7 +2056,8 @@ static int hpp_list__parse(struct perf_hpp_list *=
hpp_list,
> >
> >  static int c2c_hists__init(struct c2c_hists *hists,
> >                          const char *sort,
> > -                        int nr_header_lines)
> > +                        int nr_header_lines,
> > +                        struct perf_env *env)
> >  {
> >       __hists__init(&hists->hists, &hists->list);
> >
> > @@ -2066,15 +2071,16 @@ static int c2c_hists__init(struct c2c_hists *hi=
sts,
> >       /* Overload number of header lines.*/
> >       hists->list.nr_header_lines =3D nr_header_lines;
> >
> > -     return hpp_list__parse(&hists->list, NULL, sort);
> > +     return hpp_list__parse(&hists->list, /*output=3D*/NULL, sort, env=
);
> >  }
> >
> >  static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
> >                            const char *output,
> > -                          const char *sort)
> > +                          const char *sort,
> > +                          struct perf_env *env)
> >  {
> >       perf_hpp__reset_output_field(&c2c_hists->list);
> > -     return hpp_list__parse(&c2c_hists->list, output, sort);
> > +     return hpp_list__parse(&c2c_hists->list, output, sort, env);
> >  }
> >
> >  #define DISPLAY_LINE_LIMIT  0.001
> > @@ -2207,8 +2213,9 @@ static int filter_cb(struct hist_entry *he, void =
*arg __maybe_unused)
> >       return 0;
> >  }
> >
> > -static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unuse=
d)
> > +static int resort_cl_cb(struct hist_entry *he, void *arg)
> >  {
> > +     struct perf_env *env =3D arg;
> >       struct c2c_hist_entry *c2c_he;
> >       struct c2c_hists *c2c_hists;
> >       bool display =3D he__display(he, &c2c.shared_clines_stats);
> > @@ -2222,7 +2229,7 @@ static int resort_cl_cb(struct hist_entry *he, vo=
id *arg __maybe_unused)
> >               c2c_he->cacheline_idx =3D idx++;
> >               calc_width(c2c_he);
> >
> > -             c2c_hists__reinit(c2c_hists, c2c.cl_output, c2c.cl_resort=
);
> > +             c2c_hists__reinit(c2c_hists, c2c.cl_output, c2c.cl_resort=
, env);
> >
> >               hists__collapse_resort(&c2c_hists->hists, NULL);
> >               hists__output_resort_cb(&c2c_hists->hists, NULL, filter_c=
b);
> > @@ -2333,7 +2340,7 @@ static int resort_shared_cl_cb(struct hist_entry =
*he, void *arg __maybe_unused)
> >       return 0;
> >  }
> >
> > -static int hists__iterate_cb(struct hists *hists, hists__resort_cb_t c=
b)
> > +static int hists__iterate_cb(struct hists *hists, hists__resort_cb_t c=
b, void *arg)
> >  {
> >       struct rb_node *next =3D rb_first_cached(&hists->entries);
> >       int ret =3D 0;
> > @@ -2342,7 +2349,7 @@ static int hists__iterate_cb(struct hists *hists,=
 hists__resort_cb_t cb)
> >               struct hist_entry *he;
> >
> >               he =3D rb_entry(next, struct hist_entry, rb_node);
> > -             ret =3D cb(he, NULL);
> > +             ret =3D cb(he, arg);
> >               if (ret)
> >                       break;
> >               next =3D rb_next(&he->rb_node);
> > @@ -2448,7 +2455,7 @@ static void print_cacheline(struct c2c_hists *c2c=
_hists,
> >       hists__fprintf(&c2c_hists->hists, false, 0, 0, 0, out, false);
> >  }
> >
> > -static void print_pareto(FILE *out)
> > +static void print_pareto(FILE *out, struct perf_env *env)
> >  {
> >       struct perf_hpp_list hpp_list;
> >       struct rb_node *nd;
> > @@ -2473,7 +2480,7 @@ static void print_pareto(FILE *out)
> >                           "dcacheline";
> >
> >       perf_hpp_list__init(&hpp_list);
> > -     ret =3D hpp_list__parse(&hpp_list, cl_output, NULL);
> > +     ret =3D hpp_list__parse(&hpp_list, cl_output, /*evlist=3D*/NULL, =
env);
> >
> >       if (WARN_ONCE(ret, "failed to setup sort entries\n"))
> >               return;
> > @@ -2538,7 +2545,7 @@ static void perf_c2c__hists_fprintf(FILE *out, st=
ruct perf_session *session)
> >       fprintf(out, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D\n");
> >       fprintf(out, "#\n");
> >
> > -     print_pareto(out);
> > +     print_pareto(out, &session->header.env);
> >  }
> >
> >  #ifdef HAVE_SLANG_SUPPORT
> > @@ -3095,7 +3102,7 @@ static int perf_c2c__report(int argc, const char =
**argv)
> >               goto out_session;
> >       }
> >
> > -     err =3D c2c_hists__init(&c2c.hists, "dcacheline", 2);
> > +     err =3D c2c_hists__init(&c2c.hists, "dcacheline", 2, &session->he=
ader.env);
> >       if (err) {
> >               pr_debug("Failed to initialize hists\n");
> >               goto out_session;
> > @@ -3179,13 +3186,13 @@ static int perf_c2c__report(int argc, const cha=
r **argv)
> >       else if (c2c.display =3D=3D DISPLAY_SNP_PEER)
> >               sort_str =3D "tot_peer";
> >
> > -     c2c_hists__reinit(&c2c.hists, output_str, sort_str);
> > +     c2c_hists__reinit(&c2c.hists, output_str, sort_str, &session->hea=
der.env);
> >
> >       ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting..."=
);
> >
> >       hists__collapse_resort(&c2c.hists.hists, NULL);
> >       hists__output_resort_cb(&c2c.hists.hists, &prog, resort_shared_cl=
_cb);
> > -     hists__iterate_cb(&c2c.hists.hists, resort_cl_cb);
> > +     hists__iterate_cb(&c2c.hists.hists, resort_cl_cb, &session->heade=
r.env);
> >
> >       ui_progress__finish();
> >
> > diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> > index ae490d58af92..f6735cf02329 100644
> > --- a/tools/perf/builtin-diff.c
> > +++ b/tools/perf/builtin-diff.c
> > @@ -2003,7 +2003,7 @@ int cmd_diff(int argc, const char **argv)
> >               sort__mode =3D SORT_MODE__DIFF;
> >       }
> >
> > -     if (setup_sorting(NULL) < 0)
> > +     if (setup_sorting(/*evlist=3D*/NULL, &data__files[0].session->hea=
der.env) < 0)
> >               usage_with_options(diff_usage, options);
> >
> >       setup_pager();
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index f0299c7ee025..8be6e7c3bd22 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -1776,7 +1776,7 @@ int cmd_report(int argc, const char **argv)
> >       }
> >
> >       if ((last_key !=3D K_SWITCH_INPUT_DATA && last_key !=3D K_RELOAD)=
 &&
> > -         (setup_sorting(session->evlist) < 0)) {
> > +         (setup_sorting(session->evlist, &session->header.env) < 0)) {
> >               if (sort_order)
> >                       parse_options_usage(report_usage, options, "s", 1=
);
> >               if (field_order)
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index 7b6cde87d2af..13ef0d188a96 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1747,7 +1747,14 @@ int cmd_top(int argc, const char **argv)
> >
> >       setup_browser(false);
> >
> > -     if (setup_sorting(top.evlist) < 0) {
> > +     top.session =3D perf_session__new(/*data=3D*/NULL, /*tool=3D*/NUL=
L);
> > +     if (IS_ERR(top.session)) {
> > +             status =3D PTR_ERR(top.session);
> > +             top.session =3D NULL;
> > +             goto out_delete_evlist;
> > +     }
> > +
> > +     if (setup_sorting(top.evlist, &top.session->header.env) < 0) {
>
> I doubt a valide env can be got in perf_session__new(), since there is
> no perf.data in perf top.
> Maybe just need to invoke the perf_env__raw_arch() instead to fill the
> env->arch.

I think the current code is making things harder than it should be, we
should work away from perf_env__arch and strings, instead using EM_
values which we can default to EM_HOST avoiding any runtime costs.
Looking at perf_env__arch:
```
const char *perf_env__arch(struct perf_env *env)
{
        char *arch_name;

        if (!env || !env->arch) { /* Assume local operation */
                static struct utsname uts =3D { .machine[0] =3D '\0', };
                if (uts.machine[0] =3D=3D '\0' && uname(&uts) < 0)
                        return NULL;
                arch_name =3D uts.machine;
        } else
                arch_name =3D env->arch;

        return normalize_arch(arch_name);
}
```
in this case env->arch =3D=3D NULL and so the uname machine will be used.
For perf_env__raw_arch the behavior is similar but it populates the
env:
```
static int perf_env__read_arch(struct perf_env *env)
{
        struct utsname uts;

        if (env->arch)
                return 0;

        if (!uname(&uts))
                env->arch =3D strdup(uts.machine);

        return env->arch ? 0 : -ENOMEM;
}

const char *perf_env__raw_arch(struct perf_env *env)
{
        return env && !perf_env__read_arch(env) ? env->arch : "unknown";
}
```
Aside from caching the arch, the main difference is that
normalize_arch isn't called. Not having normalize_arch means the code
in arch_support_sort_key and arch_perf_header_entry would need to
handle strings "ppc" as well as "powerpc", "i386" as well as "x86",
etc. As I'd prefer not handle all those cases I think the way the code
is is best given how the env code is currently structured.

Thanks,
Ian

> Thanks,
> Kan
>
> >               if (sort_order)
> >                       parse_options_usage(top_usage, options, "s", 1);
> >               if (field_order)
> > @@ -1820,13 +1827,6 @@ int cmd_top(int argc, const char **argv)
> >               signal(SIGWINCH, winch_sig);
> >       }
> >
> > -     top.session =3D perf_session__new(NULL, NULL);
> > -     if (IS_ERR(top.session)) {
> > -             status =3D PTR_ERR(top.session);
> > -             top.session =3D NULL;
> > -             goto out_delete_evlist;
> > -     }
> > -
> >       if (!evlist__needs_bpf_sb_event(top.evlist))
> >               top.record_opts.no_bpf_event =3D true;
> >
> > diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists=
_cumulate.c
> > index 1e0f5a310fd5..3eb9ef8d7ec6 100644
> > --- a/tools/perf/tests/hists_cumulate.c
> > +++ b/tools/perf/tests/hists_cumulate.c
> > @@ -295,7 +295,7 @@ static int test1(struct evsel *evsel, struct machin=
e *machine)
> >       symbol_conf.cumulate_callchain =3D false;
> >       evsel__reset_sample_bit(evsel, CALLCHAIN);
> >
> > -     setup_sorting(NULL);
> > +     setup_sorting(/*evlist=3D*/NULL, machine->env);
> >       callchain_register_param(&callchain_param);
> >
> >       err =3D add_hist_entries(hists, machine);
> > @@ -442,7 +442,7 @@ static int test2(struct evsel *evsel, struct machin=
e *machine)
> >       symbol_conf.cumulate_callchain =3D false;
> >       evsel__set_sample_bit(evsel, CALLCHAIN);
> >
> > -     setup_sorting(NULL);
> > +     setup_sorting(/*evlist=3D*/NULL, machine->env);
> >       callchain_register_param(&callchain_param);
> >
> >       err =3D add_hist_entries(hists, machine);
> > @@ -500,7 +500,7 @@ static int test3(struct evsel *evsel, struct machin=
e *machine)
> >       symbol_conf.cumulate_callchain =3D true;
> >       evsel__reset_sample_bit(evsel, CALLCHAIN);
> >
> > -     setup_sorting(NULL);
> > +     setup_sorting(/*evlist=3D*/NULL, machine->env);
> >       callchain_register_param(&callchain_param);
> >
> >       err =3D add_hist_entries(hists, machine);
> > @@ -684,7 +684,7 @@ static int test4(struct evsel *evsel, struct machin=
e *machine)
> >       symbol_conf.cumulate_callchain =3D true;
> >       evsel__set_sample_bit(evsel, CALLCHAIN);
> >
> > -     setup_sorting(NULL);
> > +     setup_sorting(/*evlist=3D*/NULL, machine->env);
> >
> >       callchain_param =3D callchain_param_default;
> >       callchain_register_param(&callchain_param);
> > diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_f=
ilter.c
> > index 4b2e4f2fbe48..1cebd20cc91c 100644
> > --- a/tools/perf/tests/hists_filter.c
> > +++ b/tools/perf/tests/hists_filter.c
> > @@ -131,10 +131,6 @@ static int test__hists_filter(struct test_suite *t=
est __maybe_unused, int subtes
> >               goto out;
> >       err =3D TEST_FAIL;
> >
> > -     /* default sort order (comm,dso,sym) will be used */
> > -     if (setup_sorting(NULL) < 0)
> > -             goto out;
> > -
> >       machines__init(&machines);
> >
> >       /* setup threads/dso/map/symbols also */
> > @@ -145,6 +141,10 @@ static int test__hists_filter(struct test_suite *t=
est __maybe_unused, int subtes
> >       if (verbose > 1)
> >               machine__fprintf(machine, stderr);
> >
> > +     /* default sort order (comm,dso,sym) will be used */
> > +     if (setup_sorting(evlist, machine->env) < 0)
> > +             goto out;
> > +
> >       /* process sample events */
> >       err =3D add_hist_entries(evlist, machine);
> >       if (err < 0)
> > diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_lin=
k.c
> > index 5b6f1e883466..996f5f0b3bd1 100644
> > --- a/tools/perf/tests/hists_link.c
> > +++ b/tools/perf/tests/hists_link.c
> > @@ -303,10 +303,6 @@ static int test__hists_link(struct test_suite *tes=
t __maybe_unused, int subtest
> >               goto out;
> >
> >       err =3D TEST_FAIL;
> > -     /* default sort order (comm,dso,sym) will be used */
> > -     if (setup_sorting(NULL) < 0)
> > -             goto out;
> > -
> >       machines__init(&machines);
> >
> >       /* setup threads/dso/map/symbols also */
> > @@ -317,6 +313,10 @@ static int test__hists_link(struct test_suite *tes=
t __maybe_unused, int subtest
> >       if (verbose > 1)
> >               machine__fprintf(machine, stderr);
> >
> > +     /* default sort order (comm,dso,sym) will be used */
> > +     if (setup_sorting(evlist, machine->env) < 0)
> > +             goto out;
> > +
> >       /* process sample events */
> >       err =3D add_hist_entries(evlist, machine);
> >       if (err < 0)
> > diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_o=
utput.c
> > index 33b5cc8352a7..ee5ec8bda60e 100644
> > --- a/tools/perf/tests/hists_output.c
> > +++ b/tools/perf/tests/hists_output.c
> > @@ -146,7 +146,7 @@ static int test1(struct evsel *evsel, struct machin=
e *machine)
> >       field_order =3D NULL;
> >       sort_order =3D NULL; /* equivalent to sort_order =3D "comm,dso,sy=
m" */
> >
> > -     setup_sorting(NULL);
> > +     setup_sorting(/*evlist=3D*/NULL, machine->env);
> >
> >       /*
> >        * expected output:
> > @@ -248,7 +248,7 @@ static int test2(struct evsel *evsel, struct machin=
e *machine)
> >       field_order =3D "overhead,cpu";
> >       sort_order =3D "pid";
> >
> > -     setup_sorting(NULL);
> > +     setup_sorting(/*evlist=3D*/NULL, machine->env);
> >
> >       /*
> >        * expected output:
> > @@ -304,7 +304,7 @@ static int test3(struct evsel *evsel, struct machin=
e *machine)
> >       field_order =3D "comm,overhead,dso";
> >       sort_order =3D NULL;
> >
> > -     setup_sorting(NULL);
> > +     setup_sorting(/*evlist=3D*/NULL, machine->env);
> >
> >       /*
> >        * expected output:
> > @@ -378,7 +378,7 @@ static int test4(struct evsel *evsel, struct machin=
e *machine)
> >       field_order =3D "dso,sym,comm,overhead,dso";
> >       sort_order =3D "sym";
> >
> > -     setup_sorting(NULL);
> > +     setup_sorting(/*evlist=3D*/NULL, machine->env);
> >
> >       /*
> >        * expected output:
> > @@ -480,7 +480,7 @@ static int test5(struct evsel *evsel, struct machin=
e *machine)
> >       field_order =3D "cpu,pid,comm,dso,sym";
> >       sort_order =3D "dso,pid";
> >
> > -     setup_sorting(NULL);
> > +     setup_sorting(/*evlist=3D*/NULL, machine->env);
> >
> >       /*
> >        * expected output:
> > diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> > index 119bce37f4fd..3b97a31736c5 100644
> > --- a/tools/perf/util/event.h
> > +++ b/tools/perf/util/event.h
> > @@ -390,9 +390,6 @@ extern unsigned int proc_map_timeout;
> >  #define PAGE_SIZE_NAME_LEN   32
> >  char *get_page_size_name(u64 size, char *str);
> >
> > -const char *arch_perf_header_entry(const char *se_header);
> > -int arch_support_sort_key(const char *sort_key);
> > -
> >  static inline bool perf_event_header__cpumode_is_guest(u8 cpumode)
> >  {
> >       return cpumode =3D=3D PERF_RECORD_MISC_GUEST_KERNEL ||
> > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > index dda4ef0b5a73..ccab10cd24a5 100644
> > --- a/tools/perf/util/sort.c
> > +++ b/tools/perf/util/sort.c
> > @@ -2526,19 +2526,44 @@ struct sort_dimension {
> >       int                     taken;
> >  };
> >
> > -int __weak arch_support_sort_key(const char *sort_key __maybe_unused)
> > +static int arch_support_sort_key(const char *sort_key, struct perf_env=
 *env)
> >  {
> > +     const char *arch =3D perf_env__arch(env);
> > +
> > +     if (!strcmp("x86", arch) || !strcmp("powerpc", arch)) {
> > +             if (!strcmp(sort_key, "p_stage_cyc"))
> > +                     return 1;
> > +             if (!strcmp(sort_key, "local_p_stage_cyc"))
> > +                     return 1;
> > +     }
> >       return 0;
> >  }
> >
> > -const char * __weak arch_perf_header_entry(const char *se_header)
> > -{
> > +static const char *arch_perf_header_entry(const char *se_header, struc=
t perf_env *env)
> > +{
> > +     const char *arch =3D perf_env__arch(env);
> > +
> > +     if (!strcmp("x86", arch)) {
> > +             if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
> > +                     return "Local Retire Latency";
> > +             else if (!strcmp(se_header, "Pipeline Stage Cycle"))
> > +                     return "Retire Latency";
> > +     } else if (!strcmp("powerpc", arch)) {
> > +             if (!strcmp(se_header, "Local INSTR Latency"))
> > +                     return "Finish Cyc";
> > +             else if (!strcmp(se_header, "INSTR Latency"))
> > +                     return "Global Finish_cyc";
> > +             else if (!strcmp(se_header, "Local Pipeline Stage Cycle")=
)
> > +                     return "Dispatch Cyc";
> > +             else if (!strcmp(se_header, "Pipeline Stage Cycle"))
> > +                     return "Global Dispatch_cyc";
> > +     }
> >       return se_header;
> >  }
> >
> > -static void sort_dimension_add_dynamic_header(struct sort_dimension *s=
d)
> > +static void sort_dimension_add_dynamic_header(struct sort_dimension *s=
d, struct perf_env *env)
> >  {
> > -     sd->entry->se_header =3D arch_perf_header_entry(sd->entry->se_hea=
der);
> > +     sd->entry->se_header =3D arch_perf_header_entry(sd->entry->se_hea=
der, env);
> >  }
> >
> >  #define DIM(d, n, func) [d] =3D { .name =3D n, .entry =3D &(func) }
> > @@ -3590,7 +3615,7 @@ int hpp_dimension__add_output(unsigned col, bool =
implicit)
> >  }
> >
> >  int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
> > -                     struct evlist *evlist,
> > +                     struct evlist *evlist, struct perf_env *env,
> >                       int level)
> >  {
> >       unsigned int i, j;
> > @@ -3603,7 +3628,7 @@ int sort_dimension__add(struct perf_hpp_list *lis=
t, const char *tok,
> >        */
> >       for (j =3D 0; j < ARRAY_SIZE(arch_specific_sort_keys); j++) {
> >               if (!strcmp(arch_specific_sort_keys[j], tok) &&
> > -                             !arch_support_sort_key(tok)) {
> > +                 !arch_support_sort_key(tok, env)) {
> >                       return 0;
> >               }
> >       }
> > @@ -3616,7 +3641,7 @@ int sort_dimension__add(struct perf_hpp_list *lis=
t, const char *tok,
> >
> >               for (j =3D 0; j < ARRAY_SIZE(dynamic_headers); j++) {
> >                       if (sd->name && !strcmp(dynamic_headers[j], sd->n=
ame))
> > -                             sort_dimension_add_dynamic_header(sd);
> > +                             sort_dimension_add_dynamic_header(sd, env=
);
> >               }
> >
> >               if (sd->entry =3D=3D &sort_parent && parent_pattern) {
> > @@ -3712,13 +3737,13 @@ int sort_dimension__add(struct perf_hpp_list *l=
ist, const char *tok,
> >  }
> >
> >  /* This should match with sort_dimension__add() above */
> > -static bool is_hpp_sort_key(const char *key)
> > +static bool is_hpp_sort_key(const char *key, struct perf_env *env)
> >  {
> >       unsigned i;
> >
> >       for (i =3D 0; i < ARRAY_SIZE(arch_specific_sort_keys); i++) {
> >               if (!strcmp(arch_specific_sort_keys[i], key) &&
> > -                 !arch_support_sort_key(key)) {
> > +                 !arch_support_sort_key(key, env)) {
> >                       return false;
> >               }
> >       }
> > @@ -3740,7 +3765,7 @@ static bool is_hpp_sort_key(const char *key)
> >  }
> >
> >  static int setup_sort_list(struct perf_hpp_list *list, char *str,
> > -                        struct evlist *evlist)
> > +                        struct evlist *evlist, struct perf_env *env)
> >  {
> >       char *tmp, *tok;
> >       int ret =3D 0;
> > @@ -3769,7 +3794,7 @@ static int setup_sort_list(struct perf_hpp_list *=
list, char *str,
> >               }
> >
> >               if (*tok) {
> > -                     if (is_hpp_sort_key(tok)) {
> > +                     if (is_hpp_sort_key(tok, env)) {
> >                               /* keep output (hpp) sort keys in the sam=
e level */
> >                               if (prev_was_hpp) {
> >                                       bool next_same =3D (level =3D=3D =
next_level);
> > @@ -3782,7 +3807,7 @@ static int setup_sort_list(struct perf_hpp_list *=
list, char *str,
> >                               prev_was_hpp =3D false;
> >                       }
> >
> > -                     ret =3D sort_dimension__add(list, tok, evlist, le=
vel);
> > +                     ret =3D sort_dimension__add(list, tok, evlist, en=
v, level);
> >                       if (ret =3D=3D -EINVAL) {
> >                               if (!cacheline_size() && !strncasecmp(tok=
, "dcacheline", strlen(tok)))
> >                                       ui__error("The \"dcacheline\" --s=
ort key needs to know the cacheline size and it couldn't be determined on t=
his system");
> > @@ -3911,7 +3936,7 @@ static char *setup_overhead(char *keys)
> >       return keys;
> >  }
> >
> > -static int __setup_sorting(struct evlist *evlist)
> > +static int __setup_sorting(struct evlist *evlist, struct perf_env *env=
)
> >  {
> >       char *str;
> >       const char *sort_keys;
> > @@ -3951,7 +3976,7 @@ static int __setup_sorting(struct evlist *evlist)
> >               }
> >       }
> >
> > -     ret =3D setup_sort_list(&perf_hpp_list, str, evlist);
> > +     ret =3D setup_sort_list(&perf_hpp_list, str, evlist, env);
> >
> >       free(str);
> >       return ret;
> > @@ -4187,16 +4212,16 @@ static int __setup_output_field(void)
> >       return ret;
> >  }
> >
> > -int setup_sorting(struct evlist *evlist)
> > +int setup_sorting(struct evlist *evlist, struct perf_env *env)
> >  {
> >       int err;
> >
> > -     err =3D __setup_sorting(evlist);
> > +     err =3D __setup_sorting(evlist, env);
> >       if (err < 0)
> >               return err;
> >
> >       if (parent_pattern !=3D default_parent_pattern) {
> > -             err =3D sort_dimension__add(&perf_hpp_list, "parent", evl=
ist, -1);
> > +             err =3D sort_dimension__add(&perf_hpp_list, "parent", evl=
ist, env, -1);
> >               if (err < 0)
> >                       return err;
> >       }
> > diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> > index a742ab7f3c67..d7787958e06b 100644
> > --- a/tools/perf/util/sort.h
> > +++ b/tools/perf/util/sort.h
> > @@ -6,6 +6,7 @@
> >  #include "hist.h"
> >
> >  struct option;
> > +struct perf_env;
> >
> >  extern regex_t parent_regex;
> >  extern const char *sort_order;
> > @@ -130,7 +131,7 @@ extern struct sort_entry sort_thread;
> >
> >  struct evlist;
> >  struct tep_handle;
> > -int setup_sorting(struct evlist *evlist);
> > +int setup_sorting(struct evlist *evlist, struct perf_env *env);
> >  int setup_output_field(void);
> >  void reset_output_field(void);
> >  void sort__setup_elide(FILE *fp);
> > @@ -145,7 +146,7 @@ bool is_strict_order(const char *order);
> >  int hpp_dimension__add_output(unsigned col, bool implicit);
> >  void reset_dimensions(void);
> >  int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
> > -                     struct evlist *evlist,
> > +                     struct evlist *evlist, struct perf_env *env,
> >                       int level);
> >  int output_field_add(struct perf_hpp_list *list, const char *tok, int =
*level);
> >  int64_t
>
