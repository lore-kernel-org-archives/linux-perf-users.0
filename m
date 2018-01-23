From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/43] perf vendor events intel: Update IvyBridge files to V20
Date: Tue, 23 Jan 2018 10:12:34 -0300
Message-ID: <20180123131251.28197-27-acme@kernel.org>
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
 .../perf/pmu-events/arch/x86/ivybridge/cache.json  | 324 +++++++++++++++++++++
 .../perf/pmu-events/arch/x86/ivybridge/memory.json |  72 +++++
 2 files changed, 396 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/cache.json b/tools/perf/pmu-events/arch/x86/ivybridge/cache.json
index 3c0a28e27d73..999a01bc6467 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/cache.json
@@ -774,5 +774,329 @@
         "SampleAfterValue": "100003",
         "BriefDescription": "Split locks in SQ",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3f803c0244",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_HIT.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand & prefetch code reads that hit in the LLC",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1003c0244",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_HIT.NO_SNOOP_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand & prefetch code reads that hit in the LLC and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3f803c0091",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_HIT.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand & prefetch data reads that hit in the LLC",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x4003c0091",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand & prefetch data reads that hit in the LLC and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x10003c0091",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_HIT.HITM_OTHER_CORE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand & prefetch data reads that hit in the LLC and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1003c0091",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_HIT.NO_SNOOP_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand & prefetch data reads that hit in the LLC and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3f803c0122",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.ALL_RFO.LLC_HIT.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand & prefetch RFOs that hit in the LLC",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1003c0122",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.ALL_RFO.LLC_HIT.NO_SNOOP_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand & prefetch RFOs that hit in the LLC and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x10008",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.COREWB.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all writebacks from the core to the LLC",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3f803c0004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_HIT.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand code reads that hit in the LLC",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1003c0004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_HIT.NO_SNOOP_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand code reads that hit in the LLC and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3f803c0001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data reads that hit in the LLC",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x4003c0001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads that hit in the LLC and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x10003c0001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT.HITM_OTHER_CORE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads that hit in the LLC and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1003c0001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT.NO_SNOOP_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads that hit in the LLC and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3f803c0002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs) that hit in the LLC",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x10003c0002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.HITM_OTHER_CORE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data writes (RFOs) that hit in the LLC and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1003c0002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.NO_SNOOP_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data writes (RFOs) that hit in the LLC and sibling core snoops are not needed as either the core-valid bit is not set or the shared line is present in multiple cores",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x18000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts miscellaneous accesses that include port i/o, MMIO and uncacheable memory accesses. It also includes L2 hints sent to LLC to keep a line from being evicted out of the core caches",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x10400",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.SPLIT_LOCK_UC_LOCK.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts requests where the address of an atomic lock instruction spans a cache line boundary or the lock instruction is executed on uncacheable address ",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x10800",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts non-temporal stores",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x00010001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data reads ",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x00010002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand rfo's ",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x00010004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand code reads",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x000105B3",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand & prefetch data reads",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x00010122",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.ALL_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand & prefetch prefetch RFOs ",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x000107F7",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.ALL_READS.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all data/code/rfo references (demand & prefetch) ",
+        "CounterHTOff": "0,1,2,3"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/memory.json b/tools/perf/pmu-events/arch/x86/ivybridge/memory.json
index 6005b364c580..a74d54f56192 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/memory.json
@@ -160,5 +160,77 @@
         "PRECISE_STORE": "1",
         "TakenAlone": "1",
         "CounterHTOff": "3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x300400244",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_MISS.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand & prefetch code reads that miss the LLC  and the data returned from dram",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x300400091",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_MISS.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand & prefetch data reads that miss the LLC  and the data returned from dram",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3004003f7",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the LLC  and the data returned from dram",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x300400004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_MISS.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand code reads that miss the LLC and the data returned from dram",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x300400001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_MISS.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads that miss the LLC and the data returned from dram",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x6004001b3",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "Offcore": "1",
+        "EventName": "OFFCORE_RESPONSE.DATA_IN_SOCKET.LLC_MISS.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts LLC replacements",
+        "CounterHTOff": "0,1,2,3"
     }
 ]
\ No newline at end of file
-- 
2.14.3
