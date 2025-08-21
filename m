Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265C82E9EDA;
	Thu, 21 Aug 2025 03:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748789; cv=none; b=JUmuvOTlbcXltLIwpPj+LidtBWYoaDMPFgjrOMo/WqXmwMTvJcjMN6WCcZ/wvff0I+AW7jbh6rrT3YBfQsVD2AWrTSdgayF0TuiqaRs4T2QhfIgApvvqpOE5qOWb7oD01G8eS6zcAUZKjig/PU0KPmvYBHDAEuLMpe2y5cr5pzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748789; c=relaxed/simple;
	bh=TU+a+AKw+IF6yPIxUuarj9IFTlH3nC2cT7bicPtVW7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F68HcQb3sX88lfvROk2YlRkBTjrzGdEMkpvmwb1sNCJ4FQ0chTM1TgHHyrNv4R0FYSYl4V2nom2pPvnVLuFrZi+P6Fl6Lyu+qDKOy4qgpGKpBTj7UYPUyZ813uWIlqpfD/X+fHCWVfLngiy1yrPzDqbD3O5FFNjP11Uvh8/2qgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gk+t4fAo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gk+t4fAo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755748788; x=1787284788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TU+a+AKw+IF6yPIxUuarj9IFTlH3nC2cT7bicPtVW7g=;
  b=Gk+t4fAo3NC8UYZ6SqaItAY3JY66ThUuxIkA21HHtVgHX64VWjToJDs8
   LW2nyhkAFB0B3tgO8uda3iiw5KstlO772oghsXrOzatiIIqcgJUsS28RT
   kt252ToSMWY/g9sI8Bk6U+q5eJWNb22W85ytIWwRQNxVY7tZTR/X3dKs/
   rniv80FOpIpEK/GtLGxmPEYLTEVdjpFS8eTNDlzFNjB3bKmG60xzfsGl4
   UFp5poHX6v+S5Lra20evSV4Fx+UGNL+8JZ4h5nJBaOgqtbDW2lzATAcBZ
   aF0ktaGHVgamcw5icLKmf47YTB6w2HX2VGv/DcTOMLWgQ/1p6X0jsFIkf
   w==;
X-CSE-ConnectionGUID: R1iI8ALFR4WXffdprjTVCg==
X-CSE-MsgGUID: w40Q5nEbRv2RxTpfyGwOBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68732005"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="68732005"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 20:59:48 -0700
X-CSE-ConnectionGUID: VuyHsN7HSIe2FVd4psoftQ==
X-CSE-MsgGUID: r6R8a3omTYaPWdh0+chUwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168713127"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 20 Aug 2025 20:59:45 -0700
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
Subject: [Patch v6 08/10] perf/x86/intel: Update dyn_constranit base on PEBS event precise level
Date: Thu, 21 Aug 2025 11:58:03 +0800
Message-Id: <20250821035805.159494-9-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821035805.159494-1-dapeng1.mi@linux.intel.com>
References: <20250821035805.159494-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch-PEBS provides CPUIDs to enumerate which counters support PEBS
sampling and precise distribution PEBS sampling. Thus PEBS constraints
should be dynamically configured base on these counter and precise
distribution bitmap instead of defining them statically.

Update event dyn_constraint base on PEBS event precise level.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 11 +++++++++++
 arch/x86/events/intel/ds.c   |  1 +
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 41c4af6bd62c..818c197585c6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4252,6 +4252,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	}
 
 	if (event->attr.precise_ip) {
+		struct arch_pebs_cap pebs_cap = hybrid(event->pmu, arch_pebs_cap);
+
 		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_FIXED_VLBR_EVENT)
 			return -EINVAL;
 
@@ -4265,6 +4267,15 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		}
 		if (x86_pmu.pebs_aliases)
 			x86_pmu.pebs_aliases(event);
+
+		if (x86_pmu.arch_pebs) {
+			u64 cntr_mask = hybrid(event->pmu, intel_ctrl) &
+						~GLOBAL_CTRL_EN_PERF_METRICS;
+			u64 pebs_mask = event->attr.precise_ip >= 3 ?
+						pebs_cap.pdists : pebs_cap.counters;
+			if (cntr_mask != pebs_mask)
+				event->hw.dyn_constraint &= pebs_mask;
+		}
 	}
 
 	if (needs_branch_stack(event)) {
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7a91c4408d33..141acd45cdb3 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -3008,6 +3008,7 @@ static void __init intel_arch_pebs_init(void)
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
 	x86_pmu.drain_pebs = intel_pmu_drain_arch_pebs;
 	x86_pmu.pebs_capable = ~0ULL;
+	x86_pmu.flags |= PMU_FL_PEBS_ALL;
 
 	x86_pmu.pebs_enable = __intel_pmu_pebs_enable;
 	x86_pmu.pebs_disable = __intel_pmu_pebs_disable;
-- 
2.34.1

