Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62C1C11F67
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 21:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DEB061416
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 21:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbhGAVf6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 17:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhGAVf6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 17:35:58 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DBAC061764
        for <linux-perf-users@vger.kernel.org>; Thu,  1 Jul 2021 14:33:27 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id t12so7808692ile.13
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jul 2021 14:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tc7gbn3Ftt/4NIeXEIEA6HpsChZKnl2aVzWD/EIv0TM=;
        b=ijw8xLNjGCINxCvnMakX8PDxs6krlcvVIattltygR45dT84xYpmio/o7WAEfbMunJA
         dETSqm6ef9MteDT0aXyi6FZhORuQI7vN+ZA/6VjY877yeDLk72JwFUoq6umQg9LJsgLI
         kTPKsvc5JiiiAJ4M6vy3NTRZMh6mk9xtVYomraNn5T1OORcs6kuKAbfNoZi24eTW/yVL
         pSsaQ2bgWeHuul1ijWubHn3klzx8SH3geqbazGn70JZ6QHr9dNck1cm3oiBBJHcwpnoc
         JXeWQqCScXVGSY9yVcs3NEPQS0SFP9ZrUr+tDyOfyGzE0K8idwQujCh+95kAfutACkPy
         slCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tc7gbn3Ftt/4NIeXEIEA6HpsChZKnl2aVzWD/EIv0TM=;
        b=oJUH6YMiJbCCOhgO326rWtz7Z8LdHI34KdPH3BBlTIhKH0TdyAZlSZ58m3MzljCoLf
         bX0iRnudFz+C6MopmAgLQXXEldsByCrd4dTtkOIMVQ6Dj5YeDNzuXSf/Nl1qjHGdg0vc
         4zvcVOyp9cuTxhEi1JUp2pT2IvAXpsajW8oveoCfZNxSQySqocwO1AiF1po3o6IO9E0q
         5cQ3XMiSIsx6SXaV44vsb2JVsqahZ9gxBquIIhx+eO0RfmMsVK5iVVbALDnURy4N1H2j
         E14sVQzbDhiiUQyQ0nf9GnGByZtSfNP6Y7RrbOP7zt21bBMa8Iss/nNRoeuyvzUlDpVn
         xDWg==
X-Gm-Message-State: AOAM5327ji9Yjy5G8BgQT2oWqAD6Dnt4vEO9zt+h+NWzGk4x7Jg/O8ju
        fhgDotTdvon/+Uuu4ZtD1sAjdcmEn9jh8DtXotOYRQ==
X-Google-Smtp-Source: ABdhPJyqwQFS2DJ9sd+9rwuufJk+LsP76x3pz66cDOie6yeWh0RdRT0fXyaOwJ+2rDZqidB+kHpzVFrxJNuseEyFLKw=
X-Received: by 2002:a05:6e02:921:: with SMTP id o1mr1104988ilt.57.1625175206943;
 Thu, 01 Jul 2021 14:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210609130421.13934-1-james.clark@arm.com> <20210614155442.GA396617@p14s>
 <YN34LlxuaNo60CGu@kernel.org>
In-Reply-To: <YN34LlxuaNo60CGu@kernel.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 1 Jul 2021 15:33:15 -0600
Message-ID: <CANLsYkzH-OMr0Qo7L-Ush1nZuqhOAfocawHnVPAP8NcXk1K1Lg@mail.gmail.com>
Subject: Re: [PATCH] perf cs-etm: Delay decode of non-timeless data until cs_etm__flush_events()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        Coresight ML <coresight@lists.linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Al Grant <al.grant@arm.com>,
        Branislav Rankov <branislav.rankov@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 1 Jul 2021 at 11:15, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Mon, Jun 14, 2021 at 09:54:42AM -0600, Mathieu Poirier escreveu:
> > On Wed, Jun 09, 2021 at 04:04:20PM +0300, James Clark wrote:
> > > Currently, timeless mode starts the decode on PERF_RECORD_EXIT, and
> > > non-timeless mode starts decoding on the fist PERF_RECORD_AUX record.
> > >
> > > This can cause the "data has no samples!" error if the first
> > > PERF_RECORD_AUX record comes before the first (or any relevant)
> > > PERF_RECORD_MMAP2 record because the mmaps are required by the decoder
> > > to access the binary data.
> > >
> > > This change pushes the start of non-timeless decoding to the very end of
> > > parsing the file. The PERF_RECORD_EXIT event can't be used because it
> > > might not exist in system-wide or snapshot modes.
>
> <SNIP>
>
> > This looks good to me but I'd like to have other people testing it.
>
> So Leo reviewed and tested this, I'm taking your "looks good to me" as
> an Acked-by, as per Documentation/process/submitting-patches.rst.
>

Yes, please.  My goal here was to wait for other people to test this
code, which Leo did.

> - Arnaldo
>
> > Thanks,
> > Mathieu
