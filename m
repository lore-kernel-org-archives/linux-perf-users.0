From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/69] perf evlist: Introduce append_tp_filter_pid() and append_tp_filter_pids()
Date: Fri, 11 Oct 2019 17:05:24 -0300
Message-ID: <20191011200559.7156-35-acme@kernel.org>
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

We'll need this to support 'perf trace e tracepoint --filter=expr', as
the command line tracepoint filter is attache to the preceding evsel,
just like in 'perf record' and when we go to set pid filters, which we
do at the minimum to filter 'perf trace' own syscalls, we need to
append, not set the tp filter.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-daynpknni44ywuzi8iua57nn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 14 ++++++++++++++
 tools/perf/util/evlist.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1650d242a1c8..e33b46aca5cb 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1128,6 +1128,20 @@ int perf_evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid)
 	return perf_evlist__set_tp_filter_pids(evlist, 1, &pid);
 }
 
+int perf_evlist__append_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids)
+{
+	char *filter = asprintf__tp_filter_pids(npids, pids);
+	int ret = perf_evlist__append_tp_filter(evlist, filter);
+
+	free(filter);
+	return ret;
+}
+
+int perf_evlist__append_tp_filter_pid(struct evlist *evlist, pid_t pid)
+{
+	return perf_evlist__append_tp_filter_pids(evlist, 1, &pid);
+}
+
 bool perf_evlist__valid_sample_type(struct evlist *evlist)
 {
 	struct evsel *pos;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index c58fd1908bfc..13051409fd22 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -142,6 +142,9 @@ int perf_evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *
 
 int perf_evlist__append_tp_filter(struct evlist *evlist, const char *filter);
 
+int perf_evlist__append_tp_filter_pid(struct evlist *evlist, pid_t pid);
+int perf_evlist__append_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids);
+
 struct evsel *
 perf_evlist__find_tracepoint_by_id(struct evlist *evlist, int id);
 
-- 
2.21.0
