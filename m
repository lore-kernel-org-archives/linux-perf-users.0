From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/37] perf trace: Look up maps just on the __augmented_syscalls__ BPF object
Date: Mon, 22 Jul 2019 14:38:07 -0300
Message-ID: <20190722173839.22898-6-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We can conceivably have multiple BPF object files for other purposes, so
better look just on the BPF object containing the __augmented_syscalls__
map for all things augmented_syscalls related.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-3jt8knkuae9lt705r1lns202@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6aa080845a84..bfd739a321d1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3669,28 +3669,22 @@ static int trace__parse_cgroups(const struct option *opt, const char *str, int u
 	return 0;
 }
 
-static struct bpf_map *bpf__find_map_by_name(const char *name)
+static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace, const char *name)
 {
-	struct bpf_object *obj, *tmp;
-
-	bpf_object__for_each_safe(obj, tmp) {
-		struct bpf_map *map = bpf_object__find_map_by_name(obj, name);
-		if (map)
-			return map;
-
-	}
+	if (trace->bpf_obj == NULL)
+		return NULL;
 
-	return NULL;
+	return bpf_object__find_map_by_name(trace->bpf_obj, name);
 }
 
 static void trace__set_bpf_map_filtered_pids(struct trace *trace)
 {
-	trace->filter_pids.map = bpf__find_map_by_name("pids_filtered");
+	trace->filter_pids.map = trace__find_bpf_map_by_name(trace, "pids_filtered");
 }
 
 static void trace__set_bpf_map_syscalls(struct trace *trace)
 {
-	trace->syscalls.map = bpf__find_map_by_name("syscalls");
+	trace->syscalls.map = trace__find_bpf_map_by_name(trace, "syscalls");
 }
 
 static int trace__config(const char *var, const char *value, void *arg)
@@ -3924,7 +3918,7 @@ int cmd_trace(int argc, const char **argv)
 	err = -1;
 
 	if (map_dump_str) {
-		trace.dump.map = bpf__find_map_by_name(map_dump_str);
+		trace.dump.map = trace__find_bpf_map_by_name(&trace, map_dump_str);
 		if (trace.dump.map == NULL) {
 			pr_err("ERROR: BPF map \"%s\" not found\n", map_dump_str);
 			goto out;
-- 
2.21.0
