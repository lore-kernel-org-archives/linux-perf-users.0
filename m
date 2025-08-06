Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163DB2C3757
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510288; cv=none; b=J0LHd4c7mhRZOqu3K7ZZ3OJzbDfLcmN635B2NL+HC69emR7qhpYcvC/fWeEolfw+JGrZ/xLNMlm/8+OttolbOq35Cvv/DggOukskrwyD2f5HI8GZK8S4lMf99+0QiyKRCpVWNnk1dLoLijQWTUcl3YzVJOgZpMlKq/EcbTjGt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510288; c=relaxed/simple;
	bh=SrY28soq4e2umnXSFWFek5BM85G7hV4RrtHjWFxzyM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MeCjvfVG5TNefsZBDdPyRYj/RLNlc4H/BcFXhdTrxfoeGxNrD79DjpJoGm1EaXLDkwWdYtxUGo8IByB8fbLvO8APN07+nQr9LVFke+/arz7Lb1K20CyP+pDBlDuzoyNKMaB6dk3k56Yph6CRKzbd6UzIAU4bo72IHaQ3fQfRYB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lsTE+izp; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lsTE+izp"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bb73b63d2so286245b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510284; x=1755115084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GWdUZrt+U2ZtCbYKTsMlrHRvg1+poTmQboTMZxCN7ww=;
        b=lsTE+izpqSy/cIW9NFPPrDqdyCJ7ANLnG342H3Se9/7tbKtiDqfQV8CdT72T8q1Dma
         f9unfBmSGccU/nw47APfm8o7eRDLKo71U70iD3/PLyfAgbs3xkXhCMtDU9fL8QrjulxJ
         slg5Gj4GZvHbZBURxZgWDKhDmYsy6PRzphwnOorj3vfXlueyg5ycqh0ylwDUg596FOqv
         TfZOB7E5WE/B3XeDjSo3KnqJN9ci1xlqzxG6nmGxz8nXnvPoFyLnNqhRzAVrnTYQftoX
         A28Hh09NkVtz21gMeLq+12F6eMFAs+Bmp7H+s2C2YwmM3QM3Z3vAyavudU9Up9m/2J+O
         QuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510284; x=1755115084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWdUZrt+U2ZtCbYKTsMlrHRvg1+poTmQboTMZxCN7ww=;
        b=KABA82TzNjcWF1QF4zeClJ+Tx7+dgZ6Pk4noXpHPOPKKczOWM3eMhGAMUZDgMWIXFq
         ffcW8FUp7XUJgYjFjHwWeEoV2jVIQwPMNePA6zswutKf46ufa1WSbkz31VljkMuPfU4q
         sWkMqNhNHedxY/lNf59n2s/0HBhvp9zABn6rTlbyF+T4T/5mY2eecTiNUsrTnuPMrNFN
         REiTrdSKxhl4sMRUrIQJgvVqY9xe7LzwBr8CKsn3sjT2Kc6GOhoW8sdG/PecMjGZ+A/s
         8+l4P82JGdJ5UtkDRmy7m4AXXVNDI9gx503pIwaY4V67DTjVJBOku9A7hjLPbFUG7Cyj
         Gv2A==
X-Forwarded-Encrypted: i=1; AJvYcCX9QpoD9DCZtdGsjs3hQoc6ECwx0QJuo7HeEkpKkkE7d9pp9ELGxDYov09vcKj6E4W/uaCFMJvorfgYCcMUVXDW@vger.kernel.org
X-Gm-Message-State: AOJu0YxvB7cVnh+A3on+Y+LkwvzDsKbpns7GKodmINAO+Aas+Aj5qDus
	zXDDz52fUe6ngUezhCS2XuqV+K4JGGoAXR83uAQ0i6rLsaxwFfF/J2h7tXx3e33PEf010ceGqo/
	UYCAM2g==
X-Google-Smtp-Source: AGHT+IGuU+RWQRwCAfzWML148fgqdvdKW6alxUtwh3XwkGhhvD7y/3BjKg8jOpNbCUSNYHrZUCLfYMHRL8Y=
X-Received: from pghd12.prod.google.com ([2002:a63:fd0c:0:b0:b42:2d66:cdc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:8045:b0:240:43e9:6cb7
 with SMTP id adf61e73a8af0-24043e97001mr56266637.45.1754510284410; Wed, 06
 Aug 2025 12:58:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:41 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-20-seanjc@google.com>
Subject: [PATCH v5 19/44] KVM: x86/pmu: Implement Intel mediated PMU
 requirements and constraints
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Implement Intel PMU requirements and constraints for mediated PMU support.
Require host PMU version 4+ so that PERF_GLOBAL_STATUS_SET can be used to
precisely load the guest's status value into hardware, and require full-
width writes so that KVM can precisely load guest counter values.

Disable PEBS and LBRs if mediated PMU support is enabled, as they won't be
supported in the initial implementation.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
[sean: split to separate patch, add full-width writes dependency]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/capabilities.h |  3 ++-
 arch/x86/kvm/vmx/pmu_intel.c    | 17 +++++++++++++++++
 arch/x86/kvm/vmx/vmx.c          |  3 ++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 5316c27f6099..854e54c352f8 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -389,7 +389,8 @@ static inline bool vmx_pt_mode_is_host_guest(void)
 
 static inline bool vmx_pebs_supported(void)
 {
-	return boot_cpu_has(X86_FEATURE_PEBS) && kvm_pmu_cap.pebs_ept;
+	return boot_cpu_has(X86_FEATURE_PEBS) && kvm_pmu_cap.pebs_ept &&
+	       !enable_mediated_pmu;
 }
 
 static inline bool cpu_has_notify_vmexit(void)
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 07baff96300f..8df8d7b4f212 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -776,6 +776,20 @@ void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
 	}
 }
 
+static bool intel_pmu_is_mediated_pmu_supported(struct x86_pmu_capability *host_pmu)
+{
+	u64 host_perf_cap = 0;
+
+	if (boot_cpu_has(X86_FEATURE_PDCM))
+		rdmsrq(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
+
+	/*
+	 * Require v4+ for MSR_CORE_PERF_GLOBAL_STATUS_SET, and full-width
+	 * writes so that KVM can precisely load guest counter values.
+	 */
+	return host_pmu->version >= 4 && host_perf_cap & PMU_CAP_FW_WRITES;
+}
+
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
 	.rdpmc_ecx_to_pmc = intel_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
@@ -787,6 +801,9 @@ struct kvm_pmu_ops intel_pmu_ops __initdata = {
 	.reset = intel_pmu_reset,
 	.deliver_pmi = intel_pmu_deliver_pmi,
 	.cleanup = intel_pmu_cleanup,
+
+	.is_mediated_pmu_supported = intel_pmu_is_mediated_pmu_supported,
+
 	.EVENTSEL_EVENT = ARCH_PERFMON_EVENTSEL_EVENT,
 	.MAX_NR_GP_COUNTERS = KVM_MAX_NR_INTEL_GP_COUNTERS,
 	.MIN_NR_GP_COUNTERS = 1,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ed10013dac95..8c6343494e62 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7795,7 +7795,8 @@ static __init u64 vmx_get_perf_capabilities(void)
 	if (boot_cpu_has(X86_FEATURE_PDCM))
 		rdmsrq(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
 
-	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR)) {
+	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR) &&
+	    !enable_mediated_pmu) {
 		x86_perf_get_lbr(&vmx_lbr_caps);
 
 		/*
-- 
2.50.1.565.gc32cd1483b-goog

