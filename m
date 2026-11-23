Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418420;
	b=m+kjLhync1oaMBk98dCPcp1magFIOZuvjvSWWiT3OCIun5QVtEF+Hnh6C6+trehsxDBj
	 qII0UzFbB8xGzhzDjzcm2miTjo9Ha+vXq4lO7DqC6qDczR53cOLwRYT7LkFm9ES3HO5L1
	 BpiFcANeZKxewJvtybdXbMLRLqnLRuWiVjMjuI0Oi/HgG3c0VWe6rGdWgiN9gDvDtq3+O
	 jRzi1s5BXkLZB3l0kjFWM1QeNesnuHCD3/oiisakfBaJboZ4/ZUq86fVBs/a6EmRiuZcb
	 wdgIEET432ICsoSttr4hwS3tI1F6HXXHxjNuxtc5ZBqQRB8QslDtLaFxUiGzxVyMVMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=MCOimdxXbQe2FArhB5kqVZlCGWrX/sfLuiT+1azFX3Y=;
	b=5cTu2GJ04zhFq1W+OPbnpTldU8cA+B50PGP1vZHkOl2sBHcwBtbvWBNSyd+G4pm9YpnH
	 PlRt73w3BgshkePKzzT7X+a4Z16c0c/Y/jI9jnNMYVVDb2hyIf38c+jxQnauGcb573DA3
	 jN8jtNMx/4eGzadfZdH2CIemFAyWjb956BqOX48OpIXaBN3AwnDRLV6wKXgwISiQewcj0
	 EqoTszqAC2TEK/ZDEtyvxEjZib3Tsw9f3BUBcRbQNkQ0PyUZ6BM0OJ3l096FARhaYhEes
	 VVayNGYJq/T7ltcb3dXV4zwbulPQe6t5Rd4x1WK4NNVnAUoS1KptE3CXFlhwCjWoKgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d1bEnGC+;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FA9606A321
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3FA9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d1bEnGC+
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3869accaac2so1485874eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 23:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795418419; x=1796023219; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCOimdxXbQe2FArhB5kqVZlCGWrX/sfLuiT+1azFX3Y=;
        b=d1bEnGC+jBAEK6M9Hn+38+0mZC8tU+2m50oXoYLtLiE5YthL4h333e8kfoFFSN7oE3
         4j+Bjzt2Szk3nmKv6cvOf7czyew2MsPCyRaJjaPowvaHRYsIv2YdnQ7J/EN0wvC+iQZt
         pHS2ZygZtzX8NXb+GSJp4rvnE/xBGkBd6FBprvgCc23g9+VGU8sLpjRiHZPBMBDtpDh3
         OWJ628DyjPD0i16A/EtSzgYe7kNR+8RAosBgE3icm1hOiOKV3Pe3jyMu4w6TfhBNvGrP
         M9CEiLQhoD8sC6efSs48LrW0F12twwut+DHEw8NlugUkXtR5SyfESDZPd7qvBuQfC0lZ
         p9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795418419; x=1796023219;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MCOimdxXbQe2FArhB5kqVZlCGWrX/sfLuiT+1azFX3Y=;
        b=yuen8i5wTGQToSyvUB809QnFOYdjKkb7uukfGLrxbv21M/RStvt8IYUldtrW8GgCiz
         ITe1BZpI47f1yedCjLDnboeGoqi1OH9xlFdmMIqCSEanaobFfspecse0G4xbGQDfARwl
         +xWmUYh5dxobw0Nha1mvuebdJx5x1FTbdGoTuzsv29Taen2ZNi0JCDi8ZcrC2coPxZgQ
         pxLVKT2SmqUmR+Q4jutlFAxefuCli7LmqHeeQRodyetr+SsoFdhjg5Y/sgzpECirIHup
         JKTbiH7AU+H7bsR2bHzPRrcEuh0pFPLhwfKSogJHBW33k6hou5srpi7sw9DBqAtYm3XO
         qELg==
X-Forwarded-Encrypted: i=1; AL+hErEyrQKLmHhbtuio7L59DmVgUyMzHPIDoqXD6oYsCq7KR1pjluD5MdHzJNAuWcuD4ixqaH4TI5Caz5C03feykLCv@vger.kernel.org
X-Gm-Message-State: APuU4Z92nc1F2X/oSeAg58e72BKvPgT770vDXaRLxb8+f5DSWGngNXLV
	2PIwe3IVjse/nrxaX6QYQG5b+RwHW7ewX81fbEpnU/6oyivpAUjmLJ1okaNqiMATg6wsSW1Ixoe
	Dd9Zty7yMKw==
X-Received: from dyr3.prod.google.com ([2002:a05:693c:4003:b0:370:f640:2508])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:d804:b0:386:b076:a940
 with SMTP id 5a478bee46e88-386b076a9e4mr2353190eec.26.1795418418870; Sun, 22
 Nov 2026 23:20:18 -0800 (PST)
Date: Sun, 22 Nov 2026 23:19:11 -0800
In-Reply-To: <20261123071913.653315-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123071913.653315-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123071913.653315-12-irogers@google.com>
Subject: [PATCH v1 11/13] perf bpf-filter: Copy bpf_filters in evsel__clone()
 and close on evsel__close()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Song Liu <songliubraving@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

evsel__clone() copies evsel->filter for tracepoint/hardware filters, but
left evsel->bpf_filters empty on cloned evsels. When --for-each-cgroup
clones template evsels per cgroup, the cloned evsels lost their parsed
BPF filter expressions and ran unfiltered. Add perf_bpf_filter__copy() to
deep-copy the BPF filter expression list (including OR-group children,
which perf_bpf_filter__destroy() also leaked).

In addition, separate runtime skeleton/pinned-map teardown into
perf_bpf_filter__close() (without freeing the parsed filter expressions
or another evsel's pinned_filters entries) and call it in evsel__close()
so repeated runs (such as 'perf stat -r N') release the closed FDs' BPF
filter state and attach cleanly on subsequent runs.

Fixes: 56ec9457a4a2 ("perf bpf filter: Implement event sample filtering")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-filter.c | 57 ++++++++++++++++++++++++++++++++++--
 tools/perf/util/bpf-filter.h | 10 +++++++
 tools/perf/util/evlist.c     |  2 ++
 tools/perf/util/evsel.c      |  4 +++
 4 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 506414e5c407..affb75e7ff85 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -515,6 +515,8 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		struct pinned_filter_idx *pfi, *tmp;
 
 		list_for_each_entry_safe(pfi, tmp, &pinned_filters, list) {
+			if (pfi->evsel != evsel)
+				continue;
 			destroy_idx_hash(pfi);
 			list_del(&pfi->list);
 			free(pfi);
@@ -524,22 +526,71 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	return ret;
 }
 
-int perf_bpf_filter__destroy(struct evsel *evsel)
+static void free_filter_expr_list(struct list_head *head)
 {
 	struct perf_bpf_filter_expr *expr, *tmp;
-	struct pinned_filter_idx *pfi, *pos;
+	struct perf_bpf_filter_expr *grp, *gtmp;
 
-	list_for_each_entry_safe(expr, tmp, &evsel->bpf_filters, list) {
+	list_for_each_entry_safe(expr, tmp, head, list) {
+		list_for_each_entry_safe(grp, gtmp, &expr->groups, list) {
+			list_del(&grp->list);
+			free(grp);
+		}
 		list_del(&expr->list);
 		free(expr);
 	}
+}
+
+int perf_bpf_filter__copy(struct list_head *dst, const struct list_head *src)
+{
+	const struct perf_bpf_filter_expr *expr, *grp;
+
+	list_for_each_entry(expr, src, list) {
+		struct perf_bpf_filter_expr *copy;
+
+		copy = perf_bpf_filter_expr__new(expr->term, expr->part,
+						 expr->op, expr->val);
+		if (!copy)
+			goto err;
+		list_add_tail(&copy->list, dst);
+
+		list_for_each_entry(grp, &expr->groups, list) {
+			struct perf_bpf_filter_expr *gcopy;
+
+			gcopy = perf_bpf_filter_expr__new(grp->term, grp->part,
+							  grp->op, grp->val);
+			if (!gcopy)
+				goto err;
+			list_add_tail(&gcopy->list, &copy->groups);
+		}
+	}
+	return 0;
+
+err:
+	free_filter_expr_list(dst);
+	return -ENOMEM;
+}
+
+void perf_bpf_filter__close(struct evsel *evsel)
+{
+	struct pinned_filter_idx *pfi, *pos;
+
 	sample_filter_bpf__destroy(evsel->bpf_skel);
+	evsel->bpf_skel = NULL;
 
 	list_for_each_entry_safe(pfi, pos, &pinned_filters, list) {
+		if (pfi->evsel != evsel)
+			continue;
 		destroy_idx_hash(pfi);
 		list_del(&pfi->list);
 		free(pfi);
 	}
+}
+
+int perf_bpf_filter__destroy(struct evsel *evsel)
+{
+	free_filter_expr_list(&evsel->bpf_filters);
+	perf_bpf_filter__close(evsel);
 	return 0;
 }
 
diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
index 818c554b91b2..cf016174bc5b 100644
--- a/tools/perf/util/bpf-filter.h
+++ b/tools/perf/util/bpf-filter.h
@@ -28,7 +28,9 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term
 						       enum perf_bpf_filter_op op,
 						       unsigned long val);
 int perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
+int perf_bpf_filter__copy(struct list_head *dst, const struct list_head *src);
 int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target);
+void perf_bpf_filter__close(struct evsel *evsel);
 int perf_bpf_filter__destroy(struct evsel *evsel);
 u64 perf_bpf_filter__lost_count(struct evsel *evsel);
 int perf_bpf_filter__pin(void);
@@ -45,11 +47,19 @@ static inline int perf_bpf_filter__parse(struct list_head *expr_head __maybe_unu
 		"\tPlease make sure to build with libbpf and BPF skeleton.\n");
 	return -EOPNOTSUPP;
 }
+static inline int perf_bpf_filter__copy(struct list_head *dst __maybe_unused,
+					const struct list_head *src __maybe_unused)
+{
+	return 0;
+}
 static inline int perf_bpf_filter__prepare(struct evsel *evsel __maybe_unused,
 					   struct target *target __maybe_unused)
 {
 	return -EOPNOTSUPP;
 }
+static inline void perf_bpf_filter__close(struct evsel *evsel __maybe_unused)
+{
+}
 static inline int perf_bpf_filter__destroy(struct evsel *evsel __maybe_unused)
 {
 	return -EOPNOTSUPP;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 638d501a7531..5bcb5d0905ea 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1708,6 +1708,8 @@ void evlist__close(struct evlist *evlist)
 	}
 
 	evlist__for_each_entry_reverse(evlist, evsel) {
+		if (!evsel__is_bpf(evsel))
+			perf_bpf_filter__close(evsel);
 		perf_evsel__free_fd(&evsel->core);
 		perf_evsel__free_id(&evsel->core);
 	}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index e0f3ca79c9cc..f36c9b746c84 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -581,6 +581,8 @@ struct evsel *evsel__clone(struct evsel *orig)
 		if (evsel->filter == NULL)
 			goto out_err;
 	}
+	if (perf_bpf_filter__copy(&evsel->bpf_filters, &orig->bpf_filters) < 0)
+		goto out_err;
 	if (orig->metric_id) {
 		evsel->metric_id = strdup(orig->metric_id);
 		if (evsel->metric_id == NULL)
@@ -3261,6 +3263,8 @@ void evsel__close(struct evsel *evsel)
 {
 	if (evsel__is_retire_lat(evsel))
 		evsel__tpebs_close(evsel);
+	if (!evsel__is_bpf(evsel))
+		perf_bpf_filter__close(evsel);
 	perf_evsel__close(&evsel->core);
 	perf_evsel__free_id(&evsel->core);
 }
-- 
2.56.1.750.gf70dc682cf-goog

