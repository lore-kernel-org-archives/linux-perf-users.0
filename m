Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABB828DB49
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Feb 2026 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771032440; cv=none; b=WKmtd6eBQKYN4YQVynYJsKpvfdY/tdDxRA83gzLrBuS0oDALYtDe2iQ4wM/LpFVs9Dp00JMYOQOEDBloO1pDoibo4fUGw3VWl54egkhVB8zCCGKUNnotH7TzRxdol1DMXtomKVKNYaiPJyQhuKtTUZ8VRp2k3gLwZH6IsapHeho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771032440; c=relaxed/simple;
	bh=kfZ1Zz3kqt0Lijh2yW8pjFnNAWPf0J1gDLwcJsJYrSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jQp2zAdAnWUv3HJsePs7+n264oYZilNmg4faHpLp7sZ5nXEuqOsA78ETRAvRTHNG326MGS6dnnUQROPdeSyJaprj/zJUzeBQmuLIcTarMnr94zOWMfbgwBSulGYU/kT7RfdnGVVgoiVA2EjiSL2cxtgXJXV1GEf8P6kmAl2FHd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dt1vt/HZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dt1vt/HZ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354c65f69edso1752821a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Feb 2026 17:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771032438; x=1771637238; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=g0hBl26w79lKn400XYX8NYrJRLqwtNFM7RMEsJBIMT0=;
        b=Dt1vt/HZiSNqdOpZWvHv5ibJ5IFAnUhAUzO58NQINehJzOl6o4MQ360JM7U/a5w9Di
         4Dm5Zs6N8hJ28cZE4q77wFASLNdLSOVV34c8y6+wDzrbKHcDsDVPkZ2i+8oe9FBofkKg
         6KxUvp6tkK3zLcNSOVK1d0033JXfuSbflB6r5qEre8m7rKvzqDGykWJE3w9ubf39fi7z
         3mHMw4JCehAIQa9fsDyFUjhcQLkr4MGZ0a1VXOfyK5tMMD04RMDIDdSf+9XEbNIDHamN
         ZYm6pXSxM8XPvXmunEvOXLJdalFWLUbdizDHEPbomTM4dKlbxyNKpI0r5Ii58MCKPq17
         NTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771032438; x=1771637238;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0hBl26w79lKn400XYX8NYrJRLqwtNFM7RMEsJBIMT0=;
        b=gVoQGcJ/K8ccWQ+EeewGo0qk1+z1yziIGoVoZTzzdH/NJqQuBb1X8WcwUUlwept2PA
         kbjXfsc3DwhYGT5xb2bhsi1tURzEttpi+VbInKH8How17VkmlcAFuVu4BgRhjvDXjz/5
         rzX0whHOZIYX6FRUe/yWnLom0g7mKAYfVI+mr1bIDVHZZlZyRarLcEAa1ar3UEdsy3YQ
         gKu8uvofrTz8PijKFZ4TO1fZkCCRc1izKUEoq53bFypp1R3VqNjPr9pf6RuRsICyu0Uu
         jdNik5/R5t5w4mG67+asxH8yp5/ohtLopOfUF+KeZcdBq/SHN9jeW2VIReafef0igMLt
         fhMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0APzhMbRKQgNt9o2tiSrc+kRbIL+tRQMRnA+1fL9RTRrd58SslhqDSFNlJbYvCmfNXpXj1Rhv3qIHdCURtGgl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8XGpUzEZVx3bi9uanHyEv45XsJd2o3U3ZlP0Dy8i4Zwkm5Me0
	5IGfJ5bA8rCSPlaV8sb2xF6ElkOTGR8hO7rNTo/51Xf3BkXOc7Yf8UPBvY8Tc2Zm4R5qiMv7mB5
	o8RNMjA==
X-Received: from pjbpx8.prod.google.com ([2002:a17:90b:2708:b0:356:a274:747f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2784:b0:343:684c:f8a0
 with SMTP id 98e67ed59e1d1-356aad5f32fmr3636333a91.23.1771032438229; Fri, 13
 Feb 2026 17:27:18 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Feb 2026 17:26:53 -0800
In-Reply-To: <20260214012702.2368778-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260214012702.2368778-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260214012702.2368778-8-seanjc@google.com>
Subject: [PATCH v3 07/16] KVM: SVM: Move core EFER.SVME enablement to kernel
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

Move the innermost EFER.SVME logic out of KVM and into to core x86 to land
the SVM support alongside VMX support.  This will allow providing a more
unified API from the kernel to KVM, and will allow moving the bulk of the
emergency disabling insanity out of KVM without having a weird split
between kernel and KVM for SVM vs. VMX.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/virt.h |  6 +++++
 arch/x86/kvm/svm/svm.c      | 33 +++++------------------
 arch/x86/virt/hw.c          | 53 +++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/virt.h b/arch/x86/include/asm/virt.h
index cca0210a5c16..9a0753eaa20c 100644
--- a/arch/x86/include/asm/virt.h
+++ b/arch/x86/include/asm/virt.h
@@ -15,6 +15,12 @@ int x86_vmx_disable_virtualization_cpu(void);
 void x86_vmx_emergency_disable_virtualization_cpu(void);
 #endif
 
+#if IS_ENABLED(CONFIG_KVM_AMD)
+int x86_svm_enable_virtualization_cpu(void);
+int x86_svm_disable_virtualization_cpu(void);
+void x86_svm_emergency_disable_virtualization_cpu(void);
+#endif
+
 #else
 static __always_inline void x86_virt_init(void) {}
 #endif
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0ae66c770ebc..5f033bf3ba83 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -478,27 +478,9 @@ static __always_inline struct sev_es_save_area *sev_es_host_save_area(struct svm
 	return &sd->save_area->host_sev_es_save;
 }
 
-static inline void kvm_cpu_svm_disable(void)
-{
-	uint64_t efer;
-
-	wrmsrq(MSR_VM_HSAVE_PA, 0);
-	rdmsrq(MSR_EFER, efer);
-	if (efer & EFER_SVME) {
-		/*
-		 * Force GIF=1 prior to disabling SVM, e.g. to ensure INIT and
-		 * NMI aren't blocked.
-		 */
-		stgi();
-		wrmsrq(MSR_EFER, efer & ~EFER_SVME);
-	}
-}
-
 static void svm_emergency_disable_virtualization_cpu(void)
 {
-	virt_rebooting = true;
-
-	kvm_cpu_svm_disable();
+	wrmsrq(MSR_VM_HSAVE_PA, 0);
 }
 
 static void svm_disable_virtualization_cpu(void)
@@ -507,7 +489,7 @@ static void svm_disable_virtualization_cpu(void)
 	if (tsc_scaling)
 		__svm_write_tsc_multiplier(SVM_TSC_RATIO_DEFAULT);
 
-	kvm_cpu_svm_disable();
+	x86_svm_disable_virtualization_cpu();
 
 	amd_pmu_disable_virt();
 }
@@ -516,12 +498,12 @@ static int svm_enable_virtualization_cpu(void)
 {
 
 	struct svm_cpu_data *sd;
-	uint64_t efer;
 	int me = raw_smp_processor_id();
+	int r;
 
-	rdmsrq(MSR_EFER, efer);
-	if (efer & EFER_SVME)
-		return -EBUSY;
+	r = x86_svm_enable_virtualization_cpu();
+	if (r)
+		return r;
 
 	sd = per_cpu_ptr(&svm_data, me);
 	sd->asid_generation = 1;
@@ -529,8 +511,6 @@ static int svm_enable_virtualization_cpu(void)
 	sd->next_asid = sd->max_asid + 1;
 	sd->min_asid = max_sev_asid + 1;
 
-	wrmsrq(MSR_EFER, efer | EFER_SVME);
-
 	wrmsrq(MSR_VM_HSAVE_PA, sd->save_area_pa);
 
 	if (static_cpu_has(X86_FEATURE_TSCRATEMSR)) {
@@ -541,7 +521,6 @@ static int svm_enable_virtualization_cpu(void)
 		__svm_write_tsc_multiplier(SVM_TSC_RATIO_DEFAULT);
 	}
 
-
 	/*
 	 * Get OSVW bits.
 	 *
diff --git a/arch/x86/virt/hw.c b/arch/x86/virt/hw.c
index dc426c2bc24a..014e9dfab805 100644
--- a/arch/x86/virt/hw.c
+++ b/arch/x86/virt/hw.c
@@ -163,6 +163,59 @@ static __init int x86_vmx_init(void)
 static __init int x86_vmx_init(void) { return -EOPNOTSUPP; }
 #endif
 
+#if IS_ENABLED(CONFIG_KVM_AMD)
+int x86_svm_enable_virtualization_cpu(void)
+{
+	u64 efer;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SVM))
+		return -EOPNOTSUPP;
+
+	rdmsrq(MSR_EFER, efer);
+	if (efer & EFER_SVME)
+		return -EBUSY;
+
+	wrmsrq(MSR_EFER, efer | EFER_SVME);
+	return 0;
+}
+EXPORT_SYMBOL_FOR_KVM(x86_svm_enable_virtualization_cpu);
+
+int x86_svm_disable_virtualization_cpu(void)
+{
+	int r = -EIO;
+	u64 efer;
+
+	/*
+	 * Force GIF=1 prior to disabling SVM, e.g. to ensure INIT and
+	 * NMI aren't blocked.
+	 */
+	asm goto("1: stgi\n\t"
+		 _ASM_EXTABLE(1b, %l[fault])
+		 ::: "memory" : fault);
+	r = 0;
+
+fault:
+	rdmsrq(MSR_EFER, efer);
+	wrmsrq(MSR_EFER, efer & ~EFER_SVME);
+	return r;
+}
+EXPORT_SYMBOL_FOR_KVM(x86_svm_disable_virtualization_cpu);
+
+void x86_svm_emergency_disable_virtualization_cpu(void)
+{
+	u64 efer;
+
+	virt_rebooting = true;
+
+	rdmsrq(MSR_EFER, efer);
+	if (!(efer & EFER_SVME))
+		return;
+
+	x86_svm_disable_virtualization_cpu();
+}
+EXPORT_SYMBOL_FOR_KVM(x86_svm_emergency_disable_virtualization_cpu);
+#endif
+
 void __init x86_virt_init(void)
 {
 	x86_vmx_init();
-- 
2.53.0.310.g728cabbaf7-goog

