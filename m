Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1850194C86;
	Tue, 15 Apr 2025 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701601; cv=none; b=TTJ0yBc4UieIDyzD4mFVkmQn97tM01a74zos1w5NtmeDxWdU7gqPbdl+4m5dj5c1c434gd7+TXX3u7+zaQtr9KHLTXpBBxY5S6KozFFnlrguISJR/XQJiGwffNGJI7u5XN7bO0lyY3f3GIYi2S6kMua+tbFbwx23vZ2DZq0KLI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701601; c=relaxed/simple;
	bh=i8gxxtkW7sSiLXUgfVn/GC4E1/A4IPlbovN0YKLEkTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sl0LnhpSn04c2Sf6YVYptDbOzMvcBjMIXuzGidT61uqOYQM8/0tXf7fPfjA0Vy+Se3o1gAgv3RPmnF8bcJNgV2JossPqOMD9K7n0/wXK9Or9XLXA7tddvYTEGg95RXeDkqfzFsKB9Fns/LK3G5UpAcCFupcqFIj4QV4O7ydqCvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WM5dOf+W; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WM5dOf+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744701600; x=1776237600;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i8gxxtkW7sSiLXUgfVn/GC4E1/A4IPlbovN0YKLEkTM=;
  b=WM5dOf+WSiTHxNo41PB8FvWFetf2Ku/qOUMABI17H6dx8nk5KLRSl3ZZ
   W3eb7Ur7Z+nk7jNvAiB8YqjTjSpV+gqp4iCPVDldE7q9f0NrVanBsGQPV
   JCNbU8rqd/MFAd5KndIHpoKBL1/8vGkCvI0V/2wU//JvSI5Fzp/n4f1U6
   fvWKHcV2aSusGz9gwCgp/OoEJZpFGAhKBV4SSFK736ZyA0DAUwIrLVHb+
   QdpLBGk9srRyqzRertCQzMBwDnm2u0uc7124PBENfm0vY9lEDtVmMPAMk
   cm329zh7rKnyXC5tfUEl3lq2cmwRyCiTBpilNKr/uNbxsI8CHKOxSgDD1
   Q==;
X-CSE-ConnectionGUID: FMgCGd/9RkWNSsDlF6hHwg==
X-CSE-MsgGUID: IiO8is30SAqr6pNy6EMkhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="33807578"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="33807578"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 00:19:57 -0700
X-CSE-ConnectionGUID: kGJbe0r4SbOuwF5PeH0Ymw==
X-CSE-MsgGUID: g9oZqP9bQtW+CFFycoLB3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="129885764"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa006.fm.intel.com with ESMTP; 15 Apr 2025 00:19:54 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 1/2] perf/x86/intel: Don't clear perf metrics overflow bit unconditionally
Date: Tue, 15 Apr 2025 10:41:34 +0000
Message-Id: <20250415104135.318169-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The below code would always unconditionally clear other status bits like
perf metrics overflow bit once PEBS buffer overflows.

        status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;

This is incorrect. Perf metrics overflow bit should be cleared only when
fixed counter 3 in PEBS counter group. Otherwise perf metrics overflow
could be missed to handle.

Closes: https://lore.kernel.org/all/20250225110012.GK31462@noisy.programming.kicks-ass.net/
Fixes: 7b2c05a15d29 ("perf/x86/intel: Generic support for hardware TopDown metrics")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0ceaa1b07019..c6f69ce3b2b3 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3140,7 +3140,6 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int bit;
 	int handled = 0;
-	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
 
 	inc_irq_stat(apic_perf_irqs);
 
@@ -3184,7 +3183,6 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		handled++;
 		x86_pmu_handle_guest_pebs(regs, &data);
 		static_call(x86_pmu_drain_pebs)(regs, &data);
-		status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
 
 		/*
 		 * PMI throttle may be triggered, which stops the PEBS event.
@@ -3195,6 +3193,15 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		 */
 		if (pebs_enabled != cpuc->pebs_enabled)
 			wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
+
+		/*
+		 * Above PEBS handler (PEBS counters snapshotting) has updated fixed
+		 * counter 3 and perf metrics counts if they are in counter group,
+		 * unnecessary to update again.
+		 */
+		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
+		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
+			status &= ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
 	}
 
 	/*
@@ -3214,6 +3221,8 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		static_call(intel_pmu_update_topdown_event)(NULL, NULL);
 	}
 
+	status &= hybrid(cpuc->pmu, intel_ctrl);
+
 	/*
 	 * Checkpointed counters can lead to 'spurious' PMIs because the
 	 * rollback caused by the PMI will have cleared the overflow status

base-commit: 5c3627b6f0595f1ec27e6f5df903bd072e9b9136
-- 
2.40.1

