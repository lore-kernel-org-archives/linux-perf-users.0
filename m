Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A2A29ACFC
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Feb 2026 01:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771032440; cv=none; b=om1IziQ3U7gKeslUN4/Y/5cqFRCXF09JBazNFnFc6on8MFF422JgQve1/6JN7bp6MRRJjlPGifj4tuYnP5J4AsyrZHo6DDISDEaMyYkStlgLe7uE6ATLqk/l3B2mYo+0kPa9ifCv/TbbnxYWgKRQXBpGW8Dk6QohViSnLZTUI9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771032440; c=relaxed/simple;
	bh=/EVryE9KEraeRZcfAjdAXyVVep9IRYm2MBvmK48Hx8s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aqodVl0OdP6DFa9MNdugoaJie6zJBMF/3zblPyHz7IqPbVGfWm8sau6/5lquS5scQHxN/JW3ugSglfq7skEKkyW5Fqju7hxvev7MDBHC0qEet52QNolJ/2DT4Kr2GYc5CbBIv0urkB10gBVEpQ/VplwnnXvyhbFpcIjbZ/U+Hrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CCQoMUPR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CCQoMUPR"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a9638b0422so10487065ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Feb 2026 17:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771032437; x=1771637237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+DBpVUd3qPIKBqituI0MpYpKiFQclysQZsAv6lUaJSc=;
        b=CCQoMUPRXVQojyWut7IIWgXv7JuaFRLLOEwK8U7SKmhwW+lcXolwahsmferyelNTXm
         XkR5H63TxdsCMqQcCrpEwRz/mvfkNoc8dcImt0yYvRtktbIS6UBnS4+c1roobKgp4an0
         hZxDmAeJKPqCdVACLaEBSKUsbV4e6eurISaYxsb/27FszTQvwmo2uCOo/RVfaccjDFfd
         loEKCqaoxvGROHUscMza21W/xmWU/gPsSAt5Scq6cWkPog6nfLFeV3kSn7IMLM6cIKc4
         OfzYcTAToq4cjAjY7LGtDnYKP/3/KrrEdJp9Y8DdYytvlO80Ty05lsJhqMGd+XPAF8qI
         xXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771032437; x=1771637237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DBpVUd3qPIKBqituI0MpYpKiFQclysQZsAv6lUaJSc=;
        b=NEOc4wEt2deKC13ZeArzSfEFkYn6lY1Tsupvu0fFT3C1JLzBB8+7dBfqRJ2GDWxwV8
         rZaQyz9D7swW3ARtD+i5AJqRRPkPjbtiku8/TBWUZ26vhDHq5nsCZqWC1P1ukT0xI1fT
         JdnpaJ6WdK7cwVs+pckP5X2apKDCJaTyzB5hxHwXWPbadqmpmnI20MXsRXW8NRcnt1sp
         8QaLoyjeLQTUMUZZ2QIgj6oPxzqjo6EWzZifxP92n/ktSoknQ0F8q403ap+3cIRT0FO4
         ohFylEySGVO5tjr69ii4CziamKpsf26XFKeo2+NS6LP12otPDCWNtSUWkDznIM8ezjpI
         Ef/g==
X-Forwarded-Encrypted: i=1; AJvYcCUrkYLvRZf/PCf/j4YHzWngBU9lliHCY+Sh38u5K7lI1ryCJy6PBx9D/Uf/vM+LJ6UwpW+hInaDj0UunwNWizy8@vger.kernel.org
X-Gm-Message-State: AOJu0YzylXWgsgL+DFoMBgOIj4H9w6D14Ax+rD7dxn+uPMHOuY+k6QQ+
	VeI94adHM6TE52kYTVlulbal9X14KTBFfHev82+ppcn/6DMZ9J1B43XkvPDlAvIT0Ccrek7mG0t
	XxqT5BQ==
X-Received: from pjbnd8.prod.google.com ([2002:a17:90b:4cc8:b0:356:2c99:c20a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0f:b0:2aa:de68:98c8
 with SMTP id d9443c01a7336-2ad1740c141mr11643275ad.4.1771032436499; Fri, 13
 Feb 2026 17:27:16 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Feb 2026 17:26:52 -0800
In-Reply-To: <20260214012702.2368778-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260214012702.2368778-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260214012702.2368778-7-seanjc@google.com>
Subject: [PATCH v3 06/16] KVM: VMX: Move core VMXON enablement to kernel
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the innermost VMXON+VMXOFF logic out of KVM and into to core x86 so
that TDX can (eventually) force VMXON without having to rely on KVM being
loaded, e.g. to do SEAMCALLs during initialization.

Opportunistically update the comment regarding emergency disabling via NMI
to clarify that virt_rebooting will be set by _another_ emergency callback,
i.e. that virt_rebooting doesn't need to be set before VMCLEAR, only
before _this_ invocation does VMXOFF.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/pt.c  |  1 -
 arch/x86/include/asm/virt.h |  6 +--
 arch/x86/kvm/vmx/vmx.c      | 73 +++----------------------------
 arch/x86/virt/hw.c          | 85 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 92 insertions(+), 73 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 44524a387c58..b5726b50e77d 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1591,7 +1591,6 @@ void intel_pt_handle_vmx(int on)
 
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL_FOR_KVM(intel_pt_handle_vmx);
 
 /*
  * PMU callbacks
diff --git a/arch/x86/include/asm/virt.h b/arch/x86/include/asm/virt.h
index 0da6db4f5b0c..cca0210a5c16 100644
--- a/arch/x86/include/asm/virt.h
+++ b/arch/x86/include/asm/virt.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_VIRT_H
 #define _ASM_X86_VIRT_H
 
-#include <linux/percpu-defs.h>
-
 #include <asm/reboot.h>
 
 #if IS_ENABLED(CONFIG_KVM_X86)
@@ -12,7 +10,9 @@ extern bool virt_rebooting;
 void __init x86_virt_init(void);
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
-DECLARE_PER_CPU(struct vmcs *, root_vmcs);
+int x86_vmx_enable_virtualization_cpu(void);
+int x86_vmx_disable_virtualization_cpu(void);
+void x86_vmx_emergency_disable_virtualization_cpu(void);
 #endif
 
 #else
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e767835a4f3a..36238cc694fd 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -786,41 +786,16 @@ static int vmx_set_guest_uret_msr(struct vcpu_vmx *vmx,
 	return ret;
 }
 
-/*
- * Disable VMX and clear CR4.VMXE (even if VMXOFF faults)
- *
- * Note, VMXOFF causes a #UD if the CPU is !post-VMXON, but it's impossible to
- * atomically track post-VMXON state, e.g. this may be called in NMI context.
- * Eat all faults as all other faults on VMXOFF faults are mode related, i.e.
- * faults are guaranteed to be due to the !post-VMXON check unless the CPU is
- * magically in RM, VM86, compat mode, or at CPL>0.
- */
-static int kvm_cpu_vmxoff(void)
-{
-	asm goto("1: vmxoff\n\t"
-			  _ASM_EXTABLE(1b, %l[fault])
-			  ::: "cc", "memory" : fault);
-
-	cr4_clear_bits(X86_CR4_VMXE);
-	return 0;
-
-fault:
-	cr4_clear_bits(X86_CR4_VMXE);
-	return -EIO;
-}
-
 void vmx_emergency_disable_virtualization_cpu(void)
 {
 	int cpu = raw_smp_processor_id();
 	struct loaded_vmcs *v;
 
-	virt_rebooting = true;
-
 	/*
 	 * Note, CR4.VMXE can be _cleared_ in NMI context, but it can only be
-	 * set in task context.  If this races with VMX is disabled by an NMI,
-	 * VMCLEAR and VMXOFF may #UD, but KVM will eat those faults due to
-	 * virt_rebooting set.
+	 * set in task context.  If this races with _another_ emergency call
+	 * from NMI context, VMCLEAR may #UD, but KVM will eat those faults due
+	 * to virt_rebooting being set by the interrupting NMI callback.
 	 */
 	if (!(__read_cr4() & X86_CR4_VMXE))
 		return;
@@ -832,7 +807,7 @@ void vmx_emergency_disable_virtualization_cpu(void)
 			vmcs_clear(v->shadow_vmcs);
 	}
 
-	kvm_cpu_vmxoff();
+	x86_vmx_emergency_disable_virtualization_cpu();
 }
 
 static void __loaded_vmcs_clear(void *arg)
@@ -2988,34 +2963,9 @@ int vmx_check_processor_compat(void)
 	return 0;
 }
 
-static int kvm_cpu_vmxon(u64 vmxon_pointer)
-{
-	u64 msr;
-
-	cr4_set_bits(X86_CR4_VMXE);
-
-	asm goto("1: vmxon %[vmxon_pointer]\n\t"
-			  _ASM_EXTABLE(1b, %l[fault])
-			  : : [vmxon_pointer] "m"(vmxon_pointer)
-			  : : fault);
-	return 0;
-
-fault:
-	WARN_ONCE(1, "VMXON faulted, MSR_IA32_FEAT_CTL (0x3a) = 0x%llx\n",
-		  rdmsrq_safe(MSR_IA32_FEAT_CTL, &msr) ? 0xdeadbeef : msr);
-	cr4_clear_bits(X86_CR4_VMXE);
-
-	return -EFAULT;
-}
-
 int vmx_enable_virtualization_cpu(void)
 {
 	int cpu = raw_smp_processor_id();
-	u64 phys_addr = __pa(per_cpu(root_vmcs, cpu));
-	int r;
-
-	if (cr4_read_shadow() & X86_CR4_VMXE)
-		return -EBUSY;
 
 	/*
 	 * This can happen if we hot-added a CPU but failed to allocate
@@ -3024,15 +2974,7 @@ int vmx_enable_virtualization_cpu(void)
 	if (kvm_is_using_evmcs() && !hv_get_vp_assist_page(cpu))
 		return -EFAULT;
 
-	intel_pt_handle_vmx(1);
-
-	r = kvm_cpu_vmxon(phys_addr);
-	if (r) {
-		intel_pt_handle_vmx(0);
-		return r;
-	}
-
-	return 0;
+	return x86_vmx_enable_virtualization_cpu();
 }
 
 static void vmclear_local_loaded_vmcss(void)
@@ -3049,12 +2991,9 @@ void vmx_disable_virtualization_cpu(void)
 {
 	vmclear_local_loaded_vmcss();
 
-	if (kvm_cpu_vmxoff())
-		kvm_spurious_fault();
+	x86_vmx_disable_virtualization_cpu();
 
 	hv_reset_evmcs();
-
-	intel_pt_handle_vmx(0);
 }
 
 struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags)
diff --git a/arch/x86/virt/hw.c b/arch/x86/virt/hw.c
index 40495872fdfb..dc426c2bc24a 100644
--- a/arch/x86/virt/hw.c
+++ b/arch/x86/virt/hw.c
@@ -15,8 +15,89 @@ __visible bool virt_rebooting;
 EXPORT_SYMBOL_FOR_KVM(virt_rebooting);
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
-DEFINE_PER_CPU(struct vmcs *, root_vmcs);
-EXPORT_PER_CPU_SYMBOL(root_vmcs);
+static DEFINE_PER_CPU(struct vmcs *, root_vmcs);
+
+static int x86_virt_cpu_vmxon(void)
+{
+	u64 vmxon_pointer = __pa(per_cpu(root_vmcs, raw_smp_processor_id()));
+	u64 msr;
+
+	cr4_set_bits(X86_CR4_VMXE);
+
+	asm goto("1: vmxon %[vmxon_pointer]\n\t"
+			  _ASM_EXTABLE(1b, %l[fault])
+			  : : [vmxon_pointer] "m"(vmxon_pointer)
+			  : : fault);
+	return 0;
+
+fault:
+	WARN_ONCE(1, "VMXON faulted, MSR_IA32_FEAT_CTL (0x3a) = 0x%llx\n",
+		  rdmsrq_safe(MSR_IA32_FEAT_CTL, &msr) ? 0xdeadbeef : msr);
+	cr4_clear_bits(X86_CR4_VMXE);
+
+	return -EFAULT;
+}
+
+int x86_vmx_enable_virtualization_cpu(void)
+{
+	int r;
+
+	if (cr4_read_shadow() & X86_CR4_VMXE)
+		return -EBUSY;
+
+	intel_pt_handle_vmx(1);
+
+	r = x86_virt_cpu_vmxon();
+	if (r) {
+		intel_pt_handle_vmx(0);
+		return r;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_KVM(x86_vmx_enable_virtualization_cpu);
+
+/*
+ * Disable VMX and clear CR4.VMXE (even if VMXOFF faults)
+ *
+ * Note, VMXOFF causes a #UD if the CPU is !post-VMXON, but it's impossible to
+ * atomically track post-VMXON state, e.g. this may be called in NMI context.
+ * Eat all faults as all other faults on VMXOFF faults are mode related, i.e.
+ * faults are guaranteed to be due to the !post-VMXON check unless the CPU is
+ * magically in RM, VM86, compat mode, or at CPL>0.
+ */
+int x86_vmx_disable_virtualization_cpu(void)
+{
+	int r = -EIO;
+
+	asm goto("1: vmxoff\n\t"
+		 _ASM_EXTABLE(1b, %l[fault])
+		 ::: "cc", "memory" : fault);
+	r = 0;
+
+fault:
+	cr4_clear_bits(X86_CR4_VMXE);
+	intel_pt_handle_vmx(0);
+	return r;
+}
+EXPORT_SYMBOL_FOR_KVM(x86_vmx_disable_virtualization_cpu);
+
+void x86_vmx_emergency_disable_virtualization_cpu(void)
+{
+	virt_rebooting = true;
+
+	/*
+	 * Note, CR4.VMXE can be _cleared_ in NMI context, but it can only be
+	 * set in task context.  If this races with _another_ emergency call
+	 * from NMI context, VMXOFF may #UD, but kernel will eat those faults
+	 * due to virt_rebooting being set by the interrupting NMI callback.
+	 */
+	if (!(__read_cr4() & X86_CR4_VMXE))
+		return;
+
+	x86_vmx_disable_virtualization_cpu();
+}
+EXPORT_SYMBOL_FOR_KVM(x86_vmx_emergency_disable_virtualization_cpu);
 
 static __init void x86_vmx_exit(void)
 {
-- 
2.53.0.310.g728cabbaf7-goog

