Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769592D2381;
	Wed, 20 Aug 2025 02:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755657110; cv=none; b=d814YRqwRJImKBM3zW6N/tCsz6xrNtkcXR8X3TAe5ui8lPc4zJ0tEbfxTILxC3R/g8Vi1BcP3bSm7Bbu7SySKOFPWdyFYQfjtIx1MDFg5UwMLgq4YKFnPPrQAEPI9nieFNIxnuftFAh2M5c9KxPBCgWNdjKdrvE3LDA/qrHHj6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755657110; c=relaxed/simple;
	bh=g2LHeCdiePoL4pkXeCt0il/GMx7BvND9VlzVyJFZyuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8igyxX5bPKUJcA953VEjMetxtg8gJfMtdXRcKQs4BgW2TCGisA8NQ+SmN6EAcUyVW8fDUonTMPLubB/NncjPcLETgAWknSZyBUWENvodSz0sLRRRQUSJEV8CC++HUEg0Bh3DQA7QBbT4PEyIFgezJQU8/U4WJVj8Se73RLceEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VCXqv2W1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VCXqv2W1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755657109; x=1787193109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g2LHeCdiePoL4pkXeCt0il/GMx7BvND9VlzVyJFZyuk=;
  b=VCXqv2W1m+4N7FXgElLFMBBChml5Q+XiCZMiBWE+HRa8+AjvEMgPDMw+
   aL8jXS3sHQxOtelg9/BKxLxBYzMg+pP5C7JfMp0IHlleLN9VOe8EjQaZ1
   7M5GsThY6vEmuGZssAiDOgjoSAIOHaRRFmEE0NKLX4493cR2/hPnCgHAt
   yM8z7xXlty24VMTRrmmUlznKCIkEoJQpoWTMr86vxfO6zHDmOPlWj1TxQ
   FnyB0iS00z/6TTXEZFZ4WSuBqef/VE2VcApQKD2XROrxVqpYQsVHnymMK
   uXw+TtT2XSMXS6nIzQNdSOnd4SwZrUQYyHrF2QNhKJKnCto/W66vNqyl+
   A==;
X-CSE-ConnectionGUID: 832oPH5mSfuMpQacVLRIPA==
X-CSE-MsgGUID: Qr8PQUB9RHuVpsg+4+Wapg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57625473"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57625473"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 19:31:49 -0700
X-CSE-ConnectionGUID: nQZGU1I1QY61JssEU9Pw1g==
X-CSE-MsgGUID: 92yXRg+qRfCMGGrJtF9coQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167629041"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 19 Aug 2025 19:31:45 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Yi Lai <yi1.lai@intel.com>
Subject: [Patch v3 5/7] perf/x86/intel: Change macro GLOBAL_CTRL_EN_PERF_METRICS to BIT_ULL(48)
Date: Wed, 20 Aug 2025 10:30:30 +0800
Message-Id: <20250820023032.17128-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
References: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Macro GLOBAL_CTRL_EN_PERF_METRICS is defined to 48 instead of
BIT_ULL(48), it's inconsistent with other similar macros. This leads to
this macro is quite easily used wrongly since users thinks it's a
bit-mask just like other similar macros.

Thus change GLOBAL_CTRL_EN_PERF_METRICS to BIT_ULL(48) and eliminate
this potential misuse.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 arch/x86/events/intel/core.c      | 8 ++++----
 arch/x86/include/asm/perf_event.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 15da60cf69f2..f88a99d8d125 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5319,9 +5319,9 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 						0, x86_pmu_num_counters(&pmu->pmu), 0, 0);
 
 	if (pmu->intel_cap.perf_metrics)
-		pmu->intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
+		pmu->intel_ctrl |= GLOBAL_CTRL_EN_PERF_METRICS;
 	else
-		pmu->intel_ctrl &= ~(1ULL << GLOBAL_CTRL_EN_PERF_METRICS);
+		pmu->intel_ctrl &= ~GLOBAL_CTRL_EN_PERF_METRICS;
 
 	intel_pmu_check_event_constraints(pmu->event_constraints,
 					  pmu->cntr_mask64,
@@ -5456,7 +5456,7 @@ static void intel_pmu_cpu_starting(int cpu)
 		rdmsrq(MSR_IA32_PERF_CAPABILITIES, perf_cap.capabilities);
 		if (!perf_cap.perf_metrics) {
 			x86_pmu.intel_cap.perf_metrics = 0;
-			x86_pmu.intel_ctrl &= ~(1ULL << GLOBAL_CTRL_EN_PERF_METRICS);
+			x86_pmu.intel_ctrl &= ~GLOBAL_CTRL_EN_PERF_METRICS;
 		}
 	}
 
@@ -7790,7 +7790,7 @@ __init int intel_pmu_init(void)
 	}
 
 	if (!is_hybrid() && x86_pmu.intel_cap.perf_metrics)
-		x86_pmu.intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
+		x86_pmu.intel_ctrl |= GLOBAL_CTRL_EN_PERF_METRICS;
 
 	if (x86_pmu.intel_cap.pebs_timing_info)
 		x86_pmu.flags |= PMU_FL_RETIRE_LATENCY;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 70d1d94aca7e..f8247ac276c4 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -430,7 +430,7 @@ static inline bool is_topdown_idx(int idx)
 #define GLOBAL_STATUS_TRACE_TOPAPMI		BIT_ULL(GLOBAL_STATUS_TRACE_TOPAPMI_BIT)
 #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT	48
 
-#define GLOBAL_CTRL_EN_PERF_METRICS		48
+#define GLOBAL_CTRL_EN_PERF_METRICS		BIT_ULL(48)
 /*
  * We model guest LBR event tracing as another fixed-mode PMC like BTS.
  *
-- 
2.34.1

