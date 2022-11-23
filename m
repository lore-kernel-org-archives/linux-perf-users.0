Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978ACC4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 23:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiKWX2z (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 18:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiKWX2z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 18:28:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A8B31233
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:28:53 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g12so31688288wrs.10
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+l58gdChKgvcBGON5Y54TC6AAVv1kkRbATt9uISWhoo=;
        b=iV/MtPx8WNZf6EbGh1qyv3ssa2mn45ifdGdppmViiqQ1bND3kjZJJ6A5ekgaJzuf1W
         gh9+ml+LI9ZllyRuwsTdLOY+yT8nhQpwM5QbMuu0jz98nUDXJzjwsU0hwj2O22styM5w
         QAQ70ppJQt/A/RvW8VxxE5zRDa3xkVd6Niqn3MSCP8xueFAXvpFMwiUgGlJLFGnvFtrF
         APw3DU2PBGOPs4w1MYb8gaSLJkYq9I1YX959m9YooiG6skdJRZ4fXIiItqxYT3ND7jr+
         sc0su10hqPDRjr7sZJ95SJ42OX/pb/5ku4BOt2HrvucTzGv6Uu9tZurjLLIXh2G8PLR4
         jdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+l58gdChKgvcBGON5Y54TC6AAVv1kkRbATt9uISWhoo=;
        b=V7BGo/8+FysgQzyB3eE+fMEPdrifsl9iRrjJx6ZalfJKT5DCa0g7NAoKPZ7E2YuEgN
         OIAk+4N5//6135A1l5XOsbziWH4xUaey7fCNv6QmCahpQI6rJsUaslwyKtDD2qW+bNIf
         URK5yj1ogLZDpF7u+ApfejeVSmFGqPU7e+EqRQgwTpCtfNA1Ux3VpAXhFBXfj8pdzlyl
         frT7v3f9atApnszFIML1DkgJvkhFHpP3H4p5C6P19G8hAHTFfgcqFfyZnL1NaKAqCBqC
         SSrrPh4rqlESk3lOeVh5xzXX19RFbrXpUnpaoo61GuL3176X4X+iKBfd7tSctDB6t0wG
         X08A==
X-Gm-Message-State: ANoB5pnSfIL5iCDVfd9xU0rhvlgimhbWS899nCdBQxx/ll4/KXe65dny
        z1fGyYZ1P1u9AYEuIr4ezzxqKYgf1qH9fM4xATr7Zw==
X-Google-Smtp-Source: AA0mqf6EZsbL7InmxdiJmdaB62h1cAsPcdFfpbLEzouO228x/X9MNjYLuIDkD3lm9zXTjbB+NqJBwW4DxUfpwtDo5rU=
X-Received: by 2002:adf:f944:0:b0:236:8f54:f1f4 with SMTP id
 q4-20020adff944000000b002368f54f1f4mr18774246wrr.654.1669246132041; Wed, 23
 Nov 2022 15:28:52 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-14-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-14-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:28:39 -0800
Message-ID: <CAP-5=fU3Ruy75wRnjzN-GefLnAK8Vg6OEueUbgo2jxfSTe41jA@mail.gmail.com>
Subject: Re: [PATCH 13/15] perf stat: Fix JSON output in metric-only mode
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
> It generated a broken JSON output when aggregation mode or cgroup is
> used with --metric-only option.  Also get rid of the header line and
> make the output single line for each entry.
>
> It needs to know whether the current metric is the first one or not.
> So add 'first' field in the outstate and mark it false after printing.
>
> Before:
>   # perf stat -a -j --metric-only true
>   {"unit" : "GHz"}{"unit" : "insn per cycle"}{"unit" : "branch-misses of all branches"}
>   {{"metric-value" : "0.797"}{"metric-value" : "1.65"}{"metric-value" : "0.89"}
>    ^
>
>   # perf stat -a -j --metric-only --per-socket true
>   {"unit" : "GHz"}{"unit" : "insn per cycle"}{"unit" : "branch-misses of all branches"}
>   {"socket" : "S0", "aggregate-number" : 8, {"metric-value" : "0.295"}{"metric-value" : "1.88"}{"metric-value" : "0.64"}
>                                            ^
>
> After:
>   # perf stat -a -j --metric-only true
>   {"GHz" : "0.990", "insn per cycle" : "2.06", "branch-misses of all branches" : "0.59"}
>
>   # perf stat -a -j --metric-only --per-socket true
>   {"socket" : "S0", "aggregate-number" : 8, "GHz" : "0.439", "insn per cycle" : "2.14", "branch-misses of all branches" : "0.51"}
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 42 +++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 335627e8542d..43640115454c 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -279,9 +279,6 @@ static void print_aggr_id_json(struct perf_stat_config *config,
>  {
>         FILE *output = config->output;
>
> -       if (!config->interval)
> -               fputc('{', output);
> -
>         switch (config->aggr_mode) {
>         case AGGR_CORE:
>                 fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-number\" : %d, ",
> @@ -335,6 +332,7 @@ static void aggr_printout(struct perf_stat_config *config,
>  struct outstate {
>         FILE *fh;
>         bool newline;
> +       bool first;
>         const char *prefix;
>         int  nfields;
>         int  nr;
> @@ -491,6 +489,7 @@ static void print_metric_only(struct perf_stat_config *config,
>
>         color_snprintf(str, sizeof(str), color ?: "", fmt, val);
>         fprintf(out, "%*s ", mlen, str);
> +       os->first = false;
>  }
>
>  static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused,
> @@ -512,6 +511,7 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
>                 ends++;
>         *ends = 0;
>         fprintf(out, "%s%s", vals, config->csv_sep);
> +       os->first = false;
>  }
>
>  static void print_metric_only_json(struct perf_stat_config *config __maybe_unused,
> @@ -532,7 +532,8 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
>         while (isdigit(*ends) || *ends == '.')
>                 ends++;
>         *ends = 0;
> -       fprintf(out, "{\"metric-value\" : \"%s\"}", vals);
> +       fprintf(out, "%s\"%s\" : \"%s\"", os->first ? "" : ", ", unit, vals);
> +       os->first = false;
>  }
>
>  static void new_line_metric(struct perf_stat_config *config __maybe_unused,
> @@ -561,7 +562,7 @@ static void print_metric_header(struct perf_stat_config *config,
>         unit = fixunit(tbuf, os->evsel, unit);
>
>         if (config->json_output)
> -               fprintf(os->fh, "{\"unit\" : \"%s\"}", unit);
> +               return;
>         else if (config->csv_output)
>                 fprintf(os->fh, "%s%s", unit, config->csv_sep);
>         else
> @@ -821,6 +822,8 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>         run = aggr->counts.run;
>
>         if (!metric_only) {
> +               if (config->json_output)
> +                       fputc('{', output);
>                 if (os->prefix)
>                         fprintf(output, "%s", os->prefix);
>                 else if (config->summary && config->csv_output &&
> @@ -844,9 +847,12 @@ static void print_metric_begin(struct perf_stat_config *config,
>         struct aggr_cpu_id id;
>         struct evsel *evsel;
>
> +       os->first = true;
>         if (!config->metric_only)
>                 return;
>
> +       if (config->json_output)
> +               fputc('{', config->output);
>         if (os->prefix)
>                 fprintf(config->output, "%s", os->prefix);
>
> @@ -855,7 +861,7 @@ static void print_metric_begin(struct perf_stat_config *config,
>         aggr = &evsel->stats->aggr[aggr_idx];
>         aggr_printout(config, evsel, id, aggr->nr);
>
> -       print_cgroup(config, os->cgrp);
> +       print_cgroup(config, os->cgrp ? : evsel->cgrp);
>  }
>
>  static void print_metric_end(struct perf_stat_config *config)
> @@ -863,6 +869,8 @@ static void print_metric_end(struct perf_stat_config *config)
>         if (!config->metric_only)
>                 return;
>
> +       if (config->json_output)
> +               fputc('}', config->output);
>         fputc('\n', config->output);
>  }
>
> @@ -1005,11 +1013,9 @@ static void print_metric_headers_csv(struct perf_stat_config *config,
>                 fputs(aggr_header_csv[config->aggr_mode], config->output);
>  }
>
> -static void print_metric_headers_json(struct perf_stat_config *config,
> +static void print_metric_headers_json(struct perf_stat_config *config __maybe_unused,
>                                       bool no_indent __maybe_unused)
>  {
> -       if (config->interval)
> -               fputs("{\"unit\" : \"sec\"}", config->output);
>  }
>
>  static void print_metric_headers(struct perf_stat_config *config,
> @@ -1049,7 +1055,9 @@ static void print_metric_headers(struct perf_stat_config *config,
>                                               &config->metric_events,
>                                               &rt_stat);
>         }
> -       fputc('\n', config->output);
> +
> +       if (!config->json_output)
> +               fputc('\n', config->output);
>  }
>
>  static void prepare_interval(struct perf_stat_config *config,
> @@ -1058,17 +1066,14 @@ static void prepare_interval(struct perf_stat_config *config,
>         if (config->iostat_run)
>                 return;
>
> -       if (config->csv_output)
> +       if (config->json_output)
> +               scnprintf(prefix, len, "\"interval\" : %lu.%09lu, ",
> +                         (unsigned long) ts->tv_sec, ts->tv_nsec);
> +       else if (config->csv_output)
>                 scnprintf(prefix, len, "%lu.%09lu%s",
>                           (unsigned long) ts->tv_sec, ts->tv_nsec, config->csv_sep);
> -       else if (!config->json_output)
> -               scnprintf(prefix, len, "%6lu.%09lu ",
> -                         (unsigned long) ts->tv_sec, ts->tv_nsec);
> -       else if (!config->metric_only)
> -               scnprintf(prefix, len, "{\"interval\" : %lu.%09lu, ",
> -                         (unsigned long) ts->tv_sec, ts->tv_nsec);
>         else
> -               scnprintf(prefix, len, "{\"interval\" : %lu.%09lu}",
> +               scnprintf(prefix, len, "%6lu.%09lu ",
>                           (unsigned long) ts->tv_sec, ts->tv_nsec);
>  }
>
> @@ -1365,6 +1370,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>         char buf[64];
>         struct outstate os = {
>                 .fh = config->output,
> +               .first = true,
>         };
>
>         if (config->iostat_run)
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
