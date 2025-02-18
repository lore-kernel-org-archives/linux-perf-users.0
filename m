Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4022CBE6;
	Tue, 18 Feb 2025 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866431; cv=none; b=gekUg/d+QatrVonEtVRxDJ6OKyJXmtELge7yIK5lZEnrpvO7cyGu0hPrtLekQ5+rNxways6IQqL6SOsS4ATVFaC0N1Na/A+/OQKoqMcvqGIjpiS0yiz3waNj7nE6DF9XkerlVM9A1SagxjRRZwf36B1A7oh+XoYzFpzRXrbMyoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866431; c=relaxed/simple;
	bh=kZQKXNdpkD7OpjfkcStqQmHSPSp5/RvaKXpFdiUv940=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oRMO2Jl+k7iHFILaJ8ADRe8YGfvwzJhSSvy0KrKLFZmneYUbHemJyOuHBV0BB32OzBOND3e9pWM4SOS0uoSvZ6f82POaqphkITRNrBf1Qq+dH8Yum5rtS3HFbq+D+eV4ewfT8r1Nbz4uw8qlmVIj6JImxzorg/HP8c60Qw4Wt18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fp4ZwvDv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fp4ZwvDv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866431; x=1771402431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kZQKXNdpkD7OpjfkcStqQmHSPSp5/RvaKXpFdiUv940=;
  b=fp4ZwvDv0LuwucrhW29Sjc9IIpuGXi7KsGvTaSRBGH8UlS8H0UdFYDxL
   Ksk8LVuPxMM9cp7OQDrfgX5dbslRmq1nbhM6mRuRBdpwRCVGkVC+RqW6s
   RJA7ILLILZr3c24tVvbQyzbkJ/qHRcOf9seQmBJ4ozDQICNx+qYJ6SAwb
   ddDwZtnZsWdYmmUkKXkKr3evDKOdUOjg81fZdV6lGkztJZHiCwuC7oc9D
   0LaKuwLelVFlJbAWx038xVJALdTgrKH+DJGCCECcVk6xH/Rf1KbgbowZe
   3DyVo+ez2WudX+pvARYwk8X57VUVhRPKUupLdR0xCrnwBHCRJiF80GZ0j
   A==;
X-CSE-ConnectionGUID: tk7y9zpPTluu7Ebx5iKMrA==
X-CSE-MsgGUID: yzk5pHVOTA+Jhl58UzXUow==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200708"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200708"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:13:51 -0800
X-CSE-ConnectionGUID: 3qbxuHGzR1+JSHuHsjgptg==
X-CSE-MsgGUID: UsCsxBn+Ssi5BC0KgC6CLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166097"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:13:47 -0800
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
Subject: [Patch v2 02/24] perf/x86/intel: Add Panther Lake support
Date: Tue, 18 Feb 2025 15:27:56 +0000
Message-Id: <20250218152818.158614-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
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
index 5570d97b8f4f..936711db9b32 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7232,8 +7232,17 @@ __init int intel_pmu_init(void)
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
@@ -7255,8 +7264,6 @@ __init int intel_pmu_init(void)
 		intel_pmu_init_skt(&pmu->pmu);
 
 		intel_pmu_pebs_data_source_lnl();
-		pr_cont("Lunarlake Hybrid events, ");
-		name = "lunarlake_hybrid";
 		break;
 
 	case INTEL_ARROWLAKE_H:
-- 
2.40.1

