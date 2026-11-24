Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490953;
	b=at3rnwXcoL1jQx6LG+NVnK/6hekJBW6GY55waZh3DDGM8jtv2fqpHVwscQDbFI8w25Cf
	 G34GkjWDvISRuDDhH9QaKib+bFBS3OEgmxa/K9kOFqkRyxHQMGc47D6TBHkbPxgam+rwC
	 21lwwV6BC5KKFXHc8sTivUHNpAfCVjbL2tokOpTw/1a67dbmvbDen2vSkxSC7N7T+D5Df
	 BN73kvIV37poOqqBl0nhX6WjdI0hiAsQVAAh3sOWD+jb0KTCmZD9UFu6YeqkokC/tm8Gh
	 HUri8BdkMOGje+2PJsD4KsG/Xrs5hsBjfK7AMAtpGB02VzAFL14tqvHa9zCqbI0n+Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=U9cYIgW40qLTz/HmhCp052WSiMk+4bttOQHPeIyLy1s=;
	b=Qs9SlsgSJqdgS9LqH6rWt2AaoCHMetTQq/NMuDH83eGVG49vGCTnUvzSLgZetO+vqP9K
	 0zPDy8yJud4+Odd6f1aOkBFCCGj0DN+1GGKCKIwAbLrMKsSh3vllOH+k+ORzgnhEk87sN
	 26doG6+KhBlDWPeE2IrQJaSpeuAS6eMWqLSgWkYVSlwQ3pjCqhXAk2eC2X1yKUzMHcynN
	 L10/QMxDl9Chvkk6DCh3BiA6UlEdBk8umTMYL020n2EMLNnaUl465zH4fgZzseu/O8TXp
	 rJh7HXV2azG7Hyig2ppa/31F1vHRaD+o843WFPH6kkMEBeAK+xF/gYYl1IihnHLd3SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e4fXjzrL;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCACA606A322
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 03:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCACA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e4fXjzrL
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-386a65fca25so2714729eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 19:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795490951; x=1796095751; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U9cYIgW40qLTz/HmhCp052WSiMk+4bttOQHPeIyLy1s=;
        b=e4fXjzrL0y2Cwq64upGE3M5CNd99+OqcGOCpr9DYg37bR1t69DCVJplbt9tde8d6oV
         PomdbB/MP88x165lnzThHiHV8sfnbyVY/wfjfR7e338R6MNzmMfAgjaeSCcOdYtiUZsN
         aV5aq0G15BylCM0aiscHWD1gIq2sA+77oQhGKMt97D1sV3FT9mG8f9Cfs083IPxrsCcG
         sX/gfkyTGzuTMkciZcLWvzww2csnqxcbz8IcRiFt5RbqovzStisrE9Ah8d5xMEy/OGnH
         22xC2x18us3A/KjXAs1EUBqlIy/JzsC4UxHwe3t3X7r69JbogOa0enW+7JGIYSfVkBIq
         RUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490951; x=1796095751;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U9cYIgW40qLTz/HmhCp052WSiMk+4bttOQHPeIyLy1s=;
        b=ElzQ+GVDeeUCUUdMpMfv0vDwD/otWlQaNsqKdxkq60gnpPI9d3gvsVXMsHQqJPgPHu
         4xVXDc7xL3wAGdss4TQJq5pheX1F4z9xt7UbKDC3Tk2i35iYimwLF5KTIyIdJeqTKTr7
         yLjMlN6QspQ17Kbm2hCCi5NmltodjiyyE1GyPiikbr0BWYXzjOaf/MG9EsVpdZ1ssu3f
         2eT73ATnrY3Vc0VZlAKr4Hua4KNg9uLlUwhcIFeBxsfhhD/YAUn+CpQaTFqoB0BU8w/S
         LiDW+f2ndiSqW9z4IwqrZHItQ+Fgq7/7zAG+CcPeMrLTMYXEJpjtwxXMdegUp4MYMnkL
         QFKQ==
X-Forwarded-Encrypted: i=1; AL+hErH+eA5GXt7oaO7/eEDpqtstcOPXJIY3F/Jxo1+de4ITZbXXyg0LIoBls+vQQQvlk3xFws+yadJsRnWgwibnoXtd@vger.kernel.org
X-Gm-Message-State: APuU4Z/NYhaI/YjNWYBYAOzohW30h+hLbXwFCmQKMMQfnpLqgc71QQsK
	yJ35cPzjVRXCuyBu18iFpSD8EIfOtoHA+el2rYs46TKikr/FJ+IJttz6UN8pbHvl2Ye7YPCqEmM
	GnUhBjGeefg==
X-Received: from dyba9.prod.google.com ([2002:a05:693c:63c9:b0:386:a06c:3241])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:87d6:20b0:386:bc19:6a30
 with SMTP id 5a478bee46e88-386bc196d10mr2276891eec.20.1795490951181; Mon, 23
 Nov 2026 19:29:11 -0800 (PST)
Date: Mon, 23 Nov 2026 19:28:52 -0800
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
Message-ID: <20261124032902.3859564-2-irogers@google.com>
Subject: [PATCH v9 01/11] perf symbol: Drop num_by_name and sorted_by_name
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
index 35b08c05a2fd..03c4314935a5 100644
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
 
@@ -691,8 +685,6 @@ static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
 
 	symbols->symbols[symbols->cnt++] = sym;
 	zfree(&symbols->symbols_by_name);
-	symbols->num_by_name = 0;
-	symbols->sorted_by_name = false;
 	return 0;
 }
 
@@ -795,17 +787,9 @@ static int symbols__sort_by_name_locked(struct symbols *symbols)
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
@@ -813,8 +797,6 @@ static int symbols__sort_by_name_locked(struct symbols *symbols)
 	memcpy(result, symbols->symbols, sizeof(*result) * size);
 	qsort(result, size, sizeof(*result), symbols__sort_name_cmp);
 	symbols->symbols_by_name = result;
-	symbols->num_by_name = size;
-	symbols->sorted_by_name = true;
 	return 0;
 }
 
@@ -824,7 +806,7 @@ static int symbols__sort_by_name_read_lock(struct symbols *symbols)
 	int err = 0;
 
 	down_read(&symbols->lock);
-	while (!symbols->sorted_by_name) {
+	while (!symbols->symbols_by_name && symbols->cnt > 0) {
 		up_read(&symbols->lock);
 		down_write(&symbols->lock);
 		err = symbols__sort_by_name_locked(symbols);
@@ -833,7 +815,7 @@ static int symbols__sort_by_name_read_lock(struct symbols *symbols)
 		if (err)
 			break;
 	}
-	return symbols->sorted_by_name ? 0 : err;
+	return (symbols->symbols_by_name || symbols->cnt == 0) ? 0 : err;
 }
 
 int symbol__match_symbol_name(const char *name, const char *str,
@@ -918,8 +900,6 @@ void dso__delete_symbol(struct dso *dso, struct symbol *sym)
 				(symbols->cnt - i - 1) * sizeof(struct symbol *));
 			symbols->cnt--;
 			zfree(&symbols->symbols_by_name);
-			symbols->num_by_name = 0;
-			symbols->sorted_by_name = false;
 			symbol__delete(sym);
 			break;
 		}
@@ -947,7 +927,7 @@ struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx)
 
 	symbols = dso__symbols(dso);
 	if (!symbols__sort_by_name_read_lock(symbols) &&
-	    *idx + 1 < symbols->num_by_name) {
+	    *idx + 1 < symbols->cnt) {
 		++*idx;
 		res = symbols->symbols_by_name[*idx];
 	}
@@ -971,10 +951,10 @@ struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_
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
@@ -987,7 +967,7 @@ void dso__sort_by_name(struct dso *dso)
 	struct symbols *symbols = dso__symbols(dso);
 
 	down_read(&symbols->lock);
-	if (!symbols->sorted_by_name) {
+	if (!symbols->symbols_by_name && symbols->cnt > 0) {
 		up_read(&symbols->lock);
 		down_write(&symbols->lock);
 		symbols__sort_by_name_locked(symbols);
@@ -1004,7 +984,7 @@ int symbols__visit_by_name(struct symbols *symbols,
 	int err = symbols__sort_by_name_read_lock(symbols);
 
 	if (!err) {
-		for (size_t i = 0; i < symbols->num_by_name; i++) {
+		for (size_t i = 0; i < symbols->cnt; i++) {
 			err = cb(symbols->symbols_by_name[i], data);
 			if (err)
 				break;
@@ -1266,8 +1246,6 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	root->allocated = 0;
 	root->sorted = true;
 	zfree(&root->symbols_by_name);
-	root->num_by_name = 0;
-	root->sorted_by_name = false;
 	up_write(&root->lock);
 
 	for (unsigned int i = 0; i < old_cnt; i++) {
@@ -1340,8 +1318,6 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	root->allocated = 0;
 	root->sorted = true;
 	zfree(&root->symbols_by_name);
-	root->num_by_name = 0;
-	root->sorted_by_name = false;
 	up_write(&root->lock);
 
 	for (i = 0; i < old_cnt; i++) {
@@ -1495,8 +1471,6 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			__symbols__insert(root, old_symbols[j]);
 	}
 	zfree(&root->symbols_by_name);
-	root->num_by_name = 0;
-	root->sorted_by_name = false;
 	up_write(&root->lock);
 	free(old_symbols);
 
@@ -1525,8 +1499,6 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
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

base-commit: 964e8b1c9c795982886a6778cb0cd73c901ca4ca
-- 
2.56.1.809.ga0b61035b5-goog

