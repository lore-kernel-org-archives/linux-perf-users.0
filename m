From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 067/107] libperf: Add perf_evlist__remove() function
Date: Mon, 29 Jul 2019 23:55:30 -0300
Message-ID: <20190730025610.22603-68-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding perf_evlist__remove() function to remove a perf_evsel from
a perf_evlist struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-41-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c              | 6 ++++++
 tools/perf/lib/include/perf/evlist.h | 2 ++
 tools/perf/lib/libperf.map           | 1 +
 tools/perf/util/evlist.c             | 2 +-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index e5f187fa4e57..023fe4b44131 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -14,3 +14,9 @@ void perf_evlist__add(struct perf_evlist *evlist,
 {
 	list_add_tail(&evsel->node, &evlist->entries);
 }
+
+void perf_evlist__remove(struct perf_evlist *evlist,
+			 struct perf_evsel *evsel)
+{
+	list_del_init(&evsel->node);
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 6992568b14a0..e0c87995c6ff 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -10,5 +10,7 @@ struct perf_evsel;
 LIBPERF_API void perf_evlist__init(struct perf_evlist *evlist);
 LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
 				  struct perf_evsel *evsel);
+LIBPERF_API void perf_evlist__remove(struct perf_evlist *evlist,
+				     struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 06ccf31eb24d..168339f89a2e 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -12,6 +12,7 @@ LIBPERF_0.0.1 {
 		perf_evsel__init;
 		perf_evlist__init;
 		perf_evlist__add;
+		perf_evlist__remove;
 	local:
 		*;
 };
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f2b86f49ab8d..9b0108c23010 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -194,7 +194,7 @@ void evlist__add(struct evlist *evlist, struct evsel *entry)
 void evlist__remove(struct evlist *evlist, struct evsel *evsel)
 {
 	evsel->evlist = NULL;
-	list_del_init(&evsel->core.node);
+	perf_evlist__remove(&evlist->core, &evsel->core);
 	evlist->nr_entries -= 1;
 }
 
-- 
2.21.0
