From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 033/107] perf evsel: Rename perf_evsel__init() to evsel__init()
Date: Mon, 29 Jul 2019 23:54:56 -0300
Message-ID: <20190730025610.22603-34-acme@kernel.org>
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

Rename perf_evsel__init() to evsel__init(), so we don't have a name
clash when we add perf_evsel__init() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c  | 8 ++++----
 tools/perf/util/evsel.h  | 3 +--
 tools/perf/util/python.c | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f7f97ca6e96d..97bee83f0f98 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -223,8 +223,8 @@ bool perf_evsel__is_function_event(struct evsel *evsel)
 #undef FUNCTION_EVENT
 }
 
-void perf_evsel__init(struct evsel *evsel,
-		      struct perf_event_attr *attr, int idx)
+void evsel__init(struct evsel *evsel,
+		 struct perf_event_attr *attr, int idx)
 {
 	evsel->idx	   = idx;
 	evsel->tracking	   = !idx;
@@ -255,7 +255,7 @@ struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
 
 	if (!evsel)
 		return NULL;
-	perf_evsel__init(evsel, attr, idx);
+	evsel__init(evsel, attr, idx);
 
 	if (perf_evsel__is_bpf_output(evsel)) {
 		evsel->attr.sample_type |= (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
@@ -350,7 +350,7 @@ struct evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx)
 		event_attr_init(&attr);
 		attr.config = evsel->tp_format->id;
 		attr.sample_period = 1;
-		perf_evsel__init(evsel, &attr, idx);
+		evsel__init(evsel, &attr, idx);
 	}
 
 	return evsel;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3caabd8a4aa6..af230d92fbef 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -238,8 +238,7 @@ struct evsel *perf_evsel__new_cycles(bool precise);
 
 struct tep_event *event_format__new(const char *sys, const char *name);
 
-void perf_evsel__init(struct evsel *evsel,
-		      struct perf_event_attr *attr, int idx);
+void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx);
 void perf_evsel__exit(struct evsel *evsel);
 void perf_evsel__delete(struct evsel *evsel);
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ed57b6b5ed91..f6fe3c90828f 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -782,7 +782,7 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
 	attr.sample_id_all  = sample_id_all;
 	attr.size	    = sizeof(attr);
 
-	perf_evsel__init(&pevsel->evsel, &attr, idx);
+	evsel__init(&pevsel->evsel, &attr, idx);
 	return 0;
 }
 
-- 
2.21.0
