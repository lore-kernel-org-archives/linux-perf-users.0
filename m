From: Kajol Jain <kjain@linux.ibm.com>
Subject: [RFC v2 3/5] perf jevents: Add support for parsing perchip/percore events
Date: Tue,  7 Jul 2020 17:53:12 +0530
Message-ID: <20200707122314.624400-4-kjain@linux.ibm.com>
References: <20200707122314.624400-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200707122314.624400-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, nasastry@in.ibm.com, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Added the "PerChip" field  in enum so that perf knows they are
per chip events.

Added the "PerCore" field in enum so that perf knows they are
per core events and add these fields to pmu_event structure.

Similar to the way we had "PerPkg field
to specify perpkg events.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/pmu-events/jevents.c    | 8 +++++++-
 tools/perf/pmu-events/pmu-events.h | 4 +++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index b2f59f0af63d..1f65047db000 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -54,13 +54,19 @@ int verbose;
 char *prog;
 
 enum aggr_mode_class {
-	PerPkg = 1
+	PerChip = 0,
+	PerPkg = 1,
+	PerCore = 2
 };
 
 enum aggr_mode_class convert(const char *aggr_mode)
 {
 	if (!strcmp(aggr_mode, "PerPkg"))
 		return PerPkg;
+	else if (!strcmp(aggr_mode, "PerCore"))
+		return PerCore;
+	else if (!strcmp(aggr_mode, "PerChip"))
+		return PerChip;
 	return -1;
 }
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 71b7aa6278d0..114ae1559358 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -3,7 +3,9 @@
 #define PMU_EVENTS_H
 
 enum aggr_mode_class {
-	PerPkg = 1
+	PerChip = 0,
+	PerPkg = 1,
+	PerCore = 2
 };
 
 /*
-- 
2.26.2
