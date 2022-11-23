Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE23C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 23:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiKWXWS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 18:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiKWXWR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 18:22:17 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D1D11E703
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:22:16 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s5so17809wru.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Jdl6xJf2GOmq95nfWh92ojvpXIe3KF+eLKF3UOPapg=;
        b=qOJB4MpqAvn4MQeX4Olb2iCcV3izJiOGVFzb/LgSbt/8ZIRnI30grkK6ejxfBOtfvE
         /SBMZNNVomC0RDOeLbc/MV00k/6DUDBg3CdcDLGrFrrGEGcxd6/gvaOolgYWfgilkbAi
         7iA2CFkamZ3xUJHrx22DnoXOI2dqPuIekmMFDKWO6DpLe4rrPXZv4zqmA7ircGRFNCYu
         MHBv7nbF3CGcvzNK+3pjWsvjJip/8YfPBBtHEotbzzRPsNtabKCZqWeb1nCpGcj+1oPl
         /fsv99iPYSfg/wBfbEAiuj1ImBw3ANHFH4PTRN54fFSg06tGyKR4UyfUhJ5osash7mZp
         ha5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Jdl6xJf2GOmq95nfWh92ojvpXIe3KF+eLKF3UOPapg=;
        b=xLf7z+mkPloM98GNM9riKAb/7qQlhnscJ5WSzkYhTCgn9V9/TiLUuA9+fnJThAg7OG
         a9L/xNXQbwdSDfpBvT3UP8FZVNYN/UQO/XdBN6ZyChFMaeJXij1rLdZ+kbI9ssJA63Cz
         zQ3pJa+8Y6Nti+XtnABbFypjHoNFh1jI7yj9Z6HvW5+wOAA8k4M3KZqSEhUH8TUqQmgZ
         CK0nV53wZO6SFsiel8m+vsIXAiELr+Yp0/2Bc4TKEeHcMPdyIVzy+bZsn2f26Ko2YnHU
         fRFmu9edPDZNTi6ngb2PsrPpE6QhaP5iIjOBD1KiYbKGODXwwLV2vuzr+cHL6XMmYghb
         2FSQ==
X-Gm-Message-State: ANoB5plOYAqajIlE/0Ls80Qw4M3i+EDiBc7BWY7RdDrMq6A793papnBG
        h9Vy8yayrywpqiTMC8N/aeL16liwGatO+k8JE6seiQ==
X-Google-Smtp-Source: AA0mqf4Md+PgZrtFIP7Z6ENJJ2tkSUqIrPjqpQrsRz7vIeA+KkN2WoOq4c/CeCq2zb9OmeDhHDrxVi+OG5ALSZ+38vk=
X-Received: by 2002:adf:f6cc:0:b0:228:dd1d:8a42 with SMTP id
 y12-20020adff6cc000000b00228dd1d8a42mr7208230wrp.375.1669245734572; Wed, 23
 Nov 2022 15:22:14 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-5-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-5-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:22:01 -0800
Message-ID: <CAP-5=fXzc4-U=g96dr7jzUHNKudcUh2JZW89BT8xs01Zfp7ZDw@mail.gmail.com>
Subject: Re: [PATCH 04/15] perf stat: Use scnprintf() in prepare_interval()
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
> It should not use sprintf() anymore.  Let's pass the buffer size and use the
> safer scnprintf() instead.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 15c88b9b5aa3..744b7a40f59a 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1073,23 +1073,23 @@ static void print_metric_headers(struct perf_stat_config *config,
>  }
>
>  static void prepare_interval(struct perf_stat_config *config,
> -                            char *prefix, struct timespec *ts)
> +                            char *prefix, size_t len, struct timespec *ts)
>  {
>         if (config->iostat_run)
>                 return;
>
>         if (config->csv_output)
> -               sprintf(prefix, "%lu.%09lu%s", (unsigned long) ts->tv_sec,
> -                                ts->tv_nsec, config->csv_sep);
> +               scnprintf(prefix, len, "%lu.%09lu%s",
> +                         (unsigned long) ts->tv_sec, ts->tv_nsec, config->csv_sep);
>         else if (!config->json_output)
> -               sprintf(prefix, "%6lu.%09lu ", (unsigned long) ts->tv_sec,
> -                                ts->tv_nsec);
> +               scnprintf(prefix, len, "%6lu.%09lu ",
> +                         (unsigned long) ts->tv_sec, ts->tv_nsec);
>         else if (!config->metric_only)
> -               sprintf(prefix, "{\"interval\" : %lu.%09lu, ", (unsigned long)
> -                                ts->tv_sec, ts->tv_nsec);
> +               scnprintf(prefix, len, "{\"interval\" : %lu.%09lu, ",
> +                         (unsigned long) ts->tv_sec, ts->tv_nsec);
>         else
> -               sprintf(prefix, "{\"interval\" : %lu.%09lu}", (unsigned long)
> -                                ts->tv_sec, ts->tv_nsec);
> +               scnprintf(prefix, len, "{\"interval\" : %lu.%09lu}",
> +                         (unsigned long) ts->tv_sec, ts->tv_nsec);
>  }
>
>  static void print_header_interval_std(struct perf_stat_config *config,
> @@ -1390,7 +1390,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>
>         if (interval) {
>                 prefix = buf;
> -               prepare_interval(config, prefix, ts);
> +               prepare_interval(config, buf, sizeof(buf), ts);
>         }
>
>         print_header(config, _target, evlist, argc, argv);
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
