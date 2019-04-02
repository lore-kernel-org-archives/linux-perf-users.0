From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 38/44] perf vendor events intel: Update IvyBridge events to v21
Date: Tue,  2 Apr 2019 13:05:43 -0300
Message-ID: <20190402160549.13544-39-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: https://lkml.kernel.org/r/20190315165219.GA21223@tassilo.jf.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/ivybridge/cache.json    | 10 +++++-----
 tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json |  4 ----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/cache.json b/tools/perf/pmu-events/arch/x86/ivybridge/cache.json
index 999a01bc6467..5f6cb2abc384 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/cache.json
@@ -1012,7 +1012,7 @@
         "EventName": "OFFCORE_RESPONSE.SPLIT_LOCK_UC_LOCK.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts requests where the address of an atomic lock instruction spans a cache line boundary or the lock instruction is executed on uncacheable address ",
+        "BriefDescription": "Counts requests where the address of an atomic lock instruction spans a cache line boundary or the lock instruction is executed on uncacheable address",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -1036,7 +1036,7 @@
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand data reads ",
+        "BriefDescription": "Counts all demand data reads",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -1048,7 +1048,7 @@
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand rfo's ",
+        "BriefDescription": "Counts all demand rfo's",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -1084,7 +1084,7 @@
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch prefetch RFOs ",
+        "BriefDescription": "Counts all demand & prefetch prefetch RFOs",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -1096,7 +1096,7 @@
         "EventName": "OFFCORE_RESPONSE.ALL_READS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all data/code/rfo references (demand & prefetch) ",
+        "BriefDescription": "Counts all data/code/rfo references (demand & prefetch)",
         "CounterHTOff": "0,1,2,3"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
index 0afbfd95ea30..2a0aad91d83d 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
@@ -1,6 +1,5 @@
 [
     {
-        "EventCode": "0x00",
         "Counter": "Fixed counter 0",
         "UMask": "0x1",
         "EventName": "INST_RETIRED.ANY",
@@ -9,7 +8,6 @@
         "CounterHTOff": "Fixed counter 0"
     },
     {
-        "EventCode": "0x00",
         "Counter": "Fixed counter 1",
         "UMask": "0x2",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
@@ -19,7 +17,6 @@
     },
     {
         "PublicDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 1",
         "UMask": "0x2",
         "AnyThread": "1",
@@ -29,7 +26,6 @@
         "CounterHTOff": "Fixed counter 1"
     },
     {
-        "EventCode": "0x00",
         "Counter": "Fixed counter 2",
         "UMask": "0x3",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
-- 
2.20.1
