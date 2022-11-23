Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BAFC433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 23:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiKWXbn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 18:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiKWXbm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 18:31:42 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB6542188
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:31:40 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v1so31684088wrt.11
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/GzkdSJX9SNnKwY3qDUaOPRLL/gIxEhMol0Hco9KJpI=;
        b=pJigdusRH1JM3OUzwj2QESzt6NcfAn7uDMEsODC5XoSSnhwnwUsElhvuQ5sM8aU7nr
         2iZQNQjM/uGkSrp5Se1jUs35kDGavm4vtBgYtMeGuaW8+9lv3+qXppXdnCKNeqnTkLp2
         gXhKCgodjbjHHdyhB+dfIhSbSQKQXlpAqVMYVBVMxj22VqwryovoonYrDWoJ159RzOVu
         7LR6me/japqo6FLVcDyZ4hVvbbwLEjpYn3EoqBqhNb7XWff9r8lRBmnDfJhhm6x4TvY7
         QyEq5gb+xxiSEorfhRW0W7nQDDufKRiUOM4P6FyWjIM1tNwTvZrmjF0EtDPqP9qasPEO
         cxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/GzkdSJX9SNnKwY3qDUaOPRLL/gIxEhMol0Hco9KJpI=;
        b=qK2gTjlkdo6Dys+szXLCp8Vu9RXtOJCITqbMVcvh0MIXmZX01lCAlPXfu9bcCOVH2c
         ffhGuTx71Q3kkP8MT07q9TjX4WCYdMyOylJCkK0dXjuEaAG7XRQxvkpUdK4vzyNJm0WI
         yLBAXxc0oz/POiVTVY0WDo//niXhz+vX+oNEKUISDq7PRXuw5n+UZsOGuBhOV/SINz3+
         XbRJW+S8Cy/xfsHGUVAZz5cPpUQ8W3wjRwxkl7B1E9zRstCQAEvP5WpVTxQ+VbJgjkPy
         Zhrp29ELqTGB8BxLF5iwm3WWNP/ZN2OxBbGO5TEUg3gB6aWj3duEIrhadsc8xQNWNSMA
         Tp/w==
X-Gm-Message-State: ANoB5plhyHJzhe60Wy9GKjdBGhdPr7PVDyBozta1vzlMEN5jIveZTjTV
        sOwPk9BtnZ5MQa/6WHm8N4XtAsULDfef5I7J4TbzQg==
X-Google-Smtp-Source: AA0mqf6bcwQGpv2OmjpeQVbXNNC8KE4XFllZ+PODDpuME59hW5jYnbqMEvt1epthcqLp92qvIxYH8J/UiNmeYix8oOg=
X-Received: by 2002:adf:e64f:0:b0:241:e2f1:8b44 with SMTP id
 b15-20020adfe64f000000b00241e2f18b44mr6043654wrn.300.1669246299194; Wed, 23
 Nov 2022 15:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-16-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-16-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:31:26 -0800
Message-ID: <CAP-5=fVaUFDwcP9s8aAtxFtRWQnBqRBrZYkKxAxzog_pmicsRQ@mail.gmail.com>
Subject: Re: [PATCH 15/15] perf stat: Tidy up JSON metric-only output when no metrics
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
> It printed empty strings for each metric.  I guess it's needed for CSV
> output to match the column number.  We could just ignore the empty
> metrics in JSON but it ended up with a broken JSON object with a
> trailing comma.
>
> So I added a dummy '"metric-value" : "none"' part.  To do that, it
> needs to pass struct outstate to print_metric_end() to check if any
> metric value is printed or not.
>
> Before:
>   # perf stat -aj --metric-only --per-socket --for-each-cgroup system.slice true
>   {"socket" : "S0", "cpu-count" : 8, "cgroup" : "system.slice", "" : "", "" : "", "" : "", "" : "", "" : "", "" : "", "" : "", "" : ""}
>
> After:
>   # perf stat -aj --metric-only --per-socket --for-each-cgroup system.slice true
>   {"socket" : "S0", "cpu-count" : 8, "cgroup" : "system.slice", "metric-value" : "none"}
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 7a39a1a7261d..847acdb5dc40 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -532,6 +532,8 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
>         while (isdigit(*ends) || *ends == '.')
>                 ends++;
>         *ends = 0;
> +       if (!unit[0] || !vals[0])
> +               return;
>         fprintf(out, "%s\"%s\" : \"%s\"", os->first ? "" : ", ", unit, vals);
>         os->first = false;
>  }
> @@ -864,14 +866,19 @@ static void print_metric_begin(struct perf_stat_config *config,
>         print_cgroup(config, os->cgrp ? : evsel->cgrp);
>  }
>
> -static void print_metric_end(struct perf_stat_config *config)
> +static void print_metric_end(struct perf_stat_config *config, struct outstate *os)
>  {
> +       FILE *output = config->output;
> +
>         if (!config->metric_only)
>                 return;
>
> -       if (config->json_output)
> -               fputc('}', config->output);
> -       fputc('\n', config->output);
> +       if (config->json_output) {
> +               if (os->first)
> +                       fputs("\"metric-value\" : \"none\"", output);
> +               fputc('}', output);
> +       }
> +       fputc('\n', output);
>  }
>
>  static void print_aggr(struct perf_stat_config *config,
> @@ -897,7 +904,7 @@ static void print_aggr(struct perf_stat_config *config,
>
>                         print_counter_aggrdata(config, counter, s, os);
>                 }
> -               print_metric_end(config);
> +               print_metric_end(config, os);
>         }
>  }
>
> @@ -929,7 +936,7 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
>
>                                 print_counter_aggrdata(config, counter, s, os);
>                         }
> -                       print_metric_end(config);
> +                       print_metric_end(config, os);
>                 }
>         }
>  }
> @@ -985,7 +992,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>                         printout(config, os, uval, run, ena, 1.0, counter_idx);
>                 }
>                 if (!first)
> -                       print_metric_end(config);
> +                       print_metric_end(config, os);
>         }
>  }
>
> @@ -1348,7 +1355,7 @@ static void print_cgroup_counter(struct perf_stat_config *config, struct evlist
>         evlist__for_each_entry(evlist, counter) {
>                 if (os->cgrp != counter->cgrp) {
>                         if (os->cgrp != NULL)
> -                               print_metric_end(config);
> +                               print_metric_end(config, os);
>
>                         os->cgrp = counter->cgrp;
>                         print_metric_begin(config, evlist, os, /*aggr_idx=*/0);
> @@ -1357,7 +1364,7 @@ static void print_cgroup_counter(struct perf_stat_config *config, struct evlist
>                 print_counter(config, counter, os);
>         }
>         if (os->cgrp)
> -               print_metric_end(config);
> +               print_metric_end(config, os);
>  }
>
>  void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *config,
> @@ -1405,7 +1412,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>                         evlist__for_each_entry(evlist, counter) {
>                                 print_counter(config, counter, &os);
>                         }
> -                       print_metric_end(config);
> +                       print_metric_end(config, &os);
>                 }
>                 break;
>         case AGGR_NONE:
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
