Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2CA466B57
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581977; cv=none; b=MDzWr19VBXcz833/j6AbCMzavx0AFQb76xs99HF5rxX6lXl4OzP1qguGYza+WLaNrBU4mzVBRkTxlPdcCHErZN3j92lntLDtd3BWPSAoFr4OfsKb2WNRtqsKne0ZhQfWVisJRMbj7Sn7PpSHmV/e2qOnnzl16vae2QlrJLy+pkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581977; c=relaxed/simple;
	bh=AR3ygTj3/oA66GL8RpbkRgGBSoFcsjA0H9i7WvnRh5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dxSbNXLYhZ40whKDnjz13zvkxaW1D4PVNu3DB0yS8EYXijYMK/ioLSYNd8c/wXfKuu6yHgvMN20ozV37HzYqmrAhuyCnfof7wM1/qrA2prFz1Sce9PkGddI4mEyYs5sbKvlWhzhNmOZ7iNZ+ipnlxHz3T2BNgPrZXnN6obRAkkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MvHpyTYk; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MvHpyTYk"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-142f4306744so7792798c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 00:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790581974; x=1791186774; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cZOOHaOo/O/QErGq2d8f9szBa4Qf0hihfWUj2MwpXIo=;
        b=MvHpyTYk5OCj2khlWkbz2AzTrVKKMVhVp+7vUdnsL7iOyXrMHfqLk9F+SulVxyQ9NT
         kvlTthUc2y/vpimmimhIYCQojga1o1r/zKoDQ7WZ/c72LZmah301rVNfHExaOl7BrGvU
         M6SCUZmBcKCTz7eQA+F6OIWkD/dQxCBWL3mKNLshsysaqESlY0HGfucIRZu+LPmIJ2rx
         YMS4cSP7uEDBNS7FZtlxfeCM8X8G6i2v2y0hCKigr0tmH0xRaYE0hy8uWh47ErWbiVxC
         LWf/LOPJ3JFQ+0CAkcKtrYKRUit87zEbjT/xWUGvcXGjT3Bg9MYYoGFguaeI0ItYLVyO
         93MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581974; x=1791186774;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cZOOHaOo/O/QErGq2d8f9szBa4Qf0hihfWUj2MwpXIo=;
        b=iMdDpegCpmVYwWc/TJV0huY9UkbFfHhY08uEzaMAzTvAYzNPSHV+NCJllCf9/SLc3/
         Y0xNuXzNeSaCVS7ao697MTFH0zLVfDY370cNvO66EdGdIoVV0Zzuxsbojmev8OLB5VVi
         D6QVMt9cGz7Zo7vL9dZCkPqSW0NhkZO1TmUXAThUEclX/xU1LSMc69r7S1xCFMosS8+q
         ytRQOv75Yy1h3DCn+nbLoEKQ9u9rhLI3A8hR4d8FUqeUv4uriX3R4jSQePFUcusWa1I8
         /WFYUWlB++OinSbCRQd/OzhC4dwDSyRkOGWjlEAG1QCIsikiiQJnVLDeF1BsD+UZUkO8
         lOpA==
X-Forwarded-Encrypted: i=1; AKwUvBxB+sWr2GEMRlMin/KFladgVJF1+4QwiOErMPz0fpdj5SvHBwZzi+OtPUZ+FP7hJQ/gq3oguMpW6S6cCsezVtuY@vger.kernel.org
X-Gm-Message-State: AFuF++n2/sJci6NEdB4SExw1B4ya52UOO7yTln9wny/vZkvsqUZnUSzI
	xprch/ZBqDTcroEru5NiCpxaG1VwO7y0OAiO4rrQ3Xn7pxTWPUYNbh99CDUqUs+nazKfa/7zFrB
	qKELjj/k4ww==
X-Received: from dlx9.prod.google.com ([2002:a05:7022:89:b0:144:d025:68b5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2210:b0:14a:8df8:56b9
 with SMTP id a92af1059eb24-14a8df85c4bmr260985c88.18.1790581973419; Mon, 28
 Sep 2026 00:52:53 -0700 (PDT)
Date: Mon, 28 Sep 2026 00:52:32 -0700
In-Reply-To: <20260928075237.3055101-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928075237.3055101-3-irogers@google.com>
Subject: [PATCH v1 2/7] perf symbol: Remove symbol_conf.priv_size and
 negative-offset allocations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alireza Haghdoost <haghdoost@uber.com>
Content-Type: text/plain; charset="UTF-8"

Previously struct symbol allocations could be preceded by
symbol_conf.priv_size bytes (used by annotation, the TUI map browser
index, and db-export symbol IDs). This coupled symbol allocation size to
global configuration, allocated unused space ahead of every symbol in
the system, and complicated symbol lifetime management.

Without adding extra seldom-used fields to struct symbol:
- Move struct annotation storage to an on-demand hashmap in
  util/annotate.c keyed by struct symbol pointer, guarded by
  annotations_lock and tracked via a new SYMBOL_FLAG_ANNOTATED flag in
  sym->flags so unannotated symbols pay zero lookup or teardown
  overhead. If allocation fails in symbol__annotation(), return a static
  empty_annotation fallback so callers that do not check for NULL remain
  safe while mutating callers check for &empty_annotation.
- Remove symbol__browser_index() in ui/browsers/map.c and compute the
  TUI map browser index on demand in map_browser__search() by walking
  the map browser's symbol entries when the user searches with '/'.
  Previously, '/' search in the TUI map browser was gated behind
  'verbose > 0' (-v) in builtin-c2c.c, builtin-report.c, builtin-top.c,
  and ui/browsers/map.c solely to avoid adding sizeof(u32) to
  symbol_conf.priv_size for every struct symbol in normal runs. With on-
  demand index computation there is no per-symbol memory overhead, so
  remove the verbose > 0 restriction and allow '/' search in the map
  browser unconditionally.
- Store exported symbol database IDs in an on-demand sym_db_ids hashmap
  in struct db_export instead of symbol__priv().
- Remove symbol_conf.priv_size and symbol__priv().

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c                      |  14 --
 tools/perf/builtin-report.c                   |  14 --
 tools/perf/tests/builtin-test.c               |   1 -
 tools/perf/ui/browsers/map.c                  |  35 +++--
 tools/perf/util/annotate.c                    | 128 +++++++++++++++++-
 tools/perf/util/annotate.h                    |   6 +-
 tools/perf/util/db-export.c                   |  49 ++++++-
 tools/perf/util/db-export.h                   |   6 +
 .../scripting-engines/trace-event-python.c    |  10 +-
 tools/perf/util/symbol.c                      |  34 ++---
 tools/perf/util/symbol.h                      |  16 ++-
 tools/perf/util/symbol_conf.h                 |   1 -
 12 files changed, 219 insertions(+), 95 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 4222ac784fab..ba2f6cb7b371 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -3404,20 +3404,6 @@ static int perf_c2c__report(int argc, const char **argv)
 
 		if (ret < 0)
 			goto out_mem2node;
-		/*
-		 * For searching by name on the "Browse map details".
-		 * providing it only in verbose mode not to bloat too
-		 * much struct symbol.
-		 */
-		if (verbose > 0) {
-			/*
-			 * XXX: Need to provide a less kludgy way to ask for
-			 * more space per symbol, the u32 is for the index on
-			 * the ui browser.
-			 * See symbol__browser_index.
-			 */
-			symbol_conf.priv_size += sizeof(u32);
-		}
 		annotation_config__init();
 	}
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 57225bc87731..b42bf23e5545 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1876,20 +1876,6 @@ int cmd_report(int argc, const char **argv)
 		ret = symbol__annotation_init();
 		if (ret < 0)
 			goto error;
-		/*
- 		 * For searching by name on the "Browse map details".
- 		 * providing it only in verbose mode not to bloat too
- 		 * much struct symbol.
- 		 */
-		if (verbose > 0) {
-			/*
-			 * XXX: Need to provide a less kludgy way to ask for
-			 * more space per symbol, the u32 is for the index on
-			 * the ui browser.
-			 * See symbol__browser_index.
-			 */
-			symbol_conf.priv_size += sizeof(u32);
-		}
 		annotation_config__init();
 	}
 
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d2f594921e25..66bfd0841f95 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -1827,7 +1827,6 @@ int cmd_test(int argc, const char **argv)
 	if (dont_fork)
 		sequential = true;
 
-	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.try_vmlinux_path = true;
 
 
diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index 1f69d7a798e9..38e123d45a1f 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -40,12 +40,6 @@ static void map_browser__write(struct ui_browser *browser, void *nd, int row)
 		ui_browser__write_nstring(browser, symbol__name(sym), width);
 }
 
-/* FIXME uber-kludgy, see comment on cmd_report... */
-static u32 *symbol__browser_index(struct symbol *browser)
-{
-	return ((void *)browser) - sizeof(struct rb_node) - sizeof(u32);
-}
-
 static int map_browser__search(struct map_browser *browser)
 {
 	char target[512];
@@ -63,10 +57,21 @@ static int map_browser__search(struct map_browser *browser)
 		sym = map__find_symbol_by_name(browser->map, target);
 
 	if (sym != NULL) {
-		u32 *idx = symbol__browser_index(sym);
-
-		browser->b.top = &sym->rb_node;
-		browser->b.index = browser->b.top_idx = *idx;
+		struct rb_node *nd;
+		u32 idx = 0;
+
+		/*
+		 * Walk the map browser's symbol entries to find the matching
+		 * symbol node and its display row index, then position the
+		 * browser cursor at that entry.
+		 */
+		for (nd = rb_first(browser->b.entries); nd; nd = rb_next(nd), ++idx) {
+			if (&sym->rb_node == nd) {
+				browser->b.top = nd;
+				browser->b.index = browser->b.top_idx = idx;
+				break;
+			}
+		}
 	} else
 		ui_helpline__fpush("%s not found!", target);
 
@@ -78,8 +83,7 @@ static int map_browser__run(struct map_browser *browser)
 	int key;
 
 	if (ui_browser__show(&browser->b, dso__long_name(map__dso(browser->map)),
-			     "Press ESC to exit, %s / to search",
-			     verbose > 0 ? "" : "restart with -v to use") < 0)
+			     "Press ESC to exit, / to search") < 0)
 		return -1;
 
 	while (1) {
@@ -87,8 +91,7 @@ static int map_browser__run(struct map_browser *browser)
 
 		switch (key) {
 		case '/':
-			if (verbose > 0)
-				map_browser__search(browser);
+			map_browser__search(browser);
 			/* fall thru */
 		default:
 			ui_browser__warn_unhandled_hotkey(&browser->b, key, 0, NULL);
@@ -125,10 +128,6 @@ int map__browse(struct map *map)
 
 		if (maxaddr < symbol__end(pos))
 			maxaddr = symbol__end(pos);
-		if (verbose > 0) {
-			u32 *idx = symbol__browser_index(pos);
-			*idx = mb.b.nr_entries;
-		}
 		++mb.b.nr_entries;
 	}
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a1090a4e2e9d..9bb7e0ee1b8e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -35,6 +35,7 @@
 #include "string2.h"
 #include "dwarf-regs.h"
 #include "util/event.h"
+#include "util/rwsem.h"
 #include "util/sharded_mutex.h"
 #include "arch/common.h"
 #include "namespaces.h"
@@ -156,9 +157,126 @@ annotated_source__hist_entry(struct annotated_source *src, const struct evsel *e
 	return entry;
 }
 
+/*
+ * Map from struct symbol pointer to struct annotation. Allocated on demand so
+ * unannotated symbols do not pay the memory cost of struct annotation.
+ * empty_annotation is returned as a fallback on allocation failure so callers
+ * that do not check for NULL do not dereference NULL, while mutating callers
+ * check for &empty_annotation and return an error.
+ */
+static struct rw_semaphore _annotations_lock;
+static struct hashmap *annotations GUARDED_BY(_annotations_lock);
+static struct annotation empty_annotation;
+
+static void annotations_lock_init(void)
+{
+	init_rwsem(&_annotations_lock);
+}
+
+static struct rw_semaphore *annotations_lock(void) LOCK_RETURNED(_annotations_lock)
+{
+	static pthread_once_t annotations_lock_once = PTHREAD_ONCE_INIT;
+
+	pthread_once(&annotations_lock_once, annotations_lock_init);
+	return &_annotations_lock;
+}
+
+static size_t sym_ptr_hash(long key, void *ctx __maybe_unused)
+{
+	return hash_bits((size_t)key, 16);
+}
+
+static bool sym_ptr_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
+
+struct annotation *symbol__annotation(struct symbol *sym)
+{
+	struct annotation *notes = NULL;
+	long val = 0;
+
+	if (!sym)
+		return NULL;
+
+	/* Fast path: look up existing annotation under read lock if flagged. */
+	if (symbol__annotated(sym)) {
+		down_read(annotations_lock());
+		if (annotations && hashmap__find(annotations, (long)sym, &val))
+			notes = (struct annotation *)val;
+		up_read(annotations_lock());
+		if (notes)
+			return notes;
+	}
+
+	down_write(annotations_lock());
+	if (!annotations) {
+		annotations = hashmap__new(sym_ptr_hash, sym_ptr_equal, NULL);
+		if (IS_ERR(annotations)) {
+			annotations = NULL;
+			up_write(annotations_lock());
+			return &empty_annotation;
+		}
+	} else if (hashmap__find(annotations, (long)sym, &val)) {
+		notes = (struct annotation *)val;
+		up_write(annotations_lock());
+		return notes;
+	}
+
+	notes = zalloc(sizeof(*notes));
+	if (!notes) {
+		up_write(annotations_lock());
+		return &empty_annotation;
+	}
+	annotation__init(notes);
+	if (hashmap__add(annotations, (long)sym, notes) < 0) {
+		free(notes);
+		if (hashmap__size(annotations) == 0) {
+			hashmap__free(annotations);
+			annotations = NULL;
+		}
+		up_write(annotations_lock());
+		return &empty_annotation;
+	}
+	symbol__set_annotated(sym, true);
+	up_write(annotations_lock());
+	return notes;
+}
+
+void symbol__annotation_delete(struct symbol *sym)
+{
+	struct annotation *notes = NULL;
+	long val = 0;
+
+	/* Unannotated symbols avoid taking annotations_lock on teardown. */
+	if (!sym || !symbol__annotated(sym))
+		return;
+
+	down_write(annotations_lock());
+	if (annotations && hashmap__delete(annotations, (long)sym, NULL, &val)) {
+		notes = (struct annotation *)val;
+		if (hashmap__size(annotations) == 0) {
+			hashmap__free(annotations);
+			annotations = NULL;
+		}
+	}
+	symbol__set_annotated(sym, false);
+	up_write(annotations_lock());
+
+	if (notes) {
+		annotation__exit(notes);
+		free(notes);
+	}
+}
+
 void symbol__annotate_zero_histograms(struct symbol *sym)
 {
-	struct annotation *notes = symbol__annotation(sym);
+	struct annotation *notes;
+
+	if (!symbol__annotated(sym))
+		return;
+
+	notes = symbol__annotation(sym);
 
 	annotation__lock(notes);
 	if (notes->src != NULL) {
@@ -298,7 +416,7 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
 
 struct annotated_branch *annotation__get_branch(struct annotation *notes)
 {
-	if (notes == NULL)
+	if (notes == NULL || notes == &empty_annotation)
 		return NULL;
 
 	if (notes->branch == NULL)
@@ -337,6 +455,9 @@ struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
+	if (!notes || notes == &empty_annotation)
+		return NULL;
+
 	if (notes->src == NULL) {
 		notes->src = annotated_source__new();
 		if (notes->src == NULL)
@@ -1142,6 +1263,9 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	if (parch)
 		*parch = arch;
 
+	if (!notes || notes == &empty_annotation)
+		return -ENOMEM;
+
 	if (notes->src && !list_empty(&notes->src->source))
 		return 0;
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 1b47c1156b9a..d87de0f11a60 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -449,10 +449,8 @@ static inline struct sym_hist *annotation__histogram(struct annotation *notes,
 struct sym_hist_entry *
 annotated_source__hist_entry(struct annotated_source *src, const struct evsel *evsel, u64 offset);
 
-static inline struct annotation *symbol__annotation(struct symbol *sym)
-{
-	return (void *)sym - symbol_conf.priv_size;
-}
+struct annotation *symbol__annotation(struct symbol *sym);
+void symbol__annotation_delete(struct symbol *sym);
 
 int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample);
 
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 732369fe0046..897cda3fadd2 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -17,8 +17,20 @@
 #include "event.h"
 #include "thread-stack.h"
 #include "callchain.h"
+#include <linux/err.h>
 #include "call-path.h"
 #include "db-export.h"
+#include "hashmap.h"
+
+static size_t sym_ptr_hash(long key, void *ctx __maybe_unused)
+{
+	return hash_bits((size_t)key, 16);
+}
+
+static bool sym_ptr_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
 
 int db_export__init(struct db_export *dbe)
 {
@@ -28,6 +40,8 @@ int db_export__init(struct db_export *dbe)
 
 void db_export__exit(struct db_export *dbe)
 {
+	hashmap__free(dbe->sym_db_ids);
+	dbe->sym_db_ids = NULL;
 	call_return_processor__free(dbe->crp);
 	dbe->crp = NULL;
 }
@@ -156,15 +170,40 @@ int db_export__dso(struct db_export *dbe, struct dso *dso,
 	return 0;
 }
 
+/*
+ * Return the database export ID assigned to @sym in @dbe->sym_db_ids, or 0
+ * if @sym has not been exported yet.
+ */
+u64 db_export__symbol_db_id(struct db_export *dbe, struct symbol *sym)
+{
+	long db_id = 0;
+
+	if (sym && dbe->sym_db_ids)
+		hashmap__find(dbe->sym_db_ids, (long)sym, &db_id);
+	return (u64)db_id;
+}
+
 int db_export__symbol(struct db_export *dbe, struct symbol *sym,
 		      struct dso *dso)
 {
-	u64 *sym_db_id = symbol__priv(sym);
+	long db_id;
 
-	if (*sym_db_id)
+	if (db_export__symbol_db_id(dbe, sym))
 		return 0;
 
-	*sym_db_id = ++dbe->symbol_last_db_id;
+	if (!dbe->sym_db_ids) {
+		dbe->sym_db_ids = hashmap__new(sym_ptr_hash, sym_ptr_equal, NULL);
+		if (IS_ERR(dbe->sym_db_ids)) {
+			int err = PTR_ERR(dbe->sym_db_ids);
+
+			dbe->sym_db_ids = NULL;
+			return err;
+		}
+	}
+
+	db_id = ++dbe->symbol_last_db_id;
+	if (hashmap__set(dbe->sym_db_ids, (long)sym, db_id, NULL, NULL))
+		return -ENOMEM;
 
 	if (dbe->export_symbol)
 		return dbe->export_symbol(dbe, sym, dso);
@@ -192,12 +231,10 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 		}
 
 		if (al->sym) {
-			u64 *db_id = symbol__priv(al->sym);
-
 			err = db_export__symbol(dbe, al->sym, dso);
 			if (err)
 				return err;
-			*sym_db_id = *db_id;
+			*sym_db_id = db_export__symbol_db_id(dbe, al->sym);
 			*offset = al->addr - symbol__start(al->sym);
 		}
 	}
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 1abbfd398e3a..b5c22095e914 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -63,6 +63,11 @@ struct db_export {
 				     u64 th_in_id, u64 comm_in_id, int flags);
 	struct call_return_processor *crp;
 	struct call_path_root *cpr;
+	/**
+	 * @sym_db_ids: Hashmap mapping struct symbol pointers to their
+	 * exported 64-bit database IDs.
+	 */
+	struct hashmap *sym_db_ids;
 	u64 evsel_last_db_id;
 	u64 machine_last_db_id;
 	u64 thread_last_db_id;
@@ -90,6 +95,7 @@ int db_export__comm_thread(struct db_export *dbe, struct comm *comm,
 			   struct thread *thread);
 int db_export__dso(struct db_export *dbe, struct dso *dso,
 		   struct machine *machine);
+u64 db_export__symbol_db_id(struct db_export *dbe, struct symbol *sym);
 int db_export__symbol(struct db_export *dbe, struct symbol *sym,
 		      struct dso *dso);
 int db_export__branch_type(struct db_export *dbe, u32 branch_type,
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 408b5645b33d..91885381d8b7 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1372,12 +1372,12 @@ static int python_export_symbol(struct db_export *dbe, struct symbol *sym,
 				struct dso *dso)
 {
 	struct tables *tables = container_of(dbe, struct tables, dbe);
-	u64 *sym_db_id = symbol__priv(sym);
+	u64 sym_db_id = db_export__symbol_db_id(dbe, sym);
 	PyObject *t;
 
 	t = tuple_new(6);
 
-	tuple_set_d64(t, 0, *sym_db_id);
+	tuple_set_d64(t, 0, sym_db_id);
 	tuple_set_d64(t, 1, dso__db_id(dso));
 	tuple_set_d64(t, 2, symbol__start(sym));
 	tuple_set_d64(t, 3, symbol__end(sym));
@@ -1487,7 +1487,7 @@ static int python_export_call_path(struct db_export *dbe, struct call_path *cp)
 	u64 parent_db_id, sym_db_id;
 
 	parent_db_id = cp->parent ? cp->parent->db_id : 0;
-	sym_db_id = cp->sym ? *(u64 *)symbol__priv(cp->sym) : 0;
+	sym_db_id = db_export__symbol_db_id(dbe, cp->sym);
 
 	t = tuple_new(4);
 
@@ -1993,10 +1993,6 @@ static void set_table_handlers(struct tables *tables)
 	}
 
 	tables->db_export_mode = true;
-	/*
-	 * Reserve per symbol space for symbol->db_id via symbol__priv()
-	 */
-	symbol_conf.priv_size = sizeof(u64);
 
 	SET_TABLE_HANDLER(evsel);
 	SET_TABLE_HANDLER(machine);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8e264d38b981..2ec650a7834d 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -319,19 +319,11 @@ void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms)
 struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name)
 {
 	size_t namelen = strlen(name) + 1;
-	struct symbol *sym = calloc(1, (symbol_conf.priv_size +
-					sizeof(*sym) + namelen));
+	struct symbol *sym = calloc(1, sizeof(*sym) + namelen);
+
 	if (sym == NULL)
 		return NULL;
 
-	if (symbol_conf.priv_size) {
-		if (symbol_conf.init_annotation) {
-			struct annotation *notes = (void *)sym;
-			annotation__init(notes);
-		}
-		sym = ((void *)sym) + symbol_conf.priv_size;
-	}
-
 	sym->start   = start;
 	sym->end     = len ? start + len : start;
 	atomic_init(&sym->flags, (type << SYMBOL_FLAG_TYPE_SHIFT) |
@@ -347,14 +339,9 @@ struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *
 
 void symbol__delete(struct symbol *sym)
 {
-	if (symbol_conf.priv_size) {
-		if (symbol_conf.init_annotation) {
-			struct annotation *notes = symbol__annotation(sym);
-
-			annotation__exit(notes);
-		}
-	}
-	free(((void *)sym) - symbol_conf.priv_size);
+	if (symbol__annotated(sym))
+		symbol__annotation_delete(sym);
+	free(sym);
 }
 
 void symbol__set_ignore(struct symbol *sym, bool ignore)
@@ -389,6 +376,14 @@ void symbol__set_ifunc_alias(struct symbol *sym, bool ifunc_alias)
 		atomic_fetch_and(&sym->flags, ~SYMBOL_FLAG_IFUNC_ALIAS);
 }
 
+void symbol__set_annotated(struct symbol *sym, bool annotated)
+{
+	if (annotated)
+		atomic_fetch_or(&sym->flags, SYMBOL_FLAG_ANNOTATED);
+	else
+		atomic_fetch_and(&sym->flags, ~SYMBOL_FLAG_ANNOTATED);
+}
+
 static void symbol__set_idle(struct symbol *sym, bool idle)
 {
 	uint16_t old_flags = atomic_load_explicit(&sym->flags, memory_order_relaxed);
@@ -2504,7 +2499,6 @@ int symbol__annotation_init(void)
 		return -1;
 	}
 
-	symbol_conf.priv_size += sizeof(struct annotation);
 	symbol_conf.init_annotation = true;
 	return 0;
 }
@@ -2547,8 +2541,6 @@ int symbol__init(struct perf_env *env)
 	if (symbol_conf.initialized)
 		return 0;
 
-	symbol_conf.priv_size = PERF_ALIGN(symbol_conf.priv_size, sizeof(u64));
-
 	symbol__elf_init();
 
 	if (symbol_conf.try_vmlinux_path && vmlinux_path__init(env) < 0)
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 4fb7f6fa8441..100a7da07834 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -88,9 +88,9 @@ enum symbol_idle_kind {
 #define SYMBOL_FLAG_INLINED         (1 << 11)
 #define SYMBOL_FLAG_ANNOTATE2       (1 << 12)
 #define SYMBOL_FLAG_IFUNC_ALIAS     (1 << 13)
+#define SYMBOL_FLAG_ANNOTATED       (1 << 14)
 /**
- * A symtab entry. When allocated this may be preceded by an annotation (see
- * symbol__annotation) and/or a browser_index (see symbol__browser_index).
+ * A symtab entry.
  */
 struct symbol {
 	struct rb_node	rb_node;
@@ -185,12 +185,19 @@ static inline bool symbol__ifunc_alias(const struct symbol *sym)
 		SYMBOL_FLAG_IFUNC_ALIAS) != 0;
 }
 
+static inline bool symbol__annotated(const struct symbol *sym)
+{
+	return (atomic_load_explicit(&sym->flags, memory_order_relaxed) &
+		SYMBOL_FLAG_ANNOTATED) != 0;
+}
+
 bool symbol__is_idle(struct symbol *sym, const struct dso *dso, struct perf_env *env);
 
 void symbol__set_ignore(struct symbol *sym, bool ignore);
 void symbol__set_annotate2(struct symbol *sym, bool annotate2);
 void symbol__set_inlined(struct symbol *sym, bool inlined);
 void symbol__set_ifunc_alias(struct symbol *sym, bool ifunc_alias);
+void symbol__set_annotated(struct symbol *sym, bool annotated);
 
 /* symbols__for_each_entry - iterate over symbols (rb_root)
  *
@@ -224,11 +231,6 @@ static inline int __symbol__join_symfs(char *bf, size_t size, const char *path)
 extern int vmlinux_path__nr_entries;
 extern char **vmlinux_path;
 
-static inline void *symbol__priv(struct symbol *sym)
-{
-	return ((void *)sym) - symbol_conf.priv_size;
-}
-
 struct ref_reloc_sym {
 	const char	*name;
 	u64		addr;
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 37d35f42dcc1..aaa7148c3ac1 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -42,7 +42,6 @@ struct symbol_conf {
 	/* Was hybrid_merge given on the command line rather than in a config file? */
 	bool		hybrid_merge_set;
 	bool		nanosecs;
-	unsigned short	priv_size;
 	bool		try_vmlinux_path,
 			init_annotation,
 			force,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

