From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/83] perf annotate browser: Do not pass nr_events in disasm_rb_tree__insert
Date: Fri, 17 Nov 2017 17:15:05 -0300
Message-ID: <20171117201601.24110-28-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We now keep samples_nr in struct annotation_line, so there's no need to
pass nr_events to disasm_rb_tree__insert function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-27-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 5d99429a03bc..67e5955b3c6f 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -356,12 +356,11 @@ static unsigned int annotate_browser__refresh(struct ui_browser *browser)
 	return ret;
 }
 
-static int disasm__cmp(struct annotation_line *a,
-		       struct annotation_line *b, int nr_pcnt)
+static int disasm__cmp(struct annotation_line *a, struct annotation_line *b)
 {
 	int i;
 
-	for (i = 0; i < nr_pcnt; i++) {
+	for (i = 0; i < a->samples_nr; i++) {
 		if (a->samples[i].percent == b->samples[i].percent)
 			continue;
 		return a->samples[i].percent < b->samples[i].percent;
@@ -369,8 +368,7 @@ static int disasm__cmp(struct annotation_line *a,
 	return 0;
 }
 
-static void disasm_rb_tree__insert(struct rb_root *root, struct annotation_line *al,
-				   int nr_events)
+static void disasm_rb_tree__insert(struct rb_root *root, struct annotation_line *al)
 {
 	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
@@ -380,7 +378,7 @@ static void disasm_rb_tree__insert(struct rb_root *root, struct annotation_line
 		parent = *p;
 		l = rb_entry(parent, struct annotation_line, rb_node);
 
-		if (disasm__cmp(al, l, nr_events))
+		if (disasm__cmp(al, l))
 			p = &(*p)->rb_left;
 		else
 			p = &(*p)->rb_right;
@@ -452,7 +450,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 			continue;
 		}
 
-		for (i = 0; i < browser->nr_events; i++) {
+		for (i = 0; i < pos->al.samples_nr; i++) {
 			struct annotation_data *sample = &pos->al.samples[i];
 
 			if (max_percent < sample->percent)
@@ -463,8 +461,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 			RB_CLEAR_NODE(&pos->al.rb_node);
 			continue;
 		}
-		disasm_rb_tree__insert(&browser->entries, &pos->al,
-				       browser->nr_events);
+		disasm_rb_tree__insert(&browser->entries, &pos->al);
 	}
 	pthread_mutex_unlock(&notes->lock);
 
-- 
2.13.6
