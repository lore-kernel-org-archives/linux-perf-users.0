Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B87A14387C
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973499; cv=none; b=S3lWKpHxd5R+WNDcAmaMrGgySieMKQdBCikMeQpDPrpk7Poen/mOk2kXtWVr0uxFxO4W9Y4TFxrQxjE1e2wyuaisXWyRR7zXCG/L0UMtW/ebSyUeB6QZny5aunvJfTkVtAe6tRwV3CiKw13w8uLM1xi45hN4ZVnmDQJqx6tNxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973499; c=relaxed/simple;
	bh=H5VJU3psCYgp/k2Nle2Kr0rBKad98Mrlue8egGTIFsU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=umpG71k8N9aC8QB7JAChPsTTLsCOyhagHVG3C+98mKSZ0fhB9H7ArP0J7OoB2tNZ3HHhxnRSh46AJLxgBUTNR6JxrejSJbPsI1GzCnjloEQMTO9RFUJdCWoLbJh+hD75HuCc1zp4F1I/LHFmJz7aXIxxUSZ7ZaA2weu0ZkE7JZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e0KN4Cqv; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e0KN4Cqv"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f452eb2035so1363052b3a.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973498; x=1715578298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZpxXAlW3ogmdgJpT5++xDXNSobWCTXr0d0WIX/XGXw=;
        b=e0KN4Cqvdfe8sjpm5irEjDZmU5ryhJPIgy/VRheKTjMTN3KsGGDyq6FdHqCwTJdSVM
         iNFJ9ubOSfhqlvgTOClndEx/FT/u9mP083R0+oLawk67u9eTZZ/RDD9JYwfpB9e6eKOQ
         PkgFGl0b5LyQhEPhuEyRz2lo2iRVQGhWfz7FV36rhWakEKnapLPTWYIrfTnSR/HiMjyf
         HHhmosbRy0m1HR0FoRWWucGP1LpyNDJTxdR9gfauzX6RY/rVdrtfmRYc8s5mvSpdbr1M
         4i4IovrEDNVNWCVVSfdRE8f7iOUy+nOyWejP4Boasinl4YNevT8qnhtQ+Jkcz8Yfpglp
         Kmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973498; x=1715578298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZpxXAlW3ogmdgJpT5++xDXNSobWCTXr0d0WIX/XGXw=;
        b=cXra3wNRUi2TaqBhIw/9++TyFHyvgLK+RN3De9pY2+30tCUaoZ6YQGGdMAwioGvgf3
         0z3TGOoFsV324s0wlHAaKJGmRKTLXMMc3qa3g6WWZMprsP1huKH12EYKBcsnGN+kZ0eX
         GzncNnwEW7CIYkcWWSt8BsO8a6HQn37M7tWU/MXUJOaMZGDMm3lJ8KmCBEIgmApuHl3N
         iScHNHAmQa9NWXWfSTuxTFJAXW4jRa/gKUDh1/qjPEzMoGfldRrC6GDrgViycMId/t7z
         oARzDzTjSQzbP9Gu9qJQtKl8VPDPA+9fBNLFOyh1295idIYL2rNF4eeu81QmMA4gC2ga
         HIyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+1J91xYVFczEUWelOUgIJhT4OpmRICs5pkBHU6DGQUjV5IwJciDomcEagi6W1KcZG1+4fLVrKlybXUZ7sfSzue+ILKVYCnNW22U4hlwNWZA==
X-Gm-Message-State: AOJu0YzYoi2OXa7+L22b2cNruevYhfi35k4q0k0LzTSRx7FZarLDvhs6
	LVMqhp1/fOmYra/8wdfbCq9oZK7OJMW6WDZpwfiGLQZNJgD4Wdv/YNG0KfzlBZhA7xvQ1qO8wQM
	tAesOcA==
X-Google-Smtp-Source: AGHT+IFY5Z+Xd5c64hltPgv/1tFfWjyX318kJSm2zQaG/hAuq4r+2oqUmZbl/Z7OBEZ7ma7yhcutpgz4qrkT
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:6a00:a19:b0:6ec:f5b8:58cc with SMTP id
 p25-20020a056a000a1900b006ecf5b858ccmr320432pfh.6.1714973497691; Sun, 05 May
 2024 22:31:37 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:30:02 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-38-mizhang@google.com>
Subject: [PATCH v2 37/54] KVM: x86/pmu: Grab x86 core PMU for passthrough PMU VM
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

From: Xiong Zhang <xiong.y.zhang@linux.intel.com>

When passthrough PMU is enabled by kvm and perf, KVM call
perf_get_mediated_pmu() to exclusive own x86 core PMU at VM creation, KVM
call perf_put_mediated_pmu() to return x86 core PMU to host perf at VM
destroy.

When perf_get_mediated_pmu() fail, the host has system wide perf events
without exclude_guest = 1 which must be disabled to enable VM with
passthrough PMU.

Once VM with passthrough PMU starts, perf will refuse to create system wide
perf event without exclude_guest = 1 until the vm is closed.

Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
---
 arch/x86/kvm/x86.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index db395c00955f..3152587eca5b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6674,8 +6674,11 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		if (!kvm->created_vcpus) {
 			kvm->arch.enable_pmu = !(cap->args[0] & KVM_PMU_CAP_DISABLE);
 			/* Disable passthrough PMU if enable_pmu is false. */
-			if (!kvm->arch.enable_pmu)
+			if (!kvm->arch.enable_pmu) {
+				if (kvm->arch.enable_passthrough_pmu)
+					perf_put_mediated_pmu();
 				kvm->arch.enable_passthrough_pmu = false;
+			}
 			r = 0;
 		}
 		mutex_unlock(&kvm->lock);
@@ -12578,6 +12581,14 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.guest_can_read_msr_platform_info = true;
 	kvm->arch.enable_pmu = enable_pmu;
 	kvm->arch.enable_passthrough_pmu = enable_passthrough_pmu;
+	if (kvm->arch.enable_passthrough_pmu) {
+		ret = perf_get_mediated_pmu();
+		if (ret < 0) {
+			kvm_err("failed to enable mediated passthrough pmu, please disable system wide perf events\n");
+			goto out_uninit_mmu;
+		}
+	}
+
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	spin_lock_init(&kvm->arch.hv_root_tdp_lock);
@@ -12726,6 +12737,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		__x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, 0, 0);
 		mutex_unlock(&kvm->slots_lock);
 	}
+	if (kvm->arch.enable_passthrough_pmu)
+		perf_put_mediated_pmu();
 	kvm_unload_vcpu_mmus(kvm);
 	static_call_cond(kvm_x86_vm_destroy)(kvm);
 	kvm_free_msr_filter(srcu_dereference_check(kvm->arch.msr_filter, &kvm->srcu, 1));
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

