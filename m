Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B4341E6D9
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189125; cv=none; b=grodFq8ESyLm7vBta2Uj7zM451cNK69IOrUOoKLL7Rl9LCRtQReXraaewk8p39MHhdJddbhHQNBM9hPTmQ0C7bVkCPVU4oBMQ9AaqQ1OqSaRSs+OI9uivMTm2GnbmphvtppRhBpazqXWGSekId8Oe4FTXwRQ3qxInQk0S8BFyKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189125; c=relaxed/simple;
	bh=fdF52suTdeR8LGm7JoZ9Yc+IEQ6ItpPYArn7ZheNM1s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DK3jjkE0Et6Jzv9P1vP3i9hXsf9TnIv6+/dyKg1f2YSIDbK5Ps21M9yooI7DRaXXn/NgjxrG0RiLVvwsB8+TFV3VstUnwJvT+8r0+NDkA/mSlIGyYpwgPIzeOV975FlK+XwGsQJrI9oTXtx1c12Jnk9e/+yOvbnO6Txc6NMAhEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uc9LCif/; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uc9LCif/"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3425098ae4bso2008695eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 15:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792189122; x=1792793922; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m5CCUC1R4M25rKM1gT3H/lRe4lKcFq/fltsw3UkJoHQ=;
        b=uc9LCif/8HNrx7N5iD0uWwq9IXdFxeGLRcHHxl9A71dqqRAiaZIyH3loZXmWIL5ZKO
         SLEKlJES0MQdrZHY7gzjvP/t8PuGj91zILhoIUpVbSCh9CpUWSvSY0lamRo4KpikFTYG
         yrzRwFqwK1jlwAVm2hbQyAQ7YfpvQFvlVt7czmQHCL0+gOzglJy3mKzxjR8X3+SHsEvK
         zLrLU0t0iLlP7Tjg0tYmLiYA4JWnwpfvSlv+18mtIic9r4Bi21dE+hIBvHuRpFdd9NRi
         vuFm/zWcZswP0pN4Uhg94tnK3ExpBVfH1zAQyOJc2lUE44ww7Kg/NP8d9Zs79guKWAch
         hw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792189122; x=1792793922;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m5CCUC1R4M25rKM1gT3H/lRe4lKcFq/fltsw3UkJoHQ=;
        b=p7tn3wArj1EFCiGyGcDrf5Lot0Uq/aMOernTjQHghPfYNgUDf1ITx1UyYw83YfA9WR
         J6QER78hSoM2G2S1yo9hwYJa3StnP0az6IxcMQrfYHcvkYN//rhIdUux10NroBBvpp9p
         UpK+ZJ137ae8dTPBYOcHOophydhPR5Xp9itU4V0WIiHj1DnhQqC9jNZCr+OxtdxPa69p
         IzuUao5/ivvjkGMdUhfXjoSIqQZOm0XobvBMfJ7Hi5Z67exU/6riM1kRT9ojuHQkmbXD
         ZZlLC/9f2T+1WyZe3NerU2lrsBy2VKmXbPwJs2muFJYun0H3Pk1pEjtSfc7+2Y1drXw/
         ohag==
X-Forwarded-Encrypted: i=1; AKwUvBzEm0NHk8um8Xhu9WrBWtx/7H7rW/DSJ5i9upXZZMYScrU1E42UYECfGa9lF3s0ih/RbT8u5H/QahPv6XbGs+D4@vger.kernel.org
X-Gm-Message-State: AFq9FYLZpbtM+wt1TN5qZCVSNW82jvcW8v19RQ3OFGlYbmi8ecJ7T0PM
	b8bavxqL3bSJDLKK0Q1668QHupyGYdiq8MmK7JzW+UFMta4H3r7+Y9qOOqS6P/j8JsJ1IwlW2ch
	NOD+tNOEOJw==
X-Received: from dlbrl27.prod.google.com ([2002:a05:7022:f51b:b0:168:6cd7:1061])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3c82:b0:143:1bb1:3300
 with SMTP id a92af1059eb24-1825a3874a2mr3968473c88.17.1792189121963; Fri, 16
 Oct 2026 15:18:41 -0700 (PDT)
Date: Fri, 16 Oct 2026 15:16:55 -0700
In-Reply-To: <20261016221700.1282659-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016173106.679725-1-irogers@google.com> <20261016221700.1282659-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016221700.1282659-13-irogers@google.com>
Subject: [PATCH v4 12/17] perf thread: Expand context analysis annotations to
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

