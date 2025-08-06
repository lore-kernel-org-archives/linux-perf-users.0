Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01C02BEFF9
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510268; cv=none; b=NiUrHtHZtpq4qb6lg++m0k944SMV9eOk1iSECs6lA6FS9OvkWg/A5ZvqnYgIeT8fUOVVF+TulriFpUB/pxqs6MDRWsIbmF5MfBR/9z3m5KBjVHuDh6GuGGrWZ90G2nCtqBlBBndRm4dwvr7RlJoFktcwOQwPmCznNyilP+lOo2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510268; c=relaxed/simple;
	bh=lPxtg3K6w22yYMFe3Rv5cpyOHm8QqrTeWqcW4ebUScU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mAvyBm6L+oFLMFm7VfP8yEO5pqoVWVwWHeyMLbdTQ1cH+/VRyOVNv3CTyaaVYgWjJh+j6vGgKNoxxoCGa2e2Z9iZ43f1TRhB3ZvCbyiIU2M1EE7/nmLwfUYGMIeVr/o0W+Sk8DZyWxpqyxorY/gS5t3SyrxKmqX/Z1CHGRnHE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W9OsAinG; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W9OsAinG"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bed3183ecso276499b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510265; x=1755115065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jWazn7LbEKToZVBXfT81sYQ79Zs+usROHmWn+qgVcAw=;
        b=W9OsAinGjcMXAtBm76IFKsQZXxjqTBPqoyxyChEV3rz7VCofrp3pXNu32Ym22zydu3
         Y9BfvloSB5xZ5sc0z3zoHyteK7N3gD70rNYxBdZinUznZu1Do48W3nfY5bOoOJZBZjAw
         dpgejWDf/FvLrmtm8HSidsIPaF2X6CM/dcUUAPZ/bhgSFTr8ETNZ/Jzzwbu6xL7j5fdt
         fuhoS8HkVm30yFkZgb9lt7lzclIILwH2++s+fuMy89u7LA50GiFa9lN+qIAi2wYtyIA7
         IeYiQd0O27Zst//+GDreTFVXSnrDCHGa6J3wWnun9ifVy4xGxLS6JslZBo3IAtA9E9OQ
         /5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510265; x=1755115065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWazn7LbEKToZVBXfT81sYQ79Zs+usROHmWn+qgVcAw=;
        b=p0PfDu0epaK7M3b8iEWl0nFHTZ64Xna1Jc7F+c6JhXElNYznPPSmrK13S3v9xDRjqK
         tehIVlLnj2e/dczqxlbTi4SYWcbT+QwZQ9s5ZefxMqn3KmndIPSm6/R5paJZplSs+Bjk
         dWhEpkP4EmzeA/ni8BIg744RnUtJPTzrZp0js2EuzVjORttfBN9wSzjmaT1vYhkMYBN0
         udIi0arcl2cHMQWHdzKSBNPxBppDM6t0kUe4zmrr+uaHsZObYOT58pEb4oaOImpXNBKp
         nXym6WTf5fW0zDSmehrTOJQ4Q4GFm3sJPxNz1LSYnDyil0yHFB1EdShPjxFdbcmCwG9y
         NPfw==
X-Forwarded-Encrypted: i=1; AJvYcCX4MWAI/8mEMABvivFv9e6WzcLiAvr1smiHh8QZCfNoA+MghL9L4XGEJgaPyP0T4XZ96Nwlu8HiGlzSXpsSouvh@vger.kernel.org
X-Gm-Message-State: AOJu0YyxR7qjYVpotJXCiJQTfMyXfScM+2Extxt6Niqob40Tg+nEW8Wp
	zyvOdXNOFzljDrdzPhaIHzZFnNbzYT6UYOcfqbAR7s6TXUnm6a66hqZlwD+cXw6PIO+v5duNaAR
	fdmmscA==
X-Google-Smtp-Source: AGHT+IEOZHdE2/PbxBEmSs9IzcnvpAQDGgoykrCqSet5dWYTZm1GHUavvsVGL1zycY+fmJU68DVHh19KP/o=
X-Received: from pgbcs10.prod.google.com ([2002:a05:6a02:418a:b0:b42:2ab5:b109])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:218d:b0:23d:f987:b033
 with SMTP id adf61e73a8af0-240314c22f5mr6625238637.40.1754510264630; Wed, 06
 Aug 2025 12:57:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:31 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-10-seanjc@google.com>
Subject: [PATCH v5 09/44] perf/x86: Switch LVTPC to/from mediated PMI vector
 on guest load/put context
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

Add arch hooks to the mediated vPMU load/put APIs, and use the hooks to
switch PMIs to the dedicated mediated PMU IRQ vector on load, and back to
perf's standard NMI when the guest context is put.  I.e. route PMIs to
PERF_GUEST_MEDIATED_PMI_VECTOR when the guest context is active, and to
NMIs while the host context is active.

While running with guest context loaded, ignore all NMIs (in perf).  Any
NMI that arrives while the LVTPC points at the mediated PMU IRQ vector
can't possibly be due to a host perf event.

Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
[sean: use arch hook instead of per-PMU callback]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/core.c     | 27 +++++++++++++++++++++++++++
 include/linux/perf_event.h |  3 +++
 kernel/events/core.c       |  4 ++++
 3 files changed, 34 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7610f26dfbd9..9b0525b252f1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -55,6 +55,8 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
 	.pmu = &pmu,
 };
 
+static DEFINE_PER_CPU(bool, x86_guest_ctx_loaded);
+
 DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
 DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
 DEFINE_STATIC_KEY_FALSE(perf_is_hybrid);
@@ -1756,6 +1758,16 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 	u64 finish_clock;
 	int ret;
 
+	/*
+	 * Ignore all NMIs when a guest's mediated PMU context is loaded.  Any
+	 * such NMI can't be due to a PMI as the CPU's LVTPC is switched to/from
+	 * the dedicated mediated PMI IRQ vector while host events are quiesced.
+	 * Attempting to handle a PMI while the guest's context is loaded will
+	 * generate false positives and clobber guest state.
+	 */
+	if (this_cpu_read(x86_guest_ctx_loaded))
+		return NMI_DONE;
+
 	/*
 	 * All PMUs/events that share this PMI handler should make sure to
 	 * increment active_events for their events.
@@ -2727,6 +2739,21 @@ static struct pmu pmu = {
 	.filter			= x86_pmu_filter,
 };
 
+void arch_perf_load_guest_context(unsigned long data)
+{
+	u32 masked = data & APIC_LVT_MASKED;
+
+	apic_write(APIC_LVTPC,
+		   APIC_DM_FIXED | PERF_GUEST_MEDIATED_PMI_VECTOR | masked);
+	this_cpu_write(x86_guest_ctx_loaded, true);
+}
+
+void arch_perf_put_guest_context(void)
+{
+	this_cpu_write(x86_guest_ctx_loaded, false);
+	apic_write(APIC_LVTPC, APIC_DM_NMI);
+}
+
 void arch_perf_update_userpage(struct perf_event *event,
 			       struct perf_event_mmap_page *userpg, u64 now)
 {
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0c529fbd97e6..3a9bd9c4c90e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1846,6 +1846,9 @@ static inline unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs)
 # define perf_arch_guest_misc_flags(regs)	perf_arch_guest_misc_flags(regs)
 #endif
 
+extern void arch_perf_load_guest_context(unsigned long data);
+extern void arch_perf_put_guest_context(void);
+
 static inline bool needs_branch_stack(struct perf_event *event)
 {
 	return event->attr.branch_sample_type != 0;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e1df3c3bfc0d..ad22b182762e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6408,6 +6408,8 @@ void perf_load_guest_context(unsigned long data)
 		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
 	}
 
+	arch_perf_load_guest_context(data);
+
 	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
 	if (cpuctx->task_ctx)
 		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
@@ -6433,6 +6435,8 @@ void perf_put_guest_context(void)
 
 	perf_event_sched_in(cpuctx, cpuctx->task_ctx, NULL, EVENT_GUEST);
 
+	arch_perf_put_guest_context();
+
 	if (cpuctx->task_ctx)
 		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
 	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
-- 
2.50.1.565.gc32cd1483b-goog

