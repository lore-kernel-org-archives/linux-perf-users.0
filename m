Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45D6C38142
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Jan 2023 06:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjAWGcF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Jan 2023 01:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAWGcE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Jan 2023 01:32:04 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7C3E041
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Jan 2023 22:32:02 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4fd37a1551cso133962587b3.13
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Jan 2023 22:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uF+JjlQ7MsgfzxBec0hKgCPw0LzpRY0QST5LAR+ooF0=;
        b=nmag+Z+fyVlxFvA5nefdoDMj5stcxUik/ecI0fxM6YI9i2regguTqsdTNRiqufEAUV
         WvKGAUnrXgDHtk6X6AO3EPlQiFVDCgF/UgDKnL8n8kGKF8oHYycid8m/0+2sVx8u+jct
         waVgQ20RQ/V8lfg2OukK9Fv4EyPSQYCZq/JbGm1goAulb6EsnqR0GnNDFARdkCpZUK4s
         EUltv+ZtkqlnG4hZUBcbMFSRGy12qRCciSnQ52X9QcT9qrHcxKPYqezEnbU0ZchvvvOQ
         u2i3rWokegFqXLKMK4+RNIKuao1VRNfwG/tu4euSzf5EXtw68CH49E8wyD2UEwSPrI5M
         4zaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uF+JjlQ7MsgfzxBec0hKgCPw0LzpRY0QST5LAR+ooF0=;
        b=S0qKsIN0OMB/COnOkm9pux/AtLdiRbvPyBPoTBWcDSnEWelpbTsqLnKDquGtuWAVL/
         rvLZ8npkSuLeI5cvyxKqxlLc6ACk3UQAAPdxJGrE3U0Qd35ER93ixQWQBFb0nF4oWD/V
         UiWZgt5/m3pKGqVuEYF51CDb3OwAMDo6jcUE/9/pwKdVIM0JroSBEeweUHwm3i/Iuxbm
         AmBAGkZinahLQVTi4MMkH3mcaUZ2Bzc43iUHYcaeu5O20hCtibD6KxS3gkzdtcFZdh3I
         IdDKRmMgmk6Cz6KW7oRjyTROpF2AND6rwj2IuWmTKcfTFY/w9d7e/dntsC+F1uHXqK72
         cMsw==
X-Gm-Message-State: AFqh2kpzFCKI8hTcvIjmgo3FBL+5EdIe22znedVSSK7BB5cMqVsrsH+P
        Fwf0wzKwNqxPj/w5mYRMegZUjB8xRrFZ7I+2OlI=
X-Google-Smtp-Source: AMrXdXvpXt94ChHlumXSqhZ64EiP5yS5B9Db/XZKrQLMh2m18PKuol6DxQTnvXOjqZj2gxMDpwmYZH6MxqX3PnakxDo=
X-Received: by 2002:a81:f91:0:b0:4da:db20:6419 with SMTP id
 139-20020a810f91000000b004dadb206419mr2694123ywp.76.1674455521696; Sun, 22
 Jan 2023 22:32:01 -0800 (PST)
MIME-Version: 1.0
References: <20230120134039.17788-1-mpetlan@redhat.com> <20230120134039.17788-2-mpetlan@redhat.com>
In-Reply-To: <20230120134039.17788-2-mpetlan@redhat.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Sun, 22 Jan 2023 22:31:50 -0800
Message-ID: <CAM9d7cjS29P-0-SzCyc7HmuWsHL-j+xf03hvR7J2WmPJnaQoOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf stat: Fix JSON metric printout for multiple
 metrics per line
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
        qzhao@redhat.com, cjense@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Michael,

On Fri, Jan 20, 2023 at 5:47 AM Michael Petlan <mpetlan@redhat.com> wrote:
>
> JSON printing engine used to always print metric (even when there should
> be none and other engines (std, csv) would not print it) and the metric
> used to always close the line by printing a closing curly bracket.
>
> This caused invalid JSON output being generated for top-down metrics,
> when multiple metrics are printed on a single line, so the broken output
> might have looked like:
>
>   ... "metric-value" : 15.564203, "metric-unit" : \
>   "Memory Bound"}"metric-value" : 14.007787, "metric-unit" : "Core Bound"}
>
> To fix it, print always the separating comma BEFORE the key:value pairs
> and close the line outside of the JSON metric printing routine.
>
> Fixes: df936cadfb58 ("perf stat: Add JSON output option")
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks for the fix, a nitpick below..


> ---
>  tools/perf/util/stat-display.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 8bd8b0142630..8f80f6b566d0 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -86,7 +86,7 @@ static void print_running_json(struct perf_stat_config *config, u64 run, u64 ena
>
>         if (run != ena)
>                 enabled_percent = 100 * run / ena;
> -       fprintf(config->output, "\"event-runtime\" : %" PRIu64 ", \"pcnt-running\" : %.2f, ",
> +       fprintf(config->output, ", \"event-runtime\" : %" PRIu64 ", \"pcnt-running\" : %.2f",
>                 run, enabled_percent);
>  }
>
> @@ -121,7 +121,7 @@ static void print_noise_pct_csv(struct perf_stat_config *config,
>  static void print_noise_pct_json(struct perf_stat_config *config,
>                                  double pct)
>  {
> -       fprintf(config->output, "\"variance\" : %.2f, ", pct);
> +       fprintf(config->output, ", \"variance\" : %.2f", pct);
>  }
>
>  static void print_noise_pct(struct perf_stat_config *config,
> @@ -165,7 +165,7 @@ static void print_cgroup_csv(struct perf_stat_config *config, const char *cgrp_n
>
>  static void print_cgroup_json(struct perf_stat_config *config, const char *cgrp_name)
>  {
> -       fprintf(config->output, "\"cgroup\" : \"%s\", ", cgrp_name);
> +       fprintf(config->output, ", \"cgroup\" : \"%s\"", cgrp_name);
>  }
>
>  static void print_cgroup(struct perf_stat_config *config, struct cgroup *cgrp)
> @@ -431,10 +431,11 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
>         struct outstate *os = ctx;
>         FILE *out = os->fh;
>
> -       fprintf(out, "\"metric-value\" : %f, ", val);
> -       fprintf(out, "\"metric-unit\" : \"%s\"", unit);
> -       if (!config->metric_only)
> -               fprintf(out, "}");
> +       if (unit == NULL || fmt == NULL)
> +               return;

This seems like a separate fix.

Thanks,
Namhyung


> +
> +       fprintf(out, ", \"metric-value\" : %f", val);
> +       fprintf(out, ", \"metric-unit\" : \"%s\"", unit);
>  }
>
>  static void new_line_json(struct perf_stat_config *config, void *ctx)
> @@ -623,14 +624,14 @@ static void print_counter_value_json(struct perf_stat_config *config,
>         const char *bad_count = evsel->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED;
>
>         if (ok)
> -               fprintf(output, "\"counter-value\" : \"%f\", ", avg);
> +               fprintf(output, "\"counter-value\" : \"%f\"", avg);
>         else
> -               fprintf(output, "\"counter-value\" : \"%s\", ", bad_count);
> +               fprintf(output, "\"counter-value\" : \"%s\"", bad_count);
>
>         if (evsel->unit)
> -               fprintf(output, "\"unit\" : \"%s\", ", evsel->unit);
> +               fprintf(output, ", \"unit\" : \"%s\"", evsel->unit);
>
> -       fprintf(output, "\"event\" : \"%s\", ", evsel__name(evsel));
> +       fprintf(output, ", \"event\" : \"%s\"", evsel__name(evsel));
>  }
>
>  static void print_counter_value(struct perf_stat_config *config,
> @@ -835,8 +836,11 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>
>         printout(config, os, uval, run, ena, avg, s);
>
> -       if (!metric_only)
> +       if (!metric_only) {
> +               if (config->json_output)
> +                       fputc('}', output);
>                 fputc('\n', output);
> +       }
>  }
>
>  static void print_metric_begin(struct perf_stat_config *config,
> --
> 2.18.4
>
