Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EEE296BDC
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Feb 2026 01:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771032445; cv=none; b=DKURwiNrVnz8Gt/uvMneRQYW2LC2XeRjeDttwoIlsPO2GEcGhGEdS+JFtcK7DF0FgY3ZZOCWJdGhbt1ihKPrjLHYBvB0dQJ0aXKQ9Z+JQzc469Jds8jT4uYh1cK/dxMhn8JXKicFhTX1lFMtsbVfoF+nTtclbZ7HntAq2LbhbiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771032445; c=relaxed/simple;
	bh=hftPp1cgH316yfhw8k/dPrCnpI6uxskVDDg5/T2D/XQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NGFRq2tNULGaxVDCzyOYQkBtjsERIR/a1962ndCZ4rccL/1tvrBLr/F4XAJNM4DyzhrnFVj5DxnwHR26UaygzI6szQ788Spotb1Xk0ocrjEypQvF28espux4VpONqmSU+YeG5vNFaKiG7pg0U7iQoQKTGphAPZTn+rvvCipDvEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ODe2sKw8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ODe2sKw8"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35449510446so1467116a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Feb 2026 17:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771032444; x=1771637244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=H80q9SD+282s080Ud0tbsBB2WQnuDfalKG9TFAGQvtU=;
        b=ODe2sKw8XoEK7CQYt+oCiLu5mLNoyuVj1bq+LvEAPbVmd7QLJjArvXZ9OHfsTmlrbn
         m7Se4Odc9ibeOBJ6ztQ6uNQXaPXElwac8G4qk/2g1vFwmdd67izJuA0opxTy+94nssVV
         CLNwOsDyI29nKRzGm1kVry8CmORq5gGhQLfXL92CJgKkNry4PSPbVNDDWu2pkh+EzKv/
         cL03Q+MVhTVSH7PymNRyqlR2q/e8EIjhi7uR8TxNQtOyX0Cj03IYxNzjoSJOAxtqIB0f
         9uyqsF+3OT1utCHsc/Kt4RCT7DSJvvMKb/1zcsBtPO89Yo26Z7MXAMfav0bgkNabM/yR
         zCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771032444; x=1771637244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H80q9SD+282s080Ud0tbsBB2WQnuDfalKG9TFAGQvtU=;
        b=s0NUZ2FTvA/tAN74IU3Rts1+uJofVZvgUJWWHKx+Cw2satMCIbqwZS8mVwQV+ePcia
         V+irbS2AyTpM9xWjUJF8zEyY8jwWZ8i8EQ2uahkIT/A9vNqxWJqCTutBFIWRtyjOTChl
         0Y/nNYDvADAUqQYFVnky3avqFaCChIcHI7+YoRQIzU3kJ2y5PJR+zeiPA8KoiWqsZLQL
         ryQUZKiuABvnnapOvErc1xUlwHRK6ZzAQCWdGCvvqGdxrpNv+U+hbEq/Wppm5gzla/Yj
         5Qu9NvnbdUV+VPm/sDUAlCzwom7EBzdVTdfLONioSpBk+gDOXl4NeEmPwptK9iBzX7V9
         NrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT8KB+3S2v8Q8tt8+Cb7Mdk42Xr4Fx6YmMnQMjvVsirn4E8f+Nk51ohyMdiTYTaHwOuhtrrMBQVb+FekjASdvm@vger.kernel.org
X-Gm-Message-State: AOJu0YyF4+9osuS7cyDOA7JL0aKbRVeM5M2TgLQaJBV2ggFA2LTcJull
	KETJqCEMK5lLApAPYZRNHwgL3RIXG6fWDQCTfTJmIgp28U6CBab4ADlREr3MoKlSaJ476+sF9vn
	kX8MzSQ==
X-Received: from pgvt5.prod.google.com ([2002:a65:64c5:0:b0:c65:e24e:cef1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:43a5:b0:38e:9cc5:218c
 with SMTP id adf61e73a8af0-3946c8be39amr3465099637.54.1771032443485; Fri, 13
 Feb 2026 17:27:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Feb 2026 17:26:56 -0800
In-Reply-To: <20260214012702.2368778-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260214012702.2368778-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260214012702.2368778-11-seanjc@google.com>
Subject: [PATCH v3 10/16] x86/virt/tdx: Drop the outdated requirement that TDX
 be enabled in IRQ context
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

Remove TDX's outdated requirement that per-CPU enabling be done via IPI
function call, which was a stale artifact leftover from early versions of
the TDX enablement series.  The requirement that IRQs be disabled should
have been dropped as part of the revamped series that relied on a the KVM
rework to enable VMX at module load.

In other words, the kernel's "requirement" was never a requirement at all,
but instead a reflection of how KVM enabled VMX (via IPI callback) when
the TDX subsystem code was merged.

Note, accessing per-CPU information is safe even without disabling IRQs,
as tdx_online_cpu() is invoked via a cpuhp callback, i.e. from a per-CPU
thread.

Link: https://lore.kernel.org/all/ZyJOiPQnBz31qLZ7@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c      | 9 +--------
 arch/x86/virt/vmx/tdx/tdx.c | 4 ----
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 0c790eb0bfa6..582469118b79 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -3294,17 +3294,10 @@ int tdx_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private)
 
 static int tdx_online_cpu(unsigned int cpu)
 {
-	unsigned long flags;
-	int r;
-
 	/* Sanity check CPU is already in post-VMXON */
 	WARN_ON_ONCE(!(cr4_read_shadow() & X86_CR4_VMXE));
 
-	local_irq_save(flags);
-	r = tdx_cpu_enable();
-	local_irq_restore(flags);
-
-	return r;
+	return tdx_cpu_enable();
 }
 
 static int tdx_offline_cpu(unsigned int cpu)
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 5ce4ebe99774..dfd82fac0498 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -148,8 +148,6 @@ static int try_init_module_global(void)
  * global initialization SEAMCALL if not done) on local cpu to make this
  * cpu be ready to run any other SEAMCALLs.
  *
- * Always call this function via IPI function calls.
- *
  * Return 0 on success, otherwise errors.
  */
 int tdx_cpu_enable(void)
@@ -160,8 +158,6 @@ int tdx_cpu_enable(void)
 	if (!boot_cpu_has(X86_FEATURE_TDX_HOST_PLATFORM))
 		return -ENODEV;
 
-	lockdep_assert_irqs_disabled();
-
 	if (__this_cpu_read(tdx_lp_initialized))
 		return 0;
 
-- 
2.53.0.310.g728cabbaf7-goog

