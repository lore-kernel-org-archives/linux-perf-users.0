Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559482;
	b=Np5vmmM9pdHizJ/ZfHvoBHTgYROjEdZ8ozRLbS8V20FP60xePFf6RO9seJjPQoFxKWIO
	 pIlt58LimKmoHZRf9+lbuPvBJH4OFDuwNdQFMk11SJAsRvA2geM15+VItMMPmDV/cCrmU
	 3kg0/XSBEs9S4E5et92c/rDaiaIor4iouN4B0QqPRMTZ6gcI8KScm/MYPo66kD8CRsuUX
	 cPpkHvWHtKu0v+TKFeL8tRhyGp3IiYZ2o3+2+UQ9RqU3x94DtgHmQPBFratYhAwjwDrU2
	 WzZP6L56tBZ9AXu9QpteZUmoXoS+fVLDpA2EWczZfRTgPeggCqvei+WinAQ/FPqqmcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=txtyNdYOM/Q99nFTCthhb/YlwqzBWOP7dJbGVojxyNQ=;
	b=nAWiHXSGJ/u7mszcAKWDpV7MeWUyPLExPcwQY+7GWNGB3xI8V61gZ8AtRMHlOe5KLO6a
	 uQ+q9GsqBVzVJ07N8R868WKQwmZYU3yzSu7JrTPkzMZtXmpmE28QIRxtXLbxp0uGDxHLU
	 nYtPTgFSfrYPST/lrph+r4ye5huCsSrOVFxci3+GQTmQg/bf9laniDilZM16vE0FYTgBM
	 t5ozBngzm83elRFH2fw4uuemNgjXbajCaqGi0W9nsNHGB5HO2oIBxvx1WOoNBpcNz6xKo
	 9qWWmrAAuAd8riPCiWS5V/Og/t/9sRRv3oK3ov4nV68hPFrInI9/J/ugHAKT5Ye8IWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ib6YCXww;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5D606A335
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 22:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3F5D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ib6YCXww
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso5560463eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 14:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795559481; x=1796164281; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=txtyNdYOM/Q99nFTCthhb/YlwqzBWOP7dJbGVojxyNQ=;
        b=Ib6YCXwwt7aqM6j3yHOTgF4frLZgdn6z8F0NfSZmdO8psoCsoYExhIzkiBfZhVWiIS
         cAG3ieQXiKyMJYuCFrgBAhCSZNs0nRdRZ+sS7aEUQrEBIf5lGNat5yw+/CQ3fEIIT6AV
         3HgaFdljKPlpTel3fmSebmmbhOPb7FyQ/ys/EzvyfY/DiTlT7xjQ5TyZ1gY9yG8pIMx2
         G1KQprLhp6wzsGNxXEKZgl2i5ypj1kD4N6TsaIR55jTqi7ev7BKZMjuemXGs9R3Y9sDM
         SG4FlJHYtRmktaAiB1NwCdk7u9+WvTmaiP0tjhIomyHfgkTntSiTFqaSo/nKXzfHQ0Iz
         S95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795559481; x=1796164281;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=txtyNdYOM/Q99nFTCthhb/YlwqzBWOP7dJbGVojxyNQ=;
        b=BjgXDZ2K0cn0ECk0+47uLld8PhXq8ZSGR3lUrzLXq+sQlegr+TG65myPMITqsvYk5X
         Pey0CNzGngwpsjmBXJK4UkT2zVKZ111/u+KhumqcPqAnHaflU+GQTpr4tqabzHu9aJM3
         7hWM78KTLTWa2n5ZYsP2e2O3UDZ6dslPmo8pRMGAvKUOER7AAzAby2MXSIwtM7oFM0Ew
         oHblsAg2Bge+LMBb+eNHQJx1DR1ImPa6jvP0Mtw853JaJvNaXC9DxXuVvof+y2Q/Jq7t
         2425x9Qd58OQ/fNOV5C9R9QJHDRgiU9bRbLOsH7lzIFv7dgAp/LUGUMD9ObuPaRDmfJe
         CHbg==
X-Forwarded-Encrypted: i=1; AL+hErFpYcq8QPKfcEwwzpjdiUd2/BBXFvSRLhGucS/Kg7hPSXPWmJFdfKO+P8+BV3qvijKSKV9XuqSuYh4dzbUNQs34@vger.kernel.org
X-Gm-Message-State: APuU4Z+iIUwBoR3cYMtooLSkzgWP307sNmABUodDjYQGWgc5LM6tFHT0
	QunJ9JqxF8lrJcXe2qeUlJtBrDrjKx05FLjrMXNTQRIEvoCtC7+yBXS6bkW9XiFJYzDLiUYSu0d
	ig7keh7XYfw==
X-Received: from dycnm14.prod.google.com ([2002:a05:7300:d18e:b0:386:2134:b328])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6da7:b0:384:5885:2f81
 with SMTP id 5a478bee46e88-3856c0c7c05mr22893777eec.5.1795559480226; Tue, 24
 Nov 2026 14:31:20 -0800 (PST)
Date: Tue, 24 Nov 2026 14:31:01 -0800
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
Message-ID: <20261124223109.820609-5-irogers@google.com>
Subject: [PATCH v10 04/12] perf symbol: Add secondary sorted run for dso__insert_symbol()
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dynamic symbol resolution via dso__insert_symbol() can insert symbols
out of order (with sym->start < symbols[sorted_cnt - 1]->start) into an
already-sorted DSO symbol table. Binary-inserting directly into the
primary sorted run memmoves O(N) pointers on every insertion.

Add @sorted_tail_cnt to struct symbols tracking an optional secondary
start-address-sorted run at
symbols[sorted_cnt .. sorted_cnt + sorted_tail_cnt) (keeping
sizeof(struct symbols) unchanged at 88 bytes on 64-bit) and expand the
struct symbols kernel-doc to document the three array regions:
- Append ascending symbols in O(1) (advancing @sorted_cnt) and
  binary-insert in place for small tables (cnt < 64).
- For larger out-of-order dynamic insertions when no unsorted bulk
  entries are pending, insert into the secondary sorted run with an
  amortized sqrt(N) merge threshold (sorted_tail_cnt >= 256 and
  sorted_tail_cnt^2 >= sorted_cnt).
- Search both sorted runs under a read lock in symbols__find() while
  preserving single-array highest start <= ip lookup semantics, and
  merge into a single sorted run in symbols__sort_read_lock().

Using 'perf bench internals symbols':

  Default (10,000 symbols, 200 appends):
    Before:
      Average append + lookup: 150.333 usec (+- 0.273 usec)
    After (-71.4%):
      Average append + lookup: 43.000 usec (+- 0.311 usec)

  Large DSO (-n 100000 -a 500):
    Before:
      Average append + lookup: 3315.200 usec (+- 12.532 usec)
    After (-91.1%):
      Average append + lookup: 294.000 usec (+- 11.574 usec)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.c | 151 ++++++++++++++++++++++++++++++++++++---
 tools/perf/util/symbol.h |  38 +++++++---
 2 files changed, 172 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index cf8c8e5cbd2b..10b6c847d5e9 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -221,6 +221,7 @@ void symbols__init(struct symbols *symbols)
 	symbols->symbols_by_name = NULL;
 	symbols->cnt = 0;
 	symbols->sorted_cnt = 0;
+	symbols->sorted_tail_cnt = 0;
 	symbols->allocated = 0;
 }
 
@@ -234,6 +235,7 @@ static void symbols__delete_locked(struct symbols *symbols)
 	zfree(&symbols->symbols_by_name);
 	symbols->cnt = 0;
 	symbols->sorted_cnt = 0;
+	symbols->sorted_tail_cnt = 0;
 	symbols->allocated = 0;
 }
 
@@ -435,12 +437,16 @@ static void symbols__sort_locked(struct symbols *symbols)
 	__must_hold(&symbols->lock)
 {
 	unsigned int m = symbols->sorted_cnt;
+	unsigned int t = symbols->sorted_tail_cnt;
 	unsigned int k;
 
 	if (m >= symbols->cnt) {
 		symbols->sorted_cnt = symbols->cnt;
+		symbols->sorted_tail_cnt = 0;
 		return;
 	}
+	if (t > symbols->cnt - m)
+		t = 0;
 	k = symbols->cnt - m;
 
 	/*
@@ -451,10 +457,24 @@ static void symbols__sort_locked(struct symbols *symbols)
 	if (k <= 8 || symbols->cnt <= 64) {
 		symbols__insertion_sort_range(symbols->symbols, 0, m, symbols->cnt);
 		symbols->sorted_cnt = symbols->cnt;
+		symbols->sorted_tail_cnt = 0;
 		return;
 	}
 
-	if (m <= 1) {
+	if (m + t == symbols->cnt) {
+		/*
+		 * Both [0 .. m) and the secondary run [m .. cnt) are already
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
@@ -476,11 +496,12 @@ static void symbols__sort_locked(struct symbols *symbols)
 	}
 
 	symbols->sorted_cnt = symbols->cnt;
+	symbols->sorted_tail_cnt = 0;
 }
 
 /*
  * Acquire @symbols->lock for reading after ensuring @symbols->symbols is
- * sorted.
+ * fully sorted into a single contiguous run.
  */
 void symbols__sort_read_lock(struct symbols *symbols)
 {
@@ -721,14 +742,81 @@ static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
 
 	if (symbols->sorted_cnt == symbols->cnt &&
 	    (symbols->cnt == 0 ||
-	     symbol__less_or_equal(symbols->symbols[symbols->cnt - 1], sym)))
+	     symbol__less_or_equal(symbols->symbols[symbols->cnt - 1], sym))) {
 		symbols->sorted_cnt = symbols->cnt + 1;
+	} else if (symbols->sorted_tail_cnt > 0 &&
+		   symbols->sorted_cnt + symbols->sorted_tail_cnt == symbols->cnt &&
+		   symbol__less_or_equal(symbols->symbols[symbols->cnt - 1], sym)) {
+		symbols->sorted_tail_cnt++;
+	}
 
 	symbols->symbols[symbols->cnt++] = sym;
 	zfree(&symbols->symbols_by_name);
 	return 0;
 }
 
+static int __symbols__insert_sorted(struct symbols *symbols, struct symbol *sym)
+	__must_hold(&symbols->lock)
+{
+	unsigned int idx;
+
+	if (symbols->sorted_cnt + symbols->sorted_tail_cnt < symbols->cnt)
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
+	if (symbols->sorted_tail_cnt == 0) {
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
+			 * Start a secondary sorted run at symbols[sorted_cnt]
+			 * so out-of-order insertions do not memmove the entire
+			 * primary sorted run on every call.
+			 */
+			symbols->symbols[symbols->cnt++] = sym;
+			symbols->sorted_tail_cnt = 1;
+		}
+	} else {
+		idx = symbols->sorted_cnt +
+		      symbols__upper_bound(&symbols->symbols[symbols->sorted_cnt],
+					   symbols->sorted_tail_cnt, sym);
+		memmove(&symbols->symbols[idx + 1], &symbols->symbols[idx],
+			(symbols->cnt - idx) * sizeof(struct symbol *));
+		symbols->symbols[idx] = sym;
+		symbols->cnt++;
+		symbols->sorted_tail_cnt++;
+
+		if (symbols->sorted_tail_cnt >= 256 &&
+		    (size_t)symbols->sorted_tail_cnt * symbols->sorted_tail_cnt >=
+		    symbols->sorted_cnt)
+			symbols__sort_locked(symbols);
+	}
+
+	zfree(&symbols->symbols_by_name);
+	return 0;
+}
+
 int symbols__insert(struct symbols *symbols, struct symbol *sym)
 {
 	int ret;
@@ -747,7 +835,9 @@ static inline bool symbol__covers(const struct symbol *s, u64 ip)
 	return ip >= start && (ip < end || (ip == end && ip == start));
 }
 
-static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt, u64 ip)
+static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
+					  u64 ip, bool *has_candidate,
+					  u64 *candidate_start)
 {
 	unsigned int low = 0, high = cnt, idx;
 	u64 start;
@@ -760,8 +850,10 @@ static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
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
@@ -770,6 +862,8 @@ static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
 	 */
 	idx = low - 1;
 	start = arr[idx]->start;
+	*has_candidate = true;
+	*candidate_start = start;
 	while (idx > 0 && arr[idx - 1]->start == start)
 		idx--;
 	for (; idx < low; idx++) {
@@ -781,17 +875,43 @@ static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
 
 /*
  * Binary search @symbols->symbols for a symbol covering @ip. Lazily sorts
- * @symbols under @symbols->lock if unsorted.
+ * @symbols under @symbols->lock if unsorted entries are present.
  */
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
+	while (symbols->sorted_cnt + symbols->sorted_tail_cnt < symbols->cnt) {
+		up_read(&symbols->lock);
+		down_write(&symbols->lock);
+		symbols__sort_locked(symbols);
+		up_write(&symbols->lock);
+		down_read(&symbols->lock);
+	}
+
+	res = symbols__find_range(symbols->symbols, symbols->sorted_cnt, ip,
+				  &has_prefix, &prefix_start);
+	if (symbols->sorted_tail_cnt > 0) {
+		struct symbol *tail_res;
+		bool has_tail;
+		u64 tail_start = 0;
+
+		tail_res = symbols__find_range(&symbols->symbols[symbols->sorted_cnt],
+					       symbols->sorted_tail_cnt, ip,
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
@@ -927,7 +1047,13 @@ static struct symbol *symbols__find_by_name(struct symbol *symbols[],
 
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
@@ -942,6 +1068,8 @@ void dso__delete_symbol(struct dso *dso, struct symbol *sym)
 			symbols->cnt--;
 			if (i < symbols->sorted_cnt)
 				symbols->sorted_cnt--;
+			else if (i < symbols->sorted_cnt + symbols->sorted_tail_cnt)
+				symbols->sorted_tail_cnt--;
 			zfree(&symbols->symbols_by_name);
 			symbol__delete(sym);
 			break;
@@ -1287,6 +1415,7 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	root->symbols = NULL;
 	root->cnt = 0;
 	root->sorted_cnt = 0;
+	root->sorted_tail_cnt = 0;
 	root->allocated = 0;
 	zfree(&root->symbols_by_name);
 	up_write(&root->lock);
@@ -1359,6 +1488,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	root->symbols = NULL;
 	root->cnt = 0;
 	root->sorted_cnt = 0;
+	root->sorted_tail_cnt = 0;
 	root->allocated = 0;
 	zfree(&root->symbols_by_name);
 	up_write(&root->lock);
@@ -1507,6 +1637,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		root->symbols = old_symbols;
 		root->cnt = write_idx;
 		root->sorted_cnt = write_idx;
+		root->sorted_tail_cnt = 0;
 		root->allocated = old_allocated;
 		old_symbols = NULL;
 	} else {
@@ -1534,12 +1665,14 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		root->symbols = old_symbols;
 		root->cnt = write_idx;
 		root->sorted_cnt = (delta == 0) ? write_idx : min(write_idx, 1U);
+		root->sorted_tail_cnt = 0;
 		root->allocated = old_allocated;
 		old_symbols = NULL;
 	} else {
 		for (unsigned int j = 0; j < write_idx; j++)
 			__symbols__insert(root, old_symbols[j]);
 		root->sorted_cnt = min(root->cnt, 1U);
+		root->sorted_tail_cnt = 0;
 	}
 	zfree(&root->symbols_by_name);
 	up_write(&root->lock);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 2b20bfb22fd1..1aa54c1f1680 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -99,11 +99,31 @@ struct symbol {
  * struct symbols - A locked collection of symbols stored in a sorted array.
  *
  * The @symbols array of @cnt pointers (within an allocation of @allocated
- * slots) keeps a start-address-sorted prefix @symbols[0 .. @sorted_cnt)
- * followed by an optional unsorted tail @symbols[@sorted_cnt .. @cnt) from
- * bulk symbols__insert() appends. When @sorted_cnt == @cnt, the entire array
- * is sorted; otherwise the unsorted tail is lazily sorted and merged into the
- * prefix on lookup or iteration.
+ * slots) is partitioned into up to three contiguous regions:
+ *
+ *   [0 .. @sorted_cnt)
+ *       Primary run, sorted by ascending symbol start address.
+ *   [@sorted_cnt .. @sorted_cnt + @sorted_tail_cnt)
+ *       Optional secondary sorted run holding out-of-order dynamic insertions
+ *       from dso__insert_symbol() whose start addresses precede
+ *       @symbols[@sorted_cnt - 1]->start (so the two runs overlap in address
+ *       range rather than forming one ascending sequence). Keeping @sorted_cnt
+ *       at the boundary between the two runs avoids memmoving the primary run
+ *       on every insertion while allowing O(log N) binary search across both
+ *       runs under a read lock; once the secondary run reaches
+ *       O(sqrt(@sorted_cnt)) entries (or a single contiguous run is required),
+ *       the two runs are merged and @sorted_cnt advances to @cnt.
+ *   [@sorted_cnt + @sorted_tail_cnt .. @cnt)
+ *       Optional unsorted tail from bulk symbols__insert() appends, lazily
+ *       sorted and merged into the primary run on lookup or iteration.
+ *
+ * Invariants:
+ * - @sorted_cnt == @cnt: all entries form a single sorted run
+ *   (@sorted_tail_cnt is 0).
+ * - @sorted_cnt + @sorted_tail_cnt == @cnt: all entries reside in the two
+ *   sorted runs and can be binary-searched without sorting.
+ * - @sorted_cnt + @sorted_tail_cnt < @cnt: unsorted entries are present and
+ *   must be sorted under @lock for writing before searching.
  */
 struct symbols {
 	/** @lock: Read/write semaphore synchronizing access to the arrays. */
@@ -118,11 +138,13 @@ struct symbols {
 	struct symbol **symbols_by_name __guarded_by(&lock);
 	/** @cnt: Total number of valid symbol pointers in @symbols. */
 	unsigned int cnt __guarded_by(&lock);
+	/** @sorted_cnt: Length of the primary start-address-sorted prefix. */
+	unsigned int sorted_cnt __guarded_by(&lock);
 	/**
-	 * @sorted_cnt: Length of the leading start-address-sorted prefix in
-	 * @symbols. The entire @symbols array is sorted iff @sorted_cnt == @cnt.
+	 * @sorted_tail_cnt: Length of the secondary start-address-sorted run
+	 * immediately following @sorted_cnt (0 when absent).
 	 */
-	unsigned int sorted_cnt __guarded_by(&lock);
+	unsigned int sorted_tail_cnt __guarded_by(&lock);
 	/** @allocated: Capacity (in entries) of the @symbols allocation. */
 	unsigned int allocated __guarded_by(&lock);
 };
-- 
2.56.1.831.g720f3f5937-goog

