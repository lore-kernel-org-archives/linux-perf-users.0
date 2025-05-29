Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512F7245033;
	Thu, 29 May 2025 02:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748484974; cv=none; b=oA+Tv6z+g5XBc2n16BQlhvyym4nC5Oeez81sJ2kG1q8uVOtKELXwez+GGVVSdpERE2dk9Ip9tz5FNRQbwoFOJfNF7lwa73jQkc6s600+Q2xMIsluzNCm7aBUZO5GYAPaaUva2VR5IVo1Gz6xHZPJvIQbm2q/cKUUS/SFFOtMpZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748484974; c=relaxed/simple;
	bh=l/+G+hDWaVoOrbrhGnSPzXgf0GcqVXa1KHSdCrg7HkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbhBT7OP4XKB84VbBrOXvfcekGe0CghUuJvMiBNXxvrJz1PNMUyUbkfhA7efd3SUPotBuYTEoWy0bMKxyRc9TltPc3cq//V/lVGr4C0Rx3/h5DQwYtV8ljF3HQ1o//BZwes/pfLBG9nJfoYzd4w8ukSaT25YUV76rhGfYMB2yNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+hK8eMK; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+hK8eMK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748484974; x=1780020974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l/+G+hDWaVoOrbrhGnSPzXgf0GcqVXa1KHSdCrg7HkU=;
  b=M+hK8eMKAWJrhCzdLZGu60mYojENQPLMNAYhtVjvdjezb/HJZM4Vrajz
   Zec3Ulx3w9hrkrMquh1N1ibOMMm658zF9ZJU5Q8JUsqo8JaOYT8z5Orbm
   MV2BZdzUOmHNqkShvHXMXOLyZOn2jVIELiAgXUEh9BD09XikC/0Oru9Qp
   LB/75FFBDFQNL1xMqHe4LMrHj6LyDqIYu7As58bduIGmIRVbxI45g4BSD
   kD8sCMXM/NPc36sfENMzNWJotpwQzyuyS45SQu1h3Omsw6HlUMsdhHAh8
   nk1XDMJs+MWKzi2D9gqsuKZX7bjZwg9vH8u4eHR+k16FFc+JCziR5mpFu
   Q==;
X-CSE-ConnectionGUID: kCxZvr85SkSjHYBQkr/YoA==
X-CSE-MsgGUID: guTN/C1QTzuUVAt/SpgcoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50684614"
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="50684614"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 19:16:13 -0700
X-CSE-ConnectionGUID: iY6onNNqRlW87f2YNj4sxg==
X-CSE-MsgGUID: tE8zwvMNQz2PvbdcchOVtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="166575565"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa002.fm.intel.com with ESMTP; 28 May 2025 19:16:10 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 2/2] perf/x86/intel: Fix wrong index calculation in intel_pmu_config_acr()
Date: Thu, 29 May 2025 08:02:36 +0000
Message-ID: <20250529080236.2552247-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250529080236.2552247-1-dapeng1.mi@linux.intel.com>
References: <20250529080236.2552247-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To calculate fixed counter MSR address, the HW counter index "idx" is
subtracted by INTEL_PMC_IDX_FIXED. It leads to the ACR mask value of
fixed counters is incorrectly saved to the positions of GP counters
in acr_cfg_b[], e.g. For fixed counter 0, its ACR counter mask should be
saved to acr_cfg_b[32], but it's saved to acr_cfg_b[0] incorrectly.

Fix this issue.

Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8d046b1a237e..b0fee684ec8c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2899,6 +2899,7 @@ static void intel_pmu_config_acr(int idx, u64 mask, u32 reload)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int msr_b, msr_c;
+	int msr_offset;
 
 	if (!mask && !cpuc->acr_cfg_b[idx])
 		return;
@@ -2906,19 +2907,20 @@ static void intel_pmu_config_acr(int idx, u64 mask, u32 reload)
 	if (idx < INTEL_PMC_IDX_FIXED) {
 		msr_b = MSR_IA32_PMC_V6_GP0_CFG_B;
 		msr_c = MSR_IA32_PMC_V6_GP0_CFG_C;
+		msr_offset = x86_pmu.addr_offset(idx, false);
 	} else {
 		msr_b = MSR_IA32_PMC_V6_FX0_CFG_B;
 		msr_c = MSR_IA32_PMC_V6_FX0_CFG_C;
-		idx -= INTEL_PMC_IDX_FIXED;
+		msr_offset = x86_pmu.addr_offset(idx - INTEL_PMC_IDX_FIXED, false);
 	}
 
 	if (cpuc->acr_cfg_b[idx] != mask) {
-		wrmsrl(msr_b + x86_pmu.addr_offset(idx, false), mask);
+		wrmsrl(msr_b + msr_offset, mask);
 		cpuc->acr_cfg_b[idx] = mask;
 	}
 	/* Only need to update the reload value when there is a valid config value. */
 	if (mask && cpuc->acr_cfg_c[idx] != reload) {
-		wrmsrl(msr_c + x86_pmu.addr_offset(idx, false), reload);
+		wrmsrl(msr_c + msr_offset, reload);
 		cpuc->acr_cfg_c[idx] = reload;
 	}
 }
-- 
2.43.0

