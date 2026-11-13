Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606572;
	b=gOI0LpPjkusFhQmmhDuwYRRle6gKqJS+vVxXqGiMk4stTnk56y+0FR3N49u8TBD0Y5cv
	 Xb/sSpnZl+H+RM3zLef1VY1s+/sbAMbxvwR13LP9nP4WG0nuJYo7KaM4hBs2w9zZumUgS
	 9W53brkGMVVGYPIxFiftAzGe905Y7CgB5JihPPcuAKdX56pYowjmB2vlp5RF1IyxATcnr
	 ME6pfQ1fw3Kn0JP1w8mWkM0rwiMnF9GnHz7BLdlCeM6HAxtPEEv7U7oeEmppvd+F3PDZk
	 dyqMoLjl4A+sjr5YYFiQ5UkhTrXmP19jdc2rPaw0PsMZ6uOJPfD4xqklMXDUe4c7V8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=3GSWwUU0ETufhKC04Psrd1+I4a+q+MpdPxmUtm2w1/g=;
	b=gwqkoIQ9ThIygAXgc1RQ8txxXgNq/rhmhIzGpRPorvlqBNATTEFS01HXynBqIu/IHFCF
	 WcRdGZ0u/WO74u76JRvCrtAezBw/BsQTfaaxD+AeF0+ME5O8fiSJOS6uZqtvIORdj5mzl
	 jZ6UQ53qgb3PIX2rl3onkGTQKHNjTUzzPhaGn2x9IUYfeiJ8kXOl7D975t+WnTb3auGBS
	 qLvml3w9tvhsre7HVr6hmIh7QVjQMCt3c2W62HqHLPeQNtSHQfaqKF7ILkaqZe6lJ2AoA
	 S3L1M/DDU7BupZ/HqQs9PDe03FEPbroukJx45br++TWUSGPkNLw42qcu2KKu20f9s4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AiBC0m1t;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274560A2605
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C274560A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AiBC0m1t
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdd9fa2a558so1604895a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606570; x=1795211370; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3GSWwUU0ETufhKC04Psrd1+I4a+q+MpdPxmUtm2w1/g=;
        b=AiBC0m1tqGW8/KkxzilJFj9VivOb4pYj0N4JkuL4xY53ZiIrrgG6OQM7Q3Z70SOMRV
         r/IoQchYm1p5d72MTJn4eFJXovEnR29tFSsWFVAABvpcn0hnAi9fZJrDq/+D6uuIO8sy
         cZAChl7ax3hxTA7YlP4PmTuy2ME7F+BiBKYASsNP9cke8GjrGqI+EtSAVgTQ4CdcGgZK
         krN4ySdLvxIOcSr5C1PA6ncs//8qCbOCDGj9V+csNWTSuFo8zIc6k/hR8GOPUYjmnz/D
         LBPybW0/9dtFsyHd879wH6mSXEB+K9u6wTT7GDo0Tb6zVbAuDjoiADxD0/eMyPYP4nvS
         HViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606570; x=1795211370;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3GSWwUU0ETufhKC04Psrd1+I4a+q+MpdPxmUtm2w1/g=;
        b=qAssUd7YMEzCSCAG1PKuE5fHV5MaV0X1yV2pemNEciMsXfx5R9uEZJL73AQ1p4R/Fx
         Nce1+wCamBKRKiR6+auN/l+LaI89HGlaqRCWrGmKRthwQRzhk48Df6yN/R8ZxIOlZZGk
         TguPVZ9eTZJIsEiUz4qLd324ajerBbH4hSWzoPk9a/jwH1UHZRd9facEuc5ax4z0qJrP
         k/spsKBhw36qYRF+cSswzj2TDdhuendonQOOW6WTcs+cHAWaer8bZQ2kLgu5LyPcfKIW
         93BkehL0OlxyANg+aLblOMAsFDrD7wrZf2bjBX6ZKI4MmKZOEE8iguyU8SYSoU2TViCG
         yaHQ==
X-Forwarded-Encrypted: i=1; AL+hErE6CWpsyC30Lj9Klk2/HPV+B/pLYTgEyFxWLZY69Hqi49VA6jk33Y25e8HY7J/ESRFkUHSMAOQeJAx1L7rz4VOw@vger.kernel.org
X-Gm-Message-State: APuU4Z9KiiHsC7iAY1XXaD88BHp1BEiiy6Q+mIyw3im8Bop3M8o0JBPh
	Y6JMFu55T+qpN+j2OMmAgFRh+ws55gMFsjeu3lDFsS53NBkFEmviGN485sQ27TMuYpSHYsh0/pk
	VSsZQgdGDhw==
X-Received: from pgbe12.prod.google.com ([2002:a63:500c:0:b0:cd6:aee6:763e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7490:b0:3dd:85a9:55a4
 with SMTP id adf61e73a8af0-3f7a72caa82mr3791353637.29.1794606569887; Fri, 13
 Nov 2026 13:49:29 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:31 -0800
In-Reply-To: <20261113214850.3329699-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113214850.3329699-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113214850.3329699-8-irogers@google.com>
Subject: [PATCH v1 07/26] perf hashmap: Remove errptr usage from hashmap
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The hashmap implementation in tools/perf/util was using ERR_PTR to
return errors from hashmap__new(). This is non-standard for most of
the perf codebase which prefers NULL on error and setting errno. As
such it was a frequent source of bugs:
commit d05073adda0f ("perf trace: Avoid an ERR_PTR in syscall_stats")
commit 96f202eab813 ("perf trace: Fix IS_ERR() vs NULL check bug")
commit 9f3c16a430e8 ("perf expr: Fix return value of ids__new()")
commit 4d4d00dd321f ("perf tools: Update copy of libbpf's hashmap.c")

Remove the dependency on linux/err.h in hashmap.c. Update
__hashmap__new() to set errno = ENOMEM and return NULL on failure, and
update __hashmap__free() to check for NULL instead of using
IS_ERR_OR_NULL().

Update all callers of hashmap__new() to check for NULL (including
missing failure checks in fncache and
perf_pmu__create_placeholder_core_pmu()), and switch IS_ERR_OR_NULL()
checks on hashmap pointers to regular NULL checks.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-ftrace.c       |  9 +--------
 tools/perf/builtin-trace.c        |  4 +---
 tools/perf/ui/browsers/annotate.c |  4 ++--
 tools/perf/util/annotate.c        |  4 +---
 tools/perf/util/expr.c            |  9 ++-------
 tools/perf/util/fncache.c         | 10 +++++++---
 tools/perf/util/hashmap.c         |  9 +++++----
 tools/perf/util/pmu.c             |  6 ++++++
 tools/perf/util/s390-sample-raw.c |  2 +-
 tools/perf/util/stat.c            |  2 +-
 10 files changed, 27 insertions(+), 32 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 7cdc9ae2fbbb..ac0107f5b891 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1229,14 +1229,7 @@ static int prepare_func_profile(struct perf_ftrace *ftrace)
 	ftrace->graph_verbose = 0;
 
 	ftrace->profile_hash = hashmap__new(profile_hash, profile_equal, NULL);
-	if (IS_ERR(ftrace->profile_hash)) {
-		int err = PTR_ERR(ftrace->profile_hash);
-
-		ftrace->profile_hash = NULL;
-		return err;
-	}
-
-	return 0;
+	return ftrace->profile_hash ? 0 : -ENOMEM;
 }
 
 /* This is saved in a hashmap keyed by the function name */
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4094141461f9..128efe1be8c3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1673,9 +1673,7 @@ static bool syscall_id_equal(long key1, long key2, void *ctx __maybe_unused)
 
 static struct hashmap *alloc_syscall_stats(void)
 {
-	struct hashmap *result = hashmap__new(syscall_id_hash, syscall_id_equal, NULL);
-
-	return IS_ERR(result) ? NULL : result;
+	return hashmap__new(syscall_id_hash, syscall_id_equal, NULL);
 }
 
 static void delete_syscall_stats(struct hashmap *syscall_stats)
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index cf36b5347f72..8b0c933caf2e 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -144,7 +144,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	if (!browser->navkeypressed)
 		ops.width += 1;
 
-	if (!IS_ERR_OR_NULL(ab->type_hash))
+	if (ab->type_hash)
 		apd.type_hash = ab->type_hash;
 
 	annotation_line__write(al, notes, &ops, &apd);
@@ -1264,7 +1264,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 
 	debuginfo__delete(browser.dbg);
 
-	if (!IS_ERR_OR_NULL(browser.type_hash)) {
+	if (browser.type_hash) {
 		struct hashmap_entry *cur;
 		size_t bkt;
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9af1d6b72da9..d11add6424dc 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -137,10 +137,8 @@ static int annotated_source__alloc_histograms(struct annotated_source *src,
 		return -1;
 
 	src->samples = hashmap__new(sym_hist_hash, sym_hist_equal, NULL);
-	if (IS_ERR(src->samples)) {
+	if (!src->samples)
 		zfree(&src->histograms);
-		src->samples = NULL;
-	}
 
 	return src->histograms ? 0 : -1;
 }
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index f1164c4666b1..ac0243576def 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -66,12 +66,7 @@ static bool key_equal(long key1, long key2, void *ctx __maybe_unused)
 
 struct hashmap *ids__new(void)
 {
-	struct hashmap *hash;
-
-	hash = hashmap__new(key_hash, key_equal, NULL);
-	if (IS_ERR(hash))
-		return NULL;
-	return hash;
+	return hashmap__new(key_hash, key_equal, NULL);
 }
 
 void ids__free(struct hashmap *ids)
@@ -306,7 +301,7 @@ struct expr_parse_ctx *expr__ctx_new(void)
 		return NULL;
 
 	ctx->ids = hashmap__new(key_hash, key_equal, NULL);
-	if (IS_ERR(ctx->ids)) {
+	if (!ctx->ids) {
 		free(ctx);
 		return NULL;
 	}
diff --git a/tools/perf/util/fncache.c b/tools/perf/util/fncache.c
index bf9559c55c63..04ea150bc7cd 100644
--- a/tools/perf/util/fncache.c
+++ b/tools/perf/util/fncache.c
@@ -36,9 +36,10 @@ static struct hashmap *fncache__get(void)
 
 static bool lookup_fncache(const char *name, bool *res)
 {
+	struct hashmap *map = fncache__get();
 	long val;
 
-	if (!hashmap__find(fncache__get(), name, &val))
+	if (!map || !hashmap__find(map, name, &val))
 		return false;
 
 	*res = (val != 0);
@@ -47,11 +48,14 @@ static bool lookup_fncache(const char *name, bool *res)
 
 static void update_fncache(const char *name, bool res)
 {
+	struct hashmap *map = fncache__get();
 	char *old_key = NULL, *key = strdup(name);
 
-	if (key) {
-		hashmap__set(fncache__get(), key, res, &old_key, /*old_value*/NULL);
+	if (map && key) {
+		hashmap__set(map, key, res, &old_key, /*old_value*/NULL);
 		free(old_key);
+	} else {
+		free(key);
 	}
 }
 
diff --git a/tools/perf/util/hashmap.c b/tools/perf/util/hashmap.c
index 7fd87c7d72be..f2d8beeac27a 100644
--- a/tools/perf/util/hashmap.c
+++ b/tools/perf/util/hashmap.c
@@ -10,7 +10,6 @@
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
-#include <linux/err.h>
 #include "hashmap.h"
 
 /* make sure libbpf doesn't use kernel-only integer typedefs */
@@ -55,8 +54,10 @@ struct hashmap *__hashmap__new(hashmap_hash_fn hash_fn,
 {
 	struct hashmap *map = malloc(sizeof(struct hashmap));
 
-	if (!map)
-		return ERR_PTR(-ENOMEM);
+	if (!map) {
+		errno = ENOMEM;
+		return NULL;
+	}
 	__hashmap__init(map, hash_fn, equal_fn, ctx);
 	return map;
 }
@@ -76,7 +77,7 @@ void __hashmap__clear(struct hashmap *map)
 
 void __hashmap__free(struct hashmap *map)
 {
-	if (IS_ERR_OR_NULL(map))
+	if (!map)
 		return;
 
 	__hashmap__clear(map);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 01753d5c69d1..a63fa0d9cfa5 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1314,6 +1314,12 @@ struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pm
 
 	INIT_LIST_HEAD(&pmu->format);
 	pmu->aliases = hashmap__new(aliases__hash, aliases__equal, /*ctx=*/ NULL);
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
index aaf8838b2cb2..e0fac2aa15ed 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -202,7 +202,7 @@ static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
 						   get_counter_name_hashmap_equal_fn,
 						   /*ctx=*/NULL);
 
-		if (!IS_ERR(tmp)) {
+		if (tmp) {
 			cache = tmp;
 			cache_pmu = pmu;
 		}
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index e7013449271d..097985da3dbb 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -326,7 +326,7 @@ static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
 
 	if (!mask) {
 		mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
-		if (IS_ERR(mask))
+		if (!mask)
 			return -ENOMEM;
 
 		counter->per_pkg_mask = mask;
-- 
2.56.1.703.gf848ed807c-goog

