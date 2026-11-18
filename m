Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972217;
	b=Zs4RP7Azp/kvVByTZnEiVlEFqhKXVTWDznBTc/yErQjbNnLABNxMNtlCm+1YJS2II9fI
	 etLDr7K9eKJf17Y0QWz3ibG2HbCJ5aZv5VfptS7ki98UPZGE6EhgkaEm1C3XqylUHj+lB
	 HCq+q6FGG3QaCNAh3UMh0GcR739wsAn/mtzLU1HS7DR1mzGemmDeHF22DaiDGPnPsrKjn
	 /ehNg0/iy3Wg+/lpQ6zPWYWuvSd+9VvtvNbMITuWcDVRUzD/TzncYYgPhLA/NmIpz3S98
	 Bo8KO/Q/0Y5C5uxR2Hen0mKla9VPpD3r52m9OHaXpzM7HcFJ3LB6j2B+IOhCFBTx49w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972217;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W5yrQWldGxnXUcuCwTU+ccQpkDyoZDHUUQoWYJNDKqU=;
	b=MiZ2wmo1WBR8Hc3cK4D2cURCUdwsSJk4uCkxw12TUNkthQjIzNQT9xfuCn5CYaKjHkSK
	 xUOCgQXQ1W1saG7jDg1PLwli+O7JXxDj1BApndOw11sUBOvYTim8LBGLm8KdPU3DZW8aX
	 N8BMJvIpL9wK2kbN7FdiwE1B5GLjfHKhWuqXHeQGLDxHSd1TF3O863MtCxQLsNCj+dkeQ
	 iUuDq0OTjqRFlBoq83F8V40xnAWVh8PhL7H65afDyFlJJ6C+6fZ2+/G8ga6P7Y6BwKZ4C
	 mvc8hk9HnsRCCNkiJr3eWVsGi5Gq9U+ku/ru5yUOJ/cxqNH/tRcc+WCjTxZkRWkYKSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gQnElZ1E;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674E1606A897;
	Wed, 18 Nov 2026 03:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 674E1606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gQnElZ1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972218; x=1826508218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8C2q+EWh9Y5yRRX8rSuaA9Fyi0ljaB+AJBgzbonQCDY=;
  b=gQnElZ1EPHc1idd/4+bFGyrqNgR4uMQ9guZGK0h8yxOl2An+dI1jYV9f
   JWm1CJVD6bFR1Z0YsAFE6agIgopicXDLDCgrof7W4lxxPinh83nm/eew6
   ByGKAWahhxr16g26S0ki4p1Aw9284PegEOJHwyrg/N1Wqrs8uijInHXYd
   TVZzk9oC8FhjwsCLorzsWtkLKD0kfQ5vm3hOKkjKSHGiPZJPwr5WracPd
   hr5uQjtpCMvrf/CgeZx+iXIcrUJcItyyrAOkumGIVJoLTCduGVDbTkaXN
   8kkwv1V4LbfRwqqMI7WwNqU7ymFp9VH62GKTA5k3TTi3h5JFPMa2YRQ2z
   Q==;
X-CSE-ConnectionGUID: zuspKptRSsK8ubF6Jag8Fw==
X-CSE-MsgGUID: P7YWSOzYSOa3fgtMG70/pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629896"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629896"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:23:27 -0800
X-CSE-ConnectionGUID: RyVi+VGnTHe1Kc5aZFVBGA==
X-CSE-MsgGUID: J5QWxXikRHiAy5K7noNpDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894213"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:23:22 -0800
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [Patch v7 08/24] perf/x86/intel: Avoid re-enabling PMU and LBR for BPF when disabled
Date: Wed, 18 Nov 2026 11:14:37 +0800
Message-Id: <20261118031453.1353625-9-dapeng1.mi@linux.intel.com>
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

__intel_pmu_snapshot_branch_stack() currently re-enables the PMU and LBR
unconditionally even when they were already disabled in PMI context.
This can cause events such as cycles and instructions to be counted
while the PMI handler is running, which is not intended.

Only restore the PMU and LBR on the BPF path if they were originally
enabled.

Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 39 ++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1a33963c5ee2..b8b4e5d8a0e2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2821,7 +2821,8 @@ static void intel_pmu_enable_all(int added)
 
 static noinline int
 __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
-				  unsigned int cnt, unsigned long flags)
+				  unsigned int cnt, unsigned long flags,
+				  int pmu_enabled, int lbr_enabled)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
@@ -2829,7 +2830,21 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
 
 	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
-	intel_pmu_enable_all(0);
+
+	/*
+	 * This path may be entered from the PMI handler through
+	 * bpf_overflow_handler(), so only re-enable what was enabled
+	 * on entry. On PMU version < 4 the LBR freeze disables LBR,
+	 * so it must stay disabled. On version 4 and later, LBR is
+	 * only frozen and can be re-enabled.
+	 */
+	if (pmu_enabled) {
+		cpuc->enabled = 1;
+		___intel_pmu_enable_all();
+	}
+	if (lbr_enabled)
+		intel_pmu_lbr_enable_all(false);
+
 	local_irq_restore(flags);
 	return cnt;
 }
@@ -2837,27 +2852,43 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 static int
 intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
 {
+	struct cpu_hw_events *cpuc;
 	unsigned long flags;
+	int pmu_enabled;
+	int lbr_enabled;
 
 	/* must not have branches... */
 	local_irq_save(flags);
+	cpuc = this_cpu_ptr(&cpu_hw_events);
+	pmu_enabled = cpuc->enabled;
+	lbr_enabled = cpuc->lbr_enabled;
+	cpuc->enabled = 0;
 	__intel_pmu_disable_all(false); /* we don't care about BTS */
 	__intel_pmu_lbr_disable();
 	/*            ... until here */
-	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
+	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags,
+						 pmu_enabled, lbr_enabled);
 }
 
 static int
 intel_pmu_snapshot_arch_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
 {
+	struct cpu_hw_events *cpuc;
 	unsigned long flags;
+	int pmu_enabled;
+	int lbr_enabled;
 
 	/* must not have branches... */
 	local_irq_save(flags);
+	cpuc = this_cpu_ptr(&cpu_hw_events);
+	pmu_enabled = cpuc->enabled;
+	lbr_enabled = cpuc->lbr_enabled;
+	cpuc->enabled = 0;
 	__intel_pmu_disable_all(false); /* we don't care about BTS */
 	__intel_pmu_arch_lbr_disable();
 	/*            ... until here */
-	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
+	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags,
+						 pmu_enabled, lbr_enabled);
 }
 
 /*
-- 
2.34.1

