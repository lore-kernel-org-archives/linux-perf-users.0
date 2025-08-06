Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57642DFA3B
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510322; cv=none; b=dMDquqvKVnQVYpHPvFGZdu9v9B0cg5ihpGKV+/UlXNFCOqgoHRzVDdrUo5x0EKfIrX+Zu7KV6XtfBUqpEbk1WvxFX9PC8PUqXIhaWNpE03W1Cx4odanlyOn3hTN5iwz+Y6uoLSKk8FVfkhclATbfWe/yOVWKKBC3Y85o1O30NXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510322; c=relaxed/simple;
	bh=eowlj8R0vSVTi/YxsD+P1ORI9OIx1rmOow0uWDRXpQc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KBysBp5EA31Qihztjxj2wnfO1ApkfQm6jo+NUwMc3siAB55w0cDvGPTp4w4hj5k/KPNEIerm/V/gDbvR2aL/bwkER1w3omjHxw78YAZIxLjVlesNO0EaciXmcjvd8hJ78AyUJ4ZyHMs4U/pI3iAXbhWj4YqYt0OIeVtZME0pMQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OlE6BvYM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OlE6BvYM"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31f32271a1fso373508a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510319; x=1755115119; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=AlJpQpYzAXA8yQUaTEjcLu5rmW1zUT5mjcWEtsvn+qY=;
        b=OlE6BvYMbK2ZPWrZUD9pGLXrsiqhSrga2a6dSdgOddGyNn90KL5UA6HYAP0Ttr7K4B
         tNTx5s5HBl/2k/jm83UC+6gGbgPXyM0SG8HzuXMCGcBa2WB9Dc91JgXi/2eDxHqCLSn/
         aevWZ+Obqfw6yn84zCdjTV2ntOUIfnU0zpnSWC+XFt+xTOSm/ovxGpoOxehdvpUNhwCS
         2f8W3yWuxSNkAS+CH0Q16sh0k8LU9Su0cjpVl3Bhmlx6mWmIgnLfos7i/0rHghMv0787
         chIb9RgtUE+mJPs0UdmjJa+a1uOSEc75aqwJwz25Z6iyavLDIKJO8YZrYUtiSA/iLoOK
         gx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510319; x=1755115119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlJpQpYzAXA8yQUaTEjcLu5rmW1zUT5mjcWEtsvn+qY=;
        b=E0iv2FyOpSL0/Sl/kmZKyXEON2lq7m0oKbK6V7nb5QsJ6BvhQrc5Mr+e9gzJUDGIT2
         e8wEKGFoz4X29eKO1t8F2SXOnMcFlXzFRp65W2S1/w96jheUkM5nUo0+WE/uxV0GYCEH
         z5O/+GrpF6OrDkoq+6gW9hFsgm+c9Ur8IBxb2kt+cyTRDnBpMrSqqLxv+gZhScztsOIA
         PQC/v/9sT6yG3YxDVfiT1A6ve9O2dWFtkRA6OeTXYNKev0hUQ/EcmrjBPTTqrU6Vp4Ar
         Fo0tMgT5nWhMftIOW9dwjBUnIhEXCNYoGpRTiVLRs5oZD80T916/JfXN5DaduTUZZG5w
         Y1xg==
X-Forwarded-Encrypted: i=1; AJvYcCWu/utFuSZUSZho35aJAP9nkk9XoyolaedZLXxWv1WxUpag8LnRQuaWYtpRvhXZIlSus0wF7bblkHj1LVZHE+7D@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0TjEXbxc7JQ6OqqbNvXqEojISXkHdr2xLk5L91hsvaQbqtO3J
	Tx2IupItOB2c/s4KaqzToA9alNgw+dwyzFit8w6Z2++zuBKeFoEJSIS7vY9cvgoakPo2MQZMy7D
	2JnbFpQ==
X-Google-Smtp-Source: AGHT+IFAT6PWSjUL0hLa4l6orw0CuXbesqbqOENgS6V/LUSfRrl7M4gZLDmaQmAh4Zg14qO5rj6Zp5FZNJo=
X-Received: from pjx15.prod.google.com ([2002:a17:90b:568f:b0:31c:32f8:3f88])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5110:b0:31f:4e9b:7c6a
 with SMTP id 98e67ed59e1d1-3217562accemr1061143a91.15.1754510319397; Wed, 06
 Aug 2025 12:58:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:57:01 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-40-seanjc@google.com>
Subject: [PATCH v5 39/44] KVM: x86/pmu: Handle emulated instruction for
 mediated vPMU
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

Mediated vPMU needs to accumulate the emulated instructions into counter
and load the counter into HW at vm-entry.

Moreover, if the accumulation leads to counter overflow, KVM needs to
update GLOBAL_STATUS and inject PMI into guest as well.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 77042cad3155..ddab1630a978 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1018,10 +1018,45 @@ void kvm_pmu_destroy(struct kvm_vcpu *vcpu)
 	kvm_pmu_reset(vcpu);
 }
 
+static bool pmc_is_pmi_enabled(struct kvm_pmc *pmc)
+{
+	u8 fixed_ctr_ctrl;
+
+	if (pmc_is_gp(pmc))
+		return pmc->eventsel & ARCH_PERFMON_EVENTSEL_INT;
+
+	fixed_ctr_ctrl = fixed_ctrl_field(pmc_to_pmu(pmc)->fixed_ctr_ctrl,
+					  pmc->idx - KVM_FIXED_PMC_BASE_IDX);
+	return fixed_ctr_ctrl & INTEL_FIXED_0_ENABLE_PMI;
+}
+
 static void kvm_pmu_incr_counter(struct kvm_pmc *pmc)
 {
-	pmc->emulated_counter++;
-	kvm_pmu_request_counter_reprogram(pmc);
+	struct kvm_vcpu *vcpu = pmc->vcpu;
+
+	/*
+	 * For perf-based PMUs, accumulate software-emulated events separately
+	 * from pmc->counter, as pmc->counter is offset by the count of the
+	 * associated perf event. Request reprogramming, which will consult
+	 * both emulated and hardware-generated events to detect overflow.
+	 */
+	if (!kvm_vcpu_has_mediated_pmu(vcpu)) {
+		pmc->emulated_counter++;
+		kvm_pmu_request_counter_reprogram(pmc);
+		return;
+	}
+
+	/*
+	 * For mediated PMUs, pmc->counter is updated when the vCPU's PMU is
+	 * put, and will be loaded into hardware when the PMU is loaded. Simply
+	 * increment the counter and signal overflow if it wraps to zero.
+	 */
+	pmc->counter = (pmc->counter + 1) & pmc_bitmask(pmc);
+	if (!pmc->counter) {
+		pmc_to_pmu(pmc)->global_status |= BIT_ULL(pmc->idx);
+		if (pmc_is_pmi_enabled(pmc))
+			kvm_make_request(KVM_REQ_PMI, vcpu);
+	}
 }
 
 static inline bool cpl_is_matched(struct kvm_pmc *pmc)
-- 
2.50.1.565.gc32cd1483b-goog

