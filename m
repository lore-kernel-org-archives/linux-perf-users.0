Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972268;
	b=Vx3z/V3bVOxaEtqe8GZuXfwIecv+NWg8x1vgPuGnJEMo6wM8NL/hhyxlVc34E/3AW45Y
	 mMGzWtAYFKfQrN6LOPGuboF4UVX/0eKEiZmJIqLaGHNDAU7WFnv6xhdrnmg5cI/fkKgy+
	 /GAma5zMBgSQP5ts04lB8okSoNQXo+eNN8UWbWb+oFTKTp8GGxNwTrT6mkVoHbVlmzQVi
	 EVqlUNdiyGkhddKVfxECvj5FnN0blb5ZKUF9LZAD0cMM2wTEAItB6TYz6e8qnLq61+J6S
	 mx2RxcfmW3jSOkax17JOMNyPjDs/s0p+VHx9dbL0VrXCYIvY8pvYjuuroe9uqkl6h/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972268;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EpHjCmtVuQPRi1F1S9LTAYhtf44z2tPz47nz4SFlWV0=;
	b=o3FyJIH4kuINAa5mU21KZTJS86CwpYBoiIJfV8lQ9jq0MzDG06lG94l2YUawKKdVZz70
	 neJ/3702fFBADU5g+9tO5WVfFXt1ywftZFBdRoG2PFgcN24i/aLvBrJren8FzsFD9pptT
	 0Dor976zn7EelRe7e9yskRUqSmgauLeQEx5RDlrbtf56OhVi3ABB4cxEn01BOmyH6ruSr
	 YTPRcDN5rrV5zNA3N/jCBRHSSx60pYTKpUfF3ttqVcbu85S20DCac8QjQykK40/FSQCni
	 yMo9YMJj6KhPmB5BlyVbS8A3y2379BceHGj0xiPOEdamRyEo2I2PgXwNOu7mGzJEPfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HvYO0NUU;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC83606A8A6;
	Wed, 18 Nov 2026 03:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DC83606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HvYO0NUU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972269; x=1826508269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DVC7kDm+4suO6uWI6KKVmTqXSE7QAnET6vKWju4nsY4=;
  b=HvYO0NUU5P49Kuubru9oEclEEK1Xay5n56ln8NmaPYa/tsHuJzxiPFYH
   BNQvBykD4VgEEQ6sPPxQMsO0UB8DZxCAop/NUQ7SezHogrifogpjhtVGg
   U3WWWku6kw3dqtq20ckLspsS50oB8zMUapT7RpXkVVH9rOgAGw4oJ8oiX
   33iI4bSUrP4SwfDARfSJZAAAeaPaRJSsLMK6ywCGlRu5l7JMBo4QurM7P
   0QMCT5f+FRM+4Y6kMGASOSYZXK1nZbGNrVE0U86Gh8YxiXcrs+YabyHcd
   IzJY/iDUz4y2KVGyCIALQ6G7VFNgcF97rT2/g2Zv5a9ofmXjlG7ppQGpY
   Q==;
X-CSE-ConnectionGUID: lV7mEl8cSBek4PBfbn/R8g==
X-CSE-MsgGUID: DGH5ApoEShCyEi6i3tNUMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3630038"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3630038"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:24:28 -0800
X-CSE-ConnectionGUID: 6lBZ6z7TSkWJAzoOef0YTQ==
X-CSE-MsgGUID: QV+ika2tSp2W3wXT1dTkOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894371"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:24:24 -0800
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
Subject: [Patch v7 21/24] perf/x86/intel: Refresh LBR stack for LBR counter events in PMI handler
Date: Wed, 18 Nov 2026 11:14:50 +0800
Message-Id: <20261118031453.1353625-22-dapeng1.mi@linux.intel.com>
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

When handling an LBR counter event, the raw LBR counters in the reserved
field of each LBR entry are cleared after the stack is processed and
reported to userspace. This prevents raw counter data from leaking.

However, if multiple events overflow in the same PMI, an LBR counter
event may not be the first one processed. In that case, the raw LBR
counters may already have been cleared by the previous LBR event, so the
later LBR counter event cannot read the correct values.

Refresh the LBR stack before processing an LBR counter event when
multiple events are handled in a single PMI. This restores the correct
raw LBR counter data for the event in this corner case.

This situation is rare, so the extra refresh should have negligible
performance impact.

Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fc672bc69ae3..b4632b791e26 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3906,8 +3906,9 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 {
 	struct perf_sample_data data;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	int bit;
+	bool lbr_counter_cleared = false;
 	int handled = 0;
+	int bit;
 
 	inc_perf_irq_stat();
 
@@ -4080,12 +4081,19 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		perf_sample_data_init(&data, 0, last_period);
 
 		if (has_branch_stack(event)) {
-			if (!cpuc->lbr_stack_live) {
+			/*
+			 * Re-read the LBR stack if it no longer holds the live state,
+			 * or if an earlier LBR event already cleared the raw counters
+			 * that this event needs.
+			 */
+			if (!cpuc->lbr_stack_live ||
+			    (lbr_counter_cleared && is_branch_counters_group(event))) {
 				intel_pmu_lbr_read(cpu_lbr_stack(cpuc),
 						   cpuc->lbr_counters);
 				cpuc->lbr_stack_live = true;
 			}
 			intel_pmu_lbr_save_brstack(&data, cpuc, event);
+			lbr_counter_cleared = true;
 		}
 
 		x86_pmu_clear_perf_regs(regs);
-- 
2.34.1

