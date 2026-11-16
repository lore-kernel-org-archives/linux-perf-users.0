Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810889;
	b=mAQvzK82D52nZYayf4JEaYDDeQH84oyqgJeIzzNDyp797kzF59BY29zdh38E04148X4v
	 4jEmn48wDWyjiOeYUUAt2+CDbl1a9n3zWs0f0X/sE5i9PaiWTpiu3erSuB/eojnCASnSn
	 I2UgFPiibIj2bW34UozCHvIszdIbc8lH3e90zxg2lBOLmaPlHyuhxZCphrRzT7WLDW+5s
	 cvjJ1KB1n/1+5Sru4eT2g5ixLlcWYaziAaz51VI7mtJDBeXk/UM0nS1jMy53FRCiu1WXQ
	 Pyt9UA9EWZeDoRN3qegWIbYrIWB+YK3WmIDEq3SACpzBUM/AFyAn1tk4Xbu7vv2YwaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=HJDQxPYa0GAj7A61+fE8Awdi8wFHW3qKC9OAlJkGjcg=;
	b=h1dYoVYxexN4hrUHxlyAIf8F5EfYEgUPjXgkD9UbBMWQRvQnfHlO5yLoA5AwzU93W8/d
	 LYazTF5s8WLfdK8DMrTIblHgTInQy7p72BAjxBF9AoMaAIHsPwmG8SnxXyAChH3pw02Gb
	 Xc1MvhZpiJg1IWcHft0cnRA68K8iJbgEM8Vnkd/kksuAcR6TTLXLRV1yQ0L4PDbasJ9oB
	 UvW7f0zyfQrJ8pWz9ASjQtZqxhBmD5/uX1H/fcGt7v3/kMrZ9KCjJ1oKG0XpF7F9KFcFB
	 etJBYVQ+brwh+OJNp1A60H35ckFnSV7EHKK1/2yaz9Fsx4oiira8xLLYEPvMfFbEsPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dW6Pn7l3;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F5606A8A4
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E1F5606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dW6Pn7l3
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso3940867eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 22:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794810888; x=1795415688; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HJDQxPYa0GAj7A61+fE8Awdi8wFHW3qKC9OAlJkGjcg=;
        b=dW6Pn7l3zGzp+P8L75k0Eic+ciIB+R8vhyusevGe7RCRX3R6jvX2sB8tWM75E9cXGM
         lSu/2VgrNqMluy5KmmAABLLWzfYX6M6GzZZlCNepr0KBpwEnKY9G+VySUaNuvE0OfgXs
         yo95Tv9vnQoVL2PF3MHFZAqh6Dfn81zQUik7kYB6ueSCWEI4BfmgIA1URx7rUGMa6roB
         rF/TGVHFO+2NyoVGVvcK6jru8RvMYy/kcgWaTNWO1XbI0rfvR6z5+m4krZXMfyCiW553
         c/o/h/PM8ESFQOyVQwqywCI/8zJ1IgBd2Roep1RlMmRJTE6inZyR/Anfvj8i6935cnNk
         Kmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794810888; x=1795415688;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HJDQxPYa0GAj7A61+fE8Awdi8wFHW3qKC9OAlJkGjcg=;
        b=DXhnQzpdFrhOvxVL13ruJ1mrRqoW/aARsjeT8aNLjUgFjLWl09ERXBpTqEp/CdI8nJ
         YAEH81OQhqEyD8juUcJ46NoC4OAWfCcJxxlLUs468+OfZp/j3wUhMbwviXCkdX0KOZeU
         /A6rKRK7XDT4qCnqcJBHQwX1uVs01hZ9Cb5Hsx93S44ASJb9uBhVMX7veKKVCRGLPbVX
         vWSpLFj+PQMKvun6fKh1FeRJNBn1/eRiRNcl+svyKXTGqGqcw/qSHH8TolOgSRAjpDp8
         Ze2roZDZCx1ZJX9yA5kXH6zqxCNpJDWt/EzS347wagiXDgdmdccyDHJgIyU0ctTaSlQR
         uyrA==
X-Forwarded-Encrypted: i=1; AL+hErGxHUtJ/4CcX8gh0ui09RDDHF+NC/kx9hMmBBvpKC7yz0r3SFrr5Ni2qPJnV5jGXLxVRMQvSet3tm9gDb2th49v@vger.kernel.org
X-Gm-Message-State: APuU4Z+TwofY41OxMWt4ymA9O7LDW8pmqYzQIOrHpVEw0fNR0R3XjLrw
	hguvnQ/6Z5j4gOK1FRkUhZ4Hh8WkWSoAXKSBtsV7xMYWCI15sF9CZCS+UQVA+1910OWV3IEyCUB
	DYdyQUzQAaA==
X-Received: from dybgv25.prod.google.com ([2002:a05:7301:2319:b0:36f:5688:8a11])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2a16:b0:369:fa21:ba0b
 with SMTP id 5a478bee46e88-3796721cfc1mr9145369eec.33.1794810887168; Sun, 15
 Nov 2026 22:34:47 -0800 (PST)
Date: Sun, 15 Nov 2026 22:34:30 -0800
In-Reply-To: <20261116063435.2817923-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116063435.2817923-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116063435.2817923-5-irogers@google.com>
Subject: [PATCH v5 4/9] perf maps: Optimize tail insertion and small-append sorting
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Additionally, track the sorted prefix lengths (nr_addr_sorted and
nr_name_sorted) in struct maps:
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
 tools/perf/util/maps.c  | 276 +++++++++++++++++++++++++++++++++-------
 2 files changed, 294 insertions(+), 49 deletions(-)

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
index 675fe0223faa..b420c2f2b72a 100644
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
+	 * @nr_addr_sorted: number of leading entries in
+	 * maps_by_address that are known to be sorted.
+	 */
+	unsigned int	 nr_addr_sorted;
+	/**
+	 * @nr_name_sorted: number of leading entries in maps_by_name
+	 * that are known to be sorted.
+	 */
+	unsigned int	 nr_name_sorted;
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
+	unsigned int nr_addr_sorted = RC_CHK_ACCESS(maps)->nr_addr_sorted;
+	unsigned int nr_name_sorted = RC_CHK_ACCESS(maps)->nr_name_sorted;
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
+	    RC_CHK_ACCESS(maps)->nr_addr_sorted > nr_maps) {
+		RC_CHK_ACCESS(maps)->nr_addr_sorted = nr_maps;
+	}
+	if (RC_CHK_ACCESS(maps)->maps_by_name_sorted ||
+	    RC_CHK_ACCESS(maps)->nr_name_sorted > nr_maps) {
+		RC_CHK_ACCESS(maps)->nr_name_sorted = nr_maps;
+	}
 }
 
 /* Not in the header, to aid reference counting. */
@@ -160,6 +185,8 @@ static bool maps__maps_by_address_sorted(const struct maps *maps)
 static void maps__set_maps_by_address_sorted(struct maps *maps, bool value)
 {
 	RC_CHK_ACCESS(maps)->maps_by_address_sorted = value;
+	if (value)
+		RC_CHK_ACCESS(maps)->nr_addr_sorted = maps__nr_maps(maps);
 }
 
 static bool maps__maps_by_name_sorted(const struct maps *maps)
@@ -170,6 +197,8 @@ static bool maps__maps_by_name_sorted(const struct maps *maps)
 static void maps__set_maps_by_name_sorted(struct maps *maps, bool value)
 {
 	RC_CHK_ACCESS(maps)->maps_by_name_sorted = value;
+	if (value)
+		RC_CHK_ACCESS(maps)->nr_name_sorted = maps__nr_maps(maps);
 }
 
 struct machine *maps__machine(const struct maps *maps)
@@ -241,6 +270,8 @@ static void maps__init(struct maps *maps, struct machine *machine)
 	refcount_set(maps__refcnt(maps), 1);
 	RC_CHK_ACCESS(maps)->nr_maps = 0;
 	RC_CHK_ACCESS(maps)->nr_maps_allocated = 0;
+	RC_CHK_ACCESS(maps)->nr_addr_sorted = 0;
+	RC_CHK_ACCESS(maps)->nr_name_sorted = 0;
 	RC_CHK_ACCESS(maps)->last_search_by_name_idx = 0;
 	RC_CHK_ACCESS(maps)->maps_by_address_sorted = true;
 	RC_CHK_ACCESS(maps)->maps_by_name_sorted = false;
@@ -313,6 +344,7 @@ static void __maps__free_maps_by_name(struct maps *maps)
 	zfree(&RC_CHK_ACCESS(maps)->maps_by_name);
 
 	/* Consistent with maps__init(). When maps_by_name == NULL, maps_by_name_sorted == false */
+	RC_CHK_ACCESS(maps)->nr_name_sorted = 0;
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
+	m = RC_CHK_ACCESS(maps)->nr_addr_sorted;
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
+				RC_CHK_ACCESS(maps)->nr_name_sorted = 0;
 			}
 		}
 		if (!err) {
-			qsort(maps_by_name,
-				maps__nr_maps(maps),
-				sizeof(struct map *),
-				map__strcmp);
+			unsigned int m = RC_CHK_ACCESS(maps)->nr_name_sorted;
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
+	unsigned int nr_sorted = RC_CHK_ACCESS(maps)->nr_addr_sorted;
+	unsigned int nr_maps = maps__nr_maps(maps);
 
-	if (maps__maps_by_address_sorted(maps)) {
+	if (nr_sorted > nr_maps)
+		nr_sorted = 0;
+
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
+	unsigned int nr_sorted = RC_CHK_ACCESS(maps)->nr_name_sorted;
+	unsigned int nr_maps = maps__nr_maps(maps);
 
-	if (maps__maps_by_name_sorted(maps)) {
+	if (nr_sorted > nr_maps)
+		nr_sorted = 0;
+
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
@@ -521,7 +645,10 @@ static int __maps__insert(struct maps *maps, struct map *new)
 			maps__maps_by_address_sorted(maps) &&
 			map__end(maps_by_address[nr_maps - 2]) <= map__start(new) &&
 			map__start_cmp(&maps_by_address[nr_maps - 2], &new) <= 0);
-		maps__set_maps_by_name_sorted(maps, false);
+		maps__set_maps_by_name_sorted(maps,
+			maps_by_name &&
+			maps__maps_by_name_sorted(maps) &&
+			map__strcmp(&maps_by_name[nr_maps - 2], &new) <= 0);
 	}
 	if (map__end(new) < map__start(new))
 		RC_CHK_ACCESS(maps)->ends_broken = true;
@@ -553,6 +680,8 @@ static void __maps__remove(struct maps *maps, struct map *map)
 	memmove(&maps_by_address[address_idx],
 		&maps_by_address[address_idx + 1],
 		(nr_maps - address_idx - 1) * sizeof(*maps_by_address));
+	if (address_idx < RC_CHK_ACCESS(maps)->nr_addr_sorted)
+		--RC_CHK_ACCESS(maps)->nr_addr_sorted;
 
 	if (maps_by_name) {
 		unsigned int name_idx = maps__by_name_index(maps, map);
@@ -561,9 +690,16 @@ static void __maps__remove(struct maps *maps, struct map *map)
 		memmove(&maps_by_name[name_idx],
 			&maps_by_name[name_idx + 1],
 			(nr_maps - name_idx - 1) *  sizeof(*maps_by_name));
+		if (name_idx < RC_CHK_ACCESS(maps)->nr_name_sorted)
+			--RC_CHK_ACCESS(maps)->nr_name_sorted;
 	}
 
-	--RC_CHK_ACCESS(maps)->nr_maps;
+	--nr_maps;
+	RC_CHK_ACCESS(maps)->nr_maps = nr_maps;
+	if (RC_CHK_ACCESS(maps)->nr_addr_sorted == nr_maps)
+		RC_CHK_ACCESS(maps)->maps_by_address_sorted = true;
+	if (maps_by_name && RC_CHK_ACCESS(maps)->nr_name_sorted == nr_maps)
+		RC_CHK_ACCESS(maps)->maps_by_name_sorted = true;
 }
 
 void maps__remove(struct maps *maps, struct map *map)
@@ -604,7 +740,9 @@ int maps__mutate_mapping(struct maps *maps, struct map *map,
 
 		err = mutate_cb(map, data);
 
+		RC_CHK_ACCESS(maps)->nr_addr_sorted = 0;
 		RC_CHK_ACCESS(maps)->maps_by_address_sorted = false;
+		RC_CHK_ACCESS(maps)->nr_name_sorted = 0;
 		RC_CHK_ACCESS(maps)->maps_by_name_sorted = false;
 
 		up_write(maps__lock(maps));
@@ -858,6 +996,10 @@ static unsigned int first_ending_after(struct maps *maps, const struct map *map)
 	assert(maps__maps_by_address_sorted(maps));
 	if (low <= high && map__end(maps_by_address[0]) > map__start(map))
 		return 0;
+	if (low <= high && !RC_CHK_ACCESS(maps)->ends_broken &&
+	    map__end(maps_by_address[high]) <= map__start(map)) {
+		return first;
+	}
 
 	while (low <= high) {
 		int mid = (low + high) / 2;
@@ -925,7 +1067,17 @@ static int __maps__insert_sorted(struct maps *maps, unsigned int first_after_ind
 			maps_by_name[nr_maps + 1] = map__get(new2);
 	}
 	RC_CHK_ACCESS(maps)->nr_maps = nr_maps + to_add;
-	maps__set_maps_by_name_sorted(maps, false);
+	RC_CHK_ACCESS(maps)->nr_addr_sorted = nr_maps + to_add;
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
 
@@ -1049,9 +1201,16 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
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
+				if (ni < RC_CHK_ACCESS(maps)->nr_name_sorted)
+					--RC_CHK_ACCESS(maps)->nr_name_sorted;
+				maps__set_maps_by_name_sorted(maps, nr_maps <= 1);
 			}
 
 			err = __maps__insert_sorted(maps, i + 1, after, NULL);
@@ -1077,8 +1236,13 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 
 				if (maps_by_name) {
 					map__put(maps_by_name[ni]);
-					maps_by_name[ni] = map__get(new);
-					maps__set_maps_by_name_sorted(maps, false);
+					memmove(&maps_by_name[ni],
+						&maps_by_name[ni + 1],
+						(nr_maps - ni - 1) * sizeof(*maps_by_name));
+					maps_by_name[nr_maps - 1] = map__get(new);
+					if (ni < RC_CHK_ACCESS(maps)->nr_name_sorted)
+						--RC_CHK_ACCESS(maps)->nr_name_sorted;
+					maps__set_maps_by_name_sorted(maps, nr_maps <= 1);
 				}
 
 				check_invariants(maps);
@@ -1094,14 +1258,20 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			memmove(&maps_by_address[i],
 				&maps_by_address[i + 1],
 				(nr_maps - i - 1) * sizeof(*maps_by_address));
+			--RC_CHK_ACCESS(maps)->nr_addr_sorted;
 
 			if (maps_by_name) {
 				map__put(maps_by_name[ni]);
 				memmove(&maps_by_name[ni],
 					&maps_by_name[ni + 1],
 					(nr_maps - ni - 1) *  sizeof(*maps_by_name));
+				if (ni < RC_CHK_ACCESS(maps)->nr_name_sorted)
+					--RC_CHK_ACCESS(maps)->nr_name_sorted;
 			}
 			--RC_CHK_ACCESS(maps)->nr_maps;
+			if (maps_by_name &&
+			    RC_CHK_ACCESS(maps)->nr_name_sorted == RC_CHK_ACCESS(maps)->nr_maps)
+				RC_CHK_ACCESS(maps)->maps_by_name_sorted = true;
 			check_invariants(maps);
 			/*
 			 * Maps are ordered but no need to increase `i` as the
@@ -1181,9 +1351,17 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
 			if (err)
 				map__put(new);
 		}
-		maps__set_maps_by_address_sorted(dest, maps__maps_by_address_sorted(parent));
+		if (maps__maps_by_address_sorted(parent)) {
+			maps__set_maps_by_address_sorted(dest, true);
+		} else {
+			RC_CHK_ACCESS(dest)->nr_addr_sorted =
+				min(RC_CHK_ACCESS(parent)->nr_addr_sorted,
+				    RC_CHK_ACCESS(dest)->nr_maps);
+			maps__set_maps_by_address_sorted(dest, false);
+		}
 		RC_CHK_ACCESS(dest)->last_search_by_name_idx = 0;
 		/* Values were copied into the name array in address order. */
+		RC_CHK_ACCESS(dest)->nr_name_sorted = 0;
 		maps__set_maps_by_name_sorted(dest, false);
 	} else {
 		/* Unexpected copying to a maps containing entries. */
-- 
2.56.1.703.gf848ed807c-goog

