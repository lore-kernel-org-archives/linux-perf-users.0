Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6AE17C7CD;
	Wed, 12 Jun 2024 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199565; cv=none; b=UpfSDt1atmJGfHSD8lpSZIRnrbhmAjs3yQCKHU2WxKLHuTxmKAQctIFYG0TVUkuhEZdWC+ZZw4aoqPCweg9Y0gkgGTvPY3MYkMM7FFveAmct93cyPGT2Uk4+fmNc78gbXXlPf7TKIZcztrjREYgFqXkTPUzAyhv927mtitURKO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199565; c=relaxed/simple;
	bh=51gP7YIDdbNZvgYnqZpE0cs8chDxPxZLMs5nyFXjjkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfqgNkIiFDO+Ph5EGRf3Cdl6O1xQbb6tgT9JlO5BzZA4f9mdRp6AQ1tjFjCXXNVVm8CX04UfQBoQmueCGY53FGRQoTp0yVc5IzLxUcg1nN+krOTrMZs+mzwvFZSeEU1SFd06YmwHW4bemoZXwsbeXNSYrFAoelrKfltjdqT2cCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9332DFEC;
	Wed, 12 Jun 2024 06:39:47 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 588923F64C;
	Wed, 12 Jun 2024 06:39:21 -0700 (PDT)
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
Subject: [PATCH v8 2/4] perf: Support PERF_SAMPLE_READ with inherit
Date: Wed, 12 Jun 2024 14:39:09 +0100
Message-ID: <20240612133911.3447625-3-ben.gainey@arm.com>
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

This change allows events to use PERF_SAMPLE_READ with inherit
so long as PERF_SAMPLE_TID is also set. This enables sample based
profiling of a group of counters over a hierarchy of processes or
threads. This is useful, for example, for collecting per-thread
counters/metrics, event based sampling of multiple counters as a unit,
access to the enabled and running time when using multiplexing and so
on.

Prior to this, users were restricted to either collecting aggregate
statistics for a multi-threaded/-process application (e.g. with
"perf stat"), or to sample individual threads, or to profile the entire
system (which requires root or CAP_PERFMON, and may produce much more
data than is required). Theoretically a tool could poll for or otherwise
monitor thread/process creation and construct whatever events the user
is interested in using perf_event_open, for each new thread or process,
but this is racy, can lead to file-descriptor exhaustion, and ultimately
just replicates the behaviour of inherit, but in userspace.

This configuration differs from inherit without PERF_SAMPLE_READ in that
the accumulated event count, and consequently any sample (such as if
triggered by overflow of sample_period) will be on a per-thread rather
than on an aggregate basis.

The meaning of read_format::value field of both PERF_RECORD_READ and
PERF_RECORD_SAMPLE is changed such that if the sampled event uses this
new configuration then the values reported will be per-thread rather
than the global aggregate value. This is a change from the existing
semantics of read_format (where PERF_SAMPLE_READ is used without
inherit), but it is necessary to expose the per-thread counter values,
and it avoids reinventing a separate "read_format_thread" field that
otherwise replicates the same behaviour. This change should not break
existing tools, since this configuration was not previously valid and
was rejected by the kernel. Tools that opt into this new mode will need
to account for this when calculating the counter delta for a given
sample. Tools that wish to have both the per-thread and aggregate value
can perform the global aggregation themselves from the per-thread
values.

The change to read_format::value does not affect existing valid
perf_event_attr configurations, nor does it change the behaviour of
calls to "read" on an event descriptor. Both continue to report the
aggregate value for the entire thread/process hierarchy. The difference
between the results reported by "read" and PERF_RECORD_SAMPLE in this
new configuration is justified on the basis that it is not (easily)
possible for "read" to target a specific thread (the caller only has
the fd for the original parent event).

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 include/linux/perf_event.h |  3 ++-
 kernel/events/core.c       | 55 ++++++++++++++++++++++++++++----------
 2 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c0c6c70bb9f1..291c232bd3aa 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -965,7 +965,8 @@ struct perf_event_context {
 	 * The count of events for which using the switch-out fast path
 	 * should be avoided.
 	 *
-	 * Sum (event->pending_sigtrap + event->pending_work)
+	 * Sum (event->pending_sigtrap + event->pending_work
+	 *      + (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ)))
 	 *
 	 * The SIGTRAP is targeted at ctx->task, as such it won't do changing
 	 * that until the signal is delivered.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c9cb22304d11..3ad79ce8634b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1767,6 +1767,14 @@ perf_event_groups_next(struct perf_event *event, struct pmu *pmu)
 		event = rb_entry_safe(rb_next(&event->group_node),	\
 				typeof(*event), group_node))
 
+/*
+ * Does the event attribute request inherit with PERF_SAMPLE_READ
+ */
+static inline bool has_inherit_and_sample_read(struct perf_event_attr *attr)
+{
+	return attr->inherit && (attr->sample_type & PERF_SAMPLE_READ);
+}
+
 /*
  * Add an event from the lists for its context.
  * Must be called with ctx->mutex and ctx->lock held.
@@ -1797,6 +1805,8 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 		ctx->nr_user++;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat++;
+	if (has_inherit_and_sample_read(&event->attr))
+		local_inc(&ctx->nr_no_switch_fast);
 
 	if (event->state > PERF_EVENT_STATE_OFF)
 		perf_cgroup_event_enable(event, ctx);
@@ -2021,6 +2031,8 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 		ctx->nr_user--;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat--;
+	if (has_inherit_and_sample_read(&event->attr))
+		local_dec(&ctx->nr_no_switch_fast);
 
 	list_del_rcu(&event->event_entry);
 
@@ -3537,6 +3549,11 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 				/*
 				 * Must not swap out ctx when there's pending
 				 * events that rely on the ctx->task relation.
+				 *
+				 * Likewise, when a context contains inherit +
+				 * SAMPLE_READ events they should be switched
+				 * out using the slow path so that they are
+				 * treated as if they were distinct contexts.
 				 */
 				raw_spin_unlock(&next_ctx->lock);
 				rcu_read_unlock();
@@ -4552,8 +4569,11 @@ static void __perf_event_read(void *info)
 	raw_spin_unlock(&ctx->lock);
 }
 
-static inline u64 perf_event_count(struct perf_event *event)
+static inline u64 perf_event_count(struct perf_event *event, bool self)
 {
+	if (self)
+		return local64_read(&event->count);
+
 	return local64_read(&event->count) + atomic64_read(&event->child_count);
 }
 
@@ -5486,7 +5506,7 @@ static u64 __perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *
 	mutex_lock(&event->child_mutex);
 
 	(void)perf_event_read(event, false);
-	total += perf_event_count(event);
+	total += perf_event_count(event, false);
 
 	*enabled += event->total_time_enabled +
 			atomic64_read(&event->child_total_time_enabled);
@@ -5495,7 +5515,7 @@ static u64 __perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *
 
 	list_for_each_entry(child, &event->child_list, child_list) {
 		(void)perf_event_read(child, false);
-		total += perf_event_count(child);
+		total += perf_event_count(child, false);
 		*enabled += child->total_time_enabled;
 		*running += child->total_time_running;
 	}
@@ -5577,14 +5597,14 @@ static int __perf_read_group_add(struct perf_event *leader,
 	/*
 	 * Write {count,id} tuples for every sibling.
 	 */
-	values[n++] += perf_event_count(leader);
+	values[n++] += perf_event_count(leader, false);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
 	if (read_format & PERF_FORMAT_LOST)
 		values[n++] = atomic64_read(&leader->lost_samples);
 
 	for_each_sibling_event(sub, leader) {
-		values[n++] += perf_event_count(sub);
+		values[n++] += perf_event_count(sub, false);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 		if (read_format & PERF_FORMAT_LOST)
@@ -6164,7 +6184,7 @@ void perf_event_update_userpage(struct perf_event *event)
 	++userpg->lock;
 	barrier();
 	userpg->index = perf_event_index(event);
-	userpg->offset = perf_event_count(event);
+	userpg->offset = perf_event_count(event, false);
 	if (userpg->index)
 		userpg->offset -= local64_read(&event->hw.prev_count);
 
@@ -7224,7 +7244,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 	u64 values[5];
 	int n = 0;
 
-	values[n++] = perf_event_count(event);
+	values[n++] = perf_event_count(event, has_inherit_and_sample_read(&event->attr));
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
 		values[n++] = enabled +
 			atomic64_read(&event->child_total_time_enabled);
@@ -7242,14 +7262,15 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 }
 
 static void perf_output_read_group(struct perf_output_handle *handle,
-			    struct perf_event *event,
-			    u64 enabled, u64 running)
+				   struct perf_event *event,
+				   u64 enabled, u64 running)
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
 	unsigned long flags;
 	u64 values[6];
 	int n = 0;
+	bool self = has_inherit_and_sample_read(&event->attr);
 
 	/*
 	 * Disabling interrupts avoids all counter scheduling
@@ -7269,7 +7290,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	    (leader->state == PERF_EVENT_STATE_ACTIVE))
 		leader->pmu->read(leader);
 
-	values[n++] = perf_event_count(leader);
+	values[n++] = perf_event_count(leader, self);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
 	if (read_format & PERF_FORMAT_LOST)
@@ -7284,7 +7305,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		    (sub->state == PERF_EVENT_STATE_ACTIVE))
 			sub->pmu->read(sub);
 
-		values[n++] = perf_event_count(sub);
+		values[n++] = perf_event_count(sub, self);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 		if (read_format & PERF_FORMAT_LOST)
@@ -7305,6 +7326,10 @@ static void perf_output_read_group(struct perf_output_handle *handle,
  * The problem is that its both hard and excessively expensive to iterate the
  * child list, not to mention that its impossible to IPI the children running
  * on another CPU, from interrupt/NMI context.
+ *
+ * Instead the combination of PERF_SAMPLE_READ and inherit will track per-thread
+ * counts rather than attempting to accumulate some value across all children on
+ * all cores.
  */
 static void perf_output_read(struct perf_output_handle *handle,
 			     struct perf_event *event)
@@ -12034,10 +12059,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	local64_set(&hwc->period_left, hwc->sample_period);
 
 	/*
-	 * We currently do not support PERF_SAMPLE_READ on inherited events.
+	 * We do not support PERF_SAMPLE_READ on inherited events unless
+	 * PERF_SAMPLE_TID is also selected, which allows inherited events to
+	 * collect per-thread samples.
 	 * See perf_output_read().
 	 */
-	if (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ))
+	if (has_inherit_and_sample_read(attr) && !(attr->sample_type & PERF_SAMPLE_TID))
 		goto err_ns;
 
 	if (!has_branch_stack(event))
@@ -13061,7 +13088,7 @@ static void sync_child_event(struct perf_event *child_event)
 			perf_event_read_event(child_event, task);
 	}
 
-	child_val = perf_event_count(child_event);
+	child_val = perf_event_count(child_event, false);
 
 	/*
 	 * Add back the child's count to the parent's count:
-- 
2.45.2

