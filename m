From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/list: Fix s390 counter long description for L1D_RO_EXCL_WRITES
Date: Fri, 29 Mar 2019 14:33:37 +0100
Message-ID: <20190329133337.60255-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Command
  # ./perf list --long-desc pmu
lists the long description of the available counters. For counter
named L1D_RO_EXCL_WRITES on machine types 3906 and 3907 the long
description contains the counter number 'Counter:128 Name:'
prefix. This is wrong.

The fix changes the description text and removes this prefix.

Output before:

[root@m35lp76 perf]# ./perf list --long-desc pmu
 ...
 L1D_ONDRAWER_L4_SOURCED_WRITES
  [A directory write to the Level-1 Data cache directory where the
   returned cache line was sourced from On-Drawer Level-4 cache]

 L1D_RO_EXCL_WRITES
  [Counter:128 Name:L1D_RO_EXCL_WRITES A directory write to the Level-1
   Data cache where the line was originally in a Read-Only state in the
   cache but has been updated to be in the Exclusive state that allows
   stores to the cache line]

 ...

Output after:

[root@m35lp76 perf]# ./perf list --long-desc pmu
 ...
 L1D_ONDRAWER_L4_SOURCED_WRITES
  [A directory write to the Level-1 Data cache directory where the
   returned cache line was sourced from On-Drawer Level-4 cache]

 L1D_RO_EXCL_WRITES
  [L1D_RO_EXCL_WRITES A directory write to the Level-1
   Data cache where the line was originally in a Read-Only state in the
   cache but has been updated to be in the Exclusive state that allows
   stores to the cache line]

 ...

Fixes: 109d59b900e7 ("perf vendor events s390: Add JSON files for IBM z14")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/pmu-events/arch/s390/cf_z14/extended.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
index e7a3524b748f..68618152ea2c 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
@@ -4,7 +4,7 @@
 		"EventCode": "128",
 		"EventName": "L1D_RO_EXCL_WRITES",
 		"BriefDescription": "L1D Read-only Exclusive Writes",
-		"PublicDescription": "Counter:128	Name:L1D_RO_EXCL_WRITES A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
+		"PublicDescription": "L1D_RO_EXCL_WRITES A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
 	},
 	{
 		"Unit": "CPU-M-CF",
-- 
2.19.1
