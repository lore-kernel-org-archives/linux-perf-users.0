Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC5C1E4F04;
	Wed,  7 Aug 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031792; cv=none; b=bFMnRmDSIVSZ4BYeq8ahPoVF3ZNWWDIxap9V9nTppFsuBRflk64kk2slEmekVH1OO1vwPsHzF2gf7tQubz4NDy92y3vSRDkFdG4ZgBkYxylHPsadFZPH1L6LAZt8GRGaNYvir7hfXxiOZPvKwaaf4N0+Y7HOS39U/zOMHDaSgGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031792; c=relaxed/simple;
	bh=NCLV3XRv4F70DO/lDLYGUKSAExlAGjF5MiNF6cNiI1g=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MQmZSDmNGfLXji84wYfh/HsFPmOrGBJvrXDnpoqnbaD10W8HXBHlTtnvbj2EwMlLmDKJjqOVrQwmnrN7G2aNnMTcv08ZT9G0AQVFGnM/SDI5qLN52yakJ+A1a9LAFEKDt3PJNtJFOHx9es0ZwqGj9N0v58p7irWBcvCONfKPgEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BKiECp4b; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BKiECp4b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=fk1YC0a9penq8DhSiSBUazh/i3TIeiQXPW6dmx7/vqk=; b=BKiECp4bzsHN+8TBk4EdBU/2hS
	OaatYv2X8xW3jKXmFoK1A1xCV1EFnN5fb0AgDB0qvMcvUj7DhYn4W5AGaLxYjuGCU5cIFQpJfAVXd
	0hxUlOdi1+T05wi9SobGWJiSZkapgPsdFHfDX0gvyB0/MODK9eF26yMoTNoGNr9YxqYEaGFSWJcWz
	FPdd3fPROVFC+9CAsam7BoAPnZBuCUTpE3+R2dhJ+eZwMj9TrJ5Fa1dJS0fgKW88l1hc8cYiesRGm
	Hh8lOvAWE1pfj0++5/iL2J+yASKNn+QdPGMsypsPd1tR5EfnmlnERipwB5NlTzURX0V06AGtq5coI
	5dc7kWVQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbfHC-00000006cCk-25bd;
	Wed, 07 Aug 2024 11:56:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 970B2300AA5; Wed,  7 Aug 2024 13:56:21 +0200 (CEST)
Message-Id: <20240807115550.138301094@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 07 Aug 2024 13:29:27 +0200
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
Subject: [PATCH 3/5] perf: Fix event_function_call() locking
References: <20240807112924.448091402@infradead.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

All the event_function/@func call context already uses perf_ctx_lock()
except for the !ctx->is_active case. Make it all consistent.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -263,6 +263,7 @@ static int event_function(void *info)
 static void event_function_call(struct perf_event *event, event_f func, void *data)
 {
 	struct perf_event_context *ctx = event->ctx;
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct task_struct *task = READ_ONCE(ctx->task); /* verified in event_function */
 	struct event_function_struct efs = {
 		.event = event,
@@ -291,22 +292,22 @@ static void event_function_call(struct p
 	if (!task_function_call(task, event_function, &efs))
 		return;
 
-	raw_spin_lock_irq(&ctx->lock);
+	perf_ctx_lock(cpuctx, ctx);
 	/*
 	 * Reload the task pointer, it might have been changed by
 	 * a concurrent perf_event_context_sched_out().
 	 */
 	task = ctx->task;
 	if (task == TASK_TOMBSTONE) {
-		raw_spin_unlock_irq(&ctx->lock);
+		perf_ctx_unlock(cpuctx, ctx);
 		return;
 	}
 	if (ctx->is_active) {
-		raw_spin_unlock_irq(&ctx->lock);
+		perf_ctx_unlock(cpuctx, ctx);
 		goto again;
 	}
 	func(event, NULL, ctx, data);
-	raw_spin_unlock_irq(&ctx->lock);
+	perf_ctx_unlock(cpuctx, ctx);
 }
 
 /*


