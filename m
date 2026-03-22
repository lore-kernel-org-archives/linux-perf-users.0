Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3502E366DC1
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Mar 2026 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774141125; cv=none; b=D5L6w1r2i8oeiLu8HRckXvpe6OUcuyBOaZ2d8t8j47k59m4OdC/J8dxOvnMJ1pc0tpUVst+RrEaWThU2U8xDXcIQeL9uWzadQNMWfN/PimtELV2vVCDnOiwiDkJ9dQLRceBFzgzoNdgrIJvd1RaF9fH+LyanzaBcDTdWW24pm7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774141125; c=relaxed/simple;
	bh=oQAkcuOFIgliDB2fbpjYZzVDb5j+cfsOBBoc+A7NyIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=afXSeEs6s3bWQm+xJMy9Xs6tNHecg3xvGUU3iDEnJb0PtPPeit0hWDzyvIgSciTVW1QtwAoxjoFnMFmcHz8RG0o4f4N5UcgLt4T1zHTypm2wrlMx/YsDNSFZelDl6uo4ox4+/oMjYM8BiviEupztPF8vch+V34g8cqJdteN71us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZSPAJ61R; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZSPAJ61R"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so2502136eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 17:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774141123; x=1774745923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=geGlWvya86jMnp6cvNdHPZH2HS7OrsgObVOuTyCYnPA=;
        b=ZSPAJ61R4rOZhGhLZgF9Y9IwVcy1laf9dYmG59oQ7etV3yMYAxl/mRTwRg6vlutdHt
         PyeqsyESJEVgc+4Lbdowmh1NcErgdyeOVr9rOPhwYspLg6f4wz9DiYvam5LjMq/oQV0B
         BAU/EhAKtBYgS4X5dSblc4OyWxgT3+4beifgXLsHlzBI2qFG7w55y0i44auNmreGJio3
         4A62Bsyr1H1iGicwVtNCNI564IBv/gfblnPZoQH3dTtgJ6ziFiCydgoHmvTFvGwlJ6Gr
         jaF99VLEOPsolNfvew98MuGGx756j0NYvCn6uaaQMjNEpl4B4ZYYcatCiIvGqgnE1EM2
         q6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774141123; x=1774745923;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=geGlWvya86jMnp6cvNdHPZH2HS7OrsgObVOuTyCYnPA=;
        b=hdAwCheV9SwA39X8f9QQ2mT+yQBHVLneHd7eb3B5SwpzaxHoSjWKbbCQrslB7n0l8u
         hTl1aVETGdYF+GdPR7ICBVXB+gq8n48QaJTWJOc16lk7WQeQ9K7tqi1jz3truSJRzNig
         l3MgAMoS9gc8Coe4S+PDkjYn8EYHjyBGNInJCD1D03iLUpW0Mv56McMtRObIywQLYGvq
         KimgX/0xhuSXKW9lD+ocikfWbFpJPK9mc0tjiSbPxjI/TkQpimAZN9Ux/pyt3W4jv8Hq
         kqGh7Yg/D6ObP56976nFJS4F1OPFi5zjS6JF5ZU2T8zo4QIX1L67BM7NXkzN1XVAkdDz
         E4aA==
X-Forwarded-Encrypted: i=1; AJvYcCXT2vZWFo1HO2o8GcHpqmyY8Qx8gsNMjZra4V7vDevCJo0ci8t5a/TgZLYarIFvy22PGmuCZtkggl1lNand76Id@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1QC9kcWmxa9w1vpZ4lCPR2bOXAEmPwj9Px1/KvkbApboUHUjC
	IdIFo8zQ/WIkNsvJswPsioeZF1t6xY/7S4eHER6ecUUli4WmkAaCrGZO3rEbvqeGI30yiCPV+gR
	45v2+t2RNZQ==
X-Received: from dybms24.prod.google.com ([2002:a05:7300:d518:b0:2c1:7ca:ced1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e9cc:20b0:2c1:1588:55e3
 with SMTP id 5a478bee46e88-2c115885b4amr1886985eec.14.1774141123129; Sat, 21
 Mar 2026 17:58:43 -0700 (PDT)
Date: Sat, 21 Mar 2026 17:58:23 -0700
In-Reply-To: <20260322005823.981079-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fUsaORbZuCtUxFgzMT-Cn2jVDLYfcYGSkXC7TdtyfnatQ@mail.gmail.com>
 <20260322005823.981079-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260322005823.981079-5-irogers@google.com>
Subject: [PATCH v2 4/4] perf hashmap: Remove errptr usage from hashmap
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org
Cc: alexander.shishkin@linux.intel.com, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

The hashmap implementation in tools/perf/util was using ERR_PTR to
return errors from perf_hashmap__new. This is non-standard for most of
the perf codebase which prefers NULL on error and setting errno. As
such it was a frequent source of bugs:
commit d05073adda0f ("perf trace: Avoid an ERR_PTR in syscall_stats")
commit 96f202eab813 ("perf trace: Fix IS_ERR() vs NULL check bug")
commit 9f3c16a430e8 ("perf expr: Fix return value of ids__new()")
commit 4d4d00dd321f ("perf tools: Update copy of libbpf's hashmap.c")

Remove the dependency on linux/err.h in hashmap.c. Update
perf_hashmap__new to set errno = ENOMEM and return NULL on failure.
Update perf_hashmap__free to check for NULL instead of using
IS_ERR_OR_NULL.

Update all callers of perf_hashmap__new to check for NULL. In places
where IS_ERR_OR_NULL was used on hashmap pointers, switch to regular
NULL checks.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c        |  2 +-
 tools/perf/ui/browsers/annotate.c |  4 ++--
 tools/perf/util/expr.c            |  4 ++--
 tools/perf/util/fncache.c         | 10 +++++++---
 tools/perf/util/hashmap.c         |  9 +++++----
 tools/perf/util/pmu.c             |  6 ++++++
 tools/perf/util/s390-sample-raw.c |  2 +-
 tools/perf/util/stat.c            |  2 +-
 8 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 88b2fac16457..7b186c32cb0d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1566,7 +1566,7 @@ static struct perf_hashmap *alloc_syscall_stats(void)
 {
 	struct perf_hashmap *result = perf_hashmap__new(syscall_id_hash, syscall_id_equal, NULL);
 
-	return IS_ERR(result) ? NULL : result;
+	return result;
 }
 
 static void delete_syscall_stats(struct perf_hashmap *syscall_stats)
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index c61415295dda..5c0656421084 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -143,7 +143,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	if (!browser->navkeypressed)
 		ops.width += 1;
 
-	if (!IS_ERR_OR_NULL(ab->type_hash))
+	if (ab->type_hash)
 		apd.type_hash = ab->type_hash;
 
 	annotation_line__write(al, notes, &ops, &apd);
@@ -1248,7 +1248,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 
 	debuginfo__delete(browser.dbg);
 
-	if (!IS_ERR_OR_NULL(browser.type_hash)) {
+	if (browser.type_hash) {
 		struct perf_hashmap_entry *cur;
 		size_t bkt;
 
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index dc10c335e378..f96812bae318 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -68,7 +68,7 @@ struct perf_hashmap *ids__new(void)
 	struct perf_hashmap *hash;
 
 	hash = perf_hashmap__new(key_hash, key_equal, NULL);
-	if (IS_ERR(hash))
+	if (!hash)
 		return NULL;
 	return hash;
 }
@@ -296,7 +296,7 @@ struct expr_parse_ctx *expr__ctx_new(void)
 		return NULL;
 
 	ctx->ids = perf_hashmap__new(key_hash, key_equal, NULL);
-	if (IS_ERR(ctx->ids)) {
+	if (!ctx->ids) {
 		free(ctx);
 		return NULL;
 	}
diff --git a/tools/perf/util/fncache.c b/tools/perf/util/fncache.c
index 9c49a914e784..0970b0bbd1d5 100644
--- a/tools/perf/util/fncache.c
+++ b/tools/perf/util/fncache.c
@@ -36,9 +36,10 @@ static struct perf_hashmap *fncache__get(void)
 
 static bool lookup_fncache(const char *name, bool *res)
 {
+	struct perf_hashmap *map = fncache__get();
 	long val;
 
-	if (!perf_hashmap__find(fncache__get(), name, &val))
+	if (!map || !perf_hashmap__find(map, name, &val))
 		return false;
 
 	*res = (val != 0);
@@ -47,11 +48,14 @@ static bool lookup_fncache(const char *name, bool *res)
 
 static void update_fncache(const char *name, bool res)
 {
+	struct perf_hashmap *map = fncache__get();
 	char *old_key = NULL, *key = strdup(name);
 
-	if (key) {
-		perf_hashmap__set(fncache__get(), key, res, &old_key, /*old_value*/NULL);
+	if (map && key) {
+		perf_hashmap__set(map, key, res, &old_key, /*old_value*/NULL);
 		free(old_key);
+	} else {
+		free(key);
 	}
 }
 
diff --git a/tools/perf/util/hashmap.c b/tools/perf/util/hashmap.c
index d90ef4ed384d..147e011a547f 100644
--- a/tools/perf/util/hashmap.c
+++ b/tools/perf/util/hashmap.c
@@ -10,7 +10,6 @@
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
-#include <linux/err.h>
 #include "hashmap.h"
 
 /* make sure libbpf doesn't use kernel-only integer typedefs */
@@ -55,8 +54,10 @@ struct perf_hashmap *perf_hashmap__new(perf_hashmap_hash_fn hash_fn,
 {
 	struct perf_hashmap *map = malloc(sizeof(struct perf_hashmap));
 
-	if (!map)
-		return ERR_PTR(-ENOMEM);
+	if (!map) {
+		errno = ENOMEM;
+		return NULL;
+	}
 	perf_hashmap__init(map, hash_fn, equal_fn, ctx);
 	return map;
 }
@@ -76,7 +77,7 @@ void perf_hashmap__clear(struct perf_hashmap *map)
 
 void perf_hashmap__free(struct perf_hashmap *map)
 {
-	if (IS_ERR_OR_NULL(map))
+	if (!map)
 		return;
 
 	perf_hashmap__clear(map);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ace354b23501..01a7c0098797 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1305,6 +1305,12 @@ struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pm
 
 	INIT_LIST_HEAD(&pmu->format);
 	pmu->aliases = perf_hashmap__new(aliases__hash, aliases__equal, /*ctx=*/ NULL);
+	if (!pmu->aliases) {
+		perf_cpu_map__put(pmu->cpus);
+		free((char *)pmu->name);
+		free(pmu);
+		return NULL;
+	}
 	INIT_LIST_HEAD(&pmu->caps);
 	list_add_tail(&pmu->list, core_pmus);
 	return pmu;
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 80a5535089e0..52ab84e53173 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -201,7 +201,7 @@ static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
 						   get_counter_name_perf_hashmap_equal_fn,
 						   /*ctx=*/NULL);
 
-		if (!IS_ERR(tmp)) {
+		if (tmp) {
 			cache = tmp;
 			cache_pmu = pmu;
 		}
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 81b266c5d4f5..1359a1f81562 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -320,7 +320,7 @@ static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
 
 	if (!mask) {
 		mask = perf_hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
-		if (IS_ERR(mask))
+		if (!mask)
 			return -ENOMEM;
 
 		counter->per_pkg_mask = mask;
-- 
2.53.0.959.g497ff81fa9-goog

