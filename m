From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/27] perf report: Fix a wrong offset issue when using /proc/kcore
Date: Wed, 10 Jan 2018 18:28:22 -0300
Message-ID: <20180110212844.12441-6-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

When a valid vmlinux is not found, 'perf report' falls back to look at
/proc/kcore. In this case, it will report the impossible large offset.

For example:

  # perf record -b -e cycles:k find /etc/ > /dev/null
  # perf report --stdio --branch-history

    22.77%  _vm_normal_page+18446603336221188162
            |
            ---page_remove_rmap +18446603336221188324
               page_remove_rmap +18446603336221188487 (cycles:5)
               unlock_page_memcg +18446603336221188096
               page_remove_rmap +18446603336221188327 (cycles:1)

The issue is the value which is passed to parameter 'addr' in
__get_srcline() is the objdump address. It's not correct if we calculate
the offset by using 'addr - sym->start'.

This patch creates a new parameter 'ip' in __get_srcline(). It is not
converted to objdump address.

With this patch, the perf report output is:

    22.77%  _vm_normal_page+66
            |
            ---page_remove_rmap +228
               page_remove_rmap +391 (cycles:5)
               unlock_page_memcg +0
               page_remove_rmap +231 (cycles:1)
               page_remove_rmap +236

Committer testing:

Make sure you get any valid vmlinux out of the way, using '-v' on the
'perf report' case and deleting it from places where perf searches them,
like your kernel build dir and the build-id cache, in ~/.debug/.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1514564812-17344-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c |  3 ++-
 tools/perf/util/machine.c  |  2 +-
 tools/perf/util/map.c      |  2 +-
 tools/perf/util/sort.c     | 16 ++++++++++------
 tools/perf/util/srcline.c  |  9 +++++----
 tools/perf/util/srcline.h  |  5 +++--
 6 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 68e687d1bf99..28b233c3dcbe 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1960,7 +1960,8 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 		if (percent_max <= 0.5)
 			continue;
 
-		al->path = get_srcline(map->dso, start + al->offset, NULL, false, true);
+		al->path = get_srcline(map->dso, start + al->offset, NULL,
+				       false, true, start + al->offset);
 		insert_source_line(&tmp_root, al);
 	}
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 64d255f6a537..b05a67464c03 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1726,7 +1726,7 @@ static char *callchain_srcline(struct map *map, struct symbol *sym, u64 ip)
 		bool show_addr = callchain_param.key == CCKEY_ADDRESS;
 
 		srcline = get_srcline(map->dso, map__rip_2objdump(map, ip),
-				      sym, show_sym, show_addr);
+				      sym, show_sym, show_addr, ip);
 		srcline__tree_insert(&map->dso->srclines, ip, srcline);
 	}
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 6d40efd74402..8fe57031e1a8 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -419,7 +419,7 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 	if (map && map->dso) {
 		srcline = get_srcline(map->dso,
 				      map__rip_2objdump(map, addr), NULL,
-				      true, true);
+				      true, true, addr);
 		if (srcline != SRCLINE_UNKNOWN)
 			ret = fprintf(fp, "%s%s", prefix, srcline);
 		free_srcline(srcline);
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index a00eacdf02ed..211e7f326b9f 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -336,7 +336,7 @@ char *hist_entry__get_srcline(struct hist_entry *he)
 		return SRCLINE_UNKNOWN;
 
 	return get_srcline(map->dso, map__rip_2objdump(map, he->ip),
-			   he->ms.sym, true, true);
+			   he->ms.sym, true, true, he->ip);
 }
 
 static int64_t
@@ -380,7 +380,8 @@ sort__srcline_from_cmp(struct hist_entry *left, struct hist_entry *right)
 					   map__rip_2objdump(map,
 							     left->branch_info->from.al_addr),
 							 left->branch_info->from.sym,
-							 true, true);
+							 true, true,
+							 left->branch_info->from.al_addr);
 	}
 	if (!right->branch_info->srcline_from) {
 		struct map *map = right->branch_info->from.map;
@@ -391,7 +392,8 @@ sort__srcline_from_cmp(struct hist_entry *left, struct hist_entry *right)
 					     map__rip_2objdump(map,
 							       right->branch_info->from.al_addr),
 						     right->branch_info->from.sym,
-						     true, true);
+						     true, true,
+						     right->branch_info->from.al_addr);
 	}
 	return strcmp(right->branch_info->srcline_from, left->branch_info->srcline_from);
 }
@@ -423,7 +425,8 @@ sort__srcline_to_cmp(struct hist_entry *left, struct hist_entry *right)
 					   map__rip_2objdump(map,
 							     left->branch_info->to.al_addr),
 							 left->branch_info->from.sym,
-							 true, true);
+							 true, true,
+							 left->branch_info->to.al_addr);
 	}
 	if (!right->branch_info->srcline_to) {
 		struct map *map = right->branch_info->to.map;
@@ -434,7 +437,8 @@ sort__srcline_to_cmp(struct hist_entry *left, struct hist_entry *right)
 					     map__rip_2objdump(map,
 							       right->branch_info->to.al_addr),
 						     right->branch_info->to.sym,
-						     true, true);
+						     true, true,
+						     right->branch_info->to.al_addr);
 	}
 	return strcmp(right->branch_info->srcline_to, left->branch_info->srcline_to);
 }
@@ -465,7 +469,7 @@ static char *hist_entry__get_srcfile(struct hist_entry *e)
 		return no_srcfile;
 
 	sf = __get_srcline(map->dso, map__rip_2objdump(map, e->ip),
-			 e->ms.sym, false, true, true);
+			 e->ms.sym, false, true, true, e->ip);
 	if (!strcmp(sf, SRCLINE_UNKNOWN))
 		return no_srcfile;
 	p = strchr(sf, ':');
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index d19f05c56de6..3c21fd059b64 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -496,7 +496,8 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 #define A2L_FAIL_LIMIT 123
 
 char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
-		  bool show_sym, bool show_addr, bool unwind_inlines)
+		  bool show_sym, bool show_addr, bool unwind_inlines,
+		  u64 ip)
 {
 	char *file = NULL;
 	unsigned line = 0;
@@ -536,7 +537,7 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 
 	if (sym) {
 		if (asprintf(&srcline, "%s+%" PRIu64, show_sym ? sym->name : "",
-					addr - sym->start) < 0)
+					ip - sym->start) < 0)
 			return SRCLINE_UNKNOWN;
 	} else if (asprintf(&srcline, "%s[%" PRIx64 "]", dso->short_name, addr) < 0)
 		return SRCLINE_UNKNOWN;
@@ -550,9 +551,9 @@ void free_srcline(char *srcline)
 }
 
 char *get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
-		  bool show_sym, bool show_addr)
+		  bool show_sym, bool show_addr, u64 ip)
 {
-	return __get_srcline(dso, addr, sym, show_sym, show_addr, false);
+	return __get_srcline(dso, addr, sym, show_sym, show_addr, false, ip);
 }
 
 struct srcline_node {
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index 847b7086182c..b2bb5502fd62 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -11,9 +11,10 @@ struct symbol;
 
 extern bool srcline_full_filename;
 char *get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
-		  bool show_sym, bool show_addr);
+		  bool show_sym, bool show_addr, u64 ip);
 char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
-		  bool show_sym, bool show_addr, bool unwind_inlines);
+		  bool show_sym, bool show_addr, bool unwind_inlines,
+		  u64 ip);
 void free_srcline(char *srcline);
 
 /* insert the srcline into the DSO, which will take ownership */
-- 
2.14.3
