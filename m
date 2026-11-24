Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479805;
	b=JwjfS3vmqmXfWO9huajrA3OnkB3mJMpG+A5A9ONQs1auG+0ceGYXXkseRJkmrWUybyUJ
	 2wMiLXeAnZawGD+XrfuWYexLDlH9JRAQIxy8t+4kw9KaPBOOOntAEM+G6cpkND8ednNTc
	 Kf8c+mkmvYRpvSTGb5ZRna1yuwrJOahrHMi1F+7pto3ICGFzBWDr9FoaM1yQWGY/U+Zaf
	 2tQ33RpzzlHR3oPrWR4P8FvSB0OoSnPa+SeZEpuvwGlqqCGAx7CMj80MP1+mPxPpIZ5GW
	 peymBXTsNCB7iJoRJigGSGkVgDG/50Js4sP9RDUly5Hfex0hFHWbc0nLIJaecU6dQmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479805;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LT2epryqp8Iw+la1Zy6zB4f94YOcjD3RdwJUl5rJ/5M=;
	b=BXNBA2Htovr9oC8FPuAnSP3BS+w3AppxuaWWW3QGp6ZQo2ANMYwq5InAt4X42OzTMRaP
	 giJ37LwvcG5BNFUKulfqCkVqQ/iK+LmnyDZixtSg3McnHRjJPir6/7Rrn1/XKk+syctK+
	 /dGCH+MwEHkiCdArxSOwGI2pAK4pqDY6NhcI5h+3vGKELuR3XGxAG22LIlbWsEw566x+H
	 kiWCOFJkwtAC1yR8K6GnAcRWDnBcIP6kBUJUzwQfx4gxx4xKEY14GQtkYjkXBLqsY50a6
	 5uzuuLBv2kPpVt1fYZIGWNRyxJFRA0woP8pDM2+d/8ObyQ+9NoKj++YGamrZAglxbLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLtF6PDq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C8360A5BC0;
	Tue, 24 Nov 2026 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLtF6PDq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29671F0089E;
	Tue, 24 Nov 2026 00:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479804;
	bh=LT2epryqp8Iw+la1Zy6zB4f94YOcjD3RdwJUl5rJ/5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZLtF6PDqtGDXEY0XTDVrPoY56UBEuUcatQmPe3w4pJ1fekdZB/ZGEHrdo8/Kho/5a
	 gJlzBMoE75CxMT7eDFGKAvliR02hCO6z7Fngxzcs05Q44zMEdvxj+CEKsU9mHUx7NJ
	 USqj3YFLBcfj7tCYYkSJjLE8LltzVawEJzrhoYhhA1byf8mixwYwY3svQcxWhuafNv
	 w0SEMpHQBrNozKNSZBDbspChIvVpegHDyyFhx/UHDUHJ1ooWmMQZ2VO7DgYqz/It8t
	 tBnSX5AyzBFfy+XQDc5n6Cog8sv5LH5Weu9VqLzijHdDN13QvVcQFdNvxmtyeb1bad
	 pv5KB0kcicWXA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mingwei Zhang <mizhang@google.com>,
	Jim Mattson <jmattson@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [RFC PATCH 11/26] KVM: x86/pmu: Move PMC MSR and type helpers earlier
Date: Tue, 24 Nov 2026 00:22:48 +0000
Message-ID: <20261124002303.1785363-12-yosry@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261124002303.1785363-1-yosry@kernel.org>
References: <20261124002303.1785363-1-yosry@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move {fixed_counter,gp_counter,gp_eventsel}_msr() above
pmc_write_counter(), and pmc_is_{gp,fixed}() above pmc_read_counter(),
in preparation for using them to access PMCs in hardware while the
guest's mediated PMU context is loaded.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.c | 30 +++++++++++++++---------------
 arch/x86/kvm/pmu.h | 20 ++++++++++----------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index eef2f792dc9e8..4d170abb2b384 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -404,6 +404,21 @@ static void pmc_update_sample_period(struct kvm_pmc *pmc)
 			  get_sample_period(pmc, pmc->counter));
 }
 
+static __always_inline u32 fixed_counter_msr(u32 idx)
+{
+	return kvm_pmu_ops.FIXED_COUNTER_BASE + idx * kvm_pmu_ops.MSR_STRIDE;
+}
+
+static __always_inline u32 gp_counter_msr(u32 idx)
+{
+	return kvm_pmu_ops.GP_COUNTER_BASE + idx * kvm_pmu_ops.MSR_STRIDE;
+}
+
+static __always_inline u32 gp_eventsel_msr(u32 idx)
+{
+	return kvm_pmu_ops.GP_EVENTSEL_BASE + idx * kvm_pmu_ops.MSR_STRIDE;
+}
+
 void pmc_write_counter(struct kvm_pmc *pmc, u64 val)
 {
 	if (kvm_vcpu_has_mediated_pmu(pmc->vcpu)) {
@@ -1304,21 +1319,6 @@ int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp)
 	return r;
 }
 
-static __always_inline u32 fixed_counter_msr(u32 idx)
-{
-	return kvm_pmu_ops.FIXED_COUNTER_BASE + idx * kvm_pmu_ops.MSR_STRIDE;
-}
-
-static __always_inline u32 gp_counter_msr(u32 idx)
-{
-	return kvm_pmu_ops.GP_COUNTER_BASE + idx * kvm_pmu_ops.MSR_STRIDE;
-}
-
-static __always_inline u32 gp_eventsel_msr(u32 idx)
-{
-	return kvm_pmu_ops.GP_EVENTSEL_BASE + idx * kvm_pmu_ops.MSR_STRIDE;
-}
-
 static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 090c9bbb74f48..ff4b6f15b915c 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -127,6 +127,16 @@ static inline u64 pmc_bitmask(struct kvm_pmc *pmc)
 	return pmu->counter_bitmask[pmc->type];
 }
 
+static inline bool pmc_is_gp(struct kvm_pmc *pmc)
+{
+	return pmc->type == KVM_PMC_GP;
+}
+
+static inline bool pmc_is_fixed(struct kvm_pmc *pmc)
+{
+	return pmc->type == KVM_PMC_FIXED;
+}
+
 static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
 {
 	u64 counter, enabled, running;
@@ -145,16 +155,6 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
 
 void pmc_write_counter(struct kvm_pmc *pmc, u64 val);
 
-static inline bool pmc_is_gp(struct kvm_pmc *pmc)
-{
-	return pmc->type == KVM_PMC_GP;
-}
-
-static inline bool pmc_is_fixed(struct kvm_pmc *pmc)
-{
-	return pmc->type == KVM_PMC_FIXED;
-}
-
 static inline bool kvm_valid_perf_global_ctrl(struct kvm_pmu *pmu,
 						 u64 data)
 {
-- 
2.56.1.809.ga0b61035b5-goog

