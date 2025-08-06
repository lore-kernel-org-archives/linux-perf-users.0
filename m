Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7382D9789
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510306; cv=none; b=IPymdtLz3mabc9GtaHotRbrtNF9R7yBTtCXkCEkhT1oG0RYuw11BvTqO36F5GQgDpmXTJpLVoiCwcXCCKGfdI2pMkerX0CYr4Oh52PWQT1wQN4Kbd/O+4mMmiprAtKHwVDFC9Whu1Xa0oZCyZrnuNrzZRKKpL4zOw1ppuAO63Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510306; c=relaxed/simple;
	bh=zkHffgBonSYg4vE9BMzEVoQYPuGz4X+vSu1d1oyeTYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GRsvAsrHECKGwhZmd5qml+OHftk9sTRsNaRp/EFL7ST8Ts5oS8oQ9ZB2IPumTypH50SZ3JsySpkwBjg787J9Nz+4P3pWywV0g1n2CawcNB+FwuovIudVRh1x1yCGkamm9SnHlZEvtFIpXpjEPY0znHstofLj8uzHiCheTxRAnnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZuuBuR/K; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZuuBuR/K"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2400117dd80so1276975ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510302; x=1755115102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Jn8S/sdm+8bvzWJ6gbgYYHL6yp6bRqDxs3iW0RSe7uI=;
        b=ZuuBuR/K9xLC5JhgTwjiE14avrAtBxH2Jk+Y4+23C5SI0c/HDEI33Rw6jKG0UcP2Gy
         WQ7o9+WXKlH4pC5mgzr6AKEC90AswOTgV0qqIYA7dIG9GvNC04WJwb45a29LOcJ0MoC6
         APNDsgpnxRW3Imh86119UgQEOiEJicwW38+2619PXt8+LQgJ0qmhclk6UZ4ryF33Rihk
         SEi9d4DTrZyo0m0ImmsCRn2yU0cySAoFnzaelaPns6QIkc3GEgmKaI3wVITdTlc7PGGk
         066/lq9DYjtH5GDoQffWkphn/cX3tlAlhid4fs+W4g889WZxBIAltcyR7xtyFFqYhH6U
         cgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510302; x=1755115102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jn8S/sdm+8bvzWJ6gbgYYHL6yp6bRqDxs3iW0RSe7uI=;
        b=GRsut2hjLWwEqy8OFC3wktkrp+w9q4Ysp77+KjQnzxp9K/Scdv0vgAxNORmTYfFcnL
         HJ9BnL3MnoLRC35sIOBtuRD+kvTE0e2aBzR1PLpCDdH0kekUVuc83Qb694iOB5iGNHq9
         0Et9LySrachiOwU3ok/W/zoUtHnBJWx7QfcZrVeFTWhvJEvbgshz2zRN5teIlgoz8hAg
         R4ovypI/Ut/X5z6Q/RfjYPL5R5EGo5GfYw92eJexCbKu5GB7nnocWC2CSk1gLBz0Dlbb
         4mMHUkX09HNmQwUaCfiZ3QGhrSwafQZ7JQ/gJpQGEhovGLwKFLQf02QbDKo8qngSRn8e
         liqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiogpcddVve4TSHwkvHbE0rWpVgCHdy/2a6ALgRSqttmxg5ySR6KH5sdFHzOHixUArgYHqTEhYXxY8npapPQOy@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvrmg0tKZnBWnwYS0q6ZdWcJiohR8n6jCr4YBYILK3GtIxVpPc
	NOAyWRrCW39o1/BjUyA725zVOPi0kzyE5cO7QywAT/NvpW1EKmSsolzJFvSP+hk+BIAoMnhmam6
	AYGyS/Q==
X-Google-Smtp-Source: AGHT+IFo65jEdjZGUxY/vUUE9hB8u0/Ehm65nxno4lYpqINC12VaTwhwaABlYMWVK9zS/nrWWsDoA8ThjT4=
X-Received: from plha17.prod.google.com ([2002:a17:902:ecd1:b0:23f:d0e0:7e93])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2cf:b0:240:71ad:a454
 with SMTP id d9443c01a7336-2429f2d9e92mr70108355ad.1.1754510302251; Wed, 06
 Aug 2025 12:58:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:51 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-30-seanjc@google.com>
Subject: [PATCH v5 29/44] KVM: x86/pmu: Use BIT_ULL() instead of open coded equivalents
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

Replace a variety of "1ull << N" and "(u64)1 << N" snippets with BIT_ULL()
in the PMU code.

No functional change intended.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
[sean: split to separate patch, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/pmu.c       |  4 ++--
 arch/x86/kvm/vmx/pmu_intel.c | 15 ++++++---------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 96be2c3e0d65..b777c3743304 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -199,11 +199,11 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 					 kvm_pmu_cap.num_counters_gp);
 
 	if (pmu->version > 1) {
-		pmu->global_ctrl_rsvd = ~((1ull << pmu->nr_arch_gp_counters) - 1);
+		pmu->global_ctrl_rsvd = ~(BIT_ULL(pmu->nr_arch_gp_counters) - 1);
 		pmu->global_status_rsvd = pmu->global_ctrl_rsvd;
 	}
 
-	pmu->counter_bitmask[KVM_PMC_GP] = ((u64)1 << 48) - 1;
+	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;
 	pmu->reserved_bits = 0xfffffff000280000ull;
 	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
 	/* not applicable to AMD; but clean them to prevent any fall out */
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 98f7b45ea391..6352d029298c 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -536,11 +536,10 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 					 kvm_pmu_cap.num_counters_gp);
 	eax.split.bit_width = min_t(int, eax.split.bit_width,
 				    kvm_pmu_cap.bit_width_gp);
-	pmu->counter_bitmask[KVM_PMC_GP] = ((u64)1 << eax.split.bit_width) - 1;
+	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(eax.split.bit_width) - 1;
 	eax.split.mask_length = min_t(int, eax.split.mask_length,
 				      kvm_pmu_cap.events_mask_len);
-	pmu->available_event_types = ~entry->ebx &
-					((1ull << eax.split.mask_length) - 1);
+	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
 
 	if (pmu->version == 1) {
 		pmu->nr_arch_fixed_counters = 0;
@@ -549,16 +548,15 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 						    kvm_pmu_cap.num_counters_fixed);
 		edx.split.bit_width_fixed = min_t(int, edx.split.bit_width_fixed,
 						  kvm_pmu_cap.bit_width_fixed);
-		pmu->counter_bitmask[KVM_PMC_FIXED] =
-			((u64)1 << edx.split.bit_width_fixed) - 1;
+		pmu->counter_bitmask[KVM_PMC_FIXED] = BIT_ULL(edx.split.bit_width_fixed) - 1;
 	}
 
 	intel_pmu_enable_fixed_counter_bits(pmu, INTEL_FIXED_0_KERNEL |
 						 INTEL_FIXED_0_USER |
 						 INTEL_FIXED_0_ENABLE_PMI);
 
-	counter_rsvd = ~(((1ull << pmu->nr_arch_gp_counters) - 1) |
-		(((1ull << pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
+	counter_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
+			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
 	pmu->global_ctrl_rsvd = counter_rsvd;
 
 	/*
@@ -603,8 +601,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 			pmu->pebs_data_cfg_rsvd = ~0xff00000full;
 			intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_0_ADAPTIVE);
 		} else {
-			pmu->pebs_enable_rsvd =
-				~((1ull << pmu->nr_arch_gp_counters) - 1);
+			pmu->pebs_enable_rsvd = ~(BIT_ULL(pmu->nr_arch_gp_counters) - 1);
 		}
 	}
 }
-- 
2.50.1.565.gc32cd1483b-goog

