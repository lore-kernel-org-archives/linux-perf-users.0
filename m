Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BF9C38142
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Jan 2023 04:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjAXEtA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Jan 2023 23:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjAXEs7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Jan 2023 23:48:59 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728803B0FD
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jan 2023 20:48:53 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso10499543wmn.5
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jan 2023 20:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iKJPQXY28kZK7sCwwfHqZtW+iaz8ixGeBHkUMwf8lzA=;
        b=gNSuTHWqTDUcrxe9zsCC4yYEY2rZQXORvk3fw4qmmWxw2l42+EC9yw7KqKe2quFZEe
         bY+YmE2RUJhFudy4dhFNjFSA11WsPlVloeZNf5AEAzakkkfzjbrQIiD5AYMJuds2+p3y
         WlDGYlqR9N7caF9bVNhsWX55495kUPcpe5woqbTK2NxQvHU5lMXghhxBNMpDJNs5+4Yj
         60S83jF7r+k6aZfANn3ILWpN94enZPVhtBn4yiGBKE2/KV1d11Sna9KB2n6cUyW1r/Dz
         SbOMhIeNFfbDBSqQdCsWUDSQTFzgOUiKBjNA+3LVRTtiGvu/oqWpgZeytFOcb4JJoCn7
         6G3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKJPQXY28kZK7sCwwfHqZtW+iaz8ixGeBHkUMwf8lzA=;
        b=kx/0/6khgshbHQEAhZX+5wcTvyly8j7XK55Ms3mmaJ2c/bg3mDVbTKsNbSOITxx+CA
         6XoyOCzL+c8+UaQUvFALUiGnaGgEgmBFoY20UIUhUy1pZ+Mmhnc60OLt6Vt9yTsymmrt
         LbQHl62QK8ad5iBqsx/sdn+S9nPcy2mIYNwh+a5a0Mm19d157lj0X8PNxnF6r4nMczuP
         1C9CwR0w6xuW1XElkfFxknKnrnVGxIGVrKUjHk2gcPXrmqnOCJFT0Y6GVzHwOeSNoP8n
         uvFlloDjexXrYTpP/IRAMrWcgtqmgho+dHBXx93zB8/o6yGCziK0sqrVFIEfRPB7OSvA
         YHXA==
X-Gm-Message-State: AFqh2kogzjHO4vxNZOZ1/WCzccQuvjkCQ/pAyLjzlW+z4iZ5UBMFfXqw
        BqEmJTWzj4qVd+q/UagDvmYi+FXfs4STcjVhFS95/w==
X-Google-Smtp-Source: AMrXdXuMYuRnnaqnV0ZJVjXo29rptcdLEFYk5BJ3Dt8c+V+fJ/G1tmHSGfz0tW2p5tESpKI2eKbU3HfNsfo07+c+W9o=
X-Received: by 2002:a05:600c:2247:b0:3da:27dd:9585 with SMTP id
 a7-20020a05600c224700b003da27dd9585mr1110848wmm.182.1674535731455; Mon, 23
 Jan 2023 20:48:51 -0800 (PST)
MIME-Version: 1.0
References: <20221221223420.2157113-1-irogers@google.com> <20221221223420.2157113-8-irogers@google.com>
 <dd5070a7-254d-4763-439f-a5bfa8240fe1@oracle.com>
In-Reply-To: <dd5070a7-254d-4763-439f-a5bfa8240fe1@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 23 Jan 2023 20:48:39 -0800
Message-ID: <CAP-5=fV0GBtx_0qHPemO_AsLyf_3XAxcC9Q2eG-=rMpuTsMmzg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] perf pmu-events: Introduce pmu_metrics_table
To:     John Garry <john.g.garry@oracle.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 23, 2023 at 7:36 AM John Garry <john.g.garry@oracle.com> wrote:
>
> On 21/12/2022 22:34, Ian Rogers wrote:
> > Add a metrics table that is just a cast from pmu_events_table. This
> > changes the APIs so that event and metric usage of the underlying
> > table is different. Later changes will separate the tables.
> >
> > This introduction fixes a NO_JEVENTS=1 regression on:
> >   68: Parse and process metrics                                       : Ok
> >   70: Event expansion for cgroups                                     : Ok
> > caused by the necessary test metrics not being found.
> >
>
> I have just checked some of this code so far...
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/arch/arm64/util/pmu.c         | 23 ++++++++++-
> >   tools/perf/pmu-events/empty-pmu-events.c | 52 ++++++++++++++++++++----
> >   tools/perf/pmu-events/jevents.py         | 24 ++++++++---
> >   tools/perf/pmu-events/pmu-events.h       | 10 +++--
> >   tools/perf/tests/expand-cgroup.c         |  4 +-
> >   tools/perf/tests/parse-metric.c          |  4 +-
> >   tools/perf/tests/pmu-events.c            |  5 ++-
> >   tools/perf/util/metricgroup.c            | 50 +++++++++++------------
> >   tools/perf/util/metricgroup.h            |  2 +-
> >   tools/perf/util/pmu.c                    |  9 +++-
> >   tools/perf/util/pmu.h                    |  1 +
> >   11 files changed, 133 insertions(+), 51 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
> > index 477e513972a4..f8ae479a06db 100644
> > --- a/tools/perf/arch/arm64/util/pmu.c
> > +++ b/tools/perf/arch/arm64/util/pmu.c
> > @@ -19,7 +19,28 @@ const struct pmu_events_table *pmu_events_table__find(void)
> >               if (pmu->cpus->nr != cpu__max_cpu().cpu)
> >                       return NULL;
> >
> > -             return perf_pmu__find_table(pmu);
> > +             return perf_pmu__find_events_table(pmu);
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > +const struct pmu_metrics_table *pmu_metrics_table__find(void)
> > +{
> > +     struct perf_pmu *pmu = NULL;
> > +
> > +     while ((pmu = perf_pmu__scan(pmu))) {
> > +             if (!is_pmu_core(pmu->name))
> > +                     continue;
> > +
> > +             /*
> > +              * The cpumap should cover all CPUs. Otherwise, some CPUs may
> > +              * not support some events or have different event IDs.
> > +              */
> > +             if (pmu->cpus->nr != cpu__max_cpu().cpu)
> > +                     return NULL;
> > +
> > +             return perf_pmu__find_metrics_table(pmu);
>
> I think that this code will be conflicting with the recent arm64 metric
> support. And now it seems even more scope for factoring out code.

v3 will rebase and fix.

> >       }
> >
> >       return NULL;
> > diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
> > index 5572a4d1eddb..d50f60a571dd 100644
> > --- a/tools/perf/pmu-events/empty-pmu-events.c
> > +++ b/tools/perf/pmu-events/empty-pmu-events.c
> > @@ -278,14 +278,12 @@ int pmu_events_table_for_each_event(const struct pmu_events_table *table, pmu_ev
> >       return 0;
> >   }
> >
> > -int pmu_events_table_for_each_metric(const struct pmu_events_table *etable, pmu_metric_iter_fn fn,
> > -                                  void *data)
> > +int pmu_metrics_table_for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
> > +                                   void *data)
> >   {
> > -     struct pmu_metrics_table *table = (struct pmu_metrics_table *)etable;
> > -
> >       for (const struct pmu_metric *pm = &table->entries[0]
>
> nit on coding style: do we normally declare local variables like this?
> It condenses the code but makes a bit less readable, IMHO

The main reason to do it is to reduce the scope of pm to just be the
loop body. There's some discussion relating to this to do with the
move to C11:
https://lwn.net/Articles/885941/

> > ; pm->metric_group || pm->metric_name;
> >            pm++) {
> > -             int ret = fn(pm, etable, data);
> > +             int ret = fn(pm, table, data);
> >
> >               if (ret)
> >                       return ret;
> > @@ -293,7 +291,7 @@ int pmu_events_table_for_each_metric(const struct pmu_events_table *etable, pmu_
> >       return 0;
> >   }
> >
> > -const struct pmu_events_table *perf_pmu__find_table(struct perf_pmu *pmu)
> > +const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
> >   {
> >       const struct pmu_events_table *table = NULL;
> >       char *cpuid = perf_pmu__getcpuid(pmu);
> > @@ -321,6 +319,34 @@ const struct pmu_events_table *perf_pmu__find_table(struct perf_pmu *pmu)
> >       return table;
> >   }
> >
> > +const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu)
> > +{
> > +     const struct pmu_metrics_table *table = NULL;
> > +     char *cpuid = perf_pmu__getcpuid(pmu);
> > +     int i;
> > +
> > +     /* on some platforms which uses cpus map, cpuid can be NULL for
> > +      * PMUs other than CORE PMUs.
> > +      */
> > +     if (!cpuid)
> > +             return NULL;
> > +
> > +     i = 0;
> > +     for (;;) {
> > +             const struct pmu_events_map *map = &pmu_events_map[i++];
>
> To me, this is all strange code. Again this is a comment on the current
> code: Consider pmu_for_each_sys_event() as an example, we have a while
> loop for each member of pmu_sys_event_tables[]. But pmu_sys_event_tables
> is hardcoded for a single member, so why loop? It seems the same for all
> these "for each" helper in the "empty" events c file.

Agreed. I think we should generate the empty case and then event if
there is just 1 iteration, we know that the code is that way because
of the auto-generation.

> > +
> > +             if (!map->cpuid)
> > +                     break;
> > +
> > +             if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
> > +                     table = &map->metric_table;
> > +                     break;
> > +             }
> > +     }
> > +     free(cpuid);
> > +     return table;
> > +}
> > +
> >   const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
> >   {
> >       for (const struct pmu_events_map *tables = &pmu_events_map[0];
> > @@ -332,6 +358,17 @@ const struct pmu_events_table *find_core_events_table(const char *arch, const ch
> >       return NULL;
> >   }
> >
> > +const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const char *cpuid)
> > +{
> > +     for (const struct pmu_events_map *tables = &pmu_events_map[0];
> > +          tables->arch;
> > +          tables++) {
>
> combine with previous line?

Done.

> > +             if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpuid))
> > +                     return &tables->metric_table;
> > +     }
> > +     return NULL;
> > +}
> > +
> >   int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
> >   {
> >       for (const struct pmu_events_map *tables = &pmu_events_map[0];
> > @@ -350,8 +387,7 @@ int pmu_for_each_core_metric(pmu_metric_iter_fn fn, void *data)
> >       for (const struct pmu_events_map *tables = &pmu_events_map[0];
> >            tables->arch;
> >            tables++) {
> > -             int ret = pmu_events_table_for_each_metric(
> > -                     (const struct pmu_events_table *)&tables->metric_table, fn, data);
> > +             int ret = pmu_metrics_table_for_each_metric(&tables->metric_table, fn, data);
> >
> >               if (ret)
> >                       return ret;
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> > index 7b9714b25d0a..be2cf8a8779c 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -609,17 +609,19 @@ int pmu_events_table_for_each_event(const struct pmu_events_table *table,
> >           return 0;
> >   }
> >
> > -int pmu_events_table_for_each_metric(const struct pmu_events_table *table,
> > +int pmu_metrics_table_for_each_metric(const struct pmu_metrics_table *mtable,
> >                                        pmu_metric_iter_fn fn,
> >                                        void *data)
> >   {
> > +        struct pmu_events_table *table = (struct pmu_events_table *)mtable;
>
> As I may have hinted before, can we avoid casts like this, even if
> transient?

It was a trade-off with patch size. Will try to improve in v3.

Thanks,
Ian

> > +
> >           for (size_t i = 0; i < table->length; i++) {
> >                   struct pmu_metric pm;
> >                   int ret;
> >
> >                   decompress_metric(table->entries[i].offset, &pm);
> >                   if (pm.metric_name) {
> > -                        ret = fn(&pm, table, data);
> > +                        ret = fn(&pm, mtable, data);
> >                           if (ret)
> >                                   return ret;
> >                   }
>
>
>
