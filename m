Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD67EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jun 2023 19:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjF3TBE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 15:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjF3TBD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2023 15:01:03 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92BEE62
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 12:01:01 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4007b5bafceso44731cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688151661; x=1690743661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1P79XzyniN175v02xWz3VthmQA9nnn+iiqxl7BlzXX0=;
        b=JVWDy9S5lZQqOy6W0HMr9hUMfKM67zzYFUI/6y/vyiAgJWyzAcYT04GZIU55ncpXNt
         aHNli4HurGACd8JcJhHxJWxxIxyPLGBQN3FJ3eiu1HvhSOjAy/67jwHudoA4YAVmjsyF
         Z5rgsHbmfRWJ0CzOuDNp2EbIbYsu6QtU11iypofvqpdMGIq1T1cRlDcS34Oi6MYYDezZ
         cO59rfqLlydj/gvtcKkD4DNeYm88NrcKt69ixuST6DgrRj94eyJjtfUFzHm0DXHz/v4f
         ALcx+pomr87Wmy8jnmykSuNu/ij/peTfy1BoIPlhCDG6WeoBIuIyZFlYr+P+PvEPL836
         Nl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688151661; x=1690743661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1P79XzyniN175v02xWz3VthmQA9nnn+iiqxl7BlzXX0=;
        b=KpoCmUISS7K4PmFS3qsMLuHedx4ra/PhbyC3TinK7vzwDKc+Xgv87vDEXFgZ/FVC3Z
         bz5SNEEiGw6sOfP7kdRn2w/MGyK2/xOjVRI7b3kna8XwFRdZdP8m3GTozLKMGdSttYXN
         gzDf0/Wx3r+yTljRb8e5080Q+6jPiB6HWseUjlfskbOQSplscx/vnlbh2WQnjMEqch1L
         DsYcGk6wNxNOeQ5WxBTgOT0MhXiIX+d1RIXTMS0HbBpCuPxXLZ2CJ5M56I0tFwReWH37
         rrF/Wcgqd5zp3MfQGGHxN2MT5zDUH4vGx0oQAvlfErEJQQy44B5AoWhxS5oyyo0VPrTx
         RRTQ==
X-Gm-Message-State: ABy/qLaZJ/E7uZ4IWcQJKy4lutHxm/+kVzRPcOtnjr9n0Vtk5ZtyphxD
        pTxfiC87indJ7RwBI4KEfw3oFpaqcarb1n/Ryig0aQ==
X-Google-Smtp-Source: APBJJlHEWrTrFnIwItSQK/DV5LB3sw/UmULLL5UOl67gfobs7L4ST3kG0Nvnrd69SCX6IRmRG8ukr8HM7vuMcpTvjCo=
X-Received: by 2002:ac8:5b01:0:b0:3f9:56c:1129 with SMTP id
 m1-20020ac85b01000000b003f9056c1129mr23785qtw.5.1688151660761; Fri, 30 Jun
 2023 12:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230628102949.2598096-1-john.g.garry@oracle.com> <20230628102949.2598096-5-john.g.garry@oracle.com>
In-Reply-To: <20230628102949.2598096-5-john.g.garry@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 12:00:48 -0700
Message-ID: <CAP-5=fXa24_LEiyni0Ncyfa5hKwC1GE6y-zi2u8M98M9SwHX+g@mail.gmail.com>
Subject: Re: [PATCH RFC 4/9] perf jevents: Add sys_events_find_events_table()
To:     John Garry <john.g.garry@oracle.com>
Cc:     acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 28, 2023 at 3:30=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> Add a function to get the events table associated with a metric table for
> struct pmu_sys_events.
>
> We could also use something like:
> struct pmu_sys_events *sys =3D container_of(metrics, struct pmu_sys_event=
s,
>                                                 metric_table);
>
> to lookup struct pmu_sys_events, but that relies on the user always passi=
ng
> a sys events metric struct pointer, so this way is safer, but slower.

If an event is specific to a particular PMU, shouldn't the metric name
the PMU with the event? For example:

MetricName: "IPC",
MetricExpr: "instructions / cycles",

Here instructions and cycles can wildcard match on BIG.little/hybrid
systems and so we get an IPC metric for each PMU - although, I suspect
this isn't currently quite working. We can also, and currently, do:

MetricName: "IPC",
MetricExpr: "cpu_atom@instructions@ / cpu_atom@cycles@",
...
MetricName: "IPC",
MetricExpr: "cpu_core@instructions@ / cpu_core@cycles@",

The @ is used to avoid parsing confusion with / meaning divide. The
PMUs for the events are explicitly listed here. We could say the PMU
is implied but then it gets complex for uncore events, for metrics
that mix core and uncore events.

Thanks,
Ian


> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  tools/perf/pmu-events/empty-pmu-events.c |  6 ++++++
>  tools/perf/pmu-events/jevents.py         | 11 +++++++++++
>  tools/perf/pmu-events/pmu-events.h       |  3 +++
>  3 files changed, 20 insertions(+)
>
> diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-ev=
ents/empty-pmu-events.c
> index a630c617e879..ae431b6bdf91 100644
> --- a/tools/perf/pmu-events/empty-pmu-events.c
> +++ b/tools/perf/pmu-events/empty-pmu-events.c
> @@ -290,6 +290,12 @@ int pmu_metrics_table_for_each_metric(const struct p=
mu_metrics_table *table, pmu
>         return 0;
>  }
>
> +const struct pmu_events_table *
> +sys_events_find_events_table(__maybe_unused const struct pmu_metrics_tab=
le *metrics)
> +{
> +       return NULL;
> +}
> +
>  const struct pmu_events_table *perf_pmu__find_events_table(struct perf_p=
mu *pmu)
>  {
>         const struct pmu_events_table *table =3D NULL;
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 80b569b8634b..947e8b1efa26 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -786,6 +786,17 @@ int pmu_metrics_table_for_each_metric(const struct p=
mu_metrics_table *table,
>          return 0;
>  }
>
> +const struct pmu_events_table *
> +sys_events_find_events_table(const struct pmu_metrics_table *metrics)
> +{
> +       for (const struct pmu_sys_events *tables =3D &pmu_sys_event_table=
s[0];
> +             tables->name; tables++) {
> +               if (&tables->metric_table =3D=3D metrics)
> +                       return &tables->event_table;
> +       }
> +       return NULL;
> +}
> +
>  const struct pmu_events_table *perf_pmu__find_events_table(struct perf_p=
mu *pmu)
>  {
>          const struct pmu_events_table *table =3D NULL;
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/p=
mu-events.h
> index caf59f23cd64..a3642c08e39d 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -77,6 +77,9 @@ typedef int (*pmu_metric_iter_fn)(const struct pmu_metr=
ic *pm,
>                                   const struct pmu_metrics_table *table,
>                                   void *data);
>
> +const struct pmu_events_table *
> +sys_events_find_events_table(const struct pmu_metrics_table *metrics);
> +
>  int pmu_events_table_for_each_event(const struct pmu_events_table *table=
, pmu_event_iter_fn fn,
>                                     void *data);
>  int pmu_metrics_table_for_each_metric(const struct pmu_metrics_table *ta=
ble, pmu_metric_iter_fn fn,
> --
> 2.35.3
>
