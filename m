Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByJ82N8k"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D0FA2;
	Mon, 20 Nov 2023 17:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700530736; x=1732066736;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+7VvbUVCHmTCIcY7kK6/rBlQv5zQw4GkO8xAr+x002c=;
  b=ByJ82N8k7Bv/lD8U7DTuW/9QMijrijQnTpZamwsel9cuLVaLYXdEHyU5
   Y+u1g3zAvhIf+QYaUlyMdutAv4ovqcTK5x1QCLRW/XXVLyOHR2BsZ9h6u
   Ez8URu/ZwEgGB5hlUVoAyhwsdH0n/Ck1OJnvWZQ0D44mpvipJLCTQXlZ6
   JJBaCTomoFEPhkC7aofFBM/zLpUHB/H2nTUro0QqLPTUCAhfkedmzOP/7
   vEVLPK2Ub9DsmB9bJs7x3Mwpb6U1TftP1qO3tQFCduO/Sc+EQ5mrSbqnZ
   oNunWAulJdHAWVBeIgZ9GazSWzPAdxymd1cu+FjThujjrqphwg7KEUb4L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="458235181"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="458235181"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 17:38:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="770087205"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="770087205"
Received: from dmi-pnp-i7.sh.intel.com ([10.239.159.155])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2023 17:38:53 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] perf/x86/intel: Correct wrong 'or' operation for pmu capabilities
Date: Tue, 21 Nov 2023 09:46:28 +0800
Message-Id: <20231121014628.729989-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running perf-stat command on Intel hybrid platform, perf-stat
reports the following errors.

sudo taskset -c 7 ./perf stat -vvvv -e cpu_atom/instructions/ sleep 1

Opening: cpu/cycles/:HG
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  config                           0xa00000000
  disabled                         1
------------------------------------------------------------
sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
sys_perf_event_open failed, error -16

 Performance counter stats for 'sleep 1':

     <not counted>      cpu_atom/instructions/

It looks the cpu_atom/instructions/ event can't be enabled on atom pmu
even the process is pinned on atom core. The investigation shows that
exclusive_event_init() helper always returns -EBUSY error in the perf
event creation. That's strange since the atom pmu should not be a
exclusive PMU.

Further investigation shows the issue is introduced by commit 97588df87b56
("perf/x86/intel: Add common intel_pmu_init_hybrid()"). The commit
originally intents to clear the bit PERF_PMU_CAP_AUX_OUTPUT from pmu
capabilities if intel_cap.pebs_output_pt_available is not set, but it
incorrectly uses 'or' operation and leads to all pmu capabilities bits
are set to 1 except bit PERF_PMU_CAP_AUX_OUTPUT.

Testing this fix on Intel hybrid platforms, the observed issues
disappear.

Fixes: 97588df87b56 ("perf/x86/intel: Add common intel_pmu_init_hybrid()")
Cc: stable@vger.kernel.org
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a08f794a0e79..ce1c777227b4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4660,7 +4660,7 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 	if (pmu->intel_cap.pebs_output_pt_available)
 		pmu->pmu.capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
 	else
-		pmu->pmu.capabilities |= ~PERF_PMU_CAP_AUX_OUTPUT;
+		pmu->pmu.capabilities &= ~PERF_PMU_CAP_AUX_OUTPUT;
 
 	intel_pmu_check_event_constraints(pmu->event_constraints,
 					  pmu->num_counters,

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.34.1

