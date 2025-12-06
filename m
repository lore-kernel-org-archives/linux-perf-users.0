Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567B82C0293
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Dec 2025 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980289; cv=none; b=X/as0JCO16liBzH8jeB7nZ1LTdkhJzu21GSG0WQ0XpFtn+Rbp1hiERDbdCHigl8d76Z+UG9G+yN8JJpAR3tiLZB8cQQWjLISIcNkf3OpRt/wgL6Ml3urtLwRoYpbEAgXZpYPRcPLgXOd0hXmEiQzuAMgUSvOIf+sRDDdwgoe0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980289; c=relaxed/simple;
	bh=ke85FLmiKSfdj4rUFAQKnbz4Pj1/xMDGNPG2+PNz6uc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k4UwZwXuH9TwWvqojCxfY1rm2hbPdiE5iCGf5BEucruIkepeyWstAUqdArCs8Ha68YRInAlF9DyUtKRMSQoEHiDHWh3Zr3ia/SHcJaYloaJm9ictw5x1GXLyMdxGa16OkGs8Ama4YoVrDXtuDtOrfNx7hOyBSvfZbGkDdmAdrBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=duvqRfMk; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="duvqRfMk"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7ba92341f38so2729829b3a.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 16:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764980286; x=1765585086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3tXwFHzylPZMGyN6KBlqBM06kqQeDyKKeii7TB3ROVw=;
        b=duvqRfMkfDvLQbWqABHCg5hheVxU4oc6TzwHIiI2gz9eEoUBUcTKY0jsAP7yA43Wt7
         4OXeUJ1eUJi7bxoiQ7MV3FREuCZuYPFh6kkn8Kid923xyyNoxTcfVF53GGPwNG4z9bY3
         HEszbW1ehyBA44qD3wtJCgT4p3W9HzyPHOycndFUPEYlOe5d6UpR4Z1l+xeYVHznygo0
         9xnrSUyqzHRHmAmOdkwzj1XJrcJ2xPuv6+JIEgKG2mDg+OkfxksvQh9Qy5s2TPUpfc+J
         I8Eq3GuSKogdAbydRm976vWyI2QWASdk2w9f01J9DWKwuJjvrS32jDmIoj1Ft8vKJGle
         kQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980286; x=1765585086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tXwFHzylPZMGyN6KBlqBM06kqQeDyKKeii7TB3ROVw=;
        b=NbqdwiGbiv7vfBIVzBr/LGjv/ZhozaiY6tUDJ0EmGy5FMIphePEZuaZy9BdUiw0eg1
         OTuL/aFS3LhnBN8eQnUpJstg2ODhp5yDqwRyb8SqeSU0+DgrNxM2fhEW99NHMrfmer4l
         aPc0FVZvNGqJcZ5Su+jIk9c2UUCkgEkdDLFVngO2ZzkVpgEzp3GTmJYJlrI/OXpsEDmf
         5s55JOtXvLFOenx58eAM5h1Shqlw1kn6e7AtqIoItwkyu4mlf3I439xNkQWaOQVpYGWe
         PSTwzMsq7PZLvW7p95YFv2GxDUTyE9EuZXO/JXc1vF1AlkpBZjmWAVGygm17vdv9F35I
         s5eg==
X-Forwarded-Encrypted: i=1; AJvYcCXXvEguWpX+j9pDwNQhud7/PlBxonnYJsAMSh9zxbs0jna3sR0vxg/qp62If4fPIxRoR0aqhWF7DbcCUGrNOrH+@vger.kernel.org
X-Gm-Message-State: AOJu0YxzH9vLhJQdWXOoijriz4F+zgb/8yANQ63tqNCt2pUAjTUgYBlN
	EEgjDJjYbzIUaBZi1notaw9DQ8L9m528RH1ThHY+w/bYnw5NeoYLCPBYLEOduVGSjBTxLfWpLto
	iJgWDIA==
X-Google-Smtp-Source: AGHT+IGMO0B+jqPHT7+9YfCBpeq9zR/PklORB8CpAuE6Up8hoHfkAh/+97jt6V2KW+WqsentqXikVA61obU=
X-Received: from pfbdr8.prod.google.com ([2002:a05:6a00:4a88:b0:7ae:973b:9f29])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14c9:b0:7b7:a62:550c
 with SMTP id d2e1a72fcca58-7e8bf858c3dmr849285b3a.1.1764980286427; Fri, 05
 Dec 2025 16:18:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Dec 2025 16:16:56 -0800
In-Reply-To: <20251206001720.468579-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251206001720.468579-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251206001720.468579-21-seanjc@google.com>
Subject: [PATCH v6 20/44] KVM: x86/pmu: Disable RDPMC interception for
 compatible mediated vPMU
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Xudong Hao <xudong.hao@intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Disable RDPMC interception for vCPUs with a mediated vPMU that is
compatible with the host PMU, i.e. that doesn't require KVM emulation of
RDPMC to honor the guest's vCPU model.  With a mediated vPMU, all guest
state accessible via RDPMC is loaded into hardware while the guest is
running.

Adust RDPMC interception only for non-TDX guests, as the TDX module is
responsible for managing RDPMC intercepts based on the TD configuration.

Co-developed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Co-developed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c     | 26 ++++++++++++++++++++++++++
 arch/x86/kvm/pmu.h     |  1 +
 arch/x86/kvm/svm/svm.c |  5 +++++
 arch/x86/kvm/vmx/vmx.c |  7 +++++++
 arch/x86/kvm/x86.c     |  1 +
 5 files changed, 40 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index b3dde9a836ea..182ff2d8d119 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -716,6 +716,32 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 	return 0;
 }
 
+bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	if (!kvm_vcpu_has_mediated_pmu(vcpu))
+		return true;
+
+	/*
+	 * VMware allows access to these Pseduo-PMCs even when read via RDPMC
+	 * in Ring3 when CR4.PCE=0.
+	 */
+	if (enable_vmware_backdoor)
+		return true;
+
+	/*
+	 * Note!  Check *host* PMU capabilities, not KVM's PMU capabilities, as
+	 * KVM's capabilities are constrained based on KVM support, i.e. KVM's
+	 * capabilities themselves may be a subset of hardware capabilities.
+	 */
+	return pmu->nr_arch_gp_counters != kvm_host_pmu.num_counters_gp ||
+	       pmu->nr_arch_fixed_counters != kvm_host_pmu.num_counters_fixed ||
+	       pmu->counter_bitmask[KVM_PMC_GP] != (BIT_ULL(kvm_host_pmu.bit_width_gp) - 1) ||
+	       pmu->counter_bitmask[KVM_PMC_FIXED] != (BIT_ULL(kvm_host_pmu.bit_width_fixed) - 1);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_rdpmc_intercept);
+
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu)
 {
 	if (lapic_in_kernel(vcpu)) {
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 9849c2bb720d..506c203587ea 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -238,6 +238,7 @@ void kvm_pmu_instruction_retired(struct kvm_vcpu *vcpu);
 void kvm_pmu_branch_retired(struct kvm_vcpu *vcpu);
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx);
+bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu);
 
 extern struct kvm_pmu_ops intel_pmu_ops;
 extern struct kvm_pmu_ops amd_pmu_ops;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 24d59ccfa40d..11913574de88 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1011,6 +1011,11 @@ static void svm_recalc_instruction_intercepts(struct kvm_vcpu *vcpu)
 			svm->vmcb->control.virt_ext |= VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK;
 		}
 	}
+
+	if (kvm_need_rdpmc_intercept(vcpu))
+		svm_set_intercept(svm, INTERCEPT_RDPMC);
+	else
+		svm_clr_intercept(svm, INTERCEPT_RDPMC);
 }
 
 static void svm_recalc_intercepts(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index fdd18ad1ede3..9f71ba99cf70 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4300,8 +4300,15 @@ static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 	 */
 }
 
+static void vmx_recalc_instruction_intercepts(struct kvm_vcpu *vcpu)
+{
+	exec_controls_changebit(to_vmx(vcpu), CPU_BASED_RDPMC_EXITING,
+				kvm_need_rdpmc_intercept(vcpu));
+}
+
 void vmx_recalc_intercepts(struct kvm_vcpu *vcpu)
 {
+	vmx_recalc_instruction_intercepts(vcpu);
 	vmx_recalc_msr_intercepts(vcpu);
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1623afddff3b..76e86eb358df 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3945,6 +3945,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 		vcpu->arch.perf_capabilities = data;
 		kvm_pmu_refresh(vcpu);
+		kvm_make_request(KVM_REQ_RECALC_INTERCEPTS, vcpu);
 		break;
 	case MSR_IA32_PRED_CMD: {
 		u64 reserved_bits = ~(PRED_CMD_IBPB | PRED_CMD_SBPB);
-- 
2.52.0.223.gf5cc29aaa4-goog

