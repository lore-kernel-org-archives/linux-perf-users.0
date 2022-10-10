Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEEAC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Oct 2022 22:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJJWb5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Oct 2022 18:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJJWb4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Oct 2022 18:31:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33675F21D
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 15:31:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 8-20020a1c0208000000b003c6c154d528so6247wmc.4
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 15:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mMeBZI01pweMz96J1evuUNhHnC+bi0LzWmx+t9kc3Hk=;
        b=XtpEBAu8lU9U+ozyrhckzQ0AXwy2uAzRHuNY1n1TjPmPqMxmohFndVXuMC3Tge+uwb
         +lSrUfMLtSGCVkj50MXOy6jHNwnDbhZeHUvJHldkF3rsY+JUDP8NQ3S8wEJ+t3CyOcA6
         Gwd2qL5QhxfuuDiLS/8Xjk0CjxV3qIFE5ghXksCYtML4ZAjhO1mhaT1T9nZ/4fEAaBzh
         IiVgYNu7+D3x6v7qCOFKabHUowLvLapprP3ynB1wapvV3iPHZV+/DVgTSY9IKimsCQzb
         s7EBv32s3ckg31T0oyt5ZyjBoBk0/L8d1vs+mWe1VjlAV3gNUACJ0yjReErUeao3PDmj
         FjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMeBZI01pweMz96J1evuUNhHnC+bi0LzWmx+t9kc3Hk=;
        b=wsM6xM/+y8XGeGZ2QmwVVWE41vX5zWgmzxdp9DFGz27b8MMj9OiotTVCONSm3dH8wN
         wYWAb+1ZVYeHjASfKsCv9iAoOT8fe3morp5ajr6feBiv4EYxZGA6j/p2SsC4F/zxTDIP
         gBUIOEIccrp6MR/I7RNRN1IU1QY/Ka8YT4bmqckIF5n9gBEFgdOeXfExGwfmpyvG9F5a
         Ks9r9u7zaM+GbO5rAlaQ6ygin8++fmTjMtAn3xUvU2t3JXo4VuA+nDtVWWDGM5ZOoQf9
         qXNOo1/uT0xAO8nGaIaDPmjtv8iqw2lBrHlJHaGrTnkLjFNDTD8i+ZCL+gRy7sruIgfM
         G8FQ==
X-Gm-Message-State: ACrzQf26LHooZm6UZUsE1V/Wq/kenDo5VwbQI2o2ZqWMPpipLuZBtNBX
        KyKXZAigvlNFVZAfGgRJvpOaSPKnj0zAwDUAOhnv/g==
X-Google-Smtp-Source: AMsMyM6rODoT7c+fw8yqXePJyMu5WIi76pJaB4N2EviiozU/6kVIaUNK3eQQzQtXSnfQVw1x1EHMQZtKhlb0+pGKjIU=
X-Received: by 2002:a05:600c:4e94:b0:3b4:b416:46c3 with SMTP id
 f20-20020a05600c4e9400b003b4b41646c3mr14523851wmq.149.1665441113175; Mon, 10
 Oct 2022 15:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-3-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-3-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 15:31:41 -0700
Message-ID: <CAP-5=fU+Rg+AsgqAFs1bbLHnVOMi2_0cUHdxnohfmAw6ezrz+A@mail.gmail.com>
Subject: Re: [PATCH 02/19] perf tools: Use pmu info in evsel__is_hybrid()
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
> If evsel has pmu, it can use pmu->is_hybrid directly.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/evsel.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 196f8e4859d7..a6ea91c72659 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3132,6 +3132,9 @@ void evsel__zero_per_pkg(struct evsel *evsel)
>
>  bool evsel__is_hybrid(struct evsel *evsel)
>  {
> +       if (evsel->pmu)
> +               return evsel->pmu->is_hybrid;
> +
>         return evsel->pmu_name && perf_pmu__is_hybrid(evsel->pmu_name);

Wow, there's so much duplicated state. Why do evsels have a pmu_name
and a pmu? Why not just pmu->name? I feel always having a pmu would be
cleanest here. That said what does evsel__is_hybrid even mean? Does it
mean this event is on a PMU normally called cpu and called cpu_core
and cpu_atom on hybrid systems? And of course there are no comments to
explain what this little mystery could be. Anyway, that's not a fault
of this change, and probably later changes will go someway toward
cleaning this up. It was a shame the code wasn't cleaner in the first
place.

Acked-by: Ian Rogers

Thanks,
Ian

>  }
>
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
