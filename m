Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C278FC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Oct 2022 23:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiJJXBD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Oct 2022 19:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJJXBB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Oct 2022 19:01:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D590D4DF33
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 16:00:56 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j16so19000373wrh.5
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 16:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uc1i7IELlbjVIeYLpOxEQXmYQfmKu+VimW9xvJ8PkdQ=;
        b=nV61sBa9X59/jFPBpK2JdcnVOqLKHa9ooCneygvrWDVEjXCVeUq5+jhPtYEGFN8gBu
         jSnNNAOUWg9KDBxM32/9yUTgenXybl0PksdzH1hY7mOEb6aswL3kjQyp+dMcdeGRbmuz
         FDa9o2gfPL+pgoH2GdAq36JYxLtscepDuyfkHWXm0fe0bhTs8HqihVsuGnsA5wj0rr4E
         c9ZV9QIE1RYBtlK4aNsVkRX/QP8WGhuRrSoB9Pk9HRD9RWqaDa7socnI0PC1bAlZV1Nw
         VJ7SqzS8TB4WvI3I+mCU5grwPBDcFviOc20o5MVdMBXtP4BKEQ75mbOXwgObh9YJHSLI
         IW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uc1i7IELlbjVIeYLpOxEQXmYQfmKu+VimW9xvJ8PkdQ=;
        b=TdZ9KBHRQBK+6oYgYxqxqvgfZh/XlcAF9+W5D113Jqj8BD+vPDxJEbPY9qrHCAlqYz
         JoBOmsU/5VWO/kNtaxyDDjE5leWYDwnWXyqRtdACeSZH5tiiqgZNRiCjPtMViqJO5q+b
         yYbw5j/usCrXADVug7/JKI1CFjGRbT+Mi4wyZXIdTMLvrN9+ZnLz/TphJ3fr9/iwqCD2
         kRkDKOjcZSLRXaZXfj8CnegLs2slu1cYaQBnHheQEvgv1kHMuj6XaKLaCov7ETYYoPQl
         KyAq9qu+EoI2qFP1xCFZYGsLJDtqKKdXV5EcujbhPgCofMt8mlIb9KY0BUHDTbAl4blb
         pr0A==
X-Gm-Message-State: ACrzQf3b/+jBmX7oYKoUu9W12ihtn1NadTJOw8qOvKnbCpGm7ck5C12p
        5HHfa2n8I9acZd7cMCY6P7n7ef2qX+bfbX/cU1ETyw==
X-Google-Smtp-Source: AMsMyM4HCbBPlQZFdwDD8eFgg/OjlElS48JDVhJ0V6tAGRnILjEH+UYGgax0/LXkUhBKm1ZBjA5B4b1qKN6u+H1qJj4=
X-Received: by 2002:a5d:68d0:0:b0:22c:dfba:3bd6 with SMTP id
 p16-20020a5d68d0000000b0022cdfba3bd6mr12713716wrw.300.1665442855185; Mon, 10
 Oct 2022 16:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-8-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-8-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 16:00:42 -0700
Message-ID: <CAP-5=fXU-ydTrDXVp_WoyuvgvaHEVt0kVY2kDCGYTrpebw7RtA@mail.gmail.com>
Subject: Re: [PATCH 07/19] perf stat: Add struct perf_stat_aggr to perf_stat_evsel
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
> The perf_stat_aggr struct is to keep aggregated counter values and the
> states according to the aggregation mode.  The number of entries is
> depends on the mode and this is a preparation for the later use.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat.c | 34 +++++++++++++++++++++++++++-------
>  tools/perf/util/stat.h |  9 +++++++++
>  2 files changed, 36 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 8ec8bb4a9912..c9d5aa295b54 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -133,15 +133,33 @@ static void perf_stat_evsel_id_init(struct evsel *evsel)
>  static void evsel__reset_stat_priv(struct evsel *evsel)
>  {
>         struct perf_stat_evsel *ps = evsel->stats;
> +       struct perf_stat_aggr *aggr = ps->aggr;
>
>         init_stats(&ps->res_stats);
> +
> +       if (aggr)
> +               memset(aggr, 0, sizeof(*aggr) * ps->nr_aggr);
>  }
>
> -static int evsel__alloc_stat_priv(struct evsel *evsel)
> +
> +static int evsel__alloc_stat_priv(struct evsel *evsel, int nr_aggr)
>  {
> -       evsel->stats = zalloc(sizeof(struct perf_stat_evsel));
> -       if (evsel->stats == NULL)
> +       struct perf_stat_evsel *ps;
> +
> +       ps = zalloc(sizeof(*ps));
> +       if (ps == NULL)
>                 return -ENOMEM;
> +
> +       if (nr_aggr) {
> +               ps->nr_aggr = nr_aggr;
> +               ps->aggr = calloc(nr_aggr, sizeof(*ps->aggr));
> +               if (ps->aggr == NULL) {
> +                       free(ps);
> +                       return -ENOMEM;
> +               }
> +       }
> +
> +       evsel->stats = ps;
>         perf_stat_evsel_id_init(evsel);
>         evsel__reset_stat_priv(evsel);
>         return 0;
> @@ -151,8 +169,10 @@ static void evsel__free_stat_priv(struct evsel *evsel)
>  {
>         struct perf_stat_evsel *ps = evsel->stats;
>
> -       if (ps)
> +       if (ps) {
> +               zfree(&ps->aggr);
>                 zfree(&ps->group_data);
> +       }
>         zfree(&evsel->stats);
>  }
>
> @@ -181,9 +201,9 @@ static void evsel__reset_prev_raw_counts(struct evsel *evsel)
>                 perf_counts__reset(evsel->prev_raw_counts);
>  }
>
> -static int evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
> +static int evsel__alloc_stats(struct evsel *evsel, int nr_aggr, bool alloc_raw)
>  {
> -       if (evsel__alloc_stat_priv(evsel) < 0 ||
> +       if (evsel__alloc_stat_priv(evsel, nr_aggr) < 0 ||
>             evsel__alloc_counts(evsel) < 0 ||
>             (alloc_raw && evsel__alloc_prev_raw_counts(evsel) < 0))
>                 return -ENOMEM;
> @@ -196,7 +216,7 @@ int evlist__alloc_stats(struct evlist *evlist, bool alloc_raw)
>         struct evsel *evsel;
>
>         evlist__for_each_entry(evlist, evsel) {
> -               if (evsel__alloc_stats(evsel, alloc_raw))
> +               if (evsel__alloc_stats(evsel, 0, alloc_raw))
>                         goto out_free;
>         }
>
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index b0899c6e002f..ea356e5aa351 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -8,6 +8,7 @@
>  #include <sys/resource.h>
>  #include "cpumap.h"
>  #include "rblist.h"
> +#include "counts.h"
>
>  struct perf_cpu_map;
>  struct perf_stat_config;
> @@ -42,9 +43,17 @@ enum perf_stat_evsel_id {
>         PERF_STAT_EVSEL_ID__MAX,
>  };
>

The new struct variables below are all worth comments.

> +struct perf_stat_aggr {
> +       struct perf_counts_values       counts;
> +       int                             nr;

Could this value be derived from counts.values.size ?

> +       bool                            failed;
> +};
> +
>  struct perf_stat_evsel {
>         struct stats             res_stats;
>         enum perf_stat_evsel_id  id;
> +       int                      nr_aggr;
> +       struct perf_stat_aggr   *aggr;
>         u64                     *group_data;
>  };
>
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
