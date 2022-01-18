Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE9DC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 Jan 2022 11:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbiARLkR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 Jan 2022 06:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239489AbiARLkQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Jan 2022 06:40:16 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E16C06161C
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Jan 2022 03:40:16 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id c3-20020a9d6c83000000b00590b9c8819aso23736944otr.6
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Jan 2022 03:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYGWZCJtnfIL0hu+yeMxYhxnO6RLRB9uj48XOeWHa+E=;
        b=Q5fKoiAyjwUL1QxZfAc9NP29WkhOZF1YyACXXj9RueWaHi1dGO1SDcRVPhWHOX+uB4
         Zzl98rgrLBmOmiDUIegtvVXAzoj0kSvJRAxElWdxHFsjPKHkRvqGiIr36L0h5TLs8iGG
         G79LUMDyEQRi16YMC2sKEFHp7PtaYkJP1UgQHZWdEjmx8SmT9X0Qem4bqV8TarcKleu+
         3O4IO9IZ5Mz8BFqCfanItjYI8K8LGOVgs08yAqtCaDjRA1sgv0N5Cwd328OOH4YS+vOa
         9SjM4TPlpY+yljiyqoDppUXKc8ef0TJvhdySV0z2XXRRhhNNpJblm1GJ7xInxOCDvqE5
         OHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYGWZCJtnfIL0hu+yeMxYhxnO6RLRB9uj48XOeWHa+E=;
        b=mPJhCYUbtyiufmd6G86FrrCdWoCFdYBAY2aIBZUHOPEfem9yRnz698tAB0Sg4gRp8L
         sk2VDI/zX9RZa6CxvgXHWvuoGeD1+6XAv2xF6jvt9wWzJfooYLyk/uifjQLAXiG+PBdi
         7vAApSreexeVa6Kk+WvM+lnn/CwaRezQw5LET2zT/NPSdjvejwRjPrDVckXSZy7HIAXL
         10t8TXxxAR6xL/GhQbrh1J9V1xfj7faH4WDdlFzjbJwz0AJK5rxIsMWD8iOtyDxmTEs9
         tubkCRhLL6sCYHaW20zxYZhymrA+F3OE6QoMZ2MiOKuAJ17RDlfBdzfEHixCEF9Pfgbd
         0UHw==
X-Gm-Message-State: AOAM530v+ZYTQ8WLpKKWHOilXawUQKUFjBwIXT9k/aL8dXuTTSiIdlYy
        +pZQKzy+zdahvCzbT98VIz2ZbsMQ9o8rRl6aj7ugog==
X-Google-Smtp-Source: ABdhPJw0SRdiEUCu/e6KV+EnYwSn5ooQpcjSojjZx+2jX9yTxj9BW1Q4L3w0ENbYRu/QYUSM6YmcN9ng4iuOb8zbBl4=
X-Received: by 2002:a9d:58c7:: with SMTP id s7mr5124688oth.246.1642506015453;
 Tue, 18 Jan 2022 03:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20211216151454.752066-1-tmricht@linux.ibm.com>
 <CANpmjNNMWtjcKa961SjEvRbbPXyw5M5SkrXbb3tnyL3_XyniCw@mail.gmail.com>
 <90efb5a9-612a-919e-cf2f-c528692d61e2@huawei.com> <20220118091827.GA98966@leoy-ThinkPad-X240s>
In-Reply-To: <20220118091827.GA98966@leoy-ThinkPad-X240s>
From:   Marco Elver <elver@google.com>
Date:   Tue, 18 Jan 2022 12:40:04 +0100
Message-ID: <CANpmjNMPoU+1b1fKFuYDYwisW2YfjQHxGt5hgLp1tioG7C2jmg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Test 73 Sig_trap fails on s390
To:     Leo Yan <leo.yan@linaro.org>
Cc:     John Garry <john.garry@huawei.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 18 Jan 2022 at 10:18, Leo Yan <leo.yan@linaro.org> wrote:
>
> On Mon, Jan 17, 2022 at 03:39:10PM +0000, John Garry wrote:
> > On 16/12/2021 15:48, Marco Elver wrote:
> >
> > +
> >
> > > On Thu, 16 Dec 2021 at 16:15, Thomas Richter<tmricht@linux.ibm.com>  wrote:
> > > > In Linux next kernel
> > > > Commit 5504f67944484 ("perf test sigtrap: Add basic stress test for sigtrap handling")
> > > > introduced the new test which uses breakpoint events.
> > > > These events are not supported on s390 and PowerPC and always fail:
> > > >
> > > >   # perf test -F 73
> > > >   73: Sigtrap                                                         : FAILED!
> > > >   #
> > > >
> > > > Fix it the same way as in the breakpoint tests in file
> > > > tests/bp_account.c where these type of tests are skipped on
> > > > s390 and PowerPC platforms.
> > > >
> > > > With this patch skip this test on both platforms.
> > > >
> > > > Output after:
> > > >   # ./perf test -F 73
> > > >   73: Sigtrap
> > > >
> > > > Fixes: 5504f67944484 ("perf test sigtrap: Add basic stress test for sigtrap handling")
> > > >
> > > > Cc: Marco Elver<elver@google.com>
> > > > Signed-off-by: Thomas Richter<tmricht@linux.ibm.com>
> > > Acked-by: Marco Elver<elver@google.com>
> > >
> > > Thanks, and sorry for missing this case!
> > >
> >
> > I am finding that this test hangs on my arm64 machine:
> >
> > john@debian:~/kernel-dev2/tools/perf$ sudo ./perf test -vvv 73
> >  73: Sigtrap:
> > --- start ---
> > test child forked, pid 45193
>
> Both Arm and Arm64 platforms cannot support signal handler with
> breakpoint, please see the details in [1].  So I think we need
> something like below:
>
> static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> {
>         ...
>
>         if (!BP_SIGNAL_IS_SUPPORTED) {
>                 pr_debug("Test not supported on this architecture");
>                 return TEST_SKIP;
>         }
>
>         ...
> }
>
> Since we have defined BP_SIGNAL_IS_SUPPORTED, I think we can reuse it at
> here.
>
> [1] https://lore.kernel.org/lkml/157169993406.29376.12473771029179755767.tip-bot2@tip-bot2/

Does this limitation also exist for address watchpoints? The sigtrap
test does not make use of instruction breakpoints, but instead just
sets up a watchpoint on access to a data address.

Thanks,
-- Marco
