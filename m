Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249263;
	b=fe2vwAl46aFBzLcTJycA/FX7xCA45yRlEwMudGdBbf7eVk2j2atXahEVxNlgl2h8bKTg
	 Ij7DvFTHZGmTR69l55o/hzz80xEEgbxinu2wkH/l4NYSogEzLo+oxlCLTwYUwc8fYO++I
	 LrmYVMeZrfw+csjQvRTyrUkIHVZGsbXy3VfXYLibDHspK3GOm1Y8QNBjRw/oRSAwq5PxN
	 kb+4A0C14imoTlV/bS/6eP77t8Hnf6uCoCGfZAdne5aNVVRnjfeCNFXp4oQFtcvx9X+G4
	 qmKy/itDkhwbcp2bgT/pDbJwrFeU31KzuEvH70WzhbdpTQvCrE6h4hnKP7dHtz3J6RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249263;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sWzEv2m1SSsQZyTctY0G7ZWFAeOEfQQi/CIMu0kBQE4=;
	b=rN3TABzUJgTxUESrj4GX0VlT/ZP+uiBxIG04sRLjB2jBZdKIb49qXrWy0TRo7o/YSAqu
	 eBCRxK9WWdoPAOCJU05zuj3N76tSmXqGz/9rh6CMtTvHx+lNdK1SCPv73vK2kvz+maBLD
	 RxSH+Hm2H10ZWhg1QdjvtnUkIJuDA6JF1TTosmcD4QXu3q3QCo2oNK4R7/jxV0gD2/pQH
	 ivY2MElra6HG4/h/8gOTDnM/0EDL6tZIefu4beGoYH5+J069+Kcu8Ise9qvAkEl6su2jG
	 HLxe58Vpo8ZZIBXo1/ZipA91PDeh6HVCVh9DiZfj5X4bdKyh0rG3zkNAx3+efiDXYfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KHEHPiXI;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC8606A338;
	Thu, 29 Oct 2026 04:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45EC8606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KHEHPiXI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249264; x=1824785264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HwtEmnBHEIQ9AIPqx4xWEQq+67PHWYFmojqaSJudeMQ=;
  b=KHEHPiXIvT1S52fWDb00OyE9/9JGZbbZ5vzAEWCJy6MUHMKqfevWIFwB
   t0umgmVL7ez/d+I8Y/HxCYbPiRFBYOrXqadUYBo+2toqMO46lGn2SixSH
   WBQUwtu+384D54PanDvVmZTAD1v4KLtD3bLzqKTb2izg528zT72Bt+dIN
   DxHNlWi6XomkIdGa5HR7Fs8f3KEvPCYZqaqSGTOzN2KCv0WW8Nr+I1jop
   4oyhAcdpkVGvHXQqmZtJAtAGZLb5UAL6W7iUVez7AeL/O5V0mEQmudwWj
   qoCivzb4W49zo1lgNQ7AdYX26uMzheGphJ2PtMmombxmVMLWu0nxuByR3
   w==;
X-CSE-ConnectionGUID: PZy8Lv4qQNqBzMxy23PaRQ==
X-CSE-MsgGUID: H/bsq6wcQqyMgzqg0vWYLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986320"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986320"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:47:43 -0700
X-CSE-ConnectionGUID: F5w/D/n6SU6DKxsadhkptg==
X-CSE-MsgGUID: QzwR898hSgeURXkcxO+1ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420546"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:47:39 -0700
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
Subject: [Patch v5 13/18] perf/x86/intel: Refresh LBR stack for non-PEBS LBR events if needed
Date: Thu, 29 Oct 2026 12:39:09 +0800
Message-Id: <20261029043914.1395147-14-dapeng1.mi@linux.intel.com>
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

PEBS and non-PEBS events currently share the same LBR stack,
cpuc->lbr_stack. In the PMI handler, the non-PEBS path refreshes the
LBR state before the PEBS buffer is drained.

When PEBS and non-PEBS LBR events overflow in the same PMI, draining the
PEBS buffer can overwrite the shared LBR stack with the PEBS snapshot.
This leaves stale LBR data from the PEBS record in place, and userspace
may observe the wrong branch stack instead of the live LBR state at PMI
entry.

Add a lbr_need_update flag to indicate when the LBR state must be
refreshed. If PEBS events and non-PEBS LBR events overflow in the same
PMI, set this flag so the non-PEBS LBR event refreshes the live LBR
state. Since the LBR state is frozen for the duration of PMI handling, it
only needs to be read once even when multiple non-PEBS LBR events
overflow in the same PMI.

Fixes: c22497f5838c ("perf/x86/intel: Support adaptive PEBS v4")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 110fff65bd50..37f304a1b48c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3863,8 +3863,9 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 {
 	struct perf_sample_data data;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	int bit;
+	bool lbr_need_update = false;
 	int handled = 0;
+	int bit;
 
 	inc_perf_irq_stat();
 
@@ -3929,6 +3930,8 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
 		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
 			status &= ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
+
+		lbr_need_update = true;
 	}
 
 	/*
@@ -3944,6 +3947,8 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
 		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
 			status &= ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
+
+		lbr_need_update = true;
 	}
 
 	/*
@@ -4002,8 +4007,14 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		 *
 		 * The PEBS buffer has to be drained before handling the A-PMI
 		 */
-		if (is_pebs_counter_event_group(event))
+		if (is_pebs_counter_event_group(event)) {
 			static_call(x86_pmu_drain_pebs)(regs, &data);
+			/*
+			 * Draining the PEBS buffer can overwrite the shared
+			 * LBR stack, so mark lbr_need_update as true.
+			 */
+			lbr_need_update = true;
+		}
 
 		last_period = event->hw.last_period;
 
@@ -4012,8 +4023,14 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		perf_sample_data_init(&data, 0, last_period);
 
-		if (has_branch_stack(event))
+		if (has_branch_stack(event)) {
+			if (lbr_need_update) {
+				intel_pmu_lbr_read(&cpuc->lbr_stack,
+					cpuc->lbr_entries, cpuc->lbr_counters);
+				lbr_need_update = false;
+			}
 			intel_pmu_lbr_save_brstack(&data, cpuc, event);
+		}
 
 		x86_pmu_clear_perf_regs(regs);
 		x86_pmu_update_perf_regs(event, &data, regs, false);
-- 
2.34.1

