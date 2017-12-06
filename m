From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/36] perf rblist: Create rblist__exit() function
Date: Wed,  6 Dec 2017 11:40:54 -0300
Message-ID: <20171206144115.15097-16-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Currently we have a rblist__delete() which is used to delete a rblist.
While rblist__delete() will free the pointer of rblist at the end.

It's an inconvenience for the user to delete a rblist which is not
allocated by something like malloc(). For example, the rblist is
embedded in a larger data structure.

This patch creates a new function rblist__exit() which is similar to
rblist__delete() but it will not free the pointer of rblist.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1512125856-22056-2-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/rblist.c | 19 ++++++++++++-------
 tools/perf/util/rblist.h |  1 +
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/rblist.c b/tools/perf/util/rblist.c
index 0dfe27d99458..0efc3258c648 100644
--- a/tools/perf/util/rblist.c
+++ b/tools/perf/util/rblist.c
@@ -101,16 +101,21 @@ void rblist__init(struct rblist *rblist)
 	return;
 }
 
+void rblist__exit(struct rblist *rblist)
+{
+	struct rb_node *pos, *next = rb_first(&rblist->entries);
+
+	while (next) {
+		pos = next;
+		next = rb_next(pos);
+		rblist__remove_node(rblist, pos);
+	}
+}
+
 void rblist__delete(struct rblist *rblist)
 {
 	if (rblist != NULL) {
-		struct rb_node *pos, *next = rb_first(&rblist->entries);
-
-		while (next) {
-			pos = next;
-			next = rb_next(pos);
-			rblist__remove_node(rblist, pos);
-		}
+		rblist__exit(rblist);
 		free(rblist);
 	}
 }
diff --git a/tools/perf/util/rblist.h b/tools/perf/util/rblist.h
index 4c8638a22571..76df15c27f5f 100644
--- a/tools/perf/util/rblist.h
+++ b/tools/perf/util/rblist.h
@@ -29,6 +29,7 @@ struct rblist {
 };
 
 void rblist__init(struct rblist *rblist);
+void rblist__exit(struct rblist *rblist);
 void rblist__delete(struct rblist *rblist);
 int rblist__add_node(struct rblist *rblist, const void *new_entry);
 void rblist__remove_node(struct rblist *rblist, struct rb_node *rb_node);
-- 
2.13.6
