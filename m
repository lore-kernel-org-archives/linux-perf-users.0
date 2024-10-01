Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9264F107B6
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 02:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727748232; cv=none; b=Dxe+eew2BWp4myUt8QCjNHs53LQZDT79Z6YpOwzOZIrNZlFnkDz7HFQgpxxPHQizhmff9eZklID/CEdSG01XdPQSiLgOkePYCcK9CFeZlOhJTqPcBH1f+yz+neltnyR96XkBMWZzqVhQowKkkUC4u37akzEjfzf1rowHxq3mAYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727748232; c=relaxed/simple;
	bh=yjRxB16Ox1ZisAHgXEr1NQcnJWhocQgbn0uYAf7t66s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjrjsS9EJ3yNh1aU62Qpb9FRufmQ2M5Mb9wZFgXbgLNjcVx83FF40tLYzj9jtnIbRHBVPXLrTxK3cgrFeHS8wYP0Gpa7LGabZbmst44llDkEPH9yis7LsGFRqPf47XfNHqiNoor0LHtnjrD+RAnKPi6tKE//puaNcLzl7LPUhX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYAsONNp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYAsONNp"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b061b7299so65045ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Sep 2024 19:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727748230; x=1728353030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tYT09StdnPPHJnU+QYoMuEVh5eDSml9ru98a8DaVcM=;
        b=bYAsONNp+GmG++VMXlG05os385Qpxrwez8VYldk2Pg+prfoZpIKmJmAvJy/8TIKBpC
         0VR4k2CS4SDgM4txcXQ/o8vskTdXwBeNey4SbDa7uq9KpYqg2tXTMb8RwY+jZ7LgTW8h
         wqD1iTIfEpLeu2p1YKWoPFFUEv16Ktyk9Mn1utPMsRCauFLNv0qCU0NQ3F2F34bFDaz8
         fSoasriczuemJPutTd2UHt+GZ2ZPFIhBy6KIEvkOwiMkX/9dFzphLBQQ2g4jRJpe3lS9
         QPx0jBIhstPjiWjiIehF5jT9NjlvC5yrCcknqjZ2ziAgjtgxIRMKiSFXvjMzeA+VSD15
         JZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727748230; x=1728353030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tYT09StdnPPHJnU+QYoMuEVh5eDSml9ru98a8DaVcM=;
        b=Yo8d3pa2po7bktHr77pdIY2xC8eFMnlQL79WMbBElumTJ57Wur9yu/8LiTu7FXSR9K
         h/AyBSFm4HAN5gWl0xIUPTPplUWfEshLcfjak2E6fCmYAbwekUAiYWiZppqYUSU6TZWX
         oKejdarR5tzOIRKQeRovPW971WrvAj+0aF0PoZ1A7EVOs8VWlVgEUZs+yiWnb+kqLFUC
         dOsHjRXVqmhGkrYhLUWbHUmPUwWoNyBTfd3vkw0L574nAqKd/mQyPsWHDF8/zniWjkEX
         xzFPbOCmV/D/DvZ1tdDYgwd0bNApD4A+nhC9F+sQAyUCZearrIIee98EiaDoGD/Z4yNx
         /tNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIB/+0R6ZZclUzFnfehdSZvCLm7RDNQZ1+12BJD8SanSo9Ehy/vzOehlXRy40FgvgW3aRZjNYGsdFKnGNl+T3D@vger.kernel.org
X-Gm-Message-State: AOJu0YwJK0h7wbAlQupJjtUzenq9mOvHmTmC2c7R3yrMVVuzj8OyzHlL
	NZhb0zAk6sUCQQw4fEOYaUT+D5Xy9Voun6WgiuBFSotOMlBuauAl1pTnY5rf2UsMTDcxx2/iY0U
	02mwOzTj5qoy01v4C/FYXVZWQPTzBG83ObeyS
X-Google-Smtp-Source: AGHT+IFk7hsxUzifKsSfQl3hugr4F3lGB8+f60SaXvO0QW6DQ5/bATmdDe7R5dV1d5UAbNmVe3sfwWAEF/mpsDA4aoU=
X-Received: by 2002:a17:903:1c6:b0:206:a913:96b9 with SMTP id
 d9443c01a7336-20baccd1742mr1718735ad.10.1727748229265; Mon, 30 Sep 2024
 19:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918220133.102964-1-irogers@google.com> <20240918220133.102964-4-irogers@google.com>
 <ZvsbP2ex-wIlJaqk@google.com>
In-Reply-To: <ZvsbP2ex-wIlJaqk@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 30 Sep 2024 19:03:35 -0700
Message-ID: <CAP-5=fUTp3cb8LN587=zEyqCCzivJkhzLVnyYc4Y6NvBwKgPvQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] perf parse-events: Add "cpu" term to set the CPU
 an event is recorded on
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 2:42=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Sep 19, 2024 at 12:01:33AM +0200, Ian Rogers wrote:
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
> >  Performance counter stats for 'system wide':
> >
> > CPU0              368,647      instructions/cpu=3D0/              #    =
0.26  insn per cycle
> > CPU4        <not counted>      instructions/cpu=3D0/
> > CPU5        <not counted>      instructions/cpu=3D0/
> > CPU8        <not counted>      instructions/cpu=3D0/
>
> I think this should have an entry for CPU0 only.  IOW the cpu parameter
> in the event specification has a higher priority than -C option.

I think you are agreeing with what the output shows and what is
written in the commit message. See below for cleaning up the stat
output.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
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
> >        0.102925309 seconds time elapsed
> > ```
> >
> > Note, the event name of inst_retired.any is missing, reported as
> > cpu/cpu=3D8/, as there are unmerged uniquify fixes:
> > https://lore.kernel.org/lkml/20240510053705.2462258-3-irogers@google.co=
m/
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Documentation/perf-list.txt |  9 ++++
> >  tools/perf/util/evsel_config.h         |  1 +
> >  tools/perf/util/parse-events.c         | 71 ++++++++++++++++++++++----
> >  tools/perf/util/parse-events.h         |  3 +-
> >  tools/perf/util/parse-events.l         |  1 +
> >  tools/perf/util/pmu.c                  |  1 +
> >  6 files changed, 74 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Docume=
ntation/perf-list.txt
> > index dea005410ec0..e0cd9bb8283e 100644
> > --- a/tools/perf/Documentation/perf-list.txt
> > +++ b/tools/perf/Documentation/perf-list.txt
> > @@ -274,6 +274,15 @@ Sums up the event counts for all hardware threads =
in a core, e.g.:
> >
> >    perf stat -e cpu/event=3D0,umask=3D0x3,percore=3D1/
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
> >  EVENT GROUPS
> >  ------------
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
> >  };
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 017d31d51ea4..63c31cfdd79b 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -7,6 +7,7 @@
> >  #include <errno.h>
> >  #include <sys/ioctl.h>
> >  #include <sys/param.h>
> > +#include "cpumap.h"
> >  #include "term.h"
> >  #include "env.h"
> >  #include "evlist.h"
> > @@ -178,6 +179,26 @@ static char *get_config_name(const struct parse_ev=
ents_terms *head_terms)
> >       return get_config_str(head_terms, PARSE_EVENTS__TERM_TYPE_NAME);
> >  }
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
> >  /**
> >   * fix_raw - For each raw term see if there is an event (aka alias) in=
 pmu that
> >   *           matches the raw's string value. If the string value match=
es an
> > @@ -469,11 +490,12 @@ int parse_events_add_cache(struct list_head *list=
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
> > @@ -487,7 +509,7 @@ int parse_events_add_cache(struct list_head *list, =
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
> > @@ -507,20 +529,27 @@ int parse_events_add_cache(struct list_head *list=
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
> >  }
> >
> > @@ -835,6 +864,7 @@ static const char *config_term_name(enum parse_even=
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
> > @@ -864,6 +894,7 @@ config_term_avail(enum parse_events__term_type term=
_type, struct parse_events_er
> >       case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
> >       case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> >       case PARSE_EVENTS__TERM_TYPE_PERCORE:
> > +     case PARSE_EVENTS__TERM_TYPE_CPU:
> >               return true;
> >       case PARSE_EVENTS__TERM_TYPE_USER:
> >       case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
> > @@ -1007,6 +1038,15 @@ do {                                            =
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
> > @@ -1133,6 +1173,7 @@ static int config_term_tracepoint(struct perf_eve=
nt_attr *attr,
> >       case PARSE_EVENTS__TERM_TYPE_RAW:
> >       case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> >       case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> > +     case PARSE_EVENTS__TERM_TYPE_CPU:
> >       default:
> >               if (err) {
> >                       parse_events_error__handle(err, term->err_term,
> > @@ -1264,6 +1305,7 @@ do {                                             =
               \
> >               case PARSE_EVENTS__TERM_TYPE_RAW:
> >               case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> >               case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> > +             case PARSE_EVENTS__TERM_TYPE_CPU:
> >               default:
> >                       break;
> >               }
> > @@ -1317,6 +1359,7 @@ static int get_config_chgs(struct perf_pmu *pmu, =
struct parse_events_terms *head
> >               case PARSE_EVENTS__TERM_TYPE_RAW:
> >               case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> >               case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> > +             case PARSE_EVENTS__TERM_TYPE_CPU:
> >               default:
> >                       break;
> >               }
> > @@ -1371,6 +1414,7 @@ static int __parse_events_add_numeric(struct pars=
e_events_state *parse_state,
> >       struct perf_event_attr attr;
> >       LIST_HEAD(config_terms);
> >       const char *name, *metric_id;
> > +     struct perf_cpu_map *cpus;
> >       int ret;
> >
> >       memset(&attr, 0, sizeof(attr));
> > @@ -1392,9 +1436,11 @@ static int __parse_events_add_numeric(struct par=
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
> >  }
> > @@ -1461,6 +1507,7 @@ static int parse_events_add_pmu(struct parse_even=
ts_state *parse_state,
> >       LIST_HEAD(config_terms);
> >       struct parse_events_terms parsed_terms;
> >       bool alias_rewrote_terms =3D false;
> > +     struct perf_cpu_map *term_cpu =3D NULL;
> >
> >       if (verbose > 1) {
> >               struct strbuf sb;
> > @@ -1552,10 +1599,12 @@ static int parse_events_add_pmu(struct parse_ev=
ents_state *parse_state,
> >               return -EINVAL;
> >       }
> >
> > +     term_cpu =3D get_config_cpu(&parsed_terms);
> >       evsel =3D __add_event(list, &parse_state->idx, &attr, /*init_attr=
=3D*/true,
> >                           get_config_name(&parsed_terms),
> >                           get_config_metric_id(&parsed_terms), pmu,
> > -                         &config_terms, auto_merge_stats, /*cpu_list=
=3D*/NULL);
> > +                         &config_terms, auto_merge_stats, term_cpu);
> > +     perf_cpu_map__put(term_cpu);
> >       if (!evsel) {
> >               parse_events_terms__exit(&parsed_terms);
> >               return -ENOMEM;
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-eve=
nts.h
> > index 10cc9c433116..2532c81d4f9a 100644
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
> >  };
> >
> >  struct parse_events_term {
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-eve=
nts.l
> > index 5a0bcd7f166a..635d216632d7 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -331,6 +331,7 @@ percore                   { return term(yyscanner, =
PARSE_EVENTS__TERM_TYPE_PERCORE); }
> >  aux-output           { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
AUX_OUTPUT); }
> >  aux-sample-size              { return term(yyscanner, PARSE_EVENTS__TE=
RM_TYPE_AUX_SAMPLE_SIZE); }
> >  metric-id            { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
METRIC_ID); }
> > +cpu                  { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
CPU); }
> >  cpu-cycles|cycles                            { return hw_term(yyscanne=
r, PERF_COUNT_HW_CPU_CYCLES); }
> >  stalled-cycles-frontend|idle-cycles-frontend { return hw_term(yyscanne=
r, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
> >  stalled-cycles-backend|idle-cycles-backend   { return hw_term(yyscanne=
r, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 61bdda01a05a..4f68026a97bb 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -1738,6 +1738,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pm=
u, void *state, pmu_format_call
> >               "percore",
> >               "aux-output",
> >               "aux-sample-size=3Dnumber",
> > +             "cpu=3Dnumber",
> >       };
> >       struct perf_pmu_format *format;
> >       int ret;
> > --
> > 2.46.0.662.g92d0881bb0-goog
> >
