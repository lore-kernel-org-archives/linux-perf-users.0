Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF2C3FFAD6
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 21:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929522; cv=none; b=reAZEaHuRr1OqsPU77cOi+pAKJ9vAh4hQcQCUROIMgFrKv848cT9pOH6rzyXYiIFz67vnMZR4K/VcVx935wdrZNsBu9SVAYdxTzziunn+ohyFJHhwU3HUKK9rqLTu0uv2b93+kq5mg6qMZgajPVlcdVbxNvjiZ4xTG6rhdAiNs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929522; c=relaxed/simple;
	bh=hs64zUVCH3HRa7wBllJ5k0yO+WABy4vlJLCxV5B6Fvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ah7XwDMK6hWEaXTv6BKAPtmHtF9LfxlExhnzKfrmM6BEzXt/m6wyVptyC9fwdSX2JuAgbjyR3WtNyf/s/34b63106NQuRA4mwhj09f3nmBNOd3uho21GKsDxREyaC5HCCedOr7I465UDwNwr/vdABpD9JGF43NhLz3AJxtcv0DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JFdsxgIS; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JFdsxgIS"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-46ef241b62aso3497812b6e.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 14:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777929517; x=1778534317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=De6V46xDNQ/iwK8PV/vjnlYK6ThYLeVSMRlk50aLYFQ=;
        b=JFdsxgISSqbpHeGlQgB05LS+0pByCUmr1I/Dk6EqNvILGvrFxdfdCGRR8rRaeomdb/
         TClsA80xtkdKFWJoFqfKZ93FjQAmbBZESSF+RxbbkWX9amfqryaTnAkbQzXmlygsiZB+
         /lgrsabO8qdmCX8M7E/qU21H144YRvi01bAe8656i3f1SwfXf0tq9gogkUB2Wz3fwGTD
         MRD3RN2iEkA5Gu0ODg2ei+QMDSR/IA6+b+pOLOn97AAqp5xBXCXunL1kL8DdvrSL5TWk
         9A91W4eRfSPDclnA+9EX/0WdR3LcvR6oZbtMaXjW2/E6kdW+HbLxOLuh5b2aJAxMwG/q
         TpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929517; x=1778534317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=De6V46xDNQ/iwK8PV/vjnlYK6ThYLeVSMRlk50aLYFQ=;
        b=VijtikVww1cizIeEX949qU96rdy6mjC9OFU2Y367UHrmyAbuMQ7YN6LIdg3OEh9Ql+
         iWArU6VQaL6M94iamVrmGp7aqLhDSbUeHxgnqD9pFFReZ3rij/OWypMgq7RAeqETvUZO
         dOe7euuchoVil48WtsJ4z8EVNSKDprOn1T3cH+t7S0FyKfU1vRkgKjQ6uiJvu+UIWH8Y
         mx9h0s3ciPHJAz6zriJ5UMeAXuxdmDmTqo+TbRIXCIY0M0or2y7k+t5jzpxkrirJ1Vz2
         JUKDbBCiGeEqzRSn2r6iktZiPPcYLDG/LVmVSzChau7TrOcsdZtCSk7VZkaWXLffWVyF
         uZsQ==
X-Forwarded-Encrypted: i=1; AFNElJ/YBg4rxQHHXtQSH2e4DBm88zKq/c5NfY9IzmVWZ4r+0jHmgeewalrg6T6dWRLu3nA4aDtE2BigvlGaYFei7+oL@vger.kernel.org
X-Gm-Message-State: AOJu0YwYXTiRvrarEFfeb2Tdk22vycas29loSSH9KUCDeQ5e4ohmuGP5
	jFhHXvJxtON/aNYF94WSKMrTB/du/JFluXEcpXmn/qFiG8cEWhQk7WQ0m/S9fArkOrAuLwTPm9h
	BVpqw3maJH68oLEBzYMDqTRUm+g==
X-Received: from japu20.prod.google.com ([2002:a02:cb94:0:b0:5d6:6508:34a5])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:f013:b0:67d:e85d:b5dc with SMTP id 006d021491bc7-6998dc3602cmr165172eaf.56.1777929516927;
 Mon, 04 May 2026 14:18:36 -0700 (PDT)
Date: Mon,  4 May 2026 21:18:00 +0000
In-Reply-To: <20260504211813.1804997-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504211813.1804997-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504211813.1804997-8-coltonlewis@google.com>
Subject: [PATCH v7 07/20] KVM: arm64: Set up FGT for Partitioned PMU
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

In order to gain the best performance benefit from partitioning the
PMU, utilize fine grain traps (FEAT_FGT and FEAT_FGT2) to avoid
trapping common PMU register accesses by the guest to remove that
overhead.

Untrapped:
* PMCR_EL0
* PMUSERENR_EL0
* PMSELR_EL0
* PMCCNTR_EL0
* PMCNTEN_EL0
* PMINTEN_EL1
* PMEVCNTRn_EL0

These are safe to untrap because writing MDCR_EL2.HPMN as this series
will do limits the effect of writes to any of these registers to the
partition of counters 0..HPMN-1. Reads from these registers will not
leak information from between guests as all these registers are
context swapped by a later patch in this series. Reads from these
registers also do not leak any information about the host's hardware
beyond what is promised by PMUv3.

Trapped:
* PMOVS_EL0
* PMEVTYPERn_EL0
* PMCCFILTR_EL0
* PMICNTR_EL0
* PMICFILTR_EL0
* PMCEIDn_EL0
* PMMIR_EL1

PMOVS remains trapped so KVM can track overflow IRQs that will need to
be injected into the guest.

PMICNTR and PMIFILTR remain trapped because KVM is not handling them
yet.

PMEVTYPERn remains trapped so KVM can limit which events guests can
count, such as disallowing counting at EL2. PMCCFILTR and PMCIFILTR
are special cases of the same.

PMCEIDn and PMMIR remain trapped because they can leak information
specific to the host hardware implementation.

NOTE: This patch temporarily forces kvm_vcpu_pmu_is_partitioned() to
be false to prevent partial feature activation for easier debugging.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm/include/asm/arm_pmuv3.h |  4 +++
 arch/arm64/kvm/config.c          | 41 ++++++++++++++++++++++--
 arch/arm64/kvm/pmu-direct.c      | 54 ++++++++++++++++++++++++++++++++
 include/kvm/arm_pmu.h            | 30 ++++++++++++++++++
 4 files changed, 126 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index 154503f054886..42d62aa48d0a6 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -231,6 +231,10 @@ static inline bool kvm_set_pmuserenr(u64 val)
 }
 
 static inline void kvm_vcpu_pmu_resync_el0(void) {}
+static inline bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
+{
+	return false;
+}
 
 /* PMU Version in DFR Register */
 #define ARMV8_PMU_DFR_VER_NI        0
diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
index d9f553cbf9dfd..3b5f028f5bf11 100644
--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -1598,12 +1598,47 @@ static void __compute_hfgwtr(struct kvm_vcpu *vcpu)
 		*vcpu_fgt(vcpu, HFGWTR_EL2) |= HFGWTR_EL2_TCR_EL1;
 }
 
+static void __compute_hdfgrtr(struct kvm_vcpu *vcpu)
+{
+	__compute_fgt(vcpu, HDFGRTR_EL2);
+
+	*vcpu_fgt(vcpu, HDFGRTR_EL2) |=
+		HDFGRTR_EL2_PMOVS
+		| HDFGRTR_EL2_PMCCFILTR_EL0
+		| HDFGRTR_EL2_PMEVTYPERn_EL0
+		| HDFGRTR_EL2_PMCEIDn_EL0
+		| HDFGRTR_EL2_PMMIR_EL1;
+}
+
 static void __compute_hdfgwtr(struct kvm_vcpu *vcpu)
 {
 	__compute_fgt(vcpu, HDFGWTR_EL2);
 
 	if (is_hyp_ctxt(vcpu))
 		*vcpu_fgt(vcpu, HDFGWTR_EL2) |= HDFGWTR_EL2_MDSCR_EL1;
+
+	*vcpu_fgt(vcpu, HDFGWTR_EL2) |=
+		HDFGWTR_EL2_PMOVS
+		| HDFGWTR_EL2_PMCCFILTR_EL0
+		| HDFGWTR_EL2_PMEVTYPERn_EL0;
+}
+
+static void __compute_hdfgrtr2(struct kvm_vcpu *vcpu)
+{
+	__compute_fgt(vcpu, HDFGRTR2_EL2);
+
+	*vcpu_fgt(vcpu, HDFGRTR2_EL2) &=
+		~(HDFGRTR2_EL2_nPMICFILTR_EL0
+		  | HDFGRTR2_EL2_nPMICNTR_EL0);
+}
+
+static void __compute_hdfgwtr2(struct kvm_vcpu *vcpu)
+{
+	__compute_fgt(vcpu, HDFGWTR2_EL2);
+
+	*vcpu_fgt(vcpu, HDFGWTR2_EL2) &=
+		~(HDFGWTR2_EL2_nPMICFILTR_EL0
+		  | HDFGWTR2_EL2_nPMICNTR_EL0);
 }
 
 void kvm_vcpu_load_fgt(struct kvm_vcpu *vcpu)
@@ -1614,7 +1649,7 @@ void kvm_vcpu_load_fgt(struct kvm_vcpu *vcpu)
 	__compute_fgt(vcpu, HFGRTR_EL2);
 	__compute_hfgwtr(vcpu);
 	__compute_fgt(vcpu, HFGITR_EL2);
-	__compute_fgt(vcpu, HDFGRTR_EL2);
+	__compute_hdfgrtr(vcpu);
 	__compute_hdfgwtr(vcpu);
 	__compute_fgt(vcpu, HAFGRTR_EL2);
 
@@ -1624,6 +1659,6 @@ void kvm_vcpu_load_fgt(struct kvm_vcpu *vcpu)
 	__compute_fgt(vcpu, HFGRTR2_EL2);
 	__compute_fgt(vcpu, HFGWTR2_EL2);
 	__compute_fgt(vcpu, HFGITR2_EL2);
-	__compute_fgt(vcpu, HDFGRTR2_EL2);
-	__compute_fgt(vcpu, HDFGWTR2_EL2);
+	__compute_hdfgrtr2(vcpu);
+	__compute_hdfgwtr2(vcpu);
 }
diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index 74e40e4915416..2148bc46079c4 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -5,6 +5,8 @@
  */
 
 #include <linux/kvm_host.h>
+#include <linux/perf/arm_pmu.h>
+#include <linux/perf/arm_pmuv3.h>
 
 #include <asm/arm_pmuv3.h>
 
@@ -20,3 +22,55 @@ bool has_host_pmu_partition_support(void)
 	return has_vhe() &&
 		system_supports_pmuv3();
 }
+
+/**
+ * kvm_pmu_is_partitioned() - Determine if given PMU is partitioned
+ * @pmu: Pointer to arm_pmu struct
+ *
+ * Determine if given PMU is partitioned by looking at hpmn field. The
+ * PMU is partitioned if this field is less than the number of
+ * counters in the system.
+ *
+ * Return: True if the PMU is partitioned, false otherwise
+ */
+bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
+{
+	if (!pmu)
+		return false;
+
+	return pmu->max_guest_counters >= 0 &&
+		pmu->max_guest_counters <= *host_data_ptr(nr_event_counters);
+}
+
+/**
+ * kvm_vcpu_pmu_is_partitioned() - Determine if given VCPU has a partitioned PMU
+ * @vcpu: Pointer to kvm_vcpu struct
+ *
+ * Determine if given VCPU has a partitioned PMU by extracting that
+ * field and passing it to :c:func:`kvm_pmu_is_partitioned`
+ *
+ * Return: True if the VCPU PMU is partitioned, false otherwise
+ */
+bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu)
+{
+	return kvm_pmu_is_partitioned(vcpu->kvm->arch.arm_pmu) &&
+		false;
+}
+
+/**
+ * kvm_vcpu_pmu_use_fgt() - Determine if we can use FGT
+ * @vcpu: Pointer to struct kvm_vcpu
+ *
+ * Determine if we can use FGT for direct access to registers. We can
+ * if capabilities permit the number of guest counters requested.
+ *
+ * Return: True if we can use FGT, false otherwise
+ */
+bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu)
+{
+	u8 hpmn = vcpu->kvm->arch.nr_pmu_counters;
+
+	return kvm_vcpu_pmu_is_partitioned(vcpu) &&
+		cpus_have_final_cap(ARM64_HAS_FGT) &&
+		(hpmn != 0 || cpus_have_final_cap(ARM64_HAS_HPMN0));
+}
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 95f404cdcb2df..c3987e0c01775 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -92,6 +92,23 @@ void kvm_vcpu_pmu_resync_el0(void);
 #define kvm_vcpu_has_pmu(vcpu)					\
 	(vcpu_has_feature(vcpu, KVM_ARM_VCPU_PMU_V3))
 
+bool kvm_pmu_is_partitioned(struct arm_pmu *pmu);
+
+#if !defined(__KVM_NVHE_HYPERVISOR__)
+bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu);
+bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu);
+#else
+static inline bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+static inline bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+#endif
+
 /*
  * Updates the vcpu's view of the pmu events for this cpu.
  * Must be called before every vcpu run after disabling interrupts, to ensure
@@ -131,6 +148,14 @@ static inline u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu,
 {
 	return 0;
 }
+static inline bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+static inline bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
 static inline void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu,
 					     u64 select_idx, u64 val) {}
 static inline void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu,
@@ -228,6 +253,11 @@ static inline bool kvm_pmu_counter_is_hyp(struct kvm_vcpu *vcpu, unsigned int id
 
 static inline void kvm_pmu_nested_transition(struct kvm_vcpu *vcpu) {}
 
+static inline bool kvm_pmu_is_partitioned(void *pmu)
+{
+	return false;
+}
+
 #endif
 
 #endif
-- 
2.54.0.545.g6539524ca2-goog

