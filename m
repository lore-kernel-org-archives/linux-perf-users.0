Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4109714B07C
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 04:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488395; cv=none; b=QOQ8vH4bLf5csNDE2nrIFX2UGyWxHRGmqaY2891McTiaiwe3g+ZaqXP4NUX0gWj3tiHxAEQpO1MIThqwcl10JApg5zHJwLbvY0k3Rucr+DYWWaZtV9byVes1TnGHC/D00JEyPdM9tmhSYQ9jIWepoAHp295laY1E9PLpnxWkLeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488395; c=relaxed/simple;
	bh=4rVl8h2r83tKUyBK+CojTPOVOBKT5NmS290fwCGxVKE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E8bzvI4bszjsLkqjhbzyc7M03tG6HAFL0O3+aRa9bn1lr2dmDnFaoz8B+4nA66b6nqhZkV/uNwb8x79mDprx4Bf4kRZORikmB1bPvBDNjWQ/rOvtfpx1Tc6IKKfiXq7lM1C8YBjLhPy/inLzkHJw0tMNUX+NgXrQrAd6lutQcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aDdylcc7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aDdylcc7"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2cb51290896so6780364a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 21:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488393; x=1723093193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ADqKoJFMO3oZC+aeRLYgTAUByywP/uLwbAPB3o+n+qY=;
        b=aDdylcc7jI+Z8auXznRGasKkekxCodFPYasMqX/yCZSsfAas9Wi46Tiz26dozCTbVm
         QG8Fq6c55LQ4AbNHOCvo+YxTDwS+Mmy1yFxsuT7RZsxWAOUk8ACwx94zWzBnVRMANoNm
         YLJ2Cyen0o7e3nsbKxC4M/K0147TivrRRp4XOCKo8FoQWFdDKpyuAm7bdWsH5CIlkw/C
         phsWSqSakn3Qo8T4NjnYvSXqmFe5tKXQHpOFJI+ZPTKN0t0UndVrmwotBCALWKGTEBVZ
         zW/CUP885wHvMHjZD1vlS50H/bJafE3m22POPD8gR0htEzY+tHMjsZ5ojv0zuNs2U0kT
         kycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488393; x=1723093193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADqKoJFMO3oZC+aeRLYgTAUByywP/uLwbAPB3o+n+qY=;
        b=HZI/qNqlALc4UJ5XKkv98ndu+0DRbGAeOSLK4Rm9kTkKD08Zw1yJLVxx+nxggmD2OF
         /1DOThbIr9B6t09apcVjYt+Ck0K4qxBu3fVYXoh73yW1HNSs8NIly2831uVuDhw2xmae
         fYHaPqoHt0uAqgfFHRWWG+A+4GdMPlvmWHVVaQgQMjdce4ypzDu4RPgzGPgDgyRpB0W8
         JXb8C7C9jRS5jm6d+ZAfyVYZCTnn/rslFsKYgVvVykg6sbXhTRrv8zgLa/cxqUdepXJk
         VhH7PqhFU+BuZZts9hCs8QCSUoIQe9QwKhuHcNC9tQ095ZO+cnPShAxsrqli6o1qf/s1
         US+A==
X-Forwarded-Encrypted: i=1; AJvYcCU2NZbopJ3l9Wm0tiVmc8uEG9ugvECKhOgKlNy15eiaRLzIBaQ6afk4Rmo94t8QCuTvfW5S6IZ2HHK8uAbBXCdcKiQR/RSr24jJruwDoFxURQ==
X-Gm-Message-State: AOJu0Yx0bMDhGYVV23cbuXj+8yvVwjv+SZXlv6a/zXeypWgc36RWPg3Y
	0UlcRmPorEQYEEWTUOapk/D7x97ykHzT8YJ75n3NCEcsbQc+bfMmrrNPxokHrVcBFkH5LmUuTLF
	8PHTz8w==
X-Google-Smtp-Source: AGHT+IEOB4XveBkp1W3fqnjUIxUUwVwyG5uh9+fFTNZkjj82cYdgVR3Cn0ntZxpbe4XF8qvJFld3PE+zoua+
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a17:90a:fa05:b0:2c9:9232:75e3 with SMTP id
 98e67ed59e1d1-2cfe7b25507mr39182a91.4.1722488393393; Wed, 31 Jul 2024
 21:59:53 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:32 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-24-mizhang@google.com>
Subject: [RFC PATCH v3 23/58] KVM: x86/pmu: Allow RDPMC pass through when all
 counters exposed to guest
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

Clear RDPMC_EXITING in vmcs when all counters on the host side are exposed
to guest VM. This gives performance to passthrough PMU. However, when guest
does not get all counters, intercept RDPMC to prevent access to unexposed
counters. Make decision in vmx_vcpu_after_set_cpuid() when guest enables
PMU and passthrough PMU is enabled.

Co-developed-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
---
 arch/x86/kvm/pmu.c     | 16 ++++++++++++++++
 arch/x86/kvm/pmu.h     |  1 +
 arch/x86/kvm/vmx/vmx.c |  5 +++++
 3 files changed, 22 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index e656f72fdace..19104e16a986 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -96,6 +96,22 @@ void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops)
 #undef __KVM_X86_PMU_OP
 }
 
+bool kvm_pmu_check_rdpmc_passthrough(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	if (is_passthrough_pmu_enabled(vcpu) &&
+	    !enable_vmware_backdoor &&
+	    pmu->nr_arch_gp_counters == kvm_pmu_cap.num_counters_gp &&
+	    pmu->nr_arch_fixed_counters == kvm_pmu_cap.num_counters_fixed &&
+	    pmu->counter_bitmask[KVM_PMC_GP] == (((u64)1 << kvm_pmu_cap.bit_width_gp) - 1) &&
+	    pmu->counter_bitmask[KVM_PMC_FIXED] == (((u64)1 << kvm_pmu_cap.bit_width_fixed)  - 1))
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(kvm_pmu_check_rdpmc_passthrough);
+
 static inline void __kvm_perf_overflow(struct kvm_pmc *pmc, bool in_pmi)
 {
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index e041c8a23e2f..91941a0f6e47 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -290,6 +290,7 @@ void kvm_pmu_cleanup(struct kvm_vcpu *vcpu);
 void kvm_pmu_destroy(struct kvm_vcpu *vcpu);
 int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp);
 void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel);
+bool kvm_pmu_check_rdpmc_passthrough(struct kvm_vcpu *vcpu);
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4d60a8cf2dd1..339742350b7a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7911,6 +7911,11 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		vmx->msr_ia32_feature_control_valid_bits &=
 			~FEAT_CTL_SGX_LC_ENABLED;
 
+	if (kvm_pmu_check_rdpmc_passthrough(&vmx->vcpu))
+		exec_controls_clearbit(vmx, CPU_BASED_RDPMC_EXITING);
+	else
+		exec_controls_setbit(vmx, CPU_BASED_RDPMC_EXITING);
+
 	/* Refresh #PF interception to account for MAXPHYADDR changes. */
 	vmx_update_exception_bitmap(vcpu);
 }
-- 
2.46.0.rc1.232.g9752f9e123-goog

