Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142941;
	b=5FfPyJK7UylNFSQhdxeic1nCPhcxTYG/YqNjDjCpSQZ62E2crAszFFf/rxkryEFNacZM
	 k7fpa2yT/Q2ScXFHF6OjpOlcb2L69A+l6sW19z4n4uxt+CgPsOlq4p+dC3TVdLqhKNU6a
	 +o/Fyn7wttMIgQLOHXkOmm7Ai1laeJ4C3GQ4KrgA8efgAu22hpmJePXL7r/hXP6rAd0aZ
	 9PW2P6q1CenCMOcLQxe5Z6DtTG93YZWOJqoNPq7bimjL3xmQiKdIUyQF73tq+JeVskTrz
	 B27GoL9TH9jRaPo1cpo6CVDZlQmIIcHTFvQpyvTIjKVSxtFZdaCtoyX9iKvKXsWnLHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=/5s2hL8KKQcxUI3+YxmbsqTMKXdKpUOC/KiCWrEM1gQ=;
	b=a9phKWz75J/duafkP5Bplul27eCrDM+kI3Aw0evWy2xCQfs1c2w8nA6X5lMMvKnN1YWe
	 1wG+36UyM2qT+NaAJK2PWQveinVl37VDpBQPP0ZQB5jWWZHAc3TJQBVDUpenRXKAr1/Th
	 RxCzXaSRzE3RgcgUEqxOW2h4xUzFoa6aKCZnlaB6QcUXKjJiyyAT1rDKgL3nJbc4pL6S5
	 2vbKJa/cf0yCJqIXry2MjB3vUYKWMrPG7cm56bEC5/4d7KdyvFEqJZVhYYqVtbJzOoGyU
	 HR1FTjYw0q3dkozu232XE2e/g6XzlAZuTfq5E4Xo27kFOHWeBJQJlSKR61D/r3WVVZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kfd+rOvc;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B377606A321
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 23:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B377606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kfd+rOvc
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-19dbbe4b1d8so323935c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 16:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793142939; x=1793747739; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/5s2hL8KKQcxUI3+YxmbsqTMKXdKpUOC/KiCWrEM1gQ=;
        b=kfd+rOvcm9fjrTLwZF79Piqf3AlhsH1OUbwmd0u2hPTiko3SYe5xUMrxCT5gl/sJVJ
         hmjSLf864GeWFOWzhUO6SJWAA93BtPrnyM1RnuqNxDdMFPIilRMYdJbcf3l7dokxgk/S
         alzL9UO75vJT6+bMB+TlNmQTZoIJ88ms55tjO9nGPLP5o1YgOyWANtnLecrXgJVESSaL
         aONqyngyz8umVqqHmyBpljIQd0Vs42w5RiaqIkWrHMeLYBEZUhZDWBIJzaPdvQlaSv4D
         bsSvC/KbDA8RYGwah+HVCiwru8PRiAgYKZ0QzebMGOpWmqpndHyeHTSSmI2uUwlvrge5
         5srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142939; x=1793747739;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/5s2hL8KKQcxUI3+YxmbsqTMKXdKpUOC/KiCWrEM1gQ=;
        b=ouyz8qCbbfCGhtBegvpwVmGkDgoVlUt+mLOX7tPqLVF0LJ0gl+5amLRc1c9iLwRaI4
         HKn+pNTzRFKQooWAHCiQU2eNw9lBV8C/2T7AgW6mJQCY9iP6SclB50UbRBax5A71zLku
         WObq5b1TXO1JqRjg5YWvwz5EAqAQCQD66Ue3hqlZzMH1YX/yvaJOp8cOLFSzct3FigWy
         btL4twtJKCAZfh3GFo3qABYp/I5Fmzr9UOwYhsWj0uB8MS7Se/jy3Muky2DRKpvmfMXL
         FGTEZ3D7Ca+GWtEIfZ0krRj+3v3RfFgElu862PbHpCmCkmnaxgkvf0fv1HskCoz7lYK9
         wVkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwv59sqIofAuQY7KareMSZt1DMpnGPAJM8uhBKhc2SZu9I3LcbPPdKemsGKtyua19yXeAT8rAR2l4a9yzlIasHQ@vger.kernel.org
X-Gm-Message-State: AFq9FYK6B2zbW0TqtA23DvdgUfPBlvjuaOrhjCxhpBA57Qc02vwRJOEJ
	qh+F1qV/tMYCtWXMxzOXAnpkwsxUvGClPc41rX978xO5GAzd2b88R7JVuIH9iuFxzpR80CdsUqw
	QMsPqZc73Rw==
X-Received: from dldnz14.prod.google.com ([2002:a05:701a:ca0e:b0:195:d59a:94bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2803:b0:193:9568:b42a
 with SMTP id a92af1059eb24-1a6cd3a139amr691420c88.8.1793142938469; Tue, 27
 Oct 2026 16:15:38 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:15:02 -0700
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
Message-ID: <20261027231513.816148-9-irogers@google.com>
Subject: [PATCH v2 08/18] perf symbol: Add reference counting and DECLARE_RC_STRUCT(symbol)
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, haghdoost@uber.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Previously, struct symbol pointers returned by dso__find_symbol() and
map__find_symbol() were uncounted borrowed pointers into the DSO's
symbol table. Callers stored these raw pointers in struct map_symbol,
struct addr_location, struct hist_entry, struct callchain_list, and
annotation structures without lifetime tracking, making it unsafe to
evict unreferenced symbols from a DSO when reclaiming memory.

Wrap struct symbol with DECLARE_RC_STRUCT(symbol) and add a refcount_t
refcnt field along with symbol__get(), symbol__put(), and symbol__zput()
helpers:

- Return a counted symbol reference acquired under symbols->lock from
  symbol lookup functions (symbols__find(), dso__find_symbol(),
  dso__find_symbol_nocache(), map__find_symbol(),
  dso__find_symbol_by_name(), dso__next_symbol_by_name(),
  map__find_symbol_by_name()).
- Update util/annotate.c and util/db-export.c to hash and compare the
  underlying RC_STRUCT(symbol) pointer via RC_CHK_ACCESS(sym) and
  RC_CHK_EQUAL() so REFCNT_CHECKING wrapper pointers for the same
  symbol resolve to the same hashmap entry, and hold a symbol reference
  in struct db_export's sym_db_ids hashmap.
- Update struct addr_location, struct map_symbol, struct call_path,
  struct block_info, struct disasm_line, struct annotated_op_loc, struct
  c2c_sym_Key, inline_list, srcline, thread_stack, and hist/sort/unwind
  consumers to acquire and release symbol references and use
  RC_CHK_EQUAL() for pointer identity comparisons.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/symbols.c                    |   7 +-
 tools/perf/builtin-annotate.c                 |   7 +-
 tools/perf/builtin-kallsyms.c                 |   2 +
 tools/perf/builtin-kmem.c                     |  12 +-
 tools/perf/builtin-lock.c                     |  17 ++-
 tools/perf/builtin-script.c                   |   4 +-
 tools/perf/builtin-top.c                      |   2 +-
 tools/perf/builtin-trace.c                    |   1 +
 tools/perf/tests/dlfilter-test.c              |   8 +-
 tools/perf/tests/hists_cumulate.c             |   4 +-
 tools/perf/tests/hists_filter.c               |  10 +-
 tools/perf/tests/hists_link.c                 |  16 ++-
 tools/perf/tests/hists_output.c               |   7 +-
 tools/perf/tests/kallsyms-split.c             |   5 +-
 tools/perf/tests/pe-file-parsing.c            |   1 +
 tools/perf/tests/symbols.c                    |  14 ++-
 tools/perf/tests/vmlinux-kallsyms.c           |  10 +-
 tools/perf/ui/browsers/hists.c                |  11 +-
 tools/perf/ui/browsers/map.c                  |   7 +-
 tools/perf/ui/stdio/hist.c                    |   3 +-
 tools/perf/util/addr2line.c                   |   8 +-
 tools/perf/util/addr_location.c               |   4 +
 .../perf/util/annotate-arch/annotate-alpha.c  |   5 +-
 .../util/annotate-arch/annotate-loongarch.c   |  11 +-
 tools/perf/util/annotate-arch/annotate-s390.c |   6 +-
 tools/perf/util/annotate.c                    |  22 ++--
 tools/perf/util/block-info.c                  |   6 +-
 tools/perf/util/bpf_lock_contention.c         |  25 +++-
 tools/perf/util/c2c-function.c                |  13 ++-
 tools/perf/util/call-path.c                   |  15 ++-
 tools/perf/util/callchain.c                   |   4 +-
 tools/perf/util/capstone.c                    |   2 +
 tools/perf/util/db-export.c                   |  39 +++++--
 tools/perf/util/disasm.c                      |  22 ++--
 tools/perf/util/event.c                       |   8 +-
 tools/perf/util/hist.c                        |  13 ++-
 tools/perf/util/libbfd.c                      |   7 +-
 tools/perf/util/libdw.c                       |   5 +-
 tools/perf/util/llvm.c                        |   2 +
 tools/perf/util/lock-contention.c             |   8 +-
 tools/perf/util/machine.c                     |  56 ++++++---
 tools/perf/util/map.h                         |  10 +-
 tools/perf/util/map_symbol.c                  |   4 +-
 tools/perf/util/maps.c                        |   3 +-
 tools/perf/util/probe-event.c                 |  17 ++-
 tools/perf/util/python.c                      |  20 +---
 tools/perf/util/sort.c                        |   2 +-
 tools/perf/util/srcline.c                     |   6 +-
 tools/perf/util/symbol-elf.c                  |   6 +-
 tools/perf/util/symbol.c                      | 107 +++++++++++-------
 tools/perf/util/symbol.h                      |  60 +++++++---
 tools/perf/util/thread-stack.c                |  12 +-
 tools/perf/util/threads.c                     |  17 ++-
 tools/perf/util/unwind-libdw.c                |   2 +-
 tools/perf/util/unwind-libunwind.c            |   2 +-
 55 files changed, 478 insertions(+), 219 deletions(-)

diff --git a/tools/perf/bench/symbols.c b/tools/perf/bench/symbols.c
index 5ab71d440e67..8e0621deec83 100644
--- a/tools/perf/bench/symbols.c
+++ b/tools/perf/bench/symbols.c
@@ -159,8 +159,9 @@ static int do_synthetic_symbols_bench(void)
 			u64 addr = (j < half) ?
 				(0x100000ULL + (u64)j * 0x40ULL + 4) :
 				(0x100020ULL + (u64)(j - half) * 0x40ULL + 4);
+			struct symbol *sym = dso__find_symbol_nocache(dso, addr);
 
-			(void)dso__find_symbol_nocache(dso, addr);
+			symbol__put(sym);
 		}
 		gettimeofday(&end, NULL);
 		timersub(&end, &start, &diff);
@@ -183,7 +184,9 @@ static int do_synthetic_symbols_bench(void)
 				return -ENOMEM;
 			}
 			dso__insert_symbol(dso, sym);
-			(void)dso__find_symbol_nocache(dso, addr + 2);
+
+			sym = dso__find_symbol_nocache(dso, addr + 2);
+			symbol__put(sym);
 		}
 		gettimeofday(&end, NULL);
 		timersub(&end, &start, &diff);
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 5ee02a25fb9c..6bf88aada13d 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -134,7 +134,8 @@ static void process_basic_block(struct addr_map_symbol *start,
 		entry = block_range_iter(&iter);
 
 		entry->coverage++;
-		entry->sym = sym;
+		symbol__put(entry->sym);
+		entry->sym = symbol__get(sym);
 
 		if (branch)
 			branch->max_coverage = max(branch->max_coverage, entry->coverage);
@@ -174,6 +175,10 @@ static void process_branch_stack(struct branch_stack *bs, struct addr_location *
 		prev = &bi[i].to;
 	}
 
+	for (i = 0; i < (int)bs->nr; i++) {
+		map_symbol__exit(&bi[i].to.ms);
+		map_symbol__exit(&bi[i].from.ms);
+	}
 	free(bi);
 }
 
diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
index e99f61c3653e..8f0eaca1099b 100644
--- a/tools/perf/builtin-kallsyms.c
+++ b/tools/perf/builtin-kallsyms.c
@@ -52,6 +52,8 @@ static int __cmd_kallsyms(int argc, const char **argv)
 			map__unmap_ip(map, symbol__start(symbol)),
 			map__unmap_ip(map, symbol__end(symbol)),
 			symbol__start(symbol), symbol__end(symbol));
+		symbol__put(symbol);
+		map__put(map);
 	}
 out:
 	machine__delete(machine);
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 7070611e3619..e178be48f269 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1044,7 +1044,7 @@ static void __print_slab_result(struct rb_root *root,
 		struct alloc_stat *data = rb_entry(next, struct alloc_stat,
 						   node);
 		struct symbol *sym = NULL;
-		struct map *map;
+		struct map *map = NULL;
 		char buf[BUFSIZ];
 		u64 addr;
 
@@ -1061,6 +1061,8 @@ static void __print_slab_result(struct rb_root *root,
 		} else {
 			snprintf(buf, sizeof(buf), "%#" PRIx64 "", addr);
 		}
+		symbol__put(sym);
+		map__put(map);
 		printf(" %-34s |", buf);
 
 		printf(" %9llu/%-5lu | %9llu/%-5lu | %8lu | %9lu | %6.3f%%\n",
@@ -1111,12 +1113,11 @@ static void __print_page_alloc_result(struct perf_session *session, int n_lines)
 	while (next && n_lines--) {
 		struct page_stat *data;
 		struct symbol *sym;
-		struct map *map;
 		char buf[32];
 		const char *caller = buf;
 
 		data = rb_entry(next, struct page_stat, node);
-		sym = machine__find_kernel_symbol(machine, data->callsite, &map);
+		sym = machine__find_kernel_symbol(machine, data->callsite, NULL);
 		if (sym)
 			caller = symbol__name(sym);
 		else
@@ -1127,6 +1128,7 @@ static void __print_page_alloc_result(struct perf_session *session, int n_lines)
 		       data->nr_alloc, data->order,
 		       migrate_type_str[data->migrate_type],
 		       gfp_len, compact_gfp_string(data->gfp_flags), caller);
+		symbol__put(sym);
 
 		next = rb_next(next);
 	}
@@ -1153,12 +1155,11 @@ static void __print_page_caller_result(struct perf_session *session, int n_lines
 	while (next && n_lines--) {
 		struct page_stat *data;
 		struct symbol *sym;
-		struct map *map;
 		char buf[32];
 		const char *caller = buf;
 
 		data = rb_entry(next, struct page_stat, node);
-		sym = machine__find_kernel_symbol(machine, data->callsite, &map);
+		sym = machine__find_kernel_symbol(machine, data->callsite, NULL);
 		if (sym)
 			caller = symbol__name(sym);
 		else
@@ -1169,6 +1170,7 @@ static void __print_page_caller_result(struct perf_session *session, int n_lines
 		       data->nr_alloc, data->order,
 		       migrate_type_str[data->migrate_type],
 		       gfp_len, compact_gfp_string(data->gfp_flags), caller);
+		symbol__put(sym);
 
 		next = rb_next(next);
 	}
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index e52e3785b657..147bbc09ab76 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1003,11 +1003,15 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
 					(filters.nr_addrs + 1) * sizeof(*addrs));
 			if (addrs == NULL) {
 				pr_warning("memory allocation failure\n");
+				symbol__put(sym);
+				map__put(kmap);
 				return -ENOMEM;
 			}
 
 			addrs[filters.nr_addrs++] = map__unmap_ip(kmap, symbol__start(sym));
 			filters.addrs = addrs;
+			symbol__put(sym);
+			map__put(kmap);
 		}
 	}
 
@@ -1057,9 +1061,12 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
 
 		switch (aggr_mode) {
 		case LOCK_AGGR_ADDR:
-			sym = machine__find_kernel_symbol(machine, key, &kmap);
-			if (sym)
-				name = symbol__name(sym);
+			sym = machine__find_kernel_symbol(machine, key, NULL);
+			if (sym) {
+				scnprintf(buf, sizeof(buf), "%s", symbol__name(sym));
+				name = buf;
+				symbol__put(sym);
+			}
 			break;
 		case LOCK_AGGR_CALLER:
 			name = buf;
@@ -1671,6 +1678,8 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
 			ip = st->callstack[i];
 			sym = machine__find_kernel_symbol(con->machine, ip, &kmap);
 			get_symbol_name_offset(kmap, sym, ip, buf, sizeof(buf));
+			symbol__put(sym);
+			map__put(kmap);
 			fprintf(lock_output, "\t\t\t%#lx  %s\n", (unsigned long)ip, buf);
 		}
 	}
@@ -1724,6 +1733,8 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
 			ip = st->callstack[i];
 			sym = machine__find_kernel_symbol(con->machine, ip, &kmap);
 			get_symbol_name_offset(kmap, sym, ip, buf, sizeof(buf));
+			symbol__put(sym);
+			map__put(kmap);
 			fprintf(lock_output, "%s %#lx %s", i ? ":" : sep, (unsigned long) ip, buf);
 		}
 		fprintf(lock_output, "\n");
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 7559d4d230f2..1237b755cfdf 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1430,7 +1430,8 @@ static int ip__fprintf_sym(uint64_t addr, struct thread *thread,
 	if (PRINT_FIELD(SRCLINE))
 		printed += map__fprintf_srcline(al.map, al.addr, "\t", fp);
 	printed += fprintf(fp, "\n");
-	*lastsym = al.sym;
+	symbol__put(*lastsym);
+	*lastsym = symbol__get(al.sym);
 
 	ret = printed;
 out:
@@ -1597,6 +1598,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 			print_srccode(thread, x.cpumode, start + off);
 	}
 out:
+	symbol__put(lastsym);
 	return printed;
 }
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d85a49d546eb..11c46c38b7fb 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -209,7 +209,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 
 	if (sym == NULL || (use_browser == 0 &&
 			    (top->sym_filter_entry == NULL ||
-			     top->sym_filter_entry->ms.sym != sym)))
+			     !RC_CHK_EQUAL(top->sym_filter_entry->ms.sym, sym))))
 		return;
 
 	notes = symbol__annotation(sym);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7683b362783a..0dcf042f7ac0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -799,6 +799,7 @@ size_t syscall_arg__scnprintf_ksym(char *bf, size_t size, struct syscall_arg *ar
 				printed = scnprintf(bf, size, "%s+0x%" PRIx64,
 						    symbol__name(sym), offset);
 			}
+			symbol__put(sym);
 			map__put(map);
 			return printed;
 		}
diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
index b4649c79c309..1b7f400761bf 100644
--- a/tools/perf/tests/dlfilter-test.c
+++ b/tools/perf/tests/dlfilter-test.c
@@ -273,12 +273,16 @@ static int get_ip_addr(struct test_data *td)
 		return -1;
 
 	sym = map__find_symbol_by_name(map, "foo");
-	if (sym)
+	if (sym) {
 		td->foo = symbol__start(sym);
+		symbol__put(sym);
+	}
 
 	sym = map__find_symbol_by_name(map, "bar");
-	if (sym)
+	if (sym) {
 		td->bar = symbol__start(sym);
+		symbol__put(sym);
+	}
 
 	map__put(map);
 
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 95b9a629e59e..16637f1e1e23 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -114,7 +114,8 @@ static int add_hist_entries(struct hists *hists, struct machine *machine)
 		fake_samples[i].thread = thread__get(al.thread);
 		map__put(fake_samples[i].map);
 		fake_samples[i].map = map__get(al.map);
-		fake_samples[i].sym = al.sym;
+		symbol__put(fake_samples[i].sym);
+		fake_samples[i].sym = symbol__get(al.sym);
 	}
 
 	addr_location__exit(&al);
@@ -155,6 +156,7 @@ static void put_fake_samples(void)
 	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(fake_samples); i++) {
+		symbol__zput(fake_samples[i].sym);
 		map__zput(fake_samples[i].map);
 		thread__zput(fake_samples[i].thread);
 	}
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index 6c7e4cdc71a7..3bd0b0b270f5 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -93,7 +93,8 @@ static int add_hist_entries(struct evlist *evlist,
 			fake_samples[i].thread = thread__get(al.thread);
 			map__put(fake_samples[i].map);
 			fake_samples[i].map = map__get(al.map);
-			fake_samples[i].sym = al.sym;
+			symbol__put(fake_samples[i].sym);
+			fake_samples[i].sym = symbol__get(al.sym);
 		}
 	}
 	addr_location__exit(&al);
@@ -109,8 +110,11 @@ static void put_fake_samples(void)
 {
 	size_t i;
 
-	for (i = 0; i < ARRAY_SIZE(fake_samples); i++)
-		map__put(fake_samples[i].map);
+	for (i = 0; i < ARRAY_SIZE(fake_samples); i++) {
+		symbol__zput(fake_samples[i].sym);
+		map__zput(fake_samples[i].map);
+		thread__zput(fake_samples[i].thread);
+	}
 }
 
 static int test__hists_filter(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index cd32c8277627..b91a75a8fa23 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -99,7 +99,8 @@ static int add_hist_entries(struct evlist *evlist, struct machine *machine)
 			fake_common_samples[k].thread = thread__get(al.thread);
 			map__put(fake_common_samples[k].map);
 			fake_common_samples[k].map = map__get(al.map);
-			fake_common_samples[k].sym = al.sym;
+			symbol__put(fake_common_samples[k].sym);
+			fake_common_samples[k].sym = symbol__get(al.sym);
 		}
 
 		for (k = 0; k < ARRAY_SIZE(fake_samples[i]); k++) {
@@ -119,7 +120,8 @@ static int add_hist_entries(struct evlist *evlist, struct machine *machine)
 			fake_samples[i][k].thread = thread__get(al.thread);
 			map__put(fake_samples[i][k].map);
 			fake_samples[i][k].map = map__get(al.map);
-			fake_samples[i][k].sym = al.sym;
+			symbol__put(fake_samples[i][k].sym);
+			fake_samples[i][k].sym = symbol__get(al.sym);
 		}
 		i++;
 	}
@@ -136,11 +138,15 @@ static void put_fake_samples(void)
 {
 	size_t i, j;
 
-	for (i = 0; i < ARRAY_SIZE(fake_common_samples); i++)
+	for (i = 0; i < ARRAY_SIZE(fake_common_samples); i++) {
 		map__put(fake_common_samples[i].map);
+		symbol__put(fake_common_samples[i].sym);
+	}
 	for (i = 0; i < ARRAY_SIZE(fake_samples); i++) {
-		for (j = 0; j < ARRAY_SIZE(fake_samples[0]); j++)
+		for (j = 0; j < ARRAY_SIZE(fake_samples[0]); j++) {
 			map__put(fake_samples[i][j].map);
+			symbol__put(fake_samples[i][j].sym);
+		}
 	}
 }
 
@@ -150,7 +156,7 @@ static int find_sample(struct sample *samples, size_t nr_samples,
 	while (nr_samples--) {
 		if (RC_CHK_EQUAL(samples->thread, t) &&
 		    RC_CHK_EQUAL(samples->map, m) &&
-		    samples->sym == s)
+		    RC_CHK_EQUAL(samples->sym, s))
 			return 1;
 		samples++;
 	}
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index 77fb3a187139..63b9e48ada63 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -79,7 +79,8 @@ static int add_hist_entries(struct hists *hists, struct machine *machine)
 		fake_samples[i].thread = al.thread;
 		map__put(fake_samples[i].map);
 		fake_samples[i].map = map__get(al.map);
-		fake_samples[i].sym = al.sym;
+		symbol__put(fake_samples[i].sym);
+		fake_samples[i].sym = symbol__get(al.sym);
 	}
 
 	addr_location__exit(&al);
@@ -120,8 +121,8 @@ static void put_fake_samples(void)
 	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(fake_samples); i++) {
-		map__put(fake_samples[i].map);
-		fake_samples[i].map = NULL;
+		symbol__zput(fake_samples[i].sym);
+		map__zput(fake_samples[i].map);
 	}
 }
 
diff --git a/tools/perf/tests/kallsyms-split.c b/tools/perf/tests/kallsyms-split.c
index 244daa01bd5d..0e5c029a583e 100644
--- a/tools/perf/tests/kallsyms-split.c
+++ b/tools/perf/tests/kallsyms-split.c
@@ -99,6 +99,7 @@ static int test__kallsyms_split(struct test_suite *test __maybe_unused,
 {
 	struct machine m = { 0 };
 	struct map *map = NULL;
+	struct symbol *sym;
 	int ret = TEST_FAIL;
 
 	pr_debug("try to create fake root directory\n");
@@ -139,10 +140,12 @@ static int test__kallsyms_split(struct test_suite *test __maybe_unused,
 		goto out;
 	}
 
-	if (machine__find_kernel_symbol_by_name(&m, "main_symbol3", &map) == NULL) {
+	sym = machine__find_kernel_symbol_by_name(&m, "main_symbol3", &map);
+	if (sym == NULL) {
 		pr_debug("FAIL: failed to find a symbol\n");
 		goto out;
 	}
+	symbol__put(sym);
 
 	if (!RC_CHK_EQUAL(map, machine__kernel_map(&m))) {
 		pr_debug("FAIL: the symbol is not in the kernel map\n");
diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index 190520ffc3ad..fdb8d2a7e4c6 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -64,6 +64,7 @@ static int run_dir(const char *d)
 	dso__sort_by_name(dso);
 	sym = dso__find_symbol_by_name(dso, "main", &idx);
 	TEST_ASSERT_VAL("Failed to find main", sym);
+	symbol__put(sym);
 	dso__delete(dso);
 
 	return TEST_OK;
diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index 8ccf977aa9f7..d70adbad3978 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -260,18 +260,19 @@ static const struct kallsyms_sym kallsyms_syms[] = {
 static int check_symbol(struct dso *dso, u64 addr, const char *name, u64 end)
 {
 	struct symbol *sym = dso__find_symbol_nocache(dso, addr);
+	int ret = TEST_OK;
 
 	if (!sym || strcmp(symbol__name(sym), name)) {
 		pr_debug("%#" PRIx64 ": expected %s, got %s\n", addr, name,
 			 sym ? symbol__name(sym) : "no symbol");
-		return TEST_FAIL;
-	}
-	if (symbol__end(sym) != end) {
+		ret = TEST_FAIL;
+	} else if (symbol__end(sym) != end) {
 		pr_debug("%s: expected end %#" PRIx64 ", got %#" PRIx64 "\n",
 			 name, end, symbol__end(sym));
-		return TEST_FAIL;
+		ret = TEST_FAIL;
 	}
-	return TEST_OK;
+	symbol__put(sym);
+	return ret;
 }
 
 static int test__kallsyms_fixup_end(struct test_suite *test __maybe_unused,
@@ -289,7 +290,8 @@ static int test__kallsyms_fixup_end(struct test_suite *test __maybe_unused,
 
 		if (!sym)
 			goto out;
-		symbols__insert(dso__symbols(dso), sym);
+		if (symbols__insert(dso__symbols(dso), sym))
+			goto out;
 	}
 
 	symbols__fixup_end(dso__symbols(dso), true);
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index bef40c194d70..7454f13dba06 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -208,7 +208,7 @@ static int test__vmlinux_matches_kallsyms_sym_cb(struct symbol *sym, void *data)
 	mem_end = map__unmap_ip(args->vmlinux_map, symbol__end(sym));
 
 	first_pair = machine__find_kernel_symbol(&args->kallsyms, mem_start, NULL);
-	pair = first_pair;
+	pair = symbol__get(first_pair);
 
 	if (pair && UM(symbol__start(pair)) == mem_start) {
 next_pair:
@@ -237,8 +237,11 @@ static int test__vmlinux_matches_kallsyms_sym_cb(struct symbol *sym, void *data)
 			 * possible to get proper function end from
 			 * kallsyms.
 			 */
+			symbol__put(pair);
+			symbol__put(first_pair);
 			return 0;
 		}
+		symbol__put(pair);
 		pair = machine__find_kernel_symbol_by_name(&args->kallsyms,
 							   symbol__name(sym), NULL);
 		if (pair) {
@@ -247,14 +250,17 @@ static int test__vmlinux_matches_kallsyms_sym_cb(struct symbol *sym, void *data)
 
 			pr_debug("WARN: %#" PRIx64 ": diff name v: %s k: %s\n",
 				 mem_start, symbol__name(sym), symbol__name(pair));
+			symbol__put(pair);
 		} else {
 			pr_debug("WARN: %#" PRIx64 ": diff name v: %s k: %s\n",
 				 mem_start, symbol__name(sym), symbol__name(first_pair));
 		}
 
+		symbol__put(first_pair);
 		return 0;
 	}
-
+	symbol__put(pair);
+	symbol__put(first_pair);
 	if (mem_start == map__end(args->kallsyms.vmlinux_map)) {
 		/*
 		 * Ignore aliases to _etext, i.e. to the end of the kernel text area,
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 5147b7dca256..0267a91b06e7 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2527,12 +2527,14 @@ static struct symbol *symbol__new_unresolved(u64 addr, struct map *map)
 	if (sym) {
 		src = symbol__hists(sym, 1);
 		if (!src) {
-			symbol__delete(sym);
+			symbol__put(sym);
 			return NULL;
 		}
 
-		if (dso__insert_symbol(map__dso(map), sym))
+		if (dso__insert_symbol(map__dso(map), symbol__get(sym))) {
+			symbol__put(sym);
 			return NULL;
+		}
 	}
 
 	return sym;
@@ -2819,7 +2821,7 @@ add_script_opt_2(struct popup_action *act, char **optstr,
 	}
 
 	act->ms.thread = thread__get(thread);
-	act->ms.sym = sym;
+	act->ms.sym = symbol__get(sym);
 	act->fn = do_run_script;
 	return 1;
 }
@@ -3208,6 +3210,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 
 				memset(&hotkey_act, 0, sizeof(hotkey_act));
 				map_symbol__copy(&hotkey_act.ms, &source_ms);
+				symbol__zput(source_ms.sym);
 				do_annotate(browser, &hotkey_act);
 				map_symbol__exit(&hotkey_act.ms);
 			} else {
@@ -3410,7 +3413,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 						       &options[nr_options],
 						       &bi->from.ms,
 						       bi->from.al_addr);
-			if (bi->to.ms.sym != bi->from.ms.sym)
+			if (!RC_CHK_EQUAL(bi->to.ms.sym, bi->from.ms.sym))
 				nr_options += add_annotate_opt(&actions[nr_options],
 							&options[nr_options],
 							&bi->to.ms,
diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index 71f6161ed27a..3ef62c512355 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -64,12 +64,13 @@ static int map_browser__search(struct map_browser *browser)
 		 * cursor at that entry.
 		 */
 		for (u32 idx = 0; idx < browser->b.nr_entries; ++idx) {
-			if (entries[idx] == sym) {
+			if (RC_CHK_EQUAL(entries[idx], sym)) {
 				browser->b.top = &entries[idx];
 				browser->b.index = browser->b.top_idx = idx;
 				break;
 			}
 		}
+		symbol__put(sym);
 	} else
 		ui_helpline__fpush("%s not found!", target);
 
@@ -135,7 +136,7 @@ int map__browse(struct map *map)
 			for (unsigned int idx = 0; idx < nr_entries; idx++) {
 				struct symbol *pos = symbols->symbols[idx];
 
-				entries[idx] = pos;
+				entries[idx] = symbol__get(pos);
 				if (maxaddr < symbol__end(pos))
 					maxaddr = symbol__end(pos);
 			}
@@ -150,6 +151,8 @@ int map__browse(struct map *map)
 
 	mb.addrlen = snprintf(tmp, sizeof(tmp), "%" PRIx64, maxaddr);
 	ret = map_browser__run(&mb);
+	for (unsigned int idx = 0; idx < nr_entries; idx++)
+		symbol__put(entries[idx]);
 	free(entries);
 	return ret;
 }
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index f80cc73909ed..aedc5eb8b1a4 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -908,7 +908,8 @@ size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 
 	free(line);
 out:
-	zfree(&rem_sq_bracket);
+	symbol__zput(rem_sq_bracket);
+	rem_hits.ms.sym = NULL;
 
 	return ret;
 }
diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
index 960dd48701bb..2afa8719ac41 100644
--- a/tools/perf/util/addr2line.c
+++ b/tools/perf/util/addr2line.c
@@ -274,8 +274,14 @@ static int inline_list__append_record(struct dso *dso,
 				      unsigned int line_nr)
 {
 	struct symbol *inline_sym = new_inline_sym(dso, sym, function);
+	char *srcline = srcline_from_fileline(filename, line_nr);
 
-	return inline_list__append(inline_sym, srcline_from_fileline(filename, line_nr), node);
+	if (inline_list__append(inline_sym, srcline, node) != 0) {
+		zfree_srcline(&srcline);
+		symbol__put(inline_sym);
+		return -1;
+	}
+	return 0;
 }
 
 int cmd__addr2line(const char *dso_name, u64 addr,
diff --git a/tools/perf/util/addr_location.c b/tools/perf/util/addr_location.c
index 57e8217a00f9..0f21a01a3843 100644
--- a/tools/perf/util/addr_location.c
+++ b/tools/perf/util/addr_location.c
@@ -2,6 +2,7 @@
 #include "addr_location.h"
 #include "map.h"
 #include "maps.h"
+#include "symbol.h"
 #include "thread.h"
 
 void addr_location__init(struct addr_location *al)
@@ -29,13 +30,16 @@ void addr_location__exit(struct addr_location *al)
 {
 	map__zput(al->map);
 	thread__zput(al->thread);
+	symbol__zput(al->sym);
 }
 
 void addr_location__copy(struct addr_location *dst, struct addr_location *src)
 {
 	thread__put(dst->thread);
 	map__put(dst->map);
+	symbol__put(dst->sym);
 	*dst = *src;
 	dst->thread = thread__get(src->thread);
 	dst->map = map__get(src->map);
+	dst->sym = symbol__get(src->sym);
 }
diff --git a/tools/perf/util/annotate-arch/annotate-alpha.c b/tools/perf/util/annotate-arch/annotate-alpha.c
index ccb13e2338a2..fc4fcbf27c82 100644
--- a/tools/perf/util/annotate-arch/annotate-alpha.c
+++ b/tools/perf/util/annotate-arch/annotate-alpha.c
@@ -88,8 +88,9 @@ static int alpha_call__parse(const struct arch *arch, struct ins_operands *ops,
 
 	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map,
-			      map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
-		ops->target.sym = target.ms.sym;
+			      map__map_ip(target.ms.map, target.addr)) == ops->target.addr &&
+	    !RC_CHK_EQUAL(target.ms.sym, ms->sym))
+		ops->target.sym = symbol__get(target.ms.sym);
 
 	addr_map_symbol__exit(&target);
 	return 0;
diff --git a/tools/perf/util/annotate-arch/annotate-loongarch.c b/tools/perf/util/annotate-arch/annotate-loongarch.c
index d275730080b7..775bf44ce495 100644
--- a/tools/perf/util/annotate-arch/annotate-loongarch.c
+++ b/tools/perf/util/annotate-arch/annotate-loongarch.c
@@ -56,8 +56,10 @@ static int loongarch_call__parse(const struct arch *arch, struct ins_operands *o
 	};
 
 	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
-	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
-		ops->target.sym = target.ms.sym;
+	    map__rip_2objdump(target.ms.map,
+			      map__map_ip(target.ms.map, target.addr)) == ops->target.addr &&
+	    !RC_CHK_EQUAL(target.ms.sym, ms->sym))
+		ops->target.sym = symbol__get(target.ms.sym);
 
 	addr_map_symbol__exit(&target);
 	return 0;
@@ -99,9 +101,10 @@ static int loongarch_jump__parse(const struct arch *arch, struct ins_operands *o
 
 	ops->target.outside = target.addr < start || target.addr >= end;
 
-	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
+	if (ops->target.outside &&
+	    maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
-		ops->target.sym = target.ms.sym;
+		ops->target.sym = symbol__get(target.ms.sym);
 
 	if (!ops->target.outside) {
 		ops->target.offset = target.addr - start;
diff --git a/tools/perf/util/annotate-arch/annotate-s390.c b/tools/perf/util/annotate-arch/annotate-s390.c
index af9cabd0a586..ae88e556ee89 100644
--- a/tools/perf/util/annotate-arch/annotate-s390.c
+++ b/tools/perf/util/annotate-arch/annotate-s390.c
@@ -51,8 +51,10 @@ static int s390_call__parse(const struct arch *arch, struct ins_operands *ops,
 	};
 
 	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
-	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
-		ops->target.sym = target.ms.sym;
+	    map__rip_2objdump(target.ms.map,
+			      map__map_ip(target.ms.map, target.addr)) == ops->target.addr &&
+	    !RC_CHK_EQUAL(target.ms.sym, ms->sym))
+		ops->target.sym = symbol__get(target.ms.sym);
 
 	addr_map_symbol__exit(&target);
 	return 0;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e4332800fda4..bb9962fec076 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -198,15 +198,22 @@ static bool sym_ptr_equal(long key1, long key2, void *ctx __maybe_unused)
 struct annotation *symbol__annotation(struct symbol *sym)
 {
 	struct annotation *notes = NULL;
-	long val = 0;
+	long key, val = 0;
 
 	if (!sym)
 		return NULL;
 
+	/*
+	 * Key on the underlying RC_STRUCT(symbol) pointer so all
+	 * REFCNT_CHECKING wrapper pointers for the same symbol map to the
+	 * same annotation entry.
+	 */
+	key = (long)RC_CHK_ACCESS(sym);
+
 	/* Fast path: look up existing annotation under read lock if flagged. */
 	if (symbol__annotated(sym)) {
 		down_read(annotations_lock());
-		if (annotations && hashmap__find(annotations, (long)sym, &val))
+		if (annotations && hashmap__find(annotations, key, &val))
 			notes = (struct annotation *)val;
 		up_read(annotations_lock());
 		if (notes)
@@ -221,7 +228,7 @@ struct annotation *symbol__annotation(struct symbol *sym)
 			up_write(annotations_lock());
 			return &empty_annotation;
 		}
-	} else if (hashmap__find(annotations, (long)sym, &val)) {
+	} else if (hashmap__find(annotations, key, &val)) {
 		notes = (struct annotation *)val;
 		up_write(annotations_lock());
 		return notes;
@@ -233,7 +240,7 @@ struct annotation *symbol__annotation(struct symbol *sym)
 		return &empty_annotation;
 	}
 	annotation__init(notes);
-	if (hashmap__add(annotations, (long)sym, notes) < 0) {
+	if (hashmap__add(annotations, key, notes) < 0) {
 		free(notes);
 		if (hashmap__size(annotations) == 0) {
 			hashmap__free(annotations);
@@ -250,14 +257,15 @@ struct annotation *symbol__annotation(struct symbol *sym)
 void symbol__annotation_delete(struct symbol *sym)
 {
 	struct annotation *notes = NULL;
-	long val = 0;
+	long key, val = 0;
 
 	/* Unannotated symbols avoid taking annotations_lock on teardown. */
 	if (!sym || !symbol__annotated(sym))
 		return;
 
+	key = (long)RC_CHK_ACCESS(sym);
 	down_write(annotations_lock());
-	if (annotations && hashmap__delete(annotations, (long)sym, NULL, &val)) {
+	if (annotations && hashmap__delete(annotations, key, NULL, &val)) {
 		notes = (struct annotation *)val;
 		if (hashmap__size(annotations) == 0) {
 			hashmap__free(annotations);
@@ -571,7 +579,7 @@ int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 	 * it starts on the function start.
 	 */
 	if (start &&
-		(start->ms.sym == ams->ms.sym ||
+		(RC_CHK_EQUAL(start->ms.sym, ams->ms.sym) ||
 		 (ams->ms.sym &&
 		  start->addr == symbol__start(ams->ms.sym) + map__start(ams->ms.map))))
 		saddr = start->al_addr;
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index f6ac71a74e6d..bdd7f17ad70c 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -64,8 +64,10 @@ static struct block_info *block_info__new(unsigned int br_cntr_nr)
 
 void block_info__delete(struct block_info *bi)
 {
-	if (bi)
+	if (bi) {
+		symbol__zput(bi->sym);
 		free(bi->br_cntr);
+	}
 	free(bi);
 }
 
@@ -105,7 +107,7 @@ static void init_block_info(struct block_info *bi, struct symbol *sym,
 			    u64 total_cycles, unsigned int br_cntr_nr,
 			    u64 *br_cntr, struct evsel *evsel)
 {
-	bi->sym = sym;
+	bi->sym = symbol__get(sym);
 	bi->start = ch->start;
 	bi->end = offset;
 	bi->cycles = ch->cycles;
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 2b799bf7a9a2..cb4a2546364b 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -144,6 +144,7 @@ static void init_numa_data(struct lock_contention *con)
 						  &kmap);
 	if (sym) {
 		skel->rodata->contig_page_data_addr = map__unmap_ip(kmap, symbol__start(sym));
+		symbol__put(sym);
 		map__put(kmap);
 		return;
 	}
@@ -160,6 +161,7 @@ static void init_numa_data(struct lock_contention *con)
 		return;
 
 	skel->rodata->node_data_addr = map__unmap_ip(kmap, symbol__start(sym));
+	symbol__put(sym);
 	map__put(kmap);
 
 	/* get the number of online nodes using the last node number + 1 */
@@ -263,11 +265,15 @@ int lock_contention_prepare(struct lock_contention *con)
 					(con->filters->nr_addrs + 1) * sizeof(*addrs));
 			if (addrs == NULL) {
 				pr_warning("memory allocation failure\n");
+				symbol__put(sym);
+				map__put(kmap);
 				continue;
 			}
 
 			addrs[con->filters->nr_addrs++] = map__unmap_ip(kmap, symbol__start(sym));
 			con->filters->addrs = addrs;
+			symbol__put(sym);
+			map__put(kmap);
 		}
 		naddrs = con->filters->nr_addrs ?: has_mmap_lock;
 		skel->rodata->has_addr = 1;
@@ -289,6 +295,8 @@ int lock_contention_prepare(struct lock_contention *con)
 			}
 
 			con->delays[i].addr = map__unmap_ip(kmap, symbol__start(sym));
+			symbol__put(sym);
+			map__put(kmap);
 		}
 		skel->rodata->lock_delay = 1;
 		bpf_map__set_max_entries(skel->maps.lock_delays, con->nr_delays);
@@ -606,9 +614,12 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 			return "siglock";
 
 		/* global locks with symbols */
-		sym = machine__find_kernel_symbol(machine, key->lock_addr_or_cgroup, &kmap);
-		if (sym)
-			return symbol__name(sym);
+		sym = machine__find_kernel_symbol(machine, key->lock_addr_or_cgroup, NULL);
+		if (sym) {
+			snprintf(name_buf, sizeof(name_buf), "%s", symbol__name(sym));
+			symbol__put(sym);
+			return name_buf;
+		}
 
 		/* try semi-global locks collected separately */
 		if (!bpf_map_lookup_elem(lock_fd, &key->lock_addr_or_cgroup, &flags)) {
@@ -655,12 +666,14 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 		offset = map__map_ip(kmap, addr) - symbol__start(sym);
 
 		if (offset == 0)
-			return symbol__name(sym);
-
-		snprintf(name_buf, sizeof(name_buf), "%s+%#lx", symbol__name(sym), offset);
+			snprintf(name_buf, sizeof(name_buf), "%s", symbol__name(sym));
+		else
+			snprintf(name_buf, sizeof(name_buf), "%s+%#lx", symbol__name(sym), offset);
+		symbol__put(sym);
 	} else {
 		snprintf(name_buf, sizeof(name_buf), "%#lx", (unsigned long)addr);
 	}
+	map__put(kmap);
 
 	return name_buf;
 }
diff --git a/tools/perf/util/c2c-function.c b/tools/perf/util/c2c-function.c
index b548c76e3016..70f96adc6dc1 100644
--- a/tools/perf/util/c2c-function.c
+++ b/tools/perf/util/c2c-function.c
@@ -976,13 +976,13 @@ c2c_function_hists__level1_entry(struct symbol *sym,
 	/* mem_info__put() will map_symbol__exit() these, so take refs. */
 	mem_info__iaddr(mi)->ms.thread = thread__get(detail_he->ms.thread);
 	mem_info__iaddr(mi)->ms.map = map__get(detail_he->ms.map);
-	mem_info__iaddr(mi)->ms.sym = sym;
+	mem_info__iaddr(mi)->ms.sym = symbol__get(sym);
 	mem_info__daddr(mi)->addr = 0;
 
 	addr_location__init(&al);
 	al.thread = thread__get(synthetic_thread);
 	al.map = map__get(detail_he->ms.map);
-	al.sym = sym;
+	al.sym = symbol__get(sym);
 	al.addr = sym_start;
 	al.level = detail_he->level;
 	al.cpumode = detail_he->cpumode;
@@ -1064,9 +1064,12 @@ c2c_function_hists__level2_entry(struct c2c_hist_entry *level1_c2c,
 		return NULL;
 
 	/* Key this level by the looked-up symbol, not detail_he's. */
-	level2_c2c->he.ms.sym = sym;
-	if (level2_c2c->he.mem_info)
-		mem_info__iaddr(level2_c2c->he.mem_info)->ms.sym = sym;
+	symbol__put(level2_c2c->he.ms.sym);
+	level2_c2c->he.ms.sym = symbol__get(sym);
+	if (level2_c2c->he.mem_info) {
+		symbol__put(mem_info__iaddr(level2_c2c->he.mem_info)->ms.sym);
+		mem_info__iaddr(level2_c2c->he.mem_info)->ms.sym = symbol__get(sym);
+	}
 
 	c2c_child_entry__insert(level1_he, &level2_c2c->he, p, parent, leftmost);
 
diff --git a/tools/perf/util/call-path.c b/tools/perf/util/call-path.c
index 5c60b8be1cf6..5927068fd9b6 100644
--- a/tools/perf/util/call-path.c
+++ b/tools/perf/util/call-path.c
@@ -10,12 +10,13 @@
 #include <stdlib.h>
 
 #include "call-path.h"
+#include "symbol.h"
 
 static void call_path__init(struct call_path *cp, struct call_path *parent,
 			    struct symbol *sym, u64 ip, bool in_kernel)
 {
 	cp->parent = parent;
-	cp->sym = sym;
+	cp->sym = symbol__get(sym);
 	cp->ip = sym ? 0 : ip;
 	cp->db_id = 0;
 	cp->in_kernel = in_kernel;
@@ -38,8 +39,15 @@ struct call_path_root *call_path_root__new(void)
 void call_path_root__free(struct call_path_root *cpr)
 {
 	struct call_path_block *pos, *n;
+	size_t i = 0;
 
+	if (!cpr)
+		return;
+
+	symbol__zput(cpr->call_path.sym);
 	list_for_each_entry_safe(pos, n, &cpr->blocks, node) {
+		for (size_t j = 0; j < CALL_PATH_BLOCK_SIZE && i < cpr->next; j++, i++)
+			symbol__zput(pos->cp[j].sym);
 		list_del_init(&pos->node);
 		free(pos);
 	}
@@ -94,10 +102,11 @@ struct call_path *call_path__findnew(struct call_path_root *cpr,
 		node_parent = *p;
 		cp = rb_entry(node_parent, struct call_path, rb_node);
 
-		if (cp->sym == sym && cp->ip == ip)
+		if (RC_CHK_EQUAL(cp->sym, sym) && cp->ip == ip)
 			return cp;
 
-		if (sym < cp->sym || (sym == cp->sym && ip < cp->ip))
+		if ((sym ? RC_CHK_ACCESS(sym) : NULL) < (cp->sym ? RC_CHK_ACCESS(cp->sym) : NULL) ||
+		    (RC_CHK_EQUAL(sym, cp->sym) && ip < cp->ip))
 			p = &(*p)->rb_left;
 		else
 			p = &(*p)->rb_right;
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 24c176905c0e..fdb9a7b8639f 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1094,6 +1094,7 @@ merge_chain_branch(struct callchain_cursor *cursor,
 		struct map_symbol ms = {
 			.thread = thread__get(list->ms.thread),
 			.map = map__get(list->ms.map),
+			.sym = symbol__get(list->ms.sym),
 		};
 		callchain_cursor_append(cursor, list->ip, &ms, false, NULL, 0, 0, 0, list->srcline);
 		list_del_init(&list->list);
@@ -1204,7 +1205,8 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 
 	map__put(al->map);
 	al->map = map__get(node->ms.map);
-	al->sym = node->ms.sym;
+	symbol__put(al->sym);
+	al->sym = symbol__get(node->ms.sym);
 	al->srcline = node->srcline;
 	al->addr = node->ip;
 
diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 422a48385b78..8178d5a52bcd 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -373,6 +373,7 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
 			scnprintf(buf, len, "\t# %"PRIx64" <%s+%#"PRIx64">",
 				  orig_addr, symbol__name(sym), sym_offset);
 		}
+		symbol__put(sym);
 		map__put(found_map);
 		break;
 	}
@@ -459,6 +460,7 @@ static void format_capstone_insn_arm64(struct cs_insn *insn, char *buf,
 			scnprintf(last_imm, len, "%"PRIx64" <%s+%#"PRIx64">",
 				  addr, symbol__name(sym), sym_offset);
 		}
+		symbol__put(sym);
 		map__put(found_map);
 	}
 }
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 97ce6061a77d..f520c3b93a7e 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -13,6 +13,8 @@
 
 #include <linux/err.h>
 
+#include <internal/rc_check.h>
+
 #include "call-path.h"
 #include "callchain.h"
 #include "comm.h"
@@ -26,14 +28,24 @@
 #include "thread-stack.h"
 #include "thread.h"
 
+/*
+ * Hash and compare the underlying RC_STRUCT(symbol) pointer so all
+ * REFCNT_CHECKING wrapper pointers for the same symbol resolve to the same
+ * exported database ID.
+ */
 static size_t sym_ptr_hash(long key, void *ctx __maybe_unused)
 {
-	return hash_bits((size_t)key, 16);
+	const struct symbol *sym = (const struct symbol *)key;
+
+	return hash_bits((size_t)RC_CHK_ACCESS(sym), 16);
 }
 
 static bool sym_ptr_equal(long key1, long key2, void *ctx __maybe_unused)
 {
-	return key1 == key2;
+	const struct symbol *sym1 = (const struct symbol *)key1;
+	const struct symbol *sym2 = (const struct symbol *)key2;
+
+	return RC_CHK_EQUAL(sym1, sym2);
 }
 
 int db_export__init(struct db_export *dbe)
@@ -44,8 +56,15 @@ int db_export__init(struct db_export *dbe)
 
 void db_export__exit(struct db_export *dbe)
 {
-	hashmap__free(dbe->sym_db_ids);
-	dbe->sym_db_ids = NULL;
+	if (dbe->sym_db_ids) {
+		struct hashmap_entry *cur;
+		size_t bkt;
+
+		hashmap__for_each_entry(dbe->sym_db_ids, cur, bkt)
+			symbol__put((struct symbol *)cur->pkey);
+		hashmap__free(dbe->sym_db_ids);
+		dbe->sym_db_ids = NULL;
+	}
 	call_return_processor__free(dbe->crp);
 	dbe->crp = NULL;
 }
@@ -191,6 +210,7 @@ int db_export__symbol(struct db_export *dbe, struct symbol *sym,
 		      struct dso *dso)
 {
 	long db_id;
+	struct symbol *sym_key;
 
 	if (db_export__symbol_db_id(dbe, sym))
 		return 0;
@@ -207,8 +227,11 @@ int db_export__symbol(struct db_export *dbe, struct symbol *sym,
 	}
 
 	db_id = ++dbe->symbol_last_db_id;
-	if (hashmap__set(dbe->sym_db_ids, (long)sym, db_id, NULL, NULL))
+	sym_key = symbol__get(sym);
+	if (hashmap__set(dbe->sym_db_ids, (long)sym_key, db_id, NULL, NULL)) {
+		symbol__put(sym_key);
 		return -ENOMEM;
+	}
 
 	if (dbe->export_symbol)
 		return dbe->export_symbol(dbe, sym, dso);
@@ -231,8 +254,8 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 
 		if (!al->sym) {
 			al->sym = symbol__new(al->addr, 0, 0, 0, "unknown");
-			if (al->sym && dso__insert_symbol(dso, al->sym))
-				al->sym = NULL;
+			if (al->sym && dso__insert_symbol(dso, symbol__get(al->sym)))
+				symbol__zput(al->sym);
 		}
 
 		if (al->sym) {
@@ -292,7 +315,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 		 * db_ids_from_al() to perform the export.
 		 */
 		addr_location__init(&al);
-		al.sym = node->ms.sym;
+		al.sym = symbol__get(node->ms.sym);
 		al.map = map__get(node->ms.map);
 		al.addr = node->ip;
 		al.thread = thread__get(thread);
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 9b3e476bab6d..1a96e02e9288 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -228,6 +228,7 @@ static void ins_ops__delete(struct ins_operands *ops)
 	zfree(&ops->source.name);
 	zfree(&ops->target.raw);
 	zfree(&ops->target.name);
+	symbol__zput(ops->target.sym);
 }
 
 int ins__raw_scnprintf(const struct ins *ins, char *bf, size_t size,
@@ -289,8 +290,10 @@ static int call__parse(const struct arch *arch, struct ins_operands *ops, struct
 	};
 
 	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
-	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
-		ops->target.sym = target.ms.sym;
+	    map__rip_2objdump(target.ms.map,
+			      map__map_ip(target.ms.map, target.addr)) == ops->target.addr &&
+	    !RC_CHK_EQUAL(target.ms.sym, ms->sym))
+		ops->target.sym = symbol__get(target.ms.sym);
 
 	addr_map_symbol__exit(&target);
 	return 0;
@@ -424,9 +427,10 @@ static int jump__parse(const struct arch *arch, struct ins_operands *ops, struct
 	 * Actual navigation will come next, with further understanding of how
 	 * the symbol searching and disassembly should be done.
 	 */
-	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
+	if (ops->target.outside &&
+	    maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
-		ops->target.sym = target.ms.sym;
+		ops->target.sym = symbol__get(target.ms.sym);
 
 	if (!ops->target.outside) {
 		ops->target.offset = target.addr - start;
@@ -473,12 +477,14 @@ int jump__scnprintf(const struct ins *ins, char *bf, size_t size,
 			 ops->target.offset);
 }
 
-void jump__delete(struct ins_operands *ops __maybe_unused)
+void jump__delete(struct ins_operands *ops)
 {
 	/*
 	 * The ops->jump.raw_comment and ops->jump.raw_func_start belong to the
 	 * raw string, don't free them.
 	 */
+	if (ops)
+		symbol__zput(ops->target.sym);
 }
 
 const struct ins_ops jump_ops = {
@@ -572,6 +578,7 @@ static void lock__delete(struct ins_operands *ops)
 	zfree(&ops->locked.ins.name);
 	zfree(&ops->target.raw);
 	zfree(&ops->target.name);
+	symbol__zput(ops->target.sym);
 }
 
 const struct ins_ops lock_ops = {
@@ -1090,8 +1097,9 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 		};
 
 		if (!maps__find_ams(thread__maps(args->ms->thread), &target) &&
-		    symbol__start(target.ms.sym) == target.al_addr)
-			dl->ops.target.sym = target.ms.sym;
+		    symbol__start(target.ms.sym) == target.al_addr &&
+		    !RC_CHK_EQUAL(target.ms.sym, sym))
+			dl->ops.target.sym = symbol__get(target.ms.sym);
 
 		addr_map_symbol__exit(&target);
 	}
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 939307796a88..a71267af4f3c 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -770,7 +770,7 @@ struct map *thread__find_map_fb(struct thread *thread, u8 cpumode, u64 addr,
 struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 				   u64 addr, struct addr_location *al)
 {
-	al->sym = NULL;
+	symbol__zput(al->sym);
 	if (thread__find_map(thread, cpumode, addr, al))
 		al->sym = map__find_symbol(al->map, al->addr);
 	return al->sym;
@@ -779,7 +779,7 @@ struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
 				      u64 addr, struct addr_location *al)
 {
-	al->sym = NULL;
+	symbol__zput(al->sym);
 	if (thread__find_map_fb(thread, cpumode, addr, al))
 		al->sym = map__find_symbol(al->map, al->addr);
 	return al->sym;
@@ -829,7 +829,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 	thread__put(thread);
 	thread = NULL;
 
-	al->sym = NULL;
+	symbol__zput(al->sym);
 	al->cpu = sample->cpu;
 	al->socket = -1;
 	al->srcline = NULL;
@@ -937,7 +937,7 @@ void thread__resolve(struct thread *thread, struct addr_location *al,
 	thread__find_map_fb(thread, sample->cpumode, sample->addr, al);
 
 	al->cpu = sample->cpu;
-	al->sym = NULL;
+	symbol__zput(al->sym);
 
 	if (al->map)
 		al->sym = map__find_symbol(al->map, al->addr);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 8a1a5e36d7cd..badae244638c 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -543,6 +543,7 @@ static int hist_entry__init(struct hist_entry *he,
 
 	he->ms.thread = thread__get(he->ms.thread);
 	he->ms.map = map__get(he->ms.map);
+	he->ms.sym = symbol__get(he->ms.sym);
 
 	if (he->branch_info) {
 		/*
@@ -559,8 +560,10 @@ static int hist_entry__init(struct hist_entry *he,
 
 		he->branch_info->from.ms.thread = thread__get(he->branch_info->from.ms.thread);
 		he->branch_info->from.ms.map = map__get(he->branch_info->from.ms.map);
+		he->branch_info->from.ms.sym = symbol__get(he->branch_info->from.ms.sym);
 		he->branch_info->to.ms.thread = thread__get(he->branch_info->to.ms.thread);
 		he->branch_info->to.ms.map = map__get(he->branch_info->to.ms.map);
+		he->branch_info->to.ms.sym = symbol__get(he->branch_info->to.ms.sym);
 	}
 
 	if (he->mem_info) {
@@ -593,6 +596,7 @@ static int hist_entry__init(struct hist_entry *he,
 
 	INIT_LIST_HEAD(&he->pairs.node);
 	he->thread = thread__get(he->thread);
+	he->parent = symbol__get(he->parent);
 	he->hroot_in  = RB_ROOT_CACHED;
 	he->hroot_out = RB_ROOT_CACHED;
 
@@ -728,6 +732,8 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 			if (hists__has(hists, sym) && he->ms.map != entry->ms.map) {
 				if (he->ms.sym) {
 					u64 addr = symbol__start(he->ms.sym);
+
+					symbol__put(he->ms.sym);
 					he->ms.sym = map__find_symbol(entry->ms.map, addr);
 				}
 
@@ -1029,7 +1035,8 @@ iter_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *al)
 	al->thread = thread__get(bi[i].to.ms.thread);
 	map__put(al->map);
 	al->map = map__get(bi[i].to.ms.map);
-	al->sym = bi[i].to.ms.sym;
+	symbol__put(al->sym);
+	al->sym = symbol__get(bi[i].to.ms.sym);
 	al->addr = bi[i].to.addr;
 	return 1;
 }
@@ -1343,9 +1350,11 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 	if (al)
 		alm = map__get(al->map);
 
+	iter->parent = NULL;
 	err = sample__resolve_callchain(iter->sample, get_tls_callchain_cursor(), &iter->parent,
 					al, max_stack_depth);
 	if (err) {
+		symbol__zput(iter->parent);
 		map__put(alm);
 		return err;
 	}
@@ -1381,6 +1390,7 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 	if (!err)
 		err = err2;
 
+	symbol__zput(iter->parent);
 	map__put(alm);
 
 	return err;
@@ -1467,6 +1477,7 @@ void hist_entry__delete(struct hist_entry *he)
 	}
 
 	thread__zput(he->thread);
+	symbol__zput(he->parent);
 	map_symbol__exit(&he->ms);
 
 	if (he->branch_info) {
diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index 5e947271e388..a88a89e09545 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -246,7 +246,12 @@ static int inline_list__append_dso_a2l(struct dso *dso,
 	if (a2l->filename)
 		srcline = srcline_from_fileline(a2l->filename, a2l->line);
 
-	return inline_list__append(inline_sym, srcline, node);
+	if (inline_list__append(inline_sym, srcline, node) != 0) {
+		zfree_srcline(&srcline);
+		symbol__put(inline_sym);
+		return -1;
+	}
+	return 0;
 }
 
 int libbfd__addr2line(const char *dso_name, u64 addr,
diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
index e660623338d5..3b14a3ad6f86 100644
--- a/tools/perf/util/libdw.c
+++ b/tools/perf/util/libdw.c
@@ -99,7 +99,7 @@ static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
 		 * while DWARF keeps the pre-clone linkage name, which
 		 * left the outer frame spuriously tagged "(inlined)".
 		 */
-		inline_sym = args->sym;
+		inline_sym = symbol__get(args->sym);
 	} else {
 		/*
 		 * Prefer DW_AT_linkage_name so C++ inline frames keep
@@ -157,8 +157,7 @@ static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
 	return 0;
 
 abort_delete_sym:
-	if (symbol__inlined(inline_sym))
-		symbol__delete(inline_sym);
+	symbol__put(inline_sym);
 abort_enomem:
 	args->err = -ENOMEM;
 	return DWARF_CB_ABORT;
diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index 7429e8ef6cce..754c9ec18a11 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -63,6 +63,8 @@ int llvm__addr2line(const char *dso_name __maybe_unused, u64 addr __maybe_unused
 						      inline_frames[i].line);
 		}
 		if (inline_list__append(inline_sym, srcline, node) != 0) {
+			zfree_srcline(&srcline);
+			symbol__put(inline_sym);
 			if (file)
 				zfree(file);
 			inline_node__clear_frames(node);
diff --git a/tools/perf/util/lock-contention.c b/tools/perf/util/lock-contention.c
index 8ee1b19a8292..367666028eb2 100644
--- a/tools/perf/util/lock-contention.c
+++ b/tools/perf/util/lock-contention.c
@@ -101,7 +101,6 @@ struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags)
 
 bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_stack_depth)
 {
-	struct map *kmap;
 	struct symbol *sym;
 	u64 ip;
 	uint16_t e_machine = perf_env__e_machine(machine->env, /*e_flags=*/NULL);
@@ -130,14 +129,17 @@ bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_sta
 			break;
 
 		ip = callstack[i];
-		sym = machine__find_kernel_symbol(machine, ip, &kmap);
+		sym = machine__find_kernel_symbol(machine, ip, NULL);
 		if (sym == NULL)
 			continue;
 
 		list_for_each_entry(filter, &callstack_filters, list) {
-			if (strstr(symbol__name(sym), filter->name))
+			if (strstr(symbol__name(sym), filter->name)) {
+				symbol__put(sym);
 				return true;
+			}
 		}
+		symbol__put(sym);
 	}
 	return false;
 }
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 14e93e7fb235..cb9e34220036 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -824,8 +824,10 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
 		struct dso *dso = map__dso(map);
 
 		sym = dso__find_symbol(dso, map__map_ip(map, map__start(map)));
-		if (sym)
+		if (sym) {
 			dso__delete_symbol(dso, sym);
+			symbol__put(sym);
+		}
 	}
 	map__put(map);
 	return 0;
@@ -2085,7 +2087,7 @@ static void ip__resolve_ams(struct thread *thread,
 	ams->al_addr = al.addr;
 	ams->al_level = al.level;
 	ams->ms.thread = thread__get(al.thread);
-	ams->ms.sym = al.sym;
+	ams->ms.sym = symbol__get(al.sym);
 	ams->ms.map = map__get(al.map);
 	ams->phys_addr = 0;
 	ams->data_page_size = 0;
@@ -2106,7 +2108,7 @@ static void ip__resolve_data(struct thread *thread,
 	ams->al_addr = al.addr;
 	ams->al_level = al.level;
 	ams->ms.thread = thread__get(al.thread);
-	ams->ms.sym = al.sym;
+	ams->ms.sym = symbol__get(al.sym);
 	ams->ms.map = map__get(al.map);
 	ams->phys_addr = phys_addr;
 	ams->data_page_size = daddr_page_size;
@@ -2192,7 +2194,8 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
 		.map = map__get(map),
 	};
 	list_for_each_entry(ilist, &inline_node->val, list) {
-		ilist_ms.sym = ilist->symbol;
+		symbol__put(ilist_ms.sym);
+		ilist_ms.sym = symbol__get(ilist->symbol);
 		if (first) {
 			ret = callchain_cursor_append(cursor, ip, &ilist_ms,
 						      branch, flags, nr_loop_iter,
@@ -2204,7 +2207,7 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
 		first = false;
 
 		if (ret != 0)
-			return ret;
+			break;
 	}
 	map_symbol__exit(&ilist_ms);
 
@@ -2270,7 +2273,7 @@ static int add_callchain_ip(struct thread *thread,
 	if (al.sym != NULL) {
 		if (perf_hpp_list.parent && !*parent &&
 		    symbol__match_regex(al.sym, &parent_regex))
-			*parent = al.sym;
+			*parent = symbol__get(al.sym);
 		else if (have_ignore_callees && root_al &&
 		  symbol__match_regex(al.sym, &ignore_callees_regex)) {
 			/* Treat this symbol as the root,
@@ -2290,7 +2293,7 @@ static int add_callchain_ip(struct thread *thread,
 
 	ms.thread = thread__get(al.thread);
 	ms.map = map__get(al.map);
-	ms.sym = al.sym;
+	ms.sym = symbol__get(al.sym);
 
 	if (append_inlines(cursor, &ms, ip, branch, flags, nr_loop_iter,
 			   iter_cycles, branch_from) == 0)
@@ -2451,8 +2454,7 @@ static void save_lbr_cursor_node(struct thread *thread,
 	map_symbol__exit(&lbr_stitch->prev_lbr_cursor[idx].ms);
 	memcpy(&lbr_stitch->prev_lbr_cursor[idx], cursor->curr,
 	       sizeof(struct callchain_cursor_node));
-	lbr_stitch->prev_lbr_cursor[idx].ms.thread = thread__get(cursor->curr->ms.thread);
-	lbr_stitch->prev_lbr_cursor[idx].ms.map = map__get(cursor->curr->ms.map);
+	map_symbol__copy(&lbr_stitch->prev_lbr_cursor[idx].ms, &cursor->curr->ms);
 
 	lbr_stitch->prev_lbr_cursor[idx].valid = true;
 	cursor->pos++;
@@ -2676,9 +2678,7 @@ static bool has_stitched_lbr(struct thread *thread,
 		memcpy(&stitch_node->cursor, &lbr_stitch->prev_lbr_cursor[i],
 		       sizeof(struct callchain_cursor_node));
 
-		stitch_node->cursor.ms.thread =
-			thread__get(lbr_stitch->prev_lbr_cursor[i].ms.thread);
-		stitch_node->cursor.ms.map = map__get(lbr_stitch->prev_lbr_cursor[i].ms.map);
+		map_symbol__copy(&stitch_node->cursor.ms, &lbr_stitch->prev_lbr_cursor[i].ms);
 
 		if (callee)
 			list_add(&stitch_node->node, &lbr_stitch->lists);
@@ -3281,16 +3281,28 @@ struct dso *machine__findnew_dso(struct machine *machine, const char *filename)
 
 char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, char **modp)
 {
+	static __thread char resolved_name[512];
+	static __thread char resolved_mod[PATH_MAX];
 	struct machine *machine = vmachine;
-	struct map *map;
+	struct map *map = NULL;
 	struct symbol *sym = machine__find_kernel_symbol(machine, *addrp, &map);
 
-	if (sym == NULL)
+	if (sym == NULL) {
+		map__put(map);
 		return NULL;
+	}
 
-	*modp = __map__is_kmodule(map) ? (char *)dso__short_name(map__dso(map)) : NULL;
+	if (__map__is_kmodule(map)) {
+		snprintf(resolved_mod, sizeof(resolved_mod), "%s", dso__short_name(map__dso(map)));
+		*modp = resolved_mod;
+	} else {
+		*modp = NULL;
+	}
 	*addrp = map__unmap_ip(map, symbol__start(sym));
-	return (char *)symbol__name(sym);
+	snprintf(resolved_name, sizeof(resolved_name), "%s", symbol__name(sym));
+	symbol__put(sym);
+	map__put(map);
+	return resolved_name;
 }
 
 struct machine__for_each_dso_cb_args {
@@ -3337,26 +3349,38 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 		}
 
 		machine->sched.text_start = map__unmap_ip(kmap, symbol__start(sym));
+		symbol__put(sym);
+		map__put(kmap);
 
 		/* should not fail from here */
 		sym = machine__find_kernel_symbol_by_name(machine, "__sched_text_end", &kmap);
 		machine->sched.text_end = map__unmap_ip(kmap, symbol__start(sym));
+		symbol__put(sym);
+		map__put(kmap);
 
 		sym = machine__find_kernel_symbol_by_name(machine, "__lock_text_start", &kmap);
 		machine->lock.text_start = map__unmap_ip(kmap, symbol__start(sym));
+		symbol__put(sym);
+		map__put(kmap);
 
 		sym = machine__find_kernel_symbol_by_name(machine, "__lock_text_end", &kmap);
 		machine->lock.text_end = map__unmap_ip(kmap, symbol__start(sym));
+		symbol__put(sym);
+		map__put(kmap);
 
 		sym = machine__find_kernel_symbol_by_name(machine, "__traceiter_contention_begin", &kmap);
 		if (sym) {
 			machine->traceiter.text_start = map__unmap_ip(kmap, symbol__start(sym));
 			machine->traceiter.text_end = map__unmap_ip(kmap, symbol__end(sym));
+			symbol__put(sym);
+			map__put(kmap);
 		}
 		sym = machine__find_kernel_symbol_by_name(machine, "trace_contention_begin", &kmap);
 		if (sym) {
 			machine->trace.text_start = map__unmap_ip(kmap, symbol__start(sym));
 			machine->trace.text_end = map__unmap_ip(kmap, symbol__end(sym));
+			symbol__put(sym);
+			map__put(kmap);
 		}
 	}
 
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 3d8f72e70d49..745eefa79c7f 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -160,13 +160,15 @@ struct thread;
  * @sym_name: the symbol name
  * @pos: the 'struct symbol *' to use as a loop cursor
  * @idx: the cursor index in the symbol names array
+ * Note: caller must call symbol__put(pos) if breaking out of the loop early.
  */
 #define __map__for_each_symbol_by_name(map, sym_name, pos, idx)		\
 	for (pos = map__find_symbol_by_name_idx(map, sym_name, &idx);	\
-	     pos &&						\
-	     !symbol__match_symbol_name(symbol__name(pos), sym_name,	\
-					SYMBOL_TAG_INCLUDE__DEFAULT_ONLY); \
-	     pos = dso__next_symbol_by_name(map__dso(map), &idx))
+	     pos &&							\
+	     (!symbol__match_symbol_name(symbol__name(pos), sym_name,	\
+					 SYMBOL_TAG_INCLUDE__DEFAULT_ONLY) || \
+	      (symbol__zput(pos), false));				\
+	     symbol__put(pos), pos = dso__next_symbol_by_name(map__dso(map), &idx))
 
 #define map__for_each_symbol_by_name(map, sym_name, pos, idx)	\
 	__map__for_each_symbol_by_name(map, sym_name, (pos), idx)
diff --git a/tools/perf/util/map_symbol.c b/tools/perf/util/map_symbol.c
index 11bc0a7f704c..d1ee4e05564e 100644
--- a/tools/perf/util/map_symbol.c
+++ b/tools/perf/util/map_symbol.c
@@ -2,12 +2,14 @@
 #include "map_symbol.h"
 #include "maps.h"
 #include "map.h"
+#include "symbol.h"
 #include "thread.h"
 
 void map_symbol__exit(struct map_symbol *ms)
 {
 	thread__zput(ms->thread);
 	map__zput(ms->map);
+	symbol__zput(ms->sym);
 }
 
 void addr_map_symbol__exit(struct addr_map_symbol *ams)
@@ -19,7 +21,7 @@ void map_symbol__copy(struct map_symbol *dst, struct map_symbol *src)
 {
 	dst->thread = thread__get(src->thread);
 	dst->map = map__get(src->map);
-	dst->sym = src->sym;
+	dst->sym = symbol__get(src->sym);
 }
 
 void addr_map_symbol__copy(struct addr_map_symbol *dst, struct addr_map_symbol *src)
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index f808df2fe77b..a6cbe65cc5ca 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -788,7 +788,7 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, st
 				*mapp = map__get(map);
 			break;
 		}
-		sym = NULL;
+		symbol__zput(sym);
 	}
 
 	for (unsigned int i = 0; i < nr_maps; i++)
@@ -810,6 +810,7 @@ int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
 	}
 
 	ams->al_addr = map__map_ip(ams->ms.map, ams->addr);
+	symbol__put(ams->ms.sym);
 	ams->ms.sym = map__find_symbol(ams->ms.map, ams->al_addr);
 
 	return ams->ms.sym ? 0 : -1;
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index bea7903a11e3..a02ec8a7c058 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -152,6 +152,8 @@ static int kernel_get_symbol_address_by_name(const char *name, u64 *addr,
 		*addr = map__unmap_ip(map, symbol__start(sym)) -
 			((reloc) ? 0 : map__reloc(map)) -
 			((reladdr) ? map__start(map) : 0);
+		symbol__put(sym);
+		map__put(map);
 	}
 	return 0;
 }
@@ -422,6 +424,7 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
 					   pp->function);
 		} else
 			address = map__unmap_ip(map, symbol__start(sym)) - map__reloc(map);
+		symbol__put(sym);
 		break;
 	}
 	if (!address) {
@@ -728,11 +731,14 @@ static int post_process_probe_trace_point(struct probe_trace_point *tp,
 		else
 			free(tp->symbol);
 		tp->symbol = strdup(symbol__name(sym));
-		if (!tp->symbol)
+		if (!tp->symbol) {
+			symbol__put(sym);
 			return -ENOMEM;
+		}
 	}
 	tp->offset = addr - symbol__start(sym);
 	tp->address -= offs;
+	symbol__put(sym);
 
 	return 0;
 }
@@ -2314,6 +2320,7 @@ static int find_perf_probe_point_from_map(struct probe_trace_point *tp,
 	ret = pp->function ? 0 : -ENOMEM;
 
 out:
+	symbol__put(sym);
 	map__put(map);
 
 	return ret;
@@ -3078,7 +3085,7 @@ static int find_probe_functions_cb(struct symbol *sym, void *data)
 	if (strglobmatch(norm, args->name)) {
 		args->found++;
 		if (args->syms && args->found < probe_conf.max_probes)
-			args->syms[args->found - 1] = sym;
+			args->syms[args->found - 1] = symbol__get(sym);
 	}
 	free(buf);
 	return 0;
@@ -3146,7 +3153,7 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 		goto out;
 	}
 
-	syms = malloc(sizeof(struct symbol *) * probe_conf.max_probes);
+	syms = calloc(probe_conf.max_probes, sizeof(struct symbol *));
 	if (!syms) {
 		ret = -ENOMEM;
 		goto out;
@@ -3290,6 +3297,10 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 	}
 
 out:
+	if (syms) {
+		for (i = 0; i < probe_conf.max_probes; i++)
+			symbol__put(syms[i]);
+	}
 	map__put(map);
 	free(syms);
 	return ret;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 71ff233553cc..668bf23c166f 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -882,7 +882,7 @@ static PyObject *pyrf_sample_event__srccode(PyObject *self, PyObject *args)
 		addr_location__init(&al);
 		al.thread = thread__get(pevent->al.thread);
 		al.map = map__get(pevent->al.map);
-		al.sym = pevent->al.sym;
+		al.sym = symbol__get(pevent->al.sym);
 		al.addr = pevent->al.addr;
 	}
 
@@ -938,13 +938,12 @@ struct pyrf_callchain_node {
 	u64 ip;
 	struct map *map;
 	struct symbol *sym;
-	char *sym_name;
 };
 
 static void pyrf_callchain_node__delete(struct pyrf_callchain_node *pnode)
 {
 	map__put(pnode->map);
-	free(pnode->sym_name);
+	symbol__put(pnode->sym);
 	Py_TYPE(pnode)->tp_free((PyObject *)pnode);
 }
 
@@ -957,8 +956,6 @@ static PyObject *pyrf_callchain_node__get_ip(struct pyrf_callchain_node *pnode,
 static PyObject *pyrf_callchain_node__get_symbol(struct pyrf_callchain_node *pnode,
 						 void *closure __maybe_unused)
 {
-	if (pnode->sym_name)
-		return PyUnicode_FromString(pnode->sym_name);
 	if (pnode->sym)
 		return PyUnicode_FromString(symbol__name(pnode->sym));
 	return PyUnicode_FromString("[unknown]");
@@ -1016,7 +1013,6 @@ struct pyrf_callchain_frame {
 	u64 ip;
 	struct map *map;
 	struct symbol *sym;
-	char *sym_name;
 };
 
 struct pyrf_callchain {
@@ -1030,7 +1026,7 @@ static void pyrf_callchain__delete(struct pyrf_callchain *pchain)
 	if (pchain->frames) {
 		for (u64 i = 0; i < pchain->nr_frames; i++) {
 			map__put(pchain->frames[i].map);
-			free(pchain->frames[i].sym_name);
+			symbol__put(pchain->frames[i].sym);
 		}
 		free(pchain->frames);
 	}
@@ -1060,8 +1056,7 @@ static PyObject *pyrf_callchain__item(PyObject *obj, Py_ssize_t i)
 
 	pnode->ip = pchain->frames[i].ip;
 	pnode->map = map__get(pchain->frames[i].map);
-	pnode->sym = pchain->frames[i].sym;
-	pnode->sym_name = pchain->frames[i].sym_name ? strdup(pchain->frames[i].sym_name) : NULL;
+	pnode->sym = symbol__get(pchain->frames[i].sym);
 
 	return (PyObject *)pnode;
 }
@@ -1114,7 +1109,7 @@ static int pyrf_sample_event__resolve_callchain(struct pyrf_event *pevent)
 		node = callchain_cursor_current(cursor);
 		pchain->frames[i].ip = node->ip;
 		pchain->frames[i].map = map__get(node->ms.map);
-		pchain->frames[i].sym = node->ms.sym;
+		pchain->frames[i].sym = symbol__get(node->ms.sym);
 		callchain_cursor_advance(cursor);
 	}
 	pevent->callchain = (PyObject *)pchain;
@@ -4504,8 +4499,7 @@ static PyObject *pyrf_call_path__to_callchain(const struct call_path *cp,
 		struct pyrf_callchain_frame *frame = &pchain->frames[--nr_frames];
 
 		frame->ip = pos->ip;
-		frame->sym = NULL;
-		frame->sym_name = pos->sym ? strdup(symbol__name(pos->sym)) : NULL;
+		frame->sym = symbol__get(pos->sym);
 		frame->map = NULL;
 		if (thread) {
 			struct addr_location al;
@@ -4515,8 +4509,6 @@ static PyObject *pyrf_call_path__to_callchain(const struct call_path *cp,
 			addr_location__init(&al);
 			thread__find_map(thread, cpumode, pos->ip, &al);
 			frame->map = map__get(al.map);
-			if (frame->map)
-				frame->sym = pos->sym;
 			addr_location__exit(&al);
 		}
 	}
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index c4eca7a98642..87f23f1a31ea 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -466,7 +466,7 @@ int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
 	if (!sym_l || !sym_r)
 		return cmp_null(sym_l, sym_r);
 
-	if (sym_l == sym_r)
+	if (RC_CHK_EQUAL(sym_l, sym_r))
 		return 0;
 
 	if (symbol__inlined(sym_l) || symbol__inlined(sym_r)) {
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 14f2b6dfd086..d465bd8b7549 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -118,7 +118,7 @@ struct symbol *new_inline_sym(struct dso *dso,
 
 	if (base_sym && strcmp(funcname, symbol__name(base_sym)) == 0) {
 		/* reuse the real, existing symbol */
-		inline_sym = base_sym;
+		inline_sym = symbol__get(base_sym);
 		/* ensure that we don't alias an inlined symbol, which could
 		 * lead to double frees in inline_node__delete
 		 */
@@ -478,9 +478,7 @@ void inline_node__clear_frames(struct inline_node *node)
 	list_for_each_entry_safe(ilist, tmp, &node->val, list) {
 		list_del_init(&ilist->list);
 		zfree_srcline(&ilist->srcline);
-		/* only the inlined symbols are owned by the list */
-		if (ilist->symbol && symbol__inlined(ilist->symbol))
-			symbol__delete(ilist->symbol);
+		symbol__zput(ilist->symbol);
 		free(ilist);
 	}
 }
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 77db7ab5011d..4023174ed6db 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -352,10 +352,13 @@ static bool get_ifunc_name(Elf *elf, struct dso *dso, GElf_Ehdr *ehdr,
 
 	/* Expecting the address to be an IFUNC or IFUNC alias */
 	if (!sym || symbol__start(sym) != addr ||
-	    (symbol__type(sym) != STT_GNU_IFUNC && !symbol__ifunc_alias(sym)))
+	    (symbol__type(sym) != STT_GNU_IFUNC && !symbol__ifunc_alias(sym))) {
+		symbol__put(sym);
 		return false;
+	}
 
 	snprintf(buf, buf_sz, "%s@plt", symbol__name(sym));
+	symbol__put(sym);
 
 	return true;
 }
@@ -633,6 +636,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	f = dso__find_symbol_nocache(dso, shdr_plt.sh_offset);
 	if (f && symbol__start(f) < shdr_plt.sh_offset && symbol__end(f) > shdr_plt.sh_offset)
 		symbol__set_end(f, shdr_plt.sh_offset);
+	symbol__put(f);
 
 	if (!get_plt_sizes(dso, &ehdr, &shdr_plt, &plt_header_size, &plt_entry_size))
 		return 0;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 0055bfdc980c..b2c0a606b13a 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dirent.h>
 #include <errno.h>
+#include <stdatomic.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
@@ -228,7 +229,7 @@ void symbols__init(struct symbols *symbols)
 static void symbols__delete_locked(struct symbols *symbols)
 {
 	for (unsigned int i = 0; i < symbols->cnt; i++)
-		symbol__delete(symbols->symbols[i]);
+		symbol__put(symbols->symbols[i]);
 
 	zfree(&symbols->symbols);
 	zfree(&symbols->symbols_by_name);
@@ -248,7 +249,13 @@ void symbols__delete(struct symbols *symbols)
 
 void symbols__exit(struct symbols *symbols)
 {
-	symbols__delete(symbols);
+	down_write(&symbols->lock);
+	for (unsigned int i = 0; i < symbols->cnt; i++) {
+		if (symbol__annotated(symbols->symbols[i]))
+			symbol__annotation_delete(symbols->symbols[i]);
+	}
+	symbols__delete_locked(symbols);
+	up_write(&symbols->lock);
 	exit_rwsem(&symbols->lock);
 }
 
@@ -331,11 +338,11 @@ void symbols__fixup_duplicate(struct symbols *symbols)
 		if (choose_best_symbol(curr, next) == SYMBOL_A) {
 			if (symbol__type(next) == STT_GNU_IFUNC)
 				symbol__set_ifunc_alias(curr, true);
-			symbol__delete(next);
+			symbol__put(next);
 		} else {
 			if (symbol__type(curr) == STT_GNU_IFUNC)
 				symbol__set_ifunc_alias(next, true);
-			symbol__delete(curr);
+			symbol__put(curr);
 			symbols->symbols[write_idx] = next;
 		}
 	}
@@ -421,81 +428,96 @@ void symbols__fixup_end(struct symbols *symbols, bool is_kallsyms)
 struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name)
 {
 	size_t namelen = strlen(name) + 1;
-	struct symbol *sym = calloc(1, sizeof(*sym) + namelen);
-
-	if (sym == NULL)
-		return NULL;
-
-	sym->start   = start;
-	sym->end     = len ? start + len : start;
-	atomic_init(&sym->flags, (type << SYMBOL_FLAG_TYPE_SHIFT) |
-				 (binding << SYMBOL_FLAG_BINDING_SHIFT));
-	sym->namelen = namelen - 1;
-
-	pr_debug4("%s: %s %#" PRIx64 "-%#" PRIx64 "\n",
-		  __func__, name, start, sym->end);
-	memcpy(sym->name, name, namelen);
+	RC_STRUCT(symbol) *sym;
+	struct symbol *res;
+
+	sym = calloc(1, sizeof(*sym) + namelen);
+
+	if (ADD_RC_CHK(res, sym)) {
+		refcount_set(&sym->refcnt, 1);
+		sym->start   = start;
+		sym->end     = len ? start + len : start;
+		atomic_init(&sym->flags, (type << SYMBOL_FLAG_TYPE_SHIFT) |
+					 (binding << SYMBOL_FLAG_BINDING_SHIFT));
+		sym->namelen = namelen - 1;
+
+		pr_debug4("%s: %s %#" PRIx64 "-%#" PRIx64 "\n",
+			  __func__, name, start, sym->end);
+		memcpy(sym->name, name, namelen);
+	} else {
+		free(sym);
+	}
 
-	return sym;
+	return res;
 }
 
 void symbol__delete(struct symbol *sym)
 {
+	if (!sym)
+		return;
 	if (symbol__annotated(sym))
 		symbol__annotation_delete(sym);
-	free(sym);
+	RC_CHK_FREE(sym);
+}
+
+void symbol__put(struct symbol *sym)
+{
+	if (sym && refcount_dec_and_test(symbol__refcnt(sym)))
+		symbol__delete(sym);
+	else
+		RC_CHK_PUT(sym);
 }
 
 void symbol__set_ignore(struct symbol *sym, bool ignore)
 {
 	if (ignore)
-		atomic_fetch_or(&sym->flags, SYMBOL_FLAG_IGNORE);
+		atomic_fetch_or(&RC_CHK_ACCESS(sym)->flags, SYMBOL_FLAG_IGNORE);
 	else
-		atomic_fetch_and(&sym->flags, ~SYMBOL_FLAG_IGNORE);
+		atomic_fetch_and(&RC_CHK_ACCESS(sym)->flags, ~SYMBOL_FLAG_IGNORE);
 }
 
 void symbol__set_annotate2(struct symbol *sym, bool annotate2)
 {
 	if (annotate2)
-		atomic_fetch_or(&sym->flags, SYMBOL_FLAG_ANNOTATE2);
+		atomic_fetch_or(&RC_CHK_ACCESS(sym)->flags, SYMBOL_FLAG_ANNOTATE2);
 	else
-		atomic_fetch_and(&sym->flags, ~SYMBOL_FLAG_ANNOTATE2);
+		atomic_fetch_and(&RC_CHK_ACCESS(sym)->flags, ~SYMBOL_FLAG_ANNOTATE2);
 }
 
 void symbol__set_inlined(struct symbol *sym, bool inlined)
 {
 	if (inlined)
-		atomic_fetch_or(&sym->flags, SYMBOL_FLAG_INLINED);
+		atomic_fetch_or(&RC_CHK_ACCESS(sym)->flags, SYMBOL_FLAG_INLINED);
 	else
-		atomic_fetch_and(&sym->flags, ~SYMBOL_FLAG_INLINED);
+		atomic_fetch_and(&RC_CHK_ACCESS(sym)->flags, ~SYMBOL_FLAG_INLINED);
 }
 
 void symbol__set_ifunc_alias(struct symbol *sym, bool ifunc_alias)
 {
 	if (ifunc_alias)
-		atomic_fetch_or(&sym->flags, SYMBOL_FLAG_IFUNC_ALIAS);
+		atomic_fetch_or(&RC_CHK_ACCESS(sym)->flags, SYMBOL_FLAG_IFUNC_ALIAS);
 	else
-		atomic_fetch_and(&sym->flags, ~SYMBOL_FLAG_IFUNC_ALIAS);
+		atomic_fetch_and(&RC_CHK_ACCESS(sym)->flags, ~SYMBOL_FLAG_IFUNC_ALIAS);
 }
 
 void symbol__set_annotated(struct symbol *sym, bool annotated)
 {
 	if (annotated)
-		atomic_fetch_or(&sym->flags, SYMBOL_FLAG_ANNOTATED);
+		atomic_fetch_or(&RC_CHK_ACCESS(sym)->flags, SYMBOL_FLAG_ANNOTATED);
 	else
-		atomic_fetch_and(&sym->flags, ~SYMBOL_FLAG_ANNOTATED);
+		atomic_fetch_and(&RC_CHK_ACCESS(sym)->flags, ~SYMBOL_FLAG_ANNOTATED);
 }
 
 static void symbol__set_idle(struct symbol *sym, bool idle)
 {
-	uint16_t old_flags = atomic_load_explicit(&sym->flags, memory_order_relaxed);
+	uint16_t old_flags = atomic_load_explicit(&RC_CHK_ACCESS(sym)->flags, memory_order_relaxed);
 	uint16_t new_flags;
 	uint16_t idle_val = idle ? SYMBOL_IDLE__IDLE : SYMBOL_IDLE__NOT_IDLE;
 
 	do {
 		new_flags = old_flags & ~SYMBOL_FLAG_IDLE_MASK;
 		new_flags |= (idle_val << SYMBOL_FLAG_IDLE_SHIFT);
-	} while (!atomic_compare_exchange_weak(&sym->flags, &old_flags, new_flags));
+	} while (!atomic_compare_exchange_weak(&RC_CHK_ACCESS(sym)->flags, &old_flags, new_flags));
 }
 
 static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
@@ -506,7 +528,7 @@ static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
 					       sizeof(struct symbol *) * to_allocate);
 
 		if (!temp) {
-			symbol__delete(sym);
+			symbol__put(sym);
 			return -ENOMEM;
 		}
 		symbols->symbols = temp;
@@ -561,7 +583,7 @@ static struct symbol *symbols__find(struct symbols *symbols, u64 ip)
 		else if (ip > end || (ip == end && ip != start))
 			low = mid + 1;
 		else {
-			res = s;
+			res = symbol__get(s);
 			break;
 		}
 	}
@@ -685,7 +707,7 @@ static struct symbol *symbols__find_by_name(struct symbol *symbols[],
 		}
 	}
 	assert(!found_idx || !s || s == symbols[*found_idx]);
-	return s;
+	return symbol__get(s);
 }
 
 int dso__insert_symbol(struct dso *dso, struct symbol *sym)
@@ -699,14 +721,16 @@ void dso__delete_symbol(struct dso *dso, struct symbol *sym)
 
 	down_write(&symbols->lock);
 	for (unsigned int i = 0; i < symbols->cnt; i++) {
-		if (symbols->symbols[i] == sym) {
+		if (RC_CHK_EQUAL(symbols->symbols[i], sym)) {
+			struct symbol *old = symbols->symbols[i];
+
 			memmove(&symbols->symbols[i], &symbols->symbols[i + 1],
 				(symbols->cnt - i - 1) * sizeof(struct symbol *));
 			symbols->cnt--;
 			zfree(&symbols->symbols_by_name);
 			symbols->num_by_name = 0;
 			symbols->sorted_by_name = false;
-			symbol__delete(sym);
+			symbol__put(old);
 			break;
 		}
 	}
@@ -731,7 +755,7 @@ struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx)
 	down_read(&symbols->lock);
 	if (*idx + 1 < symbols->num_by_name) {
 		++*idx;
-		res = symbols->symbols_by_name[*idx];
+		res = symbol__get(symbols->symbols_by_name[*idx]);
 	}
 	up_read(&symbols->lock);
 
@@ -929,7 +953,8 @@ bool symbol__is_idle(struct symbol *sym, const struct dso *dso, struct perf_env
 	uint16_t e_machine;
 
 	{
-		uint16_t flags = atomic_load_explicit(&sym->flags, memory_order_relaxed);
+		uint16_t flags = atomic_load_explicit(&RC_CHK_ACCESS(sym)->flags,
+						      memory_order_relaxed);
 		uint16_t idle_val = (flags & SYMBOL_FLAG_IDLE_MASK) >> SYMBOL_FLAG_IDLE_SHIFT;
 
 		if (idle_val != SYMBOL_IDLE__UNKNOWN)
@@ -1077,7 +1102,7 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 		curr_map = maps__find(kmaps, symbol__start(pos));
 
 		if (!curr_map) {
-			symbol__delete(pos);
+			symbol__put(pos);
 			continue;
 		}
 		curr_map_dso = map__dso(curr_map);
@@ -1273,7 +1298,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 
 		continue;
 discard_symbol:
-		symbol__delete(pos);
+		symbol__put(pos);
 	}
 
 	down_write(&root->lock);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index eed4d388d1fc..b4e5fdf5c4d6 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -13,6 +13,7 @@
 #include <linux/string.h>
 #include <stdio.h>
 #include <errno.h>
+#include <internal/rc_check.h>
 #include "addr_location.h"
 #include "path.h"
 #include "rwsem.h"
@@ -85,10 +86,12 @@ enum symbol_idle_kind {
 /**
  * A symtab entry.
  */
-struct symbol {
+DECLARE_RC_STRUCT(symbol) {
 	/** Range of symbol [start, end). */
 	u64		start;
 	u64		end;
+	/** Reference count. */
+	refcount_t	refcnt;
 	/** Length of the string name. */
 	u16		namelen;
 	_Atomic uint16_t flags;
@@ -135,86 +138,111 @@ void symbols__exit(struct symbols *symbols);
 void symbols__delete(struct symbols *symbols);
 void symbols__sort_read_lock(struct symbols *symbols) SHARED_LOCK_FUNCTION(symbols->lock);
 
+static inline refcount_t *symbol__refcnt(struct symbol *sym)
+{
+	return &RC_CHK_ACCESS(sym)->refcnt;
+}
+
+static inline struct symbol *symbol__get(struct symbol *sym)
+{
+	struct symbol *result;
+
+	if (RC_CHK_GET(result, sym))
+		refcount_inc(symbol__refcnt(sym));
+
+	return result;
+}
+
+void symbol__put(struct symbol *sym);
+
+static inline void __symbol__zput(struct symbol **sym)
+{
+	symbol__put(*sym);
+	*sym = NULL;
+}
+
+#define symbol__zput(sym) __symbol__zput(&sym)
+
 static inline __attribute__((nonnull)) u64 symbol__start(const struct symbol *sym)
 {
-	return sym->start;
+	return RC_CHK_ACCESS(sym)->start;
 }
 
 static inline __attribute__((nonnull)) void symbol__set_start(struct symbol *sym, u64 start)
 {
-	sym->start = start;
+	RC_CHK_ACCESS(sym)->start = start;
 }
 
 static inline __attribute__((nonnull)) u64 symbol__end(const struct symbol *sym)
 {
-	return sym->end;
+	return RC_CHK_ACCESS(sym)->end;
 }
 
 static inline __attribute__((nonnull)) void symbol__set_end(struct symbol *sym, u64 end)
 {
-	sym->end = end;
+	RC_CHK_ACCESS(sym)->end = end;
 }
 
 static inline __attribute__((nonnull, returns_nonnull))
 const char *symbol__name(const struct symbol *sym)
 {
-	return sym->name;
+	return RC_CHK_ACCESS(sym)->name;
 }
 
 static inline __attribute__((nonnull)) u16 symbol__namelen(const struct symbol *sym)
 {
-	return sym->namelen;
+	return RC_CHK_ACCESS(sym)->namelen;
 }
 
 static inline __attribute__((nonnull)) u8 symbol__arch_sym(const struct symbol *sym)
 {
-	return sym->arch_sym;
+	return RC_CHK_ACCESS(sym)->arch_sym;
 }
 
 static inline __attribute__((nonnull)) void symbol__set_arch_sym(struct symbol *sym, u8 arch_sym)
 {
-	sym->arch_sym = arch_sym;
+	RC_CHK_ACCESS(sym)->arch_sym = arch_sym;
 }
 
 static inline u8 symbol__type(const struct symbol *sym)
 {
-	return (atomic_load_explicit(&sym->flags, memory_order_relaxed) &
+	return (atomic_load_explicit(&RC_CHK_ACCESS(sym)->flags, memory_order_relaxed) &
 		SYMBOL_FLAG_TYPE_MASK) >> SYMBOL_FLAG_TYPE_SHIFT;
 }
 
 static inline u8 symbol__binding(const struct symbol *sym)
 {
-	return (atomic_load_explicit(&sym->flags, memory_order_relaxed) &
+	return (atomic_load_explicit(&RC_CHK_ACCESS(sym)->flags, memory_order_relaxed) &
 		SYMBOL_FLAG_BINDING_MASK) >> SYMBOL_FLAG_BINDING_SHIFT;
 }
 
 static inline bool symbol__ignore(const struct symbol *sym)
 {
-	return (atomic_load_explicit(&sym->flags, memory_order_relaxed) &
+	return (atomic_load_explicit(&RC_CHK_ACCESS(sym)->flags, memory_order_relaxed) &
 		SYMBOL_FLAG_IGNORE) != 0;
 }
 
 static inline bool symbol__inlined(const struct symbol *sym)
 {
-	return (atomic_load_explicit(&sym->flags, memory_order_relaxed) &
+	return (atomic_load_explicit(&RC_CHK_ACCESS(sym)->flags, memory_order_relaxed) &
 		SYMBOL_FLAG_INLINED) != 0;
 }
 
 static inline bool symbol__is_annotate2(const struct symbol *sym)
 {
-	return (atomic_load_explicit(&sym->flags, memory_order_relaxed) &
+	return (atomic_load_explicit(&RC_CHK_ACCESS(sym)->flags, memory_order_relaxed) &
 		SYMBOL_FLAG_ANNOTATE2) != 0;
 }
 
 static inline bool symbol__ifunc_alias(const struct symbol *sym)
 {
-	return (atomic_load_explicit(&sym->flags, memory_order_relaxed) &
+	return (atomic_load_explicit(&RC_CHK_ACCESS(sym)->flags, memory_order_relaxed) &
 		SYMBOL_FLAG_IFUNC_ALIAS) != 0;
 }
 
 static inline bool symbol__annotated(const struct symbol *sym)
 {
-	return (atomic_load_explicit(&sym->flags, memory_order_relaxed) &
+	return (atomic_load_explicit(&RC_CHK_ACCESS(sym)->flags, memory_order_relaxed) &
 		SYMBOL_FLAG_ANNOTATED) != 0;
 }
 
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 76867ba83365..e2c73e890158 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -823,7 +823,7 @@ static int thread_stack__pop_cp(struct thread *thread, struct thread_stack *ts,
 	if (ts->cnt == 1) {
 		struct thread_stack_entry *tse = &ts->stack[0];
 
-		if (tse->cp->sym == sym)
+		if (RC_CHK_EQUAL(tse->cp->sym, sym))
 			return thread_stack__call_return(thread, ts, --ts->cnt,
 							 timestamp, ref, false);
 	}
@@ -941,7 +941,7 @@ static int thread_stack__no_call_return(struct thread *thread,
 	else
 		parent = root;
 
-	if (parent->sym == from_al->sym) {
+	if (RC_CHK_EQUAL(parent->sym, from_al->sym)) {
 		/*
 		 * At the bottom of the stack, assume the missing 'call' was
 		 * before the trace started. So, pop the current symbol and push
@@ -1069,7 +1069,7 @@ static int thread_stack__x86_retpoline(struct thread_stack *ts,
 		 */
 		ts->cnt -= 1;
 		sym = ts->stack[ts->cnt - 2].cp->sym;
-		if (sym && sym == tsym && to_al->addr != symbol__start(tsym)) {
+		if (sym && RC_CHK_EQUAL(sym, tsym) && to_al->addr != symbol__start(tsym)) {
 			/*
 			 * Target is back to the middle of the symbol we came
 			 * from so assume it is an indirect jmp and forget it
@@ -1078,7 +1078,7 @@ static int thread_stack__x86_retpoline(struct thread_stack *ts,
 			ts->cnt -= 1;
 			return 0;
 		}
-	} else if (sym && sym == tsym) {
+	} else if (sym && RC_CHK_EQUAL(sym, tsym)) {
 		/*
 		 * Target is back to the symbol we came from so assume it is an
 		 * indirect jmp and forget it altogether.
@@ -1169,7 +1169,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 		 * may be the start of a x86 retpoline.
 		 */
 		if (!err && rstate == X86_RETPOLINE_POSSIBLE && to_al->sym &&
-		    from_al->sym == to_al->sym &&
+		    RC_CHK_EQUAL(from_al->sym, to_al->sym) &&
 		    to_al->addr != symbol__start(to_al->sym))
 			ts->rstate = X86_RETPOLINE_DETECTED;
 
@@ -1206,7 +1206,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 	} else if (sample->flags & PERF_IP_FLAG_TRACE_END) {
 		err = thread_stack__trace_end(ts, sample, ref);
 	} else if (sample->flags & PERF_IP_FLAG_BRANCH &&
-		   from_al->sym != to_al->sym && to_al->sym &&
+		   !RC_CHK_EQUAL(from_al->sym, to_al->sym) && to_al->sym &&
 		   to_al->addr == symbol__start(to_al->sym)) {
 		struct call_path_root *cpr = ts->crp->cpr;
 		struct call_path *cp;
diff --git a/tools/perf/util/threads.c b/tools/perf/util/threads.c
index 6ca0b178fb6c..b3ec954fe7ab 100644
--- a/tools/perf/util/threads.c
+++ b/tools/perf/util/threads.c
@@ -142,10 +142,13 @@ void threads__remove_all_threads(struct threads *threads)
 		down_write(&table->lock);
 		__threads_table_entry__set_last_match(table, NULL);
 		hashmap__for_each_entry_safe(&table->shard, cur, tmp, bkt) {
-			struct thread *old_value;
+			struct thread *old_value = NULL;
 
-			hashmap__delete(&table->shard, cur->key, /*old_key=*/NULL, &old_value);
-			thread__put(old_value);
+			if (hashmap__delete(&table->shard, cur->key,
+					    /*old_key=*/NULL, &old_value)) {
+				thread__free_stitch_list(old_value);
+				thread__put(old_value);
+			}
 		}
 		up_write(&table->lock);
 	}
@@ -154,14 +157,16 @@ void threads__remove_all_threads(struct threads *threads)
 void threads__remove(struct threads *threads, struct thread *thread)
 {
 	struct threads_table_entry *table  = threads__table(threads, thread__tid(thread));
-	struct thread *old_value;
+	struct thread *old_value = NULL;
 
 	down_write(&table->lock);
 	if (table->last_match && RC_CHK_EQUAL(table->last_match, thread))
 		__threads_table_entry__set_last_match(table, NULL);
 
-	hashmap__delete(&table->shard, thread__tid(thread), /*old_key=*/NULL, &old_value);
-	thread__put(old_value);
+	if (hashmap__delete(&table->shard, thread__tid(thread), /*old_key=*/NULL, &old_value)) {
+		thread__free_stitch_list(old_value);
+		thread__put(old_value);
+	}
 	up_write(&table->lock);
 }
 
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 87ade098b5c6..eb4327aa9e7e 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -169,7 +169,7 @@ static int entry(u64 ip, struct unwind_info *ui)
 	e->ip	  = ip;
 	e->ms.thread = thread__get(al.thread);
 	e->ms.map = map__get(al.map);
-	e->ms.sym = al.sym;
+	e->ms.sym = symbol__get(al.sym);
 
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
 		 al.sym ? symbol__name(al.sym) : "''",
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index 6052383e862b..42872c7b6dcd 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -632,7 +632,7 @@ static int entry(uint64_t ip, struct thread *thread, unwind_entry_cb_t cb, void
 	e.ms.thread = thread__get(al.thread);
 
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
-		 al.sym ? al.sym->name : "''",
+		 al.sym ? symbol__name(al.sym) : "''",
 		 ip,
 		 al.map ? map__map_ip(al.map, ip) : (u64) 0);
 
-- 
2.56.0.313.g2479322e68-goog

