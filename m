From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/69] perf evlist: Factor out asprintf routine to build a tracepoint pid filter
Date: Fri, 11 Oct 2019 17:05:22 -0300
Message-ID: <20191011200559.7156-33-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Will be used to append such lists to existing filters.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-798vlyqfqw938ehoe8etivx1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index b4c43ac4583f..c1b46080426b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1053,6 +1053,9 @@ int perf_evlist__set_tp_filter(struct evlist *evlist, const char *filter)
 	struct evsel *evsel;
 	int err = 0;
 
+	if (filter == NULL)
+		return -1;
+
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
 			continue;
@@ -1065,16 +1068,15 @@ int perf_evlist__set_tp_filter(struct evlist *evlist, const char *filter)
 	return err;
 }
 
-int perf_evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids)
+static char *asprintf__tp_filter_pids(size_t npids, pid_t *pids)
 {
 	char *filter;
-	int ret = -1;
 	size_t i;
 
 	for (i = 0; i < npids; ++i) {
 		if (i == 0) {
 			if (asprintf(&filter, "common_pid != %d", pids[i]) < 0)
-				return -1;
+				return NULL;
 		} else {
 			char *tmp;
 
@@ -1086,8 +1088,17 @@ int perf_evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *
 		}
 	}
 
-	ret = perf_evlist__set_tp_filter(evlist, filter);
+	return filter;
 out_free:
+	free(filter);
+	return NULL;
+}
+
+int perf_evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids)
+{
+	char *filter = asprintf__tp_filter_pids(npids, pids);
+	int ret = perf_evlist__set_tp_filter(evlist, filter);
+
 	free(filter);
 	return ret;
 }
-- 
2.21.0
