From: Kajol Jain <kjain@linux.ibm.com>
Subject: [RFC 3/3] perf/tools/pmu_events/powerpc: Add hv_24x7 core level metric events
Date: Thu, 25 Jun 2020 17:17:18 +0530
Message-ID: <20200625114718.229911-4-kjain@linux.ibm.com>
References: <20200625114718.229911-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200625114718.229911-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

This patch adds hv_24x7 core level events in nest_metric.json file
and also add PerChip/PerCore field in metric events.

Result:

power9 platform:

command:# ./perf stat --metric-only -M PowerBUS_Frequency -C 0 -I 1000
     1.000070601                        1.9                        2.0
     2.000253881                        2.0                        1.9
     3.000364810                        2.0                        2.0

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../arch/powerpc/power9/nest_metrics.json         | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
index c121e526442a..1f9c4ec12f67 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
@@ -3,17 +3,26 @@
         "MetricExpr": "(hv_24x7@PM_MCS01_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_RD_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT23\\,chip\\=?@)",
         "MetricName": "Memory_RD_BW_Chip",
         "MetricGroup": "Memory_BW",
-        "ScaleUnit": "1.6e-2MB"
+        "ScaleUnit": "1.6e-2MB",
+	"PerChip": "1"
     },
     {
 	"MetricExpr": "(hv_24x7@PM_MCS01_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_WR_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT23\\,chip\\=?@ )",
         "MetricName": "Memory_WR_BW_Chip",
         "MetricGroup": "Memory_BW",
-        "ScaleUnit": "1.6e-2MB"
+        "ScaleUnit": "1.6e-2MB",
+	"PerChip": "1"
     },
     {
 	"MetricExpr": "(hv_24x7@PM_PB_CYC\\,chip\\=?@ )",
         "MetricName": "PowerBUS_Frequency",
-        "ScaleUnit": "2.5e-7GHz"
+        "ScaleUnit": "2.5e-7GHz",
+	"PerChip": "1"
+    },
+    {
+	"MetricExpr": "(hv_24x7@CPM_CS_32MHZ_CYC\\,domain\\=3\\,core\\=?@ )",
+        "MetricName": "CPM_CS_32MHZ_CYC",
+        "ScaleUnit": "1MHz",
+	"PerCore": "1"
     }
 ]
-- 
2.26.2
