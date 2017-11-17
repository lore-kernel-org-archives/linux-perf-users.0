From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 45/83] perf vendor events powerpc: Update POWER9 events
Date: Fri, 17 Nov 2017 17:15:23 -0300
Message-ID: <20171117201601.24110-46-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758679AbdKQUSq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:18:46 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

The POWER9 hardware has dropped support for several events, added
a few new events and changed the category for a couple of events.

Update the POWER9 events in Linux to reflect these changes.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20171108201938.GA10985@us.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/pmu-events/arch/powerpc/power9/cache.json |   5 -
 .../pmu-events/arch/powerpc/power9/frontend.json   |   7 +-
 .../pmu-events/arch/powerpc/power9/marked.json     |  27 +-
 .../perf/pmu-events/arch/powerpc/power9/other.json | 276 ++++++---------------
 .../pmu-events/arch/powerpc/power9/pipeline.json   |  14 +-
 tools/perf/pmu-events/arch/powerpc/power9/pmc.json |   2 +-
 .../arch/powerpc/power9/translation.json           |   5 -
 7 files changed, 88 insertions(+), 248 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/cache.json b/tools/perf/pmu-events/arch/powerpc/power9/cache.json
index 18f6645f2897..7945c5196c43 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/cache.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/cache.json
@@ -125,11 +125,6 @@
     "BriefDescription": "Finish stall because the NTF instruction was a larx waiting to be satisfied"
   },
   {,
-    "EventCode": "0x3006C",
-    "EventName": "PM_RUN_CYC_SMT2_MODE",
-    "BriefDescription": "Cycles in which this thread's run latch is set and the core is in SMT2 mode"
-  },
-  {,
     "EventCode": "0x1C058",
     "EventName": "PM_DTLB_MISS_16G",
     "BriefDescription": "Data TLB Miss page size 16G"
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/frontend.json b/tools/perf/pmu-events/arch/powerpc/power9/frontend.json
index c63a919eda98..bd8361b5fd6a 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/frontend.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/frontend.json
@@ -1,10 +1,5 @@
 [
   {,
-    "EventCode": "0x3E15C",
-    "EventName": "PM_MRK_L2_TM_ST_ABORT_SISTER",
-    "BriefDescription": "TM marked store abort for this thread"
-  },
-  {,
     "EventCode": "0x25044",
     "EventName": "PM_IPTEG_FROM_L31_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's L3 on the same chip due to a instruction side request"
@@ -369,4 +364,4 @@
     "EventName": "PM_IPTEG_FROM_L31_ECO_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's ECO L3 on the same chip due to a instruction side request"
   }
-]
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/marked.json b/tools/perf/pmu-events/arch/powerpc/power9/marked.json
index b9df54fb37e3..22f9f32060a8 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/marked.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/marked.json
@@ -1,10 +1,5 @@
 [
   {,
-    "EventCode": "0x3C052",
-    "EventName": "PM_DATA_SYS_PUMP_MPRED",
-    "BriefDescription": "Final Pump Scope (system) mispredicted. Either the original scope was too small (Chip/Group) or the original scope was System and it should have been smaller. Counts for a demand load"
-  },
-  {,
     "EventCode": "0x3013E",
     "EventName": "PM_MRK_STALL_CMPLU_CYC",
     "BriefDescription": "Number of cycles the marked instruction is experiencing a stall while it is next to complete (NTC)"
@@ -255,6 +250,11 @@
     "BriefDescription": "A Page Directory Entry was reloaded to a level 1 page walk cache from the core's L3 data cache"
   },
   {,
+    "EventCode": "0x3C052",
+    "EventName": "PM_DATA_SYS_PUMP_MPRED",
+    "BriefDescription": "Final Pump Scope (system) mispredicted. Either the original scope was too small (Chip/Group) or the original scope was System and it should have been smaller. Counts for a demand load"
+  },
+  {,
     "EventCode": "0x4D142",
     "EventName": "PM_MRK_DATA_FROM_L3",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 due to a marked load"
@@ -435,21 +435,6 @@
     "BriefDescription": "ITLB Reloaded. Counts 1 per ITLB miss for HPT but multiple for radix depending on number of levels traveresed"
   },
   {,
-    "EventCode": "0x2D024",
-    "EventName": "PM_RADIX_PWC_L2_HIT",
-    "BriefDescription": "A radix translation attempt missed in the TLB but hit on both the first and second levels of page walk cache."
-  },
-  {,
-    "EventCode": "0x3F056",
-    "EventName": "PM_RADIX_PWC_L3_HIT",
-    "BriefDescription": "A radix translation attempt missed in the TLB but hit on the first, second, and third levels of page walk cache."
-  },
-  {,
-    "EventCode": "0x4E014",
-    "EventName": "PM_TM_TX_PASS_RUN_INST",
-    "BriefDescription": "Run instructions spent in successful transactions"
-  },
-  {,
     "EventCode": "0x1E044",
     "EventName": "PM_DPTEG_FROM_L3_NO_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 without conflict due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
@@ -644,4 +629,4 @@
     "EventName": "PM_MRK_BR_MPRED_CMPL",
     "BriefDescription": "Marked Branch Mispredicted"
   }
-]
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/other.json b/tools/perf/pmu-events/arch/powerpc/power9/other.json
index 54cc3be00fc2..5ce312973f1e 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/other.json
@@ -80,6 +80,11 @@
     "BriefDescription": "A radix translation attempt missed in the TLB and all levels of page walk cache."
   },
   {,
+    "EventCode": "0x26882",
+    "EventName": "PM_L2_DC_INV",
+    "BriefDescription": "D-cache invalidates sent over the reload bus to the core"
+  },
+  {,
     "EventCode": "0x24048",
     "EventName": "PM_INST_FROM_LMEM",
     "BriefDescription": "The processor's Instruction cache was reloaded from the local chip's Memory due to an instruction fetch (not prefetch)"
@@ -95,11 +100,6 @@
     "BriefDescription": "Number of TM transactions that passed"
   },
   {,
-    "EventCode": "0xD1A0",
-    "EventName": "PM_MRK_LSU_FLUSH_LHS",
-    "BriefDescription": "Effective Address alias flush : no EA match but Real Address match.  If the data has not yet been returned for this load, the instruction will just be rejected, but if it has returned data, it will be flushed"
-  },
-  {,
     "EventCode": "0xF088",
     "EventName": "PM_LSU0_STORE_REJECT",
     "BriefDescription": "All internal store rejects cause the instruction to go back to the SRQ and go to sleep until woken up to try again after the condition has been met"
@@ -127,7 +127,7 @@
   {,
     "EventCode": "0xD08C",
     "EventName": "PM_LSU2_LDMX_FIN",
-    "BriefDescription": "New P9 instruction LDMX. The definition of this new PMU event is (from the ldmx RFC02491):  The thread has executed an ldmx instruction that accessed a doubleword that contains an effective address within an enabled section of the Load Monitored region. This event, therefore, should not occur if the FSCR has disabled the load monitored facility (FSCR[52]) or disabled the EBB facility (FSCR[56])"
+    "BriefDescription": "New P9 instruction LDMX. The definition of this new PMU event is (from the ldmx RFC02491):  The thread has executed an ldmx instruction that accessed a doubleword that contains an effective address within an enabled section of the Load Monitored region.  This event, therefore, should not occur if the FSCR has disabled the load monitored facility (FSCR[52]) or disabled the EBB facility (FSCR[56])."
   },
   {,
     "EventCode": "0x300F8",
@@ -205,11 +205,6 @@
     "BriefDescription": "Duration in cycles to reload with Modified (M) data from another core's ECO L3 on the same chip due to a marked load"
   },
   {,
-    "EventCode": "0xF0B4",
-    "EventName": "PM_DC_PREF_CONS_ALLOC",
-    "BriefDescription": "Prefetch stream allocated in the conservative phase by either the hardware prefetch mechanism or software prefetch"
-  },
-  {,
     "EventCode": "0xF894",
     "EventName": "PM_LSU3_L1_CAM_CANCEL",
     "BriefDescription": "ls3 l1 tm cam cancel"
@@ -220,21 +215,11 @@
     "BriefDescription": "Dispatch Flush: TLBIE"
   },
   {,
-    "EventCode": "0xD1A4",
-    "EventName": "PM_MRK_LSU_FLUSH_SAO",
-    "BriefDescription": "A load-hit-load condition with Strong Address Ordering will have address compare disabled and flush"
-  },
-  {,
     "EventCode": "0x4E11E",
     "EventName": "PM_MRK_DATA_FROM_DMEM_CYC",
     "BriefDescription": "Duration in cycles to reload from another chip's memory on the same Node or Group (Distant) due to a marked load"
   },
   {,
-    "EventCode": "0x5894",
-    "EventName": "PM_LWSYNC",
-    "BriefDescription": "Lwsync instruction decoded and transferred"
-  },
-  {,
     "EventCode": "0x14156",
     "EventName": "PM_MRK_DATA_FROM_L2_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L2 due to a marked load"
@@ -245,11 +230,6 @@
     "BriefDescription": "Read clearing SC"
   },
   {,
-    "EventCode": "0x50A0",
-    "EventName": "PM_HWSYNC",
-    "BriefDescription": "Hwsync instruction decoded and transferred"
-  },
-  {,
     "EventCode": "0x168B0",
     "EventName": "PM_L3_P1_NODE_PUMP",
     "BriefDescription": "L3 PF sent with nodal scope port 1, counts even retried requests"
@@ -265,6 +245,11 @@
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 with load hit store conflict due to a marked load"
   },
   {,
+    "EventCode": "0x468AE",
+    "EventName": "PM_L3_P3_CO_RTY",
+    "BriefDescription": "L3 CO received retry port 3 (memory only), every retry counted"
+  },
+  {,
     "EventCode": "0x460A8",
     "EventName": "PM_SN_HIT",
     "BriefDescription": "Any port snooper hit L3.  Up to 4 can happen in a cycle but we only count 1"
@@ -280,11 +265,6 @@
     "BriefDescription": "Prefetch stream allocated by the hardware prefetch mechanism"
   },
   {,
-    "EventCode": "0xF0BC",
-    "EventName": "PM_LS2_UNALIGNED_ST",
-    "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
-  },
-  {,
     "EventCode": "0xD0AC",
     "EventName": "PM_SRQ_SYNC_CYC",
     "BriefDescription": "A sync is in the S2Q (edge detect to count)"
@@ -380,26 +360,11 @@
     "BriefDescription": "Cycles in which this thread's run latch is set and the core is in SMT4 mode"
   },
   {,
-    "EventCode": "0x5088",
-    "EventName": "PM_DECODE_FUSION_OP_PRESERV",
-    "BriefDescription": "Destructive op operand preservation"
-  },
-  {,
     "EventCode": "0x1D14E",
     "EventName": "PM_MRK_DATA_FROM_OFF_CHIP_CACHE_CYC",
     "BriefDescription": "Duration in cycles to reload either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to a marked load"
   },
   {,
-    "EventCode": "0x509C",
-    "EventName": "PM_FORCED_NOP",
-    "BriefDescription": "Instruction was forced to execute as a nop because it was found to behave like a nop (have no effect) at decode time"
-  },
-  {,
-    "EventCode": "0xC098",
-    "EventName": "PM_LS2_UNALIGNED_LD",
-    "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
-  },
-  {,
     "EventCode": "0x20058",
     "EventName": "PM_DARQ1_10_12_ENTRIES",
     "BriefDescription": "Cycles in which 10 or  more DARQ1 entries (out of 12) are in use"
@@ -435,11 +400,6 @@
     "BriefDescription": "All internal store rejects cause the instruction to go back to the SRQ and go to sleep until woken up to try again after the condition has been met"
   },
   {,
-    "EventCode": "0x4505E",
-    "EventName": "PM_FLOP_CMPL",
-    "BriefDescription": "Floating Point Operation Finished"
-  },
-  {,
     "EventCode": "0x1D144",
     "EventName": "PM_MRK_DATA_FROM_L3_DISP_CONFLICT",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 with dispatch conflict due to a marked load"
@@ -480,14 +440,9 @@
     "BriefDescription": "XL-form branch was mispredicted due to the predicted target address missing from EAT.  The EAT forces a mispredict in this case since there is no predicated target to validate.  This is a rare case that may occur when the EAT is full and a branch is issued"
   },
   {,
-    "EventCode": "0xC094",
-    "EventName": "PM_LS0_UNALIGNED_LD",
-    "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
-  },
-  {,
-    "EventCode": "0xF8BC",
-    "EventName": "PM_LS3_UNALIGNED_ST",
-    "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
+    "EventCode": "0x460AE",
+    "EventName": "PM_L3_P2_CO_RTY",
+    "BriefDescription": "L3 CO received retry port 2 (memory only), every retry counted"
   },
   {,
     "EventCode": "0x58B0",
@@ -505,11 +460,6 @@
     "BriefDescription": "TM Store (fav or non-fav) ran into conflict (failed)"
   },
   {,
-    "EventCode": "0xD998",
-    "EventName": "PM_MRK_LSU_FLUSH_EMSH",
-    "BriefDescription": "An ERAT miss was detected after a set-p hit. Erat tracker indicates fail due to tlbmiss and the instruction gets flushed because the instruction was working on the wrong address"
-  },
-  {,
     "EventCode": "0xF8A0",
     "EventName": "PM_NON_DATA_STORE",
     "BriefDescription": "All ops that drain from s2q to L2 and contain no data"
@@ -525,11 +475,6 @@
     "BriefDescription": "Unconditional Branch Completed. HW branch prediction was not used for this branch. This can be an I-form branch, a B-form branch with BO-field set to branch always, or a B-form branch which was covenrted to a Resolve."
   },
   {,
-    "EventCode": "0x1F056",
-    "EventName": "PM_RADIX_PWC_L1_HIT",
-    "BriefDescription": "A radix translation attempt missed in the TLB and only the first level page walk cache was a hit."
-  },
-  {,
     "EventCode": "0xF8A8",
     "EventName": "PM_DC_PREF_FUZZY_CONF",
     "BriefDescription": "A demand load referenced a line in an active fuzzy prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software.Fuzzy stream confirm (out of order effects, or pf cant keep up)"
@@ -545,6 +490,11 @@
     "BriefDescription": "Load tm L1 miss"
   },
   {,
+    "EventCode": "0xC880",
+    "EventName": "PM_LS1_LD_VECTOR_FIN",
+    "BriefDescription": ""
+  },
+  {,
     "EventCode": "0x2894",
     "EventName": "PM_TM_OUTER_TEND",
     "BriefDescription": "Completion time outer tend"
@@ -565,21 +515,11 @@
     "BriefDescription": "Marked derat reload (miss) for any page size"
   },
   {,
-    "EventCode": "0x160A0",
-    "EventName": "PM_L3_PF_MISS_L3",
-    "BriefDescription": "L3 PF missed in L3"
-  },
-  {,
     "EventCode": "0x1C04A",
     "EventName": "PM_DATA_FROM_RL2L3_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a demand load"
   },
   {,
-    "EventCode": "0xD99C",
-    "EventName": "PM_MRK_LSU_FLUSH_UE",
-    "BriefDescription": "Correctable ECC error on reload data, reported at critical data forward time"
-  },
-  {,
     "EventCode": "0x268B0",
     "EventName": "PM_L3_P1_GRP_PUMP",
     "BriefDescription": "L3 PF sent with grp scope port 1, counts even retried requests"
@@ -630,11 +570,6 @@
     "BriefDescription": "addrs only req to L2 only on the first one,Indication that Load footprint is not expanding"
   },
   {,
-    "EventCode": "0x5884",
-    "EventName": "PM_DECODE_LANES_NOT_AVAIL",
-    "BriefDescription": "Decode has something to transmit but dispatch lanes are not available"
-  },
-  {,
     "EventCode": "0x3C042",
     "EventName": "PM_DATA_FROM_L3_DISP_CONFLICT",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 with dispatch conflict due to a demand load"
@@ -690,9 +625,9 @@
     "BriefDescription": "False LHS match detected"
   },
   {,
-    "EventCode": "0xD9A4",
-    "EventName": "PM_MRK_LSU_FLUSH_LARX_STCX",
-    "BriefDescription": "A larx is flushed because an older larx has an LMQ reservation for the same thread.  A stcx is flushed because an older stcx is in the LMQ.  The flush happens when the older larx/stcx relaunches"
+    "EventCode": "0xF0B0",
+    "EventName": "PM_L3_LD_PREF",
+    "BriefDescription": "L3 load prefetch, sourced from a hardware or software stream, was sent to the nest"
   },
   {,
     "EventCode": "0x4D012",
@@ -715,9 +650,9 @@
     "BriefDescription": "All successful Ld/St dispatches for this thread that were an L2 miss (excludes i_l2mru_tch_reqs)"
   },
   {,
-    "EventCode": "0xF8B8",
-    "EventName": "PM_LS1_UNALIGNED_ST",
-    "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
+    "EventCode": "0x160A0",
+    "EventName": "PM_L3_PF_MISS_L3",
+    "BriefDescription": "L3 PF missed in L3"
   },
   {,
     "EventCode": "0x408C",
@@ -765,11 +700,6 @@
     "BriefDescription": "Completion time nested tend"
   },
   {,
-    "EventCode": "0x36084",
-    "EventName": "PM_L2_RCST_DISP",
-    "BriefDescription": "All D-side store dispatch attempts for this thread"
-  },
-  {,
     "EventCode": "0x368A0",
     "EventName": "PM_L3_PF_OFF_CHIP_CACHE",
     "BriefDescription": "L3 PF from Off chip cache"
@@ -830,11 +760,6 @@
     "BriefDescription": "Rotating sample of 16 snoop valids"
   },
   {,
-    "EventCode": "0x16084",
-    "EventName": "PM_L2_RCLD_DISP",
-    "BriefDescription": "All I-or-D side load dispatch attempts for this thread (excludes i_l2mru_tch_reqs)"
-  },
-  {,
     "EventCode": "0x1608C",
     "EventName": "PM_RC0_BUSY",
     "BriefDescription": "RC mach 0 Busy. Used by PMU to sample ave RC lifetime (mach0 used as sample point)"
@@ -842,7 +767,7 @@
   {,
     "EventCode": "0x36082",
     "EventName": "PM_L2_LD_DISP",
-    "BriefDescription": "All successful I-or-D side load dispatches for this thread (excludes i_l2mru_tch_reqs)."
+    "BriefDescription": "All successful I-or-D side load dispatches for this thread (excludes i_l2mru_tch_reqs)"
   },
   {,
     "EventCode": "0xF8B0",
@@ -905,11 +830,6 @@
     "BriefDescription": "Instruction prefetch requests"
   },
   {,
-    "EventCode": "0xC898",
-    "EventName": "PM_LS3_UNALIGNED_LD",
-    "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
-  },
-  {,
     "EventCode": "0x488C",
     "EventName": "PM_IC_PREF_WRITE",
     "BriefDescription": "Instruction prefetch written into IL1"
@@ -1017,7 +937,7 @@
   {,
     "EventCode": "0x3E05E",
     "EventName": "PM_L3_CO_MEPF",
-    "BriefDescription": "L3 castouts in Mepf state for this thread"
+    "BriefDescription": "L3 CO of line in Mep state (includes casthrough to memory).  The Mepf state indicates that a line was brought in to satisfy an L3 prefetch request"
   },
   {,
     "EventCode": "0x460A2",
@@ -1205,11 +1125,6 @@
     "BriefDescription": "Non transactional conflict from LSU, gets reported to TEXASR"
   },
   {,
-    "EventCode": "0xD198",
-    "EventName": "PM_MRK_LSU_FLUSH_ATOMIC",
-    "BriefDescription": "Quad-word loads (lq) are considered atomic because they always span at least 2 slices.  If a snoop or store from another thread changes the data the load is accessing between the 2 or 3 pieces of the lq instruction, the lq will be flushed"
-  },
-  {,
     "EventCode": "0x201E0",
     "EventName": "PM_MRK_DATA_FROM_MEMORY",
     "BriefDescription": "The processor's data cache was reloaded from a memory location including L4 from local remote or distant due to a marked load"
@@ -1295,11 +1210,6 @@
     "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF; CR; XVF (XER/VSCR/FPSCR)"
   },
   {,
-    "EventCode": "0xC894",
-    "EventName": "PM_LS1_UNALIGNED_LD",
-    "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
-  },
-  {,
     "EventCode": "0x360A2",
     "EventName": "PM_L3_L2_CO_HIT",
     "BriefDescription": "L2 CO hits"
@@ -1325,11 +1235,6 @@
     "BriefDescription": "L2 Castouts - Shared (Tx,Sx)"
   },
   {,
-    "EventCode": "0xD884",
-    "EventName": "PM_LSU3_SET_MPRED",
-    "BriefDescription": "Set prediction(set-p) miss.  The entry was not found in the Set prediction table"
-  },
-  {,
     "EventCode": "0x26092",
     "EventName": "PM_L2_LD_MISS_64B",
     "BriefDescription": "All successful D-side load dispatches that were an L2 miss (NOT Sx,Tx,Mx) for this thread and the RC calculated the request should be for 64B(i.e., M=1)"
@@ -1362,12 +1267,12 @@
   {,
     "EventCode": "0xD8A8",
     "EventName": "PM_ISLB_MISS",
-    "BriefDescription": "Instruction SLB miss - Total of all segment sizes"
+    "BriefDescription": "Instruction SLB Miss - Total of all segment sizes"
   },
   {,
-    "EventCode": "0xD19C",
-    "EventName": "PM_MRK_LSU_FLUSH_RELAUNCH_MISS",
-    "BriefDescription": "If a load that has already returned data and has to relaunch for any reason then gets a miss (erat, setp, data cache), it will often be flushed at relaunch time because the data might be inconsistent"
+    "EventCode": "0x368AE",
+    "EventName": "PM_L3_P1_CO_RTY",
+    "BriefDescription": "L3 CO received retry port 1 (memory only), every retry counted"
   },
   {,
     "EventCode": "0x260A2",
@@ -1385,6 +1290,11 @@
     "BriefDescription": "Completion stall because the ISU is updating the TEXASR to keep track of the nested tbegin. This is a short delay, and it includes ROT"
   },
   {,
+    "EventCode": "0xC084",
+    "EventName": "PM_LS2_LD_VECTOR_FIN",
+    "BriefDescription": ""
+  },
+  {,
     "EventCode": "0x1608E",
     "EventName": "PM_ST_CAUSED_FAIL",
     "BriefDescription": "Non-TM Store caused any thread to fail"
@@ -1410,11 +1320,6 @@
     "BriefDescription": "Continuous 16 cycle (2to1) window where this signals rotates thru sampling each CO machine busy. PMU uses this wave to then do 16 cyc count to sample total number of machs running"
   },
   {,
-    "EventCode": "0xD084",
-    "EventName": "PM_LSU2_SET_MPRED",
-    "BriefDescription": "Set prediction(set-p) miss.  The entry was not found in the Set prediction table"
-  },
-  {,
     "EventCode": "0x48B8",
     "EventName": "PM_BR_MPRED_TAKEN_TA",
     "BriefDescription": "Conditional Branch Completed that was Mispredicted due to the Target Address Prediction from the Count Cache or Link Stack.  Only XL-form branches that resolved Taken set this event."
@@ -1450,29 +1355,24 @@
     "BriefDescription": "A demand load referenced a line in an active strided prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software."
   },
   {,
+    "EventCode": "0x36084",
+    "EventName": "PM_L2_RCST_DISP",
+    "BriefDescription": "All D-side store dispatch attempts for this thread"
+  },
+  {,
     "EventCode": "0x45054",
     "EventName": "PM_FMA_CMPL",
     "BriefDescription": "two flops operation completed (fmadd, fnmadd, fmsub, fnmsub) Scalar instructions only. "
   },
   {,
-    "EventCode": "0x5090",
-    "EventName": "PM_SHL_ST_DISABLE",
-    "BriefDescription": "Store-Hit-Load Table Read Hit with entry Disabled (entry was disabled due to the entry shown to not prevent the flush)"
-  },
-  {,
     "EventCode": "0x201E8",
     "EventName": "PM_THRESH_EXC_512",
     "BriefDescription": "Threshold counter exceeded a value of 512"
   },
   {,
-    "EventCode": "0x5084",
-    "EventName": "PM_DECODE_FUSION_EXT_ADD",
-    "BriefDescription": "32-bit extended addition"
-  },
-  {,
     "EventCode": "0x36080",
     "EventName": "PM_L2_INST",
-    "BriefDescription": "All successful I-side dispatches for this thread (excludes i_l2mru_tch reqs)."
+    "BriefDescription": "All successful I-side dispatches for this thread   (excludes i_l2mru_tch reqs)"
   },
   {,
     "EventCode": "0x3504C",
@@ -1555,21 +1455,11 @@
     "BriefDescription": "Memory Read With Intent to Modify for this thread"
   },
   {,
-    "EventCode": "0x26882",
-    "EventName": "PM_L2_DC_INV",
-    "BriefDescription": "D-cache invalidates sent over the reload bus to the core"
-  },
-  {,
     "EventCode": "0xC090",
     "EventName": "PM_LSU_STCX",
     "BriefDescription": "STCX sent to nest, i.e. total"
   },
   {,
-    "EventCode": "0xD080",
-    "EventName": "PM_LSU0_SET_MPRED",
-    "BriefDescription": "Set prediction(set-p) miss.  The entry was not found in the Set prediction table"
-  },
-  {,
     "EventCode": "0x2C120",
     "EventName": "PM_MRK_DATA_FROM_L2_NO_CONFLICT",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 without conflict due to a marked load"
@@ -1610,11 +1500,6 @@
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 without conflict due to a instruction side request"
   },
   {,
-    "EventCode": "0xD9A0",
-    "EventName": "PM_MRK_LSU_FLUSH_LHL_SHL",
-    "BriefDescription": "The instruction was flushed because of a sequential load/store consistency.  If a load or store hits on an older load that has either been snooped (for loads) or has stale data (for stores)."
-  },
-  {,
     "EventCode": "0x35042",
     "EventName": "PM_IPTEG_FROM_L3_DISP_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 with dispatch conflict due to a instruction side request"
@@ -1692,7 +1577,7 @@
   {,
     "EventCode": "0x2001A",
     "EventName": "PM_NTC_ALL_FIN",
-    "BriefDescription": "Cycles after all instructions have finished to group completed"
+    "BriefDescription": "Cycles after instruction finished to instruction completed."
   },
   {,
     "EventCode": "0x3005A",
@@ -1710,6 +1595,11 @@
     "BriefDescription": "ls1 l1 tm cam cancel"
   },
   {,
+    "EventCode": "0x268AE",
+    "EventName": "PM_L3_P3_PF_RTY",
+    "BriefDescription": "L3 PF received retry port 3, every retry counted"
+  },
+  {,
     "EventCode": "0xE884",
     "EventName": "PM_LS1_ERAT_MISS_PREF",
     "BriefDescription": "LS1 Erat miss due to prefetch"
@@ -1742,7 +1632,7 @@
   {,
     "EventCode": "0x160B6",
     "EventName": "PM_L3_WI0_BUSY",
-    "BriefDescription": "Rotating sample of 8 WI valid"
+    "BriefDescription": "Rotating sample of 8 WI valid (duplicate)"
   },
   {,
     "EventCode": "0x368AC",
@@ -1790,9 +1680,9 @@
     "BriefDescription": "L2 guess system (VGS or RNS) and guess was correct (ie data beyond-group)"
   },
   {,
-    "EventCode": "0x589C",
-    "EventName": "PM_PTESYNC",
-    "BriefDescription": "ptesync instruction counted when the instruction is decoded and transmitted"
+    "EventCode": "0x260AE",
+    "EventName": "PM_L3_P2_PF_RTY",
+    "BriefDescription": "L3 PF received retry port 2, every retry counted"
   },
   {,
     "EventCode": "0x26086",
@@ -1825,6 +1715,11 @@
     "BriefDescription": "Store-Hit-Load Table Read Hit with entry Enabled"
   },
   {,
+    "EventCode": "0x46882",
+    "EventName": "PM_L2_ST_HIT",
+    "BriefDescription": "All successful D-side store dispatches for this thread that were L2 hits"
+  },
+  {,
     "EventCode": "0x360AC",
     "EventName": "PM_L3_SN0_BUSY",
     "BriefDescription": "Lifetime, sample of snooper machine 0 valid"
@@ -1845,11 +1740,6 @@
     "BriefDescription": "All successful D-Side Store dispatches that were an L2 miss for this thread"
   },
   {,
-    "EventCode": "0xF8B4",
-    "EventName": "PM_DC_PREF_XCONS_ALLOC",
-    "BriefDescription": "Prefetch stream allocated in the Ultra conservative phase by either the hardware prefetch mechanism or software prefetch"
-  },
-  {,
     "EventCode": "0x35048",
     "EventName": "PM_IPTEG_FROM_DL2L3_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a instruction side request"
@@ -1970,11 +1860,6 @@
     "BriefDescription": "Cycles thread running at priority level 2 or 3"
   },
   {,
-    "EventCode": "0x10134",
-    "EventName": "PM_MRK_ST_DONE_L2",
-    "BriefDescription": "marked store completed in L2 ( RC machine done)"
-  },
-  {,
     "EventCode": "0x368B2",
     "EventName": "PM_L3_GRP_GUESS_WRONG_HIGH",
     "BriefDescription": "Initial scope=group (GS or NNS) but data from local node. Prediction too high"
@@ -2005,11 +1890,6 @@
     "BriefDescription": "L2 guess grp (GS or NNS) and guess was not correct (ie data on-chip OR beyond-group)"
   },
   {,
-    "EventCode": "0x368AE",
-    "EventName": "PM_L3_P1_CO_RTY",
-    "BriefDescription": "L3 CO received retry port 1 (memory only), every retry counted"
-  },
-  {,
     "EventCode": "0xC0AC",
     "EventName": "PM_LSU_FLUSH_EMSH",
     "BriefDescription": "An ERAT miss was detected after a set-p hit. Erat tracker indicates fail due to tlbmiss and the instruction gets flushed because the instruction was working on the wrong address"
@@ -2035,11 +1915,6 @@
     "BriefDescription": "RC requests that were on group (aka nodel) pump attempts"
   },
   {,
-    "EventCode": "0xF0B0",
-    "EventName": "PM_L3_LD_PREF",
-    "BriefDescription": "L3 load prefetch, sourced from a hardware or software stream, was sent to the nest"
-  },
-  {,
     "EventCode": "0x16080",
     "EventName": "PM_L2_LD",
     "BriefDescription": "All successful D-side Load dispatches for this thread (L2 miss + L2 hits)"
@@ -2050,6 +1925,11 @@
     "BriefDescription": "Math flop instruction completed"
   },
   {,
+    "EventCode": "0xC080",
+    "EventName": "PM_LS0_LD_VECTOR_FIN",
+    "BriefDescription": ""
+  },
+  {,
     "EventCode": "0x368B0",
     "EventName": "PM_L3_P1_SYS_PUMP",
     "BriefDescription": "L3 PF sent with sys scope port 1, counts even retried requests"
@@ -2120,11 +2000,6 @@
     "BriefDescription": "Conditional Branch Completed in which the HW correctly predicted the direction as taken.  Counted at completion time"
   },
   {,
-    "EventCode": "0xF0B8",
-    "EventName": "PM_LS0_UNALIGNED_ST",
-    "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
-  },
-  {,
     "EventCode": "0x20132",
     "EventName": "PM_MRK_DFU_FIN",
     "BriefDescription": "Decimal Unit marked Instruction Finish"
@@ -2140,6 +2015,11 @@
     "BriefDescription": "Effective Address alias flush : no EA match but Real Address match.  If the data has not yet been returned for this load, the instruction will just be rejected, but if it has returned data, it will be flushed"
   },
   {,
+    "EventCode": "0x16084",
+    "EventName": "PM_L2_RCLD_DISP",
+    "BriefDescription": "All I-or-D side load dispatch attempts for this thread (excludes i_l2mru_tch_reqs)"
+  },
+  {,
     "EventCode": "0x3F150",
     "EventName": "PM_MRK_ST_DRAIN_TO_L2DISP_CYC",
     "BriefDescription": "cycles to drain st from core to L2"
@@ -2225,11 +2105,6 @@
     "BriefDescription": "Prefetch Canceled due to page boundary"
   },
   {,
-    "EventCode": "0xF09C",
-    "EventName": "PM_SLB_TABLEWALK_CYC",
-    "BriefDescription": "Cycles when a tablewalk is pending on this thread on the SLB table"
-  },
-  {,
     "EventCode": "0x460AA",
     "EventName": "PM_L3_P0_CO_L31",
     "BriefDescription": "L3 CO to L3.1 (LCO) port 0 with or without data"
@@ -2247,10 +2122,10 @@
   {,
     "EventCode": "0x46082",
     "EventName": "PM_L2_ST_DISP",
-    "BriefDescription": "All successful D-side store dispatches for this thread "
+    "BriefDescription": "All successful D-side store dispatches for this thread (L2 miss + L2 hits)"
   },
   {,
-    "EventCode": "0x4609E",
+    "EventCode": "0x36880",
     "EventName": "PM_L2_INST_MISS",
     "BriefDescription": "All successful I-side dispatches that were an L2 miss for this thread (excludes i_l2mru_tch reqs)"
   },
@@ -2340,9 +2215,9 @@
     "BriefDescription": "All ISU rejects"
   },
   {,
-    "EventCode": "0x46882",
-    "EventName": "PM_L2_ST_HIT",
-    "BriefDescription": "All successful D-side store dispatches for this thread that were L2 hits"
+    "EventCode": "0xC884",
+    "EventName": "PM_LS3_LD_VECTOR_FIN",
+    "BriefDescription": ""
   },
   {,
     "EventCode": "0x360A8",
@@ -2360,11 +2235,6 @@
     "BriefDescription": "Asserts when a i=1 store op is sent to the nest. No record of issue pipe (LS0/LS1) is maintained so this is for both pipes. Probably don't need separate LS0 and LS1"
   },
   {,
-    "EventCode": "0xD880",
-    "EventName": "PM_LSU1_SET_MPRED",
-    "BriefDescription": "Set prediction(set-p) miss.  The entry was not found in the Set prediction table"
-  },
-  {,
     "EventCode": "0xD0B8",
     "EventName": "PM_LSU_LMQ_FULL_CYC",
     "BriefDescription": "Counts the number of cycles the LMQ is full"
@@ -2389,4 +2259,4 @@
     "EventName": "PM_L3_PF_USAGE",
     "BriefDescription": "Rotating sample of 32 PF actives"
   }
-]
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
index bc2db636dabf..5af1abbe82c4 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
@@ -125,6 +125,11 @@
     "BriefDescription": "Overflow from counter 5"
   },
   {,
+    "EventCode": "0x4505E",
+    "EventName": "PM_FLOP_CMPL",
+    "BriefDescription": "Floating Point Operation Finished"
+  },
+  {,
     "EventCode": "0x2C018",
     "EventName": "PM_CMPLU_STALL_DMISS_L21_L31",
     "BriefDescription": "Completion stall by Dcache miss which resolved on chip ( excluding local L2/L3)"
@@ -390,11 +395,6 @@
     "BriefDescription": "Ict empty for this thread due to branch mispred"
   },
   {,
-    "EventCode": "0x3405E",
-    "EventName": "PM_IFETCH_THROTTLE",
-    "BriefDescription": "Cycles in which Instruction fetch throttle was active."
-  },
-  {,
     "EventCode": "0x1F148",
     "EventName": "PM_MRK_DPTEG_FROM_ON_CHIP_CACHE",
     "BriefDescription": "A Page Table Entry was loaded into the TLB either shared or modified data from another core's L2/L3 on the same chip due to a marked data side request.. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
@@ -422,7 +422,7 @@
   {,
     "EventCode": "0xD0A8",
     "EventName": "PM_DSLB_MISS",
-    "BriefDescription": "Data SLB Miss - Total of all segment sizes"
+    "BriefDescription": "gate_and(sd_pc_c0_comp_valid AND sd_pc_c0_comp_thread(0:1)=tid,sd_pc_c0_comp_ppc_count(0:3)) + gate_and(sd_pc_c1_comp_valid AND sd_pc_c1_comp_thread(0:1)=tid,sd_pc_c1_comp_ppc_count(0:3))"
   },
   {,
     "EventCode": "0x4C058",
@@ -549,4 +549,4 @@
     "EventName": "PM_MRK_DATA_FROM_L21_SHR_CYC",
     "BriefDescription": "Duration in cycles to reload with Shared (S) data from another core's L2 on the same chip due to a marked load"
   }
-]
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/pmc.json b/tools/perf/pmu-events/arch/powerpc/power9/pmc.json
index 3ef8a10aac86..d0b89f930567 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/pmc.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/pmc.json
@@ -119,4 +119,4 @@
     "EventName": "PM_1FLOP_CMPL",
     "BriefDescription": "one flop (fadd, fmul, fsub, fcmp, fsel, fabs, fnabs, fres, fsqrte, fneg) operation completed"
   }
-]
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/translation.json b/tools/perf/pmu-events/arch/powerpc/power9/translation.json
index 8c0f12024afa..bc8e03d7a6b0 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/translation.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/translation.json
@@ -90,11 +90,6 @@
     "BriefDescription": "stcx failed"
   },
   {,
-    "EventCode": "0x20112",
-    "EventName": "PM_MRK_NTF_FIN",
-    "BriefDescription": "Marked next to finish instruction finished"
-  },
-  {,
     "EventCode": "0x300F0",
     "EventName": "PM_ST_MISS_L1",
     "BriefDescription": "Store Missed L1"
-- 
2.13.6
