Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f77V06k7"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7D8D62;
	Wed,  6 Dec 2023 12:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701893617; x=1733429617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xauO0p/GUkiGEzh2PvYpS4cwj2BY8SDJavt28LY2Q5I=;
  b=f77V06k7BtsDCeC0SzMUFOzmMDKmwqfls/HmbRr1E+plkpMQWRBywgZY
   yo5NUhIM/n3fN21gnORCoOX5JV+QPIuShPo7c7DNmrsYglw+Y3BFXLMZp
   O9RMIpF4VU+PHxNqJixg36g6en89haG+t2HmX0EZJ/uYsqOpFLrzamHmB
   GtSH7kwXUeueOOfHyukO0Zr5cV1l2dc7vWHIXkmjTXZeaB6YNT2x5Ewgw
   wat1Mo7itMC4tPO3+MMyg361SRlxvIyJBRxWAKYVT/1M3Drem1VlnBQPB
   eylrv8k8bIe74a0qbZgm2g2FL93ApcfG/3Y67UJL1LUNpnzbh+eflu9C1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="458445601"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="458445601"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 12:13:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="944766687"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="944766687"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2023 12:13:32 -0800
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	john.g.garry@oracle.com,
	will@kernel.org,
	james.clark@arm.com,
	mike.leach@linaro.org,
	leo.yan@linaro.org,
	yuhaixin.yhx@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	tmricht@linux.ibm.com,
	ravi.bangoria@amd.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 6/6] perf mem: Remove useless header files for X86
Date: Wed,  6 Dec 2023 12:13:24 -0800
Message-Id: <20231206201324.184059-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231206201324.184059-1-kan.liang@linux.intel.com>
References: <20231206201324.184059-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The X86 mem-events.c only has perf_mem_events array now. Remove useless
header files.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/mem-events.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index 71ffe16de751..62df03e91c7e 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -1,11 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "util/pmu.h"
-#include "util/pmus.h"
-#include "util/env.h"
-#include "map_symbol.h"
-#include "mem-events.h"
 #include "linux/string.h"
-#include "env.h"
+#include "util/map_symbol.h"
+#include "util/mem-events.h"
+#include "mem-events.h"
+
 
 #define MEM_LOADS_AUX		0x8203
 
-- 
2.35.1

