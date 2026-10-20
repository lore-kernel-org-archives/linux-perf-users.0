Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514241;
	b=mc2cDYccMOQ9EYttKZlosK8lpvpjgjcqPner3cTKuGzT8MA8FDIxjoSMXI3SbGwZ6GFD
	 6YRX9sLU0tT/nOLhq8XrLRPK96pWAReVYaDCmtHUGONlUWSPc0du54NV8DPJQwonSKqBX
	 wF6FP+43Ogun+GcS+BDVCY3GwUOoJ0U82fN36ZBGPL1pAMmJyYmWY3lk3vkZxyAVoywcX
	 L7N1Kkq8PN/8tjQv5sWFqhMzZAfuvzyX5LRro17RL72LaCv8YqFEDruwPPH+3gc8B6x6G
	 81V7dKVGAeX/bMd4nLlVhNrjDOSj4cfsTFZ+AmhEUOufSEHEqguBatNSziW1MzwP0ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=m5CCUC1R4M25rKM1gT3H/lRe4lKcFq/fltsw3UkJoHQ=;
	b=Ljj2SitUW7N6MyVubIAkeq2arWRH9knb51OQx90OafEauE3XOFSzMUAFLcX7QzIUk/21
	 6iil0KD05h9CXiRJ+ZbFoPWFh8bFwVh8qyHPjqdXKJfCGhCYNrgXfZCruEBHIGwiDfPz0
	 8PXdv/fSijZhchVTOds7Q8sWAspUmvBJaT4CIYkt8dOaFc2AVp89qnrVEakXH73tfJwVZ
	 spvwIwv9qx6XD4p0XDNQyJzvckKeECnQ0e/jBTXUFgUhFaL8IhYINqfRWZugFkggtfJ/L
	 Dy4WjuR/ehos1FCpeycyD8O/zV8nt1sCuEneK9X7bGJKNP2YW6g2+nbuwaDU7F34mtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GG7dhSgP;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA660A4ADA
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 16:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63EA660A4ADA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GG7dhSgP
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-359b81ad4e8so5930630eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 09:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792514241; x=1793119041; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m5CCUC1R4M25rKM1gT3H/lRe4lKcFq/fltsw3UkJoHQ=;
        b=GG7dhSgPI8FfHbKxp7z6cIdbA3rzDlRjnwut15uFJlKNXcWIpdOdDvVvCPK07cL8hQ
         Z518P6Dr5JYQBrTnzdBxkPk/zfqRtcKPY++CxFSlaMwGWypwqOO1vmEK4RhDSw0lc9m5
         46kjwG9YUlIsI5VtGpi9XG+pfHFpfbmE6vybDxOxBwnPK9ONqB5MveRvGYMBpGCbeRI2
         gQsg7obmOhWCYIpE2hfueGRu46gPBSyMOaEpW/+vw9aGGdE6zg8xcgBPxuyBrZS7+qGK
         qRP+hdcf+MRgQNwuGUOmv9BauGEd9omY8J023KW9JDBYGnY4fB2/tEF5Ul65QeRG2kRW
         jOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514241; x=1793119041;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m5CCUC1R4M25rKM1gT3H/lRe4lKcFq/fltsw3UkJoHQ=;
        b=itFJml05w6Z51Hu/An+kOlI+MbOrq2DVNc23gek+mkioRPrUR220naWLC9dLGj9LYc
         2SyR9Sx2UXXh/UjKS+NyNTYWpxZrNDapxHWtLpBll5wCDcaYI+IQK1Wtf8BalcAW6Jum
         TSSuWXXgSY+lpnrP3VsBhneJKNPZQYBSvM1/RdIS1Kw4HcC1bzY8J614q3fr/llxCRpF
         8DvwfOmF5fBR3KW4zPNjWegdimkvNpGaVqfnKs8ObafdGBeOXRoEeB78++e8gc4y+1u/
         fY2Spjj+pFsUYTalQxHO0HX35eNvYpEWnApkym177E5/3hZ8wfcCB+AtdmGHnQANNhDR
         qCtA==
X-Forwarded-Encrypted: i=1; AKwUvBw2xpdG2IuHoFSqEmUBnZ470d0yDEmKJeC68uBk2WOf0IAVkaUZdnnHVKEcDDbIhJJEUJnkOc+e+Depo4SPz94Q@vger.kernel.org
X-Gm-Message-State: AFq9FYL1HUoYDPRGa5m1mndjfoeJQtCTIj1XJCBY/tVIDYbpIRG4sZFp
	YxjVWavbFiScc/xy+XTIiJFHhq3TRUsoIOi1BxYh4inadzXCuRZ0+Hr3hyCWNNyYfH/tiaz1mlS
	fA01nvX5Y/g==
X-Received: from dleb11-n1.prod.google.com ([2002:a05:701b:424b:10b0:18f:1989:2d7b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:455a:10b0:14f:8d59:edcc
 with SMTP id a92af1059eb24-185118ee7a8mr14774194c88.12.1792514240285; Tue, 20
 Oct 2026 09:37:20 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:36:35 -0700
In-Reply-To: <20261020163640.746159-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261016221700.1282659-1-irogers@google.com> <20261020163640.746159-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020163640.746159-13-irogers@google.com>
Subject: [PATCH v5 12/17] perf thread: Expand context analysis annotations to
 threads and namespaces_lock
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Annotate shard and last_match in struct threads_table_entry with
__guarded_by(&lock) and add __must_hold_shared()/__must_hold() to the
last_match helpers in util/threads.c.

In util/thread.h and util/thread.c, add __returns_ctx_lock() to
thread__namespaces_lock() and thread__comm_lock(), annotate
namespaces_list and comm_list with __guarded_by(), and add
__must_hold_shared()/__must_hold() to the namespaces_list helpers.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/thread.c  |  2 ++
 tools/perf/util/thread.h  | 28 +++++++++++++++++-----------
 tools/perf/util/threads.c |  4 ++++
 tools/perf/util/threads.h |  6 +++---
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 616d5bf87baf..af761b1fc5d5 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -149,6 +149,7 @@ void thread__put(struct thread *thread)
 }
 
 static struct namespaces *__thread__namespaces(struct thread *thread)
+	__must_hold_shared(thread__namespaces_lock(thread))
 {
 	if (list_empty(thread__namespaces_list(thread)))
 		return NULL;
@@ -169,6 +170,7 @@ struct namespaces *thread__namespaces(struct thread *thread)
 
 static int __thread__set_namespaces(struct thread *thread, u64 timestamp,
 				    struct perf_record_namespaces *event)
+	__must_hold(thread__namespaces_lock(thread))
 {
 	struct namespaces *new, *curr = __thread__namespaces(thread);
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 9d0ce7742c06..a7850eebce4e 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -48,10 +48,10 @@ DECLARE_RC_STRUCT(thread) {
 	bool			exited;
 	bool			comm_set;
 	int			comm_len;
-	struct list_head	namespaces_list;
 	struct rw_semaphore	namespaces_lock;
-	struct list_head	comm_list;
+	struct list_head	namespaces_list __guarded_by(&namespaces_lock);
 	struct rw_semaphore	comm_lock;
+	struct list_head	comm_list __guarded_by(&comm_lock);
 	u64			db_id;
 
 	void			*priv;
@@ -230,30 +230,36 @@ static inline void thread__set_comm_len(struct thread *thread, int len)
 	RC_CHK_ACCESS(thread)->comm_len = len;
 }
 
-static inline struct list_head *thread__namespaces_list(struct thread *thread)
+static inline struct rw_semaphore *thread__namespaces_lock(const struct thread *thread)
+	__returns_ctx_lock(&RC_CHK_ACCESS(thread)->namespaces_lock)
 {
-	return &RC_CHK_ACCESS(thread)->namespaces_list;
+	return (struct rw_semaphore *)&RC_CHK_ACCESS(thread)->namespaces_lock;
 }
 
-static inline int thread__namespaces_list_empty(const struct thread *thread)
+static inline struct list_head *thread__namespaces_list(struct thread *thread)
+	__must_hold_shared(thread__namespaces_lock(thread))
 {
-	return list_empty(&RC_CHK_ACCESS(thread)->namespaces_list);
+	/* Readers hold the shared lock; writers hold the exclusive lock. */
+	return context_unsafe(&RC_CHK_ACCESS(thread)->namespaces_list);
 }
 
-static inline struct rw_semaphore *thread__namespaces_lock(struct thread *thread)
+static inline int thread__namespaces_list_empty(const struct thread *thread)
+	__must_hold_shared(thread__namespaces_lock(thread))
 {
-	return &RC_CHK_ACCESS(thread)->namespaces_lock;
+	return list_empty(&RC_CHK_ACCESS(thread)->namespaces_list);
 }
 
-static inline struct rw_semaphore *thread__comm_lock(struct thread *thread)
+static inline struct rw_semaphore *thread__comm_lock(const struct thread *thread)
+	__returns_ctx_lock(&RC_CHK_ACCESS(thread)->comm_lock)
 {
-	return &RC_CHK_ACCESS(thread)->comm_lock;
+	return (struct rw_semaphore *)&RC_CHK_ACCESS(thread)->comm_lock;
 }
 
 static inline struct list_head *thread__comm_list(struct thread *thread)
 	__must_hold_shared(thread__comm_lock(thread))
 {
-	return &RC_CHK_ACCESS(thread)->comm_list;
+	/* Readers hold the shared lock; writers hold the exclusive lock. */
+	return context_unsafe(&RC_CHK_ACCESS(thread)->comm_list);
 }
 
 static inline u64 thread__db_id(const struct thread *thread)
diff --git a/tools/perf/util/threads.c b/tools/perf/util/threads.c
index 6ca0b178fb6c..39b3c420635a 100644
--- a/tools/perf/util/threads.c
+++ b/tools/perf/util/threads.c
@@ -21,6 +21,7 @@ static bool key_equal(long key1, long key2, void *ctx __maybe_unused)
 }
 
 void threads__init(struct threads *threads)
+	__context_unsafe(/* initialization */)
 {
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
@@ -32,6 +33,7 @@ void threads__init(struct threads *threads)
 }
 
 void threads__exit(struct threads *threads)
+	__context_unsafe(/* teardown */)
 {
 	threads__remove_all_threads(threads);
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
@@ -63,6 +65,7 @@ size_t threads__nr(struct threads *threads)
  */
 static struct thread *__threads_table_entry__get_last_match(struct threads_table_entry *table,
 							    pid_t tid)
+	__must_hold_shared(&table->lock)
 {
 	struct thread *th, *res = NULL;
 
@@ -76,6 +79,7 @@ static struct thread *__threads_table_entry__get_last_match(struct threads_table
 
 static void __threads_table_entry__set_last_match(struct threads_table_entry *table,
 						  struct thread *th)
+	__must_hold(&table->lock)
 {
 	thread__put(table->last_match);
 	table->last_match = thread__get(th);
diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
index da68d2223f18..54fba16657db 100644
--- a/tools/perf/util/threads.h
+++ b/tools/perf/util/threads.h
@@ -11,10 +11,10 @@ struct thread;
 #define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
 
 struct threads_table_entry {
-	/* Key is tid, value is struct thread. */
-	struct hashmap	       shard;
 	struct rw_semaphore    lock;
-	struct thread	       *last_match;
+	/* Key is tid, value is struct thread. */
+	struct hashmap	       shard __guarded_by(&lock);
+	struct thread	       *last_match __guarded_by(&lock);
 };
 
 struct threads {
-- 
2.56.0.212.g129ede20d9-goog

