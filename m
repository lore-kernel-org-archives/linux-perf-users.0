Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686EFC4332F
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Nov 2022 23:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiKHXXP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Nov 2022 18:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiKHXXA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Nov 2022 18:23:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9E84C243
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Nov 2022 15:22:53 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l14so23340854wrw.2
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Nov 2022 15:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vcavttwH0q3M9PraafemTP01iTUHxHGotv46eg3YbBs=;
        b=rxPbT0U5+f/HhF5uwizaUfRbdFygOsBf7nhQiLgvAV6cOj1b7nnFFZAUyfXKfDuenf
         heZI60ZEINlWgvsmECMf1D6Ov6qqVXt5xaQS9AY9d76xf4lpLfo31nC97tsKkup6+PA3
         ZSZFinu/h2+DeVvpmJBlrAy1hmIvct9YLFk0GCtOtnqZF2sPMLpf6C6pxvosgIE+PC68
         Leznntw061i/+IHhbBMOMXUTtOgG+Olv1WLxAhR+hgO7+Z+vLMt1dT0xa+42ptEJaaoi
         TObTFSsPwxXSrXT+wMmfRucP5CdWNqSYLKK0tRUl55K0p8hIhH2wWRxeoPlHpzHimyeC
         uaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcavttwH0q3M9PraafemTP01iTUHxHGotv46eg3YbBs=;
        b=yvXlDHHsDdEdT2+jBxDgWdF3FNIn+xwyZaTwTZMHIBCBkvwOEfIyqrcfxjppbRsiGn
         0LKHhnh/8jhvwM1T25bdilP1g9Hy/VaZtkzKxCfIdbF/8WfOElRfl+AC7V45uRUGPmV4
         hi8TsbU1ffEtqWsXboqfZlUu/dgbZ735KGtDqoKHqXFT9evNVGcd5Ti9cDpApSn+e8vF
         YtzH2kcswust94bU6r52AVnKps1wQ29jWHbnIVBp41PUieLgCe3DXTiSJtJhzFCKPZ+h
         PNqMSDP0JH3SvoGDKDh0zdGJR0GnNXIAj6gFTH/OKnX1Y6dpHMFlS5Y2mppgA/sXeeNn
         yDPQ==
X-Gm-Message-State: ACrzQf2yj3xZmV0LMZ9ZS6RbyvjO7J2yvt+SyvIixe9zjpTGZbbqQEbd
        QrW5jE263PbNr3GnZC1XPqMj3sks24PXTNEMguhV/A==
X-Google-Smtp-Source: AMsMyM5y2i4ewEOMisgv/IT0ccWDvptArlraGJCg4PGzsgAfhXW+PMTycbgC0Fd9TLCJhykdEfACkB8+AdLs9SKnO1Q=
X-Received: by 2002:adf:db92:0:b0:236:9d4a:476f with SMTP id
 u18-20020adfdb92000000b002369d4a476fmr37191905wri.654.1667949772244; Tue, 08
 Nov 2022 15:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20221107213314.3239159-1-namhyung@kernel.org> <20221107213314.3239159-8-namhyung@kernel.org>
In-Reply-To: <20221107213314.3239159-8-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 8 Nov 2022 15:22:32 -0800
Message-ID: <CAP-5=fVyRrU_oFU_r3jsoY2MK=zMKLKvgLvhG+v8SjtSQmmoeg@mail.gmail.com>
Subject: Re: [PATCH 7/9] perf stat: Add header for interval in JSON output
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 7, 2022 at 1:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> It missed to print a matching header line for intervals.
>
> Before:
>   # perf stat -a -e cycles,instructions --metric-only -j -I 500
>   {"unit" : "insn per cycle"}
>   {"interval" : 0.500544283}{"metric-value" : "1.96"}
>   ^C
>
> After:
>   # perf stat -a -e cycles,instructions --metric-only -j -I 500
>   {"unit" : "sec"}{"unit" : "insn per cycle"}
>   {"interval" : 0.500515681}{"metric-value" : "2.31"}
>   ^C
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 25f67fb37f6d..aab2576bd40f 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -860,6 +860,10 @@ static void print_metric_headers(struct perf_stat_config *config,
>                 if (!config->iostat_run)
>                         fputs(aggr_header_csv[config->aggr_mode], config->output);
>         }
> +       if (config->json_output) {
> +               if (config->interval)
> +                       fputs("{\"unit\" : \"sec\"}", config->output);
> +       }
>         if (config->iostat_run)
>                 iostat_print_header_prefix(config);
>
> --
> 2.38.1.431.g37b22c650d-goog
>
