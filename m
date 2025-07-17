Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AE12E36E2
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752710690; cv=none; b=IOt0AMr5b2Y0O+s1sZsO1/hxWxCggclJS8sSpl8U225vrofQaXpdnBSjGjO+W+KzS7+j8QoOLZSS2ExEV8CQk5fnQu3y0N1tnNujUVt2efJCWEukr3DpiKu3QYOCsneWloH+62utb6JowDRXqs+2pqF766pBL59x36Ob6hIDBgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752710690; c=relaxed/simple;
	bh=lcxRenH58TWqsIDOjdCq9tR706F1lVSy50rAUvh/HL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xx6O7QiMG3NPD2SPy9nCJ9NWkOolpxitWbtSItgAd4l4n+MoKKoAjhaXVRIDqE4XXSl0VdOkzn3SWQMRjAiub6jz+aE8gwP9hHdD5/do9x7tKJXLDMDk5eh0bS10CxChxW5WdzYZpJyd8Mu9biirAkLsLb8cFyt9ZhMhmkEZaL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3mUQF4D; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3mUQF4D"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e2429bd4b3so29795ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Jul 2025 17:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752710688; x=1753315488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+JMNU5Wh7zphd6kSgk0HuW7oZVSEvNfSttFiaiKoog=;
        b=L3mUQF4DlmEH+2ScseYBQ2WBYpRBOggYds74/Nd6IRmEN2XMXlnmgrzbOU8Z70kJFX
         Rgkv7ZaC2M/es+k8iRJjnUH39uZqIHWk0CYFYPV2VXpr4Ka0KhJ2FpJcBhRFBMXqAvAh
         fwuE2NjNyJ/TFoubiu1htvlLfdYCmL0ZwEUJ3inqtbRNXbyTL50kzsF48chuzxkpQZsg
         j9+FC93rD1x2G/nODtU7h7ZLQ40VFRgeGQsehPrf+LoJLjyTOVx3BOvmkcguMI5s/C0o
         ftQIBoas8bpl1cSazAvkruLlPjGba6JX0BO/dCnoB+lRap5SO3uprYTnSGVQybZqFQD8
         H1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752710688; x=1753315488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+JMNU5Wh7zphd6kSgk0HuW7oZVSEvNfSttFiaiKoog=;
        b=kRMLP9ZABRHibqtTQ4Gw3ECcGGN3U79Z7SMaPhJCMT9SogqDTR/zYYqEJZCVHYdyEM
         ntPA1p/HkK4rJMmMs/Uu8hIBhRAEvV8nsIIpZoTkGtwTqT7HFkzNuIpKywgWtjDbkKew
         ijQeZoHHQrOqDmb3IPwfprT6fCcJ7/fe/WJN9OxpBg3YqvjjnNwYOJYU6P5ViORtNhF8
         imXauTrv7ExymI/jLv7tOvzAcRA2WQl4W1GS3xAJEYUw4XO/IzIQ4dj5LRsxrB3pXWj1
         RoC10uf7rmAhANpAKoVavlid5pPET/P+183mncq4Mg2LtMKGCeqhNNg7aN52TSgb8+/R
         RsNw==
X-Forwarded-Encrypted: i=1; AJvYcCUHl7i23vBTwAXPO7IRPPRTR8OgLprYRVN3sI7mbm8G7Ow9R3Wa10a4rTfSjLMH/7iCBswKrJeWDKkkTaduE9hs@vger.kernel.org
X-Gm-Message-State: AOJu0YwYKx2NQGLdzMmBgsnSAwU77TcAr9iBaT/Ziavt5tG7upFP+LMM
	W/CBTobJm+aIbFlx6nHzNU1vZQjhC/LXhvIToZ4TyfdVao6jAQQ4JEqbwJNR+iCOGiTJgl1a9IF
	QPEn/9tRtnJa5QVkfDUj23PjT3fCmk79V7tR8MV49
X-Gm-Gg: ASbGnctq++0HmBF1UPBt/a/vE/g8fl92hQfFLMRKNqngmN8X+P0awgsL/EqE6sh0vTt
	XpUw2rC/bT68siEAJOSUUADZnw4MUbHLr16oWabhNWOXb4ULowQl+mLcJFQlvFhakkaL2cjTdje
	vDJM7RGzxCA+hTxiE4DPEI3EszrtDoKhLCwhfLJttPPlDkfgXXZIgrE5Z1skJoA+x8ypRI+MxhB
	1138WBH
X-Google-Smtp-Source: AGHT+IHTAgubRojB/aYMVz3yYDQlirIw60sB3uytuexgfk+xu5o86Dpr7nrpwxbzcz9fZI5xvCCY9oSYgjvRPvZESbQ=
X-Received: by 2002:a05:6e02:184b:b0:3e2:865b:6b64 with SMTP id
 e9e14a558f8ab-3e28ddb52bamr892115ab.3.1752710687317; Wed, 16 Jul 2025
 17:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com> <20250627192417.1157736-13-irogers@google.com>
 <aHgLVcxpEphtYLsB@google.com>
In-Reply-To: <aHgLVcxpEphtYLsB@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Jul 2025 17:04:36 -0700
X-Gm-Features: Ac12FXzmt4pZ9CI7zs8896qHTGAzaVPLQnsq_ByxMFxbsfwIwa9I3Bnl7AmRf4Y
Message-ID: <CAP-5=fV5gtSQOPkOLaAauBcwjgs1ohADs5O3GF+bJOx2tSynwQ@mail.gmail.com>
Subject: Re: [PATCH v1 12/12] perf parse-events: Support user CPUs mixed with threads/processes
To: Namhyung Kim <namhyung@kernel.org>, "Mi, Dapeng1" <dapeng1.mi@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Blake Jones <blakejones@google.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 1:28=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Jun 27, 2025 at 12:24:17PM -0700, Ian Rogers wrote:
> > Counting events system-wide with a specified CPU prior to this change w=
orked:
> > ```
> > $ perf stat -e 'msr/tsc/,msr/tsc,cpu=3Dcpu_core/,msr/tsc,cpu=3Dcpu_atom=
/' -a sleep 1
> >
> >   Performance counter stats for 'system wide':
> >
> >      59,393,419,099      msr/tsc/
> >      33,927,965,927      msr/tsc,cpu=3Dcpu_core/
> >      25,465,608,044      msr/tsc,cpu=3Dcpu_atom/
> > ```
> >
> > However, when counting with process the counts became system wide:
> > ```
> > $ perf stat -e 'msr/tsc/,msr/tsc,cpu=3Dcpu_core/,msr/tsc,cpu=3Dcpu_atom=
/' perf test -F 10
> >  10.1: Basic parsing test                                            : =
Ok
> >  10.2: Parsing without PMU name                                      : =
Ok
> >  10.3: Parsing with PMU name                                         : =
Ok
> >
> >  Performance counter stats for 'perf test -F 10':
> >
> >         59,233,549      msr/tsc/
> >         59,227,556      msr/tsc,cpu=3Dcpu_core/
> >         59,224,053      msr/tsc,cpu=3Dcpu_atom/
> > ```
> >
> > Make the handling of CPU maps with event parsing clearer. When an
> > event is parsed creating an evsel the cpus should be either the PMU's
> > cpumask or user specified CPUs.
> >
> > Update perf_evlist__propagate_maps so that it doesn't clobber the user
> > specified CPUs. Try to make the behavior clearer, firstly fix up
> > missing cpumasks. Next, perform sanity checks and adjustments from the
> > global evlist CPU requests and for the PMU including simplifying to
> > the "any CPU"(-1) value. Finally remove the event if the cpumask is
> > empty.
> >
> > So that events are opened with a CPU and a thread change stat's
> > create_perf_stat_counter to give both.
> >
> > With the change things are fixed:
> > ```
> > $ perf stat --no-scale -e 'msr/tsc/,msr/tsc,cpu=3Dcpu_core/,msr/tsc,cpu=
=3Dcpu_atom/' perf test -F 10
> >  10.1: Basic parsing test                                            : =
Ok
> >  10.2: Parsing without PMU name                                      : =
Ok
> >  10.3: Parsing with PMU name                                         : =
Ok
> >
> >  Performance counter stats for 'perf test -F 10':
> >
> >         63,704,975      msr/tsc/
> >         47,060,704      msr/tsc,cpu=3Dcpu_core/                        =
(4.62%)
> >         16,640,591      msr/tsc,cpu=3Dcpu_atom/                        =
(2.18%)
> > ```
> >
> > However, note the "--no-scale" option is used. This is necessary as
> > the running time for the event on the counter isn't the same as the
> > enabled time because the thread doesn't necessarily run on the CPUs
> > specified for the counter. All counter values are scaled with:
> >
> >   scaled_value =3D value * time_enabled / time_running
> >
> > and so without --no-scale the scaled_value becomes very large. This
> > problem already exists on hybrid systems for the same reason. Here are
> > 2 runs of the same code with an instructions event that counts the
> > same on both types of core, there is no real multiplexing happening on
> > the event:
>
> This is unfortunate.  The event is in a task context but also has a CPU
> constraint.  So it's not schedulable on other CPUs.
>
> A problem is that it cannot distinguish the real multiplexing..
>
> >
> > ```
> > $ perf stat -e instructions perf test -F 10
> > ...
> >  Performance counter stats for 'perf test -F 10':
> >
> >         87,896,447      cpu_atom/instructions/                       (1=
4.37%)
> >         98,171,964      cpu_core/instructions/                       (8=
5.63%)
> > ...
> > $ perf stat --no-scale -e instructions perf test -F 10
> > ...
> >  Performance counter stats for 'perf test -F 10':
> >
> >         13,069,890      cpu_atom/instructions/                       (1=
9.32%)
> >         83,460,274      cpu_core/instructions/                       (8=
0.68%)
> > ...
> > ```
> > The scaling has inflated per-PMU instruction counts and the overall
> > count by 2x.
> >
> > To fix this the kernel needs changing when a task+CPU event (or just
> > task event on hybrid) is scheduled out. A fix could be that the state
> > isn't inactive but off for such events, so that time_enabled counts
> > don't accumulate on them.
>
> Right, maybe we need to add a new state (UNSCHEDULABLE?) to skip
> updating the enabled time.

Right having a new state would mean in __perf_update_times the enabled
and time wouldn't increase if the filter happened:
https://web.git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/kernel=
/events/core.c#n716
```
enum perf_event_state state =3D __perf_effective_state(event);
u64 delta =3D now - event->tstamp;

*enabled =3D event->total_time_enabled;
if (state >=3D PERF_EVENT_STATE_INACTIVE)
        *enabled +=3D delta;

*running =3D event->total_time_running;
if (state >=3D PERF_EVENT_STATE_ACTIVE)
        *running +=3D delta;
```

I sent out this RFC patch that just about makes this change:
https://lore.kernel.org/lkml/20250716223924.825772-1-irogers@google.com/
but for now it seems the only workaround is to use `--no-scale` :-(
This series is still necessary for the hybrid TMA fix for msr/tsc/.

Thanks,
Ian


> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/evlist.c        | 118 ++++++++++++++++++++++-----------
> >  tools/perf/util/parse-events.c |  10 ++-
> >  tools/perf/util/stat.c         |   6 +-
> >  3 files changed, 86 insertions(+), 48 deletions(-)
> >
> > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > index 9d9dec21f510..2d2236400220 100644
> > --- a/tools/lib/perf/evlist.c
> > +++ b/tools/lib/perf/evlist.c
> > @@ -36,49 +36,87 @@ void perf_evlist__init(struct perf_evlist *evlist)
> >  static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
> >                                         struct perf_evsel *evsel)
> >  {
> > -     if (evsel->system_wide) {
> > -             /* System wide: set the cpu map of the evsel to all onlin=
e CPUs. */
> > -             perf_cpu_map__put(evsel->cpus);
> > -             evsel->cpus =3D perf_cpu_map__new_online_cpus();
> > -     } else if (evlist->has_user_cpus && evsel->is_pmu_core) {
> > -             /*
> > -              * User requested CPUs on a core PMU, ensure the requeste=
d CPUs
> > -              * are valid by intersecting with those of the PMU.
> > -              */
> > +     if (perf_cpu_map__is_empty(evsel->cpus)) {
> > +             if (perf_cpu_map__is_empty(evsel->pmu_cpus)) {
> > +                     /*
> > +                      * Assume the unset PMU cpus were for a system-wi=
de
> > +                      * event, like a software or tracepoint.
> > +                      */
> > +                     evsel->pmu_cpus =3D perf_cpu_map__new_online_cpus=
();
> > +             }
> > +             if (evlist->has_user_cpus && !evsel->system_wide) {
> > +                     /*
> > +                      * Use the user CPUs unless the evsel is set to b=
e
> > +                      * system wide, such as the dummy event.
> > +                      */
> > +                     evsel->cpus =3D perf_cpu_map__get(evlist->user_re=
quested_cpus);
> > +             } else {
> > +                     /*
> > +                      * System wide and other modes, assume the cpu ma=
p
> > +                      * should be set to all PMU CPUs.
> > +                      */
> > +                     evsel->cpus =3D perf_cpu_map__get(evsel->pmu_cpus=
);
> > +             }
> > +     }
> > +     /*
> > +      * Avoid "any CPU"(-1) for uncore and PMUs that require a CPU, ev=
en if
> > +      * requested.
> > +      */
> > +     if (evsel->requires_cpu && perf_cpu_map__has_any_cpu(evsel->cpus)=
) {
> >               perf_cpu_map__put(evsel->cpus);
> > -             evsel->cpus =3D perf_cpu_map__intersect(evlist->user_requ=
ested_cpus, evsel->pmu_cpus);
> > +             evsel->cpus =3D perf_cpu_map__get(evsel->pmu_cpus);
> > +     }
> >
> > -             /*
> > -              * Empty cpu lists would eventually get opened as "any" s=
o remove
> > -              * genuinely empty ones before they're opened in the wron=
g place.
> > -              */
> > -             if (perf_cpu_map__is_empty(evsel->cpus)) {
> > -                     struct perf_evsel *next =3D perf_evlist__next(evl=
ist, evsel);
> > -
> > -                     perf_evlist__remove(evlist, evsel);
> > -                     /* Keep idx contiguous */
> > -                     if (next)
> > -                             list_for_each_entry_from(next, &evlist->e=
ntries, node)
> > -                                     next->idx--;
> > +     /*
> > +      * Globally requested CPUs replace user requested unless the evse=
l is
> > +      * set to be system wide.
> > +      */
> > +     if (evlist->has_user_cpus && !evsel->system_wide) {
> > +             assert(!perf_cpu_map__has_any_cpu(evlist->user_requested_=
cpus));
> > +             if (!perf_cpu_map__equal(evsel->cpus, evlist->user_reques=
ted_cpus)) {
> > +                     perf_cpu_map__put(evsel->cpus);
> > +                     evsel->cpus =3D perf_cpu_map__get(evlist->user_re=
quested_cpus);
> >               }
> > -     } else if (!evsel->pmu_cpus || evlist->has_user_cpus ||
> > -             (!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist=
->user_requested_cpus))) {
> > -             /*
> > -              * The PMU didn't specify a default cpu map, this isn't a=
 core
> > -              * event and the user requested CPUs or the evlist user
> > -              * requested CPUs have the "any CPU" (aka dummy) CPU valu=
e. In
> > -              * which case use the user requested CPUs rather than the=
 PMU
> > -              * ones.
> > -              */
> > +     }
> > +
> > +     /* Ensure cpus only references valid PMU CPUs. */
> > +     if (!perf_cpu_map__has_any_cpu(evsel->cpus) &&
> > +         !perf_cpu_map__is_subset(evsel->pmu_cpus, evsel->cpus)) {
> > +             struct perf_cpu_map *tmp =3D perf_cpu_map__intersect(evse=
l->pmu_cpus, evsel->cpus);
> > +
> >               perf_cpu_map__put(evsel->cpus);
> > -             evsel->cpus =3D perf_cpu_map__get(evlist->user_requested_=
cpus);
> > -     } else if (evsel->cpus !=3D evsel->pmu_cpus) {
> > -             /*
> > -              * No user requested cpu map but the PMU cpu map doesn't =
match
> > -              * the evsel's. Reset it back to the PMU cpu map.
> > -              */
> > +             evsel->cpus =3D tmp;
> > +     }
> > +
> > +     /*
> > +      * Was event requested on all the PMU's CPUs but the user request=
ed is
> > +      * any CPU (-1)? If so switch to using any CPU (-1) to reduce the=
 number
> > +      * of events.
> > +      */
> > +     if (!evsel->system_wide &&
> > +         perf_cpu_map__equal(evsel->cpus, evsel->pmu_cpus) &&
> > +         perf_cpu_map__has_any_cpu(evlist->user_requested_cpus)) {
> >               perf_cpu_map__put(evsel->cpus);
> > -             evsel->cpus =3D perf_cpu_map__get(evsel->pmu_cpus);
> > +             evsel->cpus =3D perf_cpu_map__get(evlist->user_requested_=
cpus);
> > +     }
> > +
> > +     /* Sanity check assert before the evsel is potentially removed. *=
/
> > +     assert(!evsel->requires_cpu || !perf_cpu_map__has_any_cpu(evsel->=
cpus));
> > +
> > +     /*
> > +      * Empty cpu lists would eventually get opened as "any" so remove
> > +      * genuinely empty ones before they're opened in the wrong place.
> > +      */
> > +     if (perf_cpu_map__is_empty(evsel->cpus)) {
> > +             struct perf_evsel *next =3D perf_evlist__next(evlist, evs=
el);
> > +
> > +             perf_evlist__remove(evlist, evsel);
> > +             /* Keep idx contiguous */
> > +             if (next)
> > +                     list_for_each_entry_from(next, &evlist->entries, =
node)
> > +                             next->idx--;
> > +
> > +             return;
> >       }
> >
> >       if (evsel->system_wide) {
> > @@ -98,6 +136,10 @@ static void perf_evlist__propagate_maps(struct perf=
_evlist *evlist)
> >
> >       evlist->needs_map_propagation =3D true;
> >
> > +     /* Clear the all_cpus set which will be merged into during propag=
ation. */
> > +     perf_cpu_map__put(evlist->all_cpus);
> > +     evlist->all_cpus =3D NULL;
> > +
> >       list_for_each_entry_safe(evsel, n, &evlist->entries, node)
> >               __perf_evlist__propagate_maps(evlist, evsel);
> >  }
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 4092a43aa84e..0ff7ae75d8f9 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -313,20 +313,18 @@ __add_event(struct list_head *list, int *idx,
> >       if (pmu) {
> >               is_pmu_core =3D pmu->is_core;
> >               pmu_cpus =3D perf_cpu_map__get(pmu->cpus);
> > +             if (perf_cpu_map__is_empty(pmu_cpus))
> > +                     pmu_cpus =3D cpu_map__online();
> >       } else {
> >               is_pmu_core =3D (attr->type =3D=3D PERF_TYPE_HARDWARE ||
> >                              attr->type =3D=3D PERF_TYPE_HW_CACHE);
> >               pmu_cpus =3D is_pmu_core ? cpu_map__online() : NULL;
> >       }
> >
> > -     if (has_user_cpus) {
> > +     if (has_user_cpus)
> >               cpus =3D perf_cpu_map__get(user_cpus);
> > -             /* Existing behavior that pmu_cpus matches the given user=
 ones. */
> > -             perf_cpu_map__put(pmu_cpus);
> > -             pmu_cpus =3D perf_cpu_map__get(user_cpus);
> > -     } else {
> > +     else
> >               cpus =3D perf_cpu_map__get(pmu_cpus);
> > -     }
> >
> >       if (init_attr)
> >               event_attr_init(attr);
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index 355a7d5c8ab8..8d3bcdb69d37 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -769,8 +769,6 @@ int create_perf_stat_counter(struct evsel *evsel,
> >                       attr->enable_on_exec =3D 1;
> >       }
> >
> > -     if (target__has_cpu(target) && !target__has_per_thread(target))
> > -             return evsel__open_per_cpu(evsel, evsel__cpus(evsel), cpu=
_map_idx);
> > -
> > -     return evsel__open_per_thread(evsel, evsel->core.threads);
> > +     return evsel__open_per_cpu_and_thread(evsel, evsel__cpus(evsel), =
cpu_map_idx,
> > +                                           evsel->core.threads);
> >  }
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
