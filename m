Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC61D88AC
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2025 04:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763440608; cv=none; b=I96kkEkkOzq1SktPFp26QYD+xAEvaKLPUX98jpXwb/Ca5TyJvE2kiUffgRx/0jrhC/0UeZHQ5xPu4ahECW8yQfE3blqA3dVRbYtKBmuBm7gBmTc2S+1sNPU0eK6w7vVaizWaZgs6NZrgaTiHUq5xi/iSV0HSEchoUYiRnF+yF4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763440608; c=relaxed/simple;
	bh=JMId1gGIvN6FZe0z0auRkUvTRwcjEdCzWTQEL7J5QyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRvedns//JKyWbHeAyan3BzbTg8fDa8iqignnJkPXk761vZ++MEmg88OkVxlAz4qytpkqb1M1qJcHUyMM+Mv0IgpEnCCm99gY9g7Yx+WaatyX9KoKJK09MydGiYXcUNDrJ7pPp5TcSJh5mTCKRWOuFEC+ndF2ypd6rAnUhy6avY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NcjQxApF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NcjQxApF"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297e13bf404so106105ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Nov 2025 20:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763440606; x=1764045406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Zc/gJqn5HU+wq7BMLSUPDj4rGjGpyTuVHWhzqRdqqQ=;
        b=NcjQxApFdsJVnQ79EipQN17qMvbTOhcaB5HItLBF3vx/IShvY5+qQFRS2wUZSURg8V
         0NRADvbKEJvhQamfDOlJ8FUUVu2JvK2ftw3hpSQw88o9SfyZRybJvwlgu/pW2BuCZK/f
         pH8/oXpSrwbb9AcMC+iUiUlzjz09ZTQZTIMGpO6gO1BBdsvk+LX5QlyKG7HwOMhBg+vy
         sNyn8T7I3hLjmtJdAkGkJGoqstsBBg4gsnyznO/gnOacJs/otZtL9WpJpT3pzivWq7DO
         8lTLZXSOYZNdvixDhFhQVr5lnFpGr8PzYRd6fw6qWEms5z4tp0b57NLPC74LalNzcYJ9
         zGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763440606; x=1764045406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Zc/gJqn5HU+wq7BMLSUPDj4rGjGpyTuVHWhzqRdqqQ=;
        b=lSqrFgRJPmDLt0X9R1HzADEqPQYPTMRra8hUWqzXok7lfwcdpotC3ACjJWfYqt0Cpb
         kqcijajA9Yg5BHsHQAhgHaQ28TI4pWD0xE3+fFRa7cIMBDp59ngaHDXKLrkQUG03HjcZ
         xdYmcMPHwscyaXrVoUpQkxO6WX6g481JtFRxqeyIpB/+sJtUCu9AN5hHdZr+hBX9R1qT
         afLjR7lT6BIFGfb6jAXgADnhdvvKjdaI/VsteddFXSYoZ2cOWSnylzoFB6HUdIcgTOrF
         tvRDTDJtTVUY0TW4UUPQi78gdVP6gOiWw6zyPgPEXMItjx27RqZP8daCgxhfBWjbjhTm
         zmfw==
X-Forwarded-Encrypted: i=1; AJvYcCX8rHTy2pfb3N7o6TGGA7JzWJYksk7IPqtFzWA+6tGq0Mvcbsa6hV+1FM+BwXk05hNJ1uegzxYmg1mYotTQyjqi@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmsm07MWpVWVMNV26jyaPuNi8qceNw/DJalYA7/vCGpEGTPMi0
	BDfBo+5JHgiC2aMrhola51iWF0w4mSwf/zHZ/aXeQ/QVs2tQeKGVxnv5+QrkbLVdqAX+chT62aN
	K/JlQ+n7ltv7qn8ZMUX18pr6ZmcLP7d2BGBPKccEP
X-Gm-Gg: ASbGncubCv+2ziT+3aDpjdkWQB1xm5ihyT/Xltng2LPUo1Nhc714aeqX1WePhF9v0GR
	K3RERW+yZezZO4ZFfoQ9wM2TrnMaAskPYOns2+aOAuZOvQvaPG7Qfweg1J1xs4oVnL+RpJoLyxi
	RNdPz34AzJfTSKGZDMKmQWBCn4vVuWspxjNXTFne4H8MMXgKjImMP+8vtuJLuFjVZMM5gsewfYQ
	Ul/VqwCBaLgdgRKZY7UVS5Fqf3MwZX4FqjOLfig+K5wvSDTnvgiP9qc4bgSP4bm65tZaQwJsOT9
	52zvyTA=
X-Google-Smtp-Source: AGHT+IEBeWT1Pjzcx4yNsj3hDhyoYcbdubytfbMd8c1Nm9ctx83KEx/tKOsLeY0O2FQ/pxbro1Bh95mvJxHNEH6yt0Q=
X-Received: by 2002:a17:902:f54e:b0:297:eadc:3cd5 with SMTP id
 d9443c01a7336-299f8026811mr1242485ad.15.1763440605505; Mon, 17 Nov 2025
 20:36:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113180517.44096-1-irogers@google.com> <20251113180517.44096-5-irogers@google.com>
 <aRvaK32xmC8XUA-k@google.com>
In-Reply-To: <aRvaK32xmC8XUA-k@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Nov 2025 20:36:34 -0800
X-Gm-Features: AWmQ_bnqA4a-F_-LUml3iU0y0rcXfgBjfnes7BjLD4dbhsA1MO0kLVKep-sf02s
Message-ID: <CAP-5=fUJFFOQzbPyef0F0UixFFD4Mtfh2iYc6aMXsT0mr_DXqA@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] perf stat-shadow: Read tool events directly
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 6:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Nov 13, 2025 at 10:05:10AM -0800, Ian Rogers wrote:
> > When reading time values for metrics don't use the globals updated in
> > builtin-stat, just read the events as regular events. The only
> > exception is for time events where nanoseconds need converting to
> > seconds as metrics assume time metrics are in seconds.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/stat-shadow.c | 149 +++++++++++++++-------------------
> >  1 file changed, 66 insertions(+), 83 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shado=
w.c
> > index b3b482e1808f..6c1ad78604e1 100644
> > --- a/tools/perf/util/stat-shadow.c
> > +++ b/tools/perf/util/stat-shadow.c
> > @@ -26,7 +26,32 @@ void perf_stat__reset_shadow_stats(void)
> >       memset(&ru_stats, 0, sizeof(ru_stats));
> >  }
> >
> > -static int prepare_metric(const struct metric_expr *mexp,
> > +static bool tool_pmu__is_time_event(const struct perf_stat_config *con=
fig,
> > +                                const struct evsel *evsel, int *tool_a=
ggr_idx)
> > +{
> > +     enum tool_pmu_event event =3D evsel__tool_event(evsel);
> > +     int aggr_idx;
> > +
> > +     if (event !=3D TOOL_PMU__EVENT_DURATION_TIME &&
> > +         event !=3D TOOL_PMU__EVENT_USER_TIME &&
> > +         event !=3D TOOL_PMU__EVENT_SYSTEM_TIME)
> > +             return false;
> > +
> > +     if (config) {
> > +             cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
> > +                     if (config->aggr_map->map[aggr_idx].cpu.cpu =3D=
=3D 0) {
> > +                             *tool_aggr_idx =3D aggr_idx;
> > +                             return true;
> > +                     }
> > +             }
> > +             pr_debug("Unexpected CPU0 missing in aggregation for tool=
 event.\n");
> > +     }
> > +     *tool_aggr_idx =3D 0; /* Assume the first aggregation index works=
. */
> > +     return true;
> > +}
> > +
> > +static int prepare_metric(struct perf_stat_config *config,
> > +                       const struct metric_expr *mexp,
> >                         const struct evsel *evsel,
> >                         struct expr_parse_ctx *pctx,
> >                         int aggr_idx)
> > @@ -36,93 +61,51 @@ static int prepare_metric(const struct metric_expr =
*mexp,
> >       int i;
> >
> >       for (i =3D 0; metric_events[i]; i++) {
> > +             int source_count =3D 0, tool_aggr_idx;
> > +             bool is_tool_time =3D
> > +                     tool_pmu__is_time_event(config, metric_events[i],=
 &tool_aggr_idx);
> > +             struct perf_stat_evsel *ps =3D metric_events[i]->stats;
> > +             struct perf_stat_aggr *aggr;
> >               char *n;
> >               double val;
> > -             int source_count =3D 0;
> >
> > -             if (evsel__is_tool(metric_events[i])) {
> > -                     struct stats *stats;
> > -                     double scale;
> > -
> > -                     switch (evsel__tool_event(metric_events[i])) {
> > -                     case TOOL_PMU__EVENT_DURATION_TIME:
> > -                             stats =3D &walltime_nsecs_stats;
> > -                             scale =3D 1e-9;
> > -                             break;
> > -                     case TOOL_PMU__EVENT_USER_TIME:
> > -                             stats =3D &ru_stats.ru_utime_usec_stat;
> > -                             scale =3D 1e-6;
> > +             /*
> > +              * If there are multiple uncore PMUs and we're not readin=
g the
> > +              * leader's stats, determine the stats for the appropriat=
e
> > +              * uncore PMU.
> > +              */
> > +             if (evsel && evsel->metric_leader &&
> > +                 evsel->pmu !=3D evsel->metric_leader->pmu &&
> > +                 mexp->metric_events[i]->pmu =3D=3D evsel->metric_lead=
er->pmu) {
> > +                     struct evsel *pos;
> > +
> > +                     evlist__for_each_entry(evsel->evlist, pos) {
> > +                             if (pos->pmu !=3D evsel->pmu)
> > +                                     continue;
> > +                             if (pos->metric_leader !=3D mexp->metric_=
events[i])
> > +                                     continue;
> > +                             ps =3D pos->stats;
> > +                             source_count =3D 1;
> >                               break;
> > -                     case TOOL_PMU__EVENT_SYSTEM_TIME:
> > -                             stats =3D &ru_stats.ru_stime_usec_stat;
> > -                             scale =3D 1e-6;
> > -                             break;
>
> I think this was broken as it seems to be converted to nsec in the
> update_rusage_stats().

The global utime/stime is in usecs as in the name. In the tool_pmu it
is converted to nanoseconds, for consistency with duration_time. In
the new code the counters are all in nanoseconds and so the same
scaling factor can be applied.

> > -                     case TOOL_PMU__EVENT_NONE:
> > -                             pr_err("Invalid tool event 'none'");
> > -                             abort();
> > -                     case TOOL_PMU__EVENT_MAX:
> > -                             pr_err("Invalid tool event 'max'");
> > -                             abort();
> > -                     case TOOL_PMU__EVENT_HAS_PMEM:
> > -                     case TOOL_PMU__EVENT_NUM_CORES:
> > -                     case TOOL_PMU__EVENT_NUM_CPUS:
> > -                     case TOOL_PMU__EVENT_NUM_CPUS_ONLINE:
> > -                     case TOOL_PMU__EVENT_NUM_DIES:
> > -                     case TOOL_PMU__EVENT_NUM_PACKAGES:
> > -                     case TOOL_PMU__EVENT_SLOTS:
> > -                     case TOOL_PMU__EVENT_SMT_ON:
> > -                     case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ:
> > -                     case TOOL_PMU__EVENT_CORE_WIDE:
> > -                     case TOOL_PMU__EVENT_TARGET_CPU:
> > -                     default:
> > -                             pr_err("Unexpected tool event '%s'", evse=
l__name(metric_events[i]));
> > -                             abort();
> >                       }
> > -                     val =3D avg_stats(stats) * scale;
> > -                     source_count =3D 1;
> > -             } else {
> > -                     struct perf_stat_evsel *ps =3D metric_events[i]->=
stats;
> > -                     struct perf_stat_aggr *aggr;
> > -
> > +             }
> > +             /* Time events are always on CPU0, the first aggregation =
index. */
> > +             aggr =3D &ps->aggr[is_tool_time ? tool_aggr_idx : aggr_id=
x];
> > +             if (!aggr || !metric_events[i]->supported) {
> >                       /*
> > -                      * If there are multiple uncore PMUs and we're no=
t
> > -                      * reading the leader's stats, determine the stat=
s for
> > -                      * the appropriate uncore PMU.
> > +                      * Not supported events will have a count of 0, w=
hich
> > +                      * can be confusing in a metric. Explicitly set t=
he
> > +                      * value to NAN. Not counted events (enable time =
of 0)
> > +                      * are read as 0.
> >                        */
> > -                     if (evsel && evsel->metric_leader &&
> > -                         evsel->pmu !=3D evsel->metric_leader->pmu &&
> > -                         mexp->metric_events[i]->pmu =3D=3D evsel->met=
ric_leader->pmu) {
> > -                             struct evsel *pos;
> > -
> > -                             evlist__for_each_entry(evsel->evlist, pos=
) {
> > -                                     if (pos->pmu !=3D evsel->pmu)
> > -                                             continue;
> > -                                     if (pos->metric_leader !=3D mexp-=
>metric_events[i])
> > -                                             continue;
> > -                                     ps =3D pos->stats;
> > -                                     source_count =3D 1;
> > -                                     break;
> > -                             }
> > -                     }
> > -                     aggr =3D &ps->aggr[aggr_idx];
> > -                     if (!aggr)
> > -                             break;
> > -
> > -                     if (!metric_events[i]->supported) {
> > -                             /*
> > -                              * Not supported events will have a count=
 of 0,
> > -                              * which can be confusing in a
> > -                              * metric. Explicitly set the value to NA=
N. Not
> > -                              * counted events (enable time of 0) are =
read as
> > -                              * 0.
> > -                              */
> > -                             val =3D NAN;
> > -                             source_count =3D 0;
> > -                     } else {
> > -                             val =3D aggr->counts.val;
> > -                             if (!source_count)
> > -                                     source_count =3D evsel__source_co=
unt(metric_events[i]);
> > -                     }
> > +                     val =3D NAN;
> > +                     source_count =3D 0;
> > +             } else {
> > +                     val =3D aggr->counts.val;
> > +                     if (is_tool_time)
> > +                             val *=3D 1e-9; /* Convert time event nano=
seconds to seconds. */
>
> And this code treats all time events are in nsec now.

That's correct: user_time, system_time and duration_time are all
counters that give a count in nanoseconds. However, in the metrics, I
guess as the counts are doubles, the time has always been in whole
seconds.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +                     if (!source_count)
> > +                             source_count =3D evsel__source_count(metr=
ic_events[i]);
> >               }
> >               n =3D strdup(evsel__metric_id(metric_events[i]));
> >               if (!n)
> > @@ -168,7 +151,7 @@ static void generic_metric(struct perf_stat_config =
*config,
> >               pctx->sctx.user_requested_cpu_list =3D strdup(config->use=
r_requested_cpu_list);
> >       pctx->sctx.runtime =3D runtime;
> >       pctx->sctx.system_wide =3D config->system_wide;
> > -     i =3D prepare_metric(mexp, evsel, pctx, aggr_idx);
> > +     i =3D prepare_metric(config, mexp, evsel, pctx, aggr_idx);
> >       if (i < 0) {
> >               expr__ctx_free(pctx);
> >               return;
> > @@ -229,7 +212,7 @@ double test_generic_metric(struct metric_expr *mexp=
, int aggr_idx)
> >       if (!pctx)
> >               return NAN;
> >
> > -     if (prepare_metric(mexp, /*evsel=3D*/NULL, pctx, aggr_idx) < 0)
> > +     if (prepare_metric(/*config=3D*/NULL, mexp, /*evsel=3D*/NULL, pct=
x, aggr_idx) < 0)
> >               goto out;
> >
> >       if (expr__parse(&ratio, pctx, mexp->metric_expr))
> > --
> > 2.51.2.1041.gc1ab5b90ca-goog
> >
