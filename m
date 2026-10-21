Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602723;
	b=FcITN4Imn1Gy7m0CSHkZ+sFjMFDmrkvhvzhgJfw9yk0W7U3lqDU2+i17ZLxkaSLOjbh+
	 38NCZ9MsHt7Jzn39+jw5cFPKCeA4iWIASNUu0vqpW3tMjessd1n5HGeZ1+W/41lgerEyN
	 rMZiWyCDxhOiOH6mi2nuJz/hNO2D0tohGVUpIfsd5rOpXMbL7zRAIq7/u93kTTZFglYVb
	 3ToPjAeStVYuEQjh6xkdJ1C5NviRk3axxC+VA25bpvxQg37BTjr12Q+a/twe27v6hJgJs
	 K4scFkx0/+m/1JI/vhRpdT4axPUp2myZbIhEatVQu9sf3zNkIlETf4whY91/9X2noiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=tSMiQ6NIUcAT0NRQb854JTEOyM6xl86cQuNOuZ1ci/Y=;
	b=vyI24TQnWlvT4YRKWEPZmq08gp1YtVz1rrtca0g5Fpg1gY7D7h6SPmYjq9J6V+iH8Gwm
	 y5rFGPcS1mU3NMYNKhEaQOUYlzkp35m0xPL0kCuLf+Apo1aUdaX6kbt411Ls9Tftxt5N2
	 44cVws9jEa+nNzvorbNQwRkPvYH88B3MVfNa/R/CJQYLJC4HigJgWaaXCmx2RBSHQdBjV
	 kKNPgACXZfkLUJWIzZ0RqLE6yZEZEd2TfNUYFq0+7sB/fvdrOzaPGa25JL2gI5DJdbaJr
	 5X8QN6BxSGiTMVollCScNq9ANf+k1D5sW3Pc/Uswt1hNdZ3VbeFg+WiZ7WlIZKSQugQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=W64jZwJQ;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1D2606A337
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D1D2606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=W64jZwJQ
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35cbea41088so1724598eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792602722; x=1793207522; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tSMiQ6NIUcAT0NRQb854JTEOyM6xl86cQuNOuZ1ci/Y=;
        b=W64jZwJQtnwxXEFM2ypwvFrA3vtOPWyIbthccSegGrphsx3BU5h4NGACZ575MmHB/t
         Sh37cGJLHQt/YUoiYsmitLAiRjNdmnETUc73jBhdrE1sGI+BaWNMQCWUsedTFJ6odoaO
         pOigGuUMZoIvUWAymeh6amaH0H7FkQXp5NfQp5Q7Xq4YQNnfGVsy1hCt3Tu8q96umhzr
         Ag7JMYdaYy4i+0eATlYhvopBhvUNFX6ytMVwm9NpKpxueXZKq/0wGjqZf2MA8GpGLRCx
         TuGNrIs4gOPuD1LBULUNICGuxHl5CQE6PMUhQYfRrv/yIa3QzMIqhuNs84LL38oEoIoX
         B7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602722; x=1793207522;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tSMiQ6NIUcAT0NRQb854JTEOyM6xl86cQuNOuZ1ci/Y=;
        b=UgtEzS6jRs9IIzJ6B6OADbL1mn3kBWqdJuf9F5t8LGDu7Mehz9BERpxxMWspj6jlHv
         9QpByVrSbRGSplBVExs4bAnE/KQDPYglF9vU3d/lhkRfTFsJk5k/otn0Ly6vgGjBFWQp
         qMN9GUXNoWNkLbPvEvl61AtgGzMj398oXaKT1dSUIFtQtjLNw/6LwzOfKwPIbIC1UIiz
         MUWPRfdhptl0c3RboEa22QQ0alSkidz//yMHdvqRDFkoo5zv+oHPrAXIsHv7KSA6BbO/
         hk48kNHKKeJgNvHOgJdz/Hl+J7fbno4zxyh/WW5Q8JgsrxtPVSL4j2KdgoJejQT/oxi5
         o2kQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKsW3t9jqtmln5NylqG9GpC1dmhZ7ZR+rJAco0IRiK95qqYExeSj/a76uoxwcf/tT2uX5O/Jf74jka/c4FlAPV@vger.kernel.org
X-Gm-Message-State: AFq9FYK88SwzZ+bCcPmCsUcDIyarRp2FraiNXFwP023ajENiOClCkMwS
	pK7DfHzf02lJFz+TrCDnxKsTapH30ec2cEe03z2rODxSVSGG63NXeKe1dzRkRal0+CoA4Vzf1zg
	I4oJvsPag9w==
X-Received: from dlbvg25.prod.google.com ([2002:a05:7022:7f19:b0:182:2feb:a149])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4642:b0:188:ea93:6cf9
 with SMTP id a92af1059eb24-190a709edf1mr2930187c88.43.1792602721780; Wed, 21
 Oct 2026 10:12:01 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:10:38 -0700
In-Reply-To: <20261021171044.155240-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020163640.746159-1-irogers@google.com> <20261021171044.155240-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021171044.155240-13-irogers@google.com>
Subject: [PATCH v6 12/17] perf thread: Expand context analysis annotations to
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
2.56.0.218.g1ec904b173-goog

