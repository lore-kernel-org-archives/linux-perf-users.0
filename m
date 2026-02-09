Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008CE325726
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770676862; cv=none; b=HE5CJfjiV4PIkDKt7sWg4kquGdy5ufGiOzE/6dMGDi7a85I1Mr/VN1OQPQESx+2Zi1mW4yGCVYju2etmJErx9UgyY0aLLWh98rJuj8dh+t9Sfy6Q4yLsVqeDSc8Am3QlxvJy6y65xB/uVW0ypPPK0qJyimCclzX+yguhc+dtsPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770676862; c=relaxed/simple;
	bh=+PFbR8ZNDdGusVlDRio/6EupmgT2xKnhpLR1U03oicM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oE9wqfNLU3PVxM2PTRDGQXzcYaiZ1BK7b/g1Ssw9Gesk4tPACnYjLSYpXjdXluSdvxpRc8YWuD2hEOR0HeYmx5u0SnnPgdKsnXkd+onQnhJw8Hf5ZX4f4N7bQwkKzmvfZbJsib9neYlrmIql6FSg/jdUAIXGlHr72VUKy2eoVms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rMPzMWgR; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMPzMWgR"
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7cfd0f67288so9639890a34.3
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 14:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770676858; x=1771281658; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTgLU/vlu0rEnv4svs9zdi9v/ds5aA8zfTq/qKcEnmk=;
        b=rMPzMWgRRcbVJGr+4+/FsjgZNvlQJqVcEykkXkZmIj5qFzbgiHvPut83zUwQVz1dKJ
         Qbk+Ox96f7kdUDvrDH0arbZP3KzsIogIf9P+tHlR1sMtY7Su3mXzaybvy9s90rRtnHJv
         ma0NcY7okT4DN3sCc3+NDTur1FoZAjgEPJvaKFYzxSQlZ0MNJ8b3Btd3iixgcYD4t5Oy
         G2mmCj0EotJ3EgZ7GbAqMtxp5PIrqN4/nd1XcsLAGPNnwrwj2XbZHG9Ug+mO7KVUtG+u
         7xF9ED1f6nrlaCdSAyyCK/9LY3Y2CZWf4Hhx5v3b6cGFVHbebsnvBfVbhrKaPAR67cws
         IYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770676858; x=1771281658;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTgLU/vlu0rEnv4svs9zdi9v/ds5aA8zfTq/qKcEnmk=;
        b=jyPiQnvk7ZgGz9/dzQaXRhAG7su+WZhvKt5OkS8wueJYmYi2EXtVoARqvdqmcuq8WS
         fbLHO4W8DVk8Le8so2xn8lQLeGCRnEzTSra4zHkW+p4FkHswSaFGm0KFHU8PuX7c3egW
         kkVwY29OrXbuS99kCUEjGArh93B0JxwNa5jGVp4f4YsOADn3gcfhGMDf0dlLURbpHbBv
         mzPFQ8p6Ckht+LYflnAeiQ5m/fGprGEYXjmiqcFT62QDmqXD71ijD5LtsR8EpikbasFa
         07psSn/kbkMBYnOLN3vlbmXm8D2z9qIgAOzjR/z9cbSfTzp1hnGaGNVbeDobb6WWbywj
         9JxA==
X-Forwarded-Encrypted: i=1; AJvYcCXP1FiEbAqNSUohT+77CHHVKa0qFuyJFEI064Xw09sc4Vr+6IJ9zPaXlgnSG7DYFXRE5F7QLDYb9eSHGn1pfAr/@vger.kernel.org
X-Gm-Message-State: AOJu0YytZXYq15G031w01lA8BRLpJiW/dv522jiQkCQp9yyfVygFtwu3
	6Q6voyUVMjZxKD3Wdm51PwwWqaBGU462tzQOSDg13KI0pePh79RKGZSnqhK+Fe2KcWpOHO+5Mhx
	gCiACZi2PamMMn9UFrHKYdRaGdA==
X-Received: from iorw25.prod.google.com ([2002:a5d:8459:0:b0:957:5e45:b59b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:806:b0:662:fb1b:ff9e with SMTP id 006d021491bc7-66d0c94e605mr6655176eaf.69.1770676857913;
 Mon, 09 Feb 2026 14:40:57 -0800 (PST)
Date: Mon,  9 Feb 2026 22:14:08 +0000
In-Reply-To: <20260209221414.2169465-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209221414.2169465-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260209221414.2169465-14-coltonlewis@google.com>
Subject: [PATCH v6 13/19] KVM: arm64: Implement lazy PMU context swaps
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Since many guests will never touch the PMU, they need not pay the cost
of context swapping those registers.

Use an enum to implement a simple state machine for PMU register
access. The PMU is either free or guest owned. We only need to context
swap if the PMU registers are guest owned. The PMU initially starts as
free and only transitions to guest owned if a guest has touched the
PMU registers.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/kvm_host.h  |  1 +
 arch/arm64/include/asm/kvm_types.h |  6 +++++-
 arch/arm64/kvm/debug.c             |  2 +-
 arch/arm64/kvm/hyp/vhe/switch.c    |  2 ++
 arch/arm64/kvm/pmu-direct.c        | 26 ++++++++++++++++++++++++--
 include/kvm/arm_pmu.h              |  5 +++++
 6 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 8e09865490a9f..41577ede0254f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1377,6 +1377,7 @@ static inline bool kvm_system_needs_idmapped_vectors(void)
 	return cpus_have_final_cap(ARM64_SPECTRE_V3A);
 }
 
+void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu);
 void kvm_init_host_debug_data(void);
 void kvm_debug_init_vhe(void);
 void kvm_vcpu_load_debug(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/include/asm/kvm_types.h b/arch/arm64/include/asm/kvm_types.h
index 9a126b9e2d7c9..4e39cbc80aa0b 100644
--- a/arch/arm64/include/asm/kvm_types.h
+++ b/arch/arm64/include/asm/kvm_types.h
@@ -4,5 +4,9 @@
 
 #define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE 40
 
-#endif /* _ASM_ARM64_KVM_TYPES_H */
+enum vcpu_pmu_register_access {
+	VCPU_PMU_ACCESS_FREE,
+	VCPU_PMU_ACCESS_GUEST_OWNED,
+};
 
+#endif /* _ASM_ARM64_KVM_TYPES_H */
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 0ab89c91e19cb..c2cf6b308ec60 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -34,7 +34,7 @@ static int cpu_has_spe(u64 dfr0)
  *  - Self-hosted Trace Filter controls (MDCR_EL2_TTRF)
  *  - Self-hosted Trace (MDCR_EL2_TTRF/MDCR_EL2_E2TB)
  */
-static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
+void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 {
 	int hpmn = kvm_pmu_hpmn(vcpu);
 
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 154da70146d98..b374308e786d7 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -524,6 +524,8 @@ static bool kvm_hyp_handle_pmu_regs(struct kvm_vcpu *vcpu)
 	val = vcpu_get_reg(vcpu, rt);
 	nr_cnt = vcpu->kvm->arch.nr_pmu_counters;
 
+	kvm_pmu_set_physical_access(vcpu);
+
 	switch (sysreg) {
 	case SYS_PMCR_EL0:
 		mask = ARMV8_PMU_PMCR_MASK;
diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index 4bcacc55c507f..11fae54cd6534 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -72,10 +72,30 @@ bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu)
 	u8 hpmn = vcpu->kvm->arch.nr_pmu_counters;
 
 	return kvm_vcpu_pmu_is_partitioned(vcpu) &&
+		vcpu->arch.pmu.access == VCPU_PMU_ACCESS_GUEST_OWNED &&
 		cpus_have_final_cap(ARM64_HAS_FGT) &&
 		(hpmn != 0 || cpus_have_final_cap(ARM64_HAS_HPMN0));
 }
 
+/**
+ * kvm_pmu_set_physical_access()
+ * @vcpu: Pointer to vcpu struct
+ *
+ * Reconfigure the guest for physical access of PMU hardware if
+ * allowed. This means reconfiguring mdcr_el2 and loading the vCPU
+ * state onto hardware.
+ *
+ */
+
+void kvm_pmu_set_physical_access(struct kvm_vcpu *vcpu)
+{
+	if (kvm_vcpu_pmu_is_partitioned(vcpu)
+	    && vcpu->arch.pmu.access == VCPU_PMU_ACCESS_FREE) {
+		vcpu->arch.pmu.access = VCPU_PMU_ACCESS_GUEST_OWNED;
+		kvm_arm_setup_mdcr_el2(vcpu);
+	}
+}
+
 /**
  * kvm_pmu_host_counter_mask() - Compute bitmask of host-reserved counters
  * @pmu: Pointer to arm_pmu struct
@@ -232,7 +252,8 @@ void kvm_pmu_load(struct kvm_vcpu *vcpu)
 	 * If we aren't guest-owned then we know the guest isn't using
 	 * the PMU anyway, so no need to bother with the swap.
 	 */
-	if (!kvm_vcpu_pmu_is_partitioned(vcpu))
+	if (!kvm_vcpu_pmu_is_partitioned(vcpu) ||
+	    vcpu->arch.pmu.access != VCPU_PMU_ACCESS_GUEST_OWNED)
 		return;
 
 	preempt_disable();
@@ -302,7 +323,8 @@ void kvm_pmu_put(struct kvm_vcpu *vcpu)
 	 * accessing the PMU anyway, so no need to bother with the
 	 * swap.
 	 */
-	if (!kvm_vcpu_pmu_is_partitioned(vcpu))
+	if (!kvm_vcpu_pmu_is_partitioned(vcpu) ||
+	    vcpu->arch.pmu.access != VCPU_PMU_ACCESS_GUEST_OWNED)
 		return;
 
 	preempt_disable();
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 93ccda941aa46..82665d54258df 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -7,6 +7,7 @@
 #ifndef __ASM_ARM_KVM_PMU_H
 #define __ASM_ARM_KVM_PMU_H
 
+#include <linux/kvm_types.h>
 #include <linux/perf_event.h>
 #include <linux/perf/arm_pmuv3.h>
 #include <linux/perf/arm_pmu.h>
@@ -40,6 +41,7 @@ struct kvm_pmu {
 	int irq_num;
 	bool created;
 	bool irq_level;
+	enum vcpu_pmu_register_access access;
 };
 
 struct arm_pmu_entry {
@@ -103,6 +105,8 @@ u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu);
 void kvm_pmu_load(struct kvm_vcpu *vcpu);
 void kvm_pmu_put(struct kvm_vcpu *vcpu);
 
+void kvm_pmu_set_physical_access(struct kvm_vcpu *vcpu);
+
 #if !defined(__KVM_NVHE_HYPERVISOR__)
 bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu);
@@ -177,6 +181,7 @@ static inline u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
 }
 static inline void kvm_pmu_load(struct kvm_vcpu *vcpu) {}
 static inline void kvm_pmu_put(struct kvm_vcpu *vcpu) {}
+static inline void kvm_pmu_set_physical_access(struct kvm_vcpu *vcpu) {}
 static inline void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu,
 					     u64 select_idx, u64 val) {}
 static inline void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu,
-- 
2.53.0.rc2.204.g2597b5adb4-goog

