From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/24] perf vendor events amd: Update Zen1 events to V2
Date: Wed, 25 Mar 2020 09:41:13 -0300
Message-ID: <20200325124124.32648-14-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Vijay Thakkar <vijaythakkar@me.com>, Kim Phillips <kim.phillips@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Jon Grimm <jon.grimm@amd.com>, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Vijay Thakkar <vijaythakkar@me.com>

This patch updates the PMCs for AMD Zen1 core based processors (Family
17h; Models 0 through 2F) to be in accordance with PMCs as
documented in the latest versions of the AMD Processor Programming
Reference [1], [2] and [3]. Note that some events, such as FPU pipe
assignment are missing in [1], and therefore [3] is included for full
coverage of events.

PMCs added:

  fpu_pipe_assignment.dual{0|1|2|3}
  fpu_pipe_assignment.total{0|1|2|3}
  ls_mab_alloc.dc_prefetcher
  ls_mab_alloc.stores
  ls_mab_alloc.loads
  bp_dyn_ind_pred
  bp_de_redirect

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

[3]: OSRR for AMD Family 17h processors, Models 00h-2Fh, 56255 Rev 3.03 - July, 2018

All of the PPRs can be found at:
https://bugzilla.kernel.org/show_bug.cgi?id=206537

Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>
Acked-by: Kim Phillips <kim.phillips@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Jon Grimm <jon.grimm@amd.com>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: vijay thakkar <vijaythakkar@me.com>
Link: http://lore.kernel.org/lkml/20200318190002.307290-4-vijaythakkar@me.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../pmu-events/arch/x86/amdzen1/branch.json   |  11 ++
 .../pmu-events/arch/x86/amdzen1/cache.json    | 107 ++++++------------
 .../pmu-events/arch/x86/amdzen1/core.json     |  15 +--
 .../arch/x86/amdzen1/floating-point.json      |  64 ++++++++++-
 .../pmu-events/arch/x86/amdzen1/memory.json   |  82 +++++++++-----
 .../pmu-events/arch/x86/amdzen1/other.json    |  27 ++---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 7 files changed, 172 insertions(+), 136 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/branch.json b/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
index 93ddfd8053ca..a9943eeb8d6b 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
@@ -8,5 +8,16 @@
     "EventName": "bp_l2_btb_correct",
     "EventCode": "0x8b",
     "BriefDescription": "L2 BTB Correction."
+  },
+  {
+    "EventName": "bp_dyn_ind_pred",
+    "EventCode": "0x8e",
+    "BriefDescription": "Dynamic Indirect Predictions.",
+    "PublicDescription": "Indirect Branch Prediction for potential multi-target branch (speculative)."
+  },
+  {
+    "EventName": "bp_de_redirect",
+    "EventCode": "0x91",
+    "BriefDescription": "Decoder Overrides Existing Branch Prediction (speculative)."
   }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/cache.json b/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
index 6221a840fcea..404d4c569c01 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
@@ -37,36 +37,31 @@
   {
     "EventName": "ic_fetch_stall.ic_stall_any",
     "EventCode": "0x87",
-    "BriefDescription": "IC pipe was stalled during this clock cycle for any reason (nothing valid in pipe ICM1).",
-    "PublicDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle for any reason (nothing valid in pipe ICM1).",
+    "BriefDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle for any reason (nothing valid in pipe ICM1).",
     "UMask": "0x4"
   },
   {
     "EventName": "ic_fetch_stall.ic_stall_dq_empty",
     "EventCode": "0x87",
-    "BriefDescription": "IC pipe was stalled during this clock cycle (including IC to OC fetches) due to DQ empty.",
-    "PublicDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to DQ empty.",
+    "BriefDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to DQ empty.",
     "UMask": "0x2"
   },
   {
     "EventName": "ic_fetch_stall.ic_stall_back_pressure",
     "EventCode": "0x87",
-    "BriefDescription": "IC pipe was stalled during this clock cycle (including IC to OC fetches) due to back-pressure.",
-    "PublicDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to back-pressure.",
+    "BriefDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to back-pressure.",
     "UMask": "0x1"
   },
   {
     "EventName": "ic_cache_inval.l2_invalidating_probe",
     "EventCode": "0x8c",
-    "BriefDescription": "IC line invalidated due to L2 invalidating probe (external or LS).",
-    "PublicDescription": "The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core. IC line invalidated due to L2 invalidating probe (external or LS).",
+    "BriefDescription": "IC line invalidated due to L2 invalidating probe (external or LS). The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core.",
     "UMask": "0x2"
   },
   {
     "EventName": "ic_cache_inval.fill_invalidated",
     "EventCode": "0x8c",
-    "BriefDescription": "IC line invalidated due to overwriting fill response.",
-    "PublicDescription": "The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core. IC line invalidated due to overwriting fill response.",
+    "BriefDescription": "IC line invalidated due to overwriting fill response. The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core.",
     "UMask": "0x1"
   },
   {
@@ -77,211 +72,181 @@
   {
     "EventName": "l2_request_g1.rd_blk_l",
     "EventCode": "0x60",
-    "BriefDescription": "Requests to L2 Group1.",
-    "PublicDescription": "Requests to L2 Group1.",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Data cache reads (including hardware and software prefetch).",
     "UMask": "0x80"
   },
   {
     "EventName": "l2_request_g1.rd_blk_x",
     "EventCode": "0x60",
-    "BriefDescription": "Requests to L2 Group1.",
-    "PublicDescription": "Requests to L2 Group1.",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Data cache stores.",
     "UMask": "0x40"
   },
   {
     "EventName": "l2_request_g1.ls_rd_blk_c_s",
     "EventCode": "0x60",
-    "BriefDescription": "Requests to L2 Group1.",
-    "PublicDescription": "Requests to L2 Group1.",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Data cache shared reads.",
     "UMask": "0x20"
   },
   {
     "EventName": "l2_request_g1.cacheable_ic_read",
     "EventCode": "0x60",
-    "BriefDescription": "Requests to L2 Group1.",
-    "PublicDescription": "Requests to L2 Group1.",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Instruction cache reads.",
     "UMask": "0x10"
   },
   {
     "EventName": "l2_request_g1.change_to_x",
     "EventCode": "0x60",
-    "BriefDescription": "Requests to L2 Group1.",
-    "PublicDescription": "Requests to L2 Group1.",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Data cache state change requests. Request change to writable, check L2 for current state.",
     "UMask": "0x8"
   },
   {
-    "EventName": "l2_request_g1.prefetch_l2",
+    "EventName": "l2_request_g1.prefetch_l2_cmd",
     "EventCode": "0x60",
-    "BriefDescription": "Requests to L2 Group1.",
-    "PublicDescription": "Requests to L2 Group1.",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). PrefetchL2Cmd.",
     "UMask": "0x4"
   },
   {
     "EventName": "l2_request_g1.l2_hw_pf",
     "EventCode": "0x60",
-    "BriefDescription": "Requests to L2 Group1.",
-    "PublicDescription": "Requests to L2 Group1.",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). L2 Prefetcher. All prefetches accepted by L2 pipeline, hit or miss. Types of PF and L2 hit/miss broken out in a separate perfmon event.",
     "UMask": "0x2"
   },
   {
-    "EventName": "l2_request_g1.other_requests",
+    "EventName": "l2_request_g1.group2",
     "EventCode": "0x60",
-    "BriefDescription": "Events covered by l2_request_g2.",
-    "PublicDescription": "Requests to L2 Group1. Events covered by l2_request_g2.",
+    "BriefDescription": "Miscellaneous events covered in more detail by l2_request_g2 (PMCx061).",
     "UMask": "0x1"
   },
   {
     "EventName": "l2_request_g2.group1",
     "EventCode": "0x61",
-    "BriefDescription": "All Group 1 commands not in unit0.",
-    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous. All Group 1 commands not in unit0.",
+    "BriefDescription": "Miscellaneous events covered in more detail by l2_request_g1 (PMCx060).",
     "UMask": "0x80"
   },
   {
     "EventName": "l2_request_g2.ls_rd_sized",
     "EventCode": "0x61",
-    "BriefDescription": "RdSized, RdSized32, RdSized64.",
-    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous. RdSized, RdSized32, RdSized64.",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Data cache read sized.",
     "UMask": "0x40"
   },
   {
     "EventName": "l2_request_g2.ls_rd_sized_nc",
     "EventCode": "0x61",
-    "BriefDescription": "RdSizedNC, RdSized32NC, RdSized64NC.",
-    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous. RdSizedNC, RdSized32NC, RdSized64NC.",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Data cache read sized non-cacheable.",
     "UMask": "0x20"
   },
   {
     "EventName": "l2_request_g2.ic_rd_sized",
     "EventCode": "0x61",
-    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
-    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Instruction cache read sized.",
     "UMask": "0x10"
   },
   {
     "EventName": "l2_request_g2.ic_rd_sized_nc",
     "EventCode": "0x61",
-    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
-    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Instruction cache read sized non-cacheable.",
     "UMask": "0x8"
   },
   {
     "EventName": "l2_request_g2.smc_inval",
     "EventCode": "0x61",
-    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
-    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Self-modifying code invalidates.",
     "UMask": "0x4"
   },
   {
     "EventName": "l2_request_g2.bus_locks_originator",
     "EventCode": "0x61",
-    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
-    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Bus locks.",
     "UMask": "0x2"
   },
   {
     "EventName": "l2_request_g2.bus_locks_responses",
     "EventCode": "0x61",
-    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
-    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Bus lock response.",
     "UMask": "0x1"
   },
   {
     "EventName": "l2_latency.l2_cycles_waiting_on_fills",
     "EventCode": "0x62",
     "BriefDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",
-    "PublicDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",
     "UMask": "0x1"
   },
   {
     "EventName": "l2_wcb_req.wcb_write",
     "EventCode": "0x63",
-    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) write requests.",
-    "BriefDescription": "LS to L2 WCB write requests.",
+    "BriefDescription": "LS to L2 WCB write requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) write requests.",
     "UMask": "0x40"
   },
   {
     "EventName": "l2_wcb_req.wcb_close",
     "EventCode": "0x63",
-    "BriefDescription": "LS to L2 WCB close requests.",
-    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) close requests.",
+    "BriefDescription": "LS to L2 WCB close requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) close requests.",
     "UMask": "0x20"
   },
   {
     "EventName": "l2_wcb_req.zero_byte_store",
     "EventCode": "0x63",
-    "BriefDescription": "LS to L2 WCB zero byte store requests.",
-    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) zero byte store requests.",
+    "BriefDescription": "LS to L2 WCB zero byte store requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) zero byte store requests.",
     "UMask": "0x4"
   },
   {
     "EventName": "l2_wcb_req.cl_zero",
     "EventCode": "0x63",
-    "PublicDescription": "LS to L2 WCB cache line zeroing requests.",
-    "BriefDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) cache line zeroing requests.",
+    "BriefDescription": "LS to L2 WCB cache line zeroing requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) cache line zeroing requests.",
     "UMask": "0x1"
   },
   {
     "EventName": "l2_cache_req_stat.ls_rd_blk_cs",
     "EventCode": "0x64",
-    "BriefDescription": "LS ReadBlock C/S Hit.",
-    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LS ReadBlock C/S Hit.",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache shared read hit in L2",
     "UMask": "0x80"
   },
   {
     "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_x",
     "EventCode": "0x64",
-    "BriefDescription": "LS Read Block L Hit X.",
-    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LS Read Block L Hit X.",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache read hit in L2.",
     "UMask": "0x40"
   },
   {
     "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_s",
     "EventCode": "0x64",
-    "BriefDescription": "LsRdBlkL Hit Shared.",
-    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LsRdBlkL Hit Shared.",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache read hit on shared line in L2.",
     "UMask": "0x20"
   },
   {
     "EventName": "l2_cache_req_stat.ls_rd_blk_x",
     "EventCode": "0x64",
-    "BriefDescription": "LsRdBlkX/ChgToX Hit X.  Count RdBlkX finding Shared as a Miss.",
-    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LsRdBlkX/ChgToX Hit X.  Count RdBlkX finding Shared as a Miss.",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache store or state change hit in L2.",
     "UMask": "0x10"
   },
   {
     "EventName": "l2_cache_req_stat.ls_rd_blk_c",
     "EventCode": "0x64",
-    "BriefDescription": "LS Read Block C S L X Change to X Miss.",
-    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LS Read Block C S L X Change to X Miss.",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache request miss in L2 (all types).",
     "UMask": "0x8"
   },
   {
     "EventName": "l2_cache_req_stat.ic_fill_hit_x",
     "EventCode": "0x64",
-    "BriefDescription": "IC Fill Hit Exclusive Stale.",
-    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. IC Fill Hit Exclusive Stale.",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache hit modifiable line in L2.",
     "UMask": "0x4"
   },
   {
     "EventName": "l2_cache_req_stat.ic_fill_hit_s",
     "EventCode": "0x64",
-    "BriefDescription": "IC Fill Hit Shared.",
-    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. IC Fill Hit Shared.",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache hit clean line in L2.",
     "UMask": "0x2"
   },
   {
     "EventName": "l2_cache_req_stat.ic_fill_miss",
     "EventCode": "0x64",
-    "BriefDescription": "IC Fill Miss.",
-    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. IC Fill Miss.",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache request miss in L2.",
     "UMask": "0x1"
   },
   {
     "EventName": "l2_fill_pending.l2_fill_busy",
     "EventCode": "0x6d",
-    "BriefDescription": "Total cycles spent with one or more fill requests in flight from L2.",
-    "PublicDescription": "Total cycles spent with one or more fill requests in flight from L2.",
+    "BriefDescription": "Cycles with fill pending from L2. Total cycles spent with one or more fill requests in flight from L2.",
     "UMask": "0x1"
   },
   {
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/core.json b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
index 1079544eeed5..7e1aa8273935 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/core.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
@@ -62,7 +62,6 @@
     "EventName": "ex_ret_brn_ind_misp",
     "EventCode": "0xca",
     "BriefDescription": "Retired Indirect Branch Instructions Mispredicted.",
-    "PublicDescription": "Retired Indirect Branch Instructions Mispredicted."
   },
   {
     "EventName": "ex_ret_mmx_fp_instr.sse_instr",
@@ -90,11 +89,6 @@
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
@@ -108,22 +102,19 @@
   {
     "EventName": "ex_tagged_ibs_ops.ibs_count_rollover",
     "EventCode": "0x1cf",
-    "BriefDescription": "Number of times an op could not be tagged by IBS because of a previous tagged op that has not retired.",
-    "PublicDescription": "Tagged IBS Ops. Number of times an op could not be tagged by IBS because of a previous tagged op that has not retired.",
+    "BriefDescription": "Tagged IBS Ops. Number of times an op could not be tagged by IBS because of a previous tagged op that has not retired.",
     "UMask": "0x4"
   },
   {
     "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops_ret",
     "EventCode": "0x1cf",
-    "BriefDescription": "Number of Ops tagged by IBS that retired.",
-    "PublicDescription": "Tagged IBS Ops. Number of Ops tagged by IBS that retired.",
+    "BriefDescription": "Tagged IBS Ops. Number of Ops tagged by IBS that retired.",
     "UMask": "0x2"
   },
   {
     "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops",
     "EventCode": "0x1cf",
-    "BriefDescription": "Number of Ops tagged by IBS.",
-    "PublicDescription": "Tagged IBS Ops. Number of Ops tagged by IBS.",
+    "BriefDescription": "Tagged IBS Ops. Number of Ops tagged by IBS.",
     "UMask": "0x1"
   },
   {
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
index ea4711983d1d..a35542bd3b36 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
@@ -2,17 +2,73 @@
   {
     "EventName": "fpu_pipe_assignment.dual",
     "EventCode": "0x00",
-    "BriefDescription": "Total number multi-pipe uOps.",
-    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
+    "BriefDescription": "Total number multi-pipe uOps assigned to all pipes.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to all pipes.",
     "UMask": "0xf0"
   },
+  {
+    "EventName": "fpu_pipe_assignment.dual3",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number multi-pipe uOps assigned to pipe 3.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to pipe 3.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.dual2",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number multi-pipe uOps assigned to pipe 2.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to pipe 2.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.dual1",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number multi-pipe uOps assigned to pipe 1.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to pipe 1.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.dual0",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number multi-pipe uOps assigned to pipe 0.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to pipe 0.",
+    "UMask": "0x10"
+  },
   {
     "EventName": "fpu_pipe_assignment.total",
     "EventCode": "0x00",
-    "BriefDescription": "Total number uOps.",
-    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to Pipe 3.",
+    "BriefDescription": "Total number uOps assigned to all fpu pipes.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to all pipes.",
     "UMask": "0xf"
   },
+  {
+    "EventName": "fpu_pipe_assignment.total3",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps on pipe 3.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one-cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 3.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total2",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps on pipe 2.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 2.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total1",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps on pipe 1.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 1.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total0",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps  on pipe 0.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 0.",
+    "UMask": "0x1"
+  },
   {
     "EventName": "fp_sched_empty",
     "EventCode": "0x01",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/memory.json b/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
index fa2d60d4def0..b33a3c308019 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
@@ -3,28 +3,24 @@
     "EventName": "ls_locks.bus_lock",
     "EventCode": "0x25",
     "BriefDescription": "Bus lock when a locked operations crosses a cache boundary or is done on an uncacheable memory type.",
-    "PublicDescription": "Bus lock when a locked operations crosses a cache boundary or is done on an uncacheable memory type.",
     "UMask": "0x1"
   },
   {
     "EventName": "ls_dispatch.ld_st_dispatch",
     "EventCode": "0x29",
-    "BriefDescription": "Load-op-Stores.",
-    "PublicDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed. Load-op-Stores.",
+    "BriefDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed. Load-op-Stores.",
     "UMask": "0x4"
   },
   {
     "EventName": "ls_dispatch.store_dispatch",
     "EventCode": "0x29",
-    "BriefDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
-    "PublicDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "BriefDescription": "Counts the number of stores dispatched to the LS unit. Unit Masks ADDed.",
     "UMask": "0x2"
   },
   {
     "EventName": "ls_dispatch.ld_dispatch",
     "EventCode": "0x29",
-    "BriefDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
-    "PublicDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "BriefDescription": "Counts the number of loads dispatched to the LS unit. Unit Masks ADDed.",
     "UMask": "0x1"
   },
   {
@@ -37,83 +33,114 @@
     "EventCode": "0x40",
     "BriefDescription": "The number of accesses to the data cache for load and store references. This may include certain microcode scratchpad accesses, although these are generally rare. Each increment represents an eight-byte access, although the instruction may only be accessing a portion of that. This event is a speculative event."
   },
+  {
+    "EventName": "ls_mab_alloc.dc_prefetcher",
+    "EventCode": "0x41",
+    "BriefDescription": "LS MAB allocates by type - DC prefetcher.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_mab_alloc.stores",
+    "EventCode": "0x41",
+    "BriefDescription": "LS MAB allocates by type - stores.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_mab_alloc.loads",
+    "EventCode": "0x41",
+    "BriefDescription": "LS MAB allocates by type - loads.",
+    "UMask": "0x01"
+  },
   {
     "EventName": "ls_l1_d_tlb_miss.all",
     "EventCode": "0x45",
     "BriefDescription": "L1 DTLB Miss or Reload off all sizes.",
-    "PublicDescription": "L1 DTLB Miss or Reload off all sizes.",
     "UMask": "0xff"
   },
   {
     "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss",
     "EventCode": "0x45",
     "BriefDescription": "L1 DTLB Miss of a page of 1G size.",
-    "PublicDescription": "L1 DTLB Miss of a page of 1G size.",
     "UMask": "0x80"
   },
   {
     "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss",
     "EventCode": "0x45",
     "BriefDescription": "L1 DTLB Miss of a page of 2M size.",
-    "PublicDescription": "L1 DTLB Miss of a page of 2M size.",
     "UMask": "0x40"
   },
   {
     "EventName": "ls_l1_d_tlb_miss.tlb_reload_32k_l2_miss",
     "EventCode": "0x45",
     "BriefDescription": "L1 DTLB Miss of a page of 32K size.",
-    "PublicDescription": "L1 DTLB Miss of a page of 32K size.",
     "UMask": "0x20"
   },
   {
     "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss",
     "EventCode": "0x45",
     "BriefDescription": "L1 DTLB Miss of a page of 4K size.",
-    "PublicDescription": "L1 DTLB Miss of a page of 4K size.",
     "UMask": "0x10"
   },
   {
     "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit",
     "EventCode": "0x45",
     "BriefDescription": "L1 DTLB Reload of a page of 1G size.",
-    "PublicDescription": "L1 DTLB Reload of a page of 1G size.",
     "UMask": "0x8"
   },
   {
     "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit",
     "EventCode": "0x45",
     "BriefDescription": "L1 DTLB Reload of a page of 2M size.",
-    "PublicDescription": "L1 DTLB Reload of a page of 2M size.",
     "UMask": "0x4"
   },
   {
     "EventName": "ls_l1_d_tlb_miss.tlb_reload_32k_l2_hit",
     "EventCode": "0x45",
     "BriefDescription": "L1 DTLB Reload of a page of 32K size.",
-    "PublicDescription": "L1 DTLB Reload of a page of 32K size.",
     "UMask": "0x2"
   },
   {
     "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit",
     "EventCode": "0x45",
     "BriefDescription": "L1 DTLB Reload of a page of 4K size.",
-    "PublicDescription": "L1 DTLB Reload of a page of 4K size.",
     "UMask": "0x1"
   },
   {
-    "EventName": "ls_tablewalker.perf_mon_tablewalk_alloc_iside",
+    "EventName": "ls_tablewalker.iside",
     "EventCode": "0x46",
-    "BriefDescription": "Tablewalker allocation.",
-    "PublicDescription": "Tablewalker allocation.",
+    "BriefDescription": "Total Page Table Walks on I-side.",
     "UMask": "0xc"
   },
   {
-    "EventName": "ls_tablewalker.perf_mon_tablewalk_alloc_dside",
+    "EventName": "ls_tablewalker.ic_type1",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks IC Type 1.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_tablewalker.ic_type0",
     "EventCode": "0x46",
-    "BriefDescription": "Tablewalker allocation.",
-    "PublicDescription": "Tablewalker allocation.",
+    "BriefDescription": "Total Page Table Walks IC Type 0.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_tablewalker.dside",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks on D-side.",
     "UMask": "0x3"
   },
+  {
+    "EventName": "ls_tablewalker.dc_type1",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks DC Type 1.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_tablewalker.dc_type0",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks DC Type 0.",
+    "UMask": "0x1"
+  },
   {
     "EventName": "ls_misal_accesses",
     "EventCode": "0x47",
@@ -123,35 +150,30 @@
     "EventName": "ls_pref_instr_disp.prefetch_nta",
     "EventCode": "0x4b",
     "BriefDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
-    "PublicDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
     "UMask": "0x4"
   },
   {
     "EventName": "ls_pref_instr_disp.store_prefetch_w",
     "EventCode": "0x4b",
     "BriefDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
-    "PublicDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
     "UMask": "0x2"
   },
   {
     "EventName": "ls_pref_instr_disp.load_prefetch_w",
     "EventCode": "0x4b",
-    "BriefDescription": "Prefetch, Prefetch_T0_T1_T2.",
-    "PublicDescription": "Software Prefetch Instructions Dispatched. Prefetch, Prefetch_T0_T1_T2.",
+    "BriefDescription": "Software Prefetch Instructions Dispatched. Prefetch, Prefetch_T0_T1_T2.",
     "UMask": "0x1"
   },
   {
     "EventName": "ls_inef_sw_pref.mab_mch_cnt",
     "EventCode": "0x52",
-    "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
-    "PublicDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
+    "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core. Software PREFETCH instruction saw a match on an already-allocated miss request buffer.",
     "UMask": "0x2"
   },
   {
     "EventName": "ls_inef_sw_pref.data_pipe_sw_pf_dc_hit",
     "EventCode": "0x52",
-    "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
-    "PublicDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
+    "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core. Software PREFETCH instruction saw a DC hit.",
     "UMask": "0x1"
   },
   {
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/other.json b/tools/perf/pmu-events/arch/x86/amdzen1/other.json
index b26a00d05a2e..ff780098d36e 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/other.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/other.json
@@ -2,64 +2,55 @@
   {
     "EventName": "ic_oc_mode_switch.oc_ic_mode_switch",
     "EventCode": "0x28a",
-    "BriefDescription": "OC to IC mode switch.",
-    "PublicDescription": "OC Mode Switch. OC to IC mode switch.",
+    "BriefDescription": "OC Mode Switch. OC to IC mode switch.",
     "UMask": "0x2"
   },
   {
     "EventName": "ic_oc_mode_switch.ic_oc_mode_switch",
     "EventCode": "0x28a",
-    "BriefDescription": "IC to OC mode switch.",
-    "PublicDescription": "OC Mode Switch. IC to OC mode switch.",
+    "BriefDescription": "OC Mode Switch. IC to OC mode switch.",
     "UMask": "0x1"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls0.retire_token_stall",
     "EventCode": "0xaf",
-    "BriefDescription": "RETIRE Tokens unavailable.",
-    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
     "UMask": "0x40"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls0.agsq_token_stall",
     "EventCode": "0xaf",
-    "BriefDescription": "AGSQ Tokens unavailable.",
-    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. AGSQ Tokens unavailable.",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. AGSQ Tokens unavailable.",
     "UMask": "0x20"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls0.alu_token_stall",
     "EventCode": "0xaf",
-    "BriefDescription": "ALU tokens total unavailable.",
-    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALU tokens total unavailable.",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALU tokens total unavailable.",
     "UMask": "0x10"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls0.alsq3_0_token_stall",
     "EventCode": "0xaf",
-    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall.",
-    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall.",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 3_0 Tokens unavailable.",
     "UMask": "0x8"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls0.alsq3_token_stall",
     "EventCode": "0xaf",
-    "BriefDescription": "ALSQ 3 Tokens unavailable.",
-    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 3 Tokens unavailable.",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 3 Tokens unavailable.",
     "UMask": "0x4"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls0.alsq2_token_stall",
     "EventCode": "0xaf",
-    "BriefDescription": "ALSQ 2 Tokens unavailable.",
-    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 2 Tokens unavailable.",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 2 Tokens unavailable.",
     "UMask": "0x2"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls0.alsq1_token_stall",
     "EventCode": "0xaf",
-    "BriefDescription": "ALSQ 1 Tokens unavailable.",
-    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 1 Tokens unavailable.",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 1 Tokens unavailable.",
     "UMask": "0x1"
   }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 244a36e37a3a..25b06cf98747 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -36,5 +36,5 @@ GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
 GenuineIntel-6-7D,v1,icelake,core
 GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-86,v1,tremontx,core
-AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v1,amdzen1,core
+AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
-- 
2.21.1
