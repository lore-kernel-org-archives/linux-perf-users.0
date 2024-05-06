Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F1414375B
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973498; cv=none; b=WyoI2Ja+Gw9AHZpqkt+3e3QKwHNLltqQ1qeepbglLiv+6G11d2r3MH9szwN/IA5wFt6spUiESvQ3e5sR3BVLrYOnz5QIyLMl2hKExyZu3WdtVZVAsTbEAZeUUfIxE2FjPsjUunsX6RtZaxIn2q1DkxLmjJhTYBrLwNsSqbLYxVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973498; c=relaxed/simple;
	bh=31Z1OZcvDSu8c487A71d+TOh4+WdozUoAJ76NuUEixE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ggwC9t6PwRzcWgYxATnuatF9a4vqdMMfE36K4tgqj1ESK/2rfiaJoBozXR/9ex3TyJI8vqth58qfa3oNhoEqDutolXlYTmVKooLjbEUNbiPwaC1OSo7k20zA3O8aLAJyNl8Oct1IaLNIxqH0AJf3eNuoLM+WDQSCm7zH70LJ4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JwlXF4B/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JwlXF4B/"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b3773153feso1393841a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973496; x=1715578296; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jvxmRNNzm0ialjJX5Kyuv9c+dTUZx8Ic7LeMSCgpNT0=;
        b=JwlXF4B/8KPUiFeneIr728i3JQF8Nu9iRbMpvTK5aSV0k9Nqa7an2V5V9HNi0VSkuJ
         XxoMM3vt07pY50mcbi5ZTaRrui2CY/l6lX48blRc2AVbjRd4TJEaZnADXbP7zWnqaDdK
         MeyZPKsgtGUhaU3A8694Ww5Ua/TJlTe8gFEIr2kDRpjSKg4i/AUBIP007CBuqCO97yvC
         MaiTbC6xGhUpKi/iidWu4EHTBbbbjMl284Sd14zr0LcOyGGD3Gl07tOd5xd/3nuh0k9p
         xz6VQQzoWNHJS0soaz7Vdw1nEw18d6ORDpRZnJBV1Fa8hjurami1P5qC2aUYMeNN9tiZ
         FnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973496; x=1715578296;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvxmRNNzm0ialjJX5Kyuv9c+dTUZx8Ic7LeMSCgpNT0=;
        b=tAmnD53MbnJJCktylFNmXe4W3QUAaQrol6ph51hLHWsT4tzKdF2wKP0K1Cms/NtxPT
         wjSlUwuoDu3k4AfMs/2ULzl9rioqPpGePeyIsicfx/Hu7ovv2qCi55e8AttpmvlUEgmB
         UqIUBNEj3IAa2XBVXrlN4KjZr9BV2JYjXz1nPTBKs1co4Pg++Sd3Xs7EPERSzjnER4gN
         IESfdBmB9hgi3g1Qqj56UpSlDyFs/gaK5U8XVhUaHjtr/9kaR4V9R3DM1ebWBhO1asZN
         yWykDm1z8V+Sufg5kGbBneggwNRsS9vN/gQQx8o3UCxbFWMPkpV1gliOb31+3rmD7BZB
         e/MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXROVQBbVj30MG3LX1B8k/IXrXK8+WFL0GuJXxRNcN7ALy5M3L48SNFgqwcln+uepHxcWYWHR07cV51PdC62S2/95gtopx2qvM0VNI5qbBz9w==
X-Gm-Message-State: AOJu0YzR6/XfHAlbSNAIEEWIbAGMrhCVlQaKVK5aj04ybuy9kgbcnANP
	QXBZCRnIDYyhNa5qxky+07R83HqVbWdflL+x8SEYJ9xgodGNHqJb5D3vLKW8WqdeTzz5DuJ3Kbc
	SVlsvpw==
X-Google-Smtp-Source: AGHT+IH/mxinAZrdz3Klst7c4dV90NWXmunIvbcDxzTOCTvEO16RxUWtLqzAlW0j4Xl1ImWkT0Ah5CH55iWI
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a17:90b:8d6:b0:2b3:5eb5:6a76 with SMTP id
 ds22-20020a17090b08d600b002b35eb56a76mr25362pjb.3.1714973495401; Sun, 05 May
 2024 22:31:35 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:30:01 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-37-mizhang@google.com>
Subject: [PATCH v2 36/54] KVM: x86/pmu: Switch PMI handler at KVM context
 switch boundary
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

Switch PMI handler at KVM context switch boundary because KVM uses a
separate maskable interrupt vector other than the NMI handler for the host
PMU to process its own PMIs.  So invoke the perf API that allows
registration of the PMI handler.

Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/kvm/pmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 2ad71020a2c0..a12012a00c11 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1097,6 +1097,8 @@ void kvm_pmu_save_pmu_context(struct kvm_vcpu *vcpu)
 		if (pmc->counter)
 			wrmsrl(pmc->msr_counter, 0);
 	}
+
+	x86_perf_guest_exit();
 }
 
 void kvm_pmu_restore_pmu_context(struct kvm_vcpu *vcpu)
@@ -1107,6 +1109,8 @@ void kvm_pmu_restore_pmu_context(struct kvm_vcpu *vcpu)
 
 	lockdep_assert_irqs_disabled();
 
+	x86_perf_guest_enter(kvm_lapic_get_reg(vcpu->arch.apic, APIC_LVTPC));
+
 	static_call_cond(kvm_x86_pmu_restore_pmu_context)(vcpu);
 
 	/*
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

