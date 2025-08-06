Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCAC2E264C
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510330; cv=none; b=R/ZUILjbkuhRfKE2yoSOkdnJdNNKOqEA4NXeDtRfl3OhDu7VQPc6fEnI7EOoV5wZxq36OJTzJKyzDHt9ngDqYjM+8QCQGxbHyMl7pfH/CJ8VVH3d9PikbR0d368mNM2+574ADs/xg08GfOqyK6ieuXjdWqI8D/Yaa9csz9vC68w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510330; c=relaxed/simple;
	bh=GASA5Z6faQfJd1EfEj5uOcxIVuCY+8w72a3NGzWBljs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e789pIxEb1NTes8ZmJnJl/SCvGtA/3SBhCnVrbczmzdc+tQuPyXUwmltESfvFq4TlognMS+bDJ2DHSoTFlmpHvwn3G2/yhsp9kZhHQPov+9bVaPHFGX/OxYgIOdGASHfvxX9xwpf+Tnyb4N5MQfTqRm3teDhwxfKjuri9cH5W54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NA57kutG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NA57kutG"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-315af0857f2so334824a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510326; x=1755115126; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=w80ZA8rn05ntQihJcNwz1pv2hia2ecTvLpbk0Bz9WXc=;
        b=NA57kutGoHd7SQM2ydI8bzlKGOvvhHRUL1CzhW1r8+2CTM5hU3VKBSnTK0MF3AvQCe
         Ikq1OUIaG3Lp0L10C00RaIZBI7jjUhcQeQ/hQXRdg0PXWZpHP1t4JOkPIOWHnvthTo/i
         LecQ3PqsIkkrANu6JSarmxGeAEBySU95RU4LVZtcORr5Hlb46fS+FJWpJLjBYXK8imCC
         JHj6ebSr8Gr2JGGZkNr4jP1Bg+SlrXHIaDiji71g1jCY5Zx/nwp6ag2aBeOyXpjlO4Mu
         zZrAqfh//+e+c4vsQw4hk3NL5IAZo4DyyRITUEr3ZY0qxEtLuFN7pPHICQ0qSTZ2mlaC
         n0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510326; x=1755115126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w80ZA8rn05ntQihJcNwz1pv2hia2ecTvLpbk0Bz9WXc=;
        b=ndeLPFD5LPaS/o1PPYdizzIS7bfb2bCOJ47eDxl4vGcE5wvLMxP9srkFW+3r72nw4B
         +uphKPLj2TuZFULCpYquWUf3c7gtrC7qSKNRgI1nxd+5exIGP4MhKfwxbiHhA2rUBU7P
         lk9gJDcdt1Ae18pVkY8p+QGwzIdWRUvZ9wjloT/q19E7VYfaBUs1lVW3hweRSRa1uZtk
         B/jq8oy+zm1lKBZ117m7b7VvEiCkL5VTb6dUIJ3ZmTWwGFpt8CpwqpnmK0bZPs7H8kij
         eo1ed3hSNS5wc3yrG1h/iz3eQh1ATdXUxV012h6pI0CghPjZ82yy0s/MykIxnSUC5W03
         PLOg==
X-Forwarded-Encrypted: i=1; AJvYcCVjXjr0QgQ4Yddf86AQtwHSpy34Aagh1VSNcUtuXaF5dvCwHM6uRzsE5ahSkA02F3n1eYEW+K1pfdV+CuvK+2W2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4KG37Kx+vsR+5sGTXrcX6Vu1H0gmmzz4dbrWoK5Bdeb42m6q/
	GppPzptLKgI6BHlQJJnNd/P3/nGNqsvfOOtN/IUAHamA1lb740VKjlwPrnnae1itQ1oH4Qw/AiD
	RCYZ51A==
X-Google-Smtp-Source: AGHT+IEfElow/kZ7u4L92aZnG23Q7FLbrDYX2HxfWcS+XU7qHvCNVpRcocJ/y0Y5Vl+7RC7W7jz29DD5/48=
X-Received: from pjbdy8.prod.google.com ([2002:a17:90b:6c8:b0:321:6ddc:33a0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2750:b0:321:157a:ee73
 with SMTP id 98e67ed59e1d1-32166e27ab1mr4925727a91.6.1754510326195; Wed, 06
 Aug 2025 12:58:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:57:05 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-44-seanjc@google.com>
Subject: [PATCH v5 43/44] KVM: x86/pmu: Expose enable_mediated_pmu parameter
 to user space
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Expose enable_mediated_pmu parameter to user space, i.e. allow userspace
to enable/disable mediated vPMU support.

Document the mediated versus perf-based behavior as part of the
kernel-parameters.txt entry, and opportunistically add an entry for the
core enable_pmu param as well.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../admin-guide/kernel-parameters.txt         | 49 +++++++++++++++++++
 arch/x86/kvm/svm/svm.c                        |  2 +
 arch/x86/kvm/vmx/vmx.c                        |  2 +
 3 files changed, 53 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 07e22ba5bfe3..12a96493de9a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2840,6 +2840,26 @@
 
 			Default is Y (on).
 
+	kvm.enable_pmu=[KVM,X86]
+			If enabled, KVM will virtualize PMU functionality based
+			on the virtual CPU model defined by userspace.  This
+			can be overridden on a per-VM basis via
+			KVM_CAP_PMU_CAPABILITY.
+
+			If disabled, KVM will not virtualize PMU functionality,
+			e.g. MSRs, PMCs, PMIs, etc., even if userspace defines
+			a virtual CPU model that contains PMU assets.
+
+			Note, KVM's vPMU support implicitly requires running
+			with an in-kernel local APIC, e.g. to deliver PMIs to
+			the guest.  Running without an in-kernel local APIC is
+			not supported, though KVM will allow such a combination
+			(with severely degraded functionality).
+
+			See also enable_mediated_pmu.
+
+			Default is Y (on).
+
 	kvm.enable_virt_at_load=[KVM,ARM64,LOONGARCH,MIPS,RISCV,X86]
 			If enabled, KVM will enable virtualization in hardware
 			when KVM is loaded, and disable virtualization when KVM
@@ -2886,6 +2906,35 @@
 			If the value is 0 (the default), KVM will pick a period based
 			on the ratio, such that a page is zapped after 1 hour on average.
 
+	kvm-{amd,intel}.enable_mediated_pmu=[KVM,AMD,INTEL]
+			If enabled, KVM will provide a mediated virtual PMU,
+			instead of the default perf-based virtual PMU (if
+			kvm.enable_pmu is true and PMU is enumerated via the
+			virtual CPU model).
+
+			With a perf-based vPMU, KVM operates as a user of perf,
+			i.e. emulates guest PMU counters using perf events.
+			KVM-created perf events are managed by perf as regular
+			(guest-only) events, e.g. are scheduled in/out, contend
+			for hardware resources, etc.  Using a perf-based vPMU
+			allows guest and host usage of the PMU to co-exist, but
+			incurs non-trivial overhead and can result in silently
+			dropped guest events (due to resource contention).
+
+			With a mediated vPMU, hardware PMU state is context
+			switched around the world switch to/from the guest.
+			KVM mediates which events the guest can utilize, but
+			gives the guest direct access to all other PMU assets
+			when possible (KVM may intercept some accesses if the
+			virtual CPU model provides a subset of hardware PMU
+			functionality).  Using a mediated vPMU significantly
+			reduces PMU virtualization overhead and eliminates lost
+			guest events, but is mutually exclusive with using perf
+			to profile KVM guests and adds latency to most VM-Exits
+			(to context switch PMU state).
+
+			Default is N (off).
+
 	kvm-amd.nested=	[KVM,AMD] Control nested virtualization feature in
 			KVM/SVM. Default is 1 (enabled).
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ca6f453cc160..2797c3ab7854 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -178,6 +178,8 @@ module_param(intercept_smi, bool, 0444);
 bool vnmi = true;
 module_param(vnmi, bool, 0444);
 
+module_param(enable_mediated_pmu, bool, 0444);
+
 static bool svm_gp_erratum_intercept = true;
 
 static u8 rsm_ins_bytes[] = "\x0f\xaa";
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 85bd82d41f94..4a4691beba55 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -151,6 +151,8 @@ module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUGO);
 extern bool __read_mostly allow_smaller_maxphyaddr;
 module_param(allow_smaller_maxphyaddr, bool, S_IRUGO);
 
+module_param(enable_mediated_pmu, bool, 0444);
+
 #define KVM_VM_CR0_ALWAYS_OFF (X86_CR0_NW | X86_CR0_CD)
 #define KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST X86_CR0_NE
 #define KVM_VM_CR0_ALWAYS_ON				\
-- 
2.50.1.565.gc32cd1483b-goog

