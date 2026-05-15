Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145A337F8C5;
	Fri, 15 May 2026 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825840; cv=none; b=EzF13MkbA1QVaDbo4GocO/KFpFe47Ot6FQP8HYfMSI3CKAdwhRv7CnZBjn0D83OFwprJCyogMgj5Sq+z+5sqShVFeM3k67CGROT3p0zYOrgcPw0jI5V2BloYqkBS4hXHWRRH8n8xQuMshlrYQIYKo5w8NGNA6Icz+Ovc1u7ZXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825840; c=relaxed/simple;
	bh=lXoHa15+/ZMvG5HhebR3qoV07RJpC2JPalvCZsYavDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lbdyahC9VaFF+C22jKX8igQkQUlyeB/DgFFS4fU7UtVnPgtWdY1nfRJrVe07cSS4tNSdazppOF2JDeOsZdvB9XEkjvC1hBAud+x+zinNt6v5lcXOVgSGsnTSRgnuthtX4MuqnLHrWSOIZTud3Qk5/HIBDhNgUpGR6XXhswLU4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QzEyxx+m; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QzEyxx+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778825839; x=1810361839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lXoHa15+/ZMvG5HhebR3qoV07RJpC2JPalvCZsYavDU=;
  b=QzEyxx+mjvjUeIvboV7B7YobVXcHePPWng72lyPZuRjAe1XLuZgOgNWc
   WazxNJgJleAcNHh8SBXp1m+M77fQphFMmiDnN0KnH4f97pudaocUOC+ek
   jiuyjR6o8RkimYhAfWpN86PlHDQOzuBeEecJSa0oUInIwpnrWCzau6hIp
   xp3M80Og0tcV+/GNZNayB6u+I1WrfxP7U7rv2pdRrG7MQoKsP0WZVx2kU
   un1NwG4TihYhGY+oMIrofUtZtvZuMk6rhCi8AbaYfoKMUvm50A4gnP9YD
   kkJbCtSYEc3GJjl208eYCLC53rOAQXDo/QsWhJ46jSFsjNqpXXp2v1q1a
   Q==;
X-CSE-ConnectionGUID: 2qcFDdtaQMKaR4EIVNkrVQ==
X-CSE-MsgGUID: 0Lj8xXV6TaqdYBHU7XKNoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79635967"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79635967"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:17:19 -0700
X-CSE-ConnectionGUID: 6FTCbR4kR2yqSb0VDbaMDQ==
X-CSE-MsgGUID: mpZLWe35R+SfWWiL6MrOAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="235968501"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 14 May 2026 23:17:16 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 11/11] perf/x86/intel: Update event constraints and cache_extra_regs[] for CWF
Date: Fri, 15 May 2026 14:11:43 +0800
Message-Id: <20260515061143.338553-12-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515061143.338553-1-dapeng1.mi@linux.intel.com>
References: <20260515061143.338553-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update perf hard-coded event constraints and cache_extra_regs[] for
Clearwater Forest according to the latest CWF perfmon events (V1.02).

An important difference is that CWF introduce new extra register values
for the L3 cache OCR events, so define darkmont specific
dkt_hw_cache_extra_regs[] array.

CWF perfmon events:
https://github.com/intel/perfmon/blob/main/CWF/events/clearwaterforest_core.json

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e1c6fb127f10..eaa25239f2ec 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2582,6 +2582,22 @@ static __initconst const u64 skt_hw_cache_extra_regs
 	},
 };
 
+static __initconst const u64 dkt_hw_cache_extra_regs
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[C(LL)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= 0x10001,		/* OCR.DEMAND_DATA_RD.ANY_RESPONSE */
+			[C(RESULT_MISS)]	= 0x33FBFC00001,	/* OCR.DEMAND_DATA_RD.L3_MISS */
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= 0x10002,		/* OCR.DEMAND_RFO.ANY_RESPONSE */
+			[C(RESULT_MISS)]	= 0x33FBFC00002,	/* OCR.DEMAND_RFO.L3_MISS */
+		},
+	},
+};
+
 static __initconst const u64 arw_hw_cache_extra_regs
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -7779,6 +7795,18 @@ static __always_inline void intel_pmu_init_dkt_hybrid(struct pmu *pmu)
 	hybrid(pmu, pebs_constraints) = intel_dkt_pebs_event_constraints;
 }
 
+/*
+ * Darkmont is used by the CWF and PTL E-cores, but their L3 OCR
+ * events require different extra MSR values. Keep a separate init
+ * function for the non-hybrid server variant.
+ */
+static __always_inline void intel_pmu_init_dkt(struct pmu *pmu)
+{
+	intel_pmu_init_dkt_hybrid(pmu);
+	memcpy(hybrid_var(pmu, hw_cache_extra_regs),
+	       dkt_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
+}
+
 static __always_inline void intel_pmu_init_arw(struct pmu *pmu)
 {
 	intel_pmu_init_grt(pmu);
@@ -8113,7 +8141,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_ATOM_DARKMONT_X:
-		intel_pmu_init_skt(NULL);
+		intel_pmu_init_dkt(NULL);
 		intel_pmu_pebs_data_source_cmt();
 		x86_pmu.pebs_latency_data = cmt_latency_data;
 		x86_pmu.get_event_constraints = cmt_get_event_constraints;
-- 
2.34.1

