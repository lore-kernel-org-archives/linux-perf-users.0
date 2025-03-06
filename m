Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58F71FF7C4
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Mar 2025 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281946; cv=none; b=Ik/Bb3YPcFoK2Brf9f8PNNcBTwfgMA17XB8YTW2BKTLuL4t2Ya2iqJVbriH4NoIj+po0fYq+ExrD5z3eOwKJ2FPhTxTZRBPANn/SQZiSGP+ntys51Gkc8PIKHp2MXHiaDxQAWZJaIqSrsQPzYye64FMpE5I+YTXdwz23CJ5q5Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281946; c=relaxed/simple;
	bh=4y5CKLOFYsgEvaUVDJFTAKqyglT/sOqbipANDWLGmbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkoC9YSyfFwM3Up7cbXAOj1dafRjLy92Jo+2GNS4BGZE04JL58OhygEHG1vKB1PWt0TWDe32oW7POpIiDGd91tOEgRcKqjEwXA/Q/nWDHHp/1IW5GYqdo/jwOICpl01zoqkBVZhE8rjBmxjEw3mj/EWjLEBASvguSfMY5yxwfrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y8HlyCAs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y8HlyCAs"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2240aad70f2so194625ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Mar 2025 09:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741281944; x=1741886744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDX5azaNCVN3xqFvG7UlweG4Vw/2ljxh71GMAIeJGvU=;
        b=y8HlyCAsYGHjlmEUXPut0r8kmVLoUASCMV1ZOFfqgwh8G4rilUbkEaE7DON1it6Ugh
         qpR7u6RvttdpQpMNQZAYUbmdKpR2mGEjdBE4+/LjCi947CU3ELlrcK+wDWlr885ZAFHy
         /QNlzurzLe2COlKzZf5fcAlmmtYvKlxlT3fwXSzlyJGOnMDpaDQe2tot8zS0nrmsO1gb
         YamuaHpzRrnwDvSHA+Y4xkwbito0YTOu2sq4oOx7TugUPQ4QkJwkWv3IauQGpZ8PxNhu
         vV9vUTNQvLUotjYWlvTJuS2Z1fHqK5X2n5Cq966opuPqZ2de3Uvq4O3Fj+vIy/OAoHxq
         66XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741281944; x=1741886744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDX5azaNCVN3xqFvG7UlweG4Vw/2ljxh71GMAIeJGvU=;
        b=weiF9sj2qdOlxZSwike/pxj1QEUdjNU6OvcHnEm8zNGS+MMz+uOZrF6UcNvAinX8Bc
         WglbmuqnafrDweuBRKMkSinRtdWO6xCgdGNQ2aumMKJB9EmmpLwz3l+XekPWTrO/yzav
         jM0lr4WJkcYEcnLk8kamol4aY/MkMMkwveRbyVpXPar1ehysdLiTUijhQ3mhkE7/yDtT
         +m3kA3yZRjZc5eNazYVuH6mkn2rOLOjnSt5FvdJVXkhttBibt/bk+2AN14rR4Hsf6kii
         BP4R9ZKy6KKnt0huEV63TFxNjg96tKjsL+6f8r4AKEX4y24th+lW5ULHKWB1SVIBmjw9
         7PHw==
X-Forwarded-Encrypted: i=1; AJvYcCVoqKGO2Yx6aXXB3vVEQM1aMQd69Cli2EDhtMR981eeEhZm0AZh3tjzbu008jjEjcOOOR6sH0xlsfbjd0tg+SE2@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsqf18ba0xWPLthdCYNRgo4+Aa5RZuJklXkm83XFy2X4dDh0yy
	HftvjVvJXtm5Eev2xEvag0QRku43DttABGbgHswAxFZ+DMvep0BtJC8ICZszzozuRrribU5JYMF
	yZaC+tHcBbo3Lt/UAVwL4SLwjElAAM3RYJjYe
X-Gm-Gg: ASbGnctC9TLhhC/18yr1lbJOHXO/TZxr0e5J2IijEEBvJR2bJzHdEl+Ed1BfpKfU8br
	Lc8921khmpDfQ76q2xcIyTMaZACruVuKXf6xmpN/v93j+x4uQS6BPGVF1vvC8QgQ9u5aSTOMyRG
	Gzef0ELVHOMO5pSHd4FOuyp+PMQyWRhBdFWOze/D8NIbVyUqbUODbXkRI=
X-Google-Smtp-Source: AGHT+IFeJDH1cIAqw7hbTU5dgSjR4VlHoqEfNoN2goaDYUdfA9Y0xYQB0s0fx7/m7JBmEgeT32YBFka1Zgk970EkZZI=
X-Received: by 2002:a17:903:120d:b0:200:97b5:dc2b with SMTP id
 d9443c01a7336-2240e4935d3mr2630795ad.15.1741281943789; Thu, 06 Mar 2025
 09:25:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305083735.393333-1-irogers@google.com> <20250305083735.393333-2-irogers@google.com>
 <f7e4f7e8-748c-4ec7-9088-0e844392c11a@linux.intel.com>
In-Reply-To: <f7e4f7e8-748c-4ec7-9088-0e844392c11a@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Mar 2025 09:25:31 -0800
X-Gm-Features: AQ5f1Jq-9DMT9lupgZ-H-kLEeV8c0R2k1IEGyhfcRIwo6CtoSglEKmb1mGRCxKQ
Message-ID: <CAP-5=fWvdy+_H4hv28j+N1-swfGA5Q0yHDvewvsyh3t7dQb0JA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf parse-events: Corrections to topdown sorting
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 1:17=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel.c=
om> wrote:
>
>
> On 3/5/2025 4:37 PM, Ian Rogers wrote:
> > In the case of '{instructions,slots},faults,topdown-retiring' the
> > first event that must be grouped, slots, is ignored causing the
> > topdown-retiring event not to be adjacent to the group it needs to be
> > inserted into. Don't ignore the group members when computing the
> > force_grouped_index.
> >
> > Make the force_grouped_index be for the leader of the group it is
> > within and always use it first rather than a group leader index so
> > that topdown events may be sorted from one group into another.
> >
> > Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > Closes: https://lore.kernel.org/lkml/20250224083306.71813-2-dapeng1.mi@=
linux.intel.com/
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/parse-events.c | 54 ++++++++++++++++++----------------
> >  1 file changed, 28 insertions(+), 26 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 35e48fe56dfa..cf32abc496e9 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1983,31 +1983,30 @@ static int evlist__cmp(void *_fg_idx, const str=
uct list_head *l, const struct li
> >       bool lhs_has_group, rhs_has_group;
> >
> >       /*
> > -      * First sort by grouping/leader. Read the leader idx only if the=
 evsel
> > -      * is part of a group, by default ungrouped events will be sorted
> > -      * relative to grouped events based on where the first ungrouped =
event
> > -      * occurs. If both events don't have a group we want to fall-thro=
ugh to
> > -      * the arch specific sorting, that can reorder and fix things lik=
e
> > -      * Intel's topdown events.
> > +      * Get the indexes of the 2 events to sort. If the events are
> > +      * in groups then the leader's index is used otherwise the
> > +      * event's index is used. Events in the same group will be
> > +      * sorted by PMU name. An index may be forced for events that
> > +      * must be in the same group, namely Intel topdown events.
> > +      * When everything is identical arch specific sorting is used,
> > +      * that can reorder and fix things like Intel's topdown
> > +      * events.
> >        */
> > -     if (lhs_core->leader !=3D lhs_core || lhs_core->nr_members > 1) {
> > -             lhs_has_group =3D true;
> > +     lhs_has_group =3D lhs_core->leader !=3D lhs_core || lhs_core->nr_=
members > 1;
> > +     if (*force_grouped_idx !=3D -1 && arch_evsel__must_be_in_group(lh=
s))
> > +             lhs_sort_idx =3D *force_grouped_idx;
> > +     else if (lhs_has_group)
> >               lhs_sort_idx =3D lhs_core->leader->idx;
> > -     } else {
> > -             lhs_has_group =3D false;
> > -             lhs_sort_idx =3D *force_grouped_idx !=3D -1 && arch_evsel=
__must_be_in_group(lhs)
> > -                     ? *force_grouped_idx
> > -                     : lhs_core->idx;
> > -     }
> > -     if (rhs_core->leader !=3D rhs_core || rhs_core->nr_members > 1) {
> > -             rhs_has_group =3D true;
> > +     else
> > +             lhs_sort_idx =3D lhs_core->idx;
> > +     rhs_has_group =3D rhs_core->leader !=3D rhs_core || rhs_core->nr_=
members > 1;
> > +
> > +     if (*force_grouped_idx !=3D -1 && arch_evsel__must_be_in_group(rh=
s))
> > +             rhs_sort_idx =3D *force_grouped_idx;
> > +     else if (rhs_has_group)
> >               rhs_sort_idx =3D rhs_core->leader->idx;
> > -     } else {
> > -             rhs_has_group =3D false;
> > -             rhs_sort_idx =3D *force_grouped_idx !=3D -1 && arch_evsel=
__must_be_in_group(rhs)
> > -                     ? *force_grouped_idx
> > -                     : rhs_core->idx;
> > -     }
> > +     else
> > +             rhs_sort_idx =3D rhs_core->idx;
> >
> >       if (lhs_sort_idx !=3D rhs_sort_idx)
> >               return lhs_sort_idx - rhs_sort_idx;
> > @@ -2055,10 +2054,13 @@ static int parse_events__sort_events_and_fix_gr=
oups(struct list_head *list)
> >                */
> >               pos->core.idx =3D idx++;
> >
> > -             /* Remember an index to sort all forced grouped events to=
gether to. */
> > -             if (force_grouped_idx =3D=3D -1 && pos =3D=3D pos_leader =
&& pos->core.nr_members < 2 &&
> > -                 arch_evsel__must_be_in_group(pos))
> > -                     force_grouped_idx =3D pos->core.idx;
> > +             /*
> > +              * Remember an index to sort all forced grouped events
> > +              * together to. Use the group leader as some events
> > +              * must appear first within the group.
> > +              */
> > +             if (force_grouped_idx =3D=3D -1 && arch_evsel__must_be_in=
_group(pos))
> > +                     force_grouped_idx =3D pos_leader->core.idx;
> >       }
> >
> >       /* Sort events. */
>
> Hi Ian,
>
> With this fix,  this topdown metrics sequence
> "{instructions,slots},faults,topdown-retiring" indeed works on non-hybrid
> platform, like SPR, but it still fails on hybrid platform.
>
> Here is the result on Intel LNL platform.
>
> ./perf stat -e "{instructions,slots},faults,topdown-retiring" true
> WARNING: events were regrouped to match PMUs
>
>  Performance counter stats for 'true':
>
>    *<not supported> *     cpu_core/topdown-retiring/u
>            146,710      instructions:u
>      <not counted>
> cpu_core/slots/u                                                        (=
0.00%)
>      <not counted>
> instructions:u                                                          (=
0.00%)
>                 49      faults:u
>            195,855      cpu_atom/topdown-retiring/u
>
>        0.001367139 seconds time elapsed
>
>        0.001402000 seconds user
>        0.000000000 seconds sys
>
> the "cpu_core/topdown-retiring/" event is incorrectly moved to the head a=
nd
> becomes the group leader.
>
> To thoroughly fix this issue on hybrid platform, we need an extra below
> change.
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 91c2b2e2c6bd..1f7772d4db6e 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2006,7 +2006,7 @@ static int evlist__cmp(void *_fg_idx, const struct
> list_head *l, const struct li
>                 return lhs_sort_idx - rhs_sort_idx;
>
>         /* Group by PMU if there is a group. Groups can't span PMUs. */
> -       if (lhs_has_group && rhs_has_group) {
> +       if (lhs_has_group || rhs_has_group) {
>                 lhs_pmu_name =3D lhs->group_pmu_name;
>                 rhs_pmu_name =3D rhs->group_pmu_name;
>                 ret =3D strcmp(lhs_pmu_name, rhs_pmu_name);
>
> Besides, since we support this new topdown events sequence regroup, the
> comments and tests are need to be updated accordingly.

Thanks, I was able to reproduce the problem and agree with extending
the tests. I think this needs more comments so I'll update and repost
the patch with those.

Thanks,
Ian

> diff --git a/tools/perf/arch/x86/util/evlist.c
> b/tools/perf/arch/x86/util/evlist.c
> index 447a734e591c..8d7a7c4acd4b 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -39,28 +39,21 @@ int arch_evlist__cmp(const struct evsel *lhs, const
> struct evsel *rhs)
>          *         26,319,024      slots
>          *          2,427,791      instructions
>          *          2,683,508      topdown-retiring
> -        *
> -        * If slots event and topdown metrics events are not in same grou=
p, the
> -        * topdown metrics events must be first event after the slots eve=
nt
> group,
> -        * otherwise topdown metrics events can't be regrouped correctly,=
 e.g.
> -        *
> -        * a. perf stat -e "{instructions,slots},cycles,topdown-retiring"
> -C0 sleep 1
> +        * e. slots event and metrics event are in a group and not adjace=
nt
> +        *    perf stat -e "{instructions,slots},cycles,topdown-retiring"
> -C0 sleep 1
>          *    WARNING: events were regrouped to match PMUs
> -        *     Performance counter stats for 'CPU(s) 0':
> -        *         17,923,134      slots
> -        *          2,154,855      instructions
> -        *          3,015,058      cycles
> -        *    <not supported>      topdown-retiring
> -        *
> -        * If slots event and topdown metrics events are in two groups, t=
he
> group which
> -        * has topdown metrics events must contain only the topdown metri=
cs
> event,
> -        * otherwise topdown metrics event can't be regrouped correctly a=
s
> well, e.g.
> -        *
> -        * a. perf stat -e "{instructions,slots},{topdown-retiring,cycles=
}"
> -C0 sleep 1
> +        *    Performance counter stats for 'true':
> +        *         78,452,058      slots
> +        *         10,767,929      topdown-retiring
> +        *          9,438,226      instructions
> +        *         13,080,988      cycles
> +        * f. slots event and metrics event are in two groups and not adj=
acent
> +        *    perf stat -e "{instructions,slots},{cycles,topdown-retiring=
}"
> -C0 sleep 1
>          *    WARNING: events were regrouped to match PMUs
> -        *    Error:
> -        *    The sys_perf_event_open() syscall returned with 22 (Invalid
> argument) for
> -        *    event (topdown-retiring)
> +        *         68,433,522      slots
> +        *          8,856,102      topdown-retiring
> +        *          7,791,494      instructions
> +        *         11,469,513      cycles
>          */
>         if (topdown_sys_has_perf_metrics() &&
>             (arch_evsel__must_be_in_group(lhs) ||
> arch_evsel__must_be_in_group(rhs))) {
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat=
.sh
> index 68323d636fb7..a1b847c16f07 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -97,6 +97,18 @@ test_topdown_groups() {
>      err=3D1
>      return
>    fi
> +  if perf stat -e '{instructions,slots},cycles,topdown-retiring' true 2>=
&1
> | grep -E -q "<not supported>"
> +  then
> +    echo "Topdown event group test [Failed non-adjacent topdown metrics
> group not move into slots group]"
> +    err=3D1
> +    return
> +  fi
> +  if perf stat -e '{instructions,slots},{cycles,topdown-retiring}' true
> 2>&1 | grep -E -q "<not supported>"
> +  then
> +    echo "Topdown event group test [Failed non-adjacent topdown metrics
> group not merge into slots group]"
> +    err=3D1
> +    return
> +  fi
>    if perf stat -e '{instructions,r400,r8000}' true 2>&1 | grep -E -q "<n=
ot
> supported>"
>    then
>      echo "Topdown event group test [Failed raw format slots not reordere=
d
> first]"
>
> Thanks,
>
> Dapeng Mi
>
>
