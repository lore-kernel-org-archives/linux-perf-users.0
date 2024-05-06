Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238A4143863
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973495; cv=none; b=eUuG+Z5Piv+GtmwjCiWSHQYNH0VOYqyKkhrKLFNfEkWshiPa0lqP9zt3r5xn5bmh+N21X/EClbxFT2dizIRmkblDSwFv/WCfbHaGyT/dDBEHu83JpNGc0WgBtJEhsXWRw6/TP4epxbF/+LZKx6oAJHMO64maBZf0iadCnJ6Ssec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973495; c=relaxed/simple;
	bh=HD1onq+BM7vYR58gsYAJg5M2X2pNaaeWilUMXxocmNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RNh0uygNCPQzYkA7n49ggPzx/JAiPQ6pUzUUtE+DJm2GIKtM4eamqKxzvb9YxuwsjPGJvTzMjYiM7rLFDZVWuwE5kul0iYYmR0D7xVhvjDDoXsc4TmFc9BeWQWvZpvIVDGBBWUyzGBJmSeZf13m2Vb5AMqKzteQEbnTcWK+Fj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hpkyk/Ki; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hpkyk/Ki"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b3756e6333so2197813a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973493; x=1715578293; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=C0JCnLRPCbODnXYFpihmXgFKGkWQHr1nsLQGrDq6KcE=;
        b=hpkyk/KipJg+3wQDdc3C0XM3e7EAH3OGUXyPEcGK502/eIVJ/FmY7OFcIyuXEPCDdW
         4XQnBj9BBPVmU7LaZXxyiOdTSCMfmqFBZhIv33099Jv4A30QR9e7uN15egDSxJjOAacq
         lIAuus751yRHbwbE3uCctKoZVLHkA2c5xnesCV1hJuLEcMGF8JzLrj5m4E8X+IM+wS7s
         I+FodPgcmZx5Mi5xIl5V37Ai4/wJtydUTldpMp4dFukJKUT4yt2AITbHoRYG9io4kjv7
         7D3eQmNLfBrt2bXLmMBQLC3qdhDoyLsPTo0kJW75ZKzaiCf0zifZ/ZfR224MN9ROOqtN
         BxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973493; x=1715578293;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0JCnLRPCbODnXYFpihmXgFKGkWQHr1nsLQGrDq6KcE=;
        b=wTFa46Qiim3ZnIkInQSqusNtuJbp8IWzJqLcWPfilb5XwNrbKRRFIE1oooaCUkrGJe
         /IXdSAWqx+MMbG9Jtll5RkKoOcJMYsNOWkF1Iwn3Chlx4AivGP+EuDVglrKysPX1Ap+T
         Kp7dis9c/0kVMDJYvtHLM1jMGrohoZo5ZP1YxVotL4iglze/pZTTtO61wgITs3VqGLn1
         BZUzkgN7qFjPue0HVK/UZG7ZkutRrFCHlpRCTsOyC9KlS8ekCt6IUvidyf9Bb2jEF4LI
         ed4WRE6QPaXrYzfMw82VCuNBe7ejKJuiv5Lz9Q5rNwb1Xc4YXGlAUKO7fD2nlduco0A9
         0fzg==
X-Forwarded-Encrypted: i=1; AJvYcCWajbmUvCg8TL9PnY7UhMV8dOUNIhUMt0CsLDUh2QCkt4tIz3Ji8ATISGEOClbiryT3oOtf2j4QszI/f+nOYanVEWyVg3iLZ51bSyBZ8+vmXw==
X-Gm-Message-State: AOJu0Yye79lO06cNbbg/DonwZQECkQI0AFTJj88IWCu0u2Ro+ojt6atQ
	3mvSwpApCPkKFx0dI99X9eulxMu28cWPCkfioranSClwyes2bdJd0fnqQEI0xFrD+KFfKU58nxL
	bAGIkGQ==
X-Google-Smtp-Source: AGHT+IFSTATZx92lr0Fqgyn401mL0nwJMHp0HmidDShAyEYFxJ7lIm81SMBUOz/vcz6u75ELYSoQV3OtBOLl
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a17:90a:f692:b0:2a3:8648:c8a4 with SMTP id
 cl18-20020a17090af69200b002a38648c8a4mr30515pjb.0.1714973493414; Sun, 05 May
 2024 22:31:33 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:30:00 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-36-mizhang@google.com>
Subject: [PATCH v2 35/54] KVM: x86/pmu: Exclude existing vLBR logic from the
 passthrough PMU
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

Excluding existing vLBR logic from the passthrough PMU because the it does
not support LBR related MSRs. So to avoid any side effect, do not call
vLBR related code in both vcpu_enter_guest() and pmi injection function.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 13 ++++++++-----
 arch/x86/kvm/vmx/vmx.c       |  2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index f0f99f5c21c5..6db759147896 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -660,13 +660,16 @@ static void intel_pmu_legacy_freezing_lbrs_on_pmi(struct kvm_vcpu *vcpu)
 
 static void intel_pmu_deliver_pmi(struct kvm_vcpu *vcpu)
 {
-	u8 version = vcpu_to_pmu(vcpu)->version;
+	u8 version;
 
-	if (!intel_pmu_lbr_is_enabled(vcpu))
-		return;
+	if (!is_passthrough_pmu_enabled(vcpu)) {
+		if (!intel_pmu_lbr_is_enabled(vcpu))
+			return;
 
-	if (version > 1 && version < 4)
-		intel_pmu_legacy_freezing_lbrs_on_pmi(vcpu);
+		version = vcpu_to_pmu(vcpu)->version;
+		if (version > 1 && version < 4)
+			intel_pmu_legacy_freezing_lbrs_on_pmi(vcpu);
+	}
 }
 
 static void vmx_update_intercept_for_lbr_msrs(struct kvm_vcpu *vcpu, bool set)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c86b768743a9..b6ed3ccdf1af 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7525,7 +7525,7 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 	pt_guest_enter(vmx);
 
 	atomic_switch_perf_msrs(vmx);
-	if (intel_pmu_lbr_is_enabled(vcpu))
+	if (!is_passthrough_pmu_enabled(&vmx->vcpu) && intel_pmu_lbr_is_enabled(vcpu))
 		vmx_passthrough_lbr_msrs(vcpu);
 
 	if (enable_preemption_timer)
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

