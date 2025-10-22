Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCD933711B;
	Wed, 22 Oct 2025 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132282; cv=none; b=ZDa9qhhO5sXGRJcQ9pQsCP6WqnWfU86J/kKVhGfP3gJTtCIXJruI53DFRgpwVgaY66zEUje1Opqn7PNTlW44ErlrsUKVyIkN4IsF96qpwt/L9aa9LP/G+3lP6ipazOfJtryX8GnnVYz3k3n0e3d/T+RlRwJWWQxTX76/wKmmahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132282; c=relaxed/simple;
	bh=saJh2pYKcHbfNeU6j5aIeEhHMmEGD6ngNfMdHtFav24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gc2qrAAbdK+W3oNnl1VpJRh309/z2woDeJfe3Y2EpFGMizHkd81bRw29TnkTbd/OncOPpMeG1CzvsRwn+xCqmrbNdDvFtLUeX+cnxRsv+W/KVay4B2E83pr6OrMWxcYRh8NtjCT6bLB1vHtBPmcwoIsC68bfbskTCW5uPrfVAPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fvhbRdIY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fvhbRdIY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Hx7IMRRxA9uFUyCzmuFFLeFf+897nJgZOnLj3popP8E=; b=fvhbRdIY1zIWUU8ihlkZOHEgnE
	MzODHMfk/jyzVyCCcMqOwN9DM4KwxFu4JWrlgqIhMLgv+3iol/YUkza4iHE/THkZU1euUlpqKtVAn
	dYBNjMS8/MY6P6DdoQWa5No2zJVd9VrmN5qher8vFYD+eL7tJ3hfxYluYLS8iB3UxTziwDCrNPRQL
	PqLzEc8wIGsis2nfNHIHj8iupqVRbmIO6GY5+Azdgv8ymSlChPGG1DkFfdjqY2WmhQH0hVqLmZvol
	bsD3P0ZFZcQ3l84sE91CXlk42UtZ+oaTjcN8HOEBk6LSKwGRwY5lWTeVze2gVoHisaqmyoh9i1dDH
	MMN3IIBQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBWxE-000000043BQ-07IZ;
	Wed, 22 Oct 2025 11:24:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BBDE63003C4; Wed, 22 Oct 2025 13:24:32 +0200 (CEST)
Date: Wed, 22 Oct 2025 13:24:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	kernel test robot <oliver.sang@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [Patch v8 02/12] perf/x86/intel: Fix NULL event access and
 potential PEBS record loss
Message-ID: <20251022112432.GN4067720@noisy.programming.kicks-ass.net>
References: <20251015064422.47437-1-dapeng1.mi@linux.intel.com>
 <20251015064422.47437-3-dapeng1.mi@linux.intel.com>
 <fcb09e14-970c-4ebd-82f2-a12150fe3708@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcb09e14-970c-4ebd-82f2-a12150fe3708@linux.intel.com>

On Wed, Oct 22, 2025 at 04:12:14PM +0800, Mi, Dapeng wrote:

> Just think twice about this fix, it seems current fix is incomplete.
> Besides the PEBS handler, the basic PMI handler could encounter same issue,
> like the below code in handle_pmi_common(),
> 
>     for_each_set_bit(bit, (unsigned long *)&status, X86_PMC_IDX_MAX) {
>         struct perf_event *event = cpuc->events[bit];
>         u64 last_period;
> 
>         handled++;
> 
>         if (!test_bit(bit, cpuc->active_mask))
>             continue;
> 
> Although the NULL event would not be accessed by checking
> the cpuc->active_mask, the potential overflow process of these NULL events
> is skipped as well, it may cause data loss.
> 
> Moreover, current approach defines temporary variables to snapshot the
> active events, the temporary variables may consume too much stack memory
> (384 bytes).
> 
> So I enhance the fix as below. Do you have any comment on this? Thanks.

So I didn't like the previous and I like this even less. What about
something like this instead?

I quickly went through the cpuc->event[ users and they all either check
active_mask or, in case of the PEBS stuff, check pebs_enabled mask
(which should be a subset of active_mask).

(the PEBS last case depends on count being 0 for all counters that are
not set in pebs_enabled)

WDYT?

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 745caa6c15a3..74479f9d6eed 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1344,6 +1344,7 @@ static void x86_pmu_enable(struct pmu *pmu)
 				hwc->state |= PERF_HES_ARCH;
 
 			x86_pmu_stop(event, PERF_EF_UPDATE);
+			cpuc->events[hwc->idx] = NULL;
 		}
 
 		/*
@@ -1365,6 +1366,7 @@ static void x86_pmu_enable(struct pmu *pmu)
 			 * if cpuc->enabled = 0, then no wrmsr as
 			 * per x86_pmu_enable_event()
 			 */
+			cpuc->events[hwc->idx] = event;
 			x86_pmu_start(event, PERF_EF_RELOAD);
 		}
 		cpuc->n_added = 0;
@@ -1531,7 +1533,6 @@ static void x86_pmu_start(struct perf_event *event, int flags)
 
 	event->hw.state = 0;
 
-	cpuc->events[idx] = event;
 	__set_bit(idx, cpuc->active_mask);
 	static_call(x86_pmu_enable)(event);
 	perf_event_update_userpage(event);
@@ -1610,7 +1611,6 @@ void x86_pmu_stop(struct perf_event *event, int flags)
 	if (test_bit(hwc->idx, cpuc->active_mask)) {
 		static_call(x86_pmu_disable)(event);
 		__clear_bit(hwc->idx, cpuc->active_mask);
-		cpuc->events[hwc->idx] = NULL;
 		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
 		hwc->state |= PERF_HES_STOPPED;
 	}
@@ -1648,6 +1648,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	 * Not a TXN, therefore cleanup properly.
 	 */
 	x86_pmu_stop(event, PERF_EF_UPDATE);
+	cpuc->events[event->hw.idx] = NULL;
 
 	for (i = 0; i < cpuc->n_events; i++) {
 		if (event == cpuc->event_list[i])
