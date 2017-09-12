From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/41] perf vendor events: Add JSON metrics for Skylake
Date: Tue, 12 Sep 2017 12:10:20 -0300
Message-ID: <20170912151029.6612-33-acme@kernel.org>
References: <20170912151029.6612-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912151029.6612-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add JSON metrics for Skylake.

Committer testing:

  # grep "model name" /proc/cpuinfo | head -1
  model name	: Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz
  # uname -a
  Linux seventh 4.12.0-rc6+ #1 SMP Fri Jun 30 16:40:55 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
  # perf stat --metric-only -M Summary -a sleep 1

   Performance counter stats for 'system wide':

  Instructions         CPI                  CLKS                 CPU_Utilization      GFLOPs               SMT_2T_Utilization   Kernel_Utilization
  34021097.0               0.0            119424171.0              0.0                 0.0                 0.0                 0.0

         1.001001793 seconds time elapsed

  # perf list metricgroup

  List of pre-defined events (to be used in -e):

  Metric Groups:

  DSB
  FLOPS
  Frontend
  Frontend_Bandwidth
  Memory_BW
  Memory_Bound
  Memory_Lat
  Pipeline
  Ports_Utilization
  Power
  SMT
  Summary
  TLB
  TopDownL1
  Unknown_Branches
  # perf stat --metric-only -M Ports_Utilization -a sleep 1

   Performance counter stats for 'system wide':

  ILP
  1475828.0

       1.000688547 seconds time elapsed

  # perf stat -v --metric-only -M Ports_Utilization -a sleep 1
  Using CPUID GenuineIntel-6-9E
  metric expr uops_executed.thread / ( uops_executed.core_cycles_ge_1 / 2) if #smt_on else uops_executed.core_cycles_ge_1 for ILP
  found event uops_executed.thread
  found event uops_executed.core_cycles_ge_1
  adding {uops_executed.thread,uops_executed.core_cycles_ge_1}:W
  uops_executed.thread -> cpu/umask=0x1,period=2000003,event=0xb1/
  uops_executed.core_cycles_ge_1 -> cpu/umask=0x2,period=2000003,cmask=1,event=0xb1/
  uops_executed.thread: 8115271 4002547654 4002547654
  uops_executed.core_cycles_ge_1: 3282969 4002547654 4002547654

   Performance counter stats for 'system wide':

  ILP
  3282969.0

         1.000719870 seconds time elapsed

  #

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20170905195235.GW2482@two.firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../pmu-events/arch/x86/skylake/skl-metrics.json   | 164 +++++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json

diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
new file mode 100644
index 000000000000..411f9411ec9e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -0,0 +1,164 @@
+[
+    {
+        "BriefDescription": "Instructions Per Cycle (per logical thread)",
+        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "TopDownL1",
+        "MetricName": "IPC"
+    },
+    {
+        "BriefDescription": "Uops Per Instruction",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
+        "MetricGroup": "Pipeline",
+        "MetricName": "UPI"
+    },
+    {
+        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely consumed by program instructions",
+        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY * 64 * ( ICACHE_64B.IFTAG_HIT + ICACHE_64B.IFTAG_MISS ) / 4.1) )",
+        "MetricGroup": "Frontend",
+        "MetricName": "IFetch_Line_Utilization"
+    },
+    {
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)",
+        "MetricExpr": "IDQ.DSB_UOPS / ( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS )",
+        "MetricGroup": "DSB; Frontend_Bandwidth",
+        "MetricName": "DSB_Coverage"
+    },
+    {
+        "BriefDescription": "Cycles Per Instruction (threaded)",
+        "MetricExpr": "1 / INST_RETIRED.ANY / cycles",
+        "MetricGroup": "Pipeline;Summary",
+        "MetricName": "CPI"
+    },
+    {
+        "BriefDescription": "Per-thread actual clocks when the logical processor is active. This is called 'Clockticks' in VTune.",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "Summary",
+        "MetricName": "CLKS"
+    },
+    {
+        "BriefDescription": "Total issue-pipeline slots",
+        "MetricExpr": "4*( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles",
+        "MetricGroup": "TopDownL1",
+        "MetricName": "SLOTS"
+    },
+    {
+        "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "INST_RETIRED.ANY",
+        "MetricGroup": "Summary",
+        "MetricName": "Instructions"
+    },
+    {
+        "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles",
+        "MetricGroup": "SMT",
+        "MetricName": "CoreIPC"
+    },
+    {
+        "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / ( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1",
+        "MetricGroup": "Pipeline;Ports_Utilization",
+        "MetricName": "ILP"
+    },
+    {
+        "BriefDescription": "Average Branch Address Clear Cost (fraction of cycles)",
+        "MetricExpr": "2* ( RS_EVENTS.EMPTY_CYCLES - ICACHE_16B.IFDATA_STALL  - ICACHE_64B.IFTAG_STALL ) / RS_EVENTS.EMPTY_END",
+        "MetricGroup": "Unknown_Branches",
+        "MetricName": "BAClear_Cost"
+    },
+    {
+        "BriefDescription": "Core actual clocks when any thread is active on the physical core",
+        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CPU_CLK_UNHALTED.THREAD",
+        "MetricGroup": "SMT",
+        "MetricName": "CORE_CLKS"
+    },
+    {
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads",
+	"MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
+        "MetricGroup": "Memory_Bound;Memory_Lat",
+        "MetricName": "Load_Miss_Real_Latency"
+    },
+    {
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least 1 such miss)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / ( L1D_PEND_MISS.PENDING_CYCLES_ANY / 2) if #SMT_on else L1D_PEND_MISS.PENDING_CYCLES",
+        "MetricGroup": "Memory_Bound;Memory_BW",
+        "MetricName": "MLP"
+    },
+    {
+        "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles )",
+        "MetricGroup": "TLB",
+        "MetricName": "Page_Walks_Utilization"
+    },
+    {
+        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "MetricGroup": "Summary",
+        "MetricName": "CPU_Utilization"
+    },
+    {
+        "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "( 1*( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2* FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4*( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8* FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE ) / 1000000000 / duration_time",
+        "MetricGroup": "FLOPS;Summary",
+        "MetricName": "GFLOPs"
+    },
+    {
+        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricGroup": "Power",
+        "MetricName": "Turbo_Utilization"
+    },
+    {
+        "BriefDescription": "Fraction of cycles where both hardware threads were active",
+        "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
+        "MetricGroup": "SMT;Summary",
+        "MetricName": "SMT_2T_Utilization"
+    },
+    {
+        "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricGroup": "Summary",
+        "MetricName": "Kernel_Utilization"
+    },
+    {
+        "BriefDescription": "C3 residency percent per core",
+        "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C3_Core_Residency"
+    },
+    {
+        "BriefDescription": "C6 residency percent per core",
+        "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Core_Residency"
+    },
+    {
+        "BriefDescription": "C7 residency percent per core",
+        "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C7_Core_Residency"
+    },
+    {
+        "BriefDescription": "C2 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C2_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "C3 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C3_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "C6 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "C7 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C7_Pkg_Residency"
+    }
+]
-- 
2.13.5
