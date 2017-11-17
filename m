From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/83] perf annotate: Add annotation_line__print function
Date: Fri, 17 Nov 2017 17:15:02 -0300
Message-ID: <20171117201601.24110-25-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161504AbdKQURi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:17:38 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Separating struct annotation_line display function, it will hold the
generic line display code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-24-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 29cf2a5ef620..5c6f739ac3ac 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1189,6 +1189,18 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 	return 0;
 }
 
+static int
+annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start,
+		       struct perf_evsel *evsel, u64 len, int min_pcnt, int printed,
+		       int max_lines, struct annotation_line *aq)
+{
+	struct disasm_line *dl    = container_of(al, struct disasm_line, al);
+	struct disasm_line *queue = container_of(aq, struct disasm_line, al);
+
+	return disasm_line__print(dl, sym, start, evsel, len, min_pcnt, printed,
+				  max_lines, queue);
+}
+
 /*
  * symbol__parse_objdump_line() parses objdump output (with -d --no-show-raw)
  * which looks like following
@@ -1797,7 +1809,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 	const char *evsel_name = perf_evsel__name(evsel);
 	struct annotation *notes = symbol__annotation(sym);
 	struct sym_hist *h = annotation__histogram(notes, evsel->idx);
-	struct disasm_line *pos, *queue = NULL;
+	struct annotation_line *pos, *queue = NULL;
 	u64 start = map__rip_2objdump(map, sym->start);
 	int printed = 2, queue_len = 0;
 	int more = 0;
@@ -1830,15 +1842,19 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 	if (verbose > 0)
 		symbol__annotate_hits(sym, evsel);
 
-	list_for_each_entry(pos, &notes->src->source, al.node) {
+	list_for_each_entry(pos, &notes->src->source, node) {
+		int err;
+
 		if (context && queue == NULL) {
 			queue = pos;
 			queue_len = 0;
 		}
 
-		switch (disasm_line__print(pos, sym, start, evsel, len,
-					    min_pcnt, printed, max_lines,
-					    queue)) {
+		err = annotation_line__print(pos, sym, start, evsel, len,
+					     min_pcnt, printed, max_lines,
+					     queue);
+
+		switch (err) {
 		case 0:
 			++printed;
 			if (context) {
@@ -1860,7 +1876,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 			if (!context)
 				break;
 			if (queue_len == context)
-				queue = list_entry(queue->al.node.next, typeof(*queue), al.node);
+				queue = list_entry(queue->node.next, typeof(*queue), node);
 			else
 				++queue_len;
 			break;
-- 
2.13.6
