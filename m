From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 33/69] perf evlist: Introduce append_tp_filter() method
Date: Fri, 11 Oct 2019 17:05:23 -0300
Message-ID: <20191011200559.7156-34-acme@kernel.org>
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

Will be used by 'perf trace' to support 'perf trace --filter', we need
to append to any pre-existing filter.

When parse_filter() gets invoked to process --filter, it'll set the
filter to that specified on the command line, later on, when we filter
out 'perf trace' own pid to avoid an event feedback loop, we need to
preserve the command line filter put in place by parse_filter().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-h9rot08qmxlnfmte0holt68x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 20 ++++++++++++++++++++
 tools/perf/util/evlist.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c1b46080426b..1650d242a1c8 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1068,6 +1068,26 @@ int perf_evlist__set_tp_filter(struct evlist *evlist, const char *filter)
 	return err;
 }
 
+int perf_evlist__append_tp_filter(struct evlist *evlist, const char *filter)
+{
+	struct evsel *evsel;
+	int err = 0;
+
+	if (filter == NULL)
+		return -1;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
+			continue;
+
+		err = perf_evsel__append_tp_filter(evsel, filter);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
 static char *asprintf__tp_filter_pids(size_t npids, pid_t *pids)
 {
 	char *filter;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 00eab9435847..c58fd1908bfc 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -140,6 +140,8 @@ int perf_evlist__set_tp_filter(struct evlist *evlist, const char *filter);
 int perf_evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid);
 int perf_evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids);
 
+int perf_evlist__append_tp_filter(struct evlist *evlist, const char *filter);
+
 struct evsel *
 perf_evlist__find_tracepoint_by_id(struct evlist *evlist, int id);
 
-- 
2.21.0
