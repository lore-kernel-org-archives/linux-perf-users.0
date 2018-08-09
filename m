From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/44] perf annotate: Pass struct annotation_options to symbol__calc_lines()
Date: Thu,  9 Aug 2018 11:58:03 -0300
Message-ID: <20180809145822.21391-26-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Pass struct annotation_options to symbol__calc_lines(), to carry on and
pass the percent_type value.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-14-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 91528a065768..2b06476c79c2 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1868,7 +1868,8 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 	return symbol__disassemble(sym, &args);
 }
 
-static void insert_source_line(struct rb_root *root, struct annotation_line *al)
+static void insert_source_line(struct rb_root *root, struct annotation_line *al,
+			       struct annotation_options *opts)
 {
 	struct annotation_line *iter;
 	struct rb_node **p = &root->rb_node;
@@ -1883,7 +1884,7 @@ static void insert_source_line(struct rb_root *root, struct annotation_line *al)
 		if (ret == 0) {
 			for (i = 0; i < al->data_nr; i++) {
 				iter->data[i].percent_sum += annotation_data__percent(&al->data[i],
-										      PERCENT_HITS_LOCAL);
+										      opts->percent_type);
 			}
 			return;
 		}
@@ -1896,7 +1897,7 @@ static void insert_source_line(struct rb_root *root, struct annotation_line *al)
 
 	for (i = 0; i < al->data_nr; i++) {
 		al->data[i].percent_sum = annotation_data__percent(&al->data[i],
-								   PERCENT_HITS_LOCAL);
+								   opts->percent_type);
 	}
 
 	rb_link_node(&al->rb_node, parent, p);
@@ -2372,7 +2373,8 @@ void annotation__update_column_widths(struct annotation *notes)
 }
 
 static void annotation__calc_lines(struct annotation *notes, struct map *map,
-				  struct rb_root *root)
+				   struct rb_root *root,
+				   struct annotation_options *opts)
 {
 	struct annotation_line *al;
 	struct rb_root tmp_root = RB_ROOT;
@@ -2385,7 +2387,7 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 			double percent;
 
 			percent = annotation_data__percent(&al->data[i],
-							   PERCENT_HITS_LOCAL);
+							   opts->percent_type);
 
 			if (percent > percent_max)
 				percent_max = percent;
@@ -2396,18 +2398,19 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 
 		al->path = get_srcline(map->dso, notes->start + al->offset, NULL,
 				       false, true, notes->start + al->offset);
-		insert_source_line(&tmp_root, al);
+		insert_source_line(&tmp_root, al, opts);
 	}
 
 	resort_source_line(root, &tmp_root);
 }
 
 static void symbol__calc_lines(struct symbol *sym, struct map *map,
-			      struct rb_root *root)
+			       struct rb_root *root,
+			       struct annotation_options *opts)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
-	annotation__calc_lines(notes, map, root);
+	annotation__calc_lines(notes, map, root, opts);
 }
 
 int symbol__tty_annotate2(struct symbol *sym, struct map *map,
@@ -2424,7 +2427,7 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 
 	if (opts->print_lines) {
 		srcline_full_filename = opts->full_path;
-		symbol__calc_lines(sym, map, &source_line);
+		symbol__calc_lines(sym, map, &source_line, opts);
 		print_summary(&source_line, dso->long_name);
 	}
 
@@ -2451,7 +2454,7 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 
 	if (opts->print_lines) {
 		srcline_full_filename = opts->full_path;
-		symbol__calc_lines(sym, map, &source_line);
+		symbol__calc_lines(sym, map, &source_line, opts);
 		print_summary(&source_line, dso->long_name);
 	}
 
-- 
2.14.4
