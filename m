Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C282864;
	Wed,  4 Jun 2025 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749031268; cv=none; b=SorhRLUi7AEbh5nAD5/2H0HG8knclqIfhfUpgZfeRSZ3TQh0cvqZB1Tx8Z5jOS1aaKXQpTCL/4WqFVPQ96bpO+Qf9D5Hd1ui8AW1zzVQWZx3GW7fA6P6JkZtoq/xhODUiHztuuW4LRUa7MO5hue+vj0mTjHHfE3Nrajcy9wCj94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749031268; c=relaxed/simple;
	bh=g7dNmCFIuya1AhW9VqQ7BiqRh+rsuId820P66lxPe3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjfuZnhYpO4Wl/devvLufNYljiBOCsJwOCN1dCtK4UBi7tSKDwU7RmWE+LLkT2uVaWV94a7SLFAdaiRl6m1KVowYh5LUlOciCftPUV/ShOPCeHEUFyZTAUJP/RVLrZX5/Kqr6GnK+2YReD7vAsncbuwYuoiH7FtCvwF/MFr5wME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V5gVPwYN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V5gVPwYN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hvswKOspXfPTomvHlFFhmYJf0rg8SY9R3ztOupfQW1k=; b=V5gVPwYNk3egL6TbXhE4FB0B0O
	9OWoVUpjbd6KhfBwhZs4MpN6QBPVxKc9M84ZPChKCN5d771V/VcxwIK5SrPd54p7HruLbXmcLa3OQ
	cwhxmojiIlLzewnu7hRud3tIaZgHh6g15hk6XDCXKRaSyXx6AEvceQ0Bb0JH8+2rLPsKKaPxJnWwR
	a+VO8SbpyJoBRODZ6x3ABpL/WJsHlOCYvuYSRaR+Rz/XdIc8o80Y8tmJwA6WEr6XR1JpE2R7PrvJv
	OwDfWlH4zt+sR1HTcLNOg+UFP24YEW0rDQ6mACnzbKUXMeOWGZdZdE2JTbtlj/oXqyJYuLJgv3ug0
	msCswAtw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMkvV-00000000t0z-2SCQ;
	Wed, 04 Jun 2025 10:00:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CC1C830078B; Wed,  4 Jun 2025 12:00:52 +0200 (CEST)
Date: Wed, 4 Jun 2025 12:00:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, davidcc@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf/core: Fix
 WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0) in perf_cgroup_switch
Message-ID: <20250604100052.GH38114@noisy.programming.kicks-ass.net>
References: <20250604033924.3914647-1-luogengkun@huaweicloud.com>
 <20250604033924.3914647-3-luogengkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604033924.3914647-3-luogengkun@huaweicloud.com>

On Wed, Jun 04, 2025 at 03:39:24AM +0000, Luo Gengkun wrote:
> There may be concurrency between perf_cgroup_switch and
> perf_cgroup_event_disable. Consider the following scenario: after a new
> perf cgroup event is created on CPU0, the new event may not trigger
> a reprogramming, causing ctx->is_active to be 0. In this case, when CPU1
> disables this perf event, it executes __perf_remove_from_context->
> list _del_event->perf_cgroup_event_disable on CPU1, which causes a race
> with perf_cgroup_switch running on CPU0.
> 
> The following describes the details of this concurrency scenario:
> 
> CPU0						CPU1
> 
> perf_cgroup_switch:
>    ...
>    # cpuctx->cgrp is not NULL here
>    if (READ_ONCE(cpuctx->cgrp) == NULL)
>    	return;
> 
> 						perf_remove_from_context:
> 						   ...
> 						   raw_spin_lock_irq(&ctx->lock);
> 						   ...
> 						   # ctx->is_active == 0 because reprogramm is not
> 						   # tigger, so CPU1 can do __perf_remove_from_context
> 						   # for CPU0
> 						   __perf_remove_from_context:
> 						         perf_cgroup_event_disable:
> 							    ...
> 							    if (--ctx->nr_cgroups)
> 							    ...
> 
>    # this warning will happened because CPU1 changed
>    # ctx.nr_cgroups to 0.
>    WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
> 
> To fix this problem, expand the lock-holding critical section in
> perf_cgroup_switch.
> 
> Fixes: db4a835601b7 ("perf/core: Set cgroup in CPU contexts for new cgroup events")
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> ---

Right, so how about we simply re-check the condition once we take the
lock?

Also, take the opportunity to convert to guard instead of adding goto
unlock.

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -207,6 +207,19 @@ static void perf_ctx_unlock(struct perf_
 	__perf_ctx_unlock(&cpuctx->ctx);
 }
 
+typedef struct {
+	struct perf_cpu_context *cpuctx;
+	struct perf_event_context *ctx;
+} class_perf_ctx_lock_t;
+
+static inline void class_perf_ctx_lock_destructor(class_perf_ctx_lock_t *_T)
+{ perf_ctx_unlock(_T->cpuctx, _T->ctx); }
+
+static inline class_perf_ctx_lock_t
+class_perf_ctx_lock_constructor(struct perf_cpu_context *cpuctx,
+				struct perf_event_context *ctx)
+{ perf_ctx_lock(cpuctx, ctx); return (class_perf_ctx_lock_t){ cpuctx, ctx }; }
+
 #define TASK_TOMBSTONE ((void *)-1L)
 
 static bool is_kernel_event(struct perf_event *event)
@@ -944,7 +957,13 @@ static void perf_cgroup_switch(struct ta
 	if (READ_ONCE(cpuctx->cgrp) == cgrp)
 		return;
 
-	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
+	guard(perf_ctx_lock)(cpuctx, cpuctx->task_ctx);
+	/*
+	 * Re-check, could've raced vs perf_remove_from_context().
+	 */
+	if (READ_ONCE(cpuctx->cgrp) == NULL)
+		return;
+
 	perf_ctx_disable(&cpuctx->ctx, true);
 
 	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
@@ -962,7 +981,6 @@ static void perf_cgroup_switch(struct ta
 	ctx_sched_in(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
 
 	perf_ctx_enable(&cpuctx->ctx, true);
-	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
 static int perf_cgroup_ensure_storage(struct perf_event *event,
