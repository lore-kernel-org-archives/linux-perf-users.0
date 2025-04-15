Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084B027B4FC;
	Tue, 15 Apr 2025 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705460; cv=none; b=M6CoCVrFF66k1IxN47rKpsyR1T2ViIwxYuL6jjG2/HyXtcWVDyXxfd2a6dIswaRM9oUk2xBjpGYm0ORmMuRrLNE2Bh0DIxmBcAL70GAZyQBbZtG3pelK9a++Am5pVzmkAfpNx+LepdypVzvTd6Vf0sLQdgJNKqqigGsrPWpAaOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705460; c=relaxed/simple;
	bh=9d+mLsCAasTLdGJgc6ffxudPE/jqvpz6Ci0AKO2oPrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LNBsqTa6YE/EFBcHbXWUV+Wb5YqYgOnmdLlDkdSrsNdVHK8rdU/9t/FWUUt4YA59zrEZJRpRgucOXpJt8n9PAZ2rq7JXDpw58chu+OVUP1uRd5pgfNDvCiKWkf/+2dMF6d4cpdbsYxD/0vY90OGNTLUb1aN5asUYKWa2VrmwmdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SBbaDQr5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SBbaDQr5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705459; x=1776241459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9d+mLsCAasTLdGJgc6ffxudPE/jqvpz6Ci0AKO2oPrU=;
  b=SBbaDQr5mlfQ4jM1JmtaDFVtOZwrv6Jw8SXZBnjxK221KZNoeuXZb6jv
   Z9UmEsgOfvENg2MmqO2BLkFJQCdW8qrrE+MpgFIif1qvyPp6fa1hDLLdL
   vEN+tf3I64IoklRXx/w6Yju1WKx/KtI0p/jl6cYi0AvjJd5iAUEqWngVd
   E0L7RnXjbi+paptUpJhZEdFWKjjpRcK50cEtefTgAoQ1/fFPShCVXPx51
   AInzQEi5k+Jafrw3DbmwbHDqMJpyPOR0xAMwCBa04ENL4ZXJmpLL3bcJR
   A/B2/5pFhR0SOS9d4cZGTX3XY1AUmz6r7tVNTgj4GEeXfiOiKHCn4Ur0X
   Q==;
X-CSE-ConnectionGUID: o6d8ZIfRSm2lLIe/4VTL1A==
X-CSE-MsgGUID: auVmlU7sTu+RPmX8R8lyzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46115838"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46115838"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:23:13 -0700
X-CSE-ConnectionGUID: JgW/NYlFTCi9x/B26gFmEw==
X-CSE-MsgGUID: Jt9HAbVjQoe8G6j9rkNDHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130055391"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2025 01:23:09 -0700
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
	Dapeng Mi <dapeng1.mi@intel.com>
Subject: [Patch v3 01/22] perf/x86/intel: Add Panther Lake support
Date: Tue, 15 Apr 2025 11:44:07 +0000
Message-Id: <20250415114428.341182-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

From PMU's perspective, Panther Lake is similar to the previous
generation Lunar Lake. Both are hybrid platforms, with e-core and
p-core.

The key differences are the ARCH PEBS feature and several new events.
The ARCH PEBS is supported in the following patches.
The new events will be supported later in perf tool.

Share the code path with the Lunar Lake. Only update the name.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c6f69ce3b2b3..f107dd826c11 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7572,8 +7572,17 @@ __init int intel_pmu_init(void)
 		name = "meteorlake_hybrid";
 		break;
 
+	case INTEL_PANTHERLAKE_L:
+		pr_cont("Pantherlake Hybrid events, ");
+		name = "pantherlake_hybrid";
+		goto lnl_common;
+
 	case INTEL_LUNARLAKE_M:
 	case INTEL_ARROWLAKE:
+		pr_cont("Lunarlake Hybrid events, ");
+		name = "lunarlake_hybrid";
+
+	lnl_common:
 		intel_pmu_init_hybrid(hybrid_big_small);
 
 		x86_pmu.pebs_latency_data = lnl_latency_data;
@@ -7595,8 +7604,6 @@ __init int intel_pmu_init(void)
 		intel_pmu_init_skt(&pmu->pmu);
 
 		intel_pmu_pebs_data_source_lnl();
-		pr_cont("Lunarlake Hybrid events, ");
-		name = "lunarlake_hybrid";
 		break;
 
 	case INTEL_ARROWLAKE_H:
-- 
2.40.1

