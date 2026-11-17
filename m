Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941385;
	b=h70eT+2n41SlWolZmPxg7sv3EJUaLdhljtvKIauLrDBzPb7sBXFvXFm89CjKHIeb6xas
	 /Ko5xC5A0Mez8n2Ucj0lrlF6ILQaNRlkCG1YGzHE253mYni7TM6sHrBNYaKIx5e6x+oVe
	 V8Ha5kVMYkgi2enQ1jexKKj3Ae4+hw5JE5KbAOy9pof5kx3qWz2EhVWXL8T9uSl653GWk
	 35Kof11Wd2nRlWisXiWGHxPThAJsDP4tBVumBVcTfNcT1aACiLyVxQlQ4kPso7UIYkZK6
	 LCji7ppkLWNt0D41QgWzWCwX/vckTr34BjqNsxy+lzeg9Hz9n42ZkNJFscOvcI73WMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=rlx16+2vJxWrEnrVA3YlDXzNQuEu4MjXPzh4OqUc66A=;
	b=YG5tNEuxF0OBjTzyZd2iNrkdy8ZRULf3HXTQnUAkeBxEr9ASqZfrfGAM2DhZvsgNvWJr
	 ov8DGXk7c3dakj6HcXl2HQsi1XyXAVCm58Hk4WVXe2Ox30OF4dNWeUosxpegi7dqhQgWj
	 h+6cDwVxzXbDg0nGzfCX64sb3lcV6R1Nl9uaECJ6vk86x6dhKvZeIY1SQX1iNL/lapeYM
	 /w7oi3xcNOJJs+qFSoV4asUP92Yxm7UNvLZO7L+E8mPwhqoBoRlXxIqwtF7wy50/ZMlWa
	 R3WwOJa/3rfnIDC8aALorYlPJkFATC7B7mrEjKNeXk6ibCDP9ERgfdq++RyIBSofEPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V25Wcab1;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8EB606A8AB
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD8EB606A8AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V25Wcab1
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1a5005fd0f8so224682c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 10:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941384; x=1795546184; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rlx16+2vJxWrEnrVA3YlDXzNQuEu4MjXPzh4OqUc66A=;
        b=V25Wcab1ArxmLeNdyvzfx5aPFGjwOT4kEtWvfM3nVTZOv2kNNOPONNmIX24TkmZnvg
         NYDdrF0ViVKBNw3EpcEDosm5hh2wVVZg20qot3POQXaoBItiWxp4QFPxyafzjsxtJMWK
         LSE7G+YmV8pCivZd6xmbJPcVWBT7Qf1WFB9/78YkfWLEPWp8dX/lmBg1NOxZfDB3OrPL
         +Y85yRKtrmnEDDZ+yF9brtY72n5hjooSGJRi0qque3HNItrv/qQVT/JJQxBoyWnu1taE
         kxS9VXVTu08RSl7/Cd39pysd/rOvH+Igx6nbzwAkULuw2cHKkepQQZLEzhuC2L+JyS9H
         67bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941384; x=1795546184;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rlx16+2vJxWrEnrVA3YlDXzNQuEu4MjXPzh4OqUc66A=;
        b=kuAAnJzJioXZ1CxWlCW74GLY4lPJ+Hv1r8Nv+rpJhkYJuOk4UOxOurMjgeaZ8OhfPG
         q44wWSSJYntntTSvX/eRWIS5Wbv3hI9Pfj8OOpexbx1YilAua1PuJYj4C//v4wWEF6qT
         b9+HO9gUXWfA3FB9QOjTU72ALWYnDKxRAVNstXUJYRLrmZjHipL7GYVXULt6BynMtJLF
         kVV6UjOItyjruQLBC9MjAvuRDR620dyH5Xn4oN2mYsKeWBWc2bv/kkqfJDp1uwSbhfc3
         p9Pp+849ARgGlWclUG4TQUuFcfJ7gVLrmgghVya8qJtyR0WV2CR4mqphvou46Zie2UWr
         FD9A==
X-Forwarded-Encrypted: i=1; AL+hErFTYUa/7VZ/kx19jM1c8sjIbT9fnXNMfI6mTmMQGkxjtu3Q+ej76BDZAV0d+S+YhvvkrpF0fObdikbzEO/B+yYk@vger.kernel.org
X-Gm-Message-State: APuU4Z+/ZuhQNDiSe40r9OtRw43HYnQmhyrbLUE+r/o0wmIC96e6qVBp
	9w55bKfs8jpOPgw7z/1F+UkpePMhHfxAlHXOaFPLLxpppnM+rU79EmBAyDt3GwlJ2itASNFoam0
	v6LvZn348MA==
X-Received: from dltt18.prod.google.com ([2002:a05:701a:c972:b0:1a0:8cef:34d5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea44:b0:1b2:3e9b:3dcd
 with SMTP id a92af1059eb24-1b543be9924mr401131c88.10.1794941383354; Tue, 17
 Nov 2026 10:49:43 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:41 -0800
In-Reply-To: <20261117184844.99889-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117184844.99889-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117184844.99889-21-irogers@google.com>
Subject: [PATCH v14 20/23] perf maps: Fix map index lookup fallback and removal
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
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
 tools/perf/util/maps.c    |  91 ++++++++++++++++---------
 3 files changed, 207 insertions(+), 45 deletions(-)

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
index 02711995f0b6..0cc593d5372a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1580,19 +1580,6 @@ static int machine__create_modules(struct machine *machine)
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
@@ -1604,6 +1591,10 @@ static int kernel_mmap_mutate_cb(struct map *map, void *data)
 
 	map__set_start(map, ctx->start);
 	map__set_end(map, ctx->end);
+	/*
+	 * Be a bit paranoid here, some perf.data file came with
+	 * a zero sized synthesized MMAP event for the kernel.
+	 */
 	if (ctx->start == 0 && ctx->end == 0)
 		map__set_end(map, ~0ULL);
 	return 0;
@@ -1668,8 +1659,10 @@ int machine__create_kernel_maps(struct machine *machine)
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
index 7e863f0f4a4f..d922a6df9515 100644
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
@@ -540,32 +544,44 @@ int maps__insert(struct maps *maps, struct map *map)
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
@@ -714,7 +730,7 @@ void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data
 	maps_by_address = maps__maps_by_address(maps);
 	for (unsigned int i = 0; i < maps__nr_maps(maps);) {
 		if (cb(maps_by_address[i], data)) {
-			__maps__remove(maps, maps_by_address[i]);
+			__maps__remove_at(maps, i);
 			removed = true;
 		} else {
 			i++;
@@ -1320,7 +1336,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 
 struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 {
-	unsigned int i;
+	unsigned int i, nr_maps;
 	struct map *result = NULL;
 
 	down_read(maps__lock(maps));
@@ -1330,7 +1346,8 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 		down_read(maps__lock(maps));
 	}
 	i = maps__by_address_index(maps, map);
-	if (++i < maps__nr_maps(maps))
+	nr_maps = maps__nr_maps(maps);
+	if (i < nr_maps && ++i < nr_maps)
 		result = map__get(maps__maps_by_address(maps)[i]);
 
 	up_read(maps__lock(maps));
@@ -1341,6 +1358,7 @@ void maps__fixup_end(struct maps *maps)
 {
 	struct map **maps_by_address;
 	unsigned int n;
+	bool revalidate_sort = false;
 
 	down_write(maps__lock(maps));
 	if (!maps__maps_by_address_sorted(maps))
@@ -1352,16 +1370,27 @@ void maps__fixup_end(struct maps *maps)
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
2.56.1.703.gf848ed807c-goog

