Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142943;
	b=xqJlFvpzAO2lksX8Uqwu3MAgIh+rT5VwAoLWOAS2A9hz6GS3t1srsCLEmPUbvMOim1BB
	 4/7JIYPx/HApekPna4bSSczKzux4E9urRxWHcMMLMYXI3UsocbKsASXopWCLgZqadxlxA
	 gc/At7FCsErqR2jqpZ+v0VfEhpEXmFp/J5JMiHG0kV474GzNK3r/W5ddLv1/UTSnr01F1
	 IvWarIdBasu2poh2FFAXhOuO84msmm5l8SJJftbR4GWsieodRWDyjZU9TeKOYR7w8MVmc
	 cthSWAX3XgIt1ZnB8QrCb9AB7qSDnCXHZbHZCqXrv+OBVHbGNUCPfO4muXNpf43vJqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=BYIEV2ZaeDBaHLS1knK02+j6d4YqzE4mGsYZjVYzkjE=;
	b=MClTE5OfeYJHZIxesAZm+FonQPE563lViKrnRfeEfQMCZ7A3/X1AYlkwVQYYG3v5WJvJ
	 VyLJKD9TzUb29OCnRaCsNFeH1aL8HuKSeWCVV5d6yL/3XNOitxxmkE5qDE5bxUV7mfTDE
	 nDQp3VOWoWXJZAZqZqfmp2EeoQVqJHv4Io0Kej+83LS8LQ1uAlGGue/ifny1KLh/2Aosp
	 pFGbTi8P71SWiTkULpQMHtA2pk4jZxK/cZigqp3hZ0ssTlB2Gjh8p8uuc/56iMdllRRut
	 DFuD5yF3SR3YRXXG7tYFEe5KC+3p7FZGGGfz0sABLRzCmy0/W70hcqlsoG4esoN1O6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Baz3ktT4;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C72606A325
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 23:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10C72606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Baz3ktT4
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-89f84753b43so306770b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 16:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793142941; x=1793747741; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BYIEV2ZaeDBaHLS1knK02+j6d4YqzE4mGsYZjVYzkjE=;
        b=Baz3ktT4Ft1sjxgDyxwDGIWZdx13vcOdB4s+J/q2lzrcykhdnOVyCtNOKRhcVe7OUX
         lar/aL2QccaDcJ8+oGlATVZ8L1VyvZgVALdVBHvQI83jrCUIbjyjeQkpEwj0w6i4Oa4y
         G96coBpXowVbffExz951wabWryCXOsXjsxzAAL1mQB2xONPDsSVCaajDVvGc31dzq0LS
         Tfxa9Jzm+Ed9kj+CxoWWlN2b046F3ZyB/7atgNq/Z4d935zD7DVlHirkT1I+MQnerwxD
         AO72RY4vGDkeMf/OWFVLS6b9jQBOScQeRi8sp5/njSHTzZxvaeyn8RIXqk2RaKSr8pcb
         St9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142941; x=1793747741;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BYIEV2ZaeDBaHLS1knK02+j6d4YqzE4mGsYZjVYzkjE=;
        b=lPrhAPgozfDVjzuk9Ssr63czEnmSVcnZRg31MRH+QivVZw2p/caYPRx5nVyYn35Ear
         9KFTY4yg6ImN548WDp8szgOXt04g3EAqYLtMiXEdOcGQPI8rmFVG5T7VPMwAHvd0nFav
         7oM5nvQXhrKsjY++85+eet3nDUug6A47W7Ig052dLw6tkzNdk7OBJR/qSXrE+2DS7CW8
         TKDUy1yOBie+/K79nMXpLLtsD/+kWnGakSIHDoA+dv/saRU7Ef736Vu7SdLYayKhL8tM
         eWY2Uvb0HZX4gy2lNY9MFIbSfNY2YDbsw0UlAC4YnvgVistLfw8xZ6IJqtng72KDEJYV
         dfGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzgz6UK1A8t13v9TXPKl1++4ESjMRNwPX3bhTFbo+11Tko9qEHlz5+ysqXB5eA6Cu0+V/GfD7M4K6hgAJztrSRy@vger.kernel.org
X-Gm-Message-State: AFq9FYIAciVXrRgsXr6LIiEDP/HrLVz+6Ty55TthI5QFlsoZbhP4BVOo
	Ok9EJy4F3QdYzj4uvbIn7BVe8lGDQWh7PuEUpqTgLL/7G8c2kucJrDc+nQ6WtlPwQTyrrEAKZe9
	f1myX+NcKYQ==
X-Received: from pfbfh4.prod.google.com ([2002:a05:6a00:3904:b0:891:74f:5b6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f92:b0:88d:3f61:20f3
 with SMTP id d2e1a72fcca58-8a6e83ac923mr482834b3a.54.1793142941136; Tue, 27
 Oct 2026 16:15:41 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:15:03 -0700
In-Reply-To: <20261027231513.816148-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <20261027231513.816148-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027231513.816148-10-irogers@google.com>
Subject: [PATCH v2 09/18] perf symbol: Optimize symbol sorting with
 natural-run merge sort and binary insertion
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, haghdoost@uber.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
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
 tools/perf/util/symbol.c | 434 ++++++++++++++++++++++++++++++++++++---
 tools/perf/util/symbol.h |   5 +
 2 files changed, 405 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b2c0a606b13a..7f1fcd5c64b2 100644
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
@@ -234,6 +235,7 @@ static void symbols__delete_locked(struct symbols *symbols)
 	zfree(&symbols->symbols);
 	zfree(&symbols->symbols_by_name);
 	symbols->cnt = 0;
+	symbols->sorted_cnt = 0;
 	symbols->allocated = 0;
 	symbols->num_by_name = 0;
 	symbols->sorted = true;
@@ -266,27 +268,312 @@ static inline bool symbol__less_or_equal(const struct symbol *a, const struct sy
 	return symbol__end(a) <= symbol__end(b);
 }
 
+static unsigned int symbols__upper_bound(struct symbol **arr, unsigned int len,
+					 const struct symbol *sym)
+{
+	unsigned int low = 0, high = len;
+
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
+}
+
 static int symbols__sort_cmp(const void *vlhs, const void *vrhs)
 {
-	const struct symbol *lhs = *((const struct symbol **)vlhs);
-	const struct symbol *rhs = *((const struct symbol **)vrhs);
+	const struct symbol *l = *((const struct symbol **)vlhs);
+	const struct symbol *r = *((const struct symbol **)vrhs);
 
-	if (symbol__start(lhs) != symbol__start(rhs))
-		return symbol__start(lhs) < symbol__start(rhs) ? -1 : 1;
-	if (symbol__end(lhs) != symbol__end(rhs))
-		return symbol__end(lhs) < symbol__end(rhs) ? -1 : 1;
+	if (symbol__start(l) != symbol__start(r))
+		return symbol__start(l) < symbol__start(r) ? -1 : 1;
+	if (symbol__end(l) != symbol__end(r))
+		return symbol__end(l) < symbol__end(r) ? -1 : 1;
 	return 0;
 }
 
 static void symbols__sort_locked(struct symbols *symbols)
 {
-	if (symbols->sorted)
+	unsigned int m = symbols->sorted_cnt;
+	unsigned int k;
+
+	if (symbols->sorted) {
+		symbols->sorted_cnt = symbols->cnt;
 		return;
+	}
+
+	if (m > symbols->cnt)
+		m = 0;
+	k = symbols->cnt - m;
 
-	if (symbols->cnt > 1) {
-		qsort(symbols->symbols, symbols->cnt, sizeof(struct symbol *),
-		      symbols__sort_cmp);
+	if (k == 0) {
+		symbols->sorted = true;
+		return;
 	}
+
+	/*
+	 * When only a few symbols have been appended since the last sort
+	 * (including single-symbol insertions), insert them directly at
+	 * their binary-searched sorted positions in O(N) without allocating.
+	 */
+	if (k <= 8 || symbols->cnt <= 64) {
+		for (unsigned int i = max(m, 1U); i < symbols->cnt; i++) {
+			struct symbol *sym = symbols->symbols[i];
+
+			if (!symbol__less_or_equal(symbols->symbols[i - 1], sym)) {
+				unsigned int pos = symbols__upper_bound(symbols->symbols, i, sym);
+
+				memmove(&symbols->symbols[pos + 1], &symbols->symbols[pos],
+					(i - pos) * sizeof(struct symbol *));
+				symbols->symbols[pos] = sym;
+			}
+		}
+		symbols->sorted_cnt = symbols->cnt;
+		symbols->sorted = true;
+		return;
+	}
+
+	if (m <= 1) {
+		struct symbol **tmp = malloc(((symbols->cnt + 1) / 2) * sizeof(struct symbol *));
+
+		if (tmp) {
+			symbols__sort_range_with_tmp(symbols->symbols, symbols->cnt, tmp);
+			free(tmp);
+		} else {
+			qsort(symbols->symbols, symbols->cnt, sizeof(struct symbol *),
+			      symbols__sort_cmp);
+		}
+	} else {
+		struct symbol **tmp = malloc(k * sizeof(struct symbol *));
+
+		if (tmp) {
+			symbols__sort_range_with_tmp(&symbols->symbols[m], k, tmp);
+			symbols__merge_runs(symbols->symbols, 0, m, symbols->cnt, tmp);
+			free(tmp);
+		} else {
+			qsort(symbols->symbols, symbols->cnt, sizeof(struct symbol *),
+			      symbols__sort_cmp);
+		}
+	}
+
+	symbols->sorted_cnt = symbols->cnt;
 	symbols->sorted = true;
 }
 
@@ -347,6 +634,7 @@ void symbols__fixup_duplicate(struct symbols *symbols)
 		}
 	}
 	symbols->cnt = write_idx + 1;
+	symbols->sorted_cnt = symbols->cnt;
 	zfree(&symbols->symbols_by_name);
 	symbols->num_by_name = 0;
 	symbols->sorted_by_name = false;
@@ -388,40 +676,62 @@ void symbols__fixup_end(struct symbols *symbols, bool is_kallsyms)
 		 * like in:
 		 *   ffffffffc1937000 T hdmi_driver_init  [snd_hda_codec_hdmi]
 		 */
-		if (symbol__end(prev) == symbol__start(prev)) {
+		if (symbol__end(prev) == symbol__start(prev) &&
+		    symbol__start(prev) != symbol__start(curr)) {
 			const char *prev_mod;
 			const char *curr_mod;
 
 			if (!is_kallsyms) {
 				symbol__set_end(prev, symbol__start(curr));
-				continue;
-			}
+			} else {
+				prev_mod = strchr(symbol__name(prev), '[');
+				curr_mod = strchr(symbol__name(curr), '[');
+
+				/* Last kernel/module symbol mapped to end of page */
+				if (!prev_mod != !curr_mod) {
+					symbol__set_end(prev,
+							roundup(symbol__end(prev) + 4096, 4096));
+				/* Last symbol in the previous module */
+				} else if (prev_mod && strcmp(prev_mod, curr_mod)) {
+					symbol__set_end(prev,
+							roundup(symbol__end(prev) + 4096, 4096));
+				} else {
+					symbol__set_end(prev, symbol__start(curr));
+				}
 
-			prev_mod = strchr(symbol__name(prev), '[');
-			curr_mod = strchr(symbol__name(curr), '[');
+				/* The next module can start within that page */
+				if (symbol__end(prev) > symbol__start(curr))
+					symbol__set_end(prev, symbol__start(curr));
 
-			/* Last kernel/module symbol mapped to end of page */
-			if (!prev_mod != !curr_mod)
-				symbol__set_end(prev, roundup(symbol__end(prev) + 4096, 4096));
-			/* Last symbol in the previous module */
-			else if (prev_mod && strcmp(prev_mod, curr_mod))
-				symbol__set_end(prev, roundup(symbol__end(prev) + 4096, 4096));
-			else
-				symbol__set_end(prev, symbol__start(curr));
+				pr_debug4("%s sym:%s end:%#" PRIx64 "\n",
+					  __func__, symbol__name(prev), symbol__end(prev));
+			}
 
-			/* The next module can start within that page */
-			if (symbol__end(prev) > symbol__start(curr))
-				symbol__set_end(prev, symbol__start(curr));
+			for (unsigned int k = i - 1; k > 0; k--) {
+				struct symbol *same = symbols->symbols[k - 1];
 
-			pr_debug4("%s sym:%s end:%#" PRIx64 "\n",
-				  __func__, symbol__name(prev), symbol__end(prev));
+				if (symbol__start(same) != symbol__start(prev) ||
+				    symbol__end(same) != symbol__start(same))
+					break;
+				symbol__set_end(same, symbol__end(prev));
+			}
 		}
 	}
 
 	/* Last entry */
-	if (symbol__end(curr) == symbol__start(curr))
+	if (symbol__end(curr) == symbol__start(curr)) {
 		symbol__set_end(curr, roundup(symbol__start(curr), 4096) + 4096);
 
+		for (unsigned int k = symbols->cnt - 1; k > 0; k--) {
+			struct symbol *same = symbols->symbols[k - 1];
+
+			if (symbol__start(same) != symbol__start(curr) ||
+			    symbol__end(same) != symbol__start(same))
+				break;
+			symbol__set_end(same, symbol__end(curr));
+		}
+	}
+
 	up_write(&symbols->lock);
 }
 
@@ -535,9 +845,13 @@ static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
 		symbols->allocated = to_allocate;
 	}
 
-	if (symbols->sorted && symbols->cnt > 0 &&
-	    !symbol__less_or_equal(symbols->symbols[symbols->cnt - 1], sym))
-		symbols->sorted = false;
+	if (symbols->sorted) {
+		if (symbols->cnt == 0 ||
+		    symbol__less_or_equal(symbols->symbols[symbols->cnt - 1], sym))
+			symbols->sorted_cnt = symbols->cnt + 1;
+		else
+			symbols->sorted = false;
+	}
 
 	symbols->symbols[symbols->cnt++] = sym;
 	zfree(&symbols->symbols_by_name);
@@ -546,6 +860,44 @@ static int __symbols__insert(struct symbols *symbols, struct symbol *sym)
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
+			symbol__put(sym);
+			return -ENOMEM;
+		}
+		symbols->symbols = temp;
+		symbols->allocated = to_allocate;
+	}
+
+	if (symbols->cnt == 0 ||
+	    symbol__less_or_equal(symbols->symbols[symbols->cnt - 1], sym)) {
+		idx = symbols->cnt;
+	} else {
+		idx = symbols__upper_bound(symbols->symbols, symbols->cnt, sym);
+		memmove(&symbols->symbols[idx + 1], &symbols->symbols[idx],
+			(symbols->cnt - idx) * sizeof(struct symbol *));
+	}
+
+	symbols->symbols[idx] = sym;
+	symbols->cnt++;
+	symbols->sorted_cnt = symbols->cnt;
+	zfree(&symbols->symbols_by_name);
+	symbols->num_by_name = 0;
+	symbols->sorted_by_name = false;
+	return 0;
+}
+
 int symbols__insert(struct symbols *symbols, struct symbol *sym)
 {
 	int ret;
@@ -712,7 +1064,13 @@ static struct symbol *symbols__find_by_name(struct symbol *symbols[],
 
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
@@ -720,13 +1078,16 @@ void dso__delete_symbol(struct dso *dso, struct symbol *sym)
 	struct symbols *symbols = dso__symbols(dso);
 
 	down_write(&symbols->lock);
-	for (unsigned int i = 0; i < symbols->cnt; i++) {
+	for (unsigned int i = symbols->cnt; i-- > 0; ) {
 		if (RC_CHK_EQUAL(symbols->symbols[i], sym)) {
 			struct symbol *old = symbols->symbols[i];
 
 			memmove(&symbols->symbols[i], &symbols->symbols[i + 1],
 				(symbols->cnt - i - 1) * sizeof(struct symbol *));
 			symbols->cnt--;
+			if (i < symbols->sorted_cnt)
+				symbols->sorted_cnt--;
+			symbols->sorted = (symbols->sorted_cnt == symbols->cnt);
 			zfree(&symbols->symbols_by_name);
 			symbols->num_by_name = 0;
 			symbols->sorted_by_name = false;
@@ -1082,6 +1443,7 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	old_cnt = root->cnt;
 	root->symbols = NULL;
 	root->cnt = 0;
+	root->sorted_cnt = 0;
 	root->allocated = 0;
 	root->sorted = true;
 	zfree(&root->symbols_by_name);
@@ -1159,6 +1521,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	old_allocated = root->allocated;
 	root->symbols = NULL;
 	root->cnt = 0;
+	root->sorted_cnt = 0;
 	root->allocated = 0;
 	root->sorted = true;
 	zfree(&root->symbols_by_name);
@@ -1305,6 +1668,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	if (root->cnt == 0) {
 		root->symbols = old_symbols;
 		root->cnt = write_idx;
+		root->sorted_cnt = write_idx;
 		root->allocated = old_allocated;
 		root->sorted = true;
 		old_symbols = NULL;
@@ -1334,12 +1698,14 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
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
index b4e5fdf5c4d6..066697d8da8f 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -119,6 +119,11 @@ struct symbols {
 	struct symbol **symbols_by_name;
 	/** @cnt: Number of valid entries in @symbols. */
 	unsigned int cnt;
+	/**
+	 * @sorted_cnt: Number of leading entries in @symbols that are sorted
+	 * by address range. Equal to @cnt when @sorted is true.
+	 */
+	unsigned int sorted_cnt;
 	/** @allocated: Capacity (in entries) of the @symbols allocation. */
 	unsigned int allocated;
 	/** @num_by_name: Number of valid entries in @symbols_by_name. */
-- 
2.56.0.313.g2479322e68-goog

