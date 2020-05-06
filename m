From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 51/91] perf evsel: Rename perf_evsel__find_pmu() to evsel__find_pmu()
Date: Wed,  6 May 2020 12:21:54 -0300
Message-ID: <20200506152234.21977-52-acme@kernel.org>
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
 tools/perf/util/auxtrace.c | 2 +-
 tools/perf/util/evsel.h    | 2 +-
 tools/perf/util/pmu.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 83ea7ca24686..cddd1d36f724 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2542,7 +2542,7 @@ static int parse_addr_filter(struct evsel *evsel, const char *filter,
 
 static int perf_evsel__nr_addr_filter(struct evsel *evsel)
 {
-	struct perf_pmu *pmu = perf_evsel__find_pmu(evsel);
+	struct perf_pmu *pmu = evsel__find_pmu(evsel);
 	int nr_addr_filters = 0;
 
 	if (!pmu)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 32015057429c..868e2be434c4 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -158,7 +158,7 @@ int perf_evsel__object_config(size_t object_size,
 			      int (*init)(struct evsel *evsel),
 			      void (*fini)(struct evsel *evsel));
 
-struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel);
+struct perf_pmu *evsel__find_pmu(struct evsel *evsel);
 bool perf_evsel__is_aux_event(struct evsel *evsel);
 
 struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d9f89ed18dea..2dd3d6be1a61 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -886,7 +886,7 @@ struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu)
 	return NULL;
 }
 
-struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
+struct perf_pmu *evsel__find_pmu(struct evsel *evsel)
 {
 	struct perf_pmu *pmu = NULL;
 
@@ -900,7 +900,7 @@ struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
 
 bool perf_evsel__is_aux_event(struct evsel *evsel)
 {
-	struct perf_pmu *pmu = perf_evsel__find_pmu(evsel);
+	struct perf_pmu *pmu = evsel__find_pmu(evsel);
 
 	return pmu && pmu->auxtrace;
 }
-- 
2.21.1
