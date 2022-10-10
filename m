Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371E4C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Oct 2022 23:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJJXUu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Oct 2022 19:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJJXUt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Oct 2022 19:20:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89BC7CAB5
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 16:20:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bu30so19037235wrb.8
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 16:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SReBSNXJSjBEiybMLn7KKcPydzCWliKitOyiQi1E3t8=;
        b=TaOZBGXXHBlERL+P74iMR5xvGa+Z1HS9F4iTK5i88CIU1KRy+Nw8MI96jSr3XAEsRA
         4a0yvPC4fEAz/rdgalcV7N1SlPYRAQoHZJvub7ZkoksNL4Dnma6G3PsmitjtKiIzeqBF
         OAhEub1m/L50y/3AcuZyNWLlcpcn8CYabGkM7f4wBDtPSWj1PmfEvSPjkP48lUQN8GCo
         MlaJSvjuJSO0Ve797EiAuLclFiBSGo14yXnVCzCPp4qZCW2u6XwQ332NsoZUQC0cm5CB
         4AJ9b/5oPjyDl0dUgiLT94MDQDzM42o3yrLw4Wkd18krMS6nQlIPXDyCV0hBC6dH0UsG
         nFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SReBSNXJSjBEiybMLn7KKcPydzCWliKitOyiQi1E3t8=;
        b=mWaBnjRGAEMMaS/KIsguXsEcXTeVktYLYUvFnaB8a/XPdpyB0dSEQH4kNaZS1qo/Rr
         i9WKavsBy6mt0gQe2UG1YUKKT9H1r4c2dAqoVFDF3QcFlnrC44UhZtb7j7o2tq0Fy3Cs
         yZmztPFI6iAHVNgt/wy1b7/SiB8a1nhTHFR5sUhbhyiAZvAQmZdYOZjKU3l1NjqgGmG4
         3y7WF3aqcv3bHjnCNiiqRddJ9QamFbUysMvzeMOP7TNJAHgfyWULoa2hzG5PEQCqfALx
         /6rhcLWbD/fpBIWyU5GeJs35QF3VnnPuFLUVCUg65ymLzpjty/0zOsXi4EDvhammIc5i
         aQkQ==
X-Gm-Message-State: ACrzQf2vlOcsXCUybGsr26rhKkgVdTAbksqLHHB0Jf7Bz5/iV0sx7Aev
        0HOb/BtxGFOgpAV1tkAFJEYjfVWMECllQdPL3sr4ZQ==
X-Google-Smtp-Source: AMsMyM4yNlLQdv+wlqagN8xpjPtB1Z7bWjw2NPY3HWVZZaSRbCM+zFlX9KFi2mL5buGRCQdtp71WexIAl2tp0brjWRs=
X-Received: by 2002:a5d:68d0:0:b0:22c:dfba:3bd6 with SMTP id
 p16-20020a5d68d0000000b0022cdfba3bd6mr12752265wrw.300.1665444045207; Mon, 10
 Oct 2022 16:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-13-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-13-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 16:20:32 -0700
Message-ID: <CAP-5=fVeJAfgWU62vY6LK6Buj2BFrpwwYw_mxt3F-VEUEf7NiQ@mail.gmail.com>
Subject: Re: [PATCH 12/19] perf stat: Reset aggr counts for each interval
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
> The evsel->stats->aggr->count should be reset for interval processing
> since we want to use the values directly for display.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c |  3 +++
>  tools/perf/util/stat.c    | 13 +++++++++++++
>  tools/perf/util/stat.h    |  1 +
>  3 files changed, 17 insertions(+)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 983f38cd4caa..38036f40e993 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -492,6 +492,8 @@ static void process_interval(void)
>         diff_timespec(&rs, &ts, &ref_time);
>
>         perf_stat__reset_shadow_per_stat(&rt_stat);
> +       evlist__reset_aggr_stats(evsel_list);
> +
>         read_counters(&rs);
>
>         if (STAT_RECORD) {
> @@ -965,6 +967,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>
>                 evlist__copy_prev_raw_counts(evsel_list);
>                 evlist__reset_prev_raw_counts(evsel_list);
> +               evlist__reset_aggr_stats(evsel_list);
>                 perf_stat__reset_shadow_per_stat(&rt_stat);
>         } else {
>                 update_stats(&walltime_nsecs_stats, t1 - t0);
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 279aa4ea342d..4edfc1c5dc07 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -276,6 +276,19 @@ void evlist__reset_stats(struct evlist *evlist)
>         }
>  }
>
> +void evlist__reset_aggr_stats(struct evlist *evlist)
> +{
> +       struct evsel *evsel;
> +
> +       evlist__for_each_entry(evlist, evsel) {
> +               struct perf_stat_evsel *ps = evsel->stats;
> +               struct perf_stat_aggr *aggr = ps->aggr;
> +
> +               if (aggr)
> +                       memset(aggr, 0, sizeof(*aggr) * ps->nr_aggr);

Perhaps this would be cleaner with helper functions on perf_stat_evsel
and perf_stat_aggr?

Thanks,
Ian

> +       }
> +}
> +
>  void evlist__reset_prev_raw_counts(struct evlist *evlist)
>  {
>         struct evsel *evsel;
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 936c0709ce0d..3a876ad2870b 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -266,6 +266,7 @@ void evlist__copy_prev_raw_counts(struct evlist *evlist);
>  void evlist__save_aggr_prev_raw_counts(struct evlist *evlist);
>
>  int evlist__alloc_aggr_stats(struct evlist *evlist, int nr_aggr);
> +void evlist__reset_aggr_stats(struct evlist *evlist);
>
>  int perf_stat_process_counter(struct perf_stat_config *config,
>                               struct evsel *counter);
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
