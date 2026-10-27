Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142966;
	b=wUXkkcGr8qUL+7rzUEDX6MfK3wjwKYHU7hOxmhaZLWnCDQ9SitNGbEHT822VkcWi3Y7F
	 xEsdHcxlrJhudqV3YM49X3USGYZRT2f8qvmwLGFlRDOIIfMtQNnMazJ5bsp0oVStMBXq4
	 CzRhP5JxtfNuisGunDukuaKQci7JF1EzIpGDtvf6de2V/ZzvxjJe42iNp+oiGx4T1OnC4
	 q91t0smzc/+y/fLuJIGncBNQna2c68nVSf2CgHgFivv92jWjqAsM/KQ4BgS+95ehnaSGY
	 EQ6lKoB/hjsZ538lBpKjioyXAwNOYHd+HBN9M6yLxoORn6yeBwF9cchE+K5SAEvWgGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=pe3GSuD4LGl6lVRKcgy65zyTo8/iD3NoWxDHxP9Zlm8=;
	b=2my5YmPvRJa5wi0M1nYzNdMZA3vZvWk2C4fSy9BEXa0R1CkWXIpX6RRcR5kExKFV2Bmp
	 KGb8DSXjCSMY8u4NQvzw3d+jvcthU3unkY2ZIh3bAk9/mHFAzk+ohEO/XTr4Gk74ZGMuA
	 Pv8YIi6P2meLd57B84URlPo1L/yeZvOyOZgQqdOUy3TT9q6mkqo7l/y/MyC0/ZJEjd/dG
	 u53jeBJMg+sgso0RqkAbw56ziJa4u8mPgdekIjt1TyAMWBuljX6Y+ywiTJgl8HENCKZ7/
	 7mRREw5Jo3MxgeWhV4dBQ1Sil7/+D2B2AAa1ePRk4LmjfVVzUCGFt6Iy0HWVIHKx0cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o2Uxtmxj;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E9560A383C
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 23:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79E9560A383C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o2Uxtmxj
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-139b62317d0so1089229c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 16:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793142965; x=1793747765; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pe3GSuD4LGl6lVRKcgy65zyTo8/iD3NoWxDHxP9Zlm8=;
        b=o2UxtmxjVvAB6Rci3S+LSIE0BF6fLZrXhU/6xG08l7S4pknv18DcJPTSziiktSmuQg
         2lDaJLEt64O53e7sa19/0iHJ4Ey+qZdy2Ip2xsFytQyDiIwuUNLWCqzjGVzueqsHs55s
         ARvDVdNq89nRMadItdowhnY+mhPZ03uupHr6D2Wz2d7pd5A4Se3wnD4YoRvzq17ivwYM
         qr79TigjTO5COEoptaqqPE8QxBgo5Lt9gjPru3QQ/5IFzCZfySwAgMtxSPJsvkNvxwfE
         OL6rmeQifI7PV2PtOLhYqsrsrJvOm5CWTIfiXMilOzh6Qbb4M61tCpFK0zHWdrl/WB90
         3Pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142965; x=1793747765;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pe3GSuD4LGl6lVRKcgy65zyTo8/iD3NoWxDHxP9Zlm8=;
        b=GE2fmlrOuoaFTejW9SeVfLSjEvP0hQLDA2BfpG244555n+7283JEWVhn1dLBsg998Z
         Zr5Ga4rhgam3d6URpkIIfs87s6nWh5nbKAAomEEpN4pVY7ygjGd/sus2SSM9ZmcQDUxn
         M8vgG+HVItgtX/ehyp8U+3GII9bYaot3qU6D/keswlDRIGi1r+w6p3O+oW49SGK1JA7w
         x79+PGwR+b0bkm1SM9b6UbSyT1t0XUtT0SC3tGQQ8JzXVjqn5SA57zRU3q5hIXrslmE9
         /LPy349fztOuBIVjBom7wbx1t1JXQ+yf7OZRVuTuYvv1ZnSjonzNs5EfmEL/qB7Smph3
         FC+A==
X-Forwarded-Encrypted: i=1; AKwUvBwQPxY/uVd41oYfcZUh66X8gZ7WsJRwtjnvw6F5wOP2AE4yeOcsCdrOdcTkYf/zcejyhyC3YuYxCIusLKcR3ZW2@vger.kernel.org
X-Gm-Message-State: AFq9FYIJBFGWT+GxaUCAyB9ModYeNjPK5foyTbSkJNrYbFtRmgqgoboN
	Q82nE6GUBQHWsWUviTVMmgVphcrXImi0fg7Mg+OGLqU1U7bgDPXoUT/D6gVJXyHh+pljY9otKqZ
	UiVyIrMId/A==
X-Received: from dlbcf38.prod.google.com ([2002:a05:7022:45a6:b0:195:8b4e:20b7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1716:b0:186:3f0c:bd09
 with SMTP id a92af1059eb24-1a6c800e43amr1004776c88.5.1793142964241; Tue, 27
 Oct 2026 16:16:04 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:15:12 -0700
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
Message-ID: <20261027231513.816148-19-irogers@google.com>
Subject: [PATCH v2 18/18] perf test symbols: Add tests for symbol shrinking
 and session alloc wrappers
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, haghdoost@uber.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Ensure the new symbol sorting, reference-counted symbol and DSO
shrinking, transparent DSO reload with retained-symbol pointer
preservation, and session-scoped allocation wrappers are verified by
'perf test symbols' (including under REFCNT_CHECKING=1).

Add unit tests to 'perf test symbols' covering:
- test_symbols_sorted_insert(): Verify ascending symbols__insert(),
  out-of-order dso__insert_symbol() maintaining sorted order, and
  unsorted symbols__insert() followed by sort-on-lookup in
  dso__find_symbol().
- test_symbols_shrink(): Verify symbols__shrink() evicts unreferenced
  symbols (refcnt == 1), retains symbols with active external references
  (refcnt > 1), and sets symbols.shrunk.
- test_dsos_shrink(): Verify dsos__shrink() evicts unreferenced user
  DSOs with no remaining symbols while retaining DSOs with active
  external references.
- test_session_alloc_shrink(): Verify machine__session(),
  dso__session(), perf_session__malloc/zalloc/calloc/realloc/strdup(),
  and perf_session__shrink().
- test_dso_shrink_and_reload(): Verify dso__shrink() on a loaded ELF
  binary followed by map__find_symbol() transparently reloads evicted
  symbols while preserving pointer identity for retained symbols.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/symbols.c | 372 +++++++++++++++++++++++++++++++++++++
 1 file changed, 372 insertions(+)

diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index d70adbad3978..1a773c535732 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -1,13 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 #include <linux/string.h>
+#include <linux/zalloc.h>
 #include <sys/mman.h>
+#include <errno.h>
 #include <inttypes.h>
 #include <limits.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 #include "debug.h"
 #include "dso.h"
 #include "env.h"
 #include "machine.h"
+#include "session.h"
 #include "thread.h"
 #include "symbol.h"
 #include "map.h"
@@ -179,6 +187,264 @@ static int process_subdivided_dso(struct machine *machine, struct dso *dso)
 	return ret < 0 ? TEST_FAIL : TEST_OK;
 }
 
+static int test_symbols_shrink(void)
+{
+	struct symbols symbols;
+	struct symbol *sym1, *sym2, *sym3, *held;
+	int ret = TEST_FAIL;
+
+	symbols__init(&symbols);
+
+	sym1 = symbol__new(0x100, 0x50, STB_GLOBAL, STT_FUNC, "sym1");
+	sym2 = symbol__new(0x200, 0x50, STB_GLOBAL, STT_FUNC, "sym2");
+	sym3 = symbol__new(0x300, 0x50, STB_GLOBAL, STT_FUNC, "sym3");
+	if (!sym1 || !sym2 || !sym3) {
+		symbol__put(sym1);
+		symbol__put(sym2);
+		symbol__put(sym3);
+		goto out;
+	}
+
+	/* Hold an active reference on sym1; sym2 and sym3 only have the table ref. */
+	held = symbol__get(sym1);
+
+	symbols__insert(&symbols, sym1);
+	symbols__insert(&symbols, sym2);
+	symbols__insert(&symbols, sym3);
+
+	/*
+	 * First shrink: sym2 and sym3 (refcnt == 1) are evicted; sym1 has
+	 * refcnt > 1 and is retained.
+	 */
+	if (symbols__shrink(&symbols) != 2 || symbols.cnt != 1 || !symbols.shrunk) {
+		pr_debug("First symbols__shrink failed (cnt=%u)!\n", symbols.cnt);
+		symbol__put(held);
+		goto out;
+	}
+
+	/*
+	 * Drop caller reference on sym1 and shrink again: sym1 is now evicted.
+	 */
+	symbol__put(held);
+	if (symbols__shrink(&symbols) != 1 || symbols.cnt != 0) {
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
+	struct dso *dso1, *dso2;
+	int ret = TEST_FAIL;
+
+	dsos__init(&dsos);
+
+	dso1 = dsos__findnew_id(&dsos, "/tmp/perf_test_dso1", NULL);
+	dso2 = dsos__findnew_id(&dsos, "/tmp/perf_test_dso2", NULL);
+	if (!dso1 || !dso2) {
+		dso__put(dso1);
+		dso__put(dso2);
+		goto out;
+	}
+
+	/* Keep the caller's active reference on dso1; drop caller reference on dso2. */
+	dso__put(dso2);
+
+	/*
+	 * First shrink: dso2 has refcnt == 1 and no symbols, so it is evicted;
+	 * dso1 has refcnt == 2, so it is retained.
+	 */
+	if (dsos__shrink(&dsos) != 1 || dsos.cnt != 1) {
+		pr_debug("First dsos__shrink failed (cnt=%u)!\n", dsos.cnt);
+		dso__put(dso1);
+		goto out;
+	}
+
+	dso__put(dso1);
+	if (dsos__shrink(&dsos) != 1 || dsos.cnt != 0) {
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
+	char *p1 = NULL, *p2 = NULL, *p3 = NULL, *s = NULL;
+	int ret = TEST_FAIL;
+
+	if (!session)
+		return TEST_FAIL;
+
+	if (machines__init(&session->machines, session))
+		goto out;
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
+	p1 = perf_session__realloc(session, p1, 128);
+	if (!p1) {
+		pr_debug("perf_session__realloc failed!\n");
+		goto out;
+	}
+
+	if (perf_session__shrink(session) == 0 || session->machines.host.dsos.cnt != 0) {
+		pr_debug("perf_session__shrink failed to evict unreferenced DSO!\n");
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
+		args->kept = symbol__get(sym);
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
+static int test_dso_shrink_and_reload(struct dso *dso, struct map *map)
+{
+	struct shrink_reload_find_args args = {
+		.kept = NULL,
+		.first_start = 0,
+		.second_start = 0,
+		.second_name = NULL,
+		.max_end = 0,
+	};
+	struct symbol *sym, *reloaded;
+	size_t removed;
+
+	if (!dso__can_shrink_symbols(dso) || dso__kernel(dso))
+		return TEST_OK;
+	if (dso__for_each_symbol(dso, shrink_reload_find_cb, &args) < 0) {
+		symbol__put(args.kept);
+		return TEST_FAIL;
+	}
+	if (!args.second_name) {
+		symbol__put(args.kept);
+		return TEST_OK;
+	}
+
+	/* Unreferenced symbols have refcnt == 1 and are evicted immediately. */
+	removed = dso__shrink(dso);
+	if (removed == 0 || !dso__symbols_shrunk(dso)) {
+		pr_debug("dso__shrink did not evict any symbols!\n");
+		free(args.second_name);
+		symbol__put(args.kept);
+		return TEST_FAIL;
+	}
+
+	/* Kept symbol is still found without reloading. */
+	sym = dso__find_symbol(dso, args.first_start);
+	if (!RC_CHK_EQUAL(sym, args.kept)) {
+		pr_debug("Kept symbol not found after dso__shrink!\n");
+		symbol__put(sym);
+		free(args.second_name);
+		symbol__put(args.kept);
+		return TEST_FAIL;
+	}
+	symbol__put(sym);
+
+	/* Evicted symbol is no longer in dso->symbols before reload. */
+	sym = dso__find_symbol(dso, args.second_start);
+	if (sym != NULL) {
+		pr_debug("Evicted symbol still found after dso__shrink!\n");
+		symbol__put(sym);
+		free(args.second_name);
+		symbol__put(args.kept);
+		return TEST_FAIL;
+	}
+
+	/* Lookup via map__find_symbol transparently reloads the DSO. */
+	reloaded = map__find_symbol(map, args.second_start);
+	if (!reloaded || strcmp(symbol__name(reloaded), args.second_name) != 0) {
+		pr_debug("Failed to reload evicted symbol %s!\n", args.second_name);
+		symbol__put(reloaded);
+		free(args.second_name);
+		symbol__put(args.kept);
+		return TEST_FAIL;
+	}
+	symbol__put(reloaded);
+
+	/* Kept symbol pointer was preserved across reload deduplication. */
+	sym = dso__find_symbol(dso, args.first_start);
+	if (!RC_CHK_EQUAL(sym, args.kept)) {
+		pr_debug("Kept symbol pointer was not preserved across reload!\n");
+		symbol__put(sym);
+		free(args.second_name);
+		symbol__put(args.kept);
+		return TEST_FAIL;
+	}
+	symbol__put(sym);
+	symbol__zput(args.kept);
+
+	free(args.second_name);
+	return TEST_OK;
+}
+
 static int test_file(struct test_info *ti, char *filename)
 {
 	struct map *map = NULL;
@@ -210,18 +476,124 @@ static int test_file(struct test_info *ti, char *filename)
 	/* Module dso is split into many dsos by section */
 	if (ret == TEST_OK && dso__kernel(dso) != DSO_SPACE__USER)
 		ret = process_subdivided_dso(ti->machine, dso);
+
+	if (ret == TEST_OK)
+		ret = test_dso_shrink_and_reload(dso, map);
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
+			symbol__put(sym);
+			goto out;
+		}
+		symbol__put(sym);
+	}
+
+	ret = TEST_OK;
+out:
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
-- 
2.56.0.313.g2479322e68-goog

