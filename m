Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F5A3B6352;
	Fri, 29 May 2026 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041777; cv=none; b=aDesz3tL5WVkVbL00wGqFIW7FyE9I7oFWmEX+s7Ui45Ruk8DWOcX1i/gG128l1JDAXS+lDqUc0XsjVTMi8SC3FgfnQiY/ybiMsyUSdNW473OL1VbAmnYfOZZd0m3OEHMpwwtPUq4lx5Jgd49bqU3qMsb88KslW/34S/3LeRbhCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041777; c=relaxed/simple;
	bh=r77CfGsAvEDfFwMDjM8q9sn4kKauAREg1ZMpuQEEFN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FbNZYUbciMCmu1/1P0eQ+DNe9MiIlRzGmNc1FjVGIlw1Ic7N5ya/rOcr0shpXv/iWLalZ2SN73QpDrytZxy4uDGD7OWa9PbysK+s3tXsn2jnUukckFIlzrt5kWV+TcXTyGEmjanyZiLxNeeAWoSaj/gOW0OZrMEFp9oet62tWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a02Xhsjm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a02Xhsjm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041775; x=1811577775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r77CfGsAvEDfFwMDjM8q9sn4kKauAREg1ZMpuQEEFN8=;
  b=a02Xhsjm4RXMbQRKDiBdCF+H2/pSqiSAO/NZWp4sdIc0Jfd50BAmB2KY
   QN0EUMh1weyscQBogVfLAb7+FCSKdQ5G7YKlNqr/kM5Rs3/q5W9+IhisG
   EWXmlgLlYlqdhaOt0oF5XH3xXME/ocul+W+QyXxDvQTf3OZUvSlwaBLT6
   PjZesIL37EasOWOuDwIM01xfcNp5CueV0Y9bZ3EFP7Z1ddx7fPnHBILsb
   C98LqrnZUL/a7SVS8TfUgOj+0SXSFAxZljr0HnC7KdvDAo0VJ25DBWCbD
   PQF8QksWUAQy+h9S5KJmlOxIp73A3dELR4g1REsgQ1UeDG4ZKSlJteB1g
   w==;
X-CSE-ConnectionGUID: Olul0qKUQ8enyrsJ2qyHQA==
X-CSE-MsgGUID: JU7HO9A4R4KT8WPFtrQO7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106341874"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106341874"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:02:55 -0700
X-CSE-ConnectionGUID: okP88NSpTteufOWQCTcoxA==
X-CSE-MsgGUID: Kx3l2FVoT8CIRwtc3kWTpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246801984"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 01:02:50 -0700
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
Subject: [Patch v8 04/23] perf/x86/intel: Convert x86_perf_regs to per-cpu variables
Date: Fri, 29 May 2026 15:56:26 +0800
Message-Id: <20260529075645.580362-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the intel_pmu_drain_pebs_icl() and intel_pmu_drain_arch_pebs()
helpers define many temporary variables. Upcoming patches will add new
fields like *ymm_regs and *zmm_regs to the x86_perf_regs structure to
support sampling for these SIMD registers. This would increase the stack
size consumed by these helpers, potentially triggering the warning:
"the frame size of 1048 bytes is larger than 1024 bytes
 [-Wframe-larger-than=]".

To eliminate this warning, convert x86_perf_regs to per-cpu variables.

Please note *_drain_pebs() can't be interrupted by other NMIs since
either it's already in NMI context or PMU is already disabled.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index cb72af9b61ce..a31648d2adb1 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2933,6 +2933,8 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 	}
 }
 
+static DEFINE_PER_CPU(struct x86_perf_regs, x86_pebs_regs);
+
 static __always_inline void
 __intel_pmu_pebs_events(struct perf_event *event,
 			struct pt_regs *iregs,
@@ -2942,8 +2944,8 @@ __intel_pmu_pebs_events(struct perf_event *event,
 			setup_fn setup_sample)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct x86_perf_regs perf_regs;
-	struct pt_regs *regs = &perf_regs.regs;
+	struct x86_perf_regs *perf_regs = this_cpu_ptr(&x86_pebs_regs);
+	struct pt_regs *regs = &perf_regs->regs;
 	void *at = get_next_pebs_record_by_bit(base, top, bit);
 	int cnt = count;
 
@@ -3191,8 +3193,8 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
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
@@ -3242,8 +3244,8 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
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

