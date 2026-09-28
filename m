Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DCB45FFAC
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 07:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581982; cv=none; b=U/uNCG62NkPJ40nwx6X5RYQHxkCyC71hzOnQ/gIlVomxFLMy9b3f+1eoR20yDi92n5vvShUbygssUBGN05z+xy450TaPfcNpQE6FOfcmMhJ1oWTtuJeceZijHybI0kmcFhMOavnoy9UXYG/JQ2KeGe02vnhmDKRsfcAAGEg76No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581982; c=relaxed/simple;
	bh=dy3eijDOvxy6qikmwzLdV5y3M+SE+9rlzSzuFJBTQsg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PN8i6IuclVk2G49QuyHYRPxCptzmjFr1Sdg6ya15vuFI20+0FtF8NA/BAtPoE8FLY/cljOeqmKq6WpVlcn9QmbVxgATv9U0xsnf3I/B2jWmtXDhDH+/SDn+6F7ppQ4obvajqZdEyCwQRkUgSOtGeSSJc0SFYnLhJR0SGttPt9e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rOekUIKs; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rOekUIKs"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-349ffa249bdso574253eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 00:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790581976; x=1791186776; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RvMBRckGWmyNNEYSc/KoNIWeBdgL3/EqSqi1Bj+VIUY=;
        b=rOekUIKsGeC/a13xQIeKrgt7yJZcbC4vP0tt8adjCSw+JnJaeWLXoKlAKTt/MTRk5z
         gEpcJr2oU9TKNs83L4DoDIPFSXlJzN0+z/UGvAxcAfrZOnNCctfpMdxx9ohZRFpfu6Kb
         KP+Zg7TRjmnsNYp+RRBC0vV9xAFPXpRKHTOAeEmmBR4NIwXqtuQ9SSYTYCrDM+wWre0o
         wk6ZyadT+dB1D5Y7XtVqQZ7d+JLktKKV24qfQHtDA0RG9b8aXF6+06saue020FM9mPOT
         zxPuPDeqJrgAdK4KkumsApYEGYCa8ZZcac0RQ53ZQ2XCAPgwWCtrT8/4m/ZHNEVgnVu9
         TpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581976; x=1791186776;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RvMBRckGWmyNNEYSc/KoNIWeBdgL3/EqSqi1Bj+VIUY=;
        b=ZFgx2UO/F0G1i/iFqeVXLfA6fcH0UTH3icgrn31h7e2EGLjJ1qFWmfJg909mKafGWY
         T0HdUnRKWroBT7j092e+kN4BNfCgveHf1DZADU4DezpZNqUR0YeemurKOzaYXalMsczV
         btpHG+J1tE2Dal4kWKz1sEkCWtl4TMkZkfCVjXnUi2zQ9wwprPbxl9gB9LWRQENDL97z
         buJngnkdjNPTX4Fs2iK61DWU/Snc0kgwWcYvloeCokSDu2SdDQ/A78OXMYHTbvjNpwIk
         egDjTasfpgU0mlsumUap/A17V0qSQYfytRmqXmhy2qFlhL12B1sybv4u3W5VyXF5BVuI
         CJkg==
X-Forwarded-Encrypted: i=1; AKwUvBywjABe18U7k7Bnzae7CNdwg4aPsu2LzyiUJ6VzOtXLQaSddEexN7g2fQzrIOvv5kVHdYdmfDaLfbUyU+Mw9NPi@vger.kernel.org
X-Gm-Message-State: AFuF++neN9mti2lMR4hzdg7Iju/wYulz+z7uGkwA1PIKdVrVYI3lc5Q3
	qhlLqESCI/1PDz3EmvwIpdQLe45iG383ixKHyWK2X2gpSWj1z5ZQzuwk0TzbGL3MCmkQHchTKim
	RRC37otW2VQ==
X-Received: from dlbur24.prod.google.com ([2002:a05:7022:ea58:b0:144:db76:3e5f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2406:b0:138:243e:ceb1
 with SMTP id a92af1059eb24-146ce1a9961mr8945825c88.6.1790581975195; Mon, 28
 Sep 2026 00:52:55 -0700 (PDT)
Date: Mon, 28 Sep 2026 00:52:33 -0700
In-Reply-To: <20260928075237.3055101-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928075237.3055101-4-irogers@google.com>
Subject: [PATCH v1 3/7] perf symbol: Switch backing storage from rbtree to
 struct symbols array
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alireza Haghdoost <haghdoost@uber.com>
Content-Type: text/plain; charset="UTF-8"

Replace struct rb_node rb_node in struct symbol (which cost 24 bytes per
symbol on 64-bit) with a sorted array in struct symbols, matching the
design of struct dsos and struct maps:

- Introduce struct symbols containing a rw_semaphore lock, primary
  address-sorted symbols array, secondary name-sorted symbols_by_name
  array, counts, capacity, and sorted state flags.
- Lazily sort symbols by [start, end) using qsort (symbols__sort_locked)
  and use binary search in symbols__find().
- Update symbols__fixup_duplicate(), symbols__fixup_end(),
  maps__split_kallsyms_for_kcore(), and maps__split_kallsyms() to
  operate on the sorted array and compact entries in place.
- Convert symbols__for_each_entry(), dso__for_each_symbol(), and
  map__for_each_symbol() to callback-based iteration under
  symbols->lock, matching dsos__for_each_dso() and maps__for_each_map().
- Remove the unsynchronized single-entry dso->last_find_result cache and
  dso__reset_find_symbol_cache() since binary search over a contiguous
  array is cache-friendly.
- Remove the direct rb_erase_cached() workaround in builtin-annotate.c's
  add_sample().
- Update the TUI map browser (ui/browsers/map.c) to snapshot the sorted
  symbol array into an entries array and use ui_browser__argv_refresh
  and ui_browser__argv_seek instead of ui_browser__rb_tree_refresh.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c |  34 +-
 tools/perf/builtin-annotate.c               |  11 -
 tools/perf/builtin-kmem.c                   |  51 ++-
 tools/perf/tests/symbols.c                  |  61 ++-
 tools/perf/tests/vmlinux-kallsyms.c         | 189 ++++----
 tools/perf/ui/browsers/map.c                |  62 ++-
 tools/perf/util/auxtrace.c                  | 109 +++--
 tools/perf/util/dso.c                       |  50 +-
 tools/perf/util/dso.h                       |  59 +--
 tools/perf/util/intel-pt.c                  |  74 +--
 tools/perf/util/machine.c                   |  28 +-
 tools/perf/util/map.c                       |  25 +-
 tools/perf/util/map.h                       |   8 +-
 tools/perf/util/probe-event.c               |  82 ++--
 tools/perf/util/symbol.c                    | 478 ++++++++++++--------
 tools/perf/util/symbol.h                    |  70 ++-
 16 files changed, 801 insertions(+), 590 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index d73bfdcdbec1..0ec327930b0a 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -115,13 +115,27 @@ void arch__fix_tev_from_maps(struct perf_probe_event *pev,
 }
 
 #ifdef HAVE_LIBELF_SUPPORT
+struct post_process_probe_trace_events_args {
+	struct perf_probe_event *pev;
+	struct probe_trace_event *tev;
+	struct map *map;
+};
+
+static int post_process_probe_trace_events_cb(struct symbol *sym, void *data)
+{
+	struct post_process_probe_trace_events_args *args = data;
+
+	if (map__unmap_ip(args->map, symbol__start(sym)) == args->tev->point.address) {
+		arch__fix_tev_from_maps(args->pev, args->tev, args->map, sym);
+		return 1;
+	}
+	return 0;
+}
+
 void arch__post_process_probe_trace_events(struct perf_probe_event *pev,
 					   int ntevs)
 {
-	struct probe_trace_event *tev;
 	struct map *map;
-	struct symbol *sym = NULL;
-	struct rb_node *tmp;
 	int i = 0;
 
 	map = get_target_map(pev->target, pev->nsi, pev->uprobes);
@@ -129,13 +143,13 @@ void arch__post_process_probe_trace_events(struct perf_probe_event *pev,
 		return;
 
 	for (i = 0; i < ntevs; i++) {
-		tev = &pev->tevs[i];
-		map__for_each_symbol(map, sym, tmp) {
-			if (map__unmap_ip(map, symbol__start(sym)) == tev->point.address) {
-				arch__fix_tev_from_maps(pev, tev, map, sym);
-				break;
-			}
-		}
+		struct post_process_probe_trace_events_args args = {
+			.pev = pev,
+			.tev = &pev->tevs[i],
+			.map = map,
+		};
+
+		map__for_each_symbol(map, post_process_probe_trace_events_cb, &args);
 	}
 }
 #endif /* HAVE_LIBELF_SUPPORT */
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index c93b67986334..5ee02a25fb9c 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -254,17 +254,6 @@ static int add_sample(struct perf_sample *sample,
 	    (al->sym == NULL ||
 	     strcmp(ann->sym_hist_filter, symbol__name(al->sym)) != 0)) {
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
 
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index d1883086ed58..dd8821d2d05e 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -341,13 +341,33 @@ static int callcmp(const void *a, const void *b)
 		return -1;
 }
 
+static int build_alloc_func_list_cb(struct symbol *sym, void *data)
+{
+	regex_t *alloc_func_regex = data;
+	struct alloc_func *func;
+
+	if (regexec(alloc_func_regex, symbol__name(sym), 0, NULL, 0))
+		return 0;
+
+	func = realloc(alloc_func_list,
+		       (nr_alloc_funcs + 1) * sizeof(*func));
+	if (func == NULL)
+		return -ENOMEM;
+
+	pr_debug("alloc func: %s\n", symbol__name(sym));
+	func[nr_alloc_funcs].start = symbol__start(sym);
+	func[nr_alloc_funcs].end   = symbol__end(sym);
+	func[nr_alloc_funcs].name  = symbol__name(sym);
+
+	alloc_func_list = func;
+	nr_alloc_funcs++;
+	return 0;
+}
+
 static int build_alloc_func_list(void)
 {
 	int ret;
 	struct map *kernel_map;
-	struct symbol *sym;
-	struct rb_node *node;
-	struct alloc_func *func;
 	struct machine *machine = &kmem_session->machines.host;
 	regex_t alloc_func_regex;
 	static const char pattern[] = "^_?_?(alloc|get_free|get_zeroed)_pages?";
@@ -364,30 +384,17 @@ static int build_alloc_func_list(void)
 	kernel_map = machine__kernel_map(machine);
 	if (map__load(kernel_map) < 0) {
 		pr_err("cannot load kernel map\n");
+		regfree(&alloc_func_regex);
 		return -ENOENT;
 	}
 
-	map__for_each_symbol(kernel_map, sym, node) {
-		if (regexec(&alloc_func_regex, symbol__name(sym), 0, NULL, 0))
-			continue;
-
-		func = realloc(alloc_func_list,
-			       (nr_alloc_funcs + 1) * sizeof(*func));
-		if (func == NULL)
-			return -ENOMEM;
-
-		pr_debug("alloc func: %s\n", symbol__name(sym));
-		func[nr_alloc_funcs].start = symbol__start(sym);
-		func[nr_alloc_funcs].end   = symbol__end(sym);
-		func[nr_alloc_funcs].name  = symbol__name(sym);
-
-		alloc_func_list = func;
-		nr_alloc_funcs++;
-	}
+	ret = map__for_each_symbol(kernel_map, build_alloc_func_list_cb, &alloc_func_regex);
+	regfree(&alloc_func_regex);
+	if (ret)
+		return ret;
 
-	qsort(alloc_func_list, nr_alloc_funcs, sizeof(*func), funcmp);
+	qsort(alloc_func_list, nr_alloc_funcs, sizeof(*alloc_func_list), funcmp);
 
-	regfree(&alloc_func_regex);
 	return 0;
 }
 
diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index d9796851335e..440d800d9f4d 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -112,39 +112,50 @@ static int create_map(struct test_info *ti, char *filename, struct map **map_p)
 	return TEST_OK;
 }
 
+struct test_dso_args {
+	struct symbol *last_sym;
+	int ret;
+};
+
+static int test_dso_cb(struct symbol *sym, void *data)
+{
+	struct test_dso_args *args = data;
+	struct symbol *last_sym = args->last_sym;
+
+	if (symbol__type(sym) != STT_FUNC && symbol__type(sym) != STT_GNU_IFUNC)
+		return 0;
+
+	/* Check for overlapping function symbols */
+	if (last_sym && symbol__start(sym) < symbol__end(last_sym)) {
+		pr_debug("Overlapping symbols:\n");
+		symbol__fprintf(last_sym, stderr);
+		symbol__fprintf(sym, stderr);
+		args->ret = TEST_FAIL;
+	}
+	/* Check for zero-length function symbol */
+	if (symbol__start(sym) == symbol__end(sym)) {
+		pr_debug("Zero-length symbol:\n");
+		symbol__fprintf(sym, stderr);
+		args->ret = TEST_FAIL;
+	}
+	args->last_sym = sym;
+	return 0;
+}
+
 static int test_dso(struct dso *dso)
 {
-	struct symbol *last_sym = NULL;
-	struct rb_node *nd;
-	int ret = TEST_OK;
+	struct test_dso_args args = {
+		.last_sym = NULL,
+		.ret = TEST_OK,
+	};
 
 	/* dso__fprintf() prints all the symbols */
 	if (verbose > 1)
 		dso__fprintf(dso, stderr);
 
-	for (nd = rb_first_cached(dso__symbols(dso)); nd; nd = rb_next(nd)) {
-		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
+	dso__for_each_symbol(dso, test_dso_cb, &args);
 
-		if (symbol__type(sym) != STT_FUNC && symbol__type(sym) != STT_GNU_IFUNC)
-			continue;
-
-		/* Check for overlapping function symbols */
-		if (last_sym && symbol__start(sym) < symbol__end(last_sym)) {
-			pr_debug("Overlapping symbols:\n");
-			symbol__fprintf(last_sym, stderr);
-			symbol__fprintf(sym, stderr);
-			ret = TEST_FAIL;
-		}
-		/* Check for zero-length function symbol */
-		if (symbol__start(sym) == symbol__end(sym)) {
-			pr_debug("Zero-length symbol:\n");
-			symbol__fprintf(sym, stderr);
-			ret = TEST_FAIL;
-		}
-		last_sym = sym;
-	}
-
-	return ret;
+	return args.ret;
 }
 
 static int subdivided_dso_cb(struct dso *dso, struct machine *machine __maybe_unused, void *d)
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 97950f86ed5f..98c2a9437ba7 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -113,6 +113,7 @@ static bool is_ignored_symbol(const char *name, char type)
 struct test__vmlinux_matches_kallsyms_cb_args {
 	struct machine kallsyms;
 	struct map *vmlinux_map;
+	int err;
 	bool header_printed;
 };
 
@@ -185,16 +186,103 @@ static int test__vmlinux_matches_kallsyms_cb3(struct map *map, void *data)
 	return 0;
 }
 
+static int test__vmlinux_matches_kallsyms_sym_cb(struct symbol *sym, void *data)
+{
+	struct test__vmlinux_matches_kallsyms_cb_args *args = data;
+	/*
+	 * Step 4:
+	 *
+	 * kallsyms will be internally on demand sorted by name so that we can
+	 * find the reference relocation * symbol, i.e. the symbol we will use
+	 * to see if the running kernel was relocated by checking if it has the
+	 * same value in the vmlinux file we load.
+	 */
+	struct map *kallsyms_map = machine__kernel_map(&args->kallsyms);
+	struct symbol *pair, *first_pair;
+	u64 mem_start, mem_end;
+
+	if (symbol__start(sym) == symbol__end(sym))
+		return 0;
+
+	mem_start = map__unmap_ip(args->vmlinux_map, symbol__start(sym));
+	mem_end = map__unmap_ip(args->vmlinux_map, symbol__end(sym));
+
+	first_pair = machine__find_kernel_symbol(&args->kallsyms, mem_start, NULL);
+	pair = first_pair;
+
+	if (pair && UM(symbol__start(pair)) == mem_start) {
+next_pair:
+		if (arch__compare_symbol_names(symbol__name(sym),
+					       symbol__name(pair)) == 0) {
+			/*
+			 * kallsyms don't have the symbol end, so we
+			 * set that by using the next symbol start - 1,
+			 * in some cases we get this up to a page
+			 * wrong, trace_kmalloc when I was developing
+			 * this code was one such example, 2106 bytes
+			 * off the real size. More than that and we
+			 * _really_ have a problem.
+			 */
+			s64 skew = mem_end - UM(symbol__end(pair));
+
+			if (llabs(skew) >= page_size)
+				pr_debug("WARN: %#" PRIx64 ": diff end addr for %s v: %#" PRIx64 " k: %#" PRIx64 "\n",
+					 mem_start, symbol__name(sym),
+					 mem_end,
+					 UM(symbol__end(pair)));
+
+			/*
+			 * Do not count this as a failure, because we
+			 * could really find a case where it's not
+			 * possible to get proper function end from
+			 * kallsyms.
+			 */
+			return 0;
+		} else {
+			pair = machine__find_kernel_symbol_by_name(&args->kallsyms,
+								   symbol__name(sym),
+								   NULL);
+			if (pair) {
+				if (UM(symbol__start(pair)) == mem_start)
+					goto next_pair;
+
+				pr_debug("WARN: %#" PRIx64 ": diff name v: %s k: %s\n",
+					 mem_start, symbol__name(sym),
+					 symbol__name(pair));
+			} else {
+				pr_debug("WARN: %#" PRIx64 ": diff name v: %s k: %s\n",
+					 mem_start, symbol__name(sym),
+					 symbol__name(first_pair));
+			}
+
+			return 0;
+		}
+	} else if (mem_start == map__end(args->kallsyms.vmlinux_map)) {
+		/*
+		 * Ignore aliases to _etext, i.e. to the end of the kernel text area,
+		 * such as __indirect_thunk_end.
+		 */
+		return 0;
+	} else if (is_ignored_symbol(symbol__name(sym), symbol__type(sym))) {
+		/*
+		 * Ignore hidden symbols, see scripts/kallsyms.c for the details
+		 */
+		return 0;
+	} else {
+		pr_debug("ERR : %#" PRIx64 ": %s not on kallsyms\n",
+			 mem_start, symbol__name(sym));
+	}
+
+	args->err = -1;
+	return 0;
+}
+
 static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused,
 					int subtest __maybe_unused)
 {
 	int err = TEST_FAIL;
-	struct rb_node *nd;
-	struct symbol *sym;
-	struct map *kallsyms_map;
 	struct machine vmlinux = { 0 };
 	struct maps *maps;
-	u64 mem_start, mem_end;
 	struct test__vmlinux_matches_kallsyms_cb_args args;
 
 	/*
@@ -240,16 +328,6 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 		goto out;
 	}
 
-	/*
-	 * Step 4:
-	 *
-	 * kallsyms will be internally on demand sorted by name so that we can
-	 * find the reference relocation * symbol, i.e. the symbol we will use
-	 * to see if the running kernel was relocated by checking if it has the
-	 * same value in the vmlinux file we load.
-	 */
-	kallsyms_map = machine__kernel_map(&args.kallsyms);
-
 	/*
 	 * Step 5:
 	 *
@@ -279,7 +357,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 		goto out;
 	}
 
-	err = 0;
+	args.err = 0;
 	/*
 	 * Step 7:
 	 *
@@ -287,85 +365,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	 * in the kallsyms dso. For the ones that are in both, check its names and
 	 * end addresses too.
 	 */
-	map__for_each_symbol(args.vmlinux_map, sym, nd) {
-		struct symbol *pair, *first_pair;
-
-		sym  = rb_entry(nd, struct symbol, rb_node);
-
-		if (symbol__start(sym) == symbol__end(sym))
-			continue;
-
-		mem_start = map__unmap_ip(args.vmlinux_map,
-					  symbol__start(sym));
-		mem_end = map__unmap_ip(args.vmlinux_map, symbol__end(sym));
-
-		first_pair = machine__find_kernel_symbol(&args.kallsyms, mem_start, NULL);
-		pair = first_pair;
-
-		if (pair && UM(symbol__start(pair)) == mem_start) {
-next_pair:
-			if (arch__compare_symbol_names(symbol__name(sym),
-						       symbol__name(pair)) == 0) {
-				/*
-				 * kallsyms don't have the symbol end, so we
-				 * set that by using the next symbol start - 1,
-				 * in some cases we get this up to a page
-				 * wrong, trace_kmalloc when I was developing
-				 * this code was one such example, 2106 bytes
-				 * off the real size. More than that and we
-				 * _really_ have a problem.
-				 */
-				s64 skew = mem_end - UM(symbol__end(pair));
-				if (llabs(skew) >= page_size)
-					pr_debug("WARN: %#" PRIx64 ": diff end addr for %s v: %#" PRIx64 " k: %#" PRIx64 "\n",
-						 mem_start, symbol__name(sym),
-						 mem_end,
-						 UM(symbol__end(pair)));
-
-				/*
-				 * Do not count this as a failure, because we
-				 * could really find a case where it's not
-				 * possible to get proper function end from
-				 * kallsyms.
-				 */
-				continue;
-			} else {
-				pair = machine__find_kernel_symbol_by_name(&args.kallsyms,
-									   symbol__name(sym),
-									   NULL);
-				if (pair) {
-					if (UM(symbol__start(pair)) == mem_start)
-						goto next_pair;
-
-					pr_debug("WARN: %#" PRIx64 ": diff name v: %s k: %s\n",
-						 mem_start, symbol__name(sym),
-						 symbol__name(pair));
-				} else {
-					pr_debug("WARN: %#" PRIx64 ": diff name v: %s k: %s\n",
-						 mem_start, symbol__name(sym),
-						 symbol__name(first_pair));
-				}
-
-				continue;
-			}
-		} else if (mem_start == map__end(args.kallsyms.vmlinux_map)) {
-			/*
-			 * Ignore aliases to _etext, i.e. to the end of the kernel text area,
-			 * such as __indirect_thunk_end.
-			 */
-			continue;
-		} else if (is_ignored_symbol(symbol__name(sym), symbol__type(sym))) {
-			/*
-			 * Ignore hidden symbols, see scripts/kallsyms.c for the details
-			 */
-			continue;
-		} else {
-			pr_debug("ERR : %#" PRIx64 ": %s not on kallsyms\n",
-				 mem_start, symbol__name(sym));
-		}
-
-		err = -1;
-	}
+	map__for_each_symbol(args.vmlinux_map, test__vmlinux_matches_kallsyms_sym_cb, &args);
+	err = args.err;
 
 	if (verbose <= 0)
 		goto out;
diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index 38e123d45a1f..bb35d4965a3a 100644
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
@@ -57,17 +57,16 @@ static int map_browser__search(struct map_browser *browser)
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
@@ -110,27 +109,48 @@ static int map_browser__run(struct map_browser *browser)
 
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
-		if (maxaddr < symbol__end(pos))
-			maxaddr = symbol__end(pos);
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
+				if (maxaddr < symbol__end(pos))
+					maxaddr = symbol__end(pos);
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
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index f4aee90b43a3..c7bca2acf938 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2713,61 +2713,96 @@ static bool dso_sym_match(struct symbol *sym, const char *name, int *cnt,
 		idx < 0);
 }
 
+struct print_duplicate_syms_args {
+	const char *sym_name;
+	bool near;
+	int cnt;
+};
+
+static int print_duplicate_syms_cb(struct symbol *sym, void *data)
+{
+	struct print_duplicate_syms_args *args = data;
+
+	if (dso_sym_match(sym, args->sym_name, &args->cnt, -1)) {
+		pr_err("#%d\t0x%"PRIx64"\t%c\t%s\n",
+		       ++args->cnt, symbol__start(sym),
+		       symbol__binding(sym) == STB_GLOBAL ? 'g' :
+		       symbol__binding(sym) == STB_LOCAL  ? 'l' : 'w',
+		       symbol__name(sym));
+		args->near = true;
+	} else if (args->near) {
+		args->near = false;
+		pr_err("\t\twhich is near\t\t%s\n", symbol__name(sym));
+	}
+	return 0;
+}
+
 static void print_duplicate_syms(struct dso *dso, const char *sym_name)
 {
-	struct symbol *sym;
-	bool near = false;
-	int cnt = 0;
+	struct print_duplicate_syms_args args = {
+		.sym_name = sym_name,
+		.near = false,
+		.cnt = 0,
+	};
 
 	pr_err("Multiple symbols with name '%s'\n", sym_name);
 
-	sym = dso__first_symbol(dso);
-	while (sym) {
-		if (dso_sym_match(sym, sym_name, &cnt, -1)) {
-			pr_err("#%d\t0x%"PRIx64"\t%c\t%s\n",
-			       ++cnt, symbol__start(sym),
-			       symbol__binding(sym) == STB_GLOBAL ? 'g' :
-			       symbol__binding(sym) == STB_LOCAL  ? 'l' : 'w',
-			       symbol__name(sym));
-			near = true;
-		} else if (near) {
-			near = false;
-			pr_err("\t\twhich is near\t\t%s\n", symbol__name(sym));
-		}
-		sym = dso__next_symbol(sym);
-	}
+	dso__for_each_symbol(dso, print_duplicate_syms_cb, &args);
 
 	pr_err("Disambiguate symbol name by inserting #n after the name e.g. %s #2\n",
 	       sym_name);
 	pr_err("Or select a global symbol by inserting #0 or #g or #G\n");
 }
 
+struct find_dso_sym_args {
+	const char *sym_name;
+	u64 *start;
+	u64 *size;
+	int idx;
+	int cnt;
+	bool duplicate;
+};
+
+static int find_dso_sym_cb(struct symbol *sym, void *data)
+{
+	struct find_dso_sym_args *args = data;
+
+	if (*args->start) {
+		if (!*args->size)
+			*args->size = symbol__start(sym) - *args->start;
+		if (args->idx > 0) {
+			if (*args->size)
+				return 1;
+		} else if (dso_sym_match(sym, args->sym_name, &args->cnt, args->idx)) {
+			args->duplicate = true;
+			return 1;
+		}
+	} else if (dso_sym_match(sym, args->sym_name, &args->cnt, args->idx)) {
+		*args->start = symbol__start(sym);
+		*args->size = symbol__end(sym) - symbol__start(sym);
+	}
+	return 0;
+}
+
 static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
 			u64 *size, int idx)
 {
-	struct symbol *sym;
-	int cnt = 0;
+	struct find_dso_sym_args args = {
+		.sym_name = sym_name,
+		.start = start,
+		.size = size,
+		.idx = idx,
+		.cnt = 0,
+		.duplicate = false,
+	};
 
 	*start = 0;
 	*size = 0;
 
-	sym = dso__first_symbol(dso);
-	while (sym) {
-		if (*start) {
-			if (!*size)
-				*size = symbol__start(sym) - *start;
-			if (idx > 0) {
-				if (*size)
-					return 0;
-			} else if (dso_sym_match(sym, sym_name, &cnt, idx)) {
-				print_duplicate_syms(dso, sym_name);
-				return -EINVAL;
-			}
-		} else if (dso_sym_match(sym, sym_name, &cnt, idx)) {
-			*start = symbol__start(sym);
-			*size = symbol__end(sym) - symbol__start(sym);
-		}
-		sym = dso__next_symbol(sym);
+	dso__for_each_symbol(dso, find_dso_sym_cb, &args);
+	if (args.duplicate) {
+		print_duplicate_syms(dso, sym_name);
+		return -EINVAL;
 	}
 
 	if (!*start)
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 39cb82693596..1b96853164be 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1687,12 +1687,7 @@ bool dso__loaded(const struct dso *dso)
 
 bool dso__sorted_by_name(const struct dso *dso)
 {
-	return RC_CHK_ACCESS(dso)->sorted_by_name;
-}
-
-void dso__set_sorted_by_name(struct dso *dso)
-{
-	RC_CHK_ACCESS(dso)->sorted_by_name = true;
+	return RC_CHK_ACCESS(dso)->symbols.sorted_by_name;
 }
 
 struct dso *dso__new_id(const char *name, const struct dso_id *id)
@@ -1710,9 +1705,7 @@ struct dso *dso__new_id(const char *name, const struct dso_id *id)
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
@@ -1724,7 +1717,6 @@ struct dso *dso__new_id(const char *name, const struct dso_id *id)
 		dso->is_64_bit = (sizeof(void *) == 8);
 		dso->loaded = 0;
 		dso->rel = 0;
-		dso->sorted_by_name = 0;
 		dso->has_srcline = 1;
 		dso->a2l_fails = 1;
 		dso->kernel = DSO_SPACE__USER;
@@ -1758,9 +1750,7 @@ void dso__delete(struct dso *dso)
 	/* free inlines first, as they reference symbols */
 	inlines__tree_delete(&RC_CHK_ACCESS(dso)->inlined_nodes);
 	srcline__tree_delete(&RC_CHK_ACCESS(dso)->srclines);
-	symbols__delete(&RC_CHK_ACCESS(dso)->symbols);
-	RC_CHK_ACCESS(dso)->symbol_names_len = 0;
-	zfree(&RC_CHK_ACCESS(dso)->symbol_names);
+	symbols__exit(&RC_CHK_ACCESS(dso)->symbols);
 	annotated_data_type__tree_delete(dso__data_types(dso));
 	global_var_type__tree_delete(dso__global_vars(dso));
 
@@ -1883,22 +1873,34 @@ static size_t dso__fprintf_buildid(struct dso *dso, FILE *fp)
 	return fprintf(fp, "%s", sbuild_id);
 }
 
+struct dso__fprintf_cb_args {
+	FILE *fp;
+	size_t ret;
+};
+
+static int dso__fprintf_cb(struct symbol *pos, void *data)
+{
+	struct dso__fprintf_cb_args *args = data;
+
+	args->ret += symbol__fprintf(pos, args->fp);
+	return 0;
+}
+
 size_t dso__fprintf(struct dso *dso, FILE *fp)
 {
-	struct rb_node *nd;
-	size_t ret = fprintf(fp, "dso: %s (", dso__short_name(dso));
+	struct dso__fprintf_cb_args args = {
+		.fp = fp,
+		.ret = fprintf(fp, "dso: %s (", dso__short_name(dso)),
+	};
 
 	if (dso__short_name(dso) != dso__long_name(dso))
-		ret += fprintf(fp, "%s, ", dso__long_name(dso));
-	ret += fprintf(fp, "%sloaded, ", dso__loaded(dso) ? "" : "NOT ");
-	ret += dso__fprintf_buildid(dso, fp);
-	ret += fprintf(fp, ")\n");
-	for (nd = rb_first_cached(dso__symbols(dso)); nd; nd = rb_next(nd)) {
-		struct symbol *pos = rb_entry(nd, struct symbol, rb_node);
-		ret += symbol__fprintf(pos, fp);
-	}
+		args.ret += fprintf(fp, "%s, ", dso__long_name(dso));
+	args.ret += fprintf(fp, "%sloaded, ", dso__loaded(dso) ? "" : "NOT ");
+	args.ret += dso__fprintf_buildid(dso, fp);
+	args.ret += fprintf(fp, ")\n");
+	dso__for_each_symbol(dso, dso__fprintf_cb, &args);
 
-	return ret;
+	return args.ret;
 }
 
 enum dso_type dso__type(struct dso *dso, struct machine *machine)
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index e7d5f4bbf894..1de446966f01 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -13,6 +13,7 @@
 #include "build-id.h"
 #include "debuginfo.h"
 #include "mutex.h"
+#include "symbol.h"
 #include <internal/rc_check.h>
 
 struct machine;
@@ -287,18 +288,12 @@ struct auxtrace_cache;
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
@@ -343,7 +338,6 @@ DECLARE_RC_STRUCT(dso) {
 	u8		 short_name_allocated:1;
 	u8		 long_name_allocated:1;
 	u8		 is_64_bit:1;
-	bool		 sorted_by_name;
 	bool		 loaded;
 	u8		 rel;
 	char		 name[];
@@ -357,11 +351,11 @@ int dso_id__cmp(const struct dso_id *a, const struct dso_id *b);
 /* dso__for_each_symbol - iterate over the symbols of given type
  *
  * @dso: the 'struct dso *' in which symbols are iterated
- * @pos: the 'struct symbol *' to use as a loop cursor
- * @n: the 'struct rb_node *' to use as a temporary storage
+ * @cb: callback function invoked for each symbol
+ * @data: opaque data pointer passed to @cb
  */
-#define dso__for_each_symbol(dso, pos, n)	\
-	symbols__for_each_entry(dso__symbols(dso), pos, n)
+#define dso__for_each_symbol(dso, cb, data)	\
+	symbols__for_each_entry(dso__symbols(dso), cb, data)
 
 static inline void *dso__a2l(const struct dso *dso)
 {
@@ -590,26 +584,6 @@ static inline void dso__set_kernel(struct dso *dso, enum dso_space_type kernel)
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
@@ -722,29 +696,19 @@ static inline struct rb_root *dso__global_vars(struct dso *dso)
 	return &RC_CHK_ACCESS(dso)->global_vars;
 }
 
-static inline struct rb_root_cached *dso__symbols(struct dso *dso)
+static inline struct symbols *dso__symbols(struct dso *dso)
 {
 	return &RC_CHK_ACCESS(dso)->symbols;
 }
 
 static inline struct symbol **dso__symbol_names(struct dso *dso)
 {
-	return RC_CHK_ACCESS(dso)->symbol_names;
-}
-
-static inline void dso__set_symbol_names(struct dso *dso, struct symbol **names)
-{
-	RC_CHK_ACCESS(dso)->symbol_names = names;
+	return RC_CHK_ACCESS(dso)->symbols.symbols_by_name;
 }
 
 static inline size_t dso__symbol_names_len(struct dso *dso)
 {
-	return RC_CHK_ACCESS(dso)->symbol_names_len;
-}
-
-static inline void dso__set_symbol_names_len(struct dso *dso, size_t len)
-{
-	RC_CHK_ACCESS(dso)->symbol_names_len = len;
+	return RC_CHK_ACCESS(dso)->symbols.num_by_name;
 }
 
 static inline const char *dso__symsrc_filename(const struct dso *dso)
@@ -815,13 +779,12 @@ bool dso__loaded(const struct dso *dso);
 
 static inline bool dso__has_symbols(const struct dso *dso)
 {
-	return !RB_EMPTY_ROOT(&RC_CHK_ACCESS(dso)->symbols.rb_root);
+	return RC_CHK_ACCESS(dso)->symbols.cnt > 0;
 }
 
 char *dso__filename_with_chroot(const struct dso *dso, const char *filename);
 
 bool dso__sorted_by_name(const struct dso *dso);
-void dso__set_sorted_by_name(struct dso *dso);
 void dso__sort_by_name(struct dso *dso);
 
 int dso__swap_init(struct dso *dso, unsigned char eidata);
@@ -941,8 +904,6 @@ struct map *dso__new_map(const char *name);
 struct dso *machine__findnew_kernel(struct machine *machine, const char *name,
 				    const char *short_name, int dso_type);
 
-void dso__reset_find_symbol_cache(struct dso *dso);
-
 size_t dso__fprintf_symbols_by_name(struct dso *dso, FILE *fp);
 size_t dso__fprintf(struct dso *dso, FILE *fp);
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index a9f43ac8d152..2e64b3faabc9 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2981,13 +2981,37 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 	return 0;
 }
 
+struct intel_pt_switch_ip_args {
+	struct map *map;
+	const char *name;
+	bool check_global;
+	u64 ip;
+};
+
+static int intel_pt_switch_ip_cb(struct symbol *sym, void *data)
+{
+	struct intel_pt_switch_ip_args *args = data;
+	u64 ip;
+
+	if (args->check_global && symbol__binding(sym) != STB_GLOBAL)
+		return 0;
+
+	if (!strcmp(symbol__name(sym), args->name)) {
+		ip = map__unmap_ip(args->map, symbol__start(sym));
+		if (ip >= map__start(args->map) && ip < map__end(args->map)) {
+			args->ip = ip;
+			return 1;
+		}
+	}
+	return 0;
+}
+
 static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
 {
 	struct machine *machine = pt->machine;
 	struct map *map;
-	struct symbol *sym, *start;
-	u64 ip, switch_ip = 0;
-	const char *ptss;
+	struct intel_pt_switch_ip_args args;
+	u64 switch_ip = 0;
 
 	if (ptss_ip)
 		*ptss_ip = 0;
@@ -2999,36 +3023,28 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
 	if (map__load(map))
 		return 0;
 
-	start = dso__first_symbol(map__dso(map));
-
-	for (sym = start; sym; sym = dso__next_symbol(sym)) {
-		if (symbol__binding(sym) == STB_GLOBAL &&
-		    !strcmp(symbol__name(sym), "__switch_to")) {
-			ip = map__unmap_ip(map, symbol__start(sym));
-			if (ip >= map__start(map) && ip < map__end(map)) {
-				switch_ip = ip;
-				break;
-			}
-		}
-	}
+	args = (struct intel_pt_switch_ip_args) {
+		.map = map,
+		.name = "__switch_to",
+		.check_global = true,
+		.ip = 0,
+	};
+	map__for_each_symbol(map, intel_pt_switch_ip_cb, &args);
+	switch_ip = args.ip;
 
 	if (!switch_ip || !ptss_ip)
 		return 0;
 
-	if (pt->have_sched_switch == 1)
-		ptss = "perf_trace_sched_switch";
-	else
-		ptss = "__perf_event_task_sched_out";
-
-	for (sym = start; sym; sym = dso__next_symbol(sym)) {
-		if (!strcmp(symbol__name(sym), ptss)) {
-			ip = map__unmap_ip(map, symbol__start(sym));
-			if (ip >= map__start(map) && ip < map__end(map)) {
-				*ptss_ip = ip;
-				break;
-			}
-		}
-	}
+	args = (struct intel_pt_switch_ip_args) {
+		.map = map,
+		.name = pt->have_sched_switch == 1 ?
+			"perf_trace_sched_switch" :
+			"__perf_event_task_sched_out",
+		.check_global = false,
+		.ip = 0,
+	};
+	map__for_each_symbol(map, intel_pt_switch_ip_cb, &args);
+	*ptss_ip = args.ip;
 
 	return switch_ip;
 }
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index fa2bd8e0e1f1..cb30d858f62d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1095,29 +1095,35 @@ int machine__create_extra_kernel_map(struct machine *machine,
 	return err;
 }
 
-static u64 find_entry_trampoline(struct dso *dso)
+static int find_entry_trampoline_cb(struct symbol *sym, void *data)
 {
 	/* Duplicates are removed so lookup all aliases */
-	const char *syms[] = {
+	static const char * const syms[] = {
 		"_entry_trampoline",
 		"__entry_trampoline_start",
 		"entry_SYSCALL_64_trampoline",
 	};
-	struct symbol *sym = dso__first_symbol(dso);
-	unsigned int i;
+	u64 *addr = data;
 
-	for (; sym; sym = dso__next_symbol(sym)) {
-		if (symbol__binding(sym) != STB_GLOBAL)
-			continue;
-		for (i = 0; i < ARRAY_SIZE(syms); i++) {
-			if (!strcmp(symbol__name(sym), syms[i]))
-				return symbol__start(sym);
+	if (symbol__binding(sym) != STB_GLOBAL)
+		return 0;
+	for (unsigned int i = 0; i < ARRAY_SIZE(syms); i++) {
+		if (!strcmp(symbol__name(sym), syms[i])) {
+			*addr = symbol__start(sym);
+			return 1;
 		}
 	}
-
 	return 0;
 }
 
+static u64 find_entry_trampoline(struct dso *dso)
+{
+	u64 addr = 0;
+
+	dso__for_each_symbol(dso, find_entry_trampoline_cb, &addr);
+	return addr;
+}
+
 /*
  * These values can be used for kernels that do not have symbols for the entry
  * trampolines in kallsyms.
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 85216fa71f1a..19afe676adf2 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -314,27 +314,22 @@ void map__put(struct map *map)
 
 void map__fixup_start(struct map *map)
 {
-	struct dso *dso = map__dso(map);
-	struct rb_root_cached *symbols = dso__symbols(dso);
-	struct rb_node *nd = rb_first_cached(symbols);
-
-	if (nd != NULL) {
-		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
+	struct symbols *symbols = dso__symbols(map__dso(map));
 
-		map__set_start(map, symbol__start(sym));
-	}
+	symbols__sort_read_lock(symbols);
+	if (symbols->cnt > 0)
+		map__set_start(map, symbol__start(symbols->symbols[0]));
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
-		map__set_end(map, symbol__end(sym));
-	}
+	symbols__sort_read_lock(symbols);
+	if (symbols->cnt > 0)
+		map__set_end(map, symbol__end(symbols->symbols[symbols->cnt - 1]));
+	up_read(&symbols->lock);
 }
 
 #define DSO__DELETED "(deleted)"
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index f49b4aaacf2f..3d8f72e70d49 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -146,12 +146,12 @@ struct thread;
 /* map__for_each_symbol - iterate over the symbols in the given map
  *
  * @map: the 'struct map *' in which symbols are iterated
- * @pos: the 'struct symbol *' to use as a loop cursor
- * @n: the 'struct rb_node *' to use as a temporary storage
+ * @cb: callback function invoked for each symbol
+ * @data: opaque data pointer passed to @cb
  * Note: caller must ensure map->dso is not NULL (map is loaded).
  */
-#define map__for_each_symbol(map, pos, n)	\
-	dso__for_each_symbol(map__dso(map), pos, n)
+#define map__for_each_symbol(map, cb, data)	\
+	dso__for_each_symbol(map__dso(map), cb, data)
 
 /* map__for_each_symbol_with_name - iterate over the symbols in the given map
  *                                  that have the given name
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 128076a4b92d..47dbe865c2f9 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -3047,49 +3047,63 @@ static int __add_probe_trace_events(struct perf_probe_event *pev,
 	return ret;
 }
 
-static int find_probe_functions(struct map *map, char *name,
-				struct symbol **syms)
+struct find_probe_functions_args {
+	const char *name;
+	struct symbol **syms;
+	int found;
+	bool cut_version;
+};
+
+static int find_probe_functions_cb(struct symbol *sym, void *data)
 {
-	int found = 0;
-	struct symbol *sym;
-	struct rb_node *tmp;
+	struct find_probe_functions_args *args = data;
 	const char *norm, *ver;
 	char *buf = NULL;
-	bool cut_version = true;
-
-	if (map__load(map) < 0)
-		return -EACCES;	/* Possible permission error to load symbols */
 
-	/* If user gives a version, don't cut off the version from symbols */
-	if (strchr(name, '@'))
-		cut_version = false;
-
-	map__for_each_symbol(map, sym, tmp) {
-		norm = arch__normalize_symbol_name(symbol__name(sym));
-		if (!norm)
-			continue;
+	norm = arch__normalize_symbol_name(symbol__name(sym));
+	if (!norm)
+		return 0;
 
-		if (cut_version) {
-			/* We don't care about default symbol or not */
-			ver = strchr(norm, '@');
-			if (ver) {
-				buf = strndup(norm, ver - norm);
-				if (!buf)
-					return -ENOMEM;
-				norm = buf;
-			}
+	if (args->cut_version) {
+		/* We don't care about default symbol or not */
+		ver = strchr(norm, '@');
+		if (ver) {
+			buf = strndup(norm, ver - norm);
+			if (!buf)
+				return -ENOMEM;
+			norm = buf;
 		}
+	}
 
-		if (strglobmatch(norm, name)) {
-			found++;
-			if (syms && found < probe_conf.max_probes)
-				syms[found - 1] = sym;
-		}
-		if (buf)
-			zfree(&buf);
+	if (strglobmatch(norm, args->name)) {
+		args->found++;
+		if (args->syms && args->found < probe_conf.max_probes)
+			args->syms[args->found - 1] = sym;
 	}
+	free(buf);
+	return 0;
+}
+
+static int find_probe_functions(struct map *map, char *name,
+				struct symbol **syms)
+{
+	struct find_probe_functions_args args = {
+		.name = name,
+		.syms = syms,
+		/* If user gives a version, don't cut off the version from symbols */
+		.cut_version = strchr(name, '@') == NULL,
+		.found = 0,
+	};
+	int ret;
+
+	if (map__load(map) < 0)
+		return -EACCES;	/* Possible permission error to load symbols */
+
+	ret = map__for_each_symbol(map, find_probe_functions_cb, &args);
+	if (ret < 0)
+		return ret;
 
-	return found;
+	return args.found;
 }
 
 void __weak arch__fix_tev_from_maps(struct perf_probe_event *pev __maybe_unused,
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 2ec650a7834d..d25d8c96ee66 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -213,57 +213,157 @@ static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
 	return arch__choose_best_symbol(syma, symb);
 }
 
-void symbols__fixup_duplicate(struct rb_root_cached *symbols)
+void symbols__init(struct symbols *symbols)
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
+static inline bool symbol__less_or_equal(const struct symbol *a, const struct symbol *b)
+{
+	if (symbol__start(a) != symbol__start(b))
+		return symbol__start(a) < symbol__start(b);
+	return symbol__end(a) <= symbol__end(b);
+}
+
+static int symbols__sort_cmp(const void *vlhs, const void *vrhs)
+{
+	const struct symbol *lhs = *((const struct symbol **)vlhs);
+	const struct symbol *rhs = *((const struct symbol **)vrhs);
+
+	if (symbol__start(lhs) != symbol__start(rhs))
+		return symbol__start(lhs) < symbol__start(rhs) ? -1 : 1;
+	if (symbol__end(lhs) != symbol__end(rhs))
+		return symbol__end(lhs) < symbol__end(rhs) ? -1 : 1;
+	return 0;
+}
+
+static void symbols__sort_locked(struct symbols *symbols)
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
+	NO_THREAD_SAFETY_ANALYSIS
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
-		if (symbol__start(curr) != symbol__start(next))
+		if (symbol__start(curr) != symbol__start(next)) {
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
 
-	for (nd = rb_next(prevnd); nd; nd = rb_next(nd)) {
+	for (unsigned int i = 1; i < symbols->cnt; i++) {
 		prev = curr;
-		curr = rb_entry(nd, struct symbol, rb_node);
+		curr = symbols->symbols[i];
 
 		/*
 		 * On some architecture kernel text segment start is located at
@@ -314,6 +414,8 @@ void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms)
 	if (symbol__end(curr) == symbol__start(curr))
 		symbol__set_end(curr,
 				roundup(symbol__start(curr), 4096) + 4096);
+
+	up_write(&symbols->lock);
 }
 
 struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name)
@@ -395,97 +497,92 @@ static void symbol__set_idle(struct symbol *sym, bool idle)
 		new_flags |= (idle_val << SYMBOL_FLAG_IDLE_SHIFT);
 	} while (!atomic_compare_exchange_weak(&sym->flags, &old_flags, new_flags));
 }
-void symbols__delete(struct rb_root_cached *symbols)
-{
-	struct symbol *pos;
-	struct rb_node *next = rb_first_cached(symbols);
 
-	while (next) {
-		pos = rb_entry(next, struct symbol, rb_node);
-		next = rb_next(&pos->rb_node);
-		rb_erase_cached(&pos->rb_node, symbols);
-		symbol__delete(pos);
-	}
-}
-
-void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
+int __symbols__insert(struct symbols *symbols, struct symbol *sym)
 {
-	struct rb_node **p = &symbols->rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	const u64 ip = symbol__start(sym);
-	struct symbol *s;
-	bool leftmost = true;
+	if (symbols->cnt == symbols->allocated) {
+		unsigned int to_allocate = symbols->allocated ? symbols->allocated * 2 : 32;
+		struct symbol **temp = realloc(symbols->symbols,
+					       sizeof(struct symbol *) * to_allocate);
 
-	while (*p != NULL) {
-		parent = *p;
-		s = rb_entry(parent, struct symbol, rb_node);
-		if (ip < symbol__start(s))
-			p = &(*p)->rb_left;
-		else {
-			p = &(*p)->rb_right;
-			leftmost = false;
+		if (!temp) {
+			symbol__delete(sym);
+			return -ENOMEM;
 		}
+		symbols->symbols = temp;
+		symbols->allocated = to_allocate;
 	}
-	rb_link_node(&sym->rb_node, parent, p);
-	rb_insert_color_cached(&sym->rb_node, symbols, leftmost);
+
+	if (symbols->sorted && symbols->cnt > 0 &&
+	    !symbol__less_or_equal(symbols->symbols[symbols->cnt - 1], sym))
+		symbols->sorted = false;
+
+	symbols->symbols[symbols->cnt++] = sym;
+	symbols->sorted_by_name = false;
+	return 0;
 }
 
-void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
+int symbols__insert(struct symbols *symbols, struct symbol *sym)
 {
-	__symbols__insert(symbols, sym);
+	int ret;
+
+	down_write(&symbols->lock);
+	ret = __symbols__insert(symbols, sym);
+	up_write(&symbols->lock);
+	return ret;
 }
 
-static struct symbol *symbols__find(struct rb_root_cached *symbols, u64 ip)
+/*
+ * Binary search @symbols->symbols for a symbol covering @ip. Lazily sorts
+ * @symbols under @symbols->lock if unsorted.
+ */
+static struct symbol *symbols__find(struct symbols *symbols, u64 ip)
 {
-	struct rb_node *n;
+	int low, high;
+	struct symbol *res = NULL;
 
 	if (symbols == NULL)
 		return NULL;
 
-	n = symbols->rb_root.rb_node;
+	symbols__sort_read_lock(symbols);
 
-	while (n) {
-		struct symbol *s = rb_entry(n, struct symbol, rb_node);
+	low = 0;
+	high = (int)symbols->cnt - 1;
+	while (low <= high) {
+		int mid = low + (high - low) / 2;
+		struct symbol *s = symbols->symbols[mid];
+		u64 start = symbol__start(s);
+		u64 end = symbol__end(s);
 
-		if (ip < symbol__start(s))
-			n = n->rb_left;
-		else if (ip > symbol__end(s) || (ip == symbol__end(s) && ip != symbol__start(s)))
-			n = n->rb_right;
-		else
-			return s;
+		if (ip < start)
+			high = mid - 1;
+		else if (ip > end || (ip == end && ip != start))
+			low = mid + 1;
+		else {
+			res = s;
+			break;
+		}
 	}
+	up_read(&symbols->lock);
 
-	return NULL;
-}
-
-static struct symbol *symbols__first(struct rb_root_cached *symbols)
-{
-	struct rb_node *n = rb_first_cached(symbols);
-
-	if (n)
-		return rb_entry(n, struct symbol, rb_node);
-
-	return NULL;
+	return res;
 }
 
-static struct symbol *symbols__last(struct rb_root_cached *symbols)
+int symbols__for_each_entry(struct symbols *symbols,
+			    int (*cb)(struct symbol *sym, void *data),
+			    void *data)
 {
-	struct rb_node *n = rb_last(&symbols->rb_root);
-
-	if (n)
-		return rb_entry(n, struct symbol, rb_node);
-
-	return NULL;
-}
-
-static struct symbol *symbols__next(struct symbol *sym)
-{
-	struct rb_node *n = rb_next(&sym->rb_node);
+	int err = 0;
 
-	if (n)
-		return rb_entry(n, struct symbol, rb_node);
+	symbols__sort_read_lock(symbols);
+	for (unsigned int i = 0; i < symbols->cnt; i++) {
+		err = cb(symbols->symbols[i], data);
+		if (err)
+			break;
+	}
+	up_read(&symbols->lock);
 
-	return NULL;
+	return err;
 }
 
 static int symbols__sort_name_cmp(const void *vlhs, const void *vrhs)
@@ -496,27 +593,31 @@ static int symbols__sort_name_cmp(const void *vlhs, const void *vrhs)
 	return strcmp(symbol__name(lhs), symbol__name(rhs));
 }
 
-static struct symbol **symbols__sort_by_name(struct rb_root_cached *source, size_t *len)
+static void symbols__sort_by_name_locked(struct symbols *symbols)
 {
-	struct rb_node *nd;
 	struct symbol **result;
-	size_t i = 0, size = 0;
+	unsigned int size = symbols->cnt;
 
-	for (nd = rb_first_cached(source); nd; nd = rb_next(nd))
-		size++;
+	if (symbols->sorted_by_name)
+		return;
+
+	zfree(&symbols->symbols_by_name);
+	symbols->num_by_name = 0;
+
+	if (size == 0) {
+		symbols->sorted_by_name = true;
+		return;
+	}
 
 	result = malloc(sizeof(*result) * size);
 	if (!result)
-		return NULL;
-
-	for (nd = rb_first_cached(source); nd; nd = rb_next(nd)) {
-		struct symbol *pos = rb_entry(nd, struct symbol, rb_node);
+		return;
 
-		result[i++] = pos;
-	}
+	memcpy(result, symbols->symbols, sizeof(*result) * size);
 	qsort(result, size, sizeof(*result), symbols__sort_name_cmp);
-	*len = size;
-	return result;
+	symbols->symbols_by_name = result;
+	symbols->num_by_name = size;
+	symbols->sorted_by_name = true;
 }
 
 int symbol__match_symbol_name(const char *name, const char *str,
@@ -586,39 +687,34 @@ static struct symbol *symbols__find_by_name(struct symbol *symbols[],
 	return s;
 }
 
-void dso__reset_find_symbol_cache(struct dso *dso)
+int dso__insert_symbol(struct dso *dso, struct symbol *sym)
 {
-	dso__set_last_find_result_addr(dso, 0);
-	dso__set_last_find_result_symbol(dso, NULL);
-}
-
-void dso__insert_symbol(struct dso *dso, struct symbol *sym)
-{
-	__symbols__insert(dso__symbols(dso), sym);
-
-	/* update the symbol cache if necessary */
-	if (dso__last_find_result_addr(dso) >= symbol__start(sym) &&
-	    (dso__last_find_result_addr(dso) < symbol__end(sym) ||
-	     symbol__start(sym) == symbol__end(sym))) {
-		dso__set_last_find_result_symbol(dso, sym);
-	}
+	return symbols__insert(dso__symbols(dso), sym);
 }
 
 void dso__delete_symbol(struct dso *dso, struct symbol *sym)
 {
-	rb_erase_cached(&sym->rb_node, dso__symbols(dso));
-	symbol__delete(sym);
-	dso__reset_find_symbol_cache(dso);
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
+	}
+	up_write(&symbols->lock);
 }
 
 struct symbol *dso__find_symbol(struct dso *dso, u64 addr)
 {
-	if (dso__last_find_result_addr(dso) != addr || dso__last_find_result_symbol(dso) == NULL) {
-		dso__set_last_find_result_addr(dso, addr);
-		dso__set_last_find_result_symbol(dso, symbols__find(dso__symbols(dso), addr));
-	}
-
-	return dso__last_find_result_symbol(dso);
+	return symbols__find(dso__symbols(dso), addr);
 }
 
 struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr)
@@ -626,21 +722,6 @@ struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr)
 	return symbols__find(dso__symbols(dso), addr);
 }
 
-struct symbol *dso__first_symbol(struct dso *dso)
-{
-	return symbols__first(dso__symbols(dso));
-}
-
-struct symbol *dso__last_symbol(struct dso *dso)
-{
-	return symbols__last(dso__symbols(dso));
-}
-
-struct symbol *dso__next_symbol(struct symbol *sym)
-{
-	return symbols__next(sym);
-}
-
 struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx)
 {
 	if (*idx + 1 >= dso__symbol_names_len(dso))
@@ -655,9 +736,12 @@ struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx)
   */
 struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_t *idx)
 {
-	struct symbol *s = symbols__find_by_name(dso__symbol_names(dso),
-						 dso__symbol_names_len(dso),
-						 name, SYMBOL_TAG_INCLUDE__NONE, idx);
+	struct symbol *s;
+
+	dso__sort_by_name(dso);
+	s = symbols__find_by_name(dso__symbol_names(dso),
+				  dso__symbol_names_len(dso),
+				  name, SYMBOL_TAG_INCLUDE__NONE, idx);
 	if (!s) {
 		s = symbols__find_by_name(dso__symbol_names(dso), dso__symbol_names_len(dso),
 					  name, SYMBOL_TAG_INCLUDE__DEFAULT_ONLY, idx);
@@ -667,17 +751,17 @@ struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_
 
 void dso__sort_by_name(struct dso *dso)
 {
-	mutex_lock(dso__lock(dso));
-	if (!dso__sorted_by_name(dso)) {
-		size_t len = 0;
+	struct symbols *symbols = dso__symbols(dso);
 
-		dso__set_symbol_names(dso, symbols__sort_by_name(dso__symbols(dso), &len));
-		if (dso__symbol_names(dso)) {
-			dso__set_symbol_names_len(dso, len);
-			dso__set_sorted_by_name(dso);
-		}
+	down_read(&symbols->lock);
+	if (!symbols->sorted_by_name) {
+		up_read(&symbols->lock);
+		down_write(&symbols->lock);
+		symbols__sort_by_name_locked(symbols);
+		up_write(&symbols->lock);
+		return;
 	}
-	mutex_unlock(dso__lock(dso));
+	up_read(&symbols->lock);
 }
 
 /*
@@ -877,7 +961,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 {
 	struct symbol *sym;
 	struct dso *dso = arg;
-	struct rb_root_cached *root = dso__symbols(dso);
+	struct symbols *root = dso__symbols(dso);
 
 	if (!symbol_type__filter(type))
 		return 0;
@@ -898,9 +982,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	 * We will pass the symbols to the filter later, in
 	 * map__split_kallsyms, when we have split the maps per module
 	 */
-	__symbols__insert(root, sym);
-
-	return 0;
+	return __symbols__insert(root, sym);
 }
 
 /*
@@ -917,25 +999,32 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
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
 		module = strchr((char *)symbol__name(pos), '\t');
 		if (module)
 			*module = '\0';
@@ -955,11 +1044,13 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 			symbol__set_end(pos, symbol__end(pos) -
 					(map__start(curr_map) - map__pgoff(curr_map)));
 		}
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
 
@@ -995,8 +1086,8 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	struct map *curr_map = map__get(initial_map);
 	struct symbol *pos;
 	int count = 0, moved = 0;
-	struct rb_root_cached *root = dso__symbols(dso);
-	struct rb_node *next = rb_first_cached(root);
+	struct symbols *root = dso__symbols(dso);
+	unsigned int i, write_idx = 0;
 	int kernel_range = 0;
 	uint16_t e_machine = EM_NONE;
 
@@ -1006,11 +1097,13 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	machine = maps__machine(kmaps);
 	e_machine = machine_or_dso_e_machine(machine, dso);
 
-	while (next) {
+	down_write(&root->lock);
+	symbols__sort_locked(root);
+
+	for (i = 0; i < root->cnt; i++) {
 		char *module;
 
-		pos = rb_entry(next, struct symbol, rb_node);
-		next = rb_next(&pos->rb_node);
+		pos = root->symbols[i];
 
 		module = strchr((char *)symbol__name(pos), '\t');
 		if (module) {
@@ -1098,7 +1191,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			ndso = dso__new(dso_name);
 			map__zput(curr_map);
 			if (ndso == NULL)
-				return -1;
+				goto out_err;
 
 			dso__set_kernel(ndso, dso__kernel(dso));
 			dso__set_loaded(ndso);
@@ -1106,14 +1199,14 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			curr_map = map__new2(symbol__start(pos), ndso);
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
@@ -1126,18 +1219,24 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		if (!RC_CHK_EQUAL(curr_map, initial_map)) {
 			struct dso *curr_map_dso = map__dso(curr_map);
 
-			rb_erase_cached(&pos->rb_node, root);
-			symbols__insert(dso__symbols(curr_map_dso), pos);
-			++moved;
-		} else
+			if (symbols__insert(dso__symbols(curr_map_dso), pos) == 0)
+				++moved;
+		} else {
+			root->symbols[write_idx++] = pos;
 			++count;
+		}
 
 		continue;
 discard_symbol:
-		rb_erase_cached(&pos->rb_node, root);
 		symbol__delete(pos);
 	}
 
+	root->cnt = write_idx;
+	zfree(&root->symbols_by_name);
+	root->num_by_name = 0;
+	root->sorted_by_name = false;
+	up_write(&root->lock);
+
 	if (!RC_CHK_EQUAL(curr_map, initial_map) &&
 	    dso__kernel(dso) == DSO_SPACE__KERNEL_GUEST &&
 	    machine__is_default_guest(maps__machine(kmaps))) {
@@ -1145,6 +1244,16 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	}
 	map__put(curr_map);
 	return count + moved;
+
+out_err:
+	memmove(&root->symbols[write_idx], &root->symbols[i],
+		(root->cnt - i) * sizeof(struct symbol *));
+	root->cnt = write_idx + (root->cnt - i);
+	zfree(&root->symbols_by_name);
+	root->num_by_name = 0;
+	root->sorted_by_name = false;
+	up_write(&root->lock);
+	return -1;
 }
 
 bool symbol__restricted_filename(const char *filename,
@@ -1705,7 +1814,8 @@ static int dso__load_perf_map(const char *map_path, struct dso *dso)
 		if (sym == NULL)
 			goto out_delete_line;
 
-		symbols__insert(dso__symbols(dso), sym);
+		if (symbols__insert(dso__symbols(dso), sym))
+			goto out_delete_line;
 		nr_syms++;
 	}
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 100a7da07834..52cd6b43696c 100644
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
@@ -93,7 +94,6 @@ enum symbol_idle_kind {
  * A symtab entry.
  */
 struct symbol {
-	struct rb_node	rb_node;
 	/** Range of symbol [start, end). */
 	u64		start;
 	u64		end;
@@ -106,8 +106,42 @@ struct symbol {
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
+	struct symbol **symbols;
+	/**
+	 * @symbols_by_name: Optional dynamically allocated array of symbol
+	 * pointers sorted lexicographically by symbol__name().
+	 */
+	struct symbol **symbols_by_name;
+	/** @cnt: Number of valid entries in @symbols. */
+	unsigned int cnt;
+	/** @allocated: Capacity (in entries) of the @symbols allocation. */
+	unsigned int allocated;
+	/** @num_by_name: Number of valid entries in @symbols_by_name. */
+	unsigned int num_by_name;
+	/** @sorted: True when @symbols is sorted by address range. */
+	bool sorted;
+	/**
+	 * @sorted_by_name: True when @symbols_by_name is populated and sorted
+	 * by name.
+	 */
+	bool sorted_by_name;
+};
+
 void symbol__delete(struct symbol *sym);
-void symbols__delete(struct rb_root_cached *symbols);
+void symbols__init(struct symbols *symbols);
+void symbols__exit(struct symbols *symbols);
+void symbols__delete(struct symbols *symbols);
+void symbols__sort_read_lock(struct symbols *symbols) SHARED_LOCK_FUNCTION(symbols->lock);
 
 static inline u64 symbol__start(const struct symbol *sym)
 {
@@ -199,16 +233,16 @@ void symbol__set_inlined(struct symbol *sym, bool inlined);
 void symbol__set_ifunc_alias(struct symbol *sym, bool ifunc_alias);
 void symbol__set_annotated(struct symbol *sym, bool annotated);
 
-/* symbols__for_each_entry - iterate over symbols (rb_root)
+/*
+ * symbols__for_each_entry - iterate over symbols calling @cb for each entry
  *
- * @symbols: the rb_root of symbols
- * @pos: the 'struct symbol *' to use as a loop cursor
- * @nd: the 'struct rb_node *' to use as a temporary storage
+ * @symbols: the 'struct symbols *' of symbols
+ * @cb: callback function invoked under @symbols->lock
+ * @data: opaque data pointer passed to @cb
  */
-#define symbols__for_each_entry(symbols, pos, nd)			\
-	for (nd = rb_first_cached(symbols);					\
-	     nd && (pos = rb_entry(nd, struct symbol, rb_node));	\
-	     nd = rb_next(nd))
+int symbols__for_each_entry(struct symbols *symbols,
+			    int (*cb)(struct symbol *sym, void *data),
+			    void *data);
 
 static inline size_t symbol__size(const struct symbol *sym)
 {
@@ -245,8 +279,8 @@ int __dso__load_kallsyms(struct dso *dso, const char *filename, struct map *map,
 			 bool no_kcore);
 int dso__load_kallsyms(struct dso *dso, const char *filename, struct map *map);
 
-void dso__insert_symbol(struct dso *dso,
-			struct symbol *sym);
+int dso__insert_symbol(struct dso *dso,
+		       struct symbol *sym);
 void dso__delete_symbol(struct dso *dso,
 			struct symbol *sym);
 
@@ -256,10 +290,6 @@ struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr);
 struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx);
 struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_t *idx);
 
-struct symbol *dso__first_symbol(struct dso *dso);
-struct symbol *dso__last_symbol(struct dso *dso);
-struct symbol *dso__next_symbol(struct symbol *sym);
-
 enum dso_type dso__type_fd(int fd);
 
 int filename__read_build_id(const char *filename, struct build_id *id);
@@ -310,10 +340,10 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
 
 char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
 
-void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
-void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
-void symbols__fixup_duplicate(struct rb_root_cached *symbols);
-void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms);
+int __symbols__insert(struct symbols *symbols, struct symbol *sym);
+int symbols__insert(struct symbols *symbols, struct symbol *sym);
+void symbols__fixup_duplicate(struct symbols *symbols);
+void symbols__fixup_end(struct symbols *symbols, bool is_kallsyms);
 
 typedef int (*mapfn_t)(u64 start, u64 len, u64 pgoff, void *data);
 int file__read_maps(int fd, bool exe, mapfn_t mapfn, void *data,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

