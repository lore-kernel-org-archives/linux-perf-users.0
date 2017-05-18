From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v2] perf report: always honor callchain order for inlined nodes
Date: Thu, 18 May 2017 10:37:59 +0200
Message-ID: <20170518083759.14421-1-milian.wolff@kdab.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

So far, the inlined nodes where only reversed when we built perf
against libbfd. If that was not available, the addr2line fallback
code path was missing the inline_list__reverse call.

Now we always add the nodes in the correct order within
inline_list__append. This removes the need to reverse the list
and also ensures that all callers construct the list in the right
order.

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/srcline.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

v2:
- directly create list in correct order as suggested by Namhyung

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 5e376d64d59e..bbba9c69cfec 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -56,7 +56,10 @@ static int inline_list__append(char *filename, char *funcname, int line_nr,
 		}
 	}
 
-	list_add_tail(&ilist->list, &node->val);
+	if (callchain_param.order == ORDER_CALLEE)
+		list_add_tail(&ilist->list, &node->val);
+	else
+		list_add(&ilist->list, &node->val);
 
 	return 0;
 }
@@ -200,14 +203,6 @@ static void addr2line_cleanup(struct a2l_data *a2l)
 
 #define MAX_INLINE_NEST 1024
 
-static void inline_list__reverse(struct inline_node *node)
-{
-	struct inline_list *ilist, *n;
-
-	list_for_each_entry_safe_reverse(ilist, n, &node->val, list)
-		list_move_tail(&ilist->list, &node->val);
-}
-
 static int addr2line(const char *dso_name, u64 addr,
 		     char **file, unsigned int *line, struct dso *dso,
 		     bool unwind_inlines, struct inline_node *node)
@@ -250,11 +245,6 @@ static int addr2line(const char *dso_name, u64 addr,
 				ret = 1;
 			}
 		}
-
-		if ((node != NULL) &&
-		    (callchain_param.order != ORDER_CALLEE)) {
-			inline_list__reverse(node);
-		}
 	}
 
 	if (file) {
@@ -497,12 +487,15 @@ char *get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr)
 {
 	const char *dso_name;
+	struct inline_node *node;
 
 	dso_name = dso__name(dso);
 	if (dso_name == NULL)
 		return NULL;
 
-	return addr2inlines(dso_name, addr, dso);
+	node = addr2inlines(dso_name, addr, dso);
+
+	return node;
 }
 
 void inline_node__delete(struct inline_node *node)
-- 
2.13.0
