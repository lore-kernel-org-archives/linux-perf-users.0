Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972217;
	b=V8sSz/2/ghjju/j02rOV36ylJwStzVljvOFXUs1KrQSz/3mjLfGdIaVKslPvNJFv0n7Q
	 RaagV5xRskjQhi9VVI9PW8B972IWDQT3cevd5Pps+2A98RHwxmW2LM/JPZgIip4h+AEez
	 ptK029elTzTyWiiZyFbY6CmkSN7hJrm/gdTkHZmpWSWJXUW7Fe3P2EG7xcOGe6JouQFv7
	 oEFQtQUq/NZ6qI8MBl0lARdEvSQ4X9wwNKg/r8Sye96I0CUP+H2hsBL1/Wsh4CItoP73O
	 XsqcWlxzSTrnJFt64+1S4gmqCWBrS1MaTM1xav7ieBS0uJUs2tPhXl3501PWt04ouGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972217;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X/nP+jAOB/0ThUxGcgYYBi4iMGF2nplZY8xCrH1I5Cs=;
	b=u77uaexGsMHBXSd8mXSIbXbByYeWbt/96FGMtmrMxuEHCed9titbnYu3pnViCIlpGn/G
	 Hz/EX3xRJrlhcqiJWOFAonC6ffSU1z+uIc6tMnqxhW3983uU6pt6uqyRzM03IKYBHIzd+
	 9GdVjx6OVyB6mXn93bbjrwH6eDv/oIokfI954aN0lwraP4+p1R1GGY0Ryw39tqIT9xHG0
	 NvS/0FZhNM5o68hx+EFMSTsUTrtpdHtNCLYI+u7Ag17Q3fM24t/FBPr2JYegwCa58t+me
	 sIZ9Wc3LBKuH7dLk7vUBVNEAcAoZKiZjm5fkhDx6Wlkk5clbMqnajFg9R/RRkbZFDUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="NjQu/GFS";
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F45606A331;
	Wed, 18 Nov 2026 03:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95F45606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NjQu/GFS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972217; x=1826508217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FVdSpiP5vdlrTE1wl3qve/+/uKzaKTZR9IEa134iyXY=;
  b=NjQu/GFSE3PTt00FSgWpxwznhIew+E+yK8m6GUG24dfrwEniGNWB+szX
   IHOIOJxg1M4UfSruMjrQg3CR3Hp7/ytiLKF8YavdD1KYF0b6IEfb31TDw
   s/YnS0yJvB8KHkw2KHWH2S7KyW+1ZoQbIU5nLqYFQLp6WuNzS8eSNbvWN
   EhlhMbe6xAYQHKnC67vkdwuqNykV+NyBUerHZg1SmmE18qSMgl8umhMLs
   gxJTS4xVGoQ0LR2MJWl06+/XWXezHdmvWpYL3WK9V+qksNV5KKzUFMZyX
   o13sshnWYIA+oO3zhM0NuGkTb7QYwi8RwEpKZebCicbM/CP9jooDsreqw
   A==;
X-CSE-ConnectionGUID: +cgo+ZE1TSuJpOb2laVTQA==
X-CSE-MsgGUID: yOb4H47VTwa0114KDnx1Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629884"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629884"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:23:22 -0800
X-CSE-ConnectionGUID: PZG1YOaVSgujesZmw5BNyA==
X-CSE-MsgGUID: LEyrqMTuRNatMOuCHX1/dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894196"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:23:18 -0800
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
Subject: [Patch v7 07/24] perf/x86/intel: Add helper to enable PMU without LBR
Date: Wed, 18 Nov 2026 11:14:36 +0800
Message-Id: <20261118031453.1353625-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
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
allows the branch snapshot path to re-enable the PMU without touching LBR.

Also remove the unused added argument from __intel_pmu_enable_all().

No functional change intended.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8ca7dc8c60db..1a33963c5ee2 100644
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

