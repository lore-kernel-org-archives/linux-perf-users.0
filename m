Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662CB28A1C3;
	Tue, 15 Apr 2025 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705435; cv=none; b=DLZv2S4vcsTFZZTrSj32bMzCuRmCaX0NFV1fWL4b30dXd+Os5L569zu4mmNVd+0dduryModi1VlOpj7P06iOffUoCt1CMKWBb6tJ1i2bkbjs8dw93v6tIOMVTSHkFLIbcFdvO3SO2Y2Vky3JE2modaQn0HP1NHjQ70bUySx1C64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705435; c=relaxed/simple;
	bh=+5pmn70+QMBztXdc0bA1AWAPW44xJnx2qTnnWfMn0UU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LG0ctEqI8lYiceJTbDnGbcM7Jdls1gjsc1y9oWxvhsJfif7l07bhl4S9roEboYgm4E3AGES1O3VeNnr7xmAbWWXAtfUiCqZCUuuuuXE/GmLPDHYYHBrSTa7BRZZ+F5L8adjSE9OlcaMDu7HK1PEF9lka8HDhBlB6hZcFKNF2Qgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFFXwN4N; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFFXwN4N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705434; x=1776241434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+5pmn70+QMBztXdc0bA1AWAPW44xJnx2qTnnWfMn0UU=;
  b=QFFXwN4NwSPaKR54saIkvXz0NgoNXqA/a7Ikt32p8IOGESOg4aQ2cPjN
   lw90+8XJ1++vmlHAz9g7OLgYIh22y4Tnt+Pps2opadg37QO7J2JlsapQ0
   8BNeDhVxZtC4SBVbK1WpOlnvj1gASiNN+vf+jfQrKqLXkHzA3UVwQYIFx
   9Kzic2aKsN0FgpFevPAsLfsKclMB6+MSVxqw5hNM7zeBSmJtLYUSzheuv
   f9mtFiu6y/Gq6/KsADlU2mOQ2qe1cpIbhlly3GClOZeSdpbDmbbIGtezw
   rW2lvYvWd20vi7oG5WgpldqsMXsyTqYbXuu0xjz7B2mKaIUr4wGcPMCZv
   A==;
X-CSE-ConnectionGUID: zNK6yjz6TzG7pj5Fbgujwg==
X-CSE-MsgGUID: 3ZVGfUP2RRmnMR/ewKAGpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46116029"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46116029"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:23:54 -0700
X-CSE-ConnectionGUID: NNim8lJJTtKw8ycdifHkzQ==
X-CSE-MsgGUID: X23G9NEDR8CM7Oozz4Zn3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130055619"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2025 01:23:50 -0700
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
Subject: [Patch v3 12/22] perf/x86/intel: Update dyn_constranit base on PEBS event precise level
Date: Tue, 15 Apr 2025 11:44:18 +0000
Message-Id: <20250415114428.341182-13-dapeng1.mi@linux.intel.com>
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

arch-PEBS provides CPUIDs to enumerate which counters support PEBS
sampling and precise distribution PEBS sampling. Thus PEBS constraints
should be dynamically configured base on these counter and precise
distribution bitmap instead of defining them statically.

Update event dyn_constraint base on PEBS event precise level.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 9 +++++++++
 arch/x86/events/intel/ds.c   | 1 +
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e0be6be50936..265b5e4baf73 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4252,6 +4252,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	}
 
 	if (event->attr.precise_ip) {
+		struct arch_pebs_cap pebs_cap = hybrid(event->pmu, arch_pebs_cap);
+
 		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_FIXED_VLBR_EVENT)
 			return -EINVAL;
 
@@ -4265,6 +4267,13 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		}
 		if (x86_pmu.pebs_aliases)
 			x86_pmu.pebs_aliases(event);
+
+		if (x86_pmu.arch_pebs) {
+			u64 cntr_mask = event->attr.precise_ip >= 3 ?
+						pebs_cap.pdists : pebs_cap.counters;
+			if (cntr_mask != hybrid(event->pmu, intel_ctrl))
+				event->hw.dyn_constraint = cntr_mask;
+		}
 	}
 
 	if (needs_branch_stack(event)) {
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7437a52ba5f0..757d97c05d8f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2968,6 +2968,7 @@ static void __init intel_arch_pebs_init(void)
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
 	x86_pmu.drain_pebs = intel_pmu_drain_arch_pebs;
 	x86_pmu.pebs_capable = ~0ULL;
+	x86_pmu.flags |= PMU_FL_PEBS_ALL;
 
 	x86_pmu.pebs_enable = __intel_pmu_pebs_enable;
 	x86_pmu.pebs_disable = __intel_pmu_pebs_disable;
-- 
2.40.1

