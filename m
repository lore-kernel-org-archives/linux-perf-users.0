Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0F7155A52
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Feb 2025 02:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738980090; cv=none; b=LEzp8UgjLe9n5kmujugF3n0zHqu5kEhjOYf+EOHbtbSJs+axqsz+wy73Ql1lhEn+xUB88CaJCL29ySKOxsiOQSUeRuxqP5ORdEadzkOao5ge7aYpLGstLlELLmRkJWfs8Obx89YNWNg6MVwe/dtk9gGdN/fOYnmKQqEQjFhp3go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738980090; c=relaxed/simple;
	bh=LQBYMp4KmUXKjINd8GkhcF2qurugv4q68hUcGJQNnjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eMxIWcCQOPAxhRbN1Fw3j0cCECBvJIPsqzDn3e+rkjovdagJTQTm1IVoZePdSIruqfnua873QDc6ZdZ3qAySKnpVSGyZuKpdtfuQhlDeD5KNQy94Me9c6FxMnm9q1CWND9WNiFi9766SmYxWfIDG8K2C3V40xZnESIpt7EPayo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WsHtKx+W; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WsHtKx+W"
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-847500c9b9aso503697739f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 18:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738980087; x=1739584887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ0ITpSot12bWRIgUxfFL1nJMNuEe3fyU4TCb+rHvco=;
        b=WsHtKx+WDJOKNaUauQa96j4suPxy5k0mhq7/IFflync0k7Bb7Eo13HzPLlkYXNM5rO
         UQC34q6hmhU/y0RifQK8a7n3dh/AFUvjG6SCFTusyZx39xjEKEs9RT6RzcsvxmzI8avy
         ONDg64/PsLTe7Kd5eDeAoXtJWkUE2DM7wQI7Tg7n7AuJ/wc2xWOW5Fppy+optDM+Pnhg
         7YpFTuoE2co5Uge254VNBhJwL6TVDgkrpbOOe2GYp8Ycz9OKuFHDLzDCoTQPouF1REvd
         SD4PvCSRCMJ81sEPCLsMUFni8rZfLTtgmj6OL09w7MGb+w1SSEVT5j+28iEtZMxQzSmG
         h0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738980087; x=1739584887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ0ITpSot12bWRIgUxfFL1nJMNuEe3fyU4TCb+rHvco=;
        b=Zpm/7+56QGuwu+2+4c3DmL50PgI4G6/GJ0HY1qd/tJflClf2Ux4fkzEFXklXu7/g8u
         Cdw0ONKI4Xrumq1mmzSWLHiFxFuXRUBZY+vyekxI5XLTUIuZLhFgVPanDURnHO9awuri
         VCXFfa5ubMN2xOA8fP4di7mL5axQh5mD6D0YbPTAlHXEO74me135k9mS53FxIy1TbBnB
         PB5CnbVit5VDtzezKu98DLlVR/1jud02M25qeGCUfP4igd3xn8JpmHCmQv+g9Aet1aIi
         SzW2NA9u1wDzV6gK+mXmzP0FD/MmlqjABbT5FtFSYMfZnp1zdWphZTq+dmu1SK4vePLO
         NxSw==
X-Forwarded-Encrypted: i=1; AJvYcCUld8oCU1BhRcXPuiYLiROZkp1WeyTdRAQ+zAZDH8ANuCY2P1pxUzAZOmC3cTMUi75N3okJfoALdgDUtcQtIXHq@vger.kernel.org
X-Gm-Message-State: AOJu0YxHL5FWJ35A0HIOKJjZJpnbhl5YPGm/I3ZlJMBDiiK/upEbmqUx
	cwOebVpYnEtZxBYiuYGsvuXmFEsauzZxkGPMPe2ZeqH0QanvoFDyfgUpGMqPAt8syzYOVdh5YgZ
	H0A6IQuFnIAQ1u6aH6Xp45A==
X-Google-Smtp-Source: AGHT+IHGzAbpz5Gck/2Rf7WgkWKxzSWHxb28Hylkb71d1eO6uNKmPJkkI+3L+zJwZvOSJQqcK2g9jZxrFbjtaCAz6g==
X-Received: from ilbeh24.prod.google.com ([2002:a05:6e02:4c18:b0:3d0:499b:8e3d])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:20c9:b0:3cf:cdb8:78fb with SMTP id e9e14a558f8ab-3d13df0fb5fmr49647775ab.16.1738980086868;
 Fri, 07 Feb 2025 18:01:26 -0800 (PST)
Date: Sat,  8 Feb 2025 02:01:11 +0000
In-Reply-To: <20250208020111.2068239-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250208020111.2068239-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250208020111.2068239-5-coltonlewis@google.com>
Subject: [RFC PATCH v2 4/4] KVM: arm64: Make guests see only counters they can access
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

The ARM architecture specifies that when MDCR_EL2.HPMN is set, EL1 and
EL0, which includes KVM guests, should read that value for PMCR.N.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/debug.c                                  | 3 +--
 arch/arm64/kvm/pmu-emul.c                               | 8 +++++++-
 tools/testing/selftests/kvm/arm64/vpmu_counter_access.c | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 0e4c805e7e89..7c04db00bf6c 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -36,8 +36,7 @@ static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
 	 * to disable guest access to the profiling and trace buffers
 	 */
-	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN,
-					 *host_data_ptr(nr_event_counters));
+	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN, read_mdcr());
 	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
 				MDCR_EL2_TPMS |
 				MDCR_EL2_TTRF |
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 6c5950b9ceac..052ce8c721fe 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -993,12 +993,18 @@ static bool pmu_irq_is_valid(struct kvm *kvm, int irq)
 u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
 {
 	struct arm_pmu *arm_pmu = kvm->arch.arm_pmu;
+	u8 limit;
+
+	if (arm_pmu->partitioned)
+		limit = arm_pmu->hpmn - 1;
+	else
+		limit = ARMV8_PMU_MAX_GENERAL_COUNTERS;
 
 	/*
 	 * The arm_pmu->cntr_mask considers the fixed counter(s) as well.
 	 * Ignore those and return only the general-purpose counters.
 	 */
-	return bitmap_weight(arm_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS);
+	return bitmap_weight(arm_pmu->cntr_mask, limit);
 }
 
 static void kvm_arm_set_pmu(struct kvm *kvm, struct arm_pmu *arm_pmu)
diff --git a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
index f16b3b27e32e..b5bc18b7528d 100644
--- a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
+++ b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
@@ -609,7 +609,7 @@ static void run_pmregs_validity_test(uint64_t pmcr_n)
  */
 static void run_error_test(uint64_t pmcr_n)
 {
-	pr_debug("Error test with pmcr_n %lu (larger than the host)\n", pmcr_n);
+	pr_debug("Error test with pmcr_n %lu (larger than the host allows)\n", pmcr_n);
 
 	test_create_vpmu_vm_with_pmcr_n(pmcr_n, true);
 	destroy_vpmu_vm();
-- 
2.48.1.502.g6dc24dfdaf-goog

