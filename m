Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C4B3431F0;
	Thu,  6 Nov 2025 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438759; cv=none; b=YO8P0vTLEfoYMRl6OyJEqyJOwKq04b4EqOljV8xHhZNJaGyLJbV6ZYhkjl6b2SHySgM9+alMgZDXndieUa1z0pQuNdeQmEEPbrnMhV8b2vEmkow5jHHWd9VX0psMoXhbHJqCGl60gKgkf/NGtC7PJOoxBlr5Gu2rgjaZ/UStLdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438759; c=relaxed/simple;
	bh=mLn0+4p3ILijafzFhpHB7mnQlpQsnYUJqNK7+/2sfMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ltt/lDEfPpw04aPurtZU5AqIb+QuToo5Kx80dLmRumC8YXdhYJcblBLshgM3gRmvqk1kX4shuGra+B79X9EdgbowI9YjlKOKGHbYLCMGcLNGcSR1gi3ZIYa4ITRkvSIioyuSsX0jEH0YfVWWi5O/uX77+/yiROIlN5G5tHEHiu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hpqgo7oI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hpqgo7oI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0syKB5vEf28tdL1E/HPOl9HquzlkIgHTcTZ0SpryE6E=; b=Hpqgo7oIk/+u0QBG35ZVl8HwHv
	I5HzOYmnfcxh2Yro6NAhbK2iym6bAUPPpfAgxy8RfkHkqPjPJNCM9lW35rzVE8H7mlv5skMTr0yiC
	E+85R43xNfpeoO41cJjNOPtuihmksB9p3BcfrDKQU5tRTee5S8y/XsVNqLOZKELYG/obdMiejXbJB
	tCC522qR260kIdtpftr7i0qIx3wSxa02c3E7ST4jEA934Q+UWEagbR6KWkyXaG82gBwRrLtVY0y7W
	YZn+gApWXt9GcTzwWfTy6UyDQuBULVUiU0g3iWMoZTqRbZatkm3cg02Uxo+N8aRVzpufw0hrMUYK0
	Da8iwb/g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGzxj-00000004U7x-1Vh3;
	Thu, 06 Nov 2025 13:23:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 22E393001D4; Thu, 06 Nov 2025 15:19:07 +0100 (CET)
Date: Thu, 6 Nov 2025 15:19:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>, george.kennedy@oracle.com
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	kernel test robot <oliver.sang@intel.com>, ravi.bangoria@amd.com
Subject: Re: [Patch v9 02/12] perf/x86: Fix NULL event access and potential
 PEBS record loss
Message-ID: <20251106141907.GZ4067720@noisy.programming.kicks-ass.net>
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
 <20251029102136.61364-3-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029102136.61364-3-dapeng1.mi@linux.intel.com>


George, it just occurred to me that the below might also fix the root
cause of your 866cf36bfee4 ("perf/x86/amd: Check event before enable to avoid GPF")
and thus we can revert that again.

Specifically, this moves the clearing of cpuc->events[] out to
x86_pmu_del() time.

On Wed, Oct 29, 2025 at 06:21:26PM +0800, Dapeng Mi wrote:
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
> To avoid this issue, move cpuc->events[] clearing from x86_pmu_stop()
> to x86_pmu_del(). It's safe since cpuc->active_mask or
> cpuc->pebs_enabled is always checked before access the event pointer
> from cpuc->events[].
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202507042103.a15d2923-lkp@intel.com
> Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 745caa6c15a3..74479f9d6eed 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1344,6 +1344,7 @@ static void x86_pmu_enable(struct pmu *pmu)
>  				hwc->state |= PERF_HES_ARCH;
>  
>  			x86_pmu_stop(event, PERF_EF_UPDATE);
> +			cpuc->events[hwc->idx] = NULL;
>  		}
>  
>  		/*
> @@ -1365,6 +1366,7 @@ static void x86_pmu_enable(struct pmu *pmu)
>  			 * if cpuc->enabled = 0, then no wrmsr as
>  			 * per x86_pmu_enable_event()
>  			 */
> +			cpuc->events[hwc->idx] = event;
>  			x86_pmu_start(event, PERF_EF_RELOAD);
>  		}
>  		cpuc->n_added = 0;
> @@ -1531,7 +1533,6 @@ static void x86_pmu_start(struct perf_event *event, int flags)
>  
>  	event->hw.state = 0;
>  
> -	cpuc->events[idx] = event;
>  	__set_bit(idx, cpuc->active_mask);
>  	static_call(x86_pmu_enable)(event);
>  	perf_event_update_userpage(event);
> @@ -1610,7 +1611,6 @@ void x86_pmu_stop(struct perf_event *event, int flags)
>  	if (test_bit(hwc->idx, cpuc->active_mask)) {
>  		static_call(x86_pmu_disable)(event);
>  		__clear_bit(hwc->idx, cpuc->active_mask);
> -		cpuc->events[hwc->idx] = NULL;
>  		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
>  		hwc->state |= PERF_HES_STOPPED;
>  	}
> @@ -1648,6 +1648,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
>  	 * Not a TXN, therefore cleanup properly.
>  	 */
>  	x86_pmu_stop(event, PERF_EF_UPDATE);
> +	cpuc->events[event->hw.idx] = NULL;
>  
>  	for (i = 0; i < cpuc->n_events; i++) {
>  		if (event == cpuc->event_list[i])
> -- 
> 2.34.1
> 
