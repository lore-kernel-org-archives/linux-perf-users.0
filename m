Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590306;
	b=D872yEfCU2lB2FSbDfrt0Rez7e0xlF9A9nc2BbEEF/Xk46XUWYRi39YUuiauE1fwlg+t
	 8nPgRJRi/56PDZMhFBbSD4uof7RTCTUXOdZ91iWRbM2bC7tH+0wKXeq7O+tPrFz3tVqiX
	 7NuqoYLticrfRcoG8TgaLKrYraYE4fiy7bLHiP95tq1ub3AsyakSFvH+tJcEqf6r0zLUL
	 rNzaT3l4EUZRU/pLu1IXuJgw+kD+3gda13yw+A6uewSC62D0GOjDVs6PT1ekuIpbVNY03
	 frGHso3z5y9WdhOxP5wrmVBjEd4XyhUbnUCjeMgfWCDFGbRMleKG5AhGfH1NDLFeoXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=v+dnFbGsxQIRtNKrK/7z/HSDJ9qEiWQxOv1n0s5R26k=;
	b=1Dwd/bFnm3gZj2k/mMT5C0kCkl31Nf72q53UhaITyWEZK9PUf4PfEWIMSfCrG62HRa2V
	 sCqzcesimcCz/vo3Pr4qwO6h3PA44mEc8IdNpYsJbqWxo8RBUsaJsWdrpVm0wtbNAgjCQ
	 W+f1PLRG4Gm/z7o8SxH1Cnws+BclDn5oto+Ii/MexB6jCHtT4HB0U7O2WbcWpeP01s34b
	 j2IbtTrExKORryFYjr+eVHY65FDHGF8r/PtQ44fJ+53vsvV2drJYbgquPLMPmFzwUEkZR
	 9nr4u0OJnbQvr2/0z2dF/Je0zDwLS4IEylvrRrVIJXywPrfaxBrzvfaytbVoCnKtPaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Al97Fw0z;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64189607C368
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64189607C368
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Al97Fw0z
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so1809914eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 09:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794590305; x=1795195105; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v+dnFbGsxQIRtNKrK/7z/HSDJ9qEiWQxOv1n0s5R26k=;
        b=Al97Fw0z3hn1V87GeL4C7mKQuKiT8a1WwZo/HNUbKlmZNh2gTh8MZ4VJdI3ucLN6Nk
         jW3Gp3tM+1XKABkv+7rD5aUeUbaWoCOzjBM5ZAE6aHP8FM8xnxIxVyzup+2UVrHgYmO9
         XZCP+P3Mmr/2d2fUL/oENA19V3QeX4Mavr7U3bUJlnPbyTAKMAjjFrgLi7Dn6BroftBv
         LJx4dafIWB3LD/1BzvsH0xM9Vp3LD0KvfJmRTOaiafTManXn/fGnXoH5HWqlipbDz76u
         v8J5GjzqAWn7huPRccgt25HEvomaTa6z9jtP+R6TxnKzta7iwdF7nXtyBBXw9M6AzevI
         yFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590305; x=1795195105;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v+dnFbGsxQIRtNKrK/7z/HSDJ9qEiWQxOv1n0s5R26k=;
        b=TDSE7nPVtPFR3fcwSLmMl8cNHPDCPFNZtN2oAFkQAjwrGCVq78M82dsNqXHcy1BezE
         GmiVb7LdU6B8Mnpe/XqNB56FnttGLLMYTXs8eBlBdtRmFe/1RGskd/Ilb5TgvcHBRAgw
         HW8ETd9ZqPnQZMEkztDMRF4QU91SOrxn7a6hh8YqqyKHYuIpW29/X4wstYdWTfpX75YF
         pPNr9OtRT1mFNssoUMWroXDokMsym6opLCroia3OjCiaqgk/cO8ix4Nk5d/prE99WQl7
         dNftouryU0g1ucPHppwMr3RonI70QjY3a/Tt8gZ4EqH6A0cBCOK42aF0Mi8pxY+c3KF4
         +8Rw==
X-Forwarded-Encrypted: i=1; AL+hErEiKP1YHeMrX5nrkq+7c2IjslSsTmonpv9lldQngSfCZdIujZtft7d4LVl6E/BAJ1l8Y/blB05pfYt4oDeJcmgT@vger.kernel.org
X-Gm-Message-State: APuU4Z9U53FafPlLqzb2yEl0SxGnIgOJXTzfw1lJH3YnFnXFB/Upk2Yl
	BKl9fbJp56f39DT+ADazW8Kfg1nIR9xrDBfmAMdna+YJPdQxja8n7aPLZHN16cSw2wsa47CiAqV
	UuhpT/jBG7g==
X-Received: from dycnm12.prod.google.com ([2002:a05:7300:d18c:b0:369:45ee:40a0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:83d9:10b0:36a:3453:a356
 with SMTP id 5a478bee46e88-379676faa73mr2683918eec.36.1794590304233; Fri, 13
 Nov 2026 09:18:24 -0800 (PST)
Date: Fri, 13 Nov 2026 09:17:22 -0800
In-Reply-To: <20261113171734.2188066-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110220803.2503416-1-irogers@google.com> <20261113171734.2188066-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113171734.2188066-12-irogers@google.com>
Subject: [PATCH v4 11/23] perf annotate: Move struct annotation to a hashmap
 and remove symbol_conf.priv_size
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Previously, enabling annotation added sizeof(struct annotation) to
symbol_conf.priv_size, bloating every loaded struct symbol in every DSO
even though only a small fraction of symbols are ever annotated.

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
 tools/perf/builtin-annotate.c   |   3 +
 tools/perf/tests/builtin-test.c |   1 -
 tools/perf/ui/browsers/hists.c  |  13 ++-
 tools/perf/util/annotate.c      | 136 +++++++++++++++++++++++++++++++-
 tools/perf/util/annotate.h      |   6 +-
 tools/perf/util/block-info.c    |   2 +-
 tools/perf/util/block-range.c   |   3 +-
 tools/perf/util/sort.c          |   5 +-
 tools/perf/util/symbol.c        |  36 ++++-----
 tools/perf/util/symbol.h        |  16 ++--
 tools/perf/util/symbol_conf.h   |   1 -
 11 files changed, 179 insertions(+), 43 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 331adbdbd635..d1bbee421ea6 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -441,6 +441,9 @@ static void hists__find_annotations(struct hists *hists,
 				goto find_next;
 		}
 
+		if (!symbol__annotated(he->ms.sym))
+			goto find_next;
+
 		notes = symbol__annotation(he->ms.sym);
 		if (notes->src == NULL) {
 find_next:
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 327483f96401..01c78ef20b97 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -2431,7 +2431,6 @@ int cmd_test(int argc, const char **argv)
 		test_timeout = 0;
 	}
 
-	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.try_vmlinux_path = true;
 
 
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 593e1fd5759d..a50e9b1dfe37 100644
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
 
 	if (asprintf(optstr, "Annotate %s", ms->sym->name) < 0)
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
index 529d27e2ef63..e907a83e1f27 100644
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
@@ -36,6 +39,7 @@
 #include "dwarf-regs.h"
 #include "util/event.h"
 #include "util/mutex.h"
+#include "util/rwsem.h"
 #include "util/sharded_mutex.h"
 #include "arch/common.h"
 #include "namespaces.h"
@@ -119,6 +123,7 @@ static __maybe_unused void annotated_source__delete(struct annotated_source *src
 	if (src == NULL)
 		return;
 
+	annotated_source__purge(src);
 	if (src->samples) {
 		hashmap__for_each_entry(src->samples, cur, bkt)
 			zfree(&cur->pvalue);
@@ -157,9 +162,130 @@ annotated_source__hist_entry(struct annotated_source *src, const struct evsel *e
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
+	return (size_t)key;
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
+		symbol__set_annotated(sym, true);
+		up_write(annotations_lock());
+		return notes;
+	}
+
+	notes = zalloc(sizeof(*notes));
+	if (!notes)
+		goto err_free_hashmap;
+
+	annotation__init(notes);
+	if (hashmap__add(annotations, (long)sym, notes) < 0) {
+		annotation__exit(notes);
+		free(notes);
+		goto err_free_hashmap;
+	}
+	symbol__set_annotated(sym, true);
+	up_write(annotations_lock());
+	return notes;
+
+err_free_hashmap:
+	if (hashmap__size(annotations) == 0) {
+		hashmap__free(annotations);
+		annotations = NULL;
+	}
+	up_write(annotations_lock());
+	return &empty_annotation;
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
@@ -296,7 +422,7 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
 
 struct annotated_branch *annotation__get_branch(struct annotation *notes)
 {
-	if (notes == NULL)
+	if (notes == NULL || notes == &empty_annotation)
 		return NULL;
 
 	if (notes->branch == NULL)
@@ -335,6 +461,9 @@ struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
+	if (!notes || notes == &empty_annotation)
+		return NULL;
+
 	if (notes->src == NULL) {
 		notes->src = annotated_source__new();
 		if (notes->src == NULL)
@@ -1140,6 +1269,9 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
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
 
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 1135e54f4c7f..572cfb569849 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -134,7 +134,7 @@ int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
 	static struct addr_location al;
 	u64 cycles = 0;
 
-	if (!he->ms.map || !he->ms.sym)
+	if (!he->ms.map || !he->ms.sym || !symbol__annotated(he->ms.sym))
 		return 0;
 
 	memset(&al, 0, sizeof(al));
diff --git a/tools/perf/util/block-range.c b/tools/perf/util/block-range.c
index 280d695c6c58..2f2c641b01c3 100644
--- a/tools/perf/util/block-range.c
+++ b/tools/perf/util/block-range.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "block-range.h"
 #include "annotate.h"
+#include "symbol.h"
 #include <assert.h>
 #include <stdlib.h>
 
@@ -323,7 +324,7 @@ double block_range__coverage(struct block_range *br)
 	}
 
 	sym = br->sym;
-	if (!sym)
+	if (!sym || !symbol__annotated(sym))
 		return -1;
 
 	branch = symbol__annotation(sym)->branch;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f4c50f191141..8b455081442a 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -793,14 +793,15 @@ static int hist_entry__sym_ipc_snprintf(struct hist_entry *he, char *bf,
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
index b61a574ce9a3..0deda26181e0 100644
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
@@ -347,14 +339,11 @@ struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *
 
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
+	if (!sym)
+		return;
+	if (symbol__annotated(sym))
+		symbol__annotation_delete(sym);
+	free(sym);
 }
 
 void symbol__set_ignore(struct symbol *sym, bool ignore)
@@ -389,6 +378,14 @@ void symbol__set_ifunc_alias(struct symbol *sym, bool ifunc_alias)
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
@@ -2479,7 +2476,6 @@ int symbol__annotation_init(void)
 		return -1;
 	}
 
-	symbol_conf.priv_size += sizeof(struct annotation);
 	symbol_conf.init_annotation = true;
 	return 0;
 }
@@ -2522,8 +2518,6 @@ int symbol__init(struct perf_env *env)
 	if (symbol_conf.initialized)
 		return 0;
 
-	symbol_conf.priv_size = PERF_ALIGN(symbol_conf.priv_size, sizeof(u64));
-
 	symbol__elf_init();
 
 	if (symbol_conf.try_vmlinux_path && vmlinux_path__init(env) < 0)
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 6347bd218ad5..a0ad62e452be 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -78,9 +78,9 @@ enum symbol_idle_kind {
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
@@ -135,12 +135,19 @@ static inline bool symbol__ifunc_alias(const struct symbol *sym)
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
@@ -174,11 +181,6 @@ static inline int __symbol__join_symfs(char *bf, size_t size, const char *path)
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
2.56.1.703.gf848ed807c-goog

