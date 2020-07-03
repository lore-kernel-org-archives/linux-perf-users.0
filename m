From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH] perf/tools/pmu-events/powerpc: Added nest imc metric events
Date: Fri,  3 Jul 2020 12:26:58 +0530
Message-ID: <20200703065658.377467-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, nasastry@in.ibm.com, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Added nest imc metric events.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../arch/powerpc/power9/nest_metrics.json     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
index c121e526442a..8383a37647ad 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
@@ -15,5 +15,40 @@
 	"MetricExpr": "(hv_24x7@PM_PB_CYC\\,chip\\=?@ )",
         "MetricName": "PowerBUS_Frequency",
         "ScaleUnit": "2.5e-7GHz"
+    },
+    {
+	"MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@",
+	"MetricName" : "mcs01-read",
+	"MetricGroup" : "memory_bw",
+	"ScaleUnit": "6.1e-5MB"
+    },
+    {
+	"MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@",
+	"MetricName" : "mcs23-read",
+	"MetricGroup" : "memory_bw",
+	"ScaleUnit": "6.1e-5MB"
+    },
+    {
+	"MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@",
+	"MetricName" : "mcs01-write",
+	"MetricGroup" : "memory_bw",
+	"ScaleUnit": "6.1e-5MB"
+    },
+    {
+	"MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@",
+	"MetricName" : "mcs23-write",
+	"MetricGroup" : "memory-bandwidth",
+	"ScaleUnit": "6.1e-5MB"
+    },
+    {
+	"MetricExpr" : "nest_powerbus0_imc@PM_PB_CYC@",
+	"MetricName" : "powerbus_freq",
+	"ScaleUnit": "1e-9GHz"
+    },
+    {
+	"MetricExpr" : "(nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@)",
+	"MetricName" : "Memory-bandwidth-MCS",
+	"MetricGroup" : "memory_bw",
+	"ScaleUnit": "6.1e-5MB"
     }
 ]
-- 
2.17.1
