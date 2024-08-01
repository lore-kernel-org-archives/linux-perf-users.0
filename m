Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E7214A4D4
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 04:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488386; cv=none; b=tiis6nWJsrLBEVrjYKSdLNFK8SRSEcJQ8fITSr2f/hyorvQKVehG5JlfF2cXWT9cZVYCyYGdm30gCDHbirJW9RehUheSRugSNhNnWRZ2/mIH2PhhygHaL5gYsPOXlXJEmX93a530vk/DjLoB3aLu4VaLkDwTiMO/KWsVcQVCDXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488386; c=relaxed/simple;
	bh=H0MXtlDHM6Bo/TPGQa+PMJT7MOLdgMr92QDyRKaFp8U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NGE2h/t5+Rmi8V5ElQNelYYNYIvQOrCyH8Be4K5U+H3MMEom+UNlpTUc7Wxazmz/a22jVO8N4ViuHHTm0xzuWY/KPh8LblpeqClNBEkKmZ2gIBLGzn8upS/sPEiPK9wHJMEmzq9nsExX+cjakWBBlN1T6ds+rRhr+rGhPhu5MI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PDj8XhD4; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PDj8XhD4"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70d1a9bad5dso7006478b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 21:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488384; x=1723093184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx0nuKJStuOrB4Sy2ugR4uZaoZyxQRBJGD6cg8YNS8Y=;
        b=PDj8XhD42Xw6vGKvwncEf7cD4CU8/PFMf8FT2fmgt097b4frSgYQZjyAEkRX3ib6+i
         tusOurvZsrf9KMVQvu/s8nen+KOBdQ+qpazVE86rdlfISKPK29UUnb3gPSm5sbrEv/Pz
         YdAyHpdbiSDOjPPA8WZg/9hU3APGB1sKZjcktcjjTl6uapY91aWIaejC2LxLGoQ8w5Ni
         Ya85XLUHYwoeqZ82DJQIByXm/evi7w7jC6sdifhJQPAd3mWeeKm9W0xAmmSjFtcejlND
         JzkQTWP31TjTTmCK6iZ40r8Tz9xwiH80RvsKJjMdl5ouIZOketj7gyGT97DfiexJIIc2
         ymWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488384; x=1723093184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cx0nuKJStuOrB4Sy2ugR4uZaoZyxQRBJGD6cg8YNS8Y=;
        b=qFJmD/gJGfIDwx33dKqF6dZ2UWHJV/A0V+I1F0tiEuuoLcQZYQASfbza9ZvoGqJfU7
         6w9A682Q60nNdrx/I1k3kgp6smWbZ165vpgEkMrzFJa4twED0y7wQe3Yt1M9qxFRnn4M
         LjQprWIOc/McHAvNIPwlEMneKAtOWKrnazkjzk7g+Ct3G5U9z5qDZyhbe/fxFwzhOBNB
         3YlCeVozDc1BPpdYGRoI67AFRfXphmF9AOezD4ydl5JKY2pMakrzke2CU8telDtTFyQJ
         A7hyOmwROXvYr3Cd6tPWF6rkbiWHS3iKBommEsvPlfOWEjIEvmFz0+SLJoGPofanWlYc
         Fj7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0HFwZ4NFAYgmaCXvJEdrj4b9TXMm1G1jUqhSVKsvbfnXStq6bInWiKnMfUlLEyCyyML6jYyLzLX3McpQWxaWQmFxg8rwWoodD4gUmjPiiQQ==
X-Gm-Message-State: AOJu0Yzp4uJR8KWbY2eEwmFTZ5dWtCUxPY/MqpvzPHG9oYoVKuqOrMqS
	KL/ZlWLcLe3/lOB97e2yDahP22nO8nBBM3cwbf3X1r0XOPXw3OX+A2A31/o4Ow1WPQaFPUveUm2
	OtPnhXg==
X-Google-Smtp-Source: AGHT+IFVr3lXogLikaGE4tP2X9IyV+ex0pdWhVSJYkGS2lzvNdcELKOKlh1HJT6NXYYXdrepZW6InQ2RF4wE
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:6a00:7007:b0:710:4d06:93b3 with SMTP id
 d2e1a72fcca58-7105d7c4bebmr4378b3a.3.1722488384060; Wed, 31 Jul 2024 21:59:44
 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:27 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-19-mizhang@google.com>
Subject: [RFC PATCH v3 18/58] KVM: x86/pmu: Introduce enable_passthrough_pmu
 module parameter
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce enable_passthrough_pmu as a RO KVM kernel module parameter. This
variable is true only when the following conditions satisfies:
 - set to true when module loaded.
 - enable_pmu is true.
 - is running on Intel CPU.
 - supports PerfMon v4.
 - host PMU supports passthrough mode.

The value is always read-only because passthrough PMU currently does not
support features like LBR and PEBS, while emualted PMU does. This will end
up with two different values for kvm_cap.supported_perf_cap, which is
initialized at module load time. Maintaining two different perf
capabilities will add complexity. Further, there is not enough motivation
to support running two types of PMU implementations at the same time,
although it is possible/feasible in reality.

Finally, always propagate enable_passthrough_pmu and perf_capabilities into
kvm->arch for each KVM instance.

Co-developed-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/pmu.h              | 14 ++++++++++++++
 arch/x86/kvm/vmx/vmx.c          |  7 +++++--
 arch/x86/kvm/x86.c              |  8 ++++++++
 arch/x86/kvm/x86.h              |  1 +
 5 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f8ca74e7678f..a15c783f20b9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1406,6 +1406,7 @@ struct kvm_arch {
 
 	bool bus_lock_detection_enabled;
 	bool enable_pmu;
+	bool enable_passthrough_pmu;
 
 	u32 notify_window;
 	u32 notify_vmexit_flags;
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 4d52b0b539ba..cf93be5e7359 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -208,6 +208,20 @@ static inline void kvm_init_pmu_capability(const struct kvm_pmu_ops *pmu_ops)
 			enable_pmu = false;
 	}
 
+	/* Pass-through vPMU is only supported in Intel CPUs. */
+	if (!is_intel)
+		enable_passthrough_pmu = false;
+
+	/*
+	 * Pass-through vPMU requires at least PerfMon version 4 because the
+	 * implementation requires the usage of MSR_CORE_PERF_GLOBAL_STATUS_SET
+	 * for counter emulation as well as PMU context switch.  In addition, it
+	 * requires host PMU support on passthrough mode. Disable pass-through
+	 * vPMU if any condition fails.
+	 */
+	if (!enable_pmu || kvm_pmu_cap.version < 4 || !kvm_pmu_cap.passthrough)
+		enable_passthrough_pmu = false;
+
 	if (!enable_pmu) {
 		memset(&kvm_pmu_cap, 0, sizeof(kvm_pmu_cap));
 		return;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ad465881b043..2ad122995f11 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -146,6 +146,8 @@ module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUGO);
 extern bool __read_mostly allow_smaller_maxphyaddr;
 module_param(allow_smaller_maxphyaddr, bool, S_IRUGO);
 
+module_param(enable_passthrough_pmu, bool, 0444);
+
 #define KVM_VM_CR0_ALWAYS_OFF (X86_CR0_NW | X86_CR0_CD)
 #define KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST X86_CR0_NE
 #define KVM_VM_CR0_ALWAYS_ON				\
@@ -7924,7 +7926,8 @@ static __init u64 vmx_get_perf_capabilities(void)
 	if (boot_cpu_has(X86_FEATURE_PDCM))
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
 
-	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR)) {
+	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR) &&
+	    !enable_passthrough_pmu) {
 		x86_perf_get_lbr(&vmx_lbr_caps);
 
 		/*
@@ -7938,7 +7941,7 @@ static __init u64 vmx_get_perf_capabilities(void)
 			perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
 	}
 
-	if (vmx_pebs_supported()) {
+	if (vmx_pebs_supported() && !enable_passthrough_pmu) {
 		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;
 
 		/*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f1d589c07068..0c40f551130e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -187,6 +187,10 @@ bool __read_mostly enable_pmu = true;
 EXPORT_SYMBOL_GPL(enable_pmu);
 module_param(enable_pmu, bool, 0444);
 
+/* Enable/disable mediated passthrough PMU virtualization */
+bool __read_mostly enable_passthrough_pmu;
+EXPORT_SYMBOL_GPL(enable_passthrough_pmu);
+
 bool __read_mostly eager_page_split = true;
 module_param(eager_page_split, bool, 0644);
 
@@ -6682,6 +6686,9 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		mutex_lock(&kvm->lock);
 		if (!kvm->created_vcpus) {
 			kvm->arch.enable_pmu = !(cap->args[0] & KVM_PMU_CAP_DISABLE);
+			/* Disable passthrough PMU if enable_pmu is false. */
+			if (!kvm->arch.enable_pmu)
+				kvm->arch.enable_passthrough_pmu = false;
 			r = 0;
 		}
 		mutex_unlock(&kvm->lock);
@@ -12623,6 +12630,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.default_tsc_khz = max_tsc_khz ? : tsc_khz;
 	kvm->arch.guest_can_read_msr_platform_info = true;
 	kvm->arch.enable_pmu = enable_pmu;
+	kvm->arch.enable_passthrough_pmu = enable_passthrough_pmu;
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	spin_lock_init(&kvm->arch.hv_root_tdp_lock);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index d80a4c6b5a38..dc45ba42bec2 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -332,6 +332,7 @@ extern u64 host_arch_capabilities;
 extern struct kvm_caps kvm_caps;
 
 extern bool enable_pmu;
+extern bool enable_passthrough_pmu;
 
 /*
  * Get a filtered version of KVM's supported XCR0 that strips out dynamic
-- 
2.46.0.rc1.232.g9752f9e123-goog

