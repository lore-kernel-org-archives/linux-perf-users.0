Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624251422AF
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973464; cv=none; b=sqOMLEZqCHKDaVpX+YHYnQ98T5Y/k+C9OJrJ0i4Rv+AYIhX8nW/yRN5PI4zw+Zw+yLJe/O9HpDFOMYXl0F/ENpURBv6o8D9j82adDzvYD3mLH39RJb0EQqJZl6moLmWI911bgbHmyN5Rator2AqX3MSNMJ/Wb/WGDMzigUTAtoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973464; c=relaxed/simple;
	bh=4JV3JBk542bDiuOpaxaBli9FM66gbpzuJUQm0J17X7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X1dkDS+HRYNtHgaqZSCobaWsZv1hw++ieQC7Q2Aze9jtB+O+oF9sFINk/FnAiQIpQvUpaAnEvsVZumiqGyzG/avb9tA68QknEr5jSk/30TOUkEwSHFKmet1LSCFKt1Xn3nXdX4PHkkiKHphiZYR7InTkFLFniVdrrJX8WC/g7sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gfqsbDWQ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gfqsbDWQ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f46bf70fd3so284509b3a.3
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973462; x=1715578262; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=WD50X9BvrWddKNVIGtC5ON2wXqi8A3wOjCyxWRh0RTU=;
        b=gfqsbDWQi+cV/Av3Hujbp/RsccW0b3aWdiDVLjssph68fMf2eW2UiBJMT7fbV7vYDK
         6K0fYWdycV7dQe4wqKnIvKcihZELduK/FNLxN0zyp6m58f99LD8aN/ncWCNky2csZX+Y
         00jwvIC/EQRj/9d0p1joah+awkv8CJgUwyLbEUH+D/rbR6+zSIwvUxO/kJpHBjLFvORF
         f4EQYk843LFHzQVWxZroEPZHPOp32fU8Vltbowg8eKNyP0CS7UT5xq51q+zwhOJPqoIc
         uhfDScV0GJNiQq4JB9kFr/J+aQMKZgW4n4dFZz1pDVo0tLlntpLdXJYDohSnIds+HsdU
         aL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973462; x=1715578262;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WD50X9BvrWddKNVIGtC5ON2wXqi8A3wOjCyxWRh0RTU=;
        b=fXeYLbvxsa6NjpT2oXWotcETE6IziLJmyu1wLDAfhBKRYdJm7uRN9KUXxTnORc7w+I
         D9j2Q65NFs3FWk4jMdQVWMsPlQQlb1fTBJ//zNMuxsjWxUXS+AuA/tKqA0qqVUlOtNHK
         Q9EijaAg6GR5coPraBfTUJ6bVgY9Y+19rjnF1S50JxOJunhd518J5uEjZNZE9EaYgnZ6
         pRC64mmUe34U6Sr4AlpB9LXaODiMpWA0zrDafmKbzb9/96brLMzQiMOd9p1626Cvd3ug
         TLCNgvQ4kX7AHjz1CISwqGRSS8bJ7SDG/BeWAAKUUpK4h5rNYiHjK6b8sw4JPkAeisTL
         HRBw==
X-Forwarded-Encrypted: i=1; AJvYcCU0MI/2ebC03BrOJQ8jdYa+5ioC6B8mRxTSQ02D+IVp+Ln5+PZpCuwO+yNEseIBggpGl4wac4Mb+WQdc7uSjYGLG7CXByakbaL3mH0NWxk++w==
X-Gm-Message-State: AOJu0Yy7nPA8txS9XObHRt+9f79pXGnXosIlSwokaRx9SiDXudy1lpR+
	msRYPPwALhf46qXZbSzHSKcpghgTuNho6t0zku2So+EzSfo05E/+xR0SFbqC8cuWv/zUhqVXUEK
	RPjk9cQ==
X-Google-Smtp-Source: AGHT+IHLQOvZFtWKPuz4LBXpiu1md8QkyfWklmB9msvLnz6sQoMK4hUErWRN1eYwRhHldBFeh0r679DJjYC+
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a05:6a00:3904:b0:6ed:95ce:3417 with SMTP id
 fh4-20020a056a00390400b006ed95ce3417mr271128pfb.5.1714973461697; Sun, 05 May
 2024 22:31:01 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:44 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-20-mizhang@google.com>
Subject: [PATCH v2 19/54] KVM: x86/pmu: Add host_perf_cap and initialize it in kvm_x86_vendor_init()
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
index af253cfa5c37..a5024b7b0439 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7868,14 +7868,10 @@ static u64 vmx_get_perf_capabilities(void)
 {
 	u64 perf_cap = PMU_CAP_FW_WRITES;
 	struct x86_pmu_lbr lbr;
-	u64 host_perf_cap = 0;
 
 	if (!enable_pmu)
 		return 0;
 
-	if (boot_cpu_has(X86_FEATURE_PDCM))
-		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
-
 	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR) &&
 	    !enable_passthrough_pmu) {
 		x86_perf_get_lbr(&lbr);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4c289fcb34fe..db395c00955f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -245,6 +245,9 @@ EXPORT_SYMBOL_GPL(host_xss);
 u64 __read_mostly host_arch_capabilities;
 EXPORT_SYMBOL_GPL(host_arch_capabilities);
 
+u64 __read_mostly host_perf_cap;
+EXPORT_SYMBOL_GPL(host_perf_cap);
+
 const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS(),
 	STATS_DESC_COUNTER(VM, mmu_shadow_zapped),
@@ -9772,6 +9775,9 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
 		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, host_arch_capabilities);
 
+	if (boot_cpu_has(X86_FEATURE_PDCM))
+		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
+
 	r = ops->hardware_setup();
 	if (r != 0)
 		goto out_mmu_exit;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

