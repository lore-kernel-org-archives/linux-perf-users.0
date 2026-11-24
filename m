Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490966;
	b=cIJM1v/2mUF4VJgO1Kace+uyTbQt5DwwltZNjuMEz3GK2fwp//YEpIQYp58GCltVMg4y
	 owvVmUH/2pLlB6y79A4bIsc+M39J9c+OSU80vSFiBVBO6I7Ci1mkFPg8DN36Wki/MQ8UG
	 p6zXs9D3cwIYzFp8HDMo4NP6ps5jyEnwF44NbwEc+UrM/8xueuGpz1WHx4VI2Yq+AFVTr
	 fjjaAvrrMUBS7zbeo0hc/f5wzlBTXdkxwkXRYmrAi8yi+FFytFgRQFZXG3YyKoELVkmMG
	 y96aDO85Lvt80h5SZ8/J+gW7Y2jeVwnGhrnQ/lDU0xQRzyb6F/bNZwuekYBcVQ81cHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+dhrDfNbaDX/WURc1pFIyGu1iHQQiL97I3mMz21Zq7E=;
	b=LjAHPb67hUlRQHs7Nx/Sx5j55yfHEs44Dx7WxnEtnmE0LIMEwCX1PbNsKzQXGflp2JvJ
	 TWHxEd7YRX/4VpKUAWJnwPUV7XUSZFBzoOMNLwOA3ZEekZNzogBkT5vZs1Ow65hbqRC5B
	 LBKMKCMrx4GB9oE3nXyZPF6jQSRmH3hOP3kkq7I6Hwsov7kOsJZgUQEBoWOwYwdbtJCry
	 qAwKt9/B3zIPVjtemldjCK16lPFfKUCvUrTqw1lf+M1phh3MJKh8ztnmzA0vZ3TmWwTtC
	 KzxYIJDRAftQbEACqmmKN8hUnpif1hu1Fr7RgqFP75/S411teUbO5IDrECJbh/aoLdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LDFYyLrr;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E7E606A321
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 03:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7E7E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LDFYyLrr
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1b3b45597c7so4600760c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 19:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795490965; x=1796095765; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+dhrDfNbaDX/WURc1pFIyGu1iHQQiL97I3mMz21Zq7E=;
        b=LDFYyLrrGPczujeBp8d+2okBQ79Yre4LXhBKa7vm8g7Rv7rZP/z0BbJ6KxzNP2u5xB
         Kzy7OiUGmFFSeEvODajOVA+PvjvtDYemVP+CcydmKc1FHAFK5JpcFKXEuqw+6D7+j5c0
         ig96Ol2HhDAcDFoHJ/KgDFyf7qmoWvtzcSpGtKcCc6SGaYykFb1e93giGl8IV29VHjGq
         vy+u1cvQxzhYwIJoOanly1b4WI0E9061SanD3qbEXHfQvZlxsTmaVoxmhRbw7XfSpyVR
         ZwIMumbHAwvMwCSxff/YJm72ZydlKJrps0pOaZ6aef1MRaXfpufiNyZ+j8Yeo5+ZhFjB
         96xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490965; x=1796095765;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+dhrDfNbaDX/WURc1pFIyGu1iHQQiL97I3mMz21Zq7E=;
        b=qnXkRrDn0UdgfDhxTIzZ/21j+bsmphaxocMOV3RmmdoegQocWdYIWGb9OsGY5t9Q8f
         luB6G7KWascV4oGuBY8P4xFpXOwk5C+FoijzuvfjAvJdeDm4nkudIJNI5pygIYazURLl
         K8JZ1G0Bbqx+IQJpwN7YVyXvMFU9M90CVzY4PMmrFXZhOkimt0s5JhHbVBSrruWwhsKJ
         Ei77r6v2oRvfwu0NpQelA4+SB5CNBG23y5k6ireSfacecSQ2kEUbBFmZIB24+ECmoH5j
         Ivx0HPADKdf8KKZnXF65ggnQA30wvX5WEPE6V7Jnra53mWm3gyQhScNbWFFSJqECGzGf
         OlUA==
X-Forwarded-Encrypted: i=1; AL+hErHEsmd2vteGgK3OQx1WXYi+dXhI89QxBwWP8nhH+M6hVJNnzAkBtxcrVSZ1C7jBxjrfPp2ENncJ/4mN2BvuVeGq@vger.kernel.org
X-Gm-Message-State: APuU4Z8wS9w/X7fMnj8RrlqWaD7j85OvKUlL4+pRfS6U2uE+sfqBCeg3
	c5sHuY5mjdcaS4Mlit5uKQW2r5s+1qaWcT2tTwUS+J9AfYigaZJxOpDHFZ19z1j/aoFiNYGLCMx
	WThTewesjwg==
X-Received: from dlbpv12.prod.google.com ([2002:a05:7023:90c:b0:1b5:3b6f:4e26])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4308:b0:1b5:1a6e:1bec
 with SMTP id a92af1059eb24-1b5568779e3mr13379512c88.10.1795490964504; Mon, 23
 Nov 2026 19:29:24 -0800 (PST)
Date: Mon, 23 Nov 2026 19:28:54 -0800
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
Message-ID: <20261124032902.3859564-4-irogers@google.com>
Subject: [PATCH v9 03/11] perf symbol: Add secondary sorted run for dso__insert_symbol()
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
index b9ddebdcd900..f3a3889f1062 100644
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
@@ -711,14 +732,81 @@ static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
 
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
@@ -737,7 +825,9 @@ static inline bool symbol__covers(const struct symbol *s, u64 ip)
 	return ip >= start && (ip < end || (ip == end && ip == start));
 }
 
-static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt, u64 ip)
+static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
+					  u64 ip, bool *has_candidate,
+					  u64 *candidate_start)
 {
 	unsigned int low = 0, high = cnt, idx;
 	u64 start;
@@ -750,8 +840,10 @@ static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
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
@@ -760,6 +852,8 @@ static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
 	 */
 	idx = low - 1;
 	start = arr[idx]->start;
+	*has_candidate = true;
+	*candidate_start = start;
 	while (idx > 0 && arr[idx - 1]->start == start)
 		idx--;
 	for (; idx < low; idx++) {
@@ -771,17 +865,43 @@ static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
 
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
@@ -917,7 +1037,13 @@ static struct symbol *symbols__find_by_name(struct symbol *symbols[],
 
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
@@ -932,6 +1058,8 @@ void dso__delete_symbol(struct dso *dso, struct symbol *sym)
 			symbols->cnt--;
 			if (i < symbols->sorted_cnt)
 				symbols->sorted_cnt--;
+			else if (i < symbols->sorted_cnt + symbols->sorted_tail_cnt)
+				symbols->sorted_tail_cnt--;
 			zfree(&symbols->symbols_by_name);
 			symbol__delete(sym);
 			break;
@@ -1277,6 +1405,7 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	root->symbols = NULL;
 	root->cnt = 0;
 	root->sorted_cnt = 0;
+	root->sorted_tail_cnt = 0;
 	root->allocated = 0;
 	zfree(&root->symbols_by_name);
 	up_write(&root->lock);
@@ -1349,6 +1478,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	root->symbols = NULL;
 	root->cnt = 0;
 	root->sorted_cnt = 0;
+	root->sorted_tail_cnt = 0;
 	root->allocated = 0;
 	zfree(&root->symbols_by_name);
 	up_write(&root->lock);
@@ -1497,6 +1627,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		root->symbols = old_symbols;
 		root->cnt = write_idx;
 		root->sorted_cnt = write_idx;
+		root->sorted_tail_cnt = 0;
 		root->allocated = old_allocated;
 		old_symbols = NULL;
 	} else {
@@ -1524,12 +1655,14 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
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
2.56.1.809.ga0b61035b5-goog

