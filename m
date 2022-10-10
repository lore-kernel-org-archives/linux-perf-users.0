Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78494C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Oct 2022 23:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJJXko (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Oct 2022 19:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJJXkm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Oct 2022 19:40:42 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F884C61B
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 16:40:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id iv17so7645867wmb.4
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 16:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xBZcWreQX16JxAjCNXwmCudxlP70YGvoe0KZuGaf33U=;
        b=XfPudV56hwtVG+Zn0bP5XbEk/wMiIqRjeRdRc3D6Dpp3P1tMy26PzOinO7OLnTztqV
         l0NOU7yw8diYC2TUfEd8dcXG/0k4zmYqUZfvuWVPRBQpn3AN4GMIho8Rb/TlQpwBO0Ll
         fyzFzWQa5D41RcBpjzPBBKfevI6SJNhmIdpN+54Imw+QQ3gRUuFLu2vxxMXTkp4Z28aN
         CTk/0itFoAKir0LXdqn9bxcAyMC8odLyqElaqQf28rshl6dzlYLkQ6IhuR15tP5U5d2Q
         xzy30WFpZuEt+jNZTDCYbySRtXzXni0sBHCbhP5kbM5SDJ1OSTODv8EkkrUKX5JWwkL9
         M7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBZcWreQX16JxAjCNXwmCudxlP70YGvoe0KZuGaf33U=;
        b=XOILe9Wqf1n14ZqEE9R/yhDUpd6E7Fqc6MkOcqmEg8r7WzrGJlqqKPaDyXQcuBmRqL
         5iOPmjH1duUsdk+K2otx4Jo67oLiDejF97DZ7PCPEvzgJvSG4aA3YKmQg4WQvdIyZAm7
         NFuz+vSssBkxwUSkJ8Yn8ed4503DYjra4bqVNOJ/JCbXNqq3lurImvVOOqY03tYzVyhQ
         Y/8qcnwUozJh1rR13J8lIhpJXBgGEhF2cP2+vQO/F8JQAucl/r1Md7LjoKmpzRaFCcau
         GuU32iF+gB+84XGeLohhJiJYnQFHRQCZJy8Tb1wU0F//TZWtsKl+VhaqGBpfSPdl79nx
         2Ilg==
X-Gm-Message-State: ACrzQf1w3l+GyyX9OzrdBuUNlDyohyNz8/YUh0H/OQ+UXJaB5Xv8ew0V
        /Sltpqk9U2+8Sq8eg0iFHa0aatmTbY9HWA4etmFhXA==
X-Google-Smtp-Source: AMsMyM6ypQJ/vJCBVBKT83dEQueinqyZJ7USEWmeOwIUpr5OGP4P+YfjVVdEvs5jaMCaQj1NpLo4BZP0uae65xQAQ94=
X-Received: by 2002:a05:600c:4e94:b0:3b4:b416:46c3 with SMTP id
 f20-20020a05600c4e9400b003b4b41646c3mr14654211wmq.149.1665445239324; Mon, 10
 Oct 2022 16:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-20-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-20-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 16:40:25 -0700
Message-ID: <CAP-5=fUND5eef4E0aY3UOx6sLKsJmhbcJ8reBstVrvaUpdaKGQ@mail.gmail.com>
Subject: Re: [PATCH 19/19] perf stat: Remove unused perf_counts.aggr field
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
> The aggr field in the struct perf_counts is to keep the aggregated value
> in the AGGR_GLOBAL for the old code.  But it's not used anymore.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/counts.c |  1 -
>  tools/perf/util/counts.h |  1 -
>  tools/perf/util/stat.c   | 35 ++---------------------------------
>  3 files changed, 2 insertions(+), 35 deletions(-)

Very nice!

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>
> diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
> index 7a447d918458..11cd85b278a6 100644
> --- a/tools/perf/util/counts.c
> +++ b/tools/perf/util/counts.c
> @@ -48,7 +48,6 @@ void perf_counts__reset(struct perf_counts *counts)
>  {
>         xyarray__reset(counts->loaded);
>         xyarray__reset(counts->values);
> -       memset(&counts->aggr, 0, sizeof(struct perf_counts_values));
>  }
>
>  void evsel__reset_counts(struct evsel *evsel)
> diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
> index 5de275194f2b..42760242e0df 100644
> --- a/tools/perf/util/counts.h
> +++ b/tools/perf/util/counts.h
> @@ -11,7 +11,6 @@ struct evsel;
>
>  struct perf_counts {
>         s8                        scaled;
> -       struct perf_counts_values aggr;
>         struct xyarray            *values;
>         struct xyarray            *loaded;
>  };
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 1652586a4925..0dccfa273fa7 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -307,8 +307,6 @@ static void evsel__copy_prev_raw_counts(struct evsel *evsel)
>                                 *perf_counts(evsel->prev_raw_counts, idx, thread);
>                 }
>         }
> -
> -       evsel->counts->aggr = evsel->prev_raw_counts->aggr;
>  }
>
>  void evlist__copy_prev_raw_counts(struct evlist *evlist)
> @@ -319,26 +317,6 @@ void evlist__copy_prev_raw_counts(struct evlist *evlist)
>                 evsel__copy_prev_raw_counts(evsel);
>  }
>
> -void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
> -{
> -       struct evsel *evsel;
> -
> -       /*
> -        * To collect the overall statistics for interval mode,
> -        * we copy the counts from evsel->prev_raw_counts to
> -        * evsel->counts. The perf_stat_process_counter creates
> -        * aggr values from per cpu values, but the per cpu values
> -        * are 0 for AGGR_GLOBAL. So we use a trick that saves the
> -        * previous aggr value to the first member of perf_counts,
> -        * then aggr calculation in process_counter_values can work
> -        * correctly.
> -        */
> -       evlist__for_each_entry(evlist, evsel) {
> -               *perf_counts(evsel->prev_raw_counts, 0, 0) =
> -                       evsel->prev_raw_counts->aggr;
> -       }
> -}
> -
>  static size_t pkg_id_hash(const void *__key, void *ctx __maybe_unused)
>  {
>         uint64_t *key = (uint64_t *) __key;
> @@ -422,7 +400,6 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
>                        int cpu_map_idx, int thread,
>                        struct perf_counts_values *count)
>  {
> -       struct perf_counts_values *aggr = &evsel->counts->aggr;
>         struct perf_stat_evsel *ps = evsel->stats;
>         static struct perf_counts_values zero;
>         bool skip = false;
> @@ -491,12 +468,6 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
>                 }
>         }
>
> -       if (config->aggr_mode == AGGR_GLOBAL) {
> -               aggr->val += count->val;
> -               aggr->ena += count->ena;
> -               aggr->run += count->run;
> -       }
> -
>         return 0;
>  }
>
> @@ -521,13 +492,10 @@ static int process_counter_maps(struct perf_stat_config *config,
>  int perf_stat_process_counter(struct perf_stat_config *config,
>                               struct evsel *counter)
>  {
> -       struct perf_counts_values *aggr = &counter->counts->aggr;
>         struct perf_stat_evsel *ps = counter->stats;
> -       u64 *count = counter->counts->aggr.values;
> +       u64 *count;
>         int ret;
>
> -       aggr->val = aggr->ena = aggr->run = 0;
> -
>         if (counter->per_pkg)
>                 evsel__zero_per_pkg(counter);
>
> @@ -538,6 +506,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
>         if (config->aggr_mode != AGGR_GLOBAL)
>                 return 0;
>
> +       count = ps->aggr[0].counts.values;
>         update_stats(&ps->res_stats, *count);
>
>         if (verbose > 0) {
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
