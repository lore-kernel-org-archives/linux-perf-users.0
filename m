Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B282C11EA;
	Wed, 20 Aug 2025 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755657099; cv=none; b=qQnuG0IW889KQR5IqiVzGwpubjAVaDXAO8PuXsTPgFxtQPD6HqzhBJH63AMdBuIA6xHtpPiXnc+7cMINsBS3zl9HVfoy3dVvHbOyS7rbP6sO09PYqYY2Od4VmHGkTIUgz40uJaE7q22uj6i+uiSmdAVYfr+mwwVNz+Nk05VpdoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755657099; c=relaxed/simple;
	bh=sZRpO4rbclFWtzr9ZWXs4UzuQzYyrXnLfzfs+08PKFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lwffj5l5Dev+1uAv7cpybD2u6cAgeAjhLBKwPMaKW+u7MWC4ehOrCAz+PcG49xduDRj3JIazfp8RISmufqsxVkxs3l94V6/UU94b6E0SDDXkLZCTPFzJb4FzhPhJKP9K+pUvsLZAzTwu/uTMTdqWhyprm8QgDwDtfy4HjE94HWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bb/lYRc6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bb/lYRc6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755657098; x=1787193098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sZRpO4rbclFWtzr9ZWXs4UzuQzYyrXnLfzfs+08PKFk=;
  b=Bb/lYRc6PgprJAfnaATfv/X1ze2d3kcqJhj5EmPzQ+0EitbXIEZviJzp
   mKIGXqhaq4iIbmyc61Vm/T7br1aQn9V0BWKuzv/eX+OxaxVKSBFrR85AY
   B7x0NSla4HBxbub/VImcrjqP03khnj82t3slZGJJeRd6TsIgi68WO9pu7
   Cdmf7OVIk2zAAZdhzhops6imOyPfSCJfbh1C2obtonR3/Di0Pfxbmat66
   siIas2L/cypwXzE8jlQ4SgurGa6iyL89i6Gm3FfSPayihHwqsM/NL7r0e
   sGcy/qt5/FiVLwNwraMfelScU3cwd6pXJwh8kz71N30Rps8x069PWjSpX
   A==;
X-CSE-ConnectionGUID: bZ3K4WugQCiw95iD04LEAQ==
X-CSE-MsgGUID: rQP75l/BScyeNKPMDA4nNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57625441"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57625441"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 19:31:38 -0700
X-CSE-ConnectionGUID: Ps6Yf5vrSgeQ5P9ArFr6LQ==
X-CSE-MsgGUID: I/14b8UsS1SjkDSxz9UjEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167629002"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 19 Aug 2025 19:31:34 -0700
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
Subject: [Patch v3 2/7] perf/x86/intel: Fix IA32_PMC_x_CFG_B MSRs access error
Date: Wed, 20 Aug 2025 10:30:27 +0800
Message-Id: <20250820023032.17128-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
References: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
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
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c2fb729c270e..15da60cf69f2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2997,7 +2997,8 @@ static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
 			if (event->group_leader != leader->group_leader)
 				break;
 			for_each_set_bit(idx, (unsigned long *)&event->attr.config2, X86_PMC_IDX_MAX) {
-				if (WARN_ON_ONCE(i + idx > cpuc->n_events))
+				if (i + idx >= cpuc->n_events ||
+				    !is_acr_event_group(cpuc->event_list[i + idx]))
 					return;
 				__set_bit(cpuc->assign[i + idx], (unsigned long *)&event->hw.config1);
 			}
-- 
2.34.1

