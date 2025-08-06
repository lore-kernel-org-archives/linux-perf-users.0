Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3492BEC29
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510314; cv=none; b=K7mNwd7qvdR9a+Ssnzz8+f+x2X9A/y528K2wo4mHtteP6JHbY8x+ep8YusM4T2x41Bs5wdUGrJpAT+iytzU683cAV1EUyWTS2oj1lI9WbBoukwhLz5l/EUL93B+7pNjJ/CgmE9soODZUxg+PnK+tVoHheTvGb7wmel+DAelbtNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510314; c=relaxed/simple;
	bh=4kQYudPfi5zx6gImzIgwc5QaKlQ7/lxrNTieFP93BO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bNa+EQUDpaeAy6nD6yCpQcAZrXXxaqNRG6nvgMBYhG7IvnUdk+YgRnSI2TgG8mkrj28VEuj9AESkNpdqb83qS2SRkJ0DTlyebWJC+yW/45HeSrv9fTWS9w1KqVu0CAGUgBGQ0L5/SV6jtzek+mb+qzOc4JphxGNPsC2j1j63XXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dQ5Dy7OP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQ5Dy7OP"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32147620790so266038a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510312; x=1755115112; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xm7g2YivXo6aQ0SA/h1DnHmIX017hVekqEmykFx3Fp8=;
        b=dQ5Dy7OPBZKOeslU30/Ty2nevmSlbyuAVWGlGPSo8iRtTTdIllWsmpyMaXEiR107Ka
         5DauRKz0J/vblo45Z7vRb8BjqxivKxH1i+droia/sGoL6swt6gFx4QPi9oudJr0SNldl
         Dm+njJy/t/t3sLIEhwJn6qYSmq7DNytq3MdfiEwHfpL4no+QiYg/fpm8xm6cZjE/BBLE
         4AeQVI2mvCtk40pE4TC4ctCmQMdAldCWh8Kl8UX3DTYPPAWKo+qbC927+uKkUF6LEutA
         I9j0EAp1T/yojeL/Pb1GiPohuhh4WA90MM3CeUaptCKfDqS19xJ1Eb/+ssWnovfSM+Aa
         lvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510312; x=1755115112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xm7g2YivXo6aQ0SA/h1DnHmIX017hVekqEmykFx3Fp8=;
        b=MBRYl9IIRbBaXTmYT8ybmA0p9GpTcGLtuOBxLH9zpcuNdyWpcj7dgrEtLd9xc3J8Nv
         I6bR18BTR9cJXcjUMhdsEyTr4VmDxeF7UCEwNWE9EH99RKgJ7rwdYDWxDZJZURPw071C
         tY6maGvS7yHscaOwTfYtY/E5y56ZsKI0CmZWfT8sLh66kX6T5DR9mtdRUtVzh8b0etF7
         7O/IuuyJ8BF0ItbRYdeZmH2ItTcQPp+U1LgeuApxOPJX0A+tTxoVIl0/tanaSYjRCCji
         8BymrJU8owDK6qIM+dUQmj47rIRZRXXA12tEI4M1MRuBM98xr+d6GHD+M81zLVkFFn0y
         XO5g==
X-Forwarded-Encrypted: i=1; AJvYcCXvrz5eJpqEB+xgJhgymNjEOVrBOlF6bugNzwXYhdBHugfzaiHEadwcz9NfWXMb0K7x5D5uVbq59U8fqMFEb/SK@vger.kernel.org
X-Gm-Message-State: AOJu0YzEiAyoSav+EiW+vc7TDGdQJ3wapic7u44x1NU0jDWXlI5jbi9c
	Ibded+dRtmCRMUdc8+F9f7boyJxul6+7KwdKKg24n1JRKMLT3nm+EyFT+Q4VACSvpUlBX/yZFex
	iAdcWOg==
X-Google-Smtp-Source: AGHT+IEYZIIJpt/ZXd2reg+ZYe1ccOM3EaPSbjMXbuV7EDQKePHF+PpZ3A2kJS4xCp7zKjQzYF60hKA/y+o=
X-Received: from pjbok13.prod.google.com ([2002:a17:90b:1d4d:b0:31c:2fe4:33bc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fc4:b0:31f:867:d6b4
 with SMTP id 98e67ed59e1d1-321694b7c0dmr5279932a91.10.1754510312321; Wed, 06
 Aug 2025 12:58:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:57 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-36-seanjc@google.com>
Subject: [PATCH v5 35/44] KVM: x86/pmu: Reprogram mediated PMU event selectors
 on event filter updates
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

Refresh the event selectors that are programmed into hardware when a PMC
is "reprogrammed" for a mediated PMU, i.e. if userspace changes the PMU
event filters

Note, KVM doesn't utilize the reprogramming infrastructure to handle
counter overflow for mediated PMUs, as there's no need to reprogram a
non-existent perf event.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
[sean: add a helper to document behavior, split patch and rewrite changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index e39ae37f0280..b4c6a7704a01 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -518,6 +518,25 @@ static bool pmc_is_event_allowed(struct kvm_pmc *pmc)
 	return is_fixed_event_allowed(filter, pmc->idx);
 }
 
+static void kvm_mediated_pmu_refresh_event_filter(struct kvm_pmc *pmc)
+{
+	bool allowed = pmc_is_event_allowed(pmc);
+	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
+
+	if (pmc_is_gp(pmc)) {
+		pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
+		if (allowed)
+			pmc->eventsel_hw |= pmc->eventsel &
+					    ARCH_PERFMON_EVENTSEL_ENABLE;
+	} else {
+		u64 mask = intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX, 0xf);
+
+		pmu->fixed_ctr_ctrl_hw &= ~mask;
+		if (allowed)
+			pmu->fixed_ctr_ctrl_hw |= pmu->fixed_ctr_ctrl & mask;
+	}
+}
+
 static int reprogram_counter(struct kvm_pmc *pmc)
 {
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
@@ -526,6 +545,11 @@ static int reprogram_counter(struct kvm_pmc *pmc)
 	bool emulate_overflow;
 	u8 fixed_ctr_ctrl;
 
+	if (kvm_vcpu_has_mediated_pmu(pmu_to_vcpu(pmu))) {
+		kvm_mediated_pmu_refresh_event_filter(pmc);
+		return 0;
+	}
+
 	emulate_overflow = pmc_pause_counter(pmc);
 
 	if (!pmc_is_globally_enabled(pmc) || !pmc_is_locally_enabled(pmc) ||
-- 
2.50.1.565.gc32cd1483b-goog

