From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 107/107] perf vendor events power9: Added missing event descriptions
Date: Mon, 29 Jul 2019 23:56:10 -0300
Message-ID: <20190730025610.22603-108-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Carl Love <cel@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Paul Clarke <pc@us.ibm.com>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Michael Petlan <mpetlan@redhat.com>

Documentation source:

https://wiki.raptorcs.com/w/images/6/6b/POWER9_PMU_UG_v12_28NOV2018_pub.pdf

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Carl Love <cel@us.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
LPU-Reference: 20190719100837.7503-1-mpetlan@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/powerpc/power9/memory.json | 2 +-
 tools/perf/pmu-events/arch/powerpc/power9/other.json  | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/memory.json b/tools/perf/pmu-events/arch/powerpc/power9/memory.json
index 2e2ebc700c74..c3bb283e37e9 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/memory.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/memory.json
@@ -52,7 +52,7 @@
   {,
     "EventCode": "0x4D02C",
     "EventName": "PM_PMC1_REWIND",
-    "BriefDescription": ""
+    "BriefDescription": "PMC1 rewind event"
   },
   {,
     "EventCode": "0x15158",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/other.json b/tools/perf/pmu-events/arch/powerpc/power9/other.json
index 48cf4f920b3f..62b864269623 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/other.json
@@ -237,7 +237,7 @@
   {,
     "EventCode": "0xD0B0",
     "EventName": "PM_HWSYNC",
-    "BriefDescription": ""
+    "BriefDescription": "A hwsync instruction was decoded and transferred"
   },
   {,
     "EventCode": "0x168B0",
@@ -1232,7 +1232,7 @@
   {,
     "EventCode": "0xD8AC",
     "EventName": "PM_LWSYNC",
-    "BriefDescription": ""
+    "BriefDescription": "An lwsync instruction was decoded and transferred"
   },
   {,
     "EventCode": "0x2094",
@@ -1747,7 +1747,7 @@
   {,
     "EventCode": "0xD8B0",
     "EventName": "PM_PTESYNC",
-    "BriefDescription": ""
+    "BriefDescription": "A ptesync instruction was counted when the instruction is decoded and transmitted"
   },
   {,
     "EventCode": "0x26086",
@@ -2107,7 +2107,7 @@
   {,
     "EventCode": "0xF080",
     "EventName": "PM_LSU_STCX_FAIL",
-    "BriefDescription": ""
+    "BriefDescription": "The LSU detects the condition that a stcx instruction failed. No requirement to wait for a response from the nest"
   },
   {,
     "EventCode": "0x30038",
-- 
2.21.0
