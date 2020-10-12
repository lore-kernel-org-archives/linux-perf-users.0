From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH] perf vendor events: Fix typos in power8 PMU events
Date: Mon, 12 Oct 2020 10:32:05 +0530
Message-ID: <20201012050205.328523-1-sandipan@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
To: acme@kernel.org
Cc: mpe@ellerman.id.au, ravi.bangoria@linux.ibm.com, sukadev@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, jolsa@redhat.com, kjain@linux.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

This replaces the incorrectly spelled word "localtion"
with "location" in some power8 PMU event descriptions.

Fixes: 2a81fa3bb5ed ("perf vendor events: Add power8 PMU events")
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 .../pmu-events/arch/powerpc/power8/cache.json    | 10 +++++-----
 .../pmu-events/arch/powerpc/power8/frontend.json | 12 ++++++------
 .../pmu-events/arch/powerpc/power8/marked.json   | 10 +++++-----
 .../pmu-events/arch/powerpc/power8/other.json    | 16 ++++++++--------
 .../arch/powerpc/power8/translation.json         |  2 +-
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/cache.json b/tools/perf/pmu-events/arch/powerpc/power8/cache.json
index 6b792b2c87e2..05a17084d939 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/cache.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/cache.json
@@ -32,8 +32,8 @@
   {
     "EventCode": "0x1c04e",
     "EventName": "PM_DATA_FROM_L2MISS_MOD",
-    "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L2 due to a demand load",
-    "PublicDescription": "The processor's data cache was reloaded from a localtion other than the local core's L2 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
+    "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L2 due to a demand load",
+    "PublicDescription": "The processor's data cache was reloaded from a location other than the local core's L2 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
   {
     "EventCode": "0x3c040",
@@ -74,8 +74,8 @@
   {
     "EventCode": "0x4c04e",
     "EventName": "PM_DATA_FROM_L3MISS_MOD",
-    "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to a demand load",
-    "PublicDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
+    "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L3 due to a demand load",
+    "PublicDescription": "The processor's data cache was reloaded from a location other than the local core's L3 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
   {
     "EventCode": "0x3c042",
@@ -134,7 +134,7 @@
   {
     "EventCode": "0x4e04e",
     "EventName": "PM_DPTEG_FROM_L3MISS",
-    "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L3 due to a data side request",
+    "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L3 due to a data side request",
     "PublicDescription": ""
   },
   {
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/frontend.json b/tools/perf/pmu-events/arch/powerpc/power8/frontend.json
index 1ddc30655d43..1c902a8263b6 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/frontend.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/frontend.json
@@ -116,8 +116,8 @@
   {
     "EventCode": "0x1404e",
     "EventName": "PM_INST_FROM_L2MISS",
-    "BriefDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L2 due to an instruction fetch (not prefetch)",
-    "PublicDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L2 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
+    "BriefDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L2 due to an instruction fetch (not prefetch)",
+    "PublicDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L2 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
   {
     "EventCode": "0x34040",
@@ -158,8 +158,8 @@
   {
     "EventCode": "0x4404e",
     "EventName": "PM_INST_FROM_L3MISS_MOD",
-    "BriefDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L3 due to a instruction fetch",
-    "PublicDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L3 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
+    "BriefDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L3 due to a instruction fetch",
+    "PublicDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L3 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
   {
     "EventCode": "0x34042",
@@ -320,7 +320,7 @@
   {
     "EventCode": "0x1504e",
     "EventName": "PM_IPTEG_FROM_L2MISS",
-    "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L2 due to a instruction side request",
+    "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L2 due to a instruction side request",
     "PublicDescription": ""
   },
   {
@@ -344,7 +344,7 @@
   {
     "EventCode": "0x4504e",
     "EventName": "PM_IPTEG_FROM_L3MISS",
-    "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L3 due to a instruction side request",
+    "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L3 due to a instruction side request",
     "PublicDescription": ""
   },
   {
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/marked.json b/tools/perf/pmu-events/arch/powerpc/power8/marked.json
index 94dc58b83b7e..6de61a797bbd 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/marked.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/marked.json
@@ -92,7 +92,7 @@
   {
     "EventCode": "0x4c12e",
     "EventName": "PM_MRK_DATA_FROM_L2MISS_CYC",
-    "BriefDescription": "Duration in cycles to reload from a localtion other than the local core's L2 due to a marked load",
+    "BriefDescription": "Duration in cycles to reload from a location other than the local core's L2 due to a marked load",
     "PublicDescription": ""
   },
   {
@@ -158,13 +158,13 @@
   {
     "EventCode": "0x201e4",
     "EventName": "PM_MRK_DATA_FROM_L3MISS",
-    "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to a marked load",
+    "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L3 due to a marked load",
     "PublicDescription": ""
   },
   {
     "EventCode": "0x2d12e",
     "EventName": "PM_MRK_DATA_FROM_L3MISS_CYC",
-    "BriefDescription": "Duration in cycles to reload from a localtion other than the local core's L3 due to a marked load",
+    "BriefDescription": "Duration in cycles to reload from a location other than the local core's L3 due to a marked load",
     "PublicDescription": ""
   },
   {
@@ -392,7 +392,7 @@
   {
     "EventCode": "0x1f14e",
     "EventName": "PM_MRK_DPTEG_FROM_L2MISS",
-    "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L2 due to a marked data side request",
+    "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L2 due to a marked data side request",
     "PublicDescription": ""
   },
   {
@@ -416,7 +416,7 @@
   {
     "EventCode": "0x4f14e",
     "EventName": "PM_MRK_DPTEG_FROM_L3MISS",
-    "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L3 due to a marked data side request",
+    "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L3 due to a marked data side request",
     "PublicDescription": ""
   },
   {
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/other.json b/tools/perf/pmu-events/arch/powerpc/power8/other.json
index f4e760cab111..84a0cedf1fd9 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/other.json
@@ -410,8 +410,8 @@
   {
     "EventCode": "0x61c04e",
     "EventName": "PM_DATA_ALL_FROM_L2MISS_MOD",
-    "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L2 due to either demand loads or data prefetch",
-    "PublicDescription": "The processor's data cache was reloaded from a localtion other than the local core's L2 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
+    "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L2 due to either demand loads or data prefetch",
+    "PublicDescription": "The processor's data cache was reloaded from a location other than the local core's L2 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
   {
     "EventCode": "0x63c040",
@@ -470,8 +470,8 @@
   {
     "EventCode": "0x64c04e",
     "EventName": "PM_DATA_ALL_FROM_L3MISS_MOD",
-    "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to either demand loads or data prefetch",
-    "PublicDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
+    "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L3 due to either demand loads or data prefetch",
+    "PublicDescription": "The processor's data cache was reloaded from a location other than the local core's L3 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
   {
     "EventCode": "0x63c042",
@@ -1280,8 +1280,8 @@
   {
     "EventCode": "0x51404e",
     "EventName": "PM_INST_ALL_FROM_L2MISS",
-    "BriefDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L2 due to instruction fetches and prefetches",
-    "PublicDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L2 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
+    "BriefDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L2 due to instruction fetches and prefetches",
+    "PublicDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L2 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
   {
     "EventCode": "0x534040",
@@ -1340,8 +1340,8 @@
   {
     "EventCode": "0x54404e",
     "EventName": "PM_INST_ALL_FROM_L3MISS_MOD",
-    "BriefDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L3 due to a instruction fetch",
-    "PublicDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L3 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
+    "BriefDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L3 due to a instruction fetch",
+    "PublicDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L3 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
   {
     "EventCode": "0x534042",
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/translation.json b/tools/perf/pmu-events/arch/powerpc/power8/translation.json
index 623e7475b010..a1657f5fdc6b 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/translation.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/translation.json
@@ -44,7 +44,7 @@
   {
     "EventCode": "0x1e04e",
     "EventName": "PM_DPTEG_FROM_L2MISS",
-    "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L2 due to a data side request",
+    "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L2 due to a data side request",
     "PublicDescription": ""
   },
   {
-- 
2.25.1
