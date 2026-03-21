Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B72DF128
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 02:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774061112; cv=none; b=fLcLNZv0XiCdAicJZFMRJ+opYDrdwSl7za7L5a6ZNOVhwgY4rwAyko+M8bywyH9EjWdSULhc1Ient7HbUPtt5uN6PAtNd1mugMyeTZJLARW6q6yQjMjl13Y3y/HHsmuGvJXpYRbLe1VeGkyfZDKweuEIsqbPE3gNHIHn2LXJd/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774061112; c=relaxed/simple;
	bh=Sx2qZsR0FBH05/ug8h+y2r7OwlFfZZ6aM69pnIg1Usw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=sdTFc6RnXAgXJ1x8b3CuQT/ouFN/rH0EQUp330+bfPcFM5fJWdKBreT6XZQU/T7ISX1tupmSBUfMMnxpRzgceN2ZFZMDnHAK4zIjqip6HLnl2LI4ShcnlgrsKuHt5J4EBCjey12kaZe6E2ioMu/kDlvO52GylxQeX+7xhAlakVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOkK7vbz; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOkK7vbz"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12737f276a2so2391001c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774061110; x=1774665910; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dvU3YbyuJOPN8EpBkqDof0/+6s57Kb8/NNZCwnw6CbA=;
        b=nOkK7vbzx190CnlmPeQXX4xgQvI5d+BFGIvtm8jBco+J3YqDeGkKH36ZvfF27cbs9T
         cANaiLCpiIO0xgCVFx0tu2uPVEUNiVHUoqiWGWxM/kBoArjFB6TVB7CD4TaW/yhLWHb5
         UaYLEMoZp1AuMJYnLlhzNqxyKQhysT7W6T95T/ZNcH7alg6fzJ9fAcZGKjplotCY7nl0
         uhUWsSa1TFXsmWIWoRB7TAaIK3x8uet91bOZ9UQr3NN9xlSYzqMpFUvsni0cdKSbJCCG
         5grjYRAZr3rYWrvRg9abTrDIQtge/NZRU/2v4by/dAif5gA3bMTi85GmCg56DJg7FKee
         hetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774061110; x=1774665910;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvU3YbyuJOPN8EpBkqDof0/+6s57Kb8/NNZCwnw6CbA=;
        b=Y6m4nCRXfQkoEem5WmgtbkoeB5e8iYjH28FDu0PjrcZCHpNU9rsymd1Ng0bzUVXGEU
         o2DZPAzsGi3apXj19MOQAAezA1+NLqIaByQhCfwfonF0J6T4sBaPVIwxjuAsAWkFN1a3
         EusK+g5luOxkSRDSB1qItGwT4WeoUItXdQOsHp3GA2VRNUMJh9jyaqkT/61tNTTAhRGG
         jJ6v4f4JUt69rH9IwacXkam4eSfLsh9gyotHvbup4Y7EoK2rmm+M+Ujz+aNKvT09HxP4
         wxNLdd9Jj+MLjVS0M5yV7CqY+qyOUUM671DoF25tK56FxSSHlJ4OMLdtu1kzAyEkl4f9
         kCIw==
X-Forwarded-Encrypted: i=1; AJvYcCWzxOhk9LvhQbC7YqAiXRnWbBrIJa6lR42Vag4NeJU3vty8sy/XOL1YVj3pPYBplzYkUL1ipmUFNXk/rolVI1V1@vger.kernel.org
X-Gm-Message-State: AOJu0YxUgBaJsFmC61mu9D9V0zGCWNp/pxc1wnxS1pzIee6/Fsu6lbsx
	R+eNNRRY4OlJcOX7uLZwHipCLRuDpXWB043XOw/epLwxc2O1rIk74J9AWMvIo1pJh0DFkn0YIhn
	WEaTGzyNPEA==
X-Received: from dlec8-n1.prod.google.com ([2002:a05:701b:4288:10b0:128:cffb:50d7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:327:b0:128:d494:a1ab
 with SMTP id a92af1059eb24-12a72652be2mr2192729c88.15.1774061109555; Fri, 20
 Mar 2026 19:45:09 -0700 (PDT)
Date: Fri, 20 Mar 2026 19:44:46 -0700
In-Reply-To: <20260321024446.692008-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260321024446.692008-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260321024446.692008-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf tools: Fix strict aliasing violations in hashmap
From: Ian Rogers <irogers@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The hashmap in perf util (copied from libbpf) contained strict
aliasing violations.  Specifically, the hashmap_cast_ptr(p) macro was
casting pointers (such as void **) to long *, and these were
subsequently dereferenced in functions like hashmap_insert(),
hashmap_find(), and hashmap_delete().

C's strict aliasing rules (C11 6.5/7) prohibit accessing an object
through an lvalue of an incompatible type. Dereferencing a long * to
write to a void * object is a violation, even if they share the same
size, as they are not compatible types. This can lead to undefined
behavior, especially with aggressive compiler optimizations.

Fix this by:
1. Updating hashmap_insert(), hashmap_find(), and hashmap_delete() to
   take void * for their output parameters (old_key, old_value, and
   value).
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
 tools/perf/util/hashmap.c | 21 +++++++++++----------
 tools/perf/util/hashmap.h |  8 ++++----
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/hashmap.c b/tools/perf/util/hashmap.c
index 140ee4055676..ef50d262a126 100644
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
@@ -153,24 +154,24 @@ static bool hashmap_find_entry(const struct hashmap *map,
 
 int hashmap_insert(struct hashmap *map, long key, long value,
 		   enum hashmap_insert_strategy strategy,
-		   long *old_key, long *old_value)
+		   void *old_key, void *old_value)
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
 	    hashmap_find_entry(map, key, h, NULL, &entry)) {
 		if (old_key)
-			*old_key = entry->key;
+			memcpy(old_key, &entry->key, sizeof(long));
 		if (old_value)
-			*old_value = entry->value;
+			memcpy(old_value, &entry->value, sizeof(long));
 
 		if (strategy == HASHMAP_SET || strategy == HASHMAP_UPDATE) {
 			entry->key = key;
@@ -203,7 +204,7 @@ int hashmap_insert(struct hashmap *map, long key, long value,
 	return 0;
 }
 
-bool hashmap_find(const struct hashmap *map, long key, long *value)
+bool hashmap_find(const struct hashmap *map, long key, void *value)
 {
 	struct hashmap_entry *entry;
 	size_t h;
@@ -213,12 +214,12 @@ bool hashmap_find(const struct hashmap *map, long key, long *value)
 		return false;
 
 	if (value)
-		*value = entry->value;
+		memcpy(value, &entry->value, sizeof(long));
 	return true;
 }
 
 bool hashmap_delete(struct hashmap *map, long key,
-		    long *old_key, long *old_value)
+		    void *old_key, void *old_value)
 {
 	struct hashmap_entry **pprev, *entry;
 	size_t h;
@@ -228,9 +229,9 @@ bool hashmap_delete(struct hashmap *map, long key,
 		return false;
 
 	if (old_key)
-		*old_key = entry->key;
+		memcpy(old_key, &entry->key, sizeof(long));
 	if (old_value)
-		*old_value = entry->value;
+		memcpy(old_value, &entry->value, sizeof(long));
 
 	hashmap_del_entry(pprev, entry);
 	free(entry);
diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
index 0c4f155e8eb7..a888bf8c05de 100644
--- a/tools/perf/util/hashmap.h
+++ b/tools/perf/util/hashmap.h
@@ -116,7 +116,7 @@ enum hashmap_insert_strategy {
 	_Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) ||			\
 				sizeof(*(p)) == sizeof(long),				\
 		       #p " pointee should be a long-sized integer or a pointer");	\
-	(long *)(p);									\
+	(void *)(p);									\
 })
 
 /*
@@ -128,7 +128,7 @@ enum hashmap_insert_strategy {
  */
 int hashmap_insert(struct hashmap *map, long key, long value,
 		   enum hashmap_insert_strategy strategy,
-		   long *old_key, long *old_value);
+		   void *old_key, void *old_value);
 
 #define hashmap__insert(map, key, value, strategy, old_key, old_value) \
 	hashmap_insert((map), (long)(key), (long)(value), (strategy),  \
@@ -147,14 +147,14 @@ int hashmap_insert(struct hashmap *map, long key, long value,
 #define hashmap__append(map, key, value) \
 	hashmap__insert((map), (key), (value), HASHMAP_APPEND, NULL, NULL)
 
-bool hashmap_delete(struct hashmap *map, long key, long *old_key, long *old_value);
+bool hashmap_delete(struct hashmap *map, long key, void *old_key, void *old_value);
 
 #define hashmap__delete(map, key, old_key, old_value)		       \
 	hashmap_delete((map), (long)(key),			       \
 		       hashmap_cast_ptr(old_key),		       \
 		       hashmap_cast_ptr(old_value))
 
-bool hashmap_find(const struct hashmap *map, long key, long *value);
+bool hashmap_find(const struct hashmap *map, long key, void *value);
 
 #define hashmap__find(map, key, value) \
 	hashmap_find((map), (long)(key), hashmap_cast_ptr(value))
-- 
2.53.0.959.g497ff81fa9-goog

