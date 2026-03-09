Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CAC314D08;
	Mon,  9 Mar 2026 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074342; cv=none; b=KQL07YHH4IrPgOCUBli1kOv6jQ9h3HCKgKQVSID/+b9Ut0+3Wc5fCF449g8FB/zMhli3JHRxTGMB7wIlbLb/p+ExSlNqnq8I4EAaif5Y/IwRAdPp1gH6KghzrL1XyME7QnRIX1628erJ6Wk6FLiehs9iQTz+5dIO8JSY8QAaiBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074342; c=relaxed/simple;
	bh=kKwDp49L3SDIWKktS09q4HkY7nf4iMP9Vx9VqN8zevI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdOYwWOOdYMKAk0XtT+3Ct09Y/AOBvxvwDpLsgYbu6X6Rh8nWdfsLYGmWuSbdPxqwh1U7HHTO9omqKR91OZ7xSJc+E38aUfMDDvWpWiU7i/jn3PDXUlPUM7AZouzjuJW/YTugnytvnZYOBl8mBrRMk36XdnvwoFcbm8JWptCefc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m7DFO/LX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m7DFO/LX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lSyAeknhNDmuYr0petYBrv+Ya1BSdLDe/u7IF149fCg=; b=m7DFO/LXtm3o3Vo8IiM2W0JM3G
	/IpPPTp/ITlfp0nJl8gR6SIiR4DTrt1BKicWU567yS1QwlX8sXYxAnZILetNhsxPTo6zZ0bwCv620
	rMV0Nw1eC9zWZqBJCpG+SHNxrWEcJed6aI+jDab23gqjIUBI9gD3g4bIlTKbJsAFepi0rXXNOedj1
	C6Tol+ybbDmNwLgiVH0gMP0r/eXhcphMvp9YwqMX3yTrGLpp2lqbh5rgQ6tPTKuhlRDToxEud3ttl
	gCGTt9F5fe0KbYaNhKRFNYV+/6zbTJZvCnsiLs3FxvJ17SNjwepwlhNSNTEZ0bcgAmTqaee12BWbC
	I68+r7wQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzdd3-0000000Ch0Y-0Uae;
	Mon, 09 Mar 2026 16:38:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C7D52300182; Mon, 09 Mar 2026 17:38:47 +0100 (CET)
Date: Mon, 9 Mar 2026 17:38:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Breno Leitao <leitao@debian.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] perf/x86: Restore event pointer setup in x86_pmu_start()
Message-ID: <20260309163847.GE2277644@noisy.programming.kicks-ass.net>
References: <20260309-perf-v1-1-601ffb531893@debian.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-perf-v1-1-601ffb531893@debian.org>

On Mon, Mar 09, 2026 at 07:40:56AM -0700, Breno Leitao wrote:
> A production AMD EPYC system crashed with a NULL pointer dereference
> in the PMU NMI handler:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000198
>   RIP: x86_perf_event_update+0xc/0xa0
>   Call Trace:
>    <NMI>
>    amd_pmu_v2_handle_irq+0x1a6/0x390
>    perf_event_nmi_handler+0x24/0x40
> 
> The faulting instruction is `cmpq $0x0, 0x198(%rdi)` with RDI=0,
> corresponding to the `if (unlikely(!hwc->event_base))` check in
> x86_perf_event_update() where hwc = &event->hw and event is NULL.
> 
> drgn inspection of the vmcore on CPU 106 showed a mismatch between
> cpuc->active_mask and cpuc->events[]:
> 
>   active_mask: 0x1e (bits 1, 2, 3, 4)
>   events[1]:   0xff1100136cbd4f38  (valid)
>   events[2]:   0x0                 (NULL, but active_mask bit 2 set)
>   events[3]:   0xff1100076fd2cf38  (valid)
>   events[4]:   0xff1100079e990a90  (valid)
> 
> The event that should occupy events[2] was found in event_list[2]
> with hw.idx=2 and hw.state=0x0, confirming x86_pmu_start() had run
> (which clears hw.state and sets active_mask) but events[2] was
> never populated.
> 
> Another event (event_list[0]) had hw.state=0x7 (STOPPED|UPTODATE|ARCH),
> showing it was stopped when the PMU rescheduled events, confirming the
> throttle-then-reschedule sequence occurred.
> 
> The root cause is commit 7e772a93eb61 ("perf/x86: Fix NULL event access
> and potential PEBS record loss") which moved the cpuc->events[idx]
> assignment out of x86_pmu_start() and into x86_pmu_enable(). This
> broke any path that calls pmu->start() without going through
> x86_pmu_enable() -- specifically the unthrottle path:
> 
>   perf_adjust_freq_unthr_events()
>     -> perf_event_unthrottle_group()
>       -> perf_event_unthrottle()
>         -> event->pmu->start(event, 0)
>           -> x86_pmu_start()     // sets active_mask but not events[]
> 
> The race sequence is:
> 
>   1. A group of perf events overflows, triggering group throttle via
>      perf_event_throttle_group(). All events are stopped: active_mask
>      bits cleared, events[] preserved (x86_pmu_stop no longer clears
>      events[] after commit 7e772a93eb61).
> 
>   2. While still throttled (PERF_HES_STOPPED), x86_pmu_enable() runs
>      due to other scheduling activity. Stopped events that need to
>      move counters get PERF_HES_ARCH set and events[old_idx] cleared.
>      In step 2 of x86_pmu_enable(), PERF_HES_ARCH causes these events
>      to be skipped -- events[new_idx] is never set.


So why not just move this then? Having less sites that set that value is
more better, no?

---
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 03ce1bc7ef2e..54b4c315d927 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1372,6 +1372,8 @@ static void x86_pmu_enable(struct pmu *pmu)
 			else if (i < n_running)
 				continue;
 
+			cpuc->events[hwc->idx] = event;
+
 			if (hwc->state & PERF_HES_ARCH)
 				continue;
 
@@ -1379,7 +1381,6 @@ static void x86_pmu_enable(struct pmu *pmu)
 			 * if cpuc->enabled = 0, then no wrmsr as
 			 * per x86_pmu_enable_event()
 			 */
-			cpuc->events[hwc->idx] = event;
 			x86_pmu_start(event, PERF_EF_RELOAD);
 		}
 		cpuc->n_added = 0;
