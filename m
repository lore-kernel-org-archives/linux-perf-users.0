Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245453;
	b=ESmz+FmNjsH18yejEj7Cm3zt9qXuWBxEqIBHDDL91O+9n70r3zDCgX4IFdD/j7RJ4s5b
	 EnY24e9chE64Vf5W84w6EBT9YYTpPToUeOkW214BtA3Hb1r5+xXAWyoc4DsC1fro/Z3QC
	 gvwoYo085c9EjMPfxK5V3Pq1RN9c/CE4GzU1T29WTcJzTVWEYTcPJvLl6YOiWXX7Ma95/
	 +9s7qVO2PnTaeKGzNnSn01e3/4e50cO2yoNpoHz1oxLKeio+zJWsVO959NtSBeLlQJEQ2
	 x9xl2I0XCx06+Z6c0Vi3y/uaL+zdH+sg9i/SiE1kklJYxblpaXzMFDbP6GuudUPWX6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=MHlNyxo+mafQ5vFC1JiNOwKYJbzxb2VMwl/G1pzxtY4=;
	b=s4b+otFsr1Ec1ZWr+2kpC80rCD5VEmVmaaPwx1SDTOyhV2Oa1gmJeknVecGI1ZtSaTVm
	 tOq/M+Er0qMfffwNeeOQdEPTTph7nlubcct5/Yj+ATwp3ki9LP+NYSem9zbCzLFsWrM0T
	 El8E9LZBISAtZqMuB49fkV4W/J6wL4EJZD7hPR427pdqk68O0C5xlvs+kKg96h67OfSd2
	 r8sK/IQ7hk5DlVkHwAZpu/4e5vn9Rvw8jALji7TS5o6Hr5rtvuwX95KlTUhIVK4+XoVoB
	 kLuCFmvKZktRHg5RePeyYmh8chCjPe2UGge1X3ZtS51GPrf73UvrAoelzdlCNB5c57A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BF2XwRn8;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E0A606A339
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 07:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6E0A606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BF2XwRn8
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b3b63b9665so1666015c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 23:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795245452; x=1795850252; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MHlNyxo+mafQ5vFC1JiNOwKYJbzxb2VMwl/G1pzxtY4=;
        b=BF2XwRn8Ppf3kZavS/Zy+efvXwHrhsbt5qLT7SG4Y3+XML3enH7Ob0VpMc8mQ+5xRq
         9thTTmxaA2eWShX6LTvlyhdRMCk0X07GQ4CVqPZTqu0FBIbeJSU9YSwggGOa5Jl+Amx9
         IH7Ndhm02E8QRi6hQeINEiDnkqVopKhmLvOVG4kf+z0pglBLCuTu4OiEgSkW1MO6i/aG
         JZUzXH/KAZdv3NrIhgUCdSgjSc77d0ip02+b1lkXaYmX3rxRSxanVjqdCdDHro7LINjz
         MLDSx9424zenax8hVbkDXBzVc7AWHDzy39M0VuAYRIHrgRER+GiY8QsbittknD1F7oXi
         BFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795245452; x=1795850252;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MHlNyxo+mafQ5vFC1JiNOwKYJbzxb2VMwl/G1pzxtY4=;
        b=W6O9mO9up1SlTr5YOeTnuzICCdhp61lilkfgg4nloNY6yUbQ22sFzLtnRKZNYyRrc9
         rrakCMMJDzvv/SvxwARspk0QtdPIzv9WglDwvQ4gWjL/0Rmjv3LbXaANlcj5t8JJOlaB
         FwW0qc+UMN7chUTr4wKk78wf1sOw364OfJWbL8GTwXtSgfCngNUPi3Zke7ltNklTmgNH
         DEUeo2yIe6Pu9wfOUfU4dlAPTTKSOdxhhMAwIWLxZq11lgnvLV3MPyxlKMCY5y9oar/n
         LjNYg7Gf9VaH36WAwZX/B8xbzro55Agf47wk+77vtg8XqaMf5hjXPVYh3dutw2pCaD+Q
         YC2g==
X-Forwarded-Encrypted: i=1; AL+hErEv971C1AL9rV+3kjJmCgnDXVZVadME1g5SBZ6q3LPBHONvN56y/EJTb7KZUvRzYgvecwb5CfnvcKdfBJtqVGTw@vger.kernel.org
X-Gm-Message-State: APuU4Z8/PfrkAbHnUhKT6mdJuEmjmQNWJWpPXuV+zPmjEUB2Yoe/os+z
	3Qd/hIXxLkvbqHwCjD7bJYwgapSsC4MreFADQEc8fVfrWZKnIZXrmQUlDDP7cCN4T52YaZzCrBe
	rU3cRQ0Svbg==
X-Received: from dyjz27.prod.google.com ([2002:a05:7300:b1b:b0:381:fb4c:34e1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b909:b0:1b4:f3af:355e
 with SMTP id a92af1059eb24-1b5568a660emr4864446c88.13.1795245451525; Fri, 20
 Nov 2026 23:17:31 -0800 (PST)
Date: Fri, 20 Nov 2026 23:16:47 -0800
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
Message-ID: <20261121071651.67118-7-irogers@google.com>
Subject: [PATCH v7 06/10] perf symbol: Replace qsort() with natural-run merge sort
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
index 4119e061e939..114fe5ea3891 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -263,14 +263,171 @@ static inline bool symbol__less_or_equal(const struct symbol *a, const struct sy
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
@@ -278,9 +435,17 @@ static void symbols__sort_locked(struct symbols *symbols)
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

