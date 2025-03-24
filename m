Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17037264A62
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837598; cv=none; b=ZFICklehyntn0FlNtOtkFdpK1xSHwazSbbw6p3M9azTPj71twZe9pqmGWpzzDMzWuD5asmK/gM2asOJat2FX6cLTP+BRTVvByZBZZxOg0ZIjKLOFmLdhBGSlsSx6Q1vHUN8ldYzxyoGRyv7s2N/WebAY4AdcQqWnJNAsqF0zpsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837598; c=relaxed/simple;
	bh=2UZFS7ZtPOsOdbmjBqXwodQu0sg74b205rrAfdCfezc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B7hM5Drua4thWPzDhzZKNTButidBX5Mnyo+idQAaeAzS3OPVK3B9P6kvDcxaIhrcPoLE8QhPQWQrpxthvAgjjFH13a6q/o4LEqDO8Q0hOxSNEc4T1isFtDgxOBc9i58/POD04hwH/nIxFilE/fTPxovtkTTtxHvAsixxIrJmcmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B0ky/j4t; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B0ky/j4t"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3032ea03448so3599391a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837596; x=1743442396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/pjum03NzkfgM+Q+OY/G0cb0GEix9DxH7FdvQDwo0sM=;
        b=B0ky/j4ttoOO7HETzD0jLw2boowsp81uwV2unwnFMKdWBGKvilL+7xAvqJClQVMNhS
         LbKHR+f3/bvLQS3m+cEO7c/6sMS0IsYZiWoJxrzAgJgjNeJt4nL707m2If25c1ZsjtNh
         NvsIM08qRieZrME1aoe2J9AFbl+hAyxjNzWdOTdtriawnQWgunwLtpkJBXvRMda7KaQc
         upCP2NoMO3RUMFo5wSdv495K7fb3GJP8IuWSwRUd0tlVwjE9KQvMRkZtC2+P5a4UYWEx
         21AFlA/9I+XH26OXaRgIQeG8Nn4TCA5ZgY1UuiTiTxZlsvqEixTnyUAP1t/Kb7npX/r9
         g71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837596; x=1743442396;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pjum03NzkfgM+Q+OY/G0cb0GEix9DxH7FdvQDwo0sM=;
        b=dhyNS61e+Mk3VuTutZxLNMbn1tg8tPSWRXDB3XVsNLxQRnvHrk1jwxpMgbwgn+gKnF
         JWkfydkxTFReI4tw3kmzj0k0MIdCvH0A5Ci27Du4Zkrscb4flXVsPoraiDsDmCSlTzv2
         EhULpHkLDlTi4eQPq6sDnGWu4Flj5r6rY9I7dw0IZ6nT8HemnsU/7HFJqBsHVOAmj/Vs
         Ad81swW/p7xlFCdhU8hMRmMplbV8rb9MlJx53/trcxHJRNcirux21lOPIxN8swLOREre
         adYK4AMtC5G3RQIYt9BvqL6IsADA6/daYzt40fx8V45SCOt99XgEaJoYewPeJtEzMgMz
         jt9A==
X-Forwarded-Encrypted: i=1; AJvYcCVcI3kuDas6P1f9um5t3NfpTu1JIZ+kAJj8MEl4C8KVW6lARgIjMSRBtJsqVOaoonShKlW+UXAy7yOxmXmHYhjs@vger.kernel.org
X-Gm-Message-State: AOJu0YxRObnsXZXi5bc/oFOjxFabvGQbpPoF+z/a0TdbnmQgB4Utjn2z
	v2CVGsQYHmlA646YfiNz8cLI3aKlOq91lV5KTWiLCn/2EnSp2moMqVBnexLs3BtuhW4/i0XF2q1
	KCF46wQ==
X-Google-Smtp-Source: AGHT+IEp4Ey07lcVugyBVSb+j22AJh8dSqNsTLQcXlHV08cAfBwc+uLQMdNHEOqok620nmaX8Fc8YALvVfam
X-Received: from pjm7.prod.google.com ([2002:a17:90b:2fc7:b0:2f8:49ad:406c])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e47:b0:2f4:4500:bb4d
 with SMTP id 98e67ed59e1d1-3030fec4e66mr22976717a91.20.1742837596673; Mon, 24
 Mar 2025 10:33:16 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:55 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-16-mizhang@google.com>
Subject: [PATCH v4 15/38] KVM: x86/pmu: Check PMU cpuid configuration from
 user space
From: Mingwei Zhang <mizhang@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Check user space's PMU cpuid configuration and filter the invalid
configuration.

Either legacy perf-based vPMU or mediated vPMU needs kernel to support
local APIC, otherwise PMI has no way to be injected into guest. If
kernel doesn't support local APIC, reject user space to enable PMU
cpuid.

User space configured PMU version must be no larger than KVM supported
maximum pmu version for mediated vPMU, otherwise guest may manipulate
some unsupported or unallowed PMU MSRs, this is dangerous and harmful.

If the pmu version is larger than 1 but smaller than 5, CPUID.AH.ECX
must be 0 as well which is required by SDM.

Suggested-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/cpuid.c | 15 +++++++++++++++
 arch/x86/kvm/pmu.c   |  7 +++++--
 arch/x86/kvm/pmu.h   |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 8eb3a88707f2..f849ced9deba 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -179,6 +179,21 @@ static int kvm_check_cpuid(struct kvm_vcpu *vcpu)
 			return -EINVAL;
 	}
 
+	best = kvm_find_cpuid_entry(vcpu, 0xa);
+	if (vcpu->kvm->arch.enable_pmu && best) {
+		union cpuid10_eax eax;
+
+		eax.full = best->eax;
+		if (enable_mediated_pmu &&
+		    eax.split.version_id > kvm_pmu_cap.version)
+			return -EINVAL;
+		if (eax.split.version_id > 0 && !vcpu_pmu_can_enable(vcpu))
+			return -EINVAL;
+		if (eax.split.version_id > 1 && eax.split.version_id < 5 &&
+		    best->ecx != 0)
+			return -EINVAL;
+	}
+
 	/*
 	 * Exposing dynamic xfeatures to the guest requires additional
 	 * enabling in the FPU, e.g. to expand the guest XSAVE state size.
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 4f455afe4009..92c742ead663 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -743,6 +743,10 @@ static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 	kvm_pmu_call(reset)(vcpu);
 }
 
+inline bool vcpu_pmu_can_enable(struct kvm_vcpu *vcpu)
+{
+	return vcpu->kvm->arch.enable_pmu && lapic_in_kernel(vcpu);
+}
 
 /*
  * Refresh the PMU configuration for the vCPU, e.g. if userspace changes CPUID
@@ -775,8 +779,7 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->pebs_data_cfg_rsvd = ~0ull;
 	bitmap_zero(pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
 
-	if (!vcpu->kvm->arch.enable_pmu ||
-	    (!lapic_in_kernel(vcpu) && enable_mediated_pmu))
+	if (!vcpu_pmu_can_enable(vcpu))
 		return;
 
 	kvm_pmu_call(refresh)(vcpu);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index dd45a0c6be74..e1d0096f249b 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -284,6 +284,7 @@ void kvm_pmu_cleanup(struct kvm_vcpu *vcpu);
 void kvm_pmu_destroy(struct kvm_vcpu *vcpu);
 int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp);
 void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel);
+bool vcpu_pmu_can_enable(struct kvm_vcpu *vcpu);
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx);
 
-- 
2.49.0.395.g12beb8f557-goog

