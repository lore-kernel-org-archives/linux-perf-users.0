Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B06143C44
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973505; cv=none; b=XF6ptuDDCghThpuD3le2wLF4w/Pe8biNEGA+lHXRzCBs1Lc5pKW6YtWqI6UWYOOQAOIBk3d+6G5OONCZ9kIrSa4/G9lM/89Au/3Vf8Lo/JKUT3dJwvSxJNonxfDuSWsQFSU7eCLNEnizKG7MusgYYLU54VKs9qzN0ta4z5yMmq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973505; c=relaxed/simple;
	bh=IaG3WshtNgeTnyTB/oLA4MQoJ01it8Gujk8G4J4nCbw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VT077SnZIoidBJp2r+k9ocZqyKYPw37Y+tsaiHrpUQSDLweFd7hj35YicXpM/AtoCic2Hr2QITUDpPcfM3NxkVHgmLEJXcFIKdx3C4sVRjelfeJXVM/59kACFLs8O5Ha0iVw7k6RC75QbY/wyYZM8UfjH9yrFIlq85IQm/2XFUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ayVimRto; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ayVimRto"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be75e21fdso38055317b3.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973503; x=1715578303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=v82sTxnncFb8g7f7pUYj4aCyHiFFjGX3JeQTtvNNAl0=;
        b=ayVimRtoitAOsIe0+3LgIFPyxf/t+Wum88EIG3WHPA5fYNMsEcr7IgzxD6gw8uciZh
         5jbODL1uRcvS/QEyUEzSlGMcWTR4ySh/ZbI0RQvGDDascTtc7bGxFmPf5mSvtmps2zHj
         4wF4h4Qi0W11lTcdyQryQVO4awyrJe6QmnrKq3JVkGLHvY0p8I4u4t5uQxeQ1WQv6V4H
         futpXZ6/XXdKiw0jwxk9ElU0O1+9VGqS0tjOWjYMx4h5SeTCPM8e5XrKg7eTkmfhnLwB
         +Mt8hnY4tIywNF+IEi4tK08f0Vdpoy+qEUnawdJ6Gnm7Dg/AJfyeDK4DgjzFh088h8pP
         PrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973503; x=1715578303;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v82sTxnncFb8g7f7pUYj4aCyHiFFjGX3JeQTtvNNAl0=;
        b=Yy4aCy8Cscr5nctRwHD3WdC1CsOYUSYRzJXT9N6omZI3NdMyFd360Wo6wJghlMOClY
         benExSj1ZXV0BszB5XM8wGkWSVLPFtBOQT6M/pJv8OOjbUIEoc3so2JW8guJeB+d50Nl
         2z/bOz1gDCICgRPJ9ONVP9WvinX5C18x02MhXjPsUtM+r78wC9RXNXI2W258062xFup3
         8owd20gswMrBiYEDD24NxCXAzvZQAb5KbAN+rw8qUme/xOrR2Qrq0o8UkAdSssFosSB9
         cifHIUHdXaeds9BDNQXdYf+Z6x58SFFnCCRv4PwC5NoRCNhhikQAMyyhmeOrqShdlLX/
         KHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtbp1uuI9Nn/0EGpJAIqELHPeu16BLaEmmLcdAjOkdf6F8E36snfL5QryOKdHie5e58NCmlQvuXqRS3i2hq4rIOm8J0RQJVippHQyUakG+dg==
X-Gm-Message-State: AOJu0YxyqJdJzzsAmdZcbFiroKkTXDn8fcrDiW05KNzv5YoWIEyLEnFn
	848sDI3419M6efs0mvEpaFUWSnVP9rlDtbiCjOtrCcgBlHREsskdRelV6N0CoeQ1tDWF0VhN+dQ
	PdKdIYg==
X-Google-Smtp-Source: AGHT+IEW4RzhFKt80YyR6YW1SeSH/HMbIyDtdOi+jV8EvuYRDlsFQmiRPYaYPOkisNK0JdhXPHyjGdR40kpH
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a05:6902:1082:b0:de4:5ce2:7d2 with SMTP id
 v2-20020a056902108200b00de45ce207d2mr3128058ybu.4.1714973503230; Sun, 05 May
 2024 22:31:43 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:30:05 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-41-mizhang@google.com>
Subject: [PATCH v2 40/54] KVM: x86/pmu: Introduce PMU operator to increment counter
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

Introduce PMU operator to increment counter because in passthrough PMU
there is no common backend implementation like host perf API. Having a PMU
operator for counter increment and overflow checking will help hiding
architectural differences.

So Introduce the operator function to make it convenient for passthrough
PMU to synthesize a PMI.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h |  1 +
 arch/x86/kvm/pmu.h                     |  1 +
 arch/x86/kvm/vmx/pmu_intel.c           | 12 ++++++++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index 1a848ba6a7a7..72ca78df8d2b 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -27,6 +27,7 @@ KVM_X86_PMU_OP_OPTIONAL(cleanup)
 KVM_X86_PMU_OP_OPTIONAL(passthrough_pmu_msrs)
 KVM_X86_PMU_OP_OPTIONAL(save_pmu_context)
 KVM_X86_PMU_OP_OPTIONAL(restore_pmu_context)
+KVM_X86_PMU_OP_OPTIONAL(incr_counter)
 
 #undef KVM_X86_PMU_OP
 #undef KVM_X86_PMU_OP_OPTIONAL
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 9cde62f3988e..325f17673a00 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -44,6 +44,7 @@ struct kvm_pmu_ops {
 	void (*passthrough_pmu_msrs)(struct kvm_vcpu *vcpu);
 	void (*save_pmu_context)(struct kvm_vcpu *vcpu);
 	void (*restore_pmu_context)(struct kvm_vcpu *vcpu);
+	bool (*incr_counter)(struct kvm_pmc *pmc);
 
 	const u64 EVENTSEL_EVENT;
 	const int MAX_NR_GP_COUNTERS;
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 6db759147896..485bbccf503a 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -74,6 +74,17 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 	}
 }
 
+static bool intel_incr_counter(struct kvm_pmc *pmc)
+{
+	pmc->counter += 1;
+	pmc->counter &= pmc_bitmask(pmc);
+
+	if (!pmc->counter)
+		return true;
+
+	return false;
+}
+
 static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 					    unsigned int idx, u64 *mask)
 {
@@ -885,6 +896,7 @@ struct kvm_pmu_ops intel_pmu_ops __initdata = {
 	.passthrough_pmu_msrs = intel_passthrough_pmu_msrs,
 	.save_pmu_context = intel_save_guest_pmu_context,
 	.restore_pmu_context = intel_restore_guest_pmu_context,
+	.incr_counter = intel_incr_counter,
 	.EVENTSEL_EVENT = ARCH_PERFMON_EVENTSEL_EVENT,
 	.MAX_NR_GP_COUNTERS = KVM_INTEL_PMC_MAX_GENERIC,
 	.MIN_NR_GP_COUNTERS = 1,
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

