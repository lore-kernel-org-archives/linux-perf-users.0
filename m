Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844127E7FE
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747843086; cv=none; b=KsP2I/uSFeERTVLEbkeyN0M9gKlF6fc5GQUkxyE9HPYSQPsldey1yc9ODKVwqsImEyeOu2S1oa1wFhZq8IKiNAccnZKrY/zbQ3RVzDdhE5bJ1FlAGgQLePJjFGcrIakR1QLSRLnUAgk+J0WFp3uY2yFInAuvQwJVaxh7yDIn38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747843086; c=relaxed/simple;
	bh=lqQd6mMKlygw3vDPlDPoI90H695zAIr9JGSIXSMHC4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O61CX/uiHi3TzYzjZJ4vyqQPfoauvz8CUIM6EHv7K8JBXZhuj0W7LAEIlKfk1r8VqlVElZh03rnMOvZ2zfKt3BeB/FxQ0Aae2g3rvopBp/PpaGc2X0JXBmvO1taSpbIOXcPnnBuXL2KHDfHRigpI7x93xgjB3qa5vVIh6ojLIN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OQd70yUV; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQd70yUV"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so912995ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747843083; x=1748447883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRxw8k6nh67R5Eo3YBtf36BoHaxgBuen2mFom6SQ/o4=;
        b=OQd70yUV2yxHQiQzkceUccENnXI/uXy1xpLT2btkECSlIcUAQjfj/LpKlTBg6W8z1N
         SKFkELIAnvbhjJRAbNgh2MbfGPpf6qWBLGuT9EhoMe1oxSOhlucSPOycQJn+hmNROT4O
         kPnbJ7oBxH5Qyw9cxzE6Yz58gv0PZqGSwGCnvnjUdmg07WPGz/Pk8khV7BGXKtHE3Hcn
         YPLI0NKmy8K35CU/vm6b7L38WhhP43bpxaS5CGkteVF66tx3wW2H8l7vWYbcTafV6eZS
         gs7azasneDOJgYTUu4a/XbdZu89ejyZQQix/SiCNthnWWuOiNXOJm66Fd3L3YMiUxTVu
         IfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747843083; x=1748447883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRxw8k6nh67R5Eo3YBtf36BoHaxgBuen2mFom6SQ/o4=;
        b=EDfF9xFnj1tSUklDFQ1jrKOmtB0FT0xi4VRGKNv9QxSoZDG32+0phCuoNvG4Hd8L7m
         R04uZ0zyO9lAkv5BR68KDmdYPdzLPWmMq/kPUCVNAqOaOA0VuduWJBQ/90zPEtDovGU3
         gjGs1uEACsybkUknVVsCIOgSOG+0kVKa8uaFV8XvIneGyxj0N77MjsicueGMULbYuS3U
         BDUiAVgyJRipf5SPKM5KAGhgjRgmMQG/hxJw1Kn5kJWLUAQo364iY8GqIKLgLbCypIUL
         vDXzOY8+jgp75Ed+jPQREQFq23ALaSLkxoBGVPimt5k/QgwcPqs0RSIxanN4AMAEtBPA
         CDSg==
X-Forwarded-Encrypted: i=1; AJvYcCVg1tbHoizcf4iSVy9ucc+Xu0l3z20KOgQe0lmgRhyKg+7/i81AVz1nAlMY1KxmTHvAeZM4l3om+6IsBnXwwSS/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Fc/XwsJu6SzsbTjUYx0MdLTk7S17BnuuEtmHTtYK4k4R95wr
	FPXSBCeYp72fTC5T1BUA9/Su8GTOjP70XwZG24l8oLed06u+7x0t9d4G8hruYHg2Wec7J/OFaX1
	gV/nXNM7ULDQ4jHTyF2bZcUgqgd4aj3BnQFJ+EivI
X-Gm-Gg: ASbGncuTPSzu6d++kyTeIlMDqwJlPVheJtQHhPDOd5+GCZFSpjLski538jeX0H+0PB3
	b/fvxmtTZuh/xtKJTPC32gI49tU3Om21JqTGFrDLhC0gSfDJS022UW94zr+8dZcKEJiLl/Lozki
	WW4FK9XPt6uFm+MdK5RHnB3xQ+nBw6Ap/pMWhXMPV3gusZyFy3sjXobJ8lRBMOlBLo7C1JOymJ
X-Google-Smtp-Source: AGHT+IG4KQLdizYOyOwyg0fiFlY5Aj4gB/5mAyT7fnqIDKrWMu2AQ4FLQzekHsNsl721m5/0bvucvEPJ7dS5cRwjBl0=
X-Received: by 2002:a05:6e02:12c5:b0:3d1:7948:faa2 with SMTP id
 e9e14a558f8ab-3dc5e6151b3mr17197795ab.7.1747843082685; Wed, 21 May 2025
 08:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521135500.677508-1-irogers@google.com> <20250521135500.677508-2-irogers@google.com>
 <14a4c1e3-11e1-43d2-933b-10d4b2c155a1@linux.intel.com>
In-Reply-To: <14a4c1e3-11e1-43d2-933b-10d4b2c155a1@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 May 2025 08:57:50 -0700
X-Gm-Features: AX0GCFujZDwMRg_NpxE72Eepx4H_OVuKFxGpfPifRIFbYMqDJZ8FLwnvt7H6ppg
Message-ID: <CAP-5=fUQ0gnOaFHNwjB50q3iEDpwdVbAH0rO9rfHk3n-SYPb7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf sample: Remove arch notion of sample parsing
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

On Wed, May 21, 2025 at 8:42=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2025-05-21 9:54 a.m., Ian Rogers wrote:
> > By definition arch sample parsing and synthesis will inhibit certain
> > kinds of cross-platform record then analysis (report, script,
> > etc.). Remove arch_perf_parse_sample_weight and
> > arch_perf_synthesize_sample_weight replacing with a common
> > implementation. Combine perf_sample p_stage_cyc and retire_lat to
> > capture the differing uses regardless of compiled for architecture.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/powerpc/util/event.c       | 26 ---------------------
> >  tools/perf/arch/x86/tests/sample-parsing.c |  4 ++--
> >  tools/perf/arch/x86/util/event.c           | 27 ----------------------
> >  tools/perf/builtin-script.c                |  2 +-
> >  tools/perf/util/dlfilter.c                 |  2 +-
> >  tools/perf/util/event.h                    |  2 --
> >  tools/perf/util/evsel.c                    | 17 ++++++++++----
> >  tools/perf/util/hist.c                     |  4 ++--
> >  tools/perf/util/hist.h                     |  2 +-
> >  tools/perf/util/intel-tpebs.c              |  4 ++--
> >  tools/perf/util/sample.h                   |  5 +---
> >  tools/perf/util/session.c                  |  2 +-
> >  tools/perf/util/sort.c                     |  6 ++---
> >  tools/perf/util/synthetic-events.c         | 10 ++++++--
> >  14 files changed, 34 insertions(+), 79 deletions(-)
> >
> > diff --git a/tools/perf/arch/powerpc/util/event.c b/tools/perf/arch/pow=
erpc/util/event.c
> > index 77d8cc2b5691..024ac8b54c33 100644
> > --- a/tools/perf/arch/powerpc/util/event.c
> > +++ b/tools/perf/arch/powerpc/util/event.c
> > @@ -11,32 +11,6 @@
> >  #include "../../../util/debug.h"
> >  #include "../../../util/sample.h"
> >
> > -void arch_perf_parse_sample_weight(struct perf_sample *data,
> > -                                const __u64 *array, u64 type)
> > -{
> > -     union perf_sample_weight weight;
> > -
> > -     weight.full =3D *array;
> > -     if (type & PERF_SAMPLE_WEIGHT)
> > -             data->weight =3D weight.full;
> > -     else {
> > -             data->weight =3D weight.var1_dw;
> > -             data->ins_lat =3D weight.var2_w;
> > -             data->p_stage_cyc =3D weight.var3_w;
> > -     }
> > -}
> > -
> > -void arch_perf_synthesize_sample_weight(const struct perf_sample *data=
,
> > -                                     __u64 *array, u64 type)
> > -{
> > -     *array =3D data->weight;
> > -
> > -     if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
> > -             *array &=3D 0xffffffff;
> > -             *array |=3D ((u64)data->ins_lat << 32);
> > -     }
> > -}
> > -
> >  const char *arch_perf_header_entry(const char *se_header)
> >  {
> >       if (!strcmp(se_header, "Local INSTR Latency"))
> > diff --git a/tools/perf/arch/x86/tests/sample-parsing.c b/tools/perf/ar=
ch/x86/tests/sample-parsing.c
> > index a061e8619267..95d8f7f1d2fb 100644
> > --- a/tools/perf/arch/x86/tests/sample-parsing.c
> > +++ b/tools/perf/arch/x86/tests/sample-parsing.c
> > @@ -29,7 +29,7 @@ static bool samples_same(const struct perf_sample *s1=
,
> >  {
> >       if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
> >               COMP(ins_lat);
> > -             COMP(retire_lat);
> > +             COMP(p_stage_cyc_or_retire_lat);
> >       }
> >
> >       return true;
> > @@ -50,7 +50,7 @@ static int do_test(u64 sample_type)
> >       struct perf_sample sample =3D {
> >               .weight         =3D 101,
> >               .ins_lat        =3D 102,
> > -             .retire_lat     =3D 103,
> > +             .p_stage_cyc_or_retire_lat =3D 103,
> >       };
> >       struct perf_sample sample_out;
> >       size_t i, sz, bufsz;
> > diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/uti=
l/event.c
> > index a0400707180c..576c1c36046c 100644
> > --- a/tools/perf/arch/x86/util/event.c
> > +++ b/tools/perf/arch/x86/util/event.c
> > @@ -92,33 +92,6 @@ int perf_event__synthesize_extra_kmaps(const struct =
perf_tool *tool,
> >
> >  #endif
> >
> > -void arch_perf_parse_sample_weight(struct perf_sample *data,
> > -                                const __u64 *array, u64 type)
> > -{
> > -     union perf_sample_weight weight;
> > -
> > -     weight.full =3D *array;
> > -     if (type & PERF_SAMPLE_WEIGHT)
> > -             data->weight =3D weight.full;
> > -     else {
> > -             data->weight =3D weight.var1_dw;
> > -             data->ins_lat =3D weight.var2_w;
> > -             data->retire_lat =3D weight.var3_w;
> > -     }
> > -}
> > -
> > -void arch_perf_synthesize_sample_weight(const struct perf_sample *data=
,
> > -                                     __u64 *array, u64 type)
> > -{
> > -     *array =3D data->weight;
> > -
> > -     if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
> > -             *array &=3D 0xffffffff;
> > -             *array |=3D ((u64)data->ins_lat << 32);
> > -             *array |=3D ((u64)data->retire_lat << 48);
> > -     }
> > -}
> > -
> >  const char *arch_perf_header_entry(const char *se_header)
> >  {
> >       if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 6c3bf74dd78c..c02c435e0f0b 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -2251,7 +2251,7 @@ static void process_event(struct perf_script *scr=
ipt,
> >               fprintf(fp, "%16" PRIu16, sample->ins_lat);
> >
> >       if (PRINT_FIELD(RETIRE_LAT))
> > -             fprintf(fp, "%16" PRIu16, sample->retire_lat);
> > +             fprintf(fp, "%16" PRIu16, sample->p_stage_cyc_or_retire_l=
at);
> >
> >       if (PRINT_FIELD(CGROUP)) {
> >               const char *cgrp_name;
> > diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
> > index ddacef881af2..7e61ddfa66b8 100644
> > --- a/tools/perf/util/dlfilter.c
> > +++ b/tools/perf/util/dlfilter.c
> > @@ -526,7 +526,7 @@ int dlfilter__do_filter_event(struct dlfilter *d,
> >       ASSIGN(period);
> >       ASSIGN(weight);
> >       ASSIGN(ins_lat);
> > -     ASSIGN(p_stage_cyc);
> > +     d_sample.p_stage_cyc =3D sample->p_stage_cyc_or_retire_lat;
>
> Can you please move it out of the ASSIGN() area? Maybe right after
> d_sample.size  =3D sizeof(d_sample);.
> It looks strange to insert a non-macro assignment here.

Ok. Will fix in v3.

>
> >       ASSIGN(transaction);
> >       ASSIGN(insn_cnt);
> >       ASSIGN(cyc_cnt);
> > diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> > index 664bf39567ce..119bce37f4fd 100644
> > --- a/tools/perf/util/event.h
> > +++ b/tools/perf/util/event.h
> > @@ -390,8 +390,6 @@ extern unsigned int proc_map_timeout;
> >  #define PAGE_SIZE_NAME_LEN   32
> >  char *get_page_size_name(u64 size, char *str);
> >
> > -void arch_perf_parse_sample_weight(struct perf_sample *data, const __u=
64 *array, u64 type);
> > -void arch_perf_synthesize_sample_weight(const struct perf_sample *data=
, __u64 *array, u64 type);
> >  const char *arch_perf_header_entry(const char *se_header);
> >  int arch_support_sort_key(const char *sort_key);
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index d55482f094bf..097ab98bb81a 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2846,11 +2846,18 @@ perf_event__check_size(union perf_event *event,=
 unsigned int sample_size)
> >       return 0;
> >  }
> >
> > -void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
> > -                                       const __u64 *array,
> > -                                       u64 type __maybe_unused)
> > +static void perf_parse_sample_weight(struct perf_sample *data, const _=
_u64 *array, u64 type)
> >  {
> > -     data->weight =3D *array;
> > +     union perf_sample_weight weight;
> > +
> > +     weight.full =3D *array;
> > +     if (type & PERF_SAMPLE_WEIGHT) {
> > +             data->weight =3D weight.full;
> > +     } else {
> > +             data->weight =3D weight.var1_dw;
> > +             data->ins_lat =3D weight.var2_w;
> > +             data->p_stage_cyc_or_retire_lat =3D weight.var3_w;
> > +     }
> >  }
> >
>
> It works for X86, but I'm not sure other ARCHs.
> Since the PERF_SAMPLE_WEIGHT_STRUCT is newly added type, should it be
> safer to do the below?
>         if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
>                 data->weight =3D weight.var1_dw;
>                 data->ins_lat =3D weight.var2_w;
>                 data->p_stage_cyc_or_retire_lat =3D weight.var3_w;
>         } else
>                 data->weight =3D weight.full;
>
> The default behavior is always data->weight =3D weight.full; unless an
> ARCH apply the new type PERF_SAMPLE_WEIGHT_STRUCT.

Sure. I don't think it will change any of the behavior.

> >  u64 evsel__bitfield_swap_branch_flags(u64 value)
> > @@ -3236,7 +3243,7 @@ int evsel__parse_sample(struct evsel *evsel, unio=
n perf_event *event,
> >
> >       if (type & PERF_SAMPLE_WEIGHT_TYPE) {
> >               OVERFLOW_CHECK_u64(array);
> > -             arch_perf_parse_sample_weight(data, array, type);
> > +             perf_parse_sample_weight(data, array, type);
> >               array++;
> >       }
> >
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index afc6855327ab..ae9803dca0b1 100644
> > --- a/tools/perf/util/hist.c
> > +++ b/tools/perf/util/hist.c
> > @@ -829,7 +829,7 @@ __hists__add_entry(struct hists *hists,
> >                       .period =3D sample->period,
> >                       .weight1 =3D sample->weight,
> >                       .weight2 =3D sample->ins_lat,
> > -                     .weight3 =3D sample->p_stage_cyc,
> > +                     .weight3 =3D sample->p_stage_cyc_or_retire_lat,
> >                       .latency =3D al->latency,
> >               },
> >               .parent =3D sym_parent,
> > @@ -846,7 +846,7 @@ __hists__add_entry(struct hists *hists,
> >               .time =3D hist_time(sample->time),
> >               .weight =3D sample->weight,
> >               .ins_lat =3D sample->ins_lat,
> > -             .p_stage_cyc =3D sample->p_stage_cyc,
> > +             .p_stage_cyc_or_retire_lat =3D sample->p_stage_cyc_or_ret=
ire_lat,
> >               .simd_flags =3D sample->simd_flags,
> >       }, *he =3D hists__findnew_entry(hists, &entry, al, sample_self);
> >
> > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > index c64254088fc7..67033bdabcf4 100644
> > --- a/tools/perf/util/hist.h
> > +++ b/tools/perf/util/hist.h
> > @@ -255,7 +255,7 @@ struct hist_entry {
> >       u64                     code_page_size;
> >       u64                     weight;
> >       u64                     ins_lat;
> > -     u64                     p_stage_cyc;
> > +     u64                     p_stage_cyc_or_retire_lat;
> >       s32                     socket;
> >       s32                     cpu;
> >       int                     parallelism;
> > diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpeb=
s.c
> > index 4ad4bc118ea5..ec2f3ecf1e1c 100644
> > --- a/tools/perf/util/intel-tpebs.c
> > +++ b/tools/perf/util/intel-tpebs.c
> > @@ -202,8 +202,8 @@ static int process_sample_event(const struct perf_t=
ool *tool __maybe_unused,
> >        * latency value will be used. Save the number of samples and the=
 sum of
> >        * retire latency value for each event.
> >        */
> > -     t->last =3D sample->retire_lat;
> > -     update_stats(&t->stats, sample->retire_lat);
> > +     t->last =3D sample->p_stage_cyc_or_retire_lat;
> > +     update_stats(&t->stats, sample->p_stage_cyc_or_retire_lat);
> >       mutex_unlock(tpebs_mtx_get());
> >       return 0;
> >  }
> > diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
> > index 0e96240052e9..3330d18fb5fd 100644
> > --- a/tools/perf/util/sample.h
> > +++ b/tools/perf/util/sample.h
> > @@ -104,10 +104,7 @@ struct perf_sample {
> >       u8  cpumode;
> >       u16 misc;
> >       u16 ins_lat;
> > -     union {
> > -             u16 p_stage_cyc;
> > -             u16 retire_lat;
> > -     };
> > +     u16 p_stage_cyc_or_retire_lat;
> >       bool no_hw_idx;         /* No hw_idx collected in branch_stack */
> >       char insn[MAX_INSN];
> >       void *raw_data;
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index a320672c264e..451bc24ccfba 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -1094,7 +1094,7 @@ static void dump_sample(struct evsel *evsel, unio=
n perf_event *event,
> >               printf("... weight: %" PRIu64 "", sample->weight);
> >                       if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
> >                               printf(",0x%"PRIx16"", sample->ins_lat);
> > -                             printf(",0x%"PRIx16"", sample->p_stage_cy=
c);
> > +                             printf(",0x%"PRIx16"", sample->p_stage_cy=
c_or_retire_lat);
> >                       }
> >               printf("\n");
> >       }
> > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > index 45e654653960..dda4ef0b5a73 100644
> > --- a/tools/perf/util/sort.c
> > +++ b/tools/perf/util/sort.c
> > @@ -1879,21 +1879,21 @@ struct sort_entry sort_global_ins_lat =3D {
> >  static int64_t
> >  sort__p_stage_cyc_cmp(struct hist_entry *left, struct hist_entry *righ=
t)
> >  {
> > -     return left->p_stage_cyc - right->p_stage_cyc;
> > +     return left->p_stage_cyc_or_retire_lat - right->p_stage_cyc_or_re=
tire_lat;
> >  }
> >
> >  static int hist_entry__global_p_stage_cyc_snprintf(struct hist_entry *=
he, char *bf,
> >                                       size_t size, unsigned int width)
> >  {
> >       return repsep_snprintf(bf, size, "%-*u", width,
> > -                     he->p_stage_cyc * he->stat.nr_events);
> > +                     he->p_stage_cyc_or_retire_lat * he->stat.nr_event=
s);
> >  }
> >
> >
> >  static int hist_entry__p_stage_cyc_snprintf(struct hist_entry *he, cha=
r *bf,
> >                                       size_t size, unsigned int width)
> >  {
> > -     return repsep_snprintf(bf, size, "%-*u", width, he->p_stage_cyc);
> > +     return repsep_snprintf(bf, size, "%-*u", width, he->p_stage_cyc_o=
r_retire_lat);
> >  }
> >
> >  struct sort_entry sort_local_p_stage_cyc =3D {
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synth=
etic-events.c
> > index 2fc4d0537840..449a41900fc4 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -1567,10 +1567,16 @@ size_t perf_event__sample_event_size(const stru=
ct perf_sample *sample, u64 type,
> >       return result;
> >  }
> >
> > -void __weak arch_perf_synthesize_sample_weight(const struct perf_sampl=
e *data,
> > +static void perf_synthesize_sample_weight(const struct perf_sample *da=
ta,
> >                                              __u64 *array, u64 type __m=
aybe_unused)
> >  {
> >       *array =3D data->weight;
> > +
> > +     if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
> > +             *array &=3D 0xffffffff;
> > +             *array |=3D ((u64)data->ins_lat << 32);
> > +             *array |=3D ((u64)data->p_stage_cyc_or_retire_lat << 48);
> > +     }
>
> It works for X86, but powerpc seems have a different behavior. The
> p_stage_cyc is missed here. Not sure if it intends.

Yeah, I was assuming it was a bug on powerpc not to synthesize this
part of the sample as it is read. As evsel__parse_sample will set this
to 0 and the bits don't overlap I expect the change to either be a bug
fix or benign on powerpc.

Thanks,
Ian

> Thanks,
> Kan
>
> >  }
> >
> >  static __u64 *copy_read_group_values(__u64 *array, __u64 read_format,
> > @@ -1730,7 +1736,7 @@ int perf_event__synthesize_sample(union perf_even=
t *event, u64 type, u64 read_fo
> >       }
> >
> >       if (type & PERF_SAMPLE_WEIGHT_TYPE) {
> > -             arch_perf_synthesize_sample_weight(sample, array, type);
> > +             perf_synthesize_sample_weight(sample, array, type);
> >               array++;
> >       }
> >
>
