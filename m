From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/83] perf annotate: Add annotated_source__purge function
Date: Fri, 17 Nov 2017 17:14:54 -0300
Message-ID: <20171117201601.24110-17-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161310AbdKQURL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:17:11 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Mov disasm__purge() to annotated_source__purge() to make it work over a
generic struct annotation_line.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-16-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c |  8 +++-----
 tools/perf/util/annotate.c        | 12 ++++++------
 tools/perf/util/annotate.h        |  2 +-
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 7ca5ae625cc9..4c54d5e76008 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -1084,7 +1084,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			 struct perf_evsel *evsel,
 			 struct hist_browser_timer *hbt)
 {
-	struct disasm_line *pos, *n;
+	struct disasm_line *pos;
 	struct annotation *notes;
 	size_t size;
 	struct map_symbol ms = {
@@ -1180,10 +1180,8 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	annotate_browser__update_addr_width(&browser);
 
 	ret = annotate_browser__run(&browser, evsel, hbt);
-	list_for_each_entry_safe(pos, n, &notes->src->source, al.node) {
-		list_del(&pos->al.node);
-		disasm_line__free(pos);
-	}
+
+	annotated_source__purge(notes->src);
 
 out_free_offsets:
 	free(browser.offsets);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 7c74700ae6d7..0c2eb95ba90a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1985,13 +1985,13 @@ void symbol__annotate_decay_histogram(struct symbol *sym, int evidx)
 	}
 }
 
-void disasm__purge(struct list_head *head)
+void annotated_source__purge(struct annotated_source *as)
 {
-	struct disasm_line *pos, *n;
+	struct annotation_line *al, *n;
 
-	list_for_each_entry_safe(pos, n, head, al.node) {
-		list_del(&pos->al.node);
-		disasm_line__free(pos);
+	list_for_each_entry_safe(al, n, &as->source, node) {
+		list_del(&al->node);
+		disasm_line__free(disasm_line(al));
 	}
 }
 
@@ -2047,7 +2047,7 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 	if (print_lines)
 		symbol__free_source_line(sym, len);
 
-	disasm__purge(&symbol__annotation(sym)->src->source);
+	annotated_source__purge(symbol__annotation(sym)->src);
 
 	return 0;
 }
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 2e7a08afb04f..cb60cafae1fb 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -212,7 +212,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 			    int min_pcnt, int max_lines, int context);
 void symbol__annotate_zero_histogram(struct symbol *sym, int evidx);
 void symbol__annotate_decay_histogram(struct symbol *sym, int evidx);
-void disasm__purge(struct list_head *head);
+void annotated_source__purge(struct annotated_source *as);
 
 bool ui__has_annotation(void);
 
-- 
2.13.6
