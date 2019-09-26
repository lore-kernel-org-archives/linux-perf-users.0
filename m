From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 58/66] perf evlist: Remove unused perf_evlist__fprintf() method
Date: Wed, 25 Sep 2019 21:32:36 -0300
Message-ID: <20190926003244.13962-59-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Ditch it, noone is using it, one more stdio.h include in a hot header.

Fix the fallout in parse-events.y, where we end up using a FILE pointer,
I think due to YYDEBUG being set and in some places, like Amazon Linux 1
we don't get stdio.h included by luck, like in most other places, add a
explicit stdio.h include directive.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-37k5q0lhdbo2hvvfbnnzn7og@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c       | 13 -------------
 tools/perf/util/evlist.h       |  3 ---
 tools/perf/util/parse-events.y |  1 +
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d4c7fd125ce9..84c42790dab3 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1421,19 +1421,6 @@ int perf_evlist__parse_sample_timestamp(struct evlist *evlist,
 	return perf_evsel__parse_sample_timestamp(evsel, event, timestamp);
 }
 
-size_t perf_evlist__fprintf(struct evlist *evlist, FILE *fp)
-{
-	struct evsel *evsel;
-	size_t printed = 0;
-
-	evlist__for_each_entry(evlist, evsel) {
-		printed += fprintf(fp, "%s%s", evsel->idx ? ", " : "",
-				   perf_evsel__name(evsel));
-	}
-
-	return printed + fprintf(fp, "\n");
-}
-
 int perf_evlist__strerror_open(struct evlist *evlist,
 			       int err, char *buf, size_t size)
 {
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 130d44d691b8..7cfe75522ba5 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -7,7 +7,6 @@
 #include <linux/refcount.h>
 #include <linux/list.h>
 #include <api/fd/array.h>
-#include <stdio.h>
 #include <internal/evlist.h>
 #include <internal/evsel.h>
 #include "events_stats.h"
@@ -249,8 +248,6 @@ static inline struct evsel *evlist__last(struct evlist *evlist)
 	return container_of(evsel, struct evsel, core);
 }
 
-size_t perf_evlist__fprintf(struct evlist *evlist, FILE *fp);
-
 int perf_evlist__strerror_open(struct evlist *evlist, int err, char *buf, size_t size);
 int perf_evlist__strerror_mmap(struct evlist *evlist, int err, char *buf, size_t size);
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index f1c36ed1cf36..65809ad67808 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -9,6 +9,7 @@
 #define YYDEBUG 1
 
 #include <fnmatch.h>
+#include <stdio.h>
 #include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/types.h>
-- 
2.21.0
