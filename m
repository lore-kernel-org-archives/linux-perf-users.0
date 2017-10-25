From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/15] perf callchain: Refactor inline_list to store srcline string directly
Date: Wed, 25 Oct 2017 13:00:02 -0300
Message-ID: <20171025160013.11136-5-acme@kernel.org>
References: <20171025160013.11136-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932267AbdJYQAl (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Oct 2017 12:00:41 -0400
In-Reply-To: <20171025160013.11136-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Yao Jin <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Milian Wolff <milian.wolff@kdab.com>

This is a preparation for the creation of real callchain entries for
inlined frames. The rest of the perf code uses the srcline string. As
such, using that also for the srcline API allows us to simplify some of
the upcoming code. Most notably, it will allow us to cache the srcline
for a given inline node and reuse it for different callchain entries.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yao Jin <yao.jin@linux.intel.com>
Link: http://lkml.kernel.org/r/20171009203310.17362-5-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/srcline.c | 54 +++++++++++++++++++++++++++++++++++------------
 tools/perf/util/srcline.h |  3 +--
 2 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index c0af61b355ed..f202fc7827df 100644
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
2.13.6
