Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522191D1724;
	Thu, 23 Jan 2025 06:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737613249; cv=none; b=Y2rog8IsSpqLU6ZPvQfjqiRdgv/9J8KiCYWYSvR+HnNcZcyCkUGCkqlBYff3O5kdFAC3ibvrPfeQP3ZHAwfOCdKNajXi/EW1QocByxmPBwKd9qYydMIuhf9XkSQdG6gUYIE8v/QsRwXX+wdUx1WM4Q/tecbxz0AM3k3TLklXm7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737613249; c=relaxed/simple;
	bh=mZKJOuHIfxOBrRVooiJbWghFpD1aSivSH6cGxszIQdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PbZt8pHRfUoApG4AGE4ncvt2ymx6+fKR960s8Jr1G+QIHECUcfDEtWeNP86oJPgl+OCO9eoRyLy+h5RX0zWnycUqUavB4mFGGID+sQbyAssWEF9a9t+HOe1aG1SYha7JXucBmwOc22M/r9qokUvd4q3o7KrTseWeFmlscMQNYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gkznNnc8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gkznNnc8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737613249; x=1769149249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mZKJOuHIfxOBrRVooiJbWghFpD1aSivSH6cGxszIQdY=;
  b=gkznNnc85LL48IttoxYz1tAXh2xQaypQv0fF4yzX04PFsxMVyxUkIrdw
   EoIErS4vS0niE7T858etZI3rxzQTOv/ueyS99vtqgYbLa8v5IObqAzxEn
   jUn1LtvZfH8f1FNy3SE5S65+ThUMppq+GKEwki3OkmXLeRPtkfeZaDtGg
   DRG4Ir8wBasvQOqkSblAJTrFs66+4cJim2AQXQFlhA3+fare+/nuPHhhu
   nTHEUu9ZfxJvz/AFEpdNI/tAHfNBcFdZMStb1CtsHiHEHJIkXf17LZGn8
   uRx7HhubqBVEg5UKhFZbUdtp3nZ0sUwF3gNQ1wUVHpnVk91B/Zz0YVWPh
   Q==;
X-CSE-ConnectionGUID: bumZ3KzzRV+DrsB4IYTl0A==
X-CSE-MsgGUID: OPXYHr5tQri8W21bAnibhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55513131"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="55513131"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 22:20:49 -0800
X-CSE-ConnectionGUID: WumO+90kTAqWnE2niY+v6Q==
X-CSE-MsgGUID: E55x1I8zTK+FtRBj0XQGjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112334624"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 22:20:45 -0800
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
Subject: [PATCH 11/20] perf/x86/intel: Setup PEBS constraints base on counter & pdist map
Date: Thu, 23 Jan 2025 14:07:12 +0000
Message-Id: <20250123140721.2496639-12-dapeng1.mi@linux.intel.com>
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

arch-PEBS provides CPUIDs to enumerate which counters support PEBS
sampling and precise distribution PEBS sampling. Thus PEBS constraints
can be dynamically configured base on these counter and precise
distribution bitmap instead of defining them statically.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 20 ++++++++++++++++++++
 arch/x86/events/intel/ds.c   |  1 +
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7775e1e1c1e9..0f1be36113fa 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3728,6 +3728,7 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			    struct perf_event *event)
 {
 	struct event_constraint *c1, *c2;
+	struct pmu *pmu = event->pmu;
 
 	c1 = cpuc->event_constraint[idx];
 
@@ -3754,6 +3755,25 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 		c2->weight = hweight64(c2->idxmsk64);
 	}
 
+	if (x86_pmu.arch_pebs && event->attr.precise_ip) {
+		u64 pebs_cntrs_mask;
+		u64 cntrs_mask;
+
+		if (event->attr.precise_ip >= 3)
+			pebs_cntrs_mask = hybrid(pmu, arch_pebs_cap).pdists;
+		else
+			pebs_cntrs_mask = hybrid(pmu, arch_pebs_cap).counters;
+
+		cntrs_mask = hybrid(pmu, fixed_cntr_mask64) << INTEL_PMC_IDX_FIXED |
+			     hybrid(pmu, cntr_mask64);
+
+		if (pebs_cntrs_mask != cntrs_mask) {
+			c2 = dyn_constraint(cpuc, c2, idx);
+			c2->idxmsk64 &= pebs_cntrs_mask;
+			c2->weight = hweight64(c2->idxmsk64);
+		}
+	}
+
 	return c2;
 }
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 2f2c6b7c801b..a573ce0e576a 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2941,6 +2941,7 @@ static void __init intel_arch_pebs_init(void)
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
 	x86_pmu.drain_pebs = intel_pmu_drain_arch_pebs;
 	x86_pmu.pebs_capable = ~0ULL;
+	x86_pmu.flags |= PMU_FL_PEBS_ALL;
 }
 
 /*
-- 
2.40.1

