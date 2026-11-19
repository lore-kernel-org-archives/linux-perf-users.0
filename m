Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114348;
	b=fjkizLZCMJvIx3zRbR+Bex36olvWYXe8zLdmDfaQKh/qfshe1M7S7Itl0dazq4/TfIOT
	 UxahQNrQWoHwzcP0vbBP1dPWOH2IuqG/NBJhxvHg0ZOpwwu9iN5n5OG2T5KjBwbs11tVJ
	 Gt2TmlHw2uIm3oHbwnf3Yzqpf8rqA5iipJso9/mzF3VvtoiIaXo4Q+mCxNse8jicvEth7
	 LMuxjNGixAiyMa7jRlsuXu/pDnHNY/vtjBWn01ysMjgCrBvRFrXfi6SrjWnkDDw+D/w8l
	 Pr51RX+plpwDgtH2AmIRDEgeVbBKjwhvNC68Fl7TXETFAB2Wo9XT2FnhPGc6XdBjsDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=6347H7gggToJzZ+Ilw3z4KeuVm8ZnAfGsrXn9eqrzm0=;
	b=fKYw9IXnsGJTnKQDhHickmiOIG8K/tr7qR83gnkZJKhPF4QfQ+oTk8FJqweCSlNi0tiw
	 hg5Fvyz4G06BkCwp47t8q7XZZQVfjEHFE6cWAJMMVODgcbdVieJgohPohS/7OxBhPGrpZ
	 T+lxmXwAEvSgg4YI0zz4B9GCj6YULZz/w9F/FvZn6FtQNXkq27uWEs9QtJFwqGdQAKxj/
	 Hpse9zW+dmfcf0Ts8vWyWG5XHcm5jv5Q5vacZSuXbjVq3qWJMjc2Yurds7dShN9bw7hs2
	 wCLZB4Okqvbn1g8Iz3TN5lXf8NISXxce5pAH/9bqygJkRTc+hYklhncaR+IrBxwn2Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eXbRoEop;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB92A60A6F74
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB92A60A6F74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eXbRoEop
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4cbf700ddccso164690b6e.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 10:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114347; x=1795719147; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6347H7gggToJzZ+Ilw3z4KeuVm8ZnAfGsrXn9eqrzm0=;
        b=eXbRoEopcpGI2+2eiRWItYB7cVvvGQaWF9q7H6B4I4ONHdqnpPqbwRC8O/QVsX2bxd
         ruxsiTksLeHrBKmKkqExkDdNlL9iZ6WunjkMZoTraoS99hwXQMUWGLvYIsqDkKkEUbt2
         i5WiLfz74+X1jXyiPrH3hWY+uVy6mn0dOQq0I4qvWy6iXpZ/LHSkyVlQGyzNeb2Dik1F
         +9Ayy17qBpK2x/hOAbcdlbpo21L4hC8Hgjyyxa2bRRw6zWq8097PEm9u9E6EdIyrWLYz
         RwE3K3nl56UiqHr62xVm7WWEd9rWyqDB5am/6rxLaPjt9XVJC9z6Y/Sj5Ns2xCw/66ba
         OQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114347; x=1795719147;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6347H7gggToJzZ+Ilw3z4KeuVm8ZnAfGsrXn9eqrzm0=;
        b=TIxaoBBT07kJNDs2L0vMFmK/wLFNuiKxd7J1jW/rY7j7dW3rLiE7Vmk3fNorLG35Jc
         0mOTR6Zg07CxU6Jjcg/rA6WK/sm7aRDzsEhbtXlqe+j7B62JHbqCuBlTCC+eJxqN3wqj
         jLLileWY6g6XfhqXUZiedSujSDGCVq04VQp5WkQ1QuDxaAa/Hr/6zwyCTVU4PuhvavVp
         0JpYpMpcll6p3bdLDVzYXOJfbHstFgP90ezc1JlucBNhkNcRv0DGFrll14n5zD7pY4S3
         lPJ2ixMHKTvw56IMuhKoLoxNTKAJukvkH7AlgysIY8vFglrSQcebo6U/c4WV+iOGpMGG
         1cQA==
X-Forwarded-Encrypted: i=1; AL+hErH1NlOF8Et0ZquVl3TEtGmaq0CUpYFGc8EKQgT0Whp2+ZIHdizr4kfF9Efp6d6rEGwFaDjYqneTj/6FLwFn1yxt@vger.kernel.org
X-Gm-Message-State: APuU4Z+NSYlsqwf5tmu1fhFcuNe7weR3YHvijCpafiNLFzP1wVN5URzI
	DobM5MBs7TZt6LLkRd222NX9GohYWgVAD+v0PcsFEjHXEVR32ToMaq/5W63/8ZdqgLUHTrE4ITO
	bklHIJ+z4O5Lhu4uu8EABmKGXpg==
X-Received: from ilbeb8.prod.google.com ([2002:a05:6e02:4608:b0:544:45eb:2ab])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:660e:b0:4f4:b5ba:a241 with SMTP id 5614622812f47-57a0b048d65mr920500b6e.39.1795114346425;
 Thu, 19 Nov 2026 10:52:26 -0800 (PST)
Date: Thu, 19 Nov 2026 18:51:53 +0000
In-Reply-To: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119185215.632334-12-coltonlewis@google.com>
Subject: [PATCH v10 11/33] KVM: arm64: Add initial scaffolding for Partitioned PMU
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, James Clark <james.clark@linaro.org>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Mingwei Zhang <mizhang@google.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add the foundational helpers for Partitioned PMU support in
arch/arm64/kvm/pmu-direct.c:
- has_kvm_pmu_partition_support() to check VHE and PMUv3 availability.
- kvm_pmu_partition_enable() and kvm_pmu_is_partitioned() to track per-VM
  partitioning state via KVM_ARCH_FLAG_PARTITION_PMU_ENABLED.
- kvm_pmu_guest_counter_mask() to compute the bitmask of guest-reserved
  (0..HPMN-1 and PMCCNTR_EL0) hardware counters.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm/include/asm/arm_pmuv3.h  |  4 ++
 arch/arm64/include/asm/kvm_host.h |  2 +
 arch/arm64/kvm/Makefile           |  2 +-
 arch/arm64/kvm/pmu-direct.c       | 94 +++++++++++++++++++++++++++++++
 include/kvm/arm_pmu.h             | 20 +++++++
 5 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/pmu-direct.c

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index ecfede0c03486..71cf03ab58cbb 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -227,6 +227,10 @@ static inline bool kvm_set_pmuserenr(u64 val)
 }
 
 static inline void kvm_vcpu_pmu_resync_el0(void) {}
+static inline u64 kvm_pmu_guest_counter_mask(void)
+{
+	return 0;
+}
 
 /* PMU Version in DFR Register */
 #define ARMV8_PMU_DFR_VER_NI        0
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4683281fcc5d4..89683a690828e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -96,6 +96,8 @@ enum {
 	KVM_ARCH_FLAG_EXIT_SEA,
 	/* No further ID register changes possible */
 	KVM_ARCH_FLAG_ID_REGS_FINAL,
+	/* Partitioned PMU Enabled */
+	KVM_ARCH_FLAG_PARTITION_PMU_ENABLED,
 };
 
 struct vcpu_reset_state {
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 7aaeeb84e788e..79f1602299767 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -27,7 +27,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 vgic/vgic-v5.o vgic/vgic-v5-tables.o vgic/vgic-irs-v5.o \
 	 vgic-sys-reg-v5.o
 
-kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
+kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu-direct.o pmu.o
 kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
 kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
 
diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
new file mode 100644
index 0000000000000..b1c180ae79d9d
--- /dev/null
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Google LLC
+ * Author: Colton Lewis <coltonlewis@google.com>
+ */
+
+#include <linux/kvm_host.h>
+#include <linux/perf/arm_pmu.h>
+#include <linux/perf/arm_pmuv3.h>
+
+#include <asm/arm_pmuv3.h>
+#include <asm/kvm_emulate.h>
+#include <asm/virt.h>
+
+/**
+ * has_host_pmu_partition_support() - Determine if partitioning is possible
+ *
+ * Partitioning is only supported in VHE mode with PMUv3
+ *
+ * Return: True if partitioning is possible, false otherwise
+ */
+static bool has_host_pmu_partition_support(void)
+{
+	return has_vhe() &&
+		system_supports_pmuv3();
+}
+
+/**
+ * has_kvm_pmu_partition_support() - If we can enable/disable partition
+ *
+ * Return: true if allowed, false otherwise.
+ */
+bool has_kvm_pmu_partition_support(void)
+{
+	return has_host_pmu_partition_support() &&
+		kvm_supports_guest_pmuv3();
+}
+
+/**
+ * kvm_pmu_partition_enable() - Enable/disable partition flag
+ * @kvm: Pointer to kvm struct
+ * @enable: Whether to enable or disable
+ *
+ * If we want to enable the partition, the guest is free to grab
+ * hardware by accessing PMU registers. Otherwise, the host maintains
+ * control.
+ */
+void kvm_pmu_partition_enable(struct kvm *kvm, bool enable)
+{
+	if (enable)
+		set_bit(KVM_ARCH_FLAG_PARTITION_PMU_ENABLED, &kvm->arch.flags);
+	else
+		clear_bit(KVM_ARCH_FLAG_PARTITION_PMU_ENABLED, &kvm->arch.flags);
+}
+
+/**
+ * kvm_pmu_is_partitioned() - Determine if KVM has a partitioned PMU
+ * @kvm: Pointer to kvm struct
+ *
+ * Return: True if the KVM PMU is partitioned, false otherwise
+ */
+bool kvm_pmu_is_partitioned(struct kvm *kvm)
+{
+	return kvm && test_bit(KVM_ARCH_FLAG_PARTITION_PMU_ENABLED, &kvm->arch.flags);
+}
+
+static u64 kvm_vcpu_pmu_guest_counter_mask(struct kvm_vcpu *vcpu)
+{
+	if (vcpu && kvm_pmu_is_partitioned(vcpu->kvm)) {
+		u64 mask = ARMV8_PMU_CNT_MASK_C;
+		unsigned int guest_counters = vcpu->kvm->arch.nr_pmu_counters;
+
+		if (guest_counters > 0)
+			mask |= GENMASK_ULL(guest_counters - 1, 0);
+
+		return mask;
+	}
+
+	return 0;
+}
+
+/**
+ * kvm_pmu_guest_counter_mask() - Compute bitmask of guest-reserved counters
+ *
+ * Compute the bitmask that selects the guest-reserved counters in the
+ * {PMCNTEN,PMINTEN,PMOVS}{SET,CLR} registers. These are the event counters
+ * in 0..HPMN-1 and the cycle counter (PMCCNTR_EL0).
+ *
+ * Return: Bitmask
+ */
+u64 kvm_pmu_guest_counter_mask(void)
+{
+	return kvm_vcpu_pmu_guest_counter_mask(kvm_get_running_vcpu());
+}
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 8d51cf40182d6..e06255e46a4d8 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -95,6 +95,10 @@ void kvm_vcpu_pmu_resync_el0(void);
 #define kvm_vcpu_has_pmuv3_strict(vcpu)				\
 	(vcpu_has_feature(vcpu, KVM_ARM_VCPU_PMU_V3_STRICT))
 
+bool has_kvm_pmu_partition_support(void);
+void kvm_pmu_partition_enable(struct kvm *kvm, bool enable);
+bool kvm_pmu_is_partitioned(struct kvm *kvm);
+u64 kvm_pmu_guest_counter_mask(void);
 /*
  * Updates the vcpu's view of the pmu events for this cpu.
  * Must be called before every vcpu run after disabling interrupts, to ensure
@@ -129,6 +133,10 @@ static inline u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu,
 {
 	return 0;
 }
+static inline bool kvm_pmu_is_partitioned(struct kvm *kvm)
+{
+	return false;
+}
 static inline void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu,
 					     u64 select_idx, u64 val) {}
 static inline void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu,
@@ -233,6 +241,18 @@ static inline bool kvm_pmu_counter_is_hyp(struct kvm_vcpu *vcpu, unsigned int id
 
 static inline void kvm_pmu_nested_transition(struct kvm_vcpu *vcpu) {}
 
+static inline u64 kvm_pmu_guest_counter_mask(void)
+{
+	return 0;
+}
+
+static inline bool has_kvm_pmu_partition_support(void)
+{
+	return false;
+}
+
+static inline void kvm_pmu_partition_enable(struct kvm *kvm, bool enable) {}
+
 #endif
 
 #endif
-- 
2.56.1.708.g77570a6a1d-goog

