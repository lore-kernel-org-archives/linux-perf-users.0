Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E231C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 23:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiKWXXc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 18:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiKWXX3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 18:23:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E3176140
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:23:27 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id x5so27647634wrt.7
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ayoSWu5N40Ra4iTrCvTpa/DS7Q6MrND/wB7uYtW0GPo=;
        b=J0gMFtUusKM7z1WD/Yw/59tPQwk1zT36/ku2ipXNQA/R59mzybS3dXGd0urmn6taAL
         0/LJpF41ppRutaYM5jmDpi/71omBBeK9/MAEc7CIoFkNQYmUWqscyIN1YilCMHZc1oQ8
         lddL+zkMi7Jw3LD/wkl78FzEF4EuLrMUAzId4kxkmozS7e1aC9qbErS3vYvfhK6TMS7R
         3UyAVtk7O6VAbD1sBG9xQLZ4MHHbGHZSW8A9OJFOq606oYmfCoD4pBXxBu7QuK0VTIkw
         NAQhxGW/QmqhQrmd70DjrcKHeehlRD2VEE5vHGPJiFbyCFYhBKgFbet9/vXD6oqgXpgR
         tcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayoSWu5N40Ra4iTrCvTpa/DS7Q6MrND/wB7uYtW0GPo=;
        b=fQZpevuOXj7pQ5SCZuvmAurKHE3B3X7iJuN+JgHta+nHeFq8dZjfhqiijwriFQui9s
         yPz2hEAXUb+0wHzph+bS0Bl+p61/hCQnap4rTrujXVca06ZuiDBL8kHTIc6SfS4zGaA3
         IltXHnPxwlxwPnYgi7pJbg3P0j3/3BKnglb0VyNhd0ufIfmQdaORE0EWdX/rLfgSonzr
         cl8tFaNdsoq88+I4IL186v5Oh5nc7ceaZYxnamCLHg3uRG+/R7YW0LIp9y9V6SdRdpKh
         y40BxcuYV8BPYDIzKM9aayhF44+diiTwARx8Y/hrvW5xEutjEfYVkQcw59SIVGyzRHrU
         w7FQ==
X-Gm-Message-State: ANoB5pm3MWk2CX5pcU1nxlLpqpe2WsHsFGsVbSR0SskeDiHdYWWqpM5+
        DotA/TuiqlO4ghazCTaErxmLU9yLStKlwrDVoQq3LA==
X-Google-Smtp-Source: AA0mqf7k6uq7goVGKLsUrPD80T8Ge76gaD6ZFn9Ptykpw7sVnQb9QOcdAAYIVk513e6BatfwVYJUcjXb++l+fAS9lXw=
X-Received: by 2002:adf:e2c9:0:b0:241:db86:176d with SMTP id
 d9-20020adfe2c9000000b00241db86176dmr8947881wrj.40.1669245806183; Wed, 23 Nov
 2022 15:23:26 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-6-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-6-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:23:13 -0800
Message-ID: <CAP-5=fWZ27QW+XvZx0bzEMmUbyKpmmmZudB9u=SyxiLcH3CCqw@mail.gmail.com>
Subject: Re: [PATCH 05/15] perf stat: Remove prefix argument in print_metric_headers()
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
> It always passes a whitespace to the function, thus we can just add it to the
> function body.  Furthermore, it's only used in the normal output mode.
>
> Well, actually CSV used it but it doesn't need to since we don't care about the
> indentation or alignment in the CSV output.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 744b7a40f59a..deed6ccf072f 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -996,10 +996,9 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>  }
>
>  static void print_metric_headers_std(struct perf_stat_config *config,
> -                                    const char *prefix, bool no_indent)
> +                                    bool no_indent)
>  {
> -       if (prefix)
> -               fprintf(config->output, "%s", prefix);
> +       fputc(' ', config->output);
>
>         if (!no_indent) {
>                 int len = aggr_header_lens[config->aggr_mode];
> @@ -1012,11 +1011,8 @@ static void print_metric_headers_std(struct perf_stat_config *config,
>  }
>
>  static void print_metric_headers_csv(struct perf_stat_config *config,
> -                                    const char *prefix,
>                                      bool no_indent __maybe_unused)
>  {
> -       if (prefix)
> -               fprintf(config->output, "%s", prefix);
>         if (config->interval)
>                 fputs("time,", config->output);
>         if (!config->iostat_run)
> @@ -1024,7 +1020,6 @@ static void print_metric_headers_csv(struct perf_stat_config *config,
>  }
>
>  static void print_metric_headers_json(struct perf_stat_config *config,
> -                                     const char *prefix __maybe_unused,
>                                       bool no_indent __maybe_unused)
>  {
>         if (config->interval)
> @@ -1032,8 +1027,7 @@ static void print_metric_headers_json(struct perf_stat_config *config,
>  }
>
>  static void print_metric_headers(struct perf_stat_config *config,
> -                                struct evlist *evlist,
> -                                const char *prefix, bool no_indent)
> +                                struct evlist *evlist, bool no_indent)
>  {
>         struct evsel *counter;
>         struct outstate os = {
> @@ -1047,11 +1041,11 @@ static void print_metric_headers(struct perf_stat_config *config,
>         };
>
>         if (config->json_output)
> -               print_metric_headers_json(config, prefix, no_indent);
> +               print_metric_headers_json(config, no_indent);
>         else if (config->csv_output)
> -               print_metric_headers_csv(config, prefix, no_indent);
> +               print_metric_headers_csv(config, no_indent);
>         else
> -               print_metric_headers_std(config, prefix, no_indent);
> +               print_metric_headers_std(config, no_indent);
>
>         if (config->iostat_run)
>                 iostat_print_header_prefix(config);
> @@ -1132,7 +1126,7 @@ static void print_header_interval_std(struct perf_stat_config *config,
>         }
>
>         if (config->metric_only)
> -               print_metric_headers(config, evlist, " ", true);
> +               print_metric_headers(config, evlist, true);
>         else
>                 fprintf(output, " %*s %*s events\n",
>                         COUNTS_LEN, "counts", config->unit_width, "unit");
> @@ -1168,7 +1162,7 @@ static void print_header_std(struct perf_stat_config *config,
>         fprintf(output, ":\n\n");
>
>         if (config->metric_only)
> -               print_metric_headers(config, evlist, " ", false);
> +               print_metric_headers(config, evlist, false);
>  }
>
>  static void print_header_csv(struct perf_stat_config *config,
> @@ -1178,7 +1172,7 @@ static void print_header_csv(struct perf_stat_config *config,
>                              const char **argv __maybe_unused)
>  {
>         if (config->metric_only)
> -               print_metric_headers(config, evlist, " ", true);
> +               print_metric_headers(config, evlist, true);
>  }
>  static void print_header_json(struct perf_stat_config *config,
>                               struct target *_target __maybe_unused,
> @@ -1187,7 +1181,7 @@ static void print_header_json(struct perf_stat_config *config,
>                               const char **argv __maybe_unused)
>  {
>         if (config->metric_only)
> -               print_metric_headers(config, evlist, " ", true);
> +               print_metric_headers(config, evlist, true);
>  }
>
>  static void print_header(struct perf_stat_config *config,
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
