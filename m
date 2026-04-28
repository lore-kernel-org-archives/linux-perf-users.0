Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094A3F0A86
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777377379; cv=none; b=tuG3H8JcEJz07+mCDVSAIakN4FhO40SKSdTmelTOxfYuZscKYEiM/AFjWl5d4cW5NjP0Gpooa2+uE9a8LMeccvlIItZFR3XWnRFkv1Rc8wO4pOt0LjV7BGxDt9eqwgY5UwnURbD0ufOyHztvArpb7594iH0crijZ/Gb/3EPGA4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777377379; c=relaxed/simple;
	bh=rHQ8ZpVpFxKPefGis7kEbhp+wGT64dVGc+IOm8Lf2v4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GC9dMKAK6ugepS/bwA7DaFxrPLNMpTcrgvicuUsxBPs6uMcktnwr4KzTcV+1/fKurOD90aq2k2kEPkjjng6niMAQL2AvhfU+Ck46gza0QE6D/UMcu/rdPExB3Kec3yU5j7ntXVDYrBeT3aE7cgJUWbeTRyJNuzCPekaE6cNzrK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRTTJ2aM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRTTJ2aM"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b2589c26e3so104777035ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 04:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777377377; x=1777982177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nJ0xOXWM5wm0K/iDyOfvIQKw+eIHSiLahJt/RRhEhD4=;
        b=iRTTJ2aMhq8npMuzTgSuW+J3+nb3fAtJYt6UKNotrVAO9zwbzUSzmgWV8RQTwh0GUd
         bA0O6y0VtA1JIILE2SBBKD+Um582So/+Twi0piKYyKH/CPlT6frFUDvIdc8QVj2G6vIJ
         Vczz2QadJH85nts7LHPPa1XQE7+SIT8s+6pbUFQO2Xy95ieG4aZOApHf2hObxQzlH1WI
         VNTD7kZir5nYVrR4ncr3zeX7O57XRgOpLqm52Ilnt366mUZeER4UEsN5waYHP6pEu2AN
         wABuvYOs38izAxFY3AhLceBo0cWKH3vbP6B9f2aZ36BiQUyRGuRd1l3I8I1sHzs3yvwn
         RMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777377377; x=1777982177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJ0xOXWM5wm0K/iDyOfvIQKw+eIHSiLahJt/RRhEhD4=;
        b=RnU2A2u6NkLp1MpAMTWrsRXOeXnNxPf8cnGYBE1cEV12K9f66GdrGd797wbBVCA2kK
         WBq0MG6y7oM+1cUxpaFIwpExPzQnPF8Maf2JOgf6IhVuGTGeBdorULZa4UbKgeiLSKw7
         we4ID6kJWMv4f5D1DbiUGy/EFzbq8CHacNBWb9jcNVFaKsaffQwQSVP4GZWsG+514IDy
         vR40mLBFdsOI9SZTwXC85dzfSgYdj3WfT4+8MwxC+DZvHVF1oZAfwXTynXql6GFOw3jI
         gwh6MqaFQFKvQySq4F56IacWQdgeIrViBmVOPAGznRfFtJ6fNzkTs/Do5rdI1PW9CrtN
         0LZA==
X-Forwarded-Encrypted: i=1; AFNElJ9kD9WJijnbDTSyV4MKiF6sTFPPoclPlNmlXkj4FLwe2IhX0vxi57maSLPHbTDAKKDKYMHAQXou7kDRkAEZDTwH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx63gFfbjTIQLxBy7mSQZ8uDVHRx2u5ESwCJTDzT5qWAbmDLtp1
	0Y5f2DGaBSRUJSeUxcQUXVP9AsH6Us4ojuz6eHJan/kfilQFsB13lbtgfLST5tI/
X-Gm-Gg: AeBDiev5nrD92Cl3s8kYthNO5WJWaw5qOnWx9YqCJKxwb7jsWEg1beGEJg5iIPpTI/+
	P+FnMAfwq3IzK0preOg640SW8rEf9dVuRLms6yjarS+WgwG7hVufaPGwkUiNkttD9Z2HcTtWtC8
	h1ByzFDntB7qI2txhH6D739hIvxJO9kwL+AcPdyVYcXPn6RcKOJOuWJbs/vBOwhS4jDbePznjWk
	mv02zMha9O9vQJwHdsExHCPYO8GtT3SDZ6BgKBA1tCltJzkORxKR3S7vi5O92g1GvRKtqst6CEB
	9+Belj6TWCEW7R8RQdLPJqcC3MorVA9Zt0Qz2eycNxkrq4H4N3U6dfHCTK0njobJJYJgUmsoNsZ
	6jRadOehSG528auW5l1vvwD6Bsrna6seINHCLbRXsiIRWELhCg37mWjkn1DJAWWkLRjPwOoeqOc
	oEpypE7uhkSM85i7e+5y+v7k9j0UbZVml6ZdSg+PMR/KLoCg==
X-Received: by 2002:a17:902:e9d2:b0:2b7:a3bf:b2a0 with SMTP id d9443c01a7336-2b97c3d1265mr22391915ad.5.1777377377463;
        Tue, 28 Apr 2026 04:56:17 -0700 (PDT)
Received: from localhost.localdomain ([165.132.143.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aa93a92sm25761535ad.22.2026.04.28.04.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:56:17 -0700 (PDT)
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
Subject: [PATCH] perf/core: Fix sampling period inconsistency across CPU migration
Date: Tue, 28 Apr 2026 11:53:17 +0000
Message-ID: <20260428115317.22839-1-mwahn402@gmail.com>
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
allocation condition also accounts for inherited events whose
attr.type has been remapped from PERF_TYPE_SOFTWARE to a dynamic
PMU type during initialization.

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
 include/linux/perf_event.h | 18 +++++++++++
 kernel/events/core.c       | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea..84827f81cc9c 100644
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
@@ -1148,6 +1151,21 @@ struct perf_cpu_context {
 	struct perf_event		*heap_default[2];
 };
 
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
 struct perf_output_handle {
 	struct perf_event		*event;
 	struct perf_buffer		*rb;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6d1f8bad7e1c..bd106e0b854a 100644
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
@@ -13259,6 +13291,40 @@ static void account_event(struct perf_event *event)
 	account_pmu_sb_event(event);
 }
 
+static struct perf_task_context *
+perf_get_task_ctxp(struct perf_event *event, struct task_struct *task,
+		   bool inherit)
+{
+	struct perf_task_context *ctxp = NULL;
+	struct perf_event_context *ctx = task->perf_event_ctxp;
+	struct perf_event *iter;
+
+	if (ctx) {
+		raw_spin_lock(&ctx->lock);
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
+		raw_spin_unlock(&ctx->lock);
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
@@ -13344,6 +13410,15 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		 * pmu before we get a ctx.
 		 */
 		event->hw.target = get_task_struct(task);
+
+		if (attr->sample_period &&
+		    attr->config < PERF_COUNT_SW_MAX &&
+		    (attr->type == PERF_TYPE_SOFTWARE || parent_event)) {
+			event->perf_task_ctxp = perf_get_task_ctxp(event, task,
+							!!parent_event);
+			if (!event->perf_task_ctxp)
+				return ERR_PTR(-ENOMEM);
+		}
 	}
 
 	event->clock = &local_clock;
-- 
2.49.0

