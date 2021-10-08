Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC70C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 02:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3496461075
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 02:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhJHDBx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 23:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhJHDBw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 23:01:52 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F67AC061570
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Oct 2021 19:59:58 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 5so9050697iov.9
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 19:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r1A8V1SEkH/lgI3j7mtHzdXO5tdn/QGpiavQnC667ps=;
        b=BuDcIVCUPKw/J6k1BK4QvJ25qg/hxNSNa7Kwl33LotoPUvuP37oMA0UyupjuAsSdiS
         LQr7Msib/WTxkJk7aQVmLng/QxqzCxI3Yhe3p2pMeNHR0H939jtID6xhf586c3AWGF5Q
         dlE++26KGf81fy0OkkxWhYPybu+4RQmOrsE6YRFon/1/HS+kLFGxmt/E/fgiSZLeBrLr
         wxoao5Wnq5qlxj67ZzUliSJXnRC7aJ2NmWvcib4acZVwZ5TKXfjii0fEJe3fl0lFw7Gr
         XnwPSbqoNJqUIv57I3zarFIMSMRKMYBHkQfbsB+7M0XQa3ShyxuAaumNUPElmhNqYumB
         bhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r1A8V1SEkH/lgI3j7mtHzdXO5tdn/QGpiavQnC667ps=;
        b=4VdvPQah1jFk0WbYFaUUfHOpo4eQjiLW4louACi55xp5q9IfEw9YEbPqr1KZZVtGmD
         EX97X/e42JJLsxfNzRBWDA4tUTG27Ytw/Va+HSSaSQ7EtMA2/RcWfVKb24+OAHxODHR6
         Q2feK/cQ4E6d/ZgVV4i/Zgxik1vbR1hZjmhlhJVyspcJRAiAdlslueiuF994UEDxV4rf
         cC1Hag7c1iE0andNxeq8R2tU6pDG0pCxvFoDXYB63bcxorwDPhd6mYKMMtTh8z0dxYSU
         mBic2x5AWU6a2w+aTaG5LpuZJ447J1JG1WTG4cDXEfG7vTzC8MVjv6gawmicDfgXL81X
         nlnA==
X-Gm-Message-State: AOAM532gtOC7sNnITmSvUzUvd9IYa9DGw1iSMA1TP7eUD0NRxMo6nzWi
        MHssnIU9nNgtExSmKPaBVIOTWI68dr1nUHGdLhv4ig==
X-Google-Smtp-Source: ABdhPJzKayBac8enrF14boYvvNz88G1CeLaHz0A5Pi5pd/TXk2S64own4BgBKUiPBud+8LJPhSz6HH1xUqshAGDUxro=
X-Received: by 2002:a02:662d:: with SMTP id k45mr5284836jac.14.1633661995993;
 Thu, 07 Oct 2021 19:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211004160008.21645-1-andrew.kilroy@arm.com> <b7a4a1b3-3d22-7a52-75b1-66c04b57a50c@huawei.com>
 <0743bf83-2e5d-8830-61bc-ed0731db108d@arm.com> <83767166-e379-a352-d920-ad8b6e923800@huawei.com>
 <b24041af-1c92-3855-9659-133e73a0c241@linux.intel.com>
In-Reply-To: <b24041af-1c92-3855-9659-133e73a0c241@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 7 Oct 2021 19:59:42 -0700
Message-ID: <CAP-5=fXuzH9Gh8=CP9E=vb7sDSL5TO-8_pPvfQz4p61jUQEPmQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf vendor events: Syntax corrections in Neoverse N1 json
To:     Andi Kleen <ak@linux.intel.com>
Cc:     John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 7, 2021 at 5:03 PM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 10/6/2021 9:26 AM, John Garry wrote:
> > On 06/10/2021 09:43, James Clark wrote:
> >
> > + Andi
> >
> >>
> >>
> >> On 05/10/2021 11:10, John Garry wrote:
> >>> On 04/10/2021 17:00, Andrew Kilroy wrote:
> >>>> There are some syntactical mistakes in the json files for the
> >>>> Cortex A76
> >>>> N1 (Neoverse N1).  This was obstructing parsing from an external tool.
> >>>
> >>> If the trailing comma is not allowed by standard, then maybe we
> >>> should fix our parsing tool to not allow it also. However maybe
> >>> there is a good reason why we allow it..
> >>
> >> It would be nice to do, because I have also made similar fixes
> >> before. We looked at the STRICT option
> >> in the parser (https://github.com/zserge/jsmn), but even then it
> >> seems to allow trailing commas.
> >>
> >> Trailing commas are not allowed in the json standard, but there is a
> >> split between parsers
> >> where some allow it and others don't. Specifically the Python parser
> >> doesn't allow it, and Python
> >> can easily be involved in some workflow that parses these files.
> >>
> >> The only way forwards I can think of is either getting a change
> >> accepted upstream to the parser
> >> and then updating it in perf, switching to a different parser, or
> >> doing some hack to add an extra
> >> step in perf to look for commas. None of which sound ideal.
> >>
> >
> > Looking at the license in jsmn.c, we seem to be ok to modify it (to
> > error on non-standard trailing ',') - that parser has already
> > apparently been modified in mainline.
> >
> > If we do that then I hope that there are not to many violations in out
> > JSONs, including downstream.
>
>
> Sure we can modify the file. I already did some minor changes when I
> submitted it originally.
>
> -Andi

jsmn is a somewhat frustrating way to work on json code and working on
a forked version of jsmn was frustrating in [1]. Could we assume
python on build systems and rewrite jevents in python?

Thanks,
Ian

[1] https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/
