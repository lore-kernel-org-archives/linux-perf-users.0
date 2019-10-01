From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/24] perf evsel: Fall back to global 'perf_env' in perf_evsel__env()
Date: Tue,  1 Oct 2019 08:12:10 -0300
Message-ID: <20191001111216.7208-19-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

I.e. if evsel->evlist or evsel->evlist->env isn't set, return the
environment for the running machine, as that would be set if reading
from a perf.data file.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-uqq4grmhbi12rwb0lfpo6lfu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c  | 3 ++-
 tools/perf/util/python.c | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5591af81a070..abc7fda4a0fe 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -30,6 +30,7 @@
 #include "counts.h"
 #include "event.h"
 #include "evsel.h"
+#include "util/env.h"
 #include "util/evsel_config.h"
 #include "util/evsel_fprintf.h"
 #include "evlist.h"
@@ -2512,7 +2513,7 @@ struct perf_env *perf_evsel__env(struct evsel *evsel)
 {
 	if (evsel && evsel->evlist)
 		return evsel->evlist->env;
-	return NULL;
+	return &perf_env;
 }
 
 static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 53f31053a27a..02460362256d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -14,6 +14,7 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
+#include "util/env.h"
 #include <internal/lib.h>
 #include "../perf-sys.h"
 
@@ -53,6 +54,11 @@ int parse_callchain_record(const char *arg __maybe_unused,
 	return 0;
 }
 
+/*
+ * Add this one here not to drag util/env.c
+ */
+struct perf_env perf_env;
+
 /*
  * Support debug printing even though util/debug.c is not linked.  That means
  * implementing 'verbose' and 'eprintf'.
-- 
2.21.0
