Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364DDC433FE
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Nov 2022 23:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiKHXZB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Nov 2022 18:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiKHXYm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Nov 2022 18:24:42 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292575EFB0
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Nov 2022 15:23:47 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p16so9747038wmc.3
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Nov 2022 15:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iYzYIHx1Op6tzMYXV1iOaDxLub/Ky2q3uqnqfSLOYNQ=;
        b=ZkHCkbkWnyL6p+AGwP+Z56AIV1BIFP0S7wVkLSIv6XwezdkX6vnGaTrhPXr1yqLkRj
         0pED4Kn3zKtghU1jCryiITatYJ/rE2SowM6M8BPJwiqi0FJb3qXBcNtgBiXsOLTlqtW6
         t2ONRwPwMems+fqLoLgAikay1XZdfKI6fJq3czM0aXDHbPdB/KihMCmsEHOl9/s4D4a5
         lB0mh/uZeTcc46ArxsZZO7/7hyKr0KyPC7LT8PJJFFH1rxhHtVb6y51rRqSedNXqQGmN
         2Jx/BmV3DK0BxlRXfATZ0y3+h2slZZQGpHSn1QWGMgFszL25UsQlIibPsIfs58ROuXIZ
         AkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYzYIHx1Op6tzMYXV1iOaDxLub/Ky2q3uqnqfSLOYNQ=;
        b=smPuthzwITTFNasxcNMfnX4Al4V9i5irJSRGEOF8b9iT/zly4GnXZhDP1klwAEtx7Q
         XU2HFqgSYi13uyT5p8bxwWyyhfMwEensln3RhTkch4qaKiybU5Akch7aNJhmNQXWG0tx
         oxTfILCXqnKPLvZAX8Cic1t6ErMPogJP/jtpH/X/6/89tMTj2/ivDqOIckNFumr43s8n
         l6upzNmxRUJuC50mWG/jCNI2/w7/MHWKH5EQpJB0k8JaNmXvZa0HlYf400t43imAI7qg
         +9nUiu7K4uQOdZQnC9At8sPtjK4dzBsRvoYgUq00I6qkZfq0uz95mbb6lzyr59ibrZF3
         j6ZQ==
X-Gm-Message-State: ANoB5pk+CNkUK4w4M48JGFWOHG92pIoWgt+BFYL5njVm+uvf3bkoL09+
        4DVwQtZ3uJrHG+iGVBD7st4cAmn/OYTZWxFYxwkBQg==
X-Google-Smtp-Source: AA0mqf4egsVftnJH6GjOe3fMxvtPPnq+8LeaHikbJMGonz6uaHDuvXImRXfoNTogl+49/1QhyGUaInQOE74bsYVM44k=
X-Received: by 2002:a05:600c:3ba1:b0:3cf:a511:320c with SMTP id
 n33-20020a05600c3ba100b003cfa511320cmr11282515wms.182.1667949826008; Tue, 08
 Nov 2022 15:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20221107213314.3239159-1-namhyung@kernel.org> <20221107213314.3239159-10-namhyung@kernel.org>
In-Reply-To: <20221107213314.3239159-10-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 8 Nov 2022 15:23:34 -0800
Message-ID: <CAP-5=fU+Xeqt6sn5ESkNnCHQNTYjbrv-qiZBpbtMRu3ayGL7pA@mail.gmail.com>
Subject: Re: [PATCH 9/9] perf stat: Consolidate condition to print metrics
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
> The pm variable holds an appropriate function to print metrics for CSV
> anf JSON already.  So we can combine the if statement to simplify the
> code a little bit.  This also matches to the above condition for non-CSV
> and non-JSON case.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index a10af26c26ab..4d3999673dde 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -600,9 +600,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>                         pm(config, &os, NULL, NULL, "", 0);
>                 print_noise(config, counter, noise);
>                 print_running(config, run, ena);
> -               if (config->csv_output)
> -                       pm(config, &os, NULL, NULL, "", 0);
> -               else if (config->json_output)
> +               if (config->csv_output || config->json_output)
>                         pm(config, &os, NULL, NULL, "", 0);
>                 return;
>         }
> --
> 2.38.1.431.g37b22c650d-goog
>
