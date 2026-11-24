Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490988;
	b=jMDLoJPeHRvIHrOVzHF3GGnhuk5CV7OTbVJ0cn4B9PnADq5JhhMh84PWAsUA6/IXep+7
	 fcYDiJ5IPfxysnd+5z5J7107lVCj3GtAlgBotMn/iEiBvll461dAfFm/DMhSgCrJxMf2T
	 tEpCXQPdFqvlAUmGDUjfQkLxOZS4SRRoaR2B2ziGoPeFdkZi473eGPVl+0Qca2vCTy26G
	 6wWbAQIEDwwnv9qiYZXrl74C54yKIdPxIEAMEzrB6JXiIpNOq44NAIcZxsgOQ1cmP+CRP
	 D+FentmxchEoNo7m0KI1EKOkdtSWGFay7P3q5OzUgTNoJAXzruoEK5MvFeZ/URXqMTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=d14G2+gz7YJshYudZiPYX63qqKWX4VSLwYMf2zmeidE=;
	b=OdTzrmCgGsc6rlOl3nWQMCq+H4S8FoRauRklOGeerJL3OtMEt8gi/7d87d7KvDnWZrbc
	 FgSq5I4R5q6cy8VrlTdMwP1+WBLo2HN/GFJQu5d1oIkBESjBCXS7iWd9mT/ZBeFBZq+LE
	 +mVahbo/+qex5e2aqRN3bXNOEk9ew7ffrh9Jf3+N6BRsvd8FaTHUy40Db6755lRCQCoYf
	 zFbZqkxH2Ws6QE0Tco+qAg0AjgnqoKATnHOO4YWl9TWXXnyhwGs4BiWC/9hnAgtdVit70
	 P3qEBNxlXZZp1YafF8uMFln7kZxEwUQrdS96WX9dQ2DI+RpvP9eYSj9A+3TIqz7o5vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BDaZF345;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73343606A327
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 03:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73343606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BDaZF345
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1b3ae17c536so3980676c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 19:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795490988; x=1796095788; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d14G2+gz7YJshYudZiPYX63qqKWX4VSLwYMf2zmeidE=;
        b=BDaZF345nWQTE+EEUb0xiF/7F+sHWHAYcTNYRXUL2QIQe1dWFmkv8wzzhfXXysX/d5
         UjN7zLykb/E2eBl7NZymDMyrPx0gZKCN6O9URfMTgsfwCfGTjbTNxijjr7ZRocgPN6VL
         zLoRKEXhRlC5zbBKdFAWLtfP6Ie2fQthRU/iNt4STsfrY7rShf/JolMvYWqviyOZR/sa
         fkIuDTMTJUzHrQBKZ/9Z0rcW5wgtkQFBzO1755BQtIYqciFsSDrtX/gaTw+xRE2kbaAe
         0ifyY5Rh3UUR79bwB1yGOofWX05itCEO2U9pp118Kr5j0AftTh2pZmYX8/bCjBhbAKwy
         uk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490988; x=1796095788;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d14G2+gz7YJshYudZiPYX63qqKWX4VSLwYMf2zmeidE=;
        b=PaVrlSKo/aWgMnkBam1DAkgvDe68KObT2b5lfW7/1ERLrDzbz74AGGl5n0dRg4jVuN
         ftM9xHv98rrmmsVbWSaKOYNjDJlOGkuBiIKr60XMzKeXyqX9OGOE8iqFqdbLf7waSsBo
         YdjuaafoREtlodacms96VhC+w5BoPYjrf3N43z+p0SHfKYfYyBDFSxUhR/Ik0C8xSHqr
         PYZztIZuWz3DDmqxlK2bNSEnRZnWV/8R2RQsfvaiWdFfQ73OAv1eeVybZmrxiwbGmOcz
         7+m0p0GfK9zd1yv0Jkgi11mz4Rb6RCUXK6PHPsIar7ThD44lhf7pxdHTBJ7uozTUw3jP
         ER3g==
X-Forwarded-Encrypted: i=1; AL+hErF/IcSbEoa9dqsujRfbnV7AILG1yc4x6l3WGk9SgJcNzVmeQoJ9cejyKpMk46WnkCJxO997md7Y8GH8ADCCCysI@vger.kernel.org
X-Gm-Message-State: APuU4Z9eghMYLNRLB6TMd4+FbjRCeub7bOvFXD95eNCMa3shCvLVS1WG
	wtjPX6pg77UkXU/okgMZuqpxY8ZvcnfW6iFC+yistQK8diwtvl6Bc0hwgFLYxQaGPGg0mag6S5t
	aczI7VLqjjw==
X-Received: from dyx17.prod.google.com ([2002:a05:693c:8211:b0:378:1191:3e95])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3c0e:b0:190:596:4071
 with SMTP id a92af1059eb24-1b55689f722mr11371341c88.11.1795490987139; Mon, 23
 Nov 2026 19:29:47 -0800 (PST)
Date: Mon, 23 Nov 2026 19:29:00 -0800
In-Reply-To: <20261124032902.3859564-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124032902.3859564-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124032902.3859564-10-irogers@google.com>
Subject: [PATCH v9 09/11] perf test symbols: Add symbol and DSO shrinking tests
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add unit tests to tools/perf/tests/symbols.c covering symbol and DSO
memory shrinking:
- test_symbols_shrink(): Verify symbols__shrink() reclaims symbols_by_name
  and trims excess capacity while keeping live symbols intact, and verify
  symbols__try_delete_unannotated() respects symbol annotations.
- test_dsos_shrink(): Verify dsos__shrink() evicts unreferenced user DSOs
  while retaining referenced DSOs and vDSOs.
- test_dso_shrink_and_reload(): Verify dso__shrink() on a referenced ELF
  DSO preserves symbol pointers and rebuilds symbols_by_name on demand,
  dso_symbol__copy() pins DSO symbols across dsos__shrink() until
  dso_symbol__exit(), inline/srcline trees are freed safely before
  symbols, and evicted hit DSOs reload transparently on map__find_symbol().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/symbols.c | 361 +++++++++++++++++++++++++++++++++++++
 1 file changed, 361 insertions(+)

diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index 4e4f8eabec5b..1fd6bfdc4147 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -1,20 +1,31 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
+#include <linux/list.h>
 #include <linux/string.h>
+#include <linux/zalloc.h>
 #include <sys/mman.h>
 #include <elf.h>
+#include <errno.h>
 #include <inttypes.h>
 #include <limits.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
+#include "annotate.h"
 #include "debug.h"
 #include "dso.h"
 #include "env.h"
 #include "machine.h"
+#include "srcline.h"
 #include "thread.h"
 #include "symbol.h"
 #include "map.h"
+#include "map_symbol.h"
 #include "util.h"
+#include "vdso.h"
 #include "tests.h"
 
 struct test_info {
@@ -182,6 +193,341 @@ static int process_subdivided_dso(struct machine *machine, struct dso *dso)
 	return ret < 0 ? TEST_FAIL : TEST_OK;
 }
 
+static int noop_visit_cb(struct symbol *sym __maybe_unused, void *data __maybe_unused)
+{
+	return 0;
+}
+
+static int test_symbols_shrink(void)
+	__context_unsafe(/* single-threaded white-box test */)
+{
+	struct symbols symbols;
+	struct symbol *sym1, *sym2, *sym3;
+	int ret = TEST_FAIL;
+
+	symbols__init(&symbols);
+
+	sym1 = symbol__new(0x100, 0x50, STB_GLOBAL, STT_FUNC, "sym1");
+	sym2 = symbol__new(0x200, 0x50, STB_GLOBAL, STT_FUNC, "sym2");
+	sym3 = symbol__new(0x300, 0x50, STB_GLOBAL, STT_FUNC, "sym3");
+	if (!sym1 || !sym2 || !sym3) {
+		symbol__delete(sym1);
+		symbol__delete(sym2);
+		symbol__delete(sym3);
+		goto out;
+	}
+
+	symbols__insert(&symbols, sym1);
+	symbols__insert(&symbols, sym2);
+	symbols__insert(&symbols, sym3);
+	symbols__visit_by_name(&symbols, noop_visit_cb, NULL);
+	if (!symbols.symbols_by_name || symbols.allocated <= symbols.cnt) {
+		pr_debug("Expected populated symbols_by_name and excess capacity!\n");
+		goto out;
+	}
+
+	/*
+	 * First shrink: reclaims symbols_by_name and trims excess capacity in
+	 * symbols.symbols while keeping all 3 symbols intact.
+	 */
+	if (symbols__shrink(&symbols) != 2 || symbols.cnt != 3 ||
+	    symbols.allocated != 3 || symbols.symbols_by_name != NULL) {
+		pr_debug("First symbols__shrink failed (cnt=%u, allocated=%u)!\n",
+			 symbols.cnt, symbols.allocated);
+		goto out;
+	}
+
+	/*
+	 * Second shrink with no symbols_by_name and no excess capacity is a no-op.
+	 */
+	if (symbols__shrink(&symbols) != 0 || symbols.cnt != 3) {
+		pr_debug("Second symbols__shrink failed (cnt=%u)!\n", symbols.cnt);
+		goto out;
+	}
+
+	/*
+	 * Verify symbols__try_delete_unannotated() skips deletion when any
+	 * symbol has an entry in the annotations hashmap and deletes all
+	 * symbols once unannotated.
+	 */
+	if (!symbol__annotation(sym1) || !symbol__annotated(sym1)) {
+		pr_debug("symbol__annotation(sym1) failed!\n");
+		goto out;
+	}
+	if (symbols__try_delete_unannotated(&symbols, NULL, NULL) || symbols.cnt != 3) {
+		pr_debug("symbols__try_delete_unannotated deleted annotated table!\n");
+		goto out;
+	}
+	symbol__annotation_delete(sym1);
+	if (symbol__annotated(sym1) ||
+	    !symbols__try_delete_unannotated(&symbols, NULL, NULL) ||
+	    symbols.cnt != 0) {
+		pr_debug("symbols__try_delete_unannotated failed after clearing annotation!\n");
+		goto out;
+	}
+
+	ret = TEST_OK;
+out:
+	symbols__exit(&symbols);
+	return ret;
+}
+
+static int test_dsos_shrink(void)
+	__context_unsafe(/* single-threaded white-box test */)
+{
+	struct dsos dsos;
+	struct dso *dso1, *dso2, *vdso;
+	int ret = TEST_FAIL;
+
+	dsos__init(&dsos);
+
+	dso1 = dsos__findnew_id(&dsos, "/tmp/perf_test_dso1", NULL);
+	dso2 = dsos__findnew_id(&dsos, "/tmp/perf_test_dso2", NULL);
+	vdso = dsos__findnew_id(&dsos, DSO__NAME_VDSO, NULL);
+	if (!dso1 || !dso2 || !vdso) {
+		dso__put(dso1);
+		dso__put(dso2);
+		dso__put(vdso);
+		goto out;
+	}
+
+	/*
+	 * Keep the caller's active reference on dso1; drop caller references on
+	 * dso2 and vdso.
+	 */
+	dso__put(dso2);
+	dso__put(vdso);
+
+	/*
+	 * First shrink: dso2 has refcnt == 1 and no symbols, so it is evicted;
+	 * dso1 (refcnt == 2) and vdso (dso__is_vdso() == true) are retained.
+	 */
+	if (dsos__shrink(&dsos) != 1 || dsos.cnt != 2) {
+		pr_debug("First dsos__shrink failed (cnt=%u)!\n", dsos.cnt);
+		dso__put(dso1);
+		goto out;
+	}
+
+	dso__put(dso1);
+	if (dsos__shrink(&dsos) != 1 || dsos.cnt != 1 || !dso__is_vdso(dsos.dsos[0])) {
+		pr_debug("Second dsos__shrink failed (cnt=%u)!\n", dsos.cnt);
+		goto out;
+	}
+
+	ret = TEST_OK;
+out:
+	dsos__exit(&dsos);
+	return ret;
+}
+
+struct shrink_reload_find_args {
+	struct symbol *kept;
+	u64 first_start;
+	u64 second_start;
+	char *second_name;
+	u64 max_end;
+};
+
+static int shrink_reload_find_cb(struct symbol *sym, void *data)
+{
+	struct shrink_reload_find_args *args = data;
+
+	if (!args->kept) {
+		args->kept = sym;
+		args->first_start = sym->start;
+		args->max_end = sym->end;
+		return 0;
+	}
+	if (!args->second_name && sym->start >= args->max_end) {
+		args->second_start = sym->start;
+		args->second_name = strdup(sym->name);
+		if (!args->second_name)
+			return -ENOMEM;
+	}
+	if (sym->end > args->max_end)
+		args->max_end = sym->end;
+	return 0;
+}
+
+static int test_dso_shrink_and_reload(struct test_info *ti, char *filename, struct map **map_p)
+	__context_unsafe(/* single-threaded white-box test */)
+{
+	struct shrink_reload_find_args args = {
+		.kept = NULL,
+		.first_start = 0,
+		.second_start = 0,
+		.second_name = NULL,
+		.max_end = 0,
+	};
+	struct map *map = *map_p;
+	struct dso *dso = map__dso(map);
+	struct symbols *syms = dso__symbols(dso);
+	struct symbol *sym, *reloaded;
+	unsigned int initial_cnt;
+
+	if (!dso__can_shrink_symbols(dso) || dso__kernel(dso))
+		return TEST_SKIP;
+	initial_cnt = syms->cnt;
+	if (dso__for_each_symbol(dso, shrink_reload_find_cb, &args) < 0)
+		return TEST_FAIL;
+	if (!args.second_name)
+		return TEST_SKIP;
+
+	/*
+	 * While dso is referenced by map (refcnt > 1), dso__shrink() reclaims
+	 * auxiliary buffers (such as symbols_by_name) while keeping all symbols
+	 * and their pointers valid.
+	 */
+	dso__sort_by_name(dso);
+	if (!syms->symbols_by_name || syms->cnt < 2) {
+		free(args.second_name);
+		return TEST_FAIL;
+	}
+	{
+		size_t idx = 0;
+		struct symbol *expected_next = syms->symbols_by_name[1];
+		u8 hdr_byte = 0;
+
+		/* Populate dso data fd and cache so dso__shrink() reclaims them too. */
+		(void)dso__data_read_offset(dso, ti->machine, 0, &hdr_byte, 1);
+
+		if (dso__shrink(dso) == 0 || syms->cnt != initial_cnt ||
+		    syms->symbols_by_name != NULL || dso__data(dso)->fd >= 0) {
+			pr_debug("dso__shrink on referenced DSO failed!\n");
+			free(args.second_name);
+			return TEST_FAIL;
+		}
+		if (dso__next_symbol_by_name(dso, &idx) != expected_next || idx != 1) {
+			pr_debug("dso__next_symbol_by_name failed to rebuild symbols_by_name!\n");
+			free(args.second_name);
+			return TEST_FAIL;
+		}
+		dso__shrink(dso);
+	}
+
+	sym = dso__find_symbol(dso, args.first_start);
+	if (sym != args.kept) {
+		pr_debug("Symbol pointer changed after dso__shrink on referenced DSO!\n");
+		free(args.second_name);
+		return TEST_FAIL;
+	}
+
+	/*
+	 * Verify struct dso_symbol retains a reference on its owning DSO even
+	 * after the map reference is dropped, preventing dsos__shrink() from
+	 * evicting the DSO's symbol table until dso_symbol__exit() is called.
+	 */
+	dso__set_hit(dso);
+	{
+		struct dso_symbol src = {
+			.dso = dso,
+			.sym = args.kept,
+		};
+		struct dso_symbol pinned;
+		struct inline_node *inode;
+		struct symbol *inlined_sym;
+		char *srcline;
+
+		dso_symbol__copy(&pinned, &src);
+		map__zput(*map_p);
+		dsos__shrink(&ti->machine->dsos);
+		if (!dso__loaded(pinned.dso) ||
+		    dso__symbols(pinned.dso)->cnt != initial_cnt ||
+		    dso__find_symbol(pinned.dso, args.first_start) != pinned.sym) {
+			pr_debug("dso_symbol failed to pin DSO symbols across dsos__shrink!\n");
+			dso_symbol__exit(&pinned);
+			free(args.second_name);
+			return TEST_FAIL;
+		}
+
+		/*
+		 * Populate dso->inlined_nodes (referencing both a base symbol
+		 * from dso->symbols and an owned inlined symbol) and
+		 * dso->srclines so dsos__shrink() exercises freeing inlines
+		 * before freeing the underlying symbol table.
+		 */
+		inode = zalloc(sizeof(*inode));
+		inlined_sym = new_inline_sym(pinned.dso, pinned.sym, "inlined_helper");
+		srcline = strdup("test.c:1");
+		if (!inode || !inlined_sym || !srcline) {
+			free(inode);
+			if (inlined_sym && symbol__inlined(inlined_sym))
+				symbol__delete(inlined_sym);
+			free(srcline);
+			dso_symbol__exit(&pinned);
+			free(args.second_name);
+			return TEST_FAIL;
+		}
+		inode->addr = args.first_start;
+		INIT_LIST_HEAD(&inode->val);
+		if (inline_list__append(inlined_sym, SRCLINE_UNKNOWN, inode) < 0) {
+			if (symbol__inlined(inlined_sym))
+				symbol__delete(inlined_sym);
+			inline_node__delete(inode);
+			free(srcline);
+			dso_symbol__exit(&pinned);
+			free(args.second_name);
+			return TEST_FAIL;
+		}
+		if (inline_list__append(pinned.sym, SRCLINE_UNKNOWN, inode) < 0) {
+			inline_node__delete(inode);
+			free(srcline);
+			dso_symbol__exit(&pinned);
+			free(args.second_name);
+			return TEST_FAIL;
+		}
+		inlines__tree_insert(dso__inlined_nodes(pinned.dso), inode);
+		srcline__tree_insert(dso__srclines(pinned.dso), args.first_start, srcline);
+		dso_symbol__exit(&pinned);
+	}
+
+	if (dsos__shrink(&ti->machine->dsos) == 0) {
+		pr_debug("dsos__shrink did not reclaim unreferenced DSO symbols!\n");
+		free(args.second_name);
+		return TEST_FAIL;
+	}
+
+	if (create_map(ti, filename, map_p) != TEST_OK) {
+		free(args.second_name);
+		return TEST_FAIL;
+	}
+	map = *map_p;
+	dso = map__dso(map);
+	syms = dso__symbols(dso);
+	if (!dso__hit(dso) || syms->cnt != 0 || dso__loaded(dso) ||
+	    inlines__tree_find(dso__inlined_nodes(dso), args.first_start) != NULL ||
+	    srcline__tree_find(dso__srclines(dso), args.first_start) != NULL) {
+		pr_debug("Unreferenced hit DSO state mismatch after dsos__shrink!\n");
+		free(args.second_name);
+		return TEST_FAIL;
+	}
+
+	/* Lookup via map__find_symbol transparently reloads the DSO. */
+	reloaded = map__find_symbol(map, args.second_start);
+	if (!reloaded || strcmp(reloaded->name, args.second_name) != 0) {
+		pr_debug("Failed to reload evicted symbol %s!\n", args.second_name);
+		free(args.second_name);
+		return TEST_FAIL;
+	}
+
+	if (syms->cnt != initial_cnt || syms->sorted_cnt != syms->cnt || !dso__loaded(dso)) {
+		pr_debug("Reloaded symbol table state mismatch (cnt=%u vs %u, sorted_cnt=%u, loaded=%d)!\n",
+			 syms->cnt, initial_cnt, syms->sorted_cnt, dso__loaded(dso));
+		free(args.second_name);
+		return TEST_FAIL;
+	}
+	for (unsigned int i = 1; i < syms->cnt; i++) {
+		if (syms->symbols[i - 1]->start > syms->symbols[i]->start) {
+			pr_debug("Reloaded symbols out of order at %u!\n", i);
+			free(args.second_name);
+			return TEST_FAIL;
+		}
+	}
+
+	free(args.second_name);
+	return TEST_OK;
+}
+
 static int test_file(struct test_info *ti, char *filename)
 {
 	struct map *map = NULL;
@@ -213,6 +559,13 @@ static int test_file(struct test_info *ti, char *filename)
 	/* Module dso is split into many dsos by section */
 	if (ret == TEST_OK && dso__kernel(dso) != DSO_SPACE__USER)
 		ret = process_subdivided_dso(ti->machine, dso);
+
+	if (ret == TEST_OK) {
+		int shrink_ret = test_dso_shrink_and_reload(ti, filename, &map);
+
+		if (shrink_ret != TEST_SKIP)
+			ret = shrink_ret;
+	}
 out_put:
 	map__put(map);
 
@@ -461,6 +814,14 @@ static int test__symbols(struct test_suite *test __maybe_unused, int subtest __m
 	if (ret != TEST_OK)
 		return ret;
 
+	ret = test_symbols_shrink();
+	if (ret != TEST_OK)
+		return ret;
+
+	ret = test_dsos_shrink();
+	if (ret != TEST_OK)
+		return ret;
+
 	ret = init_test_info(&ti);
 	if (ret != TEST_OK)
 		return ret;
-- 
2.56.1.809.ga0b61035b5-goog

