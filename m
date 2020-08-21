From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH] perf/tools/pmu-events/powerpc: update nest metric event to utilize other metrics
Date: Fri, 21 Aug 2020 13:39:23 +0530
Message-ID: <20200821080923.126522-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@redhat.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

This patch take advantage of the new capability added to use
computed metrics in calculating other metrics. It also update
metric group for nest events to make it consistent for all nest
memory events.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../arch/powerpc/power9/nest_metrics.json      | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
index 8383a37647ad..a21e179edaf9 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
@@ -18,25 +18,25 @@
     },
     {
 	"MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@",
-	"MetricName" : "mcs01-read",
-	"MetricGroup" : "memory_bw",
+	"MetricName" : "mcs01_read",
+	"MetricGroup" : "memory-bandwidth",
 	"ScaleUnit": "6.1e-5MB"
     },
     {
 	"MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@",
-	"MetricName" : "mcs23-read",
-	"MetricGroup" : "memory_bw",
+	"MetricName" : "mcs23_read",
+	"MetricGroup" : "memory-bandwidth",
 	"ScaleUnit": "6.1e-5MB"
     },
     {
 	"MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@",
-	"MetricName" : "mcs01-write",
-	"MetricGroup" : "memory_bw",
+	"MetricName" : "mcs01_write",
+	"MetricGroup" : "memory-bandwidth",
 	"ScaleUnit": "6.1e-5MB"
     },
     {
 	"MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@",
-	"MetricName" : "mcs23-write",
+	"MetricName" : "mcs23_write",
 	"MetricGroup" : "memory-bandwidth",
 	"ScaleUnit": "6.1e-5MB"
     },
@@ -46,9 +46,9 @@
 	"ScaleUnit": "1e-9GHz"
     },
     {
-	"MetricExpr" : "(nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@)",
+	"MetricExpr" : "mcs01_read + mcs23_read + mcs01_write + mcs23_write",
 	"MetricName" : "Memory-bandwidth-MCS",
-	"MetricGroup" : "memory_bw",
+	"MetricGroup" : "memory-bandwidth",
 	"ScaleUnit": "6.1e-5MB"
     }
 ]
-- 
2.17.1
