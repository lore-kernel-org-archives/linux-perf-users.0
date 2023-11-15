Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3608F48
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Nov 2023 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DA01FC;
	Wed, 15 Nov 2023 01:28:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7A2C1595;
	Wed, 15 Nov 2023 01:29:08 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.37.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 689733F7B4;
	Wed, 15 Nov 2023 01:28:17 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm: perf: Remove PMU locking
Date: Wed, 15 Nov 2023 14:58:04 +0530
Message-Id: <20231115092805.737822-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231115092805.737822-1-anshuman.khandual@arm.com>
References: <20231115092805.737822-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PMU is disabled and enabled, and the counters are programmed from
contexts where interrupts or preemption is disabled.

The functions to toggle the PMU and to program the PMU counters access the
registers directly and don't access data modified by the interrupt handler.
That, and the fact that they're always called from non-preemptible
contexts, means that we don't need to disable interrupts or use a spinlock.

This is very similar to an earlier change on arm64 platform.

commit 2a0e2a02e4b7 ("arm64: perf: Remove PMU locking").

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm/kernel/perf_event_v6.c     | 28 ++++--------------
 arch/arm/kernel/perf_event_v7.c     | 44 -----------------------------
 arch/arm/kernel/perf_event_xscale.c | 44 ++++++-----------------------
 3 files changed, 13 insertions(+), 103 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index 1ae99deeec54..8fc080c9e4fb 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -268,10 +268,8 @@ static inline void armv6pmu_write_counter(struct perf_event *event, u64 value)
 
 static void armv6pmu_enable_event(struct perf_event *event)
 {
-	unsigned long val, mask, evt, flags;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	unsigned long val, mask, evt;
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	if (ARMV6_CYCLE_COUNTER == idx) {
@@ -294,12 +292,10 @@ static void armv6pmu_enable_event(struct perf_event *event)
 	 * Mask out the current event and set the counter to count the event
 	 * that we're interested in.
 	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val &= ~mask;
 	val |= evt;
 	armv6_pmcr_write(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static irqreturn_t
@@ -362,26 +358,20 @@ armv6pmu_handle_irq(struct arm_pmu *cpu_pmu)
 
 static void armv6pmu_start(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags, val;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
+	unsigned long val;
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val |= ARMV6_PMCR_ENABLE;
 	armv6_pmcr_write(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void armv6pmu_stop(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags, val;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
+	unsigned long val;
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val &= ~ARMV6_PMCR_ENABLE;
 	armv6_pmcr_write(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static int
@@ -419,10 +409,8 @@ static void armv6pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 
 static void armv6pmu_disable_event(struct perf_event *event)
 {
-	unsigned long val, mask, evt, flags;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	unsigned long val, mask, evt;
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	if (ARMV6_CYCLE_COUNTER == idx) {
@@ -444,20 +432,16 @@ static void armv6pmu_disable_event(struct perf_event *event)
 	 * of ETM bus signal assertion cycles. The external reporting should
 	 * be disabled and so this should never increment.
 	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val &= ~mask;
 	val |= evt;
 	armv6_pmcr_write(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void armv6mpcore_pmu_disable_event(struct perf_event *event)
 {
-	unsigned long val, mask, flags, evt = 0;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	unsigned long val, mask, evt = 0;
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	if (ARMV6_CYCLE_COUNTER == idx) {
@@ -475,12 +459,10 @@ static void armv6mpcore_pmu_disable_event(struct perf_event *event)
 	 * Unlike UP ARMv6, we don't have a way of stopping the counters. We
 	 * simply disable the interrupt reporting.
 	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val &= ~mask;
 	val |= evt;
 	armv6_pmcr_write(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static int armv6_map_event(struct perf_event *event)
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index eb2190477da1..c890354b04e9 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -870,10 +870,8 @@ static void armv7_pmnc_dump_regs(struct arm_pmu *cpu_pmu)
 
 static void armv7pmu_enable_event(struct perf_event *event)
 {
-	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	if (!armv7_pmnc_counter_valid(cpu_pmu, idx)) {
@@ -886,7 +884,6 @@ static void armv7pmu_enable_event(struct perf_event *event)
 	 * Enable counter and interrupt, and set the counter to count
 	 * the event that we're interested in.
 	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 
 	/*
 	 * Disable counter
@@ -910,16 +907,12 @@ static void armv7pmu_enable_event(struct perf_event *event)
 	 * Enable counter
 	 */
 	armv7_pmnc_enable_counter(idx);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void armv7pmu_disable_event(struct perf_event *event)
 {
-	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	if (!armv7_pmnc_counter_valid(cpu_pmu, idx)) {
@@ -931,7 +924,6 @@ static void armv7pmu_disable_event(struct perf_event *event)
 	/*
 	 * Disable counter and interrupt
 	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 
 	/*
 	 * Disable counter
@@ -942,8 +934,6 @@ static void armv7pmu_disable_event(struct perf_event *event)
 	 * Disable interrupt for this counter
 	 */
 	armv7_pmnc_disable_intens(idx);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static irqreturn_t armv7pmu_handle_irq(struct arm_pmu *cpu_pmu)
@@ -1009,24 +999,14 @@ static irqreturn_t armv7pmu_handle_irq(struct arm_pmu *cpu_pmu)
 
 static void armv7pmu_start(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	/* Enable all counters */
 	armv7_pmnc_write(armv7_pmnc_read() | ARMV7_PMNC_E);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void armv7pmu_stop(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	/* Disable all counters */
 	armv7_pmnc_write(armv7_pmnc_read() & ~ARMV7_PMNC_E);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static int armv7pmu_get_event_idx(struct pmu_hw_events *cpuc,
@@ -1492,14 +1472,10 @@ static void krait_clearpmu(u32 config_base)
 
 static void krait_pmu_disable_event(struct perf_event *event)
 {
-	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
 	/* Disable counter and interrupt */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 
 	/* Disable counter */
 	armv7_pmnc_disable_counter(idx);
@@ -1512,23 +1488,17 @@ static void krait_pmu_disable_event(struct perf_event *event)
 
 	/* Disable interrupt for this counter */
 	armv7_pmnc_disable_intens(idx);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void krait_pmu_enable_event(struct perf_event *event)
 {
-	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
 	/*
 	 * Enable counter and interrupt, and set the counter to count
 	 * the event that we're interested in.
 	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 
 	/* Disable counter */
 	armv7_pmnc_disable_counter(idx);
@@ -1548,8 +1518,6 @@ static void krait_pmu_enable_event(struct perf_event *event)
 
 	/* Enable counter */
 	armv7_pmnc_enable_counter(idx);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void krait_pmu_reset(void *info)
@@ -1825,14 +1793,10 @@ static void scorpion_clearpmu(u32 config_base)
 
 static void scorpion_pmu_disable_event(struct perf_event *event)
 {
-	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
 	/* Disable counter and interrupt */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 
 	/* Disable counter */
 	armv7_pmnc_disable_counter(idx);
@@ -1845,23 +1809,17 @@ static void scorpion_pmu_disable_event(struct perf_event *event)
 
 	/* Disable interrupt for this counter */
 	armv7_pmnc_disable_intens(idx);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void scorpion_pmu_enable_event(struct perf_event *event)
 {
-	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
 	/*
 	 * Enable counter and interrupt, and set the counter to count
 	 * the event that we're interested in.
 	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 
 	/* Disable counter */
 	armv7_pmnc_disable_counter(idx);
@@ -1881,8 +1839,6 @@ static void scorpion_pmu_enable_event(struct perf_event *event)
 
 	/* Enable counter */
 	armv7_pmnc_enable_counter(idx);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void scorpion_pmu_reset(void *info)
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index f6cdcacfb96d..7a2ba1c689a7 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -203,10 +203,8 @@ xscale1pmu_handle_irq(struct arm_pmu *cpu_pmu)
 
 static void xscale1pmu_enable_event(struct perf_event *event)
 {
-	unsigned long val, mask, evt, flags;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	unsigned long val, mask, evt;
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	switch (idx) {
@@ -229,20 +227,16 @@ static void xscale1pmu_enable_event(struct perf_event *event)
 		return;
 	}
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
 	val &= ~mask;
 	val |= evt;
 	xscale1pmu_write_pmnc(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void xscale1pmu_disable_event(struct perf_event *event)
 {
-	unsigned long val, mask, evt, flags;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	unsigned long val, mask, evt;
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	switch (idx) {
@@ -263,12 +257,10 @@ static void xscale1pmu_disable_event(struct perf_event *event)
 		return;
 	}
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
 	val &= ~mask;
 	val |= evt;
 	xscale1pmu_write_pmnc(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static int
@@ -300,26 +292,20 @@ static void xscalepmu_clear_event_idx(struct pmu_hw_events *cpuc,
 
 static void xscale1pmu_start(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags, val;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
+	unsigned long val;
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
 	val |= XSCALE_PMU_ENABLE;
 	xscale1pmu_write_pmnc(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void xscale1pmu_stop(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags, val;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
+	unsigned long val;
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
 	val &= ~XSCALE_PMU_ENABLE;
 	xscale1pmu_write_pmnc(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static inline u64 xscale1pmu_read_counter(struct perf_event *event)
@@ -549,10 +535,8 @@ xscale2pmu_handle_irq(struct arm_pmu *cpu_pmu)
 
 static void xscale2pmu_enable_event(struct perf_event *event)
 {
-	unsigned long flags, ien, evtsel;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	unsigned long ien, evtsel;
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	ien = xscale2pmu_read_int_enable();
@@ -587,18 +571,14 @@ static void xscale2pmu_enable_event(struct perf_event *event)
 		return;
 	}
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	xscale2pmu_write_event_select(evtsel);
 	xscale2pmu_write_int_enable(ien);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void xscale2pmu_disable_event(struct perf_event *event)
 {
-	unsigned long flags, ien, evtsel, of_flags;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	unsigned long ien, evtsel, of_flags;
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	ien = xscale2pmu_read_int_enable();
@@ -638,11 +618,9 @@ static void xscale2pmu_disable_event(struct perf_event *event)
 		return;
 	}
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	xscale2pmu_write_event_select(evtsel);
 	xscale2pmu_write_int_enable(ien);
 	xscale2pmu_write_overflow_flags(of_flags);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static int
@@ -663,26 +641,20 @@ xscale2pmu_get_event_idx(struct pmu_hw_events *cpuc,
 
 static void xscale2pmu_start(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags, val;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
+	unsigned long val;
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale2pmu_read_pmnc() & ~XSCALE_PMU_CNT64;
 	val |= XSCALE_PMU_ENABLE;
 	xscale2pmu_write_pmnc(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void xscale2pmu_stop(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags, val;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
+	unsigned long val;
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale2pmu_read_pmnc();
 	val &= ~XSCALE_PMU_ENABLE;
 	xscale2pmu_write_pmnc(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static inline u64 xscale2pmu_read_counter(struct perf_event *event)
-- 
2.25.1

