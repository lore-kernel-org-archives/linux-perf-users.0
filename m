Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EFFC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Jan 2022 16:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbiAQQV4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Jan 2022 11:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbiAQQV4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Jan 2022 11:21:56 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00F3C061574
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jan 2022 08:21:55 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id i14so15174681ila.11
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jan 2022 08:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sp+0eoECInU2wfkdrbVWkaKUDKICynVO7ICEtzkqDx8=;
        b=G7gYml8dmiEYly+hsWDEJkbGtJsKpyLr2bmYQH7r+pHbSZBANaq3j/K1PRU8rlVMTG
         zpOd1VFgDUX7J6RvXrbCyRUOO5bPURbgl18lr7YyP9y0LObLswmSte7COLutEbl1nkKo
         mA9CAkIhzzh9JaSFgIRXG2Oc7mYX3yWSaj8wJLkmhYOhM3FwVwSSjaLSrtYTdm7BA2yF
         YhVsTtT3j8D7IEQ8BYZBTnjdJTUN6jZB5nr7einp2i5em+F7zF/kMIT+enAwnnFT7U5I
         fySbn8gjekMICzahIiA9HNkyz4TQ3erGhTI39hl6ehrKug2L2OQw5IZ8f7fLp2pRGcFL
         5x8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sp+0eoECInU2wfkdrbVWkaKUDKICynVO7ICEtzkqDx8=;
        b=TqHUX0l1rmFt3/iEMeiajdamHVw9YVzOE0XtczPWkktRC+r2NULNfztyaPzt07QAeP
         1hWPD5hgCrcjKTcbSKcX+I/al4KHgNT7v3NgTMw68Yt7j1bM5BuER1cm3VK/VokbqLNy
         BIPs7jI6mjE7abh1uqdp9+hDY5F/y4Xbd1TM5e9mRAbJXYef0b5TuGSH/tT4kLWNzWNo
         MLaPGwZV8FJX5SxAla+rpryoDEoGEKi7XV31dONUlyps3ABnpD2/5Yo76FPbUyFKi+j2
         1xPyQm1YoOaCGvZ7zBqkRc5T0jA8KlgPfIhHorYPIXtI9JsmFQftCerhepVl4eoECwlz
         kz1w==
X-Gm-Message-State: AOAM5303M/SNKknVRpT+vQbN0P57o3OP160BNd8s+sIF8TAyYYvsqUd1
        /did6AuiDVlQiq6uYxmDAzpFvAEEoJbE3QUCqnJ/eA==
X-Google-Smtp-Source: ABdhPJxveX9u51mv7LPmfFastALckkh2LfMODqyoJi+VTjmGfs3BSYZOA8O3DwAF3uqjWOfP8CxcKlinlIF/pdO11Y8=
X-Received: by 2002:a05:6e02:19cd:: with SMTP id r13mr11713421ill.89.1642436515137;
 Mon, 17 Jan 2022 08:21:55 -0800 (PST)
MIME-Version: 1.0
References: <1642432215-234089-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1642432215-234089-1-git-send-email-john.garry@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 17 Jan 2022 08:21:42 -0800
Message-ID: <CAP-5=fXONfbx6GzWaT21XzDyCcPkSR2hjEOO0ARVhwiSY5oKjA@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf: Support event alias in form foo-bar-baz
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, kjain@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com,
        zhangshaokun@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 17, 2022 at 7:15 AM John Garry <john.garry@huawei.com> wrote:
>
> Currently event aliases in the form foo-bar-baz are not supported.
>
> The HiSilicon D06 platform has uncore event aliases in that form, and
> using those aliases fail:
>
> $ ./perf list sdir-home-migrate
>
> List of pre-defined events (to be used in -e):
>
> uncore hha:
>   sdir-home-migrate
>  [Unit: hisi_sccl,hha]
>
> $ sudo ./perf stat -e sdir-home-migrate
> event syntax error: 'sdir-home-migrate'
>                         \___ parser error
> Run 'perf list' for a list of valid events
>
>  Usage: perf stat [<options>] [<command>]
>
>  -e, --event <event>event selector. use 'perf list' to list available events
>
> This series added support for such an event alias form.
>
> I am no expert on l+y, so any and all review here would be appreciated,
> especially the last patch which is marked as RFC (for that same reason).
>
> The series is based on acme perf/core @ 9bce13ea88f8.
>
> John Garry (3):
>   perf parse-events: Support event alias in form foo-bar-baz
>   perf test: Add pmu-events test for aliases with hyphens
>   perf test: Add parse-events test for aliases with hyphens

The whole set:

Acked-by: Ian Rogers <irogers@google.com>

The additional code is no worse than the existing code. The testing is
a great addition!

Thanks,
Ian

>  .../arch/test/test_soc/cpu/uncore.json        | 16 +++++
>  tools/perf/tests/parse-events.c               | 49 ++++++++++++++
>  tools/perf/tests/pmu-events.c                 | 32 +++++++++
>  tools/perf/util/parse-events.c                | 67 ++++++++++++++++---
>  tools/perf/util/parse-events.h                |  1 +
>  tools/perf/util/parse-events.l                |  2 +
>  tools/perf/util/parse-events.y                | 17 ++++-
>  7 files changed, 171 insertions(+), 13 deletions(-)
>
> --
> 2.26.2
>
