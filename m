Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700142;
	b=344t6rsCxlITcjIJrIvoz/thhEfT1eGA1TccrcNYc5LqxjIOKUkExx5pkR+gXxX4JN/r
	 KMtEN21szG5PRwv9MBf0j+jqi4YQxhFpboNyItjA5yYfF2Jm6kz1JEj3u60gI+Ame1Xmz
	 logSzO4wagI1tyPI1aaFzZug4U0qPscZVpQkk9vTHvSE6vqZbeFarP9dEDAsYSccFG7Y/
	 2tqpAaMMmRx8eaJsEXzKfj3dhHjeQbnkMtwdEb3v6EZT2bxYve0lN9Vl04uUW6xDI820I
	 JPcEqpoHzi9fVm6Ml/tBaDsyHXb4MGS9dDjZX08IWZJIhsX/0yXqFPbgHWdrLqAT7+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700142;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=epHYqq259OlvmbM5bUfE9T1RK5z8edIqXpc6UY2H9Ks=;
	b=HHagKPnQxzuofVlR4Fzwlwhk2J6RilE9CtyvO7p3BT6WKhVeBv5xcXtDTuEZtfXp0inL
	 SA5w0gfaOVio8TsuDTcvZnD2p9GLLFsp6SzjBJecSRTqTEvmHX8cigi0cUiu+sl4vwk3D
	 IX5+qNZ7mgDdM8GGWV35DgmBOPiHCkpczu9jZLTxAy7KSpU5WhQJpbJP9CUmuAPBtVS+d
	 yKfxfC9gBvRs8IkRvdpYFzhxR15Stxp3893FSLL9g05Z5HqQwnwyGirYMUZVrCC4gEIIz
	 0YLZ64IHzm/ovjcf9CdztrHd/ablT0zfSZNMn3YCdL8ljF0n11wTbTlpQfhjDVYZCyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pig3D3O8;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC2160A2602
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CC2160A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pig3D3O8
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-17dc865c94cso120524c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 13:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792700141; x=1793304941; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=epHYqq259OlvmbM5bUfE9T1RK5z8edIqXpc6UY2H9Ks=;
        b=pig3D3O8lLh73bJyvZFnj160+oAf4Yr9TS8vbnRHUlfhOC0d6QBxFmZF/RCwzLCWhb
         Fry/LOKMyQ7mpp5aROw+3JzlliZqALH2D3ZAg3rtItJZADIqgzua8NEmFcAuOH3VWhhb
         0oYlFtyfIYw5OgSYU6q6KFhMTKsGayupuhFyrwXBHWYy+1rjcBiB+8xEtFGwwiERuK4I
         G2oZDHfaCzoPhAu4UaTznJqezGhw45yhjpveOBqRUr/I9Eae6Na2JylA7nJIMWcE1tog
         S8kWf0zsbiirbmzVqeocTgc7DOlh3M5iRWrWQBGvdEF9Q34PI0wVDF/vOtI8Bb93rUjW
         IAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700141; x=1793304941;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=epHYqq259OlvmbM5bUfE9T1RK5z8edIqXpc6UY2H9Ks=;
        b=los4W3PZTxm00iZ/QKRZayg8ilfShv9EDFSWaixcyepkDxsTnQl07FBSgu5l6aK/N7
         REBLn/IBIQR85LDiVT2s+Frigphrl11yuynp+B1Nh41YEYZe6qJKvigBYymDhNkp0ezX
         /kaNVkKRzUsIYDaFEEN9+J+nAcv2NFR1mlg0czHYrTM5aIx6KsxfcZ6+Utu+E1ZL4iUO
         Q2KFruCBMJMdkMqMiCshJtj7tm8gYt95t9gvmPtsGBDsO2D4Q42jjP40g4wU7r8Ur7sO
         u2DLUdFb3c4CbZKEmoxSzpMSJUOzR4BrjG0PTDCjli3KP5qPVS6lNOy1RkpZeultF2iD
         LTVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzaO8b4BhbmiDwqzzqany8dDIvqA42epwaNyDnMTKcqA+qj+eCL9a5VZFudENhNy20JlzAzQkGe9Y0FM8tQ4oJy@vger.kernel.org
X-Gm-Message-State: AFq9FYI8aSAPPfEz2NuJiIeksy/RPx2DrpJp8Gi3u/KDK3Idk+g6hvYF
	HHvik2Baa3eZlHq3xCGGjOsvqpzTzRg3MFY7XT5Z4n1v6Z7ye0glbJzWiE2klDOEoVQLXi3iWT7
	szI+v/0Oyzw==
X-Received: from dlam18-n1.prod.google.com ([2002:a05:701b:2092:10b0:15d:bfd9:370b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:404:b0:147:8a40:cdf3
 with SMTP id a92af1059eb24-195c5ad11d9mr579396c88.24.1792700140868; Thu, 22
 Oct 2026 13:15:40 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:14:47 -0700
In-Reply-To: <20261022201453.1717523-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021223905.715051-1-irogers@google.com> <20261022201453.1717523-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022201453.1717523-15-irogers@google.com>
Subject: [PATCH v8 14/19] perf thread: Expand context analysis annotations to
 threads and namespaces_lock
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, elver@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org, 
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
2.56.0.307.g5fe7bd680c-goog

