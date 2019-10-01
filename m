From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/24] perf vendor events s390: Add JSON transaction for machine type 8561
Date: Tue,  1 Oct 2019 08:12:02 -0300
Message-ID: <20191001111216.7208-11-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Add s390 transaction counter definition for machine 8561. This is the
same file as for the predecessor machine.

Fixes: 6e67d77d673d ("perf vendor events s390: Add JSON files for machine type 8561")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20190927081147.18345-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.21.0
