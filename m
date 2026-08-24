Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BBE3B19AC;
	Mon, 24 Aug 2026 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560497; cv=none; b=K27uLuJMqrgOgNsFsgreZ18cGXLOru0TAjyY2RBHotwSgCnsnil2ryuKdei2kdoagfDJs14elM0uY8/VmEzYy8vJc/0Jh+i2qRcex2nIjmPBICBwf6IlLslrOF5ywcpLClys+U1sJAlZgLSgQve1dmDsp8b0TkJ21L+cvXqV53o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560497; c=relaxed/simple;
	bh=CVf+JRj7+zgIjkIgE+nlX/e37q7K4v0OwunZCAFdrkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ugqEESnUVVJ5M/o2REa7jb4+Y9tJsPF+pLHAg9T/WHYZENJ9UyEepW5TGpfquduXkb2ScY82+NrBED7/Zw5EPfPN8Cs3B/5z5A3F5YeNhU3JozFrYTBxSHMqKLCqKjTzHzgxWoJJ2sbJhQHBdo1IxbDh4V2tqblaGYYSooUzy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXCtFuv5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXCtFuv5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560496; x=1819096496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CVf+JRj7+zgIjkIgE+nlX/e37q7K4v0OwunZCAFdrkc=;
  b=BXCtFuv5AdjuQK22RT31CXk9ggVHRdzAGvYGlOKvFG4p1+7ggaoHqF2s
   ImNg/LJjV1aoOci+v9wwmKmcXrnHfglfPkeR1CTdk51fF9sM0WdfCjJV7
   OBpart8Qo0zB1Z+8KzatimMUa7bUYSeiaAcEDtZrmyyUqDfFOHg6796Rs
   YQRm7jz82AdhmHgq2la/Qp5dS7aoMRQZE0xkqRXz2sp0dJQeS9UPXlIKb
   4qHyfMO/DTpzolpdwzM/HBUbjTANh4Ht4ia4ZNxvLrR/1xXD/YOIiBJhC
   5+OlpuTx18Agq0R0/ZNEg/cyevzse+tAimzrESxxKP5FyovSUwPCy6aOH
   g==;
X-CSE-ConnectionGUID: mCsb6toATMicb1V7jGdZAQ==
X-CSE-MsgGUID: 9+TT6ki9S5ulC8dzjxGRhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98598777"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98598777"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:34:56 -0700
X-CSE-ConnectionGUID: po677VdpQZqyg6G//Wd5Tw==
X-CSE-MsgGUID: VUTz+zxeRZCvZxiOjS0qFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264326234"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 24 Aug 2026 01:34:51 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [RESEND Patch v10 09/23] perf/x86/intel: Centralize PERF_PMU_CAP_EXTENDED_REGS updates
Date: Mon, 24 Aug 2026 16:27:17 +0800
Message-Id: <20260824082731.1013973-10-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PERF_PMU_CAP_EXTENDED_REGS is currently updated in multiple paths:
intel_ds_pebs_init() and __intel_update_pmu_caps() for adaptive and
architectural PEBS. This split makes the capability flow harder to
reason about and is awkward for upcoming XSAVES-based SIMD register
sampling, which also needs consistent capability setup and validation.

Refactor the update logic into a single helper,
__intel_update_pmu_xregs_caps(), so adaptive and architectural PEBS
share one implementation.

Call this helper from intel_update_pmu_caps() to keep PMU capability
handling centralized in one place and avoid duplicated or conflicting
updates.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 16 ++++++++--------
 arch/x86/events/intel/ds.c   |  1 -
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index dbc0bd0fe73f..7ad5aa5316e3 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6162,11 +6162,14 @@ static inline bool intel_pmu_broken_perf_cap(void)
 	return false;
 }
 
-static inline void __intel_update_pmu_caps(struct pmu *pmu)
+static inline void __intel_update_pmu_xregs_caps(struct pmu *pmu)
 {
 	struct pmu *dest_pmu = pmu ? pmu : x86_get_pmu(smp_processor_id());
+	u64 caps = hybrid(pmu, arch_pebs_cap).caps;
 
-	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_XMM)
+	if ((x86_pmu.arch_pebs && (caps & ARCH_PEBS_VECR_XMM)) ||
+	    (!x86_pmu.arch_pebs && x86_pmu.intel_cap.pebs_format >= 4 &&
+	     x86_pmu.intel_cap.pebs_baseline))
 		dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 }
 
@@ -6238,12 +6241,10 @@ static void update_pmu_cap_from_perfmonext(struct pmu *pmu)
 		hybrid(pmu, arch_pebs_cap).counters = pebs_mask;
 		hybrid(pmu, arch_pebs_cap).pdists = pdists_mask;
 
-		if (WARN_ON((pebs_mask | pdists_mask) & ~cntrs_mask)) {
+		if (WARN_ON((pebs_mask | pdists_mask) & ~cntrs_mask))
 			x86_pmu.arch_pebs = 0;
-		} else {
-			__intel_update_pmu_caps(pmu);
+		else
 			__intel_update_large_pebs_flags(pmu);
-		}
 	} else {
 		WARN_ON(x86_pmu.arch_pebs == 1);
 		x86_pmu.arch_pebs = 0;
@@ -6267,6 +6268,7 @@ static void intel_update_pmu_caps(struct pmu *pmu)
 		    hybrid_pmu(pmu)->pmu_type == hybrid_big)
 			hybrid(pmu, intel_cap).perf_metrics = 1;
 	}
+	__intel_update_pmu_xregs_caps(pmu);
 }
 
 static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
@@ -6420,8 +6422,6 @@ static void intel_pmu_cpu_starting(int cpu)
 		}
 	}
 
-	__intel_update_pmu_caps(cpuc->pmu);
-
 	if (!cpuc->shared_regs)
 		return;
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7b69f8c8d0c2..78b9c0dcb14d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -3396,7 +3396,6 @@ static void __init intel_ds_pebs_init(void)
 				x86_pmu.flags |= PMU_FL_PEBS_ALL;
 				x86_pmu.pebs_capable = ~0ULL;
 				pebs_qual = "-baseline";
-				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 			} else {
 				/* Only basic record supported */
 				x86_pmu.large_pebs_flags &=
-- 
2.34.1

