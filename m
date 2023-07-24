Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75095EB64DD
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Jul 2023 21:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjGXVJd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Jul 2023 17:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGXVJc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Jul 2023 17:09:32 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAA810E3
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jul 2023 14:09:31 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-63cf6b21035so13849526d6.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jul 2023 14:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690232970; x=1690837770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4R7OXxyA6++6H908qvwT/4xVlAoInx/mRJrgLvZp3I=;
        b=7VPLC3FM4ARsMPpxFByktScwoRDHY1+O3k6ji1oMHXcyc6BWzJO2kc65fqEz/njpKS
         1e7OlV2JEjMDqg5/b/8JhzaVftGznHjCljWM27BrP56UMgo4L8DdTIELZGyd7UD9rWPk
         qQbnqI5NpI7yY40RMK0+86Sbiiv6BJBD6PmxYo61TZv00unQD3dW63wIjlZ4uU5YLag4
         6T0PNkCCqQKY3fRRiocbDQLEC+UAeiYQ8kf5hL3Z5wM+rOMs1zhoGu6GcqpFEj1KU9Dh
         YSpeA+8GtomB9U/LAI/r00dP87tOUdSYkkqZmSXVpqurgoIAKEF3A5KjksJiib/fhSTg
         muAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690232970; x=1690837770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4R7OXxyA6++6H908qvwT/4xVlAoInx/mRJrgLvZp3I=;
        b=OOpbSGuBmVLvWP6Gee8Z0c/Vl6RQ2Xt36LeZJyvL68p8pqc+If4bxUTnfvUBuA+cdc
         yYG86+yB1JQ6WzymSFW6SASdlylcDiqeLIyRMTqlI/GiiAhUhaBnXpUUNH5dDciVj0Mj
         jip2Jkjst3ei8sX9az44/X3sNFpLoX/1EZGJQQ0SPnL0YzIZTKKD5NKgTy3r7tP/wOn4
         uP2gZdDpSN6OddgyWkpds1m4pXIs6Rd7go9MrJCMDxQqc/BwSaNGkWEukFPCdENHNq7R
         7BAX9om+N6fDiq526pskd2HMyFeFBtuduShwltHe6YqwqfKqzxxpnpJvkIb0qnkbnbp9
         UIEg==
X-Gm-Message-State: ABy/qLZMjR+Y+TEVD1uFf4CmXD3lj8No+x7RyzMJejIosRl+yxrOO+AM
        kS41GvngcFoWab/OerrtKC4oNbbrA4oYVQkZeWdN0Q==
X-Google-Smtp-Source: APBJJlEVIiJyEgN+QVsm2PLjyvD1Ou20SgK8rwynWuqyeHMek9W1M6VLm3dl9IiVVE8IhJUcTcukic+uVZi3kHIPE+c=
X-Received: by 2002:a05:6214:11b0:b0:63c:fac8:ec0b with SMTP id
 u16-20020a05621411b000b0063cfac8ec0bmr786313qvv.39.1690232970451; Mon, 24 Jul
 2023 14:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230724201247.748146-1-irogers@google.com> <20230724201247.748146-2-irogers@google.com>
In-Reply-To: <20230724201247.748146-2-irogers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jul 2023 14:09:19 -0700
Message-ID: <CAKwvOdnNgd9QgvrR5H2rL8eb1Qc--ELCcOie8Bv=xTFqg9Zh-A@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] perf stat: Avoid uninitialized use of perf_stat_config
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev, maskray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 24, 2023 at 1:12=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> perf_event__read_stat_config will assign values based on number of
> tags and tag values. Initialize the structs to zero before they are
> assigned so that no uninitialized values can be seen.
>
> This potential error was reported by GCC with LTO enabled.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/stat.c | 2 +-
>  tools/perf/util/stat.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/stat.c b/tools/perf/tests/stat.c
> index 500974040fe3..706780fb5695 100644
> --- a/tools/perf/tests/stat.c
> +++ b/tools/perf/tests/stat.c
> @@ -27,7 +27,7 @@ static int process_stat_config_event(struct perf_tool *=
tool __maybe_unused,
>                                      struct machine *machine __maybe_unus=
ed)
>  {
>         struct perf_record_stat_config *config =3D &event->stat_config;
> -       struct perf_stat_config stat_config;
> +       struct perf_stat_config stat_config =3D {};

^ how did this code ever work?

1. stat_config is not initialized
2. perf_event__read_stat_config maybe assigns to &stat_config->__val
3. process_stat_config_event() tests other members of stat_config

I hope I've missed something obvious.


Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>  #define HAS(term, val) \
>         has_term(config, PERF_STAT_CONFIG_TERM__##term, val)
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 967e583392c7..ec3506042217 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -729,7 +729,7 @@ size_t perf_event__fprintf_stat_round(union perf_even=
t *event, FILE *fp)
>
>  size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp=
)
>  {
> -       struct perf_stat_config sc;
> +       struct perf_stat_config sc =3D {};
>         size_t ret;
>
>         perf_event__read_stat_config(&sc, &event->stat_config);
> --
> 2.41.0.487.g6d72f3e995-goog
>


--=20
Thanks,
~Nick Desaulniers
