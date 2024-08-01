Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3227A1448E5
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 04:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488366; cv=none; b=SUxbjoEkhR/4XjwD7B8r8EJ3ThzLeoiWA0O/7HV4VVdB/SOWYPw9W3PYiroerjuMk3g6jwJCf62fcbLs3BxR2CNbLGB4Ve0ujlOyjIQSR9+P/Wkk5yBh0eKHX+wU/NI9aLfMkwqsoOxJBlXVrjDkQg3Bdd7sxvqarMnYnuJUmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488366; c=relaxed/simple;
	bh=dif1OkND5KGhR45F83fypWTka4+w2DTtKcoRJeXtzhM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=STgnjlU3VopOu7ItV+VlP4ddlz2Z4tb/gJtRwqoQMNKPAV57BbebbbAxZMq2p1aAEaV7u8dNXOsNsFWk0e7ou+MMxAQU0LQDpSvNzOdqcq+cfAjovGBn5nSLIXsfGSTB9h6filORuX0vZQ0OxF5LPTjNHf4REpBC8+LWAAqY1Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ut/bMld9; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ut/bMld9"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6507e2f0615so5716698a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 21:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488364; x=1723093164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xPzgKPV3k5GL7Cs71Q56CHqm2Jkw0rEVhVnkYtPwoz8=;
        b=Ut/bMld9jrJaj+OtAWz3nwf2pduw72QUtUAL1MT4Jy5gONyUAahhIUWFr1oxm8qDYj
         kJjduelhNMoP48SvCusPOEHcP3PFadPvArz7jVhS0A4r4OXPIEMHYgjecHKuhGHiy8i8
         Kkcs84V/PbaOLcoO9HcFPZnxSzzcNiJjBGeqWNc6KWt9pgh3svdxBYsV/8xILorxzgrS
         csiOJCaQAXD+y/Og/wIlCJ+xNU/32eA8dLzBJ7tAuXBi6Pbcf+POcsSpOWGXEuXvRlZS
         bC11xaiab9R4dEJOS3yeqFu8+RwT+BJ9fWP1PGJA42XuLmf46HeNLrFhZGEj16YYFl2Z
         Q/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488364; x=1723093164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPzgKPV3k5GL7Cs71Q56CHqm2Jkw0rEVhVnkYtPwoz8=;
        b=A3vEEmGrnbByrr4KShf2ZrpQV+ONBXEC2+uswt3whN/UktPoaoajPgm4jVIhQnKycx
         ufGWY4R1P+G/x/jGoYpiCoL0Q4MYf54Q4p9FOhaYIQh8qZYasDE1GzMeNFcQb0FvdZX+
         OYEvYtGIMp0xrGuDQ7jstzKdYSs4DsS4s5hgBNPiJ50P0mmER14ipqUdQ/xaKgYsiIW5
         dRhh0DQd11O49MKz15wxLL8NaJjJ6MV3ZfwoWkxHb/c5VjO0hvoHlCfsVdF5aAL4/Sbe
         WrkKTfPkcVsUCqi/G6onf4WVbGnz3bAWdaayHIondEe2+zq7oReY/E0pO/TyEytnOTnf
         3ZsA==
X-Forwarded-Encrypted: i=1; AJvYcCVS9sJ+uDYgG6NGM90OEACMFBhSgthDkzzdVXeNvArlJeX76B/6xA/rVrqbugrXs3GQGg1laTpbvq75Hahp5ru885IByFWLrUN2/rwy/X/CbQ==
X-Gm-Message-State: AOJu0Yx4Ji04esYlH+jZT02kTLx3PWMd5HeR1Drbh3urAXARyfRM3olD
	tm3sDEZtkMRhsfbMXmfxxNVMM/hn0Eri2+1LmszJ+aoQYzOVs33EgrggLKV/hycoZ+TbjsTn6FZ
	Vmq7+rg==
X-Google-Smtp-Source: AGHT+IFz+avBXprMtBMgz1SOFfYLpvVoYnZfKnbG8nnpFLCHengkkev16Do8OqHeqS65tqNLTt7NTgV+82xq
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a17:90a:c794:b0:2c9:7ebd:969d with SMTP id
 98e67ed59e1d1-2cfe7b550bcmr14138a91.4.1722488364284; Wed, 31 Jul 2024
 21:59:24 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:16 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-8-mizhang@google.com>
Subject: [RFC PATCH v3 07/58] perf: Skip pmu_ctx based on event_type
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kan Liang <kan.liang@linux.intel.com>

To optimize the cgroup context switch, the perf_event_pmu_context
iteration skips the PMUs without cgroup events. A bool cgroup was
introduced to indicate the case. It can work, but this way is hard to
extend for other cases, e.g. skipping non-passthrough PMUs. It doesn't
make sense to keep adding bool variables.

Pass the event_type instead of the specific bool variable. Check both
the event_type and related pmu_ctx variables to decide whether skipping
a PMU.

Event flags, e.g., EVENT_CGROUP, should be cleard in the ctx->is_active.
Add EVENT_FLAGS to indicate such event flags.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 kernel/events/core.c | 70 +++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 45868d276cde..7cb51dbf897a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -376,6 +376,7 @@ enum event_type_t {
 	/* see ctx_resched() for details */
 	EVENT_CPU = 0x8,
 	EVENT_CGROUP = 0x10,
+	EVENT_FLAGS = EVENT_CGROUP,
 	EVENT_ALL = EVENT_FLEXIBLE | EVENT_PINNED,
 };
 
@@ -699,23 +700,32 @@ do {									\
 	___p;								\
 })
 
-static void perf_ctx_disable(struct perf_event_context *ctx, bool cgroup)
+static bool perf_skip_pmu_ctx(struct perf_event_pmu_context *pmu_ctx,
+			      enum event_type_t event_type)
+{
+	if ((event_type & EVENT_CGROUP) && !pmu_ctx->nr_cgroups)
+		return true;
+
+	return false;
+}
+
+static void perf_ctx_disable(struct perf_event_context *ctx, enum event_type_t event_type)
 {
 	struct perf_event_pmu_context *pmu_ctx;
 
 	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-		if (cgroup && !pmu_ctx->nr_cgroups)
+		if (perf_skip_pmu_ctx(pmu_ctx, event_type))
 			continue;
 		perf_pmu_disable(pmu_ctx->pmu);
 	}
 }
 
-static void perf_ctx_enable(struct perf_event_context *ctx, bool cgroup)
+static void perf_ctx_enable(struct perf_event_context *ctx, enum event_type_t event_type)
 {
 	struct perf_event_pmu_context *pmu_ctx;
 
 	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-		if (cgroup && !pmu_ctx->nr_cgroups)
+		if (perf_skip_pmu_ctx(pmu_ctx, event_type))
 			continue;
 		perf_pmu_enable(pmu_ctx->pmu);
 	}
@@ -877,7 +887,7 @@ static void perf_cgroup_switch(struct task_struct *task)
 		return;
 
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
-	perf_ctx_disable(&cpuctx->ctx, true);
+	perf_ctx_disable(&cpuctx->ctx, EVENT_CGROUP);
 
 	ctx_sched_out(&cpuctx->ctx, EVENT_ALL|EVENT_CGROUP);
 	/*
@@ -893,7 +903,7 @@ static void perf_cgroup_switch(struct task_struct *task)
 	 */
 	ctx_sched_in(&cpuctx->ctx, EVENT_ALL|EVENT_CGROUP);
 
-	perf_ctx_enable(&cpuctx->ctx, true);
+	perf_ctx_enable(&cpuctx->ctx, EVENT_CGROUP);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
@@ -2732,9 +2742,9 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 
 	event_type &= EVENT_ALL;
 
-	perf_ctx_disable(&cpuctx->ctx, false);
+	perf_ctx_disable(&cpuctx->ctx, 0);
 	if (task_ctx) {
-		perf_ctx_disable(task_ctx, false);
+		perf_ctx_disable(task_ctx, 0);
 		task_ctx_sched_out(task_ctx, event_type);
 	}
 
@@ -2752,9 +2762,9 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 
 	perf_event_sched_in(cpuctx, task_ctx);
 
-	perf_ctx_enable(&cpuctx->ctx, false);
+	perf_ctx_enable(&cpuctx->ctx, 0);
 	if (task_ctx)
-		perf_ctx_enable(task_ctx, false);
+		perf_ctx_enable(task_ctx, 0);
 }
 
 void perf_pmu_resched(struct pmu *pmu)
@@ -3299,9 +3309,6 @@ ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_event_pmu_context *pmu_ctx;
 	int is_active = ctx->is_active;
-	bool cgroup = event_type & EVENT_CGROUP;
-
-	event_type &= ~EVENT_CGROUP;
 
 	lockdep_assert_held(&ctx->lock);
 
@@ -3336,7 +3343,7 @@ ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
 		barrier();
 	}
 
-	ctx->is_active &= ~event_type;
+	ctx->is_active &= ~(event_type & ~EVENT_FLAGS);
 	if (!(ctx->is_active & EVENT_ALL))
 		ctx->is_active = 0;
 
@@ -3349,7 +3356,7 @@ ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
 	is_active ^= ctx->is_active; /* changed bits */
 
 	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-		if (cgroup && !pmu_ctx->nr_cgroups)
+		if (perf_skip_pmu_ctx(pmu_ctx, event_type))
 			continue;
 		__pmu_ctx_sched_out(pmu_ctx, is_active);
 	}
@@ -3543,7 +3550,7 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 		raw_spin_lock_nested(&next_ctx->lock, SINGLE_DEPTH_NESTING);
 		if (context_equiv(ctx, next_ctx)) {
 
-			perf_ctx_disable(ctx, false);
+			perf_ctx_disable(ctx, 0);
 
 			/* PMIs are disabled; ctx->nr_pending is stable. */
 			if (local_read(&ctx->nr_pending) ||
@@ -3563,7 +3570,7 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 			perf_ctx_sched_task_cb(ctx, false);
 			perf_event_swap_task_ctx_data(ctx, next_ctx);
 
-			perf_ctx_enable(ctx, false);
+			perf_ctx_enable(ctx, 0);
 
 			/*
 			 * RCU_INIT_POINTER here is safe because we've not
@@ -3587,13 +3594,13 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 
 	if (do_switch) {
 		raw_spin_lock(&ctx->lock);
-		perf_ctx_disable(ctx, false);
+		perf_ctx_disable(ctx, 0);
 
 inside_switch:
 		perf_ctx_sched_task_cb(ctx, false);
 		task_ctx_sched_out(ctx, EVENT_ALL);
 
-		perf_ctx_enable(ctx, false);
+		perf_ctx_enable(ctx, 0);
 		raw_spin_unlock(&ctx->lock);
 	}
 }
@@ -3890,12 +3897,12 @@ static void pmu_groups_sched_in(struct perf_event_context *ctx,
 
 static void ctx_groups_sched_in(struct perf_event_context *ctx,
 				struct perf_event_groups *groups,
-				bool cgroup)
+				enum event_type_t event_type)
 {
 	struct perf_event_pmu_context *pmu_ctx;
 
 	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-		if (cgroup && !pmu_ctx->nr_cgroups)
+		if (perf_skip_pmu_ctx(pmu_ctx, event_type))
 			continue;
 		pmu_groups_sched_in(ctx, groups, pmu_ctx->pmu);
 	}
@@ -3912,9 +3919,6 @@ ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	int is_active = ctx->is_active;
-	bool cgroup = event_type & EVENT_CGROUP;
-
-	event_type &= ~EVENT_CGROUP;
 
 	lockdep_assert_held(&ctx->lock);
 
@@ -3932,7 +3936,7 @@ ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
 		barrier();
 	}
 
-	ctx->is_active |= (event_type | EVENT_TIME);
+	ctx->is_active |= ((event_type & ~EVENT_FLAGS) | EVENT_TIME);
 	if (ctx->task) {
 		if (!is_active)
 			cpuctx->task_ctx = ctx;
@@ -3947,11 +3951,11 @@ ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
 	 * in order to give them the best chance of going on.
 	 */
 	if (is_active & EVENT_PINNED)
-		ctx_groups_sched_in(ctx, &ctx->pinned_groups, cgroup);
+		ctx_groups_sched_in(ctx, &ctx->pinned_groups, event_type);
 
 	/* Then walk through the lower prio flexible groups */
 	if (is_active & EVENT_FLEXIBLE)
-		ctx_groups_sched_in(ctx, &ctx->flexible_groups, cgroup);
+		ctx_groups_sched_in(ctx, &ctx->flexible_groups, event_type);
 }
 
 static void perf_event_context_sched_in(struct task_struct *task)
@@ -3966,11 +3970,11 @@ static void perf_event_context_sched_in(struct task_struct *task)
 
 	if (cpuctx->task_ctx == ctx) {
 		perf_ctx_lock(cpuctx, ctx);
-		perf_ctx_disable(ctx, false);
+		perf_ctx_disable(ctx, 0);
 
 		perf_ctx_sched_task_cb(ctx, true);
 
-		perf_ctx_enable(ctx, false);
+		perf_ctx_enable(ctx, 0);
 		perf_ctx_unlock(cpuctx, ctx);
 		goto rcu_unlock;
 	}
@@ -3983,7 +3987,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
 	if (!ctx->nr_events)
 		goto unlock;
 
-	perf_ctx_disable(ctx, false);
+	perf_ctx_disable(ctx, 0);
 	/*
 	 * We want to keep the following priority order:
 	 * cpu pinned (that don't need to move), task pinned,
@@ -3993,7 +3997,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
 	 * events, no need to flip the cpuctx's events around.
 	 */
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree)) {
-		perf_ctx_disable(&cpuctx->ctx, false);
+		perf_ctx_disable(&cpuctx->ctx, 0);
 		ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
 	}
 
@@ -4002,9 +4006,9 @@ static void perf_event_context_sched_in(struct task_struct *task)
 	perf_ctx_sched_task_cb(cpuctx->task_ctx, true);
 
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
-		perf_ctx_enable(&cpuctx->ctx, false);
+		perf_ctx_enable(&cpuctx->ctx, 0);
 
-	perf_ctx_enable(ctx, false);
+	perf_ctx_enable(ctx, 0);
 
 unlock:
 	perf_ctx_unlock(cpuctx, ctx);
-- 
2.46.0.rc1.232.g9752f9e123-goog

