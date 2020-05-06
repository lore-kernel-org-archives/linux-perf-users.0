From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 48/91] perf evsel: Rename 'struct perf_evsel__sb_cb_t' to 'struct evsel__sb_cb_t'
Date: Wed,  6 May 2020 12:21:51 -0300
Message-ID: <20200506152234.21977-49-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As the "perf_" prefix should be restricted to functions and types in
tools/lib/perf/, aka libperf, this way we reduce a bit the confusion for
types only in libperf or the ones in the more contained tools/perf/
project.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.h          | 4 ++--
 tools/perf/util/evsel.h           | 6 +++---
 tools/perf/util/sideband_evlist.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 93de63e2a247..b6f325dfb4d2 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -109,9 +109,9 @@ int perf_evlist__add_dummy(struct evlist *evlist);
 
 int perf_evlist__add_sb_event(struct evlist *evlist,
 			      struct perf_event_attr *attr,
-			      perf_evsel__sb_cb_t cb,
+			      evsel__sb_cb_t cb,
 			      void *data);
-void evlist__set_cb(struct evlist *evlist, perf_evsel__sb_cb_t cb, void *data);
+void evlist__set_cb(struct evlist *evlist, evsel__sb_cb_t cb, void *data);
 int perf_evlist__start_sb_thread(struct evlist *evlist,
 				 struct target *target);
 void perf_evlist__stop_sb_thread(struct evlist *evlist);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index bf999e3c50c7..7ff37c4cdf9f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -18,7 +18,7 @@ struct perf_counts;
 struct perf_stat_evsel;
 union perf_event;
 
-typedef int (perf_evsel__sb_cb_t)(union perf_event *event, void *data);
+typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
 
 enum perf_tool_event {
 	PERF_TOOL_NONE		= 0,
@@ -101,8 +101,8 @@ struct evsel {
 	int			cpu_iter;
 	const char		*pmu_name;
 	struct {
-		perf_evsel__sb_cb_t	*cb;
-		void			*data;
+		evsel__sb_cb_t	*cb;
+		void		*data;
 	} side_band;
 	/*
 	 * For reporting purposes, an evsel sample can have a callchain
diff --git a/tools/perf/util/sideband_evlist.c b/tools/perf/util/sideband_evlist.c
index 1d6f470d64c4..bb3706fbcc0c 100644
--- a/tools/perf/util/sideband_evlist.c
+++ b/tools/perf/util/sideband_evlist.c
@@ -13,7 +13,7 @@
 #include <stdbool.h>
 
 int perf_evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
-			      perf_evsel__sb_cb_t cb, void *data)
+			      evsel__sb_cb_t cb, void *data)
 {
 	struct evsel *evsel;
 
@@ -81,7 +81,7 @@ static void *perf_evlist__poll_thread(void *arg)
 	return NULL;
 }
 
-void evlist__set_cb(struct evlist *evlist, perf_evsel__sb_cb_t cb, void *data)
+void evlist__set_cb(struct evlist *evlist, evsel__sb_cb_t cb, void *data)
 {
 	struct evsel *evsel;
 
-- 
2.21.1
