Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36F4C49EA2
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 08:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C706B611B0
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 08:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFUIYa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 04:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFUIY3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 04:24:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DF1C06175F
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jun 2021 01:22:15 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id bb20so5315552pjb.3
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jun 2021 01:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gqd3O4ne1dNUetj8IOBDVEDjIC1vEw62dq7UiJ0rgTM=;
        b=P5DIJiYcaFv2PfJZNbczzivYyCCQ9u7w3i/vH90+0mTyRL8r0HLL2Pd7w/RbaVUAZG
         ucSIEnU4YgKWml+P3z4z4Gc3qujHL7jSo/JfLdH1jGjlMXfQuZNoWbPF8gWWqly7PDSa
         aFaROk04qJwKB56IRCweNyqXZCaqIPlAP9CI0u2tm3mxZNnw6exFVtzEOvUvaBXwBqxb
         wu+hLeum0CH3GVeEAtUJ81WGcSMx8vXl7oEL3V1+mrQEaS/JtjL/5vYj5T+BtAzizdL4
         toDaLFGkRDYIHX8yL7Dfdm7yUra6/gzzVOpQGabfKhy1gGKPie9uDp3UxOKTmuJIgiby
         d1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gqd3O4ne1dNUetj8IOBDVEDjIC1vEw62dq7UiJ0rgTM=;
        b=NdyRGolF5YHvSgSUanRBWVddcJkoHVW3mCWHRzTstn04CNesdg2CelsWMexYB/ohV5
         6O6+HeBhkcGGU8Kszr2IimxjS0NqIQXGjJpmhXquXg95BfbPqCTg9mTYT0ToSN9WX6a3
         pnDcJSLow5QJTtTF2tmmA3rzGOqnMI3Yiv3oZfbivsTQqwLywcOw2HvNJ00eFJvz3e5m
         n4hLi7YSgYR8KCCqqlDWVA88Z1C1jX/cNJM5b8+QB96vGH0OLeQ+Ju1X5+wOuuStKAHJ
         XveZsSHNPZhrzMdfQrIL/yUzIIRNB7MfZWOHbhUVA2ujXUgyBGpseibB1Z7TdRkTsJeu
         H4YQ==
X-Gm-Message-State: AOAM530ezPV/CwoONINW/GiaDgr1znV1WUpVjWXBcYa3FksUPCqfBzlt
        F74NHC9QNgzJs1TnkMTApn+sxehgvHofnH0Ah6XFqg==
X-Google-Smtp-Source: ABdhPJwm9dF6HvcKy6dVJDn+aQMg1MuHWfIcw7Np2YEgLInhtBmcV4IDOEML8eNuAt0mxQzlgpuCNXuEVLpBe/VG5ww=
X-Received: by 2002:a17:90b:300c:: with SMTP id hg12mr28711402pjb.46.1624263734484;
 Mon, 21 Jun 2021 01:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210528161552.654907-1-leo.yan@linaro.org> <CAOYpmdEvkSZaei-_SWrUC4YJ7rOUOoOaxM7+qc6dw=P+b_ivgA@mail.gmail.com>
 <5cf3effb-fccc-9385-6328-6d1e2e5ccdf3@arm.com> <CAOYpmdE=pSaDGOm+4iCh611DXVD766eCr5dACQ+TgOnSO=4EOA@mail.gmail.com>
 <20210612032721.GB36748@leoy-ThinkPad-X240s>
In-Reply-To: <20210612032721.GB36748@leoy-ThinkPad-X240s>
From:   Denis Nikitin <denik@google.com>
Date:   Sun, 20 Jun 2021 22:21:57 -1000
Message-ID: <CAOYpmdGW0U9u7zW3G6jyhZA23Uk1kd5gT00e9+g4O=k=WybDGA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] coresight: Fix for snapshot mode
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Leo,

On Fri, Jun 11, 2021 at 5:27 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> On Fri, Jun 11, 2021 at 01:31:41AM -0700, Denis Nikitin wrote:
> > Hi Suzuki,
> >
> > On Thu, Jun 10, 2021 at 9:04 AM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> > >
> > [...]
> > >
> > > Are you able to confirm if the patch 3 alone fixes the above issue ?
> > > I am not convinced that Patch 1 is necessary.
> > >
> >
> > Yes. "perf cs-etm: Remove callback cs_etm_find_snapshot()" alone fixes
> > the issue.
>
> Based on current testing result, we should give high priority for
> patches 2 and 3.
>
> The patch 1 is controversial for how to handle the trace data kept
> in multiple AUX buffers; essentially it's up to how we understand the
> snapshot definition.  I confirmed Intel-PT and CoreSight have the same
> behaviour for capturing trace data from multiple AUX ring buffers when
> snapshot occurs.
>
> I'd like to leave patch 1/3 out, and resend it if we get conclusion.
> At the meantime, @Denis, if you have observed any profiling result
> (or profiling quality) difference caused by patch 1, the feedback would
> be very valuable.


I evaluated AutoFDO profiles with benchmarks but I was only focused
on the system-wide mode. And as I understood patch 1 fixes the issue
in non system-wide mode.
Currently I'm OoO so I won't be able to do further evaluation.

- Denis

>
>
> Thanks a lot for Denis' testing and insight review from Suzuki!
>
> Leo
