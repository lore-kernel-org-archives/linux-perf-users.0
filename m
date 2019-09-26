From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 63/66] perf vendor events: Remove P8 HW events which are not supported
Date: Wed, 25 Sep 2019 21:32:41 -0300
Message-ID: <20190926003244.13962-64-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>

This patch is to remove following hardware events
from JSON file which are not supported on POWER8.

pm_l3_p0_grp_pump
pm_l3_p0_lco_data
pm_l3_p0_lco_no_data
pm_l3_p0_lco_rty

  Note: Unfortunately power8 event list is not publicly available.

Fixes: c3b4d5c4afb0 ("perf vendor events: Remove P8 HW events which are not supported")
Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190909065624.11956.3992.stgit@localhost.localdomain
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../pmu-events/arch/powerpc/power8/other.json | 24 -------------------
 1 file changed, 24 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/other.json b/tools/perf/pmu-events/arch/powerpc/power8/other.json
index 9dc2f6b70354..b2a3df07fbc4 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/other.json
@@ -1775,30 +1775,6 @@
     "BriefDescription": "L3 Load Prefetches",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0xa29084",
-    "EventName": "PM_L3_P0_GRP_PUMP",
-    "BriefDescription": "L3 pf sent with grp scope port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x528084",
-    "EventName": "PM_L3_P0_LCO_DATA",
-    "BriefDescription": "lco sent with data port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x518080",
-    "EventName": "PM_L3_P0_LCO_NO_DATA",
-    "BriefDescription": "dataless l3 lco sent port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xa4908c",
-    "EventName": "PM_L3_P0_LCO_RTY",
-    "BriefDescription": "L3 LCO received retry port 0",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x84908d",
     "EventName": "PM_L3_PF0_ALLOC",
-- 
2.21.0
