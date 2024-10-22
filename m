Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7819ABBD;
	Tue, 22 Oct 2024 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602188; cv=none; b=O0GvlxCUdHvu5no7QPYv+BRBocB+NUotvdeERQgEjd7FTutQEmv5uV2L8ktbj2rxTlczFdt0ZSPWI1FS/JDld7Me5TxNv1iaZAd1gNEJFyivMuLAsMIF15wXIQ0Xj0fms7rxx1yxUzG8Hn5NTYNJpBO+7gTS1a4lsHHwGdYwCHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602188; c=relaxed/simple;
	bh=TjKlg22W28xE7/B9Ew7UzmE7XquWslpHMP0GirJkxvE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qBCk2n3UrJ9lQA994KeOBgMPWMA6BW47DikUI3cYpO+8GbfnytW0V9C2CkxnDZlPps7BNKJjpMnIaC+oqNgX30gYtj8Izj8PDKMsrQmDKgFP6M5/4ckLL1NzuoF6+iuhe2QAYYEe3yHzC9EKB1SredP29P11vrqeeoHyDCdjXUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QlNivqPw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QlNivqPw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729602187; x=1761138187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TjKlg22W28xE7/B9Ew7UzmE7XquWslpHMP0GirJkxvE=;
  b=QlNivqPwXHX6a40p3asObBNBksWb72zY0hha/HFDmIQ/m3AwfP0jcz6t
   I0Xd0KJCRbFm0JhunaGYLyw2ugOilEoB1ckY6mE+vG12+hdj+MvpunPiY
   PE6rS5+YnVvsiPJmNs+UWFl5kLyFcxYb+MhpUjLEtVpWkkOW7V0jGblrM
   fL7QVrVuiddBITzw7LygLN8Bypuo/dX36zWBmYeGpyeO6A4NstOCTxnEZ
   VlvrlLXDHw3qFc8AWKjZZanWnseKsoEhhLzG7YQDiLXumN0OSn4QnhDI2
   1J0kClyaK9IvhlBuo11WXKcbFx3r4B9+eCT07TsGiPefN7TCx6nNlHj5C
   g==;
X-CSE-ConnectionGUID: u3RU2gTXR6KVyI7UCZsWBQ==
X-CSE-MsgGUID: FhvJ/VVjT6ebnMGKXBvdSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29340194"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="29340194"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 06:03:06 -0700
X-CSE-ConnectionGUID: KE0rJWUvSa2HCjEM8odeoA==
X-CSE-MsgGUID: wsdV1iyOTk2Dqk/Tgk8vGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="117299572"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa001.jf.intel.com with ESMTP; 22 Oct 2024 06:03:05 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	ak@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2] perf/x86/intel: New start period for the freq mode
Date: Tue, 22 Oct 2024 06:04:14 -0700
Message-Id: <20241022130414.2493923-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
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
---

Changes since V1:
- Move to Intel specific code

 arch/x86/events/intel/core.c | 85 ++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 812b1a1cdf47..d3b133384361 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4076,6 +4076,85 @@ static void intel_pmu_set_acr_dyn_mask(struct perf_event *event, int idx,
 		event->hw.dyn_mask &= mask;
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
@@ -4087,6 +4166,12 @@ static int intel_pmu_hw_config(struct perf_event *event)
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

