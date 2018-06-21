From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/4] Revert "perf list: Add s390 support for detailed/verbose PMU event description"
Date: Thu, 21 Jun 2018 10:04:49 +0200
Message-ID: <20180621080452.61012-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

This reverts commit 038586c34301578e538f6c5aa79ca82bce1b9152.

Fix the support of detailed/verbose PMU event description
by using the "Unit": keyword in the json files to address
event names refering to the /sys/devices/cpum_[cs]f
devices.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/util/pmu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d2fb597c9a8c..7878934ebb23 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -557,12 +557,6 @@ static int is_arm_pmu_core(const char *name)
 	if (stat(path, &st) == 0)
 		return 1;
 
-	/* Look for cpu sysfs (specific to s390) */
-	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s",
-		  sysfs, name);
-	if (stat(path, &st) == 0 && !strncmp(name, "cpum_", 5))
-		return 1;
-
 	return 0;
 }
 
-- 
2.14.3
