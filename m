From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/91] perf vendor events power9: Add hv_24x7 socket/chip level metric events
Date: Wed,  6 May 2020 12:21:24 -0300
Message-ID: <20200506152234.21977-22-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kajol Jain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jin Yao <yao.jin@linux.intel.com>, Joe Mario <jmario@redhat.com>, Kan Liang <kan.liang@linux.intel.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Michael Petlan <mpetlan@red>
List-Id: linux-perf-users.vger.kernel.org

From: Kajol Jain <kjain@linux.ibm.com>

The hv_24×7 feature in IBM® POWER9™ processor-based servers provide the
facility to continuously collect large numbers of hardware performance
metrics efficiently and accurately.

This patch adds hv_24x7  metric file for different Socket/chip
resources.

Result:

power9 platform:

  command:# ./perf stat --metric-only -M Memory_RD_BW_Chip -C 0 -I 1000

     1.000096188          0.9           0.3
     2.000285720          0.5           0.1
     3.000424990          0.4           0.1

  command:# ./perf stat --metric-only -M PowerBUS_Frequency -C 0 -I 1000

     1.000097981          2.3           2.3
     2.000291713          2.3           2.3
     3.000421719          2.3           2.3
     4.000550912          2.3           2.3

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lore.kernel.org/lkml/20200401203340.31402-8-kjain@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/powerpc/power9/nest_metrics.json     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
new file mode 100644
index 000000000000..c121e526442a
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
+	"MetricExpr": "(hv_24x7@PM_MCS01_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_WR_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT23\\,chip\\=?@ )",
+        "MetricName": "Memory_WR_BW_Chip",
+        "MetricGroup": "Memory_BW",
+        "ScaleUnit": "1.6e-2MB"
+    },
+    {
+	"MetricExpr": "(hv_24x7@PM_PB_CYC\\,chip\\=?@ )",
+        "MetricName": "PowerBUS_Frequency",
+        "ScaleUnit": "2.5e-7GHz"
+    }
+]
-- 
2.21.1
