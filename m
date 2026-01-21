Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF542B73E
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036114; cv=none; b=ZAfGM9j5MKCgZ4uFNimuiaIkjdnaP6I0zurRRAH44txUZsLXf6brHtbxFx4fTZRUyOqrLzz0w46dZ7NLCSy5hRcMF5//x5OJZBXPH8BOMDnza6XL0uj2o/8p8eONlSdWTLqhqnKS6WgikSkVE9d2DODQH1rVJaXzKh+PbBTl3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036114; c=relaxed/simple;
	bh=eLiijBQvPYZP6MiOgHZ396bWTv5T0sqkDVoO56oopeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cxNonVugkxuR2L7gw27gAGCUFUkKt0Xgt+B2N1LZnJlqJAR07Xtq0Buah5WPuRDagLTFeDATXqJL4DGP/w+8E8NP+4buqHDDAUanrVjjcjkFjLwyBznr6rOJr1vKszSFrjmpiOvfRUp3S/1XLgc5E+RDP70I84vtRWbyy8dDUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dDjn+3ty; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDjn+3ty"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34ac819b2f2so325019a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 14:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769036108; x=1769640908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eo4w6WPgEag9hYMxl6UJDX8Oqwe0fHdOT48tYz5B9VA=;
        b=dDjn+3tyZrkm5IsFL4KUBMFVzoPRGltw9JAvI9tOWo+Oh57Sf6uRX2FT1jKdeNarke
         rereMcI+1/YoFQmqhEYJZ8DnJeyAcXYV4T7LDr9kGn9PH/+nVb24FpTi2rZ+qDzYl2Bu
         HL3c69yhDtNnfA8PDznXDPRZG+coBEt/fWQfAoTzcqagsZ6HFshO67hLYp2FkG9x/LMT
         kt6GfNSTOD9FWq2iH5BWdOreeABm0A0Vd/2uokF3/wPIRMzhwQvbUVDA06cSBJxKxW7/
         0cO+0IG3nEUilSICd2A0dQeFRL6E0u007c8vLipenuxg0E574AxmS+QfRySy4fbwpWj5
         LLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769036108; x=1769640908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eo4w6WPgEag9hYMxl6UJDX8Oqwe0fHdOT48tYz5B9VA=;
        b=nCVoG8kb+AKTCTBKuKrUPLLgzrBpjKqYQGJ+Q/tSpzeWATem5sxJdaGaKqJQIcRPku
         Fd9yyInjrQMfTXrvFxkVncRvUFNlxXFY3VKHK7nDu0g9mPTIw7IoMSzeVvXZiFVVsKQQ
         sVsM7FDipY2DbHUyEP8EQvgzHx3xiend4cobb8bSlg8rkhdri/makasczG1XzF1QPpU2
         RlBzDzut7nphkTWit/zwvs/Kc/oknTH0w473PlPr7NvgMvVsvc6tVzAfkw7SSXB2hdQ7
         Z/8qQrA+nZnSQbuPsGSKmCgJTigD88AboTDkbw9UYfOCuyBCF+oOabHqgan3MTKO6/6l
         edhw==
X-Forwarded-Encrypted: i=1; AJvYcCVHzDRPbKxaXyoynLpYB/BAqawgmBYaRI3Ubz2kcOWvQHDb5F3Jd1Wd3PfHrypcIG/gQyrIi7ISyIjEAhsw54ug@vger.kernel.org
X-Gm-Message-State: AOJu0YzBF+hMVgM1oNIyRp6R7J856M8a28Xent3FjpvmVLtwfjC/xzks
	fsNoxiLw250CfMbbuCkLvM1Lp6CwG4oQQe/6x7TSady2SCxZX54hldBaRJhYk2xqqdtVHu7oBsc
	STcZjW16U6qAhaQ==
X-Received: from pjyj8.prod.google.com ([2002:a17:90a:e608:b0:34e:90d2:55c0])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3950:b0:340:bc27:97bd with SMTP id 98e67ed59e1d1-352c3e49bc7mr5864249a91.9.1769036108004;
 Wed, 21 Jan 2026 14:55:08 -0800 (PST)
Date: Wed, 21 Jan 2026 14:54:01 -0800
In-Reply-To: <20260121225438.3908422-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121225438.3908422-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121225438.3908422-4-jmattson@google.com>
Subject: [PATCH 3/6] KVM: x86/pmu: Track enabled AMD PMCs with Host-Only xor
 Guest-Only bits set
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add pmc_hostonly and pmc_guestonly bitmaps to struct kvm_pmu to track which
guest-enabled performance counters have just one of the Host-Only and
Guest-Only event selector bits set. PMCs that are disabled, have neither
HG_ONLY bit set, or have both HG_ONLY bits set are not tracked, because
they don't require special handling at vCPU state transitions.

Update the bitmaps when the guest writes to an event selector MSR.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/kvm_host.h |  4 ++++
 arch/x86/kvm/pmu.c              |  2 ++
 arch/x86/kvm/svm/pmu.c          | 28 ++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ecd4019b84b7..92050f76f84b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -593,6 +593,10 @@ struct kvm_pmu {
 	DECLARE_BITMAP(pmc_counting_instructions, X86_PMC_IDX_MAX);
 	DECLARE_BITMAP(pmc_counting_branches, X86_PMC_IDX_MAX);
 
+	/* AMD only: track PMCs with Host-Only or Guest-Only bits set */
+	DECLARE_BITMAP(pmc_hostonly, X86_PMC_IDX_MAX);
+	DECLARE_BITMAP(pmc_guestonly, X86_PMC_IDX_MAX);
+
 	u64 ds_area;
 	u64 pebs_enable;
 	u64 pebs_enable_rsvd;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index bd6b785cf261..833ee2ecd43f 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -921,6 +921,8 @@ static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 	pmu->need_cleanup = false;
 
 	bitmap_zero(pmu->reprogram_pmi, X86_PMC_IDX_MAX);
+	bitmap_zero(pmu->pmc_hostonly, X86_PMC_IDX_MAX);
+	bitmap_zero(pmu->pmc_guestonly, X86_PMC_IDX_MAX);
 
 	kvm_for_each_pmc(pmu, pmc, i, pmu->all_valid_pmc_idx) {
 		pmc_stop_counter(pmc);
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index f619417557f9..c06013e2b4b1 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -147,6 +147,33 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 1;
 }
 
+static void amd_pmu_update_hg_bitmaps(struct kvm_pmc *pmc)
+{
+	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
+	u64 eventsel = pmc->eventsel;
+
+	if (!(eventsel & ARCH_PERFMON_EVENTSEL_ENABLE)) {
+		bitmap_clear(pmu->pmc_hostonly, pmc->idx, 1);
+		bitmap_clear(pmu->pmc_guestonly, pmc->idx, 1);
+		return;
+	}
+
+	switch (eventsel & AMD64_EVENTSEL_HG_ONLY) {
+	case AMD64_EVENTSEL_HOSTONLY:
+		bitmap_set(pmu->pmc_hostonly, pmc->idx, 1);
+		bitmap_clear(pmu->pmc_guestonly, pmc->idx, 1);
+		break;
+	case AMD64_EVENTSEL_GUESTONLY:
+		bitmap_clear(pmu->pmc_hostonly, pmc->idx, 1);
+		bitmap_set(pmu->pmc_guestonly, pmc->idx, 1);
+		break;
+	default:
+		bitmap_clear(pmu->pmc_hostonly, pmc->idx, 1);
+		bitmap_clear(pmu->pmc_guestonly, pmc->idx, 1);
+		break;
+	}
+}
+
 static bool amd_pmu_dormant_hg_event(struct kvm_pmc *pmc)
 {
 	u64 hg_only = pmc->eventsel & AMD64_EVENTSEL_HG_ONLY;
@@ -196,6 +223,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (data != pmc->eventsel) {
 			pmc->eventsel = data;
 			amd_pmu_set_eventsel_hw(pmc);
+			amd_pmu_update_hg_bitmaps(pmc);
 			kvm_pmu_request_counter_reprogram(pmc);
 		}
 		return 0;
-- 
2.52.0.457.g6b5491de43-goog

