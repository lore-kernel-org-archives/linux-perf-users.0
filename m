Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0DD1BFE05;
	Thu, 23 Jan 2025 06:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737613214; cv=none; b=kgN1Ci2AnlI24qpqL9yKlPIGZiafNackzNE2hR4d53kw8ReGZsU0/3McUm8lz1rNSdE8Sc5ZRPc5AvDAcSUVMVAMXdg9ZtUUDZKMrksYQDt+/XJIg3xApR8WqjhKT47RWkXhf3NzftnwnGDRWX5c4NPnl67INFBFTIcgL9iiL2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737613214; c=relaxed/simple;
	bh=pSwGsDNCYRGk2x+g0Drr8wYURsrGsK3/Ut8o4ZT9Iwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r+n6bSd0d0y1lQiYb2iLgZaaY7xvWSzXvZXDsE4NxR5v2zLXENjq9b/Kf0dqdMibbIyLUfC73aWfJ4qBk1OTtltzg7Y8SQ0RrjsB43d2ccShcVoj8RtfC1J0OIVlc+FgtXbCYAk7o3a7QJtFdO/XU1BKZHZIXTxjAQRH+wzwLdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VCju4UFr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VCju4UFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737613213; x=1769149213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pSwGsDNCYRGk2x+g0Drr8wYURsrGsK3/Ut8o4ZT9Iwc=;
  b=VCju4UFrXhf1vXNUWiSe0esL2dWQjJ/Z6P9PdM4ra6gAa9FY/tkJWjAW
   gXVK4HfsNZ8eS00IYASPN0VWZ+OP/YdUGbCZ2iW7D6uckmILVWNS5GI1X
   5BeGaXXJei6an+zdW0Mhedd2kevmIg5FjwfudpmhLpES90Zb8xvkSkzfQ
   paGXFCxqYGblQLs1GhleYysN9UIfxxVns5ewcJ+5c89MpB+GAxTSwTRWH
   MSYJyz3XvFxVksql9U5knUOG4akeF7QfomUfAAYd0r/I+4/S/iTT9gSfm
   1kVjt6Pzjbmj8u5nafLNX5Vgyl3ZA64hxWSpaR3LuckpNxOOd962rmEik
   w==;
X-CSE-ConnectionGUID: Q+9Z9XxwSqKLQxNQftOSig==
X-CSE-MsgGUID: 2uHciqOZSO+kgTaY09UgEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55513023"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208,223";a="55513023"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 22:20:13 -0800
X-CSE-ConnectionGUID: pznLnFkWRx6Xy8EOtCspyA==
X-CSE-MsgGUID: NK12cE/2R+Sk8pWhihdXUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208,223";a="112334410"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 22:20:09 -0800
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
Subject: [PATCH 01/20] perf/x86/intel: Add PMU support for Clearwater Forest
Date: Thu, 23 Jan 2025 14:07:02 +0000
Message-Id: <20250123140721.2496639-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From PMU's perspective, Clearwater Forest is similar to the previous
generation Sierra Forest.

The key differences are the ARCH PEBS feature and the new added 3 fixed
counters for topdown L1 metrics events.

The ARCH PEBS is supported in the following patches. This patch provides
support for basic perfmon features and 3 new added fixed counters.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b140c1473a9d..5e8521a54474 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2220,6 +2220,18 @@ static struct extra_reg intel_cmt_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
+EVENT_ATTR_STR(topdown-fe-bound,       td_fe_bound_skt,        "event=0x9c,umask=0x01");
+EVENT_ATTR_STR(topdown-retiring,       td_retiring_skt,        "event=0xc2,umask=0x02");
+EVENT_ATTR_STR(topdown-be-bound,       td_be_bound_skt,        "event=0xa4,umask=0x02");
+
+static struct attribute *skt_events_attrs[] = {
+	EVENT_PTR(td_fe_bound_skt),
+	EVENT_PTR(td_retiring_skt),
+	EVENT_PTR(td_bad_spec_cmt),
+	EVENT_PTR(td_be_bound_skt),
+	NULL,
+};
+
 #define KNL_OT_L2_HITE		BIT_ULL(19) /* Other Tile L2 Hit */
 #define KNL_OT_L2_HITF		BIT_ULL(20) /* Other Tile L2 Hit */
 #define KNL_MCDRAM_LOCAL	BIT_ULL(21)
@@ -6801,6 +6813,18 @@ __init int intel_pmu_init(void)
 		name = "crestmont";
 		break;
 
+	case INTEL_ATOM_DARKMONT_X:
+		intel_pmu_init_skt(NULL);
+		intel_pmu_pebs_data_source_cmt();
+		x86_pmu.pebs_latency_data = cmt_latency_data;
+		x86_pmu.get_event_constraints = cmt_get_event_constraints;
+		td_attr = skt_events_attrs;
+		mem_attr = grt_mem_attrs;
+		extra_attr = cmt_format_attr;
+		pr_cont("Darkmont events, ");
+		name = "darkmont";
+		break;
+
 	case INTEL_WESTMERE:
 	case INTEL_WESTMERE_EP:
 	case INTEL_WESTMERE_EX:
-- 
2.40.1

