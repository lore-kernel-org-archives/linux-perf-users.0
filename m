Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245455;
	b=1J4YINffTeURKv4/NR8OcLQRuEDgJ3HNKVgYQ9ZG34yZ/34dHbUJw0YRWNwJ28IoEdqq
	 wj+inBwNl6vact7wTit4pFrk5DHlpIsmvTuvG7XVtRo95bqqW1riVNSoUgdROouncTQf/
	 d0fQ/Y1v6o3zZoYlBeyvl7GAw4n41JTcBs17+luH5ZWAprRpKbm/uNH9hc6OT/O6bfS5w
	 ExCegJuqe5emfCqyxGQ1h+Xn8cay047C0HqlI/si3jooBmI2nLuvYu+telmEgVH2wzHdE
	 CU5h6C6smsfnXGDq/4i1Z3Ws45X9RPkFOvFTFA9jsJ9SdUrcYLnIwsCg0yc3/3ZtWJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=rJ7yK0YiyGO+Du3CNOP5bM2qQgrM1Sp4d+HA79xuEhI=;
	b=0QKoNaiEZVFHumQdS2h5XBWJCEaZxk8Y5cbTmjJQKWMp4BAh/auPvKt4QHQiMLplRmZ2
	 xxEglvTHDWNtGD1XyO5VzuLL2khrkwmhIN9PZsBtSzG+ixmGfsSgr67J3lTVrAzA1PZiq
	 Zf9OlrJWZEUr6EX0D+h2YJ0BegcDo4UYUjl7HxS5lU6ZFbNWSxtc3E6IXrvgDezwMx80n
	 G6Asbsyna1R2OAh7XItDM8qdQkvArW/bo3GaF8W2x2k31Tc+YVNNxg4cHj5/mjlTZlAfm
	 FGm+DKgGsqs+m4+sBJ1gaYYe0wA3M9WG2eWsVqZrNpAaGcqxdZzINblkTjmmqXuGojQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ilV1okhL;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2913606A330
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 07:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2913606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ilV1okhL
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-383165e9b0fso1850488eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 23:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795245454; x=1795850254; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJ7yK0YiyGO+Du3CNOP5bM2qQgrM1Sp4d+HA79xuEhI=;
        b=ilV1okhLrUguYSmDjb73mq5Y+Yqm/Kuk5fKi3oRqQpohMjL4not4Th/BIGuRWHAW8V
         cVuMPSXZ0ykLdye/an/PhziHjKiBD/7VVNfBgTLELmHEgsuIy1rgTf3+fDqH9AY9E6FS
         634TTCJ+2TNrk2MF9+9ndJOUftPpbae1LePXpypuXfQtrMnjBk9tN9SGAT0JpbcztUAy
         HhCGftFSVP99VQLWIVSGXCmWxPLqSIslOUsdLVt4uq22sXvYsgQY5zGtfLc8QGUk7YCx
         oCyNduvsRdkNhjAs7ssT2O5x9dgApRBu+JoC0Fa3crZPd0HXGpbpYiYVxChctZwcgVN+
         gkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795245454; x=1795850254;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rJ7yK0YiyGO+Du3CNOP5bM2qQgrM1Sp4d+HA79xuEhI=;
        b=uB6TF5CUX9SJk9Ur5fUqd6y28c4+sQ/go+4rW7V0ctQTyx1WhTm8t58vCuyC8cVqv+
         1GjGJxOswcOQfFNcR0EvKBLYCofNjn/m91YwnhtQH7qwWbdVckQtXZx3ahCaiLfm63QJ
         zpZ4HJ7Ze5r9yT+IlhtRdBwweIU8aQMraxTWuVWR+6UsDSe64iWT6GkzZJJNY0drHO/I
         LyS126X98mWKvdSmrDL+az1wbVerEaJ0jNWQBYvKkTBkCsFLoZhPFi7C9okTl+MV/6Zj
         QAecSJzs0XXZRMO3812ZRzobSEk1H9kK1WBkkjGpoNbPtk0vAH7SHZEYlaqgeE5wuenh
         ncVw==
X-Forwarded-Encrypted: i=1; AL+hErF1t1HZOYNo8aM0kciJlzJ0siahXQtxV5BLqdN/3jrhH5e8GrF//z8+iEI+Za8GeVX1Zzg2hOYH0S+omAaaox9D@vger.kernel.org
X-Gm-Message-State: APuU4Z8dbVPtOmWc63Wk/aIQ3fkV0tl5qWFEmHaaNVlowJXWkPpgslhV
	utYXl/1p0iVgL5JllGt97yeaG+m+2Y1sQCdQmUpyJE5VyzAX7+ll2pIxy/IZyHHDvP8I7p1jWEV
	igQ712RVa8A==
X-Received: from dycnb5.prod.google.com ([2002:a05:7301:b05:b0:386:458d:ba4c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:78d:b0:385:bc4e:dbbf
 with SMTP id 5a478bee46e88-385bc4ee6c2mr4566631eec.37.1795245453508; Fri, 20
 Nov 2026 23:17:33 -0800 (PST)
Date: Fri, 20 Nov 2026 23:16:48 -0800
In-Reply-To: <20261121071651.67118-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121071651.67118-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121071651.67118-8-irogers@google.com>
Subject: [PATCH v7 07/10] perf symbol: Optimize incremental symbol insertion
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
---
 tools/perf/util/symbol.c | 192 ++++++++++++++++++++++++++++++++++++---
 tools/perf/util/symbol.h |  11 ++-
 2 files changed, 189 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 114fe5ea3891..0eaeced63cd4 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -219,6 +219,7 @@ void symbols__init(struct symbols *symbols)
 	symbols->symbols = NULL;
 	symbols->symbols_by_name = NULL;
 	symbols->cnt = 0;
+	symbols->sorted_cnt = 0;
 	symbols->allocated = 0;
 	symbols->num_by_name = 0;
 	symbols->sorted = true;
@@ -233,6 +234,7 @@ static void symbols__delete_locked(struct symbols *symbols)
 	zfree(&symbols->symbols);
 	zfree(&symbols->symbols_by_name);
 	symbols->cnt = 0;
+	symbols->sorted_cnt = 0;
 	symbols->allocated = 0;
 	symbols->num_by_name = 0;
 	symbols->sorted = true;
@@ -432,12 +434,47 @@ static void symbols__sort_range_with_tmp(struct symbol **arr, unsigned int n,
 
 static void symbols__sort_locked(struct symbols *symbols)
 {
-	if (symbols->sorted)
+	unsigned int m = symbols->sorted_cnt;
+	unsigned int k;
+
+	if (symbols->sorted && symbols->sorted_cnt == symbols->cnt)
+		return;
+
+	if (m > symbols->cnt)
+		m = 0;
+	k = symbols->cnt - m;
+
+	if (k == 0) {
+		symbols->sorted = true;
 		return;
+	}
 
-	if (symbols->cnt <= 64) {
+	/*
+	 * When only a few symbols have been appended since the last sort
+	 * (including single-symbol insertions), insert them directly at
+	 * their binary-searched sorted positions in O(N) without allocating.
+	 */
+	if (k <= 8 || symbols->cnt <= 64) {
 		symbols__insertion_sort_range(symbols->symbols, 0, symbols->cnt);
-	} else {
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
+			symbols__insertion_sort_range(symbols->symbols, 0, symbols->cnt);
+		}
+	} else if (m <= 1) {
 		struct symbol **tmp = malloc(((symbols->cnt + 1) / 2) * sizeof(struct symbol *));
 
 		if (tmp) {
@@ -446,19 +483,31 @@ static void symbols__sort_locked(struct symbols *symbols)
 		} else {
 			symbols__insertion_sort_range(symbols->symbols, 0, symbols->cnt);
 		}
+	} else {
+		struct symbol **tmp = malloc(k * sizeof(struct symbol *));
+
+		if (tmp) {
+			symbols__sort_range_with_tmp(&symbols->symbols[m], k, tmp);
+			symbols__merge_runs(symbols->symbols, 0, m, symbols->cnt, tmp);
+			free(tmp);
+		} else {
+			symbols__insertion_sort_range(symbols->symbols, 0, symbols->cnt);
+		}
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
 	NO_THREAD_SAFETY_ANALYSIS
 {
 	down_read(&symbols->lock);
-	while (!symbols->sorted) {
+	while (!symbols->sorted || symbols->sorted_cnt < symbols->cnt) {
 		up_read(&symbols->lock);
 		down_write(&symbols->lock);
 		symbols__sort_locked(symbols);
@@ -507,6 +556,7 @@ void symbols__fixup_duplicate(struct symbols *symbols)
 		}
 	}
 	symbols->cnt = write_idx + 1;
+	symbols->sorted_cnt = symbols->cnt;
 	zfree(&symbols->symbols_by_name);
 	symbols->num_by_name = 0;
 	symbols->sorted_by_name = false;
@@ -682,9 +732,15 @@ static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
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
@@ -693,6 +749,69 @@ static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
 	return 0;
 }
 
+static int __symbols__insert_sorted(struct symbols *symbols, struct symbol *sym)
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
@@ -711,7 +830,9 @@ static inline bool symbol__covers(const struct symbol *s, u64 ip)
 	return ip >= start && (ip < end || (ip == end && ip == start));
 }
 
-static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt, u64 ip)
+static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
+					  u64 ip, bool *has_candidate,
+					  u64 *candidate_start)
 {
 	unsigned int low = 0, high = cnt, idx;
 	u64 start;
@@ -724,8 +845,10 @@ static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
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
@@ -734,6 +857,8 @@ static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
 	 */
 	idx = low - 1;
 	start = arr[idx]->start;
+	*has_candidate = true;
+	*candidate_start = start;
 	while (idx > 0 && arr[idx - 1]->start == start)
 		idx--;
 	for (; idx < low; idx++) {
@@ -750,12 +875,38 @@ static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
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
@@ -900,7 +1051,13 @@ static struct symbol *symbols__find_by_name(struct symbol *symbols[],
 
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
@@ -908,11 +1065,15 @@ void dso__delete_symbol(struct dso *dso, struct symbol *sym)
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
@@ -1259,6 +1420,7 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	old_cnt = root->cnt;
 	root->symbols = NULL;
 	root->cnt = 0;
+	root->sorted_cnt = 0;
 	root->allocated = 0;
 	root->sorted = true;
 	zfree(&root->symbols_by_name);
@@ -1333,6 +1495,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	old_allocated = root->allocated;
 	root->symbols = NULL;
 	root->cnt = 0;
+	root->sorted_cnt = 0;
 	root->allocated = 0;
 	root->sorted = true;
 	zfree(&root->symbols_by_name);
@@ -1479,6 +1642,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	if (root->cnt == 0) {
 		root->symbols = old_symbols;
 		root->cnt = write_idx;
+		root->sorted_cnt = write_idx;
 		root->allocated = old_allocated;
 		root->sorted = true;
 		old_symbols = NULL;
@@ -1508,12 +1672,14 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
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
index 9d7de66cc284..dfdcf026a8c1 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -113,11 +113,20 @@ struct symbols {
 	struct symbol **symbols_by_name;
 	/** @cnt: Number of valid entries in @symbols. */
 	unsigned int cnt;
+	/**
+	 * @sorted_cnt: Number of leading entries in @symbols that form the
+	 * primary sorted prefix. When @sorted is true and @sorted_cnt < @cnt,
+	 * the remaining tail @symbols[@sorted_cnt .. @cnt - 1] is also sorted.
+	 */
+	unsigned int sorted_cnt;
 	/** @allocated: Capacity (in entries) of the @symbols allocation. */
 	unsigned int allocated;
 	/** @num_by_name: Number of valid entries in @symbols_by_name. */
 	unsigned int num_by_name;
-	/** @sorted: True when @symbols is sorted by address range. */
+	/**
+	 * @sorted: True when @symbols[0 .. @sorted_cnt - 1] and any tail
+	 * @symbols[@sorted_cnt .. @cnt - 1] are sorted by start address.
+	 */
 	bool sorted;
 	/**
 	 * @sorted_by_name: True when @symbols_by_name is populated and sorted
-- 
2.56.1.750.gf70dc682cf-goog

