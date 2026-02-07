Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5227D786
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Feb 2026 01:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770427437; cv=none; b=cBXOtmIG/qpXyf6PxEn/B7qOMRlltPl5RS4pppBwWoX0GAqXl/IU2klK3mDR2XI4TjG3yUj304eSxeFqPfVsmduybszIlDkJdwNs24lQ033M3NxWO+3QZh8UGoIQ2I5RwEngSHJcVJE+/sLY+xo3P/G/UGnaqBhYU14STEiIAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770427437; c=relaxed/simple;
	bh=I+RxoIGb1w+j2Z99Cy0rUjANHksL4tl1ovFMTp7mg1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K6iS7MOXmSV/vRcA+TCuh8mV84J9QpWCrBGavim7nHws2o3GnKCLauAjotszQW/GtOOMcrgUfQRINyLYBrgRQGykwOgWFI6wb7rs7qzWf2JBBaRdqycmjBS0DXKT9XwxuVVqBEd2d7Rp9lbGbAOEHVLxx/SwLePgo744B6C51R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v+Ea/bvt; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v+Ea/bvt"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29f29ae883bso19325495ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 17:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770427436; x=1771032236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dU5KMBJtS4wTduPehGSWJG7pWtZ+gBpfTPOt7bZn03I=;
        b=v+Ea/bvt3/x60lb1ffT5HH8hd7QIAVlYryxw8vP6rCYm/Q105iTczl5BFw5ZvnUgdh
         M5iiCb0oLA2sz+bEKCxL0Wf8LrTkH4JQWvZVwtCSxtJehcksSZxOTZx6BQMu9XM00vSy
         Tov+g+EXN/i5GPn8WNmd8UygWqvZoFWTQUegriL2enDzdHU9JvpQbaSg1pV5viOdvhJF
         JFe7upyZ4bcrc0yWBjuN9dOBRCpA0xv38X9AhyPSBz5j6C+LfFAjulH3/VlQJpazje11
         atc04gqaj2AtLEnjx/2W5D5QSiKkCn6T1sgHk9Edb1OLsNBBqZ1Z1lXsd4UyU/yqXkxU
         lmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770427436; x=1771032236;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dU5KMBJtS4wTduPehGSWJG7pWtZ+gBpfTPOt7bZn03I=;
        b=WPvcoGAtrHdXuwWnR+Jernxig0RfJh4nrPri9j0Dlb7FltKr86LLFZtDFkTf1QzRQK
         wBEu0Fftm4BA6qmbQE/Oi/axd7K9p2dbqxhy1AaHDdo0R7+TQxjCKCKP3dnpDgCTrIr5
         8A7V/KHwAUh6hf2fDI2b04cWkWG8d/r7KxlCFq09u9dyIL4Rd7XoWvkM+sJ1ww90zd38
         CIf4HOoSqYi+UhGFc+TDA+vLKblEy7siclStSMGtKMWwBuoM4UPgmux6kD5idOkzi95U
         eASeCBkF6Z/w4NO5oaSYyQ2XHpApbvXuRv3CByHC+P6nyS7qHkTywKfryU++xUveEGTW
         j8gw==
X-Forwarded-Encrypted: i=1; AJvYcCUkm2DtYd4CBLklrINvtHCE+RdU/7t1C3qj1S7th1tLd1qBvaBJ5LP9yPdxJQNQC/hOKJCui8JR7rLykROo4k8e@vger.kernel.org
X-Gm-Message-State: AOJu0YxP6AahJ5865m0C9e4BRUP2CO7xMexxs149VXqST9/GpVLNiMt1
	0N7Z2HsvYhQE6GY2oWRGHVH3VdQyVKAGI6WLkWvzMDzxuj9ArATV6oLxAkGjxui8YKaVuLF2O69
	MM6TMFUP4wn8zpA==
X-Received: from pgbbd9.prod.google.com ([2002:a65:6e09:0:b0:bac:6acd:8182])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d10:b0:390:ca32:da20 with SMTP id adf61e73a8af0-393aeea94fbmr4223884637.10.1770427436293;
 Fri, 06 Feb 2026 17:23:56 -0800 (PST)
Date: Fri,  6 Feb 2026 17:23:28 -0800
In-Reply-To: <20260207012339.2646196-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260207012339.2646196-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260207012339.2646196-3-jmattson@google.com>
Subject: [PATCH v3 2/5] KVM: x86/pmu: Disable Host-Only/Guest-Only events as
 appropriate for vCPU state
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Update amd_pmu_set_eventsel_hw() to clear the event selector's hardware
enable bit when the PMC should not count based on the guest's Host-Only and
Guest-Only event selector bits and the current vCPU state.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/perf_event.h |  2 ++
 arch/x86/kvm/svm/pmu.c            | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 0d9af4135e0a..4dfe12053c09 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -58,6 +58,8 @@
 #define AMD64_EVENTSEL_INT_CORE_ENABLE			(1ULL << 36)
 #define AMD64_EVENTSEL_GUESTONLY			(1ULL << 40)
 #define AMD64_EVENTSEL_HOSTONLY				(1ULL << 41)
+#define AMD64_EVENTSEL_HOST_GUEST_MASK			\
+	(AMD64_EVENTSEL_HOSTONLY | AMD64_EVENTSEL_GUESTONLY)
 
 #define AMD64_EVENTSEL_INT_CORE_SEL_SHIFT		37
 #define AMD64_EVENTSEL_INT_CORE_SEL_MASK		\
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index d9ca633f9f49..8d451110a94d 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -149,8 +149,26 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 static void amd_pmu_set_eventsel_hw(struct kvm_pmc *pmc)
 {
+	struct kvm_vcpu *vcpu = pmc->vcpu;
+	u64 host_guest_bits;
+
 	pmc->eventsel_hw = (pmc->eventsel & ~AMD64_EVENTSEL_HOSTONLY) |
 			   AMD64_EVENTSEL_GUESTONLY;
+
+	if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
+		return;
+
+	if (!(vcpu->arch.efer & EFER_SVME))
+		return;
+
+	host_guest_bits = pmc->eventsel & AMD64_EVENTSEL_HOST_GUEST_MASK;
+	if (!host_guest_bits || host_guest_bits == AMD64_EVENTSEL_HOST_GUEST_MASK)
+		return;
+
+	if (!!(host_guest_bits & AMD64_EVENTSEL_GUESTONLY) == is_guest_mode(vcpu))
+		return;
+
+	pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
 }
 
 static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
-- 
2.53.0.rc2.204.g2597b5adb4-goog

