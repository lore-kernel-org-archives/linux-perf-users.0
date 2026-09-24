Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175154B1274
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270992; cv=none; b=Lnveu5pjCsiYkuL+c33WJAF+aruvMWKj6057Kivu7Ig0j0VRSKzZ9AyW5NilXyb1I84HhWKcrhh8hrQEzFILxg13Iw+VaZa+WcTnhVhQxHwBp/5c/xZEIRnupWELMIgAZypyWnFASHAfOaSuIfSUZCQUi0PyqIR+ON6KzKYLUuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270992; c=relaxed/simple;
	bh=Y6adSMCNNnG6doPX3ymtb78tuo7YkMMcjAEG5UNk6Mk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pp7NwsSoAp/KjIrSM7ATf1pTq68RBuYQ4pizKEhS80jP7M624sxl+MhTKaomVqUne5DlEHtaB/gyxYB7q0MshfTk1yDTVr2GJdBradjQ5ZB72B28I/Tx50Lk4DvNslaMHg+0gglEAvuerrU5bvQlWitrpVCcJLWNXMp/OhMs1dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tduBl/MO; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tduBl/MO"
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b597558c4cso212564b6e.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790270987; x=1790875787; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/Sjq5h51RyI3GHB4u4jBTaGi29xukntF3qhviZ3NXg=;
        b=tduBl/MOfOfagDy2icDkaoFNCLVSHj5lNVPv/kQLdptKdQqBVAxb2caubTYX85ZVXq
         0GNr/Fxr1n9ltJuCfnHkvmmFMZsulU1Whx9jN5ND+UQRTv7LFKn2HHVRqSzALtikB4wz
         S1YMPOs+gX4OsjAWrhlE5k1rsYFH5KBQBEkn00KpU0ErTgB4iCLco00ML8DzYFXCF1+c
         Svo5KJLPBl12uJP3wywS7L+4d3PnF1dCnpfifaSEu46m+MnOREU/Q9o6gR+XeUfrILwA
         Yhaj6OiWDaUrM2LzZfpQ5i61WpoyeMNFI1s6ZUKY3jh9mbMhMpCbNztHRwyDqbbb/Vi2
         Sjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790270987; x=1790875787;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O/Sjq5h51RyI3GHB4u4jBTaGi29xukntF3qhviZ3NXg=;
        b=NDVBUre1zSjHuqrDHXdvDqwlSN/kB1sv2bwJX79nlIbX/kV1uF5Qs8sQMbEtyjsYrd
         DF9OuCr/UOZkqHkHiqJkzix3wMz/H3aA/3FpBjYGP25Nd/8Fj97w8kYmEPx4WDedyv8m
         dREmRhtgXeZPIHgzfJSnw2Sj2xEMkyqJRgrlrJfD4DJCUbkcu4HCml97BPhYNKcUfdf6
         gU4ScycwvN5OXhM+k79/JnuOPPDimX+vBa+H4sLLJcSAqqsdqUf+vYYL4GMI8NwTct8D
         YuDioaqSMWpx+exTC89KCb6FVb81Mo9iJBSj+jPAv8sgcAPwRphFH8DLnDjudlMKMMQS
         y1DQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwMAFPCd4BgtVgh245u/DkHhmiGecgX88n2tdbSVxSeRWoQVrWjy2dVrkKqojrkTfopZSwICdPmseepBVQFx49@vger.kernel.org
X-Gm-Message-State: AFuF++ntwjfEccU+5Ke1LBTLDMZp9/WztNlNAwVDmPbaM9gFnlrlAEwD
	WSTPrnfeG+GEmWEIewZHGO3vqydzHXyZAd99Obt2mEJFC/VtnrQH0YPce3nxS0Uo2VP9uH7VRCO
	BhOEj0YsftlU6sdC1TtkSiqb96g==
X-Received: from ilbda5.prod.google.com ([2002:a05:6e02:3cc5:b0:509:8793:a27a])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2222:b0:4d6:9133:23fa with SMTP id 5614622812f47-4d72b43c64emr3766576b6e.48.1790270986738;
 Thu, 24 Sep 2026 10:29:46 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:29:17 +0000
In-Reply-To: <20260924172928.2110956-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924172928.2110956-12-coltonlewis@google.com>
Subject: [PATCH v9 11/22] KVM: arm64: Set up MDCR_EL2 to handle a Partitioned PMU
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

Set up MDCR_EL2 to handle a Partitioned PMU. If partitioned, set the
HPME, HPMD, and HCCD bits. If we have the ability to use Fine Grain
Traps (FEAT_FGT) also, unset the TPM and TPMCR bits that trap all PMU
accesses and set HPMN to the correct number of guest counters so
hardware enforces the right values.

Protect vcpu->arch.mdcr_el2 updates with local_irq_save() to prevent
races against PMU interrupt handlers modifying MDCR_EL2.HPME.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/debug.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index f4d7b12045e8f..a722fd4594e09 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -37,14 +37,16 @@ static int cpu_has_spe(u64 dfr0)
  */
 static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 {
-	preempt_disable();
+	unsigned long flags;
+
+	local_irq_save(flags);
 
 	/*
 	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
 	 * to disable guest access to the profiling and trace buffers
 	 */
-	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN,
-					 *host_data_ptr(nr_event_counters));
+
+	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN, *host_data_ptr(nr_event_counters));
 	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
 				MDCR_EL2_TPMS |
 				MDCR_EL2_TTRF |
@@ -52,6 +54,35 @@ static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 				MDCR_EL2_TDRA |
 				MDCR_EL2_TDOSA);
 
+	if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+		u8 nr_guest_cntr = vcpu->kvm->arch.nr_pmu_counters;
+		u64 hpmn = FIELD_GET(MDCR_EL2_HPMN, read_sysreg(mdcr_el2));
+		bool hpme;
+
+		if (hpmn < *host_data_ptr(nr_event_counters))
+			hpme = !!(read_sysreg(mdcr_el2) & MDCR_EL2_HPME);
+		else
+			hpme = !!(read_sysreg(pmcr_el0) & ARMV8_PMU_PMCR_E);
+
+		vcpu->arch.mdcr_el2 |= (MDCR_EL2_HPMD | MDCR_EL2_HCCD);
+		if (hpme)
+			vcpu->arch.mdcr_el2 |= MDCR_EL2_HPME;
+
+		/*
+		 * Take out the coarse grain traps if we are using
+		 * fine grain traps and enforce counter access with
+		 * HPMN.
+		 */
+		if (!vcpu_on_unsupported_cpu(vcpu) &&
+		    (cpus_have_final_cap(ARM64_HAS_HPMN0) || nr_guest_cntr > 0)) {
+			vcpu->arch.mdcr_el2 &= ~MDCR_EL2_HPMN;
+			vcpu->arch.mdcr_el2 |= FIELD_PREP(MDCR_EL2_HPMN, nr_guest_cntr);
+
+			if (cpus_have_final_cap(ARM64_HAS_FGT))
+				vcpu->arch.mdcr_el2 &= ~(MDCR_EL2_TPM | MDCR_EL2_TPMCR);
+		}
+	}
+
 	/* Is the VM being debugged by userspace? */
 	if (vcpu->guest_debug)
 		/* Route all software debug exceptions to EL2 */
@@ -70,7 +101,7 @@ static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 	if (has_vhe())
 		write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
 
-	preempt_enable();
+	local_irq_restore(flags);
 }
 
 void kvm_init_host_debug_data(void)
-- 
2.56.0.rc1.310.g51773c2048-goog

