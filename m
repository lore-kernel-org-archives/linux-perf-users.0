Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8F1514FB
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488440; cv=none; b=mVgzZ0SyaK5lhKhOU0FgXk1D62TtFo9pL5tCUmTE0MZh4vasndsq7pYRPN77HAslMJa5Y2hGNO9G3hrlGvEYc7LBjgdaa7KURai0vw2cRA9oLspTomwUVQlLMBlQspzSI9fpKJvBEeJ7iSCZ4VSWW/Z9pk51RSfh1GPOffznDJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488440; c=relaxed/simple;
	bh=VAHMUQMsnCV9I/A+oDWWPfZJTovvEUhxF98f6nJvAIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g+U9XnUoTlbw2De5D2Gq+OnjN1XshOfc2u6XmWOWx6R+7q/cdukC304hkdR2C/0HbE98sADTRM/j+bHgfzNLB8qG22+tTPjIPBEHkgUqafFr4HB2g/+qYtZ32+QsZ8jeccUPEsBEyw3z4ifKUNJSa5N1GytoC0+dQ+eARPZBEe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPl3b8w4; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPl3b8w4"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fd8677380dso59014925ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488439; x=1723093239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GWAsbLkHW+pH+Ccv39iK+ZoMvl5iGC6gOz/C2c65y1Q=;
        b=tPl3b8w4pB249F3x7fC3+JhLR+uIy6dpXePqsM/R2i9mfG7yfBd4JdoA8JsyJzO/JG
         UGrmQxGwvIQ71F8TuvOOa1n35F9olZTL6uCyDMxhsfafz7MjH/NMC5iBig+N2hEVrKvW
         OhWezhOgrdpMEwXEGqoEaadXHOCqqica3wfAUvPwY+vX8qAsSNdbJiu6zwWToVhoV46V
         v1xNYgAkSv+Gljx7qjqPj5kqEmi/sRNiY2GyDxFkYCik0uPawTzohTlSZpJEX0+z1pXQ
         LFNDSTiLAxQVY17oVInFEnMfwZ/v5VLaZeNK6gQx1df0bQDCpOS5gTUykcDJI98VcSy0
         NhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488439; x=1723093239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWAsbLkHW+pH+Ccv39iK+ZoMvl5iGC6gOz/C2c65y1Q=;
        b=nVdzESq1453MKMYgSGMciDiwGmn0Td0HKgybSjto0N1g1vA7TI9M1SYYTwkTQIoGBq
         2SVN9fCF+9uI3pBMNqDoa0ONEux2SovFRoDoA6EpYIDZXDSAHYPw3bmNBV83uyGowCD8
         yooEVHuLKw181bB6ECRHLqFhuWuse60xmQbIrD5LDuopFSy+uzGfpxrsOSU1a3rYqFCS
         iO+Y+NfdZFx1MyTKYgVf9mSWr/OpOsPH88qRo3qkFQCCv1IW87BBX+fBnlIL0pwoso5J
         Yq0c/Wi/z80Mh1SFYrunCA/pH3IMW7T+Rb7TS87ORbPPUslL6rs5Df2C7icSyh99lZ03
         WyfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgh7jTlHfdRy2k+obhNYqSsbbDa/P1cQ6mSFLvVG7nEEXZ3yYEcB36EGMVhmuzVMIsD2z5yB2cNRkuDPXHyfS30EIi91Il7uIivVQKSWiAOA==
X-Gm-Message-State: AOJu0YwFYbduSLyzyooHFaJTWMUAhdZ5PijT4VHvO0At3rBXF8dnl4hH
	2QHbY4BfG8MS+PPFrhooJIYnkLOi1Nw+g1lEWyEHlbbyqOMcLkI24mlxtt6lUPe1PNfKuu5RKUE
	vhdte+Q==
X-Google-Smtp-Source: AGHT+IEKQb3xMKg5Ray/eNf7i3D7IdXa6mI1QNFpnmVWVX8oLP2CrMMTRi6mhHZFAwkBpII9qVpAHPA5wqKC
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a17:902:eccd:b0:1fc:4b97:cd1c with SMTP id
 d9443c01a7336-1ff4d27a611mr1369585ad.8.1722488438622; Wed, 31 Jul 2024
 22:00:38 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:56 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-48-mizhang@google.com>
Subject: [RFC PATCH v3 47/58] KVM: nVMX: Add nested virtualization support for
 passthrough PMU
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

Add nested virtualization support for passthrough PMU by combining the MSR
interception bitmaps of vmcs01 and vmcs12. Readers may argue even without
this patch, nested virtualization works for passthrough PMU because L1 will
see Perfmon v2 and will have to use legacy vPMU implementation if it is
Linux. However, any assumption made on L1 may be invalid, e.g., L1 may not
even be Linux.

If both L0 and L1 pass through PMU MSRs, the correct behavior is to allow
MSR access from L2 directly touch HW MSRs, since both L0 and L1 passthrough
the access.

However, in current implementation, if without adding anything for nested,
KVM always set MSR interception bits in vmcs02. This leads to the fact that
L0 will emulate all MSR read/writes for L2, leading to errors, since the
current passthrough vPMU never implements set_msr() and get_msr() for any
counter access except counter accesses from the VMM side.

So fix the issue by setting up the correct MSR interception for PMU MSRs.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/vmx/nested.c | 52 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 643935a0f70a..ef385f9e7513 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -612,6 +612,55 @@ static inline void nested_vmx_set_intercept_for_msr(struct vcpu_vmx *vmx,
 						   msr_bitmap_l0, msr);
 }
 
+/* Pass PMU MSRs to nested VM if L0 and L1 are set to passthrough. */
+static void nested_vmx_set_passthru_pmu_intercept_for_msr(struct kvm_vcpu *vcpu,
+							  unsigned long *msr_bitmap_l1,
+							  unsigned long *msr_bitmap_l0)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	int i;
+
+	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+		nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1,
+						 msr_bitmap_l0,
+						 MSR_ARCH_PERFMON_EVENTSEL0 + i,
+						 MSR_TYPE_RW);
+		nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1,
+						 msr_bitmap_l0,
+						 MSR_IA32_PERFCTR0 + i,
+						 MSR_TYPE_RW);
+		nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1,
+						 msr_bitmap_l0,
+						 MSR_IA32_PMC0 + i,
+						 MSR_TYPE_RW);
+	}
+
+	for (i = 0; i < vcpu_to_pmu(vcpu)->nr_arch_fixed_counters; i++) {
+		nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1,
+						 msr_bitmap_l0,
+						 MSR_CORE_PERF_FIXED_CTR0 + i,
+						 MSR_TYPE_RW);
+	}
+	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1,
+					 msr_bitmap_l0,
+					 MSR_CORE_PERF_FIXED_CTR_CTRL,
+					 MSR_TYPE_RW);
+
+	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1,
+					 msr_bitmap_l0,
+					 MSR_CORE_PERF_GLOBAL_STATUS,
+					 MSR_TYPE_RW);
+	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1,
+					 msr_bitmap_l0,
+					 MSR_CORE_PERF_GLOBAL_CTRL,
+					 MSR_TYPE_RW);
+	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1,
+					 msr_bitmap_l0,
+					 MSR_CORE_PERF_GLOBAL_OVF_CTRL,
+					 MSR_TYPE_RW);
+}
+
 /*
  * Merge L0's and L1's MSR bitmap, return false to indicate that
  * we do not use the hardware.
@@ -713,6 +762,9 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
 					 MSR_IA32_FLUSH_CMD, MSR_TYPE_W);
 
+	if (is_passthrough_pmu_enabled(vcpu))
+		nested_vmx_set_passthru_pmu_intercept_for_msr(vcpu, msr_bitmap_l1, msr_bitmap_l0);
+
 	kvm_vcpu_unmap(vcpu, &vmx->nested.msr_bitmap_map, false);
 
 	vmx->nested.force_msr_bitmap_recalc = false;
-- 
2.46.0.rc1.232.g9752f9e123-goog

