Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1AA4EB2B
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973470; cv=none; b=ZNqPryJk49suTSqdJeOPV2taWpfUUsaucSAk1v55OIonkUnpv1+cdflao9o2UKrqws4j6v7IWVXALHecO3H77Dj/En3sGwOIMATQSbzAgpQqpAdQATYsc/wkaU1uskZKrWuprXyac5R1ve7n7qTAbbH7yWarpnWRqy5RT3f1o/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973470; c=relaxed/simple;
	bh=TBqBl4pq9zYo3pUbw2b+MLaxe8vx/qYeH9SgTOuMq4s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SdTw7ixGbw2kcoKRjGGdNE/B4zxI39oHB6l8vfO+Fy9rVd+1F4fCHbimnZqGtQHeKtMFJR7yKJnMIsS9zVWpPELSp1QslB1Wik3dCHMOduFjAQZq92K5DuuQwqtSNkcL1SMyD19gnnsfjLEmPuGwNH2hyLff1k2+Fk0ypqpkvLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zpkhenw2; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zpkhenw2"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f446a1ec59so1736112b3a.1
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973468; x=1715578268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5Cm0d3WOH0gamfINjdUviBLGVbtpc+6bD+mA0Jeog2I=;
        b=Zpkhenw2IsLoIMIedxKq0FCar3ozDEJMZgR8lhA2wcZBsefVDZKTaZvCXvjc+ms8FQ
         6RfykCJlnXUUaDkJB9/DpsbpqwHb24dgup9fm+ysh9DogtixoG1f1uzdc7pWg6c4OVZ1
         31nDSqKamL3O0QEucCwP6uM98jAWm+LVgUQyLLIDFBGNZrw8WeiP+vY8edHJDeXBMWfZ
         JebJ+z0Upb4b7z4skVpc2ojG2nOZgIP+xShBKg2tTFYrnwUbDUzGk7ubOA2F6s3jboiz
         Mess5uXqQ5NuiCLKe3F8RZYxUXSYXpyAuPhfldGFiaDJSVY3PQpgqL2/Klm9ahOGMi4H
         JPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973468; x=1715578268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Cm0d3WOH0gamfINjdUviBLGVbtpc+6bD+mA0Jeog2I=;
        b=mMA2ELHTE7WUZvHWQVEU5JWcZ5KhK6hBCAJ1iU99HUMG7Oz7GcSN6ieO02RWBlDn66
         6SmuxTsipaDDg05yWCzhDfzdwRS4A0d5K6uwkAbGy1jK7UeFtayCwwxjMq41hyw2Qq65
         bjlsU8ufYIx1I4k2HPdmvcaC8J06E/5v0CdGFHJ9CX/7Sm0NBgQA1rN4SRwiyFYX/AtL
         6QIcttErkbTOpdaes+Ev0bsUfH/I2NVIgop7+mpBwjIOrscvZmpY/uv/Ts05chSiz6rD
         my23e6dlGczJhlYqpZSMBMGk7eWoHPSD6q9dfKgDp2GEIkRg1Q3tD+wgCeZRI3bLmElm
         Mt+g==
X-Forwarded-Encrypted: i=1; AJvYcCXUj+LCtu5TUBjWfathr2TdnT1UiU7RXoZCqWei2CYd8UeuYscRL+Ey0tuZ9UxyQ9jpY8gSk2ayW4+S74pgR6ziUyFn1PufwnVZA/nLh7wjzQ==
X-Gm-Message-State: AOJu0YxEy71YvTs9zdjkz74SnLgMIXZjvdWjvsovZrdhDtD75aDuG9y5
	yzHXjjwt8rXa97dFDmrP/wnqg/996WTYPOuanxyybyG1akbbTTM8VqxRbJpQNCcMPQX4E2VsBaH
	niv0e3Q==
X-Google-Smtp-Source: AGHT+IGeM4PfyrLMkRnmsSESTf0WoFqFWtMkhMXXs5KOB2nJ1aIerpPN/DcBETXcg4WzoHR8vhC3TE6qxcFC
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:6a00:391c:b0:6ec:f5d2:f7f8 with SMTP id
 fh28-20020a056a00391c00b006ecf5d2f7f8mr119218pfb.2.1714973467043; Sun, 05 May
 2024 22:31:07 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:47 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-23-mizhang@google.com>
Subject: [PATCH v2 22/54] KVM: x86/pmu: Introduce PMU operator to check if
 rdpmc passthrough allowed
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, maobibo <maobibo@loongson.cn>, 
	Like Xu <like.xu.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce a vendor specific API to check if rdpmc passthrough allowed.
RDPMC passthrough requires guest VM have the full ownership of all
counters. These include general purpose counters and fixed counters and
some vendor specific MSRs such as PERF_METRICS. Since PERF_METRICS MSR is
Intel specific, putting the check into vendor specific code.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h |  1 +
 arch/x86/kvm/pmu.c                     |  1 +
 arch/x86/kvm/pmu.h                     |  1 +
 arch/x86/kvm/svm/pmu.c                 |  6 ++++++
 arch/x86/kvm/vmx/pmu_intel.c           | 16 ++++++++++++++++
 5 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index f852b13aeefe..fd986d5146e4 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -20,6 +20,7 @@ KVM_X86_PMU_OP(get_msr)
 KVM_X86_PMU_OP(set_msr)
 KVM_X86_PMU_OP(refresh)
 KVM_X86_PMU_OP(init)
+KVM_X86_PMU_OP(is_rdpmc_passthru_allowed)
 KVM_X86_PMU_OP_OPTIONAL(reset)
 KVM_X86_PMU_OP_OPTIONAL(deliver_pmi)
 KVM_X86_PMU_OP_OPTIONAL(cleanup)
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 19104e16a986..3afefe4cf6e2 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -102,6 +102,7 @@ bool kvm_pmu_check_rdpmc_passthrough(struct kvm_vcpu *vcpu)
 
 	if (is_passthrough_pmu_enabled(vcpu) &&
 	    !enable_vmware_backdoor &&
+	    static_call(kvm_x86_pmu_is_rdpmc_passthru_allowed)(vcpu) &&
 	    pmu->nr_arch_gp_counters == kvm_pmu_cap.num_counters_gp &&
 	    pmu->nr_arch_fixed_counters == kvm_pmu_cap.num_counters_fixed &&
 	    pmu->counter_bitmask[KVM_PMC_GP] == (((u64)1 << kvm_pmu_cap.bit_width_gp) - 1) &&
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 91941a0f6e47..e1af6d07b191 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -40,6 +40,7 @@ struct kvm_pmu_ops {
 	void (*reset)(struct kvm_vcpu *vcpu);
 	void (*deliver_pmi)(struct kvm_vcpu *vcpu);
 	void (*cleanup)(struct kvm_vcpu *vcpu);
+	bool (*is_rdpmc_passthru_allowed)(struct kvm_vcpu *vcpu);
 
 	const u64 EVENTSEL_EVENT;
 	const int MAX_NR_GP_COUNTERS;
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index dfcc38bd97d3..6b471b1ec9b8 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -228,6 +228,11 @@ static void amd_pmu_init(struct kvm_vcpu *vcpu)
 	}
 }
 
+static bool amd_is_rdpmc_passthru_allowed(struct kvm_vcpu *vcpu)
+{
+	return true;
+}
+
 struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.rdpmc_ecx_to_pmc = amd_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = amd_msr_idx_to_pmc,
@@ -237,6 +242,7 @@ struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.set_msr = amd_pmu_set_msr,
 	.refresh = amd_pmu_refresh,
 	.init = amd_pmu_init,
+	.is_rdpmc_passthru_allowed = amd_is_rdpmc_passthru_allowed,
 	.EVENTSEL_EVENT = AMD64_EVENTSEL_EVENT,
 	.MAX_NR_GP_COUNTERS = KVM_AMD_PMC_MAX_GENERIC,
 	.MIN_NR_GP_COUNTERS = AMD64_NUM_COUNTERS,
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 0ed71f825e6b..ed79cbba1edc 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -725,6 +725,21 @@ void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
 	}
 }
 
+static bool intel_is_rdpmc_passthru_allowed(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Per Intel SDM vol. 2 for RDPMC, MSR_PERF_METRICS is accessible by
+	 * with type 0x2000 in ECX[31:16], while the index value in ECX[15:0] is
+	 * implementation specific. Therefore, if the host has this MSR, but
+	 * does not expose it to the guest, RDPMC has to be intercepted.
+	 */
+	if ((host_perf_cap & PMU_CAP_PERF_METRICS) &&
+	    !(vcpu_get_perf_capabilities(vcpu) & PMU_CAP_PERF_METRICS))
+		return false;
+
+	return true;
+}
+
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
 	.rdpmc_ecx_to_pmc = intel_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
@@ -736,6 +751,7 @@ struct kvm_pmu_ops intel_pmu_ops __initdata = {
 	.reset = intel_pmu_reset,
 	.deliver_pmi = intel_pmu_deliver_pmi,
 	.cleanup = intel_pmu_cleanup,
+	.is_rdpmc_passthru_allowed = intel_is_rdpmc_passthru_allowed,
 	.EVENTSEL_EVENT = ARCH_PERFMON_EVENTSEL_EVENT,
 	.MAX_NR_GP_COUNTERS = KVM_INTEL_PMC_MAX_GENERIC,
 	.MIN_NR_GP_COUNTERS = 1,
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

