Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810900;
	b=B2NhkSEtO/l0bO2HOSAhEsInKYvLJfr9sfghlGcxp5YG3fsAZWCEwkTqJoeOO3c/6Swy
	 xk3Xbc35czSY8xUd69lg8ceR66J1Gbd54IIOfiENTgoEgvOXxQTXQVJudInnIxzBLPIKh
	 MWofArNTE1gmVZF5gCh+VNVIImaEFX4N+HQsVrJVuVDWxFwzLsCQdX+BeW89uGbTtNvIn
	 k5t8b9UjcqIjxD3ZszdMLDK+ZLVHxUZRljdCwEBzBFYWXm9yoIa07PdjPjri00I4xntTM
	 s8YGb2h5wKwbI2z9nQmRTV2a7/l0vMdYOkp+0ZWNzaj7pp1SXYfA0kqZGlhLFuLEx4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=y4JEGcFdkc1RyRs31tc7Yz/xUvvH9uI9+WmPVSPBUV0=;
	b=BlK1K0T4bzEFtTjhrtJXJK4s8bQNKT2AI38zgr6xJN80P4pqUlIrzgsiKTIZXir61/U2
	 eFbXMfUKnPayy4Hz2g2SP8ybg30er/qRz6vcyntHo4vqT/wk8lYjgRiOJzqNrvKJxg2cV
	 zB4LvzQURL6N93umQgIqGHBpFGQjPUNssFwhQHXkEt8AB2tCYfcvgXJyyk+v+l9h0oWza
	 HehXjzYC66hL9RPqXSkHbn2xotbH3VD1/edS5hN17emaD5VQj0fY0d8jhFZK9buTInG/3
	 Ej/5bwPTp2/yzt+26kLpU+WgEEdZutaigm6cszGmAOMsN9W1Rlz2KOKf9JbMT4ROWzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gQtNMpAE;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6660A2614
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27B6660A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gQtNMpAE
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-378722fd4a3so3634511eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 22:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794810899; x=1795415699; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y4JEGcFdkc1RyRs31tc7Yz/xUvvH9uI9+WmPVSPBUV0=;
        b=gQtNMpAEsolVO459M+mCQBQI+SqHEehPDiG+RCItsckXXo+w6BNHElcsco1+JsIik2
         EpMerZh9455gHWKbpTFdilcZ8y1aqVFb7nJRujdr+ZGSLWZ/apDQf+HyYNw7pMp/B0J2
         ydEO/brMHfChx9wcRKGLBjGJ4Up0HfAppeA5PdAgTNk5gzGriNaWuVE+y2G3ZsKH4fJO
         Xlz4CN02C/rIAM8Egr4NDz9TW5/g2WgvUY2Y5KiGJ74nR7TgVHbH4KEvOaQplaRS4m0J
         1tovVVTJKrLqkTGnr2xyoV5wDqs9fFfv2qJAgSP/bF44fr91l/LlJyGYC4mlWmFU6e6p
         lFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794810899; x=1795415699;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y4JEGcFdkc1RyRs31tc7Yz/xUvvH9uI9+WmPVSPBUV0=;
        b=LdhQXSnwOEyIgmDZ0VkI1gDpAYD+wRiubkWhnA2hwULILGzkpwU0AENUN+rgxyB/od
         kH9TV0/z2bU9aUg8wVBemAgIcy7d7p4gFZ+KtkV/4eo2C0dP/xlVVUAr6qWNO5lF3fGc
         7lyAs4cUZDzUQSKM2HXt25sfQ6HJ0689T+oPXicLJzAwVNrdiXgAlpgdRv74hJ/k2AiO
         i9RuBiUzf2mOQIUKgtc0XEYJcFrohHB6HktPCZPUfivHL5I2w4mDtJJBeGG87KA0LQKb
         Vkyx4+WUtAaekP1v0IHtIqERa9TJR90da7lWqN00OHgAe6VEw8fSQ1awEBWGPzUmO4HA
         YfGA==
X-Forwarded-Encrypted: i=1; AL+hErFPVd3kp8PpvFUNsvcnCrfED+tao3U+v1umPffU/6c6/xFGpavUnwP5O97UXOCur99DjX+oTCuCTd0VlfW7hnd5@vger.kernel.org
X-Gm-Message-State: APuU4Z8e8gQsHNzLbMPRoRsF5yvlF9uGN5lpaSTloUCkHPQUtDxwdk6I
	ZelgnyJ9uYLGsfvy5i1VQ8A0dL4+dFtHAfF6RJlR/o8BWUvKhKRNr3VvwolZTdX+AQCC9mEhaqD
	XVfhc7w5qwQ==
X-Received: from dycpv5.prod.google.com ([2002:a05:7300:de05:b0:36e:8352:e26a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:e10f:b0:37e:744d:6a95
 with SMTP id 5a478bee46e88-37e744d7397mr3519572eec.25.1794810897701; Sun, 15
 Nov 2026 22:34:57 -0800 (PST)
Date: Sun, 15 Nov 2026 22:34:35 -0800
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
Message-ID: <20261116063435.2817923-10-irogers@google.com>
Subject: [PATCH v5 9/9] perf test symbols: Add tests for symbol shrinking and
 session alloc wrappers
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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
- test_symbols_shrink(): Verify symbols__shrink() reclaims the secondary
  symbols_by_name index and trims unused capacity in symbols->symbols
  while keeping live symbols intact, and verify
  symbols__try_delete_unannotated() preserves annotated symbol tables.
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
 tools/perf/tests/symbols.c | 748 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 737 insertions(+), 11 deletions(-)

diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index 1220f97b77bb..29b46ee43e71 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -1,20 +1,34 @@
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
+#include <pthread.h>
+#include <stdatomic.h>
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
@@ -182,6 +196,486 @@ static int process_subdivided_dso(struct machine *machine, struct dso *dso)
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
+struct shrink_lock_race_args {
+	struct dso *dso;
+	atomic_bool stop;
+};
+
+static void *shrink_lock_race_worker(void *arg)
+{
+	struct shrink_lock_race_args *args = arg;
+
+	while (!atomic_load_explicit(&args->stop, memory_order_relaxed))
+		dso__find_binary_type(args->dso);
+
+	return NULL;
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
+	 * Regression test for AB-BA lock inversion between dso__lock(dso_A)
+	 * (held by dso__load() when calling perf_session__shrink() to evict
+	 * unreferenced dso_B) and _dso__data_open_lock (acquired before
+	 * dso__lock(dso_A) by dso__find_binary_type()).
+	 */
+	dso = machine__findnew_dso(&session->machines.host, "/tmp/perf_test_contended_dso");
+	if (!dso)
+		goto out;
+	{
+		bool was_singlethreaded = perf_singlethreaded;
+		struct shrink_lock_race_args race_args = {
+			.dso = dso,
+			.stop = false,
+		};
+		pthread_t worker;
+
+		perf_set_multithreaded();
+		if (pthread_create(&worker, NULL, shrink_lock_race_worker, &race_args) != 0) {
+			if (was_singlethreaded)
+				perf_set_singlethreaded();
+			dso__put(dso);
+			goto out;
+		}
+		for (int i = 0; i < 200; i++) {
+			struct dso *evict = machine__findnew_dso(&session->machines.host,
+								 "/tmp/perf_test_evict_dso");
+
+			dso__put(evict);
+			mutex_lock(dso__lock(dso));
+			RC_CHK_ACCESS(dso)->bintype_searched = 0;
+			perf_session__shrink(session);
+			mutex_unlock(dso__lock(dso));
+		}
+		atomic_store_explicit(&race_args.stop, true, memory_order_relaxed);
+		pthread_join(worker, NULL);
+		if (was_singlethreaded)
+			perf_set_singlethreaded();
+	}
+	dso__put(dso);
+	perf_session__shrink(session);
+
+	/*
+	 * Verify perf_session__e_machine() -> threads__for_each_thread() does
+	 * not self-deadlock on table->lock when a non-leader thread looks up or
+	 * creates its leader thread in the same shard.
+	 */
+	{
+		bool was_singlethreaded = perf_singlethreaded;
+		uint16_t e_machine;
+
+		perf_set_multithreaded();
+		th = machine__findnew_thread(&session->machines.host, pid,
+					     pid + THREADS__TABLE_SIZE);
+		if (!th) {
+			if (was_singlethreaded)
+				perf_set_singlethreaded();
+			goto out;
+		}
+		thread__put(th);
+		e_machine = perf_session__e_machine(session, NULL);
+		if (was_singlethreaded)
+			perf_set_singlethreaded();
+		if (e_machine == EM_NONE) {
+			pr_debug("perf_session__e_machine failed!\n");
+			goto out;
+		}
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
+	if (syms->cnt != initial_cnt || !syms->sorted || !dso__loaded(dso)) {
+		pr_debug("Reloaded symbol table state mismatch (cnt=%u vs %u, sorted=%d, loaded=%d)!\n",
+			 syms->cnt, initial_cnt, syms->sorted, dso__loaded(dso));
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
@@ -213,18 +707,240 @@ static int test_file(struct test_info *ti, char *filename)
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
+		if (!sym || sym->start != (u64)i * 0x100) {
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
+			 found ? found->name : "NULL");
+		goto out;
+	}
+
+	/*
+	 * symbols__fixup_end() must not inflate zero_alias to 0x2000 when
+	 * sized_sym already provides a non-zero size at 0x1000.
+	 */
+	symbols__fixup_end(symbols, /*is_kallsyms=*/false);
+	if (zero_alias->end != 0x1000) {
+		pr_debug("zero_alias inflated to %#" PRIx64 "\n", zero_alias->end);
+		goto out;
+	}
+	symbols__fixup_duplicate(symbols);
+	found = dso__find_symbol(dso, 0x1020);
+	if (found != sized_sym || found->end != 0x1040) {
+		pr_debug("After dedup expected sized_sym [0x1000, 0x1040), got %s\n",
+			 found ? found->name : "NULL");
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
@@ -240,24 +956,28 @@ static int test__symbols(struct test_suite *test __maybe_unused, int subtest __m
 
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
@@ -287,7 +1007,8 @@ static int test__kallsyms_fixup_end(struct test_suite *test __maybe_unused,
 		return TEST_FAIL;
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(kallsyms_syms); i++) {
-		struct symbol *sym = symbol__new(kallsyms_syms[i].start, 0, 0, 0,
+		struct symbol *sym = symbol__new(kallsyms_syms[i].start, 0,
+						 kallsyms_syms[i].binding, STT_FUNC,
 						 kallsyms_syms[i].name);
 
 		if (!sym)
@@ -296,8 +1017,13 @@ static int test__kallsyms_fixup_end(struct test_suite *test __maybe_unused,
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

