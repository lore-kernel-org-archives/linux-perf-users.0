Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795323881;
	b=xPiNVAQoR6NFQO7tJO0ubJhSinOONcuhSAuf6kjvBH1k5ELGEuKFDL5ZRRcz6rJ46feR
	 RMi9Rx94UY6GgaFr5ajf5LM1luDJqVEOxiUgZvY1X7U9/VTV1mySHE0qFLoWX1EWndq6Y
	 2oaUe2ZetHfRNkviQr66Jghcqwp2B5GfpjQ8khs5a+r/qvQIdiNMcCFY7HmKSXbq33YuB
	 zvd7HnqrUSRYktuPXU5Mcw+6FCCm50QloYLJ6aNAEyC+N7tqjVx6cuEwFOJV3q83yzSaH
	 qZA1PSMhQQi9vJQC57tn5G0UAljIMtlUNvu7ZbEm7Y+1zi38retEumTdYPtOmeJaRpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795323881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=YA/OERqmNLnTYyBBgkFLaJldkLHIN3L3qyA39CDis04=;
	b=cn4twNYs1DsdbJsYB6z88RtBx8E1yz5JhZomnckUi2fD2yQ+8ropqAd2072jCQe5KBzK
	 bQcg520tWwGiJqc+/Heju6XF54mEcj1lhUg+Ae+SaJc2XQUuM8EL+EkRu3U3v+QW8hRVg
	 wUBFk6SK/DmO67DenNSUc0iR2RrlV3iF2lfa5w5PnctQ2GK7nAt8ZhReX+u9pOZyiwFSn
	 zh5yBx40SmJMzDVJ72gebvkgJAWQqguYdXs0V9erZh4ZAQRABJ/MRsOCHoSpexTK7sXwR
	 lpgcJaSZMn6mTVankX6XD6/kmRzPuZZc2OdLIfy6oaashogb1hG+ISycVHuP8sGx5ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bmNCjR9P;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C1606A336
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 05:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 053C1606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bmNCjR9P
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1383723dfddso2245995c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 21:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795323880; x=1795928680; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YA/OERqmNLnTYyBBgkFLaJldkLHIN3L3qyA39CDis04=;
        b=bmNCjR9P7eFLYmbijQuAtpzMbIdQPEygRKZsHolwxoMpBhIXLytQCR3X9gkRBzo5Ws
         3zpzLS96aevVMmUTGklNHAd7c+fQfmmW+6AYVKrF9wpjDr5DUqJennsVi7CRquUEoE0T
         9L/+NzXgoVKjnuDXLSPPN4KjB96mlN5/aY/L3DI6OOGAqEVPgay10fq0YSHIPz0Md38S
         IAH4/fmhgygUo5WTEi2AhaRgPvFDkPOc6yYNZQzGGK3YCqk40DJRt2fnG0STEHMcyia3
         PRycrTFzz+XUKOE9Keab3mojRv8M38eITfuAoUCOroeIKK3NjrCocHgmDrH6XRXF98II
         r6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795323880; x=1795928680;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YA/OERqmNLnTYyBBgkFLaJldkLHIN3L3qyA39CDis04=;
        b=oTG/lKfjE70I7sI9PVlwh3+yU39aAGl/bsvrsUTMMeh9dFsBAlOKIk83ldU6NSSiKy
         sE9QkL5pPBUNgIK7khvJu953x0P7icmt5rsRluvSoTomKQqUCR1CmZkvJBh/QhrW+sMX
         d/HMKvqHx0myUnhRTtakaX7ScpSyZpyIqCTQkKN1ih85CPR5SmKiyFxlYGEhJrDMIiPu
         UCJJBxmkBB+qGutV2z+9llfuc6p/7zOVW4GyuOO43ozATHvSukF6cjW3bgcJrhI0RYci
         glZMTKAsKeycnxKPHyfI+pCmHWkTIiv/GuoDlW9FIefgVQDpNLKT0mdIHuiRmtjq1iNI
         uahg==
X-Forwarded-Encrypted: i=1; AL+hErHzKldFwy6EgXd+4LVBFKfNO+6JWD/PwHq5AfmLRJEzLihRHWoeNgbCz9f8jSNUYGgt0I/5RHqUeMlG6JTmJbqR@vger.kernel.org
X-Gm-Message-State: APuU4Z+xfr5B4fnuCq23kaqis3AqQUIYb2zc/mdBfS2BSlbbmYfbU5qd
	X59X9gLrQ/52cZK8z2pVLNZIDz6AAvCCITAY/SFdLaV+qN29+E9jOzUfz8FRo1aFHmYlc+5AoIv
	rvSFpQ7WXTQ==
X-Received: from dlag8.prod.google.com ([2002:a05:701b:2508:b0:1b5:33c5:1c03])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3b8e:b0:1b5:10cf:c402
 with SMTP id a92af1059eb24-1b5568a17d9mr8661709c88.10.1795323879580; Sat, 21
 Nov 2026 21:04:39 -0800 (PST)
Date: Sat, 21 Nov 2026 21:04:01 -0800
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
Message-ID: <20261122050405.80335-7-irogers@google.com>
Subject: [PATCH v8 06/10] perf symbol: Replace qsort() with natural-run merge sort
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ELF .symtab and .dynsym sections are typically already mostly ordered by
address in ascending runs. Invoking full-array qsort() across pre-ordered
ELF runs spends avoidable CPU time in symbol comparisons and does not
guarantee relative order preservation for equal-start symbol aliases
across C library implementations.

Replace qsort() in symbols__sort_locked() with a stable natural-run merge
sort (symbols__sort_range_with_tmp() and symbols__merge_runs()), falling
back to in-place binary insertion sort (symbols__insertion_sort_range())
for small arrays (cnt <= 64) or on scratch-buffer allocation failure.

Using 'perf bench internals symbols':

  Before:
    Average DSO load + sort: 6.242 msec (+- 0.057 msec)
    Average bulk insert + lookup: 1404.150 usec (+- 18.752 usec)
  After (-7.0% load, -13.9% bulk):
    Average DSO load + sort: 5.808 msec (+- 0.047 msec)
    Average bulk insert + lookup: 1209.250 usec (+- 18.446 usec)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.c | 183 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 174 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 43347c9a3a0c..35b08c05a2fd 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -265,14 +265,171 @@ static inline bool symbol__less_or_equal(const struct symbol *a, const struct sy
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
+	unsigned int first_left, left_len, right_len;
+	unsigned int i, j, dst;
+
+	if (left >= mid || mid >= right)
+		return;
+	if (symbol__less_or_equal(arr[mid - 1], arr[mid]))
+		return;
+
+	first_left = left + symbols__upper_bound(&arr[left], mid - left, arr[mid]);
+	left_len = mid - first_left;
+	right_len = right - mid;
+
+	if (left_len <= right_len) {
+		memcpy(tmp, &arr[first_left], left_len * sizeof(struct symbol *));
+		i = 0;
+		j = mid;
+		dst = first_left;
+		while (i < left_len && j < right) {
+			if (symbol__less_or_equal(tmp[i], arr[j]))
+				arr[dst++] = tmp[i++];
+			else
+				arr[dst++] = arr[j++];
+		}
+		if (i < left_len)
+			memcpy(&arr[dst], &tmp[i], (left_len - i) * sizeof(struct symbol *));
+	} else {
+		memcpy(tmp, &arr[mid], right_len * sizeof(struct symbol *));
+		i = mid;
+		j = right_len;
+		dst = right;
+		while (i > first_left && j > 0) {
+			if (symbol__less_or_equal(arr[i - 1], tmp[j - 1]))
+				arr[--dst] = tmp[--j];
+			else
+				arr[--dst] = arr[--i];
+		}
+		if (j > 0)
+			memcpy(&arr[first_left], tmp, j * sizeof(struct symbol *));
+	}
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
@@ -281,9 +438,17 @@ static void symbols__sort_locked(struct symbols *symbols)
 	if (symbols->sorted)
 		return;
 
-	if (symbols->cnt > 1) {
-		qsort(symbols->symbols, symbols->cnt, sizeof(struct symbol *),
-		      symbols__sort_cmp);
+	if (symbols->cnt <= 64) {
+		symbols__insertion_sort_range(symbols->symbols, 0, symbols->cnt);
+	} else {
+		struct symbol **tmp = malloc(((symbols->cnt + 1) / 2) * sizeof(struct symbol *));
+
+		if (tmp) {
+			symbols__sort_range_with_tmp(symbols->symbols, symbols->cnt, tmp);
+			free(tmp);
+		} else {
+			symbols__insertion_sort_range(symbols->symbols, 0, symbols->cnt);
+		}
 	}
 	symbols->sorted = true;
 }
-- 
2.56.1.750.gf70dc682cf-goog

