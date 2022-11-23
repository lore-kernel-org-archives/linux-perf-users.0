Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49978C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 23:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKWXVQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 18:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiKWXVO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 18:21:14 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B6B116049
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:21:13 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bs21so31712349wrb.4
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4Lpbo0ikHKpltFsht0DtcDgZMUjM7tbdFF7frE7VZ4=;
        b=ClS7bcl4Ygn7/Kp0RbQZXxNryLtPAxkUI6455F67yu8/2OUUGWxL5zcLhkW/AxoRaS
         KBoo6cktP8EaRvcGH8md37ZLN5+jUj/qnZiq+69uDPEIyPP3SkQCIGeU1yoGdnqNkISd
         /nEXsHFlF1cdjIqr0Oqwt6WRwqxwE8Oh1IgjPwSLbUCNF8APu1hXT23OHZOdoSJbAlQM
         Lwu4N+q5tdoXCFpqi2rkSsY6xJ+yJS44WOqxpwOUJHRJ/SiY43GTSTMn0/jAt8vCQaWw
         j8bPbQkSpEiIAarRmHyYO7WeTCQzby71TkjsR7RyHwH6NRYkMyF5oCdZFTDuslIDeRag
         Ex0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4Lpbo0ikHKpltFsht0DtcDgZMUjM7tbdFF7frE7VZ4=;
        b=JiZ4OceAv0RxskM8Ndx+gkFXnFI6R8gwUIsT2rdgLXIDTJhRy2xeGHPo0GvC2UuNHW
         Yix7NuGg7nsehZln/snHbxipoR1NWDzH1gJYO+zUICJTinjctg3ZFvxRgjNlyW6mXiOR
         0H90Q+hXY9JEOZbnjyqVlXdwHD6t5et/dM0m/hIB/5gQutye8jSNaRleZKeNVamxJA/R
         N06y0pSuBsWmT6cOZ7MMQgTKnhpkqLeRyDKytnvlB9zeSKMlon4v1+Kiecmz/TQA2rKV
         jJt8FUwhV1N+3AjmsHoAFtdmf8W2dJ5HCyhF7OSC3GF/2+PvUdynIJaTd8emEC5InN8z
         FYpw==
X-Gm-Message-State: ANoB5pmw6hh9EaUXWo2svD9dwBvU6ZZKgRHIvZkdkptsyqu/AsgLXN6D
        xyhpKLVLMa6t63focrzk4p7jNAcVdh9NVSY8+X2Opg==
X-Google-Smtp-Source: AA0mqf5TbUvQVK7TILljNexm3NaXD/Upw1Es+Icf9IhqfTQrEsGQbeb4ts4wYloWgJSHp0FEz63UnzefeBBTh1MWkqY=
X-Received: by 2002:adf:e64f:0:b0:241:e2f1:8b44 with SMTP id
 b15-20020adfe64f000000b00241e2f18b44mr6031283wrn.300.1669245671965; Wed, 23
 Nov 2022 15:21:11 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-3-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-3-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:20:59 -0800
Message-ID: <CAP-5=fUZZkMyb=LAkz8dG79xZWeC+RjQoKGtXDoLmrHyruTg1w@mail.gmail.com>
Subject: Re: [PATCH 02/15] perf stat: Move summary prefix printing logic in
 CSV output
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
> It matches to the prefix (interval timestamp), so better to have them together.
> No functional change intended.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 46e90f0bb423..d86f2f8e020d 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -713,11 +713,6 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>                 nl = config->metric_only ? new_line_metric : new_line_std;
>         }
>
> -       if (!config->no_csv_summary && config->csv_output &&
> -           config->summary && !config->interval && !config->metric_only) {
> -               fprintf(config->output, "%16s%s", "summary", config->csv_sep);
> -       }
> -
>         if (run == 0 || ena == 0 || counter->counts->scaled == -1) {
>                 if (config->metric_only) {
>                         pm(config, &os, NULL, "", "", 0);
> @@ -828,8 +823,13 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>         ena = aggr->counts.ena;
>         run = aggr->counts.run;
>
> -       if (prefix && !metric_only)
> -               fprintf(output, "%s", prefix);
> +       if (!metric_only) {
> +               if (prefix)
> +                       fprintf(output, "%s", prefix);
> +               else if (config->summary && config->csv_output &&
> +                        !config->no_csv_summary && !config->interval)
> +                       fprintf(output, "%16s%s", "summary", config->csv_sep);
> +       }
>
>         uval = val * counter->scale;
>
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
