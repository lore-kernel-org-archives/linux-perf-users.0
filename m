From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 6/7] perf top: Fix wrong hottest instruction highlighted
Date: Mon, 21 Jan 2019 15:35:06 -0300
Message-ID: <20190121183507.23490-7-acme@kernel.org>
References: <20190121183507.23490-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121183507.23490-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, He Kuang <hekuang@huawei.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: He Kuang <hekuang@huawei.com>

The annotation line percentage is compared and inserted into the rbtree,
but the percent field of 'struct annotation_data' is an array, the
comparison result between them is the address difference.

This patch compares the right slot of percent array according to
opts->percent_type and makes things right.

The problem can be reproduced by pressing 'H' in perf top annotation view.
It should highlight the instruction line which has the highest sampling
percentage.

Signed-off-by: He Kuang <hekuang@huawei.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190120160523.4391-1-hekuang@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 1d00e5ec7906..82e16bf84466 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -224,20 +224,24 @@ static unsigned int annotate_browser__refresh(struct ui_browser *browser)
 	return ret;
 }
 
-static int disasm__cmp(struct annotation_line *a, struct annotation_line *b)
+static double disasm__cmp(struct annotation_line *a, struct annotation_line *b,
+						  int percent_type)
 {
 	int i;
 
 	for (i = 0; i < a->data_nr; i++) {
-		if (a->data[i].percent == b->data[i].percent)
+		if (a->data[i].percent[percent_type] == b->data[i].percent[percent_type])
 			continue;
-		return a->data[i].percent < b->data[i].percent;
+		return a->data[i].percent[percent_type] -
+			   b->data[i].percent[percent_type];
 	}
 	return 0;
 }
 
-static void disasm_rb_tree__insert(struct rb_root *root, struct annotation_line *al)
+static void disasm_rb_tree__insert(struct annotate_browser *browser,
+				struct annotation_line *al)
 {
+	struct rb_root *root = &browser->entries;
 	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
 	struct annotation_line *l;
@@ -246,7 +250,7 @@ static void disasm_rb_tree__insert(struct rb_root *root, struct annotation_line
 		parent = *p;
 		l = rb_entry(parent, struct annotation_line, rb_node);
 
-		if (disasm__cmp(al, l))
+		if (disasm__cmp(al, l, browser->opts->percent_type) < 0)
 			p = &(*p)->rb_left;
 		else
 			p = &(*p)->rb_right;
@@ -329,7 +333,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 			RB_CLEAR_NODE(&pos->al.rb_node);
 			continue;
 		}
-		disasm_rb_tree__insert(&browser->entries, &pos->al);
+		disasm_rb_tree__insert(browser, &pos->al);
 	}
 	pthread_mutex_unlock(&notes->lock);
 
-- 
2.20.1
