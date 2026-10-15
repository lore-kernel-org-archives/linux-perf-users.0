Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1139A4A485F;
	Thu, 15 Oct 2026 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062809; cv=none; b=n1Yeq+1tGR3CH+HzBiBSF43sVDQa+CxALvtgnABGFtp3GatgIiRUXG4O4rs3AxHVAZAqVlzc9fHwVQhEVz+bnNTRU3bb+KS1QIl3lU4y1nbPojXUYLTz0ua8Cyj50pUnNQieT+T94C7+DnR2oquhDj6nTGOn5rK4E3R69STie0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062809; c=relaxed/simple;
	bh=LrfilnFuB9fhW2urtvpexuMosoSCb5THhAwDoH3hzgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIeVuB/ZGSPXIKCv1enw2fWr6G8t5YnCtISxptMRvta+gCoDUjjyTIXmqRoEKz1i9HPXyP+9JhcU+eS+9mG0ZRL8sKNuB718t+YbxaSsBWKejHrqmQLxpEFZIL69LwjeSj5+KoTlyl+PjfBPzCHgX0gsEXVwcYq9WUzRekcW+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Sqt3USTI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sqt3USTI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xCpOlcL+L3VN03MDzmyIIb+BcnT/3D5y0X9zY5PMyU4=; b=Sqt3USTIEU7/88FDN6gmZRHig0
	2MpwR3ROScPjifIDVw+PEVscx1q+KB51XRkDjGYO/ENXkJisn53yZr4LkogPVMu72cA20IIz6YZUa
	QaDVdEFOoLmh+mBaO+qXFNoNwVrwIFS1ofth/KtNXYq/jxjGjnWYNdzzMAC81SuKHwrPrPAKrg/oy
	Y7GSqWcePFaQzoOw8i6ZNBBsAAQ0I+k2X17F+6YmhBcvlGoc1MxtzayRJAqpk3Tj9AdTEpcgouQXj
	88Gawnmx2WaCKae6WKIwI7rv2EHvb3rVfIgO0p26dDg5gJUnWSJiQmFy5X1Sv39Ui8ShWSqBoXiB8
	fzppfZkw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHJOg-00000000I41-1BAN;
	Thu, 15 Oct 2026 11:13:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DB2043006DD; Thu, 15 Oct 2026 13:13:16 +0200 (CEST)
Date: Thu, 15 Oct 2026 13:13:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Antoine HURET <antoine.huret@bull.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] perf: Rewrite core context handling breaks
 multiplexed cgroup events
Message-ID: <20261015111316.GJ4121339@noisy.programming.kicks-ass.net>
References: <PR3PR07MB69223331EED5BEBE150375B7849C2@PR3PR07MB6922.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PR3PR07MB69223331EED5BEBE150375B7849C2@PR3PR07MB6922.eurprd07.prod.outlook.com>

On Thu, Oct 15, 2026 at 09:03:42AM +0000, Antoine HURET wrote:

/me mutters something about having to go install and learn docker and
what's wrong with simple shells scripts that poke about in /cgroup
filesystems :-)

> Analysis
> ========
> 
> A cgroup event takes its times from a per-cpu cgroup clock.
> That clock only moves forward when update_cgrp_time_from_cpuctx() or
> update_cgrp_time_from_event() is called: on a cgroup switch, on a read
> of an active event, and in ctx_sched_out().
> 
> Up to v6.1, perf_rotate_context() went through ctx_sched_out(), which
> updated the cgroup clock. Since bd2756811766, it only updates ctx->time
> (update_context_time()) before __pmu_ctx_sched_out().
> 
> So between two cgroup switches, the rotations see a frozen cgroup
> clock. The events rotated out lose the running time they accumulated,
> and the next update (usually the read) credits the whole interval to
> the events that happen to be on the PMU at that moment.
> 
> Supporting this: a task from another cgroup waking up every 0.5 ms on
> the same CPU (each wake-up goes through perf_cgroup_switch()) makes
> the values correct again.
> 
> 
> Proposed fix
> ============
> 
> Update the cgroup clock in the rotation, as before v6.2:
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)
>  	if (cpu_event) {
>  		update_context_time(&cpuctx->ctx);
> +		update_cgrp_time_from_cpuctx(cpuctx, false);
>  		__pmu_ctx_sched_out(cpu_epc, EVENT_FLEXIBLE);
>  		rotate_ctx(&cpuctx->ctx, cpu_event);
>  		__pmu_ctx_sched_in(cpu_epc, EVENT_FLEXIBLE);
> 
> Tested on v7.3-rc7 (results above). Also tested on the Ubuntu 6.8
> kernel, where the values are correct for a parent cgroup, for two busy
> cgroups sharing the CPU, and for idle or mostly sleeping cgroups.
> 
> I am not a perf core expert. The root cause analysis and the fix were
> done with the help of an AI assistant. I reproduced the bug, then
> built and tested the fix on my machines. Corrections or a better fix
> are welcome, and I am happy to test them. If this is the right fix, I
> can send it as a proper patch.

Yes, I think this is right.

That said; while looking at this, I wonder if we should write this like
so instead. Although perhaps we should do this on top, your patch is
trivial, correct and more convenient for backport.



---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7846d70be57f..029c11e7358d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2535,8 +2535,10 @@ __ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ct
 			return;
 
 		update_context_time(ctx);
-		/* vPMU should not stop time */
-		update_cgrp_time_from_cpuctx(cpuctx, !(event_type & EVENT_GUEST) && final);
+		if (ctx == &cpuctx->ctx) {
+			/* vPMU should not stop time */
+			update_cgrp_time_from_cpuctx(cpuctx, !(event_type & EVENT_GUEST) && final);
+		}
 	}
 }
 
@@ -4633,12 +4635,12 @@ static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)
 	 * and then, if needed CPU flexible.
 	 */
 	if (task_event || (task_epc && cpu_event)) {
-		update_context_time(task_epc->ctx);
+		ctx_time_update(cpuctx, task_epc->ctx);
 		__pmu_ctx_sched_out(task_epc, EVENT_FLEXIBLE);
 	}
 
 	if (cpu_event) {
-		update_context_time(&cpuctx->ctx);
+		ctx_time_update(cpuctx, &cpuctx->ctx);
 		__pmu_ctx_sched_out(cpu_epc, EVENT_FLEXIBLE);
 		rotate_ctx(&cpuctx->ctx, cpu_event);
 		__pmu_ctx_sched_in(cpu_epc, EVENT_FLEXIBLE);
