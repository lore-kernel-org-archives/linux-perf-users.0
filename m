Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE23A43E9CB
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036113; cv=none; b=vBxpgYfnaQgA4Xz+956apxgjWiK4vCCMOv7d4LRXrZxw50RypPrxjtA7U3jmffym5kUWWx+wrrapbVRed6jE8JX0gnVA8wlGTLyXeDoh6xPuwbPTfucCBb8gL4gh6+jSa//N0RBXXqCGS2IQ/IEj8jEKLIXle60lWCsT1L/ffvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036113; c=relaxed/simple;
	bh=Pk/3QwlgAbVKnYQPlfuyPgZDvQuA1ZpRf9r+jYY8pfQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OZ6JAaJnTrmdeD5Qyrp5AwnLkeRd37742u5XI/xEGsuBvc3vbnOs06rW1IqO4aiMt2blSbZk/ukMEpiX/L/mcL5UHcHEV6D2umzIYmtDCZBx0r3Sn8vw3ikOIfos0m972rn7itK5bVqHFMB7gFqTrtcxbwKjiqMuuEZhXNY7SrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=blT4m+/B; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="blT4m+/B"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34ea5074935so282575a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 14:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769036106; x=1769640906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HMs2hdc0hNqNKtUHLf8UfyYdyy8QH+t4ULVxDyYCi60=;
        b=blT4m+/BSEqVX3S/YUpCMTs4CbXTOZtziwFx6dwktDIMfbU/4HF/6yxvArLL+E7QYS
         w/UXg6qsGfeg/MST3MpH2PGCcFMch2FzDyFTNfPZsK0ob/H2BPHn6OXa6vt9eCYEBZ75
         1ba1mwlYf+6nnQmAzzaOWjjQVqTO3YrKatyUCD+eDNk1idPNV57HqOAZVlhFwR7HZfDm
         sUfAxOXWaAEOtthBlNMwhVcpL6/LfiYgt50dpssSXHRMKKwY8ERR/lN8gK6BpFRLpire
         HxqrRwrdxA46oChrKwpTSDDGY0GJx+islo3OkWoQ6CfPGkuM5zR0yjyajuVX7ftvsghE
         zcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769036106; x=1769640906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMs2hdc0hNqNKtUHLf8UfyYdyy8QH+t4ULVxDyYCi60=;
        b=F7+NzLCH3FSCvWGbvtkl/Wea6M5ly7CD6E8b+G2Mg2UgQr/CpFfxfBkq2i4GsZdTgr
         NjhPsmNLaefcbML3WXPqcQF+zsg9itQhwsNul3QgA8mHgdEoh8VdqerG9P9q5qXo0fFv
         YDDEOV6UIq+qFqHJduR7ZJ2S7W9hPZlaWTkTToPnHSOgc640hBRb04wRRiJCDW7wZRru
         Xl6c9XKuxeCOgytlfxsgjD5fHnpZBi2NHUnt824fOYPsHy48sidodef+7pt5/vQC2RfB
         p3g3dy3mrvTDcMWVlSxNrIvMJqaRIcD+3EjB/aiRM+T9bg+Du4N09uJwccJ9H7Iciv7G
         KJpg==
X-Forwarded-Encrypted: i=1; AJvYcCXp4oleiY1F0zWs7Mhu4y93FC7foYNGYEp1S45L4uBPSuhSABggOW/CjAj2YrtpxuU8t7Uksts/WKbLhFCxBICX@vger.kernel.org
X-Gm-Message-State: AOJu0YxBhmLtzMLXm7CsoQeuWs48QI8GtMdDHSLvvzeimEogy+fjxZpV
	KvRSx5o48MLCn2i+U9zbBHYARzkZ9zM1OPbbY0YrLmFzZ83B4DkPGV+iGipCxJDq8astrD6hdWe
	vd+dG4RvNNLzpfQ==
X-Received: from pjbge20.prod.google.com ([2002:a17:90b:e14:b0:352:c381:4153])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:570f:b0:330:bca5:13d9 with SMTP id 98e67ed59e1d1-352732775a8mr13429526a91.32.1769036106410;
 Wed, 21 Jan 2026 14:55:06 -0800 (PST)
Date: Wed, 21 Jan 2026 14:54:00 -0800
In-Reply-To: <20260121225438.3908422-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121225438.3908422-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121225438.3908422-3-jmattson@google.com>
Subject: [PATCH 2/6] KVM: x86/pmu: Disable HG_ONLY events as appropriate for
 current vCPU state
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

Introduce amd_pmu_dormant_hg_event(), which determines whether an AMD PMC
should be dormant (i.e. not count) based on the guest's Host-Only and
Guest-Only event selector bits and the current vCPU state.

Update amd_pmu_set_eventsel_hw() to clear the event selector's enable bit
when the event is dormant.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/perf_event.h |  2 ++
 arch/x86/kvm/svm/pmu.c            | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 0d9af4135e0a..7649d79d91a6 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -58,6 +58,8 @@
 #define AMD64_EVENTSEL_INT_CORE_ENABLE			(1ULL << 36)
 #define AMD64_EVENTSEL_GUESTONLY			(1ULL << 40)
 #define AMD64_EVENTSEL_HOSTONLY				(1ULL << 41)
+#define AMD64_EVENTSEL_HG_ONLY				\
+	(AMD64_EVENTSEL_HOSTONLY | AMD64_EVENTSEL_GUESTONLY)
 
 #define AMD64_EVENTSEL_INT_CORE_SEL_SHIFT		37
 #define AMD64_EVENTSEL_INT_CORE_SEL_MASK		\
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 33c139b23a9e..f619417557f9 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -147,10 +147,33 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 1;
 }
 
+static bool amd_pmu_dormant_hg_event(struct kvm_pmc *pmc)
+{
+	u64 hg_only = pmc->eventsel & AMD64_EVENTSEL_HG_ONLY;
+	struct kvm_vcpu *vcpu = pmc->vcpu;
+
+	if (hg_only == 0)
+		/* Not an HG_ONLY event */
+		return false;
+
+	if (!(vcpu->arch.efer & EFER_SVME))
+		/* HG_ONLY bits are ignored when SVME is clear */
+		return false;
+
+	/* Always active if both HG_ONLY bits are set */
+	if (hg_only == AMD64_EVENTSEL_HG_ONLY)
+		return false;
+
+	return !!(hg_only & AMD64_EVENTSEL_HOSTONLY) == is_guest_mode(vcpu);
+}
+
 static void amd_pmu_set_eventsel_hw(struct kvm_pmc *pmc)
 {
 	pmc->eventsel_hw = (pmc->eventsel & ~AMD64_EVENTSEL_HOSTONLY) |
 		AMD64_EVENTSEL_GUESTONLY;
+
+	if (amd_pmu_dormant_hg_event(pmc))
+		pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
 }
 
 static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
-- 
2.52.0.457.g6b5491de43-goog

