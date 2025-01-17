Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6641802DD;
	Fri, 17 Jan 2025 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127135; cv=none; b=dshIt7A0oXu92BuzY6/5CDdQG+ACif7zVT18RRXqpOMY8XpQroV6SNdPbJ/mFFnTGF0wqyhASvAElQa78mGqyyG2cjhjI4m9ppbnZ6JhwKvQvBBFk+hcfZgFv4vwt1MNi6HkKvsqbr+BcaB7ciz2AYehqJZBthxKa/tH4tzE+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127135; c=relaxed/simple;
	bh=CApLjbPh7RKgD3EsARTTdv5c/JBYHRjsf8/q/GL6P5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sEhoTSNvmbM0DJ09V4K3zofPbbbtdgdwQb1nHBU0U1/hXmabIFpR2GFSsSA3QtOZcmGkRS5RtzhlvBYkBryI5DFlCPksN4f+OK0btfixkfm3JyMKN85x8mE4TeBcDR8erXdznPElpp+wki7ZIzHqrWuGIhyxnnhRThSedIVrl7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0SgeBDn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0SgeBDn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737127134; x=1768663134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CApLjbPh7RKgD3EsARTTdv5c/JBYHRjsf8/q/GL6P5g=;
  b=d0SgeBDnZH6EXubK/mtMW81fwUzYN6A3dxBry2rtpWimhM7/wH5O+4wi
   7FVFRmk4uuZ3APYlFAWIVjNfi6XWXPD3aLaL7rliJKtv+3b762LqHYJ5I
   0kWloYWRD39nqNSFO36es5lEEh68r4PcemTwpRvblkujZ5bejom8XImTR
   1RQNtAr5CeL6eawukiC/8i6xgOQ8yVrlKN79B/5BaY/6j6wsazxkxHly9
   rPfgPwjRiSwdNDtoqbtjyWjWd/ueUIYJ48Xbnz84jkjiIJyhkKNPzs74l
   MvJXELDvAtSOqYi2WcqGqXY6qbp8Z4nw1z+pv6mUmvv8w19Stgs/M0A5/
   g==;
X-CSE-ConnectionGUID: 11pFOOAwQue1JJEqvrDyDQ==
X-CSE-MsgGUID: E0whK8HaSSKfPHByrVwHBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37798358"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="37798358"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 07:18:51 -0800
X-CSE-ConnectionGUID: yNjtD3W+QM+k9CnxeKFKzw==
X-CSE-MsgGUID: gtoQ9oXGT/SY/gfxdtKJtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106292024"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa007.jf.intel.com with ESMTP; 17 Jan 2025 07:18:51 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: ak@linux.intel.com,
	ravi.bangoria@amd.com,
	jolsa@redhat.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH 3/3] perf/x86/intel: New start period for the freq mode
Date: Fri, 17 Jan 2025 07:19:13 -0800
Message-Id: <20250117151913.3043942-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250117151913.3043942-1-kan.liang@linux.intel.com>
References: <20250117151913.3043942-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The freq mode is the current default mode of Linux perf. 1 period is
used as a start period. The period is auto-adjusted in each tick or an
overflow to meet the frequency target.

The start period 1 is too low and may trigger some issues.
- Many HWs do not support period 1 well.
  https://lore.kernel.org/lkml/875xs2oh69.ffs@tglx/
- For an event that occurs frequently, period 1 is too far away from the
  real period. Lots of the samples are generated at the beginning.
  The distribution of samples may not be even.
- A low start period for the frequently occurring event also challenges
  virtualization, which has a longer path to handle a PMI.

The limit_period only checks the minimum acceptable value for HW.
It cannot be used to set the start period. Because, some events may
need a very low period. The limit_period cannot be set too high. It
doesn't help with the events that occur frequently.

It's hard to find a universal start period for all events. The idea is
only to give an estimate for the popular HW and HW cache events. For the
rest of the events, start from the lowest possible recommended value.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
---

The patch was sent last year, but not merged.
https://lore.kernel.org/lkml/20241022130414.2493923-1-kan.liang@linux.intel.com/

Since it's also related to the period of freq mode, resend it here.

 arch/x86/events/intel/core.c | 85 ++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7f1b6b90a5fb..e36f8e737f6b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3991,6 +3991,85 @@ static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
 	return test_bit(idx, (unsigned long *)&intel_cap->capabilities);
 }
 
+static u64 intel_pmu_freq_start_period(struct perf_event *event)
+{
+	int type = event->attr.type;
+	u64 config, factor;
+	s64 start;
+
+	/*
+	 * The 127 is the lowest possible recommended SAV (sample after value)
+	 * for a 4000 freq (default freq), according to the event list JSON file.
+	 * Also, assume the workload is idle 50% time.
+	 */
+	factor = 64 * 4000;
+	if (type != PERF_TYPE_HARDWARE && type != PERF_TYPE_HW_CACHE)
+		goto end;
+
+	/*
+	 * The estimation of the start period in the freq mode is
+	 * based on the below assumption.
+	 *
+	 * For a cycles or an instructions event, 1GHZ of the
+	 * underlying platform, 1 IPC. The workload is idle 50% time.
+	 * The start period = 1,000,000,000 * 1 / freq / 2.
+	 *		    = 500,000,000 / freq
+	 *
+	 * Usually, the branch-related events occur less than the
+	 * instructions event. According to the Intel event list JSON
+	 * file, the SAV (sample after value) of a branch-related event
+	 * is usually 1/4 of an instruction event.
+	 * The start period of branch-related events = 125,000,000 / freq.
+	 *
+	 * The cache-related events occurs even less. The SAV is usually
+	 * 1/20 of an instruction event.
+	 * The start period of cache-related events = 25,000,000 / freq.
+	 */
+	config = event->attr.config & PERF_HW_EVENT_MASK;
+	if (type == PERF_TYPE_HARDWARE) {
+		switch (config) {
+		case PERF_COUNT_HW_CPU_CYCLES:
+		case PERF_COUNT_HW_INSTRUCTIONS:
+		case PERF_COUNT_HW_BUS_CYCLES:
+		case PERF_COUNT_HW_STALLED_CYCLES_FRONTEND:
+		case PERF_COUNT_HW_STALLED_CYCLES_BACKEND:
+		case PERF_COUNT_HW_REF_CPU_CYCLES:
+			factor = 500000000;
+			break;
+		case PERF_COUNT_HW_BRANCH_INSTRUCTIONS:
+		case PERF_COUNT_HW_BRANCH_MISSES:
+			factor = 125000000;
+			break;
+		case PERF_COUNT_HW_CACHE_REFERENCES:
+		case PERF_COUNT_HW_CACHE_MISSES:
+			factor = 25000000;
+			break;
+		default:
+			goto end;
+		}
+	}
+
+	if (type == PERF_TYPE_HW_CACHE)
+		factor = 25000000;
+end:
+	/*
+	 * Usually, a prime or a number with less factors (close to prime)
+	 * is chosen as an SAV, which makes it less likely that the sampling
+	 * period synchronizes with some periodic event in the workload.
+	 * Minus 1 to make it at least avoiding values near power of twos
+	 * for the default freq.
+	 */
+	start = DIV_ROUND_UP_ULL(factor, event->attr.sample_freq) - 1;
+
+	if (start > x86_pmu.max_period)
+		start = x86_pmu.max_period;
+
+	if (x86_pmu.limit_period)
+		x86_pmu.limit_period(event, &start);
+
+	return start;
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -4002,6 +4081,12 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	if (ret)
 		return ret;
 
+	if (event->attr.freq && event->attr.sample_freq) {
+		event->hw.sample_period = intel_pmu_freq_start_period(event);
+		event->hw.last_period = event->hw.sample_period;
+		local64_set(&event->hw.period_left, event->hw.sample_period);
+	}
+
 	if (event->attr.precise_ip) {
 		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_FIXED_VLBR_EVENT)
 			return -EINVAL;
-- 
2.38.1

