Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588150;
	b=m3UHDH3IdsUotU9DYbu8xg+gHNee0z5Em/jPMBXzgS9Aya1L+xPQPi329539N/zgikCv
	 p44pyMO5M3+9E4vXfNRXaRqR/kDojVMXua5CXf+fXNN1vGK/+KI/8sMixWTrVhf8Iw+GN
	 XcBvRreAU6zGEx0Xtz55tCBFNhT2MBov0TtkGw/kbutsfLz9g6HkG5WI97WXxSVA8qfux
	 SLqXerk9qi5ixCAdUmE8UpqAeifErcwtulCgHrlWZ+rpcODSlSwUYtZ0SM1PJff/be+ib
	 iz4T7mivKqIY/71urr9L9y+LCKxm4tK8cRgxfrVOiyWkYE75ZTXggrhG5prNC0sVelw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=eSbuo3rOifeT7nZMgCGDcZb8c1RQ3Fa+svClU7k+PsA=;
	b=wguCSbi9ufCLzT22OMMqnhv+Wan3TsIovfi4//GTHAd7t83/tZA3tvoZMTtvinhmdu41
	 i5BMO104iXpE7ZCVlVBsdwLd9TrJgo21x/ob0T9CxWcw/VX2+oDBMZcAaj7i1EL3+kQFR
	 epGhyoLgn1qE8S8tFl4ECriD4kVKJchwRtJEO+s19duGxMmx5Wa76zDJ5UnjGuQHUwMKg
	 AW9NmqIJZuhr3o2vO3qT99uCdRrtEIi37jLrtC7yt9uKzAQG5yuKiweM/Qr3NovI20YTX
	 4frC/lLf0huHkd+Ot5Ypg2KHNyb8sU34Aq5uN2YRI+hJKHc+ZciJx3i7IAotIudCW/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mB7EBeRm;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39E6073F48
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA39E6073F48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mB7EBeRm
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b29df78132so401610c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 08:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794588149; x=1795192949; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eSbuo3rOifeT7nZMgCGDcZb8c1RQ3Fa+svClU7k+PsA=;
        b=mB7EBeRmPy+hpTEwEUhciq024n2br+RA2DigitagrnJ67raHP7XTBWvo8YcY28S0lx
         4lGducCwBQcgbqvZTuyC9RnGvhvQr+3bQg5PekaEswMNSySgfeY3/AEfpKhdoWRFNFy5
         RDnnf2+Nehtj9Cqx0DOBcdg8kvzIa23IWGH6yw25V1lGpwKBsEOV8wg/nYwm08h5Z6zO
         IP3fbBCgREyiEFhgPTTBFcnKkp69erQZjHeAKFzk2y2yDhdelsMmgcGn+m3QHB+XseJq
         Yb8f8qVZ0+Fcch1PsofSUaOrdH8RbLxgiAtvLo32dFRJiL65B7CrQWGqJJt22oJi00ID
         Nb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794588149; x=1795192949;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eSbuo3rOifeT7nZMgCGDcZb8c1RQ3Fa+svClU7k+PsA=;
        b=kApH6VeHGSdiUGcjY/f8GiYoIRw2/VTJc9riUmgsSuLUA7v9nZgbNPbgCxQSXi94W3
         8RXMU6nMaIaD0mBDvoHflQu7U3xdILuWfWiwrKW0HAlRJ3F8oUaMr9Bkfuv5GwRedyj2
         TBGhBGV78PyED8O9VZzx65EOxsmGvwPHKJBMGmV8n6Yfi7HueCGDUazzqHa8D6xnK8Ai
         +1PjPW7yeTk+wIMiby5ywRhIafe8EUXQeFmvCrCh8UJlrxMVqN5rOLmSFPAGWM6nl3Xv
         G8739LDaDxU+SAI8tRxN+XSNVAZRXzatJTD16U8PFWGtWdCDpQ30LVxCj2MA2MKkgb6Y
         +U/w==
X-Forwarded-Encrypted: i=1; AL+hErHKL8tTthQxRA7AghblAu/1U0HIpEWxUxnBLqmBzXHW/ttnTN8UxWA1I0cwOqt8D/+BFRubBcADEUeyKPErZGJ5@vger.kernel.org
X-Gm-Message-State: APuU4Z81oldnJSykA5TAnbEJtcb9Xvzwfud7MXbOH6hqRhnUG9inmTy/
	x5i1hMTuf+BQVzRxWAI+3SBFwN770dKQCtf/fAUwoIUOpJmNqW+RJJooaOmKAAy2WJYJLLRL76E
	VF2YHIpOMXQ==
X-Received: from dlbtu8.prod.google.com ([2002:a05:7022:3c08:b0:195:beb6:14cc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:258f:b0:1b0:430d:d81c
 with SMTP id a92af1059eb24-1b503112636mr3119151c88.25.1794588148598; Fri, 13
 Nov 2026 08:42:28 -0800 (PST)
Date: Fri, 13 Nov 2026 08:41:45 -0800
In-Reply-To: <20261113164152.2095566-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113164152.2095566-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113164152.2095566-15-irogers@google.com>
Subject: [PATCH v13 14/21] perf thread: Expand context analysis annotations to
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
2.56.1.703.gf848ed807c-goog

