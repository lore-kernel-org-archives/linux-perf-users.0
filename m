Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240D984DF5
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315243; cv=none; b=Ao00cRAiFO3asKu4kCPoCaEojqMzPuJtatyJL62FuUEOsBZ0nrbaCn5By/V3IcEIDmMAN+qODeisjw/S9M5FA2DG7w6XZ6zdRkVGdh/7VhRStCBi2Q/IYxKW0w0Aw7N5UIoJksJIcgPHNEYzCA2GUOz2lYi54+F+dHBW05Ok8pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315243; c=relaxed/simple;
	bh=SGSnXT6AGQNVK47nZqGxeMuHrxgrs2yy9JzNDP15pts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9VtazU9iziMFa8Fdu8YOFtRBtszo6MvSo5Scaj0546i2/i1E0GQV7NHDYlnnDKXgR/1hj2CfeHLL+KfrEmJDi67cZwNXCCFKYH7FPa140yDxaVX0mqfL4bXkQ4Z9ha0upfX5bgu+2Fs/U6Caw6v6uvA1GWBgVsNvz51B3mlbIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IlYjmLrd; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlYjmLrd"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-447df43324fso138541cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 08:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721315240; x=1721920040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lyUsUp3zH5m+bvEX2jmvlPO9SAXaFdtd+AK96FliTA=;
        b=IlYjmLrdbfxqyrEx+YEmmJO36UFFn5Biaz3dFi1WeeoTlQ3TyFLqKwCj0A7Hl3Bz3R
         F5yqACRyJ5r/Gmh9pY+S+cXhchbuXojwhLfncXGkslGIVYZuE10cOmPaW3MYRqb4F4DH
         JG2dCxmO1KxMRPIpkLVd1ChvMER4JFu9v9JMmnaFqzXLLJV/pYoyyd8skPHzX/X9IRM2
         8WB6h/c7qgVtK67JaVerAiQKdiYZhQihMF2IR+T5mTAixe4eOISI0qna5m+zjoIiUEtF
         YLF8AtQM8OA3gw5gVSL5xy9N5NzDP6Xa/wcqAOrbr8eDOxDyJqfcp80IfpfNEVez6GAk
         wifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721315240; x=1721920040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lyUsUp3zH5m+bvEX2jmvlPO9SAXaFdtd+AK96FliTA=;
        b=aWSNFA0xeL5mBX2F+OKMgeV4mx4yGqYL6D+vpsSpzZmdGcyV4EYmnkDLS4FWR6qijS
         VtAAxrR4/aG8UmyuRn2MOXwtJHAE9vk6L8QNAJr+a/hpAC6p/i76gztB0cdpxY2kH5ff
         ITfehBz40I8K7oH0GlMkFOqoUcq0hnelmKU8U4lu+79fVb0X1y80KSJoxcK0sF/UnQt8
         Fb03lNJ0oCd0SX/2ddZIaRUomt0doMC2JcqVCTf+9uEHS/BaHeVVzQUBG1Bl6eOFLv9C
         hxuj5kwJjC+p9R33gJUwwoZ2zZDWIXYg0jYRR5LY5ia6cyFbHE6mXhX3o99RgtKv2xlh
         kTLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZvNTtfwgNG0Mn44lwdwJKSiowxcgl/h0rOJItkyKq3LFhHGQ57a7MLohuuid+zIhrHw7LemCrEPpylr9YZMbNnuTPrBTPqKfmIACHbkFE0w==
X-Gm-Message-State: AOJu0Yw3pLdlGqEITvwOuTxRTJsclI50kcqxu+UT//6lGpEBFS0+4Rt4
	/esGNmkVne5TSPYAR0RCABIz1foaWjJM8eQVjObxr5JxAUmqmcwOsU4mmvBfD3jsw9FL5vuaNKM
	zeFjPIrIzLYjj58I9V09H12pN16S4ZdPQtUtG
X-Google-Smtp-Source: AGHT+IHybviklDR72kWt6kzWwqEhV875IFAKxtsUr3jlt9uFUkSHLreXebzlnAiA0oaWD9DCasOUX2BYrI0qSSW98nY=
X-Received: by 2002:ac8:4f50:0:b0:447:d555:7035 with SMTP id
 d75a77b69052e-44f969f1893mr1131571cf.13.1721315239414; Thu, 18 Jul 2024
 08:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com> <20240718003025.1486232-7-irogers@google.com>
 <ecca73c3-3260-4e95-b9d6-6f6875258fb9@linaro.org>
In-Reply-To: <ecca73c3-3260-4e95-b9d6-6f6875258fb9@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Jul 2024 08:07:06 -0700
Message-ID: <CAP-5=fVqhvR-3ya6GLs98A_1hTYX=jjjBkCbxMYb+2ZT5FRk1w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] perf parse-events: Add "cpu" term to set the CPU
 an event is recorded on
To: James Clark <james.clark@linaro.org>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	ananth.narayan@amd.com, gautham.shenoy@amd.com, kprateek.nayak@amd.com, 
	sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 7:10=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 18/07/2024 1:30 am, Ian Rogers wrote:
> > The -C option allows the CPUs for a list of events to be specified but
> > its not possible to set the CPU for a single event. Add a term to
> > allow this. The term isn't a general CPU list due to ',' already being
> > a special character in event parsing instead multiple cpu=3D terms may
> > be provided and they will be merged/unioned together.
> >
> > An example of mixing different types of events counted on different CPU=
s:
> > ```
> > $ perf stat -A -C 0,4-5,8 -e "instructions/cpu=3D0/,l1d-misses/cpu=3D4,=
cpu=3D5/,inst_retired.any/cpu=3D8/,cycles" -a sleep 0.1
> >
>
> I ran into cpu=3DN having no effect unless -C is also used. For example:
>
>   $ perf stat -vv -e branch-misses/cpu=3D1/ -- true
>
>   sys_perf_event_open: pid 10233  cpu -1  group_fd -1  flags 0x8 =3D 3
>
> Vs:
>
>   $ perf stat -C 0,1 -vv -e branch-misses/cpu=3D1/ -- true
>
>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 =3D 3
>
> Is it possible to have a warning or error in that case? Seems like it's
> quite likely to confuse a user.

Agreed. We have similar warnings for "-A". Tbh, there's no reason we
can support this, perf_event_open does. The evlist propagate maps
logic in my mind is crazy. I agree with a need to summarize the cpu
maps in the evlist, but the code changes evsel cpu maps in ways that
are brittle - for example, in this series I try to fix that legacy
hardware and hardware cache events aren't considered core. Rather than
processing command line options, the propagate maps fudge, I just wish
event parsing would do parsing and the events be pretty immutable
after that. The problem comes if you do -e then -C or -C then -e, as
our command line processing is ordering dependent.

Thanks,
Ian

> Other than that it seems to work ok.
>
> WRT the RAPL issue [1], I didn't quite follow how these two things will
> join up. Doesn't this only end up setting the cpu argument to
> perf_event_open(), which already aggregates per package rather than per
> core, even if the cpu is set? And the fix for that behavior was rejected
> because it would break Intel metrics [2].
>
> Maybe I'm missing a piece.
>
> [1]:
> https://lore.kernel.org/lkml/CAP-5=3DfXXuWchzUK0n5KTH8kamr=3DDQoEni+bUoo8=
f-4j8Y+eMBg@mail.gmail.com/
> [2]:
> https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@linux.i=
ntel.com/
>
> James
>
> >   Performance counter stats for 'system wide':
> >
> > CPU0              368,647      instructions/cpu=3D0/              #    =
0.26  insn per cycle
> > CPU4        <not counted>      instructions/cpu=3D0/
> > CPU5        <not counted>      instructions/cpu=3D0/
> > CPU8        <not counted>      instructions/cpu=3D0/
> > CPU0        <not counted>      l1d-misses [cpu]
> > CPU4              203,377      l1d-misses [cpu]
> > CPU5              138,231      l1d-misses [cpu]
> > CPU8        <not counted>      l1d-misses [cpu]
> > CPU0        <not counted>      cpu/cpu=3D8/
> > CPU4        <not counted>      cpu/cpu=3D8/
> > CPU5        <not counted>      cpu/cpu=3D8/
> > CPU8              943,861      cpu/cpu=3D8/
> > CPU0            1,412,071      cycles
> > CPU4           20,362,900      cycles
> > CPU5           10,172,725      cycles
> > CPU8            2,406,081      cycles
> >
> >         0.102925309 seconds time elapsed
> > ```
> >
> > Note, the event name of inst_retired.any is missing, reported as
> > cpu/cpu=3D8/, as there are unmerged uniquify fixes:
> > https://lore.kernel.org/lkml/20240510053705.2462258-3-irogers@google.co=
m/
> >
> > An example of spreading uncore overhead across two CPUs:
> > ```
> > $ perf stat -A -e "data_read/cpu=3D0/,data_write/cpu=3D1/" -a sleep 0.1
> >
> >   Performance counter stats for 'system wide':
> >
> > CPU0               223.65 MiB  uncore_imc_free_running_0/cpu=3D0/
> > CPU0               223.66 MiB  uncore_imc_free_running_1/cpu=3D0/
> > CPU0        <not counted> MiB  uncore_imc_free_running_0/cpu=3D1/
> > CPU1                 5.78 MiB  uncore_imc_free_running_0/cpu=3D1/
> > CPU0        <not counted> MiB  uncore_imc_free_running_1/cpu=3D1/
> > CPU1                 5.74 MiB  uncore_imc_free_running_1/cpu=3D1/
> > ```
> >
> > Manually fixing the output it should be:
> > ```
> > CPU0               223.65 MiB  uncore_imc_free_running_0/data_read,cpu=
=3D0/
> > CPU0               223.66 MiB  uncore_imc_free_running_1/data_read,cpu=
=3D0/
> > CPU1                 5.78 MiB  uncore_imc_free_running_0/data_write,cpu=
=3D1/
> > CPU1                 5.74 MiB  uncore_imc_free_running_1/data_write,cpu=
=3D1/
> > ```
> >
> > That is data_read from 2 PMUs was counted on CPU0 and data_write was
> > counted on CPU1.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/Documentation/perf-list.txt |  9 ++++
> >   tools/perf/util/evsel_config.h         |  1 +
> >   tools/perf/util/parse-events.c         | 73 ++++++++++++++++++++++---=
-
> >   tools/perf/util/parse-events.h         |  3 +-
> >   tools/perf/util/parse-events.l         |  1 +
> >   tools/perf/util/pmu.c                  |  1 +
> >   6 files changed, 77 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Docume=
ntation/perf-list.txt
> > index 6bf2468f59d3..15511afe94a1 100644
> > --- a/tools/perf/Documentation/perf-list.txt
> > +++ b/tools/perf/Documentation/perf-list.txt
> > @@ -273,6 +273,15 @@ Sums up the event counts for all hardware threads =
in a core, e.g.:
> >
> >     perf stat -e cpu/event=3D0,umask=3D0x3,percore=3D1/
> >
> > +cpu:
> > +
> > +Specifies the CPU to open the event upon. The value may be repeated to
> > +specify opening the event on multiple CPUs:
> > +
> > +
> > +  perf stat -e instructions/cpu=3D0,cpu=3D2/,cycles/cpu=3D1,cpu=3D2/ -=
a sleep 1
> > +  perf stat -e data_read/cpu=3D0/,data_write/cpu=3D1/ -a sleep 1
> > +
> >
> >   EVENT GROUPS
> >   ------------
> > diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_con=
fig.h
> > index aee6f808b512..9630c4a24721 100644
> > --- a/tools/perf/util/evsel_config.h
> > +++ b/tools/perf/util/evsel_config.h
> > @@ -47,6 +47,7 @@ struct evsel_config_term {
> >               u32           aux_sample_size;
> >               u64           cfg_chg;
> >               char          *str;
> > +             int           cpu;
> >       } val;
> >       bool weak;
> >   };
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 8c0c33361c5e..85faef85b8de 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -7,6 +7,7 @@
> >   #include <errno.h>
> >   #include <sys/ioctl.h>
> >   #include <sys/param.h>
> > +#include "cpumap.h"
> >   #include "term.h"
> >   #include "evlist.h"
> >   #include "evsel.h"
> > @@ -177,6 +178,26 @@ static char *get_config_name(const struct parse_ev=
ents_terms *head_terms)
> >       return get_config_str(head_terms, PARSE_EVENTS__TERM_TYPE_NAME);
> >   }
> >
> > +static struct perf_cpu_map *get_config_cpu(const struct parse_events_t=
erms *head_terms)
> > +{
> > +     struct parse_events_term *term;
> > +     struct perf_cpu_map *cpus =3D NULL;
> > +
> > +     if (!head_terms)
> > +             return NULL;
> > +
> > +     list_for_each_entry(term, &head_terms->terms, list) {
> > +             if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_CPU) {
> > +                     struct perf_cpu_map *cpu =3D perf_cpu_map__new_in=
t(term->val.num);
> > +
> > +                     cpus =3D perf_cpu_map__merge(cpus, cpu);
> > +                     perf_cpu_map__put(cpu);
> > +             }
> > +     }
> > +
> > +     return cpus;
> > +}
> > +
> >   /**
> >    * fix_raw - For each raw term see if there is an event (aka alias) i=
n pmu that
> >    *           matches the raw's string value. If the string value matc=
hes an
> > @@ -468,11 +489,12 @@ int parse_events_add_cache(struct list_head *list=
, int *idx, const char *name,
> >       bool found_supported =3D false;
> >       const char *config_name =3D get_config_name(parsed_terms);
> >       const char *metric_id =3D get_config_metric_id(parsed_terms);
> > +     struct perf_cpu_map *cpus =3D get_config_cpu(parsed_terms);
> > +     int ret =3D 0;
> >
> >       while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> >               LIST_HEAD(config_terms);
> >               struct perf_event_attr attr;
> > -             int ret;
> >
> >               if (parse_events__filter_pmu(parse_state, pmu))
> >                       continue;
> > @@ -486,7 +508,7 @@ int parse_events_add_cache(struct list_head *list, =
int *idx, const char *name,
> >                                                  parsed_terms,
> >                                                  perf_pmu__auto_merge_s=
tats(pmu));
> >                       if (ret)
> > -                             return ret;
> > +                             goto out_err;
> >                       continue;
> >               }
> >
> > @@ -506,20 +528,27 @@ int parse_events_add_cache(struct list_head *list=
, int *idx, const char *name,
> >
> >               if (parsed_terms) {
> >                       if (config_attr(&attr, parsed_terms, parse_state-=
>error,
> > -                                     config_term_common))
> > -                             return -EINVAL;
> > -
> > -                     if (get_config_terms(parsed_terms, &config_terms)=
)
> > -                             return -ENOMEM;
> > +                                     config_term_common)) {
> > +                             ret =3D -EINVAL;
> > +                             goto out_err;
> > +                     }
> > +                     if (get_config_terms(parsed_terms, &config_terms)=
) {
> > +                             ret =3D -ENOMEM;
> > +                             goto out_err;
> > +                     }
> >               }
> >
> >               if (__add_event(list, idx, &attr, /*init_attr*/true, conf=
ig_name ?: name,
> >                               metric_id, pmu, &config_terms, /*auto_mer=
ge_stats=3D*/false,
> > -                             /*cpu_list=3D*/NULL) =3D=3D NULL)
> > -                     return -ENOMEM;
> > +                             cpus) =3D=3D NULL)
> > +                     ret =3D -ENOMEM;
> >
> >               free_config_terms(&config_terms);
> > +             if (ret)
> > +                     goto out_err;
> >       }
> > +out_err:
> > +     perf_cpu_map__put(cpus);
> >       return found_supported ? 0 : -EINVAL;
> >   }
> >
> > @@ -814,6 +843,7 @@ static const char *config_term_name(enum parse_even=
ts__term_type term_type)
> >               [PARSE_EVENTS__TERM_TYPE_RAW]                   =3D "raw"=
,
> >               [PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          =3D "lega=
cy-cache",
> >               [PARSE_EVENTS__TERM_TYPE_HARDWARE]              =3D "hard=
ware",
> > +             [PARSE_EVENTS__TERM_TYPE_CPU]                   =3D "cpu"=
,
> >       };
> >       if ((unsigned int)term_type >=3D __PARSE_EVENTS__TERM_TYPE_NR)
> >               return "unknown term";
> > @@ -843,6 +873,7 @@ config_term_avail(enum parse_events__term_type term=
_type, struct parse_events_er
> >       case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
> >       case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> >       case PARSE_EVENTS__TERM_TYPE_PERCORE:
> > +     case PARSE_EVENTS__TERM_TYPE_CPU:
> >               return true;
> >       case PARSE_EVENTS__TERM_TYPE_USER:
> >       case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
> > @@ -986,6 +1017,15 @@ do {                                             =
                          \
> >                       return -EINVAL;
> >               }
> >               break;
> > +     case PARSE_EVENTS__TERM_TYPE_CPU:
> > +             CHECK_TYPE_VAL(NUM);
> > +             if (term->val.num >=3D (u64)cpu__max_present_cpu().cpu) {
> > +                     parse_events_error__handle(err, term->err_val,
> > +                                             strdup("too big"),
> > +                                             NULL);
> > +                     return -EINVAL;
> > +             }
> > +             break;
> >       case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
> >       case PARSE_EVENTS__TERM_TYPE_USER:
> >       case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> > @@ -1112,6 +1152,7 @@ static int config_term_tracepoint(struct perf_eve=
nt_attr *attr,
> >       case PARSE_EVENTS__TERM_TYPE_RAW:
> >       case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> >       case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> > +     case PARSE_EVENTS__TERM_TYPE_CPU:
> >       default:
> >               if (err) {
> >                       parse_events_error__handle(err, term->err_term,
> > @@ -1243,6 +1284,7 @@ do {                                             =
               \
> >               case PARSE_EVENTS__TERM_TYPE_RAW:
> >               case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> >               case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> > +             case PARSE_EVENTS__TERM_TYPE_CPU:
> >               default:
> >                       break;
> >               }
> > @@ -1296,6 +1338,7 @@ static int get_config_chgs(struct perf_pmu *pmu, =
struct parse_events_terms *head
> >               case PARSE_EVENTS__TERM_TYPE_RAW:
> >               case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> >               case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> > +             case PARSE_EVENTS__TERM_TYPE_CPU:
> >               default:
> >                       break;
> >               }
> > @@ -1350,6 +1393,7 @@ static int __parse_events_add_numeric(struct pars=
e_events_state *parse_state,
> >       struct perf_event_attr attr;
> >       LIST_HEAD(config_terms);
> >       const char *name, *metric_id;
> > +     struct perf_cpu_map *cpus;
> >       int ret;
> >
> >       memset(&attr, 0, sizeof(attr));
> > @@ -1371,9 +1415,11 @@ static int __parse_events_add_numeric(struct par=
se_events_state *parse_state,
> >
> >       name =3D get_config_name(head_config);
> >       metric_id =3D get_config_metric_id(head_config);
> > +     cpus =3D get_config_cpu(head_config);
> >       ret =3D __add_event(list, &parse_state->idx, &attr, /*init_attr*/=
true, name,
> >                       metric_id, pmu, &config_terms, /*auto_merge_stats=
=3D*/false,
> > -                     /*cpu_list=3D*/NULL) ? 0 : -ENOMEM;
> > +                     cpus) ? 0 : -ENOMEM;
> > +     perf_cpu_map__put(cpus);
> >       free_config_terms(&config_terms);
> >       return ret;
> >   }
> > @@ -1440,6 +1486,7 @@ static int parse_events_add_pmu(struct parse_even=
ts_state *parse_state,
> >       LIST_HEAD(config_terms);
> >       struct parse_events_terms parsed_terms;
> >       bool alias_rewrote_terms =3D false;
> > +     struct perf_cpu_map *term_cpu =3D NULL;
> >       int ret =3D 0;
> >
> >       if (verbose > 1) {
> > @@ -1531,6 +1578,12 @@ static int parse_events_add_pmu(struct parse_eve=
nts_state *parse_state,
> >               goto out_err;
> >       }
> >
> > +     term_cpu =3D get_config_cpu(&parsed_terms);
> > +     if (!perf_cpu_map__is_empty(term_cpu)) {
> > +             perf_cpu_map__put(info.cpus);
> > +             info.cpus =3D term_cpu;
> > +             term_cpu =3D NULL;
> > +     }
> >       evsel =3D __add_event(list, &parse_state->idx, &attr, /*init_attr=
=3D*/true,
> >                           get_config_name(&parsed_terms),
> >                           get_config_metric_id(&parsed_terms), pmu,
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-eve=
nts.h
> > index e13de2c8b706..b03857499030 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -79,7 +79,8 @@ enum parse_events__term_type {
> >       PARSE_EVENTS__TERM_TYPE_RAW,
> >       PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
> >       PARSE_EVENTS__TERM_TYPE_HARDWARE,
> > -#define      __PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_HAR=
DWARE + 1)
> > +     PARSE_EVENTS__TERM_TYPE_CPU,
> > +#define      __PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_CPU=
 + 1)
> >   };
> >
> >   struct parse_events_term {
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-eve=
nts.l
> > index 16045c383ada..e06097a62796 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -330,6 +330,7 @@ percore                   { return term(yyscanner, =
PARSE_EVENTS__TERM_TYPE_PERCORE); }
> >   aux-output          { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
AUX_OUTPUT); }
> >   aux-sample-size             { return term(yyscanner, PARSE_EVENTS__TE=
RM_TYPE_AUX_SAMPLE_SIZE); }
> >   metric-id           { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
METRIC_ID); }
> > +cpu                  { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
CPU); }
> >   cpu-cycles|cycles                           { return hw_term(yyscanne=
r, PERF_COUNT_HW_CPU_CYCLES); }
> >   stalled-cycles-frontend|idle-cycles-frontend        { return hw_term(=
yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
> >   stalled-cycles-backend|idle-cycles-backend  { return hw_term(yyscanne=
r, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 280b2499c861..27e2ff23799e 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -1767,6 +1767,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pm=
u, void *state, pmu_format_call
> >               "percore",
> >               "aux-output",
> >               "aux-sample-size=3Dnumber",
> > +             "cpu=3Dnumber",
> >       };
> >       struct perf_pmu_format *format;
> >       int ret;
