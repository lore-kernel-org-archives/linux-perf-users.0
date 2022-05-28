Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02718C433F5
	for <linux-perf-users@archiver.kernel.org>; Sat, 28 May 2022 15:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbiE1Pkq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 28 May 2022 11:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237805AbiE1Pkp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 28 May 2022 11:40:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD72417E24;
        Sat, 28 May 2022 08:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=raIeKlSNrDXKcGAZNA1Wi607LJfguWIntg7t2NTDT6M=; b=IWxpxjdX5iE9ZgGsLmhtg4M4CH
        vH/pGfaYquhHc8sshNukZNP4RSGaGcUORANzG+7DvofGt8mi1UE8qQmrARdgxTpgYMI5LQ1Cddimp
        +3+KFTStRV2FpDyn02LUuhImPCyrDxCYtFS9kto1Xa55IP0B13e3SoJ22Gf2O4s9IRnoT7F04i2cJ
        sxVyEL0HK25o1q/eNcBb4j3hVO05QjT3EvO+X+ig/mVchAOCHiEsB7mY6QRJX1LL6iId7ye0wb6Mt
        /hKdxWcjA9vyHDM9HxOhgdRvXHpvQS5VLE/mCLqPxjr/8OC76KoVs0/hfNWwadlHoQtcY5nP++GTD
        L2EppRjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuyXs-002xVY-9v; Sat, 28 May 2022 15:40:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD2A630022C;
        Sat, 28 May 2022 17:40:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C8AB0207C0205; Sat, 28 May 2022 17:40:00 +0200 (CEST)
Date:   Sat, 28 May 2022 17:40:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] perf metrics: Add literal for system TSC frequency
Message-ID: <YpJCUM08I6mRkho/@hirez.programming.kicks-ass.net>
References: <20220527040407.4193232-1-irogers@google.com>
 <YpCeo6APNtXvrTPJ@hirez.programming.kicks-ass.net>
 <76dce5d3-6c69-e403-c4d9-f882967a4467@linux.intel.com>
 <YpIrVSGH314djkh9@worktop.programming.kicks-ass.net>
 <CAP-5=fWwG+Gt+E7M8EYuDhgrvfUQLbP7ODn18r_axshqKxwuYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWwG+Gt+E7M8EYuDhgrvfUQLbP7ODn18r_axshqKxwuYA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, May 28, 2022 at 07:50:40AM -0700, Ian Rogers wrote:
> On Sat, May 28, 2022 at 7:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, May 27, 2022 at 07:54:19AM -0700, Andi Kleen wrote:
> >
> > > > This all seems bonghits inspired... and perf actually does expose the
> > > > tsc frequency. What do you think is in perf_event_mmap_page::time_* ?
> > >
> > >
> > > That's not really available to perf stat, which is the primary metrics user.
> >
> > Why not? You can mmap any perf-fd (even software events) and these
> > fields should be filled out.
> >
> > It should work on any x86 CPU that has a TSC. The only caveat is that
> > the kernel must not have marked the TSC unstable.
> >
> > It could even work for virt -- all you need is for virt to use
> > native_sched_clock() instead of the paravirt nonsense.
> 
> It will at least fail if inherit is enabled, no?

For per-task events, yes, I suppose it will. I'd forgotten about that
restriction on perf_mmap() :/
