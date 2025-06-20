Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0110725A341
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457943; cv=none; b=o7k3gwKixI417eLz44IHh8+MDaUZc9V1Y0MLahLckYoXh0V9If3YBeqXW3+OrpGnCsdE1bqgGTPnZc1ni8DdY1u85eRjztj7ZOawBGei/2Ua88LZL5BsAPFzQzrKC0v5pQ29rOAVAOX3f/87y1L/Ssso+5M9dtrm17FeSu+Rz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457943; c=relaxed/simple;
	bh=UtUM3ldBidk/ZfqaXCJxpZLHCIFaPdHm1CFC9ZX/g4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VHZ4N2VP07AL501HAoAP0MRxLTrG5Nezr0ECbx4vzmiB02xyEh+NLXbovAs6lMUIHqXqG7rp5zjrXShXsvM/hU3j4a7O+xBpv/mIyWpUkN8ljamjutrMPn1Q9qlxn8MkBYxEFeaBbvS27Z8iMAoOpuedoW2WEwhpvEeqEKlUyzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFV4/Kto; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFV4/Kto"
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-739f86ef076so928108a34.3
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 15:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457939; x=1751062739; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I8HXxU2VCpz4OytKr27sB5aizCv0X4297FAz3aEz5bM=;
        b=IFV4/KtoA1XRU73QGF/Jsc+rrtFOg3X+dp+gnwetWypQlUvBbjKu2Ui/F1eTtwxLIm
         aI3Yi5qDFAjGqgV+KzKGxAGSDDoyS8CUv2+sz6FKTGwcNroMmlLG66zEbpuD7QaSFrLs
         LzsKUetLbc17ceE/ebPYnRzNdnnsnfYovU2ma/f7c89t7szN8WfAzeTzLNuLKdKSIxMd
         d+T9ZdJ1J5rEPjn9DS8ER9GPtP62dwLA2Pb8rrIrV+RPrgSRuVrqllyHzFXWX0iXHpjf
         O/94dmNxC1X8s+vUa5AADajA3ATY5wWzSTf1npsD1eo6md6InvlO57OzxLA0AASt13Tb
         xQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457939; x=1751062739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8HXxU2VCpz4OytKr27sB5aizCv0X4297FAz3aEz5bM=;
        b=etz6LlyDKDMxe9ItUlyCe0m9d1nG+ur6wWNCO/nq4+cFaj+ARQmKP0xpn/M+9cJ9OE
         /ziYMrnXREAIYJg2IchxMRJ01lNOJtRvaF6qIXC50JBdXf8QKHIqoHhlulZnBm1SWSeX
         /byfn/h9kgeIWxdXzwQyM2/yJVUqDdWJRrBvd8wxkJDAPNvb9kthAjRJq3m0h0uIRgtD
         5jiWpmCh1vZF0y/L27l9U+m3MC0pthEkDaOVrtG/BF4m8OsIifoxYk0GA0ibBGiDt081
         N4v6VxiP93oa9K93Hmd6rO8lEw9B/fo4Dskq4aia8wKiDZ91aYImfVBCKdTtEoJxcSt7
         aA9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUem2OlkfnltwCrGWHYtMBXveXsd3L4mZml5sGU5lwsfG8HFQM0UaacLpiwKr6GwzI6ndsM2zoMOG0tBKZ3goNT@vger.kernel.org
X-Gm-Message-State: AOJu0YwL0jZ/B9nv58tXH5jXZ3PCkIUozW7bmZin6+fygTg1bTlmFXYh
	jSooGlwCx/UPmMrO7hVYhqpLMgh/Wo59vi/TjMMdW+WxCRE9MNkTmMUVeNw06SK1qFoVRMF5evN
	TlQZ3WLVuA2wS7S5pI/IMyhOJ1w==
X-Google-Smtp-Source: AGHT+IFuCnKy8+3z6ev+AWX/d4ZAkywXzAnOdFqueu4NAyl6W7lB7Mj76T4KDs7bBDbPFd+NK7woFdJUSx22J1vOEg==
X-Received: from otbek10.prod.google.com ([2002:a05:6830:710a:b0:735:b23b:2682])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:840d:b0:734:f5e2:8cbc with SMTP id 46e09a7af769-73a91d24190mr2042962a34.18.1750457939613;
 Fri, 20 Jun 2025 15:18:59 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:22 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-23-coltonlewis@google.com>
Subject: [PATCH v2 20/23] perf: pmuv3: Handle IRQs for Partitioned PMU guest counters
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Guest counters will still trigger interrupts that need to be handled
by the host PMU interrupt handler. Clear the overflow flags in
hardware to handle the interrupt as normal, but record which guest
overflow flags were set in the virtual overflow register for later
injecting the interrupt into the guest.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm/include/asm/arm_pmuv3.h |  6 ++++++
 arch/arm64/include/asm/kvm_pmu.h |  2 ++
 arch/arm64/kvm/pmu-part.c        | 17 +++++++++++++++++
 drivers/perf/arm_pmuv3.c         | 15 +++++++++++----
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index 59c471c33c77..b5caedaef594 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -180,6 +180,11 @@ static inline void write_pmintenset(u32 val)
 	write_sysreg(val, PMINTENSET);
 }
 
+static inline u32 read_pmintenset(void)
+{
+	return read_sysreg(PMINTENSET);
+}
+
 static inline void write_pmintenclr(u32 val)
 {
 	write_sysreg(val, PMINTENCLR);
@@ -245,6 +250,7 @@ static inline u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu)
 	return ~0;
 }
 
+static inline void kvm_pmu_handle_guest_irq(u64 govf) {}
 
 static inline bool has_vhe(void)
 {
diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
index 8193f48c42d0..72e96d7df9ba 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -93,6 +93,7 @@ u64 kvm_pmu_host_counter_mask(struct arm_pmu *pmu);
 u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu);
 void kvm_pmu_host_counters_enable(void);
 void kvm_pmu_host_counters_disable(void);
+void kvm_pmu_handle_guest_irq(u64 govf);
 
 u8 kvm_pmu_guest_num_counters(struct kvm_vcpu *vcpu);
 u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu);
@@ -244,6 +245,7 @@ static inline u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu)
 
 static inline void kvm_pmu_host_counters_enable(void) {}
 static inline void kvm_pmu_host_counters_disable(void) {}
+static inline void kvm_pmu_handle_guest_irq(u64 govf) {}
 
 #endif
 
diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
index fd19a1dd7901..8c35447ef103 100644
--- a/arch/arm64/kvm/pmu-part.c
+++ b/arch/arm64/kvm/pmu-part.c
@@ -319,3 +319,20 @@ void kvm_pmu_put(struct kvm_vcpu *vcpu)
 	val = read_pmintenset();
 	__vcpu_assign_sys_reg(vcpu, PMINTENSET_EL1, val & mask);
 }
+
+/**
+ * kvm_pmu_handle_guest_irq() - Record IRQs in guest counters
+ * @govf: Bitmask of guest overflowed counters
+ *
+ * Record IRQs from overflows in guest-reserved counters in the VCPU
+ * register for the guest to clear later.
+ */
+void kvm_pmu_handle_guest_irq(u64 govf)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+
+	if (!vcpu)
+		return;
+
+	__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= govf;
+}
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 48ff8c65de68..52c9a79bea74 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -755,6 +755,8 @@ static u64 armv8pmu_getreset_flags(void)
 
 	/* Write to clear flags */
 	value &= ARMV8_PMU_CNT_MASK_ALL;
+	/* Only reset interrupt enabled counters. */
+	value &= read_pmintenset();
 	write_pmovsclr(value);
 
 	return value;
@@ -857,6 +859,7 @@ static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
 static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 {
 	u64 pmovsr;
+	u64 govf;
 	struct perf_sample_data data;
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
@@ -883,19 +886,17 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 	 * to prevent skews in group events.
 	 */
 	armv8pmu_stop(cpu_pmu);
+
 	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMPMU_MAX_HWEVENTS) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
 		/* Ignore if we don't have an event. */
-		if (!event)
-			continue;
-
 		/*
 		 * We have a single interrupt for all counters. Check that
 		 * each counter has overflowed before we process it.
 		 */
-		if (!armv8pmu_counter_has_overflowed(pmovsr, idx))
+		if (!event || !armv8pmu_counter_has_overflowed(pmovsr, idx))
 			continue;
 
 		hwc = &event->hw;
@@ -911,6 +912,12 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		 */
 		perf_event_overflow(event, &data, regs);
 	}
+
+	govf = pmovsr & kvm_pmu_guest_counter_mask(cpu_pmu);
+
+	if (kvm_pmu_is_partitioned(cpu_pmu) && govf)
+		kvm_pmu_handle_guest_irq(govf);
+
 	armv8pmu_start(cpu_pmu);
 
 	return IRQ_HANDLED;
-- 
2.50.0.714.g196bf9f422-goog

