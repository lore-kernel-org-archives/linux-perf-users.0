Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B72142E62
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488459; cv=none; b=nYtuvxxFYdf+konoCS14+TtUrgoCzbrNLUPYnUpwoM9KBGydIixabAIAKnzHA/fKuEtHc0X1hpSOYrUDOW//AMDkcuB5eNhFcSK+XM3S9ftrFEjrINhFX/3SLVdABtMIlKtBkH2KxInfcNvJvO2BIeJwQaakLfF2LyMFl3Zi7jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488459; c=relaxed/simple;
	bh=rFp2g1SMteC67ga0HvXSMTdcgESu5ZuQ9UForgZgVWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ExMUDazpSphZFBqRb4AnXrqVfQsJQCfUgrmnsLqzAzesPNmaz0/aFunajwtND/oTpQAHqtkxWjI+GLXHaz1vQNz8/GaZ0p+k8k3tnwDh2u244lpP+yp80TpCBvp6j44gY7jCE0QGTMdrZjGyrMeQh/z+XHejyy6y5End58eZb6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c23YvgE1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c23YvgE1"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2cb4d02f34cso6567706a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488458; x=1723093258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=l8nLk/LSkHQ4nrGTbHoBdPhfqphQ88KWleGa+/sy98o=;
        b=c23YvgE1Nsz9TcCipakFlu1gQ3OoftQyjO3J665votWWNdUqZ0xfEUXv7rOSadiceS
         Zx66/u5TsF2WExc6mCKMddT4WuFcRWi8gctHjgcavpTTvfwV7Qv4226DwhFgozfsjPMJ
         yx2UfhWRH8RO8t+Jk1KTgz6PRwgAfJc6gJLhPdAc6wUPrahu0FVVyn3yeze3RSeKfkCH
         +52ktxLeCXm+5NmjhStYLenhANmQr/A4TeLyoW0icRJavoqLg77BPgw5TWtgEsgBAHhr
         Td9RiUh0/hG9oAFne1zK/pICi0VVc5CXSx+Q2O568a6F4pSEb8xJ0Tvdb+E/VnX2ttM0
         PF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488458; x=1723093258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8nLk/LSkHQ4nrGTbHoBdPhfqphQ88KWleGa+/sy98o=;
        b=krVWWDwbrXtzIbyBiVAVNRlyX/tU1XfaUlmd2SZw6wL5x2PQpypPAF8W1g579ww2Es
         MhwVkSnkREUvXBZB8HLNGPN1Af4/q8HQd8B/VGzC8Xii4+OUrdbc+X7PcEwbyZdyQADb
         m+ceVrc1yvDaMm32XX3lTm9WVYoE+bF6N7QrZKP8mIE2FTYkfOyGr06lmcIAiPxKiVY0
         Hf0BDx6Mvy1IPNv+GmjDWtYrOeNnAbe0RNFvk6sZojJxno0Hm3YNi2Q0n8zZ3q3ZFum6
         bxp6xGAb64g+Ul/wXKqlMLEwmKgSoJ14t3Dbt3WvfXwE6/62SK1SkqLkYitbk71pNlwk
         /CoA==
X-Forwarded-Encrypted: i=1; AJvYcCUfonsEJpNuNqz0cBQO7U7V4r8NhdxYjNzDpOOJKz0LzsAWPeJZaDD00l4cRhgz5sJwOyWvjIFnAaiML5SAxVoBGLW2Vq62j2jU3XZDCpkXOw==
X-Gm-Message-State: AOJu0YyUaBYxFSVCMdXtHkSkzVO3KBCLManTq9aSI2V+FXOb3ppZTAY0
	k0rDBl8jUwamT0vXXDqrKUawPo6xVdaUVYxnbCm9s9DjLzgf2BPsELD7fiEPBE2Z5dgFmgJJYkF
	nomReTA==
X-Google-Smtp-Source: AGHT+IFYttR/L8EQ2gsQZV8ThmFF2D60A1iub9UHBECx0FOvbVcyN0ESaoIsP44EN0FK6nV8frsUwciHF01m
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a17:90a:2cc2:b0:2c3:1985:e9c3 with SMTP id
 98e67ed59e1d1-2cfe79245e9mr3146a91.3.1722488457660; Wed, 31 Jul 2024 22:00:57
 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:59:06 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-58-mizhang@google.com>
Subject: [RFC PATCH v3 57/58] KVM: x86/pmu/svm: Implement callback to
 increment counters
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

From: Sandipan Das <sandipan.das@amd.com>

Implement the AMD-specific callback for passthrough PMU that increments
counters for cases such as instruction emulation. A PMI will also be
injected if the increment results in an overflow.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/svm/pmu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 9f3e910ee453..70465903ef1e 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -346,6 +346,17 @@ static void amd_restore_pmu_context(struct kvm_vcpu *vcpu)
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, pmu->global_ctrl);
 }
 
+static bool amd_incr_counter(struct kvm_pmc *pmc)
+{
+	pmc->counter += 1;
+	pmc->counter &= pmc_bitmask(pmc);
+
+	if (!pmc->counter)
+		return true;
+
+	return false;
+}
+
 struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.rdpmc_ecx_to_pmc = amd_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = amd_msr_idx_to_pmc,
@@ -359,6 +370,7 @@ struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.passthrough_pmu_msrs = amd_passthrough_pmu_msrs,
 	.save_pmu_context = amd_save_pmu_context,
 	.restore_pmu_context = amd_restore_pmu_context,
+	.incr_counter = amd_incr_counter,
 	.EVENTSEL_EVENT = AMD64_EVENTSEL_EVENT,
 	.MAX_NR_GP_COUNTERS = KVM_AMD_PMC_MAX_GENERIC,
 	.MIN_NR_GP_COUNTERS = AMD64_NUM_COUNTERS,
-- 
2.46.0.rc1.232.g9752f9e123-goog

