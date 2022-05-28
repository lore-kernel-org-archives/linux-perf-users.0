Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080F2C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 28 May 2022 14:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbiE1OCo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 28 May 2022 10:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiE1OCj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 28 May 2022 10:02:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6AD2B0;
        Sat, 28 May 2022 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U07sO7SnZ67NiBgTLFUgO43jJrP4Z757k3BgtolhiXA=; b=rdJZnU9mlwajkDcwArDLCE8Ewv
        DlggkLoXA49vLIC5lYQrnX849yR43s2ifqBcA95Axh3793OR1lcQ83rk7GgTVF7ZrJ4iTzkUEgDfZ
        30ecJs6RrXTsiaBbIr5EZD6cWkLvZ0i8NZBOoPI8ZW45zkN/4SunFUJ7hXCuWGQbVeaM0C976dxiM
        aOl81mTX3vAmzdBabG/EkBmm7P7CTq7qsmA7XvCh90sJm4C5hMc6HTRN4P8C42+7Skdgk8Yosj/dN
        bvjaK8YTWn7j1mrIg8Tlst6hOPq+EEzU7Aq2DNoxx/qR2AYHo2s+iAJHBp1tEySPbWOSRGUATkqxq
        HImDCLMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nux0w-002uGk-Ey; Sat, 28 May 2022 14:01:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17CCC980DC1; Sat, 28 May 2022 16:01:58 +0200 (CEST)
Date:   Sat, 28 May 2022 16:01:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>, perry.taylor@intel.com,
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
Message-ID: <YpIrVSGH314djkh9@worktop.programming.kicks-ass.net>
References: <20220527040407.4193232-1-irogers@google.com>
 <YpCeo6APNtXvrTPJ@hirez.programming.kicks-ass.net>
 <76dce5d3-6c69-e403-c4d9-f882967a4467@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76dce5d3-6c69-e403-c4d9-f882967a4467@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, May 27, 2022 at 07:54:19AM -0700, Andi Kleen wrote:

> > This all seems bonghits inspired... and perf actually does expose the
> > tsc frequency. What do you think is in perf_event_mmap_page::time_* ?
> 
> 
> That's not really available to perf stat, which is the primary metrics user.

Why not? You can mmap any perf-fd (even software events) and these
fields should be filled out.

It should work on any x86 CPU that has a TSC. The only caveat is that
the kernel must not have marked the TSC unstable.

It could even work for virt -- all you need is for virt to use
native_sched_clock() instead of the paravirt nonsense.
