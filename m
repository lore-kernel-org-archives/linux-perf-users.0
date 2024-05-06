Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6CA142629
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973472; cv=none; b=o4Sru6DJI30X6TLXPXkMutCrjQ6HsL1G3vY7L1PObkeDFX5dFawBGk4fA7/6cN5/wJnYEGXOd2Cw+LBmrqle3G+JKdRRmZs6/I0spTWgmnbTFhdiHbHcBbZF3AI0QGm9y5nnEO6KMQduKM4rkUBnuTl7kuQDk2rvJjKUayo8dWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973472; c=relaxed/simple;
	bh=XM29vpecCiZp1KknJCG3naAFJYGZHXZbY/Z/VhhUoho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A6uNNow/Mh2LPO3b8MXsGZrt3J3Jg+x/vlFPNEQqeqJbhQc1eMvvAJbuwgtQVDLege2ijLrumH7T6EQ+YO1tDBTObRQfq7RxdPAU9DctseytZZd17bxxtofKpwZmdG2d++wXHa7BJvKk/lZUGhWWysTuV8mxpAgdPAcywzOmJyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OD4kYmIk; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OD4kYmIk"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b432dfdcf6so1427337a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973470; x=1715578270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gTx6noZ6DKNT2htxMj+3XNwZouTTiws51/mPTM/eomo=;
        b=OD4kYmIkVOJPUEvI8wjvqUym1+hnWQ9CKDyqxyKKMCSapFDRur0bybzOEsTYJgCNw+
         Ym39WqIvcHK+uEEoC8JinD3OXIUMP9dOzOQsXFDfP1iOERxsqfY+6bZ/6Rcq2PFqHxyR
         xCwbWByiXlkkwXbbILJioT2DCyRZKttTtTW9TYBToDraFiUlZMVfx1kL1nmUs47vY8fI
         O0guelgsrPB5Hhv6u6luqnouZur3HePlkUPt0SFs+cocTmtRC8YXk/wJN6i7Hcahh9Sc
         Km7zxy+JcAP6ejsLnYPI0d/GltS0CXfVDj3oMcUqV7ngiiSYxMIVb1gS0WyH6TV1Zx3k
         7y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973470; x=1715578270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTx6noZ6DKNT2htxMj+3XNwZouTTiws51/mPTM/eomo=;
        b=RgbcxLElIpN4J5XbN5EwXQ8QIJWqNpUaGcH9vFXtfcx0tyyjtXkB4WudB58+lHtC6o
         WsF8Lp1tymaXYn3L1NeqWPVt9dDbGqogpmiXoeyENOZqpz/+orfA1Vqint7U8vNRGVvB
         UAB0H7kVdm5ti0nFYAmxowGcKAR2ZZnb23svFT4fTYii86nsxD7ISD4D4S44uhiQy3O4
         G+kTVyAWZwHWgXko70y1/A6LrW/kpgJv6TWU9jYATP0KmCaf8uE6D3aevpf4Sm/hRZAQ
         1BiqE+FnuEixmP4YB9wnMnGVewcCXI8dDcGK/FxW74OLAM40rD6B8RYQzZSXsSCY9aLF
         C/JA==
X-Forwarded-Encrypted: i=1; AJvYcCXlQdHbxGQHpoBSgscqG9zP6i04W1lMUxvMo6H7/C6eZ1+C+wniBFGFjH2zmIt2xNVgl/ptTrQLZjOEBoe0qhVVQACW3+c5aUGw7BZgCuUATw==
X-Gm-Message-State: AOJu0Yy6PQjrQtdN4OBedpCopaIQH/hEz9hkj2z8jMUpZJhgfIiHUBVZ
	F/BUC/zVELQ1zglNBYlYoNd+CXs0sCmsMX83EYCzLyxMXN3dtosOTCkmUOWRrQghLddXKhRidjA
	KDv3mqw==
X-Google-Smtp-Source: AGHT+IFZ0MCw/e7qn2a29netXIAibpfDk0eLQNDd86cqkpu87iBJEfEtaP5K/YWY1fKKve+tYuJCvDKrvZ/v
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a17:90a:4307:b0:2af:d65f:f89e with SMTP id
 q7-20020a17090a430700b002afd65ff89emr28972pjg.0.1714973470190; Sun, 05 May
 2024 22:31:10 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:48 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-24-mizhang@google.com>
Subject: [PATCH v2 23/54] KVM: x86/pmu: Manage MSR interception for IA32_PERF_GLOBAL_CTRL
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

From: Xiong Zhang <xiong.y.zhang@linux.intel.com>

In PMU passthrough mode, there are three requirements to manage
IA32_PERF_GLOBAL_CTRL:
 - guest IA32_PERF_GLOBAL_CTRL MSR must be saved at vm exit.
 - IA32_PERF_GLOBAL_CTRL MSR must be cleared at vm exit to avoid any
   counter of running within KVM runloop.
 - guest IA32_PERF_GLOBAL_CTRL MSR must be restored at vm entry.

Introduce vmx_set_perf_global_ctrl() function to auto switching
IA32_PERF_GLOBAL_CTR and invoke it after the VMM finishes setting up the
CPUID bits.

Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/include/asm/vmx.h |   1 +
 arch/x86/kvm/vmx/vmx.c     | 117 +++++++++++++++++++++++++++++++------
 arch/x86/kvm/vmx/vmx.h     |   3 +-
 3 files changed, 103 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 4dba17363008..9b363e30e40c 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -105,6 +105,7 @@
 #define VM_EXIT_CLEAR_BNDCFGS                   0x00800000
 #define VM_EXIT_PT_CONCEAL_PIP			0x01000000
 #define VM_EXIT_CLEAR_IA32_RTIT_CTL		0x02000000
+#define VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL      0x40000000
 
 #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a18ba5ae5376..c9de7d2623b8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4385,6 +4385,97 @@ static u32 vmx_pin_based_exec_ctrl(struct vcpu_vmx *vmx)
 	return pin_based_exec_ctrl;
 }
 
+static void vmx_set_perf_global_ctrl(struct vcpu_vmx *vmx)
+{
+	u32 vmentry_ctrl = vm_entry_controls_get(vmx);
+	u32 vmexit_ctrl = vm_exit_controls_get(vmx);
+	struct vmx_msrs *m;
+	int i;
+
+	if (cpu_has_perf_global_ctrl_bug() ||
+	    !is_passthrough_pmu_enabled(&vmx->vcpu)) {
+		vmentry_ctrl &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
+		vmexit_ctrl &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
+		vmexit_ctrl &= ~VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL;
+	}
+
+	if (is_passthrough_pmu_enabled(&vmx->vcpu)) {
+		/*
+		 * Setup auto restore guest PERF_GLOBAL_CTRL MSR at vm entry.
+		 */
+		if (vmentry_ctrl & VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL) {
+			vmcs_write64(GUEST_IA32_PERF_GLOBAL_CTRL, 0);
+		} else {
+			m = &vmx->msr_autoload.guest;
+			i = vmx_find_loadstore_msr_slot(m, MSR_CORE_PERF_GLOBAL_CTRL);
+			if (i < 0) {
+				i = m->nr++;
+				vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, m->nr);
+			}
+			m->val[i].index = MSR_CORE_PERF_GLOBAL_CTRL;
+			m->val[i].value = 0;
+		}
+		/*
+		 * Setup auto clear host PERF_GLOBAL_CTRL msr at vm exit.
+		 */
+		if (vmexit_ctrl & VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL) {
+			vmcs_write64(HOST_IA32_PERF_GLOBAL_CTRL, 0);
+		} else {
+			m = &vmx->msr_autoload.host;
+			i = vmx_find_loadstore_msr_slot(m, MSR_CORE_PERF_GLOBAL_CTRL);
+			if (i < 0) {
+				i = m->nr++;
+				vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, m->nr);
+			}
+			m->val[i].index = MSR_CORE_PERF_GLOBAL_CTRL;
+			m->val[i].value = 0;
+		}
+		/*
+		 * Setup auto save guest PERF_GLOBAL_CTRL msr at vm exit
+		 */
+		if (!(vmexit_ctrl & VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL)) {
+			m = &vmx->msr_autostore.guest;
+			i = vmx_find_loadstore_msr_slot(m, MSR_CORE_PERF_GLOBAL_CTRL);
+			if (i < 0) {
+				i = m->nr++;
+				vmcs_write32(VM_EXIT_MSR_STORE_COUNT, m->nr);
+			}
+			m->val[i].index = MSR_CORE_PERF_GLOBAL_CTRL;
+		}
+	} else {
+		if (!(vmentry_ctrl & VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL)) {
+			m = &vmx->msr_autoload.guest;
+			i = vmx_find_loadstore_msr_slot(m, MSR_CORE_PERF_GLOBAL_CTRL);
+			if (i >= 0) {
+				m->nr--;
+				m->val[i] = m->val[m->nr];
+				vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, m->nr);
+			}
+		}
+		if (!(vmexit_ctrl & VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL)) {
+			m = &vmx->msr_autoload.host;
+			i = vmx_find_loadstore_msr_slot(m, MSR_CORE_PERF_GLOBAL_CTRL);
+			if (i >= 0) {
+				m->nr--;
+				m->val[i] = m->val[m->nr];
+				vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, m->nr);
+			}
+		}
+		if (!(vmexit_ctrl & VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL)) {
+			m = &vmx->msr_autostore.guest;
+			i = vmx_find_loadstore_msr_slot(m, MSR_CORE_PERF_GLOBAL_CTRL);
+			if (i >= 0) {
+				m->nr--;
+				m->val[i] = m->val[m->nr];
+				vmcs_write32(VM_EXIT_MSR_STORE_COUNT, m->nr);
+			}
+		}
+	}
+
+	vm_entry_controls_set(vmx, vmentry_ctrl);
+	vm_exit_controls_set(vmx, vmexit_ctrl);
+}
+
 static u32 vmx_vmentry_ctrl(void)
 {
 	u32 vmentry_ctrl = vmcs_config.vmentry_ctrl;
@@ -4392,17 +4483,10 @@ static u32 vmx_vmentry_ctrl(void)
 	if (vmx_pt_mode_is_system())
 		vmentry_ctrl &= ~(VM_ENTRY_PT_CONCEAL_PIP |
 				  VM_ENTRY_LOAD_IA32_RTIT_CTL);
-	/*
-	 * IA32e mode, and loading of EFER and PERF_GLOBAL_CTRL are toggled dynamically.
-	 */
-	vmentry_ctrl &= ~(VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
-			  VM_ENTRY_LOAD_IA32_EFER |
-			  VM_ENTRY_IA32E_MODE);
-
-	if (cpu_has_perf_global_ctrl_bug())
-		vmentry_ctrl &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
-
-	return vmentry_ctrl;
+	 /*
+	  * IA32e mode, and loading of EFER is toggled dynamically.
+	  */
+	return vmentry_ctrl &= ~(VM_ENTRY_LOAD_IA32_EFER | VM_ENTRY_IA32E_MODE);
 }
 
 static u32 vmx_vmexit_ctrl(void)
@@ -4420,12 +4504,8 @@ static u32 vmx_vmexit_ctrl(void)
 		vmexit_ctrl &= ~(VM_EXIT_PT_CONCEAL_PIP |
 				 VM_EXIT_CLEAR_IA32_RTIT_CTL);
 
-	if (cpu_has_perf_global_ctrl_bug())
-		vmexit_ctrl &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
-
-	/* Loading of EFER and PERF_GLOBAL_CTRL are toggled dynamically */
-	return vmexit_ctrl &
-		~(VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL | VM_EXIT_LOAD_IA32_EFER);
+	/* Loading of EFER is toggled dynamically */
+	return vmexit_ctrl & ~VM_EXIT_LOAD_IA32_EFER;
 }
 
 static void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
@@ -4763,6 +4843,7 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 		vmcs_write64(VM_FUNCTION_CONTROL, 0);
 
 	vmcs_write32(VM_EXIT_MSR_STORE_COUNT, 0);
+	vmcs_write64(VM_EXIT_MSR_STORE_ADDR, __pa(vmx->msr_autostore.guest.val));
 	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, 0);
 	vmcs_write64(VM_EXIT_MSR_LOAD_ADDR, __pa(vmx->msr_autoload.host.val));
 	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, 0);
@@ -7865,6 +7946,8 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	else
 		exec_controls_setbit(vmx, CPU_BASED_RDPMC_EXITING);
 
+	vmx_set_perf_global_ctrl(vmx);
+
 	/* Refresh #PF interception to account for MAXPHYADDR changes. */
 	vmx_update_exception_bitmap(vcpu);
 }
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 65786dbe7d60..1b56fac35656 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -504,7 +504,8 @@ static inline u8 vmx_get_rvi(void)
 	       VM_EXIT_LOAD_IA32_EFER |					\
 	       VM_EXIT_CLEAR_BNDCFGS |					\
 	       VM_EXIT_PT_CONCEAL_PIP |					\
-	       VM_EXIT_CLEAR_IA32_RTIT_CTL)
+	       VM_EXIT_CLEAR_IA32_RTIT_CTL |                            \
+	       VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL)
 
 #define KVM_REQUIRED_VMX_PIN_BASED_VM_EXEC_CONTROL			\
 	(PIN_BASED_EXT_INTR_MASK |					\
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

