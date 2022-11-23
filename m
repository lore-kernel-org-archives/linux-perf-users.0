Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7626EC433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 23:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiKWXZC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 18:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiKWXY5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 18:24:57 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9EE1121E7
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:24:55 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v7so164709wmn.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v+tGZGhnm8P0vj642hW4k05hjjKf7AKRSNEqq1mRlYc=;
        b=bpcPSn65j8ta6d4fvzn9Gt9P2c7luz98pIdsc68q9RY24WpGnqfUJ+hHY22HiWl4fn
         r0YqGr0fd4wjrP1z8Oekw3I/JwrIozb6FJ/TPNftvkbjiW8z/o7mZjpyI1W+Z508i3Y1
         M42lqAEu6HxZ+wbO95EtM3CMnBsZZfP+GVm1eK+oWrq5nWglghS0l/Uc4+ODz0xW53GI
         9shHOiFN7bv1XTaGiehGvihALZipPyNtHYaBC341Kb7TsHJn/TPSEn4wS+ux67kii0NB
         7edk34BN5sEXjYY1AlLnKDqDdEhQRmMqCbeaBoELyW8s8H3dh5om0G7iFiwaKkFNIeg/
         6q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+tGZGhnm8P0vj642hW4k05hjjKf7AKRSNEqq1mRlYc=;
        b=6BhZzvyQBBob6GqxtOv++5APFWlpw++91q9dHT4FOPX85LP8CpAAfvgiLk7CRTMdqz
         Bw7EAADy2WarwtVMOHBO9a2kU9JdCYKeB9aiFM/CmWice8eDeHQT3c5l+TGarOw7aGvP
         VYNJckdw6xPt7ENz9I2YiPmhwWNzc/O26fzANh/8UPsl1qQoMn/O9HWroYESZozdsCS0
         RaCjK4AAWEEM9vOtFadmFSKali7hczwK4ZN5/hQNUBuqq3dOrQYjONTcFwBqnsqdLgnr
         ark3FSq4OGHZ6xBkUIxyo3hJSKeH4JZSrRjdxZC2EoI8p1jiakBfZhH18mHhgs4Gghvp
         reNg==
X-Gm-Message-State: ANoB5pnyrDskxSfNbvIZmvfy3xCD4mtlt2bCfIS7+LiCokW7p9LDwDEz
        b0lNhx6u17a5RFufhxIDzK1Pv8Gn9Dar4iXf7zmvSw==
X-Google-Smtp-Source: AA0mqf6QqwjQ01cOzNaLheZnD95o+TZ7XJifTtVsygx7sNzwVpZua6hUSmhI1+yO36Y2UlZuuyoocmDXoGIKSXDrCto=
X-Received: by 2002:a05:600c:3d8f:b0:3cf:6a4c:af8b with SMTP id
 bi15-20020a05600c3d8f00b003cf6a4caf8bmr8410535wmb.115.1669245893832; Wed, 23
 Nov 2022 15:24:53 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-9-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-9-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:24:41 -0800
Message-ID: <CAP-5=fUA4kD7neEKGGmOPTdKcb3nWZRdaqnXynO7fQOhb+K2Pg@mail.gmail.com>
Subject: Re: [PATCH 08/15] perf stat: Use struct outstate in evlist__print_counters()
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
> This is a preparation for the later cleanup.  No functional changes
> intended.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index d2894a519d61..70aebf359e16 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1372,13 +1372,16 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>         bool metric_only = config->metric_only;
>         int interval = config->interval;
>         struct evsel *counter;
> -       char buf[64], *prefix = NULL;
> +       char buf[64];
> +       struct outstate os = {
> +               .fh = config->output,
> +       };
>
>         if (config->iostat_run)
>                 evlist->selected = evlist__first(evlist);
>
>         if (interval) {
> -               prefix = buf;
> +               os.prefix = buf;
>                 prepare_interval(config, buf, sizeof(buf), ts);
>         }
>
> @@ -1390,35 +1393,35 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>         case AGGR_SOCKET:
>         case AGGR_NODE:
>                 if (config->cgroup_list)
> -                       print_aggr_cgroup(config, evlist, prefix);
> +                       print_aggr_cgroup(config, evlist, os.prefix);
>                 else
> -                       print_aggr(config, evlist, prefix);
> +                       print_aggr(config, evlist, os.prefix);
>                 break;
>         case AGGR_THREAD:
>         case AGGR_GLOBAL:
>                 if (config->iostat_run) {
> -                       iostat_print_counters(evlist, config, ts, prefix = buf,
> +                       iostat_print_counters(evlist, config, ts, buf,
>                                               print_counter);
>                 } else if (config->cgroup_list) {
> -                       print_cgroup_counter(config, evlist, prefix);
> +                       print_cgroup_counter(config, evlist, os.prefix);
>                 } else {
> -                       print_metric_begin(config, evlist, prefix,
> +                       print_metric_begin(config, evlist, os.prefix,
>                                            /*aggr_idx=*/0, /*cgrp=*/NULL);
>                         evlist__for_each_entry(evlist, counter) {
> -                               print_counter(config, counter, prefix);
> +                               print_counter(config, counter, os.prefix);
>                         }
>                         print_metric_end(config);
>                 }
>                 break;
>         case AGGR_NONE:
>                 if (metric_only)
> -                       print_no_aggr_metric(config, evlist, prefix);
> +                       print_no_aggr_metric(config, evlist, os.prefix);
>                 else {
>                         evlist__for_each_entry(evlist, counter) {
>                                 if (counter->percore)
> -                                       print_percore(config, counter, prefix);
> +                                       print_percore(config, counter, os.prefix);
>                                 else
> -                                       print_counter(config, counter, prefix);
> +                                       print_counter(config, counter, os.prefix);
>                         }
>                 }
>                 break;
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
