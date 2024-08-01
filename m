Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4710514F132
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488427; cv=none; b=OF3mMGzBmzYU8FG7L7LwzKKZC9zHAVyoqUQ2bUHP6sklLI/HKIRFX9kMyKaPUKtc/BobB1Hm5UIaU+Mbuax5Lkkm419ydzHE/14pMwzb09ZGEP7Pq7qM7foPS92QRnw8mWiXSG9Hhk4vR0LwauHOigxKpEoO8W+bTOD+9GycLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488427; c=relaxed/simple;
	bh=j5z07mEw1a3NzUvM+YcPKrlrEYXrkrfP13gxBdsC9Rk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ct3ayd67FHIpvNwN/93QjmCpawCSZlgTD57Ei/Sx57Kt4c70KlCbYk3Xdnw6JUZF6xF06wzU6c2l6ZfOKweqTdmVZrcKzz088MloVOURdq+W3+3jcXnS70sRds5hURQhFyfyAskYTD4p+Eo8qhPgzIcPMbwenHzpI/aGyslhznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZPKktfGx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPKktfGx"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fc4fcaa2e8so60762595ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488425; x=1723093225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QyXLIC3s5xW9HET961595nlV4jFaPkV2bjM57q/oowA=;
        b=ZPKktfGxFUa2qUunpQv0cglRuGMAYox53WU4Lowx4dezbcbhxB/cr38l4BYdOHB3X+
         SoNf2gRQALjhZrgFKCLQ/jDDF40SDKVpH91ns54VMJJFUN3wk7yVBM2Zd/9duIVEiofh
         PDa9zeZ7xWlnIEaxvW3gdA+kvZrupXbqbTJhXPRXUBF7b+Ohf+xQOBmATPwebJvFByEQ
         MPtuNNUYCntY8Mv/FlQp/UoBToSZNiRWfB4wBJXXcfryqXTFphMcXwWGbpRZR+Ne2Gxp
         /2HRn619xsBHweYBxW9daKPHRxBzsoTCRrCj7516u5xWRH+VKMqGJcJg2dUWdsTNAKR2
         c7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488425; x=1723093225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QyXLIC3s5xW9HET961595nlV4jFaPkV2bjM57q/oowA=;
        b=VAizOhDj7g7aqNISTWboT7fSRDRtUcc+olERr2gYrJTu8pO/hlWpmu1tHjSFrhIGo8
         Imu+gJjJgpW6vDtGd6+RxTVxsiYgw/6LEwzzQ/oL2vk/6U9H81V0LhxjjDLcMhfKW3nY
         0QdEwdfLGFaFXKeMG4gBXU2P+s3D4U09DU7lvxYD+mXq+zP66nq3yiHm4IAeDx4WrKz7
         BCtrP++bMe3pE/tXq4oknJii0GzXuhbEGkgv7kwLipHp5yvg7+KJYQmBEqbqbHYiOySM
         Jciz2TWknaCOq8n87PLaKrBl+bChKpuT6K1SwZlxKOjN3HMybQgT/PoXR2yB3bwUjfrX
         NaKA==
X-Forwarded-Encrypted: i=1; AJvYcCUFZKqqq4DAVQsBE0ML9p/JI1EBYiIBtB/2eTejASVtrwy2cireIloFuq5VvlvrF2l2WnCfe4ROWg/5g3QkRd0eHXjvT5HVodp3S2PbwcqQhA==
X-Gm-Message-State: AOJu0Ywk+jPkT1BgkyMFLUWYE/0+0+JKjZWMq2u6Grf0Jce8Ux5WqXA3
	QxdPXUt6o3YulGKa26pU74QTi57t1uFPcahM5GSRc3cObuC5bX4zX45RbW4cTmAU7jQAgqXWIfv
	+DAMdeA==
X-Google-Smtp-Source: AGHT+IFUTtpDpvZf3y7902GI7QcnK8JU6POP1tL8roTadbEKEqyAuifvYwcGL1fDLnEiYOD61Y5kOcwkmt4+
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a17:903:1d1:b0:1ff:458e:8e01 with SMTP id
 d9443c01a7336-1ff4cc7e37amr1485355ad.0.1722488425316; Wed, 31 Jul 2024
 22:00:25 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:49 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-41-mizhang@google.com>
Subject: [RFC PATCH v3 40/58] KVM: x86/pmu: Grab x86 core PMU for passthrough
 PMU VM
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
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/x86.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6db4dc496d2b..dd6d2c334d90 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6690,8 +6690,11 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
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
@@ -12637,6 +12640,14 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
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
@@ -12785,6 +12796,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		__x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, 0, 0);
 		mutex_unlock(&kvm->slots_lock);
 	}
+	if (kvm->arch.enable_passthrough_pmu)
+		perf_put_mediated_pmu();
 	kvm_unload_vcpu_mmus(kvm);
 	static_call_cond(kvm_x86_vm_destroy)(kvm);
 	kvm_free_msr_filter(srcu_dereference_check(kvm->arch.msr_filter, &kvm->srcu, 1));
-- 
2.46.0.rc1.232.g9752f9e123-goog

