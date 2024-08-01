Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408C615250A
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488447; cv=none; b=sZjwuhTSQmHAAaWPvkcWZUGkC+g6nRBlRgE9wSBOeq5m+d6LPXCYXaLBcPPcCnUg+lw3wHhaqZLpdqH3YsIIU4GKUN9CEiZNg4wyvYbD5L3Q/YPGwi48qBLOfeTHesKDLhyTMgS/FEwgr0BZ30JoNwTHrlCgzYNZLjddzZIngTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488447; c=relaxed/simple;
	bh=cdpKS3/uACb3KxMOvGHLsLYuNv1uvNwIlHZC51S5MPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XfChyq6cPcR7DEnGO+wNVsVVIOGxDdH/3oBJDyr5yerLp9leRLlS3FtrFWKHU3sODlA+HE573gOAxi+K+yjpgSXDiuW52ox4Z1k27/jXNk1OWIOalj2vtoROKfegGsOqP1nHQ5Z5cwhYv2BI1W9PRCaTbLo5iByhPlr//FS4Ftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ERqfIqa2; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ERqfIqa2"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so6360367276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488444; x=1723093244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bm7ZCS61nv2akVrVL6X4rg4hbgFHoPFsqWK4Hp1ajno=;
        b=ERqfIqa2j7N2rfjegAq9N1aLkIiTUJ7E82iNvBtoCoNbm5HtVcH/mXPzAnMoCS/Ift
         V8GkZHQPGDV3SgbiNG54ap++Jatv4tmdpAMNLwbPnLJwcOrE+CdJUZzUzv79pv9nwC/3
         PrFkuj8SM+x2NS8UvOGNRxEybU/2mSOi54qyMyj31NI9Ww4Qk5y5C+aUXWqGcUCxDpmd
         7X26ICA8VJWiN+y3qZwWXMEuB04Cu7r6gcdVzpPqME4byMYTm1ORUz9DuWmnWeG+JCZe
         7tp0futE3pMIQJ7Yf5Baloy8Uj+5uqHVwFVbMxFnq5aLFTORJLr1JJU5szXqpx1gCHPn
         97iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488444; x=1723093244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bm7ZCS61nv2akVrVL6X4rg4hbgFHoPFsqWK4Hp1ajno=;
        b=lsWnbDXXW4+d0dRKC1y0ZNd5Nu+rPGiL+kRq6tn4lMHX4YQJNF4rCPI+J3xfkTNLG7
         P/yZZoJ8Xe9L3ipAXcT4TQIOSSbRDRewYQQJr5RNzlBeKuTNK+/MNLskKtI0oTGbjrON
         kynObGt5WXWAEm5TZMbw4dXNTJp2yfvYI0fQ5OQ+a9MmGmcSlz6ecRPOlU9yp+Z3PWgk
         GambYZL+0e96DiJTrAe9bneH1qgtMkeX5++zoSWC/dR0qiVqoS/bzor6nDoOST7CYj5p
         0wFzuGJMh5h2TFwkvUI5Uw/sVsdj2BreKJ4bxLSfn0xZ8uFvNwXS7nvpyhnnQMZPbA6b
         2J9A==
X-Forwarded-Encrypted: i=1; AJvYcCWPqOhhuZHdpxZzGxl5dBNUt0lq84kIwts8ZNH/eeUgesDrknpi84bU6Tb0sj4s1KNsqvTC/bT8xLGP8NHLasWzb3Wmg1uBpJoiA/n23/1OHg==
X-Gm-Message-State: AOJu0YwLnJ+akqB2vg3veQPs6I479PE8XFi0SZoD1cE5BwUWPMXqyOli
	KK+LtJIrCEvSw6mRQVW3QCoKMcsyFlaMNg0Yi577FJfJXRP+CBhskdd93moc1lTj23YKz7ei/bu
	yV8wXfg==
X-Google-Smtp-Source: AGHT+IF4VPoCa5Bi3PU0camhKoeHZtOuU9gIT2voR88T+GMpmTvgcbCdr/cc6zxAFccrkaQh5tCHXOh06UAT
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:6902:1007:b0:dfb:22ca:1efd with SMTP id
 3f1490d57ef6-e0bcd36bf56mr2383276.9.1722488444219; Wed, 31 Jul 2024 22:00:44
 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:59 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-51-mizhang@google.com>
Subject: [RFC PATCH v3 50/58] KVM: x86/pmu/svm: Set enable_passthrough_pmu
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

From: Sandipan Das <sandipan.das@amd.com>

Since passthrough PMU can be also used on some AMD platforms, set the
"enable_passthrough_pmu" KVM kernel module parameter to true when the
following conditions are met.
 - parameter is set to true when module loaded
 - enable_pmu is true
 - is running on and AMD CPU
 - CPU supports PerfMonV2
 - host PMU supports passthrough mode

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/pmu.h     | 22 ++++++++++++++--------
 arch/x86/kvm/svm/svm.c |  2 ++
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 10553bc1ae1d..9fb3ddfd3a10 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -196,6 +196,7 @@ extern struct kvm_pmu_emulated_event_selectors kvm_pmu_eventsel;
 static inline void kvm_init_pmu_capability(const struct kvm_pmu_ops *pmu_ops)
 {
 	bool is_intel = boot_cpu_data.x86_vendor == X86_VENDOR_INTEL;
+	bool is_amd = boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
 	int min_nr_gp_ctrs = pmu_ops->MIN_NR_GP_COUNTERS;
 
 	/*
@@ -223,18 +224,23 @@ static inline void kvm_init_pmu_capability(const struct kvm_pmu_ops *pmu_ops)
 			enable_pmu = false;
 	}
 
-	/* Pass-through vPMU is only supported in Intel CPUs. */
-	if (!is_intel)
+	/* Pass-through vPMU is only supported in Intel and AMD CPUs. */
+	if (!is_intel && !is_amd)
 		enable_passthrough_pmu = false;
 
 	/*
-	 * Pass-through vPMU requires at least PerfMon version 4 because the
-	 * implementation requires the usage of MSR_CORE_PERF_GLOBAL_STATUS_SET
-	 * for counter emulation as well as PMU context switch.  In addition, it
-	 * requires host PMU support on passthrough mode. Disable pass-through
-	 * vPMU if any condition fails.
+	 * On Intel platforms, pass-through vPMU requires at least PerfMon
+	 * version 4 because the implementation requires the usage of
+	 * MSR_CORE_PERF_GLOBAL_STATUS_SET for counter emulation as well as
+	 * PMU context switch.  In addition, it requires host PMU support on
+	 * passthrough mode. Disable pass-through vPMU if any condition fails.
+	 *
+	 * On AMD platforms, pass-through vPMU requires at least PerfMonV2
+	 * because MSR_PERF_CNTR_GLOBAL_STATUS_SET is required.
 	 */
-	if (!enable_pmu || kvm_pmu_cap.version < 4 || !kvm_pmu_cap.passthrough)
+	if (!enable_pmu || !kvm_pmu_cap.passthrough ||
+	    (is_intel && kvm_pmu_cap.version < 4) ||
+	    (is_amd && kvm_pmu_cap.version < 2))
 		enable_passthrough_pmu = false;
 
 	if (!enable_pmu) {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 296c524988f9..12868b7e6f51 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -239,6 +239,8 @@ module_param(intercept_smi, bool, 0444);
 bool vnmi = true;
 module_param(vnmi, bool, 0444);
 
+module_param(enable_passthrough_pmu, bool, 0444);
+
 static bool svm_gp_erratum_intercept = true;
 
 static u8 rsm_ins_bytes[] = "\x0f\xaa";
-- 
2.46.0.rc1.232.g9752f9e123-goog

