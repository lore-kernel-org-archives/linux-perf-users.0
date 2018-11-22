From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/28] perf trace: See if there is a map named "filtered_pids"
Date: Thu, 22 Nov 2018 00:35:53 -0300
Message-ID: <20181122033611.15890-11-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Lookup for the first map named "filtered_pids" and, if augmenting
syscalls, i.e. if a BPF event is present and the
"__augmented_syscalls__" is present, then fill in that map with the pids
to filter, be it feedback loop ones (perf trace's pid, its father if it
is "sshd", more auto-filtered in the future) or the ones explicitely
stated in the tool command line via --filter-pids.

The code to actually fill in the map comes next.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-rhzytmw7qpe6lqyjxi1ded9t@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 8f966c7a7d0d..c423a78b5ecd 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -18,6 +18,7 @@
 
 #include <traceevent/event-parse.h>
 #include <api/fs/tracing_path.h>
+#include <bpf/bpf.h>
 #include "builtin.h"
 #include "util/cgroup.h"
 #include "util/color.h"
@@ -99,6 +100,7 @@ struct trace {
 	struct {
 		size_t		nr;
 		pid_t		*entries;
+		struct bpf_map  *map;
 	}			filter_pids;
 	double			duration_filter;
 	double			runtime_ms;
@@ -3315,6 +3317,25 @@ static int trace__parse_cgroups(const struct option *opt, const char *str, int u
 	return 0;
 }
 
+static struct bpf_map *bpf__find_map_by_name(const char *name)
+{
+	struct bpf_object *obj, *tmp;
+
+	bpf_object__for_each_safe(obj, tmp) {
+		struct bpf_map *map = bpf_object__find_map_by_name(obj, name);
+		if (map)
+			return map;
+
+	}
+
+	return NULL;
+}
+
+static void trace__set_bpf_map_filtered_pids(struct trace *trace)
+{
+	trace->filter_pids.map = bpf__find_map_by_name("pids_filtered");
+}
+
 int cmd_trace(int argc, const char **argv)
 {
 	const char *trace_usage[] = {
@@ -3451,8 +3472,10 @@ int cmd_trace(int argc, const char **argv)
 		goto out;
 	}
 
-	if (evsel)
+	if (evsel) {
 		trace.syscalls.events.augmented = evsel;
+		trace__set_bpf_map_filtered_pids(&trace);
+	}
 
 	err = bpf__setup_stdout(trace.evlist);
 	if (err) {
-- 
2.14.5
