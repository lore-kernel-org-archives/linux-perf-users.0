Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8928C455623
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581980; cv=none; b=ZPqt+GFPLEBm+ZNqYVRnQK6aj6REk0hPkSqHS7nugvpdXfTx/Xm5/SoiBOfFk0nb10w2NU7rq7CIS2J2llbWCwPRTjW2wgrBliJ/Q4zRBlvC8nB3QdONwBBGA0qzgtJMFDSn2NvTYbR8u9oB6xyux5R4eG0TgyvaUULf2HdPAjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581980; c=relaxed/simple;
	bh=D/zQ+6bcQJKEoF5fEWiOM3jKhfl2GLnVzVS7mTKMS7I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rQib1VTLoCdoi0HXB/3ZEzxRXNNDNx7sTLkFEXjlpkf/kuSVJeSTYbujUdjwjsVwvwTXfZl0bx0wTfspQZZ5V5GsHZoHPqoo6/iRM7El3wVyj3xnKZoKm42RXINgskS73aegxKpCCoGrPXcLkVkwOli2WtkpgTC0NkQ+HReTYu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ObqMnb4y; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ObqMnb4y"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-139b62317d0so11580339c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 00:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790581973; x=1791186773; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HsXH/l8ZxTxEnpPBAs19LBiz7Rqp4UIR2tBHhAZ4nTQ=;
        b=ObqMnb4ygDWKnj/RjCsRF3RJhOX+W5FDUZ3sUr0L6sgjXohIyW/UFv2eu8UNexXQfX
         0uoaK1VB5dlJWoE3VPhg++4x88urvm6s24OKRUk0m9NlJS1dAnAudxvcnNQeVapozU3C
         MCJro2OlYoCM3ctmN0PNkJA5GnreIzJGBp5W6eqqGhIvuGxGxnZDkIpd3CDyHKEmU/LM
         StbTDJzi5HVrtrk1o+Z4nSFdlY6QWCdP5LgdiXFkX1NRyLEtA5EXebEr/8E3tPbZRWAa
         8PuoQbKQWNDclVMJ38aF9gwo/ngx7lymqpeaiXPW7bT2a8DDzRR5Po+v/jTnbfTtAgoj
         qAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581973; x=1791186773;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HsXH/l8ZxTxEnpPBAs19LBiz7Rqp4UIR2tBHhAZ4nTQ=;
        b=nEdLOz+sjFTebeFgE5l5sDyqkmkZlI55WEN+CB5bbLEHMfpcnR0V2urhAJ0/TmHJW2
         AEa+TQI6QjhyV2A5BAkW4En5Z1pgv5azLWU+u4IblHXYtZIe0PoVghbM/DWG2MybcICX
         5lNkI2pNFjt7iJwFCZ3clFXZjoDWD3YAiahXSOh/qdYjcd+n4yKOBYbzsXi9kSebFBGK
         QmWEsfZidTeaxGUdlU3VQC1VJEHRz8MXMCpkrxMIa/Xu2WUcdzhcn7BsyRJNG8l2ER7a
         vU77r7aeppEX5LUKFLrW5beJ2FYkNrx8EZ+xxW19QqkkJIp1Mm/IWUBy4sTCJ5evI92T
         CKOA==
X-Forwarded-Encrypted: i=1; AKwUvBzHpencyUZW15yuYIvV1pP9UQcew++vdAW4V83d6Ohpe/eVLUljokl3qwg8L7LhQQAt7tBa3zkfO1gSgI0xikhr@vger.kernel.org
X-Gm-Message-State: AFuF++nZd4mrbUMnCM1wh5QU0vr0Oubw8v+KkyYLtcTXN4nKwwToL27m
	OKdnROrFnjudDKZqThD2917tczWdvgrOi9abJmPg9liqtBu88JJkRmADygGia50BOeLCu6az2QA
	ttMtA2xeJrw==
X-Received: from dlbrn3.prod.google.com ([2002:a05:7022:1503:b0:144:bc91:18ab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:108d:b0:143:862c:8c5e
 with SMTP id a92af1059eb24-146d0b58b91mr8867378c88.43.1790581971688; Mon, 28
 Sep 2026 00:52:51 -0700 (PDT)
Date: Mon, 28 Sep 2026 00:52:31 -0700
In-Reply-To: <20260928075237.3055101-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928075237.3055101-2-irogers@google.com>
Subject: [PATCH v1 1/7] perf symbol: Add accessor functions for struct symbol fields
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alireza Haghdoost <haghdoost@uber.com>
Content-Type: text/plain; charset="UTF-8"

To prepare for adding reference count checking (DECLARE_RC_STRUCT) to
struct symbol, add inline accessor functions for struct symbol fields
(symbol__start, symbol__set_start, symbol__end, symbol__set_end,
symbol__name, symbol__namelen, symbol__arch_sym, symbol__set_arch_sym)
and convert direct member accesses across tools/perf.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/powerpc/util/skip-callchain-idx.c    |   2 +-
 tools/perf/arch/powerpc/util/sym-handling.c   |   8 +-
 tools/perf/builtin-annotate.c                 |   4 +-
 tools/perf/builtin-diff.c                     |   5 +-
 tools/perf/builtin-kallsyms.c                 |   8 +-
 tools/perf/builtin-kmem.c                     |  25 ++--
 tools/perf/builtin-kwork.c                    |   4 +-
 tools/perf/builtin-lock.c                     |  12 +-
 tools/perf/builtin-mem.c                      |   2 +-
 tools/perf/builtin-sched.c                    |   6 +-
 tools/perf/builtin-script.c                   |  14 +--
 tools/perf/builtin-timechart.c                |   2 +-
 tools/perf/builtin-top.c                      |  25 ++--
 tools/perf/builtin-trace.c                    |  11 +-
 tools/perf/tests/dlfilter-test.c              |   4 +-
 tools/perf/tests/dwarf-unwind.c               |   2 +-
 tools/perf/tests/hists_common.c               |   4 +-
 tools/perf/tests/hists_cumulate.c             |   4 +-
 tools/perf/tests/hists_output.c               |   2 +-
 tools/perf/tests/symbols.c                    |   4 +-
 tools/perf/tests/vmlinux-kallsyms.c           |  34 +++---
 tools/perf/ui/browsers/annotate.c             |  11 +-
 tools/perf/ui/browsers/hists.c                |  10 +-
 tools/perf/ui/browsers/map.c                  |   9 +-
 tools/perf/ui/gtk/annotate.c                  |   7 +-
 tools/perf/ui/stdio/hist.c                    |   3 +-
 .../util/annotate-arch/annotate-loongarch.c   |   4 +-
 tools/perf/util/annotate-arch/annotate-x86.c  |  14 +--
 tools/perf/util/annotate-data.c               |  14 ++-
 tools/perf/util/annotate.c                    |  73 +++++++-----
 tools/perf/util/auxtrace.c                    |  14 +--
 tools/perf/util/block-info.c                  |   7 +-
 tools/perf/util/bpf_lock_contention.c         |  20 ++--
 tools/perf/util/c2c-function.c                |  12 +-
 tools/perf/util/callchain.c                   |  15 ++-
 tools/perf/util/capstone.c                    |  20 ++--
 tools/perf/util/data-convert-json.c           |   4 +-
 tools/perf/util/db-export.c                   |   2 +-
 tools/perf/util/debug.c                       |   3 +-
 tools/perf/util/disasm.c                      |  45 ++++----
 tools/perf/util/dlfilter.c                    |  12 +-
 tools/perf/util/dso.c                         |   4 +-
 tools/perf/util/event.c                       |   4 +-
 tools/perf/util/evsel_fprintf.c               |   2 +-
 tools/perf/util/hist.c                        |  17 +--
 tools/perf/util/intel-pt.c                    |   8 +-
 tools/perf/util/libbfd.c                      |   5 +-
 tools/perf/util/llvm.c                        |   6 +-
 tools/perf/util/lock-contention.c             |   2 +-
 tools/perf/util/machine.c                     |  34 +++---
 tools/perf/util/map.c                         |   6 +-
 tools/perf/util/map.h                         |   2 +-
 tools/perf/util/probe-event.c                 |  40 +++----
 tools/perf/util/python.c                      |   8 +-
 .../util/scripting-engines/trace-event-perl.c |   8 +-
 .../scripting-engines/trace-event-python.c    |  28 ++---
 tools/perf/util/sort.c                        |  42 +++----
 tools/perf/util/srcline.c                     |  13 ++-
 tools/perf/util/symbol-elf.c                  |  11 +-
 tools/perf/util/symbol.c                      | 107 ++++++++++--------
 tools/perf/util/symbol.h                      |  42 ++++++-
 tools/perf/util/symbol_fprintf.c              |  14 +--
 tools/perf/util/thread-stack.c                |   8 +-
 tools/perf/util/unwind-libdw.c                |   2 +-
 64 files changed, 504 insertions(+), 390 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index 472714cfad38..ee2dea01c4ea 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -239,7 +239,7 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
 	rc = check_return_addr(dso, map__map_ip(al.map, ip));
 
 	pr_debug("[DSO %s, sym %s, ip 0x%" PRIx64 "] rc %d\n",
-		dso__long_name(dso), al.sym->name, ip, rc);
+		dso__long_name(dso), symbol__name(al.sym), ip, rc);
 
 	if (rc == 0) {
 		/*
diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 947bfad7aa59..d73bfdcdbec1 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -13,7 +13,7 @@
 int arch__choose_best_symbol(struct symbol *syma,
 			     struct symbol *symb __maybe_unused)
 {
-	char *sym = syma->name;
+	const char *sym = symbol__name(syma);
 
 #if !defined(_CALL_ELF) || _CALL_ELF != 2
 	/* Skip over any initial dot */
@@ -69,7 +69,7 @@ const char *arch__normalize_symbol_name(const char *name)
 #ifdef HAVE_LIBELF_SUPPORT
 void arch__sym_update(struct symbol *s, GElf_Sym *sym)
 {
-	s->arch_sym = sym->st_other;
+	symbol__set_arch_sym(s, sym->st_other);
 }
 #endif
 
@@ -102,7 +102,7 @@ void arch__fix_tev_from_maps(struct perf_probe_event *pev,
 			return;
 	}
 
-	lep_offset = PPC64_LOCAL_ENTRY_OFFSET(sym->arch_sym);
+	lep_offset = PPC64_LOCAL_ENTRY_OFFSET(symbol__arch_sym(sym));
 
 	if (map__dso(map)->symtab_type == DSO_BINARY_TYPE__KALLSYMS)
 		tev->point.offset += PPC64LE_LEP_OFFSET;
@@ -131,7 +131,7 @@ void arch__post_process_probe_trace_events(struct perf_probe_event *pev,
 	for (i = 0; i < ntevs; i++) {
 		tev = &pev->tevs[i];
 		map__for_each_symbol(map, sym, tmp) {
-			if (map__unmap_ip(map, sym->start) == tev->point.address) {
+			if (map__unmap_ip(map, symbol__start(sym)) == tev->point.address) {
 				arch__fix_tev_from_maps(pev, tev, map, sym);
 				break;
 			}
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 8863f3a570f6..c93b67986334 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -252,7 +252,7 @@ static int add_sample(struct perf_sample *sample,
 	if ((!ann->has_br_stack || !has_annotation(ann)) &&
 	    ann->sym_hist_filter != NULL &&
 	    (al->sym == NULL ||
-	     strcmp(ann->sym_hist_filter, al->sym->name) != 0)) {
+	     strcmp(ann->sym_hist_filter, symbol__name(al->sym)) != 0)) {
 		/* We're only interested in a symbol named sym_hist_filter */
 		/*
 		 * FIXME: why isn't this done in the symbol_filter when loading
@@ -423,7 +423,7 @@ static void hists__find_annotations(struct hists *hists,
 			goto find_next;
 
 		if (ann->sym_hist_filter &&
-		    (strcmp(he->ms.sym->name, ann->sym_hist_filter) != 0))
+		    (strcmp(symbol__name(he->ms.sym), ann->sym_hist_filter) != 0))
 			goto find_next;
 
 		if (ann->min_percent) {
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 9fa8e900637b..17decf1e19ff 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1358,10 +1358,11 @@ static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
 
 	bi = block_he->block_info;
 
-	start_line = map__srcline(he->ms.map, bi->sym->start + bi->start,
+	start_line = map__srcline(he->ms.map,
+				  symbol__start(bi->sym) + bi->start,
 				  he->ms.sym);
 
-	end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
+	end_line = map__srcline(he->ms.map, symbol__start(bi->sym) + bi->end,
 				he->ms.sym);
 
 	if (start_line != SRCLINE_UNKNOWN &&
diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
index 3c4339982b16..eb62bb4ea602 100644
--- a/tools/perf/builtin-kallsyms.c
+++ b/tools/perf/builtin-kallsyms.c
@@ -48,9 +48,11 @@ static int __cmd_kallsyms(int argc, const char **argv)
 
 		dso = map__dso(map);
 		printf("%s: %s %s %#" PRIx64 "-%#" PRIx64 " (%#" PRIx64 "-%#" PRIx64")\n",
-			symbol->name, dso__short_name(dso), dso__long_name(dso),
-			map__unmap_ip(map, symbol->start), map__unmap_ip(map, symbol->end),
-			symbol->start, symbol->end);
+			symbol__name(symbol), dso__short_name(dso),
+			dso__long_name(dso),
+			map__unmap_ip(map, symbol__start(symbol)),
+			map__unmap_ip(map, symbol__end(symbol)),
+			symbol__start(symbol), symbol__end(symbol));
 	}
 out:
 	machine__delete(machine);
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 8693c6b135ca..d1883086ed58 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -310,7 +310,7 @@ static struct rb_root page_caller_sorted;
 struct alloc_func {
 	u64 start;
 	u64 end;
-	char *name;
+	const char *name;
 };
 
 static int nr_alloc_funcs;
@@ -368,7 +368,7 @@ static int build_alloc_func_list(void)
 	}
 
 	map__for_each_symbol(kernel_map, sym, node) {
-		if (regexec(&alloc_func_regex, sym->name, 0, NULL, 0))
+		if (regexec(&alloc_func_regex, symbol__name(sym), 0, NULL, 0))
 			continue;
 
 		func = realloc(alloc_func_list,
@@ -376,10 +376,10 @@ static int build_alloc_func_list(void)
 		if (func == NULL)
 			return -ENOMEM;
 
-		pr_debug("alloc func: %s\n", sym->name);
-		func[nr_alloc_funcs].start = sym->start;
-		func[nr_alloc_funcs].end   = sym->end;
-		func[nr_alloc_funcs].name  = sym->name;
+		pr_debug("alloc func: %s\n", symbol__name(sym));
+		func[nr_alloc_funcs].start = symbol__start(sym);
+		func[nr_alloc_funcs].end   = symbol__end(sym);
+		func[nr_alloc_funcs].name  = symbol__name(sym);
 
 		alloc_func_list = func;
 		nr_alloc_funcs++;
@@ -1049,8 +1049,9 @@ static void __print_slab_result(struct rb_root *root,
 			addr = data->ptr;
 
 		if (sym != NULL)
-			snprintf(buf, sizeof(buf), "%s+%" PRIx64 "", sym->name,
-				 addr - map__unmap_ip(map, sym->start));
+			snprintf(buf, sizeof(buf), "%s+%" PRIx64 "",
+				 symbol__name(sym),
+				 addr - map__unmap_ip(map, symbol__start(sym)));
 		else
 			snprintf(buf, sizeof(buf), "%#" PRIx64 "", addr);
 		printf(" %-34s |", buf);
@@ -1105,12 +1106,12 @@ static void __print_page_alloc_result(struct perf_session *session, int n_lines)
 		struct symbol *sym;
 		struct map *map;
 		char buf[32];
-		char *caller = buf;
+		const char *caller = buf;
 
 		data = rb_entry(next, struct page_stat, node);
 		sym = machine__find_kernel_symbol(machine, data->callsite, &map);
 		if (sym)
-			caller = sym->name;
+			caller = symbol__name(sym);
 		else
 			scnprintf(buf, sizeof(buf), "%"PRIx64, data->callsite);
 
@@ -1147,12 +1148,12 @@ static void __print_page_caller_result(struct perf_session *session, int n_lines
 		struct symbol *sym;
 		struct map *map;
 		char buf[32];
-		char *caller = buf;
+		const char *caller = buf;
 
 		data = rb_entry(next, struct page_stat, node);
 		sym = machine__find_kernel_symbol(machine, data->callsite, &map);
 		if (sym)
-			caller = sym->name;
+			caller = symbol__name(sym);
 		else
 			scnprintf(buf, sizeof(buf), "%"PRIx64, data->callsite);
 
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index fce588441e49..98714f1ed949 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -768,8 +768,8 @@ static void timehist_save_callchain(struct perf_kwork *kwork,
 
 		sym = node->ms.sym;
 		if (sym) {
-			if (!strcmp(sym->name, "__softirqentry_text_start") ||
-			    !strcmp(sym->name, "__do_softirq"))
+			if (!strcmp(symbol__name(sym), "__softirqentry_text_start") ||
+			    !strcmp(symbol__name(sym), "__do_softirq"))
 				symbol__set_ignore(sym, true);
 		}
 
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index d5c0d55cb82d..cd060c984068 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -826,12 +826,13 @@ static int get_symbol_name_offset(struct map *map, struct symbol *sym, u64 ip,
 		return 0;
 	}
 
-	offset = map__map_ip(map, ip) - sym->start;
+	offset = map__map_ip(map, ip) - symbol__start(sym);
 
 	if (offset)
-		return scnprintf(buf, size, "%s+%#lx", sym->name, offset);
+		return scnprintf(buf, size, "%s+%#lx", symbol__name(sym),
+				 offset);
 	else
-		return strlcpy(buf, sym->name, size);
+		return strlcpy(buf, symbol__name(sym), size);
 }
 static int lock_contention_caller(struct perf_sample *sample,
 				  char *buf, int size)
@@ -1005,7 +1006,8 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
 				return -ENOMEM;
 			}
 
-			addrs[filters.nr_addrs++] = map__unmap_ip(kmap, sym->start);
+			addrs[filters.nr_addrs++] = map__unmap_ip(kmap,
+								  symbol__start(sym));
 			filters.addrs = addrs;
 		}
 	}
@@ -1019,7 +1021,7 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
 		case LOCK_AGGR_ADDR:
 			sym = machine__find_kernel_symbol(machine, key, &kmap);
 			if (sym)
-				name = sym->name;
+				name = symbol__name(sym);
 			break;
 		case LOCK_AGGR_CALLER:
 			name = buf;
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index ade53688ebcd..5a19be73348d 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -249,7 +249,7 @@ dump_raw_samples(const struct perf_tool *tool,
 		sample->data_src,
 		symbol_conf.field_sep,
 		dso ? dso__long_name(dso) : "???",
-		al.sym ? al.sym->name : "???");
+		al.sym ? symbol__name(al.sym) : "???");
 out_put:
 	addr_location__exit(&al);
 	return 0;
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 6e8bf619c86c..e53098b532b4 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2629,9 +2629,9 @@ static void save_task_callchain(struct perf_sched *sched,
 
 		sym = node->ms.sym;
 		if (sym) {
-			if (!strcmp(sym->name, "schedule") ||
-			    !strcmp(sym->name, "__schedule") ||
-			    !strcmp(sym->name, "preempt_schedule"))
+			if (!strcmp(symbol__name(sym), "schedule") ||
+			    !strcmp(symbol__name(sym), "__schedule") ||
+			    !strcmp(symbol__name(sym), "preempt_schedule"))
 				symbol__set_ignore(sym, true);
 		}
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 565ee8d55f80..f1257a78d975 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1404,7 +1404,7 @@ static int ip__fprintf_sym(uint64_t addr, struct thread *thread,
 	addr_location__init(&al);
 	thread__find_map(thread, cpumode, addr, &al);
 
-	if ((*lastsym) && al.addr >= (*lastsym)->start && al.addr < (*lastsym)->end)
+	if ((*lastsym) && al.addr >= symbol__start((*lastsym)) && al.addr < symbol__end((*lastsym)))
 		goto out;
 
 	al.cpu = cpu;
@@ -1415,11 +1415,11 @@ static int ip__fprintf_sym(uint64_t addr, struct thread *thread,
 	if (!al.sym)
 		goto out;
 
-	if (al.addr < al.sym->end)
-		off = al.addr - al.sym->start;
+	if (al.addr < symbol__end(al.sym))
+		off = al.addr - symbol__start(al.sym);
 	else
-		off = al.addr - map__start(al.map) - al.sym->start;
-	printed += fprintf(fp, "\t%s", al.sym->name);
+		off = al.addr - map__start(al.map) - symbol__start(al.sym);
+	printed += fprintf(fp, "\t%s", symbol__name(al.sym));
 	if (off)
 		printed += fprintf(fp, "%+d", off);
 	printed += fprintf(fp, ":");
@@ -1638,7 +1638,7 @@ static const char *resolve_branch_sym(struct perf_sample *sample,
 			if (!addr_al->thread)
 				thread__resolve(thread, addr_al, sample);
 			if (addr_al->sym)
-				name = addr_al->sym->name;
+				name = symbol__name(addr_al->sym);
 			else
 				*ip = sample->addr;
 		} else {
@@ -1646,7 +1646,7 @@ static const char *resolve_branch_sym(struct perf_sample *sample,
 		}
 	} else if (sample->flags & (PERF_IP_FLAG_RETURN | PERF_IP_FLAG_TRACE_END)) {
 		if (al->sym)
-			name = al->sym->name;
+			name = symbol__name(al->sym);
 		else
 			*ip = sample->ip;
 	}
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 3f9153d5ecfb..046bd185318d 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -565,7 +565,7 @@ static char *cat_backtrace(struct perf_sample *sample,
 		addr_location__init(&tal);
 		tal.filtered = 0;
 		if (thread__find_symbol(al.thread, cpumode, ip, &tal))
-			fprintf(f, "..... %016" PRIx64 " %s\n", ip, tal.sym->name);
+			fprintf(f, "..... %016" PRIx64 " %s\n", ip, symbol__name(tal.sym));
 		else
 			fprintf(f, "..... %016" PRIx64 "\n", ip);
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a3442d2d6edf..19a21348823c 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -133,8 +133,8 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 	 * We can't annotate with just /proc/kallsyms
 	 */
 	if (dso__symtab_type(dso) == DSO_BINARY_TYPE__KALLSYMS && !dso__is_kcore(dso)) {
-		pr_err("Can't annotate %s: No vmlinux file was found in the "
-		       "path\n", sym->name);
+		pr_err("Can't annotate %s: No vmlinux file was found in the path\n",
+		       symbol__name(sym));
 		sleep(1);
 		return -1;
 	}
@@ -145,7 +145,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 	if (!symbol__hists(sym, evlist__nr_entries(top->evlist))) {
 		annotation__unlock(notes);
 		pr_err("Not enough memory for annotating '%s' symbol!\n",
-		       sym->name);
+		       symbol__name(sym));
 		sleep(1);
 		return err;
 	}
@@ -156,7 +156,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 	} else {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(&he->ms, err, msg, sizeof(msg));
-		pr_err("Couldn't annotate %s: %s\n", sym->name, msg);
+		pr_err("Couldn't annotate %s: %s\n", symbol__name(sym), msg);
 	}
 
 	annotation__unlock(notes);
@@ -186,9 +186,11 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
 		    "Not all samples will be on the annotation output.\n\n"
 		    "Please report to linux-kernel@vger.kernel.org\n",
 		    ip, dso__long_name(dso), dso__symtab_origin(dso),
-		    map__start(map), map__end(map), sym->start, sym->end,
+		    map__start(map), map__end(map), symbol__start(sym),
+		    symbol__end(sym),
 		    symbol__binding(sym) == STB_GLOBAL ? 'g' :
-		    symbol__binding(sym) == STB_LOCAL  ? 'l' : 'w', sym->name,
+		    symbol__binding(sym) == STB_LOCAL  ? 'l' : 'w',
+		    symbol__name(sym),
 		    err ? "[unknown]" : uts.machine,
 		    err ? "[unknown]" : uts.release, perf_version_string);
 	if (use_browser <= 0)
@@ -232,7 +234,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 			ui__warn_map_erange(he->ms.map, sym, ip);
 		else if (err == -ENOMEM) {
 			pr_err("Not enough memory for annotating '%s' symbol!\n",
-			       sym->name);
+			       symbol__name(sym));
 			sleep(1);
 		}
 
@@ -263,7 +265,8 @@ static void perf_top__show_details(struct perf_top *top)
 	if (notes->src == NULL)
 		goto out_unlock;
 
-	printf("Showing %s for %s\n", evsel__name(top->sym_evsel), symbol->name);
+	printf("Showing %s for %s\n", evsel__name(top->sym_evsel),
+	       symbol__name(symbol));
 	printf("  Events  Pcnt (>=%d%%)\n", annotate_opts.min_pcnt);
 
 	more = hist_entry__annotate_printf(he, top->sym_evsel);
@@ -418,7 +421,7 @@ static void perf_top__prompt_symbol(struct perf_top *top, const char *msg)
 	next = rb_first_cached(&hists->entries);
 	while (next) {
 		n = rb_entry(next, struct hist_entry, rb_node);
-		if (n->ms.sym && !strcmp(buf, n->ms.sym->name)) {
+		if (n->ms.sym && !strcmp(buf, symbol__name(n->ms.sym))) {
 			found = n;
 			break;
 		}
@@ -437,11 +440,11 @@ static void perf_top__prompt_symbol(struct perf_top *top, const char *msg)
 
 static void perf_top__print_mapped_keys(struct perf_top *top)
 {
-	char *name = NULL;
+	const char *name = NULL;
 
 	if (top->sym_filter_entry) {
 		struct symbol *sym = top->sym_filter_entry->ms.sym;
-		name = sym->name;
+		name = symbol__name(sym);
 	}
 
 	fprintf(stdout, "\nMapped keys:\n");
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d327603ae454..aaa090912409 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -768,15 +768,16 @@ size_t syscall_arg__scnprintf_ksym(char *bf, size_t size, struct syscall_arg *ar
 								 arg->val, &map);
 
 		if (sym) {
-			u64 start = map__unmap_ip(map, sym->start);
+			u64 start = map__unmap_ip(map, symbol__start(sym));
 			u64 offset = arg->val - start;
 			size_t printed;
 
 			if (offset == 0)
-				printed = scnprintf(bf, size, "%s", sym->name);
+				printed = scnprintf(bf, size, "%s",
+						    symbol__name(sym));
 			else
 				printed = scnprintf(bf, size, "%s+0x%" PRIx64,
-						    sym->name, offset);
+						    symbol__name(sym), offset);
 			map__put(map);
 			return printed;
 		}
@@ -3652,8 +3653,8 @@ static void print_location(FILE *f, struct perf_sample *sample,
 		fprintf(f, "%s@", dso__long_name(map__dso(al->map)));
 
 	if ((verbose > 0 || print_sym) && al->sym)
-		fprintf(f, "%s+0x%" PRIx64, al->sym->name,
-			al->addr - al->sym->start);
+		fprintf(f, "%s+0x%" PRIx64, symbol__name(al->sym),
+			al->addr - symbol__start(al->sym));
 	else if (al->map)
 		fprintf(f, "0x%" PRIx64, al->addr);
 	else
diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
index 204663571943..b4649c79c309 100644
--- a/tools/perf/tests/dlfilter-test.c
+++ b/tools/perf/tests/dlfilter-test.c
@@ -274,11 +274,11 @@ static int get_ip_addr(struct test_data *td)
 
 	sym = map__find_symbol_by_name(map, "foo");
 	if (sym)
-		td->foo = sym->start;
+		td->foo = symbol__start(sym);
 
 	sym = map__find_symbol_by_name(map, "bar");
 	if (sym)
-		td->bar = sym->start;
+		td->bar = symbol__start(sym);
 
 	map__put(map);
 
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 9ed78d00fb87..b8b0c430a6b3 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -56,7 +56,7 @@ int test__dwarf_unwind(struct test_suite *test, int subtest);
 static int unwind_entry(struct unwind_entry *entry, void *arg)
 {
 	unsigned long *cnt = (unsigned long *) arg;
-	char *symbol = entry->ms.sym ? entry->ms.sym->name : NULL;
+	const char *symbol = entry->ms.sym ? symbol__name(entry->ms.sym) : NULL;
 	static const char *funcs[MAX_STACK] = {
 		"test__arch_unwind_sample",
 		"test_dwarf_unwind__thread",
diff --git a/tools/perf/tests/hists_common.c b/tools/perf/tests/hists_common.c
index 187f12f5bc21..0db3ea9cf62e 100644
--- a/tools/perf/tests/hists_common.c
+++ b/tools/perf/tests/hists_common.c
@@ -184,7 +184,7 @@ void print_hists_in(struct hists *hists)
 			pr_info("%2d: entry: %-8s [%-8s] %20s: period = %"PRIu64"\n",
 				i, thread__comm_str(he->thread),
 				dso__short_name(dso),
-				he->ms.sym->name, he->stat.period);
+				symbol__name(he->ms.sym), he->stat.period);
 		}
 
 		i++;
@@ -213,7 +213,7 @@ void print_hists_out(struct hists *hists)
 			pr_info("%2d: entry: %8s:%5d [%-8s] %20s: period = %"PRIu64"/%"PRIu64"\n",
 				i, thread__comm_str(he->thread), thread__tid(he->thread),
 				dso__short_name(dso),
-				he->ms.sym->name, he->stat.period,
+				symbol__name(he->ms.sym), he->stat.period,
 				he->stat_acc ? he->stat_acc->period : 0);
 		}
 
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index c4a11a3255bc..95b9a629e59e 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -164,11 +164,11 @@ typedef int (*test_fn_t)(struct evsel *, struct machine *);
 
 #define COMM(he)  (thread__comm_str(he->thread))
 #define DSO(he)   (dso__short_name(map__dso(he->ms.map)))
-#define SYM(he)   (he->ms.sym->name)
+#define SYM(he)   (symbol__name(he->ms.sym))
 #define CPU(he)   (he->cpu)
 #define DEPTH(he) (he->callchain->max_depth)
 #define CDSO(cl)  (dso__short_name(map__dso(cl->ms.map)))
-#define CSYM(cl)  (cl->ms.sym->name)
+#define CSYM(cl)  (symbol__name(cl->ms.sym))
 
 struct result {
 	u64 children;
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index 35d230a83e43..77fb3a187139 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -129,7 +129,7 @@ typedef int (*test_fn_t)(struct evsel *, struct machine *);
 
 #define COMM(he)  (thread__comm_str(he->thread))
 #define DSO(he)   (dso__short_name(map__dso(he->ms.map)))
-#define SYM(he)   (he->ms.sym->name)
+#define SYM(he)   (symbol__name(he->ms.sym))
 #define CPU(he)   (he->cpu)
 #define PID(he)   (thread__tid(he->thread))
 
diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index c09e04f36035..d9796851335e 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -129,14 +129,14 @@ static int test_dso(struct dso *dso)
 			continue;
 
 		/* Check for overlapping function symbols */
-		if (last_sym && sym->start < last_sym->end) {
+		if (last_sym && symbol__start(sym) < symbol__end(last_sym)) {
 			pr_debug("Overlapping symbols:\n");
 			symbol__fprintf(last_sym, stderr);
 			symbol__fprintf(sym, stderr);
 			ret = TEST_FAIL;
 		}
 		/* Check for zero-length function symbol */
-		if (sym->start == sym->end) {
+		if (symbol__start(sym) == symbol__end(sym)) {
 			pr_debug("Zero-length symbol:\n");
 			symbol__fprintf(sym, stderr);
 			ret = TEST_FAIL;
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 9396c8a77c86..97950f86ed5f 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -292,18 +292,20 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 
 		sym  = rb_entry(nd, struct symbol, rb_node);
 
-		if (sym->start == sym->end)
+		if (symbol__start(sym) == symbol__end(sym))
 			continue;
 
-		mem_start = map__unmap_ip(args.vmlinux_map, sym->start);
-		mem_end = map__unmap_ip(args.vmlinux_map, sym->end);
+		mem_start = map__unmap_ip(args.vmlinux_map,
+					  symbol__start(sym));
+		mem_end = map__unmap_ip(args.vmlinux_map, symbol__end(sym));
 
 		first_pair = machine__find_kernel_symbol(&args.kallsyms, mem_start, NULL);
 		pair = first_pair;
 
-		if (pair && UM(pair->start) == mem_start) {
+		if (pair && UM(symbol__start(pair)) == mem_start) {
 next_pair:
-			if (arch__compare_symbol_names(sym->name, pair->name) == 0) {
+			if (arch__compare_symbol_names(symbol__name(sym),
+						       symbol__name(pair)) == 0) {
 				/*
 				 * kallsyms don't have the symbol end, so we
 				 * set that by using the next symbol start - 1,
@@ -313,11 +315,12 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 				 * off the real size. More than that and we
 				 * _really_ have a problem.
 				 */
-				s64 skew = mem_end - UM(pair->end);
+				s64 skew = mem_end - UM(symbol__end(pair));
 				if (llabs(skew) >= page_size)
 					pr_debug("WARN: %#" PRIx64 ": diff end addr for %s v: %#" PRIx64 " k: %#" PRIx64 "\n",
-						 mem_start, sym->name, mem_end,
-						 UM(pair->end));
+						 mem_start, symbol__name(sym),
+						 mem_end,
+						 UM(symbol__end(pair)));
 
 				/*
 				 * Do not count this as a failure, because we
@@ -328,16 +331,19 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 				continue;
 			} else {
 				pair = machine__find_kernel_symbol_by_name(&args.kallsyms,
-									   sym->name, NULL);
+									   symbol__name(sym),
+									   NULL);
 				if (pair) {
-					if (UM(pair->start) == mem_start)
+					if (UM(symbol__start(pair)) == mem_start)
 						goto next_pair;
 
 					pr_debug("WARN: %#" PRIx64 ": diff name v: %s k: %s\n",
-						 mem_start, sym->name, pair->name);
+						 mem_start, symbol__name(sym),
+						 symbol__name(pair));
 				} else {
 					pr_debug("WARN: %#" PRIx64 ": diff name v: %s k: %s\n",
-						 mem_start, sym->name, first_pair->name);
+						 mem_start, symbol__name(sym),
+						 symbol__name(first_pair));
 				}
 
 				continue;
@@ -348,14 +354,14 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 			 * such as __indirect_thunk_end.
 			 */
 			continue;
-		} else if (is_ignored_symbol(sym->name, symbol__type(sym))) {
+		} else if (is_ignored_symbol(symbol__name(sym), symbol__type(sym))) {
 			/*
 			 * Ignore hidden symbols, see scripts/kallsyms.c for the details
 			 */
 			continue;
 		} else {
 			pr_debug("ERR : %#" PRIx64 ": %s not on kallsyms\n",
-				 mem_start, sym->name);
+				 mem_start, symbol__name(sym));
 		}
 
 		err = -1;
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index cf36b5347f72..5ef9a59ebdc1 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -196,7 +196,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	int diff = 0;
 
 	/* PLT symbols contain external offsets */
-	if (strstr(sym->name, "@plt"))
+	if (strstr(symbol__name(sym), "@plt"))
 		return;
 
 	if (!disasm_line__is_valid_local_jump(cursor, sym))
@@ -554,7 +554,8 @@ static void ui_browser__init_asm_mode(struct ui_browser *browser)
 static int sym_title(struct symbol *sym, struct map *map, char *title,
 		     size_t sz, int percent_type)
 {
-	return snprintf(title, sz, "%s  %s [Percent: %s] %s", sym->name,
+	return snprintf(title, sz, "%s  %s [Percent: %s] %s",
+			symbol__name(sym),
 			dso__long_name(map__dso(map)),
 			percent_type_str(percent_type),
 			annotate_opts.code_with_type ? "[Type]" : "");
@@ -602,7 +603,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	if (!symbol__hists(dl->ops.target.sym, evlist__nr_entries(evsel->evlist))) {
 		annotation__unlock(notes);
 		ui__warning("Not enough memory for annotating '%s' symbol!\n",
-			    dl->ops.target.sym->name);
+			    symbol__name(dl->ops.target.sym));
 		return true;
 	}
 
@@ -876,7 +877,7 @@ static void annotate_browser__symbol_annotate_error(struct annotate_browser *bro
 
 	dso__set_annotate_warned(dso);
 	symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
-	ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
+	ui__error("Couldn't annotate %s:\n%s", symbol__name(sym), msg);
 }
 
 static int annotate_browser__run(struct annotate_browser *browser,
@@ -1255,7 +1256,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 	 */
 	if (al_addr != NO_ADDR) {
 		struct annotation_line *al = annotated_source__get_line(notes->src,
-			al_addr - sym->start);
+			al_addr - symbol__start(sym));
 
 		browser.selection = al;
 	}
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 593e1fd5759d..206657039223 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2548,7 +2548,7 @@ add_annotate_opt(struct popup_action *act, char **optstr,
 	if (ms->sym == NULL || symbol__annotation(ms->sym)->src == NULL)
 		return 0;
 
-	if (asprintf(optstr, "Annotate %s", ms->sym->name) < 0)
+	if (asprintf(optstr, "Annotate %s", symbol__name(ms->sym)) < 0)
 		return 0;
 
 	map_symbol__copy(&act->ms, ms);
@@ -2748,7 +2748,7 @@ do_run_script(struct hist_browser *browser,
 	if (act->ms.thread)
 		len += strlen(thread__comm_str(act->ms.thread));
 	else if (act->ms.sym)
-		len += strlen(act->ms.sym->name);
+		len += strlen(symbol__name(act->ms.sym));
 	script_opt = malloc(len);
 	if (!script_opt)
 		return -1;
@@ -2759,7 +2759,7 @@ do_run_script(struct hist_browser *browser,
 			  thread__comm_str(act->ms.thread));
 	} else if (act->ms.sym) {
 		n = scnprintf(script_opt, len, " -S %s ",
-			  act->ms.sym->name);
+			  symbol__name(act->ms.sym));
 	}
 
 	if (act->time) {
@@ -2804,7 +2804,7 @@ add_script_opt_2(struct popup_action *act, char **optstr,
 			return 0;
 	} else if (sym) {
 		if (asprintf(optstr, "Run scripts for samples of symbol [%s]%s",
-			     sym->name, tstr) < 0)
+			     symbol__name(sym), tstr) < 0)
 			return 0;
 	} else {
 		if (asprintf(optstr, "Run scripts for all samples%s", tstr) < 0)
@@ -3208,7 +3208,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 					ui_browser__warning(&browser->b, delay_secs * 2,
 						"No samples for the \"%s\" symbol.\n\n"
 						"Probably appeared just in a callchain",
-						browser->selection->sym->name);
+						symbol__name(browser->selection->sym));
 					continue;
 				}
 
diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index 075a575cdc5d..1f69d7a798e9 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -31,12 +31,13 @@ static void map_browser__write(struct ui_browser *browser, void *nd, int row)
 
 	ui_browser__set_percent_color(browser, 0, current_entry);
 	ui_browser__printf(browser, "%*" PRIx64 " %*" PRIx64 " %c ",
-			   mb->addrlen, sym->start, mb->addrlen, sym->end,
+			   mb->addrlen, symbol__start(sym), mb->addrlen,
+			   symbol__end(sym),
 			   symbol__binding(sym) == STB_GLOBAL ? 'g' :
 				symbol__binding(sym) == STB_LOCAL  ? 'l' : 'w');
 	width = browser->width - ((mb->addrlen * 2) + 4);
 	if (width > 0)
-		ui_browser__write_nstring(browser, sym->name, width);
+		ui_browser__write_nstring(browser, symbol__name(sym), width);
 }
 
 /* FIXME uber-kludgy, see comment on cmd_report... */
@@ -122,8 +123,8 @@ int map__browse(struct map *map)
 	for (nd = rb_first(mb.b.entries); nd; nd = rb_next(nd)) {
 		struct symbol *pos = rb_entry(nd, struct symbol, rb_node);
 
-		if (maxaddr < pos->end)
-			maxaddr = pos->end;
+		if (maxaddr < symbol__end(pos))
+			maxaddr = symbol__end(pos);
 		if (verbose > 0) {
 			u32 *idx = symbol__browser_index(pos);
 			*idx = mb.b.nr_entries;
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 094dfa045b77..136957d475d0 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -67,7 +67,7 @@ static int perf_gtk__get_percent(char *buf, size_t size, struct symbol *sym,
 static int perf_gtk__get_offset(char *buf, size_t size, struct map_symbol *ms,
 				struct disasm_line *dl)
 {
-	u64 start = map__rip_2objdump(ms->map, ms->sym->start);
+	u64 start = map__rip_2objdump(ms->map, symbol__start(ms->sym));
 
 	strcpy(buf, "");
 
@@ -192,7 +192,8 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
 
 		dso__set_annotate_warned(dso);
 		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
-		ui__error("Couldn't annotate %s: %s\n", sym->name, msg);
+		ui__error("Couldn't annotate %s: %s\n", symbol__name(sym),
+			  msg);
 		return -1;
 	}
 
@@ -234,7 +235,7 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
 	}
 
 	scrolled_window = gtk_scrolled_window_new();
-	tab_label = gtk_label_new(sym->name);
+	tab_label = gtk_label_new(symbol__name(sym));
 
 	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolled_window),
 				       GTK_POLICY_AUTOMATIC,
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 8c4c8925df2c..f80cc73909ed 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -100,13 +100,12 @@ static struct callchain_list rem_hits;
 
 static void init_rem_hits(void)
 {
-	rem_sq_bracket = malloc(sizeof(*rem_sq_bracket) + 6);
+	rem_sq_bracket = symbol__new(0, 0, 0, 0, "[...]");
 	if (!rem_sq_bracket) {
 		fprintf(stderr, "Not enough memory to display remaining hits\n");
 		return;
 	}
 
-	strcpy(rem_sq_bracket->name, "[...]");
 	rem_hits.ms.sym = rem_sq_bracket;
 }
 
diff --git a/tools/perf/util/annotate-arch/annotate-loongarch.c b/tools/perf/util/annotate-arch/annotate-loongarch.c
index a949b4392dd4..d275730080b7 100644
--- a/tools/perf/util/annotate-arch/annotate-loongarch.c
+++ b/tools/perf/util/annotate-arch/annotate-loongarch.c
@@ -94,8 +94,8 @@ static int loongarch_jump__parse(const struct arch *arch, struct ins_operands *o
 		ops->target.addr = strtoull(ops->raw, NULL, 16);
 
 	target.addr = map__objdump_2mem(map, ops->target.addr);
-	start = map__unmap_ip(map, sym->start);
-	end = map__unmap_ip(map, sym->end);
+	start = map__unmap_ip(map, symbol__start(sym));
+	end = map__unmap_ip(map, symbol__end(sym));
 
 	ops->target.outside = target.addr < start || target.addr >= end;
 
diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index 1acf31a2c759..07b2b9e8fd1d 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -239,7 +239,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 		/* Try to resolve the call target name */
 		if (func)
-			call_name = func->name;
+			call_name = symbol__name(func);
 		else
 			call_name = dl->ops.target.name;
 
@@ -254,7 +254,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 		/* Invalidate caller-saved registers after call */
 		call_addr = map__rip_2objdump(dloc->ms->map,
-					      dloc->ms->sym->start + dl->al.offset);
+					      symbol__start(dloc->ms->sym) + dl->al.offset);
 		for (unsigned i = 0; i < ARRAY_SIZE(state->regs); i++) {
 			struct type_state_reg *reg = &state->regs[i];
 
@@ -286,7 +286,7 @@ static void update_insn_state_x86(struct type_state *state,
 		int offset;
 		const char *var_name = NULL;
 		struct map_symbol *ms = dloc->ms;
-		u64 ip = ms->sym->start + dl->al.offset;
+		u64 ip = symbol__start(ms->sym) + dl->al.offset;
 
 		if (!has_reg_type(state, dst->reg1))
 			return;
@@ -487,7 +487,7 @@ static void update_insn_state_x86(struct type_state *state,
 		return;
 
 	if (dloc->fb_cfa) {
-		u64 ip = dloc->ms->sym->start + dl->al.offset;
+		u64 ip = symbol__start(dloc->ms->sym) + dl->al.offset;
 		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
 
 		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
@@ -504,7 +504,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 		if (dso__kernel(map__dso(dloc->ms->map)) &&
 		    src->segment == INSN_SEG_X86_GS && src->imm) {
-			u64 ip = dloc->ms->sym->start + dl->al.offset;
+			u64 ip = symbol__start(dloc->ms->sym) + dl->al.offset;
 			u64 var_addr;
 			int offset;
 
@@ -653,7 +653,7 @@ static void update_insn_state_x86(struct type_state *state,
 		/* Or check if it's a global variable */
 		else if (sreg == DWARF_REG_PC) {
 			struct map_symbol *ms = dloc->ms;
-			u64 ip = ms->sym->start + dl->al.offset;
+			u64 ip = symbol__start(ms->sym) + dl->al.offset;
 			u64 addr;
 			int offset;
 
@@ -678,7 +678,7 @@ static void update_insn_state_x86(struct type_state *state,
 		/* And check percpu access with base register */
 		else if (has_reg_type(state, sreg) &&
 			 state->regs[sreg].kind == TSR_KIND_PERCPU_BASE) {
-			u64 ip = dloc->ms->sym->start + dl->al.offset;
+			u64 ip = symbol__start(dloc->ms->sym) + dl->al.offset;
 			u64 var_addr = src->offset;
 			int offset;
 
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 19a6ecd67f28..0b2bd6702f25 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -851,9 +851,10 @@ bool get_global_var_info(struct data_loc_info *dloc, u64 addr,
 	sym = thread__find_symbol_fb(dloc->thread, dloc->cpumode,
 				     mem_addr, &al);
 	if (sym) {
-		*var_name = sym->name;
+		*var_name = symbol__name(sym);
 		/* Calculate type offset from the start of variable */
-		*var_offset = mem_addr - map__unmap_ip(al.map, sym->start);
+		*var_offset = mem_addr - map__unmap_ip(al.map,
+						       symbol__start(sym));
 	} else {
 		*var_name = NULL;
 	}
@@ -1503,7 +1504,7 @@ static enum type_match_result find_data_type_insn(struct data_loc_info *dloc,
 			     bb->begin->al.offset, bb->end->al.offset);
 
 		list_for_each_entry_from(dl, &notes->src->source, al.node) {
-			u64 this_ip = sym->start + dl->al.offset;
+			u64 this_ip = symbol__start(sym) + dl->al.offset;
 			u64 addr = map__rip_2objdump(dloc->ms->map, this_ip);
 
 			/* Skip comment or debug info lines */
@@ -1582,8 +1583,8 @@ static enum type_match_result find_data_type_block(struct data_loc_info *dloc,
 			}
 
 			pr_debug_dtp("cannot find a basic block from %"PRIx64" to %"PRIx64"\n",
-				     src_ip - dloc->ms->sym->start,
-				     dst_ip - dloc->ms->sym->start);
+				     src_ip - symbol__start(dloc->ms->sym),
+				     dst_ip - symbol__start(dloc->ms->sym));
 			continue;
 		}
 		prepend_basic_blocks(&this_blocks, &basic_blocks);
@@ -1662,7 +1663,8 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	pr_debug_dtp("-----------------------------------------------------------\n");
 	pr_debug_dtp("find data type for %s%#x(%s) at %s+%#"PRIx64"\n",
 		     offset_sign, offset, buf,
-		     dloc->ms->sym->name, dloc->ip - dloc->ms->sym->start);
+		     symbol__name(dloc->ms->sym),
+		     dloc->ip - symbol__start(dloc->ms->sym));
 
 	/*
 	 * IP is a relative instruction address from the start of the map, as
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 86a4beec6528..a1090a4e2e9d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -237,18 +237,20 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
 
 	pr_debug3("%s: addr=%#" PRIx64 "\n", __func__, map__unmap_ip(ms->map, addr));
 
-	if ((addr < sym->start || addr >= sym->end) &&
-	    (addr != sym->end || sym->start != sym->end)) {
+	if ((addr < symbol__start(sym) || addr >= symbol__end(sym)) &&
+	    (addr != symbol__end(sym) || symbol__start(sym) != symbol__end(sym))) {
 		pr_debug("%s(%d): ERANGE! sym->name=%s, start=%#" PRIx64 ", addr=%#" PRIx64 ", end=%#" PRIx64 "\n",
-		       __func__, __LINE__, sym->name, sym->start, addr, sym->end);
+		       __func__, __LINE__, symbol__name(sym),
+		       symbol__start(sym), addr, symbol__end(sym));
 		return -ERANGE;
 	}
 
-	offset = addr - sym->start;
+	offset = addr - symbol__start(sym);
 	h = annotated_source__histogram(src, evsel);
 	if (h == NULL) {
 		pr_debug("%s(%d): ENOMEM! sym->name=%s, start=%#" PRIx64 ", addr=%#" PRIx64 ", end=%#" PRIx64 ", func: %d\n",
-			 __func__, __LINE__, sym->name, sym->start, addr, sym->end,
+			 __func__, __LINE__, symbol__name(sym),
+			 symbol__start(sym), addr, symbol__end(sym),
 			 symbol__type(sym) == STT_FUNC);
 		return -ENOMEM;
 	}
@@ -288,7 +290,8 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
 	pr_debug3("%#" PRIx64 " %s: period++ [addr: %#" PRIx64 ", %#" PRIx64
 		  ", evidx=%d] => nr_samples: %" PRIu64 ", period: %" PRIu64
 		  " weight %" PRIu64 "\n",
-		  sym->start, sym->name, addr, addr - sym->start, evsel->core.idx,
+		  symbol__start(sym), symbol__name(sym), addr,
+		  addr - symbol__start(sym), evsel->core.idx,
 		  entry->nr_samples, entry->period, weight);
 	return 0;
 }
@@ -402,18 +405,18 @@ static int symbol__account_cycles(u64 addr, u64 start, struct symbol *sym,
 	branch = symbol__find_branch_hist(sym, evlist__nr_br_cntr(evsel->evlist));
 	if (!branch)
 		return -ENOMEM;
-	if (addr < sym->start || addr >= sym->end)
+	if (addr < symbol__start(sym) || addr >= symbol__end(sym))
 		return -ERANGE;
 
 	if (start) {
-		if (start < sym->start || start >= sym->end)
+		if (start < symbol__start(sym) || start >= symbol__end(sym))
 			return -ERANGE;
 		if (start >= addr)
 			start = 0;
 	}
-	offset = addr - sym->start;
+	offset = addr - symbol__start(sym);
 	ret = __symbol__account_cycles(branch->cycles_hist,
-					start ? start - sym->start : 0,
+					start ? start - symbol__start(sym) : 0,
 					offset, cycles,
 					!!start);
 
@@ -445,13 +448,13 @@ int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 	if (start &&
 		(start->ms.sym == ams->ms.sym ||
 		 (ams->ms.sym &&
-		  start->addr == ams->ms.sym->start + map__start(ams->ms.map))))
+		  start->addr == symbol__start(ams->ms.sym) + map__start(ams->ms.map))))
 		saddr = start->al_addr;
 	if (saddr == 0)
 		pr_debug2("BB with bad start: addr %"PRIx64" start %"PRIx64" sym %"PRIx64" saddr %"PRIx64"\n",
 			ams->addr,
 			start ? start->addr : 0,
-			ams->ms.sym ? ams->ms.sym->start + map__start(ams->ms.map) : 0,
+			ams->ms.sym ? symbol__start(ams->ms.sym) + map__start(ams->ms.map) : 0,
 			saddr);
 	err = symbol__account_cycles(ams->al_addr, saddr, ams->ms.sym, cycles, evsel, br_cntr);
 	if (err)
@@ -1165,9 +1168,11 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	notes->src->nr_events = nr ? nr : 1;
 
 	if (annotate_opts.full_addr)
-		notes->src->start = map__objdump_2mem(ms->map, ms->sym->start);
+		notes->src->start = map__objdump_2mem(ms->map,
+						      symbol__start(ms->sym));
 	else
-		notes->src->start = map__rip_2objdump(ms->map, ms->sym->start);
+		notes->src->start = map__rip_2objdump(ms->map,
+						      symbol__start(ms->sym));
 
 	return symbol__disassemble(sym, &args);
 }
@@ -1309,7 +1314,7 @@ static void symbol__annotate_hits(struct symbol *sym, struct evsel *evsel)
 		entry = annotated_source__hist_entry(notes->src, evsel, offset);
 		if (entry && entry->nr_samples != 0)
 			printf("%*" PRIx64 ": %" PRIu64 "\n", BITS_PER_LONG / 2,
-			       sym->start + offset, entry->nr_samples);
+			       symbol__start(sym) + offset, entry->nr_samples);
 	}
 	printf("%*s: %" PRIu64 "\n", BITS_PER_LONG / 2, "h->nr_samples", h->nr_samples);
 }
@@ -1521,7 +1526,7 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
 		.evsel = evsel,
 	};
 
-	if (asprintf(&filename, "%s.annotation", ms->sym->name) < 0)
+	if (asprintf(&filename, "%s.annotation", symbol__name(ms->sym)) < 0)
 		return -1;
 
 	fp = fopen(filename, "w");
@@ -1534,7 +1539,8 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
 	}
 
 	fprintf(fp, "%s() %s\nEvent: %s\n\n",
-		ms->sym->name, dso__long_name(map__dso(ms->map)), ev_name);
+		symbol__name(ms->sym), dso__long_name(map__dso(ms->map)),
+		ev_name);
 	symbol__annotate_fprintf2(ms->sym, fp, &apd);
 
 	fclose(fp);
@@ -1629,7 +1635,7 @@ annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 	struct annotation_line *al;
 
 	/* PLT symbols contain external offsets */
-	if (strstr(sym->name, "@plt"))
+	if (strstr(symbol__name(sym), "@plt"))
 		return;
 
 	list_for_each_entry(al, &notes->src->source, node) {
@@ -1708,7 +1714,7 @@ annotation__init_column_widths(struct annotation *notes, struct symbol *sym)
 {
 	notes->src->widths.addr = notes->src->widths.target =
 		notes->src->widths.min_addr = hex_width(symbol__size(sym));
-	notes->src->widths.max_addr = hex_width(sym->end);
+	notes->src->widths.max_addr = hex_width(symbol__end(sym));
 	notes->src->widths.jumps = width_jumps(notes->src->max_jump_sources);
 	notes->src->widths.max_ins_name = annotation__max_ins_name(notes);
 }
@@ -1733,9 +1739,11 @@ void annotation__toggle_full_addr(struct annotation *notes, struct map_symbol *m
 	annotate_opts.full_addr = !annotate_opts.full_addr;
 
 	if (annotate_opts.full_addr)
-		notes->src->start = map__objdump_2mem(ms->map, ms->sym->start);
+		notes->src->start = map__objdump_2mem(ms->map,
+						      symbol__start(ms->sym));
 	else
-		notes->src->start = map__rip_2objdump(ms->map, ms->sym->start);
+		notes->src->start = map__rip_2objdump(ms->map,
+						      symbol__start(ms->sym));
 
 	annotation__update_column_widths(notes);
 }
@@ -1764,9 +1772,10 @@ static void annotation__calc_lines(struct annotation *notes, struct map_symbol *
 		if (percent_max <= 0.5)
 			continue;
 
-		addr = map__rip_2objdump(ms->map, ms->sym->start);
+		addr = map__rip_2objdump(ms->map, symbol__start(ms->sym));
 		al->path = get_srcline(map__dso(ms->map), addr + al->offset, NULL,
-				       false, true, ms->sym->start + al->offset);
+				       false, true,
+				       symbol__start(ms->sym) + al->offset);
 		insert_source_line(&tmp_root, al);
 	}
 
@@ -1800,7 +1809,7 @@ int hist_entry__tty_annotate2(struct hist_entry *he, struct evsel *evsel)
 
 		dso__set_annotate_warned(dso);
 		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
-		ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
+		ui__error("Couldn't annotate %s:\n%s", symbol__name(sym), msg);
 		return -1;
 	}
 
@@ -1812,7 +1821,8 @@ int hist_entry__tty_annotate2(struct hist_entry *he, struct evsel *evsel)
 
 	hists__scnprintf_title(hists, buf, sizeof(buf));
 	fprintf(stdout, "%s, [percent: %s]\n%s() %s\n",
-		buf, percent_type_str(annotate_opts.percent_type), sym->name, dso__long_name(dso));
+		buf, percent_type_str(annotate_opts.percent_type),
+		symbol__name(sym), dso__long_name(dso));
 	symbol__annotate_fprintf2(sym, stdout, &apd);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
@@ -1834,7 +1844,7 @@ int hist_entry__tty_annotate(struct hist_entry *he, struct evsel *evsel)
 
 		dso__set_annotate_warned(dso);
 		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
-		ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
+		ui__error("Couldn't annotate %s:\n%s", symbol__name(sym), msg);
 		return -1;
 	}
 
@@ -2682,7 +2692,7 @@ static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
 		if (dl->al.offset == -1)
 			continue;
 
-		if (sym->start + dl->al.offset == ip) {
+		if (symbol__start(sym) + dl->al.offset == ip) {
 			/*
 			 * llvm-objdump places "lock" in a separate line and
 			 * in that case, we want to get the next line.
@@ -2818,7 +2828,7 @@ u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
 	 */
 	next = annotation__next_asm_line(notes, dl);
 	if (next == NULL)
-		addr = ms->sym->end + offset;
+		addr = symbol__end(ms->sym) + offset;
 	else
 		addr = ip + (next->al.offset - dl->al.offset) + offset;
 
@@ -2880,7 +2890,7 @@ __hist_entry__get_data_type(struct hist_entry *he, const struct arch *arch,
 			.arch = arch,
 			.thread = he->thread,
 			.ms = ms,
-			.ip = ms->sym->start + dl->al.offset,
+			.ip = symbol__start(ms->sym) + dl->al.offset,
 			.cpumode = he->cpumode,
 			.op = op_loc,
 			.di = dbg,
@@ -3134,7 +3144,7 @@ static bool process_basic_block(struct basic_block_data *bb_data,
 		if (dl->al.offset == -1)
 			continue;
 		/* Found the target instruction */
-		if (sym->start + dl->al.offset == target) {
+		if (symbol__start(sym) + dl->al.offset == target) {
 			found = true;
 			break;
 		}
@@ -3151,7 +3161,8 @@ static bool process_basic_block(struct basic_block_data *bb_data,
 		if (dl->ops.target.outside)
 			break;
 		/* jump instruction creates new basic block(s) */
-		next_dl = find_disasm_line(sym, sym->start + dl->ops.target.offset,
+		next_dl = find_disasm_line(sym,
+					   symbol__start(sym) + dl->ops.target.offset,
 					   /*allow_update=*/false);
 		if (next_dl)
 			add_basic_block(bb_data, link, next_dl);
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index ed2113190785..f4aee90b43a3 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2707,7 +2707,7 @@ static bool dso_sym_match(struct symbol *sym, const char *name, int *cnt,
 			  int idx)
 {
 	/* Same name, and global or the n'th found or any */
-	return !arch__compare_symbol_names(name, sym->name) &&
+	return !arch__compare_symbol_names(name, symbol__name(sym)) &&
 	       ((!idx && symbol__binding(sym) == STB_GLOBAL) ||
 		(idx > 0 && ++*cnt == idx) ||
 		idx < 0);
@@ -2725,14 +2725,14 @@ static void print_duplicate_syms(struct dso *dso, const char *sym_name)
 	while (sym) {
 		if (dso_sym_match(sym, sym_name, &cnt, -1)) {
 			pr_err("#%d\t0x%"PRIx64"\t%c\t%s\n",
-			       ++cnt, sym->start,
+			       ++cnt, symbol__start(sym),
 			       symbol__binding(sym) == STB_GLOBAL ? 'g' :
 			       symbol__binding(sym) == STB_LOCAL  ? 'l' : 'w',
-			       sym->name);
+			       symbol__name(sym));
 			near = true;
 		} else if (near) {
 			near = false;
-			pr_err("\t\twhich is near\t\t%s\n", sym->name);
+			pr_err("\t\twhich is near\t\t%s\n", symbol__name(sym));
 		}
 		sym = dso__next_symbol(sym);
 	}
@@ -2755,7 +2755,7 @@ static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
 	while (sym) {
 		if (*start) {
 			if (!*size)
-				*size = sym->start - *start;
+				*size = symbol__start(sym) - *start;
 			if (idx > 0) {
 				if (*size)
 					return 0;
@@ -2764,8 +2764,8 @@ static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
 				return -EINVAL;
 			}
 		} else if (dso_sym_match(sym, sym_name, &cnt, idx)) {
-			*start = sym->start;
-			*size = sym->end - sym->start;
+			*start = symbol__start(sym);
+			*size = symbol__end(sym) - symbol__start(sym);
 		}
 		sym = dso__next_symbol(sym);
 	}
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 1135e54f4c7f..5dec6c9dc1a7 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -84,7 +84,7 @@ int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right)
 			return 1;
 	}
 
-	cmp = strcmp(bi_l->sym->name, bi_r->sym->name);
+	cmp = strcmp(symbol__name(bi_l->sym), symbol__name(bi_r->sym));
 	if (cmp)
 		return cmp;
 
@@ -305,10 +305,11 @@ static int block_range_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 
 	symbol_conf.addr2line_disable_warn = true;
 
-	start_line = map__srcline(he->ms.map, bi->sym->start + bi->start,
+	start_line = map__srcline(he->ms.map,
+				  symbol__start(bi->sym) + bi->start,
 				  he->ms.sym);
 
-	end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
+	end_line = map__srcline(he->ms.map, symbol__start(bi->sym) + bi->end,
 				he->ms.sym);
 
 	if (start_line != SRCLINE_UNKNOWN &&
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index c20bd075664e..9832c45857d1 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -143,7 +143,8 @@ static void init_numa_data(struct lock_contention *con)
 						  "contig_page_data",
 						  &kmap);
 	if (sym) {
-		skel->rodata->contig_page_data_addr = map__unmap_ip(kmap, sym->start);
+		skel->rodata->contig_page_data_addr = map__unmap_ip(kmap,
+								    symbol__start(sym));
 		map__put(kmap);
 		return;
 	}
@@ -159,7 +160,7 @@ static void init_numa_data(struct lock_contention *con)
 	if (sym == NULL)
 		return;
 
-	skel->rodata->node_data_addr = map__unmap_ip(kmap, sym->start);
+	skel->rodata->node_data_addr = map__unmap_ip(kmap, symbol__start(sym));
 	map__put(kmap);
 
 	/* get the number of online nodes using the last node number + 1 */
@@ -266,7 +267,8 @@ int lock_contention_prepare(struct lock_contention *con)
 				continue;
 			}
 
-			addrs[con->filters->nr_addrs++] = map__unmap_ip(kmap, sym->start);
+			addrs[con->filters->nr_addrs++] = map__unmap_ip(kmap,
+									symbol__start(sym));
 			con->filters->addrs = addrs;
 		}
 		naddrs = con->filters->nr_addrs ?: has_mmap_lock;
@@ -288,7 +290,8 @@ int lock_contention_prepare(struct lock_contention *con)
 				continue;
 			}
 
-			con->delays[i].addr = map__unmap_ip(kmap, sym->start);
+			con->delays[i].addr = map__unmap_ip(kmap,
+							    symbol__start(sym));
 		}
 		skel->rodata->lock_delay = 1;
 		bpf_map__set_max_entries(skel->maps.lock_delays, con->nr_delays);
@@ -608,7 +611,7 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 		/* global locks with symbols */
 		sym = machine__find_kernel_symbol(machine, key->lock_addr_or_cgroup, &kmap);
 		if (sym)
-			return sym->name;
+			return symbol__name(sym);
 
 		/* try semi-global locks collected separately */
 		if (!bpf_map_lookup_elem(lock_fd, &key->lock_addr_or_cgroup, &flags)) {
@@ -652,12 +655,13 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 	if (sym) {
 		unsigned long offset;
 
-		offset = map__map_ip(kmap, addr) - sym->start;
+		offset = map__map_ip(kmap, addr) - symbol__start(sym);
 
 		if (offset == 0)
-			return sym->name;
+			return symbol__name(sym);
 
-		snprintf(name_buf, sizeof(name_buf), "%s+%#lx", sym->name, offset);
+		snprintf(name_buf, sizeof(name_buf), "%s+%#lx",
+			 symbol__name(sym), offset);
 	} else {
 		snprintf(name_buf, sizeof(name_buf), "%#lx", (unsigned long)addr);
 	}
diff --git a/tools/perf/util/c2c-function.c b/tools/perf/util/c2c-function.c
index d410196d0429..0c50d816653f 100644
--- a/tools/perf/util/c2c-function.c
+++ b/tools/perf/util/c2c-function.c
@@ -966,7 +966,7 @@ c2c_function_hists__level1_entry(struct symbol *sym,
 	 * true "function view" rather than a per-code-address view.
 	 */
 	u64 sym_start = (sym && detail_he->ms.map) ?
-			map__unmap_ip(detail_he->ms.map, sym->start) : detail_he->ip;
+			map__unmap_ip(detail_he->ms.map, symbol__start(sym)) : detail_he->ip;
 
 	mi = mem_info__new();
 	if (!mi)
@@ -1058,8 +1058,8 @@ c2c_function_hists__level2_entry(struct c2c_hist_entry *level1_c2c,
 	/* Key by the function symbol start so all code addresses collapse. */
 	level2_c2c = c2c_child_entry__alloc(level1_he, detail_he, 1,
 					    (sym && detail_he->ms.map) ?
-						  map__unmap_ip(detail_he->ms.map, sym->start) :
-						  hist_entry__iaddr(detail_he));
+					    map__unmap_ip(detail_he->ms.map, symbol__start(sym)) :
+					    hist_entry__iaddr(detail_he));
 	if (!level2_c2c)
 		return NULL;
 
@@ -1181,8 +1181,8 @@ static void c2c_he__resort_by_stores(struct hist_entry *parent_he)
 				if (a != b)
 					cmp = a < b ? -1 : 1;
 				else if (he->ms.sym && iter->ms.sym)
-					cmp = strcmp(he->ms.sym->name,
-						     iter->ms.sym->name);
+					cmp = strcmp(symbol__name(he->ms.sym),
+						     symbol__name(iter->ms.sym));
 				else
 					cmp = (iter->ms.sym ? 1 : 0) - (he->ms.sym ? 1 : 0);
 
@@ -1407,7 +1407,7 @@ static int c2c_function__ident_len(struct hist_entry *he)
 	 * Match symbol_view_entry(): sort_sym adds the cpumode prefix and, in
 	 * verbose mode, the address and DSO origin before the symbol name.
 	 */
-	size = strlen(he->ms.sym->name) + 64;
+	size = strlen(symbol__name(he->ms.sym)) + 64;
 	symbuf = malloc(size);
 	if (!symbuf)
 		return size - 1;
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 31c675cbab63..993b7c744a89 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -802,13 +802,15 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 			 * on the symbol start address.
 			 */
 			if (symbol__inlined(cnode->ms.sym) || symbol__inlined(node->ms.sym)) {
-				match = match_chain_strings(cnode->ms.sym->name,
-							    node->ms.sym->name);
+				match = match_chain_strings(symbol__name(cnode->ms.sym),
+							    symbol__name(node->ms.sym));
 				if (match != MATCH_ERROR)
 					break;
 			} else {
-				match = match_chain_dso_addresses(cnode->ms.map, cnode->ms.sym->start,
-								  node->ms.map, node->ms.sym->start);
+				match = match_chain_dso_addresses(cnode->ms.map,
+								  symbol__start(cnode->ms.sym),
+								  node->ms.map,
+								  symbol__start(node->ms.sym));
 				break;
 			}
 		}
@@ -1249,11 +1251,12 @@ char *callchain_list__sym_name(struct callchain_list *cl,
 
 		if (show_srcline && cl->srcline)
 			printed = scnprintf(bf, bfsize, "%s %s%s",
-					    cl->ms.sym->name, cl->srcline,
+					    symbol__name(cl->ms.sym),
+					    cl->srcline,
 					    inlined);
 		else
 			printed = scnprintf(bf, bfsize, "%s%s",
-					    cl->ms.sym->name, inlined);
+					    symbol__name(cl->ms.sym), inlined);
 	} else
 		printed = scnprintf(bf, bfsize, "%#" PRIx64, cl->ip);
 
diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 95881f15324a..422a48385b78 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -333,7 +333,7 @@ static struct symbol *find_symbol_from_addr(struct map *map, u64 addr,
 		return NULL;
 	}
 
-	*sym_offset = al_addr - sym->start;
+	*sym_offset = al_addr - symbol__start(sym);
 	return sym;
 }
 
@@ -368,10 +368,10 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
 
 		if (sym_offset == 0) {
 			scnprintf(buf, len, "\t# %"PRIx64" <%s>",
-				  orig_addr, sym->name);
+				  orig_addr, symbol__name(sym));
 		} else {
 			scnprintf(buf, len, "\t# %"PRIx64" <%s+%#"PRIx64">",
-				  orig_addr, sym->name, sym_offset);
+				  orig_addr, symbol__name(sym), sym_offset);
 		}
 		map__put(found_map);
 		break;
@@ -454,10 +454,10 @@ static void format_capstone_insn_arm64(struct cs_insn *insn, char *buf,
 		len = len - (last_imm - buf);
 		if (sym_offset == 0) {
 			scnprintf(last_imm, len, "%"PRIx64" <%s>",
-				  addr, sym->name);
+				  addr, symbol__name(sym));
 		} else {
 			scnprintf(last_imm, len, "%"PRIx64" <%s+%#"PRIx64">",
-				  addr, sym->name, sym_offset);
+				  addr, symbol__name(sym), sym_offset);
 		}
 		map__put(found_map);
 	}
@@ -498,7 +498,7 @@ int symbol__disassemble_capstone(const char *filename, struct symbol *sym,
 	struct annotation *notes = symbol__annotation(sym);
 	struct map *map = args->ms->map;
 	struct dso *dso = map__dso(map);
-	u64 start = map__rip_2objdump(map, sym->start);
+	u64 start = map__rip_2objdump(map, symbol__start(sym));
 	u64 offset;
 	int i, count, free_count;
 	bool is_64bit = false;
@@ -526,7 +526,7 @@ int symbol__disassemble_capstone(const char *filename, struct symbol *sym,
 
 	/* add the function address and name */
 	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
-		  start, sym->name);
+		  start, symbol__name(sym));
 
 	args->offset = -1;
 	args->line = disasm_buf;
@@ -631,8 +631,8 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 	struct map *map = args->ms->map;
 	struct dso *dso = map__dso(map);
 	struct nscookie nsc;
-	u64 start = map__rip_2objdump(map, sym->start);
-	u64 end = map__rip_2objdump(map, sym->end);
+	u64 start = map__rip_2objdump(map, symbol__start(sym));
+	u64 end = map__rip_2objdump(map, symbol__end(sym));
 	u64 len = end - start;
 	u64 offset;
 	int i, fd, count;
@@ -703,7 +703,7 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 
 	/* add the function address and name */
 	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
-		  start, sym->name);
+		  start, symbol__name(sym));
 
 	args->offset = -1;
 	args->line = disasm_buf;
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 40888b7c4467..c09bd77f5665 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -138,11 +138,11 @@ static void output_sample_callchain_entry(const struct perf_tool *tool,
 	output_json_format(out, false, 4, "{");
 	output_json_key_format(out, false, 5, "ip", "\"0x%" PRIx64 "\"", ip);
 
-	if (al && al->sym && al->sym->namelen) {
+	if (al && al->sym && symbol__namelen(al->sym)) {
 		struct dso *dso = al->map ? map__dso(al->map) : NULL;
 
 		fputc(',', out);
-		output_json_key_string(out, false, 5, "symbol", al->sym->name);
+		output_json_key_string(out, false, 5, "symbol", symbol__name(al->sym));
 
 		if (dso) {
 			const char *dso_name = dso__short_name(dso);
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index ba54b1119ee6..732369fe0046 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -198,7 +198,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 			if (err)
 				return err;
 			*sym_db_id = *db_id;
-			*offset = al->addr - al->sym->start;
+			*offset = al->addr - symbol__start(al->sym);
 		}
 	}
 
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 6b5ffe81f141..e43bfb741dd1 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -342,7 +342,8 @@ void __dump_stack(FILE *file, void **stackdump, size_t stackdump_size)
 		if (thread && thread__find_map(thread, PERF_RECORD_MISC_USER, addr, &al)) {
 			al.sym = map__find_symbol(al.map, al.addr);
 			if (al.sym) {
-				fprintf(file, "    #%zd %p in %s ", i, stackdump[i], al.sym->name);
+				fprintf(file, "    #%zd %p in %s ", i, stackdump[i],
+					symbol__name(al.sym));
 				printed = true;
 			}
 		}
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 5478c134e7e3..78b8811dcaa4 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -312,7 +312,8 @@ int call__scnprintf(const struct ins *ins, char *bf, size_t size,
 		      struct ins_operands *ops, int max_ins_name)
 {
 	if (ops->target.sym)
-		return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->target.sym->name);
+		return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name,
+				 symbol__name(ops->target.sym));
 
 	if (ops->target.addr == 0)
 		return ins__raw_scnprintf(ins, bf, size, ops, max_ins_name);
@@ -399,8 +400,8 @@ static int jump__parse(const struct arch *arch, struct ins_operands *ops, struct
 	}
 
 	target.addr = map__objdump_2mem(map, ops->target.addr);
-	start = map__unmap_ip(map, sym->start);
-	end = map__unmap_ip(map, sym->end);
+	start = map__unmap_ip(map, symbol__start(sym));
+	end = map__unmap_ip(map, symbol__end(sym));
 
 	ops->target.outside = target.addr < start || target.addr >= end;
 
@@ -445,7 +446,8 @@ int jump__scnprintf(const struct ins *ins, char *bf, size_t size,
 		return ins__raw_scnprintf(ins, bf, size, ops, max_ins_name);
 
 	if (ops->target.outside && ops->target.sym != NULL)
-		return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->target.sym->name);
+		return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name,
+				 symbol__name(ops->target.sym));
 
 	c = strchr(ops->raw, ',');
 	c = validate_comma(c, ops);
@@ -1050,8 +1052,8 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 	/* Process hex address followed by ':'. */
 	line_ip = strtoull(parsed_line, &tmp, 16);
 	if (parsed_line != tmp && tmp[0] == ':' && tmp[1] != '\0') {
-		u64 start = map__rip_2objdump(map, sym->start),
-		    end = map__rip_2objdump(map, sym->end);
+		u64 start = map__rip_2objdump(map, symbol__start(sym)),
+		    end = map__rip_2objdump(map, symbol__end(sym));
 
 		offset = line_ip - start;
 		if ((u64)line_ip < start || (u64)line_ip >= end)
@@ -1074,7 +1076,8 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 
 	if (!disasm_line__has_local_offset(dl)) {
 		dl->ops.target.offset = dl->ops.target.addr -
-					map__rip_2objdump(map, sym->start);
+					map__rip_2objdump(map,
+							  symbol__start(sym));
 		dl->ops.target.offset_avail = true;
 	}
 
@@ -1086,7 +1089,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 		};
 
 		if (!maps__find_ams(thread__maps(args->ms->thread), &target) &&
-		    target.ms.sym->start == target.al_addr)
+		    symbol__start(target.ms.sym) == target.al_addr)
 			dl->ops.target.sym = target.ms.sym;
 
 		addr_map_symbol__exit(&target);
@@ -1260,8 +1263,8 @@ static int symbol__disassemble_raw(char *filename, struct symbol *sym,
 	struct annotation *notes = symbol__annotation(sym);
 	struct map *map = args->ms->map;
 	struct dso *dso = map__dso(map);
-	u64 start = map__rip_2objdump(map, sym->start);
-	u64 end = map__rip_2objdump(map, sym->end);
+	u64 start = map__rip_2objdump(map, symbol__start(sym));
+	u64 end = map__rip_2objdump(map, symbol__end(sym));
 	u64 len = end - start;
 	u64 offset;
 	int i, count;
@@ -1280,7 +1283,7 @@ static int symbol__disassemble_raw(char *filename, struct symbol *sym,
 	if (buf == NULL)
 		goto err;
 
-	count = dso__data_read_offset(dso, NULL, sym->start, buf, len);
+	count = dso__data_read_offset(dso, NULL, symbol__start(sym), buf, len);
 
 	line = (u32 *)buf;
 
@@ -1289,7 +1292,7 @@ static int symbol__disassemble_raw(char *filename, struct symbol *sym,
 
 	/* add the function address and name */
 	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
-		  start, sym->name);
+		  start, symbol__name(sym));
 
 	args->offset = -1;
 	args->line = disasm_buf;
@@ -1454,8 +1457,8 @@ static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
 		 opts->objdump_path ?: "objdump",
 		 opts->disassembler_style ? "-M " : "",
 		 opts->disassembler_style ?: "",
-		 map__rip_2objdump(map, sym->start),
-		 map__rip_2objdump(map, sym->end),
+		 map__rip_2objdump(map, symbol__start(sym)),
+		 map__rip_2objdump(map, symbol__end(sym)),
 		 opts->show_linenr ? "-l" : "",
 		 opts->show_asm_raw ? "" : "--no-show-raw-insn",
 		 opts->annotate_src ? "-S" : "",
@@ -1576,18 +1579,20 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		return err;
 
 	pr_debug("%s: filename=%s, sym=%s, start=%#" PRIx64 ", end=%#" PRIx64 "\n", __func__,
-		 symfs_filename, sym->name, map__unmap_ip(map, sym->start),
-		 map__unmap_ip(map, sym->end));
+		 symfs_filename, symbol__name(sym),
+		 map__unmap_ip(map, symbol__start(sym)),
+		 map__unmap_ip(map, symbol__end(sym)));
 
-	pr_debug("annotating [%p] %30s : [%p] %30s\n", dso, dso__long_name(dso), sym, sym->name);
+	pr_debug("annotating [%p] %30s : [%p] %30s\n", dso, dso__long_name(dso), sym,
+		 symbol__name(sym));
 
 	if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
 		return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE;
 	} else if (dso__is_kcore(dso)) {
-		kce.addr = map__rip_2objdump(map, sym->start);
+		kce.addr = map__rip_2objdump(map, symbol__start(sym));
 		kce.kcore_filename = symfs_filename;
-		kce.len = sym->end - sym->start;
-		kce.offs = sym->start;
+		kce.len = symbol__end(sym) - symbol__start(sym);
+		kce.offs = symbol__start(sym);
 
 		if (!kcore_extract__create(&kce)) {
 			delete_extract = true;
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index e11e144af62b..3b72cb7b412e 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -47,13 +47,13 @@ static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
 		d_al->buildid = NULL;
 	}
 	if (sym) {
-		d_al->sym = sym->name;
-		d_al->sym_start = sym->start;
-		d_al->sym_end = sym->end;
-		if (al->addr < sym->end)
-			d_al->symoff = al->addr - sym->start;
+		d_al->sym = symbol__name(sym);
+		d_al->sym_start = symbol__start(sym);
+		d_al->sym_end = symbol__end(sym);
+		if (al->addr < symbol__end(sym))
+			d_al->symoff = al->addr - symbol__start(sym);
 		else if (al->map)
-			d_al->symoff = al->addr - map__start(al->map) - sym->start;
+			d_al->symoff = al->addr - map__start(al->map) - symbol__start(sym);
 		else
 			d_al->symoff = 0;
 		d_al->sym_binding = symbol__binding(sym);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 11db461f2032..39cb82693596 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2027,8 +2027,8 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 			   const struct map *map, const struct symbol *sym,
 			   u8 **out_buf, u64 *out_buf_len, bool *is_64bit)
 {
-	u64 start = map__rip_2objdump(map, sym->start);
-	u64 end = map__rip_2objdump(map, sym->end);
+	u64 start = map__rip_2objdump(map, symbol__start(sym));
+	u64 end = map__rip_2objdump(map, symbol__end(sym));
 	size_t len = end - start;
 
 	*out_buf = NULL;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index ea75816d126a..939307796a88 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -884,11 +884,11 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 
 		if (al->sym) {
 			ret = strlist__has_entry(symbol_conf.sym_list,
-						al->sym->name);
+						symbol__name(al->sym));
 		}
 		if (!ret && al->sym) {
 			snprintf(al_addr_str, sz, "0x%"PRIx64,
-				 map__unmap_ip(al->map, al->sym->start));
+				 map__unmap_ip(al->map, symbol__start(al->sym)));
 			ret = strlist__has_entry(symbol_conf.sym_list,
 						al_addr_str);
 		}
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 0f7a25500a44..76a0c69e6f45 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -200,7 +200,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 
 			/* Add srccode here too? */
 			if (bt_stop_list && sym &&
-			    strlist__has_entry(bt_stop_list, sym->name)) {
+			    strlist__has_entry(bt_stop_list, symbol__name(sym))) {
 				break;
 			}
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 443694926f1a..dd388169c25b 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -97,7 +97,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	 * +3 accounts for ' y ' symtab origin info
 	 */
 	if (h->ms.sym) {
-		symlen = h->ms.sym->namelen + 4;
+		symlen = symbol__namelen(h->ms.sym) + 4;
 		if (verbose > 0)
 			symlen += BITS_PER_LONG / 4 + 2 + 3;
 		hists__new_col_len(hists, HISTC_SYMBOL, symlen);
@@ -120,11 +120,12 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	}
 
 	if (h->parent)
-		hists__new_col_len(hists, HISTC_PARENT, h->parent->namelen);
+		hists__new_col_len(hists, HISTC_PARENT,
+				   symbol__namelen(h->parent));
 
 	if (h->branch_info) {
 		if (h->branch_info->from.ms.sym) {
-			symlen = (int)h->branch_info->from.ms.sym->namelen + 4;
+			symlen = (int) symbol__namelen(h->branch_info->from.ms.sym) + 4;
 			if (verbose > 0)
 				symlen += BITS_PER_LONG / 4 + 2 + 3;
 			hists__new_col_len(hists, HISTC_SYMBOL_FROM, symlen);
@@ -139,7 +140,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 		}
 
 		if (h->branch_info->to.ms.sym) {
-			symlen = (int)h->branch_info->to.ms.sym->namelen + 4;
+			symlen = (int) symbol__namelen(h->branch_info->to.ms.sym) + 4;
 			if (verbose > 0)
 				symlen += BITS_PER_LONG / 4 + 2 + 3;
 			hists__new_col_len(hists, HISTC_SYMBOL_TO, symlen);
@@ -163,7 +164,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 
 	if (h->mem_info) {
 		if (mem_info__daddr(h->mem_info)->ms.sym) {
-			symlen = (int)mem_info__daddr(h->mem_info)->ms.sym->namelen + 4
+			symlen = (int) symbol__namelen(mem_info__daddr(h->mem_info)->ms.sym) + 4
 			       + unresolved_col_width + 2;
 			hists__new_col_len(hists, HISTC_MEM_DADDR_SYMBOL,
 					   symlen);
@@ -178,7 +179,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 		}
 
 		if (mem_info__iaddr(h->mem_info)->ms.sym) {
-			symlen = (int)mem_info__iaddr(h->mem_info)->ms.sym->namelen + 4
+			symlen = (int) symbol__namelen(mem_info__iaddr(h->mem_info)->ms.sym) + 4
 			       + unresolved_col_width + 2;
 			hists__new_col_len(hists, HISTC_MEM_IADDR_SYMBOL,
 					   symlen);
@@ -725,7 +726,7 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 			 */
 			if (hists__has(hists, sym) && he->ms.map != entry->ms.map) {
 				if (he->ms.sym) {
-					u64 addr = he->ms.sym->start;
+					u64 addr = symbol__start(he->ms.sym);
 					he->ms.sym = map__find_symbol(entry->ms.map, addr);
 				}
 
@@ -2298,7 +2299,7 @@ static bool hists__filter_entry_by_symbol(struct hists *hists,
 					  struct hist_entry *he)
 {
 	if (hists->symbol_filter_str != NULL &&
-	    (!he->ms.sym || strstr(he->ms.sym->name,
+	    (!he->ms.sym || strstr(symbol__name(he->ms.sym),
 				   hists->symbol_filter_str) == NULL)) {
 		he->filtered |= (1 << HIST_FILTER__SYMBOL);
 		return true;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 8c21c9f52d57..a9f43ac8d152 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3003,8 +3003,8 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
 
 	for (sym = start; sym; sym = dso__next_symbol(sym)) {
 		if (symbol__binding(sym) == STB_GLOBAL &&
-		    !strcmp(sym->name, "__switch_to")) {
-			ip = map__unmap_ip(map, sym->start);
+		    !strcmp(symbol__name(sym), "__switch_to")) {
+			ip = map__unmap_ip(map, symbol__start(sym));
 			if (ip >= map__start(map) && ip < map__end(map)) {
 				switch_ip = ip;
 				break;
@@ -3021,8 +3021,8 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
 		ptss = "__perf_event_task_sched_out";
 
 	for (sym = start; sym; sym = dso__next_symbol(sym)) {
-		if (!strcmp(sym->name, ptss)) {
-			ip = map__unmap_ip(map, sym->start);
+		if (!strcmp(symbol__name(sym), ptss)) {
+			ip = map__unmap_ip(map, symbol__start(sym));
 			if (ip >= map__start(map) && ip < map__end(map)) {
 				*ptss_ip = ip;
 				break;
diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index a907d7c1ac94..d4b496bb9426 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -552,7 +552,7 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
 	struct annotation *notes = symbol__annotation(sym);
 	struct bpf_prog_linfo *prog_linfo = NULL;
 	struct bpf_prog_info_node *info_node;
-	int len = sym->end - sym->start;
+	int len = symbol__end(sym) - symbol__start(sym);
 	disassembler_ftype disassemble;
 	struct map *map = args->ms->map;
 	struct perf_bpil *info_linear;
@@ -572,7 +572,8 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
 		return SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE;
 
 	pr_debug("%s: handling sym %s addr %" PRIx64 " len %" PRIx64 "\n", __func__,
-		  sym->name, sym->start, sym->end - sym->start);
+		  symbol__name(sym), symbol__start(sym),
+		  symbol__end(sym) - symbol__start(sym));
 
 	memset(tpath, 0, sizeof(tpath));
 	perf_exe(tpath, sizeof(tpath));
diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index 722e71aab100..e90b0d55070e 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -132,7 +132,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	struct annotation *notes = symbol__annotation(sym);
 	struct map *map = args->ms->map;
 	struct dso *dso = map__dso(map);
-	u64 start = map__rip_2objdump(map, sym->start);
+	u64 start = map__rip_2objdump(map, symbol__start(sym));
 	/* Malloc-ed buffer containing instructions read from disk. */
 	u8 *code_buf = NULL;
 	/* Pointer to code to be disassembled. */
@@ -196,7 +196,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 
 	/* add the function address and name */
 	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
-		  start, sym->name);
+		  start, symbol__name(sym));
 
 	args->offset = -1;
 	args->line = disasm_buf;
@@ -317,7 +317,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	return ret;
 #else // HAVE_LIBLLVM_SUPPORT
 	pr_debug("The LLVM disassembler isn't linked in for %s in %s\n",
-		 sym->name, filename);
+		 symbol__name(sym), filename);
 	return -1;
 #endif
 }
diff --git a/tools/perf/util/lock-contention.c b/tools/perf/util/lock-contention.c
index 119a7206f3cd..8ee1b19a8292 100644
--- a/tools/perf/util/lock-contention.c
+++ b/tools/perf/util/lock-contention.c
@@ -135,7 +135,7 @@ bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_sta
 			continue;
 
 		list_for_each_entry(filter, &callstack_filters, list) {
-			if (strstr(sym->name, filter->name))
+			if (strstr(symbol__name(sym), filter->name))
 				return true;
 		}
 	}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 1d9d3bf57720..fa2bd8e0e1f1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1110,8 +1110,8 @@ static u64 find_entry_trampoline(struct dso *dso)
 		if (symbol__binding(sym) != STB_GLOBAL)
 			continue;
 		for (i = 0; i < ARRAY_SIZE(syms); i++) {
-			if (!strcmp(sym->name, syms[i]))
-				return sym->start;
+			if (!strcmp(symbol__name(sym), syms[i]))
+				return symbol__start(sym);
 		}
 	}
 
@@ -2056,7 +2056,7 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 
 static bool symbol__match_regex(struct symbol *sym, regex_t *regex)
 {
-	return regexec(regex, sym->name, 0, NULL, 0) == 0;
+	return regexec(regex, symbol__name(sym), 0, NULL, 0) == 0;
 }
 
 static void ip__resolve_ams(struct thread *thread,
@@ -3283,8 +3283,8 @@ char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, ch
 		return NULL;
 
 	*modp = __map__is_kmodule(map) ? (char *)dso__short_name(map__dso(map)) : NULL;
-	*addrp = map__unmap_ip(map, sym->start);
-	return sym->name;
+	*addrp = map__unmap_ip(map, symbol__start(sym));
+	return (char *)symbol__name(sym);
 }
 
 struct machine__for_each_dso_cb_args {
@@ -3330,27 +3330,35 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 			return false;
 		}
 
-		machine->sched.text_start = map__unmap_ip(kmap, sym->start);
+		machine->sched.text_start = map__unmap_ip(kmap,
+							  symbol__start(sym));
 
 		/* should not fail from here */
 		sym = machine__find_kernel_symbol_by_name(machine, "__sched_text_end", &kmap);
-		machine->sched.text_end = map__unmap_ip(kmap, sym->start);
+		machine->sched.text_end = map__unmap_ip(kmap,
+							symbol__start(sym));
 
 		sym = machine__find_kernel_symbol_by_name(machine, "__lock_text_start", &kmap);
-		machine->lock.text_start = map__unmap_ip(kmap, sym->start);
+		machine->lock.text_start = map__unmap_ip(kmap,
+							 symbol__start(sym));
 
 		sym = machine__find_kernel_symbol_by_name(machine, "__lock_text_end", &kmap);
-		machine->lock.text_end = map__unmap_ip(kmap, sym->start);
+		machine->lock.text_end = map__unmap_ip(kmap,
+						       symbol__start(sym));
 
 		sym = machine__find_kernel_symbol_by_name(machine, "__traceiter_contention_begin", &kmap);
 		if (sym) {
-			machine->traceiter.text_start = map__unmap_ip(kmap, sym->start);
-			machine->traceiter.text_end = map__unmap_ip(kmap, sym->end);
+			machine->traceiter.text_start = map__unmap_ip(kmap,
+								      symbol__start(sym));
+			machine->traceiter.text_end = map__unmap_ip(kmap,
+								    symbol__end(sym));
 		}
 		sym = machine__find_kernel_symbol_by_name(machine, "trace_contention_begin", &kmap);
 		if (sym) {
-			machine->trace.text_start = map__unmap_ip(kmap, sym->start);
-			machine->trace.text_end = map__unmap_ip(kmap, sym->end);
+			machine->trace.text_start = map__unmap_ip(kmap,
+								  symbol__start(sym));
+			machine->trace.text_end = map__unmap_ip(kmap,
+								symbol__end(sym));
 		}
 	}
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 41cdddc987ee..85216fa71f1a 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -321,7 +321,7 @@ void map__fixup_start(struct map *map)
 	if (nd != NULL) {
 		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
 
-		map__set_start(map, sym->start);
+		map__set_start(map, symbol__start(sym));
 	}
 }
 
@@ -333,7 +333,7 @@ void map__fixup_end(struct map *map)
 
 	if (nd != NULL) {
 		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
-		map__set_end(map, sym->end);
+		map__set_end(map, symbol__end(sym));
 	}
 }
 
@@ -606,7 +606,7 @@ u64 map__objdump_2rip(const struct map *map, u64 ip)
 
 bool map__contains_symbol(const struct map *map, const struct symbol *sym)
 {
-	u64 ip = map__unmap_ip(map, sym->start);
+	u64 ip = map__unmap_ip(map, symbol__start(sym));
 
 	return ip >= map__start(map) && ip < map__end(map);
 }
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index fb0279810ae9..f49b4aaacf2f 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -164,7 +164,7 @@ struct thread;
 #define __map__for_each_symbol_by_name(map, sym_name, pos, idx)		\
 	for (pos = map__find_symbol_by_name_idx(map, sym_name, &idx);	\
 	     pos &&						\
-	     !symbol__match_symbol_name(pos->name, sym_name,	\
+	     !symbol__match_symbol_name(symbol__name(pos), sym_name,	\
 					SYMBOL_TAG_INCLUDE__DEFAULT_ONLY); \
 	     pos = dso__next_symbol_by_name(map__dso(map), &idx))
 
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 11ae4a09412c..128076a4b92d 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -149,7 +149,7 @@ static int kernel_get_symbol_address_by_name(const char *name, u64 *addr,
 		sym = machine__find_kernel_symbol_by_name(host_machine, name, &map);
 		if (!sym)
 			return -ENOENT;
-		*addr = map__unmap_ip(map, sym->start) -
+		*addr = map__unmap_ip(map, symbol__start(sym)) -
 			((reloc) ? 0 : map__reloc(map)) -
 			((reladdr) ? map__start(map) : 0);
 	}
@@ -415,13 +415,13 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
 	/* Find the address of given function */
 	map__for_each_symbol_by_name(map, pp->function, sym, idx) {
 		if (uprobes) {
-			address = sym->start;
+			address = symbol__start(sym);
 			if (symbol__type(sym) == STT_GNU_IFUNC)
 				pr_warning("Warning: The probe function (%s) is a GNU indirect function.\n"
 					   "Consider identifying the final function used at run time and set the probe directly on that.\n",
 					   pp->function);
 		} else
-			address = map__unmap_ip(map, sym->start) - map__reloc(map);
+			address = map__unmap_ip(map, symbol__start(sym)) - map__reloc(map);
 		break;
 	}
 	if (!address) {
@@ -721,17 +721,17 @@ static int post_process_probe_trace_point(struct probe_trace_point *tp,
 		return (symbol_conf.ignore_vmlinux_buildid) ? 0 : -ENOENT;
 	}
 
-	if (strcmp(sym->name, tp->symbol)) {
+	if (strcmp(symbol__name(sym), tp->symbol)) {
 		/* If we have no realname, use symbol for it */
 		if (!tp->realname)
 			tp->realname = tp->symbol;
 		else
 			free(tp->symbol);
-		tp->symbol = strdup(sym->name);
+		tp->symbol = strdup(symbol__name(sym));
 		if (!tp->symbol)
 			return -ENOMEM;
 	}
-	tp->offset = addr - sym->start;
+	tp->offset = addr - symbol__start(sym);
 	tp->address -= offs;
 
 	return 0;
@@ -2309,8 +2309,8 @@ static int find_perf_probe_point_from_map(struct probe_trace_point *tp,
 		goto out;
 
 	pp->retprobe = tp->retprobe;
-	pp->offset = addr - map__unmap_ip(map, sym->start);
-	pp->function = strdup(sym->name);
+	pp->offset = addr - map__unmap_ip(map, symbol__start(sym));
+	pp->function = strdup(symbol__name(sym));
 	ret = pp->function ? 0 : -ENOMEM;
 
 out:
@@ -3065,7 +3065,7 @@ static int find_probe_functions(struct map *map, char *name,
 		cut_version = false;
 
 	map__for_each_symbol(map, sym, tmp) {
-		norm = arch__normalize_symbol_name(sym->name);
+		norm = arch__normalize_symbol_name(symbol__name(sym));
 		if (!norm)
 			continue;
 
@@ -3194,9 +3194,10 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 
 		/* There can be duplicated symbols in the map */
 		for (i = 0; i < j; i++)
-			if (sym->start == syms[i]->start) {
+			if (symbol__start(sym) == symbol__start(syms[i])) {
 				pr_debug("Found duplicated symbol %s @ %" PRIx64 "\n",
-					 sym->name, sym->start);
+					 symbol__name(sym),
+					 symbol__start(sym));
 				break;
 			}
 		if (i != j)
@@ -3210,28 +3211,29 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 		}
 		ret++;
 
-		if (pp->offset > sym->end - sym->start) {
+		if (pp->offset > symbol__end(sym) - symbol__start(sym)) {
 			pr_warning("Offset %ld is bigger than the size of %s\n",
-				   pp->offset, sym->name);
+				   pp->offset, symbol__name(sym));
 			ret = -ENOENT;
 			goto err_out;
 		}
 		/* Add one probe point */
-		tp->address = map__unmap_ip(map, sym->start) + pp->offset;
+		tp->address = map__unmap_ip(map, symbol__start(sym)) + pp->offset;
 
 		/* Check the kprobe (not in module) is within .text  */
 		if (!pev->uprobes && !pev->target &&
-		    kprobe_warn_out_range(sym->name, tp->address)) {
+		    kprobe_warn_out_range(symbol__name(sym), tp->address)) {
 			tp->symbol = NULL;	/* Skip it */
 			skipped++;
 		} else if (reloc_sym) {
 			tp->symbol = strdup_or_goto(reloc_sym->name, nomem_out);
 			tp->offset = tp->address - reloc_sym->addr;
 		} else {
-			tp->symbol = strdup_or_goto(sym->name, nomem_out);
+			tp->symbol = strdup_or_goto(symbol__name(sym),
+						    nomem_out);
 			tp->offset = pp->offset;
 		}
-		tp->realname = strdup_or_goto(sym->name, nomem_out);
+		tp->realname = strdup_or_goto(symbol__name(sym), nomem_out);
 
 		tp->retprobe = pp->retprobe;
 		if (pev->target) {
@@ -3813,8 +3815,8 @@ int show_available_funcs(const char *target, struct nsinfo *nsi,
 	for (size_t i = 0; i < dso__symbol_names_len(dso); i++) {
 		struct symbol *pos = dso__symbol_names(dso)[i];
 
-		if (strfilter__compare(_filter, pos->name))
-			printf("%s\n", pos->name);
+		if (strfilter__compare(_filter, symbol__name(pos)))
+			printf("%s\n", symbol__name(pos));
 	}
 end:
 	map__put(map);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index d8a842621cda..d47f6865021e 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -759,7 +759,7 @@ static PyObject *pyrf_sample_event__get_symbol(struct pyrf_event *pevent,
 	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.sym)
 		Py_RETURN_NONE;
 
-	return PyUnicode_FromString(pevent->al.sym->name);
+	return PyUnicode_FromString(symbol__name(pevent->al.sym));
 }
 
 static PyObject *pyrf_sample_event__get_sym_start(struct pyrf_event *pevent,
@@ -768,7 +768,7 @@ static PyObject *pyrf_sample_event__get_sym_start(struct pyrf_event *pevent,
 	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.sym)
 		Py_RETURN_NONE;
 
-	return PyLong_FromUnsignedLongLong(pevent->al.sym->start);
+	return PyLong_FromUnsignedLongLong(symbol__start(pevent->al.sym));
 }
 
 static PyObject *pyrf_sample_event__get_sym_end(struct pyrf_event *pevent,
@@ -777,7 +777,7 @@ static PyObject *pyrf_sample_event__get_sym_end(struct pyrf_event *pevent,
 	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.sym)
 		Py_RETURN_NONE;
 
-	return PyLong_FromUnsignedLongLong(pevent->al.sym->end);
+	return PyLong_FromUnsignedLongLong(symbol__end(pevent->al.sym));
 }
 
 static PyObject *pyrf_sample_event__get_raw_buf(struct pyrf_event *pevent,
@@ -890,7 +890,7 @@ static PyObject *pyrf_callchain_node__get_symbol(struct pyrf_callchain_node *pno
 						 void *closure __maybe_unused)
 {
 	if (pnode->sym)
-		return PyUnicode_FromString(pnode->sym->name);
+		return PyUnicode_FromString(symbol__name(pnode->sym));
 	return PyUnicode_FromString("[unknown]");
 }
 
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 410dc4cd0600..bcb4f0f6a173 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -301,11 +301,11 @@ static SV *perl_process_callchain(struct perf_sample *sample,
 				hv_undef(elem);
 				goto exit;
 			}
-			if (!hv_stores(sym, "start",   newSVuv(node->ms.sym->start)) ||
-			    !hv_stores(sym, "end",     newSVuv(node->ms.sym->end)) ||
+			if (!hv_stores(sym, "start",   newSVuv(symbol__start(node->ms.sym))) ||
+			    !hv_stores(sym, "end",     newSVuv(symbol__end(node->ms.sym))) ||
 			    !hv_stores(sym, "binding", newSVuv(symbol__binding(node->ms.sym))) ||
-			    !hv_stores(sym, "name",    newSVpvn(node->ms.sym->name,
-								node->ms.sym->namelen)) ||
+			    !hv_stores(sym, "name",    newSVpvn(symbol__name(node->ms.sym),
+								symbol__namelen(node->ms.sym))) ||
 			    !hv_stores(elem, "sym",    newRV_noinc((SV*)sym))) {
 				hv_undef(sym);
 				hv_undef(elem);
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 038c4268a429..408b5645b33d 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -382,10 +382,10 @@ static unsigned long get_offset(struct symbol *sym, struct addr_location *al)
 {
 	unsigned long offset;
 
-	if (al->addr < sym->end)
-		offset = al->addr - sym->start;
+	if (al->addr < symbol__end(sym))
+		offset = al->addr - symbol__start(sym);
 	else
-		offset = al->addr - map__start(al->map) - sym->start;
+		offset = al->addr - map__start(al->map) - symbol__start(sym);
 
 	return offset;
 }
@@ -433,14 +433,14 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
 			if (!pysym)
 				Py_FatalError("couldn't create Python dictionary");
 			pydict_set_item_string_decref(pysym, "start",
-					PyLong_FromUnsignedLongLong(node->ms.sym->start));
+					PyLong_FromUnsignedLongLong(symbol__start(node->ms.sym)));
 			pydict_set_item_string_decref(pysym, "end",
-					PyLong_FromUnsignedLongLong(node->ms.sym->end));
+					PyLong_FromUnsignedLongLong(symbol__end(node->ms.sym)));
 			pydict_set_item_string_decref(pysym, "binding",
 					_PyLong_FromLong(symbol__binding(node->ms.sym)));
 			pydict_set_item_string_decref(pysym, "name",
-					_PyUnicode_FromStringAndSize(node->ms.sym->name,
-							node->ms.sym->namelen));
+				_PyUnicode_FromStringAndSize(symbol__name(node->ms.sym),
+							     symbol__namelen(node->ms.sym)));
 			pydict_set_item_string_decref(pyelem, "sym", pysym);
 
 			if (node->ms.map) {
@@ -547,15 +547,15 @@ static int get_symoff(struct symbol *sym, struct addr_location *al,
 {
 	unsigned long offset;
 
-	if (!sym || !sym->name[0])
+	if (!sym || !symbol__name(sym)[0])
 		return scnprintf(bf, size, "%s", "[unknown]");
 
 	if (!print_off)
-		return scnprintf(bf, size, "%s", sym->name);
+		return scnprintf(bf, size, "%s", symbol__name(sym));
 
 	offset = get_offset(sym, al);
 
-	return scnprintf(bf, size, "%s+0x%x", sym->name, offset);
+	return scnprintf(bf, size, "%s+0x%x", symbol__name(sym), offset);
 }
 
 static int get_br_mspred(struct branch_flags *flags, char *bf, int size)
@@ -908,7 +908,7 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 	}
 	if (al->sym) {
 		pydict_set_item_string_decref(dict, sym_field,
-			_PyUnicode_FromString(al->sym->name));
+			_PyUnicode_FromString(symbol__name(al->sym)));
 		pydict_set_item_string_decref(dict, symoff_field,
 			PyLong_FromUnsignedLong(get_offset(al->sym, al)));
 	}
@@ -1379,10 +1379,10 @@ static int python_export_symbol(struct db_export *dbe, struct symbol *sym,
 
 	tuple_set_d64(t, 0, *sym_db_id);
 	tuple_set_d64(t, 1, dso__db_id(dso));
-	tuple_set_d64(t, 2, sym->start);
-	tuple_set_d64(t, 3, sym->end);
+	tuple_set_d64(t, 2, symbol__start(sym));
+	tuple_set_d64(t, 3, symbol__end(sym));
 	tuple_set_s32(t, 4, symbol__binding(sym));
-	tuple_set_string(t, 5, sym->name);
+	tuple_set_string(t, 5, symbol__name(sym));
 
 	call_object(tables->symbol_handler, t, "symbol_table");
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 58638ec9ae0e..89e833f35fd2 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -470,18 +470,19 @@ int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
 		return 0;
 
 	if (symbol__inlined(sym_l) || symbol__inlined(sym_r)) {
-		int ret = strcmp(sym_l->name, sym_r->name);
+		int ret = strcmp(symbol__name(sym_l), symbol__name(sym_r));
 
 		if (ret)
 			return ret;
-		if ((sym_l->start <= sym_r->end) && (sym_l->end >= sym_r->start))
+		if ((symbol__start(sym_l) <= symbol__end(sym_r)) &&
+		    (symbol__end(sym_l) >= symbol__start(sym_r)))
 			return 0;
 	}
 
-	if (sym_l->start != sym_r->start)
-		return (int64_t)(sym_r->start - sym_l->start);
+	if (symbol__start(sym_l) != symbol__start(sym_r))
+		return (int64_t)(symbol__start(sym_r) - symbol__start(sym_l));
 
-	return (int64_t)(sym_r->end - sym_l->end);
+	return (int64_t)(symbol__end(sym_r) - symbol__end(sym_l));
 }
 
 static int64_t
@@ -511,7 +512,7 @@ sort__sym_sort(struct hist_entry *left, struct hist_entry *right)
 	if (!left->ms.sym || !right->ms.sym)
 		return cmp_null(left->ms.sym, right->ms.sym);
 
-	return strcmp(right->ms.sym->name, left->ms.sym->name);
+	return strcmp(symbol__name(right->ms.sym), symbol__name(left->ms.sym));
 }
 
 static int _hist_entry__sym_snprintf(struct map_symbol *ms,
@@ -537,13 +538,14 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
 	ret += repsep_snprintf(bf + ret, size - ret, "[%c] ", level);
 	if (sym && map) {
 		if (symbol__type(sym) == STT_OBJECT) {
-			ret += repsep_snprintf(bf + ret, size - ret, "%s", sym->name);
+			ret += repsep_snprintf(bf + ret, size - ret, "%s",
+					       symbol__name(sym));
 			ret += repsep_snprintf(bf + ret, size - ret, "+0x%llx",
-					ip - map__unmap_ip(map, sym->start));
+					ip - map__unmap_ip(map, symbol__start(sym)));
 		} else {
 			ret += repsep_snprintf(bf + ret, size - ret, "%.*s",
 					       width - ret,
-					       sym->name);
+					       symbol__name(sym));
 			if (symbol__inlined(sym))
 				ret += repsep_snprintf(bf + ret, size - ret,
 						       " (inlined)");
@@ -570,7 +572,7 @@ static int hist_entry__sym_filter(struct hist_entry *he, int type, const void *a
 	if (type != HIST_FILTER__SYMBOL)
 		return -1;
 
-	return sym && (!he->ms.sym || !strstr(he->ms.sym->name, sym));
+	return sym && (!he->ms.sym || !strstr(symbol__name(he->ms.sym), sym));
 }
 
 struct sort_entry sort_sym = {
@@ -616,7 +618,8 @@ hist_entry__symoff_snprintf(struct hist_entry *he, char *bf, size_t size, unsign
 	if (sym == NULL)
 		return repsep_snprintf(bf, size, "[%c] %-#.*llx", he->level, width - 4, he->ip);
 
-	return repsep_snprintf(bf, size, "[%c] %s+0x%llx", he->level, sym->name, he->ip - sym->start);
+	return repsep_snprintf(bf, size, "[%c] %s+0x%llx", he->level,
+			       symbol__name(sym), he->ip - symbol__start(sym));
 }
 
 static struct sort_entry sort_sym_offset = {
@@ -1016,14 +1019,14 @@ sort__parent_cmp(struct hist_entry *left, struct hist_entry *right)
 	if (!sym_l || !sym_r)
 		return cmp_null(sym_l, sym_r);
 
-	return strcmp(sym_r->name, sym_l->name);
+	return strcmp(symbol__name(sym_r), symbol__name(sym_l));
 }
 
 static int hist_entry__parent_snprintf(struct hist_entry *he, char *bf,
 				       size_t size, unsigned int width)
 {
 	return repsep_snprintf(bf, size, "%-*.*s", width, width,
-			      he->parent ? he->parent->name : "[other]");
+			      he->parent ? symbol__name(he->parent) : "[other]");
 }
 
 struct sort_entry sort_parent = {
@@ -1426,7 +1429,7 @@ static int hist_entry__sym_from_filter(struct hist_entry *he, int type,
 		return -1;
 
 	return sym && !(he->branch_info && he->branch_info->from.ms.sym &&
-			strstr(he->branch_info->from.ms.sym->name, sym));
+			strstr(symbol__name(he->branch_info->from.ms.sym), sym));
 }
 
 static int hist_entry__sym_to_filter(struct hist_entry *he, int type,
@@ -1438,7 +1441,7 @@ static int hist_entry__sym_to_filter(struct hist_entry *he, int type,
 		return -1;
 
 	return sym && !(he->branch_info && he->branch_info->to.ms.sym &&
-		        strstr(he->branch_info->to.ms.sym->name, sym));
+			strstr(symbol__name(he->branch_info->to.ms.sym), sym));
 }
 
 struct sort_entry sort_dso_from = {
@@ -1484,14 +1487,15 @@ static int _hist_entry__addr_snprintf(struct map_symbol *ms,
 	ret += repsep_snprintf(bf + ret, size - ret, "[%c] ", level);
 	if (sym && map) {
 		if (symbol__type(sym) == STT_OBJECT) {
-			ret += repsep_snprintf(bf + ret, size - ret, "%s", sym->name);
+			ret += repsep_snprintf(bf + ret, size - ret, "%s",
+					       symbol__name(sym));
 			ret += repsep_snprintf(bf + ret, size - ret, "+0x%llx",
-					ip - map__unmap_ip(map, sym->start));
+					ip - map__unmap_ip(map, symbol__start(sym)));
 		} else {
 			ret += repsep_snprintf(bf + ret, size - ret, "%.*s",
 					       width - ret,
-					       sym->name);
-			offs = ip - sym->start;
+					       symbol__name(sym));
+			offs = ip - symbol__start(sym);
 			if (offs)
 				ret += repsep_snprintf(bf + ret, size - ret, "+0x%llx", offs);
 		}
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index a8d16106f619..53976de3105c 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -116,7 +116,7 @@ struct symbol *new_inline_sym(struct dso *dso,
 			funcname = demangled;
 	}
 
-	if (base_sym && strcmp(funcname, base_sym->name) == 0) {
+	if (base_sym && strcmp(funcname, symbol__name(base_sym)) == 0) {
 		/* reuse the real, existing symbol */
 		inline_sym = base_sym;
 		/* ensure that we don't alias an inlined symbol, which could
@@ -125,8 +125,9 @@ struct symbol *new_inline_sym(struct dso *dso,
 		assert(!symbol__inlined(base_sym));
 	} else {
 		/* create a fake symbol for the inline frame */
-		inline_sym = symbol__new(base_sym ? base_sym->start : 0,
-					 base_sym ? (base_sym->end - base_sym->start) : 0,
+		inline_sym = symbol__new(base_sym ? symbol__start(base_sym) : 0,
+					 base_sym ?
+					 (symbol__end(base_sym) - symbol__start(base_sym)) : 0,
 					 base_sym ? symbol__binding(base_sym) : 0,
 					 base_sym ? symbol__type(base_sym) : 0,
 					 funcname);
@@ -307,11 +308,11 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 out:
 	if (!show_addr)
 		return (show_sym && sym) ?
-			    strndup(sym->name, sym->namelen) : SRCLINE_UNKNOWN;
+			    strndup(symbol__name(sym), symbol__namelen(sym)) : SRCLINE_UNKNOWN;
 
 	if (sym) {
-		if (asprintf(&srcline, "%s+%" PRIu64, show_sym ? sym->name : "",
-					ip - sym->start) < 0)
+		if (asprintf(&srcline, "%s+%" PRIu64, show_sym ? symbol__name(sym) : "",
+					ip - symbol__start(sym)) < 0)
 			return SRCLINE_UNKNOWN;
 	} else if (asprintf(&srcline, "%s[%" PRIx64 "]", dso__short_name(dso), addr) < 0)
 		return SRCLINE_UNKNOWN;
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index e955c3feddcd..73885413073b 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -350,11 +350,11 @@ static bool get_ifunc_name(Elf *elf, struct dso *dso, GElf_Ehdr *ehdr,
 	sym = dso__find_symbol_nocache(dso, addr);
 
 	/* Expecting the address to be an IFUNC or IFUNC alias */
-	if (!sym || sym->start != addr ||
+	if (!sym || symbol__start(sym) != addr ||
 	    (symbol__type(sym) != STT_GNU_IFUNC && !symbol__ifunc_alias(sym)))
 		return false;
 
-	snprintf(buf, buf_sz, "%s@plt", sym->name);
+	snprintf(buf, buf_sz, "%s@plt", symbol__name(sym));
 
 	return true;
 }
@@ -629,8 +629,8 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	 * a symbol for .plt header.
 	 */
 	f = dso__find_symbol_nocache(dso, shdr_plt.sh_offset);
-	if (f && f->start < shdr_plt.sh_offset && f->end > shdr_plt.sh_offset)
-		f->end = shdr_plt.sh_offset;
+	if (f && symbol__start(f) < shdr_plt.sh_offset && symbol__end(f) > shdr_plt.sh_offset)
+		symbol__set_end(f, shdr_plt.sh_offset);
 
 	if (!get_plt_sizes(dso, &ehdr, &shdr_plt, &plt_header_size, &plt_entry_size))
 		return 0;
@@ -652,7 +652,8 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 		if (!get_plt_sizes(dso, &ehdr, &plt_sec_shdr, &plt_header_size, &plt_entry_size))
 			return 0;
 		/* Extend .plt symbol to entire .plt */
-		plt_sym->end = plt_sym->start + shdr_plt.sh_size;
+		symbol__set_end(plt_sym,
+				symbol__start(plt_sym) + shdr_plt.sh_size);
 		/* Use .plt.sec offset */
 		plt_offset = plt_sec_shdr.sh_offset;
 		lazy_plt = false;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 163652f071c6..8e264d38b981 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -149,9 +149,9 @@ int __weak arch__choose_best_symbol(struct symbol *syma,
 				    struct symbol *symb __maybe_unused)
 {
 	/* Avoid "SyS" kernel syscall aliases */
-	if (strlen(syma->name) >= 3 && !strncmp(syma->name, "SyS", 3))
+	if (strlen(symbol__name(syma)) >= 3 && !strncmp(symbol__name(syma), "SyS", 3))
 		return SYMBOL_B;
-	if (strlen(syma->name) >= 10 && !strncmp(syma->name, "compat_SyS", 10))
+	if (strlen(symbol__name(syma)) >= 10 && !strncmp(symbol__name(syma), "compat_SyS", 10))
 		return SYMBOL_B;
 
 	return SYMBOL_A;
@@ -164,8 +164,8 @@ static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
 	size_t na, nb;
 
 	/* Prefer a symbol with non zero length */
-	a = syma->end - syma->start;
-	b = symb->end - symb->start;
+	a = symbol__end(syma) - symbol__start(syma);
+	b = symbol__end(symb) - symbol__start(symb);
 	if ((b == 0) && (a > 0))
 		return SYMBOL_A;
 	else if ((a == 0) && (b > 0))
@@ -195,16 +195,16 @@ static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
 		return SYMBOL_B;
 
 	/* Prefer a symbol with less underscores */
-	a = prefix_underscores_count(syma->name);
-	b = prefix_underscores_count(symb->name);
+	a = prefix_underscores_count(symbol__name(syma));
+	b = prefix_underscores_count(symbol__name(symb));
 	if (b > a)
 		return SYMBOL_A;
 	else if (a > b)
 		return SYMBOL_B;
 
 	/* Choose the symbol with the longest name */
-	na = strlen(syma->name);
-	nb = strlen(symb->name);
+	na = strlen(symbol__name(syma));
+	nb = strlen(symbol__name(symb));
 	if (na > nb)
 		return SYMBOL_A;
 	else if (na < nb)
@@ -231,7 +231,7 @@ void symbols__fixup_duplicate(struct rb_root_cached *symbols)
 			break;
 
 		next = rb_entry(nd, struct symbol, rb_node);
-		if (curr->start != next->start)
+		if (symbol__start(curr) != symbol__start(next))
 			continue;
 
 		if (choose_best_symbol(curr, next) == SYMBOL_A) {
@@ -281,35 +281,39 @@ void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms)
 		 * like in:
 		 *   ffffffffc1937000 T hdmi_driver_init  [snd_hda_codec_hdmi]
 		 */
-		if (prev->end == prev->start) {
+		if (symbol__end(prev) == symbol__start(prev)) {
 			const char *prev_mod;
 			const char *curr_mod;
 
 			if (!is_kallsyms) {
-				prev->end = curr->start;
+				symbol__set_end(prev, symbol__start(curr));
 				continue;
 			}
 
-			prev_mod = strchr(prev->name, '[');
-			curr_mod = strchr(curr->name, '[');
+			prev_mod = strchr(symbol__name(prev), '[');
+			curr_mod = strchr(symbol__name(curr), '[');
 
 			/* Last kernel/module symbol mapped to end of page */
 			if (!prev_mod != !curr_mod)
-				prev->end = roundup(prev->end + 4096, 4096);
+				symbol__set_end(prev,
+						roundup(symbol__end(prev) + 4096, 4096));
 			/* Last symbol in the previous module */
 			else if (prev_mod && strcmp(prev_mod, curr_mod))
-				prev->end = roundup(prev->end + 4096, 4096);
+				symbol__set_end(prev,
+						roundup(symbol__end(prev) + 4096, 4096));
 			else
-				prev->end = curr->start;
+				symbol__set_end(prev, symbol__start(curr));
 
 			pr_debug4("%s sym:%s end:%#" PRIx64 "\n",
-				  __func__, prev->name, prev->end);
+				  __func__, symbol__name(prev),
+				  symbol__end(prev));
 		}
 	}
 
 	/* Last entry */
-	if (curr->end == curr->start)
-		curr->end = roundup(curr->start, 4096) + 4096;
+	if (symbol__end(curr) == symbol__start(curr))
+		symbol__set_end(curr,
+				roundup(symbol__start(curr), 4096) + 4096);
 }
 
 struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name)
@@ -413,14 +417,14 @@ void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
 {
 	struct rb_node **p = &symbols->rb_root.rb_node;
 	struct rb_node *parent = NULL;
-	const u64 ip = sym->start;
+	const u64 ip = symbol__start(sym);
 	struct symbol *s;
 	bool leftmost = true;
 
 	while (*p != NULL) {
 		parent = *p;
 		s = rb_entry(parent, struct symbol, rb_node);
-		if (ip < s->start)
+		if (ip < symbol__start(s))
 			p = &(*p)->rb_left;
 		else {
 			p = &(*p)->rb_right;
@@ -448,9 +452,9 @@ static struct symbol *symbols__find(struct rb_root_cached *symbols, u64 ip)
 	while (n) {
 		struct symbol *s = rb_entry(n, struct symbol, rb_node);
 
-		if (ip < s->start)
+		if (ip < symbol__start(s))
 			n = n->rb_left;
-		else if (ip > s->end || (ip == s->end && ip != s->start))
+		else if (ip > symbol__end(s) || (ip == symbol__end(s) && ip != symbol__start(s)))
 			n = n->rb_right;
 		else
 			return s;
@@ -494,7 +498,7 @@ static int symbols__sort_name_cmp(const void *vlhs, const void *vrhs)
 	const struct symbol *lhs = *((const struct symbol **)vlhs);
 	const struct symbol *rhs = *((const struct symbol **)vrhs);
 
-	return strcmp(lhs->name, rhs->name);
+	return strcmp(symbol__name(lhs), symbol__name(rhs));
 }
 
 static struct symbol **symbols__sort_by_name(struct rb_root_cached *source, size_t *len)
@@ -556,7 +560,8 @@ static struct symbol *symbols__find_by_name(struct symbol *symbols[],
 		int cmp;
 
 		i = (lower + upper) / 2;
-		cmp = symbol__match_symbol_name(symbols[i]->name, name, includes);
+		cmp = symbol__match_symbol_name(symbol__name(symbols[i]),
+						name, includes);
 
 		if (cmp > 0)
 			upper = i;
@@ -574,7 +579,7 @@ static struct symbol *symbols__find_by_name(struct symbol *symbols[],
 		for (; i > 0; i--) {
 			struct symbol *tmp = symbols[i - 1];
 
-			if (!arch__compare_symbol_names(tmp->name, s->name)) {
+			if (!arch__compare_symbol_names(symbol__name(tmp), symbol__name(s))) {
 				if (found_idx)
 					*found_idx = i - 1;
 				s = tmp;
@@ -597,9 +602,9 @@ void dso__insert_symbol(struct dso *dso, struct symbol *sym)
 	__symbols__insert(dso__symbols(dso), sym);
 
 	/* update the symbol cache if necessary */
-	if (dso__last_find_result_addr(dso) >= sym->start &&
-	    (dso__last_find_result_addr(dso) < sym->end ||
-	    sym->start == sym->end)) {
+	if (dso__last_find_result_addr(dso) >= symbol__start(sym) &&
+	    (dso__last_find_result_addr(dso) < symbol__end(sym) ||
+	     symbol__start(sym) == symbol__end(sym))) {
 		dso__set_last_find_result_symbol(dso, sym);
 	}
 }
@@ -796,7 +801,7 @@ bool symbol__is_idle(struct symbol *sym, const struct dso *dso, struct perf_env
 		"poll_idle",
 		"pseries_dedicated_idle_sleep",
 	};
-	const char *name = sym->name;
+	const char *name = symbol__name(sym);
 	uint16_t e_machine;
 
 	{
@@ -936,22 +941,25 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 
 		rb_erase_cached(&pos->rb_node, &old_root);
 		RB_CLEAR_NODE(&pos->rb_node);
-		module = strchr(pos->name, '\t');
+		module = strchr((char *)symbol__name(pos), '\t');
 		if (module)
 			*module = '\0';
 
-		curr_map = maps__find(kmaps, pos->start);
+		curr_map = maps__find(kmaps, symbol__start(pos));
 
 		if (!curr_map) {
 			symbol__delete(pos);
 			continue;
 		}
 		curr_map_dso = map__dso(curr_map);
-		pos->start -= map__start(curr_map) - map__pgoff(curr_map);
-		if (pos->end > map__end(curr_map))
-			pos->end = map__end(curr_map);
-		if (pos->end)
-			pos->end -= map__start(curr_map) - map__pgoff(curr_map);
+		symbol__set_start(pos, symbol__start(pos) -
+				  (map__start(curr_map) - map__pgoff(curr_map)));
+		if (symbol__end(pos) > map__end(curr_map))
+			symbol__set_end(pos, map__end(curr_map));
+		if (symbol__end(pos)) {
+			symbol__set_end(pos, symbol__end(pos) -
+					(map__start(curr_map) - map__pgoff(curr_map)));
+		}
 		symbols__insert(dso__symbols(curr_map_dso), pos);
 		++count;
 		map__put(curr_map);
@@ -1009,7 +1017,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		pos = rb_entry(next, struct symbol, rb_node);
 		next = rb_next(&pos->rb_node);
 
-		module = strchr(pos->name, '\t');
+		module = strchr((char *)symbol__name(pos), '\t');
 		if (module) {
 			struct dso *curr_map_dso;
 
@@ -1051,9 +1059,11 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			 * So that we look just like we get from .ko files,
 			 * i.e. not prelinked, relative to initial_map->start.
 			 */
-			pos->start = map__map_ip(curr_map, pos->start);
-			pos->end   = map__map_ip(curr_map, pos->end);
-		} else if (e_machine == EM_X86_64 && is_entry_trampoline(pos->name)) {
+			symbol__set_start(pos,
+					  map__map_ip(curr_map, symbol__start(pos)));
+			symbol__set_end(pos,
+					map__map_ip(curr_map, symbol__end(pos)));
+		} else if (e_machine == EM_X86_64 && is_entry_trampoline(symbol__name(pos))) {
 			/*
 			 * These symbols are not needed anymore since the
 			 * trampoline maps refer to the text section and it's
@@ -1069,12 +1079,13 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 
 			if (delta) {
 				/* Kernel was relocated at boot time */
-				pos->start -= delta;
-				pos->end -= delta;
+				symbol__set_start(pos,
+						  symbol__start(pos) - delta);
+				symbol__set_end(pos, symbol__end(pos) - delta);
 			}
 
-			if (map__start(initial_map) <= (pos->start + delta) &&
-			    (pos->start + delta) < map__end(initial_map)) {
+			if (map__start(initial_map) <= (symbol__start(pos) + delta) &&
+			    (symbol__start(pos) + delta) < map__end(initial_map)) {
 				map__zput(curr_map);
 				curr_map = map__get(initial_map);
 				goto add_symbol;
@@ -1097,7 +1108,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			dso__set_kernel(ndso, dso__kernel(dso));
 			dso__set_loaded(ndso);
 
-			curr_map = map__new2(pos->start, ndso);
+			curr_map = map__new2(symbol__start(pos), ndso);
 			if (curr_map == NULL) {
 				dso__put(ndso);
 				return -1;
@@ -1113,8 +1124,8 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			++kernel_range;
 		} else if (delta) {
 			/* Kernel was relocated at boot time */
-			pos->start -= delta;
-			pos->end -= delta;
+			symbol__set_start(pos, symbol__start(pos) - delta);
+			symbol__set_end(pos, symbol__end(pos) - delta);
 		}
 add_symbol:
 		if (!RC_CHK_EQUAL(curr_map, initial_map)) {
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index d0bac824c79c..4fb7f6fa8441 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -109,6 +109,46 @@ struct symbol {
 void symbol__delete(struct symbol *sym);
 void symbols__delete(struct rb_root_cached *symbols);
 
+static inline u64 symbol__start(const struct symbol *sym)
+{
+	return sym->start;
+}
+
+static inline void symbol__set_start(struct symbol *sym, u64 start)
+{
+	sym->start = start;
+}
+
+static inline u64 symbol__end(const struct symbol *sym)
+{
+	return sym->end;
+}
+
+static inline void symbol__set_end(struct symbol *sym, u64 end)
+{
+	sym->end = end;
+}
+
+static inline const char *symbol__name(const struct symbol *sym)
+{
+	return sym->name;
+}
+
+static inline u16 symbol__namelen(const struct symbol *sym)
+{
+	return sym->namelen;
+}
+
+static inline u8 symbol__arch_sym(const struct symbol *sym)
+{
+	return sym->arch_sym;
+}
+
+static inline void symbol__set_arch_sym(struct symbol *sym, u8 arch_sym)
+{
+	sym->arch_sym = arch_sym;
+}
+
 static inline u8 symbol__type(const struct symbol *sym)
 {
 	return (atomic_load_explicit(&sym->flags, memory_order_relaxed) &
@@ -165,7 +205,7 @@ void symbol__set_ifunc_alias(struct symbol *sym, bool ifunc_alias);
 
 static inline size_t symbol__size(const struct symbol *sym)
 {
-	return sym->end - sym->start;
+	return symbol__end(sym) - symbol__start(sym);
 }
 
 struct strlist;
diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
index 4dc8d5761f52..8c131325e989 100644
--- a/tools/perf/util/symbol_fprintf.c
+++ b/tools/perf/util/symbol_fprintf.c
@@ -10,10 +10,10 @@
 size_t symbol__fprintf(struct symbol *sym, FILE *fp)
 {
 	return fprintf(fp, " %" PRIx64 "-%" PRIx64 " %c %s\n",
-		       sym->start, sym->end,
+		       symbol__start(sym), symbol__end(sym),
 		       symbol__binding(sym) == STB_GLOBAL ? 'g' :
 		       symbol__binding(sym) == STB_LOCAL  ? 'l' : 'w',
-		       sym->name);
+		       symbol__name(sym));
 }
 
 size_t __symbol__fprintf_symname_offs(const struct symbol *sym,
@@ -25,12 +25,12 @@ size_t __symbol__fprintf_symname_offs(const struct symbol *sym,
 	size_t length;
 
 	if (sym) {
-		length = fprintf(fp, "%s", sym->name);
+		length = fprintf(fp, "%s", symbol__name(sym));
 		if (al && print_offsets) {
-			if (al->addr < sym->end)
-				offset = al->addr - sym->start;
+			if (al->addr < symbol__end(sym))
+				offset = al->addr - symbol__start(sym);
 			else
-				offset = al->addr - map__start(al->map) - sym->start;
+				offset = al->addr - map__start(al->map) - symbol__start(sym);
 			length += fprintf(fp, "+0x%lx", offset);
 		}
 		return length;
@@ -67,7 +67,7 @@ size_t dso__fprintf_symbols_by_name(struct dso *dso,
 	for (size_t i = 0; i < dso__symbol_names_len(dso); i++) {
 		struct symbol *pos = dso__symbol_names(dso)[i];
 
-		ret += fprintf(fp, "%s\n", pos->name);
+		ret += fprintf(fp, "%s\n", symbol__name(pos));
 	}
 	return ret;
 }
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 1360f44421ef..76867ba83365 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -1056,7 +1056,7 @@ static int thread_stack__x86_retpoline(struct thread_stack *ts,
 	struct symbol *tsym = to_al->sym;
 	struct call_path *cp;
 
-	if (sym && is_x86_retpoline(sym->name)) {
+	if (sym && is_x86_retpoline(symbol__name(sym))) {
 		/*
 		 * This is a x86 retpoline fn. It pollutes the call graph by
 		 * showing up everywhere there is an indirect branch, but does
@@ -1069,7 +1069,7 @@ static int thread_stack__x86_retpoline(struct thread_stack *ts,
 		 */
 		ts->cnt -= 1;
 		sym = ts->stack[ts->cnt - 2].cp->sym;
-		if (sym && sym == tsym && to_al->addr != tsym->start) {
+		if (sym && sym == tsym && to_al->addr != symbol__start(tsym)) {
 			/*
 			 * Target is back to the middle of the symbol we came
 			 * from so assume it is an indirect jmp and forget it
@@ -1170,7 +1170,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 		 */
 		if (!err && rstate == X86_RETPOLINE_POSSIBLE && to_al->sym &&
 		    from_al->sym == to_al->sym &&
-		    to_al->addr != to_al->sym->start)
+		    to_al->addr != symbol__start(to_al->sym))
 			ts->rstate = X86_RETPOLINE_DETECTED;
 
 	} else if (sample->flags & PERF_IP_FLAG_RETURN) {
@@ -1207,7 +1207,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 		err = thread_stack__trace_end(ts, sample, ref);
 	} else if (sample->flags & PERF_IP_FLAG_BRANCH &&
 		   from_al->sym != to_al->sym && to_al->sym &&
-		   to_al->addr == to_al->sym->start) {
+		   to_al->addr == symbol__start(to_al->sym)) {
 		struct call_path_root *cpr = ts->crp->cpr;
 		struct call_path *cp;
 
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index d49901b1571e..87ade098b5c6 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -172,7 +172,7 @@ static int entry(u64 ip, struct unwind_info *ui)
 	e->ms.sym = al.sym;
 
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
-		 al.sym ? al.sym->name : "''",
+		 al.sym ? symbol__name(al.sym) : "''",
 		 ip,
 		 al.map ? map__map_ip(al.map, ip) : (u64) 0);
 	addr_location__exit(&al);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

