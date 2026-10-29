Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249234;
	b=AE8D+oEH+s+VHTKqyWke0J9Kx2UC1/dnqiqa+GEhQfEtuTFeYB/U4ecpc6aSrvtqprog
	 HiSVeP1uY6WURf1zeTdXshNzi2O6oApSti1BZ3TjCzAPMHzpoiJS+xomMVyqD2jSwJ0dQ
	 0X3mX64Z+UE5XazY8CQ34LpjAM2DgmsBRCcjTdYRlNXGHLq6QWUU4w48pTn8WrRThFZe+
	 fIQRluR1fMr88+gvNzouZUayy83uLl01PQ9BusdHRkLZervqRPZYgQvHTyhIDDGNNhC3B
	 Dc8jZ9/NhVKF8JQgbgYQyeI7lnfSrpRLJ8J7LrDPO5yyY3Dpo1WFyxGBTp6V9Y9GUIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249234;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I9Um5hrlEU0nKbSIfVyOTyid7qphJ0n6FO97RQ2q44A=;
	b=0PARCf03EV8B9H4Tb2BJZ7+Pz1qNTtV2KsPf5Yh4ZT2smnaWD7cyCVyR4nZjDr4TaXKo
	 ytJYgWkHbTclNRYzZaPIucb9F8ycyG0OgJpe20Y2SFEUdoEN0iGLh59OQBTCLrFiAyntN
	 B8gaI/yyCZ8DogHcKLvL0DMJWVkPeJWxcbu2ZgnAgXMbsui8Ie8CFcGR+Epin6Bso3PAc
	 Lu+JylRbw4ZSVWM8UEOByMNWGo+U+4ZLnBUM14OAaSQMHNNsahoPeW/mzRmqqSAf4bWB+
	 llJ9n3cphg4BXYL3UYTrG1eYlAY69coOLraQ/Jev+ATyllLfRwjSSAI7aOG60+BlJSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Oa6FyYFk;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125DF606A32C;
	Thu, 29 Oct 2026 04:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 125DF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Oa6FyYFk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249234; x=1824785234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lyEYLEdojvqtUCgHysKXdFDzc9phIxzUgfrVSKmU+Hs=;
  b=Oa6FyYFkCn3q3N39ZYFYNQwtMF9bg52wigajEYa7z4DhgkNFdfFweNSq
   MGR5IAaIrxUdS4myFSbafPHb9oHAvYxXuaIde69MD0bjK30CrCW7KEPFn
   c6R1sxhFN+jV7LMTAR4FWes2yKLj69KqzFYDI5SrUZP6l0cMAzjXYdVzg
   pUdD7rrZOQbHOBcUp9tzevpRwzoCCJp9oCxy/S7ddQhwAFkizRjVejCQT
   hPhNbPNwyIGmOG4/Zch85kCHNCct0VxrqjjJky92MtGLsWtmvPhpHhaDY
   UYMojCy81VRmNzQcCqIOfQU09w71GwJWfkNyS/3Mg43FqG2FMIW1rL/PI
   Q==;
X-CSE-ConnectionGUID: NMZJv8UoSUafg3g/tFDqYw==
X-CSE-MsgGUID: rg036iWGQPa5+NK1cKSVCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986281"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986281"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:47:14 -0700
X-CSE-ConnectionGUID: 5I/ynOs1SiqDpH01p0TE5w==
X-CSE-MsgGUID: 0IrghzrtQzG+x6UqiS7hHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420427"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:47:10 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v5 07/18] perf/x86/intel: Add helper to enable PMU without LBR
Date: Thu, 29 Oct 2026 12:39:03 +0800
Message-Id: <20261029043914.1395147-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, __intel_pmu_enable_all() also re-enables LBR in addition to
the PMU. Split out the PMU-only path into a new helper,
___intel_pmu_enable_all(), so the PMU can be enabled independently. This
helper will be used by a subsequent patch.

Also remove the unused added argument from __intel_pmu_enable_all().

No functional change intended.

Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0ed0269189ba..5b44a4224d2c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2783,13 +2783,11 @@ static __always_inline void intel_pmu_disable_all(void)
 	intel_pmu_lbr_disable_all();
 }
 
-static void __intel_pmu_enable_all(int added, bool pmi)
+static void ___intel_pmu_enable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
 
-	intel_pmu_lbr_enable_all(pmi);
-
 	if (cpuc->fixed_ctrl_val != cpuc->active_fixed_ctrl_val) {
 		wrmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cpuc->fixed_ctrl_val);
 		cpuc->active_fixed_ctrl_val = cpuc->fixed_ctrl_val;
@@ -2809,10 +2807,16 @@ static void __intel_pmu_enable_all(int added, bool pmi)
 	}
 }
 
+static void __intel_pmu_enable_all(bool pmi)
+{
+	intel_pmu_lbr_enable_all(pmi);
+	___intel_pmu_enable_all();
+}
+
 static void intel_pmu_enable_all(int added)
 {
 	static_call_cond(x86_pmu_pebs_enable_all)();
-	__intel_pmu_enable_all(added, false);
+	__intel_pmu_enable_all(false);
 }
 
 static noinline int
@@ -4056,7 +4060,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
 	cpuc->enabled = pmu_enabled;
 	if (pmu_enabled)
-		__intel_pmu_enable_all(0, true);
+		__intel_pmu_enable_all(true);
 	intel_bts_enable_local();
 
 	/*
-- 
2.34.1

