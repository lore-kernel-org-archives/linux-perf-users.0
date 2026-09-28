Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8303463B75
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581985; cv=none; b=hxHbKSpklFngZ2F/iurWLko/uTeZjikYbkh7GXza4fmH9PW50r5Z/KrQ7Ima0AmY/II0QJ5SbQ9qE9iFhKoXtjnjnAjqOIzDWa3/AiIG5hWykgkbjpPj5LRAZV6CZEAdcS/4o9k1xg0MGD6rVI4CFKEg/9nkaa3eCZ5QgXqHrvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581985; c=relaxed/simple;
	bh=5WeSazwN7QdD6xANDGm36Dp3WpxGE/jO7sc3JQ27hz0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=JGdnSbQin8AYIAwA5SDHJo1ucKu+ydYyD51lDp95OU4fA/mswty78yxyPetVfh1jJ/xRXZjemdyaf2ATfgJmqMA7gE/W9bzApEQLL/OAt6goRlfH4jwuu6L32iUrbIllcSJr0wzbRBlGruCndFxVU4KAwlz9urU1A7PNnOphpKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sGITz6HL; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sGITz6HL"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so805242eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 00:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790581978; x=1791186778; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Xogc1ZGpueJrkTe0gWZVJ81+JUemP6BrB8PDuUtT0o=;
        b=sGITz6HLZh1mZ3iSvWBfuLh4CJzvv9O7xgX5O/9ftSP+MWcIKt95/lJlhyQwYXYGuR
         AjicmbtgJZ82+ICeHD5j4nRpTtyWlZ/nQFViFyFdhFwiW4Mo/kZiNYVGuEa0M771TFrM
         LmEc1s+qP/XDQGcXDOeZoFRbu6qKi2bzDCuyoOdHoamlGvD1kqF7cFXNBYErlMErApp1
         Cr0F6H9G+9qGDH1fd9jSi3RYKijVMgPHXfsW8I9nQ47vBKr5V8BAt/iP+smrLM9rpXbe
         tUfHQc5TQEmQT5+UnQ8iX/nnZjID5W++qsXs7Og7Ql7DEERSwWU3nOo1iIPe60KmcIiP
         TMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581978; x=1791186778;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Xogc1ZGpueJrkTe0gWZVJ81+JUemP6BrB8PDuUtT0o=;
        b=tZIILCwUPUwQVcu66oawyaGT28V0i0tFuG4fDOJeSO/Oa2axJs7vXCWtI0mZExyPFa
         p2YbfMStzeFegrqHGV5cvtr4oGYq9oXy09GISKL8fqENpCutvowr6bxIxnB4SIHn0ZBu
         f6wfWpvvu4q9T58hUYG1wJbZ274tszZEc+Rqqp1CPnWVvdE7VA0vwm2cAkDGg1HiVLAV
         SomvRxI3T2kly4VMt8SPcYRNr1nvSNS8Sq2+fv0QRR6zVwcLoWr05Gp87q+M0W0ZcYdK
         wuA5hFFnqhHgCR5auDtnRx+0W9kgkOy78N5G7kYWZvUAUY8y4hOsjcFgSIE9ToR3S9ji
         aGgg==
X-Forwarded-Encrypted: i=1; AKwUvBy1l4wvwEYFEExIeYU+ybK0Ys+2xy1dG2GA1BmckXTZS/dAXiwlXitAvloKpFZsDsr4FIqjxGlxRw6hRH1F7kdJ@vger.kernel.org
X-Gm-Message-State: AFuF++kQFaCIDpn9Qs1ZT+RGXUwkTrFjeDk5YtaQVXLtUgtEvctamG7a
	x8kmtyaNtVWgVZMUEeAKwTwJ9heJdaJ6kNZywSn1ySBy5MAnv0Zw9NbRVkFD5u0VrjVUH/kpjVm
	55TK8Ga4j3Q==
X-Received: from dybb4.prod.google.com ([2002:a05:693c:6084:b0:342:269a:ee1a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2525:b0:144:f096:4dda
 with SMTP id a92af1059eb24-146d096d302mr13508505c88.43.1790581976947; Mon, 28
 Sep 2026 00:52:56 -0700 (PDT)
Date: Mon, 28 Sep 2026 00:52:34 -0700
In-Reply-To: <20260928075237.3055101-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928075237.3055101-5-irogers@google.com>
Subject: [PATCH v1 4/7] perf symbol: Add reference counting and DECLARE_RC_STRUCT(symbol)
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alireza Haghdoost <haghdoost@uber.com>
Content-Type: text/plain; charset="UTF-8"

Wrap struct symbol with DECLARE_RC_STRUCT(symbol) and add a refcount_t
refcnt field along with symbol__get(), symbol__put(), and symbol__zput()
helpers:

- Return a counted symbol reference acquired under symbols->lock from
  symbol lookup functions (symbols__find(), dso__find_symbol(),
  map__find_symbol(), dso__find_symbol_by_name(),
  map__find_symbol_by_name(), dso__first_symbol(), dso__last_symbol())
  and iteration helpers (symbols__first_by_idx(),
  symbols__next_by_idx(), symbols__for_each_entry()).
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

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kallsyms.c                 |   2 +
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
 tools/perf/tests/vmlinux-kallsyms.c           |  12 +-
 tools/perf/ui/browsers/hists.c                |   7 +-
 tools/perf/ui/browsers/map.c                  |   7 +-
 tools/perf/ui/stdio/hist.c                    |   3 +-
 tools/perf/util/addr_location.c               |   4 +
 .../perf/util/annotate-arch/annotate-alpha.c  |   2 +-
 .../util/annotate-arch/annotate-loongarch.c   |   4 +-
 tools/perf/util/annotate-arch/annotate-s390.c |   2 +-
 tools/perf/util/annotate.c                    |  22 ++-
 tools/perf/util/block-info.c                  |   6 +-
 tools/perf/util/bpf_lock_contention.c         |  27 +++-
 tools/perf/util/c2c-function.c                |  13 +-
 tools/perf/util/call-path.c                   |  15 +-
 tools/perf/util/callchain.c                   |   4 +-
 tools/perf/util/capstone.c                    |   1 +
 tools/perf/util/db-export.c                   |  35 ++++-
 tools/perf/util/disasm.c                      |  12 +-
 tools/perf/util/event.c                       |   8 +-
 tools/perf/util/hist.c                        |  13 +-
 tools/perf/util/libdw.c                       |   5 +-
 tools/perf/util/lock-contention.c             |   8 +-
 tools/perf/util/machine.c                     |  48 +++++--
 tools/perf/util/map.h                         |  10 +-
 tools/perf/util/map_symbol.c                  |   4 +-
 tools/perf/util/maps.c                        |   3 +-
 tools/perf/util/probe-event.c                 |  17 ++-
 tools/perf/util/python.c                      |  12 +-
 tools/perf/util/sort.c                        |   2 +-
 tools/perf/util/srcline.c                     |   6 +-
 tools/perf/util/symbol-elf.c                  |   6 +-
 tools/perf/util/symbol.c                      | 129 +++++++++++-------
 tools/perf/util/symbol.h                      |  60 +++++---
 tools/perf/util/thread-stack.c                |  12 +-
 tools/perf/util/threads.c                     |  17 ++-
 tools/perf/util/unwind-libdw.c                |   2 +-
 tools/perf/util/unwind-libunwind.c            |   2 +-
 48 files changed, 427 insertions(+), 190 deletions(-)

diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
index eb62bb4ea602..5b1b87cd54d4 100644
--- a/tools/perf/builtin-kallsyms.c
+++ b/tools/perf/builtin-kallsyms.c
@@ -53,6 +53,8 @@ static int __cmd_kallsyms(int argc, const char **argv)
 			map__unmap_ip(map, symbol__start(symbol)),
 			map__unmap_ip(map, symbol__end(symbol)),
 			symbol__start(symbol), symbol__end(symbol));
+		symbol__put(symbol);
+		map__put(map);
 	}
 out:
 	machine__delete(machine);
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index cd060c984068..9b495703cf0c 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1003,12 +1003,16 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
 					(filters.nr_addrs + 1) * sizeof(*addrs));
 			if (addrs == NULL) {
 				pr_warning("memory allocation failure\n");
+				symbol__put(sym);
+				map__put(kmap);
 				return -ENOMEM;
 			}
 
 			addrs[filters.nr_addrs++] = map__unmap_ip(kmap,
 								  symbol__start(sym));
 			filters.addrs = addrs;
+			symbol__put(sym);
+			map__put(kmap);
 		}
 	}
 
@@ -1019,9 +1023,12 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
 
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
@@ -1668,6 +1675,8 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
 			ip = st->callstack[i];
 			sym = machine__find_kernel_symbol(con->machine, ip, &kmap);
 			get_symbol_name_offset(kmap, sym, ip, buf, sizeof(buf));
+			symbol__put(sym);
+			map__put(kmap);
 			fprintf(lock_output, "\t\t\t%#lx  %s\n", (unsigned long)ip, buf);
 		}
 	}
@@ -1721,6 +1730,8 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
 			ip = st->callstack[i];
 			sym = machine__find_kernel_symbol(con->machine, ip, &kmap);
 			get_symbol_name_offset(kmap, sym, ip, buf, sizeof(buf));
+			symbol__put(sym);
+			map__put(kmap);
 			fprintf(lock_output, "%s %#lx %s", i ? ":" : sep, (unsigned long) ip, buf);
 		}
 		fprintf(lock_output, "\n");
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f1257a78d975..4b6157fa87b9 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1426,7 +1426,8 @@ static int ip__fprintf_sym(uint64_t addr, struct thread *thread,
 	if (PRINT_FIELD(SRCLINE))
 		printed += map__fprintf_srcline(al.map, al.addr, "\t", fp);
 	printed += fprintf(fp, "\n");
-	*lastsym = al.sym;
+	symbol__put(*lastsym);
+	*lastsym = symbol__get(al.sym);
 
 	ret = printed;
 out:
@@ -1593,6 +1594,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 			print_srccode(thread, x.cpumode, start + off);
 	}
 out:
+	symbol__put(lastsym);
 	return printed;
 }
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 19a21348823c..dd1e475bb4dd 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -211,7 +211,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 
 	if (sym == NULL || (use_browser == 0 &&
 			    (top->sym_filter_entry == NULL ||
-			     top->sym_filter_entry->ms.sym != sym)))
+			     !RC_CHK_EQUAL(top->sym_filter_entry->ms.sym, sym))))
 		return;
 
 	notes = symbol__annotation(sym);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index aaa090912409..ab970fd45e26 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -778,6 +778,7 @@ size_t syscall_arg__scnprintf_ksym(char *bf, size_t size, struct syscall_arg *ar
 			else
 				printed = scnprintf(bf, size, "%s+0x%" PRIx64,
 						    symbol__name(sym), offset);
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
index 30c7da79e109..c9a2f418bdc5 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -64,6 +64,7 @@ static int run_dir(const char *d)
 	dso__sort_by_name(dso);
 	sym = dso__find_symbol_by_name(dso, "main", &idx);
 	TEST_ASSERT_VAL("Failed to find main", sym);
+	symbol__put(sym);
 	dso__delete(dso);
 
 	return TEST_OK;
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 98c2a9437ba7..53f7b44af843 100644
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
 		} else {
+			symbol__put(pair);
 			pair = machine__find_kernel_symbol_by_name(&args->kallsyms,
 								   symbol__name(sym),
 								   NULL);
@@ -249,15 +252,20 @@ static int test__vmlinux_matches_kallsyms_sym_cb(struct symbol *sym, void *data)
 				pr_debug("WARN: %#" PRIx64 ": diff name v: %s k: %s\n",
 					 mem_start, symbol__name(sym),
 					 symbol__name(pair));
+				symbol__put(pair);
 			} else {
 				pr_debug("WARN: %#" PRIx64 ": diff name v: %s k: %s\n",
 					 mem_start, symbol__name(sym),
 					 symbol__name(first_pair));
 			}
 
+			symbol__put(first_pair);
 			return 0;
 		}
-	} else if (mem_start == map__end(args->kallsyms.vmlinux_map)) {
+	}
+	symbol__put(pair);
+	symbol__put(first_pair);
+	if (mem_start == map__end(args->kallsyms.vmlinux_map)) {
 		/*
 		 * Ignore aliases to _etext, i.e. to the end of the kernel text area,
 		 * such as __indirect_thunk_end.
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 206657039223..72b071f2604f 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2522,11 +2522,11 @@ static struct symbol *symbol__new_unresolved(u64 addr, struct map *map)
 	if (sym) {
 		src = symbol__hists(sym, 1);
 		if (!src) {
-			symbol__delete(sym);
+			symbol__put(sym);
 			return NULL;
 		}
 
-		dso__insert_symbol(map__dso(map), sym);
+		dso__insert_symbol(map__dso(map), symbol__get(sym));
 	}
 
 	return sym;
@@ -2812,7 +2812,7 @@ add_script_opt_2(struct popup_action *act, char **optstr,
 	}
 
 	act->ms.thread = thread__get(thread);
-	act->ms.sym = sym;
+	act->ms.sym = symbol__get(sym);
 	act->fn = do_run_script;
 	return 1;
 }
@@ -3201,6 +3201,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 
 				memset(&hotkey_act, 0, sizeof(hotkey_act));
 				map_symbol__copy(&hotkey_act.ms, &source_ms);
+				symbol__zput(source_ms.sym);
 				do_annotate(browser, &hotkey_act);
 				map_symbol__exit(&hotkey_act.ms);
 			} else {
diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index bb35d4965a3a..2310fbf1ac6d 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -65,12 +65,13 @@ static int map_browser__search(struct map_browser *browser)
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
 
@@ -136,7 +137,7 @@ int map__browse(struct map *map)
 			for (unsigned int idx = 0; idx < nr_entries; idx++) {
 				struct symbol *pos = symbols->symbols[idx];
 
-				entries[idx] = pos;
+				entries[idx] = symbol__get(pos);
 				if (maxaddr < symbol__end(pos))
 					maxaddr = symbol__end(pos);
 			}
@@ -151,6 +152,8 @@ int map__browse(struct map *map)
 
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
index ccb13e2338a2..e95f7628a8fe 100644
--- a/tools/perf/util/annotate-arch/annotate-alpha.c
+++ b/tools/perf/util/annotate-arch/annotate-alpha.c
@@ -89,7 +89,7 @@ static int alpha_call__parse(const struct arch *arch, struct ins_operands *ops,
 	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map,
 			      map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
-		ops->target.sym = target.ms.sym;
+		ops->target.sym = symbol__get(target.ms.sym);
 
 	addr_map_symbol__exit(&target);
 	return 0;
diff --git a/tools/perf/util/annotate-arch/annotate-loongarch.c b/tools/perf/util/annotate-arch/annotate-loongarch.c
index d275730080b7..7fa1739966df 100644
--- a/tools/perf/util/annotate-arch/annotate-loongarch.c
+++ b/tools/perf/util/annotate-arch/annotate-loongarch.c
@@ -57,7 +57,7 @@ static int loongarch_call__parse(const struct arch *arch, struct ins_operands *o
 
 	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
-		ops->target.sym = target.ms.sym;
+		ops->target.sym = symbol__get(target.ms.sym);
 
 	addr_map_symbol__exit(&target);
 	return 0;
@@ -101,7 +101,7 @@ static int loongarch_jump__parse(const struct arch *arch, struct ins_operands *o
 
 	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
-		ops->target.sym = target.ms.sym;
+		ops->target.sym = symbol__get(target.ms.sym);
 
 	if (!ops->target.outside) {
 		ops->target.offset = target.addr - start;
diff --git a/tools/perf/util/annotate-arch/annotate-s390.c b/tools/perf/util/annotate-arch/annotate-s390.c
index af9cabd0a586..7c8050e04964 100644
--- a/tools/perf/util/annotate-arch/annotate-s390.c
+++ b/tools/perf/util/annotate-arch/annotate-s390.c
@@ -52,7 +52,7 @@ static int s390_call__parse(const struct arch *arch, struct ins_operands *ops,
 
 	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
-		ops->target.sym = target.ms.sym;
+		ops->target.sym = symbol__get(target.ms.sym);
 
 	addr_map_symbol__exit(&target);
 	return 0;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9bb7e0ee1b8e..61a5b13c4777 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -194,15 +194,22 @@ static bool sym_ptr_equal(long key1, long key2, void *ctx __maybe_unused)
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
@@ -217,7 +224,7 @@ struct annotation *symbol__annotation(struct symbol *sym)
 			up_write(annotations_lock());
 			return &empty_annotation;
 		}
-	} else if (hashmap__find(annotations, (long)sym, &val)) {
+	} else if (hashmap__find(annotations, key, &val)) {
 		notes = (struct annotation *)val;
 		up_write(annotations_lock());
 		return notes;
@@ -229,7 +236,7 @@ struct annotation *symbol__annotation(struct symbol *sym)
 		return &empty_annotation;
 	}
 	annotation__init(notes);
-	if (hashmap__add(annotations, (long)sym, notes) < 0) {
+	if (hashmap__add(annotations, key, notes) < 0) {
 		free(notes);
 		if (hashmap__size(annotations) == 0) {
 			hashmap__free(annotations);
@@ -246,14 +253,15 @@ struct annotation *symbol__annotation(struct symbol *sym)
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
@@ -567,7 +575,7 @@ int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 	 * it starts on the function start.
 	 */
 	if (start &&
-		(start->ms.sym == ams->ms.sym ||
+		(RC_CHK_EQUAL(start->ms.sym, ams->ms.sym) ||
 		 (ams->ms.sym &&
 		  start->addr == symbol__start(ams->ms.sym) + map__start(ams->ms.map))))
 		saddr = start->al_addr;
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 5dec6c9dc1a7..6bf13482da80 100644
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
index 9832c45857d1..bf9b4dc3c3bb 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -145,6 +145,7 @@ static void init_numa_data(struct lock_contention *con)
 	if (sym) {
 		skel->rodata->contig_page_data_addr = map__unmap_ip(kmap,
 								    symbol__start(sym));
+		symbol__put(sym);
 		map__put(kmap);
 		return;
 	}
@@ -161,6 +162,7 @@ static void init_numa_data(struct lock_contention *con)
 		return;
 
 	skel->rodata->node_data_addr = map__unmap_ip(kmap, symbol__start(sym));
+	symbol__put(sym);
 	map__put(kmap);
 
 	/* get the number of online nodes using the last node number + 1 */
@@ -264,12 +266,16 @@ int lock_contention_prepare(struct lock_contention *con)
 					(con->filters->nr_addrs + 1) * sizeof(*addrs));
 			if (addrs == NULL) {
 				pr_warning("memory allocation failure\n");
+				symbol__put(sym);
+				map__put(kmap);
 				continue;
 			}
 
 			addrs[con->filters->nr_addrs++] = map__unmap_ip(kmap,
 									symbol__start(sym));
 			con->filters->addrs = addrs;
+			symbol__put(sym);
+			map__put(kmap);
 		}
 		naddrs = con->filters->nr_addrs ?: has_mmap_lock;
 		skel->rodata->has_addr = 1;
@@ -292,6 +298,8 @@ int lock_contention_prepare(struct lock_contention *con)
 
 			con->delays[i].addr = map__unmap_ip(kmap,
 							    symbol__start(sym));
+			symbol__put(sym);
+			map__put(kmap);
 		}
 		skel->rodata->lock_delay = 1;
 		bpf_map__set_max_entries(skel->maps.lock_delays, con->nr_delays);
@@ -609,9 +617,12 @@ static const char *lock_contention_get_name(struct lock_contention *con,
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
@@ -658,13 +669,15 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 		offset = map__map_ip(kmap, addr) - symbol__start(sym);
 
 		if (offset == 0)
-			return symbol__name(sym);
-
-		snprintf(name_buf, sizeof(name_buf), "%s+%#lx",
-			 symbol__name(sym), offset);
+			snprintf(name_buf, sizeof(name_buf), "%s", symbol__name(sym));
+		else
+			snprintf(name_buf, sizeof(name_buf), "%s+%#lx",
+				 symbol__name(sym), offset);
+		symbol__put(sym);
 	} else {
 		snprintf(name_buf, sizeof(name_buf), "%#lx", (unsigned long)addr);
 	}
+	map__put(kmap);
 
 	return name_buf;
 }
diff --git a/tools/perf/util/c2c-function.c b/tools/perf/util/c2c-function.c
index 0c50d816653f..5bd7e0364263 100644
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
index 993b7c744a89..7f4543ea2ab5 100644
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
index 422a48385b78..69667f41a7fe 100644
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
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 897cda3fadd2..1029f23be428 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -22,14 +22,24 @@
 #include "db-export.h"
 #include "hashmap.h"
 
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
@@ -40,8 +50,15 @@ int db_export__init(struct db_export *dbe)
 
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
@@ -187,6 +204,7 @@ int db_export__symbol(struct db_export *dbe, struct symbol *sym,
 		      struct dso *dso)
 {
 	long db_id;
+	struct symbol *sym_key;
 
 	if (db_export__symbol_db_id(dbe, sym))
 		return 0;
@@ -202,8 +220,11 @@ int db_export__symbol(struct db_export *dbe, struct symbol *sym,
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
@@ -227,7 +248,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 		if (!al->sym) {
 			al->sym = symbol__new(al->addr, 0, 0, 0, "unknown");
 			if (al->sym)
-				dso__insert_symbol(dso, al->sym);
+				dso__insert_symbol(dso, symbol__get(al->sym));
 		}
 
 		if (al->sym) {
@@ -287,7 +308,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 		 * db_ids_from_al() to perform the export.
 		 */
 		addr_location__init(&al);
-		al.sym = node->ms.sym;
+		al.sym = symbol__get(node->ms.sym);
 		al.map = map__get(node->ms.map);
 		al.addr = node->ip;
 		al.thread = thread__get(thread);
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 78b8811dcaa4..cc9865ac6623 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -228,6 +228,7 @@ static void ins_ops__delete(struct ins_operands *ops)
 	zfree(&ops->source.name);
 	zfree(&ops->target.raw);
 	zfree(&ops->target.name);
+	symbol__zput(ops->target.sym);
 }
 
 int ins__raw_scnprintf(const struct ins *ins, char *bf, size_t size,
@@ -290,7 +291,7 @@ static int call__parse(const struct arch *arch, struct ins_operands *ops, struct
 
 	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
-		ops->target.sym = target.ms.sym;
+		ops->target.sym = symbol__get(target.ms.sym);
 
 	addr_map_symbol__exit(&target);
 	return 0;
@@ -425,7 +426,7 @@ static int jump__parse(const struct arch *arch, struct ins_operands *ops, struct
 	 */
 	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
-		ops->target.sym = target.ms.sym;
+		ops->target.sym = symbol__get(target.ms.sym);
 
 	if (!ops->target.outside) {
 		ops->target.offset = target.addr - start;
@@ -471,12 +472,14 @@ int jump__scnprintf(const struct ins *ins, char *bf, size_t size,
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
@@ -570,6 +573,7 @@ static void lock__delete(struct ins_operands *ops)
 	zfree(&ops->locked.ins.name);
 	zfree(&ops->target.raw);
 	zfree(&ops->target.name);
+	symbol__zput(ops->target.sym);
 }
 
 const struct ins_ops lock_ops = {
@@ -1090,7 +1094,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 
 		if (!maps__find_ams(thread__maps(args->ms->thread), &target) &&
 		    symbol__start(target.ms.sym) == target.al_addr)
-			dl->ops.target.sym = target.ms.sym;
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
index dd388169c25b..7ae4e7664ba7 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -542,6 +542,7 @@ static int hist_entry__init(struct hist_entry *he,
 
 	he->ms.thread = thread__get(he->ms.thread);
 	he->ms.map = map__get(he->ms.map);
+	he->ms.sym = symbol__get(he->ms.sym);
 
 	if (he->branch_info) {
 		/*
@@ -558,8 +559,10 @@ static int hist_entry__init(struct hist_entry *he,
 
 		he->branch_info->from.ms.thread = thread__get(he->branch_info->from.ms.thread);
 		he->branch_info->from.ms.map = map__get(he->branch_info->from.ms.map);
+		he->branch_info->from.ms.sym = symbol__get(he->branch_info->from.ms.sym);
 		he->branch_info->to.ms.thread = thread__get(he->branch_info->to.ms.thread);
 		he->branch_info->to.ms.map = map__get(he->branch_info->to.ms.map);
+		he->branch_info->to.ms.sym = symbol__get(he->branch_info->to.ms.sym);
 	}
 
 	if (he->mem_info) {
@@ -592,6 +595,7 @@ static int hist_entry__init(struct hist_entry *he,
 
 	INIT_LIST_HEAD(&he->pairs.node);
 	he->thread = thread__get(he->thread);
+	he->parent = symbol__get(he->parent);
 	he->hroot_in  = RB_ROOT_CACHED;
 	he->hroot_out = RB_ROOT_CACHED;
 
@@ -727,6 +731,8 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 			if (hists__has(hists, sym) && he->ms.map != entry->ms.map) {
 				if (he->ms.sym) {
 					u64 addr = symbol__start(he->ms.sym);
+
+					symbol__put(he->ms.sym);
 					he->ms.sym = map__find_symbol(entry->ms.map, addr);
 				}
 
@@ -1028,7 +1034,8 @@ iter_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *al)
 	al->thread = thread__get(bi[i].to.ms.thread);
 	map__put(al->map);
 	al->map = map__get(bi[i].to.ms.map);
-	al->sym = bi[i].to.ms.sym;
+	symbol__put(al->sym);
+	al->sym = symbol__get(bi[i].to.ms.sym);
 	al->addr = bi[i].to.addr;
 	return 1;
 }
@@ -1342,9 +1349,11 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
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
@@ -1380,6 +1389,7 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 	if (!err)
 		err = err2;
 
+	symbol__zput(iter->parent);
 	map__put(alm);
 
 	return err;
@@ -1466,6 +1476,7 @@ void hist_entry__delete(struct hist_entry *he)
 	}
 
 	thread__zput(he->thread);
+	symbol__zput(he->parent);
 	map_symbol__exit(&he->ms);
 
 	if (he->branch_info) {
diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
index c4504cceb313..ca66c9afdcd6 100644
--- a/tools/perf/util/libdw.c
+++ b/tools/perf/util/libdw.c
@@ -98,7 +98,7 @@ static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
 		 * while DWARF keeps the pre-clone linkage name, which
 		 * left the outer frame spuriously tagged "(inlined)".
 		 */
-		inline_sym = args->sym;
+		inline_sym = symbol__get(args->sym);
 	} else {
 		/*
 		 * Prefer DW_AT_linkage_name so C++ inline frames keep
@@ -156,8 +156,7 @@ static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
 	return 0;
 
 abort_delete_sym:
-	if (symbol__inlined(inline_sym))
-		symbol__delete(inline_sym);
+	symbol__put(inline_sym);
 abort_enomem:
 	args->err = -ENOMEM;
 	return DWARF_CB_ABORT;
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
index cb30d858f62d..f1155c608a95 100644
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
@@ -3282,15 +3282,21 @@ struct dso *machine__findnew_dso(struct machine *machine, const char *filename)
 char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, char **modp)
 {
 	struct machine *machine = vmachine;
-	struct map *map;
+	struct map *map = NULL;
 	struct symbol *sym = machine__find_kernel_symbol(machine, *addrp, &map);
+	char *name;
 
-	if (sym == NULL)
+	if (sym == NULL) {
+		map__put(map);
 		return NULL;
+	}
 
 	*modp = __map__is_kmodule(map) ? (char *)dso__short_name(map__dso(map)) : NULL;
 	*addrp = map__unmap_ip(map, symbol__start(sym));
-	return (char *)symbol__name(sym);
+	name = (char *)symbol__name(sym);
+	symbol__put(sym);
+	map__put(map);
+	return name;
 }
 
 struct machine__for_each_dso_cb_args {
@@ -3338,19 +3344,27 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 
 		machine->sched.text_start = map__unmap_ip(kmap,
 							  symbol__start(sym));
+		symbol__put(sym);
+		map__put(kmap);
 
 		/* should not fail from here */
 		sym = machine__find_kernel_symbol_by_name(machine, "__sched_text_end", &kmap);
 		machine->sched.text_end = map__unmap_ip(kmap,
 							symbol__start(sym));
+		symbol__put(sym);
+		map__put(kmap);
 
 		sym = machine__find_kernel_symbol_by_name(machine, "__lock_text_start", &kmap);
 		machine->lock.text_start = map__unmap_ip(kmap,
 							 symbol__start(sym));
+		symbol__put(sym);
+		map__put(kmap);
 
 		sym = machine__find_kernel_symbol_by_name(machine, "__lock_text_end", &kmap);
 		machine->lock.text_end = map__unmap_ip(kmap,
 						       symbol__start(sym));
+		symbol__put(sym);
+		map__put(kmap);
 
 		sym = machine__find_kernel_symbol_by_name(machine, "__traceiter_contention_begin", &kmap);
 		if (sym) {
@@ -3358,6 +3372,8 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 								      symbol__start(sym));
 			machine->traceiter.text_end = map__unmap_ip(kmap,
 								    symbol__end(sym));
+			symbol__put(sym);
+			map__put(kmap);
 		}
 		sym = machine__find_kernel_symbol_by_name(machine, "trace_contention_begin", &kmap);
 		if (sym) {
@@ -3365,6 +3381,8 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 								  symbol__start(sym));
 			machine->trace.text_end = map__unmap_ip(kmap,
 								symbol__end(sym));
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
index 47dbe865c2f9..4b2d4db364b8 100644
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
@@ -3291,6 +3298,10 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
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
index d47f6865021e..6c8bce6c795e 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -814,7 +814,7 @@ static PyObject *pyrf_sample_event__srccode(PyObject *self, PyObject *args)
 		addr_location__init(&al);
 		al.thread = thread__get(pevent->al.thread);
 		al.map = map__get(pevent->al.map);
-		al.sym = pevent->al.sym;
+		al.sym = symbol__get(pevent->al.sym);
 		al.addr = pevent->al.addr;
 	}
 
@@ -877,6 +877,7 @@ struct pyrf_callchain_node {
 static void pyrf_callchain_node__delete(struct pyrf_callchain_node *pnode)
 {
 	map__put(pnode->map);
+	symbol__put(pnode->sym);
 	Py_TYPE(pnode)->tp_free((PyObject *)pnode);
 }
 
@@ -944,8 +945,10 @@ struct pyrf_callchain {
 static void pyrf_callchain__delete(struct pyrf_callchain *pchain)
 {
 	if (pchain->frames) {
-		for (u64 i = 0; i < pchain->nr_frames; i++)
+		for (u64 i = 0; i < pchain->nr_frames; i++) {
 			map__put(pchain->frames[i].map);
+			symbol__put(pchain->frames[i].sym);
+		}
 		free(pchain->frames);
 	}
 	Py_TYPE(pchain)->tp_free((PyObject *)pchain);
@@ -974,7 +977,7 @@ static PyObject *pyrf_callchain__item(PyObject *obj, Py_ssize_t i)
 
 	pnode->ip = pchain->frames[i].ip;
 	pnode->map = map__get(pchain->frames[i].map);
-	pnode->sym = pchain->frames[i].sym;
+	pnode->sym = symbol__get(pchain->frames[i].sym);
 
 	return (PyObject *)pnode;
 }
@@ -1486,7 +1489,8 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 					pchain->frames[i].ip = node->ip;
 					pchain->frames[i].map =
 						map__get(node->ms.map);
-					pchain->frames[i].sym = node->ms.sym;
+					pchain->frames[i].sym =
+						symbol__get(node->ms.sym);
 					callchain_cursor_advance(cursor);
 				}
 				pevent->callchain = (PyObject *)pchain;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 89e833f35fd2..79ea71aab13c 100644
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
index 53976de3105c..4151107ccae1 100644
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
@@ -468,9 +468,7 @@ void inline_node__clear_frames(struct inline_node *node)
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
index 73885413073b..90542fb643e9 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -351,10 +351,13 @@ static bool get_ifunc_name(Elf *elf, struct dso *dso, GElf_Ehdr *ehdr,
 
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
@@ -631,6 +634,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	f = dso__find_symbol_nocache(dso, shdr_plt.sh_offset);
 	if (f && symbol__start(f) < shdr_plt.sh_offset && symbol__end(f) > shdr_plt.sh_offset)
 		symbol__set_end(f, shdr_plt.sh_offset);
+	symbol__put(f);
 
 	if (!get_plt_sizes(dso, &ehdr, &shdr_plt, &plt_header_size, &plt_entry_size))
 		return 0;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index d25d8c96ee66..593fccfe3240 100644
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
@@ -331,11 +332,11 @@ void symbols__fixup_duplicate(struct symbols *symbols)
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
@@ -421,81 +422,96 @@ void symbols__fixup_end(struct symbols *symbols, bool is_kallsyms)
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
 
 int __symbols__insert(struct symbols *symbols, struct symbol *sym)
@@ -506,7 +522,7 @@ int __symbols__insert(struct symbols *symbols, struct symbol *sym)
 					       sizeof(struct symbol *) * to_allocate);
 
 		if (!temp) {
-			symbol__delete(sym);
+			symbol__put(sym);
 			return -ENOMEM;
 		}
 		symbols->symbols = temp;
@@ -559,7 +575,7 @@ static struct symbol *symbols__find(struct symbols *symbols, u64 ip)
 		else if (ip > end || (ip == end && ip != start))
 			low = mid + 1;
 		else {
-			res = s;
+			res = symbol__get(s);
 			break;
 		}
 	}
@@ -684,7 +700,7 @@ static struct symbol *symbols__find_by_name(struct symbol *symbols[],
 		}
 	}
 	assert(!found_idx || !s || s == symbols[*found_idx]);
-	return s;
+	return symbol__get(s);
 }
 
 int dso__insert_symbol(struct dso *dso, struct symbol *sym)
@@ -698,14 +714,16 @@ void dso__delete_symbol(struct dso *dso, struct symbol *sym)
 
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
@@ -724,11 +742,17 @@ struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr)
 
 struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx)
 {
-	if (*idx + 1 >= dso__symbol_names_len(dso))
-		return NULL;
+	struct symbols *symbols = dso__symbols(dso);
+	struct symbol *res = NULL;
+
+	down_read(&symbols->lock);
+	if (*idx + 1 < symbols->num_by_name) {
+		++*idx;
+		res = symbol__get(symbols->symbols_by_name[*idx]);
+	}
+	up_read(&symbols->lock);
 
-	++*idx;
-	return dso__symbol_names(dso)[*idx];
+	return res;
 }
 
  /*
@@ -736,16 +760,26 @@ struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx)
   */
 struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_t *idx)
 {
+	struct symbols *symbols;
 	struct symbol *s;
 
-	dso__sort_by_name(dso);
-	s = symbols__find_by_name(dso__symbol_names(dso),
-				  dso__symbol_names_len(dso),
+	symbols = dso__symbols(dso);
+	down_read(&symbols->lock);
+	while (!symbols->sorted_by_name) {
+		up_read(&symbols->lock);
+		dso__sort_by_name(dso);
+		down_read(&symbols->lock);
+		if (!symbols->sorted_by_name && !symbols->symbols_by_name)
+			break;
+	}
+	s = symbols__find_by_name(symbols->symbols_by_name,
+				  symbols->num_by_name,
 				  name, SYMBOL_TAG_INCLUDE__NONE, idx);
 	if (!s) {
-		s = symbols__find_by_name(dso__symbol_names(dso), dso__symbol_names_len(dso),
+		s = symbols__find_by_name(symbols->symbols_by_name, symbols->num_by_name,
 					  name, SYMBOL_TAG_INCLUDE__DEFAULT_ONLY, idx);
 	}
+	up_read(&symbols->lock);
 	return s;
 }
 
@@ -884,7 +918,8 @@ bool symbol__is_idle(struct symbol *sym, const struct dso *dso, struct perf_env
 	uint16_t e_machine;
 
 	{
-		uint16_t flags = atomic_load_explicit(&sym->flags, memory_order_relaxed);
+		uint16_t flags = atomic_load_explicit(&RC_CHK_ACCESS(sym)->flags,
+						      memory_order_relaxed);
 		uint16_t idle_val = (flags & SYMBOL_FLAG_IDLE_MASK) >> SYMBOL_FLAG_IDLE_SHIFT;
 
 		if (idle_val != SYMBOL_IDLE__UNKNOWN)
@@ -1032,7 +1067,7 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 		curr_map = maps__find(kmaps, symbol__start(pos));
 
 		if (!curr_map) {
-			symbol__delete(pos);
+			symbol__put(pos);
 			continue;
 		}
 		curr_map_dso = map__dso(curr_map);
@@ -1228,7 +1263,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 
 		continue;
 discard_symbol:
-		symbol__delete(pos);
+		symbol__put(pos);
 	}
 
 	root->cnt = write_idx;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 52cd6b43696c..a3c88b5224ec 100644
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
@@ -93,10 +94,12 @@ enum symbol_idle_kind {
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
@@ -143,85 +146,110 @@ void symbols__exit(struct symbols *symbols);
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
 static inline u64 symbol__start(const struct symbol *sym)
 {
-	return sym->start;
+	return RC_CHK_ACCESS(sym)->start;
 }
 
 static inline void symbol__set_start(struct symbol *sym, u64 start)
 {
-	sym->start = start;
+	RC_CHK_ACCESS(sym)->start = start;
 }
 
 static inline u64 symbol__end(const struct symbol *sym)
 {
-	return sym->end;
+	return RC_CHK_ACCESS(sym)->end;
 }
 
 static inline void symbol__set_end(struct symbol *sym, u64 end)
 {
-	sym->end = end;
+	RC_CHK_ACCESS(sym)->end = end;
 }
 
 static inline const char *symbol__name(const struct symbol *sym)
 {
-	return sym->name;
+	return RC_CHK_ACCESS(sym)->name;
 }
 
 static inline u16 symbol__namelen(const struct symbol *sym)
 {
-	return sym->namelen;
+	return RC_CHK_ACCESS(sym)->namelen;
 }
 
 static inline u8 symbol__arch_sym(const struct symbol *sym)
 {
-	return sym->arch_sym;
+	return RC_CHK_ACCESS(sym)->arch_sym;
 }
 
 static inline void symbol__set_arch_sym(struct symbol *sym, u8 arch_sym)
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
2.56.0.rc1.315.gc6ed9934b7-goog

