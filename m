Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1895D2CCC5
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Nov 2025 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762282037; cv=none; b=oJbJ6KtT+UiD1+8v9gNZ/v5heIskLCduTqAjyYSukARxVw1nZeh6utuSdahw+3x5kdxxBIyFD3RXO/NIeYbZBxBdA9H8WsLK2aD3G3bTmnaqbrOl1Nkx4YL5uhf4pJhyrqlNHltsiKhut1MsLdnLUxFxhtKnMAG1TAEC5FnwrTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762282037; c=relaxed/simple;
	bh=KKMCBwuGCiFUjK2VvVxn1MfvAe2xK1/bDfZAgGnL9ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tx2Syh79I6Gk6tQ5BjMMfmEzyFDAo5DGftYXQX9t3/AKgg/pi6yzzOsRZ6781VH4DM6b1TR6K4XvISX4vK4N/32I9VjIWfTl5tZT2Pk/mjpOMZVXNfPQtZj5fl5ZrfEppsuIDR6tQTtNddmCHWfyroBJiFaQNnNFRgv5nWUEFcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=csnmFKmG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="csnmFKmG"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27d67abd215so21625ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Nov 2025 10:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762282035; x=1762886835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/jlOoGNiDidR02MLTeYPPu7BGXO9FosT3UCDKaUXjo=;
        b=csnmFKmGXLm1PMbXbzkueEz/JFFx1FoK0OzZWrtYoB3QzAB0rCqxXxD8MjUG6VyYgZ
         MtJbtmyDNTw74QJEY0qEDnFCGFVjgaTjlXZdtBgPynlBOWO5lPHrglmR2bZh/wR7uEsj
         b4nX/4FF5P0QC7ZML5mTFnBXfvgtKu+T5QnK4BcqyaZ7Ht5eAvNqAX1PqPYd3VsqPdcv
         otfSUx8iID+DhicjfxvO1NCAheYmPrrzZ3/xsowWnkiModPGoyaJgt2YksgtOXWgK/aD
         /h3zcxmf1s+/AEdpvVIl9asGnyb6jD9vDNxyXgRXJC0tqdfXdZHf4C0+LmqwFbrlkp8K
         yFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762282035; x=1762886835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P/jlOoGNiDidR02MLTeYPPu7BGXO9FosT3UCDKaUXjo=;
        b=YVMQTK0ddG0POmZ3TQMpMEM/AcAPu1NaExdfD5QOQ9OB23EpnyhOyPXSP8sMuhxkND
         O7kJKEqWRm3mlPctQn2zj05rTG8SOmf/MuglSh6CG1UQ23iXfY7Ae9t2GsAa7LkQVmFx
         2aA0EqjPpp6UUWmANdC5UzRHNH3bhDWxnd68HwpsZhqeVHMdOgwAi2RNeTr90i29I1Qe
         LF3qJfo5uPBYaSOZUuiitVTLu+1MVigM5f7Jqgn8c42CrQWoJ7zSgWZqxthnn01gmxM9
         d6BEGcbNOJ9242qG09j2YBijtgOHBxDNdEwVJ+R1VOFUu8mist4qE4jucC3L3M7TUqP/
         YBng==
X-Forwarded-Encrypted: i=1; AJvYcCUSMVBGkjlrJsUdItGZ7G3aCznQu/h/dtuc4XKuWXjNaKg6kmaglzvTn37FdVJZ4uyQl+RABxq7YQFXBS8gCGs3@vger.kernel.org
X-Gm-Message-State: AOJu0YwagXq13jYpfwJvisqsX90wgTyGtDa8Qsm99e/D0etAFL7FYZXo
	3Z70Vl4YjZaRticvwLotYH1uT6mqBPq9K3sZ0BoWZDLBaWm39xd2qwiATgDDRmMokxbovFOu9gW
	K7roFeHsMk7DJvUYwioWhDmZb6C75ldz6BqmEKXLx
X-Gm-Gg: ASbGnctm9GR/mtrWZsBYCnmqJ+3+XFy6JKAGHiW1qifRC67CVvcHEDWzH8r18LA5smd
	Sgk9QS3vpuuQmrun/XVWYzBneikqbPCG4m3iGzIhtTHDgLpq7HlLlQ90ew96zV2NeEc+Y5KTG3k
	rCdsQ479nYMWJ+w5okjJeOYyEiwhP2sMGmA6ekVNeaLW/6OH5n/3UZjDiDlZmQ7MpqtJCw0lsXc
	ZuU5a+G/ZrNlgM27Ux9zlDN0P3ncgwdzpSdE+YsSLKGCRdU2Olm/eM1X44r6OZ8xts2PaxEGTZH
	MdGC2guzKwQdqsQ=
X-Google-Smtp-Source: AGHT+IFEL1igWzNF0ecT+YC39xo2x7+67kX8Mtuc98edexOzCudTrCWPCDXgDs/thVWs0wQZvcUoCsJmottDgSYXEC4=
X-Received: by 2002:a17:902:f545:b0:26a:befc:e7e1 with SMTP id
 d9443c01a7336-29631395060mr342705ad.12.1762282034968; Tue, 04 Nov 2025
 10:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104053449.1208800-1-irogers@google.com> <20251104053449.1208800-2-irogers@google.com>
 <aQpBmIEX8G7mTrWQ@google.com>
In-Reply-To: <aQpBmIEX8G7mTrWQ@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Nov 2025 10:47:03 -0800
X-Gm-Features: AWmQ_bm7akqY14bRYWcJu10nqWPgMmWccIgWrGnpR3bhYQqCB_vcGgSafDMyOzM
Message-ID: <CAP-5=fW20XxHwQnjeJZjLvCF0nVJ8tJ6tDeCm4-eDHKDdg0m4Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] perf stat-shadow: Read tool events directly
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 10:10=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Mon, Nov 03, 2025 at 09:34:48PM -0800, Ian Rogers wrote:
> > When reading time values for metrics don't use the globals updated in
> > builtin-stat, just read the events as regular events. The only
> > exception is for time events where nanoseconds need converting to
> > seconds as metrics assume time metrics are in seconds.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/stat-shadow.c | 123 +++++++++++++---------------------
> >  1 file changed, 45 insertions(+), 78 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shado=
w.c
> > index abaf6b579bfc..9fae3d32a519 100644
> > --- a/tools/perf/util/stat-shadow.c
> > +++ b/tools/perf/util/stat-shadow.c
> > @@ -371,6 +371,18 @@ static void print_nsecs(struct perf_stat_config *c=
onfig,
> >       }
> >  }
> >
> > +static double tool_pmu__scale_for_metric(const struct evsel *evsel)
> > +{
> > +     enum tool_pmu_event event =3D evsel__tool_event(evsel);
> > +
> > +     if (event =3D=3D TOOL_PMU__EVENT_DURATION_TIME ||
> > +         event =3D=3D TOOL_PMU__EVENT_USER_TIME ||
> > +         event =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME)
> > +             return 1e-9; /* Scale nanoseconds to seconds. */
> > +
> > +     return 1.0;
> > +}
> > +
> >  static int prepare_metric(const struct metric_expr *mexp,
> >                         const struct evsel *evsel,
> >                         struct expr_parse_ctx *pctx,
> > @@ -382,90 +394,45 @@ static int prepare_metric(const struct metric_exp=
r *mexp,
> >
> >       for (i =3D 0; metric_events[i]; i++) {
> >               char *n;
> > -             double val;
> > +             double val, scale =3D tool_pmu__scale_for_metric(metric_e=
vents[i]);
> >               int source_count =3D 0;
> > +             struct perf_stat_evsel *ps =3D metric_events[i]->stats;
> > +             struct perf_stat_aggr *aggr;
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
> > -                             break;
> > -                     case TOOL_PMU__EVENT_SYSTEM_TIME:
> > -                             stats =3D &ru_stats.ru_stime_usec_stat;
> > -                             scale =3D 1e-6;
>
> Do {USER,SYSTEM}_TIME become nanosecond now?

The behavior is the same. In the event system/user time are read as
microseconds while duration time is nanoseconds, the system/user times
are scaled to be nanoseconds for some kind of consistency. In the
metrics we were doing a similar scaling but scaling nanoseconds and
microseconds to be seconds. Using the events directly we know the
counts are always in nanoseconds so we just need to do 1 scaling
factor.

Thanks,
Ian

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
> > +             aggr =3D &ps->aggr[aggr_idx];
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
> > +                     val =3D aggr->counts.val * scale;
> > +                     if (!source_count)
> > +                             source_count =3D evsel__source_count(metr=
ic_events[i]);
> >               }
> >               n =3D strdup(evsel__metric_id(metric_events[i]));
> >               if (!n)
> > --
> > 2.51.2.1006.ga50a493c49-goog
> >
