Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203D1C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 May 2022 23:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244731AbiEaXOQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 May 2022 19:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348647AbiEaXOO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 May 2022 19:14:14 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D78994C7
        for <linux-perf-users@vger.kernel.org>; Tue, 31 May 2022 16:14:13 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id f7-20020a1c3807000000b0039c1a10507fso135436wma.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 May 2022 16:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsGtCQjsD5Lgzs+utKozwOeVABakv4boIvT9SlNqpUs=;
        b=Add2d6klgO3WgkC4bNK13N2011UiYM6rJkpI3O+/IhZ5cnQpnUIR11pKG3SVZ5LjKo
         x6d/qMS3QqKI746+8/veBw6P6/yHLdkPpRRT6C8acpOBeedFC3ZjvCD2WGftPKNDPL5P
         SlMhRvWU0nJynHSw4CnMROfSDmd9POkoZFHL4r6vn9CDX7ZwsBCt1VfRLBuXiO4lphSd
         /+mABqoetkMw70Q1NQYVh+sXIkwpNxw/TuHpZlM0Bv3HOt8MquAbwLZyT2d/Cvwoweni
         xoNku4bQxBvR9XkK/cVlmoRDk2zNvPwTJ9jOvPX/DmN0iHXsW5mA3MdV1Vlroq8UBV1b
         2gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsGtCQjsD5Lgzs+utKozwOeVABakv4boIvT9SlNqpUs=;
        b=aT0MV88pYD8MsQV1B4WemD3CGxeDp5CuPW5SoQFjAzv/cu6GdRHiENKCbFPtPiABbe
         Afj7/6/fmeh/zDTIpqNrI4LfWbC1QW0L18JKiEB0cAj1BTelKKjAGyignEH7+iULA105
         lxLCuD+dL27O5DtKWRqwiN4yZE6FkEkfX5GfY6DfMXJC1aQXV+Hiar7v8dy/ouRW2V9U
         +VZcHDd6VqFz7GPor7zfbJqj20ETO6hmpNbmJi8lJUzH7H8oBXegzfU1qOopbgdu+ANI
         zPz57JkTzv/aFzKSLNkgYgH1Hmxt9rZgd9K/W9LCZttLdPbKMxG1X2wAQP7ZFd6+RJYO
         +Hig==
X-Gm-Message-State: AOAM533mV/FTLpJFfXwDlasIWWEv/mZvUGedp1eV+An6coDk5AbSnY9Y
        bYvS3VvUyHJqpqVEkoXBSeGQ7vPmIKzGjknKwNvKSfkEhSA+AQ==
X-Google-Smtp-Source: ABdhPJxwKGx3OW5jcWW2xYLAR97R5qwDC5CUzW+ZtS8y28XCytjsiExAmfTWRNzyE6PZnR3oPdQiKJesCE47ntIftAs=
X-Received: by 2002:a05:600c:2305:b0:397:44a4:d3cb with SMTP id
 5-20020a05600c230500b0039744a4d3cbmr25267127wmo.115.1654038852016; Tue, 31
 May 2022 16:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220525053814.3265216-1-irogers@google.com> <20220525053814.3265216-3-irogers@google.com>
 <CAM9d7cgA4fr3G7wjpaTKyEPF1JuAsQO-Ucoe9Ahd56KMz5RNBw@mail.gmail.com>
In-Reply-To: <CAM9d7cgA4fr3G7wjpaTKyEPF1JuAsQO-Ucoe9Ahd56KMz5RNBw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 31 May 2022 16:13:59 -0700
Message-ID: <CAP-5=fXcskdtN_dz5jcVywq8S1=pC5TdEN25LcEXzd0Gyk+o+w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] perf stat: Add JSON output option
To:     Namhyung Kim <namhyung@kernel.org>
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

On Tue, May 31, 2022 at 3:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Tue, May 24, 2022 at 10:38 PM Ian Rogers <irogers@google.com> wrote:
> >
> > From: Claire Jensen <cjense@google.com>
> >
> > CSV output is tricky to format and column layout changes are susceptible
> > to breaking parsers. New JSON-formatted output has variable names to
> > identify fields that are consistent and informative, making
> > the output parseable.
> >
> > CSV output example:
> >
> > 1.20,msec,task-clock:u,1204272,100.00,0.697,CPUs utilized
> > 0,,context-switches:u,1204272,100.00,0.000,/sec
> > 0,,cpu-migrations:u,1204272,100.00,0.000,/sec
> > 70,,page-faults:u,1204272,100.00,58.126,K/sec
> >
> > JSON output example:
> >
> > {"counter-value" : "3805.723968", "unit" : "msec", "event" :
> > "cpu-clock", "event-runtime" : 3805731510100.00, "pcnt-running"
> > : 100.00, "metric-value" : 4.007571, "metric-unit" : "CPUs utilized"}
> > {"counter-value" : "6166.000000", "unit" : "", "event" :
> > "context-switches", "event-runtime" : 3805723045100.00, "pcnt-running"
> > : 100.00, "metric-value" : 1.620191, "metric-unit" : "K/sec"}
> > {"counter-value" : "466.000000", "unit" : "", "event" :
> > "cpu-migrations", "event-runtime" : 3805727613100.00, "pcnt-running"
> > : 100.00, "metric-value" : 122.447136, "metric-unit" : "/sec"}
> > {"counter-value" : "208.000000", "unit" : "", "event" :
> > "page-faults", "event-runtime" : 3805726799100.00, "pcnt-running"
> > : 100.00, "metric-value" : 54.654516, "metric-unit" : "/sec"}
> >
> > Also added documentation for JSON option.
> > There is some tidy up of CSV code including a potential memory over run
> > in the os.nfields set up. To facilitate this an AGGR_MAX value is added.
> >
> > Signed-off-by: Claire Jensen <cjense@google.com>
>
> Your sign-off as well?

Doh:
Signed-off-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Anyway, I think there are places to clean up this part of code
> more but that's not a part of the work.  Maybe I need to find
> some time to do that later.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
