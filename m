Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E5C245019;
	Thu, 29 May 2025 02:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748484972; cv=none; b=gs02kza+SIr5TB/jrD9khpYEHUV1Ox3H3M0PVjm7CeVm0tbOVGMwFYKbuupTQWAz4pLnJgiQpqGUpnCPc0ai8OhX2oTUrWyEggP+I1nqAkXyujWa0loWo9ydCejg1z5MMrb3OwkScfcowVb10UCTBmm+V4Wxm+f76Bf5l4/oJpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748484972; c=relaxed/simple;
	bh=VzM0GfkwmE2qpKfFZuVL4pRL9AbAx0jfoH4PdMR8kUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ap401qI1rx5PQ4WDHrsu87qEtkRVzn5DSdC6mD4t3GhbW9RaYsw39/oRiYk8tpoPfuae1nEnqomFAQ7vIYwxGOc4K2ARlY+r/sgw5y4ShWxd3a8/8dStFsnKQG+oaiVptYrTEocdlEUvcEp0hhZ+6bceDSz9wYw3+KPfjXIypyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvaHbIX4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvaHbIX4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748484971; x=1780020971;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VzM0GfkwmE2qpKfFZuVL4pRL9AbAx0jfoH4PdMR8kUE=;
  b=nvaHbIX4QkNT1xJ+QtZvDT5gTkb1692ML8arqKyxzsW1vs4cSa5qGSvw
   NGIwAXrdQ6nZ3ElQkeTdi91L2PXbytjRhNXLfSTjfUdzrxXjR7MFKSDrc
   Fv8Dz10pah81NH5S8yYPjdkwomlFYZdoFCULUXt4m5thVXnXLxd4QNjmq
   WNE1gk0Kzp8+L5lTa4cjS6GVxZGHuiFT0tuGQ+VRdKu4Lm3IIEnPjFLv5
   E3RTCbRDugZRUjXtzH5Okh4K0PnN/0NeMZUTsmYMK7Wh3q//f/qj0kOJt
   JhGkmxHzvbfW9bOwETkTwjcQ5E+QFmdXNv+ITNKY3Q3NOC3PWKR3q9+1K
   g==;
X-CSE-ConnectionGUID: sOfEiKuYRKavgYAraY5YBg==
X-CSE-MsgGUID: BGqAz7DkQ6CjWe+v5ar7OA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50684597"
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="50684597"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 19:16:10 -0700
X-CSE-ConnectionGUID: DiBoE5e2RXaFRI4wM/Pnmg==
X-CSE-MsgGUID: 8+R7fZIYRFGtUdCfiOp1Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="166575558"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa002.fm.intel.com with ESMTP; 28 May 2025 19:16:06 -0700
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
Subject: [PATCH 1/2] perf/x86/intel: Fix IA32_PMC_x_CFG_B MSRs access error
Date: Thu, 29 May 2025 08:02:35 +0000
Message-ID: <20250529080236.2552247-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running perf_fuzzer on PTL, sometimes the below "unchecked MSR
 access error" is seen when accessing IA32_PMC_x_CFG_B MSRs.

[   55.611268] unchecked MSR access error: WRMSR to 0x1986 (tried to write 0x0000000200000001) at rIP: 0xffffffffac564b28 (native_write_msr+0x8/0x30)
[   55.611280] Call Trace:
[   55.611282]  <TASK>
[   55.611284]  ? intel_pmu_config_acr+0x87/0x160
[   55.611289]  intel_pmu_enable_acr+0x6d/0x80
[   55.611291]  intel_pmu_enable_event+0xce/0x460
[   55.611293]  x86_pmu_start+0x78/0xb0
[   55.611297]  x86_pmu_enable+0x218/0x3a0
[   55.611300]  ? x86_pmu_enable+0x121/0x3a0
[   55.611302]  perf_pmu_enable+0x40/0x50
[   55.611307]  ctx_resched+0x19d/0x220
[   55.611309]  __perf_install_in_context+0x284/0x2f0
[   55.611311]  ? __pfx_remote_function+0x10/0x10
[   55.611314]  remote_function+0x52/0x70
[   55.611317]  ? __pfx_remote_function+0x10/0x10
[   55.611319]  generic_exec_single+0x84/0x150
[   55.611323]  smp_call_function_single+0xc5/0x1a0
[   55.611326]  ? __pfx_remote_function+0x10/0x10
[   55.611329]  perf_install_in_context+0xd1/0x1e0
[   55.611331]  ? __pfx___perf_install_in_context+0x10/0x10
[   55.611333]  __do_sys_perf_event_open+0xa76/0x1040
[   55.611336]  __x64_sys_perf_event_open+0x26/0x30
[   55.611337]  x64_sys_call+0x1d8e/0x20c0
[   55.611339]  do_syscall_64+0x4f/0x120
[   55.611343]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

On PTL, GP counter 0 and 1 doesn't support auto counter reload feature,
thus it would trigger a #GP when trying to write 1 on bit 0 of CFG_B MSR
which requires to enable auto counter reload on GP counter 0.

The root cause of causing this issue is the check for auto counter
reload (ACR) counter mask from user space is incorrect in
intel_pmu_acr_late_setup() helper. It leads to an invalid ACR counter
mask from user space could be set into hw.config1 and then written into
CFG_B MSRs and trigger the MSR access warning.

e.g., User may create a perf event with ACR counter mask (config2=0xcb),
and there is only 1 event created, so "cpuc->n_events" is 1.

The correct check condition should be "i + idx >= cpuc->n_events"
instead of "i + idx > cpuc->n_events" (it looks a typo). Otherwise,
the counter mask would traverse twice and an invalid "cpuc->assign[1]"
bit (bit 0) is set into hw.config1 and cause MSR accessing error.

Besides, also check if the ACR counter mask corresponding events are
ACR events. If not, filter out these counter mask. If a event is not a
ACR event, it could be scheduled to an HW counter which doesn't support
ACR. It's invalid to add their counter index in ACR counter mask.

Furthermore, remove the WARN_ON_ONCE() since it's easily triggered as
user could set any invalid ACR counter mask and the warning message
could mislead users.

Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3a319cf6d364..8d046b1a237e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2994,7 +2994,8 @@ static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
 			if (event->group_leader != leader->group_leader)
 				break;
 			for_each_set_bit(idx, (unsigned long *)&event->attr.config2, X86_PMC_IDX_MAX) {
-				if (WARN_ON_ONCE(i + idx > cpuc->n_events))
+				if (i + idx >= cpuc->n_events ||
+				    !is_acr_event_group(cpuc->event_list[i + idx]))
 					return;
 				__set_bit(cpuc->assign[i + idx], (unsigned long *)&event->hw.config1);
 			}

base-commit: e7d952cc39fca34386ec9f15f68cb2eaac01b5ae
-- 
2.43.0

