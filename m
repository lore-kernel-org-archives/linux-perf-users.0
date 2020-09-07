From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH v9 1/5] perf/jevents: Remove jevents.h file
Date: Mon,  7 Sep 2020 12:11:29 +0530
Message-ID: <20200907064133.75090-2-kjain@linux.ibm.com>
References: <20200907064133.75090-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200907064133.75090-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, john.garry@huawei.com, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

This patch removes jevents.h and makes json_events function static.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Reviewed-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/jevents.c |  3 +--
 tools/perf/pmu-events/jevents.h | 23 -----------------------
 2 files changed, 1 insertion(+), 25 deletions(-)
 delete mode 100644 tools/perf/pmu-events/jevents.h

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index fc9c158bfa13..b9b938aaff16 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -48,7 +48,6 @@
 #include <linux/list.h>
 #include "jsmn.h"
 #include "json.h"
-#include "jevents.h"
 
 int verbose;
 char *prog;
@@ -512,7 +511,7 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 }
 
 /* Call func with each event in the json file */
-int json_events(const char *fn,
+static int json_events(const char *fn,
 	  int (*func)(void *data, char *name, char *event, char *desc,
 		      char *long_desc,
 		      char *pmu, char *unit, char *perpkg,
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
deleted file mode 100644
index 2afc8304529e..000000000000
--- a/tools/perf/pmu-events/jevents.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef JEVENTS_H
-#define JEVENTS_H 1
-
-int json_events(const char *fn,
-		int (*func)(void *data, char *name, char *event, char *desc,
-				char *long_desc,
-				char *pmu,
-				char *unit, char *perpkg, char *metric_expr,
-				char *metric_name, char *metric_group,
-				char *deprecated, char *metric_constraint),
-		void *data);
-char *get_cpu_str(void);
-
-#ifndef min
-#define min(x, y) ({                            \
-	typeof(x) _min1 = (x);                  \
-	typeof(y) _min2 = (y);                  \
-	(void) (&_min1 == &_min2);              \
-	_min1 < _min2 ? _min1 : _min2; })
-#endif
-
-#endif
-- 
2.26.2
