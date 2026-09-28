Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE029468C1D;
	Mon, 28 Sep 2026 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581842; cv=none; b=i811MhjxkXgqd2vEWFiLVPQryVYrMnX4gK0V+lPKWwJVrGRK5+xhXrjwdOLODMmJNjaOEhhvqraYkOIibmr69fYRzDkDlnout/WugmKalkTJDfoH1VRufx0Hb8HKMr0lWShQYQntlDs7mO8G5Vtyx9OpSqR+sLcEj8TATMvthuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581842; c=relaxed/simple;
	bh=zdMq2btf1wH1v06mrDFanwpxOsb79eZWpQdtXOBGLEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hJn9723enedMsNdC/v50U/E7kD0bawPMYNoySrid0UFb7w3TCa79jXNP6Z6GWH50nS2z5ohGipQIT2YT7GdMuAUGBK+3f9LhZVCEL2+V88r37W3ypqLZHqexft4aXudjyP4mnli0fTYAIOudfrvSvyQ44zMNuQoodqlU4hw9bMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IcfYYg+p; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IcfYYg+p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790581841; x=1822117841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zdMq2btf1wH1v06mrDFanwpxOsb79eZWpQdtXOBGLEE=;
  b=IcfYYg+pETU6lT0fsYNYadMCIHphTINbHKEzo8ip+5UqqBGJ+WkQ+cdx
   dmFNxJXh9mj3Zy10XjL8wRLmjsoZWMstAcmi8maTKj+juwno5SvKdEbL+
   voCH3raJ1pdCacIXWYX/3pt026+QeqR8/mhGrWMtPMWbpEfDURKyL9Zgu
   JUxTALPlt/sdjCHL/Liw8/8g1FzT/xR17nPmUxyPfF0VXmAbx/TA5T27l
   qQKs43aFt8MeTbdvW/afFQ6ANqiTF9+ZB+2orQHaD5mGH2vjadr5BEh8R
   qUDPLnz5ajvF2a2shFgAtC2vlxKatkomzZxqgad20/Y1XfA5P+hTtC8e9
   Q==;
X-CSE-ConnectionGUID: qYLLfPEaQQuq7yOOGat4eg==
X-CSE-MsgGUID: ib0j6FY8QlafsK3FWfl06g==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90141388"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90141388"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 00:50:41 -0700
X-CSE-ConnectionGUID: 5I5kSBesQguzIZKE8h/6JA==
X-CSE-MsgGUID: nqut8e5rSieRFxg4UW67Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275024863"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 28 Sep 2026 00:50:37 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 02/15] perf/x86/intel: Reset active_fixed_ctrl_val on CPU teardown
Date: Mon, 28 Sep 2026 15:42:56 +0800
Message-Id: <20260928074309.898043-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpuc->active_fixed_ctrl_val tracks the value currently programmed into
MSR_CORE_PERF_FIXED_CTR_CTRL, and reprogramming is skipped when the new
value matches the cached one.

After a CPU offline/online cycle, MSR_CORE_PERF_FIXED_CTR_CTRL may return
to its reset state, but active_fixed_ctrl_val may still hold the
pre-offline value. If the next computed fixed_ctrl_val matches that stale
cache entry, the MSR update is incorrectly skipped, leaving
MSR_CORE_PERF_FIXED_CTR_CTRL uninitialized for fixed counters and
resulting in errors in fixed counter counting or samplig.

Clear active_fixed_ctrl_val and MSR_CORE_PERF_FIXED_CTR_CTRL during CPU
teardown so MSR_CORE_PERF_FIXED_CTR_CTRL is always reprogrammed when the
CPU comes back online.

Fixes: fae9ebde9696 ("perf/x86/intel: Optimize FIXED_CTR_CTRL access")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 65815d13ae3f..b8dd7b73c31a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6591,8 +6591,25 @@ static void free_excl_cntrs(struct cpu_hw_events *cpuc)
 	cpuc->constraint_list = NULL;
 }
 
+static void fini_fixed_cntrs_on_cpu(int cpu)
+{
+	struct cpu_hw_events *cpuc;
+
+	if (x86_pmu.version < 2)
+		return;
+
+	/*
+	 * Clear active_fixed_ctrl_val so MSR_CORE_PERF_FIXED_CTR_CTRL
+	 * can be reprogrammed after CPU online.
+	 */
+	cpuc = &per_cpu(cpu_hw_events, cpu);
+	cpuc->active_fixed_ctrl_val = 0;
+	wrmsrq_on_cpu(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
+}
+
 static void intel_pmu_cpu_dying(int cpu)
 {
+	fini_fixed_cntrs_on_cpu(cpu);
 	fini_debug_store_on_cpu(cpu);
 	fini_arch_pebs_on_cpu(cpu);
 }
-- 
2.34.1

