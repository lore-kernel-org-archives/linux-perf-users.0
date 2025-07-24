Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE62E92DE
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369953; cv=none; b=YZ2/x0ZZquTD3DUhXkijeaBCVxVoIVmPT72Ps3ZGqd/GxOFDgbx1Qze7dNnKr1YIsdp57tWvx/91PBcr+8ksYUtWB7D/TmNeFDntu54y0DtXodfWBtjOnwRgaCUI3wFKDQ/agN/qgGpDNcFX31JOzXgu7kc/7ui8bdkoXxe2ocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369953; c=relaxed/simple;
	bh=cN2tNQUQ5DSmY+J8rfKkrRDzTaR0TurOmUh791JJygA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=l4Qy5sb6yLbDGP05YTDzJraaAbiUfA7CxMjLdh7NdUWfHYhJgjrlxCgXjVMUHXu7srDeZCycvi15KRPFLrysn8jnausC+8D1L26xaYwI74B1QS9HnqnduTAOXveTs91odjwuiCae8z9/RLQJ52rgM+Gqn4gQVB2oueix6oSFfsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NsQk3cq0; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NsQk3cq0"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3df371e1d29so121585ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 08:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753369951; x=1753974751; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SCZwlN1DZ4gYURnYlbzXQh7CPK4WG0l5dNr+tbXPnQ=;
        b=NsQk3cq0y6oi0pU4zOUaUfS4c5Z3j3LruojJ0IlWqzJ4xXicaYINb62Hwg/Q4Q0CXx
         S27Uc7ZcZxV+uVh4At/v5iL4CY3k6MBrTU4299GYIIjMTF3/Ou8b9vi1ys7wC4L6cohx
         bioInEdZmCfn23oM7ORXIvfpQ0g8i5xGqqadbdCT/8ZKJbzQeX/HhGErC7wPkQWATFAZ
         Gi1LPUUetymROzVgLVmBy0k03fApM7n0lgVKzUY9P4NRI98WlMlpMUcUL3Dch4NnHmny
         34iroC8f7QjgJILXAmAK7cVYGr/7sAgD2MngozfDfbCzsUCPiiNoabJ/fg+H3UHzf6yt
         XpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753369951; x=1753974751;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SCZwlN1DZ4gYURnYlbzXQh7CPK4WG0l5dNr+tbXPnQ=;
        b=N6dbSmIm0nx3Jt/JFgONT6Y29Je8iMV/Z8dVTyN9zMpBgQOW2atv/NFyy68C4uXmSg
         q+KXxreUP8PYRW/wUb1Bz0AGyzSNsbFxq8gYI+cz7A/9MTc/194Ru/BM8LJg5J2MBxEw
         /tTCYe2TZQiWzn0biILNpk+3Tn3nqB1Osy1PWup6U5gvluUEtAiuAB1iYrepHL7VOEGA
         mFurfRHsypbv5IQ9tVckpilfHA3tb4dAyAn8AVgeDKfjKndlaQhHLnCiqhA0413vc4ly
         29EHzX0YsjkRuhurbKukw9/fnKKW7vN1N/45pthmozwp4Kxin7knnCgrnobzglkqrMX0
         yIYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfgLI1E8uV0MXcOHrPwUWkg/N1Mot9NeVwjQsQH/oQ8aaryqfc289lmB68GelJ25ahKC0RfbzNX1m2PfaiY4DH@vger.kernel.org
X-Gm-Message-State: AOJu0YwvaJRDlTssGmRfFlyDxaWOtBdEcv668AMHKcsgU3Io62R1xKta
	O+iF8zIvVIvFRnEjqi+qhysO6cq2S9xzPJH5d6D0pUAPbQeXrNPflQ/hCCYkamqipMpe0vWT+Y1
	zHs1OJQf4VD4gXeFov8jV5WErCkRfzOgj2poOWBET
X-Gm-Gg: ASbGnctVJsNnKNN1Ku/ZzouKLJK5cpWyfDKaNhfQrnyobrgHIfGNQRKJqSyO/ma3Lzi
	DtpM+rnZjk8bTkewH3PfbG4xwMZ0x11CYjvhIQjdltR7DG+kYyefhDrrJDbHK983sgmOFxv3ts9
	/ymzkzUjVFhQHemxzlQzzhK096xWvbkov9kVhh6jfiw6gyY1V4I7GvTgdrguRLJMGDyiLC1WwmE
	UKlBCcxq91hhtgQ5WMpQ9smTrJTMDZNyryxRvhRaCneME8=
X-Google-Smtp-Source: AGHT+IH/NIQ93QkBUfEnqfXy7dRKNawAHkt5I0iRXm4p6DBT05rQ+OQP4NlR+mbjFGdQULHJ+2zja/Nh6U5dtUjYfOQ=
X-Received: by 2002:a05:6e02:3707:b0:3e3:a594:f0e4 with SMTP id
 e9e14a558f8ab-3e3b64c0d4cmr4850395ab.16.1753369950576; Thu, 24 Jul 2025
 08:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719030517.1990983-1-irogers@google.com> <20250719030517.1990983-13-irogers@google.com>
In-Reply-To: <20250719030517.1990983-13-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 24 Jul 2025 08:12:19 -0700
X-Gm-Features: Ac12FXxPpxrfApDu0c01skJYTXU8rS_dNJgcQlToNVfyL4nBX2N9h0is6tM5i4Y
Message-ID: <CAP-5=fWqEWeKM585esEHJGJyrxn6bz-yucrEqBWE5eqmCuccTA@mail.gmail.com>
Subject: Re: [PATCH v3 12/15] perf parse-events: Support user CPUs mixed with threads/processes
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 8:05=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Counting events system-wide with a specified CPU prior to this change
> worked:
> ```
> $ perf stat -e 'msr/tsc/,msr/tsc,cpu=3Dcpu_core/,msr/tsc,cpu=3Dcpu_atom/'=
 -a sleep 1
>
>   Performance counter stats for 'system wide':
>
>      59,393,419,099      msr/tsc/
>      33,927,965,927      msr/tsc,cpu=3Dcpu_core/
>      25,465,608,044      msr/tsc,cpu=3Dcpu_atom/
> ```
>
> However, when counting with process the counts became system wide:
> ```
> $ perf stat -e 'msr/tsc/,msr/tsc,cpu=3Dcpu_core/,msr/tsc,cpu=3Dcpu_atom/'=
 perf test -F 10
>  10.1: Basic parsing test                                            : Ok
>  10.2: Parsing without PMU name                                      : Ok
>  10.3: Parsing with PMU name                                         : Ok
>
>  Performance counter stats for 'perf test -F 10':
>
>         59,233,549      msr/tsc/
>         59,227,556      msr/tsc,cpu=3Dcpu_core/
>         59,224,053      msr/tsc,cpu=3Dcpu_atom/
> ```
>
> Make the handling of CPU maps with event parsing clearer. When an
> event is parsed creating an evsel the cpus should be either the PMU's
> cpumask or user specified CPUs.
>
> Update perf_evlist__propagate_maps so that it doesn't clobber the user
> specified CPUs. Try to make the behavior clearer, firstly fix up
> missing cpumasks. Next, perform sanity checks and adjustments from the
> global evlist CPU requests and for the PMU including simplifying to
> the "any CPU"(-1) value. Finally remove the event if the cpumask is
> empty.
>
> So that events are opened with a CPU and a thread change stat's
> create_perf_stat_counter to give both.
>
> With the change things are fixed:
> ```
> $ perf stat --no-scale -e 'msr/tsc/,msr/tsc,cpu=3Dcpu_core/,msr/tsc,cpu=
=3Dcpu_atom/' perf test -F 10
>  10.1: Basic parsing test                                            : Ok
>  10.2: Parsing without PMU name                                      : Ok
>  10.3: Parsing with PMU name                                         : Ok
>
>  Performance counter stats for 'perf test -F 10':
>
>         63,704,975      msr/tsc/
>         47,060,704      msr/tsc,cpu=3Dcpu_core/                        (4=
.62%)
>         16,640,591      msr/tsc,cpu=3Dcpu_atom/                        (2=
.18%)
> ```
>
> However, note the "--no-scale" option is used. This is necessary as
> the running time for the event on the counter isn't the same as the
> enabled time because the thread doesn't necessarily run on the CPUs
> specified for the counter. All counter values are scaled with:
>
>   scaled_value =3D value * time_enabled / time_running
>
> and so without --no-scale the scaled_value becomes very large. This
> problem already exists on hybrid systems for the same reason. Here are
> 2 runs of the same code with an instructions event that counts the
> same on both types of core, there is no real multiplexing happening on
> the event:
>
> ```
> $ perf stat -e instructions perf test -F 10
> ...
>  Performance counter stats for 'perf test -F 10':
>
>         87,896,447      cpu_atom/instructions/                       (14.=
37%)
>         98,171,964      cpu_core/instructions/                       (85.=
63%)
> ...
> $ perf stat --no-scale -e instructions perf test -F 10
> ...
>  Performance counter stats for 'perf test -F 10':
>
>         13,069,890      cpu_atom/instructions/                       (19.=
32%)
>         83,460,274      cpu_core/instructions/                       (80.=
68%)
> ...
> ```
> The scaling has inflated per-PMU instruction counts and the overall
> count by 2x.
>
> To fix this the kernel needs changing when a task+CPU event (or just
> task event on hybrid) is scheduled out. A fix could be that the state
> isn't inactive but off for such events, so that time_enabled counts
> don't accumulate on them.
>
> Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/evlist.c        | 119 ++++++++++++++++++++++-----------
>  tools/perf/util/parse-events.c |  10 ++-
>  tools/perf/util/stat.c         |   6 +-
>  3 files changed, 87 insertions(+), 48 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 9d9dec21f510..3ed023f4b190 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -36,49 +36,88 @@ void perf_evlist__init(struct perf_evlist *evlist)
>  static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>                                           struct perf_evsel *evsel)
>  {
> -       if (evsel->system_wide) {
> -               /* System wide: set the cpu map of the evsel to all onlin=
e CPUs. */
> -               perf_cpu_map__put(evsel->cpus);
> -               evsel->cpus =3D perf_cpu_map__new_online_cpus();
> -       } else if (evlist->has_user_cpus && evsel->is_pmu_core) {
> -               /*
> -                * User requested CPUs on a core PMU, ensure the requeste=
d CPUs
> -                * are valid by intersecting with those of the PMU.
> -                */
> +       if (perf_cpu_map__is_empty(evsel->cpus)) {
> +               if (perf_cpu_map__is_empty(evsel->pmu_cpus)) {
> +                       /*
> +                        * Assume the unset PMU cpus were for a system-wi=
de
> +                        * event, like a software or tracepoint.
> +                        */
> +                       evsel->pmu_cpus =3D perf_cpu_map__new_online_cpus=
();

Note, I'd like to follow this change up and remove the code above.
This isn't currently possible because of the assumptions of software
events. It is possible for a PMU to have an empty cpumask in a
situation like a hybrid machine and you've made all of one core type
off-line. By making this case be all online CPUs then the offline
PMU's events (say cpu_atom) can end up trying to be programmed on the
online PMU's CPUs (say cpu_core) and fail at perf_event_open. This can
easily happen for metrics that are defined on both core types.

Thanks,
Ian

> +               }
> +               if (evlist->has_user_cpus && !evsel->system_wide) {
> +                       /*
> +                        * Use the user CPUs unless the evsel is set to b=
e
> +                        * system wide, such as the dummy event.
> +                        */
> +                       evsel->cpus =3D perf_cpu_map__get(evlist->user_re=
quested_cpus);
> +               } else {
> +                       /*
> +                        * System wide and other modes, assume the cpu ma=
p
> +                        * should be set to all PMU CPUs.
> +                        */
> +                       evsel->cpus =3D perf_cpu_map__get(evsel->pmu_cpus=
);
> +               }
> +       }
> +       /*
> +        * Avoid "any CPU"(-1) for uncore and PMUs that require a CPU, ev=
en if
> +        * requested.
> +        */
> +       if (evsel->requires_cpu && perf_cpu_map__has_any_cpu(evsel->cpus)=
) {
>                 perf_cpu_map__put(evsel->cpus);
> -               evsel->cpus =3D perf_cpu_map__intersect(evlist->user_requ=
ested_cpus, evsel->pmu_cpus);
> +               evsel->cpus =3D perf_cpu_map__get(evsel->pmu_cpus);
> +       }
>
> -               /*
> -                * Empty cpu lists would eventually get opened as "any" s=
o remove
> -                * genuinely empty ones before they're opened in the wron=
g place.
> -                */
> -               if (perf_cpu_map__is_empty(evsel->cpus)) {
> -                       struct perf_evsel *next =3D perf_evlist__next(evl=
ist, evsel);
> -
> -                       perf_evlist__remove(evlist, evsel);
> -                       /* Keep idx contiguous */
> -                       if (next)
> -                               list_for_each_entry_from(next, &evlist->e=
ntries, node)
> -                                       next->idx--;
> +       /*
> +        * Globally requested CPUs replace user requested unless the evse=
l is
> +        * set to be system wide.
> +        */
> +       if (evlist->has_user_cpus && !evsel->system_wide) {
> +               assert(!perf_cpu_map__has_any_cpu(evlist->user_requested_=
cpus));
> +               if (!perf_cpu_map__equal(evsel->cpus, evlist->user_reques=
ted_cpus)) {
> +                       perf_cpu_map__put(evsel->cpus);
> +                       evsel->cpus =3D perf_cpu_map__get(evlist->user_re=
quested_cpus);
>                 }
> -       } else if (!evsel->pmu_cpus || evlist->has_user_cpus ||
> -               (!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist=
->user_requested_cpus))) {
> -               /*
> -                * The PMU didn't specify a default cpu map, this isn't a=
 core
> -                * event and the user requested CPUs or the evlist user
> -                * requested CPUs have the "any CPU" (aka dummy) CPU valu=
e. In
> -                * which case use the user requested CPUs rather than the=
 PMU
> -                * ones.
> -                */
> +       }
> +
> +       /* Ensure cpus only references valid PMU CPUs. */
> +       if (!perf_cpu_map__has_any_cpu(evsel->cpus) &&
> +           !perf_cpu_map__is_subset(evsel->pmu_cpus, evsel->cpus)) {
> +               struct perf_cpu_map *tmp =3D perf_cpu_map__intersect(evse=
l->pmu_cpus, evsel->cpus);
> +
>                 perf_cpu_map__put(evsel->cpus);
> -               evsel->cpus =3D perf_cpu_map__get(evlist->user_requested_=
cpus);
> -       } else if (evsel->cpus !=3D evsel->pmu_cpus) {
> -               /*
> -                * No user requested cpu map but the PMU cpu map doesn't =
match
> -                * the evsel's. Reset it back to the PMU cpu map.
> -                */
> +               evsel->cpus =3D tmp;
> +       }
> +
> +       /*
> +        * Was event requested on all the PMU's CPUs but the user request=
ed is
> +        * any CPU (-1)? If so switch to using any CPU (-1) to reduce the=
 number
> +        * of events.
> +        */
> +       if (!evsel->system_wide &&
> +           !evsel->requires_cpu &&
> +           perf_cpu_map__equal(evsel->cpus, evsel->pmu_cpus) &&
> +           perf_cpu_map__has_any_cpu(evlist->user_requested_cpus)) {
>                 perf_cpu_map__put(evsel->cpus);
> -               evsel->cpus =3D perf_cpu_map__get(evsel->pmu_cpus);
> +               evsel->cpus =3D perf_cpu_map__get(evlist->user_requested_=
cpus);
> +       }
> +
> +       /* Sanity check assert before the evsel is potentially removed. *=
/
> +       assert(!evsel->requires_cpu || !perf_cpu_map__has_any_cpu(evsel->=
cpus));
> +
> +       /*
> +        * Empty cpu lists would eventually get opened as "any" so remove
> +        * genuinely empty ones before they're opened in the wrong place.
> +        */
> +       if (perf_cpu_map__is_empty(evsel->cpus)) {
> +               struct perf_evsel *next =3D perf_evlist__next(evlist, evs=
el);
> +
> +               perf_evlist__remove(evlist, evsel);
> +               /* Keep idx contiguous */
> +               if (next)
> +                       list_for_each_entry_from(next, &evlist->entries, =
node)
> +                               next->idx--;
> +
> +               return;
>         }
>
>         if (evsel->system_wide) {
> @@ -98,6 +137,10 @@ static void perf_evlist__propagate_maps(struct perf_e=
vlist *evlist)
>
>         evlist->needs_map_propagation =3D true;
>
> +       /* Clear the all_cpus set which will be merged into during propag=
ation. */
> +       perf_cpu_map__put(evlist->all_cpus);
> +       evlist->all_cpus =3D NULL;
> +
>         list_for_each_entry_safe(evsel, n, &evlist->entries, node)
>                 __perf_evlist__propagate_maps(evlist, evsel);
>  }
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index bd2d831d5123..fe2073c6b549 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -310,20 +310,18 @@ __add_event(struct list_head *list, int *idx,
>         if (pmu) {
>                 is_pmu_core =3D pmu->is_core;
>                 pmu_cpus =3D perf_cpu_map__get(pmu->cpus);
> +               if (perf_cpu_map__is_empty(pmu_cpus))
> +                       pmu_cpus =3D cpu_map__online();
>         } else {
>                 is_pmu_core =3D (attr->type =3D=3D PERF_TYPE_HARDWARE ||
>                                attr->type =3D=3D PERF_TYPE_HW_CACHE);
>                 pmu_cpus =3D is_pmu_core ? cpu_map__online() : NULL;
>         }
>
> -       if (has_user_cpus) {
> +       if (has_user_cpus)
>                 cpus =3D perf_cpu_map__get(user_cpus);
> -               /* Existing behavior that pmu_cpus matches the given user=
 ones. */
> -               perf_cpu_map__put(pmu_cpus);
> -               pmu_cpus =3D perf_cpu_map__get(user_cpus);
> -       } else {
> +       else
>                 cpus =3D perf_cpu_map__get(pmu_cpus);
> -       }
>
>         if (init_attr)
>                 event_attr_init(attr);
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index b0205e99a4c9..50b1a92d16df 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -769,8 +769,6 @@ int create_perf_stat_counter(struct evsel *evsel,
>                         attr->enable_on_exec =3D 1;
>         }
>
> -       if (target__has_cpu(target) && !target__has_per_thread(target))
> -               return evsel__open_per_cpu(evsel, evsel__cpus(evsel), cpu=
_map_idx);
> -
> -       return evsel__open_per_thread(evsel, evsel->core.threads);
> +       return evsel__open_per_cpu_and_thread(evsel, evsel__cpus(evsel), =
cpu_map_idx,
> +                                             evsel->core.threads);
>  }
> --
> 2.50.0.727.gbf7dc18ff4-goog
>
