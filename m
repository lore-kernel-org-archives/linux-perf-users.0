Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF20119067C
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736451297; cv=none; b=Q93gUwbnNG9QEmWuUXH5xwMOA1AYhSPePpZSv7pTE5syqttQC5DzCgDKI3zcyo3sUZuVUH75Nn3a+Sx4ChW1Gza4fOeCOMQPw/2NJ0qHsNnzCZgI4uKhEGM2WHTcjPb2jibVBrBUGDUL9OVFwSHobxEhy4IFx09HwlcdMFKFBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736451297; c=relaxed/simple;
	bh=FsY9kL6LbO2PrpL6r9skQTIsYp78hZgGmAQnW4HsX18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfeWVloeNd2Qm7JnhHFybGUBSpJeyKmcHKSK26U/DqT75lnLYvZM5X4X2b5xShsjxvs1iE9zYG5KG6IhLFNnqLpl0D/bbhmqrw9lUQwFogDl2gVHgAeYQep9E6n1/8jtw8VC5AIu3X+vpvThOT595e4M+Ct8a2VBtTn3dl4Xy44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PgRyxnVX; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PgRyxnVX"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so12625ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 11:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736451295; x=1737056095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s51Op2/3j7v+dqy9k6NYicp7kedXcmLaPEGEqhndgk=;
        b=PgRyxnVX/1cHPeSm0f4hyxWOO8ng/SUf1qGpSPbEVxKGgQj33YZ88uvg0S8jeGzzYb
         UPWmQf7SckzvtLtYtj+r/NIT4/WYrshhUpdqI4KrEUKVF+W1T/rGoQIdPkgZsqAEezDm
         i+XSD4Kw6eZKhqtICM24EgLTAe6Jxv18IbK02nAC+K2yeuq8xKDN6eN/V5jhD8q6mpkZ
         8YLHzP4baoAFZLWUQaIxo8dZ1pq35IA861oi6Logtt7+PFzrCCLCBR8LBeQorzHE8fgf
         bcUrNx8H6bxHXBdO1+qaf9teP04vr38AIkpBzuM7d3O0cmq09pFZB4SKRzKCTYObSklF
         +LPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736451295; x=1737056095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+s51Op2/3j7v+dqy9k6NYicp7kedXcmLaPEGEqhndgk=;
        b=d/HbZsrv10A2xDd81pYYE41Ul6ZGAUtc/5hUrF311nysJDBKnjgQwwJsI3vN4T60He
         aoiNyZonoysIH4ztEDAbc6FCVdCPG+QImjG1W0xaFENT96/Ir+WbjNh4uNEOrgyONw5g
         tbZkX/bLVzdTM5ou4sVocvzlmSRxbI5ihzRDJUnJZIhJtsVKJYO8KAMzENhUTyNrZrl0
         iM15cQ5i/TDZUoRFK0NCiVmGRqjEMDYlCS6/AS4KQzGWlOhhf3NS5blL9CAf29qNcA+9
         CniVagrA5ssKfi2JY04keenvASyFYAc2z5yw+LMd70G3DXRL6j4ZcSTTC73AzReQhy4+
         RtlA==
X-Forwarded-Encrypted: i=1; AJvYcCWn5J63lmqXcLruflwuNIgKrKk/0q37b6k5gI7+u/uO/MUTYrvEgAmvxULhUX6Af5CzmS4+Uo5dkk/9WUcCVSpU@vger.kernel.org
X-Gm-Message-State: AOJu0YwiRNX/GQyrPDp9egsrvayENI6ZuJnStlHQvcgaVv2+tHZjx50y
	r8ZbDix3XjFlm/6ecx/l6c4/CDd9W/mGsw+a3vlfjImSOfFK3RtXZTSlg2HZFgM+aYeEMSUt/9/
	SG9Jui+EmLJpgP01T/JF9tW9N8vCHcqwC3BLs
X-Gm-Gg: ASbGnctvlJ7/KPRFiCrow22pBGpdA8+2Cn/v6HEzmYFud1Omkyy7u5wdRzVV8DwpsEh
	xOWbREbBN0jxLBG+VLKOXlpaQbB7o8Del/Kyil+k3dRLNpvYLD4cXIl99uE/RCJmn/HRoPQ==
X-Google-Smtp-Source: AGHT+IFZ5/qACAld7nCsLHoytHVwTOZaTPkRYuGe2Ebk6rKRYQIhAuECnTou1+e4XIA8bG7SI6rscRrZicjbtm6BCLM=
X-Received: by 2002:a05:6e02:1a2d:b0:3a7:c962:95d1 with SMTP id
 e9e14a558f8ab-3ce570e73e1mr235335ab.5.1736451294591; Thu, 09 Jan 2025
 11:34:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108053428.1724490-1-irogers@google.com> <20250108053428.1724490-5-irogers@google.com>
 <Z37XPa2J9uus3FDD@google.com>
In-Reply-To: <Z37XPa2J9uus3FDD@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 9 Jan 2025 11:34:43 -0800
X-Gm-Features: AbW1kvZDwS60eSEcG1-SMf1P51Sw5AMm2fB2QObLeCIsk8bA1spZpGplOMJYbWk
Message-ID: <CAP-5=fW7VERnVqR=QGYv-YM8N_6dtnOdPSUwKc_FLTJiwBoYHg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] perf parse-events: Add "cpu" term to set the CPU
 an event is recorded on
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Leo Yan <leo.yan@arm.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 11:51=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Jan 07, 2025 at 09:34:28PM -0800, Ian Rogers wrote:
> > The -C option allows the CPUs for a list of events to be specified but
> > its not possible to set the CPU for a single event. Add a term to
> > allow this. The term isn't a general CPU list due to ',' already being
> > a special character in event parsing instead multiple cpu=3D terms may
> > be provided and they will be merged/unioned together.
>
> It'd be nice if you could add a description why it's needed and/or some
> use cases.  I'm afraid it'd make the CPU map handling more complicated.

Not following. There is an example below and I'd like CPU map handling
to be robust to always work - this is why I've spent time cleaning up
the evlist behavior. Being able to set the CPU per event means, for
example, the perf_event_open for 2 uncore events can be sent to 2
different CPUs:
```
$ perf stat -vv -e data_read/cpu=3D0/,data_write/cpu=3D1/ -a sleep 1
Using CPUID GenuineIntel-6-8D-1
Attempt to add: uncore_imc_free_running_0/cpu=3D0,data_read/
..after resolving event: uncore_imc_free_running_0/cpu=3D0,event=3D0xff,uma=
sk=3D0x20/
data_read -> uncore_imc_free_running_0/cpu=3D0,data_read/
Attempt to add: uncore_imc_free_running_1/cpu=3D0,data_read/
..after resolving event: uncore_imc_free_running_1/cpu=3D0,event=3D0xff,uma=
sk=3D0x20/
data_read -> uncore_imc_free_running_1/cpu=3D0,data_read/
Attempt to add: uncore_imc_free_running_0/cpu=3D0x1,data_write/
..after resolving event:
uncore_imc_free_running_0/cpu=3D0x1,event=3D0xff,umask=3D0x30/
data_write -> uncore_imc_free_running_0/cpu=3D0x1,data_write/
Attempt to add: uncore_imc_free_running_1/cpu=3D0x1,data_write/
..after resolving event:
uncore_imc_free_running_1/cpu=3D0x1,event=3D0xff,umask=3D0x30/
data_write -> uncore_imc_free_running_1/cpu=3D0x1,data_write/
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
  type                             24 (uncore_imc_free_running_0)
  size                             136
  config                           0x20ff (data_read)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 =3D 3
------------------------------------------------------------
perf_event_attr:
  type                             25 (uncore_imc_free_running_1)
  size                             136
  config                           0x20ff (data_read)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 =3D 13
------------------------------------------------------------
perf_event_attr:
  type                             24 (uncore_imc_free_running_0)
  size                             136
  config                           0x30ff (data_write)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 =3D 14
------------------------------------------------------------
perf_event_attr:
  type                             25 (uncore_imc_free_running_1)
  size                             136
  config                           0x30ff (data_write)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 =3D 16
data_read/cpu=3D0/: 0: 35597083 1003987395 1003987395
data_read/cpu=3D0/: 0: 35593630 1003987549 1003987549
data_write/cpu=3D1/: 1: 1674310 1003942165 1003942165
data_write/cpu=3D1/: 1: 1672233 1003941578 1003941578
data_read/cpu=3D0/: 35597083 1003987395 1003987395
data_read/cpu=3D0/: 35593630 1003987549 1003987549
data_write/cpu=3D1/: 1674310 1003942165 1003942165
data_write/cpu=3D1/: 1672233 1003941578 1003941578

 Performance counter stats for 'system wide':

          4,345.14 MiB  data_read/cpu=3D0/
            204.26 MiB  data_write/cpu=3D1/

       1.003931032 seconds time elapsed
```

If the uncore PMU driver respects the perf_event_open CPU option then
for things like cgroup profiling, the context switch cost can be
spread over CPUs from a single perf command line.

You could get similar behavior by running perf multiple times and that
may workaround CPU map bugs, but that feels sub-optimal to me.

Thanks,
Ian

>
> >
> > An example of mixing different types of events counted on different CPU=
s:
> > ```
> > $ perf stat -A -C 0,4-5,8 -e "instructions/cpu=3D0/,l1d-misses/cpu=3D4,=
cpu=3D5/,inst_retired.any/cpu=3D8/,cycles" -a sleep 0.1
> >
> >  Performance counter stats for 'system wide':
> >
> > CPU0            6,979,225      instructions/cpu=3D0/              #    =
0.89  insn per cycle
> > CPU4               75,138      cpu/l1d-misses/
> > CPU5            1,418,939      cpu/l1d-misses/
> > CPU8              797,553      cpu/inst_retired.any,cpu=3D8/
> > CPU0            7,845,302      cycles
> > CPU4            6,546,859      cycles
> > CPU5          185,915,438      cycles
> > CPU8            2,065,668      cycles
> >
> >        0.112449242 seconds time elapsed
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Documentation/perf-list.txt |  9 +++
> >  tools/perf/util/evsel_config.h         |  1 +
> >  tools/perf/util/parse-events.c         | 76 +++++++++++++++++++++-----
> >  tools/perf/util/parse-events.h         |  3 +-
> >  tools/perf/util/parse-events.l         |  1 +
> >  tools/perf/util/pmu.c                  |  3 +-
> >  6 files changed, 76 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Docume=
ntation/perf-list.txt
> > index d0c65fad419a..d98de9adc515 100644
> > --- a/tools/perf/Documentation/perf-list.txt
> > +++ b/tools/perf/Documentation/perf-list.txt
> > @@ -289,6 +289,15 @@ Sums up the event counts for all hardware threads =
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
> > index af52a1516d0b..94a1e9cf73d6 100644
> > --- a/tools/perf/util/evsel_config.h
> > +++ b/tools/perf/util/evsel_config.h
> > @@ -48,6 +48,7 @@ struct evsel_config_term {
> >               u32           aux_sample_size;
> >               u64           cfg_chg;
> >               char          *str;
> > +             int           cpu;
> >       } val;
> >       bool weak;
> >  };
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 4bda4141e9e7..ec8429f0cf6d 100644
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
> > +                     perf_cpu_map__merge(&cpus, cpu);
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
> > @@ -441,11 +462,12 @@ int parse_events_add_cache(struct list_head *list=
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
> > @@ -460,7 +482,7 @@ int parse_events_add_cache(struct list_head *list, =
int *idx, const char *name,
> >                                                  perf_pmu__auto_merge_s=
tats(pmu),
> >                                                  /*alternate_hw_config=
=3D*/PERF_COUNT_HW_MAX);
> >                       if (ret)
> > -                             return ret;
> > +                             goto out_err;
> >                       continue;
> >               }
> >
> > @@ -480,21 +502,27 @@ int parse_events_add_cache(struct list_head *list=
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
> > -                             /*cpu_list=3D*/NULL,
> > -                             /*alternate_hw_config=3D*/PERF_COUNT_HW_M=
AX) =3D=3D NULL)
> > -                     return -ENOMEM;
> > +                             cpus, /*alternate_hw_config=3D*/PERF_COUN=
T_HW_MAX) =3D=3D NULL)
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
> > @@ -808,6 +836,7 @@ const char *parse_events__term_type_str(enum parse_=
events__term_type term_type)
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
> > @@ -837,6 +866,7 @@ config_term_avail(enum parse_events__term_type term=
_type, struct parse_events_er
> >       case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
> >       case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> >       case PARSE_EVENTS__TERM_TYPE_PERCORE:
> > +     case PARSE_EVENTS__TERM_TYPE_CPU:
> >               return true;
> >       case PARSE_EVENTS__TERM_TYPE_USER:
> >       case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
> > @@ -984,6 +1014,15 @@ do {                                             =
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
> > @@ -1111,6 +1150,7 @@ static int config_term_tracepoint(struct perf_eve=
nt_attr *attr,
> >       case PARSE_EVENTS__TERM_TYPE_RAW:
> >       case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> >       case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> > +     case PARSE_EVENTS__TERM_TYPE_CPU:
> >       default:
> >               if (err) {
> >                       parse_events_error__handle(err, term->err_term,
> > @@ -1245,6 +1285,7 @@ do {                                             =
               \
> >               case PARSE_EVENTS__TERM_TYPE_RAW:
> >               case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> >               case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> > +             case PARSE_EVENTS__TERM_TYPE_CPU:
> >               default:
> >                       break;
> >               }
> > @@ -1299,6 +1340,7 @@ static int get_config_chgs(struct perf_pmu *pmu, =
struct parse_events_terms *head
> >               case PARSE_EVENTS__TERM_TYPE_RAW:
> >               case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> >               case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> > +             case PARSE_EVENTS__TERM_TYPE_CPU:
> >               default:
> >                       break;
> >               }
> > @@ -1343,6 +1385,7 @@ static int __parse_events_add_numeric(struct pars=
e_events_state *parse_state,
> >       struct perf_event_attr attr;
> >       LIST_HEAD(config_terms);
> >       const char *name, *metric_id;
> > +     struct perf_cpu_map *cpus;
> >       int ret;
> >
> >       memset(&attr, 0, sizeof(attr));
> > @@ -1364,10 +1407,11 @@ static int __parse_events_add_numeric(struct pa=
rse_events_state *parse_state,
> >
> >       name =3D get_config_name(head_config);
> >       metric_id =3D get_config_metric_id(head_config);
> > +     cpus =3D get_config_cpu(head_config);
> >       ret =3D __add_event(list, &parse_state->idx, &attr, /*init_attr*/=
true, name,
> > -                       metric_id, pmu, &config_terms, /*auto_merge_sta=
ts=3D*/false,
> > -                       /*cpu_list=3D*/NULL, /*alternate_hw_config=3D*/=
PERF_COUNT_HW_MAX
> > -             ) =3D=3D NULL ? -ENOMEM : 0;
> > +                     metric_id, pmu, &config_terms, /*auto_merge_stats=
=3D*/false,
> > +                     cpus, /*alternate_hw_config=3D*/PERF_COUNT_HW_MAX=
) ? 0 : -ENOMEM;
> > +     perf_cpu_map__put(cpus);
> >       free_config_terms(&config_terms);
> >       return ret;
> >  }
> > @@ -1427,6 +1471,7 @@ static int parse_events_add_pmu(struct parse_even=
ts_state *parse_state,
> >       LIST_HEAD(config_terms);
> >       struct parse_events_terms parsed_terms;
> >       bool alias_rewrote_terms =3D false;
> > +     struct perf_cpu_map *term_cpu =3D NULL;
> >
> >       if (verbose > 1) {
> >               struct strbuf sb;
> > @@ -1521,11 +1566,12 @@ static int parse_events_add_pmu(struct parse_ev=
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
=3D*/NULL,
> > -                         alternate_hw_config);
> > +                         &config_terms, auto_merge_stats, term_cpu, al=
ternate_hw_config);
> > +     perf_cpu_map__put(term_cpu);
> >       if (!evsel) {
> >               parse_events_terms__exit(&parsed_terms);
> >               return -ENOMEM;
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-eve=
nts.h
> > index e176a34ab088..ab242f671031 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -80,7 +80,8 @@ enum parse_events__term_type {
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
> > index bf7f73548605..14bff6f9731c 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -324,6 +324,7 @@ aux-output                { return term(yyscanner, =
PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
> >  aux-action           { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
AUX_ACTION); }
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
> > index 6206c8fe2bf9..cffb4eb2696b 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -1400,7 +1400,7 @@ static int pmu_config_term(const struct perf_pmu =
*pmu,
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
> >                       return -EINVAL;
> > -             case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_=
TYPE_HARDWARE:
> > +             case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_=
TYPE_CPU:
> >                       /* Skip non-config terms. */
> >                       break;
> >               default:
> > @@ -1775,6 +1775,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pm=
u, void *state, pmu_format_call
> >               "aux-output",
> >               "aux-action=3D(pause|resume|start-paused)",
> >               "aux-sample-size=3Dnumber",
> > +             "cpu=3Dnumber",
> >       };
> >       struct perf_pmu_format *format;
> >       int ret;
> > --
> > 2.47.1.613.gc27f4b7a9f-goog
> >
