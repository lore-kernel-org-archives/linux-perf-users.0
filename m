Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD51059B681
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171927; cv=none; b=gubRujishB2s2R0grUpLwpnVcS0YYOatNnMh36Jw0O+ULeheu+9N4jfoN7rSHEobrgjavSlMgMotMuu5aF1p092kESY4yIpUXjVVwLXe6SutpFr4X+v3yVzdKhIRsZB2vMC/qjamn6104UVit+ZMa73j3Ge9rWc9l+aqPsUsqlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171927; c=relaxed/simple;
	bh=FRej2NU9A4SjKNQqc6m1O9y35c6UlrxfyRScAZPQNRg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I1sEv/Y0RtjII21VGuWLhdHS0fstnJ2/jLnV/1nIsdqB3BrbYmwyzLLfieW9oGPYJLoF8fEBDfhGxc0Uoz0gASrugAT34IQNP9tUln0f9vXWSwb2qI7H0QnIA/+FGVlQef+sH5okYc8YPwrHYP36fsj/vdS5KAsDkOmomuQeQmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pWCU4UHa; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pWCU4UHa"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso138038eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 10:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792171924; x=1792776724; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVxTJEB40dG6GDxXJnuPB70nuWsTvirWbakhi4YkxMo=;
        b=pWCU4UHaQFRv7fO7YdOHkNvH/ASIx07bcSTf8u5y2Sh9yBw8KHcDLjT2elBmFpkfvI
         KV/OqCEJfZYEGrOzGKvjKMELcOptCE2YRFCkqoYzHnbzSsgKz8Ppku8Ptln3qj0uIRYL
         1d9g6tUsdH34e0Lttq6a34jkfBIvtOBW1YCv77xSLORUH9ls5kSiZQYSogMDQA+96s3q
         zdOFW1Os+RIMe73Mrn34smn3pzOZ4O6aZk40hsHMiv8ySoPwe9yPpwL8BJsfjgN4PW3x
         s0gw4x86e/dkEI8UJxGsjvBvFDgytJbj/UlTpVQW+kGVKrRd3XqOUNvOMruJP+iP5z1R
         htMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171924; x=1792776724;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PVxTJEB40dG6GDxXJnuPB70nuWsTvirWbakhi4YkxMo=;
        b=nsFelTiaaw3Zcq0uhqRQkzs8ZhLmXM7tb1xsdcdJa8B+VWLneJx6zzLacKFl0AsAIN
         9ySS4GGEkDRjXv9sd8ZQPAvMv3ReAYP4WHk8SLzcr/KMcuD2QYW2aiH6ipi0pc6lwXrB
         yHqUc1ypVKMWzaStyN5XbPdgJux7OZg+xHRZ7FOAzsEKLbIXAQZzspThQVuOmCuzkmJi
         2lD2NxQbb53+kZQ50hoGohrsDQqK9WIlAEWZWwP1r6orInGz2Jq17NqSGo4fMVW9k/Rd
         pk+gl2l1boMU2TpHVhavpPBFcf0wNa1uDUhi95pc2kWYf/BnZDRQ1YiwcsrphE4ovp4B
         r+iQ==
X-Forwarded-Encrypted: i=1; AKwUvBwq/C8i7F/OyxwvkRmfGjnzE9d+l/1ZxZwQOApnMISipQ+AYfO68DXArqvQrksykuzVYJpkQTaDiCa9chhRADw3@vger.kernel.org
X-Gm-Message-State: AFq9FYKC4J9w7tTxxPM8i+g+wJIcNDCStl16rY+6b7WJWjMvz2pgYDKT
	J3WICYRAxpbFH6MYR7u33i49tAY9LtF5WyLcRMkXsserjFaokBJ4R19VzqzNTwJf11dq/boS8U8
	pqXXWRu6H/A==
X-Received: from dlw8.prod.google.com ([2002:a05:7022:48:b0:16b:788b:cc07])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:408a:b0:17d:7b45:f905
 with SMTP id a92af1059eb24-18514a0c6e9mr597402c88.31.1792171923262; Fri, 16
 Oct 2026 10:32:03 -0700 (PDT)
Date: Fri, 16 Oct 2026 10:31:06 -0700
In-Reply-To: <20261016173106.679725-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013222622.1822619-1-irogers@google.com> <20261016173106.679725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016173106.679725-18-irogers@google.com>
Subject: [PATCH v3 17/17] perf maps: Add context analysis annotations
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
index c0fccb776bed..7fbd7cd9c041 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -30,12 +30,12 @@ DECLARE_RC_STRUCT(maps) {
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
@@ -50,26 +50,33 @@ DECLARE_RC_STRUCT(maps) {
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
@@ -119,55 +126,65 @@ static void check_invariants(const struct maps *maps __maybe_unused)
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
@@ -177,11 +194,22 @@ struct machine *maps__machine(const struct maps *maps)
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
@@ -220,12 +248,8 @@ void maps__set_libdw_addr_space_dwfl(struct maps *maps, void *dwfl)
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
@@ -247,11 +271,12 @@ static void maps__init(struct maps *maps, struct machine *machine)
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
@@ -300,6 +325,7 @@ void maps__put(struct maps *maps)
 }
 
 static void __maps__free_maps_by_name(struct maps *maps)
+	__must_hold(maps__lock(maps))
 {
 	if (!maps__maps_by_name(maps))
 		return;
@@ -307,7 +333,7 @@ static void __maps__free_maps_by_name(struct maps *maps)
 	/*
 	 * Free everything to try to do it from the rbtree in the next search
 	 */
-	for (unsigned int i = 0; i < maps__nr_maps(maps); i++)
+	for (unsigned int i = 0; i < __maps__nr_maps(maps); i++)
 		map__put(maps__maps_by_name(maps)[i]);
 
 	zfree(&RC_CHK_ACCESS(maps)->maps_by_name);
@@ -340,12 +366,13 @@ static int map__start_cmp(const void *a, const void *b)
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
@@ -388,7 +415,7 @@ static int maps__sort_by_name(struct maps *maps)
 				err = -ENOMEM;
 			else {
 				struct map **maps_by_address = maps__maps_by_address(maps);
-				unsigned int n = maps__nr_maps(maps);
+				unsigned int n = __maps__nr_maps(maps);
 
 				maps__set_maps_by_name(maps, maps_by_name);
 				for (unsigned int i = 0; i < n; i++)
@@ -397,7 +424,7 @@ static int maps__sort_by_name(struct maps *maps)
 		}
 		if (!err) {
 			qsort(maps_by_name,
-				maps__nr_maps(maps),
+				__maps__nr_maps(maps),
 				sizeof(struct map *),
 				map__strcmp);
 			maps__set_maps_by_name_sorted(maps, true);
@@ -409,18 +436,19 @@ static int maps__sort_by_name(struct maps *maps)
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
@@ -430,18 +458,19 @@ static unsigned int maps__by_address_index(const struct maps *maps, const struct
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
@@ -470,10 +499,11 @@ static void map__set_kmap_maps(struct map *map, struct maps *maps)
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
@@ -540,10 +570,11 @@ int maps__insert(struct maps *maps, struct map *map)
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
@@ -629,7 +660,7 @@ bool maps__empty(struct maps *maps)
 	bool res;
 
 	down_read(maps__lock(maps));
-	res = maps__nr_maps(maps) == 0;
+	res = __maps__nr_maps(maps) == 0;
 	up_read(maps__lock(maps));
 
 	return res;
@@ -657,7 +688,7 @@ int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data)
 			 * the array - this may cause maps to be skipped or
 			 * repeated.
 			 */
-			for (unsigned int i = 0; i < maps__nr_maps(maps); i++) {
+			for (unsigned int i = 0; i < __maps__nr_maps(maps); i++) {
 				struct map **maps_by_address = maps__maps_by_address(maps);
 				struct map *map = maps_by_address[i];
 
@@ -684,7 +715,7 @@ int maps__load_maps(struct maps *maps)
 		return 0;
 
 	down_read(maps__lock(maps));
-	nr_maps = maps__nr_maps(maps);
+	nr_maps = __maps__nr_maps(maps);
 	if (nr_maps == 0) {
 		up_read(maps__lock(maps));
 		return 0;
@@ -717,7 +748,7 @@ void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data
 	down_write(maps__lock(maps));
 
 	maps_by_address = maps__maps_by_address(maps);
-	for (unsigned int i = 0; i < maps__nr_maps(maps);) {
+	for (unsigned int i = 0; i < __maps__nr_maps(maps);) {
 		if (cb(maps_by_address[i], data)) {
 			__maps__remove(maps, maps_by_address[i]);
 			removed = true;
@@ -771,7 +802,7 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, st
 	 * This prevents deadlocking if iteration triggers further map insertions.
 	 */
 	down_read(maps__lock(maps));
-	nr_maps = maps__nr_maps(maps);
+	nr_maps = __maps__nr_maps(maps);
 	maps_copy = calloc(nr_maps, sizeof(*maps_copy));
 	if (maps_copy) {
 		for (unsigned int i = 0; i < nr_maps; i++) {
@@ -856,9 +887,10 @@ size_t maps__fprintf(struct maps *maps, FILE *fp)
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
@@ -883,10 +915,11 @@ static unsigned int first_ending_after(struct maps *maps, const struct map *map)
 
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
 
@@ -943,6 +976,7 @@ static int __maps__insert_sorted(struct maps *maps, unsigned int first_after_ind
  * adjusted or removed so that new fits without overlapping any entries.
  */
 static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
+	__must_hold(maps__lock(maps))
 {
 	int err = 0;
 	unsigned int i, ni = INT_MAX; // Some gcc complain, but depends on maps_by_name...
@@ -954,7 +988,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 	 * Iterate through entries where the end of the existing entry is
 	 * greater-than the new map's start.
 	 */
-	for (i = first_ending_after(maps, new); i < maps__nr_maps(maps); ) {
+	for (i = first_ending_after(maps, new); i < __maps__nr_maps(maps); ) {
 		struct map **maps_by_address = maps__maps_by_address(maps);
 		struct map **maps_by_name = maps__maps_by_name(maps);
 		struct map *pos = maps_by_address[i];
@@ -1065,7 +1099,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			return err;
 		} else {
 			struct map *next = NULL;
-			unsigned int nr_maps = maps__nr_maps(maps);
+			unsigned int nr_maps = __maps__nr_maps(maps);
 
 			if (i + 1 < nr_maps)
 				next = maps_by_address[i + 1];
@@ -1149,8 +1183,8 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
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
@@ -1234,7 +1268,7 @@ struct map *maps__find(struct maps *maps, u64 ip)
 		if (maps__maps_by_address_sorted(maps)) {
 			struct map **mapp = NULL;
 			struct map **maps_by_address = maps__maps_by_address(maps);
-			unsigned int nr_maps = maps__nr_maps(maps);
+			unsigned int nr_maps = __maps__nr_maps(maps);
 
 			if (maps_by_address && nr_maps)
 				mapp = bsearch(&ip, maps_by_address, nr_maps, sizeof(*mapp),
@@ -1270,7 +1304,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 
 		/* First check last found entry. */
 		i = RC_CHK_ACCESS(maps)->last_search_by_name_idx;
-		if (i < maps__nr_maps(maps) && maps__maps_by_name(maps)) {
+		if (i < __maps__nr_maps(maps) && maps__maps_by_name(maps)) {
 			struct dso *dso = map__dso(maps__maps_by_name(maps)[i]);
 
 			if (dso && strcmp(dso__short_name(dso), name) == 0) {
@@ -1282,7 +1316,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 		/* Second search sorted array. */
 		if (!done && maps__maps_by_name_sorted(maps)) {
 			struct map **mapp =
-				bsearch(name, maps__maps_by_name(maps), maps__nr_maps(maps),
+				bsearch(name, maps__maps_by_name(maps), __maps__nr_maps(maps),
 					sizeof(*mapp), map__strcmp_name);
 
 			if (mapp) {
@@ -1305,7 +1339,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 
 				down_read(maps__lock(maps));
 				maps_by_address =  maps__maps_by_address(maps);
-				n = maps__nr_maps(maps);
+				n = __maps__nr_maps(maps);
 				for (i = 0; i < n; i++) {
 					struct map *pos = maps_by_address[i];
 					struct dso *dso = map__dso(pos);
@@ -1335,7 +1369,7 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 		down_read(maps__lock(maps));
 	}
 	i = maps__by_address_index(maps, map);
-	if (++i < maps__nr_maps(maps))
+	if (++i < __maps__nr_maps(maps))
 		result = map__get(maps__maps_by_address(maps)[i]);
 
 	up_read(maps__lock(maps));
@@ -1352,7 +1386,7 @@ void maps__fixup_end(struct maps *maps)
 		__maps__sort_by_address(maps);
 
 	maps_by_address = maps__maps_by_address(maps);
-	n = maps__nr_maps(maps);
+	n = __maps__nr_maps(maps);
 	for (unsigned int i = 1; i < n; i++) {
 		struct map *prev = maps_by_address[i - 1];
 		struct map *curr = maps_by_address[i];
@@ -1399,7 +1433,7 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 	first_after_ = first_ending_after(kmaps, new_map);
 	kmaps_maps_by_address = maps__maps_by_address(kmaps);
 
-	if (first_after_ >= maps__nr_maps(kmaps) ||
+	if (first_after_ >= __maps__nr_maps(kmaps) ||
 	    map__start(kmaps_maps_by_address[first_after_]) >= map__end(new_map)) {
 		/* No overlap so regular insert suffices. */
 		up_read(maps__lock(kmaps));
@@ -1414,7 +1448,7 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 
 	first_after_ = first_ending_after(kmaps, new_map);
 	kmaps_maps_by_address = maps__maps_by_address(kmaps);
-	kmaps__nr_maps = maps__nr_maps(kmaps);
+	kmaps__nr_maps = __maps__nr_maps(kmaps);
 
 	if (first_after_ >= kmaps__nr_maps ||
 	    map__start(kmaps_maps_by_address[first_after_]) >= map__end(new_map)) {
@@ -1468,7 +1502,7 @@ void maps__load_first(struct maps *maps)
 	struct map *first = NULL;
 
 	down_read(maps__lock(maps));
-	if (maps__nr_maps(maps) > 0)
+	if (__maps__nr_maps(maps) > 0)
 		first = map__get(maps__maps_by_address(maps)[0]);
 	up_read(maps__lock(maps));
 
-- 
2.56.0.212.g129ede20d9-goog

