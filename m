Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8126FC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Oct 2022 23:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJJXRl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Oct 2022 19:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiJJXRk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Oct 2022 19:17:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8561E1C433
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 16:17:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id ay36so7633311wmb.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 16:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aaDd0ODXQ6mBIvOHNDB+WJAKo8Eo3Nj0ghA1H4l0UjQ=;
        b=nOm/zP9qX7nlptEFA/jDIJ5HVDwR5VwoN96KofngwXxRDTqNB85IL9jCwuROKV6iZx
         ADs0TcpoeUHBbsetvlD4mIIHDBHUiYJZP7l9HSgwcq0HdS48CAzw++YoIFUdrCvF5dLf
         LyhnKMwE+HyiMkmyipuy8JhTdYHFA0LojS9ayWqqmWHfJSnvmHRKuqnOBrL5o/CsUY5l
         k8Ah465az6E6ZNArW2fIaQDZqvew6JdsMx41aTFq1cQm3y2/cHHq8WNOu50b8CDhyj8B
         N2l4hQbrCihLvxfeICuN+6+D8tN2nuIZCHUfdlaKp2SNXSaHpsvMCFky4ADI4D7e4z5r
         MsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaDd0ODXQ6mBIvOHNDB+WJAKo8Eo3Nj0ghA1H4l0UjQ=;
        b=AB37SGMvgNqjqK8UgFgOMC5vq8HoU8pvBB6HyoX+PoulWNLbN4hydf9LqC9512bIam
         grf2b2wb/Z9Zb15wFPF5IRMPMNR4zx04rW2ReZgKloPmF6sSvdDXZOhwRamLsLXneP/a
         2S0WykD19ZERT/qX9nV+fAwEzzQ3M22LtT4h7zSZzhySm0xG7GVymsYb171//DI5YhYM
         fE7X48/oI4nV5cEoINjvlqERmTYLos+luIzvXa3zO47d65rsWmYuUufdVx9epj2vE1eP
         tD/YquYPk5iXPQA9uVLmrh4tsekTzVEqHH9n9IUr794MBn8kGVtr+lxXzeVEmV7V0fer
         jkaQ==
X-Gm-Message-State: ACrzQf1c1qBPFa3HMmPK4B0lLM7ggqgyknwtekaqYN7dEujE3PWZ165j
        +nRtb+QKlXIfBMfVVbqRybM0lqDXmfuIX5/GvVpDbg==
X-Google-Smtp-Source: AMsMyM5y5E1JaUuUcczNXBzhys3kFZcIfqZyKc02F0dcjkz3TJo4n7foKSQbxRDuuCgcs7BwYaIuzPJY+nOSPRs3GIY=
X-Received: by 2002:a05:600c:19ce:b0:3b4:c709:4307 with SMTP id
 u14-20020a05600c19ce00b003b4c7094307mr21174171wmq.182.1665443856936; Mon, 10
 Oct 2022 16:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-11-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-11-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 16:17:24 -0700
Message-ID: <CAP-5=fWOsyXHC_wTjGr0MRoaohhWyQZA8jmn5W+RivNhp6tcaQ@mail.gmail.com>
Subject: Re: [PATCH 10/19] perf stat: Aggregate per-thread stats using evsel->stats->aggr
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
> Per-thread aggregation doesn't use the CPU numbers but the logic should
> be the same.  Initialize cpu_aggr_map separately for AGGR_THREAD and use
> thread map idx to aggregate counter values.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 31 +++++++++++++++++++++++++++++++
>  tools/perf/util/stat.c    | 19 +++++++++++++++++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 139e35ed68d3..c76240cfc635 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1468,6 +1468,21 @@ static int perf_stat_init_aggr_mode(void)
>                 stat_config.aggr_get_id = aggr_mode__get_id(stat_config.aggr_mode);
>         }
>
> +       if (stat_config.aggr_mode == AGGR_THREAD) {
> +               nr = perf_thread_map__nr(evsel_list->core.threads);
> +               stat_config.aggr_map = cpu_aggr_map__empty_new(nr);
> +               if (stat_config.aggr_map == NULL)
> +                       return -ENOMEM;
> +
> +               for (int s = 0; s < nr; s++) {
> +                       struct aggr_cpu_id id = aggr_cpu_id__empty();
> +
> +                       id.thread_idx = s;
> +                       stat_config.aggr_map->map[s] = id;
> +               }
> +               return 0;
> +       }
> +
>         /*
>          * The evsel_list->cpus is the base we operate on,
>          * taking the highest cpu number to be the size of
> @@ -1677,6 +1692,22 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
>         aggr_cpu_id_get_t get_id = aggr_mode__get_aggr_file(stat_config.aggr_mode);
>         bool needs_sort = stat_config.aggr_mode != AGGR_NONE;
>
> +       if (stat_config.aggr_mode == AGGR_THREAD) {
> +               int nr = perf_thread_map__nr(evsel_list->core.threads);
> +
> +               stat_config.aggr_map = cpu_aggr_map__empty_new(nr);
> +               if (stat_config.aggr_map == NULL)
> +                       return -ENOMEM;
> +
> +               for (int s = 0; s < nr; s++) {
> +                       struct aggr_cpu_id id = aggr_cpu_id__empty();
> +
> +                       id.thread_idx = s;
> +                       stat_config.aggr_map->map[s] = id;
> +               }
> +               return 0;
> +       }
> +
>         if (!get_id)
>                 return 0;
>
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 99874254809d..013dbe1c5d28 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -403,6 +403,24 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
>                 evsel__compute_deltas(evsel, cpu_map_idx, thread, count);
>         perf_counts_values__scale(count, config->scale, NULL);
>
> +       if (config->aggr_mode == AGGR_THREAD) {
> +               struct perf_counts_values *aggr_counts = &ps->aggr[thread].counts;
> +
> +               /*
> +                * Skip value 0 when enabling --per-thread globally,
> +                * otherwise too many 0 output.
> +                */
> +               if (count->val == 0 && config->system_wide)
> +                       return 0;
> +
> +               ps->aggr[thread].nr++;
> +
> +               aggr_counts->val += count->val;
> +               aggr_counts->ena += count->ena;
> +               aggr_counts->run += count->run;
> +               goto update;

nit: perhaps there is a more intention revealing name than update here.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> +       }
> +
>         if (ps->aggr) {
>                 struct perf_cpu cpu = perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx);
>                 struct aggr_cpu_id aggr_id = config->aggr_get_id(config, cpu);
> @@ -437,6 +455,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
>                 }
>         }
>
> +update:
>         switch (config->aggr_mode) {
>         case AGGR_THREAD:
>         case AGGR_CORE:
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
