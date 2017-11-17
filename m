From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/83] perf annotate: Add symbol__annotate function
Date: Fri, 17 Nov 2017 17:14:44 -0300
Message-ID: <20171117201601.24110-7-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934534AbdKQUQi (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:16:38 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Add symbol__annotate function to have generic annotation function to be
called for all annotation sources.

It calls the generic annotation init and then the specific annotation
data retrieval function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c          |  2 +-
 tools/perf/ui/browsers/annotate.c |  6 ++--
 tools/perf/ui/gtk/annotate.c      |  4 +--
 tools/perf/util/annotate.c        | 58 ++++++++++++++++++++++-----------------
 tools/perf/util/annotate.h        |  6 ++--
 5 files changed, 42 insertions(+), 34 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 477a8699f0b5..adfeeb488f1a 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -134,7 +134,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		return err;
 	}
 
-	err = symbol__disassemble(sym, map, NULL, 0, NULL, NULL);
+	err = symbol__annotate(sym, map, NULL, 0, NULL, NULL);
 	if (err == 0) {
 out_assign:
 		top->sym_filter_entry = he;
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index d1aff2f7cb6c..d77994c1cba9 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -1120,9 +1120,9 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 		  (nr_pcnt - 1);
 	}
 
-	err = symbol__disassemble(sym, map, perf_evsel__env_arch(evsel),
-				  sizeof_bdl, &browser.arch,
-				  perf_evsel__env_cpuid(evsel));
+	err = symbol__annotate(sym, map, perf_evsel__env_arch(evsel),
+			       sizeof_bdl, &browser.arch,
+			       perf_evsel__env_cpuid(evsel));
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 162f15712d2d..b498f1a92bb1 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -169,8 +169,8 @@ static int symbol__gtk_annotate(struct symbol *sym, struct map *map,
 	if (map->dso->annotate_warned)
 		return -1;
 
-	err = symbol__disassemble(sym, map, perf_evsel__env_arch(evsel),
-				  0, NULL, NULL);
+	err = symbol__annotate(sym, map, perf_evsel__env_arch(evsel),
+			       0, NULL, NULL);
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e8b69001229d..f0093918882d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1425,13 +1425,11 @@ static const char *annotate__norm_arch(const char *arch_name)
 	return normalize_arch((char *)arch_name);
 }
 
-int symbol__disassemble(struct symbol *sym, struct map *map,
-			const char *arch_name, size_t privsize,
-			struct arch **parch, char *cpuid)
+static int symbol__disassemble(struct symbol *sym, struct map *map,
+			       size_t privsize, struct arch *arch)
 {
 	struct dso *dso = map->dso;
 	char command[PATH_MAX * 2];
-	struct arch *arch = NULL;
 	FILE *file;
 	char symfs_filename[PATH_MAX];
 	struct kcore_extract kce;
@@ -1445,25 +1443,6 @@ int symbol__disassemble(struct symbol *sym, struct map *map,
 	if (err)
 		return err;
 
-	arch_name = annotate__norm_arch(arch_name);
-	if (!arch_name)
-		return -1;
-
-	arch = arch__find(arch_name);
-	if (arch == NULL)
-		return -ENOTSUP;
-
-	if (parch)
-		*parch = arch;
-
-	if (arch->init) {
-		err = arch->init(arch, cpuid);
-		if (err) {
-			pr_err("%s: failed to initialize %s arch priv area\n", __func__, arch->name);
-			return err;
-		}
-	}
-
 	pr_debug("%s: filename=%s, sym=%s, start=%#" PRIx64 ", end=%#" PRIx64 "\n", __func__,
 		 symfs_filename, sym->name, map->unmap_ip(map, sym->start),
 		 map->unmap_ip(map, sym->end));
@@ -1581,6 +1560,35 @@ int symbol__disassemble(struct symbol *sym, struct map *map,
 	goto out_remove_tmp;
 }
 
+int symbol__annotate(struct symbol *sym, struct map *map,
+		     const char *arch_name, size_t privsize,
+		     struct arch **parch, char *cpuid)
+{
+	struct arch *arch;
+	int err;
+
+	arch_name = annotate__norm_arch(arch_name);
+	if (!arch_name)
+		return -1;
+
+	arch = arch__find(arch_name);
+	if (arch == NULL)
+		return -ENOTSUP;
+
+	if (parch)
+		*parch = arch;
+
+	if (arch->init) {
+		err = arch->init(arch, cpuid);
+		if (err) {
+			pr_err("%s: failed to initialize %s arch priv area\n", __func__, arch->name);
+			return err;
+		}
+	}
+
+	return symbol__disassemble(sym, map, privsize, arch);
+}
+
 static void insert_source_line(struct rb_root *root, struct source_line *src_line)
 {
 	struct source_line *iter;
@@ -1954,8 +1962,8 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 	struct rb_root source_line = RB_ROOT;
 	u64 len;
 
-	if (symbol__disassemble(sym, map, perf_evsel__env_arch(evsel),
-				0, NULL, NULL) < 0)
+	if (symbol__annotate(sym, map, perf_evsel__env_arch(evsel),
+			     0, NULL, NULL) < 0)
 		return -1;
 
 	len = symbol__size(sym);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index a822c0a4987e..e577f9d13a58 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -173,9 +173,9 @@ int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *samp
 int symbol__alloc_hist(struct symbol *sym);
 void symbol__annotate_zero_histograms(struct symbol *sym);
 
-int symbol__disassemble(struct symbol *sym, struct map *map,
-			const char *arch_name, size_t privsize,
-			struct arch **parch, char *cpuid);
+int symbol__annotate(struct symbol *sym, struct map *map,
+		     const char *arch_name, size_t privsize,
+		     struct arch **parch, char *cpuid);
 
 enum symbol_disassemble_errno {
 	SYMBOL_ANNOTATE_ERRNO__SUCCESS		= 0,
-- 
2.13.6
