Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7987C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Oct 2022 22:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJJWdF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Oct 2022 18:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJJWdE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Oct 2022 18:33:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9CA5F7C3
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 15:33:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so4096756wma.3
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 15:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b84Mp8WPmv+V8VPNOsJnOQtQBtwAIaKOf1r81e26uMM=;
        b=le0/qN6D/NvMLVGXOGx+db9ejU8GmDnAm7b1PdYDPDJGdBqHu1EWO4xndC/AH2bEPZ
         igWJkSO6HgUHymQR7NKvbE8XXp7LDBysWgYZQFstX4bWRcgh8LFbTL/fXfQ8sIjDzgyx
         ZaiT0v/1TxPDGZLNyq6c8G2r8aj8Um4TlP6ORRSsYCXdVRxBGiN0QIga2MFFzV70545p
         1mUHwJijJYeoYMcbN0qBBC7s/k9lzcNJbQ04rKnSD7QgwVAy5X6Z2LEkBiyEhmz1k0SP
         5K6LvOq/0rhhGrmuEr3lf3zr1wRVCI/LsO3h5Isvua/HRBo04rzeuM5tWAMpNa4jxG7Y
         RLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b84Mp8WPmv+V8VPNOsJnOQtQBtwAIaKOf1r81e26uMM=;
        b=l2jvpo6e2DLVlRkLJtNdl0utJifQ2Byt7PjWhfQx7Tz8Mi8S7ErQBxq3YP811P5zoa
         fFVrotcP/7u3b9prvUqQLcjLm/BCt4tuFRPMcKAZxnTwfWOE5VG70cwTNb6hMtZ9otLV
         /ohaKJlgKP1MkU1qfOeZ9Xjkr/UrucGzfrV7hgbJ/N4K/8YCmiaQbCNwKq4bwGKk1iGk
         p7wygOiGX7P+kUzmmYACrWVxWpNp1/tWHcFAjRSD42njNOhuQ933wofiBCKPxSpBI87Y
         ddbE9NFDA6wSuD1QN5iINt/dFYXpsfIFon8Vv0aKxgtvn5xCMN7nSTN+FivZUyGvH2oz
         oJvg==
X-Gm-Message-State: ACrzQf29OdHiteH5FtXiitNfcRMAqqkF4VIjvXyEN0q+13yC7B/3cu/u
        iKmeVWhIJO51wdGbDoKxOQEAoTFlcwV1B5LafjGtQOFTdd93bg==
X-Google-Smtp-Source: AMsMyM6twfkEC4RDL89F4fZ9Hv1Hy6451EfvtruUSif3ZBySTujPli59Rfxtlg7DMl79f7Vb0tuimQUh9kO3tRftkf4=
X-Received: by 2002:a05:600c:88a:b0:3c5:c9e3:15cc with SMTP id
 l10-20020a05600c088a00b003c5c9e315ccmr6968017wmp.67.1665441182223; Mon, 10
 Oct 2022 15:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-4-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-4-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 15:32:50 -0700
Message-ID: <CAP-5=fW_z9z+46AKwh4GqM=2skXyLXkCMEOO4kxT0kShEp9k2Q@mail.gmail.com>
Subject: Re: [PATCH 03/19] perf stat: Use evsel__is_hybrid() more
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
> In the stat-display code, it needs to check if the current evsel is
> hybrid but it uses perf_pmu__has_hybrid() which can return true for
> non-hybrid event too.  I think it's better to use evsel__is_hybrid().
>
> Also remove a NULL check for the 'config' parameter in the
> hybrid_merge() since it's called after config->no_merge check.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 5c47ee9963a7..4113aa86772f 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -704,7 +704,7 @@ static void uniquify_event_name(struct evsel *counter)
>                         counter->name = new_name;
>                 }
>         } else {
> -               if (perf_pmu__has_hybrid()) {
> +               if (evsel__is_hybrid(counter)) {
>                         ret = asprintf(&new_name, "%s/%s/",
>                                        counter->pmu_name, counter->name);
>                 } else {
> @@ -744,26 +744,14 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
>         }
>  }
>
> -static bool is_uncore(struct evsel *evsel)
> -{
> -       struct perf_pmu *pmu = evsel__find_pmu(evsel);
> -
> -       return pmu && pmu->is_uncore;
> -}
> -
> -static bool hybrid_uniquify(struct evsel *evsel)
> -{
> -       return perf_pmu__has_hybrid() && !is_uncore(evsel);
> -}
> -
>  static bool hybrid_merge(struct evsel *counter, struct perf_stat_config *config,
>                          bool check)
>  {
> -       if (hybrid_uniquify(counter)) {
> +       if (evsel__is_hybrid(counter)) {
>                 if (check)
> -                       return config && config->hybrid_merge;
> +                       return config->hybrid_merge;
>                 else
> -                       return config && !config->hybrid_merge;
> +                       return !config->hybrid_merge;
>         }
>
>         return false;
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
