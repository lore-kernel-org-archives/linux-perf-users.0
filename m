Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0584E1448FB
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488403; cv=none; b=KdtY+DDWSspvRO7+l54vvyhlNiUlNtvaGGvf/3L4ysCnxJnQvRq4h1MZdTX5ShYSYbbHz1l+HX8k2oujzs4l/J3uu/X4qpowfMWznLwQhANXNEGqQgfwb/DlprieSbN1IF/sPtFVqre5HeN9JKKN22OSGMHtOH9i53Il3i7+6v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488403; c=relaxed/simple;
	bh=jVaOpdzGgUeZCcxUSgcRGcOgS5BCijhoj9k5blSwf0Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kxxJ2UTK3gwk9xUgHqf7bOM8q9Fi63GgoTt2MO97nS8QzNt7CFUSPU3I6drLsvefNgu1KIdRNVOmeOVIIM/p8wuKSxK6prowbYoC3JIXnV3i7Ny7QLNqpE1WCSTJ4scT8+safnlo/G3dO93ZfaKojqLqXDIIedWabdFMUH9xQms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ONCBjSsO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ONCBjSsO"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2cd2c7904dcso6585987a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488401; x=1723093201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KYRCskJ7zvPTDOVf+/zrSTGljeKv/UQQeog2dK9opJ8=;
        b=ONCBjSsO39j+KcJ1+C/v+zc+55Rn0yfY7UOCXIdP7kw2OPP5JVG8ETel9pgN0Ap2yb
         y0uY7fER6HIWVt+wXZbxNQMX2ol/2cm9TH/nM0QhlyDSmcVJVYMkSlWl+jbz1Ul9heqC
         IRSXwWLqersa7G5NOTXZvn/CuPZlH7JQS19xNLFSGNSZbuYkdo8Br8QhARgtkCTYAlkB
         PTz1M67M845P495GsvaFabMPTZ1ae9EFLXrgGOw+cZwob8NL23qC+/P7+b6cJLxr4gdS
         IFpt6gZt5GrG9F2oYboEURwbHc4KMj710ypIIJ/F4Pt1YLV66iZpkjZ/uLdl7bOp62Rj
         s2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488401; x=1723093201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYRCskJ7zvPTDOVf+/zrSTGljeKv/UQQeog2dK9opJ8=;
        b=GEK8Q+3cifXkaNGjjkcgnrJqp05t6iHVIYzP5EF8t12WBkdXvdCbHI30N79Km5etFa
         19g6wuJe07BQzYaN64xrjtaPTr7DVY5zVrHHG/q57PwnZv7i9MHVpz0NocHjh0Pzxbdv
         CQF0zsTnP9mr5yQWWfaxAYd2gszZIKNKpo2SLs0mdw0JsoLMOlv+QyP2AbjUZUvRcTtt
         yTvneOQnbzsFOjxazc8G5wZhfyficDAh/9rbxyNEluntD0b/i203t87Tbc7zAJ0oUzQO
         Btl3t8pwIAB1PjxusypCIeYAJDzCd+78MNliuP33O2XqhL3odfLI8lQvHgWeSuoW7nXr
         9/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCX3kqHYO05tCZGUJ1oYM+rrIPpltiYGDOXEMExUYu7G56EhddA4oWjla/VFE57b4uDG8QbMP2PhdbSDJaMt0DGznej0ELGENQZUUX0Ek893sg==
X-Gm-Message-State: AOJu0YyeZsM1YdPLGR6G7X+2VPFz5Fx2cFMWAdki9mwN8ebk/T12YnKH
	Bgr3h+CvUSVUxlIGE7V8C9gXEDkhMmkx6SImkcVfL7VpspFEUM7XkWGE7kmAxR5BlRtr6yFpKzK
	i0qvMPQ==
X-Google-Smtp-Source: AGHT+IH6c/VUOVw0ZnJ/ftVLFu6/gHn7JaI8qXMS2BuHKe/7URPK44Ba8bG8xQ88Gi3/jTv0r6E7od1qhri+
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a17:90a:9c3:b0:2c9:9208:ee66 with SMTP id
 98e67ed59e1d1-2cfe7b656a4mr3116a91.7.1722488401129; Wed, 31 Jul 2024 22:00:01
 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:36 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-28-mizhang@google.com>
Subject: [RFC PATCH v3 27/58] KVM: x86/pmu: Create a function prototype to
 disable MSR interception
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

Add one extra pmu function prototype in kvm_pmu_ops to disable PMU MSR
interception.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h | 1 +
 arch/x86/kvm/cpuid.c                   | 4 ++++
 arch/x86/kvm/pmu.c                     | 5 +++++
 arch/x86/kvm/pmu.h                     | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index fd986d5146e4..1b7876dcb3c3 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -24,6 +24,7 @@ KVM_X86_PMU_OP(is_rdpmc_passthru_allowed)
 KVM_X86_PMU_OP_OPTIONAL(reset)
 KVM_X86_PMU_OP_OPTIONAL(deliver_pmi)
 KVM_X86_PMU_OP_OPTIONAL(cleanup)
+KVM_X86_PMU_OP_OPTIONAL(passthrough_pmu_msrs)
 
 #undef KVM_X86_PMU_OP
 #undef KVM_X86_PMU_OP_OPTIONAL
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index f2f2be5d1141..3deb79b39847 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -381,6 +381,10 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	vcpu->arch.reserved_gpa_bits = kvm_vcpu_reserved_gpa_bits_raw(vcpu);
 
 	kvm_pmu_refresh(vcpu);
+
+	if (is_passthrough_pmu_enabled(vcpu))
+		kvm_pmu_passthrough_pmu_msrs(vcpu);
+
 	vcpu->arch.cr4_guest_rsvd_bits =
 	    __cr4_reserved_bits(guest_cpuid_has, vcpu);
 
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 3afefe4cf6e2..bd94f2d67f5c 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1059,3 +1059,8 @@ int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp)
 	kfree(filter);
 	return r;
 }
+
+void kvm_pmu_passthrough_pmu_msrs(struct kvm_vcpu *vcpu)
+{
+	static_call_cond(kvm_x86_pmu_passthrough_pmu_msrs)(vcpu);
+}
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index e1af6d07b191..63f876557716 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -41,6 +41,7 @@ struct kvm_pmu_ops {
 	void (*deliver_pmi)(struct kvm_vcpu *vcpu);
 	void (*cleanup)(struct kvm_vcpu *vcpu);
 	bool (*is_rdpmc_passthru_allowed)(struct kvm_vcpu *vcpu);
+	void (*passthrough_pmu_msrs)(struct kvm_vcpu *vcpu);
 
 	const u64 EVENTSEL_EVENT;
 	const int MAX_NR_GP_COUNTERS;
@@ -292,6 +293,7 @@ void kvm_pmu_destroy(struct kvm_vcpu *vcpu);
 int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp);
 void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel);
 bool kvm_pmu_check_rdpmc_passthrough(struct kvm_vcpu *vcpu);
+void kvm_pmu_passthrough_pmu_msrs(struct kvm_vcpu *vcpu);
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx);
 
-- 
2.46.0.rc1.232.g9752f9e123-goog

