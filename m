Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EE142317A
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929536; cv=none; b=cSqu/1b2ax3/vX7luSJYRhcl80lAUs49qBD9mxFo9uI3/EBwXPDYCtcxQLdW/iWlfL/LZ+wxIz4k3zGe+Hh8aSEipq0tAee1y83TCybuH0cMS2RhxDAj5juZ3jykjzjYlEG51aKpwZDsQbBZmV3dDVP3JhD51lz+8lgv61JdetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929536; c=relaxed/simple;
	bh=k8iyj1/1BXo34cJSPgEwIM1AOUBCe1L4nQxz3yETR6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OPRZWSyBWRxZpSCidkcmjaq/L5+IRsvWUS/izm+Tr94OnLG1Wa1WCFQUF+v6Els3mgNEI8pFridwX9BNsIzueM0QbJh96NwhM0qi2olkjTFfzRw6tFQCPf1h7BB6Cq+YqccLuxwWHDucZhgRvdlv+OyRxIVmYzZ4B7tXHuyaRU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=icZP8wti; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="icZP8wti"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-464a0af43deso7466360b6e.3
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 14:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777929528; x=1778534328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BCrq3V77MhQdmPRoJ9FxVuhSDGit6Nv3jKM6DslS2rc=;
        b=icZP8wti2/th4eFCRRVy1SjqOagkqqFmBfMlmjBwLp21plfGbUr7sUyCDsPfzh9Xlc
         T43zyOhTVARmDzuGvLsrMXaRxAMl9Fc5jwdTW1sdE6502BcTCoQUu1wygw3wSm+thL1h
         11AS4UNylrYOqQ8yZAFI+0GKlP3+2dVSHf6S18KkcgHa8kDRCMZ53TuHHMxVaAFgogXL
         SDmAHgPwahbSUmAc16WD39WlYR3FTnqDicRBpML1VGiPa6B79xthFsOqekradUhvNezZ
         ShELi+AzCXvt6SMJ9/ZHulhmSJ8XQq3h9w3Q5zKk8wWu8/SMcMNU7N/X+GhdSLG0jfD0
         llkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929528; x=1778534328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BCrq3V77MhQdmPRoJ9FxVuhSDGit6Nv3jKM6DslS2rc=;
        b=gzWqqaK35epzJTcQ8AS4NqKbFu6YycvNZHoCLW8HJWMV+T6dUfSImp+U/76Mt1ay+w
         pU6NMZ7FycV0I9CTSB9tmsf/HBi07u/LwuUWV4TcNCO1s1y3zi3nlvvXPzn2O/9q1OjT
         aMsCdpgElVdyHXbmKrHakVfM3Uah+X5I91yZLQvscBxOzXxRBrUva6xe9Os4RskjdK0/
         IFfUW/idUqJ9WnvX1PrlAJkZSqERonsvFH7k6a7Rm5xaQ4XlGsnFbrzhRvlg0fOiipH3
         sgZBgbKiLax+rsELXJ+vJI0RxUOXv21nYHVxmGxTMV3N2IWA/8eFMTGRd1ANJj30AqNV
         q1zQ==
X-Forwarded-Encrypted: i=1; AFNElJ/sUS6DelbOSidSSQ82PPDR+G9UOH2GHsoFSNb97Iss+67cdk/v1JMYMaV75rgADI2mQm5htCdTmCjA1jE2rUnp@vger.kernel.org
X-Gm-Message-State: AOJu0YwgTT2oS8E0yNZO2+qU5E/g9oo4dP1HqmVrF/cqG8QerKVGdnnz
	DP0aN679UYfc3yvI5JVSpxADmC5A/bYNxcexqE8QQ/2o4yoPnLw4d1oTpMf0qbH5+XQ0VLgjmRB
	7jSBQstwf68wj3CV9tTp9fOHiYA==
X-Received: from ilvd7.prod.google.com ([2002:a05:6e02:2147:b0:4fc:3ae9:bfd8])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:6ac3:b0:694:8cb0:4ef8 with SMTP id 006d021491bc7-696979ad636mr5118080eaf.9.1777929527969;
 Mon, 04 May 2026 14:18:47 -0700 (PDT)
Date: Mon,  4 May 2026 21:18:08 +0000
In-Reply-To: <20260504211813.1804997-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504211813.1804997-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504211813.1804997-16-coltonlewis@google.com>
Subject: [PATCH v7 15/20] perf: arm_pmuv3: Handle IRQs for Partitioned PMU
 guest counters
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	James Clark <james.clark@linaro.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Because ARM hardware is not yet capable of direct PPI injection into
guests, guest counters will still trigger interrupts that need to be
handled by the host PMU interrupt handler. Clear the overflow flags in
hardware to handle the interrupt as normal, but the virtual overflow
register for later injecting the interrupt into the guest.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm/include/asm/arm_pmuv3.h   |  6 ++++++
 arch/arm64/include/asm/arm_pmuv3.h |  5 +++++
 arch/arm64/kvm/pmu-direct.c        | 22 ++++++++++++++++++++++
 drivers/perf/arm_pmuv3.c           | 24 +++++++++++++++++-------
 include/kvm/arm_pmu.h              |  3 +++
 5 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index eebc89bdab7a1..0d01508c5b77f 100644
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
@@ -239,6 +244,7 @@ static inline u64 kvm_pmu_host_counter_mask(struct arm_pmu *pmu)
 {
 	return ~0;
 }
+static inline void kvm_pmu_handle_guest_irq(struct arm_pmu *pmu, u64 pmovsr) {}
 
 /* PMU Version in DFR Register */
 #define ARMV8_PMU_DFR_VER_NI        0
diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 27c4d6d47da31..69ff4d014bf39 100644
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
index 881cea5117515..535b4c492ff80 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -411,3 +411,25 @@ void kvm_pmu_put(struct kvm_vcpu *vcpu)
 	kvm_pmu_set_guest_counters(pmu, 0);
 	preempt_enable();
 }
+
+/**
+ * kvm_pmu_handle_guest_irq() - Record IRQs in guest counters
+ * @pmu: PMU to check for overflows
+ * @pmovsr: Overflow flags reported by driver
+ *
+ * Set overflow flags in guest-reserved counters in the VCPU register
+ * for the guest to clear later.
+ */
+void kvm_pmu_handle_guest_irq(struct arm_pmu *pmu, u64 pmovsr)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+	u64 mask = kvm_pmu_guest_counter_mask(pmu);
+	u64 govf = pmovsr & mask;
+
+	write_pmovsclr(govf);
+
+	if (!vcpu)
+		return;
+
+	__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, govf);
+}
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 6e447227d801f..16e3700dca645 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -774,16 +774,15 @@ static void armv8pmu_disable_event_irq(struct perf_event *event)
 	armv8pmu_disable_intens(BIT(event->hw.idx));
 }
 
-static u64 armv8pmu_getreset_flags(void)
+static u64 armv8pmu_getovf_flags(void)
 {
 	u64 value;
 
 	/* Read */
 	value = read_pmovsclr();
 
-	/* Write to clear flags */
-	value &= ARMV8_PMU_CNT_MASK_ALL;
-	write_pmovsclr(value);
+	/* Only report interrupt enabled counters. */
+	value &= read_pmintenset();
 
 	return value;
 }
@@ -897,16 +896,17 @@ static void read_branch_records(struct pmu_hw_events *cpuc,
 
 static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 {
-	u64 pmovsr;
 	struct perf_sample_data data;
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
+	u64 host_set = kvm_pmu_host_counter_mask(cpu_pmu);
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
@@ -914,6 +914,12 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 	if (!armv8pmu_has_overflowed(pmovsr))
 		return IRQ_NONE;
 
+	/*
+	 * Guest flag reset is handled the kvm hook at the bottom of
+	 * this function.
+	 */
+	write_pmovsclr(pmovsr & host_set);
+
 	/*
 	 * Handle the counter(s) overflow(s)
 	 */
@@ -955,6 +961,10 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		 */
 		perf_event_overflow(event, &data, regs);
 	}
+
+	if (kvm_pmu_is_partitioned(cpu_pmu))
+		kvm_pmu_handle_guest_irq(cpu_pmu, pmovsr);
+
 	armv8pmu_start(cpu_pmu);
 
 	return IRQ_HANDLED;
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 0de63cc48fef9..de058a5347d18 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -95,6 +95,7 @@ void kvm_vcpu_pmu_resync_el0(void);
 	(vcpu_has_feature(vcpu, KVM_ARM_VCPU_PMU_V3))
 
 bool kvm_pmu_is_partitioned(struct arm_pmu *pmu);
+void kvm_pmu_handle_guest_irq(struct arm_pmu *pmu, u64 pmovsr);
 
 u8 kvm_pmu_guest_num_counters(struct kvm_vcpu *vcpu);
 u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu);
@@ -290,6 +291,8 @@ static inline u64 kvm_pmu_guest_counter_mask(void *kvm)
 	return 0;
 }
 
+static inline void kvm_pmu_handle_guest_irq(struct arm_pmu *pmu, u64 pmovsr) {}
+
 #endif
 
 #endif
-- 
2.54.0.545.g6539524ca2-goog

