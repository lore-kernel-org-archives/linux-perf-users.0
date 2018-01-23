From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/43] perf vendor events intel: Update IvyTown events to V20
Date: Tue, 23 Jan 2018 10:12:29 -0300
Message-ID: <20180123131251.28197-22-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Link: https://lkml.kernel.org/r/20180118234518.GA27753@tassilo.jf.intel.com
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/ivytown/cache.json  | 692 +++--------------
 .../perf/pmu-events/arch/x86/ivytown/frontend.json | 122 +--
 tools/perf/pmu-events/arch/x86/ivytown/memory.json | 368 +--------
 tools/perf/pmu-events/arch/x86/ivytown/other.json  |  20 +-
 .../perf/pmu-events/arch/x86/ivytown/pipeline.json | 822 +++++++++++----------
 .../arch/x86/ivytown/virtual-memory.json           |  60 +-
 6 files changed, 635 insertions(+), 1449 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivytown/cache.json b/tools/perf/pmu-events/arch/x86/ivytown/cache.json
index ff27a620edd8..d8cc93b3a04c 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/cache.json
@@ -9,6 +9,16 @@
         "BriefDescription": "Demand Data Read requests that hit L2 cache",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "PublicDescription": "Counts any demand and L1 HW prefetch data load requests to L2.",
+        "EventCode": "0x24",
+        "Counter": "0,1,2,3",
+        "UMask": "0x3",
+        "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Demand Data Read requests",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "PublicDescription": "RFO requests that hit L2 cache.",
         "EventCode": "0x24",
@@ -29,6 +39,16 @@
         "BriefDescription": "RFO requests that miss L2 cache",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "PublicDescription": "Counts all L2 store RFO requests.",
+        "EventCode": "0x24",
+        "Counter": "0,1,2,3",
+        "UMask": "0xc",
+        "EventName": "L2_RQSTS.ALL_RFO",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "RFO requests to L2 cache",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "PublicDescription": "Number of instruction fetches that hit the L2 cache.",
         "EventCode": "0x24",
@@ -49,6 +69,16 @@
         "BriefDescription": "L2 cache misses when fetching instructions",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "PublicDescription": "Counts all L2 code requests.",
+        "EventCode": "0x24",
+        "Counter": "0,1,2,3",
+        "UMask": "0x30",
+        "EventName": "L2_RQSTS.ALL_CODE_RD",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "L2 code requests",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "PublicDescription": "Counts all L2 HW prefetcher requests that hit L2.",
         "EventCode": "0x24",
@@ -69,36 +99,6 @@
         "BriefDescription": "Requests from the L2 hardware prefetchers that miss L2 cache",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
-    {
-        "PublicDescription": "Counts any demand and L1 HW prefetch data load requests to L2.",
-        "EventCode": "0x24",
-        "Counter": "0,1,2,3",
-        "UMask": "0x3",
-        "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Demand Data Read requests",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Counts all L2 store RFO requests.",
-        "EventCode": "0x24",
-        "Counter": "0,1,2,3",
-        "UMask": "0xc",
-        "EventName": "L2_RQSTS.ALL_RFO",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "RFO requests to L2 cache",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Counts all L2 code requests.",
-        "EventCode": "0x24",
-        "Counter": "0,1,2,3",
-        "UMask": "0x30",
-        "EventName": "L2_RQSTS.ALL_CODE_RD",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "L2 code requests",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
     {
         "PublicDescription": "Counts all L2 HW prefetcher requests.",
         "EventCode": "0x24",
@@ -218,6 +218,29 @@
         "CounterMask": "1",
         "CounterHTOff": "2"
     },
+    {
+        "PublicDescription": "Cycles with L1D load Misses outstanding from any thread on physical core.",
+        "EventCode": "0x48",
+        "Counter": "2",
+        "UMask": "0x1",
+        "AnyThread": "1",
+        "EventName": "L1D_PEND_MISS.PENDING_CYCLES_ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles with L1D load Misses outstanding from any thread on physical core",
+        "CounterMask": "1",
+        "CounterHTOff": "2"
+    },
+    {
+        "PublicDescription": "Cycles a demand request was blocked due to Fill Buffers inavailability.",
+        "EventCode": "0x48",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "EventName": "L1D_PEND_MISS.FB_FULL",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles a demand request was blocked due to Fill Buffers inavailability",
+        "CounterMask": "1",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "PublicDescription": "Counts the number of lines brought into the L1 data cache.",
         "EventCode": "0x51",
@@ -239,76 +262,87 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Offcore outstanding Demand Code Read transactions in SQ to uncore. Set Cmask=1 to count cycles.",
+        "PublicDescription": "Cycles when offcore outstanding Demand Data Read transactions are present in SuperQueue (SQ), queue to uncore.",
         "EventCode": "0x60",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_CODE_RD",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA_RD",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Offcore outstanding code reads transactions in SuperQueue (SQ), queue to uncore, every cycle",
+        "BriefDescription": "Cycles when offcore outstanding Demand Data Read transactions are present in SuperQueue (SQ), queue to uncore",
+        "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Offcore outstanding RFO store transactions in SQ to uncore. Set Cmask=1 to count cycles.",
+        "PublicDescription": "Cycles with at least 6 offcore outstanding Demand Data Read transactions in uncore queue.",
         "EventCode": "0x60",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_RFO",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD_GE_6",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Offcore outstanding RFO store transactions in SuperQueue (SQ), queue to uncore",
+        "BriefDescription": "Cycles with at least 6 offcore outstanding Demand Data Read transactions in uncore queue",
+        "CounterMask": "6",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Offcore outstanding cacheable data read transactions in SQ to uncore. Set Cmask=1 to count cycles.",
+        "PublicDescription": "Offcore outstanding Demand Code Read transactions in SQ to uncore. Set Cmask=1 to count cycles.",
         "EventCode": "0x60",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
+        "UMask": "0x2",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_CODE_RD",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Offcore outstanding cacheable Core Data Read transactions in SuperQueue (SQ), queue to uncore",
+        "BriefDescription": "Offcore outstanding code reads transactions in SuperQueue (SQ), queue to uncore, every cycle",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Cycles when offcore outstanding Demand Data Read transactions are present in SuperQueue (SQ), queue to uncore.",
+        "PublicDescription": "Offcore outstanding code reads transactions in SuperQueue (SQ), queue to uncore, every cycle.",
         "EventCode": "0x60",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA_RD",
+        "UMask": "0x2",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_CODE_RD",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles when offcore outstanding Demand Data Read transactions are present in SuperQueue (SQ), queue to uncore",
+        "BriefDescription": "Offcore outstanding code reads transactions in SuperQueue (SQ), queue to uncore, every cycle",
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Cycles when offcore outstanding cacheable Core Data Read transactions are present in SuperQueue (SQ), queue to uncore.",
+        "PublicDescription": "Offcore outstanding RFO store transactions in SQ to uncore. Set Cmask=1 to count cycles.",
         "EventCode": "0x60",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "UMask": "0x4",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_RFO",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles when offcore outstanding cacheable Core Data Read transactions are present in SuperQueue (SQ), queue to uncore",
-        "CounterMask": "1",
+        "BriefDescription": "Offcore outstanding RFO store transactions in SuperQueue (SQ), queue to uncore",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Offcore outstanding code reads transactions in SuperQueue (SQ), queue to uncore, every cycle.",
+        "PublicDescription": "Offcore outstanding demand rfo reads transactions in SuperQueue (SQ), queue to uncore, every cycle.",
         "EventCode": "0x60",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_CODE_RD",
+        "UMask": "0x4",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Offcore outstanding code reads transactions in SuperQueue (SQ), queue to uncore, every cycle",
+        "BriefDescription": "Offcore outstanding demand rfo reads transactions in SuperQueue (SQ), queue to uncore, every cycle",
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Offcore outstanding demand rfo reads transactions in SuperQueue (SQ), queue to uncore, every cycle.",
+        "PublicDescription": "Offcore outstanding cacheable data read transactions in SQ to uncore. Set Cmask=1 to count cycles.",
         "EventCode": "0x60",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO",
+        "UMask": "0x8",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Offcore outstanding demand rfo reads transactions in SuperQueue (SQ), queue to uncore, every cycle",
+        "BriefDescription": "Offcore outstanding cacheable Core Data Read transactions in SuperQueue (SQ), queue to uncore",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "PublicDescription": "Cycles when offcore outstanding cacheable Core Data Read transactions are present in SuperQueue (SQ), queue to uncore.",
+        "EventCode": "0x60",
+        "Counter": "0,1,2,3",
+        "UMask": "0x8",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles when offcore outstanding cacheable Core Data Read transactions are present in SuperQueue (SQ), queue to uncore",
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
@@ -379,7 +413,7 @@
         "UMask": "0x11",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Retired load uops that miss the STLB.",
+        "BriefDescription": "Retired load uops that miss the STLB. (Precise Event)",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -389,7 +423,7 @@
         "UMask": "0x12",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Retired store uops that miss the STLB.",
+        "BriefDescription": "Retired store uops that miss the STLB. (Precise Event)",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -399,7 +433,7 @@
         "UMask": "0x21",
         "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Retired load uops with locked access.",
+        "BriefDescription": "Retired load uops with locked access. (Precise Event)",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -409,7 +443,7 @@
         "UMask": "0x41",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Retired load uops that split across a cacheline boundary.",
+        "BriefDescription": "Retired load uops that split across a cacheline boundary. (Precise Event)",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -419,7 +453,7 @@
         "UMask": "0x42",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Retired store uops that split across a cacheline boundary.",
+        "BriefDescription": "Retired store uops that split across a cacheline boundary. (Precise Event)",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -429,7 +463,7 @@
         "UMask": "0x81",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "All retired load uops.",
+        "BriefDescription": "All retired load uops. (Precise Event)",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -439,67 +473,61 @@
         "UMask": "0x82",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "All retired store uops.",
+        "BriefDescription": "All retired store uops. (Precise Event)",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Retired load uops with L1 cache hits as data sources.",
         "EventCode": "0xD1",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Retired load uops with L1 cache hits as data sources. ",
+        "BriefDescription": "Retired load uops with L1 cache hits as data sources.",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Retired load uops with L2 cache hits as data sources.",
         "EventCode": "0xD1",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Retired load uops with L2 cache hits as data sources. ",
+        "BriefDescription": "Retired load uops with L2 cache hits as data sources.",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Retired load uops whose data source was LLC hit with no snoop required.",
         "EventCode": "0xD1",
         "Counter": "0,1,2,3",
         "UMask": "0x4",
         "EventName": "MEM_LOAD_UOPS_RETIRED.LLC_HIT",
         "SampleAfterValue": "50021",
-        "BriefDescription": "Retired load uops which data sources were data hits in LLC without snoops required. ",
+        "BriefDescription": "Retired load uops which data sources were data hits in LLC without snoops required.",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Retired load uops whose data source followed an L1 miss.",
         "EventCode": "0xD1",
         "Counter": "0,1,2,3",
         "UMask": "0x8",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Retired load uops which data sources following L1 data-cache miss",
+        "BriefDescription": "Retired load uops which data sources following L1 data-cache miss.",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Retired load uops that missed L2, excluding unknown sources.",
         "EventCode": "0xD1",
         "Counter": "0,1,2,3",
         "UMask": "0x10",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
         "SampleAfterValue": "50021",
-        "BriefDescription": "Miss in mid-level (L2) cache. Excludes Unknown data-source.",
+        "BriefDescription": "Retired load uops with L2 cache misses as data sources.",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Retired load uops whose data source is LLC miss.",
         "EventCode": "0xD1",
         "Counter": "0,1,2,3",
         "UMask": "0x20",
@@ -510,67 +538,61 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Retired load uops which data sources were load uops missed L1 but hit FB due to preceding miss to the same cache line with data not ready.",
         "EventCode": "0xD1",
         "Counter": "0,1,2,3",
         "UMask": "0x40",
         "EventName": "MEM_LOAD_UOPS_RETIRED.HIT_LFB",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Retired load uops which data sources were load uops missed L1 but hit FB due to preceding miss to the same cache line with data not ready. ",
+        "BriefDescription": "Retired load uops which data sources were load uops missed L1 but hit FB due to preceding miss to the same cache line with data not ready.",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Retired load uops whose data source was an on-package core cache LLC hit and cross-core snoop missed.",
         "EventCode": "0xD2",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS",
         "SampleAfterValue": "20011",
-        "BriefDescription": "Retired load uops which data sources were LLC hit and cross-core snoop missed in on-pkg core cache. ",
+        "BriefDescription": "Retired load uops which data sources were LLC hit and cross-core snoop missed in on-pkg core cache.",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Retired load uops whose data source was an on-package LLC hit and cross-core snoop hits.",
         "EventCode": "0xD2",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
         "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT",
         "SampleAfterValue": "20011",
-        "BriefDescription": "Retired load uops which data sources were LLC and cross-core snoop hits in on-pkg core cache. ",
+        "BriefDescription": "Retired load uops which data sources were LLC and cross-core snoop hits in on-pkg core cache.",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Retired load uops whose data source was an on-package core cache with HitM responses.",
         "EventCode": "0xD2",
         "Counter": "0,1,2,3",
         "UMask": "0x4",
         "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM",
         "SampleAfterValue": "20011",
-        "BriefDescription": "Retired load uops which data sources were HitM responses from shared LLC. ",
+        "BriefDescription": "Retired load uops which data sources were HitM responses from shared LLC.",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Retired load uops whose data source was LLC hit with no snoop required.",
         "EventCode": "0xD2",
         "Counter": "0,1,2,3",
         "UMask": "0x8",
         "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_NONE",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Retired load uops which data sources were hits in LLC without snoops required. ",
+        "BriefDescription": "Retired load uops which data sources were hits in LLC without snoops required.",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Retired load uop whose Data Source was: local DRAM either Snoop not needed or Snoop Miss (RspI)",
         "EventCode": "0xD3",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "UMask": "0x3",
         "EventName": "MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Retired load uops which data sources missed LLC but serviced from local dram.",
+        "BriefDescription": "Retired load uops whose data source was local DRAM (Snoop not needed, Snoop Miss, or Snoop Hit data not forwarded).",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -778,495 +800,5 @@
         "SampleAfterValue": "100003",
         "BriefDescription": "Split locks in SQ",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Cycles with at least 6 offcore outstanding Demand Data Read transactions in uncore queue.",
-        "EventCode": "0x60",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD_GE_6",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles with at least 6 offcore outstanding Demand Data Read transactions in uncore queue",
-        "CounterMask": "6",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Cycles with L1D load Misses outstanding from any thread on physical core.",
-        "EventCode": "0x48",
-        "Counter": "2",
-        "UMask": "0x1",
-        "AnyThread": "1",
-        "EventName": "L1D_PEND_MISS.PENDING_CYCLES_ANY",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles with L1D load Misses outstanding from any thread on physical core",
-        "CounterMask": "1",
-        "CounterHTOff": "2"
-    },
-    {
-        "PublicDescription": "Cycles a demand request was blocked due to Fill Buffers inavailability.",
-        "EventCode": "0x48",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "L1D_PEND_MISS.FB_FULL",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles a demand request was blocked due to Fill Buffers inavailability",
-        "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x4003c0091",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand & prefetch data reads that hit in the LLC and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0091",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_HIT.HITM_OTHER_CORE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand & prefetch data reads that hit in the LLC and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1003c0091",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_HIT.NO_SNOOP_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand & prefetch data reads that hit in the LLC and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2003c0091",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand & prefetch data reads that hit in the LLC and sibling core snoop returned a clean response",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0090",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.LLC_HIT.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch data reads that hit the LLC",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x4003c0090",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch data reads that hit in the LLC and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0090",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.LLC_HIT.HITM_OTHER_CORE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch data reads that hit in the LLC and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1003c0090",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.LLC_HIT.NO_SNOOP_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch data reads that hit in the LLC and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2003c0090",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.LLC_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch data reads that hit in the LLC and sibling core snoop returned a clean response",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c03f7",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_HIT.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that hit in the LLC",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x4003c03f7",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that hit in the LLC and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c03f7",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_HIT.HITM_OTHER_CORE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that hit in the LLC and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1003c03f7",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_HIT.NO_SNOOP_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that hit in the LLC and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2003c03f7",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that hit in the LLC and sibling core snoop returned a clean response",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10008",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.COREWB.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all writebacks from the core to the LLC",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0004",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_HIT.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that hit in the LLC",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0001",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand data reads that hit in the LLC",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x4003c0001",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that hit in the LLC and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0001",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT.HITM_OTHER_CORE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that hit in the LLC and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1003c0001",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT.NO_SNOOP_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that hit in the LLC and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2003c0001",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that hit in the LLC and sibling core snoop returned a clean response",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0002",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.HITM_OTHER_CORE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data writes (RFOs) that hit in the LLC and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x803c8000",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.OTHER.LRU_HINTS",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts L2 hints sent to LLC to keep a line from being evicted out of the core caches",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x23ffc08000",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.OTHER.PORTIO_MMIO_UC",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts miscellaneous accesses that include port i/o, MMIO and uncacheable memory accesses",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0040",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.LLC_HIT.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to L2) code reads that hit in the LLC",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0010",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_HIT.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads that hit in the LLC",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x4003c0010",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads that hit in the LLC and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0010",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_HIT.HITM_OTHER_CORE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads that hit in the LLC and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1003c0010",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_HIT.NO_SNOOP_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads that hit in the LLC and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2003c0010",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads that hit in the LLC and the snoops sent to sibling cores return clean response",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0200",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_LLC_CODE_RD.LLC_HIT.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) code reads that hit in the LLC",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0080",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_LLC_DATA_RD.LLC_HIT.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only) data reads that hit in the LLC",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x4003c0080",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_LLC_DATA_RD.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only) data reads that hit in the LLC and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0080",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_LLC_DATA_RD.LLC_HIT.HITM_OTHER_CORE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only) data reads that hit in the LLC and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1003c0080",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_LLC_DATA_RD.LLC_HIT.NO_SNOOP_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only) data reads that hit in the LLC and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2003c0080",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_LLC_DATA_RD.LLC_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only) data reads that hit in the LLC and the snoops sent to sibling cores return clean response",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10400",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.SPLIT_LOCK_UC_LOCK.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts requests where the address of an atomic lock instruction spans a cache line boundary or the lock instruction is executed on uncacheable address",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10800",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts non-temporal stores",
-        "CounterHTOff": "0,1,2,3"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/frontend.json b/tools/perf/pmu-events/arch/x86/ivytown/frontend.json
index de72b84b3536..efaa949ead31 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/frontend.json
@@ -20,76 +20,45 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Increment each cycle. # of uops delivered to IDQ from DSB path. Set Cmask = 1 to count cycles.",
-        "EventCode": "0x79",
-        "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "IDQ.DSB_UOPS",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Uops delivered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Increment each cycle # of uops delivered to IDQ when MS_busy by DSB. Set Cmask = 1 to count cycles. Add Edge=1 to count # of delivery.",
-        "EventCode": "0x79",
-        "Counter": "0,1,2,3",
-        "UMask": "0x10",
-        "EventName": "IDQ.MS_DSB_UOPS",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Uops initiated by Decode Stream Buffer (DSB) that are being delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Increment each cycle # of uops delivered to IDQ when MS_busy by MITE. Set Cmask = 1 to count cycles.",
-        "EventCode": "0x79",
-        "Counter": "0,1,2,3",
-        "UMask": "0x20",
-        "EventName": "IDQ.MS_MITE_UOPS",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Uops initiated by MITE and delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Increment each cycle # of uops delivered to IDQ from MS by either DSB or MITE. Set Cmask = 1 to count cycles.",
+        "PublicDescription": "Cycles when uops are being delivered to Instruction Decode Queue (IDQ) from MITE path.",
         "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x30",
-        "EventName": "IDQ.MS_UOPS",
+        "UMask": "0x4",
+        "EventName": "IDQ.MITE_CYCLES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Uops delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
+        "BriefDescription": "Cycles when uops are being delivered to Instruction Decode Queue (IDQ) from MITE path",
+        "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Cycles when uops are being delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy.",
+        "PublicDescription": "Increment each cycle. # of uops delivered to IDQ from DSB path. Set Cmask = 1 to count cycles.",
         "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x30",
-        "EventName": "IDQ.MS_CYCLES",
+        "UMask": "0x8",
+        "EventName": "IDQ.DSB_UOPS",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles when uops are being delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
-        "CounterMask": "1",
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Cycles when uops are being delivered to Instruction Decode Queue (IDQ) from MITE path.",
+        "PublicDescription": "Cycles when uops are being delivered to Instruction Decode Queue (IDQ) from Decode Stream Buffer (DSB) path.",
         "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "IDQ.MITE_CYCLES",
+        "UMask": "0x8",
+        "EventName": "IDQ.DSB_CYCLES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles when uops are being delivered to Instruction Decode Queue (IDQ) from MITE path",
+        "BriefDescription": "Cycles when uops are being delivered to Instruction Decode Queue (IDQ) from Decode Stream Buffer (DSB) path",
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Cycles when uops are being delivered to Instruction Decode Queue (IDQ) from Decode Stream Buffer (DSB) path.",
+        "PublicDescription": "Increment each cycle # of uops delivered to IDQ when MS_busy by DSB. Set Cmask = 1 to count cycles. Add Edge=1 to count # of delivery.",
         "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "IDQ.DSB_CYCLES",
+        "UMask": "0x10",
+        "EventName": "IDQ.MS_DSB_UOPS",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles when uops are being delivered to Instruction Decode Queue (IDQ) from Decode Stream Buffer (DSB) path",
-        "CounterMask": "1",
+        "BriefDescription": "Uops initiated by Decode Stream Buffer (DSB) that are being delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -137,6 +106,16 @@
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "PublicDescription": "Increment each cycle # of uops delivered to IDQ when MS_busy by MITE. Set Cmask = 1 to count cycles.",
+        "EventCode": "0x79",
+        "Counter": "0,1,2,3",
+        "UMask": "0x20",
+        "EventName": "IDQ.MS_MITE_UOPS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Uops initiated by MITE and delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "PublicDescription": "Counts cycles MITE is delivered four uops. Set Cmask = 4.",
         "EventCode": "0x79",
@@ -159,6 +138,39 @@
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "PublicDescription": "Increment each cycle # of uops delivered to IDQ from MS by either DSB or MITE. Set Cmask = 1 to count cycles.",
+        "EventCode": "0x79",
+        "Counter": "0,1,2,3",
+        "UMask": "0x30",
+        "EventName": "IDQ.MS_UOPS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "PublicDescription": "Cycles when uops are being delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy.",
+        "EventCode": "0x79",
+        "Counter": "0,1,2,3",
+        "UMask": "0x30",
+        "EventName": "IDQ.MS_CYCLES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles when uops are being delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy",
+        "CounterMask": "1",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "PublicDescription": "Number of switches from DSB (Decode Stream Buffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
+        "EventCode": "0x79",
+        "Counter": "0,1,2,3",
+        "UMask": "0x30",
+        "EdgeDetect": "1",
+        "EventName": "IDQ.MS_SWITCHES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of switches from DSB (Decode Stream Buffer) or MITE (legacy decode pipeline) to the Microcode Sequencer",
+        "CounterMask": "1",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "PublicDescription": "Number of uops delivered to IDQ from any path.",
         "EventCode": "0x79",
@@ -206,7 +218,7 @@
         "UMask": "0x1",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Uops not delivered to Resource Allocation Table (RAT) per thread when backend of the machine is not stalled ",
+        "BriefDescription": "Uops not delivered to Resource Allocation Table (RAT) per thread when backend of the machine is not stalled",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -289,17 +301,5 @@
         "SampleAfterValue": "2000003",
         "BriefDescription": "Cycles when Decode Stream Buffer (DSB) fill encounter more than 3 Decode Stream Buffer (DSB) lines",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Number of switches from DSB (Decode Stream Buffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
-        "EventCode": "0x79",
-        "Counter": "0,1,2,3",
-        "UMask": "0x30",
-        "EdgeDetect": "1",
-        "EventName": "IDQ.MS_SWITCHES",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Number of switches from DSB (Decode Stream Buffer) or MITE (legacy decode pipeline) to the Microcode Sequencer",
-        "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/memory.json b/tools/perf/pmu-events/arch/x86/ivytown/memory.json
index 437d98f3e344..4ec94df8d70b 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/memory.json
@@ -28,18 +28,6 @@
         "BriefDescription": "Counts the number of machine clears due to memory order conflicts.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
-    {
-        "PEBS": "2",
-        "EventCode": "0xCD",
-        "Counter": "3",
-        "UMask": "0x2",
-        "EventName": "MEM_TRANS_RETIRED.PRECISE_STORE",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Sample stores and collect precise store operation via PEBS record. PMC3 only.",
-        "PRECISE_STORE": "1",
-        "TakenAlone": "1",
-        "CounterHTOff": "3"
-    },
     {
         "PEBS": "2",
         "PublicDescription": "Loads with latency value being above 4.",
@@ -153,351 +141,15 @@
         "CounterHTOff": "3"
     },
     {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc00244",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch code reads that miss the LLC",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x67f800244",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_MISS.REMOTE_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch code reads that miss the LLC  and the data returned from remote dram",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x87f800244",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_MISS.REMOTE_HIT_FORWARD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch code reads that miss the LLC  and the data forwarded from remote cache",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc20091",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch data reads that hits the LLC",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc203f7",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that hit the LLC",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x6004003f7",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the LLC  and the data returned from local dram",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x87f8203f7",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.REMOTE_HIT_FORWARD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the LLC  and the data forwarded from remote cache",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x107fc003f7",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.REMOTE_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the LLC  the data is found in M state in remote cache and forwarded from there",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc20004",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that miss the LLC",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x600400004",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_MISS.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that miss the LLC  and the data returned from local dram",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x67f800004",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_MISS.REMOTE_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that miss the LLC  and the data returned from remote dram",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x87f820004",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_MISS.REMOTE_HIT_FORWARD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that miss the LLC  and the data forwarded from remote cache",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x107fc00004",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_MISS.REMOTE_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that miss the LLC  the data is found in M state in remote cache and forwarded from there",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x67fc00001",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_MISS.ANY_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that miss the LLC  and the data returned from remote & local dram",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc20001",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that miss in the LLC",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x600400001",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_MISS.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that miss the LLC  and the data returned from local dram",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x67f800001",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_MISS.REMOTE_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that miss the LLC  and the data returned from remote dram",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x87f820001",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_MISS.REMOTE_HIT_FORWARD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that miss the LLC  and the data forwarded from remote cache",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x107fc00001",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_MISS.REMOTE_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that miss the LLC  the data is found in M state in remote cache and forwarded from there",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x107fc20002",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_MISS.REMOTE_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand data writes (RFOs) that miss the LLC and the data is found in M state in remote cache and forwarded from there.",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc20040",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.LLC_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to L2) code reads that miss the LLC  and the data returned from remote & local dram",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x67fc00010",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_MISS.ANY_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads that miss the LLC  and the data returned from remote & local dram",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc20010",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads that miss in the LLC",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x600400010",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_MISS.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads that miss the LLC  and the data returned from local dram",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x67f800010",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_MISS.REMOTE_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads  that miss the LLC  and the data returned from remote dram",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x87f820010",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_MISS.REMOTE_HIT_FORWARD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads that miss the LLC  and the data forwarded from remote cache",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x107fc00010",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_MISS.REMOTE_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads that miss the LLC  the data is found in M state in remote cache and forwarded from there",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc20200",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_LLC_CODE_RD.LLC_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) code reads that miss in the LLC",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc20080",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "Offcore": "1",
-        "EventName": "OFFCORE_RESPONSE.PF_LLC_DATA_RD.LLC_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only) data reads that miss in the LLC",
-        "CounterHTOff": "0,1,2,3"
+        "PEBS": "2",
+        "EventCode": "0xCD",
+        "Counter": "3",
+        "UMask": "0x2",
+        "EventName": "MEM_TRANS_RETIRED.PRECISE_STORE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Sample stores and collect precise store operation via PEBS record. PMC3 only.",
+        "PRECISE_STORE": "1",
+        "TakenAlone": "1",
+        "CounterHTOff": "3"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/other.json b/tools/perf/pmu-events/arch/x86/ivytown/other.json
index 9c2dd0511a32..4eb83ee40412 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/other.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/other.json
@@ -9,16 +9,6 @@
         "BriefDescription": "Unhalted core cycles when the thread is in ring 0",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
-    {
-        "PublicDescription": "Unhalted core cycles when the thread is not in ring 0.",
-        "EventCode": "0x5C",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "CPL_CYCLES.RING123",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Unhalted core cycles when thread is in rings 1, 2, or 3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
     {
         "PublicDescription": "Number of intervals between processor halts while thread is in ring 0.",
         "EventCode": "0x5C",
@@ -31,6 +21,16 @@
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "PublicDescription": "Unhalted core cycles when the thread is not in ring 0.",
+        "EventCode": "0x5C",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "EventName": "CPL_CYCLES.RING123",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Unhalted core cycles when thread is in rings 1, 2, or 3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "PublicDescription": "Cycles in which the L1D and L2 are locked, due to a UC lock or split lock.",
         "EventCode": "0x63",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
index 2145c28193f7..0afbfd95ea30 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
@@ -1,30 +1,41 @@
 [
     {
         "EventCode": "0x00",
-        "Counter": "Fixed counter 1",
+        "Counter": "Fixed counter 0",
         "UMask": "0x1",
         "EventName": "INST_RETIRED.ANY",
         "SampleAfterValue": "2000003",
         "BriefDescription": "Instructions retired from execution.",
-        "CounterHTOff": "Fixed counter 1"
+        "CounterHTOff": "Fixed counter 0"
     },
     {
         "EventCode": "0x00",
-        "Counter": "Fixed counter 2",
+        "Counter": "Fixed counter 1",
         "UMask": "0x2",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "SampleAfterValue": "2000003",
         "BriefDescription": "Core cycles when the thread is not in halt state.",
-        "CounterHTOff": "Fixed counter 2"
+        "CounterHTOff": "Fixed counter 1"
+    },
+    {
+        "PublicDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
+        "EventCode": "0x00",
+        "Counter": "Fixed counter 1",
+        "UMask": "0x2",
+        "AnyThread": "1",
+        "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state",
+        "CounterHTOff": "Fixed counter 1"
     },
     {
         "EventCode": "0x00",
-        "Counter": "Fixed counter 3",
+        "Counter": "Fixed counter 2",
         "UMask": "0x3",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "SampleAfterValue": "2000003",
         "BriefDescription": "Reference cycles when the core is not in halt state.",
-        "CounterHTOff": "Fixed counter 3"
+        "CounterHTOff": "Fixed counter 2"
     },
     {
         "PublicDescription": "Loads blocked by overlapping with store buffer that cannot be forwarded.",
@@ -77,6 +88,17 @@
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "EventCode": "0x0D",
+        "Counter": "0,1,2,3",
+        "UMask": "0x3",
+        "AnyThread": "1",
+        "EventName": "INT_MISC.RECOVERY_CYCLES_ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Core cycles the allocator was stalled due to recovery from earlier clear event for any thread running on the physical core (e.g. misprediction or memory nuke).",
+        "CounterMask": "1",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "PublicDescription": "Increments each cycle the # of Uops issued by the RAT to RS. Set Cmask = 1, Inv = 1, Any= 1to count stalled cycles of this core.",
         "EventCode": "0x0E",
@@ -174,6 +196,17 @@
         "BriefDescription": "Thread cycles when thread is not in halt state",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "PublicDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
+        "EventCode": "0x3C",
+        "Counter": "0,1,2,3",
+        "UMask": "0x0",
+        "AnyThread": "1",
+        "EventName": "CPU_CLK_UNHALTED.THREAD_P_ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "PublicDescription": "Increments at the frequency of XCLK (100 MHz) when not halted.",
         "EventCode": "0x3C",
@@ -184,6 +217,36 @@
         "BriefDescription": "Reference cycles when the thread is unhalted (counts at 100 MHz rate)",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "EventCode": "0x3C",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "AnyThread": "1",
+        "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Reference cycles when the at least one thread on the physical core is unhalted. (counts at 100 MHz rate)",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "PublicDescription": "Reference cycles when the thread is unhalted. (counts at 100 MHz rate)",
+        "EventCode": "0x3C",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "CPU_CLK_UNHALTED.REF_XCLK",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Reference cycles when the thread is unhalted (counts at 100 MHz rate)",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0x3C",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "AnyThread": "1",
+        "EventName": "CPU_CLK_UNHALTED.REF_XCLK_ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Reference cycles when the at least one thread on the physical core is unhalted. (counts at 100 MHz rate)",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "EventCode": "0x3C",
         "Counter": "0,1,2,3",
@@ -193,6 +256,15 @@
         "BriefDescription": "Count XClk pulses when this thread is unhalted and the other is halted.",
         "CounterHTOff": "0,1,2,3"
     },
+    {
+        "EventCode": "0x3C",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Count XClk pulses when this thread is unhalted and the other thread is halted.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "PublicDescription": "Non-SW-prefetch load dispatches that hit fill buffer allocated for S/W prefetch.",
         "EventCode": "0x4C",
@@ -216,37 +288,37 @@
     {
         "EventCode": "0x58",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "MOVE_ELIMINATION.INT_NOT_ELIMINATED",
+        "UMask": "0x1",
+        "EventName": "MOVE_ELIMINATION.INT_ELIMINATED",
         "SampleAfterValue": "1000003",
-        "BriefDescription": "Number of integer Move Elimination candidate uops that were not eliminated.",
+        "BriefDescription": "Number of integer Move Elimination candidate uops that were eliminated.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0x58",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "MOVE_ELIMINATION.SIMD_NOT_ELIMINATED",
+        "UMask": "0x2",
+        "EventName": "MOVE_ELIMINATION.SIMD_ELIMINATED",
         "SampleAfterValue": "1000003",
-        "BriefDescription": "Number of SIMD Move Elimination candidate uops that were not eliminated.",
+        "BriefDescription": "Number of SIMD Move Elimination candidate uops that were eliminated.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0x58",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "MOVE_ELIMINATION.INT_ELIMINATED",
+        "UMask": "0x4",
+        "EventName": "MOVE_ELIMINATION.INT_NOT_ELIMINATED",
         "SampleAfterValue": "1000003",
-        "BriefDescription": "Number of integer Move Elimination candidate uops that were eliminated.",
+        "BriefDescription": "Number of integer Move Elimination candidate uops that were not eliminated.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0x58",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "MOVE_ELIMINATION.SIMD_ELIMINATED",
+        "UMask": "0x8",
+        "EventName": "MOVE_ELIMINATION.SIMD_NOT_ELIMINATED",
         "SampleAfterValue": "1000003",
-        "BriefDescription": "Number of SIMD Move Elimination candidate uops that were eliminated.",
+        "BriefDescription": "Number of SIMD Move Elimination candidate uops that were not eliminated.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -259,6 +331,18 @@
         "BriefDescription": "Cycles when Reservation Station (RS) is empty for the thread",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "EventCode": "0x5E",
+        "Invert": "1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EdgeDetect": "1",
+        "EventName": "RS_EVENTS.EMPTY_END",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Counts end of periods where the Reservation Station (RS) was empty. Could be useful to precisely locate Frontend Latency Bound issues.",
+        "CounterMask": "1",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "EventCode": "0x87",
         "Counter": "0,1,2,3",
@@ -498,118 +582,118 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Cycles which a Uop is dispatched on port 1.",
+        "PublicDescription": "Cycles per core when uops are dispatched to port 0.",
         "EventCode": "0xA1",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_1",
+        "UMask": "0x1",
+        "AnyThread": "1",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_0_CORE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per thread when uops are dispatched to port 1",
+        "BriefDescription": "Cycles per core when uops are dispatched to port 0",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Cycles which a Uop is dispatched on port 4.",
+        "PublicDescription": "Cycles which a Uop is dispatched on port 1.",
         "EventCode": "0xA1",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_4",
+        "UMask": "0x2",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_1",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per thread when uops are dispatched to port 4",
+        "BriefDescription": "Cycles per thread when uops are dispatched to port 1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Cycles which a Uop is dispatched on port 5.",
+        "PublicDescription": "Cycles per core when uops are dispatched to port 1.",
         "EventCode": "0xA1",
         "Counter": "0,1,2,3",
-        "UMask": "0x80",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_5",
+        "UMask": "0x2",
+        "AnyThread": "1",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_1_CORE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per thread when uops are dispatched to port 5",
+        "BriefDescription": "Cycles per core when uops are dispatched to port 1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Cycles per core when uops are dispatched to port 0.",
+        "PublicDescription": "Cycles which a Uop is dispatched on port 2.",
         "EventCode": "0xA1",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "AnyThread": "1",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_0_CORE",
+        "UMask": "0xc",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_2",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per core when uops are dispatched to port 0",
+        "BriefDescription": "Cycles per thread when load or STA uops are dispatched to port 2",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Cycles per core when uops are dispatched to port 1.",
         "EventCode": "0xA1",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "UMask": "0xc",
         "AnyThread": "1",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_1_CORE",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_2_CORE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per core when uops are dispatched to port 1",
+        "BriefDescription": "Uops dispatched to port 2, loads and stores per core (speculative and retired).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Cycles per core when uops are dispatched to port 4.",
+        "PublicDescription": "Cycles which a Uop is dispatched on port 3.",
         "EventCode": "0xA1",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
-        "AnyThread": "1",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_4_CORE",
+        "UMask": "0x30",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_3",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per core when uops are dispatched to port 4",
+        "BriefDescription": "Cycles per thread when load or STA uops are dispatched to port 3",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Cycles per core when uops are dispatched to port 5.",
+        "PublicDescription": "Cycles per core when load or STA uops are dispatched to port 3.",
         "EventCode": "0xA1",
         "Counter": "0,1,2,3",
-        "UMask": "0x80",
+        "UMask": "0x30",
         "AnyThread": "1",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_5_CORE",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_3_CORE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per core when uops are dispatched to port 5",
+        "BriefDescription": "Cycles per core when load or STA uops are dispatched to port 3",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Cycles which a Uop is dispatched on port 2.",
+        "PublicDescription": "Cycles which a Uop is dispatched on port 4.",
         "EventCode": "0xA1",
         "Counter": "0,1,2,3",
-        "UMask": "0xc",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_2",
+        "UMask": "0x40",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_4",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per thread when load or STA uops are dispatched to port 2",
+        "BriefDescription": "Cycles per thread when uops are dispatched to port 4",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Cycles which a Uop is dispatched on port 3.",
+        "PublicDescription": "Cycles per core when uops are dispatched to port 4.",
         "EventCode": "0xA1",
         "Counter": "0,1,2,3",
-        "UMask": "0x30",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_3",
+        "UMask": "0x40",
+        "AnyThread": "1",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_4_CORE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per thread when load or STA uops are dispatched to port 3",
+        "BriefDescription": "Cycles per core when uops are dispatched to port 4",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
+        "PublicDescription": "Cycles which a Uop is dispatched on port 5.",
         "EventCode": "0xA1",
         "Counter": "0,1,2,3",
-        "UMask": "0xc",
-        "AnyThread": "1",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_2_CORE",
+        "UMask": "0x80",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_5",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Uops dispatched to port 2, loads and stores per core (speculative and retired).",
+        "BriefDescription": "Cycles per thread when uops are dispatched to port 5",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Cycles per core when load or STA uops are dispatched to port 3.",
+        "PublicDescription": "Cycles per core when uops are dispatched to port 5.",
         "EventCode": "0xA1",
         "Counter": "0,1,2,3",
-        "UMask": "0x30",
+        "UMask": "0x80",
         "AnyThread": "1",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_3_CORE",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_5_CORE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per core when load or STA uops are dispatched to port 3",
+        "BriefDescription": "Cycles per core when uops are dispatched to port 5",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -662,15 +746,14 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Cycles with pending L1 cache miss loads. Set AnyThread to count per core.",
         "EventCode": "0xA3",
-        "Counter": "2",
-        "UMask": "0x8",
-        "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_PENDING",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles with pending L1 cache miss loads.",
-        "CounterMask": "8",
-        "CounterHTOff": "2"
+        "BriefDescription": "Cycles while L2 cache miss load* is outstanding.",
+        "CounterMask": "1",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "PublicDescription": "Cycles with pending memory loads. Set AnyThread to count per core.",
@@ -683,6 +766,16 @@
         "CounterMask": "2",
         "CounterHTOff": "0,1,2,3"
     },
+    {
+        "EventCode": "0xA3",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles while memory subsystem has an outstanding load.",
+        "CounterMask": "2",
+        "CounterHTOff": "0,1,2,3"
+    },
     {
         "PublicDescription": "Total execution stalls.",
         "EventCode": "0xA3",
@@ -690,7 +783,17 @@
         "UMask": "0x4",
         "EventName": "CYCLE_ACTIVITY.CYCLES_NO_EXECUTE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Total execution stalls",
+        "BriefDescription": "This event increments by 1 for every cycle where there was no execute for this thread.",
+        "CounterMask": "4",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xA3",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Total execution stalls.",
         "CounterMask": "4",
         "CounterHTOff": "0,1,2,3"
     },
@@ -705,6 +808,16 @@
         "CounterMask": "5",
         "CounterHTOff": "0,1,2,3"
     },
+    {
+        "EventCode": "0xA3",
+        "Counter": "0,1,2,3",
+        "UMask": "0x5",
+        "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Execution stalls while L2 cache miss load* is outstanding.",
+        "CounterMask": "5",
+        "CounterHTOff": "0,1,2,3"
+    },
     {
         "EventCode": "0xA3",
         "Counter": "0,1,2,3",
@@ -716,16 +829,57 @@
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Execution stalls due to L1 data cache miss loads. Set Cmask=0CH.",
         "EventCode": "0xA3",
-        "Counter": "2",
-        "UMask": "0xc",
-        "EventName": "CYCLE_ACTIVITY.STALLS_L1D_PENDING",
-        "SampleAfterValue": "2000003",
+        "Counter": "0,1,2,3",
+        "UMask": "0x6",
+        "EventName": "CYCLE_ACTIVITY.STALLS_MEM_ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Execution stalls while memory subsystem has an outstanding load.",
+        "CounterMask": "6",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Cycles with pending L1 cache miss loads. Set AnyThread to count per core.",
+        "EventCode": "0xA3",
+        "Counter": "2",
+        "UMask": "0x8",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_PENDING",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles with pending L1 cache miss loads.",
+        "CounterMask": "8",
+        "CounterHTOff": "2"
+    },
+    {
+        "EventCode": "0xA3",
+        "Counter": "2",
+        "UMask": "0x8",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles while L1 cache miss demand load is outstanding.",
+        "CounterMask": "8",
+        "CounterHTOff": "2"
+    },
+    {
+        "PublicDescription": "Execution stalls due to L1 data cache miss loads. Set Cmask=0CH.",
+        "EventCode": "0xA3",
+        "Counter": "2",
+        "UMask": "0xc",
+        "EventName": "CYCLE_ACTIVITY.STALLS_L1D_PENDING",
+        "SampleAfterValue": "2000003",
         "BriefDescription": "Execution stalls due to L1 data cache misses",
         "CounterMask": "12",
         "CounterHTOff": "2"
     },
+    {
+        "EventCode": "0xA3",
+        "Counter": "2",
+        "UMask": "0xc",
+        "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Execution stalls while L1 cache miss demand load is outstanding.",
+        "CounterMask": "12",
+        "CounterHTOff": "2"
+    },
     {
         "EventCode": "0xA8",
         "Counter": "0,1,2,3",
@@ -746,6 +900,17 @@
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "PublicDescription": "Cycles 4 Uops delivered by the LSD, but didn't come from the decoder.",
+        "EventCode": "0xA8",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "LSD.CYCLES_4_UOPS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles 4 Uops delivered by the LSD, but didn't come from the decoder",
+        "CounterMask": "4",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "PublicDescription": "Counts total number of uops to be executed per-thread each cycle. Set Cmask = 1, INV =1 to count stall cycles.",
         "EventCode": "0xB1",
@@ -756,6 +921,61 @@
         "BriefDescription": "Counts the number of uops to be executed per-thread each cycle.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "EventCode": "0xB1",
+        "Invert": "1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "UOPS_EXECUTED.STALL_CYCLES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Counts number of cycles no uops were dispatched to be executed on this thread.",
+        "CounterMask": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Cycles where at least 1 uop was executed per-thread.",
+        "EventCode": "0xB1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles where at least 1 uop was executed per-thread",
+        "CounterMask": "1",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "PublicDescription": "Cycles where at least 2 uops were executed per-thread.",
+        "EventCode": "0xB1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles where at least 2 uops were executed per-thread",
+        "CounterMask": "2",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "PublicDescription": "Cycles where at least 3 uops were executed per-thread.",
+        "EventCode": "0xB1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles where at least 3 uops were executed per-thread",
+        "CounterMask": "3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "PublicDescription": "Cycles where at least 4 uops were executed per-thread.",
+        "EventCode": "0xB1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_4_UOPS_EXEC",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles where at least 4 uops were executed per-thread",
+        "CounterMask": "4",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "PublicDescription": "Counts total number of uops to be executed per-core each cycle.",
         "EventCode": "0xB1",
@@ -767,15 +987,59 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
+        "PublicDescription": "Cycles at least 1 micro-op is executed from any thread on physical core.",
         "EventCode": "0xB1",
-        "Invert": "1",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "UOPS_EXECUTED.STALL_CYCLES",
+        "UMask": "0x2",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Counts number of cycles no uops were dispatched to be executed on this thread.",
+        "BriefDescription": "Cycles at least 1 micro-op is executed from any thread on physical core",
         "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3"
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "PublicDescription": "Cycles at least 2 micro-op is executed from any thread on physical core.",
+        "EventCode": "0xB1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles at least 2 micro-op is executed from any thread on physical core",
+        "CounterMask": "2",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "PublicDescription": "Cycles at least 3 micro-op is executed from any thread on physical core.",
+        "EventCode": "0xB1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles at least 3 micro-op is executed from any thread on physical core",
+        "CounterMask": "3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "PublicDescription": "Cycles at least 4 micro-op is executed from any thread on physical core.",
+        "EventCode": "0xB1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles at least 4 micro-op is executed from any thread on physical core",
+        "CounterMask": "4",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "PublicDescription": "Cycles with no micro-ops executed from any thread on physical core.",
+        "EventCode": "0xB1",
+        "Invert": "1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_NONE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles with no micro-ops executed from any thread on physical core",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "PublicDescription": "Number of instructions at retirement.",
@@ -809,24 +1073,12 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Counts the number of micro-ops retired, Use cmask=1 and invert to count active cycles or stalled cycles.",
         "EventCode": "0xC2",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "UOPS_RETIRED.ALL",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Actually retired uops. ",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PEBS": "1",
-        "PublicDescription": "Counts the number of retirement slots used each cycle.",
-        "EventCode": "0xC2",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "UOPS_RETIRED.RETIRE_SLOTS",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Retirement slots used. ",
+        "BriefDescription": "Retired uops.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -863,6 +1115,27 @@
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3"
     },
+    {
+        "PEBS": "1",
+        "EventCode": "0xC2",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "EventName": "UOPS_RETIRED.RETIRE_SLOTS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Retirement slots used.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0xC3",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EdgeDetect": "1",
+        "EventName": "MACHINE_CLEARS.COUNT",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Number of machine clears (nukes) of any type.",
+        "CounterMask": "1",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "PublicDescription": "Number of self-modifying-code machine clears detected.",
         "EventCode": "0xC3",
@@ -880,50 +1153,67 @@
         "UMask": "0x20",
         "EventName": "MACHINE_CLEARS.MASKMOV",
         "SampleAfterValue": "100003",
-        "BriefDescription": "This event counts the number of executed Intel AVX masked load operations that refer to an illegal address range with the mask bits set to 0. ",
+        "BriefDescription": "This event counts the number of executed Intel AVX masked load operations that refer to an illegal address range with the mask bits set to 0.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "PublicDescription": "Branch instructions at retirement.",
+        "EventCode": "0xC4",
+        "Counter": "0,1,2,3",
+        "UMask": "0x0",
+        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "All (macro) branch instructions retired.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Counts the number of conditional branch instructions retired.",
         "EventCode": "0xC4",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "BR_INST_RETIRED.CONDITIONAL",
         "SampleAfterValue": "400009",
-        "BriefDescription": "Conditional branch instructions retired. ",
+        "BriefDescription": "Conditional branch instructions retired.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Direct and indirect near call instructions retired.",
         "EventCode": "0xC4",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Direct and indirect near call instructions retired. ",
+        "BriefDescription": "Direct and indirect near call instructions retired.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Branch instructions at retirement.",
+        "PEBS": "1",
         "EventCode": "0xC4",
         "Counter": "0,1,2,3",
-        "UMask": "0x0",
-        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
+        "UMask": "0x2",
+        "EventName": "BR_INST_RETIRED.NEAR_CALL_R3",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Direct and indirect macro near call instructions retired (captured in ring 3).",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "PEBS": "2",
+        "EventCode": "0xC4",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "EventName": "BR_INST_RETIRED.ALL_BRANCHES_PEBS",
         "SampleAfterValue": "400009",
         "BriefDescription": "All (macro) branch instructions retired.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "CounterHTOff": "0,1,2,3"
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Counts the number of near return instructions retired.",
         "EventCode": "0xC4",
         "Counter": "0,1,2,3",
         "UMask": "0x8",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Return instructions retired. ",
+        "BriefDescription": "Return instructions retired.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -933,18 +1223,17 @@
         "UMask": "0x10",
         "EventName": "BR_INST_RETIRED.NOT_TAKEN",
         "SampleAfterValue": "400009",
-        "BriefDescription": "Not taken branch instructions retired. ",
+        "BriefDescription": "Not taken branch instructions retired.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Number of near taken branches retired.",
         "EventCode": "0xC4",
         "Counter": "0,1,2,3",
         "UMask": "0x20",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
         "SampleAfterValue": "400009",
-        "BriefDescription": "Taken branch instructions retired. ",
+        "BriefDescription": "Taken branch instructions retired.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -954,28 +1243,7 @@
         "UMask": "0x40",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Far branch instructions retired. ",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PEBS": "2",
-        "EventCode": "0xC4",
-        "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "BR_INST_RETIRED.ALL_BRANCHES_PEBS",
-        "SampleAfterValue": "400009",
-        "BriefDescription": "All (macro) branch instructions retired.",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "PEBS": "1",
-        "PublicDescription": "Mispredicted conditional branch instructions retired.",
-        "EventCode": "0xC5",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "BR_MISP_RETIRED.CONDITIONAL",
-        "SampleAfterValue": "400009",
-        "BriefDescription": "Mispredicted conditional branch instructions retired. ",
+        "BriefDescription": "Far branch instructions retired.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -990,13 +1258,12 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Mispredicted taken branch instructions retired.",
         "EventCode": "0xC5",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
-        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
+        "UMask": "0x1",
+        "EventName": "BR_MISP_RETIRED.CONDITIONAL",
         "SampleAfterValue": "400009",
-        "BriefDescription": "number of near branch instructions retired that were mispredicted and taken. ",
+        "BriefDescription": "Mispredicted conditional branch instructions retired.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -1009,6 +1276,16 @@
         "BriefDescription": "Mispredicted macro branch instructions retired.",
         "CounterHTOff": "0,1,2,3"
     },
+    {
+        "PEBS": "1",
+        "EventCode": "0xC5",
+        "Counter": "0,1,2,3",
+        "UMask": "0x20",
+        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "number of near branch instructions retired that were mispredicted and taken.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "PublicDescription": "Count cases of saving new LBR records by hardware.",
         "EventCode": "0xCC",
@@ -1028,280 +1305,5 @@
         "SampleAfterValue": "100003",
         "BriefDescription": "Counts the total number when the front end is resteered, mainly when the BPU cannot provide a correct prediction and this is corrected by other branch handling mechanisms at the front end.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Cycles where at least 1 uop was executed per-thread.",
-        "EventCode": "0xB1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles where at least 1 uop was executed per-thread",
-        "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Cycles where at least 2 uops were executed per-thread.",
-        "EventCode": "0xB1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles where at least 2 uops were executed per-thread",
-        "CounterMask": "2",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Cycles where at least 3 uops were executed per-thread.",
-        "EventCode": "0xB1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles where at least 3 uops were executed per-thread",
-        "CounterMask": "3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Cycles where at least 4 uops were executed per-thread.",
-        "EventCode": "0xB1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "UOPS_EXECUTED.CYCLES_GE_4_UOPS_EXEC",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles where at least 4 uops were executed per-thread",
-        "CounterMask": "4",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0x5E",
-        "Invert": "1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EdgeDetect": "1",
-        "EventName": "RS_EVENTS.EMPTY_END",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Counts end of periods where the Reservation Station (RS) was empty. Could be useful to precisely locate Frontend Latency Bound issues.",
-        "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0xC3",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EdgeDetect": "1",
-        "EventName": "MACHINE_CLEARS.COUNT",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Number of machine clears (nukes) of any type.",
-        "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Cycles 4 Uops delivered by the LSD, but didn't come from the decoder.",
-        "EventCode": "0xA8",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "LSD.CYCLES_4_UOPS",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles 4 Uops delivered by the LSD, but didn't come from the decoder",
-        "CounterMask": "4",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0xA3",
-        "Counter": "2",
-        "UMask": "0x8",
-        "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles while L1 cache miss demand load is outstanding.",
-        "CounterMask": "8",
-        "CounterHTOff": "2"
-    },
-    {
-        "EventCode": "0xA3",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles while L2 cache miss load* is outstanding.",
-        "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0xA3",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles while memory subsystem has an outstanding load.",
-        "CounterMask": "2",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xA3",
-        "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Total execution stalls.",
-        "CounterMask": "4",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xA3",
-        "Counter": "2",
-        "UMask": "0xc",
-        "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Execution stalls while L1 cache miss demand load is outstanding.",
-        "CounterMask": "12",
-        "CounterHTOff": "2"
-    },
-    {
-        "EventCode": "0xA3",
-        "Counter": "0,1,2,3",
-        "UMask": "0x5",
-        "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Execution stalls while L2 cache miss load* is outstanding.",
-        "CounterMask": "5",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0xA3",
-        "Counter": "0,1,2,3",
-        "UMask": "0x6",
-        "EventName": "CYCLE_ACTIVITY.STALLS_MEM_ANY",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Execution stalls while memory subsystem has an outstanding load.",
-        "CounterMask": "6",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "PublicDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
-        "EventCode": "0x00",
-        "Counter": "Fixed counter 2",
-        "UMask": "0x2",
-        "AnyThread": "1",
-        "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state",
-        "CounterHTOff": "Fixed counter 2"
-    },
-    {
-        "PublicDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
-        "EventCode": "0x3C",
-        "Counter": "0,1,2,3",
-        "UMask": "0x0",
-        "AnyThread": "1",
-        "EventName": "CPU_CLK_UNHALTED.THREAD_P_ANY",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0x3C",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "AnyThread": "1",
-        "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Reference cycles when the at least one thread on the physical core is unhalted. (counts at 100 MHz rate)",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0x0D",
-        "Counter": "0,1,2,3",
-        "UMask": "0x3",
-        "AnyThread": "1",
-        "EventName": "INT_MISC.RECOVERY_CYCLES_ANY",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Core cycles the allocator was stalled due to recovery from earlier clear event for any thread running on the physical core (e.g. misprediction or memory nuke).",
-        "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Cycles at least 1 micro-op is executed from any thread on physical core.",
-        "EventCode": "0xB1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles at least 1 micro-op is executed from any thread on physical core",
-        "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Cycles at least 2 micro-op is executed from any thread on physical core.",
-        "EventCode": "0xB1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles at least 2 micro-op is executed from any thread on physical core",
-        "CounterMask": "2",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Cycles at least 3 micro-op is executed from any thread on physical core.",
-        "EventCode": "0xB1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles at least 3 micro-op is executed from any thread on physical core",
-        "CounterMask": "3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Cycles at least 4 micro-op is executed from any thread on physical core.",
-        "EventCode": "0xB1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles at least 4 micro-op is executed from any thread on physical core",
-        "CounterMask": "4",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Cycles with no micro-ops executed from any thread on physical core.",
-        "EventCode": "0xB1",
-        "Invert": "1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "UOPS_EXECUTED.CORE_CYCLES_NONE",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles with no micro-ops executed from any thread on physical core",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Reference cycles when the thread is unhalted. (counts at 100 MHz rate)",
-        "EventCode": "0x3C",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "CPU_CLK_UNHALTED.REF_XCLK",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Reference cycles when the thread is unhalted (counts at 100 MHz rate)",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0x3C",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "AnyThread": "1",
-        "EventName": "CPU_CLK_UNHALTED.REF_XCLK_ANY",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Reference cycles when the at least one thread on the physical core is unhalted. (counts at 100 MHz rate)",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0x3C",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Count XClk pulses when this thread is unhalted and the other thread is halted.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json b/tools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json
index c8de548b78fa..4645e9d3f460 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json
@@ -1,4 +1,14 @@
 [
+    {
+        "PublicDescription": "Misses in all TLB levels that cause a page walk of any page size from demand loads.",
+        "EventCode": "0x08",
+        "Counter": "0,1,2,3",
+        "UMask": "0x81",
+        "EventName": "DTLB_LOAD_MISSES.MISS_CAUSES_A_WALK",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Demand load Miss in all translation lookaside buffer (TLB) levels causes an page walk of any page size.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "EventCode": "0x08",
         "Counter": "0,1,2,3",
@@ -8,6 +18,16 @@
         "BriefDescription": "Demand load Miss in all translation lookaside buffer (TLB) levels causes a page walk that completes of any page size.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "PublicDescription": "Misses in all TLB levels that caused page walk completed of any size by demand loads.",
+        "EventCode": "0x08",
+        "Counter": "0,1,2,3",
+        "UMask": "0x82",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Demand load Miss in all translation lookaside buffer (TLB) levels causes a page walk that completes of any page size.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "EventCode": "0x08",
         "Counter": "0,1,2,3",
@@ -17,6 +37,16 @@
         "BriefDescription": "Demand load cycles page miss handler (PMH) is busy with this walk.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "PublicDescription": "Cycle PMH is busy with a walk due to demand loads.",
+        "EventCode": "0x08",
+        "Counter": "0,1,2,3",
+        "UMask": "0x84",
+        "EventName": "DTLB_LOAD_MISSES.WALK_DURATION",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Demand load cycles page miss handler (PMH) is busy with this walk.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "EventCode": "0x08",
         "Counter": "0,1,2,3",
@@ -164,35 +194,5 @@
         "SampleAfterValue": "100007",
         "BriefDescription": "STLB flush attempts",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Misses in all TLB levels that cause a page walk of any page size from demand loads.",
-        "EventCode": "0x08",
-        "Counter": "0,1,2,3",
-        "UMask": "0x81",
-        "EventName": "DTLB_LOAD_MISSES.MISS_CAUSES_A_WALK",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Demand load Miss in all translation lookaside buffer (TLB) levels causes an page walk of any page size.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Misses in all TLB levels that caused page walk completed of any size by demand loads.",
-        "EventCode": "0x08",
-        "Counter": "0,1,2,3",
-        "UMask": "0x82",
-        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Demand load Miss in all translation lookaside buffer (TLB) levels causes a page walk that completes of any page size.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "Cycle PMH is busy with a walk due to demand loads.",
-        "EventCode": "0x08",
-        "Counter": "0,1,2,3",
-        "UMask": "0x84",
-        "EventName": "DTLB_LOAD_MISSES.WALK_DURATION",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Demand load cycles page miss handler (PMH) is busy with this walk.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
     }
 ]
\ No newline at end of file
-- 
2.14.3
