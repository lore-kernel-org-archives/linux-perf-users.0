Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FAE2C0285
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Feb 2026 01:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771032448; cv=none; b=Ci6FxuooRVixQ8uSLqKwv9xm+7jjz2vHyGG0xAQGJhV1P6d6fKfse6i+cEV1O1cZe3H1DdBPKG3mHmjuXB3ZmxlSLpmJmmT949VrXt4nArMpX55dgCEEmio3sR7z0hCHOiXfRnZvFCV+b4Grb5t1i2oP7cjK56h45cmVnN7HzQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771032448; c=relaxed/simple;
	bh=iPXfIO7K+KW2+1Ao6Y3aG8DSZZi+oj+CTe/chHK4iYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jrZP1azxU4Ns3bnCSUD5RrB0evpHGA6vvyBJIjK5qBabLeSJmCk+gbNLQJSWQNmwRMkLbcWDLWYKZsB/3xhZ8NRFj/UTq5O/qsWcpk/C47/PZb/DvXhbibaM7wt0k0zzJySyUYWIseZ+CwAE4033mlAZ+vNre9vJ/iUfJ1m9vb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g9FQNT3o; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g9FQNT3o"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aaf2f3bef6so18030225ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Feb 2026 17:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771032442; x=1771637242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ryx4LNHhCx13BXADixN3R43oN7W3jye5PV09KGYh1o=;
        b=g9FQNT3o+OVraA4G2DNBhxG6hohm9bbQs+TEsoqFyWndIp++HBz/P1brDZG/FHWoTV
         dRThohkW+XTvE0Onz0DLq5mNkMFTEA4Idyb0Hb5pMBgqEP7HAYUPQt9YcaiiEMmboyzy
         UGFUUpwIl8vuiqKzZlyAmN5y2P9+fKdh1v1iTy3oHFBfnGWpho8UBS/CTW5QfcbLI54Y
         UTU+0hGS4bpNFD7z6AyaQK/AXy711yf4JptXeVN49YdtjHYtkUpuNXgT0D1qAOJ6QHsH
         KMzBDe/llqIrpY7bij5vyDz/fgKghc8ePPnJrXT8KlZKObPqTwbxZQTu9Xe3UocuDSRV
         Kn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771032442; x=1771637242;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ryx4LNHhCx13BXADixN3R43oN7W3jye5PV09KGYh1o=;
        b=iTu+bj/rIi980Je5CGE9j+2SGwGeOpUm+6PrAl9Yri82QlG/TCSysUxmoPrG/POyXp
         jRX6SQkFj8AG3ig7/+ic7YKFDcSihrTph5FMI173B8bRf0ZY07a7HAR9O0vBXr9JjtZc
         iMavjdE43KaWKSzFurUtgQkK1fQRxgu0lSY1GmIAgdd2RnG206/q/v/okiOSHb+DzEGu
         9Fo/Q29dZ6J65JMmvFNPkmUSRD4w7Nt5298Jz/IMe+TRlvtcOu52zBtReMLIJTrW9ZD2
         dd0rOQZrlFmD2468UDwzJGj7LaNXf/nYs3ZKWgsAVPsCcUzkhhx8p/TdakrMFFlETiFG
         36ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVhO4v/5KFZWDvyILEfcGmsok9uOWiDZlQDnF03KLRGaPtIxKjBiXryCoyHMcNAsAfxkMgYCA97n8aeyRefwG3b@vger.kernel.org
X-Gm-Message-State: AOJu0YwSBU/Yj7Kz8Ttof+R7lk91G2KV0c73qKPmoYUoMrpFOgN/pcKR
	a3//ZNOyqPzovl/bJToCS6d1FHX7EXsWexHn3OcG4MFBfFiY9XjnaNcAOR87ndJKyRU3zZr8eQg
	Vv4xzAg==
X-Received: from pjbsr6.prod.google.com ([2002:a17:90b:4e86:b0:354:c477:4601])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c401:b0:2a0:97d2:a264
 with SMTP id d9443c01a7336-2ad174f4c21mr14586945ad.37.1771032441603; Fri, 13
 Feb 2026 17:27:21 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Feb 2026 17:26:55 -0800
In-Reply-To: <20260214012702.2368778-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260214012702.2368778-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260214012702.2368778-10-seanjc@google.com>
Subject: [PATCH v3 09/16] x86/virt: Add refcounting of VMX/SVM usage to
 support multiple in-kernel users
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

Implement a per-CPU refcounting scheme so that "users" of hardware
virtualization, e.g. KVM and the future TDX code, can co-exist without
pulling the rug out from under each other.  E.g. if KVM were to disable
VMX on module unload or when the last KVM VM was destroyed, SEAMCALLs from
the TDX subsystem would #UD and panic the kernel.

Disable preemption in the get/put APIs to ensure virtualization is fully
enabled/disabled before returning to the caller.  E.g. if the task were
preempted after a 0=>1 transition, the new task would see a 1=>2 and thus
return without enabling virtualization.  Explicitly disable preemption
instead of requiring the caller to do so, because the need to disable
preemption is an artifact of the implementation.  E.g. from KVM's
perspective there is no _need_ to disable preemption as KVM guarantees the
pCPU on which it is running is stable (but preemption is enabled).

Opportunistically abstract away SVM vs. VMX in the public APIs by using
X86_FEATURE_{SVM,VMX} to communicate what technology the caller wants to
enable and use.

Cc: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/virt.h | 11 ++-----
 arch/x86/kvm/svm/svm.c      |  4 +--
 arch/x86/kvm/vmx/vmx.c      |  4 +--
 arch/x86/virt/hw.c          | 64 +++++++++++++++++++++++++++----------
 4 files changed, 53 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/virt.h b/arch/x86/include/asm/virt.h
index 2c35534437e0..1558a0673d06 100644
--- a/arch/x86/include/asm/virt.h
+++ b/arch/x86/include/asm/virt.h
@@ -11,15 +11,8 @@ extern bool virt_rebooting;
 
 void __init x86_virt_init(void);
 
-#if IS_ENABLED(CONFIG_KVM_INTEL)
-int x86_vmx_enable_virtualization_cpu(void);
-int x86_vmx_disable_virtualization_cpu(void);
-#endif
-
-#if IS_ENABLED(CONFIG_KVM_AMD)
-int x86_svm_enable_virtualization_cpu(void);
-int x86_svm_disable_virtualization_cpu(void);
-#endif
+int x86_virt_get_ref(int feat);
+void x86_virt_put_ref(int feat);
 
 int x86_virt_emergency_disable_virtualization_cpu(void);
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5f033bf3ba83..539fb4306dce 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -489,7 +489,7 @@ static void svm_disable_virtualization_cpu(void)
 	if (tsc_scaling)
 		__svm_write_tsc_multiplier(SVM_TSC_RATIO_DEFAULT);
 
-	x86_svm_disable_virtualization_cpu();
+	x86_virt_put_ref(X86_FEATURE_SVM);
 
 	amd_pmu_disable_virt();
 }
@@ -501,7 +501,7 @@ static int svm_enable_virtualization_cpu(void)
 	int me = raw_smp_processor_id();
 	int r;
 
-	r = x86_svm_enable_virtualization_cpu();
+	r = x86_virt_get_ref(X86_FEATURE_SVM);
 	if (r)
 		return r;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c02fd7e91809..6200cf4dbd26 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2963,7 +2963,7 @@ int vmx_enable_virtualization_cpu(void)
 	if (kvm_is_using_evmcs() && !hv_get_vp_assist_page(cpu))
 		return -EFAULT;
 
-	return x86_vmx_enable_virtualization_cpu();
+	return x86_virt_get_ref(X86_FEATURE_VMX);
 }
 
 static void vmclear_local_loaded_vmcss(void)
@@ -2980,7 +2980,7 @@ void vmx_disable_virtualization_cpu(void)
 {
 	vmclear_local_loaded_vmcss();
 
-	x86_vmx_disable_virtualization_cpu();
+	x86_virt_put_ref(X86_FEATURE_VMX);
 
 	hv_reset_evmcs();
 }
diff --git a/arch/x86/virt/hw.c b/arch/x86/virt/hw.c
index 73c8309ba3fb..c898f16fe612 100644
--- a/arch/x86/virt/hw.c
+++ b/arch/x86/virt/hw.c
@@ -13,6 +13,8 @@
 
 struct x86_virt_ops {
 	int feature;
+	int (*enable_virtualization_cpu)(void);
+	int (*disable_virtualization_cpu)(void);
 	void (*emergency_disable_virtualization_cpu)(void);
 };
 static struct x86_virt_ops virt_ops __ro_after_init;
@@ -20,6 +22,8 @@ static struct x86_virt_ops virt_ops __ro_after_init;
 __visible bool virt_rebooting;
 EXPORT_SYMBOL_FOR_KVM(virt_rebooting);
 
+static DEFINE_PER_CPU(int, virtualization_nr_users);
+
 static cpu_emergency_virt_cb __rcu *kvm_emergency_callback;
 
 void x86_virt_register_emergency_callback(cpu_emergency_virt_cb *callback)
@@ -74,13 +78,10 @@ static int x86_virt_cpu_vmxon(void)
 	return -EFAULT;
 }
 
-int x86_vmx_enable_virtualization_cpu(void)
+static int x86_vmx_enable_virtualization_cpu(void)
 {
 	int r;
 
-	if (virt_ops.feature != X86_FEATURE_VMX)
-		return -EOPNOTSUPP;
-
 	if (cr4_read_shadow() & X86_CR4_VMXE)
 		return -EBUSY;
 
@@ -94,7 +95,6 @@ int x86_vmx_enable_virtualization_cpu(void)
 
 	return 0;
 }
-EXPORT_SYMBOL_FOR_KVM(x86_vmx_enable_virtualization_cpu);
 
 /*
  * Disable VMX and clear CR4.VMXE (even if VMXOFF faults)
@@ -105,7 +105,7 @@ EXPORT_SYMBOL_FOR_KVM(x86_vmx_enable_virtualization_cpu);
  * faults are guaranteed to be due to the !post-VMXON check unless the CPU is
  * magically in RM, VM86, compat mode, or at CPL>0.
  */
-int x86_vmx_disable_virtualization_cpu(void)
+static int x86_vmx_disable_virtualization_cpu(void)
 {
 	int r = -EIO;
 
@@ -119,7 +119,6 @@ int x86_vmx_disable_virtualization_cpu(void)
 	intel_pt_handle_vmx(0);
 	return r;
 }
-EXPORT_SYMBOL_FOR_KVM(x86_vmx_disable_virtualization_cpu);
 
 static void x86_vmx_emergency_disable_virtualization_cpu(void)
 {
@@ -154,6 +153,8 @@ static __init int __x86_vmx_init(void)
 {
 	const struct x86_virt_ops vmx_ops = {
 		.feature = X86_FEATURE_VMX,
+		.enable_virtualization_cpu = x86_vmx_enable_virtualization_cpu,
+		.disable_virtualization_cpu = x86_vmx_disable_virtualization_cpu,
 		.emergency_disable_virtualization_cpu = x86_vmx_emergency_disable_virtualization_cpu,
 	};
 
@@ -212,13 +213,10 @@ static __init void x86_vmx_exit(void) { }
 #endif
 
 #if IS_ENABLED(CONFIG_KVM_AMD)
-int x86_svm_enable_virtualization_cpu(void)
+static int x86_svm_enable_virtualization_cpu(void)
 {
 	u64 efer;
 
-	if (virt_ops.feature != X86_FEATURE_SVM)
-		return -EOPNOTSUPP;
-
 	rdmsrq(MSR_EFER, efer);
 	if (efer & EFER_SVME)
 		return -EBUSY;
@@ -226,9 +224,8 @@ int x86_svm_enable_virtualization_cpu(void)
 	wrmsrq(MSR_EFER, efer | EFER_SVME);
 	return 0;
 }
-EXPORT_SYMBOL_FOR_KVM(x86_svm_enable_virtualization_cpu);
 
-int x86_svm_disable_virtualization_cpu(void)
+static int x86_svm_disable_virtualization_cpu(void)
 {
 	int r = -EIO;
 	u64 efer;
@@ -247,7 +244,6 @@ int x86_svm_disable_virtualization_cpu(void)
 	wrmsrq(MSR_EFER, efer & ~EFER_SVME);
 	return r;
 }
-EXPORT_SYMBOL_FOR_KVM(x86_svm_disable_virtualization_cpu);
 
 static void x86_svm_emergency_disable_virtualization_cpu(void)
 {
@@ -268,6 +264,8 @@ static __init int x86_svm_init(void)
 {
 	const struct x86_virt_ops svm_ops = {
 		.feature = X86_FEATURE_SVM,
+		.enable_virtualization_cpu = x86_svm_enable_virtualization_cpu,
+		.disable_virtualization_cpu = x86_svm_disable_virtualization_cpu,
 		.emergency_disable_virtualization_cpu = x86_svm_emergency_disable_virtualization_cpu,
 	};
 
@@ -281,6 +279,41 @@ static __init int x86_svm_init(void)
 static __init int x86_svm_init(void) { return -EOPNOTSUPP; }
 #endif
 
+int x86_virt_get_ref(int feat)
+{
+	int r;
+
+	/* Ensure the !feature check can't get false positives. */
+	BUILD_BUG_ON(!X86_FEATURE_SVM || !X86_FEATURE_VMX);
+
+	if (!virt_ops.feature || virt_ops.feature != feat)
+		return -EOPNOTSUPP;
+
+	guard(preempt)();
+
+	if (this_cpu_inc_return(virtualization_nr_users) > 1)
+		return 0;
+
+	r = virt_ops.enable_virtualization_cpu();
+	if (r)
+		WARN_ON_ONCE(this_cpu_dec_return(virtualization_nr_users));
+
+	return r;
+}
+EXPORT_SYMBOL_FOR_KVM(x86_virt_get_ref);
+
+void x86_virt_put_ref(int feat)
+{
+	guard(preempt)();
+
+	if (WARN_ON_ONCE(!this_cpu_read(virtualization_nr_users)) ||
+	    this_cpu_dec_return(virtualization_nr_users))
+		return;
+
+	BUG_ON(virt_ops.disable_virtualization_cpu() && !virt_rebooting);
+}
+EXPORT_SYMBOL_FOR_KVM(x86_virt_put_ref);
+
 /*
  * Disable virtualization, i.e. VMX or SVM, to ensure INIT is recognized during
  * reboot.  VMX blocks INIT if the CPU is post-VMXON, and SVM blocks INIT if
@@ -288,9 +321,6 @@ static __init int x86_svm_init(void) { return -EOPNOTSUPP; }
  */
 int x86_virt_emergency_disable_virtualization_cpu(void)
 {
-	/* Ensure the !feature check can't get false positives. */
-	BUILD_BUG_ON(!X86_FEATURE_SVM || !X86_FEATURE_VMX);
-
 	if (!virt_ops.feature)
 		return -EOPNOTSUPP;
 
-- 
2.53.0.310.g728cabbaf7-goog

