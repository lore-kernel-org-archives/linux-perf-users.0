Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3C4C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 23:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKWXX5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 18:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiKWXX4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 18:23:56 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73942107E52
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:23:55 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id n3so15144295wrp.5
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/9LTOrYBFROY+J53JzcAqe4XbAk9YHgZ2tzYpbRVsQA=;
        b=m3fUM1KIyfqKrYbp/jYVL6oBSpj9ru9NcUVqumrSs93TcSpPzG6307LYDSCdbVDSBs
         nMAoEShSOeHGtfAWyH8Wm/695q/lBqNPBdCQeKiGYTAAz5LN68njEWY9WQdLngExOCwn
         XJgrlI9Zt154R9xi5zmN0FvdbH3N6Frd8SGVOv4sxSyTVZIhnGFFhrYyMhRG38gWaQ+N
         4E6jmKaY1iR6aPLAKY/Qn9HlXZpgLGVuj80CmtbMaBAzjapi/NQ+e9XsLZ7TQe1BxDnK
         M0L8wDDkuy31lglqpOcaRNtT3yaei69c5QA+aqTI5o/fTWHV2X2R03sQlEydTS+BPIry
         caHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9LTOrYBFROY+J53JzcAqe4XbAk9YHgZ2tzYpbRVsQA=;
        b=RVUE/Q+6QsKBMMSuPHkDgrv1lJNzQCAli/4RrS6vnWcE1+SoMM6l3/uMJh4uDuD3rx
         dgfpbjFOqxHI79+m9ZddABGDQ6gHLF91P9Di9PdO/RL9wrU20wDDE2N/wGLgvaI/q64r
         xp2iZymAUHI9lwEd3OFTXdEi2DDRxgJNPw71G0JmQCFvjwKJIh2tIqgYQEbQMIkphOrx
         aPVIfDhGAIIbAED8SuM4yi6ciKJJUbiUYWpjnxzlujM2j8+2hnn+heyFYlZ1U3qFvLrH
         FqG8Ean9cfVTNQeibsMVN9hXZNbEntuul++/MLwpDo/7Q+VuiNAZOs9pyaRYLqQTgHhP
         A4UQ==
X-Gm-Message-State: ANoB5plOAZ1PgEJMvzJ2om8T6U6G1jrmEFYv6tK/E++5arR1XJE93c42
        L7Yzk0mE0Cr9a6c8JtFTFK7hRBsROW/YldVCzpNH2w==
X-Google-Smtp-Source: AA0mqf6fv8Cr2gutZIowNX4wL+XEfCdj5WXYjAFsZUWmw29ex04PORJtgHiZMEMxYiZLDJfGo3lrPfLd7UIHxLZKtbE=
X-Received: by 2002:adf:f944:0:b0:236:8f54:f1f4 with SMTP id
 q4-20020adff944000000b002368f54f1f4mr18768113wrr.654.1669245833890; Wed, 23
 Nov 2022 15:23:53 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-7-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-7-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:23:41 -0800
Message-ID: <CAP-5=fXZddVYS5VbJMmiq4CoBROXvDoBmr_m9yH=cNWPQTN63w@mail.gmail.com>
Subject: Re: [PATCH 06/15] perf stat: Remove metric_only argument in print_counter_aggrdata()
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
> It already passes the stat_config argument, then it can find the value in the
> config.  No need to pass it separately.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index deed6ccf072f..b8432c0a0ec3 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -804,7 +804,7 @@ static void uniquify_counter(struct perf_stat_config *config, struct evsel *coun
>
>  static void print_counter_aggrdata(struct perf_stat_config *config,
>                                    struct evsel *counter, int s,
> -                                  char *prefix, bool metric_only)
> +                                  char *prefix)
>  {
>         FILE *output = config->output;
>         u64 ena, run, val;
> @@ -813,6 +813,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>         struct perf_stat_aggr *aggr = &ps->aggr[s];
>         struct aggr_cpu_id id = config->aggr_map->map[s];
>         double avg = aggr->counts.val;
> +       bool metric_only = config->metric_only;
>
>         if (counter->supported && aggr->nr == 0)
>                 return;
> @@ -875,7 +876,6 @@ static void print_aggr(struct perf_stat_config *config,
>                        struct evlist *evlist,
>                        char *prefix)
>  {
> -       bool metric_only = config->metric_only;
>         struct evsel *counter;
>         int s;
>
> @@ -893,8 +893,7 @@ static void print_aggr(struct perf_stat_config *config,
>                         if (counter->merged_stat)
>                                 continue;
>
> -                       print_counter_aggrdata(config, counter, s, prefix,
> -                                              metric_only);
> +                       print_counter_aggrdata(config, counter, s, prefix);
>                 }
>                 print_metric_end(config);
>         }
> @@ -904,7 +903,6 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
>                               struct evlist *evlist,
>                               char *prefix)
>  {
> -       bool metric_only = config->metric_only;
>         struct evsel *counter, *evsel;
>         struct cgroup *cgrp = NULL;
>         int s;
> @@ -928,8 +926,7 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
>                                 if (counter->cgrp != cgrp)
>                                         continue;
>
> -                               print_counter_aggrdata(config, counter, s, prefix,
> -                                                      metric_only);
> +                               print_counter_aggrdata(config, counter, s, prefix);
>                         }
>                         print_metric_end(config);
>                 }
> @@ -939,7 +936,6 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
>  static void print_counter(struct perf_stat_config *config,
>                           struct evsel *counter, char *prefix)
>  {
> -       bool metric_only = config->metric_only;
>         int s;
>
>         /* AGGR_THREAD doesn't have config->aggr_get_id */
> @@ -950,8 +946,7 @@ static void print_counter(struct perf_stat_config *config,
>                 return;
>
>         for (s = 0; s < config->aggr_map->nr; s++) {
> -               print_counter_aggrdata(config, counter, s, prefix,
> -                                      metric_only);
> +               print_counter_aggrdata(config, counter, s, prefix);
>         }
>  }
>
> @@ -1339,7 +1334,7 @@ static void print_percore(struct perf_stat_config *config,
>                 if (found)
>                         continue;
>
> -               print_counter_aggrdata(config, counter, s, prefix, metric_only);
> +               print_counter_aggrdata(config, counter, s, prefix);
>
>                 core_map->map[c++] = core_id;
>         }
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
