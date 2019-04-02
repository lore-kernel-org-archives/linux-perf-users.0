From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 36/44] perf vendor events intel: Update JakeTown events to v20
Date: Tue,  2 Apr 2019 13:05:41 -0300
Message-ID: <20190402160549.13544-37-acme@kernel.org>
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
 tools/perf/pmu-events/arch/x86/jaketown/cache.json   |  6 +++---
 .../perf/pmu-events/arch/x86/jaketown/pipeline.json  | 12 ++++--------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/jaketown/cache.json b/tools/perf/pmu-events/arch/x86/jaketown/cache.json
index ee22e4a5e30d..52dc6ef40e63 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/cache.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/cache.json
@@ -31,7 +31,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "This event counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This event counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "EventCode": "0xD0",
         "Counter": "0,1,2,3",
         "UMask": "0x41",
@@ -42,7 +42,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "This event counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This event counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "EventCode": "0xD0",
         "Counter": "0,1,2,3",
         "UMask": "0x42",
@@ -179,7 +179,7 @@
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "This event counts L1D data line replacements.  Replacements occur when a new line is brought into the cache, causing eviction of a line loaded earlier.  ",
+        "PublicDescription": "This event counts L1D data line replacements.  Replacements occur when a new line is brought into the cache, causing eviction of a line loaded earlier.",
         "EventCode": "0x51",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
index 34a519d9bfa0..783a5b4a67b1 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
@@ -1,7 +1,6 @@
 [
     {
-        "PublicDescription": "This event counts the number of instructions retired from execution. For instructions that consist of multiple micro-ops, this event counts the retirement of the last micro-op of the instruction. Counting continues during hardware interrupts, traps, and inside interrupt handlers. ",
-        "EventCode": "0x00",
+        "PublicDescription": "This event counts the number of instructions retired from execution. For instructions that consist of multiple micro-ops, this event counts the retirement of the last micro-op of the instruction. Counting continues during hardware interrupts, traps, and inside interrupt handlers.",
         "Counter": "Fixed counter 1",
         "UMask": "0x1",
         "EventName": "INST_RETIRED.ANY",
@@ -10,8 +9,7 @@
         "CounterHTOff": "Fixed counter 1"
     },
     {
-        "PublicDescription": "This event counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events. ",
-        "EventCode": "0x00",
+        "PublicDescription": "This event counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events.",
         "Counter": "Fixed counter 2",
         "UMask": "0x2",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
@@ -20,8 +18,7 @@
         "CounterHTOff": "Fixed counter 2"
     },
     {
-        "PublicDescription": "This event counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events. ",
-        "EventCode": "0x00",
+        "PublicDescription": "This event counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events.",
         "Counter": "Fixed counter 3",
         "UMask": "0x3",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
@@ -778,7 +775,7 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts loads that followed a store to the same address, where the data could not be forwarded inside the pipeline from the store to the load.  The most common reason why store forwarding would be blocked is when a load's address range overlaps with a preceding smaller uncompleted store.  See the table of not supported store forwards in the Intel? 64 and IA-32 Architectures Optimization Reference Manual.  The penalty for blocked store forwarding is that the load must wait for the store to complete before it can be issued.",
+        "PublicDescription": "This event counts loads that followed a store to the same address, where the data could not be forwarded inside the pipeline from the store to the load.  The most common reason why store forwarding would be blocked is when a load's address range overlaps with a preceeding smaller uncompleted store.  See the table of not supported store forwards in the Intel? 64 and IA-32 Architectures Optimization Reference Manual.  The penalty for blocked store forwarding is that the load must wait for the store to complete before it can be issued.",
         "EventCode": "0x03",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
@@ -1098,7 +1095,6 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x00",
         "Counter": "Fixed counter 2",
         "UMask": "0x2",
         "AnyThread": "1",
-- 
2.20.1
