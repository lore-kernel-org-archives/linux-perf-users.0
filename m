Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC7B2046A8;
	Fri, 20 Dec 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734708499; cv=none; b=qYlvP8Eo0nlkm+XNVukhlYXRmDat7FdcCrYzLKoRJ/BSwg8XNB6ocIF/I2dHyDAKuQZShklkhYaxQ/kdBkwQpEgBhrP3DglFRbB1/edlssx1gED30XscxpoLxY5FrZT6AwrdOYWEDkDyt+ZnuGYuiRAM63kHwH3EEH1JtfohgRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734708499; c=relaxed/simple;
	bh=KmboH4rnoN6IQ8ns63qYmrFaTJoJYEu8gMk/FvGM6Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtlT948csf4mUdP46N7sj1GLCxuArynq/HulRG83nllQGLQ9AV6iV1f0wZ64oKVpLSWahQbkz1h230ydazg84m8GR3GJVjsDSbA4UR14QF8Q/go9Ra8Bdv/Dhy8qEQW2DElThDEKxrSdlMph3y/TLtnNOTX76UE0daJ8yb5jN7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hoyvtypy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hoyvtypy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qNms169r7tK0OUbX1wfbjLCRERYuIlFx5bil7ZBXx6Y=; b=hoyvtypyDbkL7Z6MZpoGOuwpXP
	jAzvXPFUt8YM5hN1Zi/+8PSOtRBI21N+sGILzxeA6UokdlRfxZAdAN6II4f/6X4Ec6ajbpRX2br+3
	Iki7kcZq/2hDcd5mFaYBiLUSER2zcFnJqxzq+8+jyBpp9/bQmGOJExlCgF50/RpnBEEnQUGzs3ANn
	7I75Zf8Q7vfWpG7J6I1DBhIMkWMKZdfnUWeyzQOWcNHNO68TZD5vyQ+zPaOVa0oubXcdXyCPvGB5d
	51E1BKaZIx4ggGI2VoeSCnfz7CKPHdjf0/FHfPeBrcQ9wUlmZrUtsgtGdXb2Ri533FHioofeTpOYS
	+Tsa49lw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tOevD-00000001MVI-0RZA;
	Fri, 20 Dec 2024 15:28:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 76EAD3003FF; Fri, 20 Dec 2024 16:28:10 +0100 (CET)
Date: Fri, 20 Dec 2024 16:28:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] events/core: fix acoount failure for event's
 total_enable_time
Message-ID: <20241220152810.GK12500@noisy.programming.kicks-ass.net>
References: <20241220100202.804062-1-yeoreum.yun@arm.com>
 <20241220133359.GC17537@noisy.programming.kicks-ass.net>
 <Z2V5s2JM4W7BRckR@e129823.arm.com>
 <20241220151414.GO11133@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220151414.GO11133@noisy.programming.kicks-ass.net>

On Fri, Dec 20, 2024 at 04:14:14PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 20, 2024 at 02:05:39PM +0000, Yeoreum Yun wrote:

> > the answer is in the perf_event_exit_event()'s
> > perf_remove_from_context(). in here
> > event_sched_out() is called via __perf_remove_from_context()
> > So above case, the enable time is fixed in here.
> 
> OK, how's this then?

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 065f9188b44a..96a00034b26f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2406,7 +2406,8 @@ ctx_time_update_event(struct perf_event_context *ctx, struct perf_event *event)
 
 #define DETACH_GROUP	0x01UL
 #define DETACH_CHILD	0x02UL
-#define DETACH_DEAD	0x04UL
+#define DETACH_EXIT	0x04UL
+#define DETACH_DEAD	0x048L
 
 /*
  * Cross CPU call to remove a performance event
@@ -2421,6 +2422,7 @@ __perf_remove_from_context(struct perf_event *event,
 			   void *info)
 {
 	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
+	enum perf_event_state state = PERF_EVENT_STATE_OFF;
 	unsigned long flags = (unsigned long)info;
 
 	ctx_time_update(cpuctx, ctx);
@@ -2429,16 +2431,20 @@ __perf_remove_from_context(struct perf_event *event,
 	 * Ensure event_sched_out() switches to OFF, at the very least
 	 * this avoids raising perf_pending_task() at this time.
 	 */
-	if (flags & DETACH_DEAD)
+	if (flags & DETACH_EXIT)
+		state = PERF_EVENT_STATE_EXIT;
+	if (flags & DETACH_DEAD) {
 		event->pending_disable = 1;
+		state = PERF_EVENT_STATE_DEAD;
+	}
 	event_sched_out(event, ctx);
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
-	if (flags & DETACH_DEAD)
-		event->state = PERF_EVENT_STATE_DEAD;
+
+	perf_event_set_state(event, min(event->state, state));
 
 	if (!pmu_ctx->nr_events) {
 		pmu_ctx->rotate_necessary = 0;
@@ -13371,12 +13377,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 		mutex_lock(&parent_event->child_mutex);
 	}
 
-	perf_remove_from_context(event, detach_flags);
-
-	raw_spin_lock_irq(&ctx->lock);
-	if (event->state > PERF_EVENT_STATE_EXIT)
-		perf_event_set_state(event, PERF_EVENT_STATE_EXIT);
-	raw_spin_unlock_irq(&ctx->lock);
+	perf_remove_from_context(event, detach_flags | DETACH_EXIT);
 
 	/*
 	 * Child events can be freed.
