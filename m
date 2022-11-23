Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39E6C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 23:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiKWX1f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 18:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiKWX1d (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 18:27:33 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7BD25D3
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:27:29 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e11so18808028wru.8
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y171LyMbl+d9pE/U0kir1w+2LkUocq5c8sm+WisaSFY=;
        b=APEuAHpfHj2oq8DyLnA/AtQIhzZCtT1HbTkSrTnxfmGeF1eSUJmvMheVJoOeo+6FTx
         +jXABgZbpe/J8PBn+ozuRgmHb1tTKx+7GMEkKGys8ahEoEtRzTcrs9GyeCWAS6eHIDOS
         BcgGfoagWxA7Bv/A6T7pZgDLzvsLe7xiNGAlGZ5/P7Dep57avfZ7vemINlf3/IWGxZN5
         9l9y/VcbPkGS/BdJwbHqcuuF7FShwTopQ9BLJ2hAfKv4VBWRghWVRWI2zYpPDlnCYbwr
         cjYuW2aO/z2YNipgA/OJh9O+AsAmCUY5xecINj3+XalGJVSmsBF79B1nMNJDruG6kgcu
         /PPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y171LyMbl+d9pE/U0kir1w+2LkUocq5c8sm+WisaSFY=;
        b=Kd9DWMZ+fUs0s/UrbcCTbmZTCPsbm/GSSvC7to6qbssM4yM2Y8pXoZtA1OMs5XvqCi
         8uWiR6t7dERXH9mn9Mo7rDB42lgc5/CoBLys192DSi92SLXNQbKBZn5Xb1YDhVlwUkMW
         sTNdKanMO5uXVuKe00X6G3mqORry/7bBSBJiV3p/5ER+DfZqrwyXHbt8cagytzOQVAZB
         cdzVP0yNn0I8C7oZzPtaxb75mW8Cr5CUhPWISTtrrq4WKRZ5KumzODSZx6kbEkSNS6OO
         NVr6v2FPICg7idC6i+KG46V2fp3L2Bj8omlqvxrtbvWVr3cmQIagOrEylkYiJWqxZV/7
         0A7Q==
X-Gm-Message-State: ANoB5pnM93DkN8fBjSfjjSFvy0tbQdAvW+LH23plMki9/pjyUX9M50+y
        Auga0fk5bgZakGy2r9Hs1eeLaN/ZLqyKnw8nH/R7lw==
X-Google-Smtp-Source: AA0mqf67WpQ1nBhDfxrztKImARiZctH65ZK7e3IW+GpvFklQZOjB7F9gOCFJy0/z9Uu2TMKcUPb/cUbuCLiuLLiyue8=
X-Received: by 2002:adf:d0cf:0:b0:241:f9c9:fdbd with SMTP id
 z15-20020adfd0cf000000b00241f9c9fdbdmr883154wrh.343.1669246048194; Wed, 23
 Nov 2022 15:27:28 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-12-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-12-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:27:15 -0800
Message-ID: <CAP-5=fUmKwWUXypzGP9dpSWL+mKrRdMU-DXJo9C86RQXk3gKSg@mail.gmail.com>
Subject: Re: [PATCH 11/15] perf stat: Do not pass runtime_stat to printout()
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
> It always passes a pointer to rt_stat as it's the only one.  Let's not
> pass it and directly refer it in the printout().
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index dd190f71e933..cdf4ca7f6e3a 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -674,8 +674,7 @@ static bool is_mixed_hw_group(struct evsel *counter)
>  }
>
>  static void printout(struct perf_stat_config *config, struct outstate *os,
> -                    double uval, u64 run, u64 ena, double noise,
> -                    struct runtime_stat *st, int map_idx)
> +                    double uval, u64 run, u64 ena, double noise, int map_idx)
>  {
>         struct perf_stat_output_ctx out;
>         print_metric_t pm;
> @@ -737,7 +736,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
>
>         if (ok) {
>                 perf_stat__print_shadow_stats(config, counter, uval, map_idx,
> -                                             &out, &config->metric_events, st);
> +                                             &out, &config->metric_events, &rt_stat);
>         } else {
>                 pm(config, &os, /*color=*/NULL, /*format=*/NULL, /*unit=*/"", /*val=*/0);
>         }
> @@ -834,7 +833,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>
>         uval = val * counter->scale;
>
> -       printout(config, &os, uval, run, ena, avg, &rt_stat, s);
> +       printout(config, &os, uval, run, ena, avg, s);
>
>         if (!metric_only)
>                 fputc('\n', output);
> @@ -987,7 +986,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>                         run = ps->aggr[counter_idx].counts.run;
>
>                         uval = val * counter->scale;
> -                       printout(config, &os, uval, run, ena, 1.0, &rt_stat, counter_idx);
> +                       printout(config, &os, uval, run, ena, 1.0, counter_idx);
>                 }
>                 if (!first)
>                         print_metric_end(config);
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
