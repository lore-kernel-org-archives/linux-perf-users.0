From: Vijay Thakkar <vijaythakkar@me.com>
Subject: [PATCH 3/3] perf vendor events amd: update Zen1 events to V2
Date: Fri, 27 Dec 2019 07:55:36 -0500
Message-ID: <20191227125536.1091387-4-vijaythakkar@me.com>
References: <20191227125536.1091387-1-vijaythakkar@me.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191227125536.1091387-1-vijaythakkar@me.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Vijay Thakkar <vijaythakkar@me.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Kim Phillips <kim.phillips@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

This patch updates the PMCs for AMD Zen1 core based processors (Family
17h; Models 01, 08, 10 and 18) to be in accordance with PMCs as
documented in the latest versions of the AMD Processor Programming
Reference [1] and [2].

PMCs added:
fpu_pipe_assignment.dual{0|1|2|3}
fpu_pipe_assignment.total{0|1|2|3}
ls_mab_alloc.dc_prefetcher
ls_mab_alloc.stores
ls_mab_alloc.loads

PMC removed:
ex_ret_cond_misp

Cumulative counts, fpu_pipe_assignment.total and
fpu_pipe_assignment.dual, existed in v1, but did expose port-level
counters.

ex_ret_cond_misp has been removed as it has been removed from the latest
versions of the PPR, and when tested, always seems to sample zero as
tested on a Ryzen 3400G system.

[1]: Processor Programming Reference (PPR) for AMD Family 17h Models
01h,08h, Revision B2 Processors, 54945 Rev 3.03 - Jun 14, 2019.
[2]: Processor Programming Reference (PPR) for AMD Family 17h Model 18h,
Revision B1 Processors, 55570-B1 Rev 3.14 - Sep 26, 2019.

Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>
---
 .../pmu-events/arch/x86/amdzen1/core.json     |  5 --
 .../arch/x86/amdzen1/floating-point.json      | 56 +++++++++++++++++++
 .../pmu-events/arch/x86/amdzen1/memory.json   | 18 ++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 4 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/core.json b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
index 1079544eeed5..38994fb4b625 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/core.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
@@ -90,11 +90,6 @@
     "EventCode": "0xd1",
     "BriefDescription": "Retired Conditional Branch Instructions."
   },
-  {
-    "EventName": "ex_ret_cond_misp",
-    "EventCode": "0xd2",
-    "BriefDescription": "Retired Conditional Branch Instructions Mispredicted."
-  },
   {
     "EventName": "ex_div_busy",
     "EventCode": "0xd3",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
index ea4711983d1d..878c1adcf91c 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
@@ -6,6 +6,34 @@
     "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
     "UMask": "0xf0"
   },
+  {
+    "EventName": "fpu_pipe_assignment.dual3",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number multi-pipe uOps to pipe 3.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.dual2",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number multi-pipe uOps to pipe 2.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.dual1",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number multi-pipe uOps to pipe 1.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.dual0",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number multi-pipe uOps to pipe 0.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
+    "UMask": "0x1"
+  },
   {
     "EventName": "fpu_pipe_assignment.total",
     "EventCode": "0x00",
@@ -13,6 +41,34 @@
     "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to Pipe 3.",
     "UMask": "0xf"
   },
+  {
+    "EventName": "fpu_pipe_assignment.total3",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps on pipe 3.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total2",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps on pipe 2.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total1",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps on pipe 1.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total0",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps  on pipe 0.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",
+    "UMask": "0x1"
+  },
   {
     "EventName": "fp_sched_empty",
     "EventCode": "0x01",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/memory.json b/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
index fa2d60d4def0..def2acf3c8d9 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
@@ -37,6 +37,24 @@
     "EventCode": "0x40",
     "BriefDescription": "The number of accesses to the data cache for load and store references. This may include certain microcode scratchpad accesses, although these are generally rare. Each increment represents an eight-byte access, although the instruction may only be accessing a portion of that. This event is a speculative event."
   },
+  {
+    "EventName": "ls_mab_alloc.dc_prefetcher",
+    "EventCode": "0x41",
+    "BriefDescription": "Data cache prefetcher miss.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_mab_alloc.stores",
+    "EventCode": "0x41",
+    "BriefDescription": "Data cache store miss.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_mab_alloc.loads",
+    "EventCode": "0x41",
+    "BriefDescription": "Data cache load miss.",
+    "UMask": "0x40"
+  },
   {
     "EventName": "ls_l1_d_tlb_miss.all",
     "EventCode": "0x45",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 82b573956e96..54a8dbdd2fe4 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -36,6 +36,6 @@ GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
 GenuineIntel-6-7D,v1,icelake,core
 GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-86,v1,tremontx,core
-AuthenticAMD-23-[01][18],v1,amdzen1,core
+AuthenticAMD-23-[01][18],v2,amdzen1,core
 AuthenticAMD-23-[37]1,v1,amdzen2,core
 AuthenticAMD-23-2[0123456789ABCDEF],v1,amdzen2,core
-- 
2.24.1
