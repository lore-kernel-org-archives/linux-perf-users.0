Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795323879;
	b=1hMdg1ov83TvJECFO4Taor1R1ZPYujt5ilCEcq++Z0IZB+6/VDerOD+4+fA+mcTEqcQo
	 yJIrnoAsD2lX2TocYiXGKoC4jNmGd15ho/ifEZeke1H3C11DRKwQqp8ak9Vv7GVp8bcEZ
	 EGk3J3gwPxF2rIAsJ2PCgzaYOi3p8667T6nXnp03WH/rNTqV4lW6JjZOYIDxk7OdJEJVd
	 OpcWgunRgqZm2C8Ixs5qaASZzDaKiX2VwmMns7bx2M2G3tqrfiHwRdrAkrwrDDmvR4q8R
	 MfjYxPIt466ZV01EGRTAGlwVgmkVm6p1vFkwmbS/xLPD7IV4DgDoEKbJJgDqIAaKA9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795323879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=eioM0PC7l/LAaBEflaadXqSxpvWv6IaP6K49lqa7SY8=;
	b=Iw36Zt44d93Rz3kKfDoAbl7DbQznYVogAyZo0OPEy/puGUDy1ncXtH2ony1zBM8T6pe1
	 Dl2ZmzZZzaacrfd1EvQfsbtg0wlo2I/kXJ0pK3PMylkfvDkT98XWDehcPDoFnCXTIjMkQ
	 aiYkAOU91M22bh0Z7xJ1BzximlZ2mLCTWQ031u/+NMK1Mbzj3BS4HqwbCa7Bq4b934/oY
	 /6Q33w6YM+v4JU4+pp1ZeAY9TCNZcJJmdyiwPKYfx6kTMzajYeBQQ+eQ/KRNAd237wfTT
	 faNiLCs1bFNZSoLupwW+lwWyM/o5KjQTHCqVFLZ7FER/hlJmUGS/2V5W/uoofduXivg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U8mXUuDh;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF24606A332
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 05:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DF24606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U8mXUuDh
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139b62317d0so6551614c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 21:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795323878; x=1795928678; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eioM0PC7l/LAaBEflaadXqSxpvWv6IaP6K49lqa7SY8=;
        b=U8mXUuDh5tih+/icUpKNHjWrETxW/pLbiz4Fa7g50tBW9sBaiRYc8zJY6B7mzarsvH
         yhWQ+AZ5Uo56nFYrwdPIPYCseoeL7+ELrS8K7H7wof/nNzjYXdRiMoQZ0eN83YeDkZNx
         U6ue7m9AW+ylVruoh+KmnFB6lBSVyqfCa4Gr8jzT6HZG7rZMckTUG0FGqrQmprghax+m
         jesC2f4crZt4+ETujx2+OXyna10xZ8nSS+QXRd1H/eM2TMfRGMIYKJ6OSlNDW4xwfvbP
         P1MrDOLQahUVGn0MIH1TbZnanqpV8D8RuHpA8EG0vM7wx8tOANE73354/Ct6dp0Ko4e3
         fM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795323878; x=1795928678;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eioM0PC7l/LAaBEflaadXqSxpvWv6IaP6K49lqa7SY8=;
        b=f2cgUIQDi3e8FLRsiwIibDSSm7SxxV9lbEMIOGzb/NUdti0X+duVIXM4+L7cBHxnnm
         USSXekLcFjriPpG806h9ttBBL26UNWC5MY4mYYjbq3qqk7paMJhwwkhv8k5OCoXP2gzC
         71Mn5iisXIrsw2sp+sngT3BjKT09Wow4IkrxKeHklFwpIFx9wcq8vPaBYfcEcweT5dv8
         zshYa+896U1tnWf+TcZ6ubjDJOw/OdgW2kHZQQ9gIG3eSNYe7yy7/g6lK3XAZzLcXhDi
         BQXbgqXMkmsxQA2KEzanqkJXV39XIXrGNpbnPHA2OwgITUAlSAE+ondAxBFP9tuGStnV
         DOAA==
X-Forwarded-Encrypted: i=1; AL+hErFHSmvHcSIaKDdyxt7PUvzqgv7bI/F/ty42LV2K7p9QdnVhtQToG2wXNS2Il/GbjMlRqw3l8bVhTTHJ8cd9cETo@vger.kernel.org
X-Gm-Message-State: APuU4Z8As3OmxKw2KDGdMgTTFMRcSnxruNhtUAt81ukEHyIPQbLT9ID9
	AfS86XkhheQDgDsOW9Wbgz42d4/o9knGLULK5QsKQ8YSvMO6x7Ynm74nzvJ0p6NJrgv8SS5YMKD
	/H5YObgbR/w==
X-Received: from dleb16-n2.prod.google.com ([2002:a05:701b:4250:20b0:1ac:2245:a27b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2706:b0:154:e9d2:d741
 with SMTP id a92af1059eb24-1b5568a12f4mr7639797c88.8.1795323877213; Sat, 21
 Nov 2026 21:04:37 -0800 (PST)
Date: Sat, 21 Nov 2026 21:04:00 -0800
In-Reply-To: <20261122050405.80335-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261122050405.80335-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261122050405.80335-6-irogers@google.com>
Subject: [PATCH v8 05/10] perf symbol: Switch backing storage from rbtree to
 struct symbols array
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously, DSO symbols were stored in an unprotected rb_root_cached
with a 24-byte struct rb_node embedded inside every struct symbol. That
design had three drawbacks:
1. Embedding struct rb_node (3 pointers, 24 bytes on 64-bit) accounted
   for nearly 40% of struct symbol's fixed header size and scattered
   symbol lookups across non-contiguous heap nodes.
2. Unlike struct dsos and struct maps, the symbol rbtree had no lock
   protecting concurrent lookups, sorting, and insertions.
3. Deduplicating symbols, splitting kallsyms, and trimming excess symbol
   container capacity under memory pressure benefit from operating on a
   compact array under a lock.

Replace struct rb_node in struct symbol with a locked, lazily-sorted
pointer array in struct symbols, matching the design of struct dsos and
struct maps:

- Introduce struct symbols containing a rw_semaphore lock, primary
  address-sorted symbols array, secondary name-sorted symbols_by_name
  array, counts, capacity, and sorted state flags.
- Lazily sort symbols by start address using qsort (symbols__sort_locked)
  and use binary search in symbols__find().
- Update symbols__fixup_duplicate(), symbols__fixup_end(),
  maps__split_kallsyms_for_kcore(), and maps__split_kallsyms() to
  operate on the sorted array and compact entries in place.
- Update symbols__visit() and symbols__visit_by_name() to iterate the
  sorted arrays under symbols->lock.
- Remove the unsynchronized single-entry dso->last_find_result cache and
  dso__reset_find_symbol_cache() since binary search over a contiguous
  array is cache-friendly.
- Remove the direct rb_erase_cached() workaround in builtin-annotate.c's
  add_sample().
- Update the TUI map browser (ui/browsers/map.c) to snapshot the sorted
  symbol array into an entries array and use ui_browser__argv_refresh
  and ui_browser__argv_seek instead of ui_browser__rb_tree_refresh.

Using 'perf bench internals symbols':

  Before (perf binary):
    Average DSO load + sort: 7.041 msec (+- 0.051 msec)
    Average DSO memory usage: 1401 KB (+- 4 KB)
    Average bulk insert + lookup: 1453.950 usec (+- 10.895 usec)
  After (perf binary, -13.5% load, -14.6% memory, -7.7% bulk):
    Average DSO load + sort: 6.089 msec (+- 0.039 msec)
    Average DSO memory usage: 1197 KB (+- 3 KB)
    Average bulk insert + lookup: 1341.500 usec (+- 21.564 usec)

  Before (libLLVM.so.21.1):
    Average DSO load + sort: 78.599 msec (+- 0.857 msec)
    Average DSO memory usage: 9530 KB (+- 5 KB)
  After (libLLVM.so.21.1, -22.3% load, -8.1% memory):
    Average DSO load + sort: 61.074 msec (+- 0.236 msec)
    Average DSO memory usage: 8755 KB (+- 1 KB)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c   |  11 -
 tools/perf/tests/hists_common.c |   5 +-
 tools/perf/ui/browser.c         |   3 +
 tools/perf/ui/browsers/hists.c  |   3 +-
 tools/perf/ui/browsers/map.c    |  62 ++-
 tools/perf/util/db-export.c     |   4 +-
 tools/perf/util/dso.c           |  20 +-
 tools/perf/util/dso.h           |  65 +---
 tools/perf/util/libbfd.c        |   3 +-
 tools/perf/util/machine.c       |   2 +-
 tools/perf/util/map.c           |  36 +-
 tools/perf/util/symbol-elf.c    |  12 +-
 tools/perf/util/symbol.c        | 656 ++++++++++++++++++++++----------
 tools/perf/util/symbol.h        |  61 ++-
 14 files changed, 604 insertions(+), 339 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 7cb7e03d9a21..65846110c309 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -258,17 +258,6 @@ static int add_sample(struct perf_sample *sample,
 	    (al->sym == NULL ||
 	     strcmp(ann->sym_hist_filter, al->sym->name) != 0)) {
 		/* We're only interested in a symbol named sym_hist_filter */
-		/*
-		 * FIXME: why isn't this done in the symbol_filter when loading
-		 * the DSO?
-		 */
-		if (al->sym != NULL) {
-			struct dso *dso = map__dso(al->map);
-
-			rb_erase_cached(&al->sym->rb_node, dso__symbols(dso));
-			symbol__delete(al->sym);
-			dso__reset_find_symbol_cache(dso);
-		}
 		return 0;
 	}
 
diff --git a/tools/perf/tests/hists_common.c b/tools/perf/tests/hists_common.c
index 187f12f5bc21..0d3acb03e02c 100644
--- a/tools/perf/tests/hists_common.c
+++ b/tools/perf/tests/hists_common.c
@@ -146,7 +146,10 @@ struct machine *setup_fake_machine(struct machines *machines)
 				goto out;
 			}
 
-			symbols__insert(dso__symbols(dso), sym);
+			if (symbols__insert(dso__symbols(dso), sym)) {
+				dso__put(dso);
+				goto out;
+			}
 		}
 
 		dso__put(dso);
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 321187b204d3..c7451f640d1d 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -622,6 +622,9 @@ static int ui_browser__color_config(const char *var, const char *value,
 
 void ui_browser__argv_seek(struct ui_browser *browser, off_t offset, int whence)
 {
+	if (browser->nr_entries == 0)
+		return;
+
 	switch (whence) {
 	case SEEK_SET:
 		browser->top = browser->entries;
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 6f9d9f7aec91..ad6882744eba 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2532,7 +2532,8 @@ static struct symbol *symbol__new_unresolved(u64 addr, struct map *map)
 			return NULL;
 		}
 
-		dso__insert_symbol(map__dso(map), sym);
+		if (dso__insert_symbol(map__dso(map), sym))
+			return NULL;
 	}
 
 	return sym;
diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index be7390156edd..51a71b20947f 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -24,7 +24,7 @@ struct map_browser {
 
 static void map_browser__write(struct ui_browser *browser, void *nd, int row)
 {
-	struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
+	struct symbol *sym = *(struct symbol **)nd;
 	struct map_browser *mb = container_of(browser, struct map_browser, b);
 	bool current_entry = ui_browser__is_current_entry(browser, row);
 	int width;
@@ -56,17 +56,16 @@ static int map_browser__search(struct map_browser *browser)
 		sym = map__find_symbol_by_name(browser->map, target);
 
 	if (sym != NULL) {
-		struct rb_node *nd;
-		u32 idx = 0;
+		struct symbol **entries = browser->b.entries;
 
 		/*
-		 * Walk the map browser's symbol entries to find the matching
-		 * symbol node and its display row index, then position the
-		 * browser cursor at that entry.
+		 * Scan the map browser's symbol entries to find the matching
+		 * symbol and its display row index, then position the browser
+		 * cursor at that entry.
 		 */
-		for (nd = rb_first(browser->b.entries); nd; nd = rb_next(nd), ++idx) {
-			if (&sym->rb_node == nd) {
-				browser->b.top = nd;
+		for (u32 idx = 0; idx < browser->b.nr_entries; ++idx) {
+			if (entries[idx] == sym) {
+				browser->b.top = &entries[idx];
 				browser->b.index = browser->b.top_idx = idx;
 				break;
 			}
@@ -109,27 +108,48 @@ static int map_browser__run(struct map_browser *browser)
 
 int map__browse(struct map *map)
 {
+	struct symbols *symbols = dso__symbols(map__dso(map));
 	struct map_browser mb = {
 		.b = {
-			.entries = dso__symbols(map__dso(map)),
-			.refresh = ui_browser__rb_tree_refresh,
-			.seek	 = ui_browser__rb_tree_seek,
+			.refresh = ui_browser__argv_refresh,
+			.seek	 = ui_browser__argv_seek,
 			.write	 = map_browser__write,
 		},
 		.map = map,
 	};
-	struct rb_node *nd;
+	struct symbol **entries = NULL;
+	unsigned int nr_entries = 0;
 	char tmp[BITS_PER_LONG / 4];
 	u64 maxaddr = 0;
-
-	for (nd = rb_first(mb.b.entries); nd; nd = rb_next(nd)) {
-		struct symbol *pos = rb_entry(nd, struct symbol, rb_node);
-
-		if (maxaddr < pos->end)
-			maxaddr = pos->end;
-		++mb.b.nr_entries;
+	int ret;
+
+	/*
+	 * Snapshot the DSO's sorted symbol array under symbols->lock for use
+	 * with ui_browser__argv_refresh and ui_browser__argv_seek.
+	 */
+	symbols__sort_read_lock(symbols);
+	nr_entries = symbols->cnt;
+	if (nr_entries > 0) {
+		entries = malloc(nr_entries * sizeof(*entries));
+		if (entries) {
+			for (unsigned int idx = 0; idx < nr_entries; idx++) {
+				struct symbol *pos = symbols->symbols[idx];
+
+				entries[idx] = pos;
+				if (maxaddr < pos->end)
+					maxaddr = pos->end;
+			}
+		} else {
+			nr_entries = 0;
+		}
 	}
+	up_read(&symbols->lock);
+
+	mb.b.entries = entries;
+	mb.b.nr_entries = nr_entries;
 
 	mb.addrlen = snprintf(tmp, sizeof(tmp), "%" PRIx64, maxaddr);
-	return map_browser__run(&mb);
+	ret = map_browser__run(&mb);
+	free(entries);
+	return ret;
 }
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index e7b807e968cf..b3790383237f 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -289,8 +289,8 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 
 		if (!al->sym) {
 			al->sym = symbol__new(al->addr, 0, 0, 0, "unknown");
-			if (al->sym)
-				dso__insert_symbol(dso, al->sym);
+			if (al->sym && dso__insert_symbol(dso, al->sym))
+				al->sym = NULL;
 		}
 
 		if (al->sym) {
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index e090a5bd12b6..d1668c986e8d 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1802,12 +1802,13 @@ bool dso__loaded(const struct dso *dso)
 
 bool dso__sorted_by_name(const struct dso *dso)
 {
-	return RC_CHK_ACCESS(dso)->sorted_by_name;
-}
+	struct symbols *symbols = (struct symbols *)&RC_CHK_ACCESS(dso)->symbols;
+	bool res;
 
-void dso__set_sorted_by_name(struct dso *dso)
-{
-	RC_CHK_ACCESS(dso)->sorted_by_name = true;
+	down_read(&symbols->lock);
+	res = symbols->sorted_by_name;
+	up_read(&symbols->lock);
+	return res;
 }
 
 struct dso *dso__new_id(const char *name, const struct dso_id *id)
@@ -1825,9 +1826,7 @@ struct dso *dso__new_id(const char *name, const struct dso_id *id)
 			dso->id = *id;
 		dso__set_long_name_id(res, dso->name, false);
 		dso__set_short_name(res, dso->name, false);
-		dso->symbols = RB_ROOT_CACHED;
-		dso->symbol_names = NULL;
-		dso->symbol_names_len = 0;
+		symbols__init(&dso->symbols);
 		dso->inlined_nodes = RB_ROOT_CACHED;
 		dso->srclines = RB_ROOT_CACHED;
 		dso->data_types = RB_ROOT;
@@ -1838,7 +1837,6 @@ struct dso *dso__new_id(const char *name, const struct dso_id *id)
 		dso->is_64_bit = (sizeof(void *) == 8);
 		dso->loaded = 0;
 		dso->rel = 0;
-		dso->sorted_by_name = 0;
 		dso->has_srcline = 1;
 		dso->a2l_fails = 1;
 		dso->kernel = DSO_SPACE__USER;
@@ -1869,9 +1867,7 @@ void dso__delete(struct dso *dso)
 	/* free inlines first, as they reference symbols */
 	inlines__tree_delete(&RC_CHK_ACCESS(dso)->inlined_nodes);
 	srcline__tree_delete(&RC_CHK_ACCESS(dso)->srclines);
-	symbols__delete(&RC_CHK_ACCESS(dso)->symbols);
-	RC_CHK_ACCESS(dso)->symbol_names_len = 0;
-	zfree(&RC_CHK_ACCESS(dso)->symbol_names);
+	symbols__exit(&RC_CHK_ACCESS(dso)->symbols);
 	annotated_data_type__tree_delete(dso__data_types(dso));
 	global_var_type__tree_delete(dso__global_vars(dso));
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index dddfcd3db0aa..63c1b7d6f6f8 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -13,6 +13,7 @@
 #include "build-id.h"
 #include "debuginfo.h"
 #include "mutex.h"
+#include "symbol.h"
 #include <internal/rc_check.h>
 
 struct machine;
@@ -284,18 +285,12 @@ struct auxtrace_cache;
 DECLARE_RC_STRUCT(dso) {
 	struct mutex	 lock;
 	struct dsos	 *dsos;
-	struct rb_root_cached symbols;
-	struct symbol	 **symbol_names;
-	size_t		 symbol_names_len;
+	struct symbols	 symbols;
 	struct rb_root_cached inlined_nodes;
 	struct rb_root_cached srclines;
 	struct rb_root	 data_types;
 	struct rb_root	 global_vars;
 
-	struct {
-		u64		addr;
-		struct symbol	*symbol;
-	} last_find_result;
 	u64		 text_offset;
 	u64		 text_end;
 	const char	 *short_name;
@@ -348,7 +343,6 @@ DECLARE_RC_STRUCT(dso) {
 	u8		 is_64_bit:1;
 	u8		 bintype_searched:1;
 	u8		 debuginfo_searched:1;
-	bool		 sorted_by_name;
 	bool		 loaded;
 	u8		 rel;
 	char		 name[];
@@ -369,7 +363,7 @@ int dso_id__cmp(const struct dso_id *a, const struct dso_id *b);
 	symbols__visit(dso__symbols(dso), cb, data)
 
 #define dso__for_each_symbol_by_name(dso, cb, data)	\
-	dso__visit_symbols_by_name(dso, cb, data)
+	symbols__visit_by_name(dso__symbols(dso), cb, data)
 
 static inline void *dso__a2l(const struct dso *dso)
 {
@@ -598,26 +592,6 @@ static inline void dso__set_kernel(struct dso *dso, enum dso_space_type kernel)
 	RC_CHK_ACCESS(dso)->kernel = kernel;
 }
 
-static inline u64 dso__last_find_result_addr(const struct dso *dso)
-{
-	return RC_CHK_ACCESS(dso)->last_find_result.addr;
-}
-
-static inline void dso__set_last_find_result_addr(struct dso *dso, u64 addr)
-{
-	RC_CHK_ACCESS(dso)->last_find_result.addr = addr;
-}
-
-static inline struct symbol *dso__last_find_result_symbol(const struct dso *dso)
-{
-	return RC_CHK_ACCESS(dso)->last_find_result.symbol;
-}
-
-static inline void dso__set_last_find_result_symbol(struct dso *dso, struct symbol *symbol)
-{
-	RC_CHK_ACCESS(dso)->last_find_result.symbol = symbol;
-}
-
 static inline enum dso_load_errno *dso__load_errno(struct dso *dso)
 {
 	return &RC_CHK_ACCESS(dso)->load_errno;
@@ -731,31 +705,11 @@ static inline struct rb_root *dso__global_vars(struct dso *dso)
 	return &RC_CHK_ACCESS(dso)->global_vars;
 }
 
-static inline struct rb_root_cached *dso__symbols(struct dso *dso)
+static inline struct symbols *dso__symbols(struct dso *dso)
 {
 	return &RC_CHK_ACCESS(dso)->symbols;
 }
 
-static inline struct symbol **dso__symbol_names(struct dso *dso)
-{
-	return RC_CHK_ACCESS(dso)->symbol_names;
-}
-
-static inline void dso__set_symbol_names(struct dso *dso, struct symbol **names)
-{
-	RC_CHK_ACCESS(dso)->symbol_names = names;
-}
-
-static inline size_t dso__symbol_names_len(struct dso *dso)
-{
-	return RC_CHK_ACCESS(dso)->symbol_names_len;
-}
-
-static inline void dso__set_symbol_names_len(struct dso *dso, size_t len)
-{
-	RC_CHK_ACCESS(dso)->symbol_names_len = len;
-}
-
 static inline const char *dso__symsrc_filename(const struct dso *dso)
 {
 	return RC_CHK_ACCESS(dso)->symsrc_filename;
@@ -825,13 +779,18 @@ bool dso__loaded(const struct dso *dso);
 
 static inline bool dso__has_symbols(const struct dso *dso)
 {
-	return !RB_EMPTY_ROOT(&RC_CHK_ACCESS(dso)->symbols.rb_root);
+	struct symbols *symbols = (struct symbols *)&RC_CHK_ACCESS(dso)->symbols;
+	bool res;
+
+	down_read(&symbols->lock);
+	res = symbols->cnt > 0;
+	up_read(&symbols->lock);
+	return res;
 }
 
 char *dso__filename_with_chroot(const struct dso *dso, const char *filename);
 
 bool dso__sorted_by_name(const struct dso *dso);
-void dso__set_sorted_by_name(struct dso *dso);
 void dso__sort_by_name(struct dso *dso);
 
 int dso__swap_init(struct dso *dso, unsigned char eidata);
@@ -955,8 +914,6 @@ struct map *dso__new_map(const char *name);
 struct dso *machine__findnew_kernel(struct machine *machine, const char *name,
 				    const char *short_name, int dso_type);
 
-void dso__reset_find_symbol_cache(struct dso *dso);
-
 size_t dso__fprintf_symbols_by_name(struct dso *dso, FILE *fp);
 size_t dso__fprintf(struct dso *dso, FILE *fp);
 
diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index 61bd4f49afba..9728e2509d4a 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -453,7 +453,8 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 		if (!symbol)
 			goto out_free;
 
-		symbols__insert(dso__symbols(dso), symbol);
+		if (symbols__insert(dso__symbols(dso), symbol))
+			goto out_free;
 	}
 #ifdef bfd_get_section
 #undef bfd_asymbol_section
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 6dd05ec1bbaf..3c206c26bd62 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -822,7 +822,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		err = -ENOMEM;
 		goto out;
 	}
-	dso__insert_symbol(dso, sym);
+	err = dso__insert_symbol(dso, sym);
 out:
 	map__put(map);
 	dso__put(dso);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 5155c95df85d..38b116d230d0 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -304,27 +304,35 @@ void map__put(struct map *map)
 
 void map__fixup_start(struct map *map)
 {
-	struct dso *dso = map__dso(map);
-	struct rb_root_cached *symbols = dso__symbols(dso);
-	struct rb_node *nd = rb_first_cached(symbols);
-
-	if (nd != NULL) {
-		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
+	struct symbols *symbols = dso__symbols(map__dso(map));
 
-		map__set_start(map, sym->start);
-	}
+	symbols__sort_read_lock(symbols);
+	if (symbols->cnt > 0)
+		map__set_start(map, symbols->symbols[0]->start);
+	up_read(&symbols->lock);
 }
 
 void map__fixup_end(struct map *map)
 {
-	struct dso *dso = map__dso(map);
-	struct rb_root_cached *symbols = dso__symbols(dso);
-	struct rb_node *nd = rb_last(&symbols->rb_root);
+	struct symbols *symbols = dso__symbols(map__dso(map));
 
-	if (nd != NULL) {
-		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
-		map__set_end(map, sym->end);
+	symbols__sort_read_lock(symbols);
+	if (symbols->cnt > 0) {
+		u64 last_start = symbols->symbols[symbols->cnt - 1]->start;
+		u64 end = symbols->symbols[symbols->cnt - 1]->end;
+
+		for (unsigned int i = symbols->cnt - 1; i > 0; i--) {
+			u64 sym_end;
+
+			if (symbols->symbols[i - 1]->start != last_start)
+				break;
+			sym_end = symbols->symbols[i - 1]->end;
+			if (sym_end > end)
+				end = sym_end;
+		}
+		map__set_end(map, end);
 	}
+	up_read(&symbols->lock);
 }
 
 #define DSO__DELETED "(deleted)"
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 2b7f9e30916d..bda0b92ada24 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -698,7 +698,8 @@ static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
 		sym = symbol__new(shdr.sh_offset + i, shdr.sh_entsize, STB_GLOBAL, STT_FUNC, buf);
 		if (!sym)
 			goto out;
-		symbols__insert(dso__symbols(dso), sym);
+		if (symbols__insert(dso__symbols(dso), sym))
+			goto out;
 	}
 	err = 0;
 out:
@@ -752,7 +753,8 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	plt_sym = symbol__new(shdr_plt.sh_offset, plt_header_size, STB_GLOBAL, STT_FUNC, ".plt");
 	if (!plt_sym)
 		goto out_elf_end;
-	symbols__insert(dso__symbols(dso), plt_sym);
+	if (symbols__insert(dso__symbols(dso), plt_sym))
+		goto out_elf_end;
 
 	/* Only x86 has .plt.got */
 	if (machine_is_x86(ehdr.e_machine) &&
@@ -874,7 +876,8 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 			goto out_elf_end;
 
 		plt_offset += plt_entry_size;
-		symbols__insert(dso__symbols(dso), f);
+		if (symbols__insert(dso__symbols(dso), f))
+			goto out_elf_end;
 		++nr;
 	}
 
@@ -1938,7 +1941,8 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 		arch__sym_update(f, &sym);
 
-		__symbols__insert(dso__symbols(curr_dso), f);
+		if (symbols__insert(dso__symbols(curr_dso), f))
+			goto out_elf_end;
 		nr++;
 	}
 	dso__put(curr_dso);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 710b80d86d07..43347c9a3a0c 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -213,57 +213,169 @@ static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
 	return arch__choose_best_symbol(syma, symb);
 }
 
-void symbols__fixup_duplicate(struct rb_root_cached *symbols)
+void symbols__init(struct symbols *symbols)
+	__context_unsafe(/* initialization */)
 {
-	struct rb_node *nd;
-	struct symbol *curr, *next;
+	init_rwsem(&symbols->lock);
+	symbols->symbols = NULL;
+	symbols->symbols_by_name = NULL;
+	symbols->cnt = 0;
+	symbols->allocated = 0;
+	symbols->num_by_name = 0;
+	symbols->sorted = true;
+	symbols->sorted_by_name = false;
+}
+
+static void symbols__delete_locked(struct symbols *symbols)
+	__must_hold(&symbols->lock)
+{
+	for (unsigned int i = 0; i < symbols->cnt; i++)
+		symbol__delete(symbols->symbols[i]);
+
+	zfree(&symbols->symbols);
+	zfree(&symbols->symbols_by_name);
+	symbols->cnt = 0;
+	symbols->allocated = 0;
+	symbols->num_by_name = 0;
+	symbols->sorted = true;
+	symbols->sorted_by_name = false;
+}
+
+void symbols__delete(struct symbols *symbols)
+{
+	down_write(&symbols->lock);
+	symbols__delete_locked(symbols);
+	up_write(&symbols->lock);
+}
+
+void symbols__exit(struct symbols *symbols)
+{
+	symbols__delete(symbols);
+	exit_rwsem(&symbols->lock);
+}
+
+/*
+ * Order symbols by start address only, preserving insertion order among
+ * symbols sharing the same start address (matching the previous rbtree
+ * __symbols__insert() behavior so alias deduplication and IFUNC resolution
+ * remain unchanged).
+ */
+static inline bool symbol__less_or_equal(const struct symbol *a, const struct symbol *b)
+{
+	return a->start <= b->start;
+}
+
+static int symbols__sort_cmp(const void *vlhs, const void *vrhs)
+{
+	const struct symbol *lhs = *((const struct symbol **)vlhs);
+	const struct symbol *rhs = *((const struct symbol **)vrhs);
+
+	if (lhs->start != rhs->start)
+		return lhs->start < rhs->start ? -1 : 1;
+	return 0;
+}
+
+static void symbols__sort_locked(struct symbols *symbols)
+	__must_hold(&symbols->lock)
+{
+	if (symbols->sorted)
+		return;
+
+	if (symbols->cnt > 1) {
+		qsort(symbols->symbols, symbols->cnt, sizeof(struct symbol *),
+		      symbols__sort_cmp);
+	}
+	symbols->sorted = true;
+}
+
+/*
+ * Acquire @symbols->lock for reading after ensuring @symbols->symbols is
+ * sorted.
+ */
+void symbols__sort_read_lock(struct symbols *symbols)
+{
+	down_read(&symbols->lock);
+	while (!symbols->sorted) {
+		up_read(&symbols->lock);
+		down_write(&symbols->lock);
+		symbols__sort_locked(symbols);
+		up_write(&symbols->lock);
+		down_read(&symbols->lock);
+	}
+}
+
+/*
+ * Deduplicate symbols sharing the same start address by sorting @symbols and
+ * compacting the array in place, keeping the best symbol at each address as
+ * chosen by choose_best_symbol().
+ */
+void symbols__fixup_duplicate(struct symbols *symbols)
+{
+	unsigned int write_idx = 0;
 
 	if (symbol_conf.allow_aliases)
 		return;
 
-	nd = rb_first_cached(symbols);
+	down_write(&symbols->lock);
+	symbols__sort_locked(symbols);
+	if (symbols->cnt <= 1) {
+		up_write(&symbols->lock);
+		return;
+	}
 
-	while (nd) {
-		curr = rb_entry(nd, struct symbol, rb_node);
-again:
-		nd = rb_next(&curr->rb_node);
-		if (!nd)
-			break;
+	for (unsigned int read_idx = 1; read_idx < symbols->cnt; read_idx++) {
+		struct symbol *curr = symbols->symbols[write_idx];
+		struct symbol *next = symbols->symbols[read_idx];
 
-		next = rb_entry(nd, struct symbol, rb_node);
-		if (curr->start != next->start)
+		if (curr->start != next->start) {
+			symbols->symbols[++write_idx] = next;
 			continue;
+		}
 
 		if (choose_best_symbol(curr, next) == SYMBOL_A) {
 			if (symbol__type(next) == STT_GNU_IFUNC)
 				symbol__set_ifunc_alias(curr, true);
-			rb_erase_cached(&next->rb_node, symbols);
 			symbol__delete(next);
-			goto again;
 		} else {
 			if (symbol__type(curr) == STT_GNU_IFUNC)
 				symbol__set_ifunc_alias(next, true);
-			nd = rb_next(&curr->rb_node);
-			rb_erase_cached(&curr->rb_node, symbols);
 			symbol__delete(curr);
+			symbols->symbols[write_idx] = next;
 		}
 	}
+	symbols->cnt = write_idx + 1;
+	zfree(&symbols->symbols_by_name);
+	symbols->num_by_name = 0;
+	symbols->sorted_by_name = false;
+	up_write(&symbols->lock);
 }
 
 /* Update zero-sized symbols using the address of the next symbol */
-void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms)
+void symbols__fixup_end(struct symbols *symbols, bool is_kallsyms)
 {
-	struct rb_node *nd, *prevnd = rb_first_cached(symbols);
 	struct symbol *curr, *prev;
+	bool addr_has_sized;
 
-	if (prevnd == NULL)
+	down_write(&symbols->lock);
+	symbols__sort_locked(symbols);
+
+	if (symbols->cnt == 0) {
+		up_write(&symbols->lock);
 		return;
+	}
 
-	curr = rb_entry(prevnd, struct symbol, rb_node);
+	curr = symbols->symbols[0];
+	addr_has_sized = curr->end > curr->start;
 
-	for (nd = rb_next(prevnd); nd; nd = rb_next(nd)) {
+	for (unsigned int i = 1; i < symbols->cnt; i++) {
 		prev = curr;
-		curr = rb_entry(nd, struct symbol, rb_node);
+		curr = symbols->symbols[i];
+
+		if (curr->start == prev->start) {
+			if (curr->end > curr->start)
+				addr_has_sized = true;
+			continue;
+		}
 
 		/*
 		 * On some architecture kernel text segment start is located at
@@ -281,39 +393,42 @@ void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms)
 		 * like in:
 		 *   ffffffffc1937000 T hdmi_driver_init  [snd_hda_codec_hdmi]
 		 */
-		if (prev->end == prev->start) {
+		if (!addr_has_sized && prev->end == prev->start) {
 			const char *prev_mod;
 			const char *curr_mod;
 
 			if (!is_kallsyms) {
 				prev->end = curr->start;
-				continue;
-			}
-
-			prev_mod = strchr(prev->name, '[');
-			curr_mod = strchr(curr->name, '[');
-
-			/* Last kernel/module symbol mapped to end of page */
-			if (!prev_mod != !curr_mod)
-				prev->end = roundup(prev->end + 4096, 4096);
-			/* Last symbol in the previous module */
-			else if (prev_mod && strcmp(prev_mod, curr_mod))
-				prev->end = roundup(prev->end + 4096, 4096);
-			else
-				prev->end = curr->start;
+			} else {
+				prev_mod = strchr(prev->name, '[');
+				curr_mod = strchr(curr->name, '[');
+
+				/* Last kernel/module symbol mapped to end of page */
+				if (!prev_mod != !curr_mod) {
+					prev->end = roundup(prev->end + 4096, 4096);
+				/* Last symbol in the previous module */
+				} else if (prev_mod && strcmp(prev_mod, curr_mod)) {
+					prev->end = roundup(prev->end + 4096, 4096);
+				} else {
+					prev->end = curr->start;
+				}
 
-			/* The next module can start within that page */
-			if (prev->end > curr->start)
-				prev->end = curr->start;
+				/* The next module can start within that page */
+				if (prev->end > curr->start)
+					prev->end = curr->start;
 
-			pr_debug4("%s sym:%s end:%#" PRIx64 "\n",
-				  __func__, prev->name, prev->end);
+				pr_debug4("%s sym:%s end:%#" PRIx64 "\n",
+					  __func__, prev->name, prev->end);
+			}
 		}
+		addr_has_sized = curr->end > curr->start;
 	}
 
 	/* Last entry */
-	if (curr->end == curr->start)
+	if (!addr_has_sized && curr->end == curr->start)
 		curr->end = roundup(curr->start, 4096) + 4096;
+
+	up_write(&symbols->lock);
 }
 
 struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name)
@@ -388,67 +503,117 @@ static void symbol__set_idle(struct symbol *sym, bool idle)
 		new_flags |= (idle_val << SYMBOL_FLAG_IDLE_SHIFT);
 	} while (!atomic_compare_exchange_weak(&sym->flags, &old_flags, new_flags));
 }
-void symbols__delete(struct rb_root_cached *symbols)
+
+static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
+	__must_hold(&symbols->lock)
 {
-	struct symbol *pos;
-	struct rb_node *next = rb_first_cached(symbols);
+	if (symbols->cnt == symbols->allocated) {
+		unsigned int to_allocate = symbols->allocated ? symbols->allocated * 2 : 32;
+		struct symbol **temp = realloc(symbols->symbols,
+					       sizeof(struct symbol *) * to_allocate);
 
-	while (next) {
-		pos = rb_entry(next, struct symbol, rb_node);
-		next = rb_next(&pos->rb_node);
-		rb_erase_cached(&pos->rb_node, symbols);
-		symbol__delete(pos);
+		if (!temp) {
+			symbol__delete(sym);
+			return -ENOMEM;
+		}
+		symbols->symbols = temp;
+		symbols->allocated = to_allocate;
 	}
+
+	if (symbols->sorted && symbols->cnt > 0 &&
+	    !symbol__less_or_equal(symbols->symbols[symbols->cnt - 1], sym))
+		symbols->sorted = false;
+
+	symbols->symbols[symbols->cnt++] = sym;
+	zfree(&symbols->symbols_by_name);
+	symbols->num_by_name = 0;
+	symbols->sorted_by_name = false;
+	return 0;
 }
 
-void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
+int symbols__insert(struct symbols *symbols, struct symbol *sym)
 {
-	struct rb_node **p = &symbols->rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	const u64 ip = sym->start;
-	struct symbol *s;
-	bool leftmost = true;
+	int ret;
 
-	while (*p != NULL) {
-		parent = *p;
-		s = rb_entry(parent, struct symbol, rb_node);
-		if (ip < s->start)
-			p = &(*p)->rb_left;
-		else {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		}
-	}
-	rb_link_node(&sym->rb_node, parent, p);
-	rb_insert_color_cached(&sym->rb_node, symbols, leftmost);
+	down_write(&symbols->lock);
+	ret = __symbols__insert(symbols, sym);
+	up_write(&symbols->lock);
+	return ret;
+}
+
+static inline bool symbol__covers(const struct symbol *s, u64 ip)
+{
+	u64 start = s->start;
+	u64 end = s->end;
+
+	return ip >= start && (ip < end || (ip == end && ip == start));
 }
 
-void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
+static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt, u64 ip)
 {
-	__symbols__insert(symbols, sym);
+	unsigned int low = 0, high = cnt, idx;
+	u64 start;
+
+	while (low < high) {
+		unsigned int mid = low + (high - low) / 2;
+
+		if (arr[mid]->start <= ip)
+			low = mid + 1;
+		else
+			high = mid;
+	}
+	if (low == 0)
+		return NULL;
+
+	/*
+	 * Rewind across any equal-start group so a trailing zero-length or
+	 * shorter alias at the same start address cannot mask an earlier
+	 * covering symbol.
+	 */
+	idx = low - 1;
+	start = arr[idx]->start;
+	while (idx > 0 && arr[idx - 1]->start == start)
+		idx--;
+	for (; idx < low; idx++) {
+		if (symbol__covers(arr[idx], ip))
+			return arr[idx];
+	}
+	return NULL;
 }
 
-static struct symbol *symbols__find(struct rb_root_cached *symbols, u64 ip)
+/*
+ * Binary search @symbols->symbols for a symbol covering @ip. Lazily sorts
+ * @symbols under @symbols->lock if unsorted.
+ */
+static struct symbol *symbols__find(struct symbols *symbols, u64 ip)
 {
-	struct rb_node *n;
+	struct symbol *res;
 
 	if (symbols == NULL)
 		return NULL;
 
-	n = symbols->rb_root.rb_node;
+	symbols__sort_read_lock(symbols);
+	res = symbols__find_range(symbols->symbols, symbols->cnt, ip);
+	up_read(&symbols->lock);
 
-	while (n) {
-		struct symbol *s = rb_entry(n, struct symbol, rb_node);
+	return res;
+}
 
-		if (ip < s->start)
-			n = n->rb_left;
-		else if (ip > s->end || (ip == s->end && ip != s->start))
-			n = n->rb_right;
-		else
-			return s;
+int symbols__visit(struct symbols *symbols,
+		   int (*cb)(struct symbol *sym, void *data),
+		   void *data)
+{
+	int err = 0;
+
+	symbols__sort_read_lock(symbols);
+	for (unsigned int i = 0; i < symbols->cnt; i++) {
+		err = cb(symbols->symbols[i], data);
+		if (err)
+			break;
 	}
+	up_read(&symbols->lock);
 
-	return NULL;
+	return err;
 }
 
 static int symbols__sort_name_cmp(const void *vlhs, const void *vrhs)
@@ -459,27 +624,51 @@ static int symbols__sort_name_cmp(const void *vlhs, const void *vrhs)
 	return strcmp(lhs->name, rhs->name);
 }
 
-static struct symbol **symbols__sort_by_name(struct rb_root_cached *source, size_t *len)
+static int symbols__sort_by_name_locked(struct symbols *symbols)
+	__must_hold(&symbols->lock)
 {
-	struct rb_node *nd;
 	struct symbol **result;
-	size_t i = 0, size = 0;
+	unsigned int size = symbols->cnt;
+
+	if (symbols->sorted_by_name)
+		return 0;
 
-	for (nd = rb_first_cached(source); nd; nd = rb_next(nd))
-		size++;
+	zfree(&symbols->symbols_by_name);
+	symbols->num_by_name = 0;
+
+	if (size == 0) {
+		symbols->sorted_by_name = true;
+		return 0;
+	}
 
 	result = malloc(sizeof(*result) * size);
 	if (!result)
-		return NULL;
+		return -ENOMEM;
+
+	memcpy(result, symbols->symbols, sizeof(*result) * size);
+	qsort(result, size, sizeof(*result), symbols__sort_name_cmp);
+	symbols->symbols_by_name = result;
+	symbols->num_by_name = size;
+	symbols->sorted_by_name = true;
+	return 0;
+}
 
-	for (nd = rb_first_cached(source); nd; nd = rb_next(nd)) {
-		struct symbol *pos = rb_entry(nd, struct symbol, rb_node);
+static int symbols__sort_by_name_read_lock(struct symbols *symbols)
+	__acquires_shared(&symbols->lock)
+{
+	int err = 0;
 
-		result[i++] = pos;
+	down_read(&symbols->lock);
+	while (!symbols->sorted_by_name) {
+		up_read(&symbols->lock);
+		down_write(&symbols->lock);
+		err = symbols__sort_by_name_locked(symbols);
+		up_write(&symbols->lock);
+		down_read(&symbols->lock);
+		if (err)
+			break;
 	}
-	qsort(result, size, sizeof(*result), symbols__sort_name_cmp);
-	*len = size;
-	return result;
+	return symbols->sorted_by_name ? 0 : err;
 }
 
 int symbol__match_symbol_name(const char *name, const char *str,
@@ -548,58 +737,34 @@ static struct symbol *symbols__find_by_name(struct symbol *symbols[],
 	return s;
 }
 
-void dso__reset_find_symbol_cache(struct dso *dso)
-{
-	dso__set_last_find_result_addr(dso, 0);
-	dso__set_last_find_result_symbol(dso, NULL);
-}
-
-void dso__insert_symbol(struct dso *dso, struct symbol *sym)
+int dso__insert_symbol(struct dso *dso, struct symbol *sym)
 {
-	__symbols__insert(dso__symbols(dso), sym);
-
-	/* update the symbol cache if necessary */
-	if (dso__last_find_result_addr(dso) >= sym->start &&
-	    (dso__last_find_result_addr(dso) < sym->end ||
-	    sym->start == sym->end)) {
-		dso__set_last_find_result_symbol(dso, sym);
-	}
+	return symbols__insert(dso__symbols(dso), sym);
 }
 
 void dso__delete_symbol(struct dso *dso, struct symbol *sym)
 {
-	rb_erase_cached(&sym->rb_node, dso__symbols(dso));
-	symbol__delete(sym);
-	dso__reset_find_symbol_cache(dso);
-}
-
-struct symbol *dso__find_symbol(struct dso *dso, u64 addr)
-{
-	if (dso__last_find_result_addr(dso) != addr || dso__last_find_result_symbol(dso) == NULL) {
-		dso__set_last_find_result_addr(dso, addr);
-		dso__set_last_find_result_symbol(dso, symbols__find(dso__symbols(dso), addr));
+	struct symbols *symbols = dso__symbols(dso);
+
+	down_write(&symbols->lock);
+	for (unsigned int i = 0; i < symbols->cnt; i++) {
+		if (symbols->symbols[i] == sym) {
+			memmove(&symbols->symbols[i], &symbols->symbols[i + 1],
+				(symbols->cnt - i - 1) * sizeof(struct symbol *));
+			symbols->cnt--;
+			zfree(&symbols->symbols_by_name);
+			symbols->num_by_name = 0;
+			symbols->sorted_by_name = false;
+			symbol__delete(sym);
+			break;
+		}
 	}
-
-	return dso__last_find_result_symbol(dso);
+	up_write(&symbols->lock);
 }
 
-int symbols__visit(struct rb_root_cached *symbols,
-		   int (*cb)(struct symbol *sym, void *data),
-		   void *data)
+struct symbol *dso__find_symbol(struct dso *dso, u64 addr)
 {
-	struct rb_node *nd;
-
-	if (!symbols)
-		return 0;
-
-	for (nd = rb_first_cached(symbols); nd; nd = rb_next(nd)) {
-		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
-		int ret = cb(sym, data);
-
-		if (ret)
-			return ret;
-	}
-	return 0;
+	return symbols__find(dso__symbols(dso), addr);
 }
 
 struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr)
@@ -607,30 +772,23 @@ struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr)
 	return symbols__find(dso__symbols(dso), addr);
 }
 
-int dso__visit_symbols_by_name(struct dso *dso,
-			       int (*cb)(struct symbol *sym, void *data),
-			       void *data)
+struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx)
 {
-	if (!dso)
-		return 0;
+	struct symbols *symbols;
+	struct symbol *res = NULL;
 
-	dso__sort_by_name(dso);
-	for (size_t i = 0; i < dso__symbol_names_len(dso); i++) {
-		int ret = cb(dso__symbol_names(dso)[i], data);
+	if (!dso)
+		return NULL;
 
-		if (ret)
-			return ret;
+	symbols = dso__symbols(dso);
+	if (!symbols__sort_by_name_read_lock(symbols) &&
+	    *idx + 1 < symbols->num_by_name) {
+		++*idx;
+		res = symbols->symbols_by_name[*idx];
 	}
-	return 0;
-}
+	up_read(&symbols->lock);
 
-struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx)
-{
-	if (*idx + 1 >= dso__symbol_names_len(dso))
-		return NULL;
-
-	++*idx;
-	return dso__symbol_names(dso)[*idx];
+	return res;
 }
 
  /*
@@ -638,29 +796,58 @@ struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx)
   */
 struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_t *idx)
 {
-	struct symbol *s = symbols__find_by_name(dso__symbol_names(dso),
-						 dso__symbol_names_len(dso),
-						 name, SYMBOL_TAG_INCLUDE__NONE, idx);
-	if (!s) {
-		s = symbols__find_by_name(dso__symbol_names(dso), dso__symbol_names_len(dso),
-					  name, SYMBOL_TAG_INCLUDE__DEFAULT_ONLY, idx);
+	struct symbols *symbols;
+	struct symbol *s = NULL;
+
+	if (idx)
+		*idx = SIZE_MAX;
+	if (!dso)
+		return NULL;
+	symbols = dso__symbols(dso);
+	if (!symbols__sort_by_name_read_lock(symbols)) {
+		s = symbols__find_by_name(symbols->symbols_by_name,
+					  symbols->num_by_name,
+					  name, SYMBOL_TAG_INCLUDE__NONE, idx);
+		if (!s) {
+			s = symbols__find_by_name(symbols->symbols_by_name, symbols->num_by_name,
+						  name, SYMBOL_TAG_INCLUDE__DEFAULT_ONLY, idx);
+		}
 	}
+	up_read(&symbols->lock);
 	return s;
 }
 
 void dso__sort_by_name(struct dso *dso)
 {
-	mutex_lock(dso__lock(dso));
-	if (!dso__sorted_by_name(dso)) {
-		size_t len = 0;
+	struct symbols *symbols = dso__symbols(dso);
+
+	down_read(&symbols->lock);
+	if (!symbols->sorted_by_name) {
+		up_read(&symbols->lock);
+		down_write(&symbols->lock);
+		symbols__sort_by_name_locked(symbols);
+		up_write(&symbols->lock);
+		return;
+	}
+	up_read(&symbols->lock);
+}
+
+int symbols__visit_by_name(struct symbols *symbols,
+			   int (*cb)(struct symbol *sym, void *data),
+			   void *data)
+{
+	int err = symbols__sort_by_name_read_lock(symbols);
 
-		dso__set_symbol_names(dso, symbols__sort_by_name(dso__symbols(dso), &len));
-		if (dso__symbol_names(dso)) {
-			dso__set_symbol_names_len(dso, len);
-			dso__set_sorted_by_name(dso);
+	if (!err) {
+		for (size_t i = 0; i < symbols->num_by_name; i++) {
+			err = cb(symbols->symbols_by_name[i], data);
+			if (err)
+				break;
 		}
 	}
-	mutex_unlock(dso__lock(dso));
+	up_read(&symbols->lock);
+
+	return err;
 }
 
 /*
@@ -860,7 +1047,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 {
 	struct symbol *sym;
 	struct dso *dso = arg;
-	struct rb_root_cached *root = dso__symbols(dso);
+	struct symbols *root = dso__symbols(dso);
 
 	if (!symbol_type__filter(type))
 		return 0;
@@ -881,9 +1068,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	 * We will pass the symbols to the filter later, in
 	 * map__split_kallsyms, when we have split the maps per module
 	 */
-	__symbols__insert(root, sym);
-
-	return 0;
+	return symbols__insert(root, sym);
 }
 
 /*
@@ -900,25 +1085,32 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 {
 	struct symbol *pos;
 	int count = 0;
-	struct rb_root_cached *root = dso__symbols(dso);
-	struct rb_root_cached old_root = *root;
-	struct rb_node *next = rb_first_cached(root);
+	struct symbols *root = dso__symbols(dso);
+	struct symbol **old_symbols;
+	unsigned int old_cnt;
 
 	if (!kmaps)
 		return -1;
 
-	*root = RB_ROOT_CACHED;
-
-	while (next) {
+	down_write(&root->lock);
+	symbols__sort_locked(root);
+	old_symbols = root->symbols;
+	old_cnt = root->cnt;
+	root->symbols = NULL;
+	root->cnt = 0;
+	root->allocated = 0;
+	root->sorted = true;
+	zfree(&root->symbols_by_name);
+	root->num_by_name = 0;
+	root->sorted_by_name = false;
+	up_write(&root->lock);
+
+	for (unsigned int i = 0; i < old_cnt; i++) {
 		struct map *curr_map;
 		struct dso *curr_map_dso;
 		char *module;
 
-		pos = rb_entry(next, struct symbol, rb_node);
-		next = rb_next(&pos->rb_node);
-
-		rb_erase_cached(&pos->rb_node, &old_root);
-		RB_CLEAR_NODE(&pos->rb_node);
+		pos = old_symbols[i];
 		module = strchr(pos->name, '\t');
 		if (module)
 			*module = '\0';
@@ -935,11 +1127,13 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 			pos->end = map__end(curr_map);
 		if (pos->end)
 			pos->end -= map__start(curr_map) - map__pgoff(curr_map);
-		symbols__insert(dso__symbols(curr_map_dso), pos);
-		++count;
+		if (symbols__insert(dso__symbols(curr_map_dso), pos) == 0)
+			++count;
 		map__put(curr_map);
 	}
 
+	free(old_symbols);
+
 	/* Symbols have been adjusted */
 	dso__set_adjust_symbols(dso, true);
 
@@ -958,8 +1152,10 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	struct map *curr_map = map__get(initial_map);
 	struct symbol *pos;
 	int count = 0, moved = 0;
-	struct rb_root_cached *root = dso__symbols(dso);
-	struct rb_node *next = rb_first_cached(root);
+	struct symbols *root = dso__symbols(dso);
+	struct symbol **old_symbols;
+	unsigned int old_cnt, old_allocated;
+	unsigned int i, write_idx = 0;
 	int kernel_range = 0;
 	uint16_t e_machine = EM_NONE;
 
@@ -969,11 +1165,24 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	machine = maps__machine(kmaps);
 	e_machine = perf_env__e_machine(machine->env, /*e_flags=*/NULL);
 
-	while (next) {
+	down_write(&root->lock);
+	symbols__sort_locked(root);
+	old_symbols = root->symbols;
+	old_cnt = root->cnt;
+	old_allocated = root->allocated;
+	root->symbols = NULL;
+	root->cnt = 0;
+	root->allocated = 0;
+	root->sorted = true;
+	zfree(&root->symbols_by_name);
+	root->num_by_name = 0;
+	root->sorted_by_name = false;
+	up_write(&root->lock);
+
+	for (i = 0; i < old_cnt; i++) {
 		char *module;
 
-		pos = rb_entry(next, struct symbol, rb_node);
-		next = rb_next(&pos->rb_node);
+		pos = old_symbols[i];
 
 		module = strchr(pos->name, '\t');
 		if (module) {
@@ -1058,7 +1267,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			ndso = dso__new(dso_name);
 			map__zput(curr_map);
 			if (ndso == NULL)
-				return -1;
+				goto out_err;
 
 			dso__set_kernel(ndso, dso__kernel(dso));
 			if (dso__kernel(dso) == DSO_SPACE__KERNEL_GUEST) {
@@ -1071,20 +1280,20 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			dso__set_loaded(ndso);
 			if (dsos__add(&machine->dsos, ndso)) {
 				dso__put(ndso);
-				return -1;
+				goto out_err;
 			}
 
 			curr_map = map__new2(pos->start, ndso);
 			if (curr_map == NULL) {
 				dso__put(ndso);
-				return -1;
+				goto out_err;
 			}
 
 			map__set_mapping_type(curr_map, MAPPING_TYPE__IDENTITY);
 			if (maps__insert(kmaps, curr_map)) {
 				map__zput(curr_map);
 				dso__put(ndso);
-				return -1;
+				goto out_err;
 			}
 			dso__put(ndso);
 			++kernel_range;
@@ -1097,18 +1306,35 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		if (!RC_CHK_EQUAL(curr_map, initial_map)) {
 			struct dso *curr_map_dso = map__dso(curr_map);
 
-			rb_erase_cached(&pos->rb_node, root);
-			symbols__insert(dso__symbols(curr_map_dso), pos);
-			++moved;
-		} else
+			if (symbols__insert(dso__symbols(curr_map_dso), pos) == 0)
+				++moved;
+		} else {
+			old_symbols[write_idx++] = pos;
 			++count;
+		}
 
 		continue;
 discard_symbol:
-		rb_erase_cached(&pos->rb_node, root);
 		symbol__delete(pos);
 	}
 
+	down_write(&root->lock);
+	if (root->cnt == 0) {
+		root->symbols = old_symbols;
+		root->cnt = write_idx;
+		root->allocated = old_allocated;
+		root->sorted = true;
+		old_symbols = NULL;
+	} else {
+		for (unsigned int j = 0; j < write_idx; j++)
+			__symbols__insert(root, old_symbols[j]);
+	}
+	zfree(&root->symbols_by_name);
+	root->num_by_name = 0;
+	root->sorted_by_name = false;
+	up_write(&root->lock);
+	free(old_symbols);
+
 	if (!RC_CHK_EQUAL(curr_map, initial_map) &&
 	    dso__kernel(dso) == DSO_SPACE__KERNEL_GUEST &&
 	    machine__is_default_guest(maps__machine(kmaps))) {
@@ -1116,6 +1342,29 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	}
 	map__put(curr_map);
 	return count + moved;
+
+out_err:
+	memmove(&old_symbols[write_idx], &old_symbols[i],
+		(old_cnt - i) * sizeof(struct symbol *));
+	write_idx += old_cnt - i;
+	down_write(&root->lock);
+	if (root->cnt == 0) {
+		root->symbols = old_symbols;
+		root->cnt = write_idx;
+		root->allocated = old_allocated;
+		root->sorted = (delta == 0);
+		old_symbols = NULL;
+	} else {
+		for (unsigned int j = 0; j < write_idx; j++)
+			__symbols__insert(root, old_symbols[j]);
+		root->sorted = false;
+	}
+	zfree(&root->symbols_by_name);
+	root->num_by_name = 0;
+	root->sorted_by_name = false;
+	up_write(&root->lock);
+	free(old_symbols);
+	return -1;
 }
 
 bool symbol__restricted_filename(const char *filename,
@@ -1676,7 +1925,8 @@ static int dso__load_perf_map(const char *map_path, struct dso *dso)
 		if (sym == NULL)
 			goto out_delete_line;
 
-		symbols__insert(dso__symbols(dso), sym);
+		if (symbols__insert(dso__symbols(dso), sym))
+			goto out_delete_line;
 		nr_syms++;
 	}
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 784c87b72f38..8b8ab7e1e148 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -15,6 +15,7 @@
 #include <errno.h>
 #include "addr_location.h"
 #include "path.h"
+#include "rwsem.h"
 #include "symbol_conf.h"
 #include "spark.h"
 #include "util.h"
@@ -82,7 +83,6 @@ enum symbol_idle_kind {
  * A symtab entry.
  */
 struct symbol {
-	struct rb_node	rb_node;
 	/** Range of symbol [start, end). */
 	u64		start;
 	u64		end;
@@ -95,8 +95,42 @@ struct symbol {
 	char		name[];
 };
 
+/**
+ * struct symbols - A locked collection of symbols stored in a sorted array.
+ */
+struct symbols {
+	/** @lock: Read/write semaphore synchronizing access to the arrays. */
+	struct rw_semaphore lock;
+	/**
+	 * @symbols: Dynamically allocated array of symbol pointers, sorted by
+	 * address range [start, end) when @sorted is true.
+	 */
+	struct symbol **symbols __guarded_by(&lock);
+	/**
+	 * @symbols_by_name: Optional dynamically allocated array of symbol
+	 * pointers sorted lexicographically by sym->name.
+	 */
+	struct symbol **symbols_by_name __guarded_by(&lock);
+	/** @cnt: Number of valid entries in @symbols. */
+	unsigned int cnt __guarded_by(&lock);
+	/** @allocated: Capacity (in entries) of the @symbols allocation. */
+	unsigned int allocated __guarded_by(&lock);
+	/** @num_by_name: Number of valid entries in @symbols_by_name. */
+	unsigned int num_by_name __guarded_by(&lock);
+	/**
+	 * @sorted_by_name: True when @symbols_by_name is populated and sorted
+	 * by name.
+	 */
+	bool sorted_by_name __guarded_by(&lock);
+	/** @sorted: True when @symbols is sorted by address range. */
+	bool sorted __guarded_by(&lock);
+};
+
 void symbol__delete(struct symbol *sym);
-void symbols__delete(struct rb_root_cached *symbols);
+void symbols__init(struct symbols *symbols);
+void symbols__exit(struct symbols *symbols);
+void symbols__delete(struct symbols *symbols);
+void symbols__sort_read_lock(struct symbols *symbols) __acquires_shared(&symbols->lock);
 
 static inline u8 symbol__type(const struct symbol *sym)
 {
@@ -144,13 +178,16 @@ void symbol__set_ifunc_alias(struct symbol *sym, bool ifunc_alias);
 /*
  * symbols__visit - iterate over symbols calling @cb for each entry
  *
- * @symbols: the rb_root_cached of symbols
- * @cb: callback function invoked for each symbol
+ * @symbols: the 'struct symbols *' of symbols
+ * @cb: callback function invoked under @symbols->lock
  * @data: opaque data pointer passed to @cb
  */
-int symbols__visit(struct rb_root_cached *symbols,
+int symbols__visit(struct symbols *symbols,
 		   int (*cb)(struct symbol *sym, void *data),
 		   void *data);
+int symbols__visit_by_name(struct symbols *symbols,
+			   int (*cb)(struct symbol *sym, void *data),
+			   void *data);
 
 static inline size_t symbol__size(const struct symbol *sym)
 {
@@ -187,8 +224,8 @@ int __dso__load_kallsyms(struct dso *dso, const char *filename, struct map *map,
 			 bool no_kcore);
 int dso__load_kallsyms(struct dso *dso, const char *filename, struct map *map);
 
-void dso__insert_symbol(struct dso *dso,
-			struct symbol *sym);
+int dso__insert_symbol(struct dso *dso,
+		       struct symbol *sym);
 void dso__delete_symbol(struct dso *dso,
 			struct symbol *sym);
 
@@ -197,9 +234,6 @@ struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr);
 
 struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx);
 struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_t *idx);
-int dso__visit_symbols_by_name(struct dso *dso,
-			       int (*cb)(struct symbol *sym, void *data),
-			       void *data);
 
 enum dso_type dso__type_fd(int fd);
 
@@ -251,10 +285,9 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
 
 char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
 
-void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
-void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
-void symbols__fixup_duplicate(struct rb_root_cached *symbols);
-void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms);
+int symbols__insert(struct symbols *symbols, struct symbol *sym);
+void symbols__fixup_duplicate(struct symbols *symbols);
+void symbols__fixup_end(struct symbols *symbols, bool is_kallsyms);
 
 typedef int (*mapfn_t)(u64 start, u64 len, u64 pgoff, void *data);
 int file__read_maps(int fd, bool exe, mapfn_t mapfn, void *data,
-- 
2.56.1.750.gf70dc682cf-goog

