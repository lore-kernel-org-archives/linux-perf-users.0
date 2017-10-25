From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/15] perf report: Cache failed lookups of inlined frames
Date: Wed, 25 Oct 2017 13:00:10 -0300
Message-ID: <20171025160013.11136-13-acme@kernel.org>
References: <20171025160013.11136-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932352AbdJYQBE (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Oct 2017 12:01:04 -0400
In-Reply-To: <20171025160013.11136-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Milian Wolff <milian.wolff@kdab.com>

When no inlined frames could be found for a given address, we did not
store this information anywhere. That means we potentially do the costly
inliner lookup repeatedly for cases where we know it can never succeed.

This patch makes dso__parse_addr_inlines always return a valid
inline_node. It will be empty when no inliners are found. This enables
us to cache the empty list in the DSO, thereby improving the performance
when many addresses fail to find the inliners.

For my trivial example, the performance impact is already quite
significant:

Before:

~~~~~
 Performance counter stats for 'perf report --stdio --inline -g srcline -s srcline' (5 runs):

        594.804032      task-clock (msec)         #    0.998 CPUs utilized            ( +-  0.07% )
                53      context-switches          #    0.089 K/sec                    ( +-  4.09% )
                 0      cpu-migrations            #    0.000 K/sec                    ( +-100.00% )
             5,687      page-faults               #    0.010 M/sec                    ( +-  0.02% )
     2,300,918,213      cycles                    #    3.868 GHz                      ( +-  0.09% )
     4,395,839,080      instructions              #    1.91  insn per cycle           ( +-  0.00% )
       939,177,205      branches                  # 1578.969 M/sec                    ( +-  0.00% )
        11,824,633      branch-misses             #    1.26% of all branches          ( +-  0.10% )

       0.596246531 seconds time elapsed                                          ( +-  0.07% )
~~~~~

After:

~~~~~
 Performance counter stats for 'perf report --stdio --inline -g srcline -s srcline' (5 runs):

        113.111405      task-clock (msec)         #    0.990 CPUs utilized            ( +-  0.89% )
                29      context-switches          #    0.255 K/sec                    ( +- 54.25% )
                 0      cpu-migrations            #    0.000 K/sec
             5,380      page-faults               #    0.048 M/sec                    ( +-  0.01% )
       432,378,779      cycles                    #    3.823 GHz                      ( +-  0.75% )
       670,057,633      instructions              #    1.55  insn per cycle           ( +-  0.01% )
       141,001,247      branches                  # 1246.570 M/sec                    ( +-  0.01% )
         2,346,845      branch-misses             #    1.66% of all branches          ( +-  0.19% )

       0.114222393 seconds time elapsed                                          ( +-  1.19% )
~~~~~

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171019113836.5548-3-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 15 +++++++--------
 tools/perf/util/srcline.c | 16 +---------------
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3d049cb313ac..177c1d4088f8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2115,9 +2115,10 @@ static int append_inlines(struct callchain_cursor *cursor,
 	struct inline_node *inline_node;
 	struct inline_list *ilist;
 	u64 addr;
+	int ret = 1;
 
 	if (!symbol_conf.inline_name || !map || !sym)
-		return 1;
+		return ret;
 
 	addr = map__rip_2objdump(map, ip);
 
@@ -2125,22 +2126,20 @@ static int append_inlines(struct callchain_cursor *cursor,
 	if (!inline_node) {
 		inline_node = dso__parse_addr_inlines(map->dso, addr, sym);
 		if (!inline_node)
-			return 1;
-
+			return ret;
 		inlines__tree_insert(&map->dso->inlined_nodes, inline_node);
 	}
 
 	list_for_each_entry(ilist, &inline_node->val, list) {
-		int ret = callchain_cursor_append(cursor, ip, map,
-						  ilist->symbol, false,
-						  NULL, 0, 0, 0,
-						  ilist->srcline);
+		ret = callchain_cursor_append(cursor, ip, map,
+					      ilist->symbol, false,
+					      NULL, 0, 0, 0, ilist->srcline);
 
 		if (ret != 0)
 			return ret;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int unwind_entry(struct unwind_entry *entry, void *arg)
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 8bea6621d657..fc3888664b20 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -353,17 +353,8 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 	INIT_LIST_HEAD(&node->val);
 	node->addr = addr;
 
-	if (!addr2line(dso_name, addr, NULL, NULL, dso, TRUE, node, sym))
-		goto out_free_inline_node;
-
-	if (list_empty(&node->val))
-		goto out_free_inline_node;
-
+	addr2line(dso_name, addr, NULL, NULL, dso, true, node, sym);
 	return node;
-
-out_free_inline_node:
-	inline_node__delete(node);
-	return NULL;
 }
 
 #else /* HAVE_LIBBFD_SUPPORT */
@@ -480,11 +471,6 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 out:
 	pclose(fp);
 
-	if (list_empty(&node->val)) {
-		inline_node__delete(node);
-		return NULL;
-	}
-
 	return node;
 }
 
-- 
2.13.6
