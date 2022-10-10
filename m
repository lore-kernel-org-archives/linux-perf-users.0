Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD93C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Oct 2022 23:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJJXDq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Oct 2022 19:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJJXDp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Oct 2022 19:03:45 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031444F68A
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 16:03:44 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bu25so18626253lfb.3
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 16:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wVmLGort4qKrNvezX2+V/I41W3nU5RzXjPeqj9ILw/M=;
        b=Ry4AoiAPztOlGYxadoWdSGk5+GwT39lz1cOrAafsb/gaDzQSCY8uheRhtqQnxkBX2v
         0lUFYz6HBAZMYp8BUc2DEuZlZp2T4IlwjIvfUk9uEuCAGCSenFlLjfOxMA6Xvks0n9Zu
         i4gKT2MA3uzk+e/taaZdeBpiJzCN83lGEgrAf85uIHa0KPZ43hPRooHresDkABRNODrS
         fzlHegoRzWqz07fqD0syfFDVD4R5nP95wToQJIx+nYx88nxazHRYITYjR31pY/nRwyu8
         2qy2sF3yoOUYO3V07OItOybE6WIzvo3YdG0wvCXU1quchbKQQonOs/wHtFSkBgKk9etl
         qCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVmLGort4qKrNvezX2+V/I41W3nU5RzXjPeqj9ILw/M=;
        b=Hc1aabttRVKlfQv5QumOe0NBkStfE0hQzQ7kI8WQrCYxHdLSSaq84o4TsRXWhko/EE
         U3gVatuRCq5ci2QexQs0fW8F0aIjlNuy+jFHZ2KOdpx8uXfEIll6MrIV1lUMeX4tPCHZ
         qe6LwJ1RGYIPtkZAdWapBvSamcLsFIHqyHOJqt/+e0lol70HGPHxqhJWPWjF6bJpqreQ
         xzGFde+zTc8wMjTDrVP9sw60Ns2qdSTRUBpvquUUQFZ0o25UIdeoQiRLUrlbp/XPykJY
         Tsqzwq9X4zBXsVnotalEsaqNrnWRgF24L4DrJOUpKg9qyo8PQb79NzxBr0LAXdE1iwVN
         GbXg==
X-Gm-Message-State: ACrzQf2Z26DlzHIexQXdYANX1AA82BcDEKwrxfIyiYgGelChm7iI5U9J
        JLoOiFBP6IFlyKt4ZU9HUcDqpYZMN/H1IMKPsrLH1MxylLh2kw==
X-Google-Smtp-Source: AMsMyM4ZJZPFkMPYuhFYzb+ffpg5SIHZFG0jZxd35x0fuxPV9ajlMnj6iaJzQqLMxVV9tws02Zca7UvDnkf801cKQzk=
X-Received: by 2002:a05:6000:168f:b0:22e:4c3:de09 with SMTP id
 y15-20020a056000168f00b0022e04c3de09mr12786491wrd.40.1665443011612; Mon, 10
 Oct 2022 16:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-9-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-9-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 16:03:18 -0700
Message-ID: <CAP-5=fX_sHxLAnj6CLSDv4w7yPrMmTQ8ZT0+36d6VjNkJqUChw@mail.gmail.com>
Subject: Re: [PATCH 08/19] perf stat: Allocate evsel->stats->aggr properly
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Oct 9, 2022 at 10:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The perf_stat_config.aggr_map should have a correct size of the
> aggregation map.  Use it to allocate aggr_counts.
>
> Also AGGR_NONE with per-core events can be tricky because it doesn't
> aggreate basically but it needs to do so for per-core events only.

nit: s/aggreate/aggregate/

> So only per-core evsels will have stats->aggr data.
>
> Note that other caller of evlist__alloc_stat() might not have
> stat_config or aggr_map.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

nit: Below there are use of constants true, false and NULL, it would
be nice to use the /*argument_name=*/... style parameter passing to be
clearer on what the parameter means.

Thanks,
Ian

> ---
>  tools/perf/builtin-script.c     | 4 ++--
>  tools/perf/builtin-stat.c       | 6 +++---
>  tools/perf/tests/parse-metric.c | 2 +-
>  tools/perf/tests/pmu-events.c   | 2 +-
>  tools/perf/util/stat.c          | 9 +++++++--
>  tools/perf/util/stat.h          | 3 ++-
>  6 files changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 7ca238277d83..691915a71c86 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2049,7 +2049,7 @@ static void perf_sample__fprint_metric(struct perf_script *script,
>         u64 val;
>
>         if (!evsel->stats)
> -               evlist__alloc_stats(script->session->evlist, false);
> +               evlist__alloc_stats(&stat_config, script->session->evlist, false);
>         if (evsel_script(leader)->gnum++ == 0)
>                 perf_stat__reset_shadow_stats();
>         val = sample->period * evsel->scale;
> @@ -3632,7 +3632,7 @@ static int set_maps(struct perf_script *script)
>
>         perf_evlist__set_maps(&evlist->core, script->cpus, script->threads);
>
> -       if (evlist__alloc_stats(evlist, true))
> +       if (evlist__alloc_stats(&stat_config, evlist, true))
>                 return -ENOMEM;
>
>         script->allocated = true;
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index e5ddf60ab31d..eaddafbd7ff2 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2124,7 +2124,7 @@ static int set_maps(struct perf_stat *st)
>
>         perf_evlist__set_maps(&evsel_list->core, st->cpus, st->threads);
>
> -       if (evlist__alloc_stats(evsel_list, true))
> +       if (evlist__alloc_stats(&stat_config, evsel_list, true))
>                 return -ENOMEM;
>
>         st->maps_allocated = true;
> @@ -2571,10 +2571,10 @@ int cmd_stat(int argc, const char **argv)
>                 goto out;
>         }
>
> -       if (evlist__alloc_stats(evsel_list, interval))
> +       if (perf_stat_init_aggr_mode())
>                 goto out;
>
> -       if (perf_stat_init_aggr_mode())
> +       if (evlist__alloc_stats(&stat_config, evsel_list, interval))
>                 goto out;
>
>         /*
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 68f5a2a03242..cb3a9b795c0f 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -103,7 +103,7 @@ static int __compute_metric(const char *name, struct value *vals,
>         if (err)
>                 goto out;
>
> -       err = evlist__alloc_stats(evlist, false);
> +       err = evlist__alloc_stats(NULL, evlist, false);
>         if (err)
>                 goto out;
>
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index 097e05c796ab..a5e1028dacfc 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -889,7 +889,7 @@ static int test__parsing_callback(const struct pmu_event *pe, const struct pmu_e
>                 goto out_err;
>         }
>
> -       err = evlist__alloc_stats(evlist, false);
> +       err = evlist__alloc_stats(NULL, evlist, false);
>         if (err)
>                 goto out_err;
>         /*
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index c9d5aa295b54..374149628507 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -211,12 +211,17 @@ static int evsel__alloc_stats(struct evsel *evsel, int nr_aggr, bool alloc_raw)
>         return 0;
>  }
>
> -int evlist__alloc_stats(struct evlist *evlist, bool alloc_raw)
> +int evlist__alloc_stats(struct perf_stat_config *config,
> +                       struct evlist *evlist, bool alloc_raw)
>  {
>         struct evsel *evsel;
> +       int nr_aggr = 0;
> +
> +       if (config && config->aggr_map)
> +               nr_aggr = config->aggr_map->nr;
>
>         evlist__for_each_entry(evlist, evsel) {
> -               if (evsel__alloc_stats(evsel, 0, alloc_raw))
> +               if (evsel__alloc_stats(evsel, nr_aggr, alloc_raw))
>                         goto out_free;
>         }
>
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index ea356e5aa351..74bd51a3cb36 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -257,7 +257,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>                                    struct runtime_stat *st);
>  void perf_stat__collect_metric_expr(struct evlist *);
>
> -int evlist__alloc_stats(struct evlist *evlist, bool alloc_raw);
> +int evlist__alloc_stats(struct perf_stat_config *config,
> +                       struct evlist *evlist, bool alloc_raw);
>  void evlist__free_stats(struct evlist *evlist);
>  void evlist__reset_stats(struct evlist *evlist);
>  void evlist__reset_prev_raw_counts(struct evlist *evlist);
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
