From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 3/4] perf json: Add s390 transaction counter definition
Date: Thu, 21 Jun 2018 10:04:51 +0200
Message-ID: <20180621080452.61012-3-tmricht@linux.ibm.com>
References: <20180621080452.61012-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621080452.61012-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

perf stat displays transactional counters using flag -T on x86.
On s390 use a json file defined metric named transaction to
achieve the same result.

Output before:
 none

Output after:
[root@s35lp76 perf]# ./perf stat -M transaction  -- \
			~/mytesttx 1 >/tmp/111

 Performance counter stats for '/root/mytesttx 1':

                 1      tx_c_tend           #     13.0 transaction
                 1      tx_nc_tend
                11      tx_nc_tabort
                 0      tx_c_tabort_special
                 0      tx_c_tabort_no_special

       0.001061232 seconds time elapsed

[root@s35lp76 perf]#

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/pmu-events/arch/s390/cf_z13/transaction.json   | 7 +++++++
 tools/perf/pmu-events/arch/s390/cf_z14/transaction.json   | 7 +++++++
 tools/perf/pmu-events/arch/s390/cf_zec12/transaction.json | 7 +++++++
 3 files changed, 21 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_zec12/transaction.json

diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
new file mode 100644
index 000000000000..1a0034f79f73
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
@@ -0,0 +1,7 @@
+[
+  {
+    "BriefDescription": "Transaction count",
+    "MetricName": "transaction",
+    "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
new file mode 100644
index 000000000000..1a0034f79f73
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
@@ -0,0 +1,7 @@
+[
+  {
+    "BriefDescription": "Transaction count",
+    "MetricName": "transaction",
+    "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_zec12/transaction.json b/tools/perf/pmu-events/arch/s390/cf_zec12/transaction.json
new file mode 100644
index 000000000000..1a0034f79f73
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_zec12/transaction.json
@@ -0,0 +1,7 @@
+[
+  {
+    "BriefDescription": "Transaction count",
+    "MetricName": "transaction",
+    "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL"
+  }
+]
-- 
2.14.3
