Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99430C4320E
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Jul 2021 23:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BAFC61055
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Jul 2021 23:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhG1XCq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Jul 2021 19:02:46 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:36708 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbhG1XCp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Jul 2021 19:02:45 -0400
Received: by mail-il1-f176.google.com with SMTP id c3so3911865ilh.3;
        Wed, 28 Jul 2021 16:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OlxhkbpU4nmz7mi89ehT/s5YzHtXWqhp1iY8cLO7UBc=;
        b=s2fQGJH2CgHFRCwq8U0YEGgL10EQLsHmvtIByF8zwX+URTOEuujUfPQA3j4ErLxRvZ
         3CspAUlau5F2ag07noSjxHZkqWjwbp2r6zmI6XJWgxITQppSl0TJSCcnM/1mtKw9w/j1
         aXVDIaQfddYVJ4+88SdvRaaZjPzGKJDQRqDcU9o0W1pdEe4OqI35HCi2mEbnLkZrEkRo
         gs+FzLpvZXN+8/gCe7FYY4hv1gYqDQqEkEOoq0wntueZGbNEEV1/skK3LmsFWbmddjrm
         GYm9rJhVuu1j7E9sQCmF/tdHUstOSmaXNl+cKNd8DeqEtpyRauqHidOb8U5iR7iQWmX+
         j6yA==
X-Gm-Message-State: AOAM531VEupt5CsGd0MrVZRrC7Ud5mcIzUnJayOseHvoniMapHtOdVm4
        ViaXPvvUoHUJiUyFbHSIew==
X-Google-Smtp-Source: ABdhPJx1SekHX1X78Z7Gb3st0jNWwI0MvaovP32m+aDxgwHQlsAwg/Q6byj115NVY25/I/a5OA5uFQ==
X-Received: by 2002:a92:750f:: with SMTP id q15mr1118351ilc.240.1627513362527;
        Wed, 28 Jul 2021 16:02:42 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id j20sm974821ile.17.2021.07.28.16.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 16:02:41 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [RFC 2/3] perf/x86: Control RDPMC access from .enable() hook
Date:   Wed, 28 Jul 2021 17:02:29 -0600
Message-Id: <20210728230230.1911468-3-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210728230230.1911468-1-robh@kernel.org>
References: <20210728230230.1911468-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Rather than controlling RDPMC access behind the scenes from switch_mm(),
move RDPMC access controls to the PMU .enable() hook. The .enable() hook
is called whenever the perf CPU or task context changes which is when
the RDPMC access may need to change.

This is the first step in moving the RDPMC state tracking out of the mm
context to the perf context.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Not sure, but I think the set_attr_rdpmc() IPI needs to hold the perf
ctx lock?


 arch/x86/events/core.c             | 75 +++++++++++++++++++-----------
 arch/x86/include/asm/mmu_context.h |  6 ---
 arch/x86/include/asm/perf_event.h  |  1 -
 arch/x86/mm/tlb.c                  | 29 +-----------
 4 files changed, 49 insertions(+), 62 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 03f87fd4c017..5c1703206ef5 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -52,8 +52,8 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
 	.pmu = &pmu,
 };

-DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
-DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
+static DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
+static DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
 DEFINE_STATIC_KEY_FALSE(perf_is_hybrid);

 /*
@@ -727,11 +727,52 @@ static void x86_pmu_disable(struct pmu *pmu)
 	static_call(x86_pmu_disable_all)();
 }

+static void perf_clear_dirty_counters(struct cpu_hw_events *cpuc)
+{
+	int i;
+
+	 /* Don't need to clear the assigned counter. */
+	for (i = 0; i < cpuc->n_events; i++)
+		__clear_bit(cpuc->assign[i], cpuc->dirty);
+
+	if (bitmap_empty(cpuc->dirty, X86_PMC_IDX_MAX))
+		return;
+
+	for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
+		/* Metrics and fake events don't have corresponding HW counters. */
+		if (is_metric_idx(i) || (i == INTEL_PMC_IDX_FIXED_VLBR))
+			continue;
+		else if (i >= INTEL_PMC_IDX_FIXED)
+			wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
+		else
+			wrmsrl(x86_pmu_event_addr(i), 0);
+	}
+
+	bitmap_zero(cpuc->dirty, X86_PMC_IDX_MAX);
+}
+
+static void x86_pmu_set_user_access(struct cpu_hw_events *cpuc)
+{
+	if (static_branch_unlikely(&rdpmc_always_available_key) ||
+	    (!static_branch_unlikely(&rdpmc_never_available_key) &&
+	     atomic_read(&(this_cpu_read(cpu_tlbstate.loaded_mm)->context.perf_rdpmc_allowed)))) {
+		/*
+		 * Clear the existing dirty counters to
+		 * prevent the leak for an RDPMC task.
+		 */
+		perf_clear_dirty_counters(cpuc);
+		cr4_set_bits_irqsoff(X86_CR4_PCE);
+	} else
+		cr4_clear_bits_irqsoff(X86_CR4_PCE);
+}
+
 void x86_pmu_enable_all(int added)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int idx;

+	x86_pmu_set_user_access(cpuc);
+
 	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
 		struct hw_perf_event *hwc = &cpuc->events[idx]->hw;

@@ -2476,29 +2517,9 @@ static int x86_pmu_event_init(struct perf_event *event)
 	return err;
 }

-void perf_clear_dirty_counters(void)
+static void x86_pmu_set_user_access_ipi(void *unused)
 {
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	int i;
-
-	 /* Don't need to clear the assigned counter. */
-	for (i = 0; i < cpuc->n_events; i++)
-		__clear_bit(cpuc->assign[i], cpuc->dirty);
-
-	if (bitmap_empty(cpuc->dirty, X86_PMC_IDX_MAX))
-		return;
-
-	for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
-		/* Metrics and fake events don't have corresponding HW counters. */
-		if (is_metric_idx(i) || (i == INTEL_PMC_IDX_FIXED_VLBR))
-			continue;
-		else if (i >= INTEL_PMC_IDX_FIXED)
-			wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
-		else
-			wrmsrl(x86_pmu_event_addr(i), 0);
-	}
-
-	bitmap_zero(cpuc->dirty, X86_PMC_IDX_MAX);
+	x86_pmu_set_user_access(this_cpu_ptr(&cpu_hw_events));
 }

 static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
@@ -2519,7 +2540,7 @@ static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 	mmap_assert_write_locked(mm);

 	if (atomic_inc_return(&mm->context.perf_rdpmc_allowed) == 1)
-		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
+		on_each_cpu_mask(mm_cpumask(mm), x86_pmu_set_user_access_ipi, NULL, 1);
 }

 static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
@@ -2528,7 +2549,7 @@ static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *m
 		return;

 	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
-		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
+		on_each_cpu_mask(mm_cpumask(mm), x86_pmu_set_user_access_ipi, NULL, 1);
 }

 static int x86_pmu_event_idx(struct perf_event *event)
@@ -2584,7 +2605,7 @@ static ssize_t set_attr_rdpmc(struct device *cdev,
 		else if (x86_pmu.attr_rdpmc == 2)
 			static_branch_dec(&rdpmc_always_available_key);

-		on_each_cpu(cr4_update_pce, NULL, 1);
+		on_each_cpu(x86_pmu_set_user_access_ipi, NULL, 1);
 		x86_pmu.attr_rdpmc = val;
 	}

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 27516046117a..1cbb32ac245e 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -22,12 +22,6 @@ static inline void paravirt_activate_mm(struct mm_struct *prev,
 }
 #endif	/* !CONFIG_PARAVIRT_XXL */

-#ifdef CONFIG_PERF_EVENTS
-DECLARE_STATIC_KEY_FALSE(rdpmc_never_available_key);
-DECLARE_STATIC_KEY_FALSE(rdpmc_always_available_key);
-void cr4_update_pce(void *ignored);
-#endif
-
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
 /*
  * ldt_structs can be allocated, used, and freed, but they are never
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8fc1b5003713..544f41a179fb 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -478,7 +478,6 @@ struct x86_pmu_lbr {

 extern void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap);
 extern void perf_check_microcode(void);
-extern void perf_clear_dirty_counters(void);
 extern int x86_perf_rdpmc_index(struct perf_event *event);
 #else
 static inline void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index cfe6b1e85fa6..060a3de78380 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -400,31 +400,6 @@ static void cond_ibpb(struct task_struct *next)
 	}
 }

-#ifdef CONFIG_PERF_EVENTS
-static inline void cr4_update_pce_mm(struct mm_struct *mm)
-{
-	if (static_branch_unlikely(&rdpmc_always_available_key) ||
-	    (!static_branch_unlikely(&rdpmc_never_available_key) &&
-	     atomic_read(&mm->context.perf_rdpmc_allowed))) {
-		/*
-		 * Clear the existing dirty counters to
-		 * prevent the leak for an RDPMC task.
-		 */
-		perf_clear_dirty_counters();
-		cr4_set_bits_irqsoff(X86_CR4_PCE);
-	} else
-		cr4_clear_bits_irqsoff(X86_CR4_PCE);
-}
-
-void cr4_update_pce(void *ignored)
-{
-	cr4_update_pce_mm(this_cpu_read(cpu_tlbstate.loaded_mm));
-}
-
-#else
-static inline void cr4_update_pce_mm(struct mm_struct *mm) { }
-#endif
-
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			struct task_struct *tsk)
 {
@@ -581,10 +556,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	this_cpu_write(cpu_tlbstate.loaded_mm, next);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);

-	if (next != real_prev) {
-		cr4_update_pce_mm(next);
+	if (next != real_prev)
 		switch_ldt(real_prev, next);
-	}
 }

 /*
--
2.27.0
