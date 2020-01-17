From: Kajol Jain <kjain@linux.ibm.com>
Subject: [RFC 6/6] perf/tools/pmu-events/powerpc: Add hv_24x7 socket/chip level metric events
Date: Fri, 17 Jan 2020 18:16:20 +0530
Message-ID: <20200117124620.26094-7-kjain@linux.ibm.com>
References: <20200117124620.26094-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200117124620.26094-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, kjain@linux.ibm.com, benh@kernel.crashing.org
List-Id: linux-perf-users.vger.kernel.org

The hv_24×7 feature in IBM® POWER9™ processor-based servers provide the
facility to continuously collect large numbers of hardware performance
metrics efficiently and accurately.
This patch adds hv_24x7 json metric file for different Socket/chip
resources.

Result:

power9 platform:

command:# ./perf stat --metric-only -M Memory_RD_BW_Chip? -C 0
	   -I 1000 sleep 1

time MB       Memory_RD_BW_Chip_0 MB   Memory_RD_BW_Chip_1 MB
1.000192635                      0.4                      0.0
1.001695883                      0.0                      0.0

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../arch/powerpc/power9/hv_24x7_metrics.json  | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/hv_24x7_metrics.json

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/hv_24x7_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/hv_24x7_metrics.json
new file mode 100644
index 000000000000..52d0116e61c2
--- /dev/null
+++ b/tools/perf/pmu-events/arch/powerpc/power9/hv_24x7_metrics.json
@@ -0,0 +1,64 @@
+[
+    {
+        "MetricExpr": "(hv_24x7@PM_MCS01_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_RD_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT23\\,chip\\=?@)",
+        "MetricName": "Memory_RD_BW_Chip?",
+        "MetricGroup": "Memory_BW",
+        "ScaleUnit": "1.6e-2MB"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_MCS01_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_WR_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT23\\,chip\\=?@ )",
+        "MetricName": "Memory_WR_BW_Chip?",
+        "MetricGroup": "Memory_BW",
+        "ScaleUnit": "1.6e-2MB"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_XLINK0_OUT_ODD_DATA_COUNT\\,chip\\=?@ + hv_24x7@PM_XLINK0_OUT_EVEN_DATA_COUNT\\,chip\\=?@ )",
+        "MetricName": "XBUS0_OUT_DATA_THRUPUT?",
+        "ScaleUnit": "6.5e-2MB"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_XLINK0_OUT_ODD_DATA_COUNT\\,chip\\=?@ + hv_24x7@PM_XLINK0_OUT_EVEN_DATA_COUNT\\,chip\\=?@ )",
+        "MetricName": "XBUS0_OUT_DATA_UTILIZATION?",
+        "ScaleUnit": "53.125%"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_XLINK0_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK0_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@ )",
+        "MetricName": "XBUS0_OUT_TOTAL_UTILIZATION?",
+        "ScaleUnit": "50%"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_XLINK1_OUT_ODD_DATA_COUNT\\,chip\\=?@ + hv_24x7@PM_XLINK1_OUT_EVEN_DATA_COUNT\\,chip\\=?@ )",
+        "MetricName": "XBUS1_OUT_DATA_THRUPUT?",
+        "ScaleUnit": "6.5e-2MB"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_XLINK1_OUT_ODD_DATA_COUNT\\,chip\\=?@ + hv_24x7@PM_XLINK1_OUT_EVEN_DATA_COUNT\\,chip\\=?@ )",
+        "MetricName": "XBUS1_OUT_DATA_UTILIZATION?",
+        "ScaleUnit": "53.125%"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_XLINK1_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK1_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@ )",
+        "MetricName": "XBUS1_OUT_TOTAL_UTILIZATION?",
+        "ScaleUnit": "50%"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_XLINK2_OUT_ODD_DATA_COUNT\\,chip\\=?@ + hv_24x7@PM_XLINK2_OUT_EVEN_DATA_COUNT\\,chip\\=?@ )",
+        "MetricName": "XBUS2_OUT_DATA_THRUPUT?",
+        "ScaleUnit": "6.5e-2MB"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_XLINK2_OUT_ODD_DATA_COUNT\\,chip\\=?@ + hv_24x7@PM_XLINK2_OUT_EVEN_DATA_COUNT\\,chip\\=?@ )",
+        "MetricName": "XBUS2_OUT_DATA_UTILIZATION?",
+        "ScaleUnit": "53.125%"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_XLINK2_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK2_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@ )",
+        "MetricName": "XBUS2_OUT_TOTAL_UTILIZATION?",
+        "ScaleUnit": "50%"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_PB_CYC\\,chip\\=?@ )",
+        "MetricName": "PowerBUS_Frequency?",
+        "ScaleUnit": "2.56e-7GHz"
+    }
+]
-- 
2.18.1
