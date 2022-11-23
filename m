Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52A7C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 23:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiKWXZc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 18:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiKWXZ1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 18:25:27 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A49107E52
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:25:26 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id x5so27653297wrt.7
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=chKYKremI8l82yLQBleCjCfCnE6ikjwksdBvNeUY2BY=;
        b=F2H0b8sbV3VuxorK3eUw56iopjhu2K4/r/sIVLjgacR+sPFVdX4Va4sie9GQFuKMBy
         UWagscDfZGav1T6v9KGGJZ5XYna09Or3U4adG7YIbnW/+8bQyoXeSnAvrFt6r2A4Znvn
         sUSvfFPjiW2xANP7aUBCn+k95uKy3FEMnzfVJYhU1oH+hWpRYGf+El4UhLj7EmgJNoIM
         lFHQWqjwVpTGoRuQKofShYE7P85nbYHFIC3g6Xsiy9lH828GrOLshouScZLw9QbO+4dS
         2quHGRqIQJbbIL+GkSxCfVrGRzh5G17O+4PG2DVukvA7F31Pq3KEeeRv8DACZkRrKejJ
         hMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chKYKremI8l82yLQBleCjCfCnE6ikjwksdBvNeUY2BY=;
        b=NG+JmcBRfkDDl4mC4qAQbxzY1HR09zmsC5CjkmQVWDJDndO6Ql0DxJPyVnfxhRnlTI
         JB0UfmWpGePHknrk5fPA3mpqzXydS53bPnIOzjQTS+phuL6Uy3PDCJY6LL6zzj1v/EuY
         6G1oevZWTjaMqYYVwiuPoOCLxg5vJYy8AEHrVXmLFB0F0EZmlY5PGryF8Br+k+KoSQAc
         +X0HV8x5xOO/c6pl004Hj7Wkw1apU0BM5cyHe87SIXuPMvmkYhnqy+AyxhGSOjXtCfr2
         FW4sEU1ygolFwjkDCeGPO2FyHPlJ5sATxS41lGlhpccypl6rxiLKGz4Be2nT2cbu2Y56
         BNUA==
X-Gm-Message-State: ANoB5pnCMXqljR+HCs63GidpPfH4p5anBv0NChqtjSJI+K08Gs75xTjG
        PEAGE9i4TD7mH6M2MCWs/jzOmbOHYWbZR3yGfp4XWg==
X-Google-Smtp-Source: AA0mqf6Z28mDgI/9Rdc1hv42MikVHtNHpL7i0pTnq4MkKZ72ZL8P7DnAmFcx4BoffQVhh5vyF1UeNfgmg1JY8fWEUNo=
X-Received: by 2002:adf:f6cc:0:b0:228:dd1d:8a42 with SMTP id
 y12-20020adff6cc000000b00228dd1d8a42mr7212105wrp.375.1669245924985; Wed, 23
 Nov 2022 15:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-10-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-10-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:25:12 -0800
Message-ID: <CAP-5=fUA-tFcpkWy2w29ou09GdoEU8e8ZFSgab12-QGPfH5g3w@mail.gmail.com>
Subject: Re: [PATCH 09/15] perf stat: Pass struct outstate to print_metric_begin()
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 23, 2022 at 10:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> It passes prefix and cgroup pointers but the outstate already has them.
> Let's pass the outstate pointer instead.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 50 +++++++++++++++++++---------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 70aebf359e16..3ed63061d6f8 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -843,8 +843,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>
>  static void print_metric_begin(struct perf_stat_config *config,
>                                struct evlist *evlist,
> -                              const char *prefix, int aggr_idx,
> -                              struct cgroup *cgrp)
> +                              struct outstate *os, int aggr_idx)
>  {
>         struct perf_stat_aggr *aggr;
>         struct aggr_cpu_id id;
> @@ -853,15 +852,15 @@ static void print_metric_begin(struct perf_stat_config *config,
>         if (!config->metric_only)
>                 return;
>
> -       if (prefix)
> -               fprintf(config->output, "%s", prefix);
> +       if (os->prefix)
> +               fprintf(config->output, "%s", os->prefix);
>
>         evsel = evlist__first(evlist);
>         id = config->aggr_map->map[aggr_idx];
>         aggr = &evsel->stats->aggr[aggr_idx];
>         aggr_printout(config, evsel, id, aggr->nr);
>
> -       print_cgroup(config, cgrp);
> +       print_cgroup(config, os->cgrp);
>  }
>
>  static void print_metric_end(struct perf_stat_config *config)
> @@ -877,6 +876,9 @@ static void print_aggr(struct perf_stat_config *config,
>                        const char *prefix)
>  {
>         struct evsel *counter;
> +       struct outstate os = {
> +               .prefix = prefix,
> +       };
>         int s;
>
>         if (!config->aggr_map || !config->aggr_get_id)
> @@ -887,7 +889,7 @@ static void print_aggr(struct perf_stat_config *config,
>          * Without each counter has its own line.
>          */
>         for (s = 0; s < config->aggr_map->nr; s++) {
> -               print_metric_begin(config, evlist, prefix, s, /*cgrp=*/NULL);
> +               print_metric_begin(config, evlist, &os, s);
>
>                 evlist__for_each_entry(evlist, counter) {
>                         if (counter->merged_stat)
> @@ -904,26 +906,28 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
>                               const char *prefix)
>  {
>         struct evsel *counter, *evsel;
> -       struct cgroup *cgrp = NULL;
> +       struct outstate os = {
> +               .prefix = prefix,
> +       };
>         int s;
>
>         if (!config->aggr_map || !config->aggr_get_id)
>                 return;
>
>         evlist__for_each_entry(evlist, evsel) {
> -               if (cgrp == evsel->cgrp)
> +               if (os.cgrp == evsel->cgrp)
>                         continue;
>
> -               cgrp = evsel->cgrp;
> +               os.cgrp = evsel->cgrp;
>
>                 for (s = 0; s < config->aggr_map->nr; s++) {
> -                       print_metric_begin(config, evlist, prefix, s, cgrp);
> +                       print_metric_begin(config, evlist, &os, s);
>
>                         evlist__for_each_entry(evlist, counter) {
>                                 if (counter->merged_stat)
>                                         continue;
>
> -                               if (counter->cgrp != cgrp)
> +                               if (counter->cgrp != os.cgrp)
>                                         continue;
>
>                                 print_counter_aggrdata(config, counter, s, prefix);
> @@ -956,6 +960,9 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>  {
>         int all_idx;
>         struct perf_cpu cpu;
> +       struct outstate os = {
> +               .prefix = prefix,
> +       };
>
>         perf_cpu_map__for_each_cpu(cpu, all_idx, evlist->core.user_requested_cpus) {
>                 struct evsel *counter;
> @@ -973,8 +980,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>
>                         id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
>                         if (first) {
> -                               print_metric_begin(config, evlist, prefix,
> -                                                  counter_idx, /*cgrp=*/NULL);
> +                               print_metric_begin(config, evlist, &os, counter_idx);
>                                 first = false;
>                         }
>                         val = ps->aggr[counter_idx].counts.val;
> @@ -1347,22 +1353,23 @@ static void print_percore(struct perf_stat_config *config,
>  static void print_cgroup_counter(struct perf_stat_config *config, struct evlist *evlist,
>                                  const char *prefix)
>  {
> -       struct cgroup *cgrp = NULL;
>         struct evsel *counter;
> +       struct outstate os = {
> +               .prefix = prefix,
> +       };
>
>         evlist__for_each_entry(evlist, counter) {
> -               if (cgrp != counter->cgrp) {
> -                       if (cgrp != NULL)
> +               if (os.cgrp != counter->cgrp) {
> +                       if (os.cgrp != NULL)
>                                 print_metric_end(config);
>
> -                       cgrp = counter->cgrp;
> -                       print_metric_begin(config, evlist, prefix,
> -                                          /*aggr_idx=*/0, cgrp);
> +                       os.cgrp = counter->cgrp;
> +                       print_metric_begin(config, evlist, &os, /*aggr_idx=*/0);
>                 }
>
>                 print_counter(config, counter, prefix);
>         }
> -       if (cgrp)
> +       if (os.cgrp)
>                 print_metric_end(config);
>  }
>
> @@ -1405,8 +1412,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>                 } else if (config->cgroup_list) {
>                         print_cgroup_counter(config, evlist, os.prefix);
>                 } else {
> -                       print_metric_begin(config, evlist, os.prefix,
> -                                          /*aggr_idx=*/0, /*cgrp=*/NULL);
> +                       print_metric_begin(config, evlist, &os, /*aggr_idx=*/0);
>                         evlist__for_each_entry(evlist, counter) {
>                                 print_counter(config, counter, os.prefix);
>                         }
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
