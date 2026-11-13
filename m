Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606566;
	b=Hlbm6zp/TJTmNIVJNt8nKG+VshTR2AVpDgtVD5N/g5aaiNnAjb33r+Df8mHEtSda1i90
	 DLv99iG+0PJuSDIbFZXBVPABJqjEM8pY7u7XoKa5n5z8+ww8vKSh/taP65/prdwdc7PKm
	 yMkry2XFnyAEiAfqzK5PsyrkHb20h3FF+Oq8ADkAfWfmAsPD4vMRv3PySFJkXPP8KjZKU
	 6nJ7xEVgHYh99BrNR+ja8MHb288hG4bVCKQSbm/yOVeyPQJVhFKEuRnJg1Y4e1bF4AT0K
	 6T4jufwoCg8hhzBXqgqsjsHRRUIyXXTiHrH5SWTPZ5hFg9UlEALHwWxATM0pMd19DrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=6oSPPOo0C6N3cNWQ993MVB5Cg/gZqiSL0WgLi3FPcVs=;
	b=JlbeEdneWuEmiMm4jlCXWNeHaQqfqkiMeHA/V7dLHfGEiHewo7c6JutiP5Tmbawxed1B
	 9EUwxyEs3hZh1YT1vB+UW0+rsFCbT2rQkI5FOtppkJl+4XuGvtHa7kLjfvf+m6E6U8V98
	 M/EzlbyMyPkCkJo/wtoK2v5+qHH6iSYFqM/X+hM8Tgw+PtGUTlrwfMT5UfNjqDEsaaNQb
	 0qBLR788597w1fNMWhu8TD8Sw+YVLLLEWSeBlk6PgOlCCZJueKJj5n5lWhNg5PFiRqJ5g
	 lCn78U4cp6K+3J4fkZqbFfbtQPTxLFVpX83NVbhgQA/ueuSOvaeXyoqcJodTSNHOSXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OqtBuF8C;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008A3606A88E
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 008A3606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OqtBuF8C
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so2168480eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606565; x=1795211365; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6oSPPOo0C6N3cNWQ993MVB5Cg/gZqiSL0WgLi3FPcVs=;
        b=OqtBuF8CYVrxv90m5tqD5cjRUOf9aUlrmuEU8newpmkajQ7mmVQejV0cKMgonkjAOh
         C8w+IZS9m8hm+Br8r3kS112E7AdUQZY3m2buRHfNWH4rZbBUGM7flkcKfNs/JnifSiKc
         4UxyD8yl1tF7Y/m+9q9N9ylEODzVIoKpDJJClHxJpC3a2pSZaL2yb9H9Kkx2r+7qKwYS
         jEOl1TRe2He+tgraSGRfiQ3Y1LDDMM8sM53FKXnEiRzey5ITjys44q/jiTlgGGdh1I4R
         7Chx4ZETKVB/1vn025ZXSUQ6ZN3XfZGbGsxrtRaxATaV9gV7lEVO19SPjfVjzPcy9SAv
         YGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606565; x=1795211365;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6oSPPOo0C6N3cNWQ993MVB5Cg/gZqiSL0WgLi3FPcVs=;
        b=ulWUoeK9VW0lFP68U7jUgSf/khmOAJto2E7nWcyBk9PkElGkQVFKGMhdSsSAaeSSYc
         UZ8XIMcWxxVYO4sBJjvVfTCe15jSjyqWR4mELDXBwgkCFbM7L7XlWnuNVOnfdSc9mEE1
         Mp90cPoOwjKMHl+GziM2ypDb0rB7p2vQWZh2pHx2FsWAp6hZ2d4UEuw+uBfqPXL+XLWV
         /zR32WT4iQQVeHdMaNlEyxtrnLQR53uZX2eHSAvr7pc9vC/Mq0dE9an2ekx+/Ohbr3jp
         G29IecmLYp3sYJdpLrYMCveBovg1eI21ApAs9WOOeUnLyZ2/E+Z94LW+P9BTH3GJkA9d
         fnOw==
X-Forwarded-Encrypted: i=1; AL+hErHgif/R6vShIUYxGe3pU67a2tuuKOaiNIm76M+F6g/UQCTMM/NPPfQKo87BAo/VdhJugOcdqcXdl/G4G7XObag9@vger.kernel.org
X-Gm-Message-State: APuU4Z+jYOh4hIj2xLWdRxrpReWgfmh7JyTkLFmCznIfgCAknhM2zySN
	/7TlJcesYaQEDmPimFF87EhM7pYlCqsFpllGBu9D60Qommce8lSn/0s92VWyCmEH5+TT/K81FTO
	4XKEwb3a+Rw==
X-Received: from dlev25.prod.google.com ([2002:a05:701b:4659:b0:1a7:3dca:e320])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4293:20b0:187:efba:9ba2
 with SMTP id a92af1059eb24-1b5031562cemr3697275c88.44.1794606564709; Fri, 13
 Nov 2026 13:49:24 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:29 -0800
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
Message-ID: <20261113214850.3329699-6-irogers@google.com>
Subject: [PATCH v1 05/26] perf hashmap: Always build perf's hashmap and avoid
 libbpf symbol conflict
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously tools/perf/util/hashmap.o was only compiled when libbpf was
disabled or linked dynamically; with static libbpf.a, perf linked
against libbpf's internal hashmap symbols.

To allow perf's hashmap implementation to diverge from libbpf's without
colliding with libbpf.a's global hashmap symbols or churning callers:
- Always build util/hashmap.o in tools/perf/util/Build.
- Rename the backing C functions in util/hashmap.c to __hashmap__*
  (__hashmap__init, __hashmap__new, __hashmap__clear, __hashmap__free,
  __hashmap__size, __hashmap__capacity, __hashmap__insert,
  __hashmap__find, and __hashmap__delete, along with the internal
  __hashmap__* helpers).
- Keep the existing struct hashmap and hashmap__* header wrappers in
  util/hashmap.h forwarding to those functions, and update the single
  direct hashmap_find() call in hwmon_pmu.c to hashmap__find().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build       |  9 ----
 tools/perf/util/hashmap.c   | 70 +++++++++++++++----------------
 tools/perf/util/hashmap.h   | 83 ++++++++++++++++++++++++++-----------
 tools/perf/util/hwmon_pmu.c |  2 +-
 4 files changed, 94 insertions(+), 70 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2c1f880c4c47..d9090f217301 100644
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
diff --git a/tools/perf/util/hashmap.c b/tools/perf/util/hashmap.c
index 140ee4055676..b6f80a92f5dd 100644
--- a/tools/perf/util/hashmap.c
+++ b/tools/perf/util/hashmap.c
@@ -21,22 +21,22 @@
 /* start with 4 buckets */
 #define HASHMAP_MIN_CAP_BITS 2
 
-static void hashmap_add_entry(struct hashmap_entry **pprev,
-			      struct hashmap_entry *entry)
+static void __hashmap__add_entry(struct hashmap_entry **pprev,
+				 struct hashmap_entry *entry)
 {
 	entry->next = *pprev;
 	*pprev = entry;
 }
 
-static void hashmap_del_entry(struct hashmap_entry **pprev,
-			      struct hashmap_entry *entry)
+static void __hashmap__del_entry(struct hashmap_entry **pprev,
+				 struct hashmap_entry *entry)
 {
 	*pprev = entry->next;
 	entry->next = NULL;
 }
 
-void hashmap__init(struct hashmap *map, hashmap_hash_fn hash_fn,
-		   hashmap_equal_fn equal_fn, void *ctx)
+void __hashmap__init(struct hashmap *map, hashmap_hash_fn hash_fn,
+		     hashmap_equal_fn equal_fn, void *ctx)
 {
 	map->hash_fn = hash_fn;
 	map->equal_fn = equal_fn;
@@ -48,19 +48,19 @@ void hashmap__init(struct hashmap *map, hashmap_hash_fn hash_fn,
 	map->sz = 0;
 }
 
-struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
-			     hashmap_equal_fn equal_fn,
-			     void *ctx)
+struct hashmap *__hashmap__new(hashmap_hash_fn hash_fn,
+			       hashmap_equal_fn equal_fn,
+			       void *ctx)
 {
 	struct hashmap *map = malloc(sizeof(struct hashmap));
 
 	if (!map)
 		return ERR_PTR(-ENOMEM);
-	hashmap__init(map, hash_fn, equal_fn, ctx);
+	__hashmap__init(map, hash_fn, equal_fn, ctx);
 	return map;
 }
 
-void hashmap__clear(struct hashmap *map)
+void __hashmap__clear(struct hashmap *map)
 {
 	struct hashmap_entry *cur, *tmp;
 	size_t bkt;
@@ -73,32 +73,32 @@ void hashmap__clear(struct hashmap *map)
 	map->cap = map->cap_bits = map->sz = 0;
 }
 
-void hashmap__free(struct hashmap *map)
+void __hashmap__free(struct hashmap *map)
 {
 	if (IS_ERR_OR_NULL(map))
 		return;
 
-	hashmap__clear(map);
+	__hashmap__clear(map);
 	free(map);
 }
 
-size_t hashmap__size(const struct hashmap *map)
+size_t __hashmap__size(const struct hashmap *map)
 {
 	return map->sz;
 }
 
-size_t hashmap__capacity(const struct hashmap *map)
+size_t __hashmap__capacity(const struct hashmap *map)
 {
 	return map->cap;
 }
 
-static bool hashmap_needs_to_grow(struct hashmap *map)
+static bool __hashmap__needs_to_grow(struct hashmap *map)
 {
 	/* grow if empty or more than 75% filled */
 	return (map->cap == 0) || ((map->sz + 1) * 4 / 3 > map->cap);
 }
 
-static int hashmap_grow(struct hashmap *map)
+static int __hashmap__grow(struct hashmap *map)
 {
 	struct hashmap_entry **new_buckets;
 	struct hashmap_entry *cur, *tmp;
@@ -116,7 +116,7 @@ static int hashmap_grow(struct hashmap *map)
 
 	hashmap__for_each_entry_safe(map, cur, tmp, bkt) {
 		h = hash_bits(map->hash_fn(cur->key, map->ctx), new_cap_bits);
-		hashmap_add_entry(&new_buckets[h], cur);
+		__hashmap__add_entry(&new_buckets[h], cur);
 	}
 
 	map->cap = new_cap;
@@ -127,10 +127,10 @@ static int hashmap_grow(struct hashmap *map)
 	return 0;
 }
 
-static bool hashmap_find_entry(const struct hashmap *map,
-			       const long key, size_t hash,
-			       struct hashmap_entry ***pprev,
-			       struct hashmap_entry **entry)
+static bool __hashmap__find_entry(const struct hashmap *map,
+				  const long key, size_t hash,
+				  struct hashmap_entry ***pprev,
+				  struct hashmap_entry **entry)
 {
 	struct hashmap_entry *cur, **prev_ptr;
 
@@ -151,9 +151,9 @@ static bool hashmap_find_entry(const struct hashmap *map,
 	return false;
 }
 
-int hashmap_insert(struct hashmap *map, long key, long value,
-		   enum hashmap_insert_strategy strategy,
-		   long *old_key, long *old_value)
+int __hashmap__insert(struct hashmap *map, long key, long value,
+		      enum hashmap_insert_strategy strategy,
+		      long *old_key, long *old_value)
 {
 	struct hashmap_entry *entry;
 	size_t h;
@@ -166,7 +166,7 @@ int hashmap_insert(struct hashmap *map, long key, long value,
 
 	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
 	if (strategy != HASHMAP_APPEND &&
-	    hashmap_find_entry(map, key, h, NULL, &entry)) {
+	    __hashmap__find_entry(map, key, h, NULL, &entry)) {
 		if (old_key)
 			*old_key = entry->key;
 		if (old_value)
@@ -184,8 +184,8 @@ int hashmap_insert(struct hashmap *map, long key, long value,
 	if (strategy == HASHMAP_UPDATE)
 		return -ENOENT;
 
-	if (hashmap_needs_to_grow(map)) {
-		err = hashmap_grow(map);
+	if (__hashmap__needs_to_grow(map)) {
+		err = __hashmap__grow(map);
 		if (err)
 			return err;
 		h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
@@ -197,19 +197,19 @@ int hashmap_insert(struct hashmap *map, long key, long value,
 
 	entry->key = key;
 	entry->value = value;
-	hashmap_add_entry(&map->buckets[h], entry);
+	__hashmap__add_entry(&map->buckets[h], entry);
 	map->sz++;
 
 	return 0;
 }
 
-bool hashmap_find(const struct hashmap *map, long key, long *value)
+bool __hashmap__find(const struct hashmap *map, long key, long *value)
 {
 	struct hashmap_entry *entry;
 	size_t h;
 
 	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
-	if (!hashmap_find_entry(map, key, h, NULL, &entry))
+	if (!__hashmap__find_entry(map, key, h, NULL, &entry))
 		return false;
 
 	if (value)
@@ -217,14 +217,14 @@ bool hashmap_find(const struct hashmap *map, long key, long *value)
 	return true;
 }
 
-bool hashmap_delete(struct hashmap *map, long key,
-		    long *old_key, long *old_value)
+bool __hashmap__delete(struct hashmap *map, long key,
+		       long *old_key, long *old_value)
 {
 	struct hashmap_entry **pprev, *entry;
 	size_t h;
 
 	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
-	if (!hashmap_find_entry(map, key, h, &pprev, &entry))
+	if (!__hashmap__find_entry(map, key, h, &pprev, &entry))
 		return false;
 
 	if (old_key)
@@ -232,7 +232,7 @@ bool hashmap_delete(struct hashmap *map, long key,
 	if (old_value)
 		*old_value = entry->value;
 
-	hashmap_del_entry(pprev, entry);
+	__hashmap__del_entry(pprev, entry);
 	free(entry);
 	map->sz--;
 
diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
index 0c4f155e8eb7..f8bc70a33026 100644
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
@@ -80,16 +80,49 @@ struct hashmap {
 	size_t sz;
 };
 
-void hashmap__init(struct hashmap *map, hashmap_hash_fn hash_fn,
-		   hashmap_equal_fn equal_fn, void *ctx);
-struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
-			     hashmap_equal_fn equal_fn,
-			     void *ctx);
-void hashmap__clear(struct hashmap *map);
-void hashmap__free(struct hashmap *map);
+void __hashmap__init(struct hashmap *map, hashmap_hash_fn hash_fn,
+		     hashmap_equal_fn equal_fn, void *ctx);
+struct hashmap *__hashmap__new(hashmap_hash_fn hash_fn,
+			       hashmap_equal_fn equal_fn,
+			       void *ctx);
+void __hashmap__clear(struct hashmap *map);
+void __hashmap__free(struct hashmap *map);
 
-size_t hashmap__size(const struct hashmap *map);
-size_t hashmap__capacity(const struct hashmap *map);
+size_t __hashmap__size(const struct hashmap *map);
+size_t __hashmap__capacity(const struct hashmap *map);
+
+static inline void hashmap__init(struct hashmap *map, hashmap_hash_fn hash_fn,
+				 hashmap_equal_fn equal_fn, void *ctx)
+{
+	__hashmap__init(map, hash_fn, equal_fn, ctx);
+}
+
+static inline struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
+					   hashmap_equal_fn equal_fn,
+					   void *ctx)
+{
+	return __hashmap__new(hash_fn, equal_fn, ctx);
+}
+
+static inline void hashmap__clear(struct hashmap *map)
+{
+	__hashmap__clear(map);
+}
+
+static inline void hashmap__free(struct hashmap *map)
+{
+	__hashmap__free(map);
+}
+
+static inline size_t hashmap__size(const struct hashmap *map)
+{
+	return __hashmap__size(map);
+}
+
+static inline size_t hashmap__capacity(const struct hashmap *map)
+{
+	return __hashmap__capacity(map);
+}
 
 /*
  * Hashmap insertion strategy:
@@ -126,14 +159,14 @@ enum hashmap_insert_strategy {
  * through old_key and old_value to allow calling code do proper memory
  * management.
  */
-int hashmap_insert(struct hashmap *map, long key, long value,
-		   enum hashmap_insert_strategy strategy,
-		   long *old_key, long *old_value);
+int __hashmap__insert(struct hashmap *map, long key, long value,
+		      enum hashmap_insert_strategy strategy,
+		      long *old_key, long *old_value);
 
 #define hashmap__insert(map, key, value, strategy, old_key, old_value) \
-	hashmap_insert((map), (long)(key), (long)(value), (strategy),  \
-		       hashmap_cast_ptr(old_key),		       \
-		       hashmap_cast_ptr(old_value))
+	__hashmap__insert((map), (long)(key), (long)(value), (strategy), \
+			  hashmap_cast_ptr(old_key),			\
+			  hashmap_cast_ptr(old_value))
 
 #define hashmap__add(map, key, value) \
 	hashmap__insert((map), (key), (value), HASHMAP_ADD, NULL, NULL)
@@ -147,17 +180,17 @@ int hashmap_insert(struct hashmap *map, long key, long value,
 #define hashmap__append(map, key, value) \
 	hashmap__insert((map), (key), (value), HASHMAP_APPEND, NULL, NULL)
 
-bool hashmap_delete(struct hashmap *map, long key, long *old_key, long *old_value);
+bool __hashmap__delete(struct hashmap *map, long key, long *old_key, long *old_value);
 
-#define hashmap__delete(map, key, old_key, old_value)		       \
-	hashmap_delete((map), (long)(key),			       \
-		       hashmap_cast_ptr(old_key),		       \
-		       hashmap_cast_ptr(old_value))
+#define hashmap__delete(map, key, old_key, old_value) \
+	__hashmap__delete((map), (long)(key), \
+			  hashmap_cast_ptr(old_key),			\
+			  hashmap_cast_ptr(old_value))
 
-bool hashmap_find(const struct hashmap *map, long key, long *value);
+bool __hashmap__find(const struct hashmap *map, long key, long *value);
 
 #define hashmap__find(map, key, value) \
-	hashmap_find((map), (long)(key), hashmap_cast_ptr(value))
+	__hashmap__find((map), (long)(key), hashmap_cast_ptr(value))
 
 /*
  * hashmap__for_each_entry - iterate over all entries in hashmap
@@ -205,4 +238,4 @@ bool hashmap_find(const struct hashmap *map, long key, long *value);
 	     cur = tmp)							    \
 		if ((map)->equal_fn(cur->key, (_key), (map)->ctx))
 
-#endif /* __LIBBPF_HASHMAP_H */
+#endif /* __PERF_UTIL_HASHMAP_H */
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index 96aeb379e169..c150fc0d7bd3 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -571,7 +571,7 @@ bool hwmon_pmu__have_event(struct perf_pmu *pmu, const char *name)
 
 	key.type = type;
 	key.num = number;
-	if (hashmap_find(&hwm->events, key.type_and_num, /*value=*/NULL))
+	if (hashmap__find(&hwm->events, key.type_and_num, /*value=*/NULL))
 		return true;
 	if (key.num != -1)
 		return false;
-- 
2.56.1.703.gf848ed807c-goog

