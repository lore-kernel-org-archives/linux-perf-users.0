Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B294BEE52
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271004; cv=none; b=hkZY7ZrfZb8U86btcak+hwj31q1jyXCw7KgO++GhYl1vUVs/iSwzOgKcsC7eTIFy4LzZsHjP2rgV/Cq1Viq/Z5IvjoQ7VWMHM0jUz2pPKp4MET86cGWcBuYv4NzpIrLNZdjqUvwtl5a6wSkKXf3xhIuxIM2DJo1Rane/vYohBM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271004; c=relaxed/simple;
	bh=hmMEP7v8amPzstS4RJUGWTMTM1EFL9VP+ZTiXaq90xQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F5SAhIIed8jHMq2zRH9N6vx2r2KnZY+K9O78pKIgxBIkKQ0jeRzs/BbJwlELpK9CigVNCzi+YhkoGxjrPEcGTe5MidH7Z1gD0/dHkjJ408riGnZ79rgBXZTZbCiLbpF4fXEOluDC8SnVXBEWnjstayxeG9j1V4LrDUTlRpQTc4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZEYq9aEq; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZEYq9aEq"
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4c467e19391so232703b6e.3
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790270996; x=1790875796; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4D4gHkQKKoRXHjGIax2rHuVglLwZYYOZFYlDPDZBIgw=;
        b=ZEYq9aEqZZuD9ey3ZnoC/LnDvh3q1sP1lqtItQbguqCiU6GnRySWduUDCwn0e792rL
         XtQ/s+GOzTVYxXuNTZsnVGHFZqLXxKV+zERkNKgg4WQyXtcuLolzXDSMYrsCO86VWtBd
         Mv6PlLcXuNot/0m6HZGRHBV4pZMtda5snKlCvR6yGIT/YgXlJ6n41k8HP+6n3p+zoqQm
         r//rTVqSyGw/+wdWHd8iUFOeWNXo7OougTx0u3JalDVkXXQOb+VMO7jgCpie6bwxsCIf
         fJRw5+cTe4MRXcZEdWggAnmmcv7PPD0ZEPfiLrdxdvu6FYuMJyA9IDSXnGi5wPQ3S7e0
         rVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790270996; x=1790875796;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4D4gHkQKKoRXHjGIax2rHuVglLwZYYOZFYlDPDZBIgw=;
        b=aRh84oIdjeCABgjrto0lwcj5uHlWSzf3gM98xc9ydRbV3sh7P4c3g6rLEAQA0FVfEd
         9wghCQcggf2/Rkimf0wVXtq5KtLcdRciyc+GQ2JJAcnSzBe2UF2s9oOILBLcp5keuZ9G
         u9fZDMxR4nA0y4lpg7P7LEJsr62rTugCRxBu8nEECEEkrRxPSBrs11NEjtwW8Pf6c/H2
         n9GWiXR+3L32OL0CJd9UB6Hoh3MPdB/FVBfFGFnvUkSONZ4JAkXstEPd2TJdej9zbE/B
         ojs040m7aM2HS8XExKTcRTryh3uNct7LT3xy+pJnOyt63mvhkirg0zCtGv5hOWe8kZWB
         /AkA==
X-Forwarded-Encrypted: i=1; AKwUvByY/5GinWxbBB67m+p4tW7ruKqOycNWkOFW00z/99e/s1gyyM8DGXs8zMtx5Q8Z9cKNpdyMunA1TvRHcTS0vYcU@vger.kernel.org
X-Gm-Message-State: AFuF++ko1cyy4zyhIcqhPYacOijFwVyy6SGwrKDR1gXp2Zlb4Lnq76mo
	BE02QEnR/LEOhd341LPS5XSXCpnrOJHquykyP/2njNLDKbjdhqhFrSzgUSPtZPPOf25uHHYmrbV
	1CEuyh3y2E+rqzcWWE9ULKAkiNg==
X-Received: from jabdy46.prod.google.com ([2002:a05:6638:1d6e:b0:5f4:2682:8634])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2384:b0:4b3:7efc:e970 with SMTP id 5614622812f47-4d72c1440a3mr2840084b6e.5.1790270995915;
 Thu, 24 Sep 2026 10:29:55 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:29:24 +0000
In-Reply-To: <20260924172928.2110956-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924172928.2110956-19-coltonlewis@google.com>
Subject: [PATCH v9 18/22] perf: arm_pmuv3: Handle IRQs for Partitioned PMU
 guest counters
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Robin Murphy <robin.murphy@arm.com>, 
	Zide Chen <zide.chen@intel.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Mingwei Zhang <mizhang@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Shuah Khan <shuah@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Because ARM hardware is not yet capable of direct PPI injection into
guests, guest counters trigger physical PMU interrupts that must be
handled by the host PMU interrupt handler.

In armv8pmu_handle_irq(), clear the overflow flags in hardware for host
counters, restrict host perf event handling to bits in cpuc->cntr_mask,
and pass the overflow flags to kvm_pmu_handle_guest_irq(). The KVM hook
clears the guest counter overflow flags in hardware and records them in
the running vCPU's virtual PMOVSSET_EL0 register for subsequent guest
interrupt injection.

Additionally, provide kvm_pmu_host_start() and kvm_pmu_host_stop() so
that armv8pmu_start() and armv8pmu_stop() toggle MDCR_EL2.HPME rather
than PMCR_EL0.E when a partitioned guest's PMU state is loaded on the
CPU.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm/include/asm/arm_pmuv3.h   |  8 ++++
 arch/arm64/include/asm/arm_pmuv3.h |  5 +++
 arch/arm64/kvm/pmu-direct.c        | 67 ++++++++++++++++++++++++++++++
 drivers/perf/arm_pmuv3.c           | 34 ++++++++-------
 include/kvm/arm_pmu.h              |  6 +++
 5 files changed, 104 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index cec26c12bc009..9b8d6bbbe70cf 100644
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
@@ -235,6 +240,9 @@ static inline u64 kvm_pmu_host_counter_mask(void)
 {
 	return ~0;
 }
+static inline void kvm_pmu_handle_guest_irq(u64 pmovsr) {}
+static inline bool kvm_pmu_host_start(void) { return false; }
+static inline bool kvm_pmu_host_stop(void) { return false; }
 
 /* PMU Version in DFR Register */
 #define ARMV8_PMU_DFR_VER_NI        0
diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index cf2b2212e00a2..9037a28365951 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -110,6 +110,11 @@ static inline void write_pmintenset(u64 val)
 	write_sysreg(val, pmintenset_el1);
 }
 
+static inline u64 read_pmintenset(void)
+{
+	return read_sysreg(pmintenset_el1);
+}
+
 static inline void write_pmintenclr(u64 val)
 {
 	write_sysreg(val, pmintenclr_el1);
diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index 1ada09d54f68f..95b5a64052762 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -512,3 +512,70 @@ void kvm_pmu_set_guest_owned(struct kvm_vcpu *vcpu)
 		kvm_pmu_load(vcpu);
 	}
 }
+
+/**
+ * kvm_pmu_handle_guest_irq() - Record IRQs in guest counters
+ * @pmovsr: Overflow flags reported by driver
+ *
+ * Set overflow flags in guest-reserved counters in the VCPU register
+ * for the guest to clear later.
+ */
+void kvm_pmu_handle_guest_irq(u64 pmovsr)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+	u64 mask = kvm_pmu_guest_counter_mask();
+	u64 govf = pmovsr & mask;
+	int i;
+
+	write_pmovsclr(govf);
+
+	if (!vcpu || !vcpu->arch.pmu.loaded_on_cpu)
+		return;
+
+	for_each_set_bit(i, (unsigned long *)&govf, 64)
+		set_bit(i, (unsigned long *)__ctxt_sys_reg(&vcpu->arch.ctxt, PMOVSSET_EL0));
+}
+
+/**
+ * kvm_pmu_host_start() - Enable host PMU counters while guest owns PMU
+ *
+ * When a partitioned guest owns the PMU, host counters (HPMN..N-1) are
+ * gated by MDCR_EL2.HPME rather than PMCR_EL0.E.
+ *
+ * Return: True if handled via MDCR_EL2.HPME, false if caller should use PMCR_EL0.E
+ */
+bool kvm_pmu_host_start(void)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+
+	if (!vcpu || !kvm_pmu_is_partitioned(vcpu->kvm) ||
+	    !vcpu->arch.pmu.loaded_on_cpu)
+		return false;
+
+	vcpu->arch.mdcr_el2 |= MDCR_EL2_HPME;
+	write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
+	isb();
+	return true;
+}
+
+/**
+ * kvm_pmu_host_stop() - Disable host PMU counters while guest owns PMU
+ *
+ * When a partitioned guest owns the PMU, host counters (HPMN..N-1) are
+ * gated by MDCR_EL2.HPME rather than PMCR_EL0.E.
+ *
+ * Return: True if handled via MDCR_EL2.HPME, false if caller should use PMCR_EL0.E
+ */
+bool kvm_pmu_host_stop(void)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+
+	if (!vcpu || !kvm_pmu_is_partitioned(vcpu->kvm) ||
+	    !vcpu->arch.pmu.loaded_on_cpu)
+		return false;
+
+	vcpu->arch.mdcr_el2 &= ~MDCR_EL2_HPME;
+	write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
+	isb();
+	return true;
+}
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 4fcdae8021a56..3e5f8207a0fee 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -763,18 +763,9 @@ static void armv8pmu_disable_event_irq(struct perf_event *event)
 	armv8pmu_disable_intens(BIT(event->hw.idx));
 }
 
-static u64 armv8pmu_getreset_flags(void)
+static u64 armv8pmu_getovf_flags(void)
 {
-	u64 value;
-
-	/* Read */
-	value = read_pmovsclr();
-
-	/* Write to clear flags */
-	value &= ARMV8_PMU_CNT_MASK_ALL;
-	write_pmovsclr(value);
-
-	return value;
+	return read_pmovsclr() & ARMV8_PMU_CNT_MASK_ALL;
 }
 
 static void update_pmuserenr(u64 val)
@@ -864,7 +855,8 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
 		brbe_enable(cpu_pmu);
 
 	/* Enable all counters */
-	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
+	if (!kvm_pmu_host_start())
+		armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
 }
 
 static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
@@ -875,7 +867,8 @@ static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
 		brbe_disable();
 
 	/* Disable all counters */
-	armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
+	if (!kvm_pmu_host_stop())
+		armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
 }
 
 static void read_branch_records(struct pmu_hw_events *cpuc,
@@ -890,16 +883,16 @@ static void read_branch_records(struct pmu_hw_events *cpuc,
 
 static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 {
-	u64 pmovsr;
 	struct perf_sample_data data;
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
+	u64 pmovsr;
 	int idx;
 
 	/*
-	 * Get and reset the IRQ flags
+	 * Get the IRQ flags
 	 */
-	pmovsr = armv8pmu_getreset_flags();
+	pmovsr = armv8pmu_getovf_flags();
 
 	/*
 	 * Did an overflow occur?
@@ -907,6 +900,12 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 	if (!armv8pmu_has_overflowed(pmovsr))
 		return IRQ_NONE;
 
+	/*
+	 * Guest flag reset is handled by the kvm hook at the bottom of
+	 * this function.
+	 */
+	write_pmovsclr(pmovsr & ~kvm_pmu_guest_counter_mask());
+
 	/*
 	 * Handle the counter(s) overflow(s)
 	 */
@@ -948,6 +947,9 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		 */
 		perf_event_overflow(event, &data, regs);
 	}
+
+	kvm_pmu_handle_guest_irq(pmovsr);
+
 	armv8pmu_start(cpu_pmu);
 
 	return IRQ_HANDLED;
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 0f2e39367d637..955f142a41b94 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -109,6 +109,9 @@ u64 kvm_pmu_guest_counter_mask(void);
 void kvm_pmu_load(struct kvm_vcpu *vcpu);
 void kvm_pmu_put(struct kvm_vcpu *vcpu);
 void kvm_pmu_set_guest_owned(struct kvm_vcpu *vcpu);
+void kvm_pmu_handle_guest_irq(u64 pmovsr);
+bool kvm_pmu_host_start(void);
+bool kvm_pmu_host_stop(void);
 void kvm_pmu_apply_single_event_filter(struct kvm_vcpu *vcpu, u8 idx);
 
 #define kvm_pmu_get_access(vcpu)	((vcpu)->arch.pmu.access)
@@ -274,6 +277,9 @@ static inline u64 kvm_pmu_guest_counter_mask(void)
 	return 0;
 }
 
+static inline void kvm_pmu_handle_guest_irq(u64 pmovsr) {}
+static inline bool kvm_pmu_host_start(void) { return false; }
+static inline bool kvm_pmu_host_stop(void) { return false; }
 static inline void kvm_pmu_apply_single_event_filter(struct kvm_vcpu *vcpu, u8 idx) {}
 
 static inline bool has_kvm_pmu_partition_support(void)
-- 
2.56.0.rc1.310.g51773c2048-goog

