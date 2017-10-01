From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v4 04/15] perf util: refactor inline_list to store srcline string directly
Date: Sun,  1 Oct 2017 16:30:49 +0200
Message-ID: <20171001143100.19988-5-milian.wolff@kdab.com>
References: <20171001143100.19988-1-milian.wolff@kdab.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171001143100.19988-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-perf-users.vger.kernel.org

This is a preparation for the creation of real callchain entries
for inlined frames. The rest of the perf code uses the srcline
string. As such, using that also for the srcline API allows us
to simplify some of the upcoming code. Most notably, it will
allow us to cache the srcline for a given inline node and reuse
it for different callchain entries.

Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/srcline.c | 54 +++++++++++++++++++++++++++++++++++------------
 tools/perf/util/srcline.h |  3 +--
 2 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 296f22e1cbef..07d1a058d7c4 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -33,8 +33,8 @@ static const char *dso__name(struct dso *dso)
 	return dso_name;
 }
 
-static int inline_list__append(struct symbol *symbol, char *filename,
-			       int line_nr, struct inline_node *node)
+static int inline_list__append(struct symbol *symbol, char *srcline,
+			       struct inline_node *node)
 {
 	struct inline_list *ilist;
 
@@ -43,8 +43,7 @@ static int inline_list__append(struct symbol *symbol, char *filename,
 		return -1;
 
 	ilist->symbol = symbol;
-	ilist->filename = filename;
-	ilist->line_nr = line_nr;
+	ilist->srcline = srcline;
 
 	if (callchain_param.order == ORDER_CALLEE)
 		list_add_tail(&ilist->list, &node->val);
@@ -54,6 +53,30 @@ static int inline_list__append(struct symbol *symbol, char *filename,
 	return 0;
 }
 
+/* basename version that takes a const input string */
+static const char *gnu_basename(const char *path)
+{
+	const char *base = strrchr(path, '/');
+
+	return base ? base + 1 : path;
+}
+
+static char *srcline_from_fileline(const char *file, unsigned int line)
+{
+	char *srcline;
+
+	if (!file)
+		return NULL;
+
+	if (!srcline_full_filename)
+		file = gnu_basename(file);
+
+	if (asprintf(&srcline, "%s:%u", file, line) < 0)
+		return NULL;
+
+	return srcline;
+}
+
 #ifdef HAVE_LIBBFD_SUPPORT
 
 /*
@@ -237,9 +260,12 @@ static int inline_list__append_dso_a2l(struct dso *dso,
 {
 	struct a2l_data *a2l = dso->a2l;
 	struct symbol *inline_sym = new_inline_sym(dso, sym, a2l->funcname);
+	char *srcline = NULL;
 
-	return inline_list__append(inline_sym, strdup(a2l->filename),
-				   a2l->line, node);
+	if (a2l->filename)
+		srcline = srcline_from_fileline(a2l->filename, a2l->line);
+
+	return inline_list__append(inline_sym, srcline, node);
 }
 
 static int addr2line(const char *dso_name, u64 addr,
@@ -437,13 +463,15 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 	node->addr = addr;
 
 	while (getline(&filename, &len, fp) != -1) {
+		char *srcline;
 
 		if (filename_split(filename, &line_nr) != 1) {
 			free(filename);
 			goto out;
 		}
 
-		if (inline_list__append(sym, filename, line_nr, node) != 0)
+		srcline = srcline_from_fileline(filename, line_nr);
+		if (inline_list__append(sym, srcline, node) != 0)
 			goto out;
 
 		filename = NULL;
@@ -487,16 +515,14 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 		       unwind_inlines, NULL, sym))
 		goto out;
 
-	if (asprintf(&srcline, "%s:%u",
-				srcline_full_filename ? file : basename(file),
-				line) < 0) {
-		free(file);
+	srcline = srcline_from_fileline(file, line);
+	free(file);
+
+	if (!srcline)
 		goto out;
-	}
 
 	dso->a2l_fails = 0;
 
-	free(file);
 	return srcline;
 
 out:
@@ -548,7 +574,7 @@ void inline_node__delete(struct inline_node *node)
 
 	list_for_each_entry_safe(ilist, tmp, &node->val, list) {
 		list_del_init(&ilist->list);
-		zfree(&ilist->filename);
+		free_srcline(ilist->srcline);
 		/* only the inlined symbols are owned by the list */
 		if (ilist->symbol && ilist->symbol->inlined)
 			symbol__delete(ilist->symbol);
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index 730bfd6926d7..0201ed2c0b9c 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -18,8 +18,7 @@ void free_srcline(char *srcline);
 
 struct inline_list {
 	struct symbol		*symbol;
-	char			*filename;
-	unsigned int		line_nr;
+	char			*srcline;
 	struct list_head	list;
 };
 
-- 
2.14.2
