From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/44] perf annotate: Make symbol__annotate_fprintf2() local
Date: Thu,  9 Aug 2018 11:57:51 -0300
Message-ID: <20180809145822.21391-14-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no outside user of it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lkml.kernel.org/r/20180804130521.11408-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 +-
 tools/perf/util/annotate.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f91775b4bc3c..b6e7d0d56622 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2129,7 +2129,7 @@ static void FILE__write_graph(void *fp, int graph)
 	fputs(s, fp);
 }
 
-int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
+static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotation_write_ops ops = {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index a4c0d91907e6..5f24fc9dcc7c 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -340,7 +340,6 @@ int symbol__strerror_disassemble(struct symbol *sym, struct map *map,
 int symbol__annotate_printf(struct symbol *sym, struct map *map,
 			    struct perf_evsel *evsel,
 			    struct annotation_options *options);
-int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp);
 void symbol__annotate_zero_histogram(struct symbol *sym, int evidx);
 void symbol__annotate_decay_histogram(struct symbol *sym, int evidx);
 void annotated_source__purge(struct annotated_source *as);
-- 
2.14.4
