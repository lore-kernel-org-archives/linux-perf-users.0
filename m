Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582845;
	b=ros/uYoGtC5VkeVKeo9i/L90vOQmSCDvFmPlls6bkK46twW5eA28S5OAvifHqntCYj5t
	 J8YF6vt2VTm2C1JgZ10a41p+Deca+dzrkgRrNgkcg88S6/D9tzAdxMyg3e8FBxfFaqWC8
	 Iz2PnPpUn72MjfUcHG+wz+xwg2jnm0xxXHKRbmg1UvixQ83mx4/wjR7g4l5bgVzyXKv9k
	 Chutz3ODVrBnO6OZMuQpsQE0dIxmgsCi/GjbEdWtr5D4AzHecUY8D/5AJhBIClPps+CGb
	 wLuu6qqsIxgitvfV3vA/WjnzJV7l/zkOmNi9owVPRbAKHsCvpRm6rH82GTSdpN9SNCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=oodsmLZsOb8DWnDpRbfxQq6nNahrCBIUV5LClRaFCg4=;
	b=QXacVBAmmLivUocKLZ33Z4TvdY4mpyCj8c0TRZtJoDdZl6T+DgVNO7tvnFqi6wf10GPZ
	 cwaGnDhgjyAf2Po4veDVpslflQeNbTgRenCWCcfbPRjHmNC18y2R5qStyv6RMR8EQKiaf
	 Ml3ynLe+wkIwO/QubsdgJeV88pF7TvywtcBRzL9vNr6/rFzgFXDfcPO+INC9lfTWpf2hJ
	 Z+vV+N6ss7yHRWCRyCYpQopc14UTeKiHRIOKtltq3sW3Ye7BHVC2vkUhN+GK/Y00QhY++
	 wifbgkltzgehrUgOw99w5/qWXm9utR8965SYymxSI2tH516sT9hTc1WEPzx2XiJ2L9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DwuWuLd5;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DF5606A31E
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 05:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5DF5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DwuWuLd5
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3854627c1c8so7571558eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 21:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795582844; x=1796187644; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oodsmLZsOb8DWnDpRbfxQq6nNahrCBIUV5LClRaFCg4=;
        b=DwuWuLd5I5k33CHs7266kbN6Qms/0ZoRllEm6W1imW+/RFa1O7J7ng8A9x4QBbxQbw
         EQSHZFV5ugnw+8zErQ4L39PsXzCCvfPKflkqVnFELv132XwFMfUDPlaoMRdmZdcNBYEX
         hdbMlue9eMoQuuiIuy97NQ9B1d++SpcNSyoUSfESPEZEUowaf+5mgNsff7DRgL1Xs4va
         KpOXYb6CVJzcNLi9dQQy+fPLion+iR0YW97W6BPoqVmBa7CgcobX6vb1lqIcLY28GsX4
         Ar6tfBmT7f2xEdoJglrCWhWGfjmqaMqKzi16OMA3EDq40di4ltJ/gbnm+6NMfF7EK0pr
         eh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795582844; x=1796187644;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oodsmLZsOb8DWnDpRbfxQq6nNahrCBIUV5LClRaFCg4=;
        b=RW9JO4HTefn/rsCmU5k6DfE6ZZKwqfRpk982HHzScaH6Ipr/YXxXnCUBKIRwBIEtZu
         X54Cltakg6usm5X1aKSUlseHJqIOOZfmiFigXrBlLU3rfPJua23MO1GJru9vwsl9nQgM
         AXGS+/0JJnACOHpmQcn3qYreU7pFJhFJWBxOsDEgQ5UDZBs5/CKwfRXi3ypupjf6J1Ws
         g5M1kwXQHR/igheUqZKXiHZIH6YstjFqaxUetVY80H3+qQmnVWhnq1C90yNT7oShKq5L
         ZO9SaCLAheCDQyAVbbM7/szlEMAdxjWuYqgg4k5KrIdrn+vgQAEEhwu/DnYTPRenFSB5
         NsSQ==
X-Forwarded-Encrypted: i=1; AL+hErETzveMwoFBzow6irLrihnuFQocBi+hD7sOerOJ2AzLefKUQbeA7UUlul4UwQeicQeP95r5DNaKtqCMPaXhVDhW@vger.kernel.org
X-Gm-Message-State: APuU4Z/2wKWRtTXvHWQGeC31LP5gAgufC0cmqi8m7UUQFwzsHD1lxUST
	ZDNTbL/27LkrGxPRRpVwI6IE4ySxQoJctOweNVfU4Cp18YVGo4VqgaryLYC/ioWdp3Lpe4Rxkl6
	Stkrw8l1hag==
X-Received: from dyz18.prod.google.com ([2002:a05:693c:4092:b0:386:aa47:53f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:37c8:b0:386:a0d1:1b41
 with SMTP id 5a478bee46e88-386a0d136aemr17859351eec.34.1795582843377; Tue, 24
 Nov 2026 21:00:43 -0800 (PST)
Date: Tue, 24 Nov 2026 21:00:39 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <80d983c5713537f5743b69e9b35ced1177e4732e.1795582691.git.irogers@google.com>
Subject: [PATCH v2 1/2] perf/core: Add PERF_EVENT_STATE_ON to fix filtered
 event enabled time
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Andi Kleen <ak@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Perf events that are filtered out during sched_in (via pmu->filter() on
hybrid/heterogeneous systems, or event_filter_match() for task+CPU and
cgroup events) remain unscheduled while the context is active. Because
enabled events previously rested in PERF_EVENT_STATE_INACTIVE, context
time accrued into total_time_enabled even when the event could not be
scheduled on the current CPU or PMU, while total_time_running did not
increase. Tools assume total_time_enabled > total_time_running implies
counter multiplexing and scale counts by enabled / running, producing
severely inaccurate counts:
https://lore.kernel.org/lkml/20250627192417.1157736-13-irogers@google.com/

For example:
- A task+CPU event opened on 1 CPU of a 128-CPU system accrues enabled
  time whenever the task runs on the other 127 CPUs, potentially scaling
  the count 128x.
- On hybrid systems, unpinned task events accrue enabled time while the
  task runs on a different core type, causing bogus multiplexing scaling
  (such as the 28.05% / 96.79% scaling on cpu_atom and cpu_core seen in
  commit d9db9c8db56c ("perf test: Fix perf stat --bpf-counters on
  hybrid machines"), which caused count mismatches until
  commit b02027776ac5 ("perf tests: Fix flakiness in BPF counters test
  on hybrid systems") pinned the workload to a single CPU) and
  preventing perf stat from accurately merging common hybrid events
  across core types.

Introduce PERF_EVENT_STATE_ON (0) for events that are enabled and not
scheduled, reserving PERF_EVENT_STATE_INACTIVE (1) for flexible events
that matched filters during merge_sched_in() but failed to go onto the
PMU due to insufficient counters or exclusivity constraints:

- total_time_enabled only accrues in PERF_EVENT_STATE_INACTIVE and
  PERF_EVENT_STATE_ACTIVE; filtered-out events stay in
  PERF_EVENT_STATE_ON and accrue neither enabled nor running time.
- Track INACTIVE flexible group leaders on epc->flexible_inactive (via
  event->active_list) so __pmu_ctx_sched_out() transitions them and
  their siblings back to PERF_EVENT_STATE_ON without touching filtered
  ON events, preserving the context-switch scalability of state-based
  timekeeping.
- Handle PERF_EVENT_STATE_INACTIVE in event_sched_out() without calling
  pmu->del() or decrementing active_oncpu, and serialize perf_event_read()
  on ctx->lock for both ON and INACTIVE events.

Fixes: 0d3d73aac2ff ("perf/core: Rewrite event timekeeping")
Signed-off-by: Ian Rogers <irogers@google.com>
---
Resending as a non-RFC v2 following Namhyung Kim's agreement on adding a
separate state for filtered events and Ingo Molnar's suggestion to
re-send:
https://lore.kernel.org/lkml/CAP-5=fV5gtSQOPkOLaAauBcwjgs1ohADs5O3GF+bJOx2tSynwQ@mail.gmail.com/
https://lore.kernel.org/lkml/aS3WXn4nz9GE87bM@gmail.com/

v2: Make the untested RFC v1 functional, tested, and handle all state
    transitions:
    https://lore.kernel.org/lkml/20250716223924.825772-1-irogers@google.com/
  - Add epc->flexible_inactive (and handle sibling promotion on group
    detach) so __pmu_ctx_sched_out() resets INACTIVE flexible groups
    back to PERF_EVENT_STATE_ON on context switch / rotation.
  - Transition flexible groups that fail to schedule in merge_sched_in()
    (including after can_add_hw == 0 or partial group rollback) to
    PERF_EVENT_STATE_INACTIVE, while pinned groups still enter
    PERF_EVENT_STATE_ERROR.
  - Handle PERF_EVENT_STATE_INACTIVE in event_sched_out() without
    calling pmu->del() or decrementing active_oncpu/nr_freq, and update
    the userpage.
  - Drop premature PERF_EVENT_STATE_ACTIVE in __perf_event_enable(),
    match INACTIVE leader state when enabling a sibling, serialize
    perf_event_read() on ctx->lock for both ON and INACTIVE, and drop
    invalid ERROR -> OFF disable() edge from the state diagram comment.
---
 include/linux/perf_event.h | 60 ++++++++++++++++----------
 kernel/events/core.c       | 86 +++++++++++++++++++++++++++-----------
 2 files changed, 101 insertions(+), 45 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e1e11500df09..715f564a3f96 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -639,28 +639,44 @@ struct perf_addr_filter_range {
 /*
  * The normal states are:
  *
- *            ACTIVE    --.
- *               ^        |
- *               |        |
- *       sched_{in,out}() |
- *               |        |
- *               v        |
- *      ,---> INACTIVE  --+ <-.
- *      |                 |   |
- *      |                {dis,en}able()
- *   sched_in()           |   |
- *      |       OFF    <--' --+
- *      |                     |
- *      `--->  ERROR    ------'
+ *                         OFF <----disable()-------.
+ *                          |         ^             |
+ *    .-----------------> enable()    |             |
+ *    |                     |  .------'             |
+ *    |                     v /                     |
+ *  ERROR      .---------> ON <-----------.         |
+ *    ^        |            |             |         |
+ *    |      filter <-- sched_in()  sched_out()     |
+ *    |                     |             |         |
+ *    +-(lack of counters)--+             |         |
+ *    v                     v             |         |
+ *  INACTIVE              ACTIVE          |         |
+ *    |                     |             |         |
+ *    '---------------------+-------------+---------'
  *
  * That is:
  *
- * sched_in:       INACTIVE          -> {ACTIVE,ERROR}
- * sched_out:      ACTIVE            -> INACTIVE
- * disable:        {ACTIVE,INACTIVE} -> OFF
- * enable:         {OFF,ERROR}       -> INACTIVE
+ * sched_in:       ON                   -> {ON,ERROR,INACTIVE,ACTIVE}
+ * sched_out:      {INACTIVE,ACTIVE}    -> ON
+ * disable:        {ON,INACTIVE,ACTIVE} -> OFF
+ * enable:         {OFF,ERROR}          -> ON
  *
- * Where {OFF,ERROR} are disabled states.
+ * Where {ON,INACTIVE,ACTIVE} are enabled states and {OFF,ERROR} are disabled
+ * states.
+ *
+ * ON differs from INACTIVE as enabled time only increases for INACTIVE and
+ * ACTIVE events, running time only increases for ACTIVE events. A filter, such
+ * as the task, cgroup, CPU, or PMU an event should be scheduled on, can cause
+ * an event during sched_in to remain in the ON state, while lack of counters
+ * or exclusivity constraints move pinned events to ERROR and flexible events
+ * to INACTIVE.
+ *
+ * Additional special-case transitions not shown above:
+ *  - enable() on a sibling of an INACTIVE group leader moves directly from ON
+ *    to INACTIVE when the context is active and filters match;
+ *  - sched_out() with pending_disable moves {INACTIVE,ACTIVE} directly to OFF;
+ *  - detaching a group sibling that requires a group leader (such as
+ *    aux_output or PERF_EV_CAP_SIBLING) disables it into ERROR.
  *
  * Then we have the {EXIT,REVOKED,DEAD} states which are various shades of
  * defunct events:
@@ -682,9 +698,10 @@ enum perf_event_state {
 	PERF_EVENT_STATE_REVOKED	= -4, /* pmu gone, must not touch */
 	PERF_EVENT_STATE_EXIT		= -3, /* task died, still inherit */
 	PERF_EVENT_STATE_ERROR		= -2, /* scheduling error, can enable */
-	PERF_EVENT_STATE_OFF		= -1,
-	PERF_EVENT_STATE_INACTIVE	=  0,
-	PERF_EVENT_STATE_ACTIVE		=  1,
+	PERF_EVENT_STATE_OFF		= -1, /* regular disabled event */
+	PERF_EVENT_STATE_ON		=  0, /* enabled but not scheduled */
+	PERF_EVENT_STATE_INACTIVE	=  1, /* not scheduled due to lack of counters */
+	PERF_EVENT_STATE_ACTIVE		=  2, /* scheduled and counting */
 };
 
 struct file;
@@ -969,6 +986,7 @@ struct perf_event_pmu_context {
 
 	struct list_head		pinned_active;
 	struct list_head		flexible_active;
+	struct list_head		flexible_inactive;
 
 	/* Used to identify the per-cpu perf_event_pmu_context */
 	unsigned int			embedded : 1;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 366fca000ff0..cf76e9290cc5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2023,7 +2023,7 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 static inline void perf_event__state_init(struct perf_event *event)
 {
 	event->state = event->attr.disabled ? PERF_EVENT_STATE_OFF :
-					      PERF_EVENT_STATE_INACTIVE;
+					      PERF_EVENT_STATE_ON;
 }
 
 static int __perf_event_read_size(u64 read_format, int nr_siblings)
@@ -2374,6 +2374,8 @@ static void perf_promote_sibling_to_leader(struct perf_event *sibling,
 
 		if (sibling->state == PERF_EVENT_STATE_ACTIVE)
 			list_add_tail(&sibling->active_list, get_event_list(sibling));
+		else if (sibling->state == PERF_EVENT_STATE_INACTIVE)
+			list_add_tail(&sibling->active_list, &sibling->pmu_ctx->flexible_inactive);
 	}
 
 	perf_event__header_size(sibling);
@@ -2473,14 +2475,14 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 {
 	struct perf_event_pmu_context *epc = event->pmu_ctx;
 	struct perf_cpu_pmu_context *cpc = this_cpc(epc->pmu);
-	enum perf_event_state state = PERF_EVENT_STATE_INACTIVE;
+	enum perf_event_state state = PERF_EVENT_STATE_ON;
 
 	// XXX cpc serialization, probably per-cpu IRQ disabled
 
 	WARN_ON_ONCE(event->ctx != ctx);
 	lockdep_assert_held(&ctx->lock);
 
-	if (event->state != PERF_EVENT_STATE_ACTIVE)
+	if (event->state < PERF_EVENT_STATE_INACTIVE)
 		return;
 
 	/*
@@ -2490,6 +2492,17 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 	 */
 	list_del_init(&event->active_list);
 
+	if (event->state == PERF_EVENT_STATE_INACTIVE) {
+		if (event->pending_disable) {
+			event->pending_disable = 0;
+			perf_cgroup_event_disable(event, ctx);
+			state = PERF_EVENT_STATE_OFF;
+		}
+		perf_event_set_state(event, state);
+		perf_event_update_userpage(event);
+		return;
+	}
+
 	perf_pmu_disable(event->pmu);
 
 	event->pmu->del(event, 0);
@@ -2520,7 +2533,7 @@ group_sched_out(struct perf_event *group_event, struct perf_event_context *ctx)
 {
 	struct perf_event *event;
 
-	if (group_event->state != PERF_EVENT_STATE_ACTIVE)
+	if (group_event->state < PERF_EVENT_STATE_INACTIVE)
 		return;
 
 	perf_assert_pmu_disabled(group_event->pmu_ctx->pmu);
@@ -2702,7 +2715,7 @@ static void __perf_event_disable(struct perf_event *event,
 				 struct perf_event_context *ctx,
 				 void *info)
 {
-	if (event->state < PERF_EVENT_STATE_INACTIVE)
+	if (event->state < PERF_EVENT_STATE_ON)
 		return;
 
 	perf_pmu_disable(event->pmu_ctx->pmu);
@@ -2717,7 +2730,7 @@ static void __perf_event_disable(struct perf_event *event,
 
 	/*
 	 * But only mark the leader OFF; the siblings will remain
-	 * INACTIVE.
+	 * ON.
 	 */
 	__event_disable(event, ctx, PERF_EVENT_STATE_OFF);
 
@@ -2859,7 +2872,7 @@ event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
 	perf_log_itrace_start(event);
 
 	if (event->pmu->add(event, PERF_EF_START)) {
-		perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
+		perf_event_set_state(event, PERF_EVENT_STATE_ON);
 		event->oncpu = -1;
 		ret = -EAGAIN;
 		goto out;
@@ -2886,7 +2899,7 @@ group_sched_in(struct perf_event *group_event, struct perf_event_context *ctx)
 	struct perf_event *event, *partial_group = NULL;
 	struct pmu *pmu = group_event->pmu_ctx->pmu;
 
-	if (group_event->state == PERF_EVENT_STATE_OFF)
+	if (group_event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
 	pmu->start_txn(pmu, PERF_PMU_TXN_ADD);
@@ -3261,13 +3274,13 @@ static void __perf_event_enable(struct perf_event *event,
 	struct perf_event *leader = event->group_leader;
 	struct perf_event_context *task_ctx;
 
-	if (event->state >= PERF_EVENT_STATE_INACTIVE ||
+	if (event->state >= PERF_EVENT_STATE_ON ||
 	    event->state <= PERF_EVENT_STATE_ERROR)
 		return;
 
 	ctx_time_freeze(cpuctx, ctx);
 
-	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
+	perf_event_set_state(event, PERF_EVENT_STATE_ON);
 	perf_cgroup_event_enable(event, ctx);
 
 	if (!ctx->is_active)
@@ -3280,8 +3293,11 @@ static void __perf_event_enable(struct perf_event *event,
 	 * If the event is in a group and isn't the group leader,
 	 * then don't put it on unless the group is on.
 	 */
-	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE)
+	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE) {
+		if (leader->state == PERF_EVENT_STATE_INACTIVE)
+			perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 		return;
+	}
 
 	task_ctx = cpuctx->task_ctx;
 	if (ctx->task)
@@ -3304,7 +3320,7 @@ static void _perf_event_enable(struct perf_event *event)
 	struct perf_event_context *ctx = event->ctx;
 
 	raw_spin_lock_irq(&ctx->lock);
-	if (event->state >= PERF_EVENT_STATE_INACTIVE ||
+	if (event->state >= PERF_EVENT_STATE_ON ||
 	    event->state <  PERF_EVENT_STATE_ERROR) {
 out:
 		raw_spin_unlock_irq(&ctx->lock);
@@ -3578,6 +3594,10 @@ static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
 					 &pmu_ctx->flexible_active,
 					 active_list)
 			group_sched_out(event, ctx);
+		list_for_each_entry_safe(event, tmp,
+					 &pmu_ctx->flexible_inactive,
+					 active_list)
+			group_sched_out(event, ctx);
 		/*
 		 * Since we cleared EVENT_FLEXIBLE, also clear
 		 * rotate_necessary, is will be reset by
@@ -4134,6 +4154,21 @@ struct merge_sched_data {
 	enum event_type_t event_type;
 };
 
+static void group_set_inactive(struct perf_event *group_event)
+{
+	struct perf_event *sibling;
+
+	perf_event_set_state(group_event, PERF_EVENT_STATE_INACTIVE);
+
+	for_each_sibling_event(sibling, group_event) {
+		if (sibling->state == PERF_EVENT_STATE_ON)
+			perf_event_set_state(sibling, PERF_EVENT_STATE_INACTIVE);
+	}
+
+	list_add_tail(&group_event->active_list,
+		      &group_event->pmu_ctx->flexible_inactive);
+}
+
 static int merge_sched_in(struct perf_event *event, void *data)
 {
 	struct perf_event_context *ctx = event->ctx;
@@ -4159,7 +4194,7 @@ static int merge_sched_in(struct perf_event *event, void *data)
 			list_add_tail(&event->active_list, get_event_list(event));
 	}
 
-	if (event->state == PERF_EVENT_STATE_INACTIVE) {
+	if (event->state == PERF_EVENT_STATE_ON) {
 		msd->can_add_hw = 0;
 		if (event->attr.pinned) {
 			perf_cgroup_event_disable(event, ctx);
@@ -4173,6 +4208,7 @@ static int merge_sched_in(struct perf_event *event, void *data)
 		} else {
 			struct perf_cpu_pmu_context *cpc = this_cpc(event->pmu_ctx->pmu);
 
+			group_set_inactive(event);
 			event->pmu_ctx->rotate_necessary = 1;
 			perf_mux_hrtimer_restart(cpc);
 			group_update_userpage(event);
@@ -4702,10 +4738,10 @@ static int event_enable_on_exec(struct perf_event *event,
 		return 0;
 
 	event->attr.enable_on_exec = 0;
-	if (event->state >= PERF_EVENT_STATE_INACTIVE)
+	if (event->state >= PERF_EVENT_STATE_ON)
 		return 0;
 
-	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
+	perf_event_set_state(event, PERF_EVENT_STATE_ON);
 
 	return 1;
 }
@@ -5032,13 +5068,13 @@ static int perf_event_read(struct perf_event *event, bool group)
 		preempt_enable();
 		ret = data.ret;
 
-	} else if (state == PERF_EVENT_STATE_INACTIVE) {
+	} else if (state >= PERF_EVENT_STATE_ON) {
 		struct perf_event_context *ctx = event->ctx;
 		unsigned long flags;
 
 		raw_spin_lock_irqsave(&ctx->lock, flags);
-		state = event->state;
-		if (state != PERF_EVENT_STATE_INACTIVE) {
+		if (event->state != state) {
+			state = event->state;
 			raw_spin_unlock_irqrestore(&ctx->lock, flags);
 			goto again;
 		}
@@ -5079,6 +5115,7 @@ __perf_init_event_pmu_context(struct perf_event_pmu_context *epc, struct pmu *pm
 	INIT_LIST_HEAD(&epc->pmu_ctx_entry);
 	INIT_LIST_HEAD(&epc->pinned_active);
 	INIT_LIST_HEAD(&epc->flexible_active);
+	INIT_LIST_HEAD(&epc->flexible_inactive);
 	atomic_set(&epc->refcount, 1);
 }
 
@@ -5314,6 +5351,7 @@ static void put_pmu_ctx(struct perf_event_pmu_context *epc)
 
 	WARN_ON_ONCE(!list_empty(&epc->pinned_active));
 	WARN_ON_ONCE(!list_empty(&epc->flexible_active));
+	WARN_ON_ONCE(!list_empty(&epc->flexible_inactive));
 
 	raw_spin_unlock_irqrestore(&ctx->lock, flags);
 
@@ -9155,7 +9193,7 @@ perf_iterate_ctx(struct perf_event_context *ctx,
 
 	list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
 		if (!all) {
-			if (event->state < PERF_EVENT_STATE_INACTIVE)
+			if (event->state < PERF_EVENT_STATE_ON)
 				continue;
 			if (!event_filter_match(event))
 				continue;
@@ -9179,7 +9217,7 @@ static void perf_iterate_sb_cpu(perf_iterate_f output, void *data)
 		if (!smp_load_acquire(&event->ctx))
 			continue;
 
-		if (event->state < PERF_EVENT_STATE_INACTIVE)
+		if (event->state < PERF_EVENT_STATE_ON)
 			continue;
 		if (!event_filter_match(event))
 			continue;
@@ -13554,7 +13592,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	event->ns		= get_pid_ns(task_active_pid_ns(current));
 	event->id		= atomic64_inc_return(&perf_event_id);
 
-	event->state		= PERF_EVENT_STATE_INACTIVE;
+	event->state		= PERF_EVENT_STATE_ON;
 
 	if (parent_event)
 		event->event_caps = parent_event->event_caps;
@@ -14600,7 +14638,7 @@ static void __perf_pmu_install_event(struct pmu *pmu,
 	event->pmu_ctx = epc;
 
 	if (event->state >= PERF_EVENT_STATE_OFF)
-		event->state = PERF_EVENT_STATE_INACTIVE;
+		event->state = PERF_EVENT_STATE_ON;
 	perf_install_in_context(ctx, event, cpu);
 
 	/*
@@ -15038,8 +15076,8 @@ inherit_event(struct perf_event *parent_event,
 	 * not its attr.disabled bit.  We hold the parent's mutex,
 	 * so we won't race with perf_event_{en, dis}able_family.
 	 */
-	if (parent_state >= PERF_EVENT_STATE_INACTIVE)
-		child_event->state = PERF_EVENT_STATE_INACTIVE;
+	if (parent_state >= PERF_EVENT_STATE_ON)
+		child_event->state = PERF_EVENT_STATE_ON;
 	else
 		child_event->state = PERF_EVENT_STATE_OFF;
 
-- 
2.56.1.831.g720f3f5937-goog

