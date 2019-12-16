From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/9] perf/x86/pmu-events: Fix Kernel_Utilization metric
Date: Mon, 16 Dec 2019 17:47:33 -0300
Message-ID: <20191216204738.12107-5-acme@kernel.org>
References: <20191216204738.12107-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216204738.12107-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Kernel Utilization should divide ref cycles spent in kernel with total
ref cycles.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Haiyan Song <haiyanx.song@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20191204162121.29998-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json     | 2 +-
 tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 2 +-
 tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json    | 2 +-
 tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json  | 2 +-
 tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json       | 2 +-
 tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json      | 2 +-
 tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json     | 2 +-
 tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json       | 2 +-
 tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json      | 2 +-
 tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json   | 2 +-
 tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json       | 2 +-
 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json      | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
index bc7151d639d7..45a34ce4fe89 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
@@ -297,7 +297,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
index 49c5f123d811..961fe4395758 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
@@ -115,7 +115,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
index 113d19e92678..746734ce09be 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
@@ -297,7 +297,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 2ba32af9bc36..f94653229dd4 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -315,7 +315,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
index c80f16fde6d0..5402cd3120f9 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
@@ -267,7 +267,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
index e501729c3dd1..832f3cb40b34 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
@@ -267,7 +267,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
index e2446966b651..d69b2a8fc0bc 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
@@ -285,7 +285,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
index 9294769dec64..5f465fd81315 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
@@ -285,7 +285,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
index 603ff9c2e9a1..3e909b306003 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
@@ -171,7 +171,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
index c6b485b3a2cb..50c053235752 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
@@ -171,7 +171,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index 0ca539bb60f6..e7feb60f9fa9 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -303,7 +303,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index 047d7e11aa6f..21d7a0c2c2e8 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -315,7 +315,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
-- 
2.21.0
