Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117253A6B7F
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777448649; cv=none; b=GZzJv9Tvwc8y2TkotDJwWhA0WAd7JLngBmzbbWb3OpGwbpA43m9n/GGQ9u7IYSDOL7S7XJuAIk7c+NEK6hiezg2G+NMx0aOnhH28wDkD0cs5aJ0wkswJyqj+OGwvR0SAXkg15wOqVV2owsr0j8s4ObEK8G78cS8Am4c7ak2S274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777448649; c=relaxed/simple;
	bh=KMTwrO6lyGA9HXWMDRxyqvFbl0UsijqV/ZH6/je9Ys4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f8zIKBXptV9vr4+bNU8P57d/gKBe/0cglgrRov28mnqiXSuiUPRigpqk72VAPHm+aKiWBn/VVIFONEjfOqb53/+HjTLfhhCR54CwBrOxz5Tj2ZtYIU7xy6F59KVYydd3M4JtnMRX8tmwNLC0B1Orqxr8XQWda/FJXZH1GYY8Uo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+suWJyj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+suWJyj"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so8205298a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 00:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777448647; x=1778053447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ug4IsgIcxYoU7FipCLH2YRUtUPisQjttB4gCz1feTAY=;
        b=I+suWJyjaLWujMMbcBt2o52W4O0TDyDRBShL0wZ8wo21ArU+TZ5Ad66MahWXJ/qsFK
         SsaRdulVuAo1DgvKPNT2gA5iJS6uGK33n3JbFWzzHlZMdUlWPF2ue+ewrIxKnEhJOf+f
         L1ZxsTmU5b6KLRNhDqq8p0mhbE09KrTqkvHvmkdKPWByvuZV3SRICiWtrzWTN77nDoJm
         zq882/cx5s/12QdTpxh9v7E+NOrBVajgekJ/gnQv6WDO4zhR7Eu64bVqf0wjKWT54Dot
         hPaPEzFtlwdWkJhP9U5wkkQgbivgkXvPH41/RyJ70vFR7+dVp+ER5sUM0eFMwtmkLmHy
         j4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777448647; x=1778053447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ug4IsgIcxYoU7FipCLH2YRUtUPisQjttB4gCz1feTAY=;
        b=dAWJ7FUgqtCt5lBoLoDbA+Phy2XIyIkRoftptfzc2Jkg5PGs/DX+dqOrneliEqAfLk
         ow1+1LL5r5Wk8e2CwisGXOlPaWA9t4O/OCJ7dTCN5I3xlHdmXfhMq/aSrvIrraRFBMT8
         mrR+HMr9lPQ85gNZrRndwjXjUwV67wVz0pe16VcePHnsGEOy5Pes9lYd8k9BfkjiPTdV
         Ct2jfSG9MbWzlEJpiU26h5AkH9an8KidZZ+O18388zp2KYilMrU0rY5x1eSoqnntuT8Z
         yHk3hx8cK8QdYULcTkwl0tpmyPd/b6bDiA7r7UY/W5HNhqiwewyXSfFiT8oomB4A05rm
         RV5A==
X-Forwarded-Encrypted: i=1; AFNElJ87ypjI2LwtPngAJMLAeP86lCkXL8PE0n1QnjUo9sv44FYK15fpkYWZceQcYfs6l3itm82TUiu0GU5o6UHqmI3e@vger.kernel.org
X-Gm-Message-State: AOJu0YzoBK2uZ/vf0c3MKlaZKzwl97mAuBSnn5JWcl8RtX20yYmoOVM+
	m3s16DAVcHz1tnWTQy8hr7IEkd/9xnTAoFsh0gJqhTyNIIVgqbiCGG4P
X-Gm-Gg: AeBDieujwnWEPn/0m4bDuKoX1BuED5e8apUvflBN94UCLu42i5PsCSUpU5WZVLT/PX1
	oDLWRcoCBJnRWbd+r5uW+YWGSDhYJ+6NkxWd1aSp+vEBLC/WpWAka+w561XqvgoYy9R8EOHov/o
	0WD3N3V2ZfpCFdWCvFhRKTU+doLWDZ9JteaU0kCQe2MPfIPbzjKfRt8zgG/4dAkmCAj3C5razic
	Bj2yGXZyPryXCpsi6quNe2nKEFxpyQkXb+yrTicQdO3j5zRdkR7Bg9ZiBKv1bsAHcVw7i3P1FsP
	kn4ZlwbFpzPRcF6dNr48uSHV4fSbM9T2OaLFLQv30TVKL29f9wxaiHbSui14oKIL7QhEDHCijg5
	/gf3Of9/Cc1JngXak+zNCmdtsQpnU00O5VzTINyScB3pMAv+F9IMax6bcEXX0ivGunjMC2yManQ
	wzdUx/iB/OOi5j9BGAK+TIq9KY749nEeCpvF3vfs6gB1edhEWCE5Mku5zNzQ==
X-Received: by 2002:a17:90b:2604:b0:35b:e4d8:e21d with SMTP id 98e67ed59e1d1-36491f6c9b5mr7194320a91.2.1777448647126;
        Wed, 29 Apr 2026 00:44:07 -0700 (PDT)
Received: from localhost.localdomain ([165.132.143.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a2a4b65dsm569443a91.14.2026.04.29.00.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 00:44:06 -0700 (PDT)
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
Subject: [PATCH v3] perf/core: Fix sampling period inconsistency across CPU migration
Date: Wed, 29 Apr 2026 07:43:28 +0000
Message-ID: <20260429074328.41991-1-mwahn402@gmail.com>
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
(where owner is NULL), the inherit flag relaxes the owner check
so that child events properly share perf_task_context. The
allocation condition for inherited events checks that the parent
event actually has a perf_task_ctxp, ensuring only genuine software
events propagate the context. The existing perf_task_context lookup
uses perf_lock_task_context() to safely access the task's event
context under proper RCU and IRQ protection.

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
 kernel/events/core.c       | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

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
index 6d1f8bad7e1c..f5cb1a273fbf 100644
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
@@ -13259,6 +13291,41 @@ static void account_event(struct perf_event *event)
 	account_pmu_sb_event(event);
 }
 
+static struct perf_task_context *
+perf_get_task_ctxp(struct perf_event *event, struct task_struct *task,
+		   bool inherit)
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
+			     (inherit && !iter->owner)) &&
+			    perf_event_equal_task_ctx(&iter->attr,
+						     &event->attr)) {
+				ctxp = iter->perf_task_ctxp;
+				refcount_inc(&ctxp->refcount);
+				break;
+			}
+		}
+		raw_spin_unlock_irqrestore(&ctx->lock, flags);
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
@@ -13344,6 +13411,16 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		 * pmu before we get a ctx.
 		 */
 		event->hw.target = get_task_struct(task);
+
+		if (attr->sample_period &&
+		    attr->config < PERF_COUNT_SW_MAX &&
+		    (attr->type == PERF_TYPE_SOFTWARE ||
+		     (parent_event && parent_event->perf_task_ctxp))) {
+			event->perf_task_ctxp = perf_get_task_ctxp(event, task,
+							!!parent_event);
+			if (!event->perf_task_ctxp)
+				return ERR_PTR(-ENOMEM);
+		}
 	}
 
 	event->clock = &local_clock;
-- 
2.49.0

