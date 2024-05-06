Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9BB1422C3
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973466; cv=none; b=Bdo6Y6up0wZY7x+bCgvcKapzFjZJ8iiw6SyLZrmzmHnzIIUpG9n2SAipzviTFs55q81VLBN8FkpkQS8DHTh/4Ypz0tJhfDDsUeZdggx351xrPUFWITs5c2GQ9Sdmjpq5gmwMMTZ9o5dkosikyHav+n+JaheJXdsQmvX47RX2Xp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973466; c=relaxed/simple;
	bh=/IExVlLXi1XUumwctFV0xeMQG4rxFDbkAvxG8e5Ynds=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F/u5Hi8psRu76G7jhm87fQT2Adi3+r5+ZR+6/gMU7Unrf41gKnbkuYq59ZnrBHMbSGHw9emjbKBcGO4K3NB/q6n5ibiBntH/R8B73Ij2wNS3y9IfZUdtck9foiPlDX/pic7GWLXSpld2Io908l3hPJyAtdSbaloZPINYfZJa1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kVvTIs73; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVvTIs73"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de5a8638579so3251202276.1
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973463; x=1715578263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hfbUgxYRV9YwnDSJq93oojIJaw2adkoZd3HkvbQekyY=;
        b=kVvTIs73iE1H+EZASb4tEgY25uNo1zEjcDbCBu3x7JgtktEKXK4Ek2X8FdadWwKAPX
         CQn1QwGGCbZdHcALAvfqBEke6MX0dUdA8ZHokz4SKJYuRnrD2Ixo2RU4Q9rjmwdITPIt
         syNksOpIMOnVMHf/ZV54UaWCQ+pQ+JPrDMea9lFlQ/FWYgGZ1EjNtxHiRdCgW/YF397a
         9ERb+qXmtVmbxUhOvQafbI0I3d5WqkbbiJiOUqQPvraYk4guRIPLIeEjvJbgW+vS0U0r
         BgCBS8HOXXI5ox8L40PA42VMbV2cPRTDTJUUbkyXlp2OaQqqnbXroy+6pA5QCvrwrDsZ
         vQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973463; x=1715578263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfbUgxYRV9YwnDSJq93oojIJaw2adkoZd3HkvbQekyY=;
        b=F6TF3iUW4rNhJI1DMomTOCuEUQvYRtV7eDTCI920vvmQwmwXTwXAaO/kltCwYJ32eR
         EhpDotHDPgh2QhEJiF2sd/tcMFMUaOemiag80uMFG7Y3UzbrzNCFRbfXnxPOMw4E3UPK
         KlVqBx8OwHTGjhm3tTUzE5ggqPJaxjpPNWhfnd7D5fd3Br37clrXO8Gdi61jpR0LjVeC
         Ko7ISxESp3NONvuP0F2EZCEBeNvOslKl8TGUiWHMnkhSdtDwLquI/Po1FbpIOTPZKBhb
         abZZW12MHe5ZZfKkxJcQ87kd5VDI+BdJoQ1+VJptonRklYRTaRehtKxQ7frFUBG2W2L/
         mOTw==
X-Forwarded-Encrypted: i=1; AJvYcCV59qSrAZD4auACEDUdA1nx+xQraIlaY6N9PFqmb+8U4dgJYc/vIKbVohhJOMFp7IHeZ3RXzw0W+1WrRvBUfOP3ynNWRJrH1qn0KXc9db3S5A==
X-Gm-Message-State: AOJu0YzaX359GvndG7SX1/7E+z4h8euTDN0sUaPIJYyDPdQ+cXRjhbWD
	QY9+YtTOYpJhvXtgQAzJjOPdvufE56hCPDbRu6KsW0OEmcfr5PHSYmjntGQkgQEsINpoPj8qYoM
	xBFETsw==
X-Google-Smtp-Source: AGHT+IF27Sa8E+fx+mHIrCHtklZSfumUby+NmojCdwBpig8er9Vggb885cYLPpAAghizdh7rqjeJ89+7BF1F
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:6902:114d:b0:dd9:1b94:edb5 with SMTP id
 p13-20020a056902114d00b00dd91b94edb5mr1041962ybu.10.1714973463649; Sun, 05
 May 2024 22:31:03 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:45 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-21-mizhang@google.com>
Subject: [PATCH v2 20/54] KVM: x86/pmu: Allow RDPMC pass through when all
 counters exposed to guest
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

Clear RDPMC_EXITING in vmcs when all counters on the host side are exposed
to guest VM. This gives performance to passthrough PMU. However, when guest
does not get all counters, intercept RDPMC to prevent access to unexposed
counters. Make decision in vmx_vcpu_after_set_cpuid() when guest enables
PMU and passthrough PMU is enabled.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Co-developed-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/kvm/pmu.c     | 16 ++++++++++++++++
 arch/x86/kvm/pmu.h     |  1 +
 arch/x86/kvm/vmx/vmx.c |  5 +++++
 3 files changed, 22 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index e656f72fdace..19104e16a986 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -96,6 +96,22 @@ void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops)
 #undef __KVM_X86_PMU_OP
 }
 
+bool kvm_pmu_check_rdpmc_passthrough(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	if (is_passthrough_pmu_enabled(vcpu) &&
+	    !enable_vmware_backdoor &&
+	    pmu->nr_arch_gp_counters == kvm_pmu_cap.num_counters_gp &&
+	    pmu->nr_arch_fixed_counters == kvm_pmu_cap.num_counters_fixed &&
+	    pmu->counter_bitmask[KVM_PMC_GP] == (((u64)1 << kvm_pmu_cap.bit_width_gp) - 1) &&
+	    pmu->counter_bitmask[KVM_PMC_FIXED] == (((u64)1 << kvm_pmu_cap.bit_width_fixed)  - 1))
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(kvm_pmu_check_rdpmc_passthrough);
+
 static inline void __kvm_perf_overflow(struct kvm_pmc *pmc, bool in_pmi)
 {
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index e041c8a23e2f..91941a0f6e47 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -290,6 +290,7 @@ void kvm_pmu_cleanup(struct kvm_vcpu *vcpu);
 void kvm_pmu_destroy(struct kvm_vcpu *vcpu);
 int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp);
 void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel);
+bool kvm_pmu_check_rdpmc_passthrough(struct kvm_vcpu *vcpu);
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a5024b7b0439..a18ba5ae5376 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7860,6 +7860,11 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		vmx->msr_ia32_feature_control_valid_bits &=
 			~FEAT_CTL_SGX_LC_ENABLED;
 
+	if (kvm_pmu_check_rdpmc_passthrough(&vmx->vcpu))
+		exec_controls_clearbit(vmx, CPU_BASED_RDPMC_EXITING);
+	else
+		exec_controls_setbit(vmx, CPU_BASED_RDPMC_EXITING);
+
 	/* Refresh #PF interception to account for MAXPHYADDR changes. */
 	vmx_update_exception_bitmap(vcpu);
 }
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

