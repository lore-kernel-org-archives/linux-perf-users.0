From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH v2 8/8] perf/tools/pmu-events/powerpc: Add hv_24x7 socket/chip
 level metric events
Date: Fri, 21 Feb 2020 11:40:22 +0530
Message-ID: <20200221061022.3047-9-kjain@linux.ibm.com>
References: <20200221061022.3047-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
In-Reply-To: <20200221061022.3047-1-kjain@linux.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
To: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, suka@us.ibm.com
Cc: mark.rutland@arm.com, ravi.bangoria@linux.ibm.com, maddy@linux.vnet.ibm.com, tglx@linutronix.de, jmario@redhat.com, peterz@infradead.org, gregkh@linuxfoundation.org, mpetlan@redhat.com, alexander.shishkin@linux.intel.com, linux-perf-users@vger.kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, anju@linux.vnet.ibm.com, mamatha4@linux.vnet.ibm.com, kjain@linux.ibm.com, jolsa@kernel.org, namhyung@kernel.org, mingo@kernel.org, kan.liang@linux.intel.com
List-Id: linux-perf-users.vger.kernel.org

The hv_24×7 feature in IBM® POWER9™ processor-based servers provide the
facility to continuously collect large numbers of hardware performance
metrics efficiently and accurately.
This patch adds hv_24x7  metric file for different Socket/chip
resources.

Result:

power9 platform:

command:# ./perf stat --metric-only -M Memory_RD_BW_Chip -C 0
           -I 1000 sleep 1

time MB       Memory_RD_BW_Chip_0 MB   Memory_RD_BW_Chip_1 MB
1.000192635                      0.4                      0.0
1.001695883                      0.0                      0.0

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../arch/powerpc/power9/nest_metrics.json     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
new file mode 100644
index 000000000000..ac38f5540ac6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
@@ -0,0 +1,19 @@
+[
+    {
+        "MetricExpr": "(hv_24x7@PM_MCS01_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_RD_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT23\\,chip\\=?@)",
+        "MetricName": "Memory_RD_BW_Chip",
+        "MetricGroup": "Memory_BW",
+        "ScaleUnit": "1.6e-2MB"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_MCS01_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_WR_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT23\\,chip\\=?@ )",
+        "MetricName": "Memory_WR_BW_Chip",
+        "MetricGroup": "Memory_BW",
+        "ScaleUnit": "1.6e-2MB"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_PB_CYC\\,chip\\=?@ )",
+        "MetricName": "PowerBUS_Frequency",
+        "ScaleUnit": "2.5e-7GHz"
+    }
+]
-- 
2.18.1
