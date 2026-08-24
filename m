Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BEE3B388C;
	Mon, 24 Aug 2026 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560469; cv=none; b=LgXwJM+DylVVYwOKhAZ9ATLFTCpniNVuzs2s5yb0ifCN+CWOOc21RsoZVu0uA413VaVuayyNEVyGtuhKitF/v5fYD6yD85cieTfTy5L39Kj3ihbeeMR0SggJfeAlZtw1b6GI5CQq70VeR/aaYKV51bk4rQApcwyb8aJ/JDOGYfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560469; c=relaxed/simple;
	bh=tuyZjr5EP9qPUsB7n6tM7ofzWD5aQAftAphuW4Lj9u8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ofrr3PzxhkBRIrWzRb3rACBVqFjHYqZKSDGk/k6/EiLEAYD5PCD5Q3Gd3Or1ureWswei59s6boO+ZG32j+Si6AdfuTcYuwVM2C3toQNRugJIFQzUvEyBSZPLvv1oSZxUtc7Fozn++xkB5byUXUSH6hdi0gxkyqqRaYBuBw3MaUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMiI+Ht4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMiI+Ht4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560467; x=1819096467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tuyZjr5EP9qPUsB7n6tM7ofzWD5aQAftAphuW4Lj9u8=;
  b=JMiI+Ht4oOxBd4/1+4yKyU3ArYQZDxtyUiVBtOj9aQ6Q/EoSXu7qKmKa
   7kdcziZUOw+IXXmakixn07kEKC3pOkYmswwZ7B1OU/L/2xvtQ9t1oc5qa
   +TwvpkZ2uDuS/xCati8+5dRuvbE2BoSyi6L/zd7dmOF9DJ20DW2CvIovC
   iB2q0yvTdm4f8NBOEessPCTTVluCV+KaHqwWY57oeOdH9S7oXzpapKEjq
   4Uq56XMXB7C8/xuzjthrPBRSahE4IWJIXYPDu7Z6tessA6GdTv0UdkXx+
   MnwX/5SN0kRsWWUpfTdf9rc/SfoOpRrt/Y2mFQ6eUxcJRo12b967Nx5zO
   Q==;
X-CSE-ConnectionGUID: 8lraWYp0TPCuXahBa/0nTQ==
X-CSE-MsgGUID: Eeyg3U8mSROh14XRKIFcZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98598688"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98598688"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:34:26 -0700
X-CSE-ConnectionGUID: z3hnSiQETp2emFMkHtn+QA==
X-CSE-MsgGUID: wcWFkFiRQwijtZNid/mPrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264325939"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 24 Aug 2026 01:34:21 -0700
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
Subject: [RESEND Patch v10 03/23] perf/x86/intel: Convert x86_perf_regs to per-cpu variables
Date: Mon, 24 Aug 2026 16:27:11 +0800
Message-Id: <20260824082731.1013973-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
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

