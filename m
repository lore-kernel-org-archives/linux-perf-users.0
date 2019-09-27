From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/2] perf vendor events s390: Add JSON transaction for machine type 8561
Date: Fri, 27 Sep 2019 10:11:46 +0200
Message-ID: <20190927081147.18345-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: gor@linux.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Add s390 transaction counter definition for machine 8561. This
is the same file as for the predecessor machine.

Fixes: 6e67d77d673d7 ("perf vendor events s390: Add JSON files for machine type 8561")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json

diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json b/tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json
new file mode 100644
index 000000000000..1a0034f79f73
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json
@@ -0,0 +1,7 @@
+[
+  {
+    "BriefDescription": "Transaction count",
+    "MetricName": "transaction",
+    "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL"
+  }
+]
-- 
2.19.1
