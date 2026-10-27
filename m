Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142936;
	b=hEZmN/NvYik1N0LqDMdk1NWiIrELXKkA0QmXuMYpcHTCXWYWtdrekpsYfAQpEEXvHmTZ
	 JZCAWa5WkhegzaYhzsv7jep5EtIFdcU1IxVFxIVroW065K4jdwF1b5nWLF9RjKW/n6QHO
	 2qRO0tcSOOkJasnY2R98ezDOOGLyCbB8k/YfA8oIFQL39aLAuz458b7kGXeOppQHwKg7f
	 zAWypk9VbAIcv7ASBve1Z3gZ8wZ6BdGkxIgQ445XoEumL7GI73+i+FQaezzhXGdsl41Os
	 arSvVDn5KZs+GSL4PPSbfQqgdjA3ZajSZod3hJpXeEoZSPvrxDftOYwSjxXhudUM2Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=bMNJ1bgeNx4P+2tQQU55kRRJUpbr72DzOPhHaFxRyeA=;
	b=KLPqQDeotOf0K+9XBs4PqBWlffDTm8DJ9JRAcqC9Z1qbBxmsr/0DNXArWBCBFl/VfW4w
	 31m8PNeGFeyOR+DKmXtogbVVPgyTcIDlqjmNEX9np2M6FBeTJIgY0HV23LmKm+h7P5VYQ
	 RVqy02nPR9pdKZp6/X/F8ptGHef+ka3l2wWQc/AQyPPt8K76nredM4rJPdrpfoEZ+Ocps
	 PNhlOQiSOUmwgxSHMm9L70SzcDKNXX08dKNMobzYe5s2KYp1c2fwAvsSjJodTw0VjHmhS
	 SuQzyjHWIl8BHlalUiq7K1uHIHopA1CdLqbt8y3a+q1M9VVHLxXesPgUFCybW3SLX5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q21otRbc;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CC4606A325
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 23:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75CC4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q21otRbc
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so761068eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 16:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793142934; x=1793747734; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bMNJ1bgeNx4P+2tQQU55kRRJUpbr72DzOPhHaFxRyeA=;
        b=Q21otRbcnbBnbX6lPWm0UQJTqGGEkQPvjL8TAkuc2i9MZu7AZLGvTFKd21ZpPqriCX
         wiKf8dxyznIb6buG6azpti1zfJBJRFirJcQ85BQMbMt5CtBjrOpXVG5q9ZDbQmGe/+C5
         nX4GHBHVaXDFImXNXKT4tjHpLQgGGy6Bac6lpu+OTLfXpYQXKDamVVJ2uCc6o9ECVs0i
         onWtF7oEBumBB3OlsaHQ3tC3IRBDmoIGzJJcKcs7WCCdhI+tAmzeChj7RymKU04iLd8O
         QVKP+macGirAepz2YSY7VY1qjxq0ioheGdCsFPt/6qPxh8tkFkQVJLosgl7ADLFVkix8
         0LxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142934; x=1793747734;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bMNJ1bgeNx4P+2tQQU55kRRJUpbr72DzOPhHaFxRyeA=;
        b=UMuHLXF/0AnJfJ5cJSrYpRxjSjygLQK1zBXGb8hHvfz9uMPuQYHt3HWBRRQWHodFEy
         vkpmVJtM2FODw4f1+YHOfYk/IFwhHwW8Mcq4/0dJ+pC7PNDOM6XhmSfgNwGAHaDYUO+q
         Aia4t1QK6lQy4vOh1lbSOxb8Ec87pfq8z7qJ6QZ5zdp08eKzP4xGTgnflF/0020TkHO9
         EhXBkmDyWF8M5hTArt7TtXnxsAnXUKaXjX4X+HKPfiOnaFdC9jW7zZfLqTg1e903x0II
         ic3ugk3ZYTctXevN/cm/liUnAsE8vREYXFU18QMyTDj6wnCRO2J6foX02kVsy/t9MPt5
         LrIQ==
X-Forwarded-Encrypted: i=1; AKwUvBx6zITuFbiAkBCfJOKBRqLBJx2BcFV8wEv1vpKw7/UTieRsPLnujFokGSRBvMKxDpxtGZj3UJ8EX3t1ZfnjIk9q@vger.kernel.org
X-Gm-Message-State: AFq9FYLnavtCRdTECzlDjBxDxx6R5nU25miJ0RBiO6KLKGOZGgP9uxg8
	F8Ve/l9+T4CK83RQMlM8SEKHxy396481ODS4edQdRb69aFQrRAQIYJ1mu1IgatVU1i/6jjgQtE/
	bh9Oa/E7VjQ==
X-Received: from dldyr26-n2.prod.google.com ([2002:a05:701b:451a:20b0:195:cde8:ab41])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1702:b0:151:70a0:6bfd
 with SMTP id a92af1059eb24-1a6cd0c1a2emr770600c88.24.1793142933216; Tue, 27
 Oct 2026 16:15:33 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:15:00 -0700
In-Reply-To: <20261027231513.816148-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <20261027231513.816148-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027231513.816148-7-irogers@google.com>
Subject: [PATCH v2 06/18] perf annotate: Move struct annotation to a hashmap
 and remove symbol_conf.priv_size
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, haghdoost@uber.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Previously, enabling annotation added sizeof(struct annotation) to
symbol_conf.priv_size, bloating every loaded struct symbol in every DSO
even though only a small fraction of symbols are ever annotated. In
addition, allocating private data at a negative offset ahead of struct
symbol via symbol__priv() prevents wrapping struct symbol with
DECLARE_RC_STRUCT(symbol) for reference-count checking.

Move struct annotation storage to an on-demand hashmap in
util/annotate.c keyed by struct symbol pointer, guarded by
annotations_lock and tracked via a new SYMBOL_FLAG_ANNOTATED flag in
sym->flags so unannotated symbols pay zero lookup or teardown overhead.
If allocation fails in symbol__annotation(), return a static
empty_annotation fallback so callers that do not check for NULL remain
safe while mutating callers check for &empty_annotation.

With annotation, TUI map browser indices, and db-export symbol IDs no
longer using negative-offset space ahead of struct symbol, remove
symbol_conf.priv_size and symbol__priv().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c |   1 -
 tools/perf/ui/browsers/hists.c  |  13 +++-
 tools/perf/util/annotate.c      | 132 +++++++++++++++++++++++++++++++-
 tools/perf/util/annotate.h      |   6 +-
 tools/perf/util/sort.c          |   5 +-
 tools/perf/util/symbol.c        |  34 ++++----
 tools/perf/util/symbol.h        |  16 ++--
 tools/perf/util/symbol_conf.h   |   1 -
 8 files changed, 167 insertions(+), 41 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 0b8897fd42ca..9e52a194f919 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -2050,7 +2050,6 @@ int cmd_test(int argc, const char **argv)
 	if (dont_fork)
 		sequential = true;
 
-	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.try_vmlinux_path = true;
 
 
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 206657039223..1f1a877f667e 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -796,7 +796,9 @@ static void hist_browser__show_callchain_entry(struct hist_browser *browser,
 {
 	int color, width;
 	char folded_sign = callchain_list__folded(chain);
-	bool show_annotated = browser->show_dso && chain->ms.sym && symbol__annotation(chain->ms.sym)->src;
+	bool show_annotated = browser->show_dso && chain->ms.sym &&
+			      symbol__annotated(chain->ms.sym) &&
+			      symbol__annotation(chain->ms.sym)->src;
 
 	color = HE_COLORSET_NORMAL;
 	width = browser->b.width - (offset + 2);
@@ -2486,6 +2488,9 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 	    perf_env__lookup_objdump(browser->env, &annotate_opts.objdump_path))
 		return 0;
 
+	if (!symbol__annotated(act->ms.sym))
+		return 0;
+
 	notes = symbol__annotation(act->ms.sym);
 	if (!notes->src)
 		return 0;
@@ -2545,7 +2550,8 @@ add_annotate_opt(struct popup_action *act, char **optstr,
 	if (!ms->sym)
 		ms->sym = symbol__new_unresolved(addr, ms->map);
 
-	if (ms->sym == NULL || symbol__annotation(ms->sym)->src == NULL)
+	if (ms->sym == NULL || !symbol__annotated(ms->sym) ||
+	    symbol__annotation(ms->sym)->src == NULL)
 		return 0;
 
 	if (asprintf(optstr, "Annotate %s", symbol__name(ms->sym)) < 0)
@@ -3204,7 +3210,8 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 				do_annotate(browser, &hotkey_act);
 				map_symbol__exit(&hotkey_act.ms);
 			} else {
-				if (symbol__annotation(browser->selection->sym)->src == NULL) {
+				if (!symbol__annotated(browser->selection->sym) ||
+				    symbol__annotation(browser->selection->sym)->src == NULL) {
 					ui_browser__warning(&browser->b, delay_secs * 2,
 						"No samples for the \"%s\" symbol.\n\n"
 						"Probably appeared just in a callchain",
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4163689b6b2c..e4332800fda4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -8,6 +8,9 @@
 
 #include <errno.h>
 #include <inttypes.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <stddef.h>
 #include <stdlib.h>
 #include "util.h" // hex_width()
 #include "ui/ui.h"
@@ -35,6 +38,7 @@
 #include "string2.h"
 #include "dwarf-regs.h"
 #include "util/event.h"
+#include "util/rwsem.h"
 #include "util/sharded_mutex.h"
 #include "arch/common.h"
 #include "namespaces.h"
@@ -118,6 +122,7 @@ static __maybe_unused void annotated_source__delete(struct annotated_source *src
 	if (src == NULL)
 		return;
 
+	annotated_source__purge(src);
 	if (src->samples) {
 		hashmap__for_each_entry(src->samples, cur, bkt)
 			zfree(&cur->pvalue);
@@ -156,9 +161,126 @@ annotated_source__hist_entry(struct annotated_source *src, const struct evsel *e
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
@@ -298,7 +420,7 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
 
 struct annotated_branch *annotation__get_branch(struct annotation *notes)
 {
-	if (notes == NULL)
+	if (notes == NULL || notes == &empty_annotation)
 		return NULL;
 
 	if (notes->branch == NULL)
@@ -337,6 +459,9 @@ struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
+	if (!notes || notes == &empty_annotation)
+		return NULL;
+
 	if (notes->src == NULL) {
 		notes->src = annotated_source__new();
 		if (notes->src == NULL)
@@ -1142,6 +1267,9 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
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
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 62cf3d40e4b6..c4eca7a98642 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -795,14 +795,15 @@ static int hist_entry__sym_ipc_snprintf(struct hist_entry *he, char *bf,
 {
 
 	struct symbol *sym = he->ms.sym;
-	struct annotated_branch *branch;
+	struct annotated_branch *branch = NULL;
 	double ipc = 0.0, coverage = 0.0;
 	char tmp[64];
 
 	if (!sym)
 		return repsep_snprintf(bf, size, "%-*s", width, "-");
 
-	branch = symbol__annotation(sym)->branch;
+	if (symbol__annotated(sym))
+		branch = symbol__annotation(sym)->branch;
 
 	if (branch && branch->hit_cycles)
 		ipc = branch->hit_insn / ((double)branch->hit_cycles);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 991167b2dfa4..5b50cca7989d 100644
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
@@ -2482,7 +2477,6 @@ int symbol__annotation_init(void)
 		return -1;
 	}
 
-	symbol_conf.priv_size += sizeof(struct annotation);
 	symbol_conf.init_annotation = true;
 	return 0;
 }
@@ -2525,8 +2519,6 @@ int symbol__init(struct perf_env *env)
 	if (symbol_conf.initialized)
 		return 0;
 
-	symbol_conf.priv_size = PERF_ALIGN(symbol_conf.priv_size, sizeof(u64));
-
 	symbol__elf_init();
 
 	if (symbol_conf.try_vmlinux_path && vmlinux_path__init(env) < 0)
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 780ea3030a6f..37e6ab1478b5 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -80,9 +80,9 @@ enum symbol_idle_kind {
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
@@ -178,12 +178,19 @@ static inline bool symbol__ifunc_alias(const struct symbol *sym)
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
@@ -217,11 +224,6 @@ static inline int __symbol__join_symfs(char *bf, size_t size, const char *path)
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
2.56.0.313.g2479322e68-goog

