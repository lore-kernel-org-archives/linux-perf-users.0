Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622407;
	b=WdVuk6+hG0hbbFKw1Ob5RKPwBR1yiI0BZVgHb+RuY0pcZ4KZKDvnF6nATMlmYOBTgchU
	 8OHu1o/nsO3THHQaXKSCSGzF2k7NPA+bgDyJ6fRRI85uBSa+xmX684Lm7SiDxOCBealsR
	 hUVtwUXhYaoYAH+vuY2gLxFC0pWLvmAubwaXnt3Z8AESgpgaREJR+mN/8rqRV+YCteQm0
	 4dGAB3JSiuBI+JDmXg/m/0KhMNXVEf/SHhIyGjssm9aqCIwLv/hqhmrBa8Mwm0RkClj6S
	 JvMqalfbHd8om4csxXP4UKST4kjugaHVVetndlx6dIrRNV3c6jsIvmj8nLii9MlG6MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=TYMBvXCTRXuQ5mO/8vFF6FRl/G2RGG2wmeXJ7prmFOQ=;
	b=uv9Yms3wREIEQZ21RBIy5INa8mYecbcaOAUA5/YklgMATmrZ40dps27H5NJCgusBjLlO
	 0gBOVrX58JbXCwhJ1+eqepDfpR4Vyoz0pOeePif/ruJsPVYJchZgbTZGR1yDSonMg11z3
	 iUfDSEpKNzYE/HVGk2rTF86xyuHvBJH7wBPseDAJpZIkln58+g9ES0LRDMB8Jcu5HiRvb
	 FiG22Nh0G8gyG+qjhUwFboSjuO2i6szsxaTJp8GatMVypnTnpyZhJojeSdtaxDHDgheS+
	 phZMJvAT2qfhSbLWdmqbo06+a8Z1JHeVNhLFELa4oNbOhjRkXDM0xVC3RLJ0aKiQdDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=o3txSSW5;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978F606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5978F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=o3txSSW5
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1663fb7e005so1790589c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 15:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792622406; x=1793227206; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TYMBvXCTRXuQ5mO/8vFF6FRl/G2RGG2wmeXJ7prmFOQ=;
        b=o3txSSW5+tF/0JoiO6OTWHuKxHjTe2EkCw9iBx+FzF35eog/klmb1EPFDcP0T7Creo
         8qADhONZnRzZ+UMAnEAtdbO4+CAF6vGCVEnwEPYTwj8BggBVRxEUi4oBZQcK8AOZQS5G
         2kx0/lBjUwshRgohjwCXC1U709eCm7iutjHJjGecWt3oa8SxE9dsyEucvh/ID3CeYLSr
         0l5SEho0SHrgPHB9RekSIkeMH8jKCpnT9Te1wsST+YsLGYj0pxttVIB3nnmg5DuEeB+d
         smw2R0ySoYNk/dUX3Qiq9Iwfx1K4yt4ThdL8Dp8dog0Z4qlNS0FK2iH381GScJ2dsUXs
         yqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792622406; x=1793227206;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TYMBvXCTRXuQ5mO/8vFF6FRl/G2RGG2wmeXJ7prmFOQ=;
        b=NfmClzwyPU/FWf+W4z6cTA4Q907i0jFYSCZSzDeqx3ZGDgOecliNjIRo7rSWlamD7z
         iwk+yuHnpZkXLoYtBajI8IelYvTHcPd5snMSQ12E9NTZ7yV6MCUXTxO3waiel4vbf03N
         Ltq8bj7qOh8EkTu19JZmXWN029w6folz5tjOkLctaF8qykYdojVxjH4y86fCosbo7smK
         RV5u+TwcAnv8vDna3Qdur9U1v0RcVusUHeDqUvUcwR3km8hVgTyiHWqM2UJZaYUgr1+D
         dudfeUXDPs4no+PkVaDyO0XfRJrdjrGnVhtCXtR0+0SyFgCeCI6PHVbyXjSe3Phxb0Dy
         nHVg==
X-Forwarded-Encrypted: i=1; AKwUvBxnrTmm2+xR/0cZSyXlEqCcCtzjoX+w0wdXOvFY1OI3os0e93qfEF1P6bOQmL58DU0grHV40Rh227opORLZp/aB@vger.kernel.org
X-Gm-Message-State: AFq9FYKGc8u5ZMFO4voa7pOhzz3MqNJKQlTEDZCXgiNDOiKfVRYQgBPx
	5yb5L9rLUmOllH2HEraR28q5tRytPQv9sPKs6D2XmUtUgxp1p3h7ECjGTf2D3yICUoSkZI97myT
	vl3iQUfbj0g==
X-Received: from dlbps11.prod.google.com ([2002:a05:7023:88b:b0:165:775d:c25a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:451c:10b0:143:50a0:56be
 with SMTP id a92af1059eb24-190a437b8b4mr3918600c88.14.1792622406134; Wed, 21
 Oct 2026 15:40:06 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:39:05 -0700
In-Reply-To: <20261021223905.715051-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021171044.155240-1-irogers@google.com> <20261021223905.715051-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021223905.715051-18-irogers@google.com>
Subject: [PATCH v7 17/17] perf maps: Add context analysis annotations
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add __returns_ctx_lock() to maps__lock(), annotate DECLARE_RC_STRUCT(maps)
members protected by lock with __guarded_by(&lock), and annotate
internal maps helpers with __must_hold() and __must_hold_shared().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 122 ++++++++++++++++++++++++++---------------
 1 file changed, 78 insertions(+), 44 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index e947506c60a5..1c9e8e22793d 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -31,12 +31,12 @@ DECLARE_RC_STRUCT(maps) {
 	 * @maps_by_address: array of maps sorted by their starting address if
 	 * maps_by_address_sorted is true.
 	 */
-	struct map	 **maps_by_address;
+	struct map	 **maps_by_address __guarded_by(&lock);
 	/**
 	 * @maps_by_name: optional array of maps sorted by their dso name if
 	 * maps_by_name_sorted is true.
 	 */
-	struct map	 **maps_by_name;
+	struct map	 **maps_by_name __guarded_by(&lock);
 	struct machine	 *machine;
 #ifdef HAVE_LIBUNWIND_SUPPORT
 	void		*addr_space;
@@ -51,26 +51,33 @@ DECLARE_RC_STRUCT(maps) {
 	 * @nr_maps: number of maps_by_address, and possibly maps_by_name,
 	 * entries that contain maps.
 	 */
-	unsigned int	 nr_maps;
+	unsigned int	 nr_maps __guarded_by(&lock);
 	/**
 	 * @nr_maps_allocated: number of entries in maps_by_address and possibly
 	 * maps_by_name.
 	 */
-	unsigned int	 nr_maps_allocated;
+	unsigned int	 nr_maps_allocated __guarded_by(&lock);
 	/**
 	 * @last_search_by_name_idx: cache of last found by name entry's index
 	 * as frequent searches for the same dso name are common.
 	 */
 	unsigned int	 last_search_by_name_idx;
 	/** @maps_by_address_sorted: is maps_by_address sorted. */
-	bool		 maps_by_address_sorted;
+	bool		 maps_by_address_sorted __guarded_by(&lock);
 	/** @maps_by_name_sorted: is maps_by_name sorted. */
-	bool		 maps_by_name_sorted;
+	bool		 maps_by_name_sorted __guarded_by(&lock);
 	/** @ends_broken: does the map contain a map where end values are unset/unsorted? */
-	bool		 ends_broken;
+	bool		 ends_broken __guarded_by(&lock);
 };
 
+static struct rw_semaphore *maps__lock(const struct maps *maps)
+	__returns_ctx_lock(&RC_CHK_ACCESS(maps)->lock)
+{
+	return (struct rw_semaphore *)&RC_CHK_ACCESS(maps)->lock;
+}
+
 static void check_invariants(const struct maps *maps __maybe_unused)
+	__must_hold_shared(maps__lock(maps))
 {
 #ifndef NDEBUG
 	assert(RC_CHK_ACCESS(maps)->nr_maps <= RC_CHK_ACCESS(maps)->nr_maps_allocated);
@@ -120,55 +127,65 @@ static void check_invariants(const struct maps *maps __maybe_unused)
 }
 
 static struct map **maps__maps_by_address(const struct maps *maps)
+	__must_hold_shared(maps__lock(maps))
 {
 	return RC_CHK_ACCESS(maps)->maps_by_address;
 }
 
 static void maps__set_maps_by_address(struct maps *maps, struct map **new)
+	__must_hold(maps__lock(maps))
 {
 	RC_CHK_ACCESS(maps)->maps_by_address = new;
 
 }
 
 static void maps__set_nr_maps_allocated(struct maps *maps, unsigned int nr_maps_allocated)
+	__must_hold(maps__lock(maps))
 {
 	RC_CHK_ACCESS(maps)->nr_maps_allocated = nr_maps_allocated;
 }
 
 static void maps__set_nr_maps(struct maps *maps, unsigned int nr_maps)
+	__must_hold(maps__lock(maps))
 {
 	RC_CHK_ACCESS(maps)->nr_maps = nr_maps;
 }
 
 /* Not in the header, to aid reference counting. */
 static struct map **maps__maps_by_name(const struct maps *maps)
+	__must_hold_shared(maps__lock(maps))
 {
 	return RC_CHK_ACCESS(maps)->maps_by_name;
 
 }
 
 static void maps__set_maps_by_name(struct maps *maps, struct map **new)
+	__must_hold(maps__lock(maps))
 {
 	RC_CHK_ACCESS(maps)->maps_by_name = new;
 
 }
 
 static bool maps__maps_by_address_sorted(const struct maps *maps)
+	__must_hold_shared(maps__lock(maps))
 {
 	return RC_CHK_ACCESS(maps)->maps_by_address_sorted;
 }
 
 static void maps__set_maps_by_address_sorted(struct maps *maps, bool value)
+	__must_hold(maps__lock(maps))
 {
 	RC_CHK_ACCESS(maps)->maps_by_address_sorted = value;
 }
 
 static bool maps__maps_by_name_sorted(const struct maps *maps)
+	__must_hold_shared(maps__lock(maps))
 {
 	return RC_CHK_ACCESS(maps)->maps_by_name_sorted;
 }
 
 static void maps__set_maps_by_name_sorted(struct maps *maps, bool value)
+	__must_hold(maps__lock(maps))
 {
 	RC_CHK_ACCESS(maps)->maps_by_name_sorted = value;
 }
@@ -178,11 +195,22 @@ struct machine *maps__machine(const struct maps *maps)
 	return RC_CHK_ACCESS(maps)->machine;
 }
 
-unsigned int maps__nr_maps(const struct maps *maps)
+static unsigned int __maps__nr_maps(const struct maps *maps)
+	__must_hold_shared(maps__lock(maps))
 {
 	return RC_CHK_ACCESS(maps)->nr_maps;
 }
 
+unsigned int maps__nr_maps(const struct maps *maps)
+{
+	unsigned int nr;
+
+	down_read(maps__lock(maps));
+	nr = __maps__nr_maps(maps);
+	up_read(maps__lock(maps));
+	return nr;
+}
+
 refcount_t *maps__refcnt(struct maps *maps)
 {
 	return &RC_CHK_ACCESS(maps)->refcnt;
@@ -221,12 +249,8 @@ void maps__set_libdw_addr_space_dwfl(struct maps *maps, void *dwfl)
 }
 #endif
 
-static struct rw_semaphore *maps__lock(struct maps *maps)
-{
-	return &RC_CHK_ACCESS(maps)->lock;
-}
-
 static void maps__init(struct maps *maps, struct machine *machine)
+	__context_unsafe(/* initialization */)
 {
 	init_rwsem(maps__lock(maps));
 	RC_CHK_ACCESS(maps)->maps_by_address = NULL;
@@ -248,11 +272,12 @@ static void maps__init(struct maps *maps, struct machine *machine)
 }
 
 static void maps__exit(struct maps *maps)
+	__context_unsafe(/* teardown */)
 {
 	struct map **maps_by_address = maps__maps_by_address(maps);
 	struct map **maps_by_name = maps__maps_by_name(maps);
 
-	for (unsigned int i = 0; i < maps__nr_maps(maps); i++) {
+	for (unsigned int i = 0; i < __maps__nr_maps(maps); i++) {
 		map__zput(maps_by_address[i]);
 		if (maps_by_name)
 			map__zput(maps_by_name[i]);
@@ -301,6 +326,7 @@ void maps__put(struct maps *maps)
 }
 
 static void __maps__free_maps_by_name(struct maps *maps)
+	__must_hold(maps__lock(maps))
 {
 	if (!maps__maps_by_name(maps))
 		return;
@@ -308,7 +334,7 @@ static void __maps__free_maps_by_name(struct maps *maps)
 	/*
 	 * Free everything to try to do it from the rbtree in the next search
 	 */
-	for (unsigned int i = 0; i < maps__nr_maps(maps); i++)
+	for (unsigned int i = 0; i < __maps__nr_maps(maps); i++)
 		map__put(maps__maps_by_name(maps)[i]);
 
 	zfree(&RC_CHK_ACCESS(maps)->maps_by_name);
@@ -341,12 +367,13 @@ static int map__start_cmp(const void *a, const void *b)
 }
 
 static void __maps__sort_by_address(struct maps *maps)
+	__must_hold(maps__lock(maps))
 {
 	if (maps__maps_by_address_sorted(maps))
 		return;
 
 	qsort(maps__maps_by_address(maps),
-		maps__nr_maps(maps),
+		__maps__nr_maps(maps),
 		sizeof(struct map *),
 		map__start_cmp);
 	maps__set_maps_by_address_sorted(maps, true);
@@ -389,7 +416,7 @@ static int maps__sort_by_name(struct maps *maps)
 				err = -ENOMEM;
 			else {
 				struct map **maps_by_address = maps__maps_by_address(maps);
-				unsigned int n = maps__nr_maps(maps);
+				unsigned int n = __maps__nr_maps(maps);
 
 				maps__set_maps_by_name(maps, maps_by_name);
 				for (unsigned int i = 0; i < n; i++)
@@ -398,7 +425,7 @@ static int maps__sort_by_name(struct maps *maps)
 		}
 		if (!err) {
 			qsort(maps_by_name,
-				maps__nr_maps(maps),
+				__maps__nr_maps(maps),
 				sizeof(struct map *),
 				map__strcmp);
 			maps__set_maps_by_name_sorted(maps, true);
@@ -410,18 +437,19 @@ static int maps__sort_by_name(struct maps *maps)
 }
 
 static unsigned int maps__by_address_index(const struct maps *maps, const struct map *map)
+	__must_hold_shared(maps__lock(maps))
 {
 	struct map **maps_by_address = maps__maps_by_address(maps);
 
 	if (maps__maps_by_address_sorted(maps)) {
 		struct map **mapp =
-			bsearch(&map, maps__maps_by_address(maps), maps__nr_maps(maps),
+			bsearch(&map, maps__maps_by_address(maps), __maps__nr_maps(maps),
 				sizeof(*mapp), map__start_cmp);
 
 		if (mapp)
 			return mapp - maps_by_address;
 	} else {
-		for (unsigned int i = 0; i < maps__nr_maps(maps); i++) {
+		for (unsigned int i = 0; i < __maps__nr_maps(maps); i++) {
 			if (RC_CHK_ACCESS(maps_by_address[i]) == RC_CHK_ACCESS(map))
 				return i;
 		}
@@ -431,18 +459,19 @@ static unsigned int maps__by_address_index(const struct maps *maps, const struct
 }
 
 static unsigned int maps__by_name_index(const struct maps *maps, const struct map *map)
+	__must_hold_shared(maps__lock(maps))
 {
 	struct map **maps_by_name = maps__maps_by_name(maps);
 
 	if (maps__maps_by_name_sorted(maps)) {
 		struct map **mapp =
-			bsearch(&map, maps_by_name, maps__nr_maps(maps),
+			bsearch(&map, maps_by_name, __maps__nr_maps(maps),
 				sizeof(*mapp), map__strcmp);
 
 		if (mapp)
 			return mapp - maps_by_name;
 	} else {
-		for (unsigned int i = 0; i < maps__nr_maps(maps); i++) {
+		for (unsigned int i = 0; i < __maps__nr_maps(maps); i++) {
 			if (RC_CHK_ACCESS(maps_by_name[i]) == RC_CHK_ACCESS(map))
 				return i;
 		}
@@ -471,10 +500,11 @@ static void map__set_kmap_maps(struct map *map, struct maps *maps)
 }
 
 static int __maps__insert(struct maps *maps, struct map *new)
+	__must_hold(maps__lock(maps))
 {
 	struct map **maps_by_address = maps__maps_by_address(maps);
 	struct map **maps_by_name = maps__maps_by_name(maps);
-	unsigned int nr_maps = maps__nr_maps(maps);
+	unsigned int nr_maps = __maps__nr_maps(maps);
 	unsigned int nr_allocate = RC_CHK_ACCESS(maps)->nr_maps_allocated;
 
 	if (nr_maps + 1 > nr_allocate) {
@@ -541,10 +571,11 @@ int maps__insert(struct maps *maps, struct map *map)
 }
 
 static void __maps__remove(struct maps *maps, struct map *map)
+	__must_hold(maps__lock(maps))
 {
 	struct map **maps_by_address = maps__maps_by_address(maps);
 	struct map **maps_by_name = maps__maps_by_name(maps);
-	unsigned int nr_maps = maps__nr_maps(maps);
+	unsigned int nr_maps = __maps__nr_maps(maps);
 	unsigned int address_idx;
 
 	/* Slide later mappings over the one to remove */
@@ -631,7 +662,7 @@ bool maps__empty(struct maps *maps)
 	bool res;
 
 	down_read(maps__lock(maps));
-	res = maps__nr_maps(maps) == 0;
+	res = __maps__nr_maps(maps) == 0;
 	up_read(maps__lock(maps));
 
 	return res;
@@ -659,7 +690,7 @@ int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data)
 			 * the array - this may cause maps to be skipped or
 			 * repeated.
 			 */
-			for (unsigned int i = 0; i < maps__nr_maps(maps); i++) {
+			for (unsigned int i = 0; i < __maps__nr_maps(maps); i++) {
 				struct map **maps_by_address = maps__maps_by_address(maps);
 				struct map *map = maps_by_address[i];
 
@@ -686,7 +717,7 @@ int maps__load_maps(struct maps *maps)
 		return 0;
 
 	down_read(maps__lock(maps));
-	nr_maps = maps__nr_maps(maps);
+	nr_maps = __maps__nr_maps(maps);
 	if (nr_maps == 0) {
 		up_read(maps__lock(maps));
 		return 0;
@@ -719,7 +750,7 @@ void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data
 	down_write(maps__lock(maps));
 
 	maps_by_address = maps__maps_by_address(maps);
-	for (unsigned int i = 0; i < maps__nr_maps(maps);) {
+	for (unsigned int i = 0; i < __maps__nr_maps(maps);) {
 		if (cb(maps_by_address[i], data)) {
 			__maps__remove(maps, maps_by_address[i]);
 			removed = true;
@@ -773,7 +804,7 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, st
 	 * This prevents deadlocking if iteration triggers further map insertions.
 	 */
 	down_read(maps__lock(maps));
-	nr_maps = maps__nr_maps(maps);
+	nr_maps = __maps__nr_maps(maps);
 	maps_copy = calloc(nr_maps, sizeof(*maps_copy));
 	if (maps_copy) {
 		for (unsigned int i = 0; i < nr_maps; i++) {
@@ -858,9 +889,10 @@ size_t maps__fprintf(struct maps *maps, FILE *fp)
  * Same as find_vma() in kernel.
  */
 static unsigned int first_ending_after(struct maps *maps, const struct map *map)
+	__must_hold_shared(maps__lock(maps))
 {
 	struct map **maps_by_address = maps__maps_by_address(maps);
-	int low = 0, high = (int)maps__nr_maps(maps) - 1, first = high + 1;
+	int low = 0, high = (int)__maps__nr_maps(maps) - 1, first = high + 1;
 
 	assert(maps__maps_by_address_sorted(maps));
 	if (low <= high && map__end(maps_by_address[0]) > map__start(map))
@@ -885,10 +917,11 @@ static unsigned int first_ending_after(struct maps *maps, const struct map *map)
 
 static int __maps__insert_sorted(struct maps *maps, unsigned int first_after_index,
 				 struct map *new1, struct map *new2)
+	__must_hold(maps__lock(maps))
 {
 	struct map **maps_by_address = maps__maps_by_address(maps);
 	struct map **maps_by_name = maps__maps_by_name(maps);
-	unsigned int nr_maps = maps__nr_maps(maps);
+	unsigned int nr_maps = __maps__nr_maps(maps);
 	unsigned int nr_allocate = RC_CHK_ACCESS(maps)->nr_maps_allocated;
 	unsigned int to_add = new2 ? 2 : 1;
 
@@ -945,6 +978,7 @@ static int __maps__insert_sorted(struct maps *maps, unsigned int first_after_ind
  * adjusted or removed so that new fits without overlapping any entries.
  */
 static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
+	__must_hold(maps__lock(maps))
 {
 	int err = 0;
 	unsigned int i, ni = INT_MAX; // Some gcc complain, but depends on maps_by_name...
@@ -956,7 +990,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 	 * Iterate through entries where the end of the existing entry is
 	 * greater-than the new map's start.
 	 */
-	for (i = first_ending_after(maps, new); i < maps__nr_maps(maps); ) {
+	for (i = first_ending_after(maps, new); i < __maps__nr_maps(maps); ) {
 		struct map **maps_by_address = maps__maps_by_address(maps);
 		struct map **maps_by_name = maps__maps_by_name(maps);
 		struct map *pos = maps_by_address[i];
@@ -1067,7 +1101,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			return err;
 		} else {
 			struct map *next = NULL;
-			unsigned int nr_maps = maps__nr_maps(maps);
+			unsigned int nr_maps = __maps__nr_maps(maps);
 
 			if (i + 1 < nr_maps)
 				next = maps_by_address[i + 1];
@@ -1151,8 +1185,8 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
 	}
 #endif
 	parent_maps_by_address = maps__maps_by_address(parent);
-	n = maps__nr_maps(parent);
-	if (maps__nr_maps(dest) == 0) {
+	n = __maps__nr_maps(parent);
+	if (__maps__nr_maps(dest) == 0) {
 		/* No existing mappings so just copy from parent to avoid reallocs in insert. */
 		unsigned int nr_maps_allocated = RC_CHK_ACCESS(parent)->nr_maps_allocated;
 		struct map **dest_maps_by_address =
@@ -1236,7 +1270,7 @@ struct map *maps__find(struct maps *maps, u64 ip)
 		if (maps__maps_by_address_sorted(maps)) {
 			struct map **mapp = NULL;
 			struct map **maps_by_address = maps__maps_by_address(maps);
-			unsigned int nr_maps = maps__nr_maps(maps);
+			unsigned int nr_maps = __maps__nr_maps(maps);
 
 			if (maps_by_address && nr_maps)
 				mapp = bsearch(&ip, maps_by_address, nr_maps, sizeof(*mapp),
@@ -1272,7 +1306,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 
 		/* First check last found entry. */
 		i = RC_CHK_ACCESS(maps)->last_search_by_name_idx;
-		if (i < maps__nr_maps(maps) && maps__maps_by_name(maps)) {
+		if (i < __maps__nr_maps(maps) && maps__maps_by_name(maps)) {
 			struct dso *dso = map__dso(maps__maps_by_name(maps)[i]);
 
 			if (dso && strcmp(dso__short_name(dso), name) == 0) {
@@ -1284,7 +1318,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 		/* Second search sorted array. */
 		if (!done && maps__maps_by_name_sorted(maps)) {
 			struct map **mapp =
-				bsearch(name, maps__maps_by_name(maps), maps__nr_maps(maps),
+				bsearch(name, maps__maps_by_name(maps), __maps__nr_maps(maps),
 					sizeof(*mapp), map__strcmp_name);
 
 			if (mapp) {
@@ -1307,7 +1341,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 
 				down_read(maps__lock(maps));
 				maps_by_address =  maps__maps_by_address(maps);
-				n = maps__nr_maps(maps);
+				n = __maps__nr_maps(maps);
 				for (i = 0; i < n; i++) {
 					struct map *pos = maps_by_address[i];
 					struct dso *dso = map__dso(pos);
@@ -1337,7 +1371,7 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 		down_read(maps__lock(maps));
 	}
 	i = maps__by_address_index(maps, map);
-	if (++i < maps__nr_maps(maps))
+	if (++i < __maps__nr_maps(maps))
 		result = map__get(maps__maps_by_address(maps)[i]);
 
 	up_read(maps__lock(maps));
@@ -1354,7 +1388,7 @@ void maps__fixup_end(struct maps *maps)
 		__maps__sort_by_address(maps);
 
 	maps_by_address = maps__maps_by_address(maps);
-	n = maps__nr_maps(maps);
+	n = __maps__nr_maps(maps);
 	for (unsigned int i = 1; i < n; i++) {
 		struct map *prev = maps_by_address[i - 1];
 		struct map *curr = maps_by_address[i];
@@ -1401,7 +1435,7 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 	first_after_ = first_ending_after(kmaps, new_map);
 	kmaps_maps_by_address = maps__maps_by_address(kmaps);
 
-	if (first_after_ >= maps__nr_maps(kmaps) ||
+	if (first_after_ >= __maps__nr_maps(kmaps) ||
 	    map__start(kmaps_maps_by_address[first_after_]) >= map__end(new_map)) {
 		/* No overlap so regular insert suffices. */
 		up_read(maps__lock(kmaps));
@@ -1416,7 +1450,7 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 
 	first_after_ = first_ending_after(kmaps, new_map);
 	kmaps_maps_by_address = maps__maps_by_address(kmaps);
-	kmaps__nr_maps = maps__nr_maps(kmaps);
+	kmaps__nr_maps = __maps__nr_maps(kmaps);
 
 	if (first_after_ >= kmaps__nr_maps ||
 	    map__start(kmaps_maps_by_address[first_after_]) >= map__end(new_map)) {
@@ -1470,7 +1504,7 @@ void maps__load_first(struct maps *maps)
 	struct map *first = NULL;
 
 	down_read(maps__lock(maps));
-	if (maps__nr_maps(maps) > 0)
+	if (__maps__nr_maps(maps) > 0)
 		first = map__get(maps__maps_by_address(maps)[0]);
 	up_read(maps__lock(maps));
 
-- 
2.56.0.218.g1ec904b173-goog

