Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313AB33A015;
	Thu, 21 Aug 2025 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783327; cv=none; b=pY18knpDwI3Vl7GC5bDHtMgvnvQWVT9mBXKW/a1Z/b11pCSFLGybxO3TtXGVnk1EjfnrlqdPUjYB3KsUapI012KNsHQZqgnPEB+pSB3J0CfAftRNDjDumgmU/Y4uCe9imP2Lc1LSQHgLGhBZ4LCPQSX5iCdev2aRRLHk821m6lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783327; c=relaxed/simple;
	bh=w7nIIDkRK9t5nLFkzgF1a+WYngfQaEmyXr2OHfJvdak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBZgDpumM7eYNBeJzmIU4HfsZwZvNREWHycU63KL5wKAY7Yskr7xd7g795XyjL1NdRbg+ofstbh2BYHo6EAtYkhfqDd7UrcDY25yHLqueKgmus2kQnx+6vfz7sH73hQ8xnewOI9JdOFdc9zCurtx2J0YcqIHsXH7r25RqdG+H5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M6v/z7bN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M6v/z7bN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b//6ITwUdDd18oQHJucKsAo4DJTBu0O+Y4/SsZ6tjY0=; b=M6v/z7bNxTDGdWvzEQNNazzGYh
	0LDod8tbH4YCxdVYtkY2euXXbWX7lBRiQS/7z2cQGwzz7F4nmJQAt5SuALER8Pr99BHH9D3CuxhOD
	T+mY8NTehTJuPcfe8pPr8GAl+aL/+6W8GTbVJ1pVSSyQE7NsIyPEQSZBrudpbcln3hkv8OYceZjld
	ik9orMzkaP9ThNsvAKZoq7nnmTyTgfVSwFGNsg5WxvEdPaTFFxxE3iJZd/nNY3yuZRbNG38R+r4mg
	0vT1NRd0cpwfxt5ZdbGiIRus64ep2sZM5x8FNZh8j7+JPJB/aVf1jEJmEo9O8GV6aw/VULg5Iq472
	fI4B0zVQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up5Rk-00000000ZYq-00wv;
	Thu, 21 Aug 2025 13:35:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F1F1F3002ED; Thu, 21 Aug 2025 15:35:14 +0200 (CEST)
Date: Thu, 21 Aug 2025 15:35:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [Patch v3 3/7] perf/x86: Check if cpuc->events[*] pointer exists
 before accessing it
Message-ID: <20250821133514.GP4067720@noisy.programming.kicks-ass.net>
References: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
 <20250820023032.17128-4-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820023032.17128-4-dapeng1.mi@linux.intel.com>

On Wed, Aug 20, 2025 at 10:30:28AM +0800, Dapeng Mi wrote:
> When intel_pmu_drain_pebs_icl() is called to drain PEBS records, the
> perf_event_overflow() could be called to process the last PEBS record.
> 
> While perf_event_overflow() could trigger the interrupt throttle and
> stop all events of the group, like what the below call-chain shows.
> 
> perf_event_overflow()
>   -> __perf_event_overflow()
>     ->__perf_event_account_interrupt()
>       -> perf_event_throttle_group()
>         -> perf_event_throttle()
>           -> event->pmu->stop()
>             -> x86_pmu_stop()
> 
> The side effect of stopping the events is that all corresponding event
> pointers in cpuc->events[] array are cleared to NULL.
> 
> Assume there are two PEBS events (event a and event b) in a group. When
> intel_pmu_drain_pebs_icl() calls perf_event_overflow() to process the
> last PEBS record of PEBS event a, interrupt throttle is triggered and
> all pointers of event a and event b are cleared to NULL. Then
> intel_pmu_drain_pebs_icl() tries to process the last PEBS record of
> event b and encounters NULL pointer access.
> 
> Since the left PEBS records have been processed when stopping the event,
> check and skip to process the last PEBS record if cpuc->events[*] is
> NULL.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202507042103.a15d2923-lkp@intel.com
> Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> ---
>  arch/x86/events/intel/ds.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index c0b7ac1c7594..dcf29c099ad2 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2663,6 +2663,16 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>  			continue;
>  
>  		event = cpuc->events[bit];
> +		/*
> +		 * perf_event_overflow() called by below __intel_pmu_pebs_last_event()
> +		 * could trigger interrupt throttle and clear all event pointers of the
> +		 * group in cpuc->events[] to NULL. So need to re-check if cpuc->events[*]
> +		 * is NULL, if so it indicates the event has been throttled (stopped) and
> +		 * the corresponding last PEBS records have been processed in stopping
> +		 * event, don't need to process it again.
> +		 */
> +		if (!event)
> +			continue;
>  
>  		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
>  					    counts[bit], setup_pebs_adaptive_sample_data);


So if this is due to __intel_pmu_pebs_last_event() calling into
perf_event_overflow(); then isn't intel_pmu_drain_pebs_nhm() similarly
affected?

And worse, the _nhm() version would loose all events for that counter,
not just the last.

I'm really thinking this isn't the right thing to do.


How about we audit the entirety of arch/x86/events/ for cpuc->events[]
usage and see if we can get away with changing x86_pmu_stop() to simply
not clearing that field.

Or perhaps move the setting and clearing into x86_pmu_{add,del}() rather
than x86_pmu_{start,stop}(). After all, the latter don't affect the
counter placement, they just stop/start the event.

