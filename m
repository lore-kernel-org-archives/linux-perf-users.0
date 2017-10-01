From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v4 13/15] perf report: cache srclines for callchain nodes
Date: Sun,  1 Oct 2017 16:30:58 +0200
Message-ID: <20171001143100.19988-14-milian.wolff@kdab.com>
References: <20171001143100.19988-1-milian.wolff@kdab.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171001143100.19988-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-perf-users.vger.kernel.org

On one hand this ensures that the memory is properly freed when
the DSO gets freed. On the other hand this significantly speeds up
the processing of the callchain nodes when lots of srclines are
requested. For one of my data files e.g.:

Before:

 Performance counter stats for 'perf report -s srcline -g srcline --stdio':

      52496.495043      task-clock (msec)         #    0.999 CPUs utilized
               634      context-switches          #    0.012 K/sec
                 2      cpu-migrations            #    0.000 K/sec
           191,561      page-faults               #    0.004 M/sec
   165,074,498,235      cycles                    #    3.144 GHz
   334,170,832,408      instructions              #    2.02  insn per cycle
    90,220,029,745      branches                  # 1718.591 M/sec
       654,525,177      branch-misses             #    0.73% of all branches

      52.533273822 seconds time elapsedProcessed 236605 events and lost 40 chunks!

After:

 Performance counter stats for 'perf report -s srcline -g srcline --stdio':

      22606.323706      task-clock (msec)         #    1.000 CPUs utilized
                31      context-switches          #    0.001 K/sec
                 0      cpu-migrations            #    0.000 K/sec
           185,471      page-faults               #    0.008 M/sec
    71,188,113,681      cycles                    #    3.149 GHz
   133,204,943,083      instructions              #    1.87  insn per cycle
    34,886,384,979      branches                  # 1543.214 M/sec
       278,214,495      branch-misses             #    0.80% of all branches

      22.609857253 seconds time elapsed

Note that the difference is only this large when `--inline` is not
passed. In such situations, we would use the inliner cache and
thus do not run this code path that often.

I think that this cache should actually be used in other places, too.
When looking at the valgrind leak report for perf report, we see tons
of srclines being leaked, most notably from calls to
hist_entry__get_srcline. The problem is that get_srcline has many
different formatting options (show_sym, show_addr, potentially even
unwind_inlines when calling __get_srcline directly). As such, the
srcline cannot easily be cached for all calls, or we'd have to add
caches for all formatting combinations (6 so far). An alternative
would be to remove the formatting options and handle that on a
different level - i.e. print the sym/addr on demand wherever we
actually output something. And the unwind_inlines could be moved into
a separate function that does not return the srcline.

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/dso.c     |  2 ++
 tools/perf/util/dso.h     |  1 +
 tools/perf/util/machine.c | 17 +++++++++---
 tools/perf/util/srcline.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/srcline.h |  7 +++++
 5 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 6e743dffc487..e73ef7854a07 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1203,6 +1203,7 @@ struct dso *dso__new(const char *name)
 			dso->symbols[i] = dso->symbol_names[i] = RB_ROOT;
 		dso->data.cache = RB_ROOT;
 		dso->inlined_nodes = RB_ROOT;
+		dso->srclines = RB_ROOT;
 		dso->data.fd = -1;
 		dso->data.status = DSO_DATA_STATUS_UNKNOWN;
 		dso->symtab_type = DSO_BINARY_TYPE__NOT_FOUND;
@@ -1237,6 +1238,7 @@ void dso__delete(struct dso *dso)
 	for (i = 0; i < MAP__NR_TYPES; ++i)
 		symbols__delete(&dso->symbols[i]);
 	inlines__tree_delete(&dso->inlined_nodes);
+	srcline__tree_delete(&dso->srclines);
 
 	if (dso->short_name_allocated) {
 		zfree((char **)&dso->short_name);
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 122eca0d242d..821b16c67030 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -142,6 +142,7 @@ struct dso {
 	struct rb_root	 symbols[MAP__NR_TYPES];
 	struct rb_root	 symbol_names[MAP__NR_TYPES];
 	struct rb_root	 inlined_nodes;
+	struct rb_root	 srclines;
 	struct {
 		u64		addr;
 		struct symbol	*symbol;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 888f71793ce1..06a1c19958d8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1711,11 +1711,22 @@ struct mem_info *sample__resolve_mem(struct perf_sample *sample,
 
 static char *callchain_srcline(struct map *map, struct symbol *sym, u64 ip)
 {
+	char *srcline = NULL;
+
 	if (!map || callchain_param.key == CCKEY_FUNCTION)
-		return NULL;
+		return srcline;
+
+	srcline = srcline__tree_find(&map->dso->srclines, ip);
+	if (!srcline) {
+		bool show_sym = false;
+		bool show_addr = callchain_param.key == CCKEY_ADDRESS;
+
+		srcline = get_srcline(map->dso, map__rip_2objdump(map, ip),
+				      sym, show_sym, show_addr);
+		srcline__tree_insert(&map->dso->srclines, ip, srcline);
+	}
 
-	return get_srcline(map->dso, map__rip_2objdump(map, ip),
-			   sym, false, callchain_param.key == CCKEY_ADDRESS);
+	return srcline;
 }
 
 struct iterations {
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 26d9954dc19e..03b7432a1578 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -542,6 +542,72 @@ char *get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 	return __get_srcline(dso, addr, sym, show_sym, show_addr, false);
 }
 
+struct srcline_node {
+	u64			addr;
+	char			*srcline;
+	struct rb_node		rb_node;
+};
+
+void srcline__tree_insert(struct rb_root *tree, u64 addr, char *srcline)
+{
+	struct rb_node **p = &tree->rb_node;
+	struct rb_node *parent = NULL;
+	struct srcline_node *i, *node;
+
+	node = zalloc(sizeof(struct srcline_node));
+	if (!node) {
+		perror("not enough memory for the srcline node");
+		return;
+	}
+
+	node->addr = addr;
+	node->srcline = srcline;
+
+	while (*p != NULL) {
+		parent = *p;
+		i = rb_entry(parent, struct srcline_node, rb_node);
+		if (addr < i->addr)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+	rb_link_node(&node->rb_node, parent, p);
+	rb_insert_color(&node->rb_node, tree);
+}
+
+char *srcline__tree_find(struct rb_root *tree, u64 addr)
+{
+	struct rb_node *n = tree->rb_node;
+
+	while (n) {
+		struct srcline_node *i = rb_entry(n, struct srcline_node,
+						  rb_node);
+
+		if (addr < i->addr)
+			n = n->rb_left;
+		else if (addr > i->addr)
+			n = n->rb_right;
+		else
+			return i->srcline;
+	}
+
+	return NULL;
+}
+
+void srcline__tree_delete(struct rb_root *tree)
+{
+	struct srcline_node *pos;
+	struct rb_node *next = rb_first(tree);
+
+	while (next) {
+		pos = rb_entry(next, struct srcline_node, rb_node);
+		next = rb_next(&pos->rb_node);
+		rb_erase(&pos->rb_node, tree);
+		free_srcline(pos->srcline);
+		zfree(&pos);
+	}
+}
+
 struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
 					    struct symbol *sym)
 {
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index ebe38cd22294..1c4d6210860b 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -15,6 +15,13 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 		  bool show_sym, bool show_addr, bool unwind_inlines);
 void free_srcline(char *srcline);
 
+/* insert the srcline into the DSO, which will take ownership */
+void srcline__tree_insert(struct rb_root *tree, u64 addr, char *srcline);
+/* find previously inserted srcline */
+char *srcline__tree_find(struct rb_root *tree, u64 addr);
+/* delete all srclines within the tree */
+void srcline__tree_delete(struct rb_root *tree);
+
 #define SRCLINE_UNKNOWN  ((char *) "??:0")
 
 struct inline_list {
-- 
2.14.2
