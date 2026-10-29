Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249239;
	b=AcokzzOd4pPN4DsOOfx8X1Nw035LAYtZh+GzOvZ3kLEwJDWdVqG0+Vbm4/p+kdtRYDHc
	 qhBJ4sea1+WE2jCHJqo3jVzISqeHc1IHqFi/zj2gRHDzNvgueHXjSn2RNETCnKPwlQVuD
	 LwdXclTRvZLtScG18k4nQnEhJuz2BlZp8P3y+AHs8u38y6rUYDxmsLSRNXg3oytGAb6B6
	 Izio0qleTY2fOiE9hNMEAo2anPzaQCtWx2ZVqP5hZtWyo5AhvMZqH9ecNDc+iojhroN4A
	 n4Xcny5cybtmbTuheyFv8ZTOvj7IGBpJU7E/MR85AfDDHzRzu3o689K0wz5124xvxmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249239;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ICa+So7EFdlOSl1nPVt1NWARBazxkJ1wNWOi7qtx420=;
	b=mgfNF9IPYrons5mC4wuKHW52eBQ/ADfdHGTHMJqsE8omffkQgGuUbqRQlkEHm79GfqKB
	 lmO2KtDg00SFW67WsHwM7I2aeUuQdZ/lIsdBSzaoPbQSTrWs9LwKgGEXWVxca//ojibVa
	 AM6HuyJQw16JLuQYEchmz+H1f28ZudcqKq+n+TMnS4CFHNQLxhtS8YAKVetW3T1RTEtl2
	 FrA8sM1eExoytB6LN5OiGplQUqou1S1QEp/PQ6f6N5zFUse6i7tM5XvOuEAH6uMJUQah9
	 rDnXP68TfNlrELKUD5TJzNTR9O6LyRXHvxpWXkMox1Clbtwbu22FLH9fzr7AFhvXstw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oEMxfgSd;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0DC606A329;
	Thu, 29 Oct 2026 04:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F0DC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oEMxfgSd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249239; x=1824785239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YUBCZFsbXC2t+Mo09FbsE1x88jsHe2m9E2Qf495fQ8k=;
  b=oEMxfgSdgO0PZZd1Majwwph62WNjhBlAjZJb0VOwwuk11yO4RELMupDP
   LzlH2yjCyAVUEEDMR7uMJTUrejGuQkthYj6NnVyfshXcseAkjXMR8idwf
   Bbl80q0th7px/jHDRt7oKnCiy4Vr1rCje1WxQ5juvI6Il13ZVNcYPN3KM
   +1vYXigucedtI3W/D/7tb0H8VpNP+CqHX7NMjmcC4kp5n57nf0egvV/fZ
   YiDkgvdopJz8QCLtoBS7OXp/n2UKFMIhHNlW4P7h7bnfwzhj7oGNqZt2q
   cbH+Oz8GUn5aY40q2S7CpQABHAgQ7bzSEnv8PwbsRlZGNhbZFk/5KDnmT
   A==;
X-CSE-ConnectionGUID: y3iUiVo3R06YSF+iRTcK2A==
X-CSE-MsgGUID: TdBlh1qGQGWEGTg2hwy37Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986289"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986289"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:47:19 -0700
X-CSE-ConnectionGUID: 3lvkOa6yTWiRctnBtc0dDg==
X-CSE-MsgGUID: I8I7W5VNTjq5lfUxqnbGDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420454"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:47:14 -0700
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
Subject: [Patch v5 08/18] perf/x86/intel: Avoid re-enabling PMU and LBR for BPF when disabled
Date: Thu, 29 Oct 2026 12:39:04 +0800
Message-Id: <20261029043914.1395147-9-dapeng1.mi@linux.intel.com>
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

__intel_pmu_snapshot_branch_stack() currently re-enables the PMU and LBR
unconditionally even when they were already disabled in PMI context.
This can cause events such as cycles and instructions to be counted
while the PMI handler is running, which is not intended.

Only restore the PMU and LBR on the BPF path if they were originally
enabled.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 38 ++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5b44a4224d2c..15dcf8b78de9 100644
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
 
@@ -2829,7 +2830,22 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
 
 	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
-	intel_pmu_enable_all(0);
+
+	/*
+	 * Do not blindly call intel_pmu_enable_all() to re-enable LBR.
+	 * This path may be entered from the PMI handler through
+	 * bpf_overflow_handler().
+	 *
+	 * If PMU version < 4, LBR is disabled by the LBR freeze mechanism,
+	 * LBR can't be re-enabled here.
+	 * If PMU version >= 4, LBR is only frozen instead of disabled,
+	 * LBR should be re-enabled here.
+	 */
+	if (lbr_enabled)
+		intel_pmu_lbr_enable_all(false);
+	if (pmu_enabled)
+		___intel_pmu_enable_all();
+
 	local_irq_restore(flags);
 	return cnt;
 }
@@ -2837,27 +2853,41 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
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

