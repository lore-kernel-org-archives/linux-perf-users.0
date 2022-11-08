Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DBDC4332F
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Nov 2022 23:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiKHXQS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Nov 2022 18:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKHXQR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Nov 2022 18:16:17 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FD3193D7
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Nov 2022 15:16:16 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j15so23293903wrq.3
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Nov 2022 15:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o6bbEVkp/O+6HFBPQrcPCeDrxXI7++0ZLl8zYzUmUHM=;
        b=Ei6BncYhV7jPMWsfnUvXvoN1cQzVOrERH3xmvYSdqOjTjsEKwUA/JKPZqLCiHD9uvh
         mR1/quI0l6SKPQc6aa+ZYv9jM2FUgaNXeN7MnXOOp6HqT7I2dgAqYctcqQQ+DwCG69qo
         e/R70p2aoxRAITBvw3NzrWfn2/Bm/Uhh/0zddIV7oul3dmM9iUrI8XysszGqwPVsaq8i
         Bhf9/5Y4Bra5+07VBR4sb55TTawMazg02qZIp+nBy8PeNwBZsmsOT9gAwU2HYGocl1l3
         KNNdCqRJIHw7mY8poaZYgmh7iN1Xa+Q2/vCZUIn1obYIG6/PL18j614Xv/s5JyFb3UfN
         qpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6bbEVkp/O+6HFBPQrcPCeDrxXI7++0ZLl8zYzUmUHM=;
        b=sJWRFz5OculPGgfkEZSnoxW6EyHQg1UwNLOiH4bfUGMn+/zFsE7VapG44MLzvBZuEU
         z8RMgR9rWQgcIlRVtr4HPKbB/lagbiK2/r116fvo39tDaprobwHWhJai0AHYnJqPMuZv
         0ZeAI2aJvqeYqexQM8EFbz3LrxL98qjPvCvmzCgCoTbovWHcWYnOecbhAsfuJ1vBzsI4
         RqXtBaEJ8+O3Y5Phoi7s8VM5HXcmTLlNU+fRMXzcLtnwVtypKPrS0GUudj4ZKz5zpEkK
         GNsoQ57V+zxBGPnLQozdBqhw8/z/9zwbHgW3pX+gOVbqtDnzfmJ3/KLq6ivjiE+XAigR
         cYTA==
X-Gm-Message-State: ACrzQf1JnsS8ro/1/pULDpHF2rzy/X+nm78g1OOge9fST7dFCnDYa1FJ
        WDtwAXkHtl/uc9qhO8wnZ1Q1pPxAKTChFMzE5t6THg==
X-Google-Smtp-Source: AMsMyM7/dic9/JyfUZsBFtA+TVNm7iuSTlgQA63H+lcm7Cyf1EqEGKz313B+P6eYpjNVycKyB4IaETcGY5BjeXP0We8=
X-Received: by 2002:a5d:47a6:0:b0:236:7854:246d with SMTP id
 6-20020a5d47a6000000b002367854246dmr36320076wrb.300.1667949374614; Tue, 08
 Nov 2022 15:16:14 -0800 (PST)
MIME-Version: 1.0
References: <20221107213314.3239159-1-namhyung@kernel.org> <20221107213314.3239159-4-namhyung@kernel.org>
In-Reply-To: <20221107213314.3239159-4-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 8 Nov 2022 15:16:02 -0800
Message-ID: <CAP-5=fWXAjWd-dbVXCVfRzP9iw5RzXo+cPWWPpOmTw-1xBECqg@mail.gmail.com>
Subject: Re: [PATCH 3/9] perf stat: Clear screen only if output file is a tty
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
> The --interval-clear option makes perf stat to clear the terminal at
> each interval.  But it doesn't need to clear the screen when it saves
> to a file.

Would it be more intuitive to warn if interval-clear is specified with a file?

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 17d656566cd9..d4936a502560 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -892,7 +892,7 @@ static void print_interval(struct perf_stat_config *config,
>         FILE *output = config->output;
>         static int num_print_interval;
>
> -       if (config->interval_clear)
> +       if (config->interval_clear && isatty(fileno(output)))
>                 puts(CONSOLE_CLEAR);
>
>         if (!config->iostat_run && !config->json_output)
> --
> 2.38.1.431.g37b22c650d-goog
>
