Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED053B6368
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456340; cv=none; b=EqpvgxVsdjl4djQHJmViKCUHhUyyxEeIoxEVp9mUICji1UFjSKPOOFDVecpNtxIawQSoboc8gsQpIlwPFD6Y3C7Nzgy1XJdWpd7aRk0prGKXn8x6QKm+IExMlveGfgqs/oPh7Q4gYxSQaplzB3ooUbjFWIGlda8s9NVxoSv6A0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456340; c=relaxed/simple;
	bh=SWC+vxtCtrw3Vdxk+vcIHvxa7pc9Uh7R4J7YDHCe2Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b/gARwaWxcpO0MgH2pDoL/irlvcPsqz7clDvqLwVqbsR0G+dSq27rQWYqB3iCceLUcuimXYLM1+ir9LIB9uwUokTHMxKah7fVv0cIedF+5uXhHkllrkmK/PjbtOvPiPFhpQnHPPVLRYZNapMODMyl+uTKFFUETt49SNhWtGLno4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZ+l2yS8; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ+l2yS8"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so4334792a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 02:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777456338; x=1778061138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVpegQtvf/2jkW8Z8yowj+e6dpZ2jzjTHSP/4hKqvuM=;
        b=QZ+l2yS8GLPyT7TFXLgk6KPhIREG6W+Mts8buqVfuM2cj0dzHF5fh50m7EnAee/X9E
         A6v4kh5slS5qAxIjvlkdCLjxO0VHEE9q/+uS625ckMyt/lQp/19NuvIShC4XmTV57U7e
         v8pMzbqDYUoiyaA6ierjGZAc44wOfFnJoxDIDBi40ZYIuSKDIczTo1MoMKanIG+E2e0C
         f7apPnObJ/tOK7PCWfXdto3Nr4gWNt2GO4Mcktl3g1SZJZXjeob7Pi/hWP/yV34ChC2M
         UG6gcX/5Zbs4pfzaOuOJ6eF1tAVo5Zdd46yx54hDOcDTPc+UXA51OKDLpOcStlLHeBKT
         rNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777456338; x=1778061138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVpegQtvf/2jkW8Z8yowj+e6dpZ2jzjTHSP/4hKqvuM=;
        b=e144rjWDj8aoDKhmtexrwXwIwtDL5Kf0GZKgTn19QTPwhtwasV8EerNJra9G/kQUDc
         rokKFL6c484xEm2/E7JqchzwL3fGH/W2sCLe2ZvaD+i+4mjRa91DyMrgk3jpCFsbB6+d
         vx7Ze9wUKRhYg7iLCn239iKBladrscpDHL0UdEHP7Zaiz0qa+57fnMmQimUgupDa5Lzv
         OAqdh+JfPxMRwfPWroZidueTEr9iDRbtDbFG1N0LDhUPOr++oEsByctZrOkRY/DDuek3
         UZtM7nTxmPTgvUTRn/h+9QYwqoRadDAQ/q2ufE0MJLLlThAFBfknXVXlGLsaH8qijemW
         O43Q==
X-Forwarded-Encrypted: i=1; AFNElJ+N6o4If6TEjw9FCQD2zdX3qxPHb+c64qZTpdiUckN9VTu92Zw5X23x5kJLkfIULKOlLQFFt4SqY8rRGmiDqwWJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/xQD3p8uNIwZBQH5rPt6JvYrCNjkbBeddzhxmcdt9bgPOw8tl
	HJUpCOLxWCRefVgRlWRoWJh/zo5nUbMpLwhE+Ufe3HbSLe4/inacebZ4
X-Gm-Gg: AeBDievqjM4QS0Wsn8nOLtY4Pyhm1B+nBXdkOUEbtdAUPhe+f0u36dCnGmPvAUb/Vbr
	59L39y+PHCc7NTu5BF3xQdZYdN4ELeeX/22EYcBQUCbJSCcTiEbdbAmEtDej7qjlx30cewstHDN
	gDShjnEPGoAnChp83l/AXcV297jhG3OrCxuCSFXEFWPD3Qg3b1xkoWkMV3ib9rPPr8vW+FNHvXm
	QjYNTXuJd5sN1mq1d2BqdX5ZcxA5C5q8bgCMwdzaOA9KKVoqH5XtUWsSPPuYQTiRSnXLOgccvUp
	9vRnBFKyAU0rsFGtHTxZ35sCBP0XCa+Wrn4RrVgKwifF7v/tLwYfL1TpsmnSQ21jiq3WPdQB9Eg
	3SfFU0zSGekrSj6ejoP6jeGXbQUEO0dfQaa+0CWD858KHoFFGKZJKJDIlQx2nHYV5PeHwp6fbbV
	kNDT6Y0aCMgWalMhSgEG3dlZO2tQlSZ7Yqk7gNPCmIz7Y3CEo=
X-Received: by 2002:a05:6a20:12cb:b0:39b:9644:6ea4 with SMTP id adf61e73a8af0-3a3af3e0bcfmr3358603637.16.1777456338053;
        Wed, 29 Apr 2026 02:52:18 -0700 (PDT)
Received: from localhost.localdomain ([165.132.143.163])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd64f09e5sm1463207a12.16.2026.04.29.02.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 02:52:17 -0700 (PDT)
From: Minwoo Ahn <mwahn402@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Jinkyu Jeong <jinkyu@yonsei.ac.kr>,
	Minwoo Ahn <mwahn402@gmail.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] perf/core: Fix sampling period inconsistency across CPU migration
Date: Wed, 29 Apr 2026 09:51:34 +0000
Message-ID: <20260429095134.10049-1-mwahn402@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


When per-task software events are sampled, period_left is not
managed consistently when task migration happens. The perf_event
may observe a different hw_perf_event::period_left on the new CPU,
breaking the sampling periodicity. Even if a task was near its
sampling point, it would use a stale period_left after migration.

Introduce struct perf_task_context as a per-task container to
preserve period_left across CPU migrations. A separate structure
is used rather than adding fields to hw_perf_event, because
hw_perf_event is a general-purpose structure shared by all event
types (hardware, software, tracepoint, breakpoint, etc.) and
embedding per-task sampling state there would bloat it for the
majority of events that do not need it. perf_task_context is only
allocated for per-task software sampling events.

Multiple per-CPU perf_event instances originating from the same
perf_event_open caller share a single perf_task_context via
refcounting. The perf_event owner field is used to distinguish events
from different perf_event_open callers, preventing unrelated sampling
sessions from interfering with each other. For inherited events
(where owner is NULL), child events are matched by verifying that
their parent events share the same perf_task_ctxp, ensuring only
events from the same profiling session share context. The
allocation condition for inherited events checks that the parent
event actually has a perf_task_ctxp, ensuring only genuine
software events propagate the context. The perf_task_context
lookup uses perf_lock_task_context() to safely access the task's
event context under proper RCU and IRQ protection.

perf_task_context serves purely as a transport for period_left
across CPU migrations. On event removal (swevent_del for non-clock
events, cancel_hrtimer for clock events), hw_perf_event::period_left
is backed up to perf_task_context::period_left. On event addition
(swevent_add for non-clock events, start_hrtimer for clock events),
perf_task_context::period_left is restored to hw_perf_event::period_left.
During normal operation between migrations, hw_perf_event::period_left
remains the sole working copy, keeping existing code paths unaffected.

To reproduce, force CPU migration during task-clock sampling:

  $ sysbench cpu --threads=1 --time=60 run &
  $ sleep 0.1
  $ TID=$(ls /proc/$!/task/ | grep -v "^$!$")
  $ perf record -e task-clock -c 1000000000 -t $TID &

  # Force migration across CPUs every 1.2 seconds
  $ while kill -0 $TID 2>/dev/null; do
        taskset -p -c 0 $TID; sleep 1.2
        taskset -p -c 1 $TID; sleep 1.2
        taskset -p -c 2 $TID; sleep 1.2
    done

  # Check sample intervals (expected: ~1.000s each)
  $ perf script -F time | \
        awk 'NR==1 {prev=$1; next} {print $1-prev; prev=$1}'

Without this patch, sample intervals show significant deviation
from the expected 1-second period after each migration. With this
patch, intervals remain consistent.

Co-developed-by: Jinkyu Jeong <jinkyu@yonsei.ac.kr>
Signed-off-by: Jinkyu Jeong <jinkyu@yonsei.ac.kr>
Signed-off-by: Minwoo Ahn <mwahn402@gmail.com>
---
Changes in v4:
- Fix perf_event_context reference leak by adding put_ctx() after
  perf_lock_task_context()
- Use parent event lineage (parent->perf_task_ctxp) to match inherited
  events, preventing cross-session interference when multiple profiling
  sessions monitor the same task

Changes in v3:
- Move struct perf_task_context and perf_event_equal_task_ctx macro
  inside #ifdef CONFIG_PERF_EVENTS guard to fix build error on
  configs where CONFIG_PERF_EVENTS is disabled (local64_t undefined)

Changes in v2:
- Use perf_lock_task_context() to safely access the task's event context,
  avoiding a potential use-after-free and IRQ inversion deadlock
- Tighten allocation condition for inherited events by checking
  parent_event->perf_task_ctxp instead of just parent_event

 include/linux/perf_event.h | 18 +++++++++++
 kernel/events/core.c       | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea..f8c973325c76 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -829,6 +829,9 @@ struct perf_event {
 	u16				read_size;
 	struct hw_perf_event		hw;
 
+	/* Per-task sampling state for sw events, survives CPU migration */
+	struct perf_task_context	*perf_task_ctxp;
+
 	struct perf_event_context	*ctx;
 	/*
 	 * event->pmu_ctx points to perf_event_pmu_context in which the event
@@ -1207,6 +1210,21 @@ perf_cgroup_from_task(struct task_struct *task, struct perf_event_context *ctx)
 
 #ifdef CONFIG_PERF_EVENTS
 
+#define perf_event_equal_task_ctx(a1, a2)	\
+	((a1)->config == (a2)->config &&	\
+	 (a1)->sample_period == (a2)->sample_period)
+
+/**
+ * struct perf_task_context - per-task software event context
+ *
+ * Shared across per-CPU perf_event instances of the same task to
+ * preserve period_left across CPU migrations.
+ */
+struct perf_task_context {
+	refcount_t			refcount;
+	local64_t			period_left;
+};
+
 extern struct perf_event_context *perf_cpu_task_ctx(void);
 
 extern void *perf_aux_output_begin(struct perf_output_handle *handle,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6d1f8bad7e1c..eec0e822ef6e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5740,6 +5740,13 @@ static bool exclusive_event_installable(struct perf_event *event,
 
 static void perf_free_addr_filters(struct perf_event *event);
 
+static void perf_put_task_ctxp(struct perf_event *event)
+{
+	if (event->perf_task_ctxp &&
+	    refcount_dec_and_test(&event->perf_task_ctxp->refcount))
+		kfree(event->perf_task_ctxp);
+}
+
 /* vs perf_event_alloc() error */
 static void __free_event(struct perf_event *event)
 {
@@ -5761,6 +5768,9 @@ static void __free_event(struct perf_event *event)
 	if (event->attach_state & PERF_ATTACH_TASK_DATA)
 		detach_perf_ctx_data(event);
 
+	if (event->perf_task_ctxp)
+		perf_put_task_ctxp(event);
+
 	if (event->destroy)
 		event->destroy(event);
 
@@ -11054,9 +11064,14 @@ static void perf_swevent_read(struct perf_event *event)
 static int perf_swevent_add(struct perf_event *event, int flags)
 {
 	struct swevent_htable *swhash = this_cpu_ptr(&swevent_htable);
+	struct perf_task_context *ctxp = event->perf_task_ctxp;
 	struct hw_perf_event *hwc = &event->hw;
 	struct hlist_head *head;
 
+	if (ctxp)
+		local64_set(&hwc->period_left,
+			    local64_read(&ctxp->period_left));
+
 	if (is_sampling_event(event)) {
 		hwc->last_period = hwc->sample_period;
 		perf_swevent_set_period(event);
@@ -11076,7 +11091,13 @@ static int perf_swevent_add(struct perf_event *event, int flags)
 
 static void perf_swevent_del(struct perf_event *event, int flags)
 {
+	struct perf_task_context *ctxp = event->perf_task_ctxp;
+
 	hlist_del_rcu(&event->hlist_entry);
+
+	if (ctxp)
+		local64_set(&ctxp->period_left,
+			    local64_read(&event->hw.period_left));
 }
 
 static void perf_swevent_start(struct perf_event *event, int flags)
@@ -12203,12 +12224,17 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
 
 static void perf_swevent_start_hrtimer(struct perf_event *event)
 {
+	struct perf_task_context *ctxp = event->perf_task_ctxp;
 	struct hw_perf_event *hwc = &event->hw;
 	s64 period;
 
 	if (!is_sampling_event(event))
 		return;
 
+	if (ctxp)
+		local64_set(&hwc->period_left,
+			    local64_read(&ctxp->period_left));
+
 	period = local64_read(&hwc->period_left);
 	if (period) {
 		if (period < 0)
@@ -12224,6 +12250,7 @@ static void perf_swevent_start_hrtimer(struct perf_event *event)
 
 static void perf_swevent_cancel_hrtimer(struct perf_event *event)
 {
+	struct perf_task_context *ctxp = event->perf_task_ctxp;
 	struct hw_perf_event *hwc = &event->hw;
 
 	/*
@@ -12238,8 +12265,13 @@ static void perf_swevent_cancel_hrtimer(struct perf_event *event)
 	 */
 	if (is_sampling_event(event) && (hwc->interrupts != MAX_INTERRUPTS)) {
 		ktime_t remaining = hrtimer_get_remaining(&hwc->hrtimer);
+
 		local64_set(&hwc->period_left, ktime_to_ns(remaining));
 
+		if (ctxp)
+			local64_set(&ctxp->period_left,
+				    ktime_to_ns(remaining));
+
 		hrtimer_try_to_cancel(&hwc->hrtimer);
 	}
 }
@@ -13259,6 +13291,45 @@ static void account_event(struct perf_event *event)
 	account_pmu_sb_event(event);
 }
 
+static struct perf_task_context *
+perf_get_task_ctxp(struct perf_event *event, struct task_struct *task,
+		   struct perf_event *parent_event)
+{
+	struct perf_task_context *ctxp = NULL;
+	struct perf_event_context *ctx;
+	struct perf_event *iter;
+	unsigned long flags;
+
+	ctx = perf_lock_task_context(task, &flags);
+	if (ctx) {
+		list_for_each_entry(iter, &ctx->event_list, event_entry) {
+			if (iter->perf_task_ctxp &&
+			    (iter->owner == current ||
+			     (parent_event && !iter->owner &&
+			      iter->parent &&
+			      iter->parent->perf_task_ctxp ==
+			      parent_event->perf_task_ctxp)) &&
+			    perf_event_equal_task_ctx(&iter->attr,
+						     &event->attr)) {
+				ctxp = iter->perf_task_ctxp;
+				refcount_inc(&ctxp->refcount);
+				break;
+			}
+		}
+		raw_spin_unlock_irqrestore(&ctx->lock, flags);
+		put_ctx(ctx);
+	}
+
+	if (!ctxp) {
+		ctxp = kzalloc_obj(struct perf_task_context);
+		if (!ctxp)
+			return NULL;
+		refcount_set(&ctxp->refcount, 1);
+	}
+
+	return ctxp;
+}
+
 /*
  * Allocate and initialize an event structure
  */
@@ -13344,6 +13415,16 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		 * pmu before we get a ctx.
 		 */
 		event->hw.target = get_task_struct(task);
+
+		if (attr->sample_period &&
+		    attr->config < PERF_COUNT_SW_MAX &&
+		    (attr->type == PERF_TYPE_SOFTWARE ||
+		     (parent_event && parent_event->perf_task_ctxp))) {
+			event->perf_task_ctxp = perf_get_task_ctxp(event, task,
+							parent_event);
+			if (!event->perf_task_ctxp)
+				return ERR_PTR(-ENOMEM);
+		}
 	}
 
 	event->clock = &local_clock;
-- 
2.49.0

