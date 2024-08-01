Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3117314AD38
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 04:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488393; cv=none; b=e78edQrlj9TzLieMb1/+d2hMuX/36HeNEPv5D+1vDNsDovJdAzRLLMTzIPkagfhX1IKaIzMqKmoI24gOrUtCR9080oU6OdtLbcyG4AVSMmcVZ+EYh7dCGCylk1VKZIIOVjjxsATSEOvnw3G+u6efAMMBYFKflUcgZU1Hqq+DMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488393; c=relaxed/simple;
	bh=i+iKXS4OaJEBodpsWYy3FtgcOpXsnTrgmVcFte6q7sU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ioo+WYyowZs1CoUws6tjpDmMY9wS/kulduwF+556AUUy/UJGEO6WtkP1HczKOcbzMpHMN8fb3BrWR1MPHYjo7fGSY3SCHXfJREqUMnKIgqd4ARC+xokBvRlZiDlYCJbWKHtisc5UciyZw5/LZLqo6e4G1EkqRi+GDBWu38GQgUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MXwuBvJ2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MXwuBvJ2"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7b696999c65so150096a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 21:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488392; x=1723093192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Nlv85ewzW2qIefav1CarrlFlRBn2irhgWxbrOUVK3qI=;
        b=MXwuBvJ2j/hgbuWaE8eR6KWW+URs4AJQxUP4GFxDFz3mrbgXciu7yiBpgfs9VPTkLW
         dPc/3YBijyy58v4/pDkdWfH4U0HjUx5YxpmLg9BZB6/gl59cys96uDyjMexLZT1ukwFK
         LNkAOhmCsTU9EQ3qEFfEi8PvhIiDFWWoq7xWTBMA9lgQ2gGHaWylAZ/ioxiicaqf+xIg
         H07LqMVGK5r3RkxIXxGaWSm9xZbZWdsOwt9RGVN4jbyJV1nE0NEBhEYihCA/2ZUGvKW8
         TY+qWxSLhJB2QHNeHcRJIitnl9ONZ+LrKIniJlk85RSmdHLnkCKuqYDdzOE89nvdVVF/
         agMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488392; x=1723093192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nlv85ewzW2qIefav1CarrlFlRBn2irhgWxbrOUVK3qI=;
        b=LuHWbJDxFLs1k5muWESSL3bCIKRSA2Z2CDLGS6pQ05LxM15cULXE8g26Xkdv18L3iD
         Uq93jaAKCUGF64UtQJWjMuDgtBffKo+Dno50S37hZWd92T/99r4j3ReLlMNFR4lkDMtl
         bIpQkxq9fQX6LZjEF2GZ5kZDaaTfNumCZ2SlaT2spVw7gnRADCfsuY0EKV6mGWeexo7h
         m+V/eb5DRXANQqqH/e2sxXe3HmbFgKxzPpJFRKfnESUkIalvkS0+H2XQPCX4UCVBaNWP
         3HrEQkqYSKEd37CfCSd2nG7q2nrdAoqC67p8hspVPBlzRO9dEN2ifZXa6BlijQf48Kyd
         EY6A==
X-Forwarded-Encrypted: i=1; AJvYcCX3a1S6gRC7IShOoJUKltAFarobPFZoyTQH/E/HCYIeFZtDiVW6ohKKqD3WvRTBpzU79GmNMRBaCGS6xbjT/iOwW5VDnhhl2BWLVUmz7ij/3w==
X-Gm-Message-State: AOJu0YzEo9JpElrtpfipKHM9DSp9LdqA8gL3wnpBLjCyL9lUF7BaQxXX
	iOSs6rMeAlri9MxLGMataEn9J6RP5QWi7xfFpYhb7CZCA2ZUloEMzXSPY7Cpl7xXqKcb+WPseeX
	OU8Ga0A==
X-Google-Smtp-Source: AGHT+IFZ49mLHiqlUlHM39yjLzPb9I3pfDZn0rW5d2UkwB7f/PM+pZci+lS82tm5+kMsHtKKKRxeQImasO02
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a05:6a02:59b:b0:660:d635:147b with SMTP id
 41be03b00d2f7-7b636ac2440mr2376a12.11.1722488391411; Wed, 31 Jul 2024
 21:59:51 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:31 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-23-mizhang@google.com>
Subject: [RFC PATCH v3 22/58] KVM: x86/pmu: Add host_perf_cap and initialize
 it in kvm_x86_vendor_init()
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

Initialize host_perf_cap early in kvm_x86_vendor_init(). This helps KVM
recognize the HW PMU capability against its guest VMs.  This awareness
directly decides the feasibility of passing through RDPMC and indirectly
affects the performance in PMU context switch. Having the host PMU feature
set cached in host_perf_cap saves a rdmsrl() to IA32_PERF_CAPABILITY MSR on
each PMU context switch.

In addition, just opportunistically remove the host_perf_cap initialization
in vmx_get_perf_capabilities() so the value is not dependent on module
parameter "enable_pmu".

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
---
 arch/x86/kvm/pmu.h     | 1 +
 arch/x86/kvm/vmx/vmx.c | 4 ----
 arch/x86/kvm/x86.c     | 6 ++++++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 56ba0772568c..e041c8a23e2f 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -295,4 +295,5 @@ bool is_vmware_backdoor_pmc(u32 pmc_idx);
 
 extern struct kvm_pmu_ops intel_pmu_ops;
 extern struct kvm_pmu_ops amd_pmu_ops;
+extern u64 __read_mostly host_perf_cap;
 #endif /* __KVM_X86_PMU_H */
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2ad122995f11..4d60a8cf2dd1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7918,14 +7918,10 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 static __init u64 vmx_get_perf_capabilities(void)
 {
 	u64 perf_cap = PMU_CAP_FW_WRITES;
-	u64 host_perf_cap = 0;
 
 	if (!enable_pmu)
 		return 0;
 
-	if (boot_cpu_has(X86_FEATURE_PDCM))
-		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
-
 	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR) &&
 	    !enable_passthrough_pmu) {
 		x86_perf_get_lbr(&vmx_lbr_caps);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0c40f551130e..6db4dc496d2b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -239,6 +239,9 @@ EXPORT_SYMBOL_GPL(host_xss);
 u64 __read_mostly host_arch_capabilities;
 EXPORT_SYMBOL_GPL(host_arch_capabilities);
 
+u64 __read_mostly host_perf_cap;
+EXPORT_SYMBOL_GPL(host_perf_cap);
+
 const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS(),
 	STATS_DESC_COUNTER(VM, mmu_shadow_zapped),
@@ -9793,6 +9796,9 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
 		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, host_arch_capabilities);
 
+	if (boot_cpu_has(X86_FEATURE_PDCM))
+		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
+
 	r = ops->hardware_setup();
 	if (r != 0)
 		goto out_mmu_exit;
-- 
2.46.0.rc1.232.g9752f9e123-goog

