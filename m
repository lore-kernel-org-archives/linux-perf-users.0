Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2742D877B
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762411349; cv=none; b=HPzSmGsxs1dw/zMC1r3MUIul+UDdjUsWfsKEUrSMLpuFsrhhVEazitWubr/V96oBNQT9xKb0im2Xx9hDq3A21Fhfs5R8czp/NOc7qHzzRuEF5fR6Z9WVLnOGx3P5gCLG6vweidkkO5nndIMXSWh69ZhZk7QYRSgmINL0+Inu36k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762411349; c=relaxed/simple;
	bh=AeSCdyni83k4yUuA+0559bO8HAwzStYb9FVIwXJwHyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCuoS2uOzHGDvjjdrJ2wTssFFQwymyt1+esDEoO+7c0kXmCQhDJj3DErvXuLVn+mTm1jBqMxdlVAvhIxspnA8NT2rVyh3HNpCAFFTxvfGkl3RN16AD/Eq/xL6tFzyZtJmmT+Hk0zHiSVqBLT9FQ+3JJ6wndSPDX10bm4S/JDJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=igPW6I0e; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="igPW6I0e"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-294f3105435so83275ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Nov 2025 22:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762411346; x=1763016146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvO8RyImdodmU0WiqheiYuh6o925qsAYhxVdO/bn8JE=;
        b=igPW6I0eFrTFhOGUdBc+zPi18hWM07zWK8Z2j3Tlw8IsXt+wtAV/7QnjHzKKEh8ecO
         8cY62/OEpKVexuGsKL75HQWC/eOkoawLQ0np6DHqeZEkV5CZtyLxYpEokg3sw+XSlwff
         BEVfgwtQLtfgVnIqFlxFX9QZ4ENCRx8auMzJXmJyKCRSFM7ZqkjHmfJse3Xl783A6HW5
         5+mBoWX7pfKTpvhsuCspPn3E8CgPo5AuYFJcXC2yFQ06+ekH+5wg1i7oGr9UMRDvNr+M
         Ri/Kxv+GJpHqOixQM5FlSkFfwAXgiQ9HQEy3CT6/loEVFIy6RuDEddHodlJ5UrudYFUe
         iYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762411346; x=1763016146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dvO8RyImdodmU0WiqheiYuh6o925qsAYhxVdO/bn8JE=;
        b=lFgn4dYz+nNNuTQnhGJ7Qp6EIzkZ5tuqhdUv2I5djOHok2pUFnvO/5TE3WVX9R0a/F
         FkmmuvJtdDeDhpyYmTII7Mcsee9i37t+MkkEJZi6UUDlO0fJ3fddzHL8+iTe0sAPy/IG
         oIcEKi5TugRHel6wUvXzmV7Mar/Z8eLlBLWHsJI/53zpbO1J43bFhk96AVDHxW2+39+G
         rtLD/VS2N7uis3q3yTDNCe5oJ29K7jbET/czw2ZghhoQS/cCmFo96EBVe0K+vxcCciHx
         1ZEI44gejV7/xNPj8+aQ0tFYKVBc7ur2lQRP9Jf11APJfTkOB8HpmPIteIleT9F8aL0P
         Q3Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUy8aCPkDprgM+/1+hOzYaHIT4swBGR7kk57qTLwyY9YM5vtkatm17ernjF3sfXbHwa397+7aAdHxF645jNIYGd@vger.kernel.org
X-Gm-Message-State: AOJu0YxV1LSTRl2F92sm261PtlzYfhIljEdckDs/zv8BWZKsghn+uWEp
	Mos+WQ8b/1Xd5LFBJVAYJakuT4TiAIW/+Lp0a7MBNaNceZESQyZlhMabsN4ACXPbhfmjJNJ81Y7
	uAAijcE1CTT73fxJbMLVXIVDHb4W+OBUNLZDIqbfN
X-Gm-Gg: ASbGncuWVopRu2CriqcN8AHFB4O0SzLXd6uniUX21Fo0MCO3bE2eKgt+3saD2Nv98dL
	kkf85VDHdwKz3ONhE5oedRaXABeH0exSImPF7/MhbWBc5bXnuBQaogq4tPD7h6QegBAhZXgehIT
	0fF82ibG+09MgXy6ki3z6v6Zn1d+Er1qDq8NiXvNyKOeKQnAL3uHEl/Z+C5ONqRrGwL+9+n0+i6
	wmsVewzGmhB/WfWHdwhPvzI8JiOLbsRNo0NVdz3Dn71GdaPaHgEF/5JYt3J
X-Google-Smtp-Source: AGHT+IHC+tliRZizWFcSYLcf5QMiPn7Oq+hZB4RN/+YM9E3o/Jahu+vLtbbDG6NA9xu77vW5B1wRahXndakIa0XJHko=
X-Received: by 2002:a17:902:f818:b0:26d:72f8:8cfa with SMTP id
 d9443c01a7336-2965b1dba42mr1678855ad.13.1762411345890; Wed, 05 Nov 2025
 22:42:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com> <20251024175857.808401-6-irogers@google.com>
 <aQmGfLVKk0UFGAyd@google.com> <CAP-5=fXmT-1io1k1O5d2QMken9aJmGTiuDEz2f-7k8-n=GCWtA@mail.gmail.com>
 <aQw6Jje7bSpywGqq@google.com>
In-Reply-To: <aQw6Jje7bSpywGqq@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Nov 2025 22:42:13 -0800
X-Gm-Features: AWmQ_bk_ICs-PvZxmDtwMA5i1WiR0FyuaXdsrA9bzvplc08ela5Gm4UCfQidVCU
Message-ID: <CAP-5=fV666tSv+3=6t-UobtGuzvw4g2oQZZScCX-P7oqDz+4Rg@mail.gmail.com>
Subject: Re: [PATCH v1 05/22] perf metricgroup: Add care to picking the evsel
 for displaying a metric
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 10:03=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Nov 03, 2025 at 09:28:44PM -0800, Ian Rogers wrote:
> > On Mon, Nov 3, 2025 at 8:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Fri, Oct 24, 2025 at 10:58:40AM -0700, Ian Rogers wrote:
> > > > Rather than using the first evsel in the matched events, try to fin=
d
> > > > the least shared non-tool evsel. The aim is to pick the first evsel
> > > > that typifies the metric within the list of metrics.
> > > >
> > > > This addresses an issue where Default metric group metrics may lose
> > > > their counter value due to how the stat displaying hides counters f=
or
> > > > default event/metric output.
> > >
> > > Do you have a command line example to show impact of this change?
> >
> > You can just run a Topdown metricgroup on Intel to see differences,
>
> Ok, before this change.
>
>   $ perf stat -M topdownL1 true
>
>    Performance counter stats for 'true':
>
>            7,754,275      TOPDOWN.SLOTS                    #     37.1 %  =
tma_backend_bound
>                                                     #     38.7 %  tma_fro=
ntend_bound
>                                                     #      8.8 %  tma_bad=
_speculation
>                                                     #     15.3 %  tma_ret=
iring
>            1,185,947      topdown-retiring
>            3,010,483      topdown-fe-bound
>            2,828,029      topdown-be-bound
>              729,814      topdown-bad-spec
>                9,987      INT_MISC.CLEARS_COUNT
>              221,405      IDQ.MS_UOPS
>                6,352      INT_MISC.UOP_DROPPING
>            1,212,644      UOPS_RETIRED.SLOTS
>              119,895      UOPS_DECODED.DEC0
>               60,975      cpu/UOPS_DECODED.DEC0,cmask=3D1/
>            1,639,442      UOPS_ISSUED.ANY
>              820,982      IDQ.MITE_UOPS
>
>          0.001172956 seconds time elapsed
>
>          0.001269000 seconds user
>          0.000000000 seconds sys
>
>
> And with this change, it does look better.
>
>   $ perf stat -M topdownL1 true
>
>    Performance counter stats for 'true':
>
>            7,977,430      TOPDOWN.SLOTS
>            1,188,793      topdown-retiring
>            3,159,687      topdown-fe-bound
>            2,940,699      topdown-be-bound
>              688,248      topdown-bad-spec
>                9,749      INT_MISC.CLEARS_COUNT            #     37.5 %  =
tma_backend_bound
>                                                     #      8.1 %  tma_bad=
_speculation
>              219,145      IDQ.MS_UOPS                      #     14.9 %  =
tma_retiring
>                6,188      INT_MISC.UOP_DROPPING            #     39.5 %  =
tma_frontend_bound
>            1,205,712      UOPS_RETIRED.SLOTS
>              117,505      UOPS_DECODED.DEC0
>               59,891      cpu/UOPS_DECODED.DEC0,cmask=3D1/
>            1,625,232      UOPS_ISSUED.ANY
>              805,560      IDQ.MITE_UOPS
>
>          0.001629344 seconds time elapsed
>
>          0.001672000 seconds user
>          0.000000000 seconds sys
>
> > but they are minor. The main impact is on the Default legacy metrics
> > as those have a counter then a metric, but without this change you get
> > everything grouped on the cpu-clock event and the formatting gets broke=
n.
>
> Do you mean with other changes in this series?  I don't see any
> differences in the output just after this patch..
>
> Before:
>
>   $ perf stat -a true
>
>    Performance counter stats for 'system wide':
>
>           19,078,719      cpu-clock                        #    7.256 CPU=
s utilized
>                   94      context-switches                 #    4.927 K/s=
ec
>                   14      cpu-migrations                   #  733.802 /se=
c
>                   61      page-faults                      #    3.197 K/s=
ec
>           43,304,957      instructions                     #    1.10  ins=
n per cycle
>           39,281,107      cycles                           #    2.059 GHz
>            5,012,071      branches                         #  262.705 M/s=
ec
>              128,358      branch-misses                    #    2.56% of =
all branches
>    #     24.4 %  tma_retiring
>    #     33.7 %  tma_backend_bound
>                                                     #      5.9 %  tma_bad=
_speculation
>    #     36.0 %  tma_frontend_bound
>
>          0.002629534 seconds time elapsed
>
> After:
>
>   $ perf stat -a true
>
>    Performance counter stats for 'system wide':
>
>            6,201,661      cpu-clock                        #    3.692 CPU=
s utilized
>                   24      context-switches                 #    3.870 K/s=
ec
>                    7      cpu-migrations                   #    1.129 K/s=
ec
>                   60      page-faults                      #    9.675 K/s=
ec
>           11,458,681      instructions                     #    1.07  ins=
n per cycle
>           10,704,978      cycles                           #    1.726 GHz
>            2,457,704      branches                         #  396.298 M/s=
ec
>               54,553      branch-misses                    #    2.22% of =
all branches
>    #     21.4 %  tma_retiring
>    #     36.1 %  tma_backend_bound
>                                                     #     10.2 %  tma_bad=
_speculation
>    #     32.3 %  tma_frontend_bound
>
>          0.001679679 seconds time elapsed

These are the hardcoded metrics that aren't impacted by my changes to
the json metric's behavior. Patch 8 will add json for the legacy
metrics.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > As --metric-only is popular when looking at a group of events
> > and the Default legacy metrics are added in subsequent changes it
> > didn't seem right to include the output (it either shows broken things
> > keeping to be somewhat broken or output from later patches).
> >
> > Thanks,
> > Ian
> >
> > > Thanks,
> > > Namhyung
> > >
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/util/metricgroup.c | 48 +++++++++++++++++++++++++++++++=
+++-
> > > >  1 file changed, 47 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metric=
group.c
> > > > index 48936e517803..76092ee26761 100644
> > > > --- a/tools/perf/util/metricgroup.c
> > > > +++ b/tools/perf/util/metricgroup.c
> > > > @@ -1323,6 +1323,51 @@ static int parse_ids(bool metric_no_merge, b=
ool fake_pmu,
> > > >       return ret;
> > > >  }
> > > >
> > > > +/* How many times will a given evsel be used in a set of metrics? =
*/
> > > > +static int count_uses(struct list_head *metric_list, struct evsel =
*evsel)
> > > > +{
> > > > +     const char *metric_id =3D evsel__metric_id(evsel);
> > > > +     struct metric *m;
> > > > +     int uses =3D 0;
> > > > +
> > > > +     list_for_each_entry(m, metric_list, nd) {
> > > > +             if (hashmap__find(m->pctx->ids, metric_id, NULL))
> > > > +                     uses++;
> > > > +     }
> > > > +     return uses;
> > > > +}
> > > > +
> > > > +/*
> > > > + * Select the evsel that stat-display will use to trigger shadow/m=
etric
> > > > + * printing. Pick the least shared non-tool evsel, encouraging met=
rics to be
> > > > + * with a hardware counter that is specific to them.
> > > > + */
> > > > +static struct evsel *pick_display_evsel(struct list_head *metric_l=
ist,
> > > > +                                     struct evsel **metric_events)
> > > > +{
> > > > +     struct evsel *selected =3D metric_events[0];
> > > > +     size_t selected_uses;
> > > > +     bool selected_is_tool;
> > > > +
> > > > +     if (!selected)
> > > > +             return NULL;
> > > > +
> > > > +     selected_uses =3D count_uses(metric_list, selected);
> > > > +     selected_is_tool =3D evsel__is_tool(selected);
> > > > +     for (int i =3D 1; metric_events[i]; i++) {
> > > > +             struct evsel *candidate =3D metric_events[i];
> > > > +             size_t candidate_uses =3D count_uses(metric_list, can=
didate);
> > > > +
> > > > +             if ((selected_is_tool && !evsel__is_tool(candidate)) =
||
> > > > +                 (candidate_uses < selected_uses)) {
> > > > +                     selected =3D candidate;
> > > > +                     selected_uses =3D candidate_uses;
> > > > +                     selected_is_tool =3D evsel__is_tool(selected)=
;
> > > > +             }
> > > > +     }
> > > > +     return selected;
> > > > +}
> > > > +
> > > >  static int parse_groups(struct evlist *perf_evlist,
> > > >                       const char *pmu, const char *str,
> > > >                       bool metric_no_group,
> > > > @@ -1430,7 +1475,8 @@ static int parse_groups(struct evlist *perf_e=
vlist,
> > > >                       goto out;
> > > >               }
> > > >
> > > > -             me =3D metricgroup__lookup(&perf_evlist->metric_event=
s, metric_events[0],
> > > > +             me =3D metricgroup__lookup(&perf_evlist->metric_event=
s,
> > > > +                                      pick_display_evsel(&metric_l=
ist, metric_events),
> > > >                                        /*create=3D*/true);
> > > >
> > > >               expr =3D malloc(sizeof(struct metric_expr));
> > > > --
> > > > 2.51.1.821.gb6fe4d2222-goog
> > > >
