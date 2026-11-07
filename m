Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026508;
	b=ct36lD3gT7f2kCHlBDu1NLHtQRSS1xgwegAJCOWauANijAXzVuB4VudRzRH1PxgdcEmd
	 i2syD4mkU5iEx/7LGSZAJ2pOk4aYaXb71/gfYxHBtzFZs85+benrtZw5kFDWYvlWKUlit
	 z+d5SikqyRHmCosKPpxguDleg8e9jI289+G4N0MzArr7HWJNCpEwnSxT+30+L2QS+zo+F
	 OBcGVsnCDRJ8s1s798JL2y2WZwParZsGJ2zAZAvvxPTJyWVbVZtqhka22iWpbtica7Jl3
	 4uD1ip/MY2fUqB8prrGX3eXUjVujhxZ9pLhyplo968CbdzGBnEGtIJK4FzPtRAWBIwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=XZtmXCO5rPqSF5TB73JVHVsA8zk5dMz4OqnHdHYyiiI=;
	b=vrpD0sk3oHn7xNEx36HSBUxVH46a2M6wT93PCzbbzYSZ81d7QU+aaGisoPtPJBVa/XLT
	 ERrjBSPCtjjfNpvI1J3fHK/ltOo5ZjZyJktWQxceBbxZq5JfFlcY+/uahT8d+zUwcDKcL
	 XlUjD2iNWcAdVyNh6tehR5gfotRMefuYqk0u93WhL0NRHEUgnV20SPQqjhWsyFo27S3qD
	 PwiOHy5pGFcPuMDbkyPmZQtuqceE3SqymKcQKdO9HvdQ5KIC/vti6znLnlgUzVHIvXTpl
	 5T81BCtoHo99tPk1HE4kWDQorqA7y7qrTCrKC7zeCmiLuKglGUQPbIAnNjeziiHJ8YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JvxdanR6;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED41606D821
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 04:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ED41606D821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JvxdanR6
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36d69ab3c2bso1753036eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 20:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794026508; x=1794631308; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XZtmXCO5rPqSF5TB73JVHVsA8zk5dMz4OqnHdHYyiiI=;
        b=JvxdanR6JsskHk8bo+HHVTVUcKbAiwPzqbXeGY17gwfHrc3lvDmMOf8mNarIf9fZib
         419mV6gz4XFLg4c6HYxHaS2AaVYVePCdbfMHqGqPHYzm+xiFjP95OM/HwYxcRKvjYEna
         XHRt5DvptqLO0mXrkbI9lAZqQxX6IgiH2C568k91s4/sl41uOM75DZXf7NZ2UzQ2SNWT
         2uzNQa9xTxioPAWTJeLBfH2dk6RuOniFDOsHOI3xcDdqyFKuqWDXC0rZlALc5fS5jyMW
         3dbwlQgZ4cjyp1udR559Rc2CMNvdLUC581yKstTFzdgkBGWnuRbSr1T5QeDLnmW9fxYD
         A7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794026508; x=1794631308;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XZtmXCO5rPqSF5TB73JVHVsA8zk5dMz4OqnHdHYyiiI=;
        b=eu5lI3UbH97t2KmF2oKzEZMeziFNu5g9ETrajrivx+3H/OxxBhLTESq2imFQtnHGJ0
         P1rxiXfKqhNwu251rgWo6Ypmgr5eyVCEhaOldXzedm5infwgFrrgzupSGmH0Vi4e3XGc
         LCTRit63pB79Tk2fAtjE5IY2zX75nx40GUTMSQD9kc5XOoLAXx0BBoMJqf6P4v2grKRE
         ZFGwPdpyIiX86VGiLDIY5crK8B2g/yeEP19Uo7Xji4np+qXcRWP8RJJNKuyjYUr2AxQx
         iMoGdmWv7mORVMdNRtAYn5TrcjkHLpGjH9fugjqfoD9Kd2PwHq8pnlaRjX3gTtVIRgPH
         wevg==
X-Forwarded-Encrypted: i=1; AL+hErHd4MI4ou0XQBhkeBPyOtV89eEI/zi18vpzPJnX7Q6hRKW6N4qDshMBUVapB3bqO9ap1h6UrFLZxZ7loI3Cnp4o@vger.kernel.org
X-Gm-Message-State: APuU4Z/fGQ3xGI4cAPCzM/N+xNDBN95kO9My83NjMScXH2TkTvKm1iqS
	++e2VaFU+KEQ4DkpX9hPn84mXTR2TdWgXZySPeWJfnUimK2HM6D3Zla2R267/9dpVIbgagynowE
	JfrkXRWbePA==
X-Received: from dyuw12-n2.prod.google.com ([2002:a05:693c:880c:20b0:370:948e:79b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ea8e:b0:370:ff2:f78d
 with SMTP id 5a478bee46e88-3700ff2f98cmr4135624eec.8.1794026507236; Fri, 06
 Nov 2026 20:41:47 -0800 (PST)
Date: Fri,  6 Nov 2026 20:41:00 -0800
In-Reply-To: <20261107044102.1506626-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107044102.1506626-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261107044102.1506626-20-irogers@google.com>
Subject: [PATCH v11 19/20] perf maps: Fix map index lookup fallback and removal
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

maps__by_address_index() and maps__by_name_index() currently only run
their linear pointer scan when maps_by_address_sorted or
maps_by_name_sorted is false, returning -1 (UINT_MAX) immediately if
bsearch() returns NULL. When a map's start/end address or DSO short_name
is updated in place without clearing the sorted flags (for example
during module map setup), map__start_cmp() or map__strcmp() tie-breakers
can become stale and cause bsearch() to miss an entry that is present in
the array.

Fix the lookup and removal paths so stale sort keys or missing maps are
handled safely:
  - Fall back to the linear pointer scan in maps__by_address_index() and
    maps__by_name_index() when bsearch() returns NULL, and avoid calling
    bsearch() on empty or NULL arrays.
  - Check map__start(prev) < map__start(new) in __maps__insert() before
    preserving maps_by_address_sorted so entries with end == 0 (from
    map__new2()) or equal start addresses do not leave an unsorted array
    marked sorted.
  - Factor out __maps__remove_at() with bounds checks on address_idx and
    name_idx (freeing maps_by_name if out of bounds) and remove from
    maps_by_name before calling map__put() on the maps_by_address entry
    so REFCNT_CHECKING does not see a freed handle. Have
    maps__remove_maps() call __maps__remove_at(maps, i) directly so it
    removes at index i in O(1) without redundant lookup or risking an
    infinite loop if lookup failed.
  - Guard against maps__by_address_index() returning -1 wrapping ++i to
    0 in maps__find_next_entry().
  - Clear maps_by_name_sorted and re-sort maps_by_address when
    maps__fixup_end() clamps equal-start maps, and use
    machine__update_kernel_mmap() instead of the unlocked
    machine__set_kernel_mmap() in machine__create_kernel_maps().

Add a unit test in tests/maps.c covering maps__remove(),
maps__remove_maps(), maps__fixup_end(), and maps__find_next_entry().

Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for addresses")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/maps.c   | 140 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/machine.c |  21 ++----
 tools/perf/util/maps.c    |  92 ++++++++++++++++---------
 3 files changed, 208 insertions(+), 45 deletions(-)

diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index ff6d25f9c043..054e4fafef3f 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <inttypes.h>
+#include <string.h>
 #include <unistd.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
@@ -253,9 +254,148 @@ static int test__maps__fixup_overlap_and_insert(struct test_suite *t __maybe_unu
 	return TEST_OK;
 }
 
+static bool remove_not_keep_cb(struct map *map, void *data)
+{
+	const char *keep_name = data;
+
+	return strcmp(dso__name(map__dso(map)), keep_name) != 0;
+}
+
+static int check_remove_after_end_update(bool swap_order, bool use_by_name,
+					 bool use_fixup_end, bool use_remove_maps)
+{
+	struct perf_env host_env;
+	struct machine *machine;
+	struct maps *maps;
+	struct map *map_a = NULL, *map_b = NULL, *map_keep = NULL, *missing = NULL;
+	struct map *map_first, *map_second, *found;
+	struct map_def expected_after_first[] = {
+		{ "map_same", 1000, use_fixup_end ? 1000 : 1100 },
+		{ "z_keep",   1000, 1300 },
+	};
+	struct map_def expected_after_remove_maps[] = {
+		{ "z_keep",   1000, 1300 },
+	};
+	int ret = TEST_FAIL;
+
+	perf_env__init(&host_env);
+	machine = machine__new_live(&host_env, /*kernel_maps=*/false, getpid());
+	maps = maps__new(machine);
+	if (!machine || !maps)
+		goto out_env;
+
+	map_a = dso__new_map("map_same");
+	map_b = dso__new_map("map_same");
+	map_keep = dso__new_map("z_keep");
+	missing = dso__new_map("missing");
+	if (!map_a || !map_b || !map_keep || !missing)
+		goto out_maps;
+
+	map_first = swap_order ? map_b : map_a;
+	map_second = swap_order ? map_a : map_b;
+
+	map__set_start(map_first, 1000);
+	map__set_end(map_first, 1100);
+	map__set_start(map_second, 1000);
+	map__set_end(map_second, 1200);
+	map__set_start(map_keep, 1000);
+	map__set_end(map_keep, 1300);
+
+	if (maps__insert(maps, map_first) ||
+	    maps__insert(maps, map_second) ||
+	    maps__insert(maps, map_keep))
+		goto out_maps;
+
+	/* Trigger sorting of maps_by_address, and optionally maps_by_name. */
+	found = maps__find(maps, 1000);
+	map__zput(found);
+	if (use_by_name) {
+		found = maps__find_by_name(maps, "z_keep");
+		map__zput(found);
+	}
+
+	/* Missing map must not wrap around to index 0 in maps__find_next_entry(). */
+	found = maps__find_next_entry(maps, missing);
+	if (found) {
+		map__zput(found);
+		goto out_maps;
+	}
+
+	if (use_fixup_end) {
+		maps__fixup_end(maps);
+	} else {
+		/*
+		 * Simulate in-place end adjustment (as in module map setup),
+		 * which can invert the pointer tie-breaker in map__start_cmp().
+		 */
+		map__set_end(map_second, 1100);
+	}
+
+	if (use_remove_maps) {
+		map__zput(map_a);
+		map__zput(map_b);
+		map__zput(map_keep);
+		maps__remove_maps(maps, remove_not_keep_cb, (void *)"z_keep");
+		if (use_by_name) {
+			found = maps__find_by_name(maps, "z_keep");
+			if (found && maps__nr_maps(maps) == 1)
+				ret = TEST_OK;
+			map__zput(found);
+		} else {
+			ret = check_maps(expected_after_remove_maps,
+					 ARRAY_SIZE(expected_after_remove_maps), maps);
+		}
+	} else {
+		maps__remove(maps, map_first);
+		map__zput(map_a);
+		map__zput(map_b);
+		map__zput(map_keep);
+		if (use_by_name) {
+			found = maps__find_by_name(maps, "z_keep");
+			if (found && maps__nr_maps(maps) == 2)
+				ret = TEST_OK;
+			map__zput(found);
+		} else {
+			ret = check_maps(expected_after_first,
+					 ARRAY_SIZE(expected_after_first), maps);
+		}
+	}
+
+out_maps:
+	map__zput(map_a);
+	map__zput(map_b);
+	map__zput(map_keep);
+	map__zput(missing);
+out_env:
+	maps__zput(maps);
+	machine__delete(machine);
+	perf_env__exit(&host_env);
+	return ret;
+}
+
+static int test__maps__remove(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
+{
+	for (int fixup = 0; fixup <= 1; fixup++) {
+		for (int by_name = 0; by_name <= 1; by_name++) {
+			for (int swap = 0; swap <= 1; swap++) {
+				TEST_ASSERT_VAL("maps__remove failed",
+						check_remove_after_end_update(swap, by_name,
+									      fixup, false) ==
+						TEST_OK);
+				TEST_ASSERT_VAL("maps__remove_maps failed",
+						check_remove_after_end_update(swap, by_name,
+									      fixup, true) ==
+						TEST_OK);
+			}
+		}
+	}
+	return TEST_OK;
+}
+
 static struct test_case tests__maps[] = {
 	TEST_CASE("Test merge_in interface", maps__merge_in),
 	TEST_CASE("Test fix up overlap interface", maps__fixup_overlap_and_insert),
+	TEST_CASE("Test remove interface", maps__remove),
 	{	.name = NULL, }
 };
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0044ea046aca..bd1554e9f56d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1551,19 +1551,6 @@ static int machine__create_modules(struct machine *machine)
 	return 0;
 }
 
-static void machine__set_kernel_mmap(struct machine *machine,
-				     u64 start, u64 end)
-{
-	map__set_start(machine->vmlinux_map, start);
-	map__set_end(machine->vmlinux_map, end);
-	/*
-	 * Be a bit paranoid here, some perf.data file came with
-	 * a zero sized synthesized MMAP event for the kernel.
-	 */
-	if (start == 0 && end == 0)
-		map__set_end(machine->vmlinux_map, ~0ULL);
-}
-
 struct kernel_mmap_mutation_ctx {
 	u64 start;
 	u64 end;
@@ -1575,6 +1562,10 @@ static int kernel_mmap_mutate_cb(struct map *map, void *data)
 
 	map__set_start(map, ctx->start);
 	map__set_end(map, ctx->end);
+	/*
+	 * Be a bit paranoid here, some perf.data file came with
+	 * a zero sized synthesized MMAP event for the kernel.
+	 */
 	if (ctx->start == 0 && ctx->end == 0)
 		map__set_end(map, ~0ULL);
 	return 0;
@@ -1639,8 +1630,10 @@ int machine__create_kernel_maps(struct machine *machine)
 							 machine__kernel_map(machine));
 
 		if (next) {
-			machine__set_kernel_mmap(machine, start, map__start(next));
+			ret = machine__update_kernel_mmap(machine, start, map__start(next));
 			map__put(next);
+			if (ret < 0)
+				goto out_put;
 		}
 	}
 
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 7ca33e5218e7..e6a53b31006f 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 #include <linux/zalloc.h>
 #include "debug.h"
 #include "dso.h"
@@ -411,19 +412,19 @@ static int maps__sort_by_name(struct maps *maps)
 static unsigned int maps__by_address_index(const struct maps *maps, const struct map *map)
 {
 	struct map **maps_by_address = maps__maps_by_address(maps);
+	unsigned int nr_maps = maps__nr_maps(maps);
 
-	if (maps__maps_by_address_sorted(maps)) {
+	if (nr_maps && maps__maps_by_address_sorted(maps)) {
 		struct map **mapp =
-			bsearch(&map, maps__maps_by_address(maps), maps__nr_maps(maps),
+			bsearch(&map, maps_by_address, nr_maps,
 				sizeof(*mapp), map__start_cmp);
 
 		if (mapp)
 			return mapp - maps_by_address;
-	} else {
-		for (unsigned int i = 0; i < maps__nr_maps(maps); i++) {
-			if (RC_CHK_ACCESS(maps_by_address[i]) == RC_CHK_ACCESS(map))
-				return i;
-		}
+	}
+	for (unsigned int i = 0; i < nr_maps; i++) {
+		if (RC_CHK_ACCESS(maps_by_address[i]) == RC_CHK_ACCESS(map))
+			return i;
 	}
 	pr_err("Map missing from maps");
 	return -1;
@@ -432,19 +433,22 @@ static unsigned int maps__by_address_index(const struct maps *maps, const struct
 static unsigned int maps__by_name_index(const struct maps *maps, const struct map *map)
 {
 	struct map **maps_by_name = maps__maps_by_name(maps);
+	unsigned int nr_maps = maps__nr_maps(maps);
+
+	if (!maps_by_name)
+		return -1;
 
-	if (maps__maps_by_name_sorted(maps)) {
+	if (nr_maps && maps__maps_by_name_sorted(maps)) {
 		struct map **mapp =
-			bsearch(&map, maps_by_name, maps__nr_maps(maps),
+			bsearch(&map, maps_by_name, nr_maps,
 				sizeof(*mapp), map__strcmp);
 
 		if (mapp)
 			return mapp - maps_by_name;
-	} else {
-		for (unsigned int i = 0; i < maps__nr_maps(maps); i++) {
-			if (RC_CHK_ACCESS(maps_by_name[i]) == RC_CHK_ACCESS(map))
-				return i;
-		}
+	}
+	for (unsigned int i = 0; i < nr_maps; i++) {
+		if (RC_CHK_ACCESS(maps_by_name[i]) == RC_CHK_ACCESS(map))
+			return i;
 	}
 	pr_err("Map missing from maps");
 	return -1;
@@ -519,6 +523,7 @@ static int __maps__insert(struct maps *maps, struct map *new)
 		/* Sorted if maps were already sorted and this map starts after the last one. */
 		maps__set_maps_by_address_sorted(maps,
 			maps__maps_by_address_sorted(maps) &&
+			map__start(maps_by_address[nr_maps - 2]) < map__start(new) &&
 			map__end(maps_by_address[nr_maps - 2]) <= map__start(new));
 		maps__set_maps_by_name_sorted(maps, false);
 	}
@@ -539,32 +544,44 @@ int maps__insert(struct maps *maps, struct map *map)
 	return ret;
 }
 
-static void __maps__remove(struct maps *maps, struct map *map)
+static void __maps__remove_at(struct maps *maps, unsigned int address_idx)
 {
 	struct map **maps_by_address = maps__maps_by_address(maps);
 	struct map **maps_by_name = maps__maps_by_name(maps);
 	unsigned int nr_maps = maps__nr_maps(maps);
-	unsigned int address_idx;
+	struct map *map;
 
-	/* Slide later mappings over the one to remove */
-	address_idx = maps__by_address_index(maps, map);
-	map__put(maps_by_address[address_idx]);
-	memmove(&maps_by_address[address_idx],
-		&maps_by_address[address_idx + 1],
-		(nr_maps - address_idx - 1) * sizeof(*maps_by_address));
+	if (address_idx >= nr_maps)
+		return;
 
+	/* Slide later mappings over the one to remove */
+	map = maps_by_address[address_idx];
 	if (maps_by_name) {
 		unsigned int name_idx = maps__by_name_index(maps, map);
 
-		map__put(maps_by_name[name_idx]);
-		memmove(&maps_by_name[name_idx],
-			&maps_by_name[name_idx + 1],
-			(nr_maps - name_idx - 1) *  sizeof(*maps_by_name));
+		if (name_idx < nr_maps) {
+			map__put(maps_by_name[name_idx]);
+			memmove(&maps_by_name[name_idx],
+				&maps_by_name[name_idx + 1],
+				(nr_maps - name_idx - 1) * sizeof(*maps_by_name));
+		} else {
+			__maps__free_maps_by_name(maps);
+		}
 	}
 
+	map__put(map);
+	memmove(&maps_by_address[address_idx],
+		&maps_by_address[address_idx + 1],
+		(nr_maps - address_idx - 1) * sizeof(*maps_by_address));
+
 	--RC_CHK_ACCESS(maps)->nr_maps;
 }
 
+static void __maps__remove(struct maps *maps, struct map *map)
+{
+	__maps__remove_at(maps, maps__by_address_index(maps, map));
+}
+
 void maps__remove(struct maps *maps, struct map *map)
 {
 	down_write(maps__lock(maps));
@@ -713,7 +730,7 @@ void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data
 	maps_by_address = maps__maps_by_address(maps);
 	for (unsigned int i = 0; i < maps__nr_maps(maps);) {
 		if (cb(maps_by_address[i], data)) {
-			__maps__remove(maps, maps_by_address[i]);
+			__maps__remove_at(maps, i);
 			removed = true;
 		} else {
 			i++;
@@ -1319,7 +1336,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 
 struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 {
-	unsigned int i;
+	unsigned int i, nr_maps;
 	struct map *result = NULL;
 
 	down_read(maps__lock(maps));
@@ -1329,7 +1346,8 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 		down_read(maps__lock(maps));
 	}
 	i = maps__by_address_index(maps, map);
-	if (++i < maps__nr_maps(maps))
+	nr_maps = maps__nr_maps(maps);
+	if (i < nr_maps && ++i < nr_maps)
 		result = map__get(maps__maps_by_address(maps)[i]);
 
 	up_read(maps__lock(maps));
@@ -1340,6 +1358,7 @@ void maps__fixup_end(struct maps *maps)
 {
 	struct map **maps_by_address;
 	unsigned int n;
+	bool revalidate_sort = false;
 
 	down_write(maps__lock(maps));
 	if (!maps__maps_by_address_sorted(maps))
@@ -1351,16 +1370,27 @@ void maps__fixup_end(struct maps *maps)
 		struct map *prev = maps_by_address[i - 1];
 		struct map *curr = maps_by_address[i];
 
-		if (!map__end(prev) || map__end(prev) > map__start(curr))
+		if (!map__end(prev) || map__end(prev) > map__start(curr)) {
 			map__set_end(prev, map__start(curr));
+			if (map__start(prev) == map__start(curr))
+				revalidate_sort = true;
+			maps__set_maps_by_name_sorted(maps, false);
+		}
 	}
 
 	/*
 	 * We still haven't the actual symbols, so guess the
 	 * last map final address.
 	 */
-	if (n > 0 && !map__end(maps_by_address[n - 1]))
+	if (n > 0 && !map__end(maps_by_address[n - 1])) {
 		map__set_end(maps_by_address[n - 1], ~0ULL);
+		maps__set_maps_by_name_sorted(maps, false);
+	}
+
+	if (revalidate_sort) {
+		maps__set_maps_by_address_sorted(maps, false);
+		__maps__sort_by_address(maps);
+	}
 
 	RC_CHK_ACCESS(maps)->ends_broken = false;
 	check_invariants(maps);
-- 
2.56.0.455.g6c5a503b38-goog

