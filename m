Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606568;
	b=LH/nYiio+kCSWufzlrN3gr2x1gJLRjXkilbLVWsA4e7R+iJrvLB0Plx6VnpZVSUXKpNw
	 G4qUKrP72ikDTiFn3dob4neCk4uQ2IT76hbH7eeHn8KoGmhHKuhj2fKFWpMnrnKrZXpqH
	 NMymRR+j7iYsUBxguTgVzA2apgM+5Uo9140/rbxYDQhBj06X2bH4EtBEFu0/2h5gvx/ui
	 xccoRzwIwiiKsvwjGavKj356nCLJn++EP+wtyKrcnPcWR45lxQ8UDofYjXJySnquzBy3Q
	 g/COVYfVSqZY+YfCyG4ycxHxZpeZuzt8/qs841RlRTIKu8Quz+zkNpFCpBFr/wielYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=eLMRs6tGAi+pj+BgiCyYGtaXdwslAeT3pBREDlZ4/UY=;
	b=BE1+AAI/iIVauq4AcvJOpWXpkyoFL65d8i6slXjJg8NHR22GRWUroeQEXX7oBN+UOAx2
	 cYpoaUTSZwbZfFOsvrqupC6wqm9n1942/xkLHk47msPVOYu6A5P5FqGDuE5mGhTQaI3Ux
	 J8W0+Hp/5v3Fo8Oo03W7xH2VyD0JqH4aR0kr7eStr+4lJkfgoZgjODCOwrjSWolWC1diy
	 FhJ8ylmjJD98YE1/39jcQ5hrBpA0clV+l4IeJnvXqz0JkULXvp/+3tQ0hAuf3wwGMTmbW
	 zp/PENflKPO0bIAp9YXdLWMZzgU2TEIGENUsT0jU1SzlduC9/g9tUWvUxhUWxddGabw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GwniiCSJ;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E630606A332
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E630606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GwniiCSJ
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-370230d93efso6341895eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606567; x=1795211367; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eLMRs6tGAi+pj+BgiCyYGtaXdwslAeT3pBREDlZ4/UY=;
        b=GwniiCSJ20b/W7ZsBc8Mpv1+3mWcIsnFpa+UgQwDUDtNxxXRII0MqozFeGm1zs1X9E
         grb5A2kW/EHRJMXZjlnIA5nRvGKV4QlK0KQydSmzEGOABvbbitFdZgs9IjGvYVy8YkUe
         FA6MAOyWNixm4PoVfQyNcnO60ZdSryyjakvWEU+YAFNQA89yr0PpC11GDPBkpQd6t3He
         yCt/PQtO5ucMMsVuezMuqkjYdnJN7f0A2Zh9wFRtDQQ6Jg2YbkvSpOgttZjCZakd69rP
         xbXUbWXbFVpx2qfs5tK39gjJMUNVQ5WY1/OjSRB2EtrfJhlRs8keopkBQlYVvWZQHtvo
         V1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606567; x=1795211367;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eLMRs6tGAi+pj+BgiCyYGtaXdwslAeT3pBREDlZ4/UY=;
        b=0KqHExwmy46ZVJgTzIXRetJKdUdUGs45MAd9MUlGbsf9YcKHm1A5nRGW2jbcreQe0y
         9ZHs8yyVPglwWSNlRSlK42C4qmdcsBiBaJye0QPuiCqENv9BTV2xN5lTJRgnQ8ZxnP5E
         EFV9R97U0gyFJ7oI/w0ZhXFqm2vkqWGp2V9s3kU3PK/pTG+vAYhVhpVeKg1GLxsKtl13
         yROWKqRi3/vftCi2dXMxsuhfzHBkhPQfrM8xAamJ7zwivSXhG74v5o3EVb2EyD63jhUm
         TzU4K3EPKRX8QacMvNHnXvrREfmCdJmq3Lrbi+qoLTPhkTyl+Z1ciuwplyU6ZkjO2fhm
         yFNA==
X-Forwarded-Encrypted: i=1; AL+hErEn1In68VezAYmIpwJO6fvDk+gnSRrk481aKJ7Kkm8fGuUr69htEPLqZ/vNT5HfGUQGaq5kL8oJyMNWKM4Tx4X9@vger.kernel.org
X-Gm-Message-State: APuU4Z9Q2BZxPiSx3WtNx60c3IAY+LxFmoDp0pRI2YlKxBwsokUn7cgq
	qyytVVAi55QydGMcFpq8kWTnU1Fe1qhBdZ8UMtadFqH4kYxElkPRIFPR5qfs3AKPqc5pAuf6Miu
	bq2qTe1BMRg==
X-Received: from dyad24.prod.google.com ([2002:a05:693c:8358:b0:369:68b5:ef])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:e2d:b0:378:3227:b4dd
 with SMTP id 5a478bee46e88-37966a5c862mr3175386eec.18.1794606567340; Fri, 13
 Nov 2026 13:49:27 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:30 -0800
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
Message-ID: <20261113214850.3329699-7-irogers@google.com>
Subject: [PATCH v1 06/26] perf hashmap: Fix strict aliasing violations in hashmap
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The hashmap in perf util (copied from libbpf) contained strict
aliasing violations. Specifically, the hashmap_cast_ptr(p) macro was
casting pointers (such as void **) to long *, and these were
subsequently dereferenced in functions like __hashmap__insert(),
__hashmap__find(), and __hashmap__delete().

C's strict aliasing rules (C11 6.5/7) prohibit accessing an object
through an lvalue of an incompatible type. Dereferencing a long * to
write to a void * object is a violation, even if they share the same
size, as they are not compatible types. This can lead to undefined
behavior, especially with aggressive compiler optimizations.

Fix this by:
1. Updating __hashmap__insert(), __hashmap__find(), and
   __hashmap__delete() to take void * for their output parameters
   (old_key, old_value, and value), and zeroing old_key/old_value on
   entry in __hashmap__delete() to match __hashmap__insert().
2. Modifying the implementation to use memcpy() and memset() for
   accessing these output parameters. Accessing an object as an array of
   characters (as done by memcpy) is a permitted exception to the
   strict aliasing rules.
3. Updating the hashmap_cast_ptr(p) macro to return void *, ensuring
   compatibility with the new function signatures while preserving the
   static assertion that ensures the pointed-to type matches the size of
   a long.

Input parameters (key and value) remain as long, as they involve value
conversion rather than incompatible pointer dereferencing, which is safe
under strict aliasing rules.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hashmap.c | 26 ++++++++++++++++----------
 tools/perf/util/hashmap.h |  8 ++++----
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/hashmap.c b/tools/perf/util/hashmap.c
index b6f80a92f5dd..7fd87c7d72be 100644
--- a/tools/perf/util/hashmap.c
+++ b/tools/perf/util/hashmap.c
@@ -8,6 +8,7 @@
 #include <stdint.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <string.h>
 #include <errno.h>
 #include <linux/err.h>
 #include "hashmap.h"
@@ -153,24 +154,24 @@ static bool __hashmap__find_entry(const struct hashmap *map,
 
 int __hashmap__insert(struct hashmap *map, long key, long value,
 		      enum hashmap_insert_strategy strategy,
-		      long *old_key, long *old_value)
+		      void *old_key, void *old_value)
 {
 	struct hashmap_entry *entry;
 	size_t h;
 	int err;
 
 	if (old_key)
-		*old_key = 0;
+		memset(old_key, 0, sizeof(long));
 	if (old_value)
-		*old_value = 0;
+		memset(old_value, 0, sizeof(long));
 
 	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
 	if (strategy != HASHMAP_APPEND &&
 	    __hashmap__find_entry(map, key, h, NULL, &entry)) {
 		if (old_key)
-			*old_key = entry->key;
+			memcpy(old_key, &entry->key, sizeof(long));
 		if (old_value)
-			*old_value = entry->value;
+			memcpy(old_value, &entry->value, sizeof(long));
 
 		if (strategy == HASHMAP_SET || strategy == HASHMAP_UPDATE) {
 			entry->key = key;
@@ -203,7 +204,7 @@ int __hashmap__insert(struct hashmap *map, long key, long value,
 	return 0;
 }
 
-bool __hashmap__find(const struct hashmap *map, long key, long *value)
+bool __hashmap__find(const struct hashmap *map, long key, void *value)
 {
 	struct hashmap_entry *entry;
 	size_t h;
@@ -213,24 +214,29 @@ bool __hashmap__find(const struct hashmap *map, long key, long *value)
 		return false;
 
 	if (value)
-		*value = entry->value;
+		memcpy(value, &entry->value, sizeof(long));
 	return true;
 }
 
 bool __hashmap__delete(struct hashmap *map, long key,
-		       long *old_key, long *old_value)
+		       void *old_key, void *old_value)
 {
 	struct hashmap_entry **pprev, *entry;
 	size_t h;
 
+	if (old_key)
+		memset(old_key, 0, sizeof(long));
+	if (old_value)
+		memset(old_value, 0, sizeof(long));
+
 	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
 	if (!__hashmap__find_entry(map, key, h, &pprev, &entry))
 		return false;
 
 	if (old_key)
-		*old_key = entry->key;
+		memcpy(old_key, &entry->key, sizeof(long));
 	if (old_value)
-		*old_value = entry->value;
+		memcpy(old_value, &entry->value, sizeof(long));
 
 	__hashmap__del_entry(pprev, entry);
 	free(entry);
diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
index f8bc70a33026..4dcc2cf3ef1a 100644
--- a/tools/perf/util/hashmap.h
+++ b/tools/perf/util/hashmap.h
@@ -149,7 +149,7 @@ enum hashmap_insert_strategy {
 	_Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) ||			\
 				sizeof(*(p)) == sizeof(long),				\
 		       #p " pointee should be a long-sized integer or a pointer");	\
-	(long *)(p);									\
+	(void *)(p);									\
 })
 
 /*
@@ -161,7 +161,7 @@ enum hashmap_insert_strategy {
  */
 int __hashmap__insert(struct hashmap *map, long key, long value,
 		      enum hashmap_insert_strategy strategy,
-		      long *old_key, long *old_value);
+		      void *old_key, void *old_value);
 
 #define hashmap__insert(map, key, value, strategy, old_key, old_value) \
 	__hashmap__insert((map), (long)(key), (long)(value), (strategy), \
@@ -180,14 +180,14 @@ int __hashmap__insert(struct hashmap *map, long key, long value,
 #define hashmap__append(map, key, value) \
 	hashmap__insert((map), (key), (value), HASHMAP_APPEND, NULL, NULL)
 
-bool __hashmap__delete(struct hashmap *map, long key, long *old_key, long *old_value);
+bool __hashmap__delete(struct hashmap *map, long key, void *old_key, void *old_value);
 
 #define hashmap__delete(map, key, old_key, old_value) \
 	__hashmap__delete((map), (long)(key), \
 			  hashmap_cast_ptr(old_key),			\
 			  hashmap_cast_ptr(old_value))
 
-bool __hashmap__find(const struct hashmap *map, long key, long *value);
+bool __hashmap__find(const struct hashmap *map, long key, void *value);
 
 #define hashmap__find(map, key, value) \
 	__hashmap__find((map), (long)(key), hashmap_cast_ptr(value))
-- 
2.56.1.703.gf848ed807c-goog

