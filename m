Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543A2D29D0;
	Wed, 20 Aug 2025 02:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755657113; cv=none; b=RDPyn6bd0V5QxtU6ywaujvdErcx7hW/14PIyRMOAqUuGs/ePVC0fNM67lNiQ6JJ01JXbHCG2py2XPcSzkEYNwydvytBJ36d0oacitpFUtJ2AIbjrL8RvpR728UaVpVK8yZzNTf3I+wb0Eqe8pbn9O4UKbewNl4Pb5PY1BzpOBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755657113; c=relaxed/simple;
	bh=402V8pGoVyuTsWmTmtf9pX4uV3lRq6eo3ZhtScx0QkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eq6ZfaNko30FyJoXU/didmi3B3lZGnweNSg4wVSLQ2G68haaYtf42maJ6cq5ZsrH6JEbhEaYfAqXiyHIOP4LQIalybpoYtUOvMguhD5yIORxyfUQFZIHRwtJrrbrxDImnthWBeYirJ7MzFquxKKWHGztLWx/qTjA0X3bvYVHHd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmMZ80Va; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmMZ80Va"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755657112; x=1787193112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=402V8pGoVyuTsWmTmtf9pX4uV3lRq6eo3ZhtScx0QkU=;
  b=MmMZ80Vap05KW5VjGl4yuRWuyp4EjYFO/rS/ETeSa+o2RbDMD2iqndkZ
   4J9mYD5lZ4VzxeEjz2SxKXBuzBmSl1ZM3P/hknxR+omwavgXINg9KJs/T
   5Z+wFxKRlkQh8+gISSB+tKSs8xfLe9TPVgQcY/+u6dOzfFmcxzEEhbxnv
   EMD1Xh45aKcRPwI20B71cjoseBulqsxEdw3HFhs8gbHc5gOvSn1/fgfws
   mEWu7O7yTlhbjJd/uj/Mh2xun7e5SBSrx1PfhPCKXehVwnl7lTkStca2d
   Z2yhYdzGWe6pUlKJYr4InpMYMpvFgjftJEB6El2DxUiNrlcMVSacEqVJ+
   g==;
X-CSE-ConnectionGUID: 2fwuLXnXTBKL3qg1CtI5TA==
X-CSE-MsgGUID: fk71IGBJSbCIGom0Ej14Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57625484"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57625484"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 19:31:52 -0700
X-CSE-ConnectionGUID: SvY+pXAeTsOP9dhMjxJYGQ==
X-CSE-MsgGUID: xcVpyhpFQJqXj6kA676hLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167629046"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 19 Aug 2025 19:31:48 -0700
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
Subject: [Patch v3 6/7] perf/x86/intel: Add ICL_FIXED_0_ADAPTIVE bit into INTEL_FIXED_BITS_MASK
Date: Wed, 20 Aug 2025 10:30:31 +0800
Message-Id: <20250820023032.17128-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
References: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ICL_FIXED_0_ADAPTIVE is missed to be added into INTEL_FIXED_BITS_MASK,
add it.

With help of this new INTEL_FIXED_BITS_MASK, intel_pmu_enable_fixed() can
be optimized. The old fixed counter control bits can be unconditionally
cleared with INTEL_FIXED_BITS_MASK and then set new control bits base on
new configuration.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 arch/x86/events/intel/core.c      | 10 +++-------
 arch/x86/include/asm/perf_event.h |  6 +++++-
 arch/x86/kvm/pmu.h                |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f88a99d8d125..28f5468a6ea3 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2845,8 +2845,8 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
-	u64 mask, bits = 0;
 	int idx = hwc->idx;
+	u64 bits = 0;
 
 	if (is_topdown_idx(idx)) {
 		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -2885,14 +2885,10 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 
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

