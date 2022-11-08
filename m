Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A2AC4332F
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Nov 2022 23:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKHXU5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Nov 2022 18:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKHXU4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Nov 2022 18:20:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1393D22B22
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Nov 2022 15:20:55 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h9so23357934wrt.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Nov 2022 15:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kUnYOUwlAhTiIxun+3EmlrJD7Z1kFHI5Kib+dD6aRMQ=;
        b=B5kllI0DUR7e0rjuPoqVmMaizNRfiRBDmVsTyupE1yfyV8XkUnrR5WZaeBhmIZbApv
         CUnIqkT1PswOUdS50DXst9OnZKyaTmOVoovd+3u4mGQPLWnTJaHUwk8VLc/bcOqmtMZD
         GNP5n/N512fciJyCL4mNhE169fKS7eYiKKU3D9nJOJAx8B1yztbs5kFn3EsKZn+cUhL2
         F133q5qkj9wiQEQuaHDrGqzk8pPqfaM1jIbbF761FPp+eAbWmr7xh+GKL87AVtXqJazy
         E9Qkn+XRmGSU/wchy1wU9EFXn23qVVv8mUsc416TiSAyPzWSs4g6ShCzA1Ugl3Bq2L3i
         k6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUnYOUwlAhTiIxun+3EmlrJD7Z1kFHI5Kib+dD6aRMQ=;
        b=UptesLawfBamqY1KklpHMRR1UeTtVlvvm2un6YnbPqNfuTrN4xkatxq1VP5mK8K++R
         jTCRR6+6sJesTlB5u5GDgmFODNCXgKvdufr2KbX42bwqLApwFgezJN/lOpaEMAQtH7k8
         NJ4HmrX/G1ndz++MVCpU3eA5SmfmmCw8oXDsgxpVSKWi6euEBURu+odmixHGnzVa0PoH
         78DTbxEZdkZLMDN7OTr1kRsG6LH/yKdxnrDQKzfVYYLueMn/xaL/nojuc2dPMIYPtocO
         TpvKlgb7j80IYqv61pNWTVe7IguxyXRhQm+vcVIB8laRrTcuvN+fWU/TuG0Nr1H+iKOn
         3qCA==
X-Gm-Message-State: ACrzQf1CCLR64n33c+cZGXLXy4Fk4LglzVKoDvpme4/rXT1i9sxybRIg
        ZkJgTpHiNP6Au8Ahwuz1S0FkbVW90vdorBtEvCsScAwYVSgN4A==
X-Google-Smtp-Source: AMsMyM4lQGiaprqHiWECzyXIIKuncPhQ5UXFOjXQo9uzf3X6QkA3C4OiBmyEowYEdcOAVRt1A0bJC5qQtDAlQwpy4wI=
X-Received: by 2002:adf:e711:0:b0:236:2f7f:4f08 with SMTP id
 c17-20020adfe711000000b002362f7f4f08mr37589267wrm.375.1667949653475; Tue, 08
 Nov 2022 15:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20221107213314.3239159-1-namhyung@kernel.org> <20221107213314.3239159-7-namhyung@kernel.org>
In-Reply-To: <20221107213314.3239159-7-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 8 Nov 2022 15:20:41 -0800
Message-ID: <CAP-5=fXSROZwwgGGHGjYwC3QkzX9_CBXrV7Ye5y8+2mK16jJmQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] perf stat: Do not indent headers for JSON
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
> Currently --metric-only with --json indents header lines.  This is not
> needed for JSON.
>
>   $ perf stat -aA --metric-only -j true
>         {"unit" : "GHz"}{"unit" : "insn per cycle"}{"unit" : "branch-misses of all branches"}
>   {"cpu" : "0", {"metric-value" : "0.101"}{"metric-value" : "0.86"}{"metric-value" : "1.91"}
>   {"cpu" : "1", {"metric-value" : "0.102"}{"metric-value" : "0.87"}{"metric-value" : "2.02"}
>   {"cpu" : "2", {"metric-value" : "0.085"}{"metric-value" : "1.02"}{"metric-value" : "1.69"}
>   ...
>
> Note that the other lines are broken JSON, but it will be handled later.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 515fb6db3d67..25f67fb37f6d 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -851,7 +851,7 @@ static void print_metric_headers(struct perf_stat_config *config,
>         if (prefix && !config->json_output)
>                 fprintf(config->output, "%s", prefix);
>
> -       if (!config->csv_output && !no_indent)
> +       if (!config->csv_output && !config->json_output && !no_indent)
>                 fprintf(config->output, "%*s",
>                         aggr_header_lens[config->aggr_mode], "");
>         if (config->csv_output) {
> --
> 2.38.1.431.g37b22c650d-goog
>
