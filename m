From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/44] perf annotate: Add percent_type to struct annotation_options
Date: Thu,  9 Aug 2018 11:58:02 -0300
Message-ID: <20180809145822.21391-25-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

It will be used to carry user selection of percent type for annotation
output.

Passing the percent_type to the annotation_line__print function as the
first step and making it default to current percentage type
(PERCENT_HITS_LOCAL) value.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-13-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 13 ++++++++-----
 tools/perf/util/annotate.h |  1 +
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e890164592b0..91528a065768 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -49,6 +49,7 @@ struct annotation_options annotation__default_options = {
 	.jump_arrows    = true,
 	.annotate_src	= true,
 	.offset_level	= ANNOTATION__OFFSET_JUMP_TARGETS,
+	.percent_type	= PERCENT_HITS_LOCAL,
 };
 
 static regex_t	 file_lineno;
@@ -1297,7 +1298,8 @@ static int disasm_line__print(struct disasm_line *dl, u64 start, int addr_fmt_wi
 static int
 annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start,
 		       struct perf_evsel *evsel, u64 len, int min_pcnt, int printed,
-		       int max_lines, struct annotation_line *queue, int addr_fmt_width)
+		       int max_lines, struct annotation_line *queue, int addr_fmt_width,
+		       int percent_type)
 {
 	struct disasm_line *dl = container_of(al, struct disasm_line, al);
 	static const char *prev_line;
@@ -1313,7 +1315,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 			double percent;
 
 			percent = annotation_data__percent(&al->data[i],
-							   PERCENT_HITS_LOCAL);
+							   percent_type);
 
 			if (percent > max_percent)
 				max_percent = percent;
@@ -1333,7 +1335,8 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 				if (queue == al)
 					break;
 				annotation_line__print(queue, sym, start, evsel, len,
-						       0, 0, 1, NULL, addr_fmt_width);
+						       0, 0, 1, NULL, addr_fmt_width,
+						       percent_type);
 			}
 		}
 
@@ -1357,7 +1360,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 			struct annotation_data *data = &al->data[i];
 			double percent;
 
-			percent = annotation_data__percent(data, PERCENT_HITS_LOCAL);
+			percent = annotation_data__percent(data, percent_type);
 			color = get_percent_color(percent);
 
 			if (symbol_conf.show_total_period)
@@ -2075,7 +2078,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 
 		err = annotation_line__print(pos, sym, start, evsel, len,
 					     opts->min_pcnt, printed, opts->max_lines,
-					     queue, addr_fmt_width);
+					     queue, addr_fmt_width, opts->percent_type);
 
 		switch (err) {
 		case 0:
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 48fe2aa6b5a8..145dec845f33 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -82,6 +82,7 @@ struct annotation_options {
 	int  context;
 	const char *objdump_path;
 	const char *disassembler_style;
+	unsigned int percent_type;
 };
 
 enum {
-- 
2.14.4
