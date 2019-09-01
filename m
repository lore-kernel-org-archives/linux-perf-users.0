From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/47] perf timechart: Refactor svg_build_topology_map()
Date: Sun,  1 Sep 2019 09:22:41 -0300
Message-ID: <20190901122326.5793-3-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kyle Meyer <meyerk@hpe.com>, Kyle Meyer <kyle.meyer@hpe.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Russ Anderson <russ.anderson@hpe.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kyle Meyer <meyerk@hpe.com>

Exchange the parameters of svg_build_topology_map() with 'struct
perf_env *env' and adjust the function accordingly.

This patch should not change any behavior, it is merely refactoring for
the following patch.

Committer notes:

No need to include env.h from svghelper.h, all it needs is a forward
declaration for 'struct perf_env', so move the include directive to
svghelper.c, where it is really needed.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Link: http://lore.kernel.org/lkml/20190827214352.94272-2-meyerk@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-timechart.c |  5 +----
 tools/perf/util/svghelper.c    | 20 ++++++++++++--------
 tools/perf/util/svghelper.h    |  4 +++-
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 7d6a6ecf4e02..1ff81a790931 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1518,10 +1518,7 @@ static int process_header(struct perf_file_section *section __maybe_unused,
 		if (!tchart->topology)
 			break;
 
-		if (svg_build_topology_map(ph->env.sibling_cores,
-					   ph->env.nr_sibling_cores,
-					   ph->env.sibling_threads,
-					   ph->env.nr_sibling_threads))
+		if (svg_build_topology_map(&ph->env))
 			fprintf(stderr, "problem building topology\n");
 		break;
 
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index bbdd87163285..2e9971590590 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -19,6 +19,7 @@
 #include <linux/zalloc.h>
 #include <perf/cpumap.h>
 
+#include "env.h"
 #include "perf.h"
 #include "svghelper.h"
 #include "cpumap.h"
@@ -752,23 +753,26 @@ static int str_to_bitmap(char *s, cpumask_t *b)
 	return ret;
 }
 
-int svg_build_topology_map(char *sib_core, int sib_core_nr,
-			   char *sib_thr, int sib_thr_nr)
+int svg_build_topology_map(struct perf_env *env)
 {
 	int i;
 	struct topology t;
+	char *sib_core, *sib_thr;
 
-	t.sib_core_nr = sib_core_nr;
-	t.sib_thr_nr = sib_thr_nr;
-	t.sib_core = calloc(sib_core_nr, sizeof(cpumask_t));
-	t.sib_thr = calloc(sib_thr_nr, sizeof(cpumask_t));
+	t.sib_core_nr = env->nr_sibling_cores;
+	t.sib_thr_nr = env->nr_sibling_threads;
+	t.sib_core = calloc(env->nr_sibling_cores, sizeof(cpumask_t));
+	t.sib_thr = calloc(env->nr_sibling_threads, sizeof(cpumask_t));
+
+	sib_core = env->sibling_cores;
+	sib_thr = env->sibling_threads;
 
 	if (!t.sib_core || !t.sib_thr) {
 		fprintf(stderr, "topology: no memory\n");
 		goto exit;
 	}
 
-	for (i = 0; i < sib_core_nr; i++) {
+	for (i = 0; i < env->nr_sibling_cores; i++) {
 		if (str_to_bitmap(sib_core, &t.sib_core[i])) {
 			fprintf(stderr, "topology: can't parse siblings map\n");
 			goto exit;
@@ -777,7 +781,7 @@ int svg_build_topology_map(char *sib_core, int sib_core_nr,
 		sib_core += strlen(sib_core) + 1;
 	}
 
-	for (i = 0; i < sib_thr_nr; i++) {
+	for (i = 0; i < env->nr_sibling_threads; i++) {
 		if (str_to_bitmap(sib_thr, &t.sib_thr[i])) {
 			fprintf(stderr, "topology: can't parse siblings map\n");
 			goto exit;
diff --git a/tools/perf/util/svghelper.h b/tools/perf/util/svghelper.h
index e55338d5c3bd..81823e8bae3e 100644
--- a/tools/perf/util/svghelper.h
+++ b/tools/perf/util/svghelper.h
@@ -4,6 +4,8 @@
 
 #include <linux/types.h>
 
+struct perf_env;
+
 void open_svg(const char *filename, int cpus, int rows, u64 start, u64 end);
 void svg_ubox(int Yslot, u64 start, u64 end, double height, const char *type, int fd, int err, int merges);
 void svg_lbox(int Yslot, u64 start, u64 end, double height, const char *type, int fd, int err, int merges);
@@ -28,7 +30,7 @@ void svg_partial_wakeline(u64 start, int row1, char *desc1, int row2, char *desc
 void svg_interrupt(u64 start, int row, const char *backtrace);
 void svg_text(int Yslot, u64 start, const char *text);
 void svg_close(void);
-int svg_build_topology_map(char *sib_core, int sib_core_nr, char *sib_thr, int sib_thr_nr);
+int svg_build_topology_map(struct perf_env *env);
 
 extern int svg_page_width;
 extern u64 svg_highlight;
-- 
2.21.0
