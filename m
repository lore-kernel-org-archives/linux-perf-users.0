From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/27] Revert "perf list: Add s390 support for detailed/verbose PMU event description"
Date: Wed, 25 Jul 2018 14:59:39 -0300
Message-ID: <20180725180001.15108-6-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

This reverts commit 038586c34301578e538f6c5aa79ca82bce1b9152.

Fix the support of detailed/verbose PMU event description by using the
"Unit": keyword in the json files to address event names refering to the
/sys/devices/cpum_[cs]f devices.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180621080452.61012-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 3ba6a1742f91..afd68524ffa9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -652,12 +652,6 @@ static int is_arm_pmu_core(const char *name)
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
2.14.4
