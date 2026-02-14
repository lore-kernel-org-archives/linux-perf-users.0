Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7012F2BCF6C
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Feb 2026 01:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771032438; cv=none; b=mxkZHUtpaz4d/d9SCBO7e69z8RoAcCWXRJVLmfwJbJ341MiAVLGaf0XXstlnuujMTBzwf7Qla11DbLRvUrD3g9lZZyGMch2jDA5k2XXgHZE/wSvk8TdWXpz/XF7qqxrw9YR8SsQeMM0vr+Vmen3yDVXBtCtD2EUbtkkYxR7+7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771032438; c=relaxed/simple;
	bh=KxQaeOFTUwNddWWAwysEkVI+6gLN8UxXhcnpjxklb+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nz7d95uWDh2bHugdT0k8/CPwThUVeQmiAw02fNwHhK0GhrxotqFA/JlxghYLm9Cnw407cLkjhWjNvoR8jD7FOBaQwH1NVuu145XUzmXSPy3oVd03FlKfQorsgwn699CcQVuXenHxyFOcgR2Ooy0eC+j9NQ3EyFohI2eKAC/D1Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XJ/dSDIR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJ/dSDIR"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354c0eb08ceso6018722a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Feb 2026 17:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771032435; x=1771637235; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ncRTKT34NsAmZ158dpqAeNu/HepDjS+oL5Xbl/IP/0E=;
        b=XJ/dSDIRMgLOoGcIeQSSlYDnhpgjRACXRnBQt7SUi8al2r6NZ1t/zPFQRmMPO0VZ5I
         1729pOs24HGlcDrvT820muwdBAXj+ia9yAcXg85xR97KCNYzHpLhtSVFK8+BTS/Q0ocZ
         g+NSpKHhjD7LDS7OU4GXmBgBRW10KxWhRS8N/KHmI2Y77fzD9EyFbM/J4y1K/NuI4usq
         GZg0rurbbY4e8D7D01WrbQNXrqGwyzDEyeuGocOPxQ9KtycIDptP/927gCwE1FfRDKk0
         gtA4f3PNFx37kMmSq9IZ3kUfR373ObgH9U9nRKSGomq6G8KO48PZjq4/eY5d2ybBddm5
         tuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771032435; x=1771637235;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ncRTKT34NsAmZ158dpqAeNu/HepDjS+oL5Xbl/IP/0E=;
        b=qwTpHHLV3HAfNdtzIwNea4fMdO+snfMww56eSAoeZWKtPXrVWAjzyKJ59CSHq+ZCAl
         4ythddtydCbg6pnDngzGHSAKbeLbsp8Jy1oQ+l7sl5QiRjBCoYcRrJ4CL2Ms0Ny5xhUQ
         DqieK6oXSAS9OqL2rlVb98wv2vYIb3ClC8PmNOAtVhgFcaJ/johrRCe6ORUZbRoK6eSf
         5BfFZRcNFCSl00Gd6AzksAbJIIsh6PlCyZWxM5b5PTLGKMIPZxFOYJWSgVnG+9SAq/Xw
         a9g5p3rXHHYIwGdbueV0xpLwYSy6o0JbU+Lssfnjcj3AUHK56pWbWkDLDTpYz8m8K9FN
         oNfA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ4Lcoxl8AyTa7Rzx1Cl37pUniLEXAI1T8g9EGJmK7dlskwDIr11YIkQylkhHRf8/KMQCdZF4Djgp18qeF4AZB@vger.kernel.org
X-Gm-Message-State: AOJu0YzSWMxxpvDp1RXKLqn/fI5dn1IDD1wd2D4B3HnV/al5k9IdQbUW
	kkd72QT57o2D8oixKq3tuZ2pX745gkB5IOunRkY4Ccrxcq9rHxqvTzJVS/C9rdCFXDQiGdewwyU
	lADtupQ==
X-Received: from pjl16.prod.google.com ([2002:a17:90b:2f90:b0:353:28:3531])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5105:b0:33b:be31:8194
 with SMTP id 98e67ed59e1d1-356aad80906mr3557884a91.34.1771032434676; Fri, 13
 Feb 2026 17:27:14 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Feb 2026 17:26:51 -0800
In-Reply-To: <20260214012702.2368778-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260214012702.2368778-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260214012702.2368778-6-seanjc@google.com>
Subject: [PATCH v3 05/16] x86/virt: Force-clear X86_FEATURE_VMX if configuring
 root VMCS fails
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

If allocating and configuring a root VMCS fails, clear X86_FEATURE_VMX in
all CPUs so that KVM doesn't need to manually check root_vmcs.  As added
bonuses, clearing VMX will reflect that VMX is unusable in /proc/cpuinfo,
and will avoid a futile auto-probe of kvm-intel.ko.

WARN if allocating a root VMCS page fails, e.g. to help users figure out
why VMX is broken in the unlikely scenario something goes sideways during
boot (and because the allocation should succeed unless there's a kernel
bug).  Tweak KVM's error message to suggest checking kernel logs if VMX is
unsupported (in addition to checking BIOS).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c |  7 ++++---
 arch/x86/virt/hw.c     | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index abd4830f71d8..e767835a4f3a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2927,14 +2927,15 @@ static bool __kvm_is_vmx_supported(void)
 		return false;
 	}
 
-	if (!this_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
-	    !this_cpu_has(X86_FEATURE_VMX)) {
+	if (!this_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL)) {
 		pr_err("VMX not enabled (by BIOS) in MSR_IA32_FEAT_CTL on CPU %d\n", cpu);
 		return false;
 	}
 
-	if (!per_cpu(root_vmcs, cpu))
+	if (!this_cpu_has(X86_FEATURE_VMX)) {
+		pr_err("VMX not fully enabled on CPU %d.  Check kernel logs and/or BIOS\n", cpu);
 		return false;
+	}
 
 	return true;
 }
diff --git a/arch/x86/virt/hw.c b/arch/x86/virt/hw.c
index 56972f594d90..40495872fdfb 100644
--- a/arch/x86/virt/hw.c
+++ b/arch/x86/virt/hw.c
@@ -28,7 +28,7 @@ static __init void x86_vmx_exit(void)
 	}
 }
 
-static __init int x86_vmx_init(void)
+static __init int __x86_vmx_init(void)
 {
 	u64 basic_msr;
 	u32 rev_id;
@@ -56,7 +56,7 @@ static __init int x86_vmx_init(void)
 		struct vmcs *vmcs;
 
 		page = __alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
-		if (!page) {
+		if (WARN_ON_ONCE(!page)) {
 			x86_vmx_exit();
 			return -ENOMEM;
 		}
@@ -68,6 +68,16 @@ static __init int x86_vmx_init(void)
 
 	return 0;
 }
+
+static __init int x86_vmx_init(void)
+{
+	int r;
+
+	r = __x86_vmx_init();
+	if (r)
+		setup_clear_cpu_cap(X86_FEATURE_VMX);
+	return r;
+}
 #else
 static __init int x86_vmx_init(void) { return -EOPNOTSUPP; }
 #endif
-- 
2.53.0.310.g728cabbaf7-goog

