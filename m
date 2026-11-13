Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590339;
	b=RlvuBq5lfoN8Lb/tEt+yLLDRPj+NgCGJU65JirOEObMEveJE8Ib29iiyLfs1dZSXbT3t
	 alRlp6v8YIHtqeCeLgyk4GTPOppYyRc7TKw5x4qOFu3RJoyPsutY5rTpJ0+26Xi5fyWRY
	 GSsTbx8Qk9VcOxjySW06SB8F0EVvp80WMoaEQ3ejRmIRpmmb1VT1fHjWIEGf73LO7nnvo
	 RK/uzOH8EJkWZbBLBEBo09/V9k63T5X+TGbk5oj6ZX4NfyGj20M8Mn/igGAQ9XTnubt4l
	 G8Ar82/EeZmhRt2mZdf/INPoIzf7/4dpF4tdyo5IMfvhsTMqnJUztaQmMKwshfUHkDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=xlDIGmkcb7NyxW3pW+VtoMDxZ75nzVKA+7dNV6XMTSM=;
	b=TkZK/O9Ap9Xw+1+c+0nC4d3YeRbkbNc9jzgPSeU6iKotXKN7nGwwpR7FDYk8QvDzUZcM
	 l+6qM2AypSyCFZkakgNT3GZuUTYaRJnZ+JXGWxuBZDQe3ZRb/Ut5Tl026auXtKU6lkQNa
	 KaVrj8RZQSt/UbVHZ/7mITk4uX0hTfeD/c1/kzZz+T3qtx2+hJ93zWpEJhQiffwi5evHC
	 6WMImbUMwJYnQSV+Bd1o3fOH7TdGLWkfKolPzD/yJP16us6Ve0iEfKsXzZivOc+jayicD
	 /s5PaMpS9TRx94Nm4luz8vQdntG2+5C/IeenqFLKjcwGMO8jUeQ75g8mVbPoh2aINWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I0D0pB0S;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F9D606D4B4
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74F9D606D4B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I0D0pB0S
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c0d568830so1635009eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 09:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794590338; x=1795195138; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xlDIGmkcb7NyxW3pW+VtoMDxZ75nzVKA+7dNV6XMTSM=;
        b=I0D0pB0SUDTE3S+iw4j6OjVg/WeLP8u6yg/202hsLRowm3RnHlBA6t8xYoLFoesBZg
         CqMg5CvTmQSyrLS3Z2NDCYZVqmYINhI9VuKHyvdkOvLaGd9Sdz/2fp+i3TrtPq4cUJey
         xzGLYB7uZbr8kMNBnCA2h1GRYLzclDTF2+5z+Wk9v+XySvh6PhqN5JfDtkW/lHzrme+m
         wGaDjTS6FTqLwPAfDG4rgZKUdIxfvFjVHvNH0CB3R6aQ0TjNEjDtcQ0Ob12zSgIttaOT
         D5AMi/Z9dJ7Qu++50rI1+Z3J7lVhnzaTjThImcZSdtbX2hqvG2isYiywra2q9BluN3Hm
         JBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590338; x=1795195138;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xlDIGmkcb7NyxW3pW+VtoMDxZ75nzVKA+7dNV6XMTSM=;
        b=rpVmPOaGXStM5pVBcTBBtVVtPjhBQbzM20Ush1fBMQ0+opPCAq0h5X0A16IQ3GlpO+
         V8CVXzi804fcvFcBq8u5BIU3WddLSOUaeaC3CWDGTRjLE1j/hWSPs6IUWooCJcgPY7+T
         WJut2/yxxUfl5p6etTdluSNTrKHWtBmLI7fMe9U1d2XjnJj4VNgsBAbi/PsrDIFgnH8O
         Ngm3HVcEAe6eCGJrjtgt8v8ZHXONA5h491maf1zCNDcgXt0XWXzpU549gyyACYxOmAPx
         Ts8Iy9pAqOJoOiJ3uzCj68cIkferKEGLxFw/5C4FC8i7mdW9+2hJPhkpoWprRvuNFCsN
         Relg==
X-Forwarded-Encrypted: i=1; AL+hErHt4yNhHXrK5A6uuGQTZKAVYrpfrOh5wSNEF15bB0Bd5ge8/ajtflWmwT69RQV23mx833TC+2qOORp5kIbJSK3E@vger.kernel.org
X-Gm-Message-State: APuU4Z8i8Z6tReUMy+r0d9tIVnIic/aBmnlwzS0EqzXjJE9SV5vwO/Lb
	QdaDkkYNvE22p5vmS/ceaaSX+rpH/7iNbluoPdlIZJsHSfyQXw1a2LIWSU9tNrT+VPnIJ1WRH4h
	Y4B0/KCyl9w==
X-Received: from dlbph9.prod.google.com ([2002:a05:7022:3709:b0:1a0:8cef:34d5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:66cd:20b0:36c:9af3:2309
 with SMTP id 5a478bee46e88-3796047bba6mr2488639eec.0.1794590337184; Fri, 13
 Nov 2026 09:18:57 -0800 (PST)
Date: Fri, 13 Nov 2026 09:17:34 -0800
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
Message-ID: <20261113171734.2188066-24-irogers@google.com>
Subject: [PATCH v4 23/23] perf test symbols: Add tests for symbol shrinking
 and session alloc wrappers
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Ensure the new symbol sorting, DSO-lifetime symbol and DSO shrinking,
dso_symbol reference pinning, on-demand DSO reload after unreferenced
eviction, and session-scoped allocation wrappers are verified by
'perf test symbols' (including under REFCNT_CHECKING=1).

Add unit tests to 'perf test symbols' covering:
- test_symbols_sorted_insert(): Verify ascending symbols__insert(),
  out-of-order dso__insert_symbol() maintaining sorted order, and
  unsorted symbols__insert() followed by sort-on-lookup in
  dso__find_symbol().
- test_symbols_shrink(): Verify symbols__shrink() and
  symbols__try_delete_unannotated() respect held locks without
  deadlocking, reclaim the secondary symbols_by_name index, and trim
  unused capacity in symbols->symbols while keeping live symbols intact.
- test_dsos_shrink(): Verify dsos__shrink() evicts unreferenced user
  DSOs while retaining DSOs with active external references and vDSOs.
- test_session_alloc_shrink(): Verify machine__session(),
  dso__session(), perf_session__malloc/zalloc/calloc/realloc/strdup(),
  and perf_session__shrink().
- test_dso_shrink_and_reload(): Verify dso__shrink() on a referenced ELF
  DSO reclaims auxiliary buffers while preserving symbol pointers,
  dso_symbol__copy() pins DSO symbols across dsos__shrink() until
  dso_symbol__exit(), and dsos__shrink() on an unreferenced hit DSO
  evicts its symbol table and transparently reloads it on a subsequent
  map__find_symbol().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/symbols.c | 671 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 660 insertions(+), 11 deletions(-)

diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index 1185ab0731e0..1297cb277d2a 100644
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
 #include "debug.h"
 #include "dso.h"
 #include "env.h"
 #include "machine.h"
+#include "session.h"
+#include "srcline.h"
 #include "thread.h"
 #include "symbol.h"
 #include "map.h"
+#include "map_symbol.h"
 #include "util.h"
+#include "vdso.h"
 #include "tests.h"
 
 struct test_info {
@@ -182,6 +193,412 @@ static int process_subdivided_dso(struct machine *machine, struct dso *dso)
 	return ret < 0 ? TEST_FAIL : TEST_OK;
 }
 
+static int noop_visit_cb(struct symbol *sym __maybe_unused, void *data __maybe_unused)
+{
+	return 0;
+}
+
+static int test_symbols_shrink(void)
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
+	 * Verify symbols__shrink() (via down_write_trylock()) does not
+	 * re-enter when symbols->lock is already held on the current thread.
+	 */
+	down_write(&symbols.lock);
+	if (symbols__shrink(&symbols) != 0 || symbols.cnt != 3) {
+		up_write(&symbols.lock);
+		pr_debug("symbols__shrink re-entered held write lock!\n");
+		goto out;
+	}
+	up_write(&symbols.lock);
+
+	down_read(&symbols.lock);
+	if (symbols__try_delete_unannotated(&symbols, NULL, NULL) || symbols.cnt != 3) {
+		up_read(&symbols.lock);
+		pr_debug("symbols__try_delete_unannotated re-entered held read lock!\n");
+		goto out;
+	}
+	up_read(&symbols.lock);
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
+	ret = TEST_OK;
+out:
+	symbols__exit(&symbols);
+	return ret;
+}
+
+static int test_dsos_shrink(void)
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
+static int test_session_alloc_shrink(void)
+{
+	struct perf_session *session = zalloc(sizeof(*session));
+	struct dso *dso;
+	struct thread *th;
+	pid_t pid = getpid();
+	char *p1 = NULL, *p2 = NULL, *p3 = NULL, *s = NULL, *tmp;
+	int ret = TEST_FAIL;
+
+	if (!session)
+		return TEST_FAIL;
+
+	perf_env__init(&session->header.env);
+	if (machines__init(&session->machines, session))
+		goto out;
+	session->machines.host.env = &session->header.env;
+	if (machine__session(&session->machines.host) != session) {
+		pr_debug("machine__session did not return owning session!\n");
+		goto out;
+	}
+
+	dso = machine__findnew_dso(&session->machines.host, "/tmp/perf_test_session_dso");
+	if (!dso)
+		goto out;
+	if (dso__session(dso) != session) {
+		pr_debug("dso__session did not return owning session!\n");
+		dso__put(dso);
+		goto out;
+	}
+	dso__put(dso);
+
+	p1 = perf_session__malloc(session, 64);
+	p2 = perf_session__zalloc(session, 64);
+	p3 = perf_session__calloc(session, 4, 16);
+	s = perf_session__strdup(session, "perf_session_alloc_test");
+	if (!p1 || !p2 || !p3 || !s || strcmp(s, "perf_session_alloc_test") != 0) {
+		pr_debug("perf_session allocation wrappers failed!\n");
+		goto out;
+	}
+
+	tmp = perf_session__realloc(session, p1, 128);
+	if (!tmp) {
+		pr_debug("perf_session__realloc failed!\n");
+		goto out;
+	}
+	p1 = tmp;
+
+	if (perf_session__shrink(session) == 0 || session->machines.host.dsos.cnt != 0) {
+		pr_debug("perf_session__shrink failed to evict unreferenced DSO!\n");
+		goto out;
+	}
+
+	/*
+	 * Verify perf_session__e_machine() -> threads__for_each_thread() does
+	 * not self-deadlock on table->lock when a non-leader thread looks up or
+	 * creates its leader thread in the same shard.
+	 */
+	th = machine__findnew_thread(&session->machines.host, pid,
+				     pid + THREADS__TABLE_SIZE);
+	if (!th)
+		goto out;
+	thread__put(th);
+	if (perf_session__e_machine(session, NULL) == EM_NONE) {
+		pr_debug("perf_session__e_machine failed!\n");
+		goto out;
+	}
+
+	ret = TEST_OK;
+out:
+	free(p1);
+	free(p2);
+	free(p3);
+	free(s);
+	machines__exit(&session->machines);
+	perf_env__exit(&session->header.env);
+	free(session);
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
+		args->first_start = symbol__start(sym);
+		args->max_end = symbol__end(sym);
+		return 0;
+	}
+	if (!args->second_name && symbol__start(sym) >= args->max_end) {
+		args->second_start = symbol__start(sym);
+		args->second_name = strdup(symbol__name(sym));
+		if (!args->second_name)
+			return -ENOMEM;
+	}
+	if (symbol__end(sym) > args->max_end)
+		args->max_end = symbol__end(sym);
+	return 0;
+}
+
+static int test_dso_shrink_and_reload(struct test_info *ti, char *filename, struct map **map_p)
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
+	if (syms->num_by_name < 2) {
+		free(args.second_name);
+		return TEST_FAIL;
+	}
+	{
+		size_t idx = 0;
+		struct symbol *expected_next = syms->symbols_by_name[1];
+
+		if (dso__shrink(dso) == 0 || syms->cnt != initial_cnt ||
+		    syms->symbols_by_name != NULL) {
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
+	if (!reloaded || strcmp(symbol__name(reloaded), args.second_name) != 0) {
+		pr_debug("Failed to reload evicted symbol %s!\n", args.second_name);
+		free(args.second_name);
+		return TEST_FAIL;
+	}
+
+	if (syms->cnt != initial_cnt || !syms->sorted || !dso__loaded(dso)) {
+		pr_debug("Reloaded symbol table state mismatch (cnt=%u vs %u, sorted=%d, loaded=%d)!\n",
+			 syms->cnt, initial_cnt, syms->sorted, dso__loaded(dso));
+		free(args.second_name);
+		return TEST_FAIL;
+	}
+	for (unsigned int i = 1; i < syms->cnt; i++) {
+		if (symbol__start(syms->symbols[i - 1]) > symbol__start(syms->symbols[i])) {
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
@@ -213,18 +630,240 @@ static int test_file(struct test_info *ti, char *filename)
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
 
 	return ret;
 }
 
+static int test_symbols_sorted_insert(void)
+{
+	struct dso *dso = dso__new("/tmp/perf_test_sorted_insert");
+	struct symbols *symbols;
+	int ret = TEST_FAIL;
+
+	if (!dso)
+		return TEST_FAIL;
+
+	symbols = dso__symbols(dso);
+
+	/*
+	 * Insert 100 odd-indexed symbols in ascending order via
+	 * symbols__insert(), then insert 5 even-indexed symbols out of order via
+	 * dso__insert_symbol() and verify symbols->sorted remains true.
+	 */
+	for (unsigned int i = 0; i < 100; i++) {
+		char name[32];
+		u64 addr = (u64)(i * 2 + 1) * 0x100;
+		struct symbol *sym;
+
+		snprintf(name, sizeof(name), "sym_%u", i * 2 + 1);
+		sym = symbol__new(addr, 0x40, STB_GLOBAL, STT_FUNC, name);
+		if (!sym || symbols__insert(symbols, sym))
+			goto out;
+	}
+	if (!symbols->sorted || symbols->cnt != 100) {
+		pr_debug("Expected sorted=true, cnt=100 after ordered inserts\n");
+		goto out;
+	}
+
+	for (unsigned int i = 0; i < 5; i++) {
+		char name[32];
+		u64 addr = (u64)(i * 20) * 0x100;
+		struct symbol *sym;
+
+		snprintf(name, sizeof(name), "ins_%u", i * 20);
+		sym = symbol__new(addr, 0x40, STB_GLOBAL, STT_FUNC, name);
+		if (!sym || dso__insert_symbol(dso, sym))
+			goto out;
+		if (!symbols->sorted) {
+			pr_debug("dso__insert_symbol did not preserve sorted invariant!\n");
+			goto out;
+		}
+	}
+
+	/*
+	 * Now append 95 remaining even-indexed symbols in descending order via
+	 * symbols__insert() to exercise the unsorted append + sort-on-lookup path.
+	 */
+	for (unsigned int i = 99; i > 0; i--) {
+		char name[32];
+		u64 addr;
+		struct symbol *sym;
+
+		if ((i * 2) % 20 == 0 && (i * 2) < 100)
+			continue;
+		addr = (u64)(i * 2) * 0x100;
+		snprintf(name, sizeof(name), "ins_%u", i * 2);
+		sym = symbol__new(addr, 0x40, STB_GLOBAL, STT_FUNC, name);
+		if (!sym || symbols__insert(symbols, sym))
+			goto out;
+	}
+	if (symbols->sorted || symbols->cnt != 200) {
+		pr_debug("Unexpected sorted=%d cnt=%u before lookup\n",
+			 symbols->sorted, symbols->cnt);
+		goto out;
+	}
+
+	for (unsigned int i = 0; i < 200; i++) {
+		u64 addr = (u64)i * 0x100 + 0x10;
+		struct symbol *sym = dso__find_symbol(dso, addr);
+
+		if (!sym || symbol__start(sym) != (u64)i * 0x100) {
+			pr_debug("Lookup failed at idx %u (addr=%#" PRIx64 ")\n", i, addr);
+			goto out;
+		}
+	}
+
+	/*
+	 * Insert a dynamic symbol into the unmerged sorted tail inside an
+	 * existing primary-prefix symbol's [0x0, 0x40) range and verify lookup
+	 * resolves to the closer tail symbol rather than the outer prefix one.
+	 */
+	{
+		struct symbol *inner = symbol__new(0x20, 0x10, STB_GLOBAL, STT_FUNC,
+						   "inner_tail_sym");
+
+		if (!inner || dso__insert_symbol(dso, inner))
+			goto out;
+		if (symbols->sorted_cnt >= symbols->cnt) {
+			pr_debug("Expected unmerged sorted tail!\n");
+			goto out;
+		}
+		if (dso__find_symbol(dso, 0x24) != inner) {
+			pr_debug("Tail symbol lookup returned outer prefix symbol!\n");
+			goto out;
+		}
+	}
+
+	ret = TEST_OK;
+out:
+	dso__put(dso);
+	return ret;
+}
+
+static int test_symbols_equal_start_aliases(void)
+{
+	struct dso *dso = dso__new("/tmp/perf_test_equal_start_aliases");
+	struct map *map = NULL;
+	struct symbols *symbols;
+	struct symbol *sized_sym, *zero_alias, *last_sized, *last_short, *found;
+	int ret = TEST_FAIL;
+
+	if (!dso)
+		return TEST_FAIL;
+
+	map = map__new2(0, dso);
+	if (!map)
+		goto out;
+
+	symbols = dso__symbols(dso);
+	sized_sym = symbol__new(0x1000, 0x40, STB_GLOBAL, STT_FUNC, "sized_sym");
+	zero_alias = symbol__new(0x1000, 0, STB_GLOBAL, STT_FUNC, "zero_alias");
+	last_sized = symbol__new(0x2000, 0x80, STB_GLOBAL, STT_FUNC, "last_sized");
+	if (!sized_sym || !zero_alias || !last_sized) {
+		symbol__delete(sized_sym);
+		symbol__delete(zero_alias);
+		symbol__delete(last_sized);
+		goto out;
+	}
+
+	if (symbols__insert(symbols, sized_sym)) {
+		symbol__delete(zero_alias);
+		symbol__delete(last_sized);
+		goto out;
+	}
+	if (symbols__insert(symbols, zero_alias)) {
+		symbol__delete(last_sized);
+		goto out;
+	}
+	if (symbols__insert(symbols, last_sized))
+		goto out;
+
+	/*
+	 * With 3 entries [0x1000..0x1040, 0x1000..0x1000, 0x2000..0x2080], a
+	 * lookup at 0x1020 must rewind past the trailing zero-length alias at
+	 * 0x1000 and find sized_sym.
+	 */
+	found = dso__find_symbol(dso, 0x1020);
+	if (found != sized_sym) {
+		pr_debug("Expected sized_sym at 0x1020, got %s\n",
+			 found ? symbol__name(found) : "NULL");
+		goto out;
+	}
+
+	/*
+	 * symbols__fixup_end() must not inflate zero_alias to 0x2000 when
+	 * sized_sym already provides a non-zero size at 0x1000.
+	 */
+	symbols__fixup_end(symbols, /*is_kallsyms=*/false);
+	if (symbol__end(zero_alias) != 0x1000) {
+		pr_debug("zero_alias inflated to %#" PRIx64 "\n", symbol__end(zero_alias));
+		goto out;
+	}
+	symbols__fixup_duplicate(symbols);
+	found = dso__find_symbol(dso, 0x1020);
+	if (found != sized_sym || symbol__end(found) != 0x1040) {
+		pr_debug("After dedup expected sized_sym [0x1000, 0x1040), got %s\n",
+			 found ? symbol__name(found) : "NULL");
+		goto out;
+	}
+
+	/*
+	 * Append a shorter alias at the final start address 0x2000 (as when
+	 * symbol_conf.allow_aliases is set) and verify map__fixup_end() uses
+	 * the maximum end across the equal-start group.
+	 */
+	last_short = symbol__new(0x2000, 0x10, STB_WEAK, STT_FUNC, "last_short");
+	if (!last_short || symbols__insert(symbols, last_short))
+		goto out;
+
+	map__fixup_end(map);
+	if (map__end(map) != 0x2080) {
+		pr_debug("Expected map end 0x2080, got %#" PRIx64 "\n", map__end(map));
+		goto out;
+	}
+
+	ret = TEST_OK;
+out:
+	map__put(map);
+	dso__put(dso);
+	return ret;
+}
+
 static int test__symbols(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	char filename[PATH_MAX];
 	struct test_info ti;
 	int ret;
 
+	ret = test_symbols_sorted_insert();
+	if (ret != TEST_OK)
+		return ret;
+
+	ret = test_symbols_equal_start_aliases();
+	if (ret != TEST_OK)
+		return ret;
+
+	ret = test_symbols_shrink();
+	if (ret != TEST_OK)
+		return ret;
+
+	ret = test_dsos_shrink();
+	if (ret != TEST_OK)
+		return ret;
+
+	ret = test_session_alloc_shrink();
+	if (ret != TEST_OK)
+		return ret;
+
 	ret = init_test_info(&ti);
 	if (ret != TEST_OK)
 		return ret;
@@ -240,24 +879,28 @@ static int test__symbols(struct test_suite *test __maybe_unused, int subtest __m
 
 struct kallsyms_sym {
 	u64 start;
+	u8 binding;
 	const char *name;
 };
 
 /*
  * kallsyms from an x86 host where nf_tables was loaded in the page right
  * after the last symbol of dca, plus a kernel symbol followed closely by a
- * module and a module far away from the others.
+ * module, a weak/global alias pair at the same address, and a module far
+ * away from the others.
  */
 static const struct kallsyms_sym kallsyms_syms[] = {
-	{ 0xffffffff81000000, "_stext" },
-	{ 0xffffffff81000ff0, "last_kernel_symbol" },
-	{ 0xffffffff81001000, "near_module_symbol\t[near]" },
-	{ 0xffffffffc0c4aa40, "dca_exit\t[dca]" },
-	{ 0xffffffffc0c4aa50, "dca_sysfs_exit\t[dca]" },
-	{ 0xffffffffc0c4b000, "__nft_trace_packet\t[nf_tables]" },
-	{ 0xffffffffc0c4b0b0, "nft_do_chain\t[nf_tables]" },
-	{ 0xffffffffc0c4b4e0, "nf_tables_core_module_exit\t[nf_tables]" },
-	{ 0xffffffffc2000000, "far_module_symbol\t[far]" },
+	{ 0xffffffff81000000, STB_GLOBAL, "_stext" },
+	{ 0xffffffff81000500, STB_WEAK, "weak_alias_symbol" },
+	{ 0xffffffff81000500, STB_GLOBAL, "global_target_symbol" },
+	{ 0xffffffff81000ff0, STB_GLOBAL, "last_kernel_symbol" },
+	{ 0xffffffff81001000, STB_GLOBAL, "near_module_symbol\t[near]" },
+	{ 0xffffffffc0c4aa40, STB_GLOBAL, "dca_exit\t[dca]" },
+	{ 0xffffffffc0c4aa50, STB_GLOBAL, "dca_sysfs_exit\t[dca]" },
+	{ 0xffffffffc0c4b000, STB_GLOBAL, "__nft_trace_packet\t[nf_tables]" },
+	{ 0xffffffffc0c4b0b0, STB_GLOBAL, "nft_do_chain\t[nf_tables]" },
+	{ 0xffffffffc0c4b4e0, STB_GLOBAL, "nf_tables_core_module_exit\t[nf_tables]" },
+	{ 0xffffffffc2000000, STB_GLOBAL, "far_module_symbol\t[far]" },
 };
 
 static int check_symbol(struct dso *dso, u64 addr, const char *name, u64 end)
@@ -287,7 +930,8 @@ static int test__kallsyms_fixup_end(struct test_suite *test __maybe_unused,
 		return TEST_FAIL;
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(kallsyms_syms); i++) {
-		struct symbol *sym = symbol__new(kallsyms_syms[i].start, 0, 0, 0,
+		struct symbol *sym = symbol__new(kallsyms_syms[i].start, 0,
+						 kallsyms_syms[i].binding, STT_FUNC,
 						 kallsyms_syms[i].name);
 
 		if (!sym)
@@ -296,8 +940,13 @@ static int test__kallsyms_fixup_end(struct test_suite *test __maybe_unused,
 	}
 
 	symbols__fixup_end(dso__symbols(dso), true);
+	symbols__fixup_duplicate(dso__symbols(dso));
 
 	ret = TEST_OK;
+	/* Same-address weak/global alias pair resolves to global_target_symbol. */
+	if (check_symbol(dso, 0xffffffff81000510, "global_target_symbol",
+			 0xffffffff81000ff0))
+		ret = TEST_FAIL;
 	/* The next symbol is too close for the end of the page. */
 	if (check_symbol(dso, 0xffffffff81000ff8, "last_kernel_symbol",
 			 0xffffffff81001000))
-- 
2.56.1.703.gf848ed807c-goog

