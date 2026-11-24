Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490959;
	b=Zb+Fsew6oyIGUD2BzlBrKQ9V5QK5TsFU96P13F2LiHP0tPgcz6QVzo9104ppvcZxEd0P
	 YNivl+XoCE+EBkPj7sKWE8vde6o5FsJxBpGk9Z3BkvAWeL2l7Q1k6zkRkKorNoFfhg+19
	 P8ZrO7lCUeKK2P1mgo0eguTJ5VdqcK2cZJhETUHNxiP9qobecio6/t8X+18rBLMjhzO7s
	 CC/83yTis1YlqPLCiyon4DEn/EHtOp0WLg6aaMYAKwjqThjJSultLFJRZd7/8IAURmrqi
	 l1qZ/MaWcboYErgq0KFtoG0q6+/Q4Lb9042xxOq14XFEUTcHNzWKIdLf48dA7yPO2zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=fT0zSbnD3mo4aMVQeMcqaVdNSoaD5DKwARAcwlYJEpk=;
	b=fbHtM8zaPnlDKkwRG25i7b31q56hjGYHYHaFsIyu2sVX7GYrhwf3+uZ8qVKTW4ijm+oW
	 MqK4x6PvN99FG5HCUGo1pmE87i6cjMju3lXUt6k0JDVOVg8rR1+7155IWGbyuopaAmhHC
	 Iflr/3ccfjAOF3S+5uGlmF0+rTcgz+aCW0osb8kTMzf/EvINIJ4TQKilL32LV69f0oAdS
	 C7Fgacs/Va8CTQ6XACZ93a20N3LL2m10BzRi2tcHmTEbR+DjomyhUZrUXGGRLO6MEZI0B
	 K92jumNWDHc5tHpf3KWu2UGr9LVkoNKxGk+LLSGxRyXsZph604IlAET5ThAe24iQr7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ALdQ07cK;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B8A606A326
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 03:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6B8A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ALdQ07cK
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139b62317d0so3344389c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 19:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795490958; x=1796095758; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fT0zSbnD3mo4aMVQeMcqaVdNSoaD5DKwARAcwlYJEpk=;
        b=ALdQ07cKpdmyBHJpYRiLET3wQu906BW/wX2YomBauyAvAtDirelIFTcQ8n70WrbJQV
         ErZx5ih41SnFUYXOt9xVwXtIoPdAswHrTFpXyEHK9xtSCACsATGe6q7bZ1AVz19CqjJ8
         /1CUlZaum97img0HdfxOML2j9YZyC975kbS6xG3GErJJiyBAhXskj0Z0l0mWwBGQKtmK
         MeHC/XCN9JydEE4+2eBjV5bWAjU4Hev9TPifqGClYv+pIAt4GQtAeYplXmtaVYhgqh+J
         l320ItlZ25mcXg6fSksXGGvWDcHa+R7OlD5xp20WqhVrOIpYb6sbHBvhabJBL1hlK3w4
         qWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490958; x=1796095758;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fT0zSbnD3mo4aMVQeMcqaVdNSoaD5DKwARAcwlYJEpk=;
        b=IVC4eZ95a19DLD01UON4PzG1qTnlaMUf//gW/7l8pTEE1go8dOQ2m8gp3Fs8JxHF1o
         YeER9Urkas+dYfkP9Ngb0hXnjiKUUzI8BYWr0/vRAMhqyH0+9Vx1P78uVvW+dXE2CVQn
         RbYGYHMiH1NG68Ogrk+x7K05GOy/4Pr7CYDLA8wL0JQ45qER8zyqUbB5hmyClOhDKuSB
         BDTgLZ/LG3iV8Ymj/iiY+HvX9zE6tfnVxPPyCMDDzfd4BJowCLevQ7gpObZCnoXuOdZp
         WU3RSZ6IpXV5y2koJecFGUOMCRFG/Fe5Z66xnVJT8eKgzSI54pn185M3OEdKf48wjjTq
         DV2g==
X-Forwarded-Encrypted: i=1; AL+hErGm2a0q9i0oMgrfcpA+OKs48R6X+ZRJyHbtn5cY+3vJImDboam2SRBv230CGA5LXbR5CXQbFK1/zvLCjhoxRXMp@vger.kernel.org
X-Gm-Message-State: APuU4Z+KOgdtgt5oBxF2PNU54coLKlP75FqOTbci5/TBTs616kSqa2r3
	EZwwsqmEERxhZbj+2C7p8uFrqTJucp/QBJLZXGZyLV0dFzdeLll+RlDAiAOlx/cI302XNdrHR6n
	mxNhZDLnmIA==
X-Received: from dlea16-n2.prod.google.com ([2002:a05:701b:4210:20b0:1b5:43fc:8107])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1701:b0:1a4:c892:b130
 with SMTP id a92af1059eb24-1b55feaa6a4mr10986719c88.15.1795490957426; Mon, 23
 Nov 2026 19:29:17 -0800 (PST)
Date: Mon, 23 Nov 2026 19:28:53 -0800
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
Message-ID: <20261124032902.3859564-3-irogers@google.com>
Subject: [PATCH v9 02/11] perf symbol: Replace sorted boolean with sorted_cnt
 prefix length
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When symbols are appended after an initial sort, re-running full-array
merge sort across the entire symbol table rescans the already-sorted
prefix and allocates a scratch buffer even when only a few symbols were
appended.

Replace the @sorted boolean in struct symbols with @sorted_cnt, the
length of the leading start-address-sorted prefix (so @sorted_cnt ==
@cnt indicates the entire array is sorted):
- Pass first_unsorted to symbols__insertion_sort_range() so
  already-sorted prefixes are not rescanned.
- In symbols__sort_locked(), binary-insert in place without allocating
  when <= 8 symbols have been appended (or cnt <= 64), and otherwise
  sort only the newly appended tail [sorted_cnt .. cnt) before merging
  with [0 .. sorted_cnt).

Using 'perf bench internals symbols':

  Before:
    Average append + lookup: 1551.533 usec (+- 3.379 usec)
  After (-90.3%):
    Average append + lookup: 150.333 usec (+- 0.273 usec)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.c | 75 +++++++++++++++++++++++++++++-----------
 tools/perf/util/symbol.h | 21 +++++++----
 2 files changed, 68 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 03c4314935a5..b9ddebdcd900 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -220,8 +220,8 @@ void symbols__init(struct symbols *symbols)
 	symbols->symbols = NULL;
 	symbols->symbols_by_name = NULL;
 	symbols->cnt = 0;
+	symbols->sorted_cnt = 0;
 	symbols->allocated = 0;
-	symbols->sorted = true;
 }
 
 static void symbols__delete_locked(struct symbols *symbols)
@@ -233,8 +233,8 @@ static void symbols__delete_locked(struct symbols *symbols)
 	zfree(&symbols->symbols);
 	zfree(&symbols->symbols_by_name);
 	symbols->cnt = 0;
+	symbols->sorted_cnt = 0;
 	symbols->allocated = 0;
-	symbols->sorted = true;
 }
 
 void symbols__delete(struct symbols *symbols)
@@ -279,9 +279,10 @@ static unsigned int symbols__upper_bound(struct symbol **arr, unsigned int len,
 
 static void symbols__insertion_sort_range(struct symbol **arr,
 					  unsigned int start,
+					  unsigned int first_unsorted,
 					  unsigned int end)
 {
-	for (unsigned int i = start + 1; i < end; i++) {
+	for (unsigned int i = max(first_unsorted, start + 1); i < end; i++) {
 		struct symbol *sym = arr[i];
 
 		if (!symbol__less_or_equal(arr[i - 1], sym)) {
@@ -355,7 +356,7 @@ static void symbols__sort_range_with_tmp(struct symbol **arr, unsigned int n,
 	unsigned int i = 0;
 
 	if (n <= 32) {
-		symbols__insertion_sort_range(arr, 0, n);
+		symbols__insertion_sort_range(arr, 0, 1, n);
 		return;
 	}
 
@@ -379,8 +380,10 @@ static void symbols__sort_range_with_tmp(struct symbol **arr, unsigned int n,
 		}
 
 		if (i - start < 32 && i < n) {
+			unsigned int run_end = i;
+
 			i = min(start + 32U, n);
-			symbols__insertion_sort_range(arr, start, i);
+			symbols__insertion_sort_range(arr, start, run_end, i);
 		}
 
 		runs[nr_runs++] = (struct symbol_run){
@@ -431,22 +434,48 @@ static void symbols__sort_range_with_tmp(struct symbol **arr, unsigned int n,
 static void symbols__sort_locked(struct symbols *symbols)
 	__must_hold(&symbols->lock)
 {
-	if (symbols->sorted)
+	unsigned int m = symbols->sorted_cnt;
+	unsigned int k;
+
+	if (m >= symbols->cnt) {
+		symbols->sorted_cnt = symbols->cnt;
 		return;
+	}
+	k = symbols->cnt - m;
 
-	if (symbols->cnt <= 64) {
-		symbols__insertion_sort_range(symbols->symbols, 0, symbols->cnt);
-	} else {
+	/*
+	 * When only a few symbols have been appended since the last sort
+	 * (including single-symbol insertions), insert them directly at
+	 * their binary-searched sorted positions in O(N) without allocating.
+	 */
+	if (k <= 8 || symbols->cnt <= 64) {
+		symbols__insertion_sort_range(symbols->symbols, 0, m, symbols->cnt);
+		symbols->sorted_cnt = symbols->cnt;
+		return;
+	}
+
+	if (m <= 1) {
 		struct symbol **tmp = malloc(((symbols->cnt + 1) / 2) * sizeof(struct symbol *));
 
 		if (tmp) {
 			symbols__sort_range_with_tmp(symbols->symbols, symbols->cnt, tmp);
 			free(tmp);
 		} else {
-			symbols__insertion_sort_range(symbols->symbols, 0, symbols->cnt);
+			symbols__insertion_sort_range(symbols->symbols, 0, m, symbols->cnt);
+		}
+	} else {
+		struct symbol **tmp = malloc(k * sizeof(struct symbol *));
+
+		if (tmp) {
+			symbols__sort_range_with_tmp(&symbols->symbols[m], k, tmp);
+			symbols__merge_runs(symbols->symbols, 0, m, symbols->cnt, tmp);
+			free(tmp);
+		} else {
+			symbols__insertion_sort_range(symbols->symbols, 0, m, symbols->cnt);
 		}
 	}
-	symbols->sorted = true;
+
+	symbols->sorted_cnt = symbols->cnt;
 }
 
 /*
@@ -456,7 +485,7 @@ static void symbols__sort_locked(struct symbols *symbols)
 void symbols__sort_read_lock(struct symbols *symbols)
 {
 	down_read(&symbols->lock);
-	while (!symbols->sorted) {
+	while (symbols->sorted_cnt < symbols->cnt) {
 		up_read(&symbols->lock);
 		down_write(&symbols->lock);
 		symbols__sort_locked(symbols);
@@ -505,6 +534,7 @@ void symbols__fixup_duplicate(struct symbols *symbols)
 		}
 	}
 	symbols->cnt = write_idx + 1;
+	symbols->sorted_cnt = symbols->cnt;
 	zfree(&symbols->symbols_by_name);
 	up_write(&symbols->lock);
 }
@@ -679,9 +709,10 @@ static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
 		symbols->allocated = to_allocate;
 	}
 
-	if (symbols->sorted && symbols->cnt > 0 &&
-	    !symbol__less_or_equal(symbols->symbols[symbols->cnt - 1], sym))
-		symbols->sorted = false;
+	if (symbols->sorted_cnt == symbols->cnt &&
+	    (symbols->cnt == 0 ||
+	     symbol__less_or_equal(symbols->symbols[symbols->cnt - 1], sym)))
+		symbols->sorted_cnt = symbols->cnt + 1;
 
 	symbols->symbols[symbols->cnt++] = sym;
 	zfree(&symbols->symbols_by_name);
@@ -894,11 +925,13 @@ void dso__delete_symbol(struct dso *dso, struct symbol *sym)
 	struct symbols *symbols = dso__symbols(dso);
 
 	down_write(&symbols->lock);
-	for (unsigned int i = 0; i < symbols->cnt; i++) {
+	for (unsigned int i = symbols->cnt; i-- > 0; ) {
 		if (symbols->symbols[i] == sym) {
 			memmove(&symbols->symbols[i], &symbols->symbols[i + 1],
 				(symbols->cnt - i - 1) * sizeof(struct symbol *));
 			symbols->cnt--;
+			if (i < symbols->sorted_cnt)
+				symbols->sorted_cnt--;
 			zfree(&symbols->symbols_by_name);
 			symbol__delete(sym);
 			break;
@@ -1243,8 +1276,8 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	old_cnt = root->cnt;
 	root->symbols = NULL;
 	root->cnt = 0;
+	root->sorted_cnt = 0;
 	root->allocated = 0;
-	root->sorted = true;
 	zfree(&root->symbols_by_name);
 	up_write(&root->lock);
 
@@ -1315,8 +1348,8 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	old_allocated = root->allocated;
 	root->symbols = NULL;
 	root->cnt = 0;
+	root->sorted_cnt = 0;
 	root->allocated = 0;
-	root->sorted = true;
 	zfree(&root->symbols_by_name);
 	up_write(&root->lock);
 
@@ -1463,8 +1496,8 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	if (root->cnt == 0) {
 		root->symbols = old_symbols;
 		root->cnt = write_idx;
+		root->sorted_cnt = write_idx;
 		root->allocated = old_allocated;
-		root->sorted = true;
 		old_symbols = NULL;
 	} else {
 		for (unsigned int j = 0; j < write_idx; j++)
@@ -1490,13 +1523,13 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	if (root->cnt == 0) {
 		root->symbols = old_symbols;
 		root->cnt = write_idx;
+		root->sorted_cnt = (delta == 0) ? write_idx : min(write_idx, 1U);
 		root->allocated = old_allocated;
-		root->sorted = (delta == 0);
 		old_symbols = NULL;
 	} else {
 		for (unsigned int j = 0; j < write_idx; j++)
 			__symbols__insert(root, old_symbols[j]);
-		root->sorted = false;
+		root->sorted_cnt = min(root->cnt, 1U);
 	}
 	zfree(&root->symbols_by_name);
 	up_write(&root->lock);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 629f6b2fcd0a..2b20bfb22fd1 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -97,14 +97,18 @@ struct symbol {
 
 /**
  * struct symbols - A locked collection of symbols stored in a sorted array.
+ *
+ * The @symbols array of @cnt pointers (within an allocation of @allocated
+ * slots) keeps a start-address-sorted prefix @symbols[0 .. @sorted_cnt)
+ * followed by an optional unsorted tail @symbols[@sorted_cnt .. @cnt) from
+ * bulk symbols__insert() appends. When @sorted_cnt == @cnt, the entire array
+ * is sorted; otherwise the unsorted tail is lazily sorted and merged into the
+ * prefix on lookup or iteration.
  */
 struct symbols {
 	/** @lock: Read/write semaphore synchronizing access to the arrays. */
 	struct rw_semaphore lock;
-	/**
-	 * @symbols: Dynamically allocated array of @allocated symbol pointers,
-	 * sorted by start address when @sorted is true.
-	 */
+	/** @symbols: Dynamically allocated array of @allocated symbol pointers. */
 	struct symbol **symbols __guarded_by(&lock);
 	/**
 	 * @symbols_by_name: Optional lazily built array of @cnt symbol pointers
@@ -112,12 +116,15 @@ struct symbols {
 	 * is 0, or when invalidated by a symbol-table mutation.
 	 */
 	struct symbol **symbols_by_name __guarded_by(&lock);
-	/** @cnt: Number of valid entries in @symbols. */
+	/** @cnt: Total number of valid symbol pointers in @symbols. */
 	unsigned int cnt __guarded_by(&lock);
+	/**
+	 * @sorted_cnt: Length of the leading start-address-sorted prefix in
+	 * @symbols. The entire @symbols array is sorted iff @sorted_cnt == @cnt.
+	 */
+	unsigned int sorted_cnt __guarded_by(&lock);
 	/** @allocated: Capacity (in entries) of the @symbols allocation. */
 	unsigned int allocated __guarded_by(&lock);
-	/** @sorted: True when @symbols is sorted by address range. */
-	bool sorted __guarded_by(&lock);
 };
 
 void symbol__delete(struct symbol *sym);
-- 
2.56.1.809.ga0b61035b5-goog

