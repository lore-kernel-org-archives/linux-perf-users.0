Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245446;
	b=UKWvSdINUONmEx0DJ/XxidrMG4akouap225i2Z1RTQ/btL9o+uQ5vIbM0tRi7M4aqdlH
	 p6yToCPmjFo24eB2FDXLYxPryadpsTZRVKVR8EfnxVg1x6P2QrI79zDKWO5jKfaK9Q+x9
	 kVL27kiJfNYsmLGkPq4rgFwkUSPkMY6E0GLtNQVWj173HreAAPNx9UDKlToipzLIiwnoX
	 7QeNooxjWzaCt0F+LAw/9j6+UpuT70sjugtjSBjNzaBWhLHe/9OHMg6di1aIiFZS3leCu
	 K5NZiOh2D35FXZaDIjxhsPe8iuWbmzlZCXH/MFp1HiNXWUms4wKrtxebFfFendHouGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=LInqi4dxkfEPk4z2pnlbtUvtYpO2/YfmAPE79tBUOJo=;
	b=zL5OUpFDisDdPl7obPJ07I7yINZRA45y0vfTYHMr8AzpRGSx/aTnEuXZTIlLvn3wQk5G
	 eWDgWXu/eThJQJrNDnHwl0FBXVYXKq+ztCJOR0RKGo7vrAprv3reBqsPqFe52OYhaebaP
	 BzTEspQrKJVHNcJNIPn8Pm5lp43nRq9MjBgDrRWZ18rG3+tl71OfNxhJzmhIQGj/kv40g
	 ZkKYkbjEhrvQ039kyzckRRouKTuxlqrm5jCRJZH6fQlOzysi++qT7ixWBJEcsZ69NwGZL
	 a1WyWj7RLJU8PPdGpbs7mVATvN1vFqxJkLGEQqtduuVnsKJ9U/ILaI9l+9fWUivNvkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VAWUrcSl;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89524606A32A
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 07:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89524606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VAWUrcSl
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1a5005fd0f8so3150856c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 23:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795245445; x=1795850245; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LInqi4dxkfEPk4z2pnlbtUvtYpO2/YfmAPE79tBUOJo=;
        b=VAWUrcSl9FFjzRe+ufJXpAtv6QcqEw9JQGE75hAP9ooOeFD4I3YMJOAxcJbksC2kB2
         I/wxY6pk5DvaC9oFc+mnxtCYgMZxCxQV7tijU1u3Z9bZ28iRgRaOoOIdHpn3mv9dVqA7
         zWfYaAiIwutS/Z4Bjp15qjd3naVbSgehUeRPPusnXb/WWt6JdwF8pOzkcMBFfH0GUGQp
         aDkj8Sgsj3mEjqv8IZhuwsIf/HL1n+oc78nY+2Kej9UCXktF1QRHhYa9i+SL5EcQmkiI
         /ZfxyLkMYErCLrS86PqyjKq+Ba++JChr1WmazDnCDAc28V1TA3QTPvWeC5l4pp6CDvZ+
         8pkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795245445; x=1795850245;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LInqi4dxkfEPk4z2pnlbtUvtYpO2/YfmAPE79tBUOJo=;
        b=txeDCwTuU3DI8F+WD/FcE/+3HI/tu7zzYClnLOHTp8KL5qM9SCTPzYM+xoIUulEf7Y
         JaKsUZFQA0cAbP1GIUKdyVcR+5i73ujzKuHqvCknlZqckbHu9u7awB7HiQ+Ctub6aWaQ
         CjTNfbKZ2Rky+ksokzRwnOvESYitnLng0e/uUTkv9jll8u40hw5X2v6On9KtVlVOf782
         0esq/YL9IYQwNtNAStDr7cTOn18ld7vuW4e0aQAfO9FjQB1wJVUYG6DDy4AO+cwBXQCJ
         Hb4gtaVhTtPVhU0yRaWZ3p3n69asDt4jla9e/w+NA7/vF0o0Nd4kqArInhUz1j8uNwyl
         0aQw==
X-Forwarded-Encrypted: i=1; AL+hErHitpbgM2S3rFOrUXZkd5MAjq0MryWRjSeTHQENugPoTcvtNhO/gu4B+o5grZWGVQWtRNmMRFcP3jdJT7vt4TlO@vger.kernel.org
X-Gm-Message-State: APuU4Z+1WqPqlsiibnAUaeRfrz5NEKg1GJ6qfcaMHcLOcjDYIrfGgNpc
	ebpPxRVA1pLXkpQXcdsX+m4oNOXquffUGwr0L74RkZx7bpiyJ/8PmPPHnska/DOfFyOhZmvQyei
	Z/TjH0pWKJA==
X-Received: from dloo22-n1.prod.google.com ([2002:a05:7023:a56:10b0:1a1:7dc7:2c24])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2096:10b0:151:2e62:fe5b
 with SMTP id a92af1059eb24-1b5568eb642mr6096531c88.22.1795245444329; Fri, 20
 Nov 2026 23:17:24 -0800 (PST)
Date: Fri, 20 Nov 2026 23:16:44 -0800
In-Reply-To: <20261121071651.67118-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121071651.67118-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121071651.67118-4-irogers@google.com>
Subject: [PATCH v7 03/10] perf symbol: Convert map__for_each_symbol() to
 callback-based iteration
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently symbols__for_each_entry(), dso__for_each_symbol(), and
map__for_each_symbol() are macros that expose struct rb_node * cursors to
callers and perform unlocked rb_first_cached() / rb_next() walks.

To prepare for replacing the unprotected symbol rbtree with a locked
symbol array, replace symbols__for_each_entry() with a callback-based
symbols__visit() helper and convert dso__for_each_symbol() and
map__for_each_symbol() to callback-based iteration matching
dsos__for_each_dso() and maps__for_each_map(), updating the existing
map__for_each_symbol() callers.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c |  34 ++--
 tools/perf/builtin-kmem.c                   |  52 +++---
 tools/perf/tests/vmlinux-kallsyms.c         | 181 ++++++++++----------
 tools/perf/util/dso.h                       |   8 +-
 tools/perf/util/map.h                       |   8 +-
 tools/perf/util/probe-event.c               |  82 +++++----
 tools/perf/util/symbol.c                    |  19 ++
 tools/perf/util/symbol.h                    |  16 +-
 8 files changed, 228 insertions(+), 172 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 947bfad7aa59..f87d77262c00 100644
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
+	if (map__unmap_ip(args->map, sym->start) == args->tev->point.address) {
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
-			if (map__unmap_ip(map, sym->start) == tev->point.address) {
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
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 1404b523a785..87869c717266 100644
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
+	if (regexec(alloc_func_regex, sym->name, 0, NULL, 0))
+		return 0;
+
+	func = realloc(alloc_func_list,
+		       (nr_alloc_funcs + 1) * sizeof(*func));
+	if (func == NULL)
+		return -ENOMEM;
+
+	pr_debug("alloc func: %s\n", sym->name);
+	func[nr_alloc_funcs].start = sym->start;
+	func[nr_alloc_funcs].end   = sym->end;
+	func[nr_alloc_funcs].name  = sym->name;
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
@@ -368,29 +388,13 @@ static int build_alloc_func_list(void)
 		return -ENOENT;
 	}
 
-	map__for_each_symbol(kernel_map, sym, node) {
-		if (regexec(&alloc_func_regex, sym->name, 0, NULL, 0))
-			continue;
-
-		func = realloc(alloc_func_list,
-			       (nr_alloc_funcs + 1) * sizeof(*func));
-		if (func == NULL) {
-			regfree(&alloc_func_regex);
-			return -ENOMEM;
-		}
-
-		pr_debug("alloc func: %s\n", sym->name);
-		func[nr_alloc_funcs].start = sym->start;
-		func[nr_alloc_funcs].end   = sym->end;
-		func[nr_alloc_funcs].name  = sym->name;
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
 
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 9396c8a77c86..38f5c9584e15 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -113,6 +113,7 @@ static bool is_ignored_symbol(const char *name, char type)
 struct test__vmlinux_matches_kallsyms_cb_args {
 	struct machine kallsyms;
 	struct map *vmlinux_map;
+	int err;
 	bool header_printed;
 };
 
@@ -185,16 +186,101 @@ static int test__vmlinux_matches_kallsyms_cb3(struct map *map, void *data)
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
+	if (sym->start == sym->end)
+		return 0;
+
+	mem_start = map__unmap_ip(args->vmlinux_map, sym->start);
+	mem_end = map__unmap_ip(args->vmlinux_map, sym->end);
+
+	first_pair = machine__find_kernel_symbol(&args->kallsyms, mem_start, NULL);
+	pair = first_pair;
+
+	if (pair && UM(pair->start) == mem_start) {
+next_pair:
+		if (arch__compare_symbol_names(sym->name, pair->name) == 0) {
+			/*
+			 * kallsyms don't have the symbol end, so we
+			 * set that by using the next symbol start - 1,
+			 * in some cases we get this up to a page
+			 * wrong, trace_kmalloc when I was developing
+			 * this code was one such example, 2106 bytes
+			 * off the real size. More than that and we
+			 * _really_ have a problem.
+			 */
+			s64 skew = mem_end - UM(pair->end);
+
+			if (llabs(skew) >= page_size) {
+				pr_debug("WARN: %#" PRIx64 ": diff end addr for %s v: %#"
+					 PRIx64 " k: %#" PRIx64 "\n",
+					 mem_start, sym->name, mem_end,
+					 UM(pair->end));
+			}
+
+			/*
+			 * Do not count this as a failure, because we
+			 * could really find a case where it's not
+			 * possible to get proper function end from
+			 * kallsyms.
+			 */
+			return 0;
+		}
+		pair = machine__find_kernel_symbol_by_name(&args->kallsyms,
+							   sym->name, NULL);
+		if (pair) {
+			if (UM(pair->start) == mem_start)
+				goto next_pair;
+
+			pr_debug("WARN: %#" PRIx64 ": diff name v: %s k: %s\n",
+				 mem_start, sym->name, pair->name);
+		} else {
+			pr_debug("WARN: %#" PRIx64 ": diff name v: %s k: %s\n",
+				 mem_start, sym->name, first_pair->name);
+		}
+
+		return 0;
+	}
+
+	if (mem_start == map__end(args->kallsyms.vmlinux_map)) {
+		/*
+		 * Ignore aliases to _etext, i.e. to the end of the kernel text area,
+		 * such as __indirect_thunk_end.
+		 */
+		return 0;
+	}
+	if (is_ignored_symbol(sym->name, symbol__type(sym))) {
+		/*
+		 * Ignore hidden symbols, see scripts/kallsyms.c for the details
+		 */
+		return 0;
+	}
+	pr_debug("ERR : %#" PRIx64 ": %s not on kallsyms\n",
+		 mem_start, sym->name);
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
@@ -240,16 +326,6 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
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
@@ -279,7 +355,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 		goto out;
 	}
 
-	err = 0;
+	args.err = 0;
 	/*
 	 * Step 7:
 	 *
@@ -287,79 +363,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	 * in the kallsyms dso. For the ones that are in both, check its names and
 	 * end addresses too.
 	 */
-	map__for_each_symbol(args.vmlinux_map, sym, nd) {
-		struct symbol *pair, *first_pair;
-
-		sym  = rb_entry(nd, struct symbol, rb_node);
-
-		if (sym->start == sym->end)
-			continue;
-
-		mem_start = map__unmap_ip(args.vmlinux_map, sym->start);
-		mem_end = map__unmap_ip(args.vmlinux_map, sym->end);
-
-		first_pair = machine__find_kernel_symbol(&args.kallsyms, mem_start, NULL);
-		pair = first_pair;
-
-		if (pair && UM(pair->start) == mem_start) {
-next_pair:
-			if (arch__compare_symbol_names(sym->name, pair->name) == 0) {
-				/*
-				 * kallsyms don't have the symbol end, so we
-				 * set that by using the next symbol start - 1,
-				 * in some cases we get this up to a page
-				 * wrong, trace_kmalloc when I was developing
-				 * this code was one such example, 2106 bytes
-				 * off the real size. More than that and we
-				 * _really_ have a problem.
-				 */
-				s64 skew = mem_end - UM(pair->end);
-				if (llabs(skew) >= page_size)
-					pr_debug("WARN: %#" PRIx64 ": diff end addr for %s v: %#" PRIx64 " k: %#" PRIx64 "\n",
-						 mem_start, sym->name, mem_end,
-						 UM(pair->end));
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
-									   sym->name, NULL);
-				if (pair) {
-					if (UM(pair->start) == mem_start)
-						goto next_pair;
-
-					pr_debug("WARN: %#" PRIx64 ": diff name v: %s k: %s\n",
-						 mem_start, sym->name, pair->name);
-				} else {
-					pr_debug("WARN: %#" PRIx64 ": diff name v: %s k: %s\n",
-						 mem_start, sym->name, first_pair->name);
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
-		} else if (is_ignored_symbol(sym->name, symbol__type(sym))) {
-			/*
-			 * Ignore hidden symbols, see scripts/kallsyms.c for the details
-			 */
-			continue;
-		} else {
-			pr_debug("ERR : %#" PRIx64 ": %s not on kallsyms\n",
-				 mem_start, sym->name);
-		}
-
-		err = -1;
-	}
+	map__for_each_symbol(args.vmlinux_map, test__vmlinux_matches_kallsyms_sym_cb, &args);
+	err = args.err;
 
 	if (verbose <= 0)
 		goto out;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index d5f7382d4e13..532ad3ec156f 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -365,11 +365,11 @@ int dso_id__cmp(const struct dso_id *a, const struct dso_id *b);
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
+	symbols__visit(dso__symbols(dso), cb, data)
 
 static inline void *dso__a2l(const struct dso *dso)
 {
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index c2e31be232c8..32f1fd9a7404 100644
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
index 1534280c0c1d..3d506c09b749 100644
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
-		norm = arch__normalize_symbol_name(sym->name);
-		if (!norm)
-			continue;
+	norm = arch__normalize_symbol_name(sym->name);
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
index a1ac1cd1d2e7..1f7faae5a357 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -613,6 +613,25 @@ struct symbol *dso__find_symbol(struct dso *dso, u64 addr)
 	return dso__last_find_result_symbol(dso);
 }
 
+int symbols__visit(struct rb_root_cached *symbols,
+		   int (*cb)(struct symbol *sym, void *data),
+		   void *data)
+{
+	struct rb_node *nd;
+
+	if (!symbols)
+		return 0;
+
+	for (nd = rb_first_cached(symbols); nd; nd = rb_next(nd)) {
+		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
+		int ret = cb(sym, data);
+
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr)
 {
 	return symbols__find(dso__symbols(dso), addr);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index a6a2ab200f98..5a105b10a089 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -141,16 +141,16 @@ void symbol__set_annotate2(struct symbol *sym, bool annotate2);
 void symbol__set_inlined(struct symbol *sym, bool inlined);
 void symbol__set_ifunc_alias(struct symbol *sym, bool ifunc_alias);
 
-/* symbols__for_each_entry - iterate over symbols (rb_root)
+/*
+ * symbols__visit - iterate over symbols calling @cb for each entry
  *
- * @symbols: the rb_root of symbols
- * @pos: the 'struct symbol *' to use as a loop cursor
- * @nd: the 'struct rb_node *' to use as a temporary storage
+ * @symbols: the rb_root_cached of symbols
+ * @cb: callback function invoked for each symbol
+ * @data: opaque data pointer passed to @cb
  */
-#define symbols__for_each_entry(symbols, pos, nd)			\
-	for (nd = rb_first_cached(symbols);					\
-	     nd && (pos = rb_entry(nd, struct symbol, rb_node));	\
-	     nd = rb_next(nd))
+int symbols__visit(struct rb_root_cached *symbols,
+		   int (*cb)(struct symbol *sym, void *data),
+		   void *data);
 
 static inline size_t symbol__size(const struct symbol *sym)
 {
-- 
2.56.1.750.gf70dc682cf-goog

