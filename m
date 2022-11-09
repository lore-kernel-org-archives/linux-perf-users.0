Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C62C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Nov 2022 01:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKIB06 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Nov 2022 20:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKIB05 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Nov 2022 20:26:57 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15476034D
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Nov 2022 17:26:55 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j15so23614018wrq.3
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Nov 2022 17:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7n+Gogs44J3MJAJFkEwmyw3zIckfNB0Js5JwY2k9IMU=;
        b=Le+s4FRc9ouIMB0kqkuqrKi4XeMgA8YMCXURQLU5VFsV7hy6fVBAjHQfq5HZ0EPYVq
         wpMilK1lDWQvTqHWZdCZfPaYbJAqWAp9siesyO7BjXXFa+1SZMDEcEf/EDrAY5Y3xgjm
         N6nvh/EVn3TJw//wiJTj0/x85UAeByx+ayY4VauJLwVURWlxb/9Ztj3GCLctIFeOZ/+T
         jNnzamm4YEiZJxiUshD8DhYhnpFFX+oSu1yxSDcuO4i0N/kVMR1420RtfddRKvJZ1r2C
         /pw4CNRHLFJi3bZoGnTaEs6xtL5H+9WpBWUIp7jTNFjuMdDySYEkY16Hc8f8/SKjT2Tm
         T9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7n+Gogs44J3MJAJFkEwmyw3zIckfNB0Js5JwY2k9IMU=;
        b=Rt+K76qLCk7FlEAWTiq0GLJZHIWA+0U8NE9DGidb1807AQ7/GPJTz9ETzW+dWH9C2L
         0CUUFkaDOc5IeaiEbAwV03fKoRFLJL2y+z9ons2RYjZQ4LDqVXAoAmpZSvv7b7Z3u60g
         o9ftegjZ51mLX5w+09uWg9qkSS/tk076dBM0GMHxZWJK/wq1PiAo2R/Ts8z1EssAlHPG
         JGiPYxs1vpR2n2NlaDJWfz/YzERqebfpjLN+nq35yCaTezqYWvpU6R/sW2C2Z8zwd7vg
         KM/RZHs/7bDveKqWJd8Nr3xYezgu1VAWYQ+Xy4NZPPrDuA82cjhEbAReIoCjzPlHdBjt
         LGFA==
X-Gm-Message-State: ACrzQf1yPgrRFCbPaWdC/4tda9H0WFeuvbZbs7E19iES5K29WRIhNuI6
        8M2mGoy4gfK2iC4NAKvf5EmpiJOotd0pKInUrESgag==
X-Google-Smtp-Source: AMsMyM4/riFfccIbi5E00FSgoiJMy1SJ2ltr1Pxqlx3R8Ubo5hkaajkI673foBf+8LVYZG9zQJTYkvJ9JIkUn7KYYhQ=
X-Received: by 2002:adf:e711:0:b0:236:2f7f:4f08 with SMTP id
 c17-20020adfe711000000b002362f7f4f08mr37777536wrm.375.1667957214030; Tue, 08
 Nov 2022 17:26:54 -0800 (PST)
MIME-Version: 1.0
References: <20221107213314.3239159-1-namhyung@kernel.org> <20221107213314.3239159-6-namhyung@kernel.org>
In-Reply-To: <20221107213314.3239159-6-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 8 Nov 2022 17:26:41 -0800
Message-ID: <CAP-5=fUjOMDQoKbo3a2nLY06u7udTjY_chJm_BvQtMUZEPXmzA@mail.gmail.com>
Subject: Re: [PATCH 5/9] perf stat: Fix --metric-only --json output
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
> Currently it prints all metric headers for JSON output.  But actually it
> skips some metrics with valid_only_metric().  So the output looks like:
>
>   $ perf stat --metric-only --json true
>   {"unit" : "CPUs utilized", "unit" : "/sec", "unit" : "/sec", "unit" : "/sec", "unit" : "GHz", "unit" : "insn per cycle", "unit" : "/sec", "unit" : "branch-misses of all branches"}
>   {"metric-value" : "3.861"}{"metric-value" : "0.79"}{"metric-value" : "3.04"}
>
> As you can see there are 8 units in the header but only 3 metric-values
> are there.  It should skip the unused headers as well.  Also each unit
> should be printed as a separate object like metric values.
>
> With this patch:
>
>   $ perf stat --metric-only --json true
>   {"unit" : "GHz"}{"unit" : "insn per cycle"}{"unit" : "branch-misses of all branches"}
>   {"metric-value" : "4.166"}{"metric-value" : "0.73"}{"metric-value" : "2.96"}

It looks like the correct output would be to place the unit with the
metric-value, but perhaps that's something best done by deleting the
output code and starting again - the new output is wrong but better.
We could really do with functions like emit counter, emit metric and
have appropriate output for CSV, JSON, etc. A lot of the problems in
JSON and CSV outputting come from the unnatural way it is driven and
placing a large significance on newline characters. Putting the CSV
and JSON output to stdout also is problematic, as it naturally gets
interwoven with the monitored commands output. The dictionaries in the
new output should really be in a list, this is fixed in the test here:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/tests/shell/lib/perf_json_output_lint.py?h=perf/core#n74

Thanks,
Ian

>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c | 22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 115477461224..515fb6db3d67 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -430,12 +430,12 @@ static void print_metric_header(struct perf_stat_config *config,
>             os->evsel->priv != os->evsel->evlist->selected->priv)
>                 return;
>
> -       if (!valid_only_metric(unit) && !config->json_output)
> +       if (!valid_only_metric(unit))
>                 return;
>         unit = fixunit(tbuf, os->evsel, unit);
>
>         if (config->json_output)
> -               fprintf(os->fh, "\"unit\" : \"%s\"", unit);
> +               fprintf(os->fh, "{\"unit\" : \"%s\"}", unit);
>         else if (config->csv_output)
>                 fprintf(os->fh, "%s%s", unit, config->csv_sep);
>         else
> @@ -847,10 +847,6 @@ static void print_metric_headers(struct perf_stat_config *config,
>                 .new_line = new_line_metric,
>                 .force_header = true,
>         };
> -       bool first = true;
> -
> -       if (config->json_output && !config->interval)
> -               fprintf(config->output, "{");
>
>         if (prefix && !config->json_output)
>                 fprintf(config->output, "%s", prefix);
> @@ -871,18 +867,12 @@ static void print_metric_headers(struct perf_stat_config *config,
>         evlist__for_each_entry(evlist, counter) {
>                 os.evsel = counter;
>
> -               if (!first && config->json_output)
> -                       fprintf(config->output, ", ");
> -               first = false;
> -
>                 perf_stat__print_shadow_stats(config, counter, 0,
>                                               0,
>                                               &out,
>                                               &config->metric_events,
>                                               &rt_stat);
>         }
> -       if (config->json_output)
> -               fprintf(config->output, "}");
>         fputc('\n', config->output);
>  }
>
> @@ -954,14 +944,8 @@ static void print_interval(struct perf_stat_config *config,
>                 }
>         }
>
> -       if ((num_print_interval == 0 || config->interval_clear)
> -                        && metric_only && !config->json_output)
> +       if ((num_print_interval == 0 || config->interval_clear) && metric_only)
>                 print_metric_headers(config, evlist, " ", true);
> -       if ((num_print_interval == 0 || config->interval_clear)
> -                        && metric_only && config->json_output) {
> -               fprintf(output, "{");
> -               print_metric_headers(config, evlist, " ", true);
> -       }
>         if (++num_print_interval == 25)
>                 num_print_interval = 0;
>  }
> --
> 2.38.1.431.g37b22c650d-goog
>
