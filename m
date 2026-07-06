Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225BF18C2C;
	Mon,  6 Jul 2026 02:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303289; cv=none; b=jjsTzlUEgoIywCT/WBL726uyVxaUk7fQcUDfoWWW8i3+peLLx0q1N7/BClwFgmpUIhz302UP+NDHEahDUE4vJiPmTI4dTwFAEWab/YeFdWi6nE7sgARQ3afmyGd5x68dPwJHrEm7v1qDekVWWaLRJNRmvP74g7AyBiUcbqRLdxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303289; c=relaxed/simple;
	bh=tuyZjr5EP9qPUsB7n6tM7ofzWD5aQAftAphuW4Lj9u8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uMV0bpOV2/SXUeEsDhxL/r3DEzMJ8cRk6M/jpVI3mECq/QCt+60wTShmbBmMHpocZYPu40isA5qnztp2HdBNYvYpl7F9xbDbjD1TSLN9QrwOQm1gtuqluF9vDFVq9MwURB2WRahUd1PpZvUehO0L66VMCZ6w/SdOODs6KdEOC4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEHj0Omn; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEHj0Omn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783303289; x=1814839289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tuyZjr5EP9qPUsB7n6tM7ofzWD5aQAftAphuW4Lj9u8=;
  b=nEHj0Omn6j4nmPQNn8kGnFMoHN8wNRESHHW+dXeEQT4q3h3tpnusBURx
   DKpjbBQ/S4NRN6pqLCQaBhsZecfKtYZs5Mr6+SHtvqyzjmYMIJL3b4upC
   7JSIo1gHdLBs0LkgnKO2YvCBTMgJBFCai24Egj86gSpKI7Qj7CaQRmNu/
   LhLeT006vA7An6A8uMgTjtgfVfNaHqKRg7ndz6dPXjCbIH6OmBCO4Y638
   9Jq4hqFij3AbcUrB2dyjquOV7dlbA/yrVCqi2gsCG5o8uDjR2zQbBTrN+
   nVGgRXLQiI43e6XbwG/GQGnoYgalsEhpePCccwN6X/s1X9k0ypM8PVsG6
   A==;
X-CSE-ConnectionGUID: eNaRUVTJRDOHf+M/atFw5Q==
X-CSE-MsgGUID: RwrQJvaxRxq8t91BWd8weA==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83911584"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83911584"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:01:28 -0700
X-CSE-ConnectionGUID: RnO0wCOjQ/WUmoZJv4PgHg==
X-CSE-MsgGUID: iy1KMsl7Q3KOaxESzyYkag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="247191276"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jul 2026 19:01:23 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v9 04/24] perf/x86/intel: Convert x86_perf_regs to per-cpu variables
Date: Mon,  6 Jul 2026 09:54:19 +0800
Message-Id: <20260706015439.3040804-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the drain_pebs() helpers, e.g., intel_pmu_drain_arch_pebs()
define an on-stack x86_perf_regs. Upcoming patches will add new fields
like *ymm_regs and *zmm_regs to the x86_perf_regs structure to support
sampling for these SIMD registers. This would increase the stack size
consumed by these helpers, potentially triggering the warning:

"the frame size of 1048 bytes is larger than 1024 bytes
 [-Wframe-larger-than=]".

To eliminate this warning, convert x86_perf_regs to per-cpu variables.

Please note drain_pebs() can't be interrupted by other NMIs since
either it's already in NMI context or PMU is already disabled.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e86e4ba91e1b..7b69f8c8d0c2 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2917,6 +2917,8 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 	}
 }
 
+static DEFINE_PER_CPU(struct x86_perf_regs, x86_pebs_regs);
+
 static __always_inline void
 __intel_pmu_pebs_events(struct perf_event *event,
 			struct pt_regs *iregs,
@@ -2926,8 +2928,8 @@ __intel_pmu_pebs_events(struct perf_event *event,
 			setup_fn setup_sample)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct x86_perf_regs perf_regs;
-	struct pt_regs *regs = &perf_regs.regs;
+	struct x86_perf_regs *perf_regs = this_cpu_ptr(&x86_pebs_regs);
+	struct pt_regs *regs = &perf_regs->regs;
 	void *at = get_next_pebs_record_by_bit(base, top, bit);
 	int cnt = count;
 
@@ -3175,8 +3177,8 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
-	struct x86_perf_regs perf_regs;
-	struct pt_regs *regs = &perf_regs.regs;
+	struct x86_perf_regs *perf_regs = this_cpu_ptr(&x86_pebs_regs);
+	struct pt_regs *regs = &perf_regs->regs;
 	struct pebs_basic *basic;
 	void *base, *at, *top;
 	u64 mask;
@@ -3226,8 +3228,8 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	union arch_pebs_index index;
-	struct x86_perf_regs perf_regs;
-	struct pt_regs *regs = &perf_regs.regs;
+	struct x86_perf_regs *perf_regs = this_cpu_ptr(&x86_pebs_regs);
+	struct pt_regs *regs = &perf_regs->regs;
 	void *base, *at, *top;
 	u64 mask;
 
-- 
2.34.1

