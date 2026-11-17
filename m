Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941603;
	b=fqT5cAE0gF0Ik3YjGDoFNcCtLCx8bKdAG1zbMzhVvjCNBVs9QmlLtgrMnYn/GSWEQ114
	 vBTMzYs6AFxGUFmhWU7Z3hIkzP0Y2KcN6uQlhMIX3XSTSKGc9x7Mu4cI2prUSmlnBRtik
	 dJgJ5BbNZiUTaeP2mlSQ7g81irymG8EG51dzJldUa29NnZ0SiSCuG4tTESGDOwND2uD1C
	 Ihm5dWBqVQiyUboGYfbiKPm/VYB5JwxPrrh0SuazF64bZANTvcnTadzX2FrGXB1Plx6Kl
	 kqVvJqELWWwdt4pJNv5dcaDGWWYjLhOEJUJIPalFStZfUf12U4UwnoWRfOCSPt6y8uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=O3T5tdof4nzkqStaS1bDkoxYMZKJxthtedIrhdcQc08=;
	b=J64l7fFFAm1M5bz7I6N0nbjadC8WuqRSa6tKCewf6MChfqRzBckBjJaSP4JfuHA9NQft
	 kbfTsCkDdC3C0oIgOfrvQz3zz75KSvHfEnHFZNe4qAb7u3jn3Tal601gutfD5acqBocp8
	 hYUwVwC0N6SXFkqCWHjFXk51l8+DQqj7RgJGV/dxv4xGx4Tnr04mJMVKQrlHgftXxz7UN
	 sHf/l/Ll/gf0aKeOIYVi/LsOxMS4EsnhoNZIAxWsBXGn2n11r8+tCiXXkncXrGUNUYjxT
	 H6Uss9LTCvTiE3gtwAUErDtdDtHt2Mj9Ejw6swh75krnuESQRnTOvWN8NvLq1dCdg8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=H70PzzNP;
	arc=none smtp.remote-ip=209.85.160.69
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A1F606A883
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5A1F606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=H70PzzNP
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-46f178d813bso147942fac.3
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 10:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941601; x=1795546401; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O3T5tdof4nzkqStaS1bDkoxYMZKJxthtedIrhdcQc08=;
        b=H70PzzNPQAy7gg4HBBeXsbKc0rpDWX7dJWSUfU6FzxBruwo/DKP45ukb6sEejUHjLV
         3MifahhW7TLSerqB3SYmWnQepnsC2LepPBgPRgTA7XTQTNW+KPweGXlZ2ht0XGhMxQrE
         Cl5od5f7dLl3nnheFHs8SjjteWBlpvFm6+O/mRbnxO/4b2awHMyu51DlQ1g0PvmRoeEU
         ajaul4pLJV/YlzREupAyHx7LjZo49vQSxnHkjykVCnnm/8AcBMDtG+5KoNpxg+ipZ5we
         s3519N1M/6dp1f2NVzxcVtQx/RoJKWX3aRFhBuKJLfQyiLpQ4AjBjwKLCtOAG6Utofrt
         KGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941601; x=1795546401;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O3T5tdof4nzkqStaS1bDkoxYMZKJxthtedIrhdcQc08=;
        b=TTn1LArOD2VNCSlc1NVGyZhLh8uCfMx8Acd4wJg+XvFH5rxFhsUOD4iqX1/JAtBX4c
         AsDQt66//2k90GUeHUYv3lBYnopVzhNR0l5v9qVGqWEfCU6dlu2MyWoTfNye5cdApAR5
         Vx6rz4bRfrZogShFf8afS7pv2y1fenGtIuSlp2U23RqbmGqES43FwhAejO33U6OK5l53
         vta+Yk4fREP7LxMuiLL1VO4uwY3dZfUBYCvQkFpC3g/Ck5ZF6YbngAfoQPl5WeiEj8Ke
         1MVHs176FACPKzN/OqdV3gjDjls0CyNXJhjsyLgZxQF/QNx7URy0KrhHTslzcO9W03Ts
         gq/w==
X-Forwarded-Encrypted: i=1; AL+hErGuL5swxRxqOafARcZm7+PvwYivEdFPH6mhEgNlLIJzjbBo3xBMDtii7iQwfm4ASLBDEw9lBFQgMG3njYJYyRQG@vger.kernel.org
X-Gm-Message-State: APuU4Z+8oeLy3e9OYvr5qzWnCZMoxfRsQzmJPwoVInMIALuagIy9MI9K
	UCRUqC7eD2GBqWgzm9QeNc/DlzYkqZrZyJHYGFN5Vum6vOpk9ourj/VNaDp7bZH2ViwIRDZEBEF
	7gUU17OS//Q==
X-Received: from oaep18.prod.google.com ([2002:a05:6870:8312:b0:49e:2cc3:427])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:4f62:b0:4e9:df3c:c45c
 with SMTP id 5614622812f47-5773cd21607mr825951b6e.19.1794941601308; Tue, 17
 Nov 2026 10:53:21 -0800 (PST)
Date: Tue, 17 Nov 2026 10:53:02 -0800
In-Reply-To: <20261117185305.108003-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117185305.108003-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117185305.108003-7-irogers@google.com>
Subject: [PATCH v6 6/9] perf symbol: Optimize symbol sorting with natural-run
 merge sort and binary insertion
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ELF .symtab and .dynsym sections are typically already mostly ordered by
address in ascending runs, and dynamic symbol resolution
(dso__insert_symbol()) frequently inserts one or a few symbols into an
already-sorted DSO symbol table. Invoking full-array qsort() on every
sort after incremental insertions or across pre-ordered ELF runs spends
avoidable CPU time in symbol comparisons.

Speed up symbol array sorting and out-of-order symbol insertions:

- Track the sorted prefix length (@sorted_cnt) in struct symbols and
  replace full-array qsort() with a natural-run merge sort
  (symbols__sort_range_with_tmp()) and galloping binary-search merge
  (symbols__merge_runs()), plus an O(N) in-place binary insertion fast
  path when <= 8 symbols are appended.
- Insert directly into sorted position in dso__insert_symbol() when
  symbols->sorted is true so dynamic single-symbol insertions maintain
  the sorted invariant without triggering full re-sorts.

Using 'perf bench internals symbols':

  Before:
    Average DSO load + sort: 6.242 msec (+- 0.057 msec)
    Average bulk insert + lookup: 1404.150 usec (+- 18.752 usec)
    Average append + lookup: 40429.750 usec (+- 507.578 usec)
  After (-7.0% load, -13.9% bulk, -99.6% append):
    Average DSO load + sort: 5.808 msec (+- 0.047 msec)
    Average bulk insert + lookup: 1209.250 usec (+- 18.446 usec)
    Average append + lookup: 152.900 usec (+- 0.736 usec)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.c | 433 +++++++++++++++++++++++++++++++++++++--
 tools/perf/util/symbol.h |  11 +-
 2 files changed, 423 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index f1e3d7af714c..84a8b3e4c528 100644
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
@@ -263,37 +265,311 @@ static inline bool symbol__less_or_equal(const struct symbol *a, const struct sy
 	return a->start <= b->start;
 }
 
-static int symbols__sort_cmp(const void *vlhs, const void *vrhs)
+static unsigned int symbols__upper_bound(struct symbol **arr, unsigned int len,
+					 const struct symbol *sym)
 {
-	const struct symbol *lhs = *((const struct symbol **)vlhs);
-	const struct symbol *rhs = *((const struct symbol **)vrhs);
+	unsigned int low = 0, high = len;
 
-	if (lhs->start != rhs->start)
-		return lhs->start < rhs->start ? -1 : 1;
-	return 0;
+	while (low < high) {
+		unsigned int mid = low + (high - low) / 2;
+
+		if (symbol__less_or_equal(arr[mid], sym))
+			low = mid + 1;
+		else
+			high = mid;
+	}
+	return low;
+}
+
+static unsigned int symbols__lower_bound(struct symbol **arr, unsigned int len,
+					 const struct symbol *sym)
+{
+	unsigned int low = 0, high = len;
+
+	while (low < high) {
+		unsigned int mid = low + (high - low) / 2;
+
+		if (!symbol__less_or_equal(sym, arr[mid]))
+			low = mid + 1;
+		else
+			high = mid;
+	}
+	return low;
+}
+
+static void symbols__insertion_sort_range(struct symbol **arr,
+					  unsigned int start,
+					  unsigned int end)
+{
+	for (unsigned int i = start + 1; i < end; i++) {
+		struct symbol *sym = arr[i];
+
+		if (!symbol__less_or_equal(arr[i - 1], sym)) {
+			unsigned int pos = start +
+				symbols__upper_bound(&arr[start], i - start, sym);
+
+			memmove(&arr[pos + 1], &arr[pos],
+				(i - pos) * sizeof(struct symbol *));
+			arr[pos] = sym;
+		}
+	}
+}
+
+static void symbols__merge_runs(struct symbol **arr,
+				unsigned int left,
+				unsigned int mid,
+				unsigned int right,
+				struct symbol **tmp)
+{
+	unsigned int first_left, last_left, left_len, right_len;
+	unsigned int i, j, dst;
+
+	if (left >= mid || mid >= right)
+		return;
+	if (symbol__less_or_equal(arr[mid - 1], arr[mid]))
+		return;
+
+	first_left = left + symbols__upper_bound(&arr[left], mid - left, arr[mid]);
+	right_len = right - mid;
+
+	if (mid - first_left <= right_len) {
+		left_len = mid - first_left;
+		memcpy(tmp, &arr[first_left], left_len * sizeof(struct symbol *));
+		i = 0;
+		j = mid;
+		dst = first_left;
+		while (i < left_len && j < right) {
+			if (symbol__less_or_equal(tmp[i], arr[j])) {
+				arr[dst++] = tmp[i++];
+			} else {
+				arr[dst++] = arr[j++];
+				if (right - j >= 16 &&
+				    (right - j) > 8 * (left_len - i) &&
+				    !symbol__less_or_equal(tmp[i], arr[j])) {
+					unsigned int step =
+						symbols__lower_bound(&arr[j], right - j, tmp[i]);
+
+					if (step > 0) {
+						memmove(&arr[dst], &arr[j],
+							step * sizeof(struct symbol *));
+						dst += step;
+						j += step;
+					}
+				}
+			}
+		}
+		if (i < left_len)
+			memcpy(&arr[dst], &tmp[i], (left_len - i) * sizeof(struct symbol *));
+		return;
+	}
+
+	last_left = first_left +
+		    symbols__upper_bound(&arr[first_left], mid - first_left, arr[right - 1]);
+	left_len = last_left - first_left;
+
+	memcpy(tmp, &arr[mid], right_len * sizeof(struct symbol *));
+	if (last_left < mid) {
+		memmove(&arr[last_left + right_len], &arr[last_left],
+			(mid - last_left) * sizeof(struct symbol *));
+	}
+
+	if (first_left == last_left) {
+		memcpy(&arr[first_left], tmp, right_len * sizeof(struct symbol *));
+		return;
+	}
+
+	i = last_left;
+	j = right_len;
+	dst = last_left + right_len;
+	while (i > first_left && j > 0) {
+		if (symbol__less_or_equal(arr[i - 1], tmp[j - 1])) {
+			arr[--dst] = tmp[--j];
+		} else {
+			arr[--dst] = arr[--i];
+			if (i - first_left >= 16 &&
+			    (i - first_left) > 8 * j &&
+			    !symbol__less_or_equal(arr[i - 1], tmp[j - 1])) {
+				unsigned int pos = first_left +
+					symbols__upper_bound(&arr[first_left],
+							     i - first_left,
+							     tmp[j - 1]);
+				unsigned int step = i - pos;
+
+				if (step > 0) {
+					dst -= step;
+					i = pos;
+					memmove(&arr[dst], &arr[pos],
+						step * sizeof(struct symbol *));
+				}
+			}
+		}
+	}
+	if (j > 0)
+		memcpy(&arr[first_left], tmp, j * sizeof(struct symbol *));
+}
+
+struct symbol_run {
+	unsigned int start;
+	unsigned int len;
+};
+
+static void symbols__sort_range_with_tmp(struct symbol **arr, unsigned int n,
+					 struct symbol **tmp)
+{
+	struct symbol_run runs[64];
+	unsigned int nr_runs = 0;
+	unsigned int i = 0;
+
+	if (n <= 32) {
+		symbols__insertion_sort_range(arr, 0, n);
+		return;
+	}
+
+	while (i < n) {
+		unsigned int start = i++;
+
+		if (i < n) {
+			if (symbol__less_or_equal(arr[i - 1], arr[i])) {
+				while (i < n && symbol__less_or_equal(arr[i - 1], arr[i]))
+					i++;
+			} else {
+				while (i < n && !symbol__less_or_equal(arr[i - 1], arr[i]))
+					i++;
+				for (unsigned int lo = start, hi = i - 1; lo < hi; lo++, hi--) {
+					struct symbol *swap = arr[lo];
+
+					arr[lo] = arr[hi];
+					arr[hi] = swap;
+				}
+			}
+		}
+
+		if (i - start < 32 && i < n) {
+			i = min(start + 32U, n);
+			symbols__insertion_sort_range(arr, start, i);
+		}
+
+		runs[nr_runs++] = (struct symbol_run){
+			.start = start,
+			.len = i - start,
+		};
+
+		while (nr_runs > 1) {
+			unsigned int r = nr_runs - 2;
+
+			if (nr_runs >= 3 &&
+			    runs[nr_runs - 3].len <=
+			    runs[nr_runs - 2].len + runs[nr_runs - 1].len) {
+				if (runs[nr_runs - 3].len < runs[nr_runs - 1].len)
+					r = nr_runs - 3;
+			} else if (runs[nr_runs - 2].len > runs[nr_runs - 1].len &&
+				   nr_runs < ARRAY_SIZE(runs)) {
+				break;
+			}
+
+			symbols__merge_runs(arr, runs[r].start,
+					    runs[r + 1].start,
+					    runs[r + 1].start + runs[r + 1].len,
+					    tmp);
+			runs[r].len += runs[r + 1].len;
+			if (r + 2 < nr_runs)
+				runs[r + 1] = runs[r + 2];
+			nr_runs--;
+		}
+	}
+
+	while (nr_runs > 1) {
+		unsigned int r = nr_runs - 2;
+
+		if (nr_runs >= 3 && runs[nr_runs - 3].len < runs[nr_runs - 1].len)
+			r = nr_runs - 3;
+		symbols__merge_runs(arr, runs[r].start,
+				    runs[r + 1].start,
+				    runs[r + 1].start + runs[r + 1].len,
+				    tmp);
+		runs[r].len += runs[r + 1].len;
+		if (r + 2 < nr_runs)
+			runs[r + 1] = runs[r + 2];
+		nr_runs--;
+	}
 }
 
 static void symbols__sort_locked(struct symbols *symbols)
 {
-	if (symbols->sorted)
+	unsigned int m = symbols->sorted_cnt;
+	unsigned int k;
+
+	if (symbols->sorted && symbols->sorted_cnt == symbols->cnt)
 		return;
 
-	if (symbols->cnt > 1) {
-		qsort(symbols->symbols, symbols->cnt, sizeof(struct symbol *),
-		      symbols__sort_cmp);
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
+		symbols__insertion_sort_range(symbols->symbols, 0, symbols->cnt);
+		symbols->sorted_cnt = symbols->cnt;
+		symbols->sorted = true;
+		return;
 	}
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
+		struct symbol **tmp = malloc(((symbols->cnt + 1) / 2) * sizeof(struct symbol *));
+
+		if (tmp) {
+			symbols__sort_range_with_tmp(symbols->symbols, symbols->cnt, tmp);
+			free(tmp);
+		} else {
+			symbols__insertion_sort_range(symbols->symbols, 0, symbols->cnt);
+		}
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
+	}
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
@@ -342,6 +618,7 @@ void symbols__fixup_duplicate(struct symbols *symbols)
 		}
 	}
 	symbols->cnt = write_idx + 1;
+	symbols->sorted_cnt = symbols->cnt;
 	zfree(&symbols->symbols_by_name);
 	symbols->num_by_name = 0;
 	symbols->sorted_by_name = false;
@@ -517,9 +794,15 @@ static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
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
@@ -528,6 +811,69 @@ static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
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
@@ -546,7 +892,9 @@ static inline bool symbol__covers(const struct symbol *s, u64 ip)
 	return ip >= start && (ip < end || (ip == end && ip == start));
 }
 
-static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt, u64 ip)
+static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
+					  u64 ip, bool *has_candidate,
+					  u64 *candidate_start)
 {
 	unsigned int low = 0, high = cnt, idx;
 	u64 start;
@@ -559,8 +907,10 @@ static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
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
@@ -569,6 +919,8 @@ static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
 	 */
 	idx = low - 1;
 	start = arr[idx]->start;
+	*has_candidate = true;
+	*candidate_start = start;
 	while (idx > 0 && arr[idx - 1]->start == start)
 		idx--;
 	for (; idx < low; idx++) {
@@ -585,12 +937,38 @@ static struct symbol *symbols__find_range(struct symbol **arr, unsigned int cnt,
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
@@ -735,7 +1113,13 @@ static struct symbol *symbols__find_by_name(struct symbol *symbols[],
 
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
@@ -743,11 +1127,15 @@ void dso__delete_symbol(struct dso *dso, struct symbol *sym)
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
@@ -1094,6 +1482,7 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	old_cnt = root->cnt;
 	root->symbols = NULL;
 	root->cnt = 0;
+	root->sorted_cnt = 0;
 	root->allocated = 0;
 	root->sorted = true;
 	zfree(&root->symbols_by_name);
@@ -1168,6 +1557,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	old_allocated = root->allocated;
 	root->symbols = NULL;
 	root->cnt = 0;
+	root->sorted_cnt = 0;
 	root->allocated = 0;
 	root->sorted = true;
 	zfree(&root->symbols_by_name);
@@ -1314,6 +1704,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	if (root->cnt == 0) {
 		root->symbols = old_symbols;
 		root->cnt = write_idx;
+		root->sorted_cnt = write_idx;
 		root->allocated = old_allocated;
 		root->sorted = true;
 		old_symbols = NULL;
@@ -1343,12 +1734,14 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
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
index adfb1a3a89be..ce7be4b18a11 100644
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
2.56.1.703.gf848ed807c-goog

