Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559478;
	b=HkiN9C5e1elw3+A/NbtpDo7T+fTbgO0sOU4dl9d/SUAyDWTHkdCNe6Q855F/n3prYjM4
	 aku+0ZZMwIvVHEQQNQNViPzHXtG95OrgN/OYSJhfYSurO4VKiFaqewXIP25HBXkB1Epz6
	 gRWEpxhSpqmfDZZVD8gkUAacmdj9Sr9viSpbipNTWXefdfUa7lyDuJhLKkJR+5fk8aAnC
	 2h1PANBmGXQ0LSzbt4jMcRFjS1gOvg8xLmSbehDqhfFYwJPznqxaoxhAScj0kT3siwaiu
	 PEFLAI7byOYnE7HdUGIMk1VK/c/7YCKhJwQqE3BjnF2HRUGjCh9f2fdxr5rYPhOiudg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=c536sWW2rimx1N1MpOLJFvt+7kCYzuGmbKYiaW7Fjw0=;
	b=nZkW7PH4lwYPANh9cOmlKH/xwZR8nD9ODusrdWBbIBaWq1bsHFsdGV4Yv+0FSvEs6MZM
	 isCNOcEoMxqNegoNm9T/vMEQi0AZI0F2M3xgOZQsQ0YZRq8jsH0htSHp8CnAOHLV3kjPS
	 kYBOdQ/dR5OzebleP6CaDF7z4wWKQHRo0jo8E5gX5wD4mo6icecM8Cjd03EVSwmwqDT6F
	 zdCtBXugGQPbJvK7XKHH3GpzTK7RJkv6Z7UgDv1Wv+b/L46LTNvUys8VA/wDu/dJohBU6
	 trvsY9mgDqeI6j1p2i1PeMmEOnFDfqaPmcfMja0ltyIQak/jv/Lp7GkiWhlHYn114nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bZoflTbI;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779C2606A323
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 22:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 779C2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bZoflTbI
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-38355b03cb8so4965305eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 14:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795559477; x=1796164277; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c536sWW2rimx1N1MpOLJFvt+7kCYzuGmbKYiaW7Fjw0=;
        b=bZoflTbIG9KGzDVh3fB+LgkBJiw7692oPF0NQ+UCTmTiXJSW4aaFbjtd4sxccGP06Y
         wm55ZlrCJuidSCK8cblLvfPnyo3bf9pjRcfWehsgafUB6gYGOB/3gFVZrNzbeYA3xqFU
         LUjDAVK0zUldwt/H9PTlw9bcxbNJCchuIF/ZFV/BehIrud0btHSHT6itLVf5riZv9Ivv
         fa8733fiFQRQtiu5e7JhRARxy5bjd2ax4BxPqo16x2/uJE8YzeUUYl+zdxpiVL8R4V1a
         x6ZmcPMuk26N2MTvoe439A06RVHk0qIoVcVi7GlNv4r8joJ57ZwwLKmMaTTelnEspK/a
         lI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795559477; x=1796164277;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c536sWW2rimx1N1MpOLJFvt+7kCYzuGmbKYiaW7Fjw0=;
        b=YXpjsJHHpEAHL/JIFaATkGWqfWM/JO4h3EJwu/R2uKaHjBq/NjYrYIvvY11U/Txyas
         9lrZmCioJzJneTiqcO0xKnV/RDZXcyI9t5KH2v7PJW9PDmz3D9r6YVmC1Ttwvi54Hycp
         mSBbt/+jm+1yAw8MlMES2zgQuo+dlhzu3VdsHhD+h7104a5a6OFyQBPcbnykxOj8WEn6
         wYG5j/un+5cxyWvZP/6gzqotbNbI3SFf5FWO6ElMpfms4zuQjVds5/YQF8ezTZY3ir41
         94SIyjgHOJ49i/rQTWXsVAoAzJGXPct4dylWpttCJ9eV7r571bTfHh4kZyzxW8GcM0Tk
         F0aw==
X-Forwarded-Encrypted: i=1; AL+hErEmzBD94gUTH52fDrKkEYwkZrZsqD8qzVkJjD5ewaeY+HIDxgvpq+KGnAtENmwhk8RdCW8lR2XvpEquGfrQinh7@vger.kernel.org
X-Gm-Message-State: APuU4Z83XCeEs6pimgPlSgovrso0pA4mvm1AmFfIIXgjxPiyfWVwtbTb
	rBmwN/lqVqq1D6iwgtdqJFXZp1aRnLmirubghy9xeWAjboIAi9MK+VLN+2mkv+zxl7FqRQgKYS4
	a+vods7XNMA==
X-Received: from dycnh14.prod.google.com ([2002:a05:7300:ce8e:b0:36a:17c6:6824])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:65ca:b0:386:b826:407
 with SMTP id 5a478bee46e88-386b826061cmr6154460eec.20.1795559476114; Tue, 24
 Nov 2026 14:31:16 -0800 (PST)
Date: Tue, 24 Nov 2026 14:30:59 -0800
In-Reply-To: <20261124223109.820609-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124223109.820609-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124223109.820609-3-irogers@google.com>
Subject: [PATCH v10 02/12] perf symbol: Drop num_by_name and sorted_by_name
 from struct symbols
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Every mutation to symbols->symbols frees symbols->symbols_by_name, and
symbols__sort_by_name_locked() copies all symbols->cnt pointers verbatim
before sorting by name. As a result:
- symbols->num_by_name always equals symbols->cnt whenever
  symbols->symbols_by_name is non-NULL (and 0 otherwise).
- symbols->sorted_by_name is equivalent to
  (symbols->symbols_by_name != NULL || symbols->cnt == 0). Treating
  cnt == 0 as trivially sorted by name also avoids an unnecessary
  read-to-write lock upgrade on empty DSOs in
  symbols__sort_by_name_read_lock() and dso__sort_by_name().

Remove num_by_name and sorted_by_name from struct symbols and clarify
the @symbols_by_name kernel-doc.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c    |  2 +-
 tools/perf/util/symbol.c | 44 ++++++++--------------------------------
 tools/perf/util/symbol.h | 16 +++++----------
 3 files changed, 14 insertions(+), 48 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 287f6812139c..ab0c87d0595e 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1809,7 +1809,7 @@ bool dso__sorted_by_name(const struct dso *dso)
 	bool res;
 
 	down_read(&symbols->lock);
-	res = symbols->sorted_by_name;
+	res = symbols->symbols_by_name != NULL || symbols->cnt == 0;
 	up_read(&symbols->lock);
 	return res;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 920951aaa5be..6dce0f44fb4b 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -221,9 +221,7 @@ void symbols__init(struct symbols *symbols)
 	symbols->symbols_by_name = NULL;
 	symbols->cnt = 0;
 	symbols->allocated = 0;
-	symbols->num_by_name = 0;
 	symbols->sorted = true;
-	symbols->sorted_by_name = false;
 }
 
 static void symbols__delete_locked(struct symbols *symbols)
@@ -236,9 +234,7 @@ static void symbols__delete_locked(struct symbols *symbols)
 	zfree(&symbols->symbols_by_name);
 	symbols->cnt = 0;
 	symbols->allocated = 0;
-	symbols->num_by_name = 0;
 	symbols->sorted = true;
-	symbols->sorted_by_name = false;
 }
 
 void symbols__delete(struct symbols *symbols)
@@ -510,8 +506,6 @@ void symbols__fixup_duplicate(struct symbols *symbols)
 	}
 	symbols->cnt = write_idx + 1;
 	zfree(&symbols->symbols_by_name);
-	symbols->num_by_name = 0;
-	symbols->sorted_by_name = false;
 	up_write(&symbols->lock);
 }
 
@@ -701,8 +695,6 @@ static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
 
 	symbols->symbols[symbols->cnt++] = sym;
 	zfree(&symbols->symbols_by_name);
-	symbols->num_by_name = 0;
-	symbols->sorted_by_name = false;
 	return 0;
 }
 
@@ -805,17 +797,9 @@ static int symbols__sort_by_name_locked(struct symbols *symbols)
 	struct symbol **result;
 	unsigned int size = symbols->cnt;
 
-	if (symbols->sorted_by_name)
+	if (symbols->symbols_by_name || size == 0)
 		return 0;
 
-	zfree(&symbols->symbols_by_name);
-	symbols->num_by_name = 0;
-
-	if (size == 0) {
-		symbols->sorted_by_name = true;
-		return 0;
-	}
-
 	result = malloc(sizeof(*result) * size);
 	if (!result)
 		return -ENOMEM;
@@ -823,8 +807,6 @@ static int symbols__sort_by_name_locked(struct symbols *symbols)
 	memcpy(result, symbols->symbols, sizeof(*result) * size);
 	qsort(result, size, sizeof(*result), symbols__sort_name_cmp);
 	symbols->symbols_by_name = result;
-	symbols->num_by_name = size;
-	symbols->sorted_by_name = true;
 	return 0;
 }
 
@@ -834,7 +816,7 @@ static int symbols__sort_by_name_read_lock(struct symbols *symbols)
 	int err = 0;
 
 	down_read(&symbols->lock);
-	while (!symbols->sorted_by_name) {
+	while (!symbols->symbols_by_name && symbols->cnt > 0) {
 		up_read(&symbols->lock);
 		down_write(&symbols->lock);
 		err = symbols__sort_by_name_locked(symbols);
@@ -843,7 +825,7 @@ static int symbols__sort_by_name_read_lock(struct symbols *symbols)
 		if (err)
 			break;
 	}
-	return symbols->sorted_by_name ? 0 : err;
+	return (symbols->symbols_by_name || symbols->cnt == 0) ? 0 : err;
 }
 
 int symbol__match_symbol_name(const char *name, const char *str,
@@ -928,8 +910,6 @@ void dso__delete_symbol(struct dso *dso, struct symbol *sym)
 				(symbols->cnt - i - 1) * sizeof(struct symbol *));
 			symbols->cnt--;
 			zfree(&symbols->symbols_by_name);
-			symbols->num_by_name = 0;
-			symbols->sorted_by_name = false;
 			symbol__delete(sym);
 			break;
 		}
@@ -957,7 +937,7 @@ struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx)
 
 	symbols = dso__symbols(dso);
 	if (!symbols__sort_by_name_read_lock(symbols) &&
-	    *idx + 1 < symbols->num_by_name) {
+	    *idx + 1 < symbols->cnt) {
 		++*idx;
 		res = symbols->symbols_by_name[*idx];
 	}
@@ -981,10 +961,10 @@ struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_
 	symbols = dso__symbols(dso);
 	if (!symbols__sort_by_name_read_lock(symbols)) {
 		s = symbols__find_by_name(symbols->symbols_by_name,
-					  symbols->num_by_name,
+					  symbols->cnt,
 					  name, SYMBOL_TAG_INCLUDE__NONE, idx);
 		if (!s) {
-			s = symbols__find_by_name(symbols->symbols_by_name, symbols->num_by_name,
+			s = symbols__find_by_name(symbols->symbols_by_name, symbols->cnt,
 						  name, SYMBOL_TAG_INCLUDE__DEFAULT_ONLY, idx);
 		}
 	}
@@ -997,7 +977,7 @@ void dso__sort_by_name(struct dso *dso)
 	struct symbols *symbols = dso__symbols(dso);
 
 	down_read(&symbols->lock);
-	if (!symbols->sorted_by_name) {
+	if (!symbols->symbols_by_name && symbols->cnt > 0) {
 		up_read(&symbols->lock);
 		down_write(&symbols->lock);
 		symbols__sort_by_name_locked(symbols);
@@ -1014,7 +994,7 @@ int symbols__visit_by_name(struct symbols *symbols,
 	int err = symbols__sort_by_name_read_lock(symbols);
 
 	if (!err) {
-		for (size_t i = 0; i < symbols->num_by_name; i++) {
+		for (size_t i = 0; i < symbols->cnt; i++) {
 			err = cb(symbols->symbols_by_name[i], data);
 			if (err)
 				break;
@@ -1276,8 +1256,6 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	root->allocated = 0;
 	root->sorted = true;
 	zfree(&root->symbols_by_name);
-	root->num_by_name = 0;
-	root->sorted_by_name = false;
 	up_write(&root->lock);
 
 	for (unsigned int i = 0; i < old_cnt; i++) {
@@ -1350,8 +1328,6 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	root->allocated = 0;
 	root->sorted = true;
 	zfree(&root->symbols_by_name);
-	root->num_by_name = 0;
-	root->sorted_by_name = false;
 	up_write(&root->lock);
 
 	for (i = 0; i < old_cnt; i++) {
@@ -1505,8 +1481,6 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			__symbols__insert(root, old_symbols[j]);
 	}
 	zfree(&root->symbols_by_name);
-	root->num_by_name = 0;
-	root->sorted_by_name = false;
 	up_write(&root->lock);
 	free(old_symbols);
 
@@ -1535,8 +1509,6 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		root->sorted = false;
 	}
 	zfree(&root->symbols_by_name);
-	root->num_by_name = 0;
-	root->sorted_by_name = false;
 	up_write(&root->lock);
 	free(old_symbols);
 	return -1;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 8b8ab7e1e148..629f6b2fcd0a 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -102,26 +102,20 @@ struct symbols {
 	/** @lock: Read/write semaphore synchronizing access to the arrays. */
 	struct rw_semaphore lock;
 	/**
-	 * @symbols: Dynamically allocated array of symbol pointers, sorted by
-	 * address range [start, end) when @sorted is true.
+	 * @symbols: Dynamically allocated array of @allocated symbol pointers,
+	 * sorted by start address when @sorted is true.
 	 */
 	struct symbol **symbols __guarded_by(&lock);
 	/**
-	 * @symbols_by_name: Optional dynamically allocated array of symbol
-	 * pointers sorted lexicographically by sym->name.
+	 * @symbols_by_name: Optional lazily built array of @cnt symbol pointers
+	 * sorted lexicographically by sym->name; NULL when unbuilt, when @cnt
+	 * is 0, or when invalidated by a symbol-table mutation.
 	 */
 	struct symbol **symbols_by_name __guarded_by(&lock);
 	/** @cnt: Number of valid entries in @symbols. */
 	unsigned int cnt __guarded_by(&lock);
 	/** @allocated: Capacity (in entries) of the @symbols allocation. */
 	unsigned int allocated __guarded_by(&lock);
-	/** @num_by_name: Number of valid entries in @symbols_by_name. */
-	unsigned int num_by_name __guarded_by(&lock);
-	/**
-	 * @sorted_by_name: True when @symbols_by_name is populated and sorted
-	 * by name.
-	 */
-	bool sorted_by_name __guarded_by(&lock);
 	/** @sorted: True when @symbols is sorted by address range. */
 	bool sorted __guarded_by(&lock);
 };
-- 
2.56.1.831.g720f3f5937-goog

