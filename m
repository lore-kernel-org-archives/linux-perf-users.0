From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 040/107] perf evlist: Rename perf_evlist__remove() to evlist__remove()
Date: Mon, 29 Jul 2019 23:55:03 -0300
Message-ID: <20190730025610.22603-41-acme@kernel.org>
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

Rename perf_evlist__remove() to evlist__remove(), so we don't have a
name clash when we add perf_evlist__remove() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-14-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 4 ++--
 tools/perf/util/evlist.c    | 2 +-
 tools/perf/util/evlist.h    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 917c8fb4baa5..4e56e399bbc8 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -622,7 +622,7 @@ static void strip_fini(struct perf_inject *inject)
 		if (evsel->handler == drop_sample &&
 		    ok_to_remove(evlist, evsel)) {
 			pr_debug("Deleting %s\n", perf_evsel__name(evsel));
-			perf_evlist__remove(evlist, evsel);
+			evlist__remove(evlist, evsel);
 			evsel__delete(evsel);
 		}
 	}
@@ -724,7 +724,7 @@ static int __cmd_inject(struct perf_inject *inject)
 			if (evsel) {
 				pr_debug("Deleting %s\n",
 					 perf_evsel__name(evsel));
-				perf_evlist__remove(session->evlist, evsel);
+				evlist__remove(session->evlist, evsel);
 				evsel__delete(evsel);
 			}
 			if (inject->strip)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7741e12bdcb0..47516db62424 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -190,7 +190,7 @@ void evlist__add(struct evlist *evlist, struct evsel *entry)
 	__perf_evlist__propagate_maps(evlist, entry);
 }
 
-void perf_evlist__remove(struct evlist *evlist, struct evsel *evsel)
+void evlist__remove(struct evlist *evlist, struct evsel *evsel)
 {
 	evsel->evlist = NULL;
 	list_del_init(&evsel->node);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index d52b29a1d852..b3a44e2eed08 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -74,7 +74,7 @@ void perf_evlist__exit(struct evlist *evlist);
 void evlist__delete(struct evlist *evlist);
 
 void evlist__add(struct evlist *evlist, struct evsel *entry);
-void perf_evlist__remove(struct evlist *evlist, struct evsel *evsel);
+void evlist__remove(struct evlist *evlist, struct evsel *evsel);
 
 int __perf_evlist__add_default(struct evlist *evlist, bool precise);
 
-- 
2.21.0
