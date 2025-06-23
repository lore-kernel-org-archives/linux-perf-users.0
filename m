Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCA320E6F7;
	Thu, 26 Jun 2025 03:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750909398; cv=none; b=Zyagef4MgGJQE6MxGEgmtD6cYHVN6odVlZHzk4x5VsK8qs0uj6KQT9IhURduso15gbijk5mV4NeLXzBqQKl0aHtDTI9VOX94ma1a9XKUdu+P6E4vEzBtSUuYF7FqEMCsQem++KIEF/q5Zw3ECtjJFpiFcE2vyHH6gPq6Y3pNTRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750909398; c=relaxed/simple;
	bh=4mvaUopx/Fl+Ry2XwaUVH7Kjsnnjmwgs753hp10/4NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJVLfouRDQcgw3nrSYzl+MzlMNeaUtUmM8PGz+oWz4+hJZPS3qa8izpdB01VpWzVWXu3KF+A+ZAnzoFZdy93DN9ThCqPWIETc4XPl/XV3J1KvZdvEh1J9gozT8+Mxx6RL1BhaHCObj2rnRiyO63fNkJdmjYUjDJyMDCa7FG+NIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sksj60YB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sksj60YB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750909396; x=1782445396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4mvaUopx/Fl+Ry2XwaUVH7Kjsnnjmwgs753hp10/4NM=;
  b=Sksj60YBhwfle97ATk/nHwpeY7M+obk89k1LC4LAnoljUW4rRrP4ywbq
   HrKQv/a6gczF76Zdw+waAZEWJj5hRgdIVR5Mv+/6q0RoUeUj5EY+f0ZJJ
   sWfeQkx4AhItoeRXWaGe2MCVukkddNgvHk9658OeHv16dIgazb4pECB20
   Ksdd8ISZONw/HXGmUtQ6Mh6+i0Gnc2SyRknMqBCdpgFNkCkHI3gvCYYP2
   +D1QXaXhYqQKrGcexfiFyuHiRY9We/2DZmIrr0jVB7vZVs8YCPbgWkP5S
   JJEMI5bCG84X6/DBR7rYcxQNU+4zGlKWCVW8wLZgd2jt2EFFb7pBOsFa4
   g==;
X-CSE-ConnectionGUID: VRHXvhp8TPKbpY6As/UKlw==
X-CSE-MsgGUID: kC+WsdPkQOWETRWhA5adOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="55820690"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="55820690"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 20:43:16 -0700
X-CSE-ConnectionGUID: VfZnG2WHT0S+/A6V8LShCQ==
X-CSE-MsgGUID: Dp9nGqk+TKSPxYBlXq22Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="157895013"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jun 2025 20:43:13 -0700
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
Subject: [Patch v5 08/10] perf/x86/intel: Update dyn_constranit base on PEBS event precise level
Date: Mon, 23 Jun 2025 22:35:43 +0000
Message-ID: <20250623223546.112465-9-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623223546.112465-1-dapeng1.mi@linux.intel.com>
References: <20250623223546.112465-1-dapeng1.mi@linux.intel.com>
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
index da6efd08149f..8765a919391b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4255,6 +4255,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	}
 
 	if (event->attr.precise_ip) {
+		struct arch_pebs_cap pebs_cap = hybrid(event->pmu, arch_pebs_cap);
+
 		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_FIXED_VLBR_EVENT)
 			return -EINVAL;
 
@@ -4268,6 +4270,15 @@ static int intel_pmu_hw_config(struct perf_event *event)
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
index 5ec42025d272..9e153bfcff19 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2998,6 +2998,7 @@ static void __init intel_arch_pebs_init(void)
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
 	x86_pmu.drain_pebs = intel_pmu_drain_arch_pebs;
 	x86_pmu.pebs_capable = ~0ULL;
+	x86_pmu.flags |= PMU_FL_PEBS_ALL;
 
 	x86_pmu.pebs_enable = __intel_pmu_pebs_enable;
 	x86_pmu.pebs_disable = __intel_pmu_pebs_disable;
-- 
2.43.0

