Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73631791F2;
	Wed, 12 Jun 2024 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199563; cv=none; b=bUPgywd2tDVw8WdY7EgcI/MO31WN0qVXTvB+zz1kxkrCzA7+0bZqQUAF+8J4IZt/eOG17z0OzGRdjb7n16qvMPdEa2GI1NqSBK0m8IKIjcmECheV7C8OAvr0Zl+eXEkxOOajz2MFYr4gfzutO0RKXDxGvmUF8rO02wMzq46BDBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199563; c=relaxed/simple;
	bh=9KRHK76G7WN2RzGj0D9xCxYn1xUiBRPUAVotFckFqv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRmgTFKGBX5uSTXtDYjngC2gWRs333aQUjnnhqSVtdqeZv1qGALe3wS/l7ETyP3PruYykwrj4M0BEET6mfVXG7uTHisoqKlNo/YvKp9M2Y4PC/ZH/VjJ90KvZFW7zUZ8megSLxeezyFfCEEhgw2ytQ8RngcaCgenvW8iMhdp+kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4BB0DA7;
	Wed, 12 Jun 2024 06:39:45 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 69B733F64C;
	Wed, 12 Jun 2024 06:39:19 -0700 (PDT)
From: Ben Gainey <ben.gainey@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH v8 1/4] perf: Rename perf_event_context.nr_pending to nr_no_switch_fast.
Date: Wed, 12 Jun 2024 14:39:08 +0100
Message-ID: <20240612133911.3447625-2-ben.gainey@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612133911.3447625-1-ben.gainey@arm.com>
References: <20240612133911.3447625-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nr_pending counts the number of events in the context that
either pending_sigtrap or pending_work, but it is used
to prevent taking the fast path in perf_event_context_sched_out.

Renamed to reflect what it is used for, rather than what it
counts. This change allows using the field to track other
event properties that also require skipping the fast path
without possible confusion over the name.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 include/linux/perf_event.h |  5 ++++-
 kernel/events/core.c       | 14 +++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a5304ae8c654..c0c6c70bb9f1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -962,12 +962,15 @@ struct perf_event_context {
 	struct rcu_head			rcu_head;
 
 	/*
+	 * The count of events for which using the switch-out fast path
+	 * should be avoided.
+	 *
 	 * Sum (event->pending_sigtrap + event->pending_work)
 	 *
 	 * The SIGTRAP is targeted at ctx->task, as such it won't do changing
 	 * that until the signal is delivered.
 	 */
-	local_t				nr_pending;
+	local_t				nr_no_switch_fast;
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f908f077935..c9cb22304d11 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2295,7 +2295,7 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 			task_work_add(current, &event->pending_task, TWA_RESUME);
 		}
 		if (dec)
-			local_dec(&event->ctx->nr_pending);
+			local_dec(&event->ctx->nr_no_switch_fast);
 	}
 
 	perf_event_set_state(event, state);
@@ -3531,9 +3531,9 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 
 			perf_ctx_disable(ctx, false);
 
-			/* PMIs are disabled; ctx->nr_pending is stable. */
-			if (local_read(&ctx->nr_pending) ||
-			    local_read(&next_ctx->nr_pending)) {
+			/* PMIs are disabled; ctx->nr_no_switch_fast is stable. */
+			if (local_read(&ctx->nr_no_switch_fast) ||
+			    local_read(&next_ctx->nr_no_switch_fast)) {
 				/*
 				 * Must not swap out ctx when there's pending
 				 * events that rely on the ctx->task relation.
@@ -6768,7 +6768,7 @@ static void __perf_pending_irq(struct perf_event *event)
 		if (event->pending_sigtrap) {
 			event->pending_sigtrap = 0;
 			perf_sigtrap(event);
-			local_dec(&event->ctx->nr_pending);
+			local_dec(&event->ctx->nr_no_switch_fast);
 		}
 		if (event->pending_disable) {
 			event->pending_disable = 0;
@@ -6841,7 +6841,7 @@ static void perf_pending_task(struct callback_head *head)
 	if (event->pending_work) {
 		event->pending_work = 0;
 		perf_sigtrap(event);
-		local_dec(&event->ctx->nr_pending);
+		local_dec(&event->ctx->nr_no_switch_fast);
 	}
 
 	if (rctx >= 0)
@@ -9711,7 +9711,7 @@ static int __perf_event_overflow(struct perf_event *event,
 			pending_id = hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
 		if (!event->pending_sigtrap) {
 			event->pending_sigtrap = pending_id;
-			local_inc(&event->ctx->nr_pending);
+			local_inc(&event->ctx->nr_no_switch_fast);
 		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
 			 * Should not be able to return to user space without
-- 
2.45.2

