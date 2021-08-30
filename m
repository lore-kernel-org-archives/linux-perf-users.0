Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BCFC432BE
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Aug 2021 08:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8501161027
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Aug 2021 08:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhH3IxT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 Aug 2021 04:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbhH3IxT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Aug 2021 04:53:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3203C061575;
        Mon, 30 Aug 2021 01:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TGgrN/B0XD/DChleER3ZB1D526KLmomMww/bQlzMToQ=; b=pjZqlfF7WVcNo52wNqLl+hKAnc
        Y2RvaotywmdFq6A5yDmYBHUcECw9SY1x1nvSqVeu7isAwuejrRc0844Qf9na6ef+rBExK36qRjf/+
        FzYPKvjDyKJE06eTJE29ByVEeQcaQYyqJNMkagiB+sLBNLXIKPsYAV9pHElqQ7B07NpFwIWJvewIc
        NuJBJGDhghCQ9HdLolkRJFky/ykNPXyxf4NkoeOUgee/vaJyvsRV/Ct0StJSCVm1NV5LQU89/XocC
        pfZ0rd/UwmTNyZoddosD/B6+fLuCPgNSNJX8XGRSx3J+gYN30fOz54FfgAsljD1DMx7hQ6Wfp2F1L
        xnRT4N7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKd0V-00HWhD-QA; Mon, 30 Aug 2021 08:51:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4352098176A; Mon, 30 Aug 2021 10:51:06 +0200 (CEST)
Date:   Mon, 30 Aug 2021 10:51:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Andy Lutomirski <luto@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC 2/3] perf/x86: Control RDPMC access from .enable() hook
Message-ID: <20210830085106.GF4353@worktop.programming.kicks-ass.net>
References: <20210728230230.1911468-1-robh@kernel.org>
 <20210728230230.1911468-3-robh@kernel.org>
 <d720903c-926e-f57a-0862-4e5d76db763a@kernel.org>
 <CAL_JsqLRv9ugKJcn4dq_ps0JMt74Y7PKA=5yySYxvftdQWzzPA@mail.gmail.com>
 <de97454b-9b4d-492f-a435-6a5e33889219@www.fastmail.com>
 <CAL_JsqKpT93W6nBj68DykEJzjFYOPG=8PGShsh2QZVzHq5N3fQ@mail.gmail.com>
 <43b3a838-da8a-4733-9832-f3d5f990ec13@www.fastmail.com>
 <f3b72c71-f9c9-e1a8-4542-e248e8a5d769@maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3b72c71-f9c9-e1a8-4542-e248e8a5d769@maine.edu>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Aug 29, 2021 at 11:05:55PM -0400, Vince Weaver wrote:

> as the author of those perf_event tests for rdpmc, I have to say if ARM 
> comes up with a cleaner implementation I'd be glad to have x86 transition 
> to something better.
> 
> The rdpmc code is a huge mess and has all kinds of corner cases.  I'm not 
> sure anyone besides the PAPI library tries to use it, and while it's a 
> nice performance improvement to use rdpmc it is really hard to get things 
> working right.
> 
> As a PAPI developer we actually have run into the issue where the CPU 
> switches and we were reporting the wrong results.  Also if I recall (it's 
> been a while) we were having issues where the setup lets you attach to a 
> process on another CPU for monitoring using the rdpmc interface and it 
> returns results even though I think that will rarely ever work in 
> practice.

There's just not much we can do to validate the usage, fundamentally at
RDPMC time we're not running any kernel code, so we can't validate the
conditions under which we're called.

I suppose one way would be to create a mode where RDPMC is disabled but
emulated -- which completely voids the reason for using RDPMC in the
first place (performance), but would allow us to validate the usage.

Fundamentally, we must call RDPMC only for events that are currently
actuve on *this* CPU. Currently we rely on userspace to DTRT and if it
doesn't we have no way of knowing and it gets to keep the pieces.
