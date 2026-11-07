Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026498;
	b=FZoaEJGgii3WBTZAQqEMYIvkvsZm8PlB+Kqsd8V9pIU9lGi0YNLmj5nmuwSp1VM0JEVL
	 Uoja+XOWWiGykgPT3OWpBPFpJyvBQFp4hZKDTWRER4/a4A9NuHtMU5jkkisWGkyCVTaFv
	 CqtgyvLIzjOmyDNoFB33Ich2Oxgy/rYw3gh/Y+HwXKmRMi1mCT+hTwn9fWnV5+oyqogOL
	 EeR0R1vwJIHilY874qhDW/E9v2uHD1ptPQVpSpJ2gTxrsvkYW9a6IrSvM2471cokiicMM
	 96b3BGj/vNQAJCk7Bb9tdW5hu+U6G1irPHq0GXzvZQdw9A6EcQfeeOxgLHLf9UDGElA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=o7CTrAhrkmxdP5PCIw1MA98wNNK+lzvPv6pZbJYyzjo=;
	b=uJuj2W5laup0M0XVKDFpOZoxPbr0CfUq5QRTo2TbOjb9gQJX/cA6Kq1Bs2tLcup1UhR/
	 6iK5ewXCGwXkSvv3J4+jWyGYsoTWdAIAp5g3HCPZjqktDTUDBIZqMF8Ly5x3YyN1nUiIL
	 GemHYG2k8DEcNGOV1V4eAWblAmIuUCbP+6KGr6qT/Wq9HF+SGE5mVZEdxUEIZR41voupg
	 x6Fx0RVb/2/gRXHBuypl8Eh1mmpxeFbonc0BZHyGlvS/RosAf2rPdiVUk3KmR/PlfYUz6
	 yopQpKxx9khvCvTbbg93RNtz8HvpkUNHWZBOms5XQ4oPevBZd1k8s1W2cc52H6RO7Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ac5yltpe;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C56606D803
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 04:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35C56606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ac5yltpe
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36ecd5db581so4374325eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 20:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794026497; x=1794631297; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o7CTrAhrkmxdP5PCIw1MA98wNNK+lzvPv6pZbJYyzjo=;
        b=ac5yltpe4QY1Hk5Ull6PMoFjfd2QT3zeNYFVCkjbiMSjP4ZVzP/GYYnVKVQEW/yUOC
         DR+CpkhU/nVZK8ww88OXn2UaZmlrvFQmyCVJIC6iokud0Fsl3Ckqvz6oVAB4RlSH99i5
         sjiCctB0CyGV7OwiCxpK9FANPelHkpBJm/TqsgKw+e2wIItlRgsWFFXPUJlVOVT68lD/
         vYlNKUn2ol9G8Bc3nhhy3BNQA0F6iThHMC3FJ/moHKijluQcCYwzeHRcLNXLUatqoT+y
         NUzXHbt4/8ymi5OM0adh/ZVHegvfyJQleQFm5NMVGJQjkZv5YBx4c7aiQjf/in7ODv8t
         n/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794026497; x=1794631297;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o7CTrAhrkmxdP5PCIw1MA98wNNK+lzvPv6pZbJYyzjo=;
        b=UqbRC1MB2uu4uyZ9eteXiRHHlTCC72tlTn8ymCqfcFnNV5A87ilpoAA4FbY5itqJn8
         cFP4Evcdp+XCX31sEBvftJShPfncOBXWh/YagL4R0YJ6/hctlYKM9VfR0iDIrUIz9dXL
         sJ6YchJrDNvsOVaJ46/odYwnjNF4a8jA5jOOoT1uy+blp+bCvVrwM2CYLyU6Fust97QV
         4JrOCwrK52N80z+YqPfknbxsj1Bp4e1Rpt8oW1H4xYrEmHRZupCnbc9hTSQldobgQtTg
         TwLSkE/CiR1c5wiCj3gtw6q6VyX9RSaBGEuy6C54R5eZAJowPpHH+j43lTtZO256WqtM
         prdQ==
X-Forwarded-Encrypted: i=1; AL+hErFRAgyvy8eIpMW3iAB9x2P1ypGguB3JV31CH2WCp5eLw+r40jnNcQ7UZmnrxJrQZ9AUiKqRMEHcOX8xWgwSI0pE@vger.kernel.org
X-Gm-Message-State: APuU4Z8Z0GHzJYRbl09AesHTwQzBqZzbZOycoDv/JwP+uD7jWveyr6e1
	+6hpf/972/wTQ8kcTB/NV1QoTnLFleNf5xl2/rrNbDrGcG4kmlNFkWx0yrRDW60E3ZWl4VUF2D9
	FXoz9q+SwOg==
X-Received: from dybmb9.prod.google.com ([2002:a05:7301:1909:b0:36f:7f0f:e2e1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ea0f:b0:36a:1f8:a5a4
 with SMTP id 5a478bee46e88-36f772fa36cmr6328613eec.38.1794026496928; Fri, 06
 Nov 2026 20:41:36 -0800 (PST)
Date: Fri,  6 Nov 2026 20:40:55 -0800
In-Reply-To: <20261107044102.1506626-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107044102.1506626-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261107044102.1506626-15-irogers@google.com>
Subject: [PATCH v11 14/20] perf thread: Expand context analysis annotations to
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

