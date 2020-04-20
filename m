From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 37/60] perf evsel: Move and globalize perf_evsel__find_pmu() and perf_evsel__is_aux_event()
Date: Mon, 20 Apr 2020 08:52:53 -0300
Message-ID: <20200420115316.18781-38-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Move and globalize 2 functions from the auxtrace specific sources so
that they can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-13-adrian.hunter@intel.com
[ Move to pmu.c, as moving to evsel.h breaks the python binding ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 19 -------------------
 tools/perf/util/evsel.h    |  3 +++
 tools/perf/util/pmu.c      | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 809a09e75c55..33ad33378a90 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -58,25 +58,6 @@
 #include "symbol/kallsyms.h"
 #include <internal/lib.h>
 
-static struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
-{
-	struct perf_pmu *pmu = NULL;
-
-	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
-		if (pmu->type == evsel->core.attr.type)
-			break;
-	}
-
-	return pmu;
-}
-
-static bool perf_evsel__is_aux_event(struct evsel *evsel)
-{
-	struct perf_pmu *pmu = perf_evsel__find_pmu(evsel);
-
-	return pmu && pmu->auxtrace;
-}
-
 /*
  * Make a group from 'leader' to 'last', requiring that the events were not
  * already grouped to a different leader.
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index e64ed4202cab..a463bc65b001 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -158,6 +158,9 @@ int perf_evsel__object_config(size_t object_size,
 			      int (*init)(struct evsel *evsel),
 			      void (*fini)(struct evsel *evsel));
 
+struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel);
+bool perf_evsel__is_aux_event(struct evsel *evsel);
+
 struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx);
 
 static inline struct evsel *evsel__new(struct perf_event_attr *attr)
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ef6a63f3d386..bc912a84b5e9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -18,6 +18,7 @@
 #include <regex.h>
 #include <perf/cpumap.h>
 #include "debug.h"
+#include "evsel.h"
 #include "pmu.h"
 #include "parse-events.h"
 #include "header.h"
@@ -884,6 +885,25 @@ struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu)
 	return NULL;
 }
 
+struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
+{
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (pmu->type == evsel->core.attr.type)
+			break;
+	}
+
+	return pmu;
+}
+
+bool perf_evsel__is_aux_event(struct evsel *evsel)
+{
+	struct perf_pmu *pmu = perf_evsel__find_pmu(evsel);
+
+	return pmu && pmu->auxtrace;
+}
+
 struct perf_pmu *perf_pmu__find(const char *name)
 {
 	struct perf_pmu *pmu;
-- 
2.21.1
