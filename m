Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825991;
	b=3Wg8t8iNFM75q35K4uW4D9OxFZvt3/xVnuxW4qGGSI8q/aENRetkE3u4Qee02lYikcGx
	 O1TKEiuDHshRMqwWl3R0ABkgBPCMNAPX0kR1PKwslJT9ekbGukHRUozT3F7CRUe2HQuqi
	 L7qk86IBwWo+N7U3YOfS7tmLNnp33anUO/gFks7QzJO9+tTIh+fq8OUq89AVpQTySJFtR
	 +qo3ZESg81P7KtqLu+ztAhTCdhGsAFsNFRwP9E44HeclFSdOo40wktyCQos32hE5DGkI+
	 aJAqE7Vu3s0a4VRUG+eFNih4VYNZPxRuQandUSN5Jri1teNz15XoOhR5o0D2Wqdr3uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=o7CTrAhrkmxdP5PCIw1MA98wNNK+lzvPv6pZbJYyzjo=;
	b=w6P/MRimJnbgCDDvn5ZPmdde8UYGXz4z9cocJ8Gb1hZaIJ/TUhb63JnM1dgeEsZnKzJI
	 zmQwCYEchMqNThTxmOEYfViw7PHDKMNzzjGiMIgp6SPQN5G38WpuKUI8pOjm7iVpDMCL3
	 n+U2UJaeXACSonlCU0aeRJ5tyLwClVw2qNcHSaBX8ADOtUbn3akFporxLaaHrAwE5s8Zk
	 rNWFi4TjESB3Hm/kK6u0s6HSLfDpV7uwvM0Y7XgYFZboDmayU71KbMPUtBBfTbqe4o4te
	 T8ulsB1LiJ0wXertXrp5ykRVZLIAjnuu9excUqS9u2b7dzRCymJQ+0/6ImBTxfGVx6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BVe1hekJ;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45AF6078977
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 20:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A45AF6078977
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BVe1hekJ
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso2043516eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 12:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793825990; x=1794430790; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o7CTrAhrkmxdP5PCIw1MA98wNNK+lzvPv6pZbJYyzjo=;
        b=BVe1hekJk3Sawp9GpROn/LtJ1GLeIJ5CFqU67RQD5a59Zzs9+JEEaxqNJ/BJKeaNCM
         cbIA5RDKzkxNc8GzUf4RHdsFjFf8gRHc0w/XZlHKe6epzxXG5mJDHzj1ilKYTGQwHVK6
         PzCQgz9+/5ZjyUwEitr8xZaVrGioJGv03xJ5ur0gjKidOY5Z4v2or7V/8HGlT7/vhYwX
         5AQn9J+XhBq/r/PpXEzSMcmDP7fI3qUoG2DruaZlte0akE8b5tWcfNlhRQIsy/msT7zq
         UrgNjjWdr7B+DFuXjyMuDgvs4WkyQBLT0VobqClvp7R7NQFErRzMPSiYdpCmIS2zkzIF
         OIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825990; x=1794430790;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o7CTrAhrkmxdP5PCIw1MA98wNNK+lzvPv6pZbJYyzjo=;
        b=oiFEYp1iArykjFpOKaTD3gOfNiLUPFcWjoZNcparPsrYNMrxITRz5Xgg9pLhVqcbog
         /cXFzjyTNU6SRph7wJGfqIZNOhoBLOaZM8egoqrK2A5G4ghjWY/i5gLjpp+g/O7etbLK
         vmGZMQBT83wOaZ4Ky2pHDsZM0QWRpMQmIsKlmnQ0LVInPDqsrdEw33Tp7vuS/ErHW3yc
         vvR5im4DmafOB/16/WhyoBuN+HONBhLtzLxlemzbTADx23bKvwlndMrY9VFtzoChO7wg
         mWPENBhi6LAED2No8E218whtQ+RJqxE+/ICFnJihRFJamufh1TlAn4ZAp+EIuKoU1rzM
         d4bA==
X-Forwarded-Encrypted: i=1; AKwUvByKTu4JQ/wQCsHiLk0vnUDAkMNvCkyAx4pESRj1kosDPvK9tnrW3DsCmaiE/5Bstf1qNlDqN1jHy9vd4VWu/JC2@vger.kernel.org
X-Gm-Message-State: APuU4Z+X6y3nEsfSz1heaW5Ip1vXY0xfGMnEUElHREDZowHFWyAdAAuM
	bZYpyK6ymFHF4lvhHBDjLU70xSJNDoP/fjc/Gk1bdOYmwR4yMfdPx0KNftiQ71YHktI0WbEHN1g
	Adb1MlbU8jg==
X-Received: from dyrp17.prod.google.com ([2002:a05:693c:69d1:b0:369:f864:c5e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d0a5:b0:36a:1b23:a1cd
 with SMTP id 5a478bee46e88-36a4239359bmr23699630eec.9.1793825989560; Wed, 04
 Nov 2026 12:59:49 -0800 (PST)
Date: Wed,  4 Nov 2026 12:59:04 -0800
In-Reply-To: <20261104205909.2078411-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104205909.2078411-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261104205909.2078411-15-irogers@google.com>
Subject: [PATCH v9 14/19] perf thread: Expand context analysis annotations to
 threads and namespaces_lock
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
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
2.56.0.455.g6c5a503b38-goog

