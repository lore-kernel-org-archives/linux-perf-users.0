Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606624;
	b=lqgNx9DnnsYF4p+IQzaaqXjQKt9d8H4SkFtM4bc54r98yc6WYfLG1l4SW2PGcpL20F/v
	 3ymtsEhC55aasnybrr/gGmYGzpGItuHBOPJeLfPajCdAztmnRYCz1QsfkdHrkGWmso1gZ
	 sfTvum6/KXr7WiZgo/8mERtvAwyW7dNcyniuCZgiivX0rotgVKIKmKLi0xtwmfDeqFyhz
	 3k8hqUvpQ5QsTgfEk+rvS8esx+2Sl0FTs1Vl0JycfsfMZDwn15ivpIkGr3LbyFPfcBLal
	 XgSlHncL2SahvqhgNm4Vv9Q4qP8KNC+qAIDBuh/vPk4IdoeP8WH7+Y2sMxLAxXVNxWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ldX8YQvqTSlsz8Z9+2OEt8Ll7sc2UvMr61JE0L916Vk=;
	b=GZ9lx8Id1BTBhktMU+51S3u0/WsePPVc52MDn/y1nyJCXopsYUX0FdDm07XEbmxlUMEn
	 +0o7oZa3Ea/Y6Vxf/2v3DkD5oQ9pcmw+2jhhPdyWemOEFgSRJmwe9t6rxW9q+4+bSEZA3
	 KPvFLdx5FYwUzS6PwbTxpN3YG19kGY75Y4iuZZILATZPCp2GG6bFpFx3fuOymjI8CqWM8
	 c5j7DGRDlerwcKlI7HItL2zd10AVvEQKm6Vk7jG/gwvlIUbZZ6cghDE9GVTvmCsIcaMYB
	 2fIWcA8wO0Yt7NKXzLc71+vdBWaYbcqJMjlfmNnOYVDZUpUi4oaZD7G3PMdgVq7aCPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wfot4zSq;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2260A380D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AE2260A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wfot4zSq
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36f479b9819so1687909eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606621; x=1795211421; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ldX8YQvqTSlsz8Z9+2OEt8Ll7sc2UvMr61JE0L916Vk=;
        b=Wfot4zSqkNywY2/Os3EI/EPabKFYy1hGdx42Z7AtQFil0IYOVFe+lJcsxNHaHuoOfK
         SpeixEjqhuR+37P6S0RtZdtYqr9Wh8MTZse10KoqUB8xQgTc1g+ITcYcIqYACduleppM
         MDMQ6ZZeW2rzItmzjgO1IM/uRq1v/mLKKo3hwaFGOnT6uSCHhsnJcvlQ5WAwHIPR6Ujy
         2KLzJRhLH62xMDUZggK01zMM27AXtZhnEPh1iy8zfyARuJCXmxg8QKpq5ZWPo3EbzaF6
         JTCBJ1p0hIhHzLiRb1z8IcLM/uKhXJEnuDZ7MGiaS83UbAvKJP2zlZxh7IAG6dnNvOlX
         O9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606621; x=1795211421;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ldX8YQvqTSlsz8Z9+2OEt8Ll7sc2UvMr61JE0L916Vk=;
        b=Mhnx0I1BfT4ATkjpNh9/6NNi0s57FHYsRwQ+CFzVSWO9BXWMyBRpnEoxWkWF4jl0bg
         wlkE7p/ybGcHc80FtnlGQ3pPDUBiYQw7WEwkv0XGJwu+80LJfzj3vimGKSIMXqeCArdv
         6xE+Yi7P6HW9tVki7JoPSa2vL3zB19QpLQwOj1oNEQsYcjTVTtbttEcr8Rx7yaz9dAvF
         Zq2z88I5tOaLBTWVZGYAydVlhNEaDq6I3nfaxdJcaLWnGX8x9tnGssVhx98rtaDpSaFR
         5H/LpviBKHrxXIqb7m59xNr4goZwyIsZFCqA9tsTVwGRg0u0gbWcbopZNTYD6Fp+EMeM
         4c5g==
X-Forwarded-Encrypted: i=1; AL+hErFai+crqtGyvOKiRzj6JFz90am1gBk7hxpG+3ar3De0PKEBNbgubSCgKZXypm8UZZSQSzCvoDX/OnpLX5nRAEB/@vger.kernel.org
X-Gm-Message-State: APuU4Z9E3F99vR6E4QkQ6nHUnUygwnXPBQk5/JML09txaVJ9ZQA79JbX
	jg6icgEKSaJEBqV+BZEM6B548ptb3U7PUoklpxnRst5aLbBhdQkt/610nO1hKsl+pgS00Oy0v34
	9cFQooTMgUg==
X-Received: from dyax22-n1.prod.google.com ([2002:a05:693c:4196:10b0:33e:5767:2163])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:a22:b0:379:7bb6:9c4b
 with SMTP id 5a478bee46e88-3797bb69cf2mr2829297eec.39.1794606620707; Fri, 13
 Nov 2026 13:50:20 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:50 -0800
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
Message-ID: <20261113214850.3329699-27-irogers@google.com>
Subject: [PATCH v1 26/26] perf hashmap: Remove untyped struct hashmap API
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now that all hashmap users in tools/perf have been migrated to
DECLARE_HASHMAP(), remove the legacy untyped struct hashmap wrapper,
hashmap__new(), __hashmap__new(), __hashmap__free(), the
untyped-hashmap compatibility branches in hashmap__insert/find/delete,
and the unused hashmap__for_each_entry* macros from util/hashmap.h, and
rename struct hashmap_entry to struct __hashmap_entry.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hashmap.c |  75 +++++++----------
 tools/perf/util/hashmap.h | 173 +++++++-------------------------------
 2 files changed, 62 insertions(+), 186 deletions(-)

diff --git a/tools/perf/util/hashmap.c b/tools/perf/util/hashmap.c
index f6bfaeaee9d7..946105919197 100644
--- a/tools/perf/util/hashmap.c
+++ b/tools/perf/util/hashmap.c
@@ -21,15 +21,15 @@
 /* start with 4 buckets */
 #define HASHMAP_MIN_CAP_BITS 2
 
-static void __hashmap__add_entry(struct hashmap_entry **pprev,
-				 struct hashmap_entry *entry)
+static void __hashmap__add_entry(struct __hashmap_entry **pprev,
+				 struct __hashmap_entry *entry)
 {
 	entry->next = *pprev;
 	*pprev = entry;
 }
 
-static void __hashmap__del_entry(struct hashmap_entry **pprev,
-				 struct hashmap_entry *entry)
+static void __hashmap__del_entry(struct __hashmap_entry **pprev,
+				 struct __hashmap_entry *entry)
 {
 	*pprev = entry->next;
 	entry->next = NULL;
@@ -48,42 +48,23 @@ void __hashmap__init(struct __hashmap *map, hashmap_hash_fn hash_fn,
 	map->sz = 0;
 }
 
-struct __hashmap *__hashmap__new(hashmap_hash_fn hash_fn,
-				 hashmap_equal_fn equal_fn,
-				 void *ctx)
-{
-	struct __hashmap *map = malloc(sizeof(*map));
-
-	if (!map) {
-		errno = ENOMEM;
-		return NULL;
-	}
-	__hashmap__init(map, hash_fn, equal_fn, ctx);
-	return map;
-}
-
 void __hashmap__clear(struct __hashmap *map)
 {
-	struct hashmap_entry *cur, *tmp;
-	size_t bkt;
+	for (size_t bkt = 0; bkt < map->cap; bkt++) {
+		struct __hashmap_entry *cur = map->buckets[bkt];
+
+		while (cur) {
+			struct __hashmap_entry *next = cur->next;
 
-	hashmap__for_each_entry_safe(map, cur, tmp, bkt) {
-		free(cur);
+			free(cur);
+			cur = next;
+		}
 	}
 	free(map->buckets);
 	map->buckets = NULL;
 	map->cap = map->cap_bits = map->sz = 0;
 }
 
-void __hashmap__free(struct __hashmap *map)
-{
-	if (!map)
-		return;
-
-	__hashmap__clear(map);
-	free(map);
-}
-
 size_t __hashmap__size(const struct __hashmap *map)
 {
 	return map->sz;
@@ -102,10 +83,9 @@ static bool __hashmap__needs_to_grow(struct __hashmap *map)
 
 static int __hashmap__grow(struct __hashmap *map)
 {
-	struct hashmap_entry **new_buckets;
-	struct hashmap_entry *cur, *tmp;
+	struct __hashmap_entry **new_buckets;
 	size_t new_cap_bits, new_cap;
-	size_t h, bkt;
+	size_t h;
 
 	new_cap_bits = map->cap_bits + 1;
 	if (new_cap_bits < HASHMAP_MIN_CAP_BITS)
@@ -116,9 +96,16 @@ static int __hashmap__grow(struct __hashmap *map)
 	if (!new_buckets)
 		return -ENOMEM;
 
-	hashmap__for_each_entry_safe(map, cur, tmp, bkt) {
-		h = hash_bits(map->hash_fn(cur->key, map->ctx), new_cap_bits);
-		__hashmap__add_entry(&new_buckets[h], cur);
+	for (size_t bkt = 0; bkt < map->cap; bkt++) {
+		struct __hashmap_entry *cur = map->buckets[bkt];
+
+		while (cur) {
+			struct __hashmap_entry *next = cur->next;
+
+			h = hash_bits(map->hash_fn(cur->key, map->ctx), new_cap_bits);
+			__hashmap__add_entry(&new_buckets[h], cur);
+			cur = next;
+		}
 	}
 
 	map->cap = new_cap;
@@ -131,10 +118,10 @@ static int __hashmap__grow(struct __hashmap *map)
 
 static bool __hashmap__find_entry(const struct __hashmap *map,
 				  const long key, size_t hash,
-				  struct hashmap_entry ***pprev,
-				  struct hashmap_entry **entry)
+				  struct __hashmap_entry ***pprev,
+				  struct __hashmap_entry **entry)
 {
-	struct hashmap_entry *cur, **prev_ptr;
+	struct __hashmap_entry *cur, **prev_ptr;
 
 	if (!map->buckets)
 		return false;
@@ -157,7 +144,7 @@ int __hashmap__insert(struct __hashmap *map, long key, long value,
 		      enum hashmap_insert_strategy strategy,
 		      void *old_key, void *old_value)
 {
-	struct hashmap_entry *entry;
+	struct __hashmap_entry *entry;
 	size_t h;
 	int err;
 
@@ -193,7 +180,7 @@ int __hashmap__insert(struct __hashmap *map, long key, long value,
 		h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
 	}
 
-	entry = malloc(sizeof(struct hashmap_entry));
+	entry = malloc(sizeof(struct __hashmap_entry));
 	if (!entry)
 		return -ENOMEM;
 
@@ -207,7 +194,7 @@ int __hashmap__insert(struct __hashmap *map, long key, long value,
 
 bool __hashmap__find(const struct __hashmap *map, long key, void *value)
 {
-	struct hashmap_entry *entry;
+	struct __hashmap_entry *entry;
 	size_t h;
 
 	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
@@ -222,7 +209,7 @@ bool __hashmap__find(const struct __hashmap *map, long key, void *value)
 bool __hashmap__delete(struct __hashmap *map, long key,
 		       void *old_key, void *old_value)
 {
-	struct hashmap_entry **pprev, *entry;
+	struct __hashmap_entry **pprev, *entry;
 	size_t h;
 
 	if (old_key)
diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
index bb85a65486be..e515443d3c70 100644
--- a/tools/perf/util/hashmap.h
+++ b/tools/perf/util/hashmap.h
@@ -92,16 +92,10 @@ typedef bool (*hashmap_equal_fn)(long key1, long key2, void *ctx);
  *   (e.g. bool, int, pid_t) are safe from buffer overflows, endianness bugs,
  *   and strict-aliasing violations.
  */
-struct hashmap_entry {
-	union {
-		long key;
-		const void *pkey;
-	};
-	union {
-		long value;
-		void *pvalue;
-	};
-	struct hashmap_entry *next;
+struct __hashmap_entry {
+	long key;
+	long value;
+	struct __hashmap_entry *next;
 };
 
 struct __hashmap {
@@ -109,57 +103,19 @@ struct __hashmap {
 	hashmap_equal_fn equal_fn;
 	void *ctx;
 
-	struct hashmap_entry **buckets;
+	struct __hashmap_entry **buckets;
 	size_t cap;
 	size_t cap_bits;
 	size_t sz;
 };
 
-/* Legacy untyped hashmap, kept while migrating callers to DECLARE_HASHMAP. */
-struct hashmap {
-	union {
-		struct __hashmap map;
-		struct {
-			hashmap_hash_fn hash_fn;
-			hashmap_equal_fn equal_fn;
-			void *ctx;
-
-			struct hashmap_entry **buckets;
-			size_t cap;
-			size_t cap_bits;
-			size_t sz;
-		};
-		long *__key;
-		long *__value;
-		char __untyped;
-	};
-};
-
 void __hashmap__init(struct __hashmap *map, hashmap_hash_fn hash_fn,
 		     hashmap_equal_fn equal_fn, void *ctx);
-struct __hashmap *__hashmap__new(hashmap_hash_fn hash_fn,
-				 hashmap_equal_fn equal_fn,
-				 void *ctx);
 void __hashmap__clear(struct __hashmap *map);
-void __hashmap__free(struct __hashmap *map);
 
 size_t __hashmap__size(const struct __hashmap *map);
 size_t __hashmap__capacity(const struct __hashmap *map);
 
-static inline struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
-					   hashmap_equal_fn equal_fn,
-					   void *ctx)
-{
-	struct hashmap *map = malloc(sizeof(*map));
-
-	if (!map) {
-		errno = ENOMEM;
-		return NULL;
-	}
-	__hashmap__init(&map->map, hash_fn, equal_fn, ctx);
-	return map;
-}
-
 /**
  * enum hashmap_insert_strategy - Strategy for hashmap__insert().
  * @HASHMAP_ADD: Only add key/value if key doesn't exist yet; returns -EEXIST
@@ -195,8 +151,8 @@ bool __hashmap__find(const struct __hashmap *map, long key, void *value);
 struct __hashmap_iter {
 	const struct __hashmap *map;
 	size_t bkt;
-	struct hashmap_entry *cur;
-	struct hashmap_entry *next;
+	struct __hashmap_entry *cur;
+	struct __hashmap_entry *next;
 };
 
 static inline struct __hashmap_iter
@@ -210,7 +166,7 @@ __hashmap_iter__init(const struct __hashmap *map)
 	};
 }
 
-static inline struct hashmap_entry *
+static inline struct __hashmap_entry *
 __hashmap_iter__advance(struct __hashmap_iter *it)
 {
 	if (!it->map || !it->map->buckets)
@@ -232,14 +188,14 @@ __hashmap_iter__advance(struct __hashmap_iter *it)
 struct __hashmap_key_iter {
 	const struct __hashmap *map;
 	long key;
-	struct hashmap_entry *cur;
-	struct hashmap_entry *next;
+	struct __hashmap_entry *cur;
+	struct __hashmap_entry *next;
 };
 
 static inline struct __hashmap_key_iter
 __hashmap_key_iter__init(const struct __hashmap *map, long key)
 {
-	struct hashmap_entry *first = NULL;
+	struct __hashmap_entry *first = NULL;
 
 	if (map && map->buckets) {
 		size_t h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
@@ -254,11 +210,11 @@ __hashmap_key_iter__init(const struct __hashmap *map, long key)
 	};
 }
 
-static inline struct hashmap_entry *
+static inline struct __hashmap_entry *
 __hashmap_key_iter__advance(struct __hashmap_key_iter *it)
 {
 	while (it->next) {
-		struct hashmap_entry *entry = it->next;
+		struct __hashmap_entry *entry = it->next;
 
 		it->next = entry->next;
 		if (it->map->equal_fn(entry->key, it->key, it->map->ctx)) {
@@ -289,7 +245,6 @@ struct name {									\
 		struct __hashmap map;					\
 		key_type *__key;						\
 		value_type *__value;						\
-		int __untyped;							\
 	};									\
 	_Static_assert(sizeof(key_type) <= sizeof(long),			\
 		       #name " key_type exceeds sizeof(long)");			\
@@ -328,19 +283,6 @@ static inline __maybe_unused void name##__free(struct name *hmap)		\
 			*(hm)->__key, (char *)NULL)) *)NULL,			\
 		*(hm)->__key))
 
-#define ___hashmap__choose(hm, untyped_expr, typed_expr)				\
-	__builtin_choose_expr(sizeof((hm)->__untyped) == 1,			\
-			      (untyped_expr), (typed_expr))
-
-#define ___hashmap__in_val(hm, expr) \
-	___hashmap__choose(hm, (long)(expr), (expr))
-
-#define ___hashmap__check_untyped_ptr(hm, ptr)					\
-	_Static_assert(sizeof((hm)->__untyped) != 1 ||				\
-		       (__builtin_constant_p((ptr)) ? (ptr) == NULL : 0) ||	\
-		       sizeof(*(ptr)) == sizeof(long),				\
-		       #ptr " pointee should be a long-sized integer or a pointer")
-
 /**
  * hashmap__init() - Initialize an embedded/stack-allocated typed hashmap.
  * @hmap: Pointer to a hashmap struct declared with DECLARE_HASHMAP().
@@ -397,25 +339,16 @@ do {										\
 	__hashmap__capacity(&(hmap)->map)
 
 #define ___hashmap__insert(hmap, key, value, strategy, old_key, old_value,	\
-			   hm, k, v, okp, ovp, raw_ok, raw_ov, ok, ov, err)	\
+			   hm, k, v, okp, ovp, ok, ov, err)		\
 ({										\
 	typeof(hmap) hm = (hmap);						\
-	typeof(*(hm)->__key) k = ___hashmap__in_val(hm, key);			\
-	typeof(*(hm)->__value) v = ___hashmap__in_val(hm, value);			\
+	typeof(*(hm)->__key) k = (key);						\
+	typeof(*(hm)->__value) v = (value);					\
+	typeof((hm)->__key) okp = (old_key);					\
+	typeof((hm)->__value) ovp = (old_value);				\
 	long ok = 0, ov = 0;							\
-	typeof((hm)->__key) okp =						\
-		___hashmap__choose(hm, (long *)NULL, (old_key));			\
-	typeof((hm)->__value) ovp =						\
-		___hashmap__choose(hm, (long *)NULL, (old_value));		\
-	void *raw_ok = ___hashmap__choose(hm, (void *)(old_key),			\
-					(void *)(okp ? &ok : NULL));		\
-	void *raw_ov = ___hashmap__choose(hm, (void *)(old_value),		\
-					(void *)(ovp ? &ov : NULL));		\
-	int err;								\
-	___hashmap__check_untyped_ptr(hm, old_key);				\
-	___hashmap__check_untyped_ptr(hm, old_value);				\
-	err = __hashmap__insert(&(hm)->map, (long)k, (long)v, (strategy),	\
-				raw_ok, raw_ov);			\
+	int err = __hashmap__insert(&(hm)->map, (long)k, (long)v, (strategy),	\
+				    okp ? &ok : NULL, ovp ? &ov : NULL);	\
 	if (okp)								\
 		*okp = (typeof(*(hm)->__key))ok;				\
 	if (ovp)								\
@@ -427,7 +360,6 @@ do {										\
 	___hashmap__insert(hmap, key, value, strategy, old_key, old_value,	\
 			   __PASTE(__hm_, u), __PASTE(__k_, u), __PASTE(__v_, u),	\
 			   __PASTE(__okp_, u), __PASTE(__ovp_, u),	\
-			   __PASTE(__rok_, u), __PASTE(__rov_, u),	\
 			   __PASTE(__ok_, u), __PASTE(__ov_, u), __PASTE(__err_, u))
 
 /**
@@ -503,18 +435,13 @@ do {										\
 #define hashmap__append(hmap, key, value) \
 	hashmap__insert(hmap, key, value, HASHMAP_APPEND, NULL, NULL)
 
-#define ___hashmap__find(hmap, key, value_ptr, hm, k, vp, raw_vp, v, found)	\
+#define ___hashmap__find(hmap, key, value_ptr, hm, k, vp, v, found)		\
 ({										\
 	typeof(hmap) hm = (hmap);						\
-	___hashmap__lookup_key_type(hm) k = ___hashmap__in_val(hm, key);		\
+	___hashmap__lookup_key_type(hm) k = (key);				\
+	typeof((hm)->__value) vp = (value_ptr);					\
 	long v = 0;								\
-	typeof((hm)->__value) vp =						\
-		___hashmap__choose(hm, (long *)NULL, (value_ptr));		\
-	void *raw_vp = ___hashmap__choose(hm, (void *)(value_ptr),		\
-					(void *)(vp ? &v : NULL));		\
-	bool found;								\
-	___hashmap__check_untyped_ptr(hm, value_ptr);				\
-	found = __hashmap__find(&(hm)->map, (long)k, raw_vp);			\
+	bool found = __hashmap__find(&(hm)->map, (long)k, vp ? &v : NULL);	\
 	if (found && vp)							\
 		*vp = (typeof(*(hm)->__value))v;				\
 	found;									\
@@ -523,7 +450,7 @@ do {										\
 #define _hashmap__find(hmap, key, value_ptr, u)					\
 	___hashmap__find(hmap, key, value_ptr,					\
 			 __PASTE(__hm_, u), __PASTE(__k_, u), __PASTE(__vp_, u),	\
-			 __PASTE(__rvp_, u), __PASTE(__v_, u), __PASTE(__found_, u))
+			 __PASTE(__v_, u), __PASTE(__found_, u))
 
 /**
  * hashmap__find() - Look up a key in a typed hashmap.
@@ -538,23 +465,15 @@ do {										\
 	_hashmap__find(hmap, key, value_ptr, __COUNTER__)
 
 #define ___hashmap__delete(hmap, key, old_key, old_value,				\
-			   hm, k, okp, ovp, raw_ok, raw_ov, ok, ov, rem)	\
+			   hm, k, okp, ovp, ok, ov, rem)		\
 ({										\
 	typeof(hmap) hm = (hmap);						\
-	___hashmap__lookup_key_type(hm) k = ___hashmap__in_val(hm, key);		\
+	___hashmap__lookup_key_type(hm) k = (key);				\
+	typeof((hm)->__key) okp = (old_key);					\
+	typeof((hm)->__value) ovp = (old_value);				\
 	long ok = 0, ov = 0;							\
-	typeof((hm)->__key) okp =						\
-		___hashmap__choose(hm, (long *)NULL, (old_key));			\
-	typeof((hm)->__value) ovp =						\
-		___hashmap__choose(hm, (long *)NULL, (old_value));		\
-	void *raw_ok = ___hashmap__choose(hm, (void *)(old_key),			\
-					(void *)(okp ? &ok : NULL));		\
-	void *raw_ov = ___hashmap__choose(hm, (void *)(old_value),		\
-					(void *)(ovp ? &ov : NULL));		\
-	bool rem;								\
-	___hashmap__check_untyped_ptr(hm, old_key);				\
-	___hashmap__check_untyped_ptr(hm, old_value);				\
-	rem = __hashmap__delete(&(hm)->map, (long)k, raw_ok, raw_ov);		\
+	bool rem = __hashmap__delete(&(hm)->map, (long)k,			\
+				     okp ? &ok : NULL, ovp ? &ov : NULL);	\
 	if (okp)								\
 		*okp = (typeof(*(hm)->__key))ok;				\
 	if (ovp)								\
@@ -566,7 +485,6 @@ do {										\
 	___hashmap__delete(hmap, key, old_key, old_value,				\
 			   __PASTE(__hm_, u), __PASTE(__k_, u),		\
 			   __PASTE(__okp_, u), __PASTE(__ovp_, u),	\
-			   __PASTE(__rok_, u), __PASTE(__rov_, u),	\
 			   __PASTE(__ok_, u), __PASTE(__ov_, u), __PASTE(__rem_, u))
 
 /**
@@ -660,33 +578,4 @@ do {										\
 #define hashmap__for_each_key_safe(hmap, key, val_var) \
 	hashmap__for_each_key(hmap, key, val_var)
 
-/*
- * Legacy entry iterators for unconverted struct hashmap callers.
- */
-#define hashmap__for_each_entry(map, cur, bkt)				    \
-	for (bkt = 0; bkt < (map)->cap; bkt++)				    \
-		for (cur = (map)->buckets[bkt]; cur; cur = cur->next)
-
-#define hashmap__for_each_entry_safe(map, cur, tmp, bkt)		    \
-	for (bkt = 0; bkt < (map)->cap; bkt++)				    \
-		for (cur = (map)->buckets[bkt];				    \
-		     cur && ({tmp = cur->next; true; });		    \
-		     cur = tmp)
-
-#define hashmap__for_each_key_entry(map, cur, _key)			    \
-	for (cur = (map)->buckets					    \
-		     ? (map)->buckets[hash_bits((map)->hash_fn((_key), (map)->ctx), (map)->cap_bits)] \
-		     : NULL;						    \
-	     cur;							    \
-	     cur = cur->next)						    \
-		if ((map)->equal_fn(cur->key, (_key), (map)->ctx))
-
-#define hashmap__for_each_key_entry_safe(map, cur, tmp, _key)		    \
-	for (cur = (map)->buckets					    \
-		     ? (map)->buckets[hash_bits((map)->hash_fn((_key), (map)->ctx), (map)->cap_bits)] \
-		     : NULL;						    \
-	     cur && ({ tmp = cur->next; true; });			    \
-	     cur = tmp)							    \
-		if ((map)->equal_fn(cur->key, (_key), (map)->ctx))
-
 #endif /* __PERF_UTIL_HASHMAP_H */
-- 
2.56.1.703.gf848ed807c-goog

