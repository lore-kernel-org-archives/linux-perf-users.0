Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6159F2E2EEB
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510331; cv=none; b=nDZwY6NuHkY6/3LKaiguKbxqfGkDcPZTAssxf7Jv+fr8n3awbdtU4IkWZeOTr3slx94Vm9szyFysIs4Uvtd2PkSryh28qcoEZZtsWsCPaKgQeljujzeNYLhShdy0IouAFsW1FEi2T6p6FREal8JvU1ItPPhHqujr0eXXrXhLbRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510331; c=relaxed/simple;
	bh=UqKbQ/MEitFcIh6oJaDa5iQaYpCTlGUBLK908ME1g4Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Li9oUe/0hvFp42x0tjWQQHhOoaTo2rTRTrj6Yxz/m/QZDin1bkPytNRT9dksAKsUBcqv1TK9M1UKUbhdSHH5rMyHdRDz7BwSuA2mwWnLWBpb+6dD7/K/0fln80sEkK29nqt7W4fgg6FLmWy9leKNn6mX4TTIHmpIlrnAgY65pwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4DFPLcrp; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4DFPLcrp"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b421b03d498so121698a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510328; x=1755115128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FEfQdODxvc/WYDgKcBJNCqpRp5QcBVEYBtlnYDr8f+A=;
        b=4DFPLcrpXC8nzPtT2ABri2kiMNcEVcSAxV5rGGrD+ycZK7+G/xw3XhsrSAq1GUn+KV
         c3mpEz7/DDiuZDG7GsCIPbif7RO/cx41LAnNr0vTSFC6UyiRf85KJwYiHHN+6gMvD2x3
         r/KZj9P6pt0zyfbT2R5csi8Lws+uVx2QP1ChHeoVC3qnHlqdtPqLRPMYbMDeSoA+untO
         RvTmh5AQsiEoV3GWBjr95m3BQ/5EUFHIiRvNkBOZmvg7CjaLz86K424skxFJa2S2WDzF
         5659bUKO7cI22AYTqU4s+3QVJ2DpO+fanRhX7RIBIsPgxSskBdF4PvKFLbevBywWkkOk
         jgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510328; x=1755115128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEfQdODxvc/WYDgKcBJNCqpRp5QcBVEYBtlnYDr8f+A=;
        b=Q2n2dJfYtfGs0MfKtuTXrkJHRxyLh6o+MO0rh9PKbS+9TetLhGRQPAzs4HaeXKnaaQ
         2y8RVwgPWEcjSJlh92thGHpSwhtTfh0B+c8ZV5PZGRZlvyoAaNpbLcrKDlhy001aRNN/
         MgL+QEYudIIs3NMsitkqWKNhvVPMiQSooWzcrD+7yf03mclCVkV3NF19fi/nsoWppjqb
         mzMz2dbjxozXkWyUzQIpQWiPO+IihSysLPB2Ne134mWyCdWq61gsblF7GcxQuTsy+OoR
         iH38+tzeA0cmjhSRTtiLDtqrB4y6Bxp9sRU29qttAWf6scQH9PU8fQddNSh3wQs7VVte
         x4xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKS4/KPL5mfJzXExMCPZvh1fZ1u5mDpzhgpNNxFjHECtapMN2QpT97zhPmPFMuZbL1c7dFXoIoHXtleRXekeHp@vger.kernel.org
X-Gm-Message-State: AOJu0YyLZeCdFVfRB8IT7CNJnH8laba3sxBogFwWHx39WL15+arkZjrG
	jkqJRaMhAPuCXTqFJKfR6EQc7rCDTkeE3mVyi+Dzvs8DRxSEHHAh5hx69TxGfEJBX9XPo8y5JHW
	iWnjPlg==
X-Google-Smtp-Source: AGHT+IHKT98t7sh+NJ88sddK4YezK7lHLHfrTfL2AYLv+RO+SAkhLkiCccC37Go9T+seI3ZwHUra06wFxFw=
X-Received: from plbmp11.prod.google.com ([2002:a17:902:fd0b:b0:23f:fa41:1de3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3bcc:b0:234:c8ec:51b5
 with SMTP id d9443c01a7336-242a0bffb31mr47813405ad.53.1754510327813; Wed, 06
 Aug 2025 12:58:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:57:06 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-45-seanjc@google.com>
Subject: [PATCH v5 44/44] KVM: x86/pmu: Elide WRMSRs when loading guest PMCs
 if values already match
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

When loading a mediated PMU state, elide the WRMSRs to load PMCs with the
guest's value if the value in hardware already matches the guest's value.
For the relatively common case where neither the guest nor the host is
actively using the PMU, i.e. when all/many counters are '0', eliding the
WRMSRs reduces the latency of handling VM-Exit by a measurable amount
(WRMSR is significantly more expensive than RDPMC).

As measured by KVM-Unit-Tests' CPUID VM-Exit testcase, this provides a
a ~25% reduction in latency (4k => 3k cycles) on Intel Emerald Rapids,
and a ~13% reduction (6.2k => 5.3k cycles) on AMD Turing.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index ddab1630a978..0e5048ae86fa 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1299,13 +1299,15 @@ static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
 	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
 		pmc = &pmu->gp_counters[i];
 
-		wrmsrl(gp_counter_msr(i), pmc->counter);
+		if (pmc->counter != rdpmc(i))
+			wrmsrl(gp_counter_msr(i), pmc->counter);
 		wrmsrl(gp_eventsel_msr(i), pmc->eventsel_hw);
 	}
 	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
 		pmc = &pmu->fixed_counters[i];
 
-		wrmsrl(fixed_counter_msr(i), pmc->counter);
+		if (pmc->counter != rdpmc(INTEL_PMC_FIXED_RDPMC_BASE | i))
+			wrmsrl(fixed_counter_msr(i), pmc->counter);
 	}
 }
 
-- 
2.50.1.565.gc32cd1483b-goog

