Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="desokLTU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463B018C;
	Wed, 13 Dec 2023 11:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702497149; x=1734033149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OgOFyuxRKcLOzqxt3C1lozEyX1aFj1Oa+GydWrLoLmI=;
  b=desokLTUOW5eX3gUeFjIa42n1TMsTHxnPez6WjZKyewbFO7bBiMBKqet
   H86b4mZ5HTEYgg85nA26A1DFkAsApi0yPdgpZRDngWGE26NkQtpvcrV32
   K5gGjs7h/2TfTuTngEP+4ygEWPU7/JQtt1bP+9BNYojcXWo9B0N35t3BR
   Y8X6Bwn33B7gFF5R9hNHcfveqC2JN+SYI/60iBIHN0dSMEGiTN9wKmrGo
   BtFahtxmMKqN1OG5cv+13kS4V6IjEfH+i6pLbLERQYCi0yaDU6sHI0xEA
   nnm6IZ4NWrLTrxqLN1DxN3J9dy/kD9zX5hvVFofJZ+4RsENKZs0UJmKWL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8412936"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="8412936"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:52:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="917772573"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="917772573"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga001.fm.intel.com with ESMTP; 13 Dec 2023 11:52:07 -0800
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
	atrajeev@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 5/7] perf mem: Clean up is_mem_loads_aux_event()
Date: Wed, 13 Dec 2023 11:51:52 -0800
Message-Id: <20231213195154.1085945-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231213195154.1085945-1-kan.liang@linux.intel.com>
References: <20231213195154.1085945-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The aux_event can be retrieved from the perf_pmu now. Implement a
generic support.

Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/mem-events.c | 23 ++++-------------------
 tools/perf/util/mem-events.c          | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index b776d849fc64..62df03e91c7e 100644
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
 
@@ -28,16 +26,3 @@ struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
 	E(NULL,		NULL,		NULL,	false,	0),
 	E("mem-ldst",	"%s//",		NULL,	false,	0),
 };
-
-bool is_mem_loads_aux_event(struct evsel *leader)
-{
-	struct perf_pmu *pmu = perf_pmus__find("cpu");
-
-	if (!pmu)
-		pmu = perf_pmus__find("cpu_core");
-
-	if (pmu && !perf_pmu__have_event(pmu, "mem-loads-aux"))
-		return false;
-
-	return leader->core.attr.config == MEM_LOADS_AUX;
-}
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 32890848bb3d..7d7df3d0b2b9 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -107,9 +107,19 @@ static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu)
 	return NULL;
 }
 
-__weak bool is_mem_loads_aux_event(struct evsel *leader __maybe_unused)
+bool is_mem_loads_aux_event(struct evsel *leader)
 {
-	return false;
+	struct perf_pmu *pmu = leader->pmu;
+	struct perf_mem_event *e;
+
+	if (!pmu || !pmu->mem_events)
+		return false;
+
+	e = &pmu->mem_events[PERF_MEM_EVENTS__LOAD];
+	if (!e->aux_event)
+		return false;
+
+	return leader->core.attr.config == e->aux_event;
 }
 
 int perf_pmu__mem_events_parse(struct perf_pmu *pmu, const char *str)
-- 
2.35.1

