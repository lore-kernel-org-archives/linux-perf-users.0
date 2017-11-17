From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/83] perf annotate: Remove disasm__calc_percent() from annotate_browser__calc_percent()
Date: Fri, 17 Nov 2017 17:14:59 -0300
Message-ID: <20171117201601.24110-22-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758265AbdKQUR2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:17:28 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Remove disasm__calc_percent() from annotate_browser__calc_percent(),
because we already have the data calculated in struct annotation_line.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-21-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 4c54d5e76008..613682432940 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -444,17 +444,16 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 	struct map_symbol *ms = browser->b.priv;
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
-	struct annotation_line *next;
 	struct disasm_line *pos;
-	s64 len = symbol__size(sym);
 
 	browser->entries = RB_ROOT;
 
 	pthread_mutex_lock(&notes->lock);
 
+	symbol__calc_percent(sym, evsel);
+
 	list_for_each_entry(pos, &notes->src->source, al.node) {
 		struct browser_disasm_line *bpos = disasm_line__browser(pos);
-		const char *path = NULL;
 		double max_percent = 0.0;
 		int i;
 
@@ -463,17 +462,11 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 			continue;
 		}
 
-		next = annotation_line__next(&pos->al, &notes->src->source);
-
 		for (i = 0; i < browser->nr_events; i++) {
-			struct sym_hist_entry sample;
-
-			bpos->samples[i].percent = disasm__calc_percent(notes,
-						evsel->idx + i,
-						pos->al.offset,
-						next ? next->offset : len,
-						&path, &sample);
-			bpos->samples[i].he = sample;
+			struct annotation_data *sample = &pos->al.samples[i];
+
+			bpos->samples[i].percent = sample->percent;
+			bpos->samples[i].he      = sample->he;
 
 			if (max_percent < bpos->samples[i].percent)
 				max_percent = bpos->samples[i].percent;
-- 
2.13.6
