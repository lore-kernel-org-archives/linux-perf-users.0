Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2433171E69;
	Wed,  7 Aug 2024 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031789; cv=none; b=H6iQo7BPiF35X/atE8ntS++2tZgRslhxhfudl6XcwHD0/GO/hDTAxcS6oxqZ/U12Me3nn+TIReog1e3QGNTt4NWn2lWvtcGfYPqLSPRdW25OHJMtDwI+mYKPfMHLUC1EeJVfi6f006RZ0IYY7DbD6BpFqeu3gXw6+KCzs/CyFEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031789; c=relaxed/simple;
	bh=uMFl+7ygjlbqWs0UDPLyRXIAhdtOiGqRDnVBA/mNfdA=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=TVP15+scxYmoNhql6bRjLH39H1ttj+Wdkqy2irYB+oH29ZKWWLEIC6kI07bsJV7Vok9N0Lz/vblVzSa3j3P5xFEWJtz0k5nEhR6RCUpUS+R1v/sqkzuWOR26ZIC3gzx06DNKjDRpfu6ruOKAibYxMPYKcSTcnkdzJmO1HmWvUxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iTPpt8P+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iTPpt8P+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=5P0E9yKnMuzgmP4VzsJaPEqiK0GCko+7ZBlVG8EI9A4=; b=iTPpt8P+yvP3cOUYj3HP4q3/Xj
	m0AxjNp3Uqe54q+a0Fg7+wRD3JGU8F7eEVsYpS0gnLtgZGlIcGRqcdyaQEE1eZ1DjKLZixvgL7bqs
	br5aGYafOxVsoKK6a2l1diHAYHn4w41S7O41jZ27kuxm3Ayl2A4fh2NlO7XyuLH2QbYAYvC9/5433
	7CQWtha6aqcvBJd6jtzDy1Ys1jJvhg807vV5uj0EzPrOIt1g0emCWyL2yua/HOwE8I1AlX8y6mCEm
	Sqem7IvnGawtLaygGbE6dcS6c1WruZJbqj2B5IaJT9S2iU0KVSVX3mAI9el6xcR/XOpUeU7aXaVu4
	dpFr26+g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbfHC-00000007FPh-2En8;
	Wed, 07 Aug 2024 11:56:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 9307A30074E; Wed,  7 Aug 2024 13:56:21 +0200 (CEST)
Message-Id: <20240807115550.031212518@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 07 Aug 2024 13:29:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: peterz@infradead.org,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] perf: Extract a few helpers
References: <20240807112924.448091402@infradead.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The context time update code is repeated verbatim a few times.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2330,6 +2330,24 @@ group_sched_out(struct perf_event *group
 		event_sched_out(event, ctx);
 }
 
+static inline void
+ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx)
+{
+	if (ctx->is_active & EVENT_TIME) {
+		update_context_time(ctx);
+		update_cgrp_time_from_cpuctx(cpuctx, false);
+	}
+}
+
+static inline void
+ctx_time_update_event(struct perf_event_context *ctx, struct perf_event *event)
+{
+	if (ctx->is_active & EVENT_TIME) {
+		update_context_time(ctx);
+		update_cgrp_time_from_event(event);
+	}
+}
+
 #define DETACH_GROUP	0x01UL
 #define DETACH_CHILD	0x02UL
 #define DETACH_DEAD	0x04UL
@@ -2349,10 +2367,7 @@ __perf_remove_from_context(struct perf_e
 	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
 	unsigned long flags = (unsigned long)info;
 
-	if (ctx->is_active & EVENT_TIME) {
-		update_context_time(ctx);
-		update_cgrp_time_from_cpuctx(cpuctx, false);
-	}
+	ctx_time_update(cpuctx, ctx);
 
 	/*
 	 * Ensure event_sched_out() switches to OFF, at the very least
@@ -2437,12 +2452,8 @@ static void __perf_event_disable(struct
 	if (event->state < PERF_EVENT_STATE_INACTIVE)
 		return;
 
-	if (ctx->is_active & EVENT_TIME) {
-		update_context_time(ctx);
-		update_cgrp_time_from_event(event);
-	}
-
 	perf_pmu_disable(event->pmu_ctx->pmu);
+	ctx_time_update_event(ctx, event);
 
 	if (event == event->group_leader)
 		group_sched_out(event, ctx);
@@ -4529,10 +4540,7 @@ static void __perf_event_read(void *info
 		return;
 
 	raw_spin_lock(&ctx->lock);
-	if (ctx->is_active & EVENT_TIME) {
-		update_context_time(ctx);
-		update_cgrp_time_from_event(event);
-	}
+	ctx_time_update_event(ctx, event);
 
 	perf_event_update_time(event);
 	if (data->group)
@@ -4732,10 +4740,7 @@ static int perf_event_read(struct perf_e
 		 * May read while context is not active (e.g., thread is
 		 * blocked), in that case we cannot update context time
 		 */
-		if (ctx->is_active & EVENT_TIME) {
-			update_context_time(ctx);
-			update_cgrp_time_from_event(event);
-		}
+		ctx_time_update_event(ctx, event);
 
 		perf_event_update_time(event);
 		if (group)


