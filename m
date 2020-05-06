From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 58/91] perf evsel: Rename perf_evsel__group_desc() to evsel__group_desc()
Date: Wed,  6 May 2020 12:22:01 -0300
Message-ID: <20200506152234.21977-59-acme@kernel.org>
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
 tools/perf/builtin-report.c | 2 +-
 tools/perf/ui/gtk/hists.c   | 2 +-
 tools/perf/util/annotate.c  | 4 ++--
 tools/perf/util/evsel.c     | 2 +-
 tools/perf/util/evsel.h     | 2 +-
 tools/perf/util/hist.c      | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index b5dd93a76aa1..e00f6244cbda 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -462,7 +462,7 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 	if (perf_evsel__is_group_event(evsel)) {
 		struct evsel *pos;
 
-		perf_evsel__group_desc(evsel, buf, size);
+		evsel__group_desc(evsel, buf, size);
 		evname = buf;
 
 		for_each_group_member(pos, evsel) {
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index 50c072d2f3d3..40b52ae6ca6a 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -646,7 +646,7 @@ int perf_evlist__gtk_browse_hists(struct evlist *evlist,
 				continue;
 
 			if (pos->core.nr_members > 1) {
-				perf_evsel__group_desc(pos, buf, size);
+				evsel__group_desc(pos, buf, size);
 				evname = buf;
 			}
 		}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 37d95627c65f..7d03563b608b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2370,7 +2370,7 @@ int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel,
 
 	if (perf_evsel__is_group_event(evsel)) {
 		width *= evsel->core.nr_members;
-		perf_evsel__group_desc(evsel, buf, sizeof(buf));
+		evsel__group_desc(evsel, buf, sizeof(buf));
 		evsel_name = buf;
 	}
 
@@ -2519,7 +2519,7 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
 		goto out_free_filename;
 
 	if (perf_evsel__is_group_event(evsel)) {
-		perf_evsel__group_desc(evsel, buf, sizeof(buf));
+		evsel__group_desc(evsel, buf, sizeof(buf));
 		ev_name = buf;
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 167599e8b794..9b3db6d34d37 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -663,7 +663,7 @@ const char *evsel__group_name(struct evsel *evsel)
  *  For record -e 'cycles,instructions' and report --group
  *    'cycles:u, instructions:u'
  */
-int perf_evsel__group_desc(struct evsel *evsel, char *buf, size_t size)
+int evsel__group_desc(struct evsel *evsel, char *buf, size_t size)
 {
 	int ret = 0;
 	struct evsel *pos;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 7160f3d49d6c..82d2d308fa33 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -212,7 +212,7 @@ int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size
 const char *evsel__name(struct evsel *evsel);
 
 const char *evsel__group_name(struct evsel *evsel);
-int perf_evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
+int evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
 
 void __perf_evsel__set_sample_bit(struct evsel *evsel,
 				  enum perf_event_sample_format bit);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index fa77574f12ca..bce49ae97532 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2698,7 +2698,7 @@ int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool sh
 	if (perf_evsel__is_group_event(evsel)) {
 		struct evsel *pos;
 
-		perf_evsel__group_desc(evsel, buf, buflen);
+		evsel__group_desc(evsel, buf, buflen);
 		ev_name = buf;
 
 		for_each_group_member(pos, evsel) {
-- 
2.21.1
