From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v3] perf report: always honor callchain order for inlined nodes
Date: Thu, 18 May 2017 14:16:52 +0200
Message-ID: <20170518121652.16679-1-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:57920 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754241AbdERMQ5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 May 2017 08:16:57 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>

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
 tools/perf/util/srcline.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

v3:
- minimize code changes

v2:
- directly create list in correct order as suggested by Namhyung

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 5e376d64d59e..6af0364cad06 100644
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
-- 
2.13.0
