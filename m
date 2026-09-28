Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B51469838
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581987; cv=none; b=tz8Mf4UVFvehgG1OqYqJlEmELUVbnNlkdmDDPX7Q5nJQDL4BFi5Ou8f9wr6qkUjCY8NhSkIkhgLcHssbYRiegfLm6mtZyikFesnMHq8RuYjPvX50LvJ6kNJ8Pa1Hrp9vD1clz/kfidkRBdCODQ2sI9/LhaIVBS5F5q5pt6Z0RqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581987; c=relaxed/simple;
	bh=0W74A4G0Kg33QjW9HnZEJgQHl2T6OmKbbVPBHe5PjFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=P08JgQIYtGefmJ1iLOgGfXgd34+FXiRgev8GsLoN7Tu0RtB0NxmQ1kznWvlQI2CZaOtMPrGcSUZjSSzdiY2ueofyd6TKoyFFSGwOEZ9bx992IATxScrXDg9kUwVeEWbE5zHekN5NXOja7hb8QN/7l34vOjt0ILSHnrXfg2+t4PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M2QLmjSU; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M2QLmjSU"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3441e2b3fc3so1346255eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 00:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790581984; x=1791186784; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q5+y+5qudjVInjOkSlb/vD7Hzp5i1XRcQfzv89496r8=;
        b=M2QLmjSUI4ITwBHe+SHoCrtKCQXy6SUViObeZRyWJkEhtCausWyLCPbjO7WMUT0v5X
         CaecziCn2hPAHWZe2EYYUI2Angnjm9OcxUWAGmxcGCAEOWpH8c2ncOpcBHdjAOB1GsId
         G7SOW4NroGO3tUlaUmRiR6InKx5OpLSfb0Dz0VYMeKxeIJbckKs+zXoEx8DVMc4bbYQM
         M3MSfdxMJvspi8Y9vxN5YOFk36u+Dd0YDzrXHiwLCwi+MBM0dii9XY9mTMv/wTjORk2B
         I1O2vOpZggivv6y8SeyOqGwMst/g11M2xPCYSZ9+hbqRSFutRxj/GZYKGiB7ezKlwBrl
         RENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581984; x=1791186784;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q5+y+5qudjVInjOkSlb/vD7Hzp5i1XRcQfzv89496r8=;
        b=mYpQcc53Co9cP26sY34ltQKXGcBH+SFR+3GODKDH0pft2sjOU6nTga56wkZsapiwT7
         EGJt1CbpSC8Fi/qRcSpkxiC1dYzHFHGFbZwkkWr6m3kcj/CaRsHTdYvaQyxhPmvKewgr
         4WbC1MwX/ZechC7qLHd7uJ32dGz9iu///gNJX3e+e6X5dJ6TaxIX8q2ZYXLgpA3ZDqoe
         Pa6PbVSJwVqtdWuqdqHkxd19DcVkSjU72qivs4DUYlGKTDfg/cwbn/LFWS0BSoBUW6WX
         wcDWl583DA0idQPouoxKIEh3ylIHa6SXy+8JXM6krZmd5K60WalZ3xA8yTjdgCFW1CaG
         qivQ==
X-Forwarded-Encrypted: i=1; AKwUvByxVPu1xr8Q8Tks+fUJAuI6VfMtbE9FM6CgI5OMoQllNQkJ6ZEbW9WKeL7LiYxjCtJNpTPdyMy+JrOU4bEu1wTo@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6eqr40SQkcdPyIapQOF3t89T6LxrzW4CmMiGVhA7isioRdHvG
	xsqvBuQ7d8NcFvpB8PRnpOBDKM6FrjL/o8AtNGXnQE7vCvYwW+GK0lMrdGWMkYqU/h4BFFFNpIB
	ftDlNGNoHyQ==
X-Received: from dybgi42.prod.google.com ([2002:a05:7301:aa:b0:33e:6278:a7ac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4e4b:b0:342:ca31:2b82
 with SMTP id 5a478bee46e88-342ca313203mr8002165eec.33.1790581983159; Mon, 28
 Sep 2026 00:53:03 -0700 (PDT)
Date: Mon, 28 Sep 2026 00:52:37 -0700
In-Reply-To: <20260928075237.3055101-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928075237.3055101-8-irogers@google.com>
Subject: [PATCH v1 7/7] perf test symbols: Add tests for symbol and DSO LRU shrinking
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alireza Haghdoost <haghdoost@uber.com>
Content-Type: text/plain; charset="UTF-8"

Add unit tests in tools/perf/tests/symbols.c covering:
- symbols__shrink(): Second-Chance / Clock eviction of unaccessed
  symbols, clearing of SYMBOL_FLAG_ACCESSED on survival, and retention
  of symbols with external reference counts (refcnt > 1).
- dsos__shrink(): Second-Chance / Clock eviction of cold DSOs from
  struct dsos while retaining accessed DSOs and externally referenced
  DSOs.
- dso__shrink() and map__find_symbol(): Shrinking a loaded DSO's symbol
  table and verifying that a subsequent map__find_symbol() transparently
  reloads the symbol table on demand.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/symbols.c | 228 +++++++++++++++++++++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index 440d800d9f4d..6113acbaf602 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -3,6 +3,8 @@
 #include <linux/string.h>
 #include <sys/mman.h>
 #include <limits.h>
+#include <stdlib.h>
+#include <string.h>
 #include "debug.h"
 #include "dso.h"
 #include "env.h"
@@ -178,6 +180,221 @@ static int process_subdivided_dso(struct machine *machine, struct dso *dso)
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
+	/* Hold an active reference on sym1, and mark sym2 accessed. */
+	held = symbol__get(sym1);
+	symbol__set_accessed(sym2, true);
+
+	symbols__insert(&symbols, sym1);
+	symbols__insert(&symbols, sym2);
+	symbols__insert(&symbols, sym3);
+
+	/*
+	 * First shrink: sym3 (unreferenced) is evicted; sym2 gets a second
+	 * chance because SYMBOL_FLAG_ACCESSED was set; sym1 has refcnt > 1.
+	 */
+	if (symbols__shrink(&symbols) != 1 || symbols.cnt != 2) {
+		pr_debug("First symbols__shrink failed (cnt=%u)!\n", symbols.cnt);
+		symbol__put(held);
+		goto out;
+	}
+
+	/*
+	 * Second shrink: sym2 was not accessed since first shrink, so it is now
+	 * evicted; sym1 still has refcnt > 1.
+	 */
+	if (symbols__shrink(&symbols) != 1 || symbols.cnt != 1) {
+		pr_debug("Second symbols__shrink failed (cnt=%u)!\n", symbols.cnt);
+		symbol__put(held);
+		goto out;
+	}
+
+	symbol__set_accessed(held, false);
+	symbol__put(held);
+	if (symbols__shrink(&symbols) != 1 || symbols.cnt != 0) {
+		pr_debug("Third symbols__shrink failed (cnt=%u)!\n", symbols.cnt);
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
+	 * First shrink: both DSOs had accessed=true from creation, so neither
+	 * is evicted on the first pass (Clock second chance), and accessed is
+	 * cleared.
+	 */
+	if (dsos__shrink(&dsos) != 0 || dsos.cnt != 2) {
+		pr_debug("First dsos__shrink failed (cnt=%u)!\n", dsos.cnt);
+		dso__put(dso1);
+		goto out;
+	}
+
+	/*
+	 * Second shrink: dso2 has refcnt == 1 and accessed == false, so it is
+	 * evicted; dso1 has refcnt == 2, so it is kept.
+	 */
+	if (dsos__shrink(&dsos) != 1 || dsos.cnt != 1) {
+		pr_debug("Second dsos__shrink failed (cnt=%u)!\n", dsos.cnt);
+		dso__put(dso1);
+		goto out;
+	}
+
+	dso__put(dso1);
+	if (dsos__shrink(&dsos) != 1 || dsos.cnt != 0) {
+		pr_debug("Third dsos__shrink failed (cnt=%u)!\n", dsos.cnt);
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
+};
+
+static int shrink_reload_find_cb(struct symbol *sym, void *data)
+{
+	struct shrink_reload_find_args *args = data;
+
+	if (!args->kept) {
+		args->kept = symbol__get(sym);
+		args->first_start = symbol__start(sym);
+		return 0;
+	}
+	if (symbol__start(sym) != args->first_start) {
+		args->second_start = symbol__start(sym);
+		args->second_name = strdup(symbol__name(sym));
+		return args->second_name ? 1 : -ENOMEM;
+	}
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
+	};
+	struct symbol *sym, *reloaded;
+	size_t removed;
+
+	if (!dso__can_shrink_symbols(dso) || dso__kernel(dso))
+		return TEST_OK;
+
+	if (dso__for_each_symbol(dso, shrink_reload_find_cb, &args) < 0) {
+		symbol__put(args.kept);
+		return TEST_FAIL;
+	}
+	if (!args.second_name) {
+		symbol__put(args.kept);
+		return TEST_OK;
+	}
+
+	/* Unreferenced symbols have SYMBOL_FLAG_ACCESSED == false and are evicted immediately. */
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
+		pr_debug("Evicted symbol still present after dso__shrink!\n");
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
+
+	free(args.second_name);
+	symbol__put(args.kept);
+	return TEST_OK;
+}
+
 static int test_file(struct test_info *ti, char *filename)
 {
 	struct map *map = NULL;
@@ -209,6 +426,9 @@ static int test_file(struct test_info *ti, char *filename)
 	/* Module dso is split into many dsos by section */
 	if (ret == TEST_OK && dso__kernel(dso) != DSO_SPACE__USER)
 		ret = process_subdivided_dso(ti->machine, dso);
+
+	if (ret == TEST_OK)
+		ret = test_dso_shrink_and_reload(dso, map);
 out_put:
 	map__put(map);
 
@@ -221,6 +441,14 @@ static int test__symbols(struct test_suite *test __maybe_unused, int subtest __m
 	struct test_info ti;
 	int ret;
 
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
2.56.0.rc1.315.gc6ed9934b7-goog

