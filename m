Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795323886;
	b=anLO4LPionDMwTtph6cDEj8ejm8D2oapM1yBtEaZwwocRok3GZrbtMhCcHa2jnjD6rDe
	 W8yIjV2aBY88XskRyCOhCgrs3yphdPjyJH3mxrbrbppLEgPr8CzpJqLzS0afpEY0GCXU5
	 VaCeJhpxOD+1d/74f9TrOGfUpkhEXT8V8fblcBaEZuENyUwUX6Vrs6Gg7Tha2U2S23/m/
	 y5MttmMiiVzT2ff8Ejvr+Jn0W+ptS1Xt4ZTTjm1iWs7HlMnNgaZGjzwkxH6IJ7WW+v8M/
	 q+4ZtgDdCvYex1Zx3LZITkj0WaGVbfJQL7drDS9EKsmdZTpxPOKx9WuXpwE5BJCFZZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795323886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=CWnAV6tVqdMDcZJwj0hP4WWO5uyvqyeRK1R20QMTbqA=;
	b=Et6/Ta6hFj3Ahg6LYnggvR02VwCl61lHe0C5te0jZybrqe18Ct+R09AKaa+uhD8Xz5Yh
	 4d84v6VsRm9o1gpR1PWUjKi5ly+Qbmo2ONXSiRmnzvor1GIvVtoLRDUpmJy14zmvuYR/d
	 Ls1AOlMGTjpHKRXl5kcjsPFme0G+tjGGSUD0bh0e5XXMLtOoCwOdRAqCkXUf3LpEdz6yX
	 wyx5VHPVYS/IydsStSgbAZIXJJ4Lph2lhUugMI/q2s0YE36cJQBCiN/sbtmUySWYRozoI
	 8r/1BshLWzAceUUtlSKxNKxaIKDt5StP7YlLw09A20DJoKrQrAZ6tItSN5/gUMtB+Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="b4/EfRDN";
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8EA606A330
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 05:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E8EA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b4/EfRDN
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-154e9d2d94fso1456944c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 21:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795323885; x=1795928685; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CWnAV6tVqdMDcZJwj0hP4WWO5uyvqyeRK1R20QMTbqA=;
        b=b4/EfRDNn7VK2NV3rUwB7T8alIllnYy/mvx1HI9xHyYApYCCjK0O2KdOaJQmChGmcg
         SjuPfmxZWuXsY/7MK98QV6kMKl+moPXj2I3mUdc9G6yNJE3AzDW0jX7vDelZUYe1mznf
         eqoWO1EbFOeEgsH4FqCQaSVbwfHpDRSI32QmVpm7SWfOnPw55P8vi39VA80kVOXzm0dm
         JoWcimPQJb8wmDdUhKKHoD3jzZgNqrTkTLYRyE/KwulchJCrHLG0y4tm9/puetVuIiCx
         +3X26AYNYmVMq8knckOURtgAMI6CdqUnjZ7UQZwXTEI4+Dy0U+sFu8mqka9rGhp5JZGA
         V67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795323885; x=1795928685;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CWnAV6tVqdMDcZJwj0hP4WWO5uyvqyeRK1R20QMTbqA=;
        b=QgP31my2LOK8FyNPizLyizkPotk+8XwoViqTxU9K/SeoHaROEQeu0+8s5P3l608HCM
         1l8hwXr068LYlgmRRiaWUTCqhC3nSt2MgoPdq6aMoaSBWlXB5cFpC5QZS2gcp4tKe9z6
         0idR+3ixIvlmtkXsMFokWWMjdy6sAiYcF2GhQSRTJDXIsTTiZII3t7yWMlMUip7EyxaA
         atkksR9+b6k0H/6txxM1mlmBuBm4B3NfIdPA1AJZGl8RrDv3QDDQn6GN1c5UhBMa1R11
         fux3CO0Tf1zZMOjDPuvrbpFExes+iECkE240QerQp7IhhViNWWY7u/y1Yfq3HjwbTmIc
         hp4A==
X-Forwarded-Encrypted: i=1; AL+hErFNURVMV48mR9GBI5VVlqzWpoKRxtgKHkNNX1J5Snd3mrkRVCRVLxE0BrYCDzOugfytj0O/XhV4rKJQlpiIRbqo@vger.kernel.org
X-Gm-Message-State: APuU4Z8VlS+vwZ8wtN4uWvOv5IGdT2kIhkS7SaCjGU2mNVU3RHgUxpYq
	Nt0dm32/c9ZQVJuwMXUhSTymNeMxmUgtM7aT9s7vqQPCDYU++jVzVMPkFobxHNT2STsRa02xB6K
	MtPzeuykD5w==
X-Received: from dlbuu1.prod.google.com ([2002:a05:7022:7e81:b0:1b3:ba1e:2c7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4308:b0:1b5:1a6e:1bec
 with SMTP id a92af1059eb24-1b5568779e3mr7790764c88.10.1795323884202; Sat, 21
 Nov 2026 21:04:44 -0800 (PST)
Date: Sat, 21 Nov 2026 21:04:02 -0800
In-Reply-To: <20261122050405.80335-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261122050405.80335-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261122050405.80335-8-irogers@google.com>
Subject: [PATCH v8 07/10] perf symbol: Optimize incremental symbol insertion
 with sorted tail
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dynamic symbol resolution (dso__insert_symbol()) frequently inserts one
or a few symbols into an already-sorted DSO symbol table, and small
batches of symbols may also be appended after an initial sort.
Re-running full-array merge sort on every incremental insertion or
memmoving the entire sorted array on every out-of-order dynamic
insertion spends avoidable CPU time.

Speed up incremental symbol insertions and small-append sorting:

- Track the sorted prefix length (@sorted_cnt) in struct symbols and use
  an O(N) in-place binary insertion fast path in symbols__sort_locked()
  when <= 8 symbols have been appended.
- Add __symbols__insert_sorted() for dso__insert_symbol() so that when
  symbols->sorted is true, ascending symbols append in O(1), small
  tables (cnt < 64) binary-insert in place, and larger out-of-order
  insertions maintain a sorted tail buffer at symbols[sorted_cnt .. cnt)
  with an amortized sqrt(N) merge threshold.
- Search both the sorted prefix and any unmerged sorted tail in
  symbols__find() while preserving the single-array highest start <= ip
  semantics.

Using 'perf bench internals symbols':

  Before:
    Average append + lookup: 40429.750 usec (+- 507.578 usec)
  After (-99.6%):
    Average append + lookup: 152.900 usec (+- 0.736 usec)

Signed-off-by: Ian Rogers <irogers@google.com>

# Conflicts:
#	tools/perf/util/symbol.h
---
 tools/perf/util/symbol.c | 206 +++++++++++++++++++++++++++++++++++----
 tools/perf/util/symbol.h |  11 ++-
 2 files changed, 198 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 35b08c05a2fd..22b84e9a40fd 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -220,6 +220,7 @@ void symbols__init(struct symbols *symbols)
 	symbols->symbols = NULL;
 	symbols->symbols_by_name = NULL;
 	symbols->cnt = 0;
+	symbols->sorted_cnt = 0;
 	symbols->allocated = 0;
 	symbols->num_by_name = 0;
 	symbols->sorted = true;
@@ -235,6 +236,7 @@ static void symbols__delete_locked(struct symbols *symbols)
 	zfree(&symbols->symbols);
 	zfree(&symbols->symbols_by_name);
 	symbols->cnt = 0;
+	symbols->sorted_cnt = 0;
 	symbols->allocated = 0;
 	symbols->num_by_name = 0;
 	symbols->sorted = true;
@@ -283,9 +285,10 @@ static unsigned int symbols__upper_bound(struct symbol **arr, unsigned int len,
 
 static void symbols__insertion_sort_range(struct symbol **arr,
 					  unsigned int start,
+					  unsigned int first_unsorted,
 					  unsigned int end)
 {
-	for (unsigned int i = start + 1; i < end; i++) {
+	for (unsigned int i = max(first_unsorted, start + 1); i < end; i++) {
 		struct symbol *sym = arr[i];
 
 		if (!symbol__less_or_equal(arr[i - 1], sym)) {
@@ -359,7 +362,7 @@ static void symbols__sort_range_with_tmp(struct symbol **arr, unsigned int n,
 	unsigned int i = 0;
 
 	if (n <= 32) {
-		symbols__insertion_sort_range(arr, 0, n);
+		symbols__insertion_sort_range(arr, 0, 1, n);
 		return;
 	}
 
@@ -383,8 +386,10 @@ static void symbols__sort_range_with_tmp(struct symbol **arr, unsigned int n,
 		}
 
 		if (i - start < 32 && i < n) {
+			unsigned int run_end = i;
+
 			i = min(start + 32U, n);
-			symbols__insertion_sort_range(arr, start, i);
+			symbols__insertion_sort_range(arr, start, run_end, i);
 		}
 
 		runs[nr_runs++] = (struct symbol_run){
@@ -435,32 +440,79 @@ static void symbols__sort_range_with_tmp(struct symbol **arr, unsigned int n,
 static void symbols__sort_locked(struct symbols *symbols)
 	__must_hold(&symbols->lock)
 {
-	if (symbols->sorted)
+	unsigned int m = symbols->sorted_cnt;
+	unsigned int k;
+
+	if (symbols->sorted && symbols->sorted_cnt == symbols->cnt)
 		return;
 
-	if (symbols->cnt <= 64) {
-		symbols__insertion_sort_range(symbols->symbols, 0, symbols->cnt);
-	} else {
+	if (m > symbols->cnt)
+		m = 0;
+	k = symbols->cnt - m;
+
+	if (k == 0) {
+		symbols->sorted = true;
+		return;
+	}
+
+	/*
+	 * When only a few symbols have been appended since the last sort
+	 * (including single-symbol insertions), insert them directly at
+	 * their binary-searched sorted positions in O(N) without allocating.
+	 */
+	if (k <= 8 || symbols->cnt <= 64) {
+		symbols__insertion_sort_range(symbols->symbols, 0, m, symbols->cnt);
+		symbols->sorted_cnt = symbols->cnt;
+		symbols->sorted = true;
+		return;
+	}
+
+	if (symbols->sorted) {
+		/*
+		 * Both [0 .. m) and the sorted tail [m .. cnt) are already
+		 * sorted; merge them into a single sorted run.
+		 */
+		struct symbol **tmp = malloc(min(m, k) * sizeof(struct symbol *));
+
+		if (tmp) {
+			symbols__merge_runs(symbols->symbols, 0, m, symbols->cnt, tmp);
+			free(tmp);
+		} else {
+			symbols__insertion_sort_range(symbols->symbols, 0, m, symbols->cnt);
+		}
+	} else if (m <= 1) {
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
+
+	symbols->sorted_cnt = symbols->cnt;
 	symbols->sorted = true;
 }
 
 /*
  * Acquire @symbols->lock for reading after ensuring @symbols->symbols is
- * sorted.
+ * fully sorted into a single contiguous run.
  */
 void symbols__sort_read_lock(struct symbols *symbols)
 {
 	down_read(&symbols->lock);
-	while (!symbols->sorted) {
+	while (!symbols->sorted || symbols->sorted_cnt < symbols->cnt) {
 		up_read(&symbols->lock);
 		down_write(&symbols->lock);
 		symbols__sort_locked(symbols);
@@ -509,6 +561,7 @@ void symbols__fixup_duplicate(struct symbols *symbols)
 		}
 	}
 	symbols->cnt = write_idx + 1;
+	symbols->sorted_cnt = symbols->cnt;
 	zfree(&symbols->symbols_by_name);
 	symbols->num_by_name = 0;
 	symbols->sorted_by_name = false;
@@ -685,9 +738,15 @@ static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
 		symbols->allocated = to_allocate;
 	}
 
-	if (symbols->sorted && symbols->cnt > 0 &&
-	    !symbol__less_or_equal(symbols->symbols[symbols->cnt - 1], sym))
+	if (symbols->sorted && symbols->sorted_cnt == symbols->cnt) {
+		if (symbols->cnt == 0 ||
+		    symbol__less_or_equal(symbols->symbols[symbols->cnt - 1], sym))
+			symbols->sorted_cnt = symbols->cnt + 1;
+		else
+			symbols->sorted = false;
+	} else {
 		symbols->sorted = false;
+	}
 
 	symbols->symbols[symbols->cnt++] = sym;
 	zfree(&symbols->symbols_by_name);
@@ -696,6 +755,70 @@ static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
 	return 0;
 }
 
+static int __symbols__insert_sorted(struct symbols *symbols, struct symbol *sym)
+	__must_hold(&symbols->lock)
+{
+	unsigned int idx;
+
+	if (!symbols->sorted)
+		return __symbols__insert(symbols, sym);
+
+	if (symbols->cnt == symbols->allocated) {
+		unsigned int to_allocate = symbols->allocated ? symbols->allocated * 2 : 32;
+		struct symbol **temp = realloc(symbols->symbols,
+					       sizeof(struct symbol *) * to_allocate);
+
+		if (!temp) {
+			symbol__delete(sym);
+			return -ENOMEM;
+		}
+		symbols->symbols = temp;
+		symbols->allocated = to_allocate;
+	}
+
+	if (symbols->sorted_cnt == symbols->cnt) {
+		if (symbols->cnt == 0 ||
+		    symbol__less_or_equal(symbols->symbols[symbols->cnt - 1], sym)) {
+			symbols->symbols[symbols->cnt++] = sym;
+			symbols->sorted_cnt = symbols->cnt;
+		} else if (symbols->cnt < 64) {
+			idx = symbols__upper_bound(symbols->symbols, symbols->cnt, sym);
+			memmove(&symbols->symbols[idx + 1], &symbols->symbols[idx],
+				(symbols->cnt - idx) * sizeof(struct symbol *));
+			symbols->symbols[idx] = sym;
+			symbols->cnt++;
+			symbols->sorted_cnt = symbols->cnt;
+		} else {
+			/*
+			 * Start a sorted tail buffer at symbols[sorted_cnt .. cnt)
+			 * so out-of-order insertions do not memmove the entire
+			 * primary sorted prefix on every call.
+			 */
+			symbols->symbols[symbols->cnt++] = sym;
+		}
+	} else {
+		unsigned int tail_cnt = symbols->cnt - symbols->sorted_cnt;
+
+		idx = symbols->sorted_cnt +
+		      symbols__upper_bound(&symbols->symbols[symbols->sorted_cnt],
+					   tail_cnt, sym);
+		memmove(&symbols->symbols[idx + 1], &symbols->symbols[idx],
+			(symbols->cnt - idx) * sizeof(struct symbol *));
+		symbols->symbols[idx] = sym;
+		symbols->cnt++;
+		tail_cnt++;
+
+		if (tail_cnt >= 256 &&
+		    (size_t)tail_cnt * tail_cnt >= symbols->sorted_cnt)
+			symbols__sort_locked(symbols);
+	}
+
+	zfree(&symbols->symbols_by_name);
+	symbols->num_by_name = 0;
+	symbols->sorted_by_name = false;
+	return 0;
+}
+
 int symbols__insert(struct symbols *symbols, struct symbol *sym)
 {
 	int ret;
@@ -714,7 +837,9 @@ static inline bool symbol__covers(const struct symbol *s, u64 ip)
 	return ip >= start && (ip < end || (ip == end && ip == start));
 }
 
-static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt, u64 ip)
+static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
+					  u64 ip, bool *has_candidate,
+					  u64 *candidate_start)
 {
 	unsigned int low = 0, high = cnt, idx;
 	u64 start;
@@ -727,8 +852,10 @@ static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
 		else
 			high = mid;
 	}
-	if (low == 0)
+	if (low == 0) {
+		*has_candidate = false;
 		return NULL;
+	}
 
 	/*
 	 * Rewind across any equal-start group so a trailing zero-length or
@@ -737,6 +864,8 @@ static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
 	 */
 	idx = low - 1;
 	start = arr[idx]->start;
+	*has_candidate = true;
+	*candidate_start = start;
 	while (idx > 0 && arr[idx - 1]->start == start)
 		idx--;
 	for (; idx < low; idx++) {
@@ -753,12 +882,38 @@ static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
 static struct symbol *symbols__find(struct symbols *symbols, u64 ip)
 {
 	struct symbol *res;
+	bool has_prefix;
+	u64 prefix_start = 0;
 
 	if (symbols == NULL)
 		return NULL;
 
-	symbols__sort_read_lock(symbols);
-	res = symbols__find_range(symbols->symbols, symbols->cnt, ip);
+	down_read(&symbols->lock);
+	while (!symbols->sorted) {
+		up_read(&symbols->lock);
+		down_write(&symbols->lock);
+		symbols__sort_locked(symbols);
+		up_write(&symbols->lock);
+		down_read(&symbols->lock);
+	}
+
+	res = symbols__find_range(symbols->symbols, symbols->sorted_cnt, ip,
+				  &has_prefix, &prefix_start);
+	if (symbols->sorted_cnt < symbols->cnt) {
+		struct symbol *tail_res;
+		bool has_tail;
+		u64 tail_start = 0;
+
+		tail_res = symbols__find_range(&symbols->symbols[symbols->sorted_cnt],
+					       symbols->cnt - symbols->sorted_cnt, ip,
+					       &has_tail, &tail_start);
+		if (has_tail) {
+			if (!has_prefix || tail_start > prefix_start)
+				res = tail_res;
+			else if (tail_start == prefix_start && !res)
+				res = tail_res;
+		}
+	}
 	up_read(&symbols->lock);
 
 	return res;
@@ -904,7 +1059,13 @@ static struct symbol *symbols__find_by_name(struct symbol *symbols[],
 
 int dso__insert_symbol(struct dso *dso, struct symbol *sym)
 {
-	return symbols__insert(dso__symbols(dso), sym);
+	struct symbols *symbols = dso__symbols(dso);
+	int ret;
+
+	down_write(&symbols->lock);
+	ret = __symbols__insert_sorted(symbols, sym);
+	up_write(&symbols->lock);
+	return ret;
 }
 
 void dso__delete_symbol(struct dso *dso, struct symbol *sym)
@@ -912,11 +1073,15 @@ void dso__delete_symbol(struct dso *dso, struct symbol *sym)
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
+			if (symbols->sorted_cnt == symbols->cnt)
+				symbols->sorted = true;
 			zfree(&symbols->symbols_by_name);
 			symbols->num_by_name = 0;
 			symbols->sorted_by_name = false;
@@ -1263,6 +1428,7 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	old_cnt = root->cnt;
 	root->symbols = NULL;
 	root->cnt = 0;
+	root->sorted_cnt = 0;
 	root->allocated = 0;
 	root->sorted = true;
 	zfree(&root->symbols_by_name);
@@ -1337,6 +1503,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	old_allocated = root->allocated;
 	root->symbols = NULL;
 	root->cnt = 0;
+	root->sorted_cnt = 0;
 	root->allocated = 0;
 	root->sorted = true;
 	zfree(&root->symbols_by_name);
@@ -1487,6 +1654,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	if (root->cnt == 0) {
 		root->symbols = old_symbols;
 		root->cnt = write_idx;
+		root->sorted_cnt = write_idx;
 		root->allocated = old_allocated;
 		root->sorted = true;
 		old_symbols = NULL;
@@ -1516,12 +1684,14 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	if (root->cnt == 0) {
 		root->symbols = old_symbols;
 		root->cnt = write_idx;
+		root->sorted_cnt = (delta == 0) ? write_idx : 0;
 		root->allocated = old_allocated;
 		root->sorted = (delta == 0);
 		old_symbols = NULL;
 	} else {
 		for (unsigned int j = 0; j < write_idx; j++)
 			__symbols__insert(root, old_symbols[j]);
+		root->sorted_cnt = 0;
 		root->sorted = false;
 	}
 	zfree(&root->symbols_by_name);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 8b8ab7e1e148..541ab9321d99 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -113,6 +113,12 @@ struct symbols {
 	struct symbol **symbols_by_name __guarded_by(&lock);
 	/** @cnt: Number of valid entries in @symbols. */
 	unsigned int cnt __guarded_by(&lock);
+	/**
+	 * @sorted_cnt: Number of leading entries in @symbols that form the
+	 * primary sorted prefix. When @sorted is true and @sorted_cnt < @cnt,
+	 * the remaining tail @symbols[@sorted_cnt .. @cnt - 1] is also sorted.
+	 */
+	unsigned int sorted_cnt __guarded_by(&lock);
 	/** @allocated: Capacity (in entries) of the @symbols allocation. */
 	unsigned int allocated __guarded_by(&lock);
 	/** @num_by_name: Number of valid entries in @symbols_by_name. */
@@ -122,7 +128,10 @@ struct symbols {
 	 * by name.
 	 */
 	bool sorted_by_name __guarded_by(&lock);
-	/** @sorted: True when @symbols is sorted by address range. */
+	/**
+	 * @sorted: True when @symbols[0 .. @sorted_cnt - 1] and any tail
+	 * @symbols[@sorted_cnt .. @cnt - 1] are sorted by start address.
+	 */
 	bool sorted __guarded_by(&lock);
 };
 
-- 
2.56.1.750.gf70dc682cf-goog

