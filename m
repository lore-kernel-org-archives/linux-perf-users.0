Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5681C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 May 2022 22:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345491AbiEaWqu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 May 2022 18:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241562AbiEaWqu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 May 2022 18:46:50 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AD564E3;
        Tue, 31 May 2022 15:46:48 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id u140so369256oie.3;
        Tue, 31 May 2022 15:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtfN9Ae7L2YdbBQXYfVn369SwWqSdF9XH/jlV1HuQs8=;
        b=df+h7b7fIO5YHY1KlqN4Uydrn2YhcfnXTEQ6oz4GW/lIFB+qXM1bOfIqkzEfAsT0ob
         EpeJyKxdUGqxYAs01QYeKpPTUsL+871CmOYX6RLKM+vcYyO2yb4C5MYnTElOj/5i9MRl
         hY0Uj97CPFQVXQQj/wCBJjF8qmb8ge25D++b6rBxHlz2yRZ5NKvhZbJB8YpxkmvMdVp8
         jlJTj53WyIz4uJQrLdq2CG343NBu1FtPOdDAhS8b9khOz3Q4HvEHALnpR3S1BOOaDneL
         2mrZFeWhh25OcnqcrhGaYvjMQsYTdaiuoNtuczR/zLUyXWwmD0KGPlVqoxH8iZ37p+4A
         nqjQ==
X-Gm-Message-State: AOAM5309w6CIkmf/8suPZsGQ6qHrQKqGsVTDUPEcMIsRjVLgLJn4G4Vf
        KcBuztgMD/PfeUL0nzaXL52A1SaZznW0odXWXd0=
X-Google-Smtp-Source: ABdhPJwNLpQWKEJhhoMAFvXA0GO+YgoH9ouItjCncWsXjpIbe7s0bdp9uW6UUljnMe35rwNcYL7LjeS20uabRliwtpU=
X-Received: by 2002:a05:6808:16ac:b0:2f9:52e5:da90 with SMTP id
 bb44-20020a05680816ac00b002f952e5da90mr13721026oib.5.1654037207957; Tue, 31
 May 2022 15:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220525053814.3265216-1-irogers@google.com> <20220525053814.3265216-3-irogers@google.com>
In-Reply-To: <20220525053814.3265216-3-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 31 May 2022 15:46:37 -0700
Message-ID: <CAM9d7cgA4fr3G7wjpaTKyEPF1JuAsQO-Ucoe9Ahd56KMz5RNBw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] perf stat: Add JSON output option
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Claire Jensen <clairej735@gmail.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian,

On Tue, May 24, 2022 at 10:38 PM Ian Rogers <irogers@google.com> wrote:
>
> From: Claire Jensen <cjense@google.com>
>
> CSV output is tricky to format and column layout changes are susceptible
> to breaking parsers. New JSON-formatted output has variable names to
> identify fields that are consistent and informative, making
> the output parseable.
>
> CSV output example:
>
> 1.20,msec,task-clock:u,1204272,100.00,0.697,CPUs utilized
> 0,,context-switches:u,1204272,100.00,0.000,/sec
> 0,,cpu-migrations:u,1204272,100.00,0.000,/sec
> 70,,page-faults:u,1204272,100.00,58.126,K/sec
>
> JSON output example:
>
> {"counter-value" : "3805.723968", "unit" : "msec", "event" :
> "cpu-clock", "event-runtime" : 3805731510100.00, "pcnt-running"
> : 100.00, "metric-value" : 4.007571, "metric-unit" : "CPUs utilized"}
> {"counter-value" : "6166.000000", "unit" : "", "event" :
> "context-switches", "event-runtime" : 3805723045100.00, "pcnt-running"
> : 100.00, "metric-value" : 1.620191, "metric-unit" : "K/sec"}
> {"counter-value" : "466.000000", "unit" : "", "event" :
> "cpu-migrations", "event-runtime" : 3805727613100.00, "pcnt-running"
> : 100.00, "metric-value" : 122.447136, "metric-unit" : "/sec"}
> {"counter-value" : "208.000000", "unit" : "", "event" :
> "page-faults", "event-runtime" : 3805726799100.00, "pcnt-running"
> : 100.00, "metric-value" : 54.654516, "metric-unit" : "/sec"}
>
> Also added documentation for JSON option.
> There is some tidy up of CSV code including a potential memory over run
> in the os.nfields set up. To facilitate this an AGGR_MAX value is added.
>
> Signed-off-by: Claire Jensen <cjense@google.com>

Your sign-off as well?

Anyway, I think there are places to clean up this part of code
more but that's not a part of the work.  Maybe I need to find
some time to do that later.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
