Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA8C43152;
	Tue, 30 Jul 2024 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329071; cv=none; b=aEplHHkwJzzPFG4lr3UqhDlslUk6+Rmfbd1bOX6kCgIbqcbnxnv4a+es/IuHOK1ZxTL0xmV+LX+4gab5geSom3p6BEZJYx/1IgZqHgc28QocjpWC4T0/92dm6uiqXOhcdNeFgbLF2URWtYS3DyjU+U3qNjRoDZHA56tpISz70JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329071; c=relaxed/simple;
	bh=70etayXrUCfZdnKM3OyZxCdJ+uHIiB7Bw8Sf3hLSHjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jq5BSPd7/FcPOzVvjQt0GE8vryGxIPRs16JCSWRhCddLpFfMAucNweuEbrc6GiOpzBS99irKuiHHtrpYqhhuqxKnPZ3zSSA8mkTmn2BdIi0IUd3RAF0Fcs2o+TCzKm82IPNXfPNN/2dS86xojn0FqfhaoqZk0Thxw9jtxY8LaDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF14C106F;
	Tue, 30 Jul 2024 01:44:54 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 880233F766;
	Tue, 30 Jul 2024 01:44:27 -0700 (PDT)
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
Subject: [PATCH v9 1/4] perf: Rename perf_event_context.nr_pending to nr_no_switch_fast.
Date: Tue, 30 Jul 2024 09:44:14 +0100
Message-ID: <20240730084417.7693-2-ben.gainey@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730084417.7693-1-ben.gainey@arm.com>
References: <20240730084417.7693-1-ben.gainey@arm.com>
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
 include/linux/perf_event.h |  5 +++--
 kernel/events/core.c       | 12 ++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1a8942277dda..87ccb7ca241f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -963,12 +963,13 @@ struct perf_event_context {
 	struct rcu_head			rcu_head;
 
 	/*
-	 * Sum (event->pending_work + event->pending_work)
+	 * The count of events for which using the switch-out fast path
+	 * should be avoided.
 	 *
 	 * The SIGTRAP is targeted at ctx->task, as such it won't do changing
 	 * that until the signal is delivered.
 	 */
-	local_t				nr_pending;
+	local_t				nr_no_switch_fast;
 };
 
 struct perf_cpu_pmu_context {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450bdc227..e6cc354a3cee 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3516,9 +3516,9 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 
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
@@ -5204,7 +5204,7 @@ static void perf_pending_task_sync(struct perf_event *event)
 	 */
 	if (task_work_cancel(current, head)) {
 		event->pending_work = 0;
-		local_dec(&event->ctx->nr_pending);
+		local_dec(&event->ctx->nr_no_switch_fast);
 		return;
 	}
 
@@ -6868,7 +6868,7 @@ static void perf_pending_task(struct callback_head *head)
 	if (event->pending_work) {
 		event->pending_work = 0;
 		perf_sigtrap(event);
-		local_dec(&event->ctx->nr_pending);
+		local_dec(&event->ctx->nr_no_switch_fast);
 		rcuwait_wake_up(&event->pending_work_wait);
 	}
 	rcu_read_unlock();
@@ -9740,7 +9740,7 @@ static int __perf_event_overflow(struct perf_event *event,
 		if (!event->pending_work &&
 		    !task_work_add(current, &event->pending_task, notify_mode)) {
 			event->pending_work = pending_id;
-			local_inc(&event->ctx->nr_pending);
+			local_inc(&event->ctx->nr_no_switch_fast);
 
 			event->pending_addr = 0;
 			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
-- 
2.45.2

