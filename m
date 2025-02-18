Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25FA22DFB9;
	Tue, 18 Feb 2025 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866434; cv=none; b=TqDxJEKls1tfB8TI1dI42XNWE/PafjvIl0IYQFqtdtl4vYVeRGw/jP42ZjuwQ1YecG9y6nZukXXxIf04vaRi/+ht4l8xp3uv90eMqk5CBjUIcrkVLZxX22B+uk/cl0uODLH55lshHZHi729eaMVN1oSci4/mXIQIBFLJzzAxcQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866434; c=relaxed/simple;
	bh=Uut365/ciFBvWZ+DR4kLzryNCuCzRyMVrUTrk247BYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kWdInzi8yAqLAaiRC/OIAdgkkQhSbgiR2mtvER23zhKZnRYPyX6Y6OpMU84yh6weCrw0j5R476VBG1J9UTFZj9VfUraQPIM2SoaS1RN1u2hWUsNA4yOmY48dTsj6jujWs/ZCkUzaPn90P4GlnDkSk1WjLYMz7XB1UcfCkcSMZyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dUlT4cK+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dUlT4cK+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866434; x=1771402434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uut365/ciFBvWZ+DR4kLzryNCuCzRyMVrUTrk247BYA=;
  b=dUlT4cK++sFQjsicIhfknIQ1dPml5WPyw/oO1YRGcMEyz0qO3YYRsEGU
   mV5NxK7SA1h6ccvVjGrpKCecche0ParVfcG4Y5/y5M8hbFqxYUvoBWRDB
   q75WsYOAv/Ax0CtoXkbyWFoKE6dDze9QW4UnGYfPZ+LGbO1La7+wSgFzs
   IRxN7y6M7CI7kZpnHSJulRm2K9A9O7rSv+4RAMO+wj3fCJQEBCIwETOGp
   eWyaGbv81B4y2yaLLS0rdqS9I4hAG9+ptNmthwi0rAChHV9qMrfMFjjWL
   tBh1t5GAhLLhauiGoa/yk0tOw0WQpb9BG1bfzczYXdgJkMU8bD4NOpg1Q
   w==;
X-CSE-ConnectionGUID: rmdXl/9RRtuGDkv/Wl7OFA==
X-CSE-MsgGUID: SHvstu0RQGWeitrI/2b8FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200721"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208,223";a="44200721"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:13:54 -0800
X-CSE-ConnectionGUID: pNRWhCyyTruyIsZKlHVrww==
X-CSE-MsgGUID: BimNziPCT1uzqqwjG5+GUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208,223";a="145166109"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:13:50 -0800
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
Subject: [Patch v2 03/24] perf/x86/intel: Add PMU support for Clearwater Forest
Date: Tue, 18 Feb 2025 15:27:57 +0000
Message-Id: <20250218152818.158614-4-dapeng1.mi@linux.intel.com>
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
index 936711db9b32..7521e1e55c0e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2230,6 +2230,18 @@ static struct extra_reg intel_cmt_extra_regs[] __read_mostly = {
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
@@ -6802,6 +6814,18 @@ __init int intel_pmu_init(void)
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

