Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="19ngTHNV"
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9D9BD
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 14:12:41 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso1487a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 14:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702419160; x=1703023960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cks51YM0UKyckZloGW9xq/gv3l7nlcfYyHgSc2Hh0TE=;
        b=19ngTHNVv8mlYeA4Op3uITxGKXA3b1tmg9K/fTu7VFQeWrtIah7eKriskXtW/PaxiV
         bYt8iIe9GOsFRRsQm5gkR72R9m5EmoL8VXT45hQABqXXqbfMiukcHl8fXlLcIpQpO0wa
         PepR3cJbjkL80mThin/3d9yOPGdDmJqLYsiGtjB5FpoMjtw2UcfaMCOxaIrgIdLVs5pa
         rxSPzq+rTknwbOiTYC9mPsvJ8isznQgQ/6HmOHHkQH906RVfQWP5qurIY7DmxwbQNRn8
         B52DJfxzoID7A+PjWYNMJXfB/I0ZrlFkvXHfxvVVE4k0dyyG8xxBrRTQ/EOowP2maeA0
         7o6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419160; x=1703023960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cks51YM0UKyckZloGW9xq/gv3l7nlcfYyHgSc2Hh0TE=;
        b=orvhsAU1L9jMxBs3MZ3cVvDrdFUiSB/qcSLAjZeQ0RXHIUik2CGh6/Fwv8iwRcsBCm
         wi74mDdfNZdxcLnk+9iOc7Tf4WLkwP34Z+elI6+6EvCZjsfBZOgvvNiVAsaZzCVPT2KK
         3yADHzQXCqotO41jGaYKxX0ryzlrCzlZSfGzVL95/Q65676ulYj68kPznzxl7NBy0wnu
         bmPkVI02wgicQPKCspc7pyRgjvHV5dlXJ5J4CStafgcYrz8w7gbjGwKQu8nUENx4atJS
         e6cf+AHJas9hN/h/mmwM1L4CsAj+yn/ubB0LRCLoMSBMAYnfhDsDVKDuE7If174mquLp
         3+sQ==
X-Gm-Message-State: AOJu0YzcIi/HBPMW9wIi6sRWQrBHcLOc3YE3A7cd3KQl7af+4x1JTy9E
	l4+z7pxwCqHT8OIYhoDEVUgmNuMOWe5+4X7uip+ynw==
X-Google-Smtp-Source: AGHT+IF3yLnso16rdyhcMLLN9D0e3Wjogglt21LQD5Hss1z5ysbNndCPVrF7FCR53v1hYWLvdC1D9AEWOUEiGoK+COk=
X-Received: by 2002:aa7:d4d6:0:b0:551:d490:2748 with SMTP id
 t22-20020aa7d4d6000000b00551d4902748mr78706edr.5.1702419159394; Tue, 12 Dec
 2023 14:12:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212193833.415110-1-kan.liang@linux.intel.com>
 <CAP-5=fWCgjCC-DHHx+HJCuYk6vNn9Lf9EKcnBBZQ+xmnyYnmPg@mail.gmail.com> <996ec30b-2bcf-4739-bec0-728c7f7af2ac@linux.intel.com>
In-Reply-To: <996ec30b-2bcf-4739-bec0-728c7f7af2ac@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 Dec 2023 14:12:27 -0800
Message-ID: <CAP-5=fVnH0eTEvvNbKLF9xYye5Pu8hvDL4ruoxh5xG76+B8WFQ@mail.gmail.com>
Subject: Re: [PATCH V2] perf top: Use evsel's cpus to replace user_requested_cpus
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, maz@kernel.org, 
	marcan@marcan.st, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 1:25=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-12-12 3:37 p.m., Ian Rogers wrote:
> > On Tue, Dec 12, 2023 at 11:39=E2=80=AFAM <kan.liang@linux.intel.com> wr=
ote:
> >>
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> perf top errors out on a hybrid machine
> >>  $perf top
> >>
> >>  Error:
> >>  The cycles:P event is not supported.
> >>
> >> The perf top expects that the "cycles" is collected on all CPUs in the
> >> system. But for hybrid there is no single "cycles" event which can cov=
er
> >> all CPUs. Perf has to split it into two cycles events, e.g.,
> >> cpu_core/cycles/ and cpu_atom/cycles/. Each event has its own CPU mask=
.
> >> If a event is opened on the unsupported CPU. The open fails. That's th=
e
> >> reason of the above error out.
> >>
> >> Perf should only open the cycles event on the corresponding CPU. The
> >> commit ef91871c960e ("perf evlist: Propagate user CPU maps intersectin=
g
> >> core PMU maps") intersect the requested CPU map with the CPU map of th=
e
> >> PMU. Use the evsel's cpus to replace user_requested_cpus.
> >>
> >> The evlist's threads are also propagated to the evsel's threads in
> >> __perf_evlist__propagate_maps(). For a system-wide event, perf appends
> >> a dummy event and assign it to the evsel's threads. For a per-thread
> >> event, the evlist's thread_map is assigned to the evsel's threads. The
> >> same as the other tools, e.g., perf record, using the evsel's threads
> >> when opening an event.
> >>
> >> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> Closes: https://lore.kernel.org/linux-perf-users/ZXNnDrGKXbEELMXV@kern=
el.org/
> >> Reviewed-by: Ian Rogers <irogers@google.com>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> ---
> >>
> >> Changes since V1:
> >> - Update the description
> >> - Add Reviewed-by from Ian
> >
> > Thanks Kan, quick question. Does "perf top" on hybrid ask the user to
> > select between the cycles event on cpu_atom and cpu_core?
>
> Yes, but the event doesn't include the PMU information.
> We probably need a follow up patch to append the PMU name.
>
> Available samples
> 385 cycles:P
>
> 903 cycles:P

Thanks and agreed, it isn't possible to tell which is which PMU/CPU
type at the moment. I tried the patch with perf top --stdio, there
wasn't a choice of event  and I can't tell what counter is being
displayed. When I quit I also see:
```
exiting.
corrupted double-linked list
Aborted (core dumped)
```
but I wasn't able to repro this on a debuggable binary/system.

If my memory serves there was a patch where perf top was showing >1
event. It would be nice here to do some kind of hybrid merging rather
than having to view each PMU's top separately.

Thanks,
Ian


> Thanks,
> Kan
>
> > I'm
> > wondering if there is some kind of missing "hybrid-merge"
> > functionality like we have for perf stat.
> >
> > Thanks,
> > Ian
> >
> >>  tools/perf/builtin-top.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> >> index ea8c7eca5eee..cce9350177e2 100644
> >> --- a/tools/perf/builtin-top.c
> >> +++ b/tools/perf/builtin-top.c
> >> @@ -1027,8 +1027,8 @@ static int perf_top__start_counters(struct perf_=
top *top)
> >>
> >>         evlist__for_each_entry(evlist, counter) {
> >>  try_again:
> >> -               if (evsel__open(counter, top->evlist->core.user_reques=
ted_cpus,
> >> -                                    top->evlist->core.threads) < 0) {
> >> +               if (evsel__open(counter, counter->core.cpus,
> >> +                               counter->core.threads) < 0) {
> >>
> >>                         /*
> >>                          * Specially handle overwrite fall back.
> >> --
> >> 2.35.1
> >>
