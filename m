Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77949263C90;
	Mon, 11 Aug 2025 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902922; cv=none; b=Gd17tGQBaTl7NkEFlc/i4yVp/CiOjQQ23PwJ5RXD4lr8yrIga0eWg7ZAsEme96b1WzpfpJn6zTNLMP+HgiDEO/2iHqCz9487EQgf8EjGmxiPFQJJV1z1rbFgw+t+g/afCUuO1y24qXJdijQlCjIB5VBmScXLfPM63W9DFyFX7rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902922; c=relaxed/simple;
	bh=P8KdGfXOFljOVpITDk6jNbMaI0Tluc2AyNId32bn8X0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dboTjyoa7CjfbDKPaUnGF0UB5SI3T3xMy7iBGfKjoYMHDOFFE1jyXUE6+oS84ZNgIqejg3SZkYtZ5DN/GckMPzVq44GNynLY+8wGy1+dsJU72bwAzYwqmHKoNlNV713I4TACno7XUg2l/o8+6BbYDuXBCPnbKZklulsd8rEyJ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrMcwE5Y; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrMcwE5Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754902921; x=1786438921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P8KdGfXOFljOVpITDk6jNbMaI0Tluc2AyNId32bn8X0=;
  b=nrMcwE5YDSSEradkTK/sw90nPJfFLOUqs5STtw4+gU1xMe2NF9RacFFd
   pQ97pHM3PrZ+ldJqKppgUvoaCHM/j+b1DQkWujw5uxnr2P5MQ/aOlrR4s
   OzOKWmdKXh6wX5wZHrlrUIEbzlD5B6QlG3GGACirbjnyO7QaVIE2R+Sn1
   61vr6yaGGo2fxysJ3kaieWLDK9lCpdZj24vbQiAyDtAH1WPXOPR8/T0IY
   QlkQ0nHobYSpNZoUBpPmQB1QT86dABo/DLDGvcTT5jb0TfpPxt7nB1U7h
   HsQYuzgR2Z5a5yBq8vpMNW5vO9U7JxPCog/bWwgC6zcYHXJjFkUGC2jNz
   Q==;
X-CSE-ConnectionGUID: +9NS8Vw7QO2gp4kaX6cs5g==
X-CSE-MsgGUID: p+tz45hAT0icjISLrcBlIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57107447"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57107447"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 02:01:51 -0700
X-CSE-ConnectionGUID: ET+7rkEkSgiiyQhbJMJq2w==
X-CSE-MsgGUID: 0uSjbyJxQieZi3HUvpWINA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166219975"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 11 Aug 2025 02:01:48 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Yi Lai <yi1.lai@intel.com>
Subject: [Patch v2 6/6] perf/x86/intel: Add ICL_FIXED_0_ADAPTIVE bit into INTEL_FIXED_BITS_MASK
Date: Mon, 11 Aug 2025 17:00:34 +0800
Message-Id: <20250811090034.51249-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811090034.51249-1-dapeng1.mi@linux.intel.com>
References: <20250811090034.51249-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ICL_FIXED_0_ADAPTIVE is missed to be added into INTEL_FIXED_BITS_MASK,
add it and opportunistically refine fixed counter enabling code.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 arch/x86/events/intel/core.c      | 10 +++-------
 arch/x86/include/asm/perf_event.h |  6 +++++-
 arch/x86/kvm/pmu.h                |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cdd10370ed95..1a91b527d3c5 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2849,8 +2849,8 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
-	u64 mask, bits = 0;
 	int idx = hwc->idx;
+	u64 bits = 0;
 
 	if (is_topdown_idx(idx)) {
 		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -2889,14 +2889,10 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 
 	idx -= INTEL_PMC_IDX_FIXED;
 	bits = intel_fixed_bits_by_idx(idx, bits);
-	mask = intel_fixed_bits_by_idx(idx, INTEL_FIXED_BITS_MASK);
-
-	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip) {
+	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip)
 		bits |= intel_fixed_bits_by_idx(idx, ICL_FIXED_0_ADAPTIVE);
-		mask |= intel_fixed_bits_by_idx(idx, ICL_FIXED_0_ADAPTIVE);
-	}
 
-	cpuc->fixed_ctrl_val &= ~mask;
+	cpuc->fixed_ctrl_val &= ~intel_fixed_bits_by_idx(idx, INTEL_FIXED_BITS_MASK);
 	cpuc->fixed_ctrl_val |= bits;
 }
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index f8247ac276c4..49a4d442f3fc 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -35,7 +35,6 @@
 #define ARCH_PERFMON_EVENTSEL_EQ			(1ULL << 36)
 #define ARCH_PERFMON_EVENTSEL_UMASK2			(0xFFULL << 40)
 
-#define INTEL_FIXED_BITS_MASK				0xFULL
 #define INTEL_FIXED_BITS_STRIDE			4
 #define INTEL_FIXED_0_KERNEL				(1ULL << 0)
 #define INTEL_FIXED_0_USER				(1ULL << 1)
@@ -48,6 +47,11 @@
 #define ICL_EVENTSEL_ADAPTIVE				(1ULL << 34)
 #define ICL_FIXED_0_ADAPTIVE				(1ULL << 32)
 
+#define INTEL_FIXED_BITS_MASK					\
+	(INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER |		\
+	 INTEL_FIXED_0_ANYTHREAD | INTEL_FIXED_0_ENABLE_PMI |	\
+	 ICL_FIXED_0_ADAPTIVE)
+
 #define intel_fixed_bits_by_idx(_idx, _bits)			\
 	((_bits) << ((_idx) * INTEL_FIXED_BITS_STRIDE))
 
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index ad89d0bd6005..103604c4b33b 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -13,7 +13,7 @@
 #define MSR_IA32_MISC_ENABLE_PMU_RO_MASK (MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL |	\
 					  MSR_IA32_MISC_ENABLE_BTS_UNAVAIL)
 
-/* retrieve the 4 bits for EN and PMI out of IA32_FIXED_CTR_CTRL */
+/* retrieve a fixed counter bits out of IA32_FIXED_CTR_CTRL */
 #define fixed_ctrl_field(ctrl_reg, idx) \
 	(((ctrl_reg) >> ((idx) * INTEL_FIXED_BITS_STRIDE)) & INTEL_FIXED_BITS_MASK)
 
-- 
2.34.1

