From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/83] perf annotate: Add annotation_line__next function
Date: Fri, 17 Nov 2017 17:14:50 -0300
Message-ID: <20171117201601.24110-13-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965591AbdKQUQ5 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:16:57 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Rename disasm__get_next_ip_line() to annotation_line__next() to make it
work over a generic struct annotation_line.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c |  7 ++++---
 tools/perf/util/annotate.c        | 13 +++++++------
 tools/perf/util/annotate.h        |  3 ++-
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 3b72519c085f..881ad6122057 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -440,7 +440,8 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 	struct map_symbol *ms = browser->b.priv;
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
-	struct disasm_line *pos, *next;
+	struct annotation_line *next;
+	struct disasm_line *pos;
 	s64 len = symbol__size(sym);
 
 	browser->entries = RB_ROOT;
@@ -458,7 +459,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 			continue;
 		}
 
-		next = disasm__get_next_ip_line(&notes->src->source, pos);
+		next = annotation_line__next(&pos->al, &notes->src->source);
 
 		for (i = 0; i < browser->nr_events; i++) {
 			struct sym_hist_entry sample;
@@ -466,7 +467,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 			bpos->samples[i].percent = disasm__calc_percent(notes,
 						evsel->idx + i,
 						pos->al.offset,
-						next ? next->al.offset : len,
+						next ? next->offset : len,
 						&path, &sample);
 			bpos->samples[i].he = sample;
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 75f54eab22c8..e7da88d7bb27 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -942,10 +942,11 @@ static void disasm__add(struct list_head *head, struct disasm_line *line)
 	list_add_tail(&line->al.node, head);
 }
 
-struct disasm_line *disasm__get_next_ip_line(struct list_head *head, struct disasm_line *pos)
+struct annotation_line *
+annotation_line__next(struct annotation_line *pos, struct list_head *head)
 {
-	list_for_each_entry_continue(pos, head, al.node)
-		if (pos->al.offset >= 0)
+	list_for_each_entry_continue(pos, head, node)
+		if (pos->offset >= 0)
 			return pos;
 
 	return NULL;
@@ -1096,10 +1097,10 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 		struct annotation *notes = symbol__annotation(sym);
 		s64 offset = dl->al.offset;
 		const u64 addr = start + offset;
-		struct disasm_line *next;
+		struct annotation_line *next;
 		struct block_range *br;
 
-		next = disasm__get_next_ip_line(&notes->src->source, dl);
+		next = annotation_line__next(&dl->al, &notes->src->source);
 
 		if (perf_evsel__is_group_event(evsel)) {
 			nr_percent = evsel->nr_members;
@@ -1114,7 +1115,7 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 			percent = disasm__calc_percent(notes,
 					notes->src->lines ? i : evsel->idx + i,
 					offset,
-					next ? next->al.offset : (s64) len,
+					next ? next->offset : (s64) len,
 					&path, &sample);
 
 			ppercents[i] = percent;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index baf34032504a..43bef6cacbc4 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -85,7 +85,8 @@ struct sym_hist_entry {
 };
 
 void disasm_line__free(struct disasm_line *dl);
-struct disasm_line *disasm__get_next_ip_line(struct list_head *head, struct disasm_line *pos);
+struct annotation_line *
+annotation_line__next(struct annotation_line *pos, struct list_head *head);
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw);
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
 double disasm__calc_percent(struct annotation *notes, int evidx, s64 offset,
-- 
2.13.6
