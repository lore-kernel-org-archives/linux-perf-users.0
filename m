Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9524A14D2AB
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488410; cv=none; b=m9yM0FjxXr23rKZcGLJ2rxP4T3EhlqybKNX7aOA4771DzwtkeQ1NJI+8P+PEuvODA5wYxcB+VGZSvsxBcCsROLyMN38XZEc//J4vSwq8XF4LebBqEAfcMMLv2eHlUSgQdzl7t/J0OYm4PrQ+BQkVgz0DMVLiIjSWuIlk9NlJMQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488410; c=relaxed/simple;
	bh=p3G6v+vySZulVP8fq6n+1kq4EnOmvFAPMDF+phz0KVo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bCc99ax0DgFSnLI3s+WrNPH4RRkirK0KXb8w5oA+2lr9ixy9v8VOkgowI5MK9YujYD4SEmDaNBMTf0cWMn2KOdw8AoX+4BC8C/xoWQT73Pa1aW/gNm0XJKwp3Bmrkj+mAsPdn5U+xpG4hhA2pUggXDqB6z4ioCduN7IUSXLQ234=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qlpH71tW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qlpH71tW"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6818fa37eecso6939175a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488408; x=1723093208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LjR5TutF57Z+U0kiSopi0HHzsk31y+CBb0PAzrY9SwM=;
        b=qlpH71tWO+C0VxSozsNaHHTwpD4jy358DC6fAom4GIeN7aHhkRhh8qL3O/BwqF1HsY
         AQhnoaJCK2Vq8CI9wUjRMMancIEnEaQY80v5GdxtmIWh3mKR4kVVVZlvBRDBdkyVNUZO
         NbWz3qzQS/mie0h7ktq/r/rsqdmJ5JB5CTgnW8JOdYJtS5aUnfhIX5kRjXs/omma9hFn
         H3XPgnPxS3avSytB6RFpj1z8E4NrxhT6yXgn+ecKMqYUKBk1S4B7GmMvvEHnU6PxcShX
         j4lku9A0awCtGzsm+1nOi6Kgv3t+qGtFXrPseUudtW99T5r1lxBdLRyMX3LcJRYE+Yd7
         wfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488408; x=1723093208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LjR5TutF57Z+U0kiSopi0HHzsk31y+CBb0PAzrY9SwM=;
        b=WX1yi2RZJAP6Zyv20rGLcAg7eQdPR8m5+f1w9wM+/26q5fFD7Bq6BofGuQjvU5rCSp
         HyeORcuKeAwbIZJhWbIj0TQhR/CeA2xPpd3SDzxehB3UxpNRj/JphvWHbPSVvPTJOSgG
         wCO974hrRw3eW1hfHSLtliOkDcS55j/zh8XG322pETlukPqLLALLmRSIKpDOGw8yQ1IH
         zK0j4HJJZ9wQm873+COzj5GIEIW6mZtPZ1ihJkGflRBg+5NcBYU7ZhI8O1pww6bqyVY3
         1NIUfqxYj+Sa9t9R0Di0fmIP45SFXoyjMV4Ni8t9w2iLvlYg//npoAvRrtu+KXBtiOW9
         C9gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEjrf1FcQM0vZZ+Jl0qF+OPQxhSsDs8wQ+DrNEU4RpL5Sk8L83I79xPP1DNBzw2uYsF+1uzuIERNPGprjHYy+Z6xTVFU2KR/m6ZgP7d0UB9A==
X-Gm-Message-State: AOJu0YwaZneGYtSj1I7u39FGSCouaRNmdFuYL92xMxUEeL8lzo7ksHJc
	lD94mU7XxA7VrZoitEGHrFxvIdBEfAYVcbUdx+pTZWMUwf0UIVFbaLz5DVBED1070rFVObpt5eV
	m/jPNOw==
X-Google-Smtp-Source: AGHT+IF52maArG4VmTHMH8GbTzoryZmzz65yaXqqNwszdr58L0KBYdjaW4qxWBLtVuF3cQm/y7AMnMUwnaVt
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a17:902:d4c9:b0:1fd:9157:bd0d with SMTP id
 d9443c01a7336-1ff4d223878mr903745ad.8.1722488407939; Wed, 31 Jul 2024
 22:00:07 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:40 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-32-mizhang@google.com>
Subject: [RFC PATCH v3 31/58] KVM: x86/pmu: Add counter MSR and selector MSR
 index into struct kvm_pmc
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

Add the MSR indices for both selector and counter in each kvm_pmc. Giving
convenience to mediated passthrough vPMU in scenarios of querying MSR from
a given pmc. Note that legacy vPMU does not need this because it never
directly accesses PMU MSRs, instead each kvm_pmc is bound to a perf_event.

For actual Zen 4 and later hardware, it will never be the case that the
PerfMonV2 CPUID bit is set but the PerfCtrCore bit is not. However, a
guest can be booted with PerfMonV2 enabled and PerfCtrCore disabled.
KVM does not clear the PerfMonV2 bit from guest CPUID as long as the
host has the PerfCtrCore capability.

In this case, passthrough mode will use the K7 legacy MSRs to program
events but with the incorrect assumption that there are 6 such counters
instead of 4 as advertised by CPUID leaf 0x80000022 EBX. The host kernel
will also report unchecked MSR accesses for the absent counters while
saving or restoring guest PMU contexts.

Ensure that K7 legacy MSRs are not used as long as the guest CPUID has
either PerfCtrCore or PerfMonV2 set.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/svm/pmu.c          | 13 +++++++++++++
 arch/x86/kvm/vmx/pmu_intel.c    | 13 +++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4b3ce6194bdb..603727312f9c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -522,6 +522,8 @@ struct kvm_pmc {
 	 */
 	u64 emulated_counter;
 	u64 eventsel;
+	u64 msr_counter;
+	u64 msr_eventsel;
 	struct perf_event *perf_event;
 	struct kvm_vcpu *vcpu;
 	/*
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 6b471b1ec9b8..64060cbd8210 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -177,6 +177,7 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	union cpuid_0x80000022_ebx ebx;
+	int i;
 
 	pmu->version = 1;
 	if (guest_cpuid_has(vcpu, X86_FEATURE_PERFMON_V2)) {
@@ -210,6 +211,18 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
 	pmu->nr_arch_fixed_counters = 0;
 	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
+
+	if (pmu->version > 1 || guest_cpuid_has(vcpu, X86_FEATURE_PERFCTR_CORE)) {
+		for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+			pmu->gp_counters[i].msr_eventsel = MSR_F15H_PERF_CTL0 + 2 * i;
+			pmu->gp_counters[i].msr_counter = MSR_F15H_PERF_CTR0 + 2 * i;
+		}
+	} else {
+		for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+			pmu->gp_counters[i].msr_eventsel = MSR_K7_EVNTSEL0 + i;
+			pmu->gp_counters[i].msr_counter = MSR_K7_PERFCTR0 + i;
+		}
+	}
 }
 
 static void amd_pmu_init(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 737de5bf1eee..0de918dc14ea 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -562,6 +562,19 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 				~((1ull << pmu->nr_arch_gp_counters) - 1);
 		}
 	}
+
+	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+		pmu->gp_counters[i].msr_eventsel = MSR_P6_EVNTSEL0 + i;
+		if (fw_writes_is_enabled(vcpu))
+			pmu->gp_counters[i].msr_counter = MSR_IA32_PMC0 + i;
+		else
+			pmu->gp_counters[i].msr_counter = MSR_IA32_PERFCTR0 + i;
+	}
+
+	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
+		pmu->fixed_counters[i].msr_eventsel = MSR_CORE_PERF_FIXED_CTR_CTRL;
+		pmu->fixed_counters[i].msr_counter = MSR_CORE_PERF_FIXED_CTR0 + i;
+	}
 }
 
 static void intel_pmu_init(struct kvm_vcpu *vcpu)
-- 
2.46.0.rc1.232.g9752f9e123-goog

