Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810885;
	b=EF3aIJfmeB0CLFvX2k1bkqVIChLBIqEJ98AGkUvgfmLWt7zocKdG+J/vateeujvALznP
	 WuhAaE7ueABB98kB/Mo8alKbl4xcfIwiSrrkRjaWVShRGXU+YRMKGzUzsYPz1Ir+4oyGF
	 kFr7HY/UepVRNzH2rW5DqJZO+yvnqHPnyhF3nYAKIo+STnvPLhVwmeQgzOSFAfpQc7tDL
	 YmKT7yDewd9iBXJzovh51lAhrITowsm/iFGmLlSQRAZ66QS9H48Y4JJkxJHfPqH6pFwyx
	 Eeg3XWTEzgfDkua/h1ie00Ki5vO15hbJ+2e8O3FTxA5mqZF48qB/D/Lxg0ZGRKawZ1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=dwRxJui9ORL8tQwQkQZxWvl64U4BOW2X+A8toEkq/8w=;
	b=OL6GI+jYZDjfuiekE9Bd94COJjXJpoE9roiewLGKTWJBy7CtKgII3mFkl40nRh8D/90i
	 gVnAQ74z428qOfikvBvEQUdXD70+u4naDMX5uEsEhtpo1Yd8Q8C1JnB3FjjrcGiIVM1Qs
	 yL/Zb0ws24aJKgLwNMt2OCsbl82K3h3Ym4v4aRNfZZ0y7AYfv3NTsYXfhCEr/tGr6wyQv
	 +DGVHIBn/0ixi+CzpZtryRlZghzg20oAQgmmEnmKALUoENEoVGZiURdoiWYQW0Mx+XivF
	 1bVFjCOGpiIN9n+uCR2tGo8oGH234rGb27MGC1he/6T0akKxai3oRXHPgqnzqYfUFSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TCo9tqj6;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AC7606A335
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50AC7606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TCo9tqj6
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-370230d93efso1680827eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 22:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794810883; x=1795415683; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dwRxJui9ORL8tQwQkQZxWvl64U4BOW2X+A8toEkq/8w=;
        b=TCo9tqj66Ilci21R6ObXr/V9Ir9H3ZJ553rGxkmQOIeOShZum156KZRN2vH6ep+2OO
         80xyhM2qocXHUL5PfboTqAxU3EiUb2MqtjuoTAA222ypQ6icCZ1FDbV4WwqWbVYbja56
         Chq58BPkFdiI1AF+Ueb6jzzNf/IJx8JxVaprjySTjEIaZKzd0rEUA60sLPe3y0lzyEf1
         9LEgploGd0TuW9Y9btNdkCfnwnSkZlvDXwomx6zWIWQ2/x6r3rtJRNGAvtBZwgauRW52
         G1ExX5iOgXeSDtG6bjo12RNW+I8+SCKROMRnMAKZoAdjXC6KyysH9Wag9bC+Ij+BjJBj
         89Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794810883; x=1795415683;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dwRxJui9ORL8tQwQkQZxWvl64U4BOW2X+A8toEkq/8w=;
        b=O/Zu2S19N+8lIB0+hEu6xRo/WLhpktyrwKp6L77NXRZPoX85Sw6K46LbJ/fyNsIggm
         skZJ8k95iDyqYhnukCOmPfgLPwha7w3PkrW0gznfLzlKgW9ZSp+0i8nfJxrnZwrp/ov3
         y6MIMzwsj4+M4ghmCLpzTjk1CY4A7DrxvFkb2Bmoji+wGwa27nIovdctF3KXl/oJP/d0
         ckJCOGHIWUD1J2/Z+yvvlYaTyjQ+XA+m9JEg6iNNKRA5W34T69XdimlwBonAWiw/MtPY
         BcWrpY+yrXKMdHjsJ/WCUfAyQM28KCL4lAWgVPwz7BXyGe7FKFmXMKbNldO/jkI0PCHY
         GSPw==
X-Forwarded-Encrypted: i=1; AL+hErGLZImJVTPpfe1zZNN4toMtRM+0YdPNFt2P7DEYfbsPiNr/Q/kvqL6UC6EFDuY6daP7GnfI4r64jJ7Y1SI3PKaP@vger.kernel.org
X-Gm-Message-State: APuU4Z9u7zZ7tMulPhs8P/6/9qo4PKlbJXhNLCSYGrOlhuByy9dIcupz
	wxxuZLIPaPSKuwsedu2sJm9XqtOzH4qfS56+zIXr7JioZdv8krwkZWpXoUwih7vUI6C+82rc0mB
	uuRVkIOYOkA==
X-Received: from dycpv5.prod.google.com ([2002:a05:7300:de05:b0:36e:8352:e26a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:11b:b0:36d:2b50:4eb9
 with SMTP id 5a478bee46e88-37967316395mr11300357eec.25.1794810883008; Sun, 15
 Nov 2026 22:34:43 -0800 (PST)
Date: Sun, 15 Nov 2026 22:34:28 -0800
In-Reply-To: <20261116063435.2817923-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116063435.2817923-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116063435.2817923-3-irogers@google.com>
Subject: [PATCH v5 2/9] perf annotate: Move struct annotation to a hashmap and
 remove symbol_conf.priv_size
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously, enabling annotation added sizeof(struct annotation) to
symbol_conf.priv_size, bloating every loaded struct symbol in every DSO
even though only a small fraction of symbols are ever annotated.

Move struct annotation storage to an on-demand hashmap in
util/annotate.c keyed by struct symbol pointer, guarded by
annotations_lock, with an atomic nr_annotations count so unannotated
sessions skip lock and teardown overhead while symbol__annotated()
checks the hashmap under a read lock. Return NULL from
symbol__annotation() on allocation failure and check for NULL at
entry-point callers.

With annotation, TUI map browser indices, and db-export symbol IDs no
longer using negative-offset space ahead of struct symbol, remove
symbol_conf.priv_size and symbol__priv().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c     |   5 +-
 tools/perf/builtin-top.c          |  21 ++++-
 tools/perf/tests/builtin-test.c   |   1 -
 tools/perf/ui/browsers/annotate.c |  16 +++-
 tools/perf/ui/browsers/hists.c    |  23 ++++-
 tools/perf/ui/gtk/annotate.c      |   4 +
 tools/perf/util/annotate.c        | 152 +++++++++++++++++++++++++++++-
 tools/perf/util/annotate.h        |   7 +-
 tools/perf/util/block-info.c      |   2 +-
 tools/perf/util/block-range.c     |  11 ++-
 tools/perf/util/sort.c            |   9 +-
 tools/perf/util/symbol.c          |  27 ++----
 tools/perf/util/symbol.h          |   8 +-
 tools/perf/util/symbol_conf.h     |   1 -
 14 files changed, 235 insertions(+), 52 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 331adbdbd635..7cb7e03d9a21 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -441,8 +441,11 @@ static void hists__find_annotations(struct hists *hists,
 				goto find_next;
 		}
 
+		if (!symbol__annotated(he->ms.sym))
+			goto find_next;
+
 		notes = symbol__annotation(he->ms.sym);
-		if (notes->src == NULL) {
+		if (!notes || notes->src == NULL) {
 find_next:
 			if (key == K_LEFT || key == '<')
 				nd = rb_prev(nd);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a3442d2d6edf..a272e6649077 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -140,6 +140,12 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 	}
 
 	notes = symbol__annotation(sym);
+	if (!notes) {
+		pr_err("Not enough memory for annotating '%s' symbol!\n",
+		       sym->name);
+		sleep(1);
+		return err;
+	}
 	annotation__lock(notes);
 
 	if (!symbol__hists(sym, evlist__nr_entries(top->evlist))) {
@@ -213,13 +219,16 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 		return;
 
 	notes = symbol__annotation(sym);
+	if (!notes) {
+		err = -ENOMEM;
+	} else {
+		if (!annotation__trylock(notes))
+			return;
 
-	if (!annotation__trylock(notes))
-		return;
-
-	err = hist_entry__inc_addr_samples(he, sample, ip);
+		err = hist_entry__inc_addr_samples(he, sample, ip);
 
-	annotation__unlock(notes);
+		annotation__unlock(notes);
+	}
 
 	if (unlikely(err)) {
 		/*
@@ -255,6 +264,8 @@ static void perf_top__show_details(struct perf_top *top)
 
 	symbol = he->ms.sym;
 	notes = symbol__annotation(symbol);
+	if (!notes)
+		return;
 
 	annotation__lock(notes);
 
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 327483f96401..01c78ef20b97 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -2431,7 +2431,6 @@ int cmd_test(int argc, const char **argv)
 		test_timeout = 0;
 	}
 
-	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.try_vmlinux_path = true;
 
 
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index cf36b5347f72..f2a46eabe5a1 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -597,6 +597,11 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	}
 
 	notes = symbol__annotation(dl->ops.target.sym);
+	if (!notes) {
+		ui__warning("Not enough memory for annotating '%s' symbol!\n",
+			    dl->ops.target.sym->name);
+		return true;
+	}
 	annotation__lock(notes);
 
 	if (!symbol__hists(dl->ops.target.sym, evlist__nr_entries(evsel->evlist))) {
@@ -1174,7 +1179,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 			       struct hist_browser_timer *hbt, u64 al_addr)
 {
 	struct symbol *sym = ms->sym;
-	struct annotation *notes = symbol__annotation(sym);
+	struct annotation *notes;
 	struct annotate_browser browser = {
 		.b = {
 			.refresh = annotate_browser__refresh,
@@ -1190,7 +1195,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 	};
 	struct dso *dso;
 	int ret = -1, err;
-	int not_annotated = list_empty(&notes->src->source);
+	int not_annotated;
 
 	if (sym == NULL)
 		return -1;
@@ -1199,6 +1204,13 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 	if (dso__annotate_warned(dso))
 		return -1;
 
+	notes = symbol__annotation(sym);
+	if (!notes) {
+		annotate_browser__symbol_annotate_error(&browser, -ENOMEM);
+		return -1;
+	}
+	not_annotated = !notes->src || list_empty(&notes->src->source);
+
 	if (not_annotated || !symbol__is_annotate2(sym)) {
 		err = symbol__annotate2(ms, evsel, &browser.arch);
 		if (err) {
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 593e1fd5759d..6f9d9f7aec91 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -796,7 +796,10 @@ static void hist_browser__show_callchain_entry(struct hist_browser *browser,
 {
 	int color, width;
 	char folded_sign = callchain_list__folded(chain);
-	bool show_annotated = browser->show_dso && chain->ms.sym && symbol__annotation(chain->ms.sym)->src;
+	struct annotation *notes = (browser->show_dso && chain->ms.sym &&
+				    symbol__annotated(chain->ms.sym)) ?
+				   symbol__annotation(chain->ms.sym) : NULL;
+	bool show_annotated = notes && notes->src;
 
 	color = HE_COLORSET_NORMAL;
 	width = browser->b.width - (offset + 2);
@@ -2486,8 +2489,11 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 	    perf_env__lookup_objdump(browser->env, &annotate_opts.objdump_path))
 		return 0;
 
+	if (!symbol__annotated(act->ms.sym))
+		return 0;
+
 	notes = symbol__annotation(act->ms.sym);
-	if (!notes->src)
+	if (!notes || !notes->src)
 		return 0;
 
 	if (browser->block_evsel)
@@ -2537,6 +2543,7 @@ add_annotate_opt(struct popup_action *act, char **optstr,
 		 struct map_symbol *ms,
 		 u64 addr)
 {
+	struct annotation *notes;
 	struct dso *dso;
 
 	if (!ms->map || (dso = map__dso(ms->map)) == NULL || dso__annotate_warned(dso))
@@ -2545,7 +2552,11 @@ add_annotate_opt(struct popup_action *act, char **optstr,
 	if (!ms->sym)
 		ms->sym = symbol__new_unresolved(addr, ms->map);
 
-	if (ms->sym == NULL || symbol__annotation(ms->sym)->src == NULL)
+	if (ms->sym == NULL || !symbol__annotated(ms->sym))
+		return 0;
+
+	notes = symbol__annotation(ms->sym);
+	if (!notes || notes->src == NULL)
 		return 0;
 
 	if (asprintf(optstr, "Annotate %s", ms->sym->name) < 0)
@@ -3204,7 +3215,11 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 				do_annotate(browser, &hotkey_act);
 				map_symbol__exit(&hotkey_act.ms);
 			} else {
-				if (symbol__annotation(browser->selection->sym)->src == NULL) {
+				struct annotation *notes;
+
+				notes = symbol__annotated(browser->selection->sym) ?
+					symbol__annotation(browser->selection->sym) : NULL;
+				if (!notes || notes->src == NULL) {
 					ui_browser__warning(&browser->b, delay_secs * 2,
 						"No samples for the \"%s\" symbol.\n\n"
 						"Probably appeared just in a callchain",
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 094dfa045b77..13a175c1b6e7 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -44,6 +44,8 @@ static int perf_gtk__get_percent(char *buf, size_t size, struct symbol *sym,
 		return 0;
 
 	notes = symbol__annotation(sym);
+	if (!notes || !notes->src)
+		return 0;
 	symhist = annotation__histogram(notes, evsel);
 	entry = annotated_source__hist_entry(notes->src, evsel, dl->al.offset);
 	if (entry)
@@ -116,6 +118,8 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct map_symbol *ms,
 	char s[512];
 
 	notes = symbol__annotation(sym);
+	if (!notes || !notes->src)
+		return 0;
 
 	for (i = 0; i < MAX_ANN_COLS; i++) {
 		col_types[i] = G_TYPE_STRING;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 86a4beec6528..59d20bd2d861 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -8,6 +8,10 @@
 
 #include <errno.h>
 #include <inttypes.h>
+#include <pthread.h>
+#include <stdatomic.h>
+#include <stdbool.h>
+#include <stddef.h>
 #include <stdlib.h>
 #include "util.h" // hex_width()
 #include "ui/ui.h"
@@ -35,6 +39,7 @@
 #include "string2.h"
 #include "dwarf-regs.h"
 #include "util/event.h"
+#include "util/rwsem.h"
 #include "util/sharded_mutex.h"
 #include "arch/common.h"
 #include "namespaces.h"
@@ -118,6 +123,7 @@ static __maybe_unused void annotated_source__delete(struct annotated_source *src
 	if (src == NULL)
 		return;
 
+	annotated_source__purge(src);
 	if (src->samples) {
 		hashmap__for_each_entry(src->samples, cur, bkt)
 			zfree(&cur->pvalue);
@@ -156,9 +162,141 @@ annotated_source__hist_entry(struct annotated_source *src, const struct evsel *e
 	return entry;
 }
 
+/*
+ * Map from struct symbol pointer to struct annotation. Allocated on demand so
+ * unannotated symbols do not pay the memory cost of struct annotation.
+ */
+static struct rw_semaphore _annotations_lock;
+static struct hashmap *annotations GUARDED_BY(_annotations_lock);
+static atomic_size_t nr_annotations;
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
+bool symbol__annotated(const struct symbol *sym)
+{
+	bool found;
+
+	if (!sym || atomic_load_explicit(&nr_annotations, memory_order_acquire) == 0)
+		return false;
+
+	down_read(annotations_lock());
+	found = annotations && hashmap__find(annotations, (long)sym, NULL);
+	up_read(annotations_lock());
+	return found;
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
+	/* Fast path: look up existing annotation under read lock. */
+	if (atomic_load_explicit(&nr_annotations, memory_order_acquire) > 0) {
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
+			return NULL;
+		}
+	} else if (hashmap__find(annotations, (long)sym, &val)) {
+		notes = (struct annotation *)val;
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
+	atomic_fetch_add_explicit(&nr_annotations, 1, memory_order_release);
+	up_write(annotations_lock());
+	return notes;
+
+err_free_hashmap:
+	if (hashmap__size(annotations) == 0) {
+		hashmap__free(annotations);
+		annotations = NULL;
+	}
+	up_write(annotations_lock());
+	return NULL;
+}
+
+void symbol__annotation_delete(struct symbol *sym)
+{
+	struct annotation *notes = NULL;
+	long val = 0;
+
+	/* Unannotated symbols avoid taking annotations_lock for write on teardown. */
+	if (!symbol__annotated(sym))
+		return;
+
+	down_write(annotations_lock());
+	if (annotations && hashmap__delete(annotations, (long)sym, NULL, &val)) {
+		notes = (struct annotation *)val;
+		atomic_fetch_sub_explicit(&nr_annotations, 1, memory_order_release);
+		if (hashmap__size(annotations) == 0) {
+			hashmap__free(annotations);
+			annotations = NULL;
+		}
+	}
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
+	if (!notes)
+		return;
 
 	annotation__lock(notes);
 	if (notes->src != NULL) {
@@ -334,6 +472,9 @@ struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
+	if (!notes)
+		return NULL;
+
 	if (notes->src == NULL) {
 		notes->src = annotated_source__new();
 		if (notes->src == NULL)
@@ -1074,6 +1215,9 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
+	if (!notes || !notes->src)
+		return;
+
 	annotation__calc_percent(notes, evsel, symbol__size(sym));
 }
 
@@ -1139,6 +1283,9 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	if (parch)
 		*parch = arch;
 
+	if (!notes)
+		return -ENOMEM;
+
 	if (notes->src && !list_empty(&notes->src->source))
 		return 0;
 
@@ -2340,6 +2487,9 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	size_t size = symbol__size(sym);
 	int err;
 
+	if (!notes)
+		return -ENOMEM;
+
 	err = symbol__annotate(ms, evsel, parch);
 	if (err)
 		return err;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 1b47c1156b9a..bc2237609d6e 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -449,10 +449,9 @@ static inline struct sym_hist *annotation__histogram(struct annotation *notes,
 struct sym_hist_entry *
 annotated_source__hist_entry(struct annotated_source *src, const struct evsel *evsel, u64 offset);
 
-static inline struct annotation *symbol__annotation(struct symbol *sym)
-{
-	return (void *)sym - symbol_conf.priv_size;
-}
+bool symbol__annotated(const struct symbol *sym);
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
index 280d695c6c58..9c3d70ffcc29 100644
--- a/tools/perf/util/block-range.c
+++ b/tools/perf/util/block-range.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "block-range.h"
 #include "annotate.h"
+#include "symbol.h"
 #include <assert.h>
 #include <stdlib.h>
 
@@ -323,10 +324,16 @@ double block_range__coverage(struct block_range *br)
 	}
 
 	sym = br->sym;
-	if (!sym)
+	if (!sym || !symbol__annotated(sym))
 		return -1;
 
-	branch = symbol__annotation(sym)->branch;
+	branch = NULL;
+	{
+		struct annotation *notes = symbol__annotation(sym);
+
+		if (notes)
+			branch = notes->branch;
+	}
 	if (!branch)
 		return -1;
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f4c50f191141..57d7877782d1 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -793,14 +793,19 @@ static int hist_entry__sym_ipc_snprintf(struct hist_entry *he, char *bf,
 {
 
 	struct symbol *sym = he->ms.sym;
-	struct annotated_branch *branch;
+	struct annotated_branch *branch = NULL;
 	double ipc = 0.0, coverage = 0.0;
 	char tmp[64];
 
 	if (!sym)
 		return repsep_snprintf(bf, size, "%-*s", width, "-");
 
-	branch = symbol__annotation(sym)->branch;
+	if (symbol__annotated(sym)) {
+		struct annotation *notes = symbol__annotation(sym);
+
+		if (notes)
+			branch = notes->branch;
+	}
 
 	if (branch && branch->hit_cycles)
 		ipc = branch->hit_insn / ((double)branch->hit_cycles);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index dc70bbe8514f..a1ac1cd1d2e7 100644
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
@@ -347,14 +339,10 @@ struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *
 
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
+	symbol__annotation_delete(sym);
+	free(sym);
 }
 
 void symbol__set_ignore(struct symbol *sym, bool ignore)
@@ -2479,7 +2467,6 @@ int symbol__annotation_init(void)
 		return -1;
 	}
 
-	symbol_conf.priv_size += sizeof(struct annotation);
 	symbol_conf.init_annotation = true;
 	return 0;
 }
@@ -2522,8 +2509,6 @@ int symbol__init(struct perf_env *env)
 	if (symbol_conf.initialized)
 		return 0;
 
-	symbol_conf.priv_size = PERF_ALIGN(symbol_conf.priv_size, sizeof(u64));
-
 	symbol__elf_init();
 
 	if (symbol_conf.try_vmlinux_path && vmlinux_path__init(env) < 0)
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 6347bd218ad5..a6a2ab200f98 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -79,8 +79,7 @@ enum symbol_idle_kind {
 #define SYMBOL_FLAG_ANNOTATE2       (1 << 12)
 #define SYMBOL_FLAG_IFUNC_ALIAS     (1 << 13)
 /**
- * A symtab entry. When allocated this may be preceded by an annotation (see
- * symbol__annotation) and/or a browser_index (see symbol__browser_index).
+ * A symtab entry.
  */
 struct symbol {
 	struct rb_node	rb_node;
@@ -174,11 +173,6 @@ static inline int __symbol__join_symfs(char *bf, size_t size, const char *path)
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

