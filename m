From: "Paul A. Clarke" <pc@us.ibm.com>
Subject: [PATCH] perf stat: POWER9 metrics: expand "ICT" acronym
Date: Tue, 19 May 2020 14:18:06 -0500
Message-ID: <1589915886-22992-1-git-send-email-pc@us.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org
Cc: mpe@ellerman.id.au, ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com, irogers@google.com
List-Id: linux-perf-users.vger.kernel.org

From: "Paul A. Clarke" <pc@us.ibm.com>

Uses of "ICT" and "Ict" are expanded to "Instruction Completion Table".

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
 .../arch/powerpc/power9/metrics.json          | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
index f371104dcbe3..80816d6402e9 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
@@ -208,19 +208,19 @@
         "MetricName": "fxu_stall_cpi"
     },
     {
-        "BriefDescription": "Ict empty for this thread due to branch mispred",
+        "BriefDescription": "Instruction Completion Table empty for this thread due to branch mispred",
         "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_br_mpred_cpi"
     },
     {
-        "BriefDescription": "Ict empty for this thread due to Icache Miss and branch mispred",
+        "BriefDescription": "Instruction Completion Table empty for this thread due to Icache Miss and branch mispred",
         "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED_ICMISS/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_br_mpred_icmiss_cpi"
     },
     {
-        "BriefDescription": "ICT other stalls",
+        "BriefDescription": "Instruction Completion Table other stalls",
         "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HELD)/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_cyc_other_cpi"
@@ -232,13 +232,13 @@
         "MetricName": "ict_noslot_disp_held_cpi"
     },
     {
-        "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
+        "BriefDescription": "Instruction Completion Table empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
         "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_HB_FULL/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_disp_held_hb_full_cpi"
     },
     {
-        "BriefDescription": "Ict empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
+        "BriefDescription": "Instruction Completion Table empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
         "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_ISSQ/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_disp_held_issq_cpi"
@@ -268,19 +268,19 @@
         "MetricName": "ict_noslot_ic_l2_cpi"
     },
     {
-        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from the local L3",
+        "BriefDescription": "Instruction Completion Table empty for this thread due to icache misses that were sourced from the local L3",
         "MetricExpr": "PM_ICT_NOSLOT_IC_L3/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_ic_l3_cpi"
     },
     {
-        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
+        "BriefDescription": "Instruction Completion Table empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
         "MetricExpr": "PM_ICT_NOSLOT_IC_L3MISS/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_ic_l3miss_cpi"
     },
     {
-        "BriefDescription": "Ict empty for this thread due to Icache Miss",
+        "BriefDescription": "Instruction Completion Table empty for this thread due to Icache Miss",
         "MetricExpr": "PM_ICT_NOSLOT_IC_MISS/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_ic_miss_cpi"
@@ -391,7 +391,7 @@
         "MetricName": "nested_tend_stall_cpi"
     },
     {
-        "BriefDescription": "Number of cycles the ICT has no itags assigned to this thread",
+        "BriefDescription": "Number of cycles the Instruction Completion Table has no itags assigned to this thread",
         "MetricExpr": "PM_ICT_NOSLOT_CYC/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "nothing_dispatched_cpi"
@@ -503,7 +503,7 @@
         "MetricName": "st_fwd_stall_cpi"
     },
     {
-        "BriefDescription": "Nothing completed and ICT not empty",
+        "BriefDescription": "Nothing completed and Instruction Completion Table not empty",
         "MetricExpr": "PM_CMPLU_STALL/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "stall_cpi"
-- 
2.18.2
