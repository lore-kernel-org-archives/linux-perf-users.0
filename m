Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477842D9EFC
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510308; cv=none; b=XhE6UQaI4CQPk1hJirAu7ruT/3NKuE4Np6gMU/Zq/L5vkHc0SGS6NJdXIx+O8ZeHaGkQPa4Y5HL7+umQjQXPgGHeQzMuPK4zhL1JhvGVhMTQHVM4G2GFw5S3jRJbc4pCEhauAkKNur6PXW4vkgjPhaSzo/KH1M/Ghy/SNT9GgJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510308; c=relaxed/simple;
	bh=BfJD/1Qs0KzM5Cij/W0LAx626YykgL14nn6y0sZD13E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kAy+8dPHowNQUuVoCAB/rrmAbCFHlvKrzwz303GvZ2HYKYtxk8tCEhyCPvYzJMog0EQ3tHbbPpKbaeQjS7g67igOxFNMBM9jXdqRI9AObC4S7+TlNpkPr5VFLRA+AbiYyXRhVuJ6lAA4i2p3QHfVAuebsjqXsikC/ZR2e7hglhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xDr6yWK4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xDr6yWK4"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31eec17b5acso271836a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510305; x=1755115105; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=I4KPqQMNJiob4xQ680shjgCKcMsOL7wxmLpd2hZ8prQ=;
        b=xDr6yWK4hAQu4g4sPBMSO0M2FfzjXx4tlWOiucsbhbm/sp1O0ME48hxePLbpIXF7Bm
         KmSdbfWu8257/uk5IhDt6F/bPvOpu8NviDrq2ME2hW76muOxW7uAibmltX5DV9B4LJFn
         6P0vhRi4aOE/IgSUvZUgN5+FWTj+RjGbhCsftatPs/EnNF7AFwc3P3dJM95CCBdy7J+T
         RZlulwYaFKV++iWR5wAyxIOSph6DfogtNz+gjnqc9UQrKtmJAC5qNFCuMmoIMu9o4hSV
         KYl+0sUpO1pL9h6LfS2Zi77fQikDI7OTGs20izF4nQMu50MDCDssBANMsuCyTd9rdvdM
         C9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510305; x=1755115105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4KPqQMNJiob4xQ680shjgCKcMsOL7wxmLpd2hZ8prQ=;
        b=DUdajeC3x21xWeE5eG+ZLv04gensLG8Lb7BR0tcktNHVnc9PGLs1KXkaVL4ak7HtsT
         9F4A/t5U1oGdG7anIcJXxYUtH0vamPoZ21XXuGAzOe5vTB+HiI0eMx7R/EEsHbUAAgOV
         Z2/X1uX7mjeVn3MrFPSzCm5FCZgUBFzCo7d40Zv1Bz6HVIwLFOo4sxANHmKtLMJ0/NNn
         zX/C/mYJfaaNaX3TTT6YkZ3vtoxgT1OLxPCIElWrAfX509E8yiugOozjd1dogx9V1GnE
         wXlBsEXDRDDejK4gLSO1vQudKGk9LIazuRzIfCsIdOwvRmQViDTSbLSYnMd2886eidqU
         nHBg==
X-Forwarded-Encrypted: i=1; AJvYcCVA6Aen4g75m33miklhGcDmcCym9cmwFTxJrgqCI03nmgk6GknEkczOmQ/cK2plIdYQlHCSw8EbltdoLsytR0Kg@vger.kernel.org
X-Gm-Message-State: AOJu0YwxLZOEtAS9MOULrAARxkyKPZV0AvS2luJxaq+bhdqJEwGwvHPJ
	HEp0UbBxKl1ZYyPJxbrakNgUKz79xABOEmfT0+WwfYyseBDEV9d9IQ13kT9g5NLLGJOL8XXh3q4
	gGhWcrQ==
X-Google-Smtp-Source: AGHT+IEv/lsCJTvAMTt82qYQ74YEmuDhqDy/AIKEkMbUihLXDbLqrOMm3UgmKM47ElROS0wMJkdtmjAP5S0=
X-Received: from pjbsn13.prod.google.com ([2002:a17:90b:2e8d:b0:30a:31eb:ec8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:554e:b0:31e:ff97:75a1
 with SMTP id 98e67ed59e1d1-32166c19241mr5583048a91.3.1754510305634; Wed, 06
 Aug 2025 12:58:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:53 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-32-seanjc@google.com>
Subject: [PATCH v5 31/44] KVM: x86/pmu: Restrict GLOBAL_{CTRL,STATUS}, fixed
 PMCs, and PEBS to PMU v2+
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Restrict support for GLOBAL_CTRL, GLOBAL_STATUS, fixed PMCs, and PEBS to
v2 or later vPMUs.  The SDM explicitly states that GLOBAL_{CTRL,STATUS} and
fixed counters were introduced with PMU v2, and PEBS has hard dependencies
on fixed counters and the bitmap MSR layouts established by PMU v2.

Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 51 ++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 1de94a39ca18..779b4e64acac 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -541,16 +541,33 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 				      kvm_pmu_cap.events_mask_len);
 	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
 
-	if (pmu->version == 1) {
-		pmu->nr_arch_fixed_counters = 0;
-	} else {
-		pmu->nr_arch_fixed_counters = min_t(int, edx.split.num_counters_fixed,
-						    kvm_pmu_cap.num_counters_fixed);
-		edx.split.bit_width_fixed = min_t(int, edx.split.bit_width_fixed,
-						  kvm_pmu_cap.bit_width_fixed);
-		pmu->counter_bitmask[KVM_PMC_FIXED] = BIT_ULL(edx.split.bit_width_fixed) - 1;
+	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
+	if (entry &&
+	    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) &&
+	    (entry->ebx & (X86_FEATURE_HLE|X86_FEATURE_RTM))) {
+		pmu->reserved_bits ^= HSW_IN_TX;
+		pmu->raw_event_mask |= (HSW_IN_TX|HSW_IN_TX_CHECKPOINTED);
 	}
 
+	perf_capabilities = vcpu_get_perf_capabilities(vcpu);
+	if (intel_pmu_lbr_is_compatible(vcpu) &&
+	    (perf_capabilities & PERF_CAP_LBR_FMT))
+		memcpy(&lbr_desc->records, &vmx_lbr_caps, sizeof(vmx_lbr_caps));
+	else
+		lbr_desc->records.nr = 0;
+
+	if (lbr_desc->records.nr)
+		bitmap_set(pmu->all_valid_pmc_idx, INTEL_PMC_IDX_FIXED_VLBR, 1);
+
+	if (pmu->version == 1)
+		return;
+
+	pmu->nr_arch_fixed_counters = min_t(int, edx.split.num_counters_fixed,
+					    kvm_pmu_cap.num_counters_fixed);
+	edx.split.bit_width_fixed = min_t(int, edx.split.bit_width_fixed,
+					  kvm_pmu_cap.bit_width_fixed);
+	pmu->counter_bitmask[KVM_PMC_FIXED] = BIT_ULL(edx.split.bit_width_fixed) - 1;
+
 	intel_pmu_enable_fixed_counter_bits(pmu, INTEL_FIXED_0_KERNEL |
 						 INTEL_FIXED_0_USER |
 						 INTEL_FIXED_0_ENABLE_PMI);
@@ -571,24 +588,6 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 		pmu->global_status_rsvd &=
 				~MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI;
 
-	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
-	if (entry &&
-	    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) &&
-	    (entry->ebx & (X86_FEATURE_HLE|X86_FEATURE_RTM))) {
-		pmu->reserved_bits ^= HSW_IN_TX;
-		pmu->raw_event_mask |= (HSW_IN_TX|HSW_IN_TX_CHECKPOINTED);
-	}
-
-	perf_capabilities = vcpu_get_perf_capabilities(vcpu);
-	if (intel_pmu_lbr_is_compatible(vcpu) &&
-	    (perf_capabilities & PERF_CAP_LBR_FMT))
-		memcpy(&lbr_desc->records, &vmx_lbr_caps, sizeof(vmx_lbr_caps));
-	else
-		lbr_desc->records.nr = 0;
-
-	if (lbr_desc->records.nr)
-		bitmap_set(pmu->all_valid_pmc_idx, INTEL_PMC_IDX_FIXED_VLBR, 1);
-
 	if (perf_capabilities & PERF_CAP_PEBS_FORMAT) {
 		if (perf_capabilities & PERF_CAP_PEBS_BASELINE) {
 			pmu->pebs_enable_rsvd = counter_rsvd;
-- 
2.50.1.565.gc32cd1483b-goog

