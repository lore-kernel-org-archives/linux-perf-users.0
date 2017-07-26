From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/40] perf trace: Introduce filter_loop_pids()
Date: Wed, 26 Jul 2017 11:17:03 -0300
Message-ID: <20170726141730.30750-14-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No change in functionality, just to make clearer that what we want when
filtering the tracer pid in a system wide tracing session is to avoid a
feedback loop.

This also paves the way for a more interesting loop avoidance algorithm,
one that tries to figure out if we are in a ssh session, xterm, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-5fcttc5kdjkcyp9404ezkuy9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 9e74e675d7cb..0ba36f08efd8 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2239,6 +2239,16 @@ static int trace__set_ev_qualifier_filter(struct trace *trace)
 	goto out;
 }
 
+static int trace__set_filter_loop_pids(struct trace *trace)
+{
+	int nr = 1;
+	pid_t pids[32] = {
+		getpid(),
+	};
+
+	return perf_evlist__set_filter_pids(trace->evlist, nr, pids);
+}
+
 static int trace__run(struct trace *trace, int argc, const char **argv)
 {
 	struct perf_evlist *evlist = trace->evlist;
@@ -2362,7 +2372,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (trace->filter_pids.nr > 0)
 		err = perf_evlist__set_filter_pids(evlist, trace->filter_pids.nr, trace->filter_pids.entries);
 	else if (thread_map__pid(evlist->threads, 0) == -1)
-		err = perf_evlist__set_filter_pid(evlist, getpid());
+		err = trace__set_filter_loop_pids(trace);
 
 	if (err < 0)
 		goto out_error_mem;
-- 
2.9.4
