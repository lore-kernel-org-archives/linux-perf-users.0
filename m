Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098BFC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Oct 2022 22:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiJJWVv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Oct 2022 18:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJJWVt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Oct 2022 18:21:49 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B0D5C944
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 15:21:46 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a3so18973599wrt.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 15:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G/wYzmbA6+gMDeR2BM5mvVlEp0/hUq2QWaok3j3uzqk=;
        b=NXts5Mwo//pGvcNR8yXDV6cr3Q8Y0Kg5XXrNUow+3cVirTRLEhaKGnCx4bLqUb72mg
         /tqfsH/Ap+COQfNccPRXM+mYeDpR0MPItEEcHCe897pTpXZFiCBlXEOZGIe4uO/QVqKp
         t6trAW5Xn6GAgHp1Xlz3IPZMkezz9quORbEkoqN1SilRvRvNB+rk3/k5raU8VZ9qXwbU
         Yc6spKIqZ20S2ceg3qPgSmB28TaShdPiMHKA8EXmC4o05IuXRE/d0lU+RyKPVLKfsDyW
         zf9LeFtBdF7k2oHAUZ677KS+TSRdTApcTET6iYJe/0z2UfzsTAxOTVIw508Cj8y5OZGw
         4LBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/wYzmbA6+gMDeR2BM5mvVlEp0/hUq2QWaok3j3uzqk=;
        b=Q++aXQXQzcXVN/8StmqCdyy8wFbC9pxG4BAl+ZT3Nvv4QmmksZrURRtsA0iuY8thPX
         TT4zoDvyeRsW1wxylx5Tw6QhvEKn2P1V14EfjnKNivDqHoAaLIiI3Hs5vYYJz8oRqikx
         ovIiyFAxJBJ+g8eTzNStVt+FebdVcqcXruFFJR1B28QqGVvSylX+fUbRRCpozWPfraX+
         ANi9ljfJVYUi5EkXBMIRYyALgF0sOAKXD/Fvm+cFVR6VLax/jkErOn7WPH8y+HXgks55
         CkoJj0r3IY1eUfsNRNDFG7+TMi3m1IBSmboCjRccO9n7Gqgs79VSfQMTgs8ZEHHGDlH6
         SyXg==
X-Gm-Message-State: ACrzQf3OF0tlh8weYUOjg+wC7wCG/zxf3H1qx01qmLsVMCRcg5YumJR6
        LZttkNmWf0fJwK1uBPBDpcuRdAuKaLSBUMkTlreiQQ==
X-Google-Smtp-Source: AMsMyM6tthXZkiaayDWZoyPDVFnmA59Wap4Ns4wRNSOWT1GksYHyp9KS8nnKaXpoQ67Ww7ORDhCTx84nshGQwlSVIxw=
X-Received: by 2002:adf:fd50:0:b0:22e:5503:9c4c with SMTP id
 h16-20020adffd50000000b0022e55039c4cmr12974711wrs.375.1665440505115; Mon, 10
 Oct 2022 15:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-2-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 15:21:33 -0700
Message-ID: <CAP-5=fV58VRhh_kvQfrA7gYQXiVDqPwXgQdXHCQg64qAT_W7Rw@mail.gmail.com>
Subject: Re: [PATCH 01/19] perf tools: Save evsel->pmu in parse_events()
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
> Now evsel has a pmu pointer, let's save the info and use it like in
> evsel__find_pmu().
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/evsel.c        | 1 +
>  tools/perf/util/parse-events.c | 1 +
>  tools/perf/util/pmu.c          | 4 ++++
>  3 files changed, 6 insertions(+)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 76605fde3507..196f8e4859d7 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -467,6 +467,7 @@ struct evsel *evsel__clone(struct evsel *orig)
>         evsel->collect_stat = orig->collect_stat;
>         evsel->weak_group = orig->weak_group;
>         evsel->use_config_name = orig->use_config_name;
> +       evsel->pmu = orig->pmu;
>
>         if (evsel__copy_config_terms(evsel, orig) < 0)
>                 goto out_err;
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 437389dacf48..9e704841273d 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -263,6 +263,7 @@ __add_event(struct list_head *list, int *idx,
>         evsel->core.own_cpus = perf_cpu_map__get(cpus);
>         evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
>         evsel->auto_merge_stats = auto_merge_stats;
> +       evsel->pmu = pmu;
>
>         if (name)
>                 evsel->name = strdup(name);
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 74a2cafb4e8d..15bf5943083a 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1048,11 +1048,15 @@ struct perf_pmu *evsel__find_pmu(struct evsel *evsel)
>  {
>         struct perf_pmu *pmu = NULL;
>
> +       if (evsel->pmu)
> +               return evsel->pmu;
> +
>         while ((pmu = perf_pmu__scan(pmu)) != NULL) {
>                 if (pmu->type == evsel->core.attr.type)
>                         break;
>         }
>
> +       evsel->pmu = pmu;
>         return pmu;
>  }
>
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
