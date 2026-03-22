Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32D636828D
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Mar 2026 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774141122; cv=none; b=MMmgBwXyZDPZTJjqWm7rf0K00A762kH4kvSrYZyT6i4TPFzzOA91ftsQ3EB5Y8Sg7za7Cn8SkPYQPWtfVu/JVaYcqZcYKjzwtBkh6sM/sNAZIXBjMR0fPL5692rto5fAMtjSOl3bM5Zy09VfDFRsTQEUCHA4CU8MarBprfXnOEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774141122; c=relaxed/simple;
	bh=vioz0+MisITw57cAoM3iweOa/+7fcSWUqOqvspGkFWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AuOAEOrpXqv5jyR/7nBpjCeg0i1q9hoyGdA1tgOrkHxoJ8IHun/NmaavfUwxn8RL6bLL9LJwou9o6YMXPWjOKfzOOxnbfW3NTAhvoDHRWUqM/LVZe2qjOFtLvdfblWBEvpVPXYLqTCGvWCEh9uUCQTvzjFGvP5e1DzZcjg9971w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pivmwq2R; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pivmwq2R"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1279caef718so1445016c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 17:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774141118; x=1774745918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKMNKrBvCJ+Y345Biu9LiA1wBlOnTT99L42XYZixZJ4=;
        b=Pivmwq2RylQzwfIcbwxKNxGz59d4C7VQLIzbtLdjHGc8jCVoVurIhQLnz3p09+7/Gi
         N3knpzuDVzb56GfrcX4n2guFVgPI4BLUDoiQJBpM+lnZPcMFAFYciyyDVr2FTPfcCNWD
         SWMq+zFHZYP7pdnOBEOdjjJNlyQ0SVazmDZ3xbbThYWo4DNCV/WK3irZyELEDwGGME40
         O3a6hHFHo2BBP1RFh0Ze85zu2zr9sxUUfRvEdUEcA0F9gPG9g15wGPPZLHG+NDx9KnBJ
         SwlksoXSFvt4nQjrcYIScrjRshPBk/nuQWDVGNKRUiKLQQHxYFyyyvS+JRKfrognvF7V
         lABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774141118; x=1774745918;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKMNKrBvCJ+Y345Biu9LiA1wBlOnTT99L42XYZixZJ4=;
        b=ZVbfF5fsUKzX9awRav857nX97pYmU3mFi6ZR9kGAQ9UCErDA0PG8+8NDJU5HnD8Cyr
         ERKTpVxHWhGVK+1QdraNq64eFfnbEcuvlpczUW9rp88DD6G9Bj7ZHt3RD43B5d2HJeNx
         WsoHhVYLanTXv0ulFK9FwTjaZJF3mKoSQQomy0AZr4F08+VJ+1tK2upvvT4DUrx0jrHU
         JXPquuejWkB2wOLACI9BK5IGH49e32lsBxb1/KcuWqohAaquPM4ce9ubMABC4yH2Om9R
         JAPhD3ddDNwZJRIPxODyxwyJlm9jS6AsFOBasHm6t5/+UdSyBt7ZGe2kbJFe+NcoZqlv
         dY4g==
X-Forwarded-Encrypted: i=1; AJvYcCWIO4GLGzCEpi30Ii07U/5ruLyENi5ugluUOuKWMaenteGlh/9AUOe+/k/sPmJcgHPOfQY8N0y0nPj2Hr3jVRkO@vger.kernel.org
X-Gm-Message-State: AOJu0YzXemrU2gY4joEGVoTHCS2IbMSbDLqj8cY1ClkxQh32JQLa6BqL
	7IBwqQGDwLLrPz8R0dJidJlChBR0WMrjdYeTle60zo5SpbQLrkrDKkAP3qcMwM8N15ABaAo5Gn7
	z7cUoKj3vkQ==
X-Received: from dlea6-n2.prod.google.com ([2002:a05:701b:4206:20b0:12a:6959:fb9b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:61a1:b0:11b:ade6:45a7
 with SMTP id a92af1059eb24-12a72671b02mr2672424c88.1.1774141117653; Sat, 21
 Mar 2026 17:58:37 -0700 (PDT)
Date: Sat, 21 Mar 2026 17:58:21 -0700
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
Message-ID: <20260322005823.981079-3-irogers@google.com>
Subject: [PATCH v2 2/4] perf hashmap: Rename hashmap to perf_hashmap to avoid
 libbpf conflict
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

The hashmap implementation in tools/perf/util was copied from
libbpf. To avoid symbol conflicts when linking against a version of
libbpf that also provides hashmap functions, rename the perf-specific
version to include a 'perf_' prefix.

Updated:
- hashmap_ -> perf_hashmap_
- hashmap__ -> perf_hashmap__
- struct hashmap -> struct perf_hashmap
- struct hashmap_entry -> struct perf_hashmap_entry
- enum hashmap_insert_strategy -> enum perf_hashmap_insert_strategy
- HASHMAP_ADD -> PERF_HASHMAP_ADD (and other strategy enums)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-ftrace.c           |  20 ++--
 tools/perf/builtin-trace.c            |  30 +++---
 tools/perf/tests/expr.c               |  68 ++++++-------
 tools/perf/tests/pmu-events.c         |   8 +-
 tools/perf/ui/browsers/annotate.c     |  12 +--
 tools/perf/util/Build                 |   9 --
 tools/perf/util/annotate.c            |  18 ++--
 tools/perf/util/annotate.h            |   6 +-
 tools/perf/util/bpf-trace-summary.c   |  30 +++---
 tools/perf/util/bpf_lock_contention.c |  14 +--
 tools/perf/util/evsel.c               |   8 +-
 tools/perf/util/evsel.h               |   4 +-
 tools/perf/util/expr.c                |  64 ++++++------
 tools/perf/util/expr.h                |  12 +--
 tools/perf/util/expr.y                |   2 +-
 tools/perf/util/fncache.c             |  10 +-
 tools/perf/util/ftrace.h              |   2 +-
 tools/perf/util/hashmap.c             |  98 +++++++++----------
 tools/perf/util/hashmap.h             | 134 +++++++++++++-------------
 tools/perf/util/hwmon_pmu.c           |  44 ++++-----
 tools/perf/util/metricgroup.c         |  30 +++---
 tools/perf/util/pmu.c                 |  24 ++---
 tools/perf/util/pmu.h                 |   4 +-
 tools/perf/util/s390-sample-raw.c     |  12 +--
 tools/perf/util/stat.c                |   8 +-
 tools/perf/util/threads.c             |  24 ++---
 tools/perf/util/threads.h             |   2 +-
 27 files changed, 344 insertions(+), 353 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 6b6eec65f93f..94abfac934f7 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1208,7 +1208,7 @@ static int prepare_func_profile(struct perf_ftrace *ftrace)
 	ftrace->graph_tail = 1;
 	ftrace->graph_verbose = 0;
 
-	ftrace->profile_hash = hashmap__new(profile_hash, profile_equal, NULL);
+	ftrace->profile_hash = perf_hashmap__new(profile_hash, profile_equal, NULL);
 	if (ftrace->profile_hash == NULL)
 		return -ENOMEM;
 
@@ -1224,7 +1224,7 @@ static int add_func_duration(struct perf_ftrace *ftrace, char *func, double time
 {
 	struct ftrace_profile_data *prof = NULL;
 
-	if (!hashmap__find(ftrace->profile_hash, func, &prof)) {
+	if (!perf_hashmap__find(ftrace->profile_hash, func, &prof)) {
 		char *key = strdup(func);
 
 		if (key == NULL)
@@ -1237,7 +1237,7 @@ static int add_func_duration(struct perf_ftrace *ftrace, char *func, double time
 		}
 
 		init_stats(&prof->st);
-		hashmap__add(ftrace->profile_hash, key, prof);
+		perf_hashmap__add(ftrace->profile_hash, key, prof);
 	}
 
 	update_stats(&prof->st, time_ns);
@@ -1332,8 +1332,8 @@ static enum perf_ftrace_profile_sort_key profile_sort = PFP_SORT_TOTAL;
 
 static int cmp_profile_data(const void *a, const void *b)
 {
-	const struct hashmap_entry *e1 = *(const struct hashmap_entry **)a;
-	const struct hashmap_entry *e2 = *(const struct hashmap_entry **)b;
+	const struct perf_hashmap_entry *e1 = *(const struct perf_hashmap_entry **)a;
+	const struct perf_hashmap_entry *e2 = *(const struct perf_hashmap_entry **)b;
 	struct ftrace_profile_data *p1 = e1->pvalue;
 	struct ftrace_profile_data *p2 = e2->pvalue;
 	double v1, v2;
@@ -1369,10 +1369,10 @@ static int cmp_profile_data(const void *a, const void *b)
 
 static void print_profile_result(struct perf_ftrace *ftrace)
 {
-	struct hashmap_entry *entry, **profile;
+	struct perf_hashmap_entry *entry, **profile;
 	size_t i, nr, bkt;
 
-	nr = hashmap__size(ftrace->profile_hash);
+	nr = perf_hashmap__size(ftrace->profile_hash);
 	if (nr == 0)
 		return;
 
@@ -1383,7 +1383,7 @@ static void print_profile_result(struct perf_ftrace *ftrace)
 	}
 
 	i = 0;
-	hashmap__for_each_entry(ftrace->profile_hash, entry, bkt)
+	perf_hashmap__for_each_entry(ftrace->profile_hash, entry, bkt)
 		profile[i++] = entry;
 
 	assert(i == nr);
@@ -1405,12 +1405,12 @@ static void print_profile_result(struct perf_ftrace *ftrace)
 
 	free(profile);
 
-	hashmap__for_each_entry(ftrace->profile_hash, entry, bkt) {
+	perf_hashmap__for_each_entry(ftrace->profile_hash, entry, bkt) {
 		free((char *)entry->pkey);
 		free(entry->pvalue);
 	}
 
-	hashmap__free(ftrace->profile_hash);
+	perf_hashmap__free(ftrace->profile_hash);
 	ftrace->profile_hash = NULL;
 }
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f487fbaa0ad6..88b2fac16457 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -184,7 +184,7 @@ struct trace {
 	 * into the key, but this would make the code inconsistent with the
 	 * per-thread version.
 	 */
-	struct hashmap		*syscall_stats;
+	struct perf_hashmap		*syscall_stats;
 	double			duration_filter;
 	double			runtime_ms;
 	unsigned long		pfmaj, pfmin;
@@ -1549,7 +1549,7 @@ struct thread_trace {
 		struct file   *table;
 	} files;
 
-	struct hashmap *syscall_stats;
+	struct perf_hashmap *syscall_stats;
 };
 
 static size_t syscall_id_hash(long key, void *ctx __maybe_unused)
@@ -1562,24 +1562,24 @@ static bool syscall_id_equal(long key1, long key2, void *ctx __maybe_unused)
 	return key1 == key2;
 }
 
-static struct hashmap *alloc_syscall_stats(void)
+static struct perf_hashmap *alloc_syscall_stats(void)
 {
-	struct hashmap *result = hashmap__new(syscall_id_hash, syscall_id_equal, NULL);
+	struct perf_hashmap *result = perf_hashmap__new(syscall_id_hash, syscall_id_equal, NULL);
 
 	return IS_ERR(result) ? NULL : result;
 }
 
-static void delete_syscall_stats(struct hashmap *syscall_stats)
+static void delete_syscall_stats(struct perf_hashmap *syscall_stats)
 {
-	struct hashmap_entry *pos;
+	struct perf_hashmap_entry *pos;
 	size_t bkt;
 
 	if (!syscall_stats)
 		return;
 
-	hashmap__for_each_entry(syscall_stats, pos, bkt)
+	perf_hashmap__for_each_entry(syscall_stats, pos, bkt)
 		zfree(&pos->pvalue);
-	hashmap__free(syscall_stats);
+	perf_hashmap__free(syscall_stats);
 }
 
 static struct thread_trace *thread_trace__new(struct trace *trace)
@@ -2637,7 +2637,7 @@ static void thread__update_stats(struct thread *thread, struct thread_trace *ttr
 				 int id, struct perf_sample *sample, long err,
 				 struct trace *trace)
 {
-	struct hashmap *syscall_stats = ttrace->syscall_stats;
+	struct perf_hashmap *syscall_stats = ttrace->syscall_stats;
 	struct syscall_stats *stats = NULL;
 	u64 duration = 0;
 
@@ -2647,13 +2647,13 @@ static void thread__update_stats(struct thread *thread, struct thread_trace *ttr
 	if (trace->summary_mode == SUMMARY__BY_TOTAL)
 		syscall_stats = trace->syscall_stats;
 
-	if (!hashmap__find(syscall_stats, id, &stats)) {
+	if (!perf_hashmap__find(syscall_stats, id, &stats)) {
 		stats = zalloc(sizeof(*stats));
 		if (stats == NULL)
 			return;
 
 		init_stats(&stats->stats);
-		if (hashmap__add(syscall_stats, id, stats) < 0) {
+		if (perf_hashmap__add(syscall_stats, id, stats) < 0) {
 			free(stats);
 			return;
 		}
@@ -4815,10 +4815,10 @@ static int entry_cmp(const void *e1, const void *e2)
 	return entry1->msecs > entry2->msecs ? -1 : 1;
 }
 
-static struct syscall_entry *syscall__sort_stats(struct hashmap *syscall_stats)
+static struct syscall_entry *syscall__sort_stats(struct perf_hashmap *syscall_stats)
 {
 	struct syscall_entry *entry;
-	struct hashmap_entry *pos;
+	struct perf_hashmap_entry *pos;
 	unsigned bkt, i, nr;
 
 	nr = syscall_stats->sz;
@@ -4827,7 +4827,7 @@ static struct syscall_entry *syscall__sort_stats(struct hashmap *syscall_stats)
 		return NULL;
 
 	i = 0;
-	hashmap__for_each_entry(syscall_stats, pos, bkt) {
+	perf_hashmap__for_each_entry(syscall_stats, pos, bkt) {
 		struct syscall_stats *ss = pos->pvalue;
 		struct stats *st = &ss->stats;
 
@@ -4843,7 +4843,7 @@ static struct syscall_entry *syscall__sort_stats(struct hashmap *syscall_stats)
 }
 
 static size_t syscall__dump_stats(struct trace *trace, int e_machine, FILE *fp,
-				  struct hashmap *syscall_stats)
+				  struct perf_hashmap *syscall_stats)
 {
 	size_t printed = 0;
 	int lines = 0;
diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 726cf8d4da28..78493a0ca925 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -15,7 +15,7 @@
 
 static int test_ids_union(void)
 {
-	struct hashmap *ids1, *ids2;
+	struct perf_hashmap *ids1, *ids2;
 
 	/* Empty union. */
 	ids1 = ids__new();
@@ -24,7 +24,7 @@ static int test_ids_union(void)
 	TEST_ASSERT_VAL("ids__new", ids2);
 
 	ids1 = ids__union(ids1, ids2);
-	TEST_ASSERT_EQUAL("union", (int)hashmap__size(ids1), 0);
+	TEST_ASSERT_EQUAL("union", (int)perf_hashmap__size(ids1), 0);
 
 	/* Union {foo, bar} against {}. */
 	ids2 = ids__new();
@@ -34,7 +34,7 @@ static int test_ids_union(void)
 	TEST_ASSERT_EQUAL("ids__insert", ids__insert(ids1, strdup("bar")), 0);
 
 	ids1 = ids__union(ids1, ids2);
-	TEST_ASSERT_EQUAL("union", (int)hashmap__size(ids1), 2);
+	TEST_ASSERT_EQUAL("union", (int)perf_hashmap__size(ids1), 2);
 
 	/* Union {foo, bar} against {foo}. */
 	ids2 = ids__new();
@@ -42,7 +42,7 @@ static int test_ids_union(void)
 	TEST_ASSERT_EQUAL("ids__insert", ids__insert(ids2, strdup("foo")), 0);
 
 	ids1 = ids__union(ids1, ids2);
-	TEST_ASSERT_EQUAL("union", (int)hashmap__size(ids1), 2);
+	TEST_ASSERT_EQUAL("union", (int)perf_hashmap__size(ids1), 2);
 
 	/* Union {foo, bar} against {bar,baz}. */
 	ids2 = ids__new();
@@ -51,7 +51,7 @@ static int test_ids_union(void)
 	TEST_ASSERT_EQUAL("ids__insert", ids__insert(ids2, strdup("baz")), 0);
 
 	ids1 = ids__union(ids1, ids2);
-	TEST_ASSERT_EQUAL("union", (int)hashmap__size(ids1), 3);
+	TEST_ASSERT_EQUAL("union", (int)perf_hashmap__size(ids1), 3);
 
 	ids__free(ids1);
 
@@ -134,27 +134,27 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("FOO + BAR + BAZ + BOZO", "FOO",
 					ctx) == 0);
-	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 3);
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "BAR", &val_ptr));
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "BAZ", &val_ptr));
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "BOZO", &val_ptr));
+	TEST_ASSERT_VAL("find ids", perf_hashmap__size(ctx->ids) == 3);
+	TEST_ASSERT_VAL("find ids", perf_hashmap__find(ctx->ids, "BAR", &val_ptr));
+	TEST_ASSERT_VAL("find ids", perf_hashmap__find(ctx->ids, "BAZ", &val_ptr));
+	TEST_ASSERT_VAL("find ids", perf_hashmap__find(ctx->ids, "BOZO", &val_ptr));
 
 	expr__ctx_clear(ctx);
 	ctx->sctx.runtime = 3;
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@",
 					NULL, ctx) == 0);
-	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 2);
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1,param=3@", &val_ptr));
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT2,param=3@", &val_ptr));
+	TEST_ASSERT_VAL("find ids", perf_hashmap__size(ctx->ids) == 2);
+	TEST_ASSERT_VAL("find ids", perf_hashmap__find(ctx->ids, "EVENT1,param=3@", &val_ptr));
+	TEST_ASSERT_VAL("find ids", perf_hashmap__find(ctx->ids, "EVENT2,param=3@", &val_ptr));
 
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("dash\\-event1 - dash\\-event2",
 				       NULL, ctx) == 0);
-	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 2);
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "dash-event1", &val_ptr));
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "dash-event2", &val_ptr));
+	TEST_ASSERT_VAL("find ids", perf_hashmap__size(ctx->ids) == 2);
+	TEST_ASSERT_VAL("find ids", perf_hashmap__find(ctx->ids, "dash-event1", &val_ptr));
+	TEST_ASSERT_VAL("find ids", perf_hashmap__find(ctx->ids, "dash-event2", &val_ptr));
 
 	/* Only EVENT1 or EVENT2 need be measured depending on the value of smt_on. */
 	{
@@ -166,8 +166,8 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 		TEST_ASSERT_VAL("find ids",
 				expr__find_ids("EVENT1 if #smt_on else EVENT2",
 					NULL, ctx) == 0);
-		TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
-		TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
+		TEST_ASSERT_VAL("find ids", perf_hashmap__size(ctx->ids) == 1);
+		TEST_ASSERT_VAL("find ids", perf_hashmap__find(ctx->ids,
 							  smton ? "EVENT1" : "EVENT2",
 							  &val_ptr));
 
@@ -175,8 +175,8 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 		TEST_ASSERT_VAL("find ids",
 				expr__find_ids("EVENT1 if #core_wide else EVENT2",
 					NULL, ctx) == 0);
-		TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
-		TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
+		TEST_ASSERT_VAL("find ids", perf_hashmap__size(ctx->ids) == 1);
+		TEST_ASSERT_VAL("find ids", perf_hashmap__find(ctx->ids,
 							  corewide ? "EVENT1" : "EVENT2",
 							  &val_ptr));
 
@@ -186,47 +186,47 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("1.0 if EVENT1 > 100.0 else 1.0",
 			NULL, ctx) == 0);
-	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
+	TEST_ASSERT_VAL("find ids", perf_hashmap__size(ctx->ids) == 0);
 
 	/* The expression is a constant 0.0 without needing to evaluate EVENT1. */
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("0 & EVENT1 > 0", NULL, ctx) == 0);
-	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
+	TEST_ASSERT_VAL("find ids", perf_hashmap__size(ctx->ids) == 0);
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("EVENT1 > 0 & 0", NULL, ctx) == 0);
-	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
+	TEST_ASSERT_VAL("find ids", perf_hashmap__size(ctx->ids) == 0);
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("1 & EVENT1 > 0", NULL, ctx) == 0);
-	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
+	TEST_ASSERT_VAL("find ids", perf_hashmap__size(ctx->ids) == 1);
+	TEST_ASSERT_VAL("find ids", perf_hashmap__find(ctx->ids, "EVENT1", &val_ptr));
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("EVENT1 > 0 & 1", NULL, ctx) == 0);
-	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
+	TEST_ASSERT_VAL("find ids", perf_hashmap__size(ctx->ids) == 1);
+	TEST_ASSERT_VAL("find ids", perf_hashmap__find(ctx->ids, "EVENT1", &val_ptr));
 
 	/* The expression is a constant 1.0 without needing to evaluate EVENT1. */
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("1 | EVENT1 > 0", NULL, ctx) == 0);
-	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
+	TEST_ASSERT_VAL("find ids", perf_hashmap__size(ctx->ids) == 0);
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("EVENT1 > 0 | 1", NULL, ctx) == 0);
-	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
+	TEST_ASSERT_VAL("find ids", perf_hashmap__size(ctx->ids) == 0);
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("0 | EVENT1 > 0", NULL, ctx) == 0);
-	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
+	TEST_ASSERT_VAL("find ids", perf_hashmap__size(ctx->ids) == 1);
+	TEST_ASSERT_VAL("find ids", perf_hashmap__find(ctx->ids, "EVENT1", &val_ptr));
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("EVENT1 > 0 | 0", NULL, ctx) == 0);
-	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
+	TEST_ASSERT_VAL("find ids", perf_hashmap__size(ctx->ids) == 1);
+	TEST_ASSERT_VAL("find ids", perf_hashmap__find(ctx->ids, "EVENT1", &val_ptr));
 
 	/* Test toplogy constants appear well ordered. */
 	expr__ctx_clear(ctx);
@@ -264,8 +264,8 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	TEST_ASSERT_VAL("source count",
 			expr__find_ids("source_count(EVENT1)",
 			NULL, ctx) == 0);
-	TEST_ASSERT_VAL("source count", hashmap__size(ctx->ids) == 1);
-	TEST_ASSERT_VAL("source count", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
+	TEST_ASSERT_VAL("source count", perf_hashmap__size(ctx->ids) == 1);
+	TEST_ASSERT_VAL("source count", perf_hashmap__find(ctx->ids, "EVENT1", &val_ptr));
 
 
 	/* Test no cpuid match */
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index a99716862168..c851e61f6041 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -929,7 +929,7 @@ static struct test_metric metrics[] = {
 static int metric_parse_fake(const char *metric_name, const char *str)
 {
 	struct expr_parse_ctx *ctx;
-	struct hashmap_entry *cur;
+	struct perf_hashmap_entry *cur;
 	double result;
 	int ret = -1;
 	size_t bkt;
@@ -954,10 +954,10 @@ static int metric_parse_fake(const char *metric_name, const char *str)
 	 * make them unique.
 	 */
 	i = 1;
-	hashmap__for_each_entry(ctx->ids, cur, bkt)
+	perf_hashmap__for_each_entry(ctx->ids, cur, bkt)
 		expr__add_id_val(ctx, strdup(cur->pkey), i++);
 
-	hashmap__for_each_entry(ctx->ids, cur, bkt) {
+	perf_hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		if (check_parse_fake(cur->pkey)) {
 			pr_err("check_parse_fake failed\n");
 			goto out;
@@ -971,7 +971,7 @@ static int metric_parse_fake(const char *metric_name, const char *str)
 		 * resolve divide by zero issues.
 		 */
 		i = 1024;
-		hashmap__for_each_entry(ctx->ids, cur, bkt)
+		perf_hashmap__for_each_entry(ctx->ids, cur, bkt)
 			expr__add_id_val(ctx, strdup(cur->pkey), i--);
 		if (expr__parse(&result, ctx, str)) {
 			pr_err("expr__parse failed for %s\n", metric_name);
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ea17e6d29a7e..c61415295dda 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -38,7 +38,7 @@ struct annotate_browser {
 	struct hist_entry	   *he;
 	struct debuginfo	   *dbg;
 	struct evsel		   *evsel;
-	struct hashmap		   *type_hash;
+	struct perf_hashmap		   *type_hash;
 	bool			    searching_backwards;
 	char			    search_bf[128];
 };
@@ -1117,7 +1117,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			if (browser->dbg == NULL)
 				browser->dbg = dso__debuginfo(map__dso(ms->map));
 			if (browser->type_hash == NULL) {
-				browser->type_hash = hashmap__new(type_hash, type_equal,
+				browser->type_hash = perf_hashmap__new(type_hash, type_equal,
 								  /*ctx=*/NULL);
 			}
 			annotate_browser__show(browser, title, help);
@@ -1219,7 +1219,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 
 	if (annotate_opts.code_with_type) {
 		browser.dbg = dso__debuginfo(dso);
-		browser.type_hash = hashmap__new(type_hash, type_equal, /*ctx=*/NULL);
+		browser.type_hash = perf_hashmap__new(type_hash, type_equal, /*ctx=*/NULL);
 	}
 
 	browser.b.width = notes->src->widths.max_line_len;
@@ -1249,12 +1249,12 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 	debuginfo__delete(browser.dbg);
 
 	if (!IS_ERR_OR_NULL(browser.type_hash)) {
-		struct hashmap_entry *cur;
+		struct perf_hashmap_entry *cur;
 		size_t bkt;
 
-		hashmap__for_each_entry(browser.type_hash, cur, bkt)
+		perf_hashmap__for_each_entry(browser.type_hash, cur, bkt)
 			zfree(&cur->pvalue);
-		hashmap__free(browser.type_hash);
+		perf_hashmap__free(browser.type_hash);
 	}
 
 	if (not_annotated && !notes->src->tried_source)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 70cc91d00804..b8fc4d102c0b 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -197,16 +197,7 @@ perf-util-$(CONFIG_LIBELF) += symbol-elf.o
 perf-util-$(CONFIG_LIBELF) += probe-file.o
 perf-util-$(CONFIG_LIBELF) += probe-event.o
 
-ifdef CONFIG_LIBBPF_DYNAMIC
-  hashmap := 1
-endif
-ifndef CONFIG_LIBBPF
-  hashmap := 1
-endif
-
-ifdef hashmap
 perf-util-y += hashmap.o
-endif
 
 ifndef CONFIG_LIBELF
 perf-util-y += symbol-minimal.o
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2e3522905046..d49ae1f4327e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -112,16 +112,16 @@ static struct annotated_source *annotated_source__new(void)
 
 static __maybe_unused void annotated_source__delete(struct annotated_source *src)
 {
-	struct hashmap_entry *cur;
+	struct perf_hashmap_entry *cur;
 	size_t bkt;
 
 	if (src == NULL)
 		return;
 
 	if (src->samples) {
-		hashmap__for_each_entry(src->samples, cur, bkt)
+		perf_hashmap__for_each_entry(src->samples, cur, bkt)
 			zfree(&cur->pvalue);
-		hashmap__free(src->samples);
+		perf_hashmap__free(src->samples);
 	}
 	zfree(&src->histograms);
 	free(src);
@@ -136,7 +136,7 @@ static int annotated_source__alloc_histograms(struct annotated_source *src,
 	if (src->histograms == NULL)
 		return -1;
 
-	src->samples = hashmap__new(sym_hist_hash, sym_hist_equal, NULL);
+	src->samples = perf_hashmap__new(sym_hist_hash, sym_hist_equal, NULL);
 	if (src->samples == NULL)
 		zfree(&src->histograms);
 
@@ -151,7 +151,7 @@ void symbol__annotate_zero_histograms(struct symbol *sym)
 	if (notes->src != NULL) {
 		memset(notes->src->histograms, 0,
 		       notes->src->nr_histograms * sizeof(*notes->src->histograms));
-		hashmap__clear(notes->src->samples);
+		perf_hashmap__clear(notes->src->samples);
 	}
 	if (notes->branch && notes->branch->cycles_hist) {
 		memset(notes->branch->cycles_hist, 0,
@@ -238,12 +238,12 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
 	}
 
 	hash_key = offset << 16 | evsel->core.idx;
-	if (!hashmap__find(src->samples, hash_key, &entry)) {
+	if (!perf_hashmap__find(src->samples, hash_key, &entry)) {
 		entry = zalloc(sizeof(*entry));
 		if (entry == NULL)
 			return -ENOMEM;
 
-		if (hashmap__add(src->samples, hash_key, entry) < 0)
+		if (perf_hashmap__add(src->samples, hash_key, entry) < 0)
 			return -ENOMEM;
 	}
 
@@ -1970,7 +1970,7 @@ static int disasm_line__snprint_type_info(struct disasm_line *dl,
 		return 1;
 
 	if (apd->type_hash) {
-		hashmap__find(apd->type_hash, dl->al.offset, &entry);
+		perf_hashmap__find(apd->type_hash, dl->al.offset, &entry);
 		if (entry != NULL) {
 			data_type = entry->type;
 			offset = entry->offset;
@@ -1985,7 +1985,7 @@ static int disasm_line__snprint_type_info(struct disasm_line *dl,
 		if (entry != NULL) {
 			entry->type = data_type;
 			entry->offset = offset;
-			hashmap__add(apd->type_hash, dl->al.offset, entry);
+			perf_hashmap__add(apd->type_hash, dl->al.offset, entry);
 		}
 	}
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 696e36dbf013..b59be2389a65 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -205,7 +205,7 @@ struct annotation_print_data {
 	const struct arch *arch;
 	struct debuginfo *dbg;
 	/* save data type info keyed by al->offset */
-	struct hashmap *type_hash;
+	struct perf_hashmap *type_hash;
 	/* It'll be set in hist_entry__annotate_printf() */
 	int addr_fmt_width;
 };
@@ -300,7 +300,7 @@ struct cyc_hist {
 struct annotated_source {
 	struct list_head	source;
 	struct sym_hist		*histograms;
-	struct hashmap	   	*samples;
+	struct perf_hashmap	   	*samples;
 	int    			nr_histograms;
 	int    			nr_events;
 	int			nr_entries;
@@ -412,7 +412,7 @@ annotated_source__hist_entry(struct annotated_source *src, const struct evsel *e
 	struct sym_hist_entry *entry;
 	long key = offset << 16 | evsel->core.idx;
 
-	if (!hashmap__find(src->samples, key, &entry))
+	if (!perf_hashmap__find(src->samples, key, &entry))
 		return NULL;
 	return entry;
 }
diff --git a/tools/perf/util/bpf-trace-summary.c b/tools/perf/util/bpf-trace-summary.c
index cf6e1e4402d5..2cdafd4b433d 100644
--- a/tools/perf/util/bpf-trace-summary.c
+++ b/tools/perf/util/bpf-trace-summary.c
@@ -169,19 +169,19 @@ static int print_common_stats(struct syscall_data *data, int max_summary, FILE *
 	return printed;
 }
 
-static int update_thread_stats(struct hashmap *hash, struct syscall_key *map_key,
+static int update_thread_stats(struct perf_hashmap *hash, struct syscall_key *map_key,
 			       struct syscall_stats *map_data)
 {
 	struct syscall_data *data;
 	struct syscall_node *nodes;
 
-	if (!hashmap__find(hash, map_key->cpu_or_tid, &data)) {
+	if (!perf_hashmap__find(hash, map_key->cpu_or_tid, &data)) {
 		data = zalloc(sizeof(*data));
 		if (data == NULL)
 			return -ENOMEM;
 
 		data->key = map_key->cpu_or_tid;
-		if (hashmap__add(hash, data->key, data) < 0) {
+		if (perf_hashmap__add(hash, data->key, data) < 0) {
 			free(data);
 			return -ENOMEM;
 		}
@@ -233,13 +233,13 @@ static int print_thread_stats(struct syscall_data **data, int nr_data, int max_s
 	return printed;
 }
 
-static int update_total_stats(struct hashmap *hash, struct syscall_key *map_key,
+static int update_total_stats(struct perf_hashmap *hash, struct syscall_key *map_key,
 			      struct syscall_stats *map_data)
 {
 	struct syscall_data *data;
 	struct syscall_stats *stat;
 
-	if (!hashmap__find(hash, map_key->nr, &data)) {
+	if (!perf_hashmap__find(hash, map_key->nr, &data)) {
 		data = zalloc(sizeof(*data));
 		if (data == NULL)
 			return -ENOMEM;
@@ -254,7 +254,7 @@ static int update_total_stats(struct hashmap *hash, struct syscall_key *map_key,
 		data->key = map_key->nr;
 		data->nodes->syscall_nr = data->key;
 
-		if (hashmap__add(hash, data->key, data) < 0) {
+		if (perf_hashmap__add(hash, data->key, data) < 0) {
 			free(data->nodes);
 			free(data);
 			return -ENOMEM;
@@ -305,19 +305,19 @@ static int print_total_stats(struct syscall_data **data, int nr_data, int max_su
 	return printed;
 }
 
-static int update_cgroup_stats(struct hashmap *hash, struct syscall_key *map_key,
+static int update_cgroup_stats(struct perf_hashmap *hash, struct syscall_key *map_key,
 			       struct syscall_stats *map_data)
 {
 	struct syscall_data *data;
 	struct syscall_node *nodes;
 
-	if (!hashmap__find(hash, map_key->cgroup, &data)) {
+	if (!perf_hashmap__find(hash, map_key->cgroup, &data)) {
 		data = zalloc(sizeof(*data));
 		if (data == NULL)
 			return -ENOMEM;
 
 		data->key = map_key->cgroup;
-		if (hashmap__add(hash, data->key, data) < 0) {
+		if (perf_hashmap__add(hash, data->key, data) < 0) {
 			free(data);
 			return -ENOMEM;
 		}
@@ -379,14 +379,14 @@ int trace_print_bpf_summary(FILE *fp, int max_summary)
 	struct bpf_map *map = skel->maps.syscall_stats_map;
 	struct syscall_key *prev_key, key;
 	struct syscall_data **data = NULL;
-	struct hashmap schash;
-	struct hashmap_entry *entry;
+	struct perf_hashmap schash;
+	struct perf_hashmap_entry *entry;
 	int nr_data = 0;
 	int printed = 0;
 	int i;
 	size_t bkt;
 
-	hashmap__init(&schash, sc_node_hash, sc_node_equal, /*ctx=*/NULL);
+	perf_hashmap__init(&schash, sc_node_hash, sc_node_equal, /*ctx=*/NULL);
 
 	printed = fprintf(fp, "\n Summary of events:\n\n");
 
@@ -414,13 +414,13 @@ int trace_print_bpf_summary(FILE *fp, int max_summary)
 		prev_key = &key;
 	}
 
-	nr_data = hashmap__size(&schash);
+	nr_data = perf_hashmap__size(&schash);
 	data = calloc(nr_data, sizeof(*data));
 	if (data == NULL)
 		goto out;
 
 	i = 0;
-	hashmap__for_each_entry(&schash, entry, bkt)
+	perf_hashmap__for_each_entry(&schash, entry, bkt)
 		data[i++] = entry->pvalue;
 
 	qsort(data, nr_data, sizeof(*data), datacmp);
@@ -446,7 +446,7 @@ int trace_print_bpf_summary(FILE *fp, int max_summary)
 	free(data);
 
 out:
-	hashmap__clear(&schash);
+	perf_hashmap__clear(&schash);
 	return printed;
 }
 
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index cbd7435579fe..3efe82915ebb 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -22,7 +22,7 @@
 
 static struct lock_contention_bpf *skel;
 static bool has_slab_iter;
-static struct hashmap slab_hash;
+static struct perf_hashmap slab_hash;
 
 static size_t slab_cache_hash(long key, void *ctx __maybe_unused)
 {
@@ -38,7 +38,7 @@ static void check_slab_cache_iter(struct lock_contention *con)
 {
 	s32 ret;
 
-	hashmap__init(&slab_hash, slab_cache_hash, slab_cache_equal, /*ctx=*/NULL);
+	perf_hashmap__init(&slab_hash, slab_cache_hash, slab_cache_equal, /*ctx=*/NULL);
 
 	con->btf = btf__load_vmlinux_btf();
 	if (con->btf == NULL) {
@@ -92,20 +92,20 @@ static void run_slab_cache_iter(void)
 		if (bpf_map_lookup_elem(fd, &key, data) < 0)
 			break;
 
-		hashmap__add(&slab_hash, data->id, data);
+		perf_hashmap__add(&slab_hash, data->id, data);
 		prev_key = &key;
 	}
 }
 
 static void exit_slab_cache_iter(void)
 {
-	struct hashmap_entry *cur;
+	struct perf_hashmap_entry *cur;
 	unsigned bkt;
 
-	hashmap__for_each_entry(&slab_hash, cur, bkt)
+	perf_hashmap__for_each_entry(&slab_hash, cur, bkt)
 		free(cur->pvalue);
 
-	hashmap__clear(&slab_hash);
+	perf_hashmap__clear(&slab_hash);
 }
 
 static void init_numa_data(struct lock_contention *con)
@@ -615,7 +615,7 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 		}
 
 		/* look slab_hash for dynamic locks in a slab object */
-		if (hashmap__find(&slab_hash, flags & LCB_F_SLAB_ID_MASK, &slab_data)) {
+		if (perf_hashmap__find(&slab_hash, flags & LCB_F_SLAB_ID_MASK, &slab_data)) {
 			snprintf(name_buf, sizeof(name_buf), "&%s", slab_data->name);
 			return name_buf;
 		}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5a294595a677..99a698de28be 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1878,7 +1878,7 @@ void evsel__exit(struct evsel *evsel)
 	zfree(&evsel->unit);
 	zfree(&evsel->metric_id);
 	evsel__zero_per_pkg(evsel);
-	hashmap__free(evsel->per_pkg_mask);
+	perf_hashmap__free(evsel->per_pkg_mask);
 	evsel->per_pkg_mask = NULL;
 	if (evsel__priv_destructor)
 		evsel__priv_destructor(evsel->priv);
@@ -4190,14 +4190,14 @@ int evsel__store_ids(struct evsel *evsel, struct evlist *evlist)
 
 void evsel__zero_per_pkg(struct evsel *evsel)
 {
-	struct hashmap_entry *cur;
+	struct perf_hashmap_entry *cur;
 	size_t bkt;
 
 	if (evsel->per_pkg_mask) {
-		hashmap__for_each_entry(evsel->per_pkg_mask, cur, bkt)
+		perf_hashmap__for_each_entry(evsel->per_pkg_mask, cur, bkt)
 			zfree(&cur->pkey);
 
-		hashmap__clear(evsel->per_pkg_mask);
+		perf_hashmap__clear(evsel->per_pkg_mask);
 	}
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 339b5c08a33d..ff28d1b4cc19 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -21,7 +21,7 @@ struct perf_stat_evsel;
 union perf_event;
 struct bpf_counter_ops;
 struct target;
-struct hashmap;
+struct perf_hashmap;
 struct bperf_leader_bpf;
 struct bperf_follower_bpf;
 
@@ -126,7 +126,7 @@ struct evsel {
 	bool			needs_uniquify;
 	bool			fallenback_eacces;
 	bool			fallenback_eopnotsupp;
-	struct hashmap		*per_pkg_mask;
+	struct perf_hashmap		*per_pkg_mask;
 	int			err;
 	int			script_output_type;
 	struct {
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 465fe2e9bbbe..dc10c335e378 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -63,39 +63,39 @@ static bool key_equal(long key1, long key2, void *ctx __maybe_unused)
 	return !strcmp((const char *)key1, (const char *)key2);
 }
 
-struct hashmap *ids__new(void)
+struct perf_hashmap *ids__new(void)
 {
-	struct hashmap *hash;
+	struct perf_hashmap *hash;
 
-	hash = hashmap__new(key_hash, key_equal, NULL);
+	hash = perf_hashmap__new(key_hash, key_equal, NULL);
 	if (IS_ERR(hash))
 		return NULL;
 	return hash;
 }
 
-void ids__free(struct hashmap *ids)
+void ids__free(struct perf_hashmap *ids)
 {
-	struct hashmap_entry *cur;
+	struct perf_hashmap_entry *cur;
 	size_t bkt;
 
 	if (ids == NULL)
 		return;
 
-	hashmap__for_each_entry(ids, cur, bkt) {
+	perf_hashmap__for_each_entry(ids, cur, bkt) {
 		zfree(&cur->pkey);
 		zfree(&cur->pvalue);
 	}
 
-	hashmap__free(ids);
+	perf_hashmap__free(ids);
 }
 
-int ids__insert(struct hashmap *ids, const char *id)
+int ids__insert(struct perf_hashmap *ids, const char *id)
 {
 	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
 	char *old_key = NULL;
 	int ret;
 
-	ret = hashmap__set(ids, id, data_ptr, &old_key, &old_data);
+	ret = perf_hashmap__set(ids, id, data_ptr, &old_key, &old_data);
 	if (ret)
 		free(data_ptr);
 	free(old_key);
@@ -103,10 +103,10 @@ int ids__insert(struct hashmap *ids, const char *id)
 	return ret;
 }
 
-struct hashmap *ids__union(struct hashmap *ids1, struct hashmap *ids2)
+struct perf_hashmap *ids__union(struct perf_hashmap *ids1, struct perf_hashmap *ids2)
 {
 	size_t bkt;
-	struct hashmap_entry *cur;
+	struct perf_hashmap_entry *cur;
 	int ret;
 	struct expr_id_data *old_data = NULL;
 	char *old_key = NULL;
@@ -117,24 +117,24 @@ struct hashmap *ids__union(struct hashmap *ids1, struct hashmap *ids2)
 	if (!ids2)
 		return ids1;
 
-	if (hashmap__size(ids1) <  hashmap__size(ids2)) {
-		struct hashmap *tmp = ids1;
+	if (perf_hashmap__size(ids1) <  perf_hashmap__size(ids2)) {
+		struct perf_hashmap *tmp = ids1;
 
 		ids1 = ids2;
 		ids2 = tmp;
 	}
-	hashmap__for_each_entry(ids2, cur, bkt) {
-		ret = hashmap__set(ids1, cur->key, cur->value, &old_key, &old_data);
+	perf_hashmap__for_each_entry(ids2, cur, bkt) {
+		ret = perf_hashmap__set(ids1, cur->key, cur->value, &old_key, &old_data);
 		free(old_key);
 		free(old_data);
 
 		if (ret) {
-			hashmap__free(ids1);
-			hashmap__free(ids2);
+			perf_hashmap__free(ids1);
+			perf_hashmap__free(ids2);
 			return NULL;
 		}
 	}
-	hashmap__free(ids2);
+	perf_hashmap__free(ids2);
 	return ids1;
 }
 
@@ -165,7 +165,7 @@ int expr__add_id_val_source_count(struct expr_parse_ctx *ctx, const char *id,
 	data_ptr->val.source_count = source_count;
 	data_ptr->kind = EXPR_ID_DATA__VALUE;
 
-	ret = hashmap__set(ctx->ids, id, data_ptr, &old_key, &old_data);
+	ret = perf_hashmap__set(ctx->ids, id, data_ptr, &old_key, &old_data);
 	if (ret) {
 		free(data_ptr);
 	} else if (old_data) {
@@ -204,7 +204,7 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 	data_ptr->ref.metric_expr = ref->metric_expr;
 	data_ptr->kind = EXPR_ID_DATA__REF;
 
-	ret = hashmap__set(ctx->ids, name, data_ptr, &old_key, &old_data);
+	ret = perf_hashmap__set(ctx->ids, name, data_ptr, &old_key, &old_data);
 	if (ret)
 		free(data_ptr);
 
@@ -221,17 +221,17 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 {
 	if (!ctx || !id)
 		return -1;
-	return hashmap__find(ctx->ids, id, data) ? 0 : -1;
+	return perf_hashmap__find(ctx->ids, id, data) ? 0 : -1;
 }
 
 bool expr__subset_of_ids(struct expr_parse_ctx *haystack,
 			 struct expr_parse_ctx *needles)
 {
-	struct hashmap_entry *cur;
+	struct perf_hashmap_entry *cur;
 	size_t bkt;
 	struct expr_id_data *data;
 
-	hashmap__for_each_entry(needles->ids, cur, bkt) {
+	perf_hashmap__for_each_entry(needles->ids, cur, bkt) {
 		if (expr__get_id(haystack, cur->pkey, &data))
 			return false;
 	}
@@ -282,7 +282,7 @@ void expr__del_id(struct expr_parse_ctx *ctx, const char *id)
 	struct expr_id_data *old_val = NULL;
 	char *old_key = NULL;
 
-	hashmap__delete(ctx->ids, id, &old_key, &old_val);
+	perf_hashmap__delete(ctx->ids, id, &old_key, &old_val);
 	free(old_key);
 	free(old_val);
 }
@@ -295,7 +295,7 @@ struct expr_parse_ctx *expr__ctx_new(void)
 	if (!ctx)
 		return NULL;
 
-	ctx->ids = hashmap__new(key_hash, key_equal, NULL);
+	ctx->ids = perf_hashmap__new(key_hash, key_equal, NULL);
 	if (IS_ERR(ctx->ids)) {
 		free(ctx);
 		return NULL;
@@ -306,30 +306,30 @@ struct expr_parse_ctx *expr__ctx_new(void)
 
 void expr__ctx_clear(struct expr_parse_ctx *ctx)
 {
-	struct hashmap_entry *cur;
+	struct perf_hashmap_entry *cur;
 	size_t bkt;
 
-	hashmap__for_each_entry(ctx->ids, cur, bkt) {
+	perf_hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		zfree(&cur->pkey);
 		zfree(&cur->pvalue);
 	}
-	hashmap__clear(ctx->ids);
+	perf_hashmap__clear(ctx->ids);
 }
 
 void expr__ctx_free(struct expr_parse_ctx *ctx)
 {
-	struct hashmap_entry *cur;
+	struct perf_hashmap_entry *cur;
 	size_t bkt;
 
 	if (!ctx)
 		return;
 
 	zfree(&ctx->sctx.user_requested_cpu_list);
-	hashmap__for_each_entry(ctx->ids, cur, bkt) {
+	perf_hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		zfree(&cur->pkey);
 		zfree(&cur->pvalue);
 	}
-	hashmap__free(ctx->ids);
+	perf_hashmap__free(ctx->ids);
 	free(ctx);
 }
 
@@ -421,7 +421,7 @@ double expr__has_event(const struct expr_parse_ctx *ctx, bool compute_ids, const
 	struct evlist *tmp;
 	double ret;
 
-	if (hashmap__find(ctx->ids, id, /*value=*/NULL))
+	if (perf_hashmap__find(ctx->ids, id, /*value=*/NULL))
 		return 1.0;
 
 	if (!compute_ids)
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index c0cec29ddc29..4c333af0c5e3 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -2,7 +2,7 @@
 #ifndef PARSE_CTX_H
 #define PARSE_CTX_H 1
 
-struct hashmap;
+struct perf_hashmap;
 struct metric_ref;
 
 struct expr_scanner_ctx {
@@ -13,20 +13,20 @@ struct expr_scanner_ctx {
 };
 
 struct expr_parse_ctx {
-	struct hashmap	*ids;
+	struct perf_hashmap	*ids;
 	struct expr_scanner_ctx sctx;
 };
 
 struct expr_id_data;
 
-struct hashmap *ids__new(void);
-void ids__free(struct hashmap *ids);
-int ids__insert(struct hashmap *ids, const char *id);
+struct perf_hashmap *ids__new(void);
+void ids__free(struct perf_hashmap *ids);
+int ids__insert(struct perf_hashmap *ids, const char *id);
 /*
  * Union two sets of ids (hashmaps) and construct a third, freeing ids1 and
  * ids2.
  */
-struct hashmap *ids__union(struct hashmap *ids1, struct hashmap *ids2);
+struct perf_hashmap *ids__union(struct perf_hashmap *ids1, struct perf_hashmap *ids2);
 
 struct expr_parse_ctx *expr__ctx_new(void);
 void expr__ctx_clear(struct expr_parse_ctx *ctx);
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index e364790babb5..75c95e62aeac 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -29,7 +29,7 @@ int expr_lex(YYSTYPE * yylval_param , void *yyscanner);
 		 * When creating ids, holds the working set of event ids. NULL
 		 * implies the set is empty.
 		 */
-		struct hashmap *ids;
+		struct perf_hashmap *ids;
 		/*
 		 * The metric value. When not creating ids this is the value
 		 * read from a counter, a constant or some computed value. When
diff --git a/tools/perf/util/fncache.c b/tools/perf/util/fncache.c
index bf9559c55c63..9c49a914e784 100644
--- a/tools/perf/util/fncache.c
+++ b/tools/perf/util/fncache.c
@@ -8,7 +8,7 @@
 #include "fncache.h"
 #include "hashmap.h"
 
-static struct hashmap *fncache;
+static struct perf_hashmap *fncache;
 
 static size_t fncache__hash(long key, void *ctx __maybe_unused)
 {
@@ -22,10 +22,10 @@ static bool fncache__equal(long key1, long key2, void *ctx __maybe_unused)
 
 static void fncache__init(void)
 {
-	fncache = hashmap__new(fncache__hash, fncache__equal, /*ctx=*/NULL);
+	fncache = perf_hashmap__new(fncache__hash, fncache__equal, /*ctx=*/NULL);
 }
 
-static struct hashmap *fncache__get(void)
+static struct perf_hashmap *fncache__get(void)
 {
 	static pthread_once_t fncache_once = PTHREAD_ONCE_INIT;
 
@@ -38,7 +38,7 @@ static bool lookup_fncache(const char *name, bool *res)
 {
 	long val;
 
-	if (!hashmap__find(fncache__get(), name, &val))
+	if (!perf_hashmap__find(fncache__get(), name, &val))
 		return false;
 
 	*res = (val != 0);
@@ -50,7 +50,7 @@ static void update_fncache(const char *name, bool res)
 	char *old_key = NULL, *key = strdup(name);
 
 	if (key) {
-		hashmap__set(fncache__get(), key, res, &old_key, /*old_value*/NULL);
+		perf_hashmap__set(fncache__get(), key, res, &old_key, /*old_value*/NULL);
 		free(old_key);
 	}
 }
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 950f2efafad2..46a0b3d94826 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -18,7 +18,7 @@ struct perf_ftrace {
 	struct list_head	graph_funcs;
 	struct list_head	nograph_funcs;
 	struct list_head	event_pair;
-	struct hashmap		*profile_hash;
+	struct perf_hashmap		*profile_hash;
 	unsigned long		percpu_buffer_size;
 	bool			inherit;
 	bool			use_nsec;
diff --git a/tools/perf/util/hashmap.c b/tools/perf/util/hashmap.c
index 140ee4055676..8c4b1f2af3ed 100644
--- a/tools/perf/util/hashmap.c
+++ b/tools/perf/util/hashmap.c
@@ -19,24 +19,24 @@
 #pragma GCC poison reallocarray
 
 /* start with 4 buckets */
-#define HASHMAP_MIN_CAP_BITS 2
+#define PERF_HASHMAP_MIN_CAP_BITS 2
 
-static void hashmap_add_entry(struct hashmap_entry **pprev,
-			      struct hashmap_entry *entry)
+static void perf_hashmap_add_entry(struct perf_hashmap_entry **pprev,
+			      struct perf_hashmap_entry *entry)
 {
 	entry->next = *pprev;
 	*pprev = entry;
 }
 
-static void hashmap_del_entry(struct hashmap_entry **pprev,
-			      struct hashmap_entry *entry)
+static void perf_hashmap_del_entry(struct perf_hashmap_entry **pprev,
+			      struct perf_hashmap_entry *entry)
 {
 	*pprev = entry->next;
 	entry->next = NULL;
 }
 
-void hashmap__init(struct hashmap *map, hashmap_hash_fn hash_fn,
-		   hashmap_equal_fn equal_fn, void *ctx)
+void perf_hashmap__init(struct perf_hashmap *map, perf_hashmap_hash_fn hash_fn,
+		   perf_hashmap_equal_fn equal_fn, void *ctx)
 {
 	map->hash_fn = hash_fn;
 	map->equal_fn = equal_fn;
@@ -48,24 +48,24 @@ void hashmap__init(struct hashmap *map, hashmap_hash_fn hash_fn,
 	map->sz = 0;
 }
 
-struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
-			     hashmap_equal_fn equal_fn,
+struct perf_hashmap *perf_hashmap__new(perf_hashmap_hash_fn hash_fn,
+			     perf_hashmap_equal_fn equal_fn,
 			     void *ctx)
 {
-	struct hashmap *map = malloc(sizeof(struct hashmap));
+	struct perf_hashmap *map = malloc(sizeof(struct perf_hashmap));
 
 	if (!map)
 		return ERR_PTR(-ENOMEM);
-	hashmap__init(map, hash_fn, equal_fn, ctx);
+	perf_hashmap__init(map, hash_fn, equal_fn, ctx);
 	return map;
 }
 
-void hashmap__clear(struct hashmap *map)
+void perf_hashmap__clear(struct perf_hashmap *map)
 {
-	struct hashmap_entry *cur, *tmp;
+	struct perf_hashmap_entry *cur, *tmp;
 	size_t bkt;
 
-	hashmap__for_each_entry_safe(map, cur, tmp, bkt) {
+	perf_hashmap__for_each_entry_safe(map, cur, tmp, bkt) {
 		free(cur);
 	}
 	free(map->buckets);
@@ -73,50 +73,50 @@ void hashmap__clear(struct hashmap *map)
 	map->cap = map->cap_bits = map->sz = 0;
 }
 
-void hashmap__free(struct hashmap *map)
+void perf_hashmap__free(struct perf_hashmap *map)
 {
 	if (IS_ERR_OR_NULL(map))
 		return;
 
-	hashmap__clear(map);
+	perf_hashmap__clear(map);
 	free(map);
 }
 
-size_t hashmap__size(const struct hashmap *map)
+size_t perf_hashmap__size(const struct perf_hashmap *map)
 {
 	return map->sz;
 }
 
-size_t hashmap__capacity(const struct hashmap *map)
+size_t perf_hashmap__capacity(const struct perf_hashmap *map)
 {
 	return map->cap;
 }
 
-static bool hashmap_needs_to_grow(struct hashmap *map)
+static bool perf_hashmap_needs_to_grow(struct perf_hashmap *map)
 {
 	/* grow if empty or more than 75% filled */
 	return (map->cap == 0) || ((map->sz + 1) * 4 / 3 > map->cap);
 }
 
-static int hashmap_grow(struct hashmap *map)
+static int perf_hashmap_grow(struct perf_hashmap *map)
 {
-	struct hashmap_entry **new_buckets;
-	struct hashmap_entry *cur, *tmp;
+	struct perf_hashmap_entry **new_buckets;
+	struct perf_hashmap_entry *cur, *tmp;
 	size_t new_cap_bits, new_cap;
 	size_t h, bkt;
 
 	new_cap_bits = map->cap_bits + 1;
-	if (new_cap_bits < HASHMAP_MIN_CAP_BITS)
-		new_cap_bits = HASHMAP_MIN_CAP_BITS;
+	if (new_cap_bits < PERF_HASHMAP_MIN_CAP_BITS)
+		new_cap_bits = PERF_HASHMAP_MIN_CAP_BITS;
 
 	new_cap = 1UL << new_cap_bits;
 	new_buckets = calloc(new_cap, sizeof(new_buckets[0]));
 	if (!new_buckets)
 		return -ENOMEM;
 
-	hashmap__for_each_entry_safe(map, cur, tmp, bkt) {
+	perf_hashmap__for_each_entry_safe(map, cur, tmp, bkt) {
 		h = hash_bits(map->hash_fn(cur->key, map->ctx), new_cap_bits);
-		hashmap_add_entry(&new_buckets[h], cur);
+		perf_hashmap_add_entry(&new_buckets[h], cur);
 	}
 
 	map->cap = new_cap;
@@ -127,12 +127,12 @@ static int hashmap_grow(struct hashmap *map)
 	return 0;
 }
 
-static bool hashmap_find_entry(const struct hashmap *map,
+static bool perf_hashmap_find_entry(const struct perf_hashmap *map,
 			       const long key, size_t hash,
-			       struct hashmap_entry ***pprev,
-			       struct hashmap_entry **entry)
+			       struct perf_hashmap_entry ***pprev,
+			       struct perf_hashmap_entry **entry)
 {
-	struct hashmap_entry *cur, **prev_ptr;
+	struct perf_hashmap_entry *cur, **prev_ptr;
 
 	if (!map->buckets)
 		return false;
@@ -151,11 +151,11 @@ static bool hashmap_find_entry(const struct hashmap *map,
 	return false;
 }
 
-int hashmap_insert(struct hashmap *map, long key, long value,
-		   enum hashmap_insert_strategy strategy,
+int perf_hashmap_insert(struct perf_hashmap *map, long key, long value,
+		   enum perf_hashmap_insert_strategy strategy,
 		   long *old_key, long *old_value)
 {
-	struct hashmap_entry *entry;
+	struct perf_hashmap_entry *entry;
 	size_t h;
 	int err;
 
@@ -165,51 +165,51 @@ int hashmap_insert(struct hashmap *map, long key, long value,
 		*old_value = 0;
 
 	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
-	if (strategy != HASHMAP_APPEND &&
-	    hashmap_find_entry(map, key, h, NULL, &entry)) {
+	if (strategy != PERF_HASHMAP_APPEND &&
+	    perf_hashmap_find_entry(map, key, h, NULL, &entry)) {
 		if (old_key)
 			*old_key = entry->key;
 		if (old_value)
 			*old_value = entry->value;
 
-		if (strategy == HASHMAP_SET || strategy == HASHMAP_UPDATE) {
+		if (strategy == PERF_HASHMAP_SET || strategy == PERF_HASHMAP_UPDATE) {
 			entry->key = key;
 			entry->value = value;
 			return 0;
-		} else if (strategy == HASHMAP_ADD) {
+		} else if (strategy == PERF_HASHMAP_ADD) {
 			return -EEXIST;
 		}
 	}
 
-	if (strategy == HASHMAP_UPDATE)
+	if (strategy == PERF_HASHMAP_UPDATE)
 		return -ENOENT;
 
-	if (hashmap_needs_to_grow(map)) {
-		err = hashmap_grow(map);
+	if (perf_hashmap_needs_to_grow(map)) {
+		err = perf_hashmap_grow(map);
 		if (err)
 			return err;
 		h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
 	}
 
-	entry = malloc(sizeof(struct hashmap_entry));
+	entry = malloc(sizeof(struct perf_hashmap_entry));
 	if (!entry)
 		return -ENOMEM;
 
 	entry->key = key;
 	entry->value = value;
-	hashmap_add_entry(&map->buckets[h], entry);
+	perf_hashmap_add_entry(&map->buckets[h], entry);
 	map->sz++;
 
 	return 0;
 }
 
-bool hashmap_find(const struct hashmap *map, long key, long *value)
+bool perf_hashmap_find(const struct perf_hashmap *map, long key, long *value)
 {
-	struct hashmap_entry *entry;
+	struct perf_hashmap_entry *entry;
 	size_t h;
 
 	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
-	if (!hashmap_find_entry(map, key, h, NULL, &entry))
+	if (!perf_hashmap_find_entry(map, key, h, NULL, &entry))
 		return false;
 
 	if (value)
@@ -217,14 +217,14 @@ bool hashmap_find(const struct hashmap *map, long key, long *value)
 	return true;
 }
 
-bool hashmap_delete(struct hashmap *map, long key,
+bool perf_hashmap_delete(struct perf_hashmap *map, long key,
 		    long *old_key, long *old_value)
 {
-	struct hashmap_entry **pprev, *entry;
+	struct perf_hashmap_entry **pprev, *entry;
 	size_t h;
 
 	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
-	if (!hashmap_find_entry(map, key, h, &pprev, &entry))
+	if (!perf_hashmap_find_entry(map, key, h, &pprev, &entry))
 		return false;
 
 	if (old_key)
@@ -232,7 +232,7 @@ bool hashmap_delete(struct hashmap *map, long key,
 	if (old_value)
 		*old_value = entry->value;
 
-	hashmap_del_entry(pprev, entry);
+	perf_hashmap_del_entry(pprev, entry);
 	free(entry);
 	map->sz--;
 
diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
index 0c4f155e8eb7..310b08c0b669 100644
--- a/tools/perf/util/hashmap.h
+++ b/tools/perf/util/hashmap.h
@@ -5,8 +5,8 @@
  *
  * Copyright (c) 2019 Facebook
  */
-#ifndef __LIBBPF_HASHMAP_H
-#define __LIBBPF_HASHMAP_H
+#ifndef __PERF_UTIL_HASHMAP_H
+#define __PERF_UTIL_HASHMAP_H
 
 #include <stdbool.h>
 #include <stddef.h>
@@ -40,24 +40,24 @@ static inline size_t str_hash(const char *s)
 	return h;
 }
 
-typedef size_t (*hashmap_hash_fn)(long key, void *ctx);
-typedef bool (*hashmap_equal_fn)(long key1, long key2, void *ctx);
+typedef size_t (*perf_hashmap_hash_fn)(long key, void *ctx);
+typedef bool (*perf_hashmap_equal_fn)(long key1, long key2, void *ctx);
 
 /*
  * Hashmap interface is polymorphic, keys and values could be either
  * long-sized integers or pointers, this is achieved as follows:
  * - interface functions that operate on keys and values are hidden
- *   behind auxiliary macros, e.g. hashmap_insert <-> hashmap__insert;
+ *   behind auxiliary macros, e.g. perf_hashmap_insert <-> perf_hashmap__insert;
  * - these auxiliary macros cast the key and value parameters as
  *   long or long *, so the user does not have to specify the casts explicitly;
  * - for pointer parameters (e.g. old_key) the size of the pointed
- *   type is verified by hashmap_cast_ptr using _Static_assert;
- * - when iterating using hashmap__for_each_* forms
+ *   type is verified by perf_hashmap_cast_ptr using _Static_assert;
+ * - when iterating using perf_hashmap__for_each_* forms
  *   hasmap_entry->key should be used for integer keys and
  *   hasmap_entry->pkey should be used for pointer keys,
  *   same goes for values.
  */
-struct hashmap_entry {
+struct perf_hashmap_entry {
 	union {
 		long key;
 		const void *pkey;
@@ -66,53 +66,53 @@ struct hashmap_entry {
 		long value;
 		void *pvalue;
 	};
-	struct hashmap_entry *next;
+	struct perf_hashmap_entry *next;
 };
 
-struct hashmap {
-	hashmap_hash_fn hash_fn;
-	hashmap_equal_fn equal_fn;
+struct perf_hashmap {
+	perf_hashmap_hash_fn hash_fn;
+	perf_hashmap_equal_fn equal_fn;
 	void *ctx;
 
-	struct hashmap_entry **buckets;
+	struct perf_hashmap_entry **buckets;
 	size_t cap;
 	size_t cap_bits;
 	size_t sz;
 };
 
-void hashmap__init(struct hashmap *map, hashmap_hash_fn hash_fn,
-		   hashmap_equal_fn equal_fn, void *ctx);
-struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
-			     hashmap_equal_fn equal_fn,
+void perf_hashmap__init(struct perf_hashmap *map, perf_hashmap_hash_fn hash_fn,
+		   perf_hashmap_equal_fn equal_fn, void *ctx);
+struct perf_hashmap *perf_hashmap__new(perf_hashmap_hash_fn hash_fn,
+			     perf_hashmap_equal_fn equal_fn,
 			     void *ctx);
-void hashmap__clear(struct hashmap *map);
-void hashmap__free(struct hashmap *map);
+void perf_hashmap__clear(struct perf_hashmap *map);
+void perf_hashmap__free(struct perf_hashmap *map);
 
-size_t hashmap__size(const struct hashmap *map);
-size_t hashmap__capacity(const struct hashmap *map);
+size_t perf_hashmap__size(const struct perf_hashmap *map);
+size_t perf_hashmap__capacity(const struct perf_hashmap *map);
 
 /*
  * Hashmap insertion strategy:
- * - HASHMAP_ADD - only add key/value if key doesn't exist yet;
- * - HASHMAP_SET - add key/value pair if key doesn't exist yet; otherwise,
+ * - PERF_HASHMAP_ADD - only add key/value if key doesn't exist yet;
+ * - PERF_HASHMAP_SET - add key/value pair if key doesn't exist yet; otherwise,
  *   update value;
- * - HASHMAP_UPDATE - update value, if key already exists; otherwise, do
+ * - PERF_HASHMAP_UPDATE - update value, if key already exists; otherwise, do
  *   nothing and return -ENOENT;
- * - HASHMAP_APPEND - always add key/value pair, even if key already exists.
+ * - PERF_HASHMAP_APPEND - always add key/value pair, even if key already exists.
  *   This turns hashmap into a multimap by allowing multiple values to be
  *   associated with the same key. Most useful read API for such hashmap is
- *   hashmap__for_each_key_entry() iteration. If hashmap__find() is still
+ *   perf_hashmap__for_each_key_entry() iteration. If perf_hashmap__find() is still
  *   used, it will return last inserted key/value entry (first in a bucket
  *   chain).
  */
-enum hashmap_insert_strategy {
-	HASHMAP_ADD,
-	HASHMAP_SET,
-	HASHMAP_UPDATE,
-	HASHMAP_APPEND,
+enum perf_hashmap_insert_strategy {
+	PERF_HASHMAP_ADD,
+	PERF_HASHMAP_SET,
+	PERF_HASHMAP_UPDATE,
+	PERF_HASHMAP_APPEND,
 };
 
-#define hashmap_cast_ptr(p) ({								\
+#define perf_hashmap_cast_ptr(p) ({								\
 	_Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) ||			\
 				sizeof(*(p)) == sizeof(long),				\
 		       #p " pointee should be a long-sized integer or a pointer");	\
@@ -120,76 +120,76 @@ enum hashmap_insert_strategy {
 })
 
 /*
- * hashmap__insert() adds key/value entry w/ various semantics, depending on
+ * perf_hashmap__insert() adds key/value entry w/ various semantics, depending on
  * provided strategy value. If a given key/value pair replaced already
  * existing key/value pair, both old key and old value will be returned
  * through old_key and old_value to allow calling code do proper memory
  * management.
  */
-int hashmap_insert(struct hashmap *map, long key, long value,
-		   enum hashmap_insert_strategy strategy,
+int perf_hashmap_insert(struct perf_hashmap *map, long key, long value,
+		   enum perf_hashmap_insert_strategy strategy,
 		   long *old_key, long *old_value);
 
-#define hashmap__insert(map, key, value, strategy, old_key, old_value) \
-	hashmap_insert((map), (long)(key), (long)(value), (strategy),  \
-		       hashmap_cast_ptr(old_key),		       \
-		       hashmap_cast_ptr(old_value))
+#define perf_hashmap__insert(map, key, value, strategy, old_key, old_value) \
+	perf_hashmap_insert((map), (long)(key), (long)(value), (strategy),  \
+		       perf_hashmap_cast_ptr(old_key),		       \
+		       perf_hashmap_cast_ptr(old_value))
 
-#define hashmap__add(map, key, value) \
-	hashmap__insert((map), (key), (value), HASHMAP_ADD, NULL, NULL)
+#define perf_hashmap__add(map, key, value) \
+	perf_hashmap__insert((map), (key), (value), PERF_HASHMAP_ADD, NULL, NULL)
 
-#define hashmap__set(map, key, value, old_key, old_value) \
-	hashmap__insert((map), (key), (value), HASHMAP_SET, (old_key), (old_value))
+#define perf_hashmap__set(map, key, value, old_key, old_value) \
+	perf_hashmap__insert((map), (key), (value), PERF_HASHMAP_SET, (old_key), (old_value))
 
-#define hashmap__update(map, key, value, old_key, old_value) \
-	hashmap__insert((map), (key), (value), HASHMAP_UPDATE, (old_key), (old_value))
+#define perf_hashmap__update(map, key, value, old_key, old_value) \
+	perf_hashmap__insert((map), (key), (value), PERF_HASHMAP_UPDATE, (old_key), (old_value))
 
-#define hashmap__append(map, key, value) \
-	hashmap__insert((map), (key), (value), HASHMAP_APPEND, NULL, NULL)
+#define perf_hashmap__append(map, key, value) \
+	perf_hashmap__insert((map), (key), (value), PERF_HASHMAP_APPEND, NULL, NULL)
 
-bool hashmap_delete(struct hashmap *map, long key, long *old_key, long *old_value);
+bool perf_hashmap_delete(struct perf_hashmap *map, long key, long *old_key, long *old_value);
 
-#define hashmap__delete(map, key, old_key, old_value)		       \
-	hashmap_delete((map), (long)(key),			       \
-		       hashmap_cast_ptr(old_key),		       \
-		       hashmap_cast_ptr(old_value))
+#define perf_hashmap__delete(map, key, old_key, old_value)		       \
+	perf_hashmap_delete((map), (long)(key),			       \
+		       perf_hashmap_cast_ptr(old_key),		       \
+		       perf_hashmap_cast_ptr(old_value))
 
-bool hashmap_find(const struct hashmap *map, long key, long *value);
+bool perf_hashmap_find(const struct perf_hashmap *map, long key, long *value);
 
-#define hashmap__find(map, key, value) \
-	hashmap_find((map), (long)(key), hashmap_cast_ptr(value))
+#define perf_hashmap__find(map, key, value) \
+	perf_hashmap_find((map), (long)(key), perf_hashmap_cast_ptr(value))
 
 /*
- * hashmap__for_each_entry - iterate over all entries in hashmap
+ * perf_hashmap__for_each_entry - iterate over all entries in hashmap
  * @map: hashmap to iterate
- * @cur: struct hashmap_entry * used as a loop cursor
+ * @cur: struct perf_hashmap_entry * used as a loop cursor
  * @bkt: integer used as a bucket loop cursor
  */
-#define hashmap__for_each_entry(map, cur, bkt)				    \
+#define perf_hashmap__for_each_entry(map, cur, bkt)				    \
 	for (bkt = 0; bkt < (map)->cap; bkt++)				    \
 		for (cur = (map)->buckets[bkt]; cur; cur = cur->next)
 
 /*
- * hashmap__for_each_entry_safe - iterate over all entries in hashmap, safe
+ * perf_hashmap__for_each_entry_safe - iterate over all entries in hashmap, safe
  * against removals
  * @map: hashmap to iterate
- * @cur: struct hashmap_entry * used as a loop cursor
- * @tmp: struct hashmap_entry * used as a temporary next cursor storage
+ * @cur: struct perf_hashmap_entry * used as a loop cursor
+ * @tmp: struct perf_hashmap_entry * used as a temporary next cursor storage
  * @bkt: integer used as a bucket loop cursor
  */
-#define hashmap__for_each_entry_safe(map, cur, tmp, bkt)		    \
+#define perf_hashmap__for_each_entry_safe(map, cur, tmp, bkt)		    \
 	for (bkt = 0; bkt < (map)->cap; bkt++)				    \
 		for (cur = (map)->buckets[bkt];				    \
 		     cur && ({tmp = cur->next; true; });		    \
 		     cur = tmp)
 
 /*
- * hashmap__for_each_key_entry - iterate over entries associated with given key
+ * perf_hashmap__for_each_key_entry - iterate over entries associated with given key
  * @map: hashmap to iterate
- * @cur: struct hashmap_entry * used as a loop cursor
+ * @cur: struct perf_hashmap_entry * used as a loop cursor
  * @key: key to iterate entries for
  */
-#define hashmap__for_each_key_entry(map, cur, _key)			    \
+#define perf_hashmap__for_each_key_entry(map, cur, _key)			    \
 	for (cur = (map)->buckets					    \
 		     ? (map)->buckets[hash_bits((map)->hash_fn((_key), (map)->ctx), (map)->cap_bits)] \
 		     : NULL;						    \
@@ -197,7 +197,7 @@ bool hashmap_find(const struct hashmap *map, long key, long *value);
 	     cur = cur->next)						    \
 		if ((map)->equal_fn(cur->key, (_key), (map)->ctx))
 
-#define hashmap__for_each_key_entry_safe(map, cur, tmp, _key)		    \
+#define perf_hashmap__for_each_key_entry_safe(map, cur, tmp, _key)		    \
 	for (cur = (map)->buckets					    \
 		     ? (map)->buckets[hash_bits((map)->hash_fn((_key), (map)->ctx), (map)->cap_bits)] \
 		     : NULL;						    \
@@ -205,4 +205,4 @@ bool hashmap_find(const struct hashmap *map, long key, long *value);
 	     cur = tmp)							    \
 		if ((map)->equal_fn(cur->key, (_key), (map)->ctx))
 
-#endif /* __LIBBPF_HASHMAP_H */
+#endif /* __PERF_UTIL_HASHMAP_H */
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index fb3ffa8d32ad..4dc5634aab0f 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -103,7 +103,7 @@ static const char *const hwmon_units[HWMON_TYPE_MAX] = {
 
 struct hwmon_pmu {
 	struct perf_pmu pmu;
-	struct hashmap events;
+	struct perf_hashmap events;
 	char *hwmon_dir;
 };
 
@@ -135,12 +135,12 @@ bool evsel__is_hwmon(const struct evsel *evsel)
 	return perf_pmu__is_hwmon(evsel->pmu);
 }
 
-static size_t hwmon_pmu__event_hashmap_hash(long key, void *ctx __maybe_unused)
+static size_t hwmon_pmu__event_perf_hashmap_hash(long key, void *ctx __maybe_unused)
 {
 	return ((union hwmon_pmu_event_key)key).type_and_num;
 }
 
-static bool hwmon_pmu__event_hashmap_equal(long key1, long key2, void *ctx __maybe_unused)
+static bool hwmon_pmu__event_perf_hashmap_equal(long key1, long key2, void *ctx __maybe_unused)
 {
 	return ((union hwmon_pmu_event_key)key1).type_and_num ==
 	       ((union hwmon_pmu_event_key)key2).type_and_num;
@@ -236,7 +236,7 @@ static void fix_name(char *p)
 static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 {
 	int err = 0;
-	struct hashmap_entry *cur, *tmp;
+	struct perf_hashmap_entry *cur, *tmp;
 	size_t bkt;
 	struct io_dirent64 *ent;
 	struct io_dir dir;
@@ -267,13 +267,13 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 		}
 		key.num = number;
 		key.type = type;
-		if (!hashmap__find(&pmu->events, key.type_and_num, &value)) {
+		if (!perf_hashmap__find(&pmu->events, key.type_and_num, &value)) {
 			value = zalloc(sizeof(*value));
 			if (!value) {
 				err = -ENOMEM;
 				goto err_out;
 			}
-			err = hashmap__add(&pmu->events, key.type_and_num, value);
+			err = perf_hashmap__add(&pmu->events, key.type_and_num, value);
 			if (err) {
 				free(value);
 				err = -ENOMEM;
@@ -317,10 +317,10 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 			close(fd);
 		}
 	}
-	if (hashmap__size(&pmu->events) == 0)
+	if (perf_hashmap__size(&pmu->events) == 0)
 		pr_debug2("hwmon_pmu: %s has no events\n", pmu->pmu.name);
 
-	hashmap__for_each_entry_safe((&pmu->events), cur, tmp, bkt) {
+	perf_hashmap__for_each_entry_safe((&pmu->events), cur, tmp, bkt) {
 		union hwmon_pmu_event_key key = {
 			.type_and_num = cur->key,
 		};
@@ -329,7 +329,7 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 		if (!test_bit(HWMON_ITEM_INPUT, value->items)) {
 			pr_debug("hwmon_pmu: %s removing event '%s%d' that has no input file\n",
 				pmu->pmu.name, hwmon_type_strs[key.type], key.num);
-			hashmap__delete(&pmu->events, key.type_and_num, &key, &value);
+			perf_hashmap__delete(&pmu->events, key.type_and_num, &key, &value);
 			zfree(&value->label);
 			zfree(&value->name);
 			free(value);
@@ -383,8 +383,8 @@ struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, const char *hwmon_dir,
 	}
 	INIT_LIST_HEAD(&hwm->pmu.format);
 	INIT_LIST_HEAD(&hwm->pmu.caps);
-	hashmap__init(&hwm->events, hwmon_pmu__event_hashmap_hash,
-		      hwmon_pmu__event_hashmap_equal, /*ctx=*/NULL);
+	perf_hashmap__init(&hwm->events, hwmon_pmu__event_perf_hashmap_hash,
+		      hwmon_pmu__event_perf_hashmap_equal, /*ctx=*/NULL);
 
 	list_add_tail(&hwm->pmu.list, pmus);
 	return &hwm->pmu;
@@ -393,17 +393,17 @@ struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, const char *hwmon_dir,
 void hwmon_pmu__exit(struct perf_pmu *pmu)
 {
 	struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
-	struct hashmap_entry *cur, *tmp;
+	struct perf_hashmap_entry *cur, *tmp;
 	size_t bkt;
 
-	hashmap__for_each_entry_safe((&hwm->events), cur, tmp, bkt) {
+	perf_hashmap__for_each_entry_safe((&hwm->events), cur, tmp, bkt) {
 		struct hwmon_pmu_event_value *value = cur->pvalue;
 
 		zfree(&value->label);
 		zfree(&value->name);
 		free(value);
 	}
-	hashmap__clear(&hwm->events);
+	perf_hashmap__clear(&hwm->events);
 	zfree(&hwm->hwmon_dir);
 }
 
@@ -459,13 +459,13 @@ static size_t hwmon_pmu__describe_items(struct hwmon_pmu *hwm, char *out_buf, si
 int hwmon_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb)
 {
 	struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
-	struct hashmap_entry *cur;
+	struct perf_hashmap_entry *cur;
 	size_t bkt;
 
 	if (hwmon_pmu__read_events(hwm))
 		return false;
 
-	hashmap__for_each_entry((&hwm->events), cur, bkt) {
+	perf_hashmap__for_each_entry((&hwm->events), cur, bkt) {
 		static const char *const hwmon_scale_units[HWMON_TYPE_MAX] = {
 			NULL,
 			"0.001V", /* cpu */
@@ -547,7 +547,7 @@ size_t hwmon_pmu__num_events(struct perf_pmu *pmu)
 	struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
 
 	hwmon_pmu__read_events(hwm);
-	return hashmap__size(&hwm->events);
+	return perf_hashmap__size(&hwm->events);
 }
 
 bool hwmon_pmu__have_event(struct perf_pmu *pmu, const char *name)
@@ -556,7 +556,7 @@ bool hwmon_pmu__have_event(struct perf_pmu *pmu, const char *name)
 	enum hwmon_type type;
 	int number;
 	union hwmon_pmu_event_key key = { .type_and_num = 0 };
-	struct hashmap_entry *cur;
+	struct perf_hashmap_entry *cur;
 	size_t bkt;
 
 	if (!parse_hwmon_filename(name, &type, &number, /*item=*/NULL, /*is_alarm=*/NULL))
@@ -567,12 +567,12 @@ bool hwmon_pmu__have_event(struct perf_pmu *pmu, const char *name)
 
 	key.type = type;
 	key.num = number;
-	if (hashmap_find(&hwm->events, key.type_and_num, /*value=*/NULL))
+	if (perf_hashmap_find(&hwm->events, key.type_and_num, /*value=*/NULL))
 		return true;
 	if (key.num != -1)
 		return false;
 	/* Item is of form <type>_ which means we should match <type>_<label>. */
-	hashmap__for_each_entry((&hwm->events), cur, bkt) {
+	perf_hashmap__for_each_entry((&hwm->events), cur, bkt) {
 		struct hwmon_pmu_event_value *value = cur->pvalue;
 
 		key.type_and_num = cur->key;
@@ -598,11 +598,11 @@ static int hwmon_pmu__config_term(const struct hwmon_pmu *hwm,
 				 * Item is of form <type>_ which means we should
 				 * match <type>_<label>.
 				 */
-				struct hashmap_entry *cur;
+				struct perf_hashmap_entry *cur;
 				size_t bkt;
 
 				attr->config = 0;
-				hashmap__for_each_entry((&hwm->events), cur, bkt) {
+				perf_hashmap__for_each_entry((&hwm->events), cur, bkt) {
 					union hwmon_pmu_event_key key = {
 						.type_and_num = cur->key,
 					};
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 7e39d469111b..655eed78d1bf 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -287,7 +287,7 @@ static bool contains_metric_id(struct evsel **metric_events, int num_events,
  * @metric_evlist: the list of perf events.
  * @out_metric_events: holds the created metric events array.
  */
-static int setup_metric_events(const char *pmu, struct hashmap *ids,
+static int setup_metric_events(const char *pmu, struct perf_hashmap *ids,
 			       struct evlist *metric_evlist,
 			       struct evsel ***out_metric_events)
 {
@@ -298,7 +298,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 	bool all_pmus = !strcmp(pmu, "all") || perf_pmus__num_core_pmus() == 1 || !is_pmu_core(pmu);
 
 	*out_metric_events = NULL;
-	ids_size = hashmap__size(ids);
+	ids_size = perf_hashmap__size(ids);
 
 	metric_events = calloc(ids_size + 1, sizeof(void *));
 	if (!metric_events)
@@ -326,7 +326,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 		 * combined or shared groups, this metric may not care
 		 * about this event.
 		 */
-		if (hashmap__find(ids, metric_id, &val_ptr)) {
+		if (perf_hashmap__find(ids, metric_id, &val_ptr)) {
 			pr_debug("Matched metric-id %s to %s\n", metric_id, evsel__name(ev));
 			metric_events[matched_events++] = ev;
 
@@ -560,7 +560,7 @@ static int metricgroup__build_event_string(struct strbuf *events,
 					   const char *modifier,
 					   bool group_events)
 {
-	struct hashmap_entry *cur;
+	struct perf_hashmap_entry *cur;
 	size_t bkt;
 	bool no_group = true, has_tool_events = false;
 	bool tool_events[TOOL_PMU__EVENT_MAX] = {false};
@@ -568,7 +568,7 @@ static int metricgroup__build_event_string(struct strbuf *events,
 
 #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
 
-	hashmap__for_each_entry(ctx->ids, cur, bkt) {
+	perf_hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		const char *sep, *rsep, *id = cur->pkey;
 		enum tool_pmu_event ev;
 
@@ -742,7 +742,7 @@ static int resolve_metric(struct list_head *metric_list,
 			  const struct visited_metric *visited,
 			  const struct pmu_metrics_table *table)
 {
-	struct hashmap_entry *cur;
+	struct perf_hashmap_entry *cur;
 	size_t bkt;
 	struct to_resolve {
 		/* The metric to resolve. */
@@ -759,7 +759,7 @@ static int resolve_metric(struct list_head *metric_list,
 	 * Iterate all the parsed IDs and if there's a matching metric and it to
 	 * the pending array.
 	 */
-	hashmap__for_each_entry(root_metric->pctx->ids, cur, bkt) {
+	perf_hashmap__for_each_entry(root_metric->pctx->ids, cur, bkt) {
 		struct pmu_metric pm;
 
 		if (pmu_metrics_table__find_metric(table, pmu, cur->pkey,
@@ -987,13 +987,13 @@ static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
 	struct expr_id_data *data;
 	int i, left_count, right_count;
 
-	left_count = hashmap__size(left->pctx->ids);
+	left_count = perf_hashmap__size(left->pctx->ids);
 	tool_pmu__for_each_event(i) {
 		if (!expr__get_id(left->pctx, tool_pmu__event_to_str(i), &data))
 			left_count--;
 	}
 
-	right_count = hashmap__size(right->pctx->ids);
+	right_count = perf_hashmap__size(right->pctx->ids);
 	tool_pmu__for_each_event(i) {
 		if (!expr__get_id(right->pctx, tool_pmu__event_to_str(i), &data))
 			right_count--;
@@ -1213,7 +1213,7 @@ static void find_tool_events(const struct list_head *metric_list,
 static int build_combined_expr_ctx(const struct list_head *metric_list,
 				   struct expr_parse_ctx **combined)
 {
-	struct hashmap_entry *cur;
+	struct perf_hashmap_entry *cur;
 	size_t bkt;
 	struct metric *m;
 	char *dup;
@@ -1225,7 +1225,7 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
 
 	list_for_each_entry(m, metric_list, nd) {
 		if (!m->group_events && !m->modifier) {
-			hashmap__for_each_entry(m->pctx->ids, cur, bkt) {
+			perf_hashmap__for_each_entry(m->pctx->ids, cur, bkt) {
 				dup = strdup(cur->pkey);
 				if (!dup) {
 					ret = -ENOMEM;
@@ -1267,7 +1267,7 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
 	int ret;
 
 	*out_evlist = NULL;
-	if (!metric_no_merge || hashmap__size(ids->ids) == 0) {
+	if (!metric_no_merge || perf_hashmap__size(ids->ids) == 0) {
 		bool added_event = false;
 		int i;
 		/*
@@ -1293,7 +1293,7 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
 				added_event = true;
 			}
 		}
-		if (!added_event && hashmap__size(ids->ids) == 0) {
+		if (!added_event && perf_hashmap__size(ids->ids) == 0) {
 			char *tmp = strdup("duration_time");
 
 			if (!tmp)
@@ -1341,7 +1341,7 @@ static int count_uses(struct list_head *metric_list, struct evsel *evsel)
 	int uses = 0;
 
 	list_for_each_entry(m, metric_list, nd) {
-		if (hashmap__find(m->pctx->ids, metric_id, NULL))
+		if (perf_hashmap__find(m->pctx->ids, metric_id, NULL))
 			uses++;
 	}
 	return uses;
@@ -1411,7 +1411,7 @@ static int parse_groups(struct evlist *perf_evlist,
 
 		ret = build_combined_expr_ctx(&metric_list, &combined);
 
-		if (!ret && combined && hashmap__size(combined->ids)) {
+		if (!ret && combined && perf_hashmap__size(combined->ids)) {
 			ret = parse_ids(metric_no_merge, fake_pmu, combined,
 					/*modifier=*/NULL,
 					/*group_events=*/false,
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 23337d2fa281..ace354b23501 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -422,16 +422,16 @@ static void perf_pmu_free_alias(struct perf_pmu_alias *alias)
 
 static void perf_pmu__del_aliases(struct perf_pmu *pmu)
 {
-	struct hashmap_entry *entry;
+	struct perf_hashmap_entry *entry;
 	size_t bkt;
 
 	if (!pmu->aliases)
 		return;
 
-	hashmap__for_each_entry(pmu->aliases, entry, bkt)
+	perf_hashmap__for_each_entry(pmu->aliases, entry, bkt)
 		perf_pmu_free_alias(entry->pvalue);
 
-	hashmap__free(pmu->aliases);
+	perf_hashmap__free(pmu->aliases);
 	pmu->aliases = NULL;
 }
 
@@ -443,7 +443,7 @@ static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
 	bool has_sysfs_event;
 	char event_file_name[NAME_MAX + 8];
 
-	if (hashmap__find(pmu->aliases, name, &alias))
+	if (perf_hashmap__find(pmu->aliases, name, &alias))
 		return alias;
 
 	if (!load || pmu->sysfs_aliases_loaded)
@@ -467,7 +467,7 @@ static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
 	}
 	if (has_sysfs_event) {
 		pmu_aliases_parse(pmu);
-		if (hashmap__find(pmu->aliases, name, &alias))
+		if (perf_hashmap__find(pmu->aliases, name, &alias))
 			return alias;
 	}
 
@@ -673,7 +673,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 		break;
 
 	}
-	hashmap__set(pmu->aliases, alias->name, alias, /*old_key=*/ NULL, &old_alias);
+	perf_hashmap__set(pmu->aliases, alias->name, alias, /*old_key=*/ NULL, &old_alias);
 	perf_pmu_free_alias(old_alias);
 	return 0;
 }
@@ -1189,7 +1189,7 @@ int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name)
 	if (!pmu->name)
 		return -ENOMEM;
 
-	pmu->aliases = hashmap__new(aliases__hash, aliases__equal, /*ctx=*/ NULL);
+	pmu->aliases = perf_hashmap__new(aliases__hash, aliases__equal, /*ctx=*/ NULL);
 	if (!pmu->aliases)
 		return -ENOMEM;
 
@@ -1304,7 +1304,7 @@ struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pm
 	pmu->cpus = cpu_map__online();
 
 	INIT_LIST_HEAD(&pmu->format);
-	pmu->aliases = hashmap__new(aliases__hash, aliases__equal, /*ctx=*/ NULL);
+	pmu->aliases = perf_hashmap__new(aliases__hash, aliases__equal, /*ctx=*/ NULL);
 	INIT_LIST_HEAD(&pmu->caps);
 	list_add_tail(&pmu->list, core_pmus);
 	return pmu;
@@ -2199,7 +2199,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		.event_type_desc = "Kernel PMU event",
 	};
 	int ret = 0;
-	struct hashmap_entry *entry;
+	struct perf_hashmap_entry *entry;
 	size_t bkt;
 
 	if (perf_pmu__is_tracepoint(pmu))
@@ -2211,7 +2211,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
-	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
+	perf_hashmap__for_each_entry(pmu->aliases, entry, bkt) {
 		struct perf_pmu_alias *event = entry->pvalue;
 		size_t buf_used, pmu_name_len;
 
@@ -2714,7 +2714,7 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 
 const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 {
-	struct hashmap_entry *entry;
+	struct perf_hashmap_entry *entry;
 	size_t bkt;
 
 	if (!pmu)
@@ -2722,7 +2722,7 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
-	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
+	perf_hashmap__for_each_entry(pmu->aliases, entry, bkt) {
 		struct perf_pmu_alias *event = entry->pvalue;
 		struct perf_event_attr attr = {.config = 0,};
 		int ret = perf_pmu__parse_terms_to_attr(pmu, event->terms, &attr);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 0d9f3c57e8e8..43413860f5a9 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -14,7 +14,7 @@
 #include "mem-events.h"
 
 struct evsel_config_term;
-struct hashmap;
+struct perf_hashmap;
 struct perf_cpu_map;
 struct print_callbacks;
 
@@ -142,7 +142,7 @@ struct perf_pmu {
 	 * event read from <sysfs>/bus/event_source/devices/<name>/events/ or
 	 * from json events in pmu-events.c.
 	 */
-	struct hashmap *aliases;
+	struct perf_hashmap *aliases;
 	/**
 	 * @events_table: The events table for json events in pmu-events.c.
 	 */
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index c6ae0ae8d86a..80a5535089e0 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -164,7 +164,7 @@ static size_t get_counter_name_hash_fn(long key, void *ctx __maybe_unused)
 	return key;
 }
 
-static bool get_counter_name_hashmap_equal_fn(long key1, long key2, void *ctx __maybe_unused)
+static bool get_counter_name_perf_hashmap_equal_fn(long key1, long key2, void *ctx __maybe_unused)
 {
 	return key1 == key2;
 }
@@ -176,7 +176,7 @@ static bool get_counter_name_hashmap_equal_fn(long key1, long key2, void *ctx __
  */
 static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
 {
-	static struct hashmap *cache;
+	static struct perf_hashmap *cache;
 	static struct perf_pmu *cache_pmu;
 	long cache_key = get_counterset_start(set) + nr;
 	struct get_counter_name_data data = {
@@ -188,7 +188,7 @@ static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
 	if (!pmu)
 		return NULL;
 
-	if (cache_pmu == pmu && hashmap__find(cache, cache_key, &result))
+	if (cache_pmu == pmu && perf_hashmap__find(cache, cache_key, &result))
 		return strdup(result);
 
 	perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=*/ true,
@@ -197,8 +197,8 @@ static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
 	result = strdup(data.result ?: "<unknown>");
 
 	if (cache_pmu == NULL) {
-		struct hashmap *tmp = hashmap__new(get_counter_name_hash_fn,
-						   get_counter_name_hashmap_equal_fn,
+		struct perf_hashmap *tmp = perf_hashmap__new(get_counter_name_hash_fn,
+						   get_counter_name_perf_hashmap_equal_fn,
 						   /*ctx=*/NULL);
 
 		if (!IS_ERR(tmp)) {
@@ -211,7 +211,7 @@ static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
 		char *old_value = NULL, *new_value = strdup(result);
 
 		if (new_value) {
-			hashmap__set(cache, cache_key, new_value, /*old_key=*/NULL, &old_value);
+			perf_hashmap__set(cache, cache_key, new_value, /*old_key=*/NULL, &old_value);
 			/*
 			 * Free in case of a race, but resizing would be broken
 			 * in that case.
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 976a06e63252..81b266c5d4f5 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -304,7 +304,7 @@ static bool pkg_id_equal(long __key1, long __key2, void *ctx __maybe_unused)
 static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
 			 int cpu_map_idx, bool *skip)
 {
-	struct hashmap *mask = counter->per_pkg_mask;
+	struct perf_hashmap *mask = counter->per_pkg_mask;
 	struct perf_cpu_map *cpus = evsel__cpus(counter);
 	struct perf_cpu cpu = perf_cpu_map__cpu(cpus, cpu_map_idx);
 	int s, d, ret = 0;
@@ -319,7 +319,7 @@ static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
 		return 0;
 
 	if (!mask) {
-		mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
+		mask = perf_hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
 		if (IS_ERR(mask))
 			return -ENOMEM;
 
@@ -354,11 +354,11 @@ static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
 		return -ENOMEM;
 
 	*key = (uint64_t)d << 32 | s;
-	if (hashmap__find(mask, key, NULL)) {
+	if (perf_hashmap__find(mask, key, NULL)) {
 		*skip = true;
 		free(key);
 	} else
-		ret = hashmap__add(mask, key, 1);
+		ret = perf_hashmap__add(mask, key, 1);
 
 	return ret;
 }
diff --git a/tools/perf/util/threads.c b/tools/perf/util/threads.c
index 6ca0b178fb6c..44a2bd5bc011 100644
--- a/tools/perf/util/threads.c
+++ b/tools/perf/util/threads.c
@@ -25,7 +25,7 @@ void threads__init(struct threads *threads)
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
 
-		hashmap__init(&table->shard, key_hash, key_equal, NULL);
+		perf_hashmap__init(&table->shard, key_hash, key_equal, NULL);
 		init_rwsem(&table->lock);
 		table->last_match = NULL;
 	}
@@ -37,7 +37,7 @@ void threads__exit(struct threads *threads)
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
 
-		hashmap__clear(&table->shard);
+		perf_hashmap__clear(&table->shard);
 		exit_rwsem(&table->lock);
 	}
 }
@@ -50,7 +50,7 @@ size_t threads__nr(struct threads *threads)
 		struct threads_table_entry *table = &threads->table[i];
 
 		down_read(&table->lock);
-		nr += hashmap__size(&table->shard);
+		nr += perf_hashmap__size(&table->shard);
 		up_read(&table->lock);
 	}
 	return nr;
@@ -97,7 +97,7 @@ struct thread *threads__find(struct threads *threads, pid_t tid)
 	down_read(&table->lock);
 	res = __threads_table_entry__get_last_match(table, tid);
 	if (!res) {
-		if (hashmap__find(&table->shard, tid, &res))
+		if (perf_hashmap__find(&table->shard, tid, &res))
 			res = thread__get(res);
 	}
 	up_read(&table->lock);
@@ -115,11 +115,11 @@ struct thread *threads__findnew(struct threads *threads, pid_t pid, pid_t tid, b
 	down_write(&table->lock);
 	res = thread__new(pid, tid);
 	if (res) {
-		if (hashmap__add(&table->shard, tid, res)) {
+		if (perf_hashmap__add(&table->shard, tid, res)) {
 			/* Add failed. Assume a race so find other entry. */
 			thread__put(res);
 			res = NULL;
-			if (hashmap__find(&table->shard, tid, &res))
+			if (perf_hashmap__find(&table->shard, tid, &res))
 				res = thread__get(res);
 		} else {
 			res = thread__get(res);
@@ -136,15 +136,15 @@ void threads__remove_all_threads(struct threads *threads)
 {
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
-		struct hashmap_entry *cur, *tmp;
+		struct perf_hashmap_entry *cur, *tmp;
 		size_t bkt;
 
 		down_write(&table->lock);
 		__threads_table_entry__set_last_match(table, NULL);
-		hashmap__for_each_entry_safe(&table->shard, cur, tmp, bkt) {
+		perf_hashmap__for_each_entry_safe(&table->shard, cur, tmp, bkt) {
 			struct thread *old_value;
 
-			hashmap__delete(&table->shard, cur->key, /*old_key=*/NULL, &old_value);
+			perf_hashmap__delete(&table->shard, cur->key, /*old_key=*/NULL, &old_value);
 			thread__put(old_value);
 		}
 		up_write(&table->lock);
@@ -160,7 +160,7 @@ void threads__remove(struct threads *threads, struct thread *thread)
 	if (table->last_match && RC_CHK_EQUAL(table->last_match, thread))
 		__threads_table_entry__set_last_match(table, NULL);
 
-	hashmap__delete(&table->shard, thread__tid(thread), /*old_key=*/NULL, &old_value);
+	perf_hashmap__delete(&table->shard, thread__tid(thread), /*old_key=*/NULL, &old_value);
 	thread__put(old_value);
 	up_write(&table->lock);
 }
@@ -171,11 +171,11 @@ int threads__for_each_thread(struct threads *threads,
 {
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
-		struct hashmap_entry *cur;
+		struct perf_hashmap_entry *cur;
 		size_t bkt;
 
 		down_read(&table->lock);
-		hashmap__for_each_entry(&table->shard, cur, bkt) {
+		perf_hashmap__for_each_entry(&table->shard, cur, bkt) {
 			int rc = fn((struct thread *)cur->pvalue, data);
 
 			if (rc != 0) {
diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
index da68d2223f18..fb1dccd23ee1 100644
--- a/tools/perf/util/threads.h
+++ b/tools/perf/util/threads.h
@@ -12,7 +12,7 @@ struct thread;
 
 struct threads_table_entry {
 	/* Key is tid, value is struct thread. */
-	struct hashmap	       shard;
+	struct perf_hashmap	       shard;
 	struct rw_semaphore    lock;
 	struct thread	       *last_match;
 };
-- 
2.53.0.959.g497ff81fa9-goog

