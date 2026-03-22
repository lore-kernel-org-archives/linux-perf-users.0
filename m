Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A263009F6
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Mar 2026 00:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774141123; cv=none; b=M7eo6QtRJ6QBpECY45+ScbpX9L8qfRF3aIRjXlDQmNFORc8NBpuKJwHJ8KnIHY6Zrm1MmEgxFsMGE3DermKBL/G2NT/XZHHXP8Lz65nhcsDV3jCFZ1pwmUGETmuxPLomhIZAEMNMEGgUZgJabWrorADgYlHmQr6OsYzeczfjEXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774141123; c=relaxed/simple;
	bh=Xi26mi2r8DHR8oMuMh395oOrh2l3ijlWFs+X3Pz+Xt4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b7GDQqed8krQ1EXvUn/6KgdhNYKTjgPo5ece5GWafSNfJxqNwW1HSkJ7QqM17unIJqSvIWnaJVFoozc84krojo5v4EdGdZV1Xa0gErgt1HhWiX+2oSlrnajenry1rRTRHB4saHyglPvQ1usF+u1eIIVl9AzA+6sOgIbD3k8Ftss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l85hh+h7; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l85hh+h7"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12a77b008deso26726607c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 17:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774141121; x=1774745921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5+u7im+r5FXXC5mFCuuw+HnvASxDTX01rUlO6Z3BfdU=;
        b=l85hh+h7lRYcVH90Y08Ig+OECU1/TRpoL1wYGvx62vWJIMI8tEEHcjRkj8tK2jL+ml
         DMx/dix2rVntsCybVHGbScU4FtpKQ6liTUTLxAj71x/7sE3hOA4bYBBj3MVxZ+Xjmw7a
         W+l4bx3u+BDKY6227nM0oZTip1JTc3I5pBtCEPez2xUEGLpJ9eCGcymkfQdWInm7iqKX
         fR+9CjVpPlUu+A95GCMdGAgJnh0njq5V2KW8KVGbIfnBWyNWHwgmeKWWjcoo3p34fVCt
         up0E9lbUR6vetvXR6plHHMj4XLe03ZNPe4dDhl/MkPgGWTGWnBOqlRtJfeZG47VCtexO
         Tpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774141121; x=1774745921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+u7im+r5FXXC5mFCuuw+HnvASxDTX01rUlO6Z3BfdU=;
        b=UT9D8/1sjSc8DmZ2mBx7vbFLyUqprDibnbs3u3yrAO/bCCcV7BmvoT8phelg/ahBl5
         +uRjxsCDacAfHMY+xk+UTprv7LARORHQprMPwSV6jpo43rTfBD6b6xrT0rroYa1KCm3A
         10F6XBSNsTBqv5Ucf8vQfgz34P+vT1qZrzEO/fOXj656IsFf8SnJoe72kCCB1CZ8geBw
         ga44vIpCCd41SHwoO9XFokLhPhCIL088uhCtkRi3+G8Im+HfkHzEqCctFqYGSd5rag50
         vIjUMrOyzelP+ofURY0RGgVepB/Yocb4UaxRhbMDxsqdeqSCoXU0OosXKYhnnACFDKAI
         dxxA==
X-Forwarded-Encrypted: i=1; AJvYcCXTh6rHuJxNRURMkzbUI9YJ0Iv96dNQbPsMuVl3yUrat3rT2JA16fFudUjJ///unHX9ubSir0UirCIj47pd4mNM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/JLnNdMnADQxY0QZZ70qwoTKP2LD9yAypkvGspf7kUA9KKsOr
	9+epV2hWK/U/FBt3QOzdNipGZYZquOh4zlazelgAagRfFYO1wDNN2I3DDpmk7mSuPdV3/uJmGZe
	pFq928pzUjg==
X-Received: from dlbur16.prod.google.com ([2002:a05:7022:ea50:b0:12a:6c32:ffd2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:226:b0:11b:b179:6e17
 with SMTP id a92af1059eb24-12a726d0480mr3862859c88.34.1774141120998; Sat, 21
 Mar 2026 17:58:40 -0700 (PDT)
Date: Sat, 21 Mar 2026 17:58:22 -0700
In-Reply-To: <20260322005823.981079-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fUsaORbZuCtUxFgzMT-Cn2jVDLYfcYGSkXC7TdtyfnatQ@mail.gmail.com>
 <20260322005823.981079-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260322005823.981079-4-irogers@google.com>
Subject: [PATCH v2 3/4] perf hashmap: Fix strict aliasing violations in hashmap
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org
Cc: alexander.shishkin@linux.intel.com, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev
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
index 8c4b1f2af3ed..d90ef4ed384d 100644
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
@@ -153,24 +154,24 @@ static bool perf_hashmap_find_entry(const struct perf_hashmap *map,
 
 int perf_hashmap_insert(struct perf_hashmap *map, long key, long value,
 		   enum perf_hashmap_insert_strategy strategy,
-		   long *old_key, long *old_value)
+		   void *old_key, void *old_value)
 {
 	struct perf_hashmap_entry *entry;
 	size_t h;
 	int err;
 
 	if (old_key)
-		*old_key = 0;
+		memset(old_key, 0, sizeof(long));
 	if (old_value)
-		*old_value = 0;
+		memset(old_value, 0, sizeof(long));
 
 	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
 	if (strategy != PERF_HASHMAP_APPEND &&
 	    perf_hashmap_find_entry(map, key, h, NULL, &entry)) {
 		if (old_key)
-			*old_key = entry->key;
+			memcpy(old_key, &entry->key, sizeof(long));
 		if (old_value)
-			*old_value = entry->value;
+			memcpy(old_value, &entry->value, sizeof(long));
 
 		if (strategy == PERF_HASHMAP_SET || strategy == PERF_HASHMAP_UPDATE) {
 			entry->key = key;
@@ -203,7 +204,7 @@ int perf_hashmap_insert(struct perf_hashmap *map, long key, long value,
 	return 0;
 }
 
-bool perf_hashmap_find(const struct perf_hashmap *map, long key, long *value)
+bool perf_hashmap_find(const struct perf_hashmap *map, long key, void *value)
 {
 	struct perf_hashmap_entry *entry;
 	size_t h;
@@ -213,12 +214,12 @@ bool perf_hashmap_find(const struct perf_hashmap *map, long key, long *value)
 		return false;
 
 	if (value)
-		*value = entry->value;
+		memcpy(value, &entry->value, sizeof(long));
 	return true;
 }
 
 bool perf_hashmap_delete(struct perf_hashmap *map, long key,
-		    long *old_key, long *old_value)
+		    void *old_key, void *old_value)
 {
 	struct perf_hashmap_entry **pprev, *entry;
 	size_t h;
@@ -228,9 +229,9 @@ bool perf_hashmap_delete(struct perf_hashmap *map, long key,
 		return false;
 
 	if (old_key)
-		*old_key = entry->key;
+		memcpy(old_key, &entry->key, sizeof(long));
 	if (old_value)
-		*old_value = entry->value;
+		memcpy(old_value, &entry->value, sizeof(long));
 
 	perf_hashmap_del_entry(pprev, entry);
 	free(entry);
diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
index 310b08c0b669..51ad25dd9980 100644
--- a/tools/perf/util/hashmap.h
+++ b/tools/perf/util/hashmap.h
@@ -116,7 +116,7 @@ enum perf_hashmap_insert_strategy {
 	_Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) ||			\
 				sizeof(*(p)) == sizeof(long),				\
 		       #p " pointee should be a long-sized integer or a pointer");	\
-	(long *)(p);									\
+	(void *)(p);									\
 })
 
 /*
@@ -128,7 +128,7 @@ enum perf_hashmap_insert_strategy {
  */
 int perf_hashmap_insert(struct perf_hashmap *map, long key, long value,
 		   enum perf_hashmap_insert_strategy strategy,
-		   long *old_key, long *old_value);
+		   void *old_key, void *old_value);
 
 #define perf_hashmap__insert(map, key, value, strategy, old_key, old_value) \
 	perf_hashmap_insert((map), (long)(key), (long)(value), (strategy),  \
@@ -147,14 +147,14 @@ int perf_hashmap_insert(struct perf_hashmap *map, long key, long value,
 #define perf_hashmap__append(map, key, value) \
 	perf_hashmap__insert((map), (key), (value), PERF_HASHMAP_APPEND, NULL, NULL)
 
-bool perf_hashmap_delete(struct perf_hashmap *map, long key, long *old_key, long *old_value);
+bool perf_hashmap_delete(struct perf_hashmap *map, long key, void *old_key, void *old_value);
 
 #define perf_hashmap__delete(map, key, old_key, old_value)		       \
 	perf_hashmap_delete((map), (long)(key),			       \
 		       perf_hashmap_cast_ptr(old_key),		       \
 		       perf_hashmap_cast_ptr(old_value))
 
-bool perf_hashmap_find(const struct perf_hashmap *map, long key, long *value);
+bool perf_hashmap_find(const struct perf_hashmap *map, long key, void *value);
 
 #define perf_hashmap__find(map, key, value) \
 	perf_hashmap_find((map), (long)(key), perf_hashmap_cast_ptr(value))
-- 
2.53.0.959.g497ff81fa9-goog

