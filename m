Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EA22D1F69
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510289; cv=none; b=aCUfwdY9GXwJYSXZcTiEH0iI1fwo6osBtcu3Yy3Hp2Wi74ZOahT/RXLSkTYVaclrCLXBFq7oldjmgjr/xWS1Ho+D9FkPD7teXDPhZG2eZzqEZMBxpx7g1sIo3oyS3W33mOakRQenMkbLi4KtRLsH5DybuptRJe8uliKlk9tSJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510289; c=relaxed/simple;
	bh=JJbKDILTxe6TmmJfqZTBwaNtNaEK5gYeJU99RMfSqbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VHITAwI55voaD6QXbSsd5EigVBkoj8oZ5d7UGLRNKcZVMzexXbgE1vdiN1MWKv7BTlXlQBLDuvXrbbmdV9zr0wSiqXMAd5IMMbmMjj009/HvHzY6Xlz39R4OdGxB36kOhgLGpx+ZR+mRIyljRksgVlsQYOnzOTdeVfyYf+qOFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NG8S4guY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NG8S4guY"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23ff6e5c131so1300045ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510286; x=1755115086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UYs6XLsbq3wmUfEBezJ9021CIzqcfmK4yWnl0Vk41Lo=;
        b=NG8S4guYhFZftTktJx/3KraRGl4TJTLFugM4i7pwjurAOwU/SkdbsSkn90UKJtwpQI
         C//Co/NmazMiKi2lQ6RxGdwbd48IElHyj1pXD768S5sMAHnVIULfX94Q2R4IUP7+rijk
         P424HtPw7w6KfCG1M8s/xsS8LKQHogpgt1oUjPMKx1nPS2igK9gEneM5QoUtXBz/n5+Y
         bLP/CQ9CuWuZcE6n8/yaZRGicBj1TPg6i1S9CbRMM/4DNmK0AGk8/6e8NZcytVCVx2EC
         8gq9KGpcwmpD5+zkOf22AHSgvp9JK0YLM9SI3xUPRGoWBgDsIluo+QTQWvsM2EKCOuyR
         Xlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510286; x=1755115086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYs6XLsbq3wmUfEBezJ9021CIzqcfmK4yWnl0Vk41Lo=;
        b=C+0JpejlfGWemdqHaaIVtWIODlpnuAds1Mr38z7nHY2KIItYwf7lRspmIRzAGWIyJ+
         /PkbwNsrx8ylQYW5d3WyA+xCuV8FWaFyB5zch4jH3WMNWrUtrurD2O22iTxdBbb+Q/XM
         0fPMGgJK0TyVMbXGwpY8NRsrMOlgDCQItNuZlNn70b4U1bUhAoUZqJypMtboHk2VbA9Y
         lfn3hwjkg4a3cET1q+iW4Kjnbkzl34eZZm9bVESiP3jftgv2i5tEUFCY4HhUk10TOoMC
         WpfSHgPt3pTO9nsS3qyM9MtMI8H7HE4jikYDZsjttlZqIfvJenEIGi+Xr/07P9BxyRdB
         qOSA==
X-Forwarded-Encrypted: i=1; AJvYcCXY2zE+m7RxQ3RwTYBbsKL1N4e//7ZVR51+10BMmKwbMdOzWaGHDgUQfnTAfNE2Emk/VCEcrc6jBI6wDlHg0f5M@vger.kernel.org
X-Gm-Message-State: AOJu0YyClIW1QbdMdw5/CWw2qRedQsXjNHUOwTqTMwBWkmi2mbeWUt9r
	szhtDZI4Nce46roqKxZw1ENtHlRDnPIsZnYDLutV27R32ZpRQrCq0WeehC1lwJ2gHf5vLup4L5r
	PHme9IA==
X-Google-Smtp-Source: AGHT+IEjtNNsSzvoH0/VB3MvaueTobKjhNGxenKGyVkg+/CWGpyESmYfNsRK9kQsugEnvTMUeRjISaSTO8s=
X-Received: from pjov3.prod.google.com ([2002:a17:90a:9603:b0:31c:2fe4:33b6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b44:b0:240:b28:22a3
 with SMTP id d9443c01a7336-242b1a687dfmr5147985ad.29.1754510285965; Wed, 06
 Aug 2025 12:58:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:42 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-21-seanjc@google.com>
Subject: [PATCH v5 20/44] KVM: x86/pmu: Implement AMD mediated PMU requirements
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

Require host PMU version 2+ for AMD mediated PMU support, as
PERF_GLOBAL_CTRL and friends are hard requirements for the mediated PMU.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
[sean: extract to separate patch, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/pmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 7b8577f3c57a..96be2c3e0d65 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -227,6 +227,11 @@ static void amd_pmu_init(struct kvm_vcpu *vcpu)
 	}
 }
 
+static bool amd_pmu_is_mediated_pmu_supported(struct x86_pmu_capability *host_pmu)
+{
+	return host_pmu->version >= 2;
+}
+
 struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.rdpmc_ecx_to_pmc = amd_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = amd_msr_idx_to_pmc,
@@ -236,6 +241,9 @@ struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.set_msr = amd_pmu_set_msr,
 	.refresh = amd_pmu_refresh,
 	.init = amd_pmu_init,
+
+	.is_mediated_pmu_supported = amd_pmu_is_mediated_pmu_supported,
+
 	.EVENTSEL_EVENT = AMD64_EVENTSEL_EVENT,
 	.MAX_NR_GP_COUNTERS = KVM_MAX_NR_AMD_GP_COUNTERS,
 	.MIN_NR_GP_COUNTERS = AMD64_NUM_COUNTERS,
-- 
2.50.1.565.gc32cd1483b-goog

