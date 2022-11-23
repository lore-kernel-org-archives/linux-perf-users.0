Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF46C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 23:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKWXVq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 18:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiKWXVp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 18:21:45 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1E211604E
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:21:44 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so2687505wmb.2
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EjQEbGjYCwaCAVNOvIzuhjLPz0PBi/aiFkgT1FMj0Kw=;
        b=YvcTWxjSyEJM5hJr9+pChZuvA4Mpc8IQtZ6dM7459/az4DEuJKRJzNOud25mfC/m1W
         ISHaYPZNDmcCtk/DIDtImd5v53sPP8vHw1f3i4hzM6D57zDUh0kPTDVooBtiaq2lXYqT
         ERQXHZflXYSilXhb6NbLQKNwm3v11INVuIopi+E+CSCChS0jc9HIyjqeYcRyBrdi0Y2v
         raotMCZjamvZd3/V17Tr7MgbF2kVfBHfJNVMa+sQeCgU8u5/7A5jOrRWrVTuP5x3XLvO
         A2oX/7JjVv8LAQovO1xA1KAQzRbb8ttaDCvhUUTNQnReqGSV3/aUc4VFc0L4MhklF3kO
         xc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjQEbGjYCwaCAVNOvIzuhjLPz0PBi/aiFkgT1FMj0Kw=;
        b=NryR6pN4gmERc2rVt7JNnCjWzglrBvkHeWDIoDbhgkTpkr0lQ1OUXhMP9N41C1D89z
         c6OtcrueouBWIC/tqJUxWg8dySIr8fzAJSTlezzC9JCxrI9cfy/mOBtb33VerUJ+SD5O
         b5+v04xcfblhMvVy14jM6qoF218EvKoNM/mKi0w3KxmMckqi8EPDiToWGkgyXzsYDzdg
         ZeD8WJt4/Uwk74x5eFFdCcDNktE2ox0yxEqL32LV2jtz33VFBEfiudQZu/EVsmOAIM7c
         Y1mE5klQvXUS9A7lr2dU8T+AvYQe4YNIoQ3ZrIKZwkYq97nEdJbfHtkR2pSSlEhesWqa
         pluA==
X-Gm-Message-State: ANoB5pmw/vVCzGb/WMthX8RPSNPLFrB5RUxEiFkFBrzCbT18xmMWULo4
        8saSRHIEbtJ0eVDsBPTkLpEa7BVf+r3Qrne/3h675g==
X-Google-Smtp-Source: AA0mqf7Vw5eLSy5FQU2GnXiaLgU41DckXd+YgpmFBiRb+IrjmyR2uA2PL3d6xcetVpQcDogn1FA/eDE36DARBHng26A=
X-Received: by 2002:a05:600c:4fc4:b0:3c6:c109:2d9 with SMTP id
 o4-20020a05600c4fc400b003c6c10902d9mr11821409wmq.149.1669245702716; Wed, 23
 Nov 2022 15:21:42 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-4-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-4-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:21:30 -0800
Message-ID: <CAP-5=fUmc3uL7o1zkJ9vv4dAa1dHwtNe1XZZbpqB5xhbgxWuTw@mail.gmail.com>
Subject: Re: [PATCH 03/15] perf stat: Do not align time prefix in CSV output
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
> We don't care about the alignment in the CSV output as it's intended for machine
> processing.  Let's get rid of it to make the output more compact.
>
> Before:
>   # perf stat -a --summary -I 1 -x, true
>        0.001149309,219.20,msec,cpu-clock,219322251,100.00,219.200,CPUs utilized
>        0.001149309,144,,context-switches,219241902,100.00,656.935,/sec
>        0.001149309,38,,cpu-migrations,219173705,100.00,173.358,/sec
>        0.001149309,61,,page-faults,219093635,100.00,278.285,/sec
>        0.001149309,10679310,,cycles,218746228,100.00,0.049,GHz
>        0.001149309,6288296,,instructions,218589869,100.00,0.59,insn per cycle
>        0.001149309,1386904,,branches,218428851,100.00,6.327,M/sec
>        0.001149309,56863,,branch-misses,218219951,100.00,4.10,of all branches
>            summary,219.20,msec,cpu-clock,219322251,100.00,20.025,CPUs utilized
>            summary,144,,context-switches,219241902,100.00,656.935,/sec
>            summary,38,,cpu-migrations,219173705,100.00,173.358,/sec
>            summary,61,,page-faults,219093635,100.00,278.285,/sec
>            summary,10679310,,cycles,218746228,100.00,0.049,GHz
>            summary,6288296,,instructions,218589869,100.00,0.59,insn per cycle
>            summary,1386904,,branches,218428851,100.00,6.327,M/sec
>            summary,56863,,branch-misses,218219951,100.00,4.10,of all branches
>
> After:
>   0.001148449,224.75,msec,cpu-clock,224870589,100.00,224.747,CPUs utilized
>   0.001148449,176,,context-switches,224775564,100.00,783.103,/sec
>   0.001148449,38,,cpu-migrations,224707428,100.00,169.079,/sec
>   0.001148449,61,,page-faults,224629326,100.00,271.416,/sec
>   0.001148449,12172071,,cycles,224266368,100.00,0.054,GHz
>   0.001148449,6901907,,instructions,224108764,100.00,0.57,insn per cycle
>   0.001148449,1515655,,branches,223946693,100.00,6.744,M/sec
>   0.001148449,70027,,branch-misses,223735385,100.00,4.62,of all branches
>   summary,224.75,msec,cpu-clock,224870589,100.00,21.066,CPUs utilized
>   summary,176,,context-switches,224775564,100.00,783.103,/sec
>   summary,38,,cpu-migrations,224707428,100.00,169.079,/sec
>   summary,61,,page-faults,224629326,100.00,271.416,/sec
>   summary,12172071,,cycles,224266368,100.00,0.054,GHz
>   summary,6901907,,instructions,224108764,100.00,0.57,insn per cycle
>   summary,1515655,,branches,223946693,100.00,6.744,M/sec
>   summary,70027,,branch-misses,223735385,100.00,4.62,of all branches
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index d86f2f8e020d..15c88b9b5aa3 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -828,7 +828,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>                         fprintf(output, "%s", prefix);
>                 else if (config->summary && config->csv_output &&
>                          !config->no_csv_summary && !config->interval)
> -                       fprintf(output, "%16s%s", "summary", config->csv_sep);
> +                       fprintf(output, "%s%s", "summary", config->csv_sep);
>         }
>
>         uval = val * counter->scale;
> @@ -1078,9 +1078,12 @@ static void prepare_interval(struct perf_stat_config *config,
>         if (config->iostat_run)
>                 return;
>
> -       if (!config->json_output)
> -               sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec,
> +       if (config->csv_output)
> +               sprintf(prefix, "%lu.%09lu%s", (unsigned long) ts->tv_sec,
>                                  ts->tv_nsec, config->csv_sep);
> +       else if (!config->json_output)
> +               sprintf(prefix, "%6lu.%09lu ", (unsigned long) ts->tv_sec,
> +                                ts->tv_nsec);
>         else if (!config->metric_only)
>                 sprintf(prefix, "{\"interval\" : %lu.%09lu, ", (unsigned long)
>                                  ts->tv_sec, ts->tv_nsec);
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
