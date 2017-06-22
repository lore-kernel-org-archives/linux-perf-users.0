From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH V3 20/37] perf script: Add 'synth' event type for
 synthesized events
Date: Thu, 22 Jun 2017 11:59:30 -0300
Message-ID: <20170622145930.GS13640@kernel.org>
References: <1495786658-18063-21-git-send-email-adrian.hunter@intel.com>
 <1498040239-32418-1-git-send-email-adrian.hunter@intel.com>
 <20170621135145.GO13640@kernel.org>
 <66cdc4e6-58a4-e365-8a76-112daf71baf9@intel.com>
 <20170621172911.GQ13640@kernel.org>
 <0d5f93ef-f5c9-5185-c1f6-f176f8f533ea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752015AbdFVO7h (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jun 2017 10:59:37 -0400
Content-Disposition: inline
In-Reply-To: <0d5f93ef-f5c9-5185-c1f6-f176f8f533ea@intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, David Ahern <dsahern@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Em Wed, Jun 21, 2017 at 11:20:03PM +0300, Adrian Hunter escreveu:
> On 06/21/2017 08:29 PM, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jun 21, 2017 at 07:41:04PM +0300, Adrian Hunter escreveu:
> >> PERF_TYPE_ is dynamically allocated above PERF_TYPE_MAX for PMUs.  Presently
> >> perf_pmu_register() calls idr_alloc() with end=0 which limits the allocation
> >> to INT_MAX.

> > Oh, forgot about that, guess a comment right beside PERF_TYPE_MAX is in
> > demand :-\

> > So why not:

> > /*
> >  * PERF_TYPE_ is dynamically allocated above PERF_TYPE_MAX for PMUs.  Presently
> >  * perf_pmu_register() calls idr_alloc() with end=0 which limits the allocation
> >  * to INT_MAX.
> >  */
> > #define PERF_TYPE_SYNTH		(INT_MAX + 1L)

> > I.e. wouldn't be some arbitrarily huge value, but one right after what
> > was defined as the area for the dynamicly allocated PERF_TYPE_
> > "namespace" for PMUs, right?
 
> That seems fine.  Pedantically it should be (INT_MAX + 1U) otherwise it will
> be negative on a 32-bit system.

oh, not pedantic at all, thanks for the fix, will update your patch and
continue from there, Ingo already pulled everything up to this point,
btw.

- Arnaldo
