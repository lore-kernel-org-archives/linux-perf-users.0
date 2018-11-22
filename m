From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/28] perf evlist: Rename perf_evlist__set_filter* to perf_evlist__set_tp_filter*
Date: Thu, 22 Nov 2018 00:35:51 -0300
Message-ID: <20181122033611.15890-9-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To better reflect that this is a tracepoint filter, as opposed, for
instance to map based BPF filters.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-9138svli6ddcphrr3ymy9oy3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c |  4 ++--
 tools/perf/util/evlist.c   | 10 +++++-----
 tools/perf/util/evlist.h   |  6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 835619476370..d86ba17fcf44 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2586,7 +2586,7 @@ static int trace__set_filter_loop_pids(struct trace *trace)
 		thread = parent;
 	}
 
-	return perf_evlist__set_filter_pids(trace->evlist, nr, pids);
+	return perf_evlist__set_tp_filter_pids(trace->evlist, nr, pids);
 }
 
 static int trace__run(struct trace *trace, int argc, const char **argv)
@@ -2702,7 +2702,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	 * we fork the workload in perf_evlist__prepare_workload.
 	 */
 	if (trace->filter_pids.nr > 0)
-		err = perf_evlist__set_filter_pids(evlist, trace->filter_pids.nr, trace->filter_pids.entries);
+		err = perf_evlist__set_tp_filter_pids(evlist, trace->filter_pids.nr, trace->filter_pids.entries);
 	else if (thread_map__pid(evlist->threads, 0) == -1)
 		err = trace__set_filter_loop_pids(trace);
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 668d2a9ef0f4..36526d229315 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1176,7 +1176,7 @@ int perf_evlist__apply_filters(struct perf_evlist *evlist, struct perf_evsel **e
 	return err;
 }
 
-int perf_evlist__set_filter(struct perf_evlist *evlist, const char *filter)
+int perf_evlist__set_tp_filter(struct perf_evlist *evlist, const char *filter)
 {
 	struct perf_evsel *evsel;
 	int err = 0;
@@ -1193,7 +1193,7 @@ int perf_evlist__set_filter(struct perf_evlist *evlist, const char *filter)
 	return err;
 }
 
-int perf_evlist__set_filter_pids(struct perf_evlist *evlist, size_t npids, pid_t *pids)
+int perf_evlist__set_tp_filter_pids(struct perf_evlist *evlist, size_t npids, pid_t *pids)
 {
 	char *filter;
 	int ret = -1;
@@ -1214,15 +1214,15 @@ int perf_evlist__set_filter_pids(struct perf_evlist *evlist, size_t npids, pid_t
 		}
 	}
 
-	ret = perf_evlist__set_filter(evlist, filter);
+	ret = perf_evlist__set_tp_filter(evlist, filter);
 out_free:
 	free(filter);
 	return ret;
 }
 
-int perf_evlist__set_filter_pid(struct perf_evlist *evlist, pid_t pid)
+int perf_evlist__set_tp_filter_pid(struct perf_evlist *evlist, pid_t pid)
 {
-	return perf_evlist__set_filter_pids(evlist, 1, &pid);
+	return perf_evlist__set_tp_filter_pids(evlist, 1, &pid);
 }
 
 bool perf_evlist__valid_sample_type(struct perf_evlist *evlist)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 9919eed6d15b..d108d167eb36 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -98,9 +98,9 @@ void __perf_evlist__reset_sample_bit(struct perf_evlist *evlist,
 #define perf_evlist__reset_sample_bit(evlist, bit) \
 	__perf_evlist__reset_sample_bit(evlist, PERF_SAMPLE_##bit)
 
-int perf_evlist__set_filter(struct perf_evlist *evlist, const char *filter);
-int perf_evlist__set_filter_pid(struct perf_evlist *evlist, pid_t pid);
-int perf_evlist__set_filter_pids(struct perf_evlist *evlist, size_t npids, pid_t *pids);
+int perf_evlist__set_tp_filter(struct perf_evlist *evlist, const char *filter);
+int perf_evlist__set_tp_filter_pid(struct perf_evlist *evlist, pid_t pid);
+int perf_evlist__set_tp_filter_pids(struct perf_evlist *evlist, size_t npids, pid_t *pids);
 
 struct perf_evsel *
 perf_evlist__find_tracepoint_by_id(struct perf_evlist *evlist, int id);
-- 
2.14.5
