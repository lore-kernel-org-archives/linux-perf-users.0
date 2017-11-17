From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/83] perf annotate: Factor annotation_line__print from disasm_line__print
Date: Fri, 17 Nov 2017 17:15:03 -0300
Message-ID: <20171117201601.24110-26-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161548AbdKQURl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:17:41 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Move generic annotation line display code into annotation_line__print
function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-25-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 69 ++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 36 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 5c6f739ac3ac..cb065ca431ee 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1093,24 +1093,36 @@ static void annotate__branch_printf(struct block_range *br, u64 addr)
 }
 
 
-static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 start,
-		      struct perf_evsel *evsel, u64 len, int min_pcnt, int printed,
-		      int max_lines, struct disasm_line *queue)
+static int disasm_line__print(struct disasm_line *dl, u64 start)
 {
+	s64 offset = dl->al.offset;
+	const u64 addr = start + offset;
+	struct block_range *br;
+
+	br = block_range__find(addr);
+	color_fprintf(stdout, annotate__address_color(br), "  %" PRIx64 ":", addr);
+	color_fprintf(stdout, annotate__asm_color(br), "%s", dl->al.line);
+	annotate__branch_printf(br, addr);
+	return 0;
+}
+
+static int
+annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start,
+		       struct perf_evsel *evsel, u64 len, int min_pcnt, int printed,
+		       int max_lines, struct annotation_line *queue)
+{
+	struct disasm_line *dl = container_of(al, struct disasm_line, al);
 	static const char *prev_line;
 	static const char *prev_color;
 
-	if (dl->al.offset != -1) {
+	if (al->offset != -1) {
 		double max_percent = 0.0;
 		int i, nr_percent = 1;
 		const char *color;
 		struct annotation *notes = symbol__annotation(sym);
-		s64 offset = dl->al.offset;
-		const u64 addr = start + offset;
-		struct block_range *br;
 
-		for (i = 0; i < dl->al.samples_nr; i++) {
-			struct annotation_data *sample = &dl->al.samples[i];
+		for (i = 0; i < al->samples_nr; i++) {
+			struct annotation_data *sample = &al->samples[i];
 
 			if (sample->percent > max_percent)
 				max_percent = sample->percent;
@@ -1123,11 +1135,11 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 			return 1;
 
 		if (queue != NULL) {
-			list_for_each_entry_from(queue, &notes->src->source, al.node) {
-				if (queue == dl)
+			list_for_each_entry_from(queue, &notes->src->source, node) {
+				if (queue == al)
 					break;
-				disasm_line__print(queue, sym, start, evsel, len,
-						    0, 0, 1, NULL);
+				annotation_line__print(queue, sym, start, evsel, len,
+						       0, 0, 1, NULL);
 			}
 		}
 
@@ -1138,17 +1150,17 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 		 * the same color than the percentage. Don't print it
 		 * twice for close colored addr with the same filename:line
 		 */
-		if (dl->al.path) {
-			if (!prev_line || strcmp(prev_line, dl->al.path)
+		if (al->path) {
+			if (!prev_line || strcmp(prev_line, al->path)
 				       || color != prev_color) {
-				color_fprintf(stdout, color, " %s", dl->al.path);
-				prev_line = dl->al.path;
+				color_fprintf(stdout, color, " %s", al->path);
+				prev_line = al->path;
 				prev_color = color;
 			}
 		}
 
 		for (i = 0; i < nr_percent; i++) {
-			struct annotation_data *sample = &dl->al.samples[i];
+			struct annotation_data *sample = &al->samples[i];
 
 			color = get_percent_color(sample->percent);
 
@@ -1164,10 +1176,7 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 
 		printf(" :	");
 
-		br = block_range__find(addr);
-		color_fprintf(stdout, annotate__address_color(br), "  %" PRIx64 ":", addr);
-		color_fprintf(stdout, annotate__asm_color(br), "%s", dl->al.line);
-		annotate__branch_printf(br, addr);
+		disasm_line__print(dl, start);
 		printf("\n");
 	} else if (max_lines && printed >= max_lines)
 		return 1;
@@ -1180,27 +1189,15 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 		if (perf_evsel__is_group_event(evsel))
 			width *= evsel->nr_members;
 
-		if (!*dl->al.line)
+		if (!*al->line)
 			printf(" %*s:\n", width, " ");
 		else
-			printf(" %*s:	%s\n", width, " ", dl->al.line);
+			printf(" %*s:	%s\n", width, " ", al->line);
 	}
 
 	return 0;
 }
 
-static int
-annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start,
-		       struct perf_evsel *evsel, u64 len, int min_pcnt, int printed,
-		       int max_lines, struct annotation_line *aq)
-{
-	struct disasm_line *dl    = container_of(al, struct disasm_line, al);
-	struct disasm_line *queue = container_of(aq, struct disasm_line, al);
-
-	return disasm_line__print(dl, sym, start, evsel, len, min_pcnt, printed,
-				  max_lines, queue);
-}
-
 /*
  * symbol__parse_objdump_line() parses objdump output (with -d --no-show-raw)
  * which looks like following
-- 
2.13.6
