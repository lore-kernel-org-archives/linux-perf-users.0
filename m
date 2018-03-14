From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 2/2 v2] perf stat: Add support for flag T on s390
Date: Wed, 14 Mar 2018 13:40:04 +0100
Message-ID: <20180314124004.98937-2-tmricht@linux.vnet.ibm.com>
References: <20180314124004.98937-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314124004.98937-1-tmricht@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

This patch adds support for command 'perf stat -T' on s390.
It adds s390 specfic counter table for transactions.
The architecture is queried and the event string for
transaction counters is constructed
depending on the s390 type and model CPU measurement
facility counter list.

Output Before:
[root@s35lp76 perf]# perf stat -T -- sleep 1
Cannot set up transaction events
[root@s35lp76 perf]#

Output after:
[root@s35lp76 perf]# ./perf stat -T -- sleep 1

 Performance counter stats for 'sleep 1':

   0.939985      task-clock (msec)         #    0.001 CPUs utilized
  2,557,145      instructions              #    0.53  insn per cycle
  4,785,929      cycles                    #    5.091 GHz
          0      cpum_cf/TX_C_TABORT_NO_SPECIAL/ #    0.000 K/sec
          0      cpum_cf/TX_C_TABORT_SPECIAL/ #    0.000 K/sec
          0      cpum_cf/TX_C_TEND/        #    0.000 K/sec
          0      cpum_cf/TX_NC_TABORT/     #    0.000 K/sec
          0      cpum_cf/TX_NC_TEND/       #    0.000 K/sec

  1.001934710 seconds time elapsed

[root@s35lp76 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/builtin-stat.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8d7b97c708e4..943ed3648049 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2162,10 +2162,40 @@ static struct pmu_tx_events x86_tx_events[] = {/* x86 transaction counters */
 	}
 };
 
+static struct pmu_tx_events s390_tx_events[] = {/* s390 transaction counters */
+	{
+		.pmu = "cpum_cf",
+		.name = "TX_C_TABORT_NO_SPECIAL",
+	},
+	{
+		.pmu = "cpum_cf",
+		.name = "TX_C_TABORT_SPECIAL",
+	},
+	{
+		.pmu = "cpum_cf",
+		.name = "TX_C_TEND",
+	},
+	{
+		.pmu = "cpum_cf",
+		.name = "TX_NC_TABORT",
+	},
+	{
+		.pmu = "cpum_cf",
+		.name = "TX_NC_TEND",
+	},
+	{
+		.pmu = 0
+	}
+};
+
 struct arch_pmu_tx_events {
 	const char *archname;		/* Architecture name */
 	struct pmu_tx_events *tx;	/* Architecture specific counters */
 } arch_pmu_tx_events[] = {
+	{
+		.archname = "s390",
+		.tx = s390_tx_events
+	},
 	{
 		.archname = "x86",
 		.tx = x86_tx_events
-- 
2.14.3
