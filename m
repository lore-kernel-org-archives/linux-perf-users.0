From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 53/91] perf evsel: Rename perf_evsel__exit() to evsel__exit()
Date: Wed,  6 May 2020 12:21:56 -0300
Message-ID: <20200506152234.21977-54-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As it is a 'struct evsel' method, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c  | 4 ++--
 tools/perf/util/evsel.h  | 2 +-
 tools/perf/util/python.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index db6d2a5f9b3c..11e754746984 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1259,7 +1259,7 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
 	}
 }
 
-void perf_evsel__exit(struct evsel *evsel)
+void evsel__exit(struct evsel *evsel)
 {
 	assert(list_empty(&evsel->core.node));
 	assert(evsel->evlist == NULL);
@@ -1279,7 +1279,7 @@ void perf_evsel__exit(struct evsel *evsel)
 
 void evsel__delete(struct evsel *evsel)
 {
-	perf_evsel__exit(evsel);
+	evsel__exit(evsel);
 	free(evsel);
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 6187dba21298..2facb16e9f12 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -183,7 +183,7 @@ struct evsel *perf_evsel__new_cycles(bool precise);
 struct tep_event *event_format__new(const char *sys, const char *name);
 
 void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx);
-void perf_evsel__exit(struct evsel *evsel);
+void evsel__exit(struct evsel *evsel);
 void evsel__delete(struct evsel *evsel);
 
 struct callchain_param;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 83212c65848b..67810d31f88d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -801,7 +801,7 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
 
 static void pyrf_evsel__delete(struct pyrf_evsel *pevsel)
 {
-	perf_evsel__exit(&pevsel->evsel);
+	evsel__exit(&pevsel->evsel);
 	Py_TYPE(pevsel)->tp_free((PyObject*)pevsel);
 }
 
-- 
2.21.1
