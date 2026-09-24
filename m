Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5FE4ABBA8
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270988; cv=none; b=tmVb0f/znh91/Hd7HQf3pzDg0yDjSlrecGU14aVp1R+SaeGNgoC4/DHwM4H8TpNYwdQwrEd1C4cDGa2QYioERidRS5nFmBLPTM744R/1Y3yzn6xyT9Mb6GY+B0iflbEcDYyxvyVbfpUYqwzi5aZ/UPlsADgX+7cBYsychm6Cwgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270988; c=relaxed/simple;
	bh=KUjTePhajLuc9ozI4yLwz+g5uVp5uJ+h3b9v95Fvy+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p8wRaGX5pQdZJGJDGG5A90dVgkldy2V9NdYmbYnVWZCdf3zvrjokJOsSyo/xJVimmjBNo9lxnI/Vr6NxH9wqmwz2h0klR5epBdwwX7B+oWP3JFxaViicMyIhiv5Q+ZyenwQ3XbGJ6R5N1qH4Rp00TtvYmNC2kS2/Vw6KftspJ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hkphPy7M; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkphPy7M"
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4c307941971so249542b6e.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790270982; x=1790875782; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JOIrjlPHlsQKXA2/9FwwNsLLczH4MkvA/TRaBpEfDYA=;
        b=hkphPy7MznfMQ6+hJ/vTBmI+YDthwyx4To2MuqpYame0sKv1jOqW4/eILdxwcl/FYw
         5PyY4QpzAtcwJ0nK1slfs/o2QcjS2Bc2+ZsXp6oeHjsi4JTDHHjYoQjVf3xAEqFuko7r
         /7XL5QTAJmvq7s01JnhY5J4MGuBUNsi6T4g1rMI/XOhySbyjQ+LzOtKF+myIpmghQvet
         /PpQfaj4NbloRfkAAuoau8RX3gMYY4eMf+6+WVjo3qpIn1DON4li9qy0sQFDwUBFlduT
         C2sGMgwnoJa/vfalMEofftRFUJ23hcEACS8fFX6l1nnuTfPat/wqdzEND+/oaKzs9uIW
         Sj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790270982; x=1790875782;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JOIrjlPHlsQKXA2/9FwwNsLLczH4MkvA/TRaBpEfDYA=;
        b=pcuCwsCDJyZbFz07HpryHEuZMXRml8gPcL38Z3Gm70jREF1luvsr9zzAblJpgfa9+Z
         yI4fzO4Mc1VR5SoDyiDqfAoqnLXrNUPQ9yoReS+k32tq3Auuny3uTUlCfm6OHa/vbg2c
         rd83TZgWtdTdVMqUHoyYNKdTIEuaX89uVlwYccNvPGAxGaaRdRU7/lrK4jX5iGVh4gyK
         BWtdKdY8wsiXd4I8GQ0J0Tb1LDpoyjlBKX7EV6IE40tlMgp03kMb+QuL5AACYRyMGiBz
         CMBtpT0Ril6fJA51v/G2Fxfdsrs2UlBEzDtOE6ArlB2uybQtssJVcMo35b14o4LYaXZW
         E0+A==
X-Forwarded-Encrypted: i=1; AKwUvByn6JsXZU9ANBevhXryPisN+CRe3P7gtjxIn3T7opAZSOm/3OTZLQGaL4td+FjbVUqQ6tNUsUeYlolfHzpGuEn+@vger.kernel.org
X-Gm-Message-State: AFuF++k/eEutBqQAdmADcG0l1BtJmv9Jcng+4DWb4MS5Wi9MyWDC9thd
	LgwDUc0L4QW6+9O4YOfOsk5XqqwLH0908FvxfNV8bNV3cnuQzZLi7LjbKGsyD+kVMkjqW5I4wQd
	q+Kt7xaM9b27j1EUSpFYYM1T+0Q==
X-Received: from jalg14.prod.google.com ([2002:a05:6638:c4e:b0:5f0:cbe4:72e7])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1394:b0:4b5:5bfb:f25e with SMTP id 5614622812f47-4d72c637812mr3680802b6e.21.1790270981701;
 Thu, 24 Sep 2026 10:29:41 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:29:15 +0000
In-Reply-To: <20260924172928.2110956-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924172928.2110956-10-coltonlewis@google.com>
Subject: [PATCH v9 09/22] KVM: arm64: Set up FGT for Partitioned PMU
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

In order to gain the best performance benefit from partitioning the
PMU, utilize fine grain traps (FEAT_FGT and FEAT_FGT2) to avoid
trapping common PMU register accesses by the guest to remove that
overhead.

Untrapped:
- PMCR_EL0
- PMUSERENR_EL0
- PMSELR_EL0
- PMCCNTR_EL0
- PMCNTEN_EL0
- PMINTEN_EL1
- PMEVCNTRn_EL0

These are safe to untrap because writing MDCR_EL2.HPMN as this series
will do limits the effect of writes to any of these registers to the
partition of counters 0..HPMN-1. Reads from these registers will not
leak information from between guests as all these registers are
context swapped by a later patch in this series. Reads from these
registers also do not leak any information about the host's hardware
beyond what is promised by PMUv3.

Trapped:
- PMOVS_EL0
- PMEVTYPERn_EL0
- PMCCFILTR_EL0
- PMICNTR_EL0
- PMICFILTR_EL0
- PMCEIDn_EL0
- PMMIR_EL1

PMOVS remains trapped so KVM can track overflow IRQs that will need to
be injected into the guest.

PMICNTR and PMICFILTR remain trapped because KVM is not handling them
yet.

PMEVTYPERn remains trapped so KVM can limit which events guests can
count, such as disallowing counting at EL2. PMCCFILTR and PMICFILTR
are special cases of the same.

PMCEIDn and PMMIR remain trapped because they can leak information
specific to the host hardware implementation.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/config.c | 49 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
index 1053676551aff..f00ef9d598a95 100644
--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -1708,12 +1708,55 @@ static void __compute_hfgwtr(struct kvm_vcpu *vcpu)
 		*vcpu_fgt(vcpu, HFGWTR_EL2) |= HFGWTR_EL2_TCR_EL1;
 }
 
+static void __compute_hdfgrtr(struct kvm_vcpu *vcpu)
+{
+	__compute_fgt(vcpu, HDFGRTR_EL2);
+
+	if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+		*vcpu_fgt(vcpu, HDFGRTR_EL2) |=
+			(HDFGRTR_EL2_PMOVS |
+			 HDFGRTR_EL2_PMCCFILTR_EL0 |
+			 HDFGRTR_EL2_PMEVTYPERn_EL0 |
+			 HDFGRTR_EL2_PMCEIDn_EL0 |
+			 HDFGRTR_EL2_PMMIR_EL1) & ~hdfgrtr_masks.res0;
+	}
+}
+
 static void __compute_hdfgwtr(struct kvm_vcpu *vcpu)
 {
 	__compute_fgt(vcpu, HDFGWTR_EL2);
 
 	if (is_hyp_ctxt(vcpu))
 		*vcpu_fgt(vcpu, HDFGWTR_EL2) |= HDFGWTR_EL2_MDSCR_EL1;
+
+	if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+		*vcpu_fgt(vcpu, HDFGWTR_EL2) |=
+			(HDFGWTR_EL2_PMOVS |
+			 HDFGWTR_EL2_PMCCFILTR_EL0 |
+			 HDFGWTR_EL2_PMEVTYPERn_EL0) & ~hdfgwtr_masks.res0;
+	}
+}
+
+static void __compute_hdfgrtr2(struct kvm_vcpu *vcpu)
+{
+	__compute_fgt(vcpu, HDFGRTR2_EL2);
+
+	if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+		*vcpu_fgt(vcpu, HDFGRTR2_EL2) &=
+			~(HDFGRTR2_EL2_nPMICFILTR_EL0 |
+			  HDFGRTR2_EL2_nPMICNTR_EL0) | hdfgrtr2_masks.res1;
+	}
+}
+
+static void __compute_hdfgwtr2(struct kvm_vcpu *vcpu)
+{
+	__compute_fgt(vcpu, HDFGWTR2_EL2);
+
+	if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+		*vcpu_fgt(vcpu, HDFGWTR2_EL2) &=
+			~(HDFGWTR2_EL2_nPMICFILTR_EL0 |
+			  HDFGWTR2_EL2_nPMICNTR_EL0) | hdfgwtr2_masks.res1;
+	}
 }
 
 static void __compute_ich_hfgrtr(struct kvm_vcpu *vcpu)
@@ -1750,7 +1793,7 @@ void kvm_vcpu_load_fgt(struct kvm_vcpu *vcpu)
 	__compute_fgt(vcpu, HFGRTR_EL2);
 	__compute_hfgwtr(vcpu);
 	__compute_fgt(vcpu, HFGITR_EL2);
-	__compute_fgt(vcpu, HDFGRTR_EL2);
+	__compute_hdfgrtr(vcpu);
 	__compute_hdfgwtr(vcpu);
 	__compute_fgt(vcpu, HAFGRTR_EL2);
 
@@ -1758,8 +1801,8 @@ void kvm_vcpu_load_fgt(struct kvm_vcpu *vcpu)
 		__compute_fgt(vcpu, HFGRTR2_EL2);
 		__compute_fgt(vcpu, HFGWTR2_EL2);
 		__compute_fgt(vcpu, HFGITR2_EL2);
-		__compute_fgt(vcpu, HDFGRTR2_EL2);
-		__compute_fgt(vcpu, HDFGWTR2_EL2);
+		__compute_hdfgrtr2(vcpu);
+		__compute_hdfgwtr2(vcpu);
 	}
 
 	if (cpus_have_final_cap(ARM64_HAS_GICV5_CPUIF)) {
-- 
2.56.0.rc1.310.g51773c2048-goog

