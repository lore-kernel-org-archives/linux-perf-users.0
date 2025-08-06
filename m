Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4702BE037
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510254; cv=none; b=V3re7nvh8dhgcBnzk2vl8D6HGLuMIEz2G2W910fKWUrQUE1CseiRkOiGgkqXrwkNkfL+yAgHy5OQ/LTRuj6gUyWkOFogZDqRIoinD7AC7Y+wrYzcSC9/yyiuzvLe6GcaWUhPMdEjUgjvRlfOExevSpD8zrT5oj+SE9NrZhgYb6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510254; c=relaxed/simple;
	bh=N7QiJzpxt/oF3iR/QDRN+b3QtpGh0UIAL2mIbSM/BGQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XDU+X0tsIbxvtKVoI34m3L1tZGiicS8UIyvUwUGe3vsaP8PRHB499jeiHtTm1GCfWw55jNlzXqdr51uNvchxj/eCzIZD85J7wrFRdyY8KiSJo74VAfp2e9zIyqEXdfGSBUtZd2v85+EFKG7d/B+bQgepiBoDH5PPP/gw04LmDAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0I2BzlDA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0I2BzlDA"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23fe98c50daso1493115ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510250; x=1755115050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mLCoApegT2C8Zn1SJf1wYwN1uRlNuEQSrOHklByprgU=;
        b=0I2BzlDAehUhPPwsBSye1tc0ocBcSeIxtswzpz0wkBDozmBy6sluPTWdo7tEON1oiS
         4nMfuPr6EkKELT53PvvgvNvUcNgX4liHt4KVP9M3JScFLIOklFAqAyh1wddMV9Zmvl+6
         oaHYlK+vwDGQXwRa7d2DR+3wAPeoszBDc/mRRecZOpB6tqhpZTP0Fr9cGnAhftPUc5eF
         +cHOzk9Y74RkhYm5+CEMkDkimSF8+OyrXPQ7tgRqDanctChFw55Va8wLLtCWQjlEmXbA
         Ie+BySPTtx3oSM7HMgV3Pj03B1y8VbQk1mvOMnavvi4K1zbOl4aTL3stYPw8nfQQvLso
         A92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510250; x=1755115050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLCoApegT2C8Zn1SJf1wYwN1uRlNuEQSrOHklByprgU=;
        b=IVYzz0tw4GROX1tvr5wsLFK+oJy4SD2Usvtcc7odQOgGtd0ZIpRGuBxC5ICe3BL2QF
         zQ6qwSsh4taSwMYzj3RU3+j1OXdzuQnVvz3ebxR3awBez7vGjg5jxkkvHyHKy1SHhr5v
         kgf2BJCp/3YI72zltPsgoSibPTKzzYZ+2OvOX9er3hNXKNv5M9zUAqSGznCnocUpiOPo
         Jyv6QvW0U7ric3IDfVNdCW8SZ9YGx5EYGwRq7G6leHHjPVMnMgnEva5TDDTgt0uv5h8S
         eu9JI4Gmaa1Q90NAuh2xJ456rgR2uQ4lBa3/ZgInA46PcWwb4oCTW2HZYpZYByXxUaFp
         vnbg==
X-Forwarded-Encrypted: i=1; AJvYcCULq1juWFqfSyZ2YW/VjD54MZl2Z93WrwcTUBOOj6+PEETEPvswgvj5S16VFMtbHAVhqi2WIquyMsrSK1sJiT6I@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7p3lhJBpAeHF3lVAaZiGLuA58ORbA4O1PsxyJMEkrO7O2epgf
	P9jw+w/iMpq7/QsLYcYtCJz3N9M0YVy83UpB1s9UwBAJ9lXZ4OMnr7SeCx0aHdSMd3jvOWNBCuR
	wyEU8Wg==
X-Google-Smtp-Source: AGHT+IGGAEizgonLm0FsoKt80WWuFMmxvZ9tdXyWc4+Z75ESLdyWsCnJtZKQl7SnHv99v5pbq5U5y7gC/zQ=
X-Received: from plq1.prod.google.com ([2002:a17:903:2f81:b0:23f:ecf6:4649])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:144b:b0:240:2970:65e7
 with SMTP id d9443c01a7336-2429eebe90emr51929475ad.25.1754510250416; Wed, 06
 Aug 2025 12:57:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:23 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-2-seanjc@google.com>
Subject: [PATCH v5 01/44] perf: Skip pmu_ctx based on event_type
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Kan Liang <kan.liang@linux.intel.com>

To optimize the cgroup context switch, the perf_event_pmu_context
iteration skips the PMUs without cgroup events. A bool cgroup was
introduced to indicate the case. It can work, but this way is hard to
extend for other cases, e.g. skipping non-mediated PMUs. It doesn't
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
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/events/core.c | 74 ++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 22fdf0c187cd..d4528554528d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -164,7 +164,7 @@ enum event_type_t {
 	/* see ctx_resched() for details */
 	EVENT_CPU	= 0x10,
 	EVENT_CGROUP	= 0x20,
-
+	EVENT_FLAGS	= EVENT_CGROUP,
 	/* compound helpers */
 	EVENT_ALL         = EVENT_FLEXIBLE | EVENT_PINNED,
 	EVENT_TIME_FROZEN = EVENT_TIME | EVENT_FROZEN,
@@ -778,27 +778,37 @@ do {									\
 	___p;								\
 })
 
-#define for_each_epc(_epc, _ctx, _pmu, _cgroup)				\
+static bool perf_skip_pmu_ctx(struct perf_event_pmu_context *pmu_ctx,
+			      enum event_type_t event_type)
+{
+	if ((event_type & EVENT_CGROUP) && !pmu_ctx->nr_cgroups)
+		return true;
+	return false;
+}
+
+#define for_each_epc(_epc, _ctx, _pmu, _event_type)			\
 	list_for_each_entry(_epc, &((_ctx)->pmu_ctx_list), pmu_ctx_entry) \
-		if (_cgroup && !_epc->nr_cgroups)			\
+		if (perf_skip_pmu_ctx(_epc, _event_type))		\
 			continue;					\
 		else if (_pmu && _epc->pmu != _pmu)			\
 			continue;					\
 		else
 
-static void perf_ctx_disable(struct perf_event_context *ctx, bool cgroup)
+static void perf_ctx_disable(struct perf_event_context *ctx,
+			     enum event_type_t event_type)
 {
 	struct perf_event_pmu_context *pmu_ctx;
 
-	for_each_epc(pmu_ctx, ctx, NULL, cgroup)
+	for_each_epc(pmu_ctx, ctx, NULL, event_type)
 		perf_pmu_disable(pmu_ctx->pmu);
 }
 
-static void perf_ctx_enable(struct perf_event_context *ctx, bool cgroup)
+static void perf_ctx_enable(struct perf_event_context *ctx,
+			    enum event_type_t event_type)
 {
 	struct perf_event_pmu_context *pmu_ctx;
 
-	for_each_epc(pmu_ctx, ctx, NULL, cgroup)
+	for_each_epc(pmu_ctx, ctx, NULL, event_type)
 		perf_pmu_enable(pmu_ctx->pmu);
 }
 
@@ -963,8 +973,7 @@ static void perf_cgroup_switch(struct task_struct *task)
 		return;
 
 	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
-
-	perf_ctx_disable(&cpuctx->ctx, true);
+	perf_ctx_disable(&cpuctx->ctx, EVENT_CGROUP);
 
 	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
 	/*
@@ -980,7 +989,7 @@ static void perf_cgroup_switch(struct task_struct *task)
 	 */
 	ctx_sched_in(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
 
-	perf_ctx_enable(&cpuctx->ctx, true);
+	perf_ctx_enable(&cpuctx->ctx, EVENT_CGROUP);
 }
 
 static int perf_cgroup_ensure_storage(struct perf_event *event,
@@ -2898,11 +2907,11 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 
 	event_type &= EVENT_ALL;
 
-	for_each_epc(epc, &cpuctx->ctx, pmu, false)
+	for_each_epc(epc, &cpuctx->ctx, pmu, 0)
 		perf_pmu_disable(epc->pmu);
 
 	if (task_ctx) {
-		for_each_epc(epc, task_ctx, pmu, false)
+		for_each_epc(epc, task_ctx, pmu, 0)
 			perf_pmu_disable(epc->pmu);
 
 		task_ctx_sched_out(task_ctx, pmu, event_type);
@@ -2922,11 +2931,11 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 
 	perf_event_sched_in(cpuctx, task_ctx, pmu);
 
-	for_each_epc(epc, &cpuctx->ctx, pmu, false)
+	for_each_epc(epc, &cpuctx->ctx, pmu, 0)
 		perf_pmu_enable(epc->pmu);
 
 	if (task_ctx) {
-		for_each_epc(epc, task_ctx, pmu, false)
+		for_each_epc(epc, task_ctx, pmu, 0)
 			perf_pmu_enable(epc->pmu);
 	}
 }
@@ -3475,11 +3484,10 @@ static void
 ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t event_type)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+	enum event_type_t active_type = event_type & ~EVENT_FLAGS;
 	struct perf_event_pmu_context *pmu_ctx;
 	int is_active = ctx->is_active;
-	bool cgroup = event_type & EVENT_CGROUP;
 
-	event_type &= ~EVENT_CGROUP;
 
 	lockdep_assert_held(&ctx->lock);
 
@@ -3510,7 +3518,7 @@ ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 	 * see __load_acquire() in perf_event_time_now()
 	 */
 	barrier();
-	ctx->is_active &= ~event_type;
+	ctx->is_active &= ~active_type;
 
 	if (!(ctx->is_active & EVENT_ALL)) {
 		/*
@@ -3531,7 +3539,7 @@ ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 
 	is_active ^= ctx->is_active; /* changed bits */
 
-	for_each_epc(pmu_ctx, ctx, pmu, cgroup)
+	for_each_epc(pmu_ctx, ctx, pmu, event_type)
 		__pmu_ctx_sched_out(pmu_ctx, is_active);
 }
 
@@ -3687,7 +3695,7 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 		raw_spin_lock_nested(&next_ctx->lock, SINGLE_DEPTH_NESTING);
 		if (context_equiv(ctx, next_ctx)) {
 
-			perf_ctx_disable(ctx, false);
+			perf_ctx_disable(ctx, 0);
 
 			/* PMIs are disabled; ctx->nr_no_switch_fast is stable. */
 			if (local_read(&ctx->nr_no_switch_fast) ||
@@ -3711,7 +3719,7 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 
 			perf_ctx_sched_task_cb(ctx, task, false);
 
-			perf_ctx_enable(ctx, false);
+			perf_ctx_enable(ctx, 0);
 
 			/*
 			 * RCU_INIT_POINTER here is safe because we've not
@@ -3735,13 +3743,13 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 
 	if (do_switch) {
 		raw_spin_lock(&ctx->lock);
-		perf_ctx_disable(ctx, false);
+		perf_ctx_disable(ctx, 0);
 
 inside_switch:
 		perf_ctx_sched_task_cb(ctx, task, false);
 		task_ctx_sched_out(ctx, NULL, EVENT_ALL);
 
-		perf_ctx_enable(ctx, false);
+		perf_ctx_enable(ctx, 0);
 		raw_spin_unlock(&ctx->lock);
 	}
 }
@@ -4050,11 +4058,9 @@ static void
 ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t event_type)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+	enum event_type_t active_type = event_type & ~EVENT_FLAGS;
 	struct perf_event_pmu_context *pmu_ctx;
 	int is_active = ctx->is_active;
-	bool cgroup = event_type & EVENT_CGROUP;
-
-	event_type &= ~EVENT_CGROUP;
 
 	lockdep_assert_held(&ctx->lock);
 
@@ -4072,7 +4078,7 @@ ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 		barrier();
 	}
 
-	ctx->is_active |= (event_type | EVENT_TIME);
+	ctx->is_active |= active_type | EVENT_TIME;
 	if (ctx->task) {
 		if (!(is_active & EVENT_ALL))
 			cpuctx->task_ctx = ctx;
@@ -4087,13 +4093,13 @@ ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 	 * in order to give them the best chance of going on.
 	 */
 	if (is_active & EVENT_PINNED) {
-		for_each_epc(pmu_ctx, ctx, pmu, cgroup)
+		for_each_epc(pmu_ctx, ctx, pmu, event_type)
 			__pmu_ctx_sched_in(pmu_ctx, EVENT_PINNED);
 	}
 
 	/* Then walk through the lower prio flexible groups */
 	if (is_active & EVENT_FLEXIBLE) {
-		for_each_epc(pmu_ctx, ctx, pmu, cgroup)
+		for_each_epc(pmu_ctx, ctx, pmu, event_type)
 			__pmu_ctx_sched_in(pmu_ctx, EVENT_FLEXIBLE);
 	}
 }
@@ -4110,11 +4116,11 @@ static void perf_event_context_sched_in(struct task_struct *task)
 
 	if (cpuctx->task_ctx == ctx) {
 		perf_ctx_lock(cpuctx, ctx);
-		perf_ctx_disable(ctx, false);
+		perf_ctx_disable(ctx, 0);
 
 		perf_ctx_sched_task_cb(ctx, task, true);
 
-		perf_ctx_enable(ctx, false);
+		perf_ctx_enable(ctx, 0);
 		perf_ctx_unlock(cpuctx, ctx);
 		goto rcu_unlock;
 	}
@@ -4127,7 +4133,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
 	if (!ctx->nr_events)
 		goto unlock;
 
-	perf_ctx_disable(ctx, false);
+	perf_ctx_disable(ctx, 0);
 	/*
 	 * We want to keep the following priority order:
 	 * cpu pinned (that don't need to move), task pinned,
@@ -4137,7 +4143,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
 	 * events, no need to flip the cpuctx's events around.
 	 */
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree)) {
-		perf_ctx_disable(&cpuctx->ctx, false);
+		perf_ctx_disable(&cpuctx->ctx, 0);
 		ctx_sched_out(&cpuctx->ctx, NULL, EVENT_FLEXIBLE);
 	}
 
@@ -4146,9 +4152,9 @@ static void perf_event_context_sched_in(struct task_struct *task)
 	perf_ctx_sched_task_cb(cpuctx->task_ctx, task, true);
 
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
-		perf_ctx_enable(&cpuctx->ctx, false);
+		perf_ctx_enable(&cpuctx->ctx, 0);
 
-	perf_ctx_enable(ctx, false);
+	perf_ctx_enable(ctx, 0);
 
 unlock:
 	perf_ctx_unlock(cpuctx, ctx);
-- 
2.50.1.565.gc32cd1483b-goog

