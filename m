From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/24] perf jevents: Add some test events
Date: Wed, 25 Mar 2020 09:41:16 -0300
Message-ID: <20200325124124.32648-17-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, John Garry <john.garry@huawei.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@arm.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, linuxarm@huawei.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: John Garry <john.garry@huawei.com>

Add some test PMU events. The events are randomly chosen from x86 and
arm64 JSONs. The events include CPU and uncore events.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: James Clark <james.clark@arm.com>
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com
Link: http://lore.kernel.org/lkml/1584442939-8911-2-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../pmu-events/arch/test/test_cpu/branch.json | 12 +++++++++
 .../pmu-events/arch/test/test_cpu/other.json  | 26 +++++++++++++++++++
 .../pmu-events/arch/test/test_cpu/uncore.json | 21 +++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/branch.json
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/other.json
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/uncore.json

diff --git a/tools/perf/pmu-events/arch/test/test_cpu/branch.json b/tools/perf/pmu-events/arch/test/test_cpu/branch.json
new file mode 100644
index 000000000000..93ddfd8053ca
--- /dev/null
+++ b/tools/perf/pmu-events/arch/test/test_cpu/branch.json
@@ -0,0 +1,12 @@
+[
+  {
+    "EventName": "bp_l1_btb_correct",
+    "EventCode": "0x8a",
+    "BriefDescription": "L1 BTB Correction."
+  },
+  {
+    "EventName": "bp_l2_btb_correct",
+    "EventCode": "0x8b",
+    "BriefDescription": "L2 BTB Correction."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/test/test_cpu/other.json b/tools/perf/pmu-events/arch/test/test_cpu/other.json
new file mode 100644
index 000000000000..7d53d7ecd723
--- /dev/null
+++ b/tools/perf/pmu-events/arch/test/test_cpu/other.json
@@ -0,0 +1,26 @@
+[
+    {
+        "EventCode": "0x6",
+        "Counter": "0,1",
+        "UMask": "0x80",
+        "EventName": "SEGMENT_REG_LOADS.ANY",
+        "SampleAfterValue": "200000",
+        "BriefDescription": "Number of segment register loads."
+    },
+    {
+        "EventCode": "0x9",
+        "Counter": "0,1",
+        "UMask": "0x20",
+        "EventName": "DISPATCH_BLOCKED.ANY",
+        "SampleAfterValue": "200000",
+        "BriefDescription": "Memory cluster signals to block micro-op dispatch for any reason"
+    },
+    {
+        "EventCode": "0x3A",
+        "Counter": "0,1",
+        "UMask": "0x0",
+        "EventName": "EIST_TRANS",
+        "SampleAfterValue": "200000",
+        "BriefDescription": "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/test/test_cpu/uncore.json b/tools/perf/pmu-events/arch/test/test_cpu/uncore.json
new file mode 100644
index 000000000000..d0a890cc814d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/test/test_cpu/uncore.json
@@ -0,0 +1,21 @@
+[
+ {
+	    "EventCode": "0x02",
+	    "EventName": "uncore_hisi_ddrc.flux_wcmd",
+	    "BriefDescription": "DDRC write commands",
+	    "PublicDescription": "DDRC write commands",
+	    "Unit": "hisi_sccl,ddrc"
+   },
+   {
+	    "Unit": "CBO",
+	    "EventCode": "0x22",
+	    "UMask": "0x81",
+	    "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_EVICTION",
+	    "BriefDescription": "A cross-core snoop resulted from L3 Eviction which misses in some processor core.",
+	    "PublicDescription": "A cross-core snoop resulted from L3 Eviction which misses in some processor core.",
+	    "Counter": "0,1",
+	    "CounterMask": "0",
+	    "Invert": "0",
+	    "EdgeDetect": "0"
+  }
+]
-- 
2.21.1
