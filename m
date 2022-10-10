Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3ABC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Oct 2022 23:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJJXbX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Oct 2022 19:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJJXbW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Oct 2022 19:31:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150725A894
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 16:31:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l8so7636418wmi.2
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 16:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/v6g9Kdleld/yeVPU6X4g4uNgysmsgRCmKP9+LCGWtM=;
        b=KysGkKqxoou7Gs0SDD/ty7UdXRnom0BsWjYgpCJTP/vZaodGC3Y4PUtYUOMfHZThyH
         UGh1WPIbn6IpYaBZ0ETH+2u1xaA4BjfIU/Js0jvIYeNF3RIpgtOGp1SmiW4Bn2kCebC8
         spzVKBVxUsaTK23Ul34sM++ohOws+nxpu6FCE2VHqqbMplH3vRjtP0zwUAIOic6Hd2+e
         5gtSUudOf3V1Mc3xuC5RPJ8W/43MnGYvNmyvMpas738vA+xCBR56sCRTK04XH902QVgF
         rH50uv+W2a63YSPKvfIgKz3FjcCpbFebgNBeVWpDWxypBVu9IbU3QbFHBJEsdBm9Lw63
         KQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/v6g9Kdleld/yeVPU6X4g4uNgysmsgRCmKP9+LCGWtM=;
        b=nzjeZnV3z9eIR51NM8dJdoCRGrcLx3Wzr0oaGgMTLh3auSzOAtBOSeliDHSgBSb3kQ
         jnSErJNvQQGcBGpnLwHtxMg9lk3WZaLJlW7KfxiB/DfltCw2/7xPPv/DJ3rnskdE7vI+
         zJTsDUcwp041/aUyEfNtwiB/9jyvhs2g+IcKppXP3YHVhLkxxRlQvVqx6n2+WZebATU+
         ValHV0mZkLRNqMik/ANFMIPrdF7+k0Zo/ycRRxPfnvO4PUoOjs0NsDmVD19Sv4BH+eT9
         IOQquxRtJasjimiy2FpdXitrpV5wYlQ54hZqATro+O9+udgpUOT8o/B4NNg1HcvXceLO
         89tQ==
X-Gm-Message-State: ACrzQf3jSTll3l9c7sdUmOnAy4oHYZQ65JMzye6ZcDPGONBgQNElkmOp
        Ffyu65ZyWr1vYsJgeQWpU3pgnOgvGdWcgD6NqbSbyuDfbrZ6ww==
X-Google-Smtp-Source: AMsMyM62f7RRRby9buK7I0POCSwoAyIv6zm2cJcUTxMAJ85tNU3YLz8SgQWzLg3ykvLENbzZBhN0AgR8O/B2xXMy8ho=
X-Received: by 2002:a05:600c:88a:b0:3c5:c9e3:15cc with SMTP id
 l10-20020a05600c088a00b003c5c9e315ccmr7075775wmp.67.1665444677484; Mon, 10
 Oct 2022 16:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-15-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-15-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 16:31:05 -0700
Message-ID: <CAP-5=fWxD6KJiHCDOK6UdgfQadnjCc6eMPmPY68T3TKYAz402Q@mail.gmail.com>
Subject: Re: [PATCH 14/19] perf stat: Add perf_stat_merge_counters()
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
> The perf_stat_merge_counters() is to aggregate the same events in different
> PMUs like in case of uncore or hybrid.  The same logic is in the stat-display
> routines but I think it should be handled when it processes the event counters.

I think I'm confused as to what a merged counter is. Does it relate to
the evsel leader? How are aliases and merging related?

Thanks,
Ian

>
> As it works on the aggr_counters, it doesn't change the output yet.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c |  2 +
>  tools/perf/util/stat.c    | 96 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/stat.h    |  2 +
>  3 files changed, 100 insertions(+)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 49a7e290d778..f90e8f29cb23 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -486,6 +486,8 @@ static void process_counters(void)
>                         pr_warning("failed to process counter %s\n", counter->name);
>                 counter->err = 0;
>         }
> +
> +       perf_stat_merge_counters(&stat_config, evsel_list);
>  }
>
>  static void process_interval(void)
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 4edfc1c5dc07..1bb197782a34 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -575,6 +575,102 @@ int perf_stat_process_counter(struct perf_stat_config *config,
>         return 0;
>  }
>
> +static int evsel__merge_aggr_counters(struct evsel *evsel, struct evsel *alias)
> +{
> +       struct perf_stat_evsel *ps_a = evsel->stats;
> +       struct perf_stat_evsel *ps_b = alias->stats;
> +       int i;
> +
> +       if (ps_a->aggr == NULL && ps_b->aggr == NULL)
> +               return 0;
> +
> +       if (ps_a->nr_aggr != ps_b->nr_aggr) {
> +               pr_err("Unmatched aggregation mode between aliases\n");
> +               return -1;
> +       }
> +
> +       for (i = 0; i < ps_a->nr_aggr; i++) {
> +               struct perf_counts_values *aggr_counts_a = &ps_a->aggr[i].counts;
> +               struct perf_counts_values *aggr_counts_b = &ps_b->aggr[i].counts;
> +
> +               /* NB: don't increase aggr.nr for aliases */
> +
> +               aggr_counts_a->val += aggr_counts_b->val;
> +               aggr_counts_a->ena += aggr_counts_b->ena;
> +               aggr_counts_a->run += aggr_counts_b->run;
> +       }
> +
> +       return 0;
> +}
> +/* events should have the same name, scale, unit, cgroup but on different PMUs */
> +static bool evsel__is_alias(struct evsel *evsel_a, struct evsel *evsel_b)
> +{
> +       if (strcmp(evsel__name(evsel_a), evsel__name(evsel_b)))
> +               return false;
> +
> +       if (evsel_a->scale != evsel_b->scale)
> +               return false;
> +
> +       if (evsel_a->cgrp != evsel_b->cgrp)
> +               return false;
> +
> +       if (strcmp(evsel_a->unit, evsel_b->unit))
> +               return false;
> +
> +       if (evsel__is_clock(evsel_a) != evsel__is_clock(evsel_b))
> +               return false;
> +
> +       return !!strcmp(evsel_a->pmu_name, evsel_b->pmu_name);
> +}
> +
> +static void evsel__merge_aliases(struct evsel *evsel)
> +{
> +       struct evlist *evlist = evsel->evlist;
> +       struct evsel *alias;
> +
> +       alias = list_prepare_entry(evsel, &(evlist->core.entries), core.node);
> +       list_for_each_entry_continue(alias, &evlist->core.entries, core.node) {
> +               /* Merge the same events on different PMUs. */
> +               if (evsel__is_alias(evsel, alias)) {
> +                       evsel__merge_aggr_counters(evsel, alias);
> +                       alias->merged_stat = true;
> +               }
> +       }
> +}
> +
> +static bool evsel__should_merge_hybrid(struct evsel *evsel, struct perf_stat_config *config)
> +{
> +       struct perf_pmu *pmu;
> +
> +       if (!config->hybrid_merge)
> +               return false;
> +
> +       pmu = evsel__find_pmu(evsel);
> +       return pmu && pmu->is_hybrid;
> +}
> +
> +static void evsel__merge_stats(struct evsel *evsel, struct perf_stat_config *config)
> +{
> +       /* this evsel is already merged */
> +       if (evsel->merged_stat)
> +               return;
> +
> +       if (evsel->auto_merge_stats || evsel__should_merge_hybrid(evsel, config))
> +               evsel__merge_aliases(evsel);
> +}
> +
> +/* merge the same uncore and hybrid events if requested */
> +void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *evlist)
> +{
> +       struct evsel *evsel;
> +
> +       if (config->no_merge)
> +               return;
> +
> +       evlist__for_each_entry(evlist, evsel)
> +               evsel__merge_stats(evsel, config);
> +}
> +
>  int perf_event__process_stat_event(struct perf_session *session,
>                                    union perf_event *event)
>  {
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 3a876ad2870b..12cc60ab04e4 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -270,6 +270,8 @@ void evlist__reset_aggr_stats(struct evlist *evlist);
>
>  int perf_stat_process_counter(struct perf_stat_config *config,
>                               struct evsel *counter);
> +void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *evlist);
> +
>  struct perf_tool;
>  union perf_event;
>  struct perf_session;
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
