From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH] perf report: enable sorting by srcline as key
Date: Sat, 18 Mar 2017 22:49:28 +0100
Message-ID: <20170318214928.9047-1-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:60638 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751187AbdCRWAN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 18 Mar 2017 18:00:13 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>

Often it is interesting to know how costly a given source line is in
total. Previously, one had to build these sums manually based on all
addresses that pointed to the same source line. This patch introduces
srcline as a sort key, which will do the aggregation for us.

Paired with the recent addition of showing inline frames, this makes
perf report much more useful for many C++ work loads.

The following shows the new feature in action. First, let's show the
status quo output when we sort by address. The result contains many
hist entries that generate the same output:

~~~~~~~~~~~~~~~~
$ perf report --stdio --inline -g address
# Children      Self  Command       Shared Object        Symbol
# ........  ........  ............  ...................  .........................................
#
    99.89%    35.34%  cpp-inlining  cpp-inlining         [.] main
            |
            |--64.55%--main complex:655
            |          /home/milian/projects/kdab/rnd/hotspot/tests/test-clients/cpp-inlining/main.cpp:39 (inline)
            |          /usr/include/c++/6.3.1/complex:664 (inline)
            |          |
            |          |--60.31%--hypot +20
            |          |          |
            |          |          |--8.52%--__hypot_finite +273
            |          |          |
            |          |          |--7.32%--__hypot_finite +411
...
             --35.34%--_start +4194346
                       __libc_start_main +241
                       |
                       |--6.65%--main random.tcc:3326
                       |          /home/milian/projects/kdab/rnd/hotspot/tests/test-clients/cpp-inlining/main.cpp:39 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:1809 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:1818 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:185 (inline)
                       |
                       |--2.70%--main random.tcc:3326
                       |          /home/milian/projects/kdab/rnd/hotspot/tests/test-clients/cpp-inlining/main.cpp:39 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:1809 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:1818 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:185 (inline)
                       |
                       |--1.69%--main random.tcc:3326
                       |          /home/milian/projects/kdab/rnd/hotspot/tests/test-clients/cpp-inlining/main.cpp:39 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:1809 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:1818 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:185 (inline)
...
~~~~~~~~~~~~~~~~

With this patch and `-g srcline` we instead get the following output:

~~~~~~~~~~~~~~~~
$ perf report --stdio --inline -g srcline
# Children      Self  Command       Shared Object        Symbol
# ........  ........  ............  ...................  .........................................
#
    99.89%    35.34%  cpp-inlining  cpp-inlining         [.] main
            |
            |--64.55%--main complex:655
            |          /home/milian/projects/kdab/rnd/hotspot/tests/test-clients/cpp-inlining/main.cpp:39 (inline)
            |          /usr/include/c++/6.3.1/complex:664 (inline)
            |          |
            |          |--64.02%--hypot
            |          |          |
            |          |           --59.81%--__hypot_finite
            |          |
            |           --0.53%--cabs
            |
             --35.34%--_start
                       __libc_start_main
                       |
                       |--12.48%--main random.tcc:3326
                       |          /home/milian/projects/kdab/rnd/hotspot/tests/test-clients/cpp-inlining/main.cpp:39 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:1809 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:1818 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:185 (inline)
...
~~~~~~~~~~~~~~~~

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/Documentation/perf-report.txt |  1 +
 tools/perf/ui/browsers/hists.c           |  3 +-
 tools/perf/ui/stdio/hist.c               |  3 +-
 tools/perf/util/annotate.c               |  3 +-
 tools/perf/util/callchain.c              | 52 +++++++++++++++++++++++++++++---
 tools/perf/util/callchain.h              |  3 +-
 tools/perf/util/map.c                    |  3 +-
 tools/perf/util/sort.c                   | 16 ++++++----
 tools/perf/util/srcline.c                | 11 +++++--
 tools/perf/util/util.h                   |  4 +--
 10 files changed, 78 insertions(+), 21 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 248bba434b53..37a175914157 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -235,6 +235,7 @@ OPTIONS
 	sort_key can be:
 	- function: compare on functions (default)
 	- address: compare on individual code addresses
+	- srcline: compare on source filename and line number
 
 	branch can be:
 	- branch: include last branch information in callgraph when available.
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 757222bc9dad..bca08be9fd78 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -851,7 +851,8 @@ static int hist_browser__show_inline(struct hist_browser *browser,
 			if (ui_browser__is_current_entry(&browser->b, row))
 				color = HE_COLORSET_SELECTED;
 
-			if (callchain_param.key == CCKEY_ADDRESS) {
+			if (callchain_param.key == CCKEY_ADDRESS ||
+			    callchain_param.key == CCKEY_SRCLINE) {
 				if (ilist->filename != NULL)
 					scnprintf(buf, sizeof(buf),
 						  "%s:%d (inline)",
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 183470f25100..bf95b4a9a592 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -53,7 +53,8 @@ static size_t inline__fprintf(struct map *map, u64 ip, int left_margin,
 				ret += fprintf(fp, "          ");
 			}
 
-			if (callchain_param.key == CCKEY_ADDRESS) {
+			if (callchain_param.key == CCKEY_ADDRESS ||
+			    callchain_param.key == CCKEY_SRCLINE) {
 				if (ilist->filename != NULL)
 					ret += fprintf(fp, "%s:%d (inline)",
 						       ilist->filename,
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 273f21fa32b5..e7194ff88c4f 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1668,7 +1668,8 @@ static int symbol__get_source_line(struct symbol *sym, struct map *map,
 			goto next;
 
 		offset = start + i;
-		src_line->path = get_srcline(map->dso, offset, NULL, false);
+		src_line->path = get_srcline(map->dso, offset, NULL,
+					     false, true);
 		insert_source_line(&tmp_root, src_line);
 
 	next:
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index aba953421a03..d78776a20e80 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -80,6 +80,10 @@ static int parse_callchain_sort_key(const char *value)
 		callchain_param.key = CCKEY_ADDRESS;
 		return 0;
 	}
+	if (!strncmp(value, "srcline", strlen(value))) {
+		callchain_param.key = CCKEY_SRCLINE;
+		return 0;
+	}
 	if (!strncmp(value, "branch", strlen(value))) {
 		callchain_param.branch_callstack = 1;
 		return 0;
@@ -510,14 +514,51 @@ enum match_result {
 	MATCH_GT,
 };
 
+static enum match_result match_chain_srcline(struct callchain_cursor_node *node,
+					     struct callchain_list *cnode)
+{
+	char *left = get_srcline(cnode->ms.map->dso,
+				 map__rip_2objdump(cnode->ms.map, cnode->ip),
+				 cnode->ms.sym, true, false);
+	char *right = get_srcline(node->map->dso,
+				  map__rip_2objdump(node->map, node->ip),
+				  node->sym, true, false);
+	enum match_result ret = MATCH_EQ;
+	int cmp;
+
+	if (left && right)
+		cmp = strcmp(left, right);
+	else if (!left && right)
+		cmp = 1;
+	else if (left && !right)
+		cmp = -1;
+	else if (cnode->ip == node->ip)
+		cmp = 0;
+	else
+		cmp = (cnode->ip < node->ip) ? -1 : 1;
+
+	if (cmp != 0)
+		ret = cmp < 0 ? MATCH_LT : MATCH_GT;
+
+	free_srcline(left);
+	free_srcline(right);
+	return ret;
+}
+
 static enum match_result match_chain(struct callchain_cursor_node *node,
 				     struct callchain_list *cnode)
 {
 	struct symbol *sym = node->sym;
 	u64 left, right;
 
-	if (cnode->ms.sym && sym &&
-	    callchain_param.key == CCKEY_FUNCTION) {
+	if (callchain_param.key == CCKEY_SRCLINE) {
+		enum match_result match = match_chain_srcline(node, cnode);
+
+		if (match != MATCH_ERROR)
+			return match;
+	}
+
+	if (cnode->ms.sym && sym && callchain_param.key == CCKEY_FUNCTION) {
 		left = cnode->ms.sym->start;
 		right = sym->start;
 	} else {
@@ -911,15 +952,16 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 char *callchain_list__sym_name(struct callchain_list *cl,
 			       char *bf, size_t bfsize, bool show_dso)
 {
+	bool show_addr = callchain_param.key == CCKEY_ADDRESS;
+	bool show_srcline = show_addr || callchain_param.key == CCKEY_SRCLINE;
 	int printed;
 
 	if (cl->ms.sym) {
-		if (callchain_param.key == CCKEY_ADDRESS &&
-		    cl->ms.map && !cl->srcline)
+		if (show_srcline && cl->ms.map && !cl->srcline)
 			cl->srcline = get_srcline(cl->ms.map->dso,
 						  map__rip_2objdump(cl->ms.map,
 								    cl->ip),
-						  cl->ms.sym, false);
+						  cl->ms.sym, false, show_addr);
 		if (cl->srcline)
 			printed = scnprintf(bf, bfsize, "%s %s",
 					cl->ms.sym->name, cl->srcline);
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 4f4b60f1558a..c56c23dbbf72 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -77,7 +77,8 @@ typedef void (*sort_chain_func_t)(struct rb_root *, struct callchain_root *,
 
 enum chain_key {
 	CCKEY_FUNCTION,
-	CCKEY_ADDRESS
+	CCKEY_ADDRESS,
+	CCKEY_SRCLINE
 };
 
 enum chain_value {
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 1d9ebcf9e38e..c1870ac365a3 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -405,7 +405,8 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 
 	if (map && map->dso) {
 		srcline = get_srcline(map->dso,
-				      map__rip_2objdump(map, addr), NULL, true);
+				      map__rip_2objdump(map, addr), NULL,
+				      true, true);
 		if (srcline != SRCLINE_UNKNOWN)
 			ret = fprintf(fp, "%s%s", prefix, srcline);
 		free_srcline(srcline);
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 8b0d4e39f640..73f3ec1cf2a0 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -323,7 +323,7 @@ char *hist_entry__get_srcline(struct hist_entry *he)
 		return SRCLINE_UNKNOWN;
 
 	return get_srcline(map->dso, map__rip_2objdump(map, he->ip),
-			   he->ms.sym, true);
+			   he->ms.sym, true, true);
 }
 
 static int64_t
@@ -366,7 +366,8 @@ sort__srcline_from_cmp(struct hist_entry *left, struct hist_entry *right)
 			left->branch_info->srcline_from = get_srcline(map->dso,
 					   map__rip_2objdump(map,
 							     left->branch_info->from.al_addr),
-							 left->branch_info->from.sym, true);
+							 left->branch_info->from.sym,
+							 true, true);
 	}
 	if (!right->branch_info->srcline_from) {
 		struct map *map = right->branch_info->from.map;
@@ -376,7 +377,8 @@ sort__srcline_from_cmp(struct hist_entry *left, struct hist_entry *right)
 			right->branch_info->srcline_from = get_srcline(map->dso,
 					     map__rip_2objdump(map,
 							       right->branch_info->from.al_addr),
-						     right->branch_info->from.sym, true);
+						     right->branch_info->from.sym,
+						     true, true);
 	}
 	return strcmp(right->branch_info->srcline_from, left->branch_info->srcline_from);
 }
@@ -407,7 +409,8 @@ sort__srcline_to_cmp(struct hist_entry *left, struct hist_entry *right)
 			left->branch_info->srcline_to = get_srcline(map->dso,
 					   map__rip_2objdump(map,
 							     left->branch_info->to.al_addr),
-							 left->branch_info->from.sym, true);
+							 left->branch_info->from.sym,
+							 true, true);
 	}
 	if (!right->branch_info->srcline_to) {
 		struct map *map = right->branch_info->to.map;
@@ -417,7 +420,8 @@ sort__srcline_to_cmp(struct hist_entry *left, struct hist_entry *right)
 			right->branch_info->srcline_to = get_srcline(map->dso,
 					     map__rip_2objdump(map,
 							       right->branch_info->to.al_addr),
-						     right->branch_info->to.sym, true);
+						     right->branch_info->to.sym,
+						     true, true);
 	}
 	return strcmp(right->branch_info->srcline_to, left->branch_info->srcline_to);
 }
@@ -448,7 +452,7 @@ static char *hist_entry__get_srcfile(struct hist_entry *e)
 		return no_srcfile;
 
 	sf = __get_srcline(map->dso, map__rip_2objdump(map, e->ip),
-			 e->ms.sym, false, true);
+			 e->ms.sym, false, true, true);
 	if (!strcmp(sf, SRCLINE_UNKNOWN))
 		return no_srcfile;
 	p = strchr(sf, ':');
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index f9d4b47d1fb5..6f8651104990 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -427,7 +427,7 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 #define A2L_FAIL_LIMIT 123
 
 char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
-		  bool show_sym, bool unwind_inlines)
+		  bool show_sym, bool show_addr, bool unwind_inlines)
 {
 	char *file = NULL;
 	unsigned line = 0;
@@ -461,6 +461,11 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 		dso->has_srcline = 0;
 		dso__free_a2l(dso);
 	}
+
+	if (!show_addr)
+		return (show_sym && sym) ?
+			    strndup(sym->name, sym->namelen) : NULL;
+
 	if (sym) {
 		if (asprintf(&srcline, "%s+%" PRIu64, show_sym ? sym->name : "",
 					addr - sym->start) < 0)
@@ -477,9 +482,9 @@ void free_srcline(char *srcline)
 }
 
 char *get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
-		  bool show_sym)
+		  bool show_sym, bool show_addr)
 {
-	return __get_srcline(dso, addr, sym, show_sym, false);
+	return __get_srcline(dso, addr, sym, show_sym, show_addr, false);
 }
 
 struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr)
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index cc0700d6fef0..7cf5752b38fd 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -287,9 +287,9 @@ struct symbol;
 
 extern bool srcline_full_filename;
 char *get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
-		  bool show_sym);
+		  bool show_sym, bool show_addr);
 char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
-		  bool show_sym, bool unwind_inlines);
+		  bool show_sym, bool show_addr, bool unwind_inlines);
 void free_srcline(char *srcline);
 
 int perf_event_paranoid(void);
-- 
2.12.0
