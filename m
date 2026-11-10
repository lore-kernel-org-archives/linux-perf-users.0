Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348535;
	b=M3Wqs9K8/0LKLA0F5oQxFL9Q/ykY3rrnRg7vozCNxNFn4ZCzhQE8YWlQpqiVa7+TMEl5
	 r7aEcHHlz/++H51jfG9tzA56hLtM2/+4WUG8ZDUJErL6zdh53jATtFzohadkZRfZHAmFr
	 ndCEv5x0PKamK00oNruSSA6jISKFQfjimxOBDQuPF3BRykoBDd5kkuco1duiSXwpnTNmc
	 wYYy9toKVP/34u00TTxoFUkVH1UaIR15dnKEQifwjq60xIbFX9fXsjhKKdMX9gJmdXqtG
	 eeCm3edGU9wW01pDmreKN/8AqBKbtWRy6whvNkrAytlEXgn04ogj2W/iI30o9ZpLQEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ZGwd5cSvUMUOmS08Hib/3ug0QS74myq3SreaI/KQwEo=;
	b=N/Qv3009s4yoi3VfNXNZgaZOBr4iWT60oPFM5BrtQYou19ev15XVTYdSexO9EXLgOGxx
	 aNqvz1e6df/U+Ahseb87mIradwlW27CbZB2JbThBd2uTmYsI6M6mtvIgHkoa7Tn2bZyBA
	 YgTZJKFDWJ4rPg3QHDz7nO3VkNfOvEhEtjP2yfHU3GWGN9gLp2qfp0aI9ZTyB6aPjWRCJ
	 YVkbF/jo6STT2vdnFmv5L66pZFuOMByapXoe+zU4NkFSNtTMh5MjYAYkRLDFo9sCcX/Ju
	 dYnpyb5gUYpkVlJdr2D+oTmDNUtG2sh7WiJiApMLI/W0qGt9I6chFWqGdwu9MzhJPxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QPKMFYxV;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE051606A942
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE051606A942
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QPKMFYxV
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso4408380eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 14:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794348534; x=1794953334; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGwd5cSvUMUOmS08Hib/3ug0QS74myq3SreaI/KQwEo=;
        b=QPKMFYxV+54izWmu6UuvOCiqnRVOR6QbIhWqs5pVpdmL//CeEnsmPT1HwWyPeE3eX6
         4nnv1MfLqrvuPgR/m37w99CB2ej3+1FYErF/663DS69GDj0h+9MYifgdgyYv1JvpfXja
         lj26by020RC9L9h5iykXuV/T2bbtix6BJDlPLT/N0r8rh/PVElcW1zRkcmGIHmH2wZZj
         +wK6Ms4xlPY51HSn7K3toLs0UWM9ktbqbdRes6SrRevbL4nm0ARXR7x3HE6+bmHvkdSN
         8TuVtipF4+GjKnceLs9n0zAjYof+gJQw/4JRzLd7Cuozl1vKbGP83L8GTNaAT7I+hR77
         YOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794348534; x=1794953334;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZGwd5cSvUMUOmS08Hib/3ug0QS74myq3SreaI/KQwEo=;
        b=FdBQ5GN7sKystGCW/crNH3+iaaeGf2LxT02KJa7+dGsKmr3WrMau/V+x9rkHSdItld
         mUrLZwAhbJ61PWNnLfv8yxHnCDmqFSldVFsj69+zanhyQFo9upxygde+oJYl4IaBzmeQ
         RkK3xlvBclBf472zAO+hxPeqF1GaVYqPH4Fi/ZgWTg2rE1C003QCfHGwURLRwOd3F1DF
         s1/nLjfh7LQj2r27Swamj3i2+oQy2yktQRmHVzX84gJA/yE2zhK/UQW7a/Wdo9vkCjsH
         /pLRDdr6kiMYraa9YdayNB74Ktvvup/y2Ew/7Lwk+6BczKHnStUs5w/2V8PpwbAbRuHP
         BT4w==
X-Forwarded-Encrypted: i=1; AL+hErElwSoIJnbJHZsU5QPH9F4Dp1uL8oRXNVnrylfp2mKKAtm6zVrGm/HpyM2HIEmKtOhWEI78xgZAhN7tx0/d4vIJ@vger.kernel.org
X-Gm-Message-State: APuU4Z/yB/LuijUNclCBNjgjOyi1yBoX1PdJN9q5PPrWsSF/kFzqEtUh
	+tV37FFstJN7Sjv6NbInPmnpH4M/mZ3zDdg2MWFV9OgxSB+5CpLZ5I9pIx7zy6y34phsH9cSTsr
	gotUE7tBl2w==
X-Received: from dybtg10.prod.google.com ([2002:a05:7301:6e8a:b0:375:5ce5:6e37])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8947:10b0:36f:14ef:ad08
 with SMTP id 5a478bee46e88-376850ced2cmr866764eec.9.1794348533532; Tue, 10
 Nov 2026 14:08:53 -0800 (PST)
Date: Tue, 10 Nov 2026 14:07:56 -0800
In-Reply-To: <20261110220803.2503416-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027231513.816148-1-irogers@google.com> <20261110220803.2503416-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261110220803.2503416-14-irogers@google.com>
Subject: [PATCH v3 13/20] perf maps: Optimize tail insertion and small-append sorting
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

User-space map insertions (from /proc/pid/maps synthesis, runtime
PERF_RECORD_MMAP2, and jitdump) and BPF ksymbol registrations all flow
through maps__fixup_overlap_and_insert() -> first_ending_after().
Currently first_ending_after() has a fast-path check for the first map
(maps_by_address[0]), but no fast-path check for the last map
(maps_by_address[high]). Because /proc/pid/maps entries are synthesized
in ascending address order, every synthesized mapping starts at or after
maps_by_address[high]'s end, yet currently executes the full O(log N)
binary search loop. Add a tail check in first_ending_after() so
non-overlapping ascending insertions complete in O(1).

Additionally, track the sorted prefix lengths (nr_maps_by_address_sorted
and nr_maps_by_name_sorted) in struct maps:
- In __maps__sort_by_address() and maps__sort_by_name(), when the
  unsorted tail is small (k <= 8) or the total map count is small
  (n <= 64), binary-insert the newly appended maps into the sorted
  prefix instead of re-running qsort() over the entire array. This
  avoids O(N^2 log N) re-sorting when maps__find_by_name() is called
  repeatedly between single-map maps__insert() calls in
  dso__process_kernel_symbol() and dso__split_kallsyms().
- In maps__by_address_index() and maps__by_name_index(), binary-search
  the known-sorted prefix before scanning only the unsorted tail.
- Add a unit test in tools/perf/tests/maps.c covering the tail
  fast-path and incremental binary-insertion sort.

Using 'perf bench internals maps':

  Before:
    Average ascending insert + lookup: 63.370 usec (+- 0.476 usec)
    Average append + lookup: 7477.450 usec (+- 20.829 usec)
  After (-6.9% ascending, -98.7% append):
    Average ascending insert + lookup: 58.970 usec (+- 0.609 usec)
    Average append + lookup: 96.670 usec (+- 1.353 usec)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/maps.c |  67 ++++++++++
 tools/perf/util/maps.c  | 281 +++++++++++++++++++++++++++++++++-------
 2 files changed, 298 insertions(+), 50 deletions(-)

diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index ff6d25f9c043..04ab425f4a87 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <inttypes.h>
 #include <unistd.h>
+#include <internal/rc_check.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include "debug.h"
@@ -253,9 +254,75 @@ static int test__maps__fixup_overlap_and_insert(struct test_suite *t __maybe_unu
 	return TEST_OK;
 }
 
+static int test__maps__incremental_sort(struct test_suite *t __maybe_unused,
+					int subtest __maybe_unused)
+{
+	struct map_def ascending_maps[] = {
+		{ "map_c", 1000, 2000 },
+		{ "map_a", 2000, 3000 },
+		{ "map_d", 4000, 5000 },
+	};
+	struct map_def out_of_order = { "map_b", 3000, 4000 };
+	struct map *map, *found;
+	struct perf_env host_env;
+	struct machine *machine;
+	struct maps *maps;
+
+	perf_env__init(&host_env);
+	machine = machine__new_live(&host_env, /*kernel_maps=*/false, getpid());
+	maps = maps__new(machine);
+
+	TEST_ASSERT_VAL("failed to create machine", machine);
+	TEST_ASSERT_VAL("failed to create maps", maps);
+
+	/* Exercise tail fast-path in maps__fixup_overlap_and_insert. */
+	for (unsigned int i = 0; i < ARRAY_SIZE(ascending_maps); i++) {
+		map = dso__new_map(ascending_maps[i].name);
+		TEST_ASSERT_VAL("failed to create map", map);
+		map__set_start(map, ascending_maps[i].start);
+		map__set_end(map, ascending_maps[i].end);
+		TEST_ASSERT_VAL("failed to insert sorted map",
+				maps__fixup_overlap_and_insert(maps, map) == 0);
+		map__put(map);
+	}
+
+	/* Populate maps_by_name and verify lookup. */
+	found = maps__find_by_name(maps, "map_a");
+	TEST_ASSERT_VAL("failed to find map_a by name", found && map__start(found) == 2000);
+	map__zput(found);
+
+	/* Append out-of-order map via maps__insert and verify binary-insertion sort. */
+	map = dso__new_map(out_of_order.name);
+	TEST_ASSERT_VAL("failed to create map_b", map);
+	map__set_start(map, out_of_order.start);
+	map__set_end(map, out_of_order.end);
+	TEST_ASSERT_VAL("failed to insert map_b", maps__insert(maps, map) == 0);
+
+	found = maps__find(maps, 3500);
+	TEST_ASSERT_VAL("failed to find map_b by address", RC_CHK_EQUAL(found, map));
+	map__zput(found);
+
+	found = maps__find_by_name(maps, "map_b");
+	TEST_ASSERT_VAL("failed to find map_b by name", RC_CHK_EQUAL(found, map));
+	map__zput(found);
+
+	maps__remove(maps, map);
+	map__zput(map);
+
+	found = maps__find_by_name(maps, "map_d");
+	TEST_ASSERT_VAL("failed to find map_d after removal", found && map__start(found) == 4000);
+	map__zput(found);
+
+	maps__zput(maps);
+	machine__delete(machine);
+	perf_env__exit(&host_env);
+	return TEST_OK;
+}
+
 static struct test_case tests__maps[] = {
 	TEST_CASE("Test merge_in interface", maps__merge_in),
 	TEST_CASE("Test fix up overlap interface", maps__fixup_overlap_and_insert),
+	TEST_CASE("Test incremental sort and tail insert", maps__incremental_sort),
 	{	.name = NULL, }
 };
 
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index f808df2fe77b..98401fdd0e51 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <stdlib.h>
+#include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include "debug.h"
 #include "dso.h"
@@ -56,6 +57,16 @@ DECLARE_RC_STRUCT(maps) {
 	 * maps_by_name.
 	 */
 	unsigned int	 nr_maps_allocated;
+	/**
+	 * @nr_maps_by_address_sorted: number of leading entries in
+	 * maps_by_address that are known to be sorted.
+	 */
+	unsigned int	 nr_maps_by_address_sorted;
+	/**
+	 * @nr_maps_by_name_sorted: number of leading entries in maps_by_name
+	 * that are known to be sorted.
+	 */
+	unsigned int	 nr_maps_by_name_sorted;
 	/**
 	 * @last_search_by_name_idx: cache of last found by name entry's index
 	 * as frequent searches for the same dso name are common.
@@ -72,8 +83,17 @@ DECLARE_RC_STRUCT(maps) {
 static void check_invariants(const struct maps *maps __maybe_unused)
 {
 #ifndef NDEBUG
-	assert(RC_CHK_ACCESS(maps)->nr_maps <= RC_CHK_ACCESS(maps)->nr_maps_allocated);
-	for (unsigned int i = 0; i < RC_CHK_ACCESS(maps)->nr_maps; i++) {
+	unsigned int nr_maps = RC_CHK_ACCESS(maps)->nr_maps;
+	unsigned int nr_addr_sorted = RC_CHK_ACCESS(maps)->nr_maps_by_address_sorted;
+	unsigned int nr_name_sorted = RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted;
+
+	assert(nr_maps <= RC_CHK_ACCESS(maps)->nr_maps_allocated);
+	assert(nr_addr_sorted <= nr_maps);
+	assert(!RC_CHK_ACCESS(maps)->maps_by_address_sorted || nr_addr_sorted == nr_maps);
+	assert(nr_name_sorted <= nr_maps);
+	assert(!RC_CHK_ACCESS(maps)->maps_by_name_sorted || nr_name_sorted == nr_maps);
+
+	for (unsigned int i = 0; i < nr_maps; i++) {
 		struct map *map = RC_CHK_ACCESS(maps)->maps_by_address[i];
 
 		/* Check map is well-formed. */
@@ -84,28 +104,25 @@ static void check_invariants(const struct maps *maps __maybe_unused)
 		if (map__dso(map) && dso__kernel(map__dso(map)))
 			assert(RC_CHK_EQUAL(map__kmap(map)->kmaps, maps));
 
-		if (i > 0) {
+		if (i > 0 && i < nr_addr_sorted) {
 			struct map *prev = RC_CHK_ACCESS(maps)->maps_by_address[i - 1];
 
-			/* If addresses are sorted... */
-			if (RC_CHK_ACCESS(maps)->maps_by_address_sorted) {
-				/* Maps should be in start address order. */
-				assert(map__start(prev) <= map__start(map));
-				/*
-				 * If the ends of maps aren't broken (during
-				 * construction) then they should be ordered
-				 * too.
-				 */
-				if (!RC_CHK_ACCESS(maps)->ends_broken) {
-					assert(map__end(prev) <= map__end(map));
-					assert(map__end(prev) <= map__start(map) ||
-					       map__start(prev) == map__start(map));
-				}
+			/* Maps in sorted prefix should be in start address order. */
+			assert(map__start(prev) <= map__start(map));
+			/*
+			 * If the ends of maps aren't broken (during
+			 * construction) then they should be ordered
+			 * too.
+			 */
+			if (!RC_CHK_ACCESS(maps)->ends_broken) {
+				assert(map__end(prev) <= map__end(map));
+				assert(map__end(prev) <= map__start(map) ||
+				       map__start(prev) == map__start(map));
 			}
 		}
 	}
 	if (RC_CHK_ACCESS(maps)->maps_by_name) {
-		for (unsigned int i = 0; i < RC_CHK_ACCESS(maps)->nr_maps; i++) {
+		for (unsigned int i = 0; i < nr_maps; i++) {
 			struct map *map = RC_CHK_ACCESS(maps)->maps_by_name[i];
 
 			/*
@@ -137,6 +154,14 @@ static void maps__set_nr_maps_allocated(struct maps *maps, unsigned int nr_maps_
 static void maps__set_nr_maps(struct maps *maps, unsigned int nr_maps)
 {
 	RC_CHK_ACCESS(maps)->nr_maps = nr_maps;
+	if (RC_CHK_ACCESS(maps)->maps_by_address_sorted ||
+	    RC_CHK_ACCESS(maps)->nr_maps_by_address_sorted > nr_maps) {
+		RC_CHK_ACCESS(maps)->nr_maps_by_address_sorted = nr_maps;
+	}
+	if (RC_CHK_ACCESS(maps)->maps_by_name_sorted ||
+	    RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted > nr_maps) {
+		RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted = nr_maps;
+	}
 }
 
 /* Not in the header, to aid reference counting. */
@@ -160,6 +185,8 @@ static bool maps__maps_by_address_sorted(const struct maps *maps)
 static void maps__set_maps_by_address_sorted(struct maps *maps, bool value)
 {
 	RC_CHK_ACCESS(maps)->maps_by_address_sorted = value;
+	if (value)
+		RC_CHK_ACCESS(maps)->nr_maps_by_address_sorted = maps__nr_maps(maps);
 }
 
 static bool maps__maps_by_name_sorted(const struct maps *maps)
@@ -170,6 +197,8 @@ static bool maps__maps_by_name_sorted(const struct maps *maps)
 static void maps__set_maps_by_name_sorted(struct maps *maps, bool value)
 {
 	RC_CHK_ACCESS(maps)->maps_by_name_sorted = value;
+	if (value)
+		RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted = maps__nr_maps(maps);
 }
 
 struct machine *maps__machine(const struct maps *maps)
@@ -241,6 +270,8 @@ static void maps__init(struct maps *maps, struct machine *machine)
 	refcount_set(maps__refcnt(maps), 1);
 	RC_CHK_ACCESS(maps)->nr_maps = 0;
 	RC_CHK_ACCESS(maps)->nr_maps_allocated = 0;
+	RC_CHK_ACCESS(maps)->nr_maps_by_address_sorted = 0;
+	RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted = 0;
 	RC_CHK_ACCESS(maps)->last_search_by_name_idx = 0;
 	RC_CHK_ACCESS(maps)->maps_by_address_sorted = true;
 	RC_CHK_ACCESS(maps)->maps_by_name_sorted = false;
@@ -313,6 +344,7 @@ static void __maps__free_maps_by_name(struct maps *maps)
 	zfree(&RC_CHK_ACCESS(maps)->maps_by_name);
 
 	/* Consistent with maps__init(). When maps_by_name == NULL, maps_by_name_sorted == false */
+	RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted = 0;
 	maps__set_maps_by_name_sorted(maps, false);
 }
 
@@ -339,15 +371,54 @@ static int map__start_cmp(const void *a, const void *b)
 	return map_a_start > map_b_start ? 1 : -1;
 }
 
+static unsigned int maps__by_address_upper_bound(struct map **arr, unsigned int len,
+						 const struct map *map)
+{
+	unsigned int low = 0, high = len;
+
+	while (low < high) {
+		unsigned int mid = low + (high - low) / 2;
+
+		if (map__start_cmp(&arr[mid], &map) <= 0)
+			low = mid + 1;
+		else
+			high = mid;
+	}
+	return low;
+}
+
 static void __maps__sort_by_address(struct maps *maps)
 {
+	struct map **maps_by_address;
+	unsigned int n, m, k;
+
 	if (maps__maps_by_address_sorted(maps))
 		return;
 
-	qsort(maps__maps_by_address(maps),
-		maps__nr_maps(maps),
-		sizeof(struct map *),
-		map__start_cmp);
+	maps_by_address = maps__maps_by_address(maps);
+	n = maps__nr_maps(maps);
+	m = RC_CHK_ACCESS(maps)->nr_maps_by_address_sorted;
+	if (m > n)
+		m = 0;
+	k = n - m;
+
+	if (k <= 8 || n <= 64) {
+		for (unsigned int i = max(m, 1U); i < n; i++) {
+			struct map *map = maps_by_address[i];
+
+			if (map__start_cmp(&maps_by_address[i - 1], &map) > 0) {
+				unsigned int pos =
+					maps__by_address_upper_bound(maps_by_address, i, map);
+
+				memmove(&maps_by_address[pos + 1],
+					&maps_by_address[pos],
+					(i - pos) * sizeof(*maps_by_address));
+				maps_by_address[pos] = map;
+			}
+		}
+	} else {
+		qsort(maps_by_address, n, sizeof(struct map *), map__start_cmp);
+	}
 	maps__set_maps_by_address_sorted(maps, true);
 }
 
@@ -373,6 +444,22 @@ static int map__strcmp(const void *a, const void *b)
 	return ret;
 }
 
+static unsigned int maps__by_name_upper_bound(struct map **arr, unsigned int len,
+					      const struct map *map)
+{
+	unsigned int low = 0, high = len;
+
+	while (low < high) {
+		unsigned int mid = low + (high - low) / 2;
+
+		if (map__strcmp(&arr[mid], &map) <= 0)
+			low = mid + 1;
+		else
+			high = mid;
+	}
+	return low;
+}
+
 static int maps__sort_by_name(struct maps *maps)
 {
 	int err = 0;
@@ -380,6 +467,7 @@ static int maps__sort_by_name(struct maps *maps)
 	down_write(maps__lock(maps));
 	if (!maps__maps_by_name_sorted(maps)) {
 		struct map **maps_by_name = maps__maps_by_name(maps);
+		unsigned int n = maps__nr_maps(maps);
 
 		if (!maps_by_name) {
 			maps_by_name = malloc(RC_CHK_ACCESS(maps)->nr_maps_allocated *
@@ -388,18 +476,38 @@ static int maps__sort_by_name(struct maps *maps)
 				err = -ENOMEM;
 			else {
 				struct map **maps_by_address = maps__maps_by_address(maps);
-				unsigned int n = maps__nr_maps(maps);
 
 				maps__set_maps_by_name(maps, maps_by_name);
 				for (unsigned int i = 0; i < n; i++)
 					maps_by_name[i] = map__get(maps_by_address[i]);
+				RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted = 0;
 			}
 		}
 		if (!err) {
-			qsort(maps_by_name,
-				maps__nr_maps(maps),
-				sizeof(struct map *),
-				map__strcmp);
+			unsigned int m = RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted;
+			unsigned int k;
+
+			if (m > n)
+				m = 0;
+			k = n - m;
+			if (k <= 8 || n <= 64) {
+				for (unsigned int i = max(m, 1U); i < n; i++) {
+					struct map *map = maps_by_name[i];
+
+					if (map__strcmp(&maps_by_name[i - 1], &map) > 0) {
+						unsigned int pos =
+							maps__by_name_upper_bound(maps_by_name,
+										  i, map);
+
+						memmove(&maps_by_name[pos + 1],
+							&maps_by_name[pos],
+							(i - pos) * sizeof(*maps_by_name));
+						maps_by_name[pos] = map;
+					}
+				}
+			} else {
+				qsort(maps_by_name, n, sizeof(struct map *), map__strcmp);
+			}
 			maps__set_maps_by_name_sorted(maps, true);
 		}
 	}
@@ -411,19 +519,27 @@ static int maps__sort_by_name(struct maps *maps)
 static unsigned int maps__by_address_index(const struct maps *maps, const struct map *map)
 {
 	struct map **maps_by_address = maps__maps_by_address(maps);
+	unsigned int nr_sorted = RC_CHK_ACCESS(maps)->nr_maps_by_address_sorted;
+	unsigned int nr_maps = maps__nr_maps(maps);
+
+	if (nr_sorted > nr_maps)
+		nr_sorted = 0;
 
-	if (maps__maps_by_address_sorted(maps)) {
+	if (nr_sorted > 0) {
 		struct map **mapp =
-			bsearch(&map, maps__maps_by_address(maps), maps__nr_maps(maps),
+			bsearch(&map, maps_by_address, nr_sorted,
 				sizeof(*mapp), map__start_cmp);
 
 		if (mapp)
 			return mapp - maps_by_address;
-	} else {
-		for (unsigned int i = 0; i < maps__nr_maps(maps); i++) {
-			if (RC_CHK_ACCESS(maps_by_address[i]) == RC_CHK_ACCESS(map))
-				return i;
-		}
+	}
+	for (unsigned int i = nr_sorted; i < nr_maps; i++) {
+		if (RC_CHK_ACCESS(maps_by_address[i]) == RC_CHK_ACCESS(map))
+			return i;
+	}
+	for (unsigned int i = 0; i < nr_sorted; i++) {
+		if (RC_CHK_ACCESS(maps_by_address[i]) == RC_CHK_ACCESS(map))
+			return i;
 	}
 	pr_err("Map missing from maps");
 	return -1;
@@ -432,19 +548,27 @@ static unsigned int maps__by_address_index(const struct maps *maps, const struct
 static unsigned int maps__by_name_index(const struct maps *maps, const struct map *map)
 {
 	struct map **maps_by_name = maps__maps_by_name(maps);
+	unsigned int nr_sorted = RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted;
+	unsigned int nr_maps = maps__nr_maps(maps);
+
+	if (nr_sorted > nr_maps)
+		nr_sorted = 0;
 
-	if (maps__maps_by_name_sorted(maps)) {
+	if (nr_sorted > 0) {
 		struct map **mapp =
-			bsearch(&map, maps_by_name, maps__nr_maps(maps),
+			bsearch(&map, maps_by_name, nr_sorted,
 				sizeof(*mapp), map__strcmp);
 
 		if (mapp)
 			return mapp - maps_by_name;
-	} else {
-		for (unsigned int i = 0; i < maps__nr_maps(maps); i++) {
-			if (RC_CHK_ACCESS(maps_by_name[i]) == RC_CHK_ACCESS(map))
-				return i;
-		}
+	}
+	for (unsigned int i = nr_sorted; i < nr_maps; i++) {
+		if (RC_CHK_ACCESS(maps_by_name[i]) == RC_CHK_ACCESS(map))
+			return i;
+	}
+	for (unsigned int i = 0; i < nr_sorted; i++) {
+		if (RC_CHK_ACCESS(maps_by_name[i]) == RC_CHK_ACCESS(map))
+			return i;
 	}
 	pr_err("Map missing from maps");
 	return -1;
@@ -519,8 +643,12 @@ static int __maps__insert(struct maps *maps, struct map *new)
 		/* Sorted if maps were already sorted and this map starts after the last one. */
 		maps__set_maps_by_address_sorted(maps,
 			maps__maps_by_address_sorted(maps) &&
-			map__end(maps_by_address[nr_maps - 2]) <= map__start(new));
-		maps__set_maps_by_name_sorted(maps, false);
+			map__end(maps_by_address[nr_maps - 2]) <= map__start(new) &&
+			map__start_cmp(&maps_by_address[nr_maps - 2], &new) <= 0);
+		maps__set_maps_by_name_sorted(maps,
+			maps_by_name &&
+			maps__maps_by_name_sorted(maps) &&
+			map__strcmp(&maps_by_name[nr_maps - 2], &new) <= 0);
 	}
 	if (map__end(new) < map__start(new))
 		RC_CHK_ACCESS(maps)->ends_broken = true;
@@ -552,6 +680,8 @@ static void __maps__remove(struct maps *maps, struct map *map)
 	memmove(&maps_by_address[address_idx],
 		&maps_by_address[address_idx + 1],
 		(nr_maps - address_idx - 1) * sizeof(*maps_by_address));
+	if (address_idx < RC_CHK_ACCESS(maps)->nr_maps_by_address_sorted)
+		--RC_CHK_ACCESS(maps)->nr_maps_by_address_sorted;
 
 	if (maps_by_name) {
 		unsigned int name_idx = maps__by_name_index(maps, map);
@@ -560,9 +690,16 @@ static void __maps__remove(struct maps *maps, struct map *map)
 		memmove(&maps_by_name[name_idx],
 			&maps_by_name[name_idx + 1],
 			(nr_maps - name_idx - 1) *  sizeof(*maps_by_name));
+		if (name_idx < RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted)
+			--RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted;
 	}
 
-	--RC_CHK_ACCESS(maps)->nr_maps;
+	--nr_maps;
+	RC_CHK_ACCESS(maps)->nr_maps = nr_maps;
+	if (RC_CHK_ACCESS(maps)->nr_maps_by_address_sorted == nr_maps)
+		RC_CHK_ACCESS(maps)->maps_by_address_sorted = true;
+	if (maps_by_name && RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted == nr_maps)
+		RC_CHK_ACCESS(maps)->maps_by_name_sorted = true;
 }
 
 void maps__remove(struct maps *maps, struct map *map)
@@ -603,7 +740,9 @@ int maps__mutate_mapping(struct maps *maps, struct map *map,
 
 		err = mutate_cb(map, data);
 
+		RC_CHK_ACCESS(maps)->nr_maps_by_address_sorted = 0;
 		RC_CHK_ACCESS(maps)->maps_by_address_sorted = false;
+		RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted = 0;
 		RC_CHK_ACCESS(maps)->maps_by_name_sorted = false;
 
 		up_write(maps__lock(maps));
@@ -857,6 +996,10 @@ static unsigned int first_ending_after(struct maps *maps, const struct map *map)
 	assert(maps__maps_by_address_sorted(maps));
 	if (low <= high && map__end(maps_by_address[0]) > map__start(map))
 		return 0;
+	if (low <= high && !RC_CHK_ACCESS(maps)->ends_broken &&
+	    map__end(maps_by_address[high]) <= map__start(map)) {
+		return first;
+	}
 
 	while (low <= high) {
 		int mid = (low + high) / 2;
@@ -924,7 +1067,17 @@ static int __maps__insert_sorted(struct maps *maps, unsigned int first_after_ind
 			maps_by_name[nr_maps + 1] = map__get(new2);
 	}
 	RC_CHK_ACCESS(maps)->nr_maps = nr_maps + to_add;
-	maps__set_maps_by_name_sorted(maps, false);
+	RC_CHK_ACCESS(maps)->nr_maps_by_address_sorted = nr_maps + to_add;
+	if (maps_by_name) {
+		if (nr_maps == 0 && to_add == 1) {
+			maps__set_maps_by_name_sorted(maps, true);
+		} else {
+			maps__set_maps_by_name_sorted(maps,
+				maps__maps_by_name_sorted(maps) &&
+				map__strcmp(&maps_by_name[nr_maps - 1], &new1) <= 0 &&
+				(!new2 || map__strcmp(&new1, &new2) <= 0));
+		}
+	}
 	map__set_kmap_maps(new1, maps);
 	map__set_kmap_maps(new2, maps);
 
@@ -1048,9 +1201,16 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			map__set_kmap_maps(new, maps);
 
 			if (maps_by_name) {
+				unsigned int nr_maps = maps__nr_maps(maps);
+
 				map__put(maps_by_name[ni]);
-				maps_by_name[ni] = map__get(new);
-				maps__set_maps_by_name_sorted(maps, false);
+				memmove(&maps_by_name[ni],
+					&maps_by_name[ni + 1],
+					(nr_maps - ni - 1) * sizeof(*maps_by_name));
+				maps_by_name[nr_maps - 1] = map__get(new);
+				if (ni < RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted)
+					--RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted;
+				maps__set_maps_by_name_sorted(maps, nr_maps <= 1);
 			}
 
 			err = __maps__insert_sorted(maps, i + 1, after, NULL);
@@ -1076,8 +1236,13 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 
 				if (maps_by_name) {
 					map__put(maps_by_name[ni]);
-					maps_by_name[ni] = map__get(new);
-					maps__set_maps_by_name_sorted(maps, false);
+					memmove(&maps_by_name[ni],
+						&maps_by_name[ni + 1],
+						(nr_maps - ni - 1) * sizeof(*maps_by_name));
+					maps_by_name[nr_maps - 1] = map__get(new);
+					if (ni < RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted)
+						--RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted;
+					maps__set_maps_by_name_sorted(maps, nr_maps <= 1);
 				}
 
 				check_invariants(maps);
@@ -1093,14 +1258,22 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			memmove(&maps_by_address[i],
 				&maps_by_address[i + 1],
 				(nr_maps - i - 1) * sizeof(*maps_by_address));
+			--RC_CHK_ACCESS(maps)->nr_maps_by_address_sorted;
 
 			if (maps_by_name) {
 				map__put(maps_by_name[ni]);
 				memmove(&maps_by_name[ni],
 					&maps_by_name[ni + 1],
 					(nr_maps - ni - 1) *  sizeof(*maps_by_name));
+				if (ni < RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted)
+					--RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted;
 			}
 			--RC_CHK_ACCESS(maps)->nr_maps;
+			if (maps_by_name &&
+			    RC_CHK_ACCESS(maps)->nr_maps_by_name_sorted ==
+			    RC_CHK_ACCESS(maps)->nr_maps) {
+				RC_CHK_ACCESS(maps)->maps_by_name_sorted = true;
+			}
 			check_invariants(maps);
 			/*
 			 * Maps are ordered but no need to increase `i` as the
@@ -1180,9 +1353,17 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
 			if (err)
 				map__put(new);
 		}
-		maps__set_maps_by_address_sorted(dest, maps__maps_by_address_sorted(parent));
+		if (maps__maps_by_address_sorted(parent)) {
+			maps__set_maps_by_address_sorted(dest, true);
+		} else {
+			RC_CHK_ACCESS(dest)->nr_maps_by_address_sorted =
+				min(RC_CHK_ACCESS(parent)->nr_maps_by_address_sorted,
+				    RC_CHK_ACCESS(dest)->nr_maps);
+			maps__set_maps_by_address_sorted(dest, false);
+		}
 		RC_CHK_ACCESS(dest)->last_search_by_name_idx = 0;
 		/* Values were copied into the name array in address order. */
+		RC_CHK_ACCESS(dest)->nr_maps_by_name_sorted = 0;
 		maps__set_maps_by_name_sorted(dest, false);
 	} else {
 		/* Unexpected copying to a maps containing entries. */
-- 
2.56.0.542.g3ef89b7020-goog

