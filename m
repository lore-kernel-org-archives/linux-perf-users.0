From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH v4 3/5] perf jevents: Add support for parsing perchip/percore events
Date: Mon, 20 Jul 2020 12:31:25 +0530
Message-ID: <20200720070127.109234-4-kjain@linux.ibm.com>
References: <20200720070127.109234-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200720070127.109234-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, nasastry@in.ibm.com, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Added the "PerChiip" field  in enum "aggr_mode_classs" so that perf
knows they are per chip events.

Added the "PerCore" field in enum "aggr_mode_class" so that perf
knows they are per core events.

Similar to the way we had "PerPkg field to specify perpkg events.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.c    | 4 ++++
 tools/perf/pmu-events/pmu-events.h | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 6601f1fd2e80..2f48b783a64d 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -58,6 +58,10 @@ enum aggr_mode_class convert(const char *aggr_mode)
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
index 71b7aa6278d0..214ffc681b54 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -3,7 +3,9 @@
 #define PMU_EVENTS_H
 
 enum aggr_mode_class {
-	PerPkg = 1
+	PerPkg = 1,
+	PerChip,
+	PerCore
 };
 
 /*
-- 
2.26.2
