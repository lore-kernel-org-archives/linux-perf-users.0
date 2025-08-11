Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC68E2DD5EF;
	Mon, 11 Aug 2025 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902916; cv=none; b=HQ0tpmsA8D9jFkZDMB/ALQRzElqa1+/lDK8jVTkr/dQRaCWIPwDostLJbznWOBeTwkdKzbM/I3n+yeNRRMwCL04aHmivr47GzdJ1LCHrVgMdV6FbXPN+GH93tjsNNBg62fFDfSt6A4Eaw3aTmUTD6/GYeid3+G28NuL3sJFBlHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902916; c=relaxed/simple;
	bh=fSGEJ8LBndoHk9y2A/U407ioZmHKOGrzLCNFN60i/H0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hOai32g1B1ZuJaqbtwAgdpWGQKdjm72EuDMHS3ryILXWt+8dGWmzpmSYEHf7afJD5711tyZqEhoQW/OWQQrr+gYqezzPV0WxRwz7RG7DSqwGJ7AJ+mfoPgnzh5u9nnpWe2LmZ9si2V5h6exB3+pRW+8i/JbQSgAwQAIYjA+POTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NToKSTL/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NToKSTL/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754902915; x=1786438915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fSGEJ8LBndoHk9y2A/U407ioZmHKOGrzLCNFN60i/H0=;
  b=NToKSTL/zM2xNHN+HET5bP1wwaGYePUP+lLZ44jRorS5DhRuSI2iZtq5
   roiTw4/rBD45Qpv9Dro8seWYxPwag94FD+yxP9nIqEN0xmY+EFRrwhLu3
   WCJ1UQxzFAmeI62aVZoiklntNqDhWDOAUjlbMehButCeMhluE8RgUbVDa
   Za12dmKRqogwI9DLtGGzXcqzRaVA53498QEqfPVIxK3o6xINTVT7aUPUl
   AGpI4hvVwqo5Tr02PxI79+rwqZcuZM6QnN4Og0MPIJDf4CeGknhI8+DXZ
   6AGWZlbf70HlExAFn0lBB9QAGCma1Y8V8Io95N6yyD6pIPCk3sW6nJTFr
   A==;
X-CSE-ConnectionGUID: f89w9kjVRe6JqcvEWM/IpQ==
X-CSE-MsgGUID: FEwB4jHiSbe2iJdVG7HwjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57107421"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57107421"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 02:01:47 -0700
X-CSE-ConnectionGUID: uWtYLQ9VSjui4m/Bu+n44w==
X-CSE-MsgGUID: Oo1EFSgTQL2bJE7JZc594g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166219937"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 11 Aug 2025 02:01:44 -0700
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
Subject: [Patch v2 5/6] perf/x86/intel: Change macro GLOBAL_CTRL_EN_PERF_METRICS to BIT_ULL(48)
Date: Mon, 11 Aug 2025 17:00:33 +0800
Message-Id: <20250811090034.51249-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811090034.51249-1-dapeng1.mi@linux.intel.com>
References: <20250811090034.51249-1-dapeng1.mi@linux.intel.com>
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
index 386717b75a09..cdd10370ed95 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5323,9 +5323,9 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 						0, x86_pmu_num_counters(&pmu->pmu), 0, 0);
 
 	if (pmu->intel_cap.perf_metrics)
-		pmu->intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
+		pmu->intel_ctrl |= GLOBAL_CTRL_EN_PERF_METRICS;
 	else
-		pmu->intel_ctrl &= ~(1ULL << GLOBAL_CTRL_EN_PERF_METRICS);
+		pmu->intel_ctrl &= ~GLOBAL_CTRL_EN_PERF_METRICS;
 
 	intel_pmu_check_event_constraints(pmu->event_constraints,
 					  pmu->cntr_mask64,
@@ -5460,7 +5460,7 @@ static void intel_pmu_cpu_starting(int cpu)
 		rdmsrq(MSR_IA32_PERF_CAPABILITIES, perf_cap.capabilities);
 		if (!perf_cap.perf_metrics) {
 			x86_pmu.intel_cap.perf_metrics = 0;
-			x86_pmu.intel_ctrl &= ~(1ULL << GLOBAL_CTRL_EN_PERF_METRICS);
+			x86_pmu.intel_ctrl &= ~GLOBAL_CTRL_EN_PERF_METRICS;
 		}
 	}
 
@@ -7794,7 +7794,7 @@ __init int intel_pmu_init(void)
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

