Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606574;
	b=JCj5e8DxUzNFgbhxAjAKvr00kez1CQfBh3fWbPbEPP0CNNlxVziSWTIHrlIQB9GyzAU1
	 g/4QtO1IEMgnoIrY3NHS4EKAZ0VLVmx4xpHYbL67w0cX2tkT4gqVLaui5FOj/6R1/6OGO
	 uTaCmxbt2wLF4CGizPLONw6J7JJbKO0/UoAlU7GBmuPbauDoh7dhNOsMaYXG6LX0JSl0K
	 zktfuRSchfzCLAgB9LteipSh7Lq4hQRsz6WsOVhKMca5j5/dluRo8HXGJqQsVTXj0Cuh1
	 cJ3s6dxW6Q7xC/qnNtaPsHBKgTdrKRVU/XnrgLn4mNQtKX+zusdJh/MSnvN+RXLKhew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RzjDfFMZReiuwcSB4uYV8dPIh1JIEi/9PGrxuqlVz3g=;
	b=qm3isd/YymnvHrN/pp/eIMnQjLqRHElZXjRTF61KuNPnQlbrx/zCvGpp6at7AQgTds7X
	 ykxJ4BKEFIPTZNbf5+KHr/jUxe22FKvl/shpQCIIvDXFPgV970sM3V1EqrcVh5FMORJIK
	 U860PgFS/sOltzf2Gj6EbfuStBb/tij0+M3Tq8w+T9j2wzf4R02EvL3KBsQUdspT6qauK
	 QfY/udAzvMfp3KsEYZ5QyASqDSpZ2Xh8FPjBI0AiAXRS/5CppYY0PDrGzPKu+WqBkQ2h+
	 BELD9Tzw2WAMHAA82YLoyJ573RWVuSsfFWWHaiA0vM/gT31u5Fy9KkhTpJEmpvDIGmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Ki7/sVkB";
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DF8606A8A1
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3DF8606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ki7/sVkB
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36de26cb4b3so1769009eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606573; x=1795211373; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RzjDfFMZReiuwcSB4uYV8dPIh1JIEi/9PGrxuqlVz3g=;
        b=Ki7/sVkBavPKUI5q2IMRSDgoJ0xfOzy0nuVZZsO6hu1UFllDbsR90mRAThLZeoQslc
         gpXHAdTfEBEpl3E9F/fzxChHSLdrpvPeMUW3l/tR4BejESYxZGfc3b7hi7AEjHDA3LLD
         BCWzYI9roKUq2GfMY2g8qqfXr1IKMbWmV/w3qyzmq9UOK1cqwyZD3Ao7aCfZ8K8kem6G
         nTBlcBSJU/r5VrZ6VaG0j50fJd++pXcN5xuz+RTEbrNDfRwJTZmj0SWNI5qZgEIGmPqM
         rfv0gxMLSRDTqSInkd1x1zQ3tPhwZfoE9tXIXm1lNqMA+5Shw9xReai5L46PiRwOMAr3
         Xc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606573; x=1795211373;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RzjDfFMZReiuwcSB4uYV8dPIh1JIEi/9PGrxuqlVz3g=;
        b=cWR//0fZgtXPapor1nekvgFk+UVFjd7GPl9nMEw/kaXWSmUgC0IF3rN370wBuCxcOJ
         YZ4KFbzl5ZsLZ16DlrHoF1SF6wFkqE+JEhLBw+R4ziQ1XAkpBYW4SMjkZoPRwaXiBlJk
         kIJnPiMBgl3x9iGNoVprdGIfXBGgPt/RLPYEyFVKvy8T4E0Nu274ZFQmPAu4H4EwsDle
         hRkaNMz1nf3OSPWQOhPwgSlN6Vi7VJXGhwoVSCgp8AqOZ4YCum2R2FGNAwPw0AUI6tvg
         ytctb5UeuXnosY9PQaIXjVSg+n4kUJsUubBqZcxlIJfiTp+ZAf7/t+ZGRgk1sCWZSYci
         2ptw==
X-Forwarded-Encrypted: i=1; AL+hErFaF07Tb0HkMNQKRPyWNwKTWGfKZ9F3yaUlJLWhU5rv0qLdebL6LmJP+NA/cVrI4beCtXMvgZ2falTx47gqCtte@vger.kernel.org
X-Gm-Message-State: APuU4Z8KfBOXLqYiILoB2zlrc/Hd75KnWuYXJTUPM4sTGZEZC15D+DeG
	smzYyZhB96ZhmqTBDfxZfot6f/Rp0bl38HMn2oQi9NRaqUr5HtBTz6/rb8FXzVatnV51hl8mQrb
	CNR1tBKV+2w==
X-Received: from dyr22.prod.google.com ([2002:a05:693c:4016:b0:359:72f9:2aab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cc82:b0:36c:9b35:5d46
 with SMTP id 5a478bee46e88-379681c811dmr3590058eec.26.1794606572714; Fri, 13
 Nov 2026 13:49:32 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:32 -0800
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
Message-ID: <20261113214850.3329699-9-irogers@google.com>
Subject: [PATCH v1 08/26] perf hashmap: Introduce generic types and macros
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add DECLARE_HASHMAP(name, key_type, value_type) and type-checked
hashmap__* wrapper macros around struct __hashmap while keeping legacy
struct hashmap compatible so callers can be migrated one hashmap at a
time:

- Encode key_type and value_type via phantom pointer members in a union
  with struct __hashmap so wrapper structs preserve identical size and
  alignment across 32-bit and 64-bit targets, with _Static_assert checks
  that key_type and value_type fit in a long.
- Generate typed <name>__new() and NULL-safe <name>__free() helpers,
  plus pointer-taking hashmap__init(), hashmap__clear(), hashmap__free(),
  hashmap__size(), hashmap__capacity(), hashmap__insert(),
  hashmap__add(), hashmap__set(), hashmap__update(), hashmap__append(),
  hashmap__find(), and hashmap__delete() macros.
- Marshal output parameters (value_ptr, old_key, old_value) through
  long-sized temporaries and assign via the declared types so sub-long
  types (such as bool, int, or pid_t) are safe from stack buffer
  overflows, endianness bugs, and strict-aliasing violations, while
  allowing NULL output pointers and const-qualified lookup keys.
- Implement hashmap__for_each{,_safe}() and
  hashmap__for_each_key{,_safe}() using single-loop __hashmap_iter and
  __hashmap_key_iter helpers so 'break' exits the entire iteration,
  bucket cursors are internal, and element deletion during iteration is
  safe.
- Add a 'Generic hashmap' perf test suite exercising integer, string,
  and sub-long bool/int32 maps, NULL frees, const lookups, early loop
  breaks, and in-loop deletions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/hashmap.c      | 192 +++++++++
 tools/perf/tests/tests.h        |   1 +
 tools/perf/util/hashmap.c       |  30 +-
 tools/perf/util/hashmap.h       | 675 ++++++++++++++++++++++++++------
 6 files changed, 773 insertions(+), 127 deletions(-)
 create mode 100644 tools/perf/tests/hashmap.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 5eebb2ec5dde..2c2560613323 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -74,6 +74,7 @@ perf-test-y += hwmon_pmu.o
 perf-test-y += tool_pmu.o
 perf-test-y += subcmd-help.o
 perf-test-y += kallsyms-split.o
+perf-test-y += hashmap.o
 
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc riscv))
 perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 327483f96401..24e7f8443e94 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -192,6 +192,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__util,
 	&suite__subcmd_help,
 	&suite__kallsyms_split,
+	&suite__hashmap,
 	NULL,
 };
 
diff --git a/tools/perf/tests/hashmap.c b/tools/perf/tests/hashmap.c
new file mode 100644
index 000000000000..5a4f39eb8c17
--- /dev/null
+++ b/tools/perf/tests/hashmap.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "util/hashmap.h"
+#include "tests.h"
+#include <errno.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+
+DECLARE_HASHMAP(int_map, long, long);
+DECLARE_HASHMAP(bool_map, char *, bool);
+DECLARE_HASHMAP(int32_map, int, const char *);
+
+static size_t int_hash(long key, void *ctx __maybe_unused)
+{
+	return (size_t)key;
+}
+
+static bool int_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
+
+static size_t str_hash_fn(long key, void *ctx __maybe_unused)
+{
+	return str_hash((const char *)key);
+}
+
+static bool str_equal_fn(long key1, long key2, void *ctx __maybe_unused)
+{
+	return strcmp((const char *)key1, (const char *)key2) == 0;
+}
+
+static int test_int_map(void)
+{
+	struct int_map imap;
+	long val = -1, old_k = -1, old_v = -1;
+	long k, v, sum = 0;
+
+	hashmap__init(&imap, int_hash, int_equal, NULL);
+	TEST_ASSERT_EQUAL("initial size", (int)hashmap__size(&imap), 0);
+
+	TEST_ASSERT_EQUAL("add 1", hashmap__add(&imap, 1L, 10L), 0);
+	TEST_ASSERT_EQUAL("add 2", hashmap__add(&imap, 2L, 20L), 0);
+	TEST_ASSERT_EQUAL("add dup", hashmap__add(&imap, 1L, 99L), -EEXIST);
+	TEST_ASSERT_EQUAL("size after add", (int)hashmap__size(&imap), 2);
+	TEST_ASSERT_VAL("capacity > 0", hashmap__capacity(&imap) >= 2);
+
+	TEST_ASSERT_VAL("find 1", hashmap__find(&imap, 1L, &val));
+	TEST_ASSERT_EQUAL("find 1 val", (int)val, 10);
+	TEST_ASSERT_VAL("find 2 NULL out", hashmap__find(&imap, 2L, NULL));
+	TEST_ASSERT_VAL("find 3 missing", !hashmap__find(&imap, 3L, &val));
+
+	/* Update missing vs existing */
+	TEST_ASSERT_EQUAL("update missing",
+			  hashmap__update(&imap, 3L, 30L, &old_k, &old_v), -ENOENT);
+	TEST_ASSERT_EQUAL("update existing",
+			  hashmap__update(&imap, 1L, 11L, &old_k, &old_v), 0);
+	TEST_ASSERT_EQUAL("update old_k", (int)old_k, 1);
+	TEST_ASSERT_EQUAL("update old_v", (int)old_v, 10);
+
+	/* Set new vs existing */
+	TEST_ASSERT_EQUAL("set new",
+			  hashmap__set(&imap, 3L, 30L, &old_k, &old_v), 0);
+	TEST_ASSERT_EQUAL("set new old_k", (int)old_k, 0);
+	TEST_ASSERT_EQUAL("set new old_v", (int)old_v, 0);
+
+	/* Multimap append + for_each_key */
+	TEST_ASSERT_EQUAL("append 2", hashmap__append(&imap, 2L, 200L), 0);
+	sum = 0;
+	hashmap__for_each_key(&imap, 2L, v)
+		sum += v;
+	TEST_ASSERT_EQUAL("for_each_key sum", (int)sum, 220);
+
+	/* Delete one of the key=2 entries; verify missing delete zeroes outputs */
+	TEST_ASSERT_VAL("delete 2", hashmap__delete(&imap, 2L, &old_k, &old_v));
+	TEST_ASSERT_EQUAL("delete old_k", (int)old_k, 2);
+	TEST_ASSERT_VAL("delete missing", !hashmap__delete(&imap, 999L, &old_k, &old_v));
+	TEST_ASSERT_EQUAL("delete missing old_k zeroed", (int)old_k, 0);
+	TEST_ASSERT_EQUAL("delete missing old_v zeroed", (int)old_v, 0);
+
+	sum = 0;
+	hashmap__for_each(&imap, k, v)
+		sum += v;
+	TEST_ASSERT_EQUAL("for_each sum", (int)sum, 11 + 20 + 30);
+
+	hashmap__clear(&imap);
+	TEST_ASSERT_EQUAL("cleared size", (int)hashmap__size(&imap), 0);
+	return 0;
+}
+
+static int test_bool_and_str_map(void)
+{
+	struct bool_map *bmap;
+	char *k1, *k2, *k2_dup, *old_key = NULL;
+	char *iter_key;
+	const char *const_lookup = "alpha";
+	/* Guard bytes around bool to catch any >1-byte write overflow. */
+	struct {
+		unsigned char pre[8];
+		bool val;
+		unsigned char post[8];
+	} guard;
+	bool old_val = true;
+
+	/* Freeing NULL must be a safe no-op (including under UBSAN). */
+	bool_map__free(NULL);
+
+	bmap = bool_map__new(str_hash_fn, str_equal_fn, NULL);
+	TEST_ASSERT_VAL("bool_map__new", bmap != NULL);
+
+	k1 = strdup("alpha");
+	k2 = strdup("beta");
+	k2_dup = strdup("beta");
+	TEST_ASSERT_VAL("strdup", k1 && k2 && k2_dup);
+
+	TEST_ASSERT_EQUAL("add alpha", hashmap__add(bmap, k1, true), 0);
+	TEST_ASSERT_EQUAL("add beta", hashmap__add(bmap, k2, false), 0);
+
+	memset(&guard, 0x5a, sizeof(guard));
+	TEST_ASSERT_VAL("find const key", hashmap__find(bmap, const_lookup, &guard.val));
+	TEST_ASSERT_VAL("alpha is true", guard.val == true);
+	for (size_t i = 0; i < sizeof(guard.pre); i++) {
+		TEST_ASSERT_EQUAL("pre guard intact", guard.pre[i], 0x5a);
+		TEST_ASSERT_EQUAL("post guard intact", guard.post[i], 0x5a);
+	}
+
+	TEST_ASSERT_VAL("find beta", hashmap__find(bmap, "beta", &guard.val));
+	TEST_ASSERT_VAL("beta is false", guard.val == false);
+
+	TEST_ASSERT_EQUAL("set beta",
+			  hashmap__set(bmap, k2_dup, true, &old_key, &old_val), 0);
+	TEST_ASSERT_VAL("old_key == k2", old_key == k2);
+	TEST_ASSERT_VAL("old_val == false", old_val == false);
+	free(old_key);
+
+	hashmap__for_each(bmap, iter_key, old_val)
+		free(iter_key);
+	bool_map__free(bmap);
+	return 0;
+}
+
+static int test_iter_break_and_safe_delete(void)
+{
+	struct int32_map map;
+	const struct int32_map *cmap = &map;
+	int k, count = 0;
+	const char *v;
+
+	hashmap__init(&map, int_hash, int_equal, NULL);
+
+	/* Insert enough entries (including negative keys) to span multiple buckets. */
+	for (int i = -10; i < 20; i++)
+		TEST_ASSERT_EQUAL("add int32", hashmap__add(&map, i, "entry"), 0);
+
+	TEST_ASSERT_VAL("find negative key on const map",
+			hashmap__find(cmap, -7, &v) && strcmp(v, "entry") == 0);
+
+	/* Verify 'break' exits the entire hashmap__for_each loop, not just one bucket. */
+	hashmap__for_each(cmap, k, v) {
+		count++;
+		if (count == 3)
+			break;
+	}
+	TEST_ASSERT_EQUAL("break stops outer iteration", count, 3);
+
+	/* Verify safe deletion during iteration. */
+	hashmap__for_each_safe(&map, k, v) {
+		if (k < 0)
+			TEST_ASSERT_VAL("delete negative", hashmap__delete(&map, k, NULL, NULL));
+	}
+	TEST_ASSERT_EQUAL("remaining non-negative", (int)hashmap__size(&map), 20);
+
+	hashmap__clear(&map);
+	return 0;
+}
+
+static int test__hashmap(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
+{
+	int err;
+
+	err = test_int_map();
+	if (err)
+		return err;
+
+	err = test_bool_and_str_map();
+	if (err)
+		return err;
+
+	return test_iter_break_and_safe_delete();
+}
+
+DEFINE_SUITE("Generic hashmap", hashmap);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index af822885890d..e9cbc0dcd778 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -203,6 +203,7 @@ DECLARE_SUITE(util);
 DECLARE_SUITE(uncore_event_sorting);
 DECLARE_SUITE(subcmd_help);
 DECLARE_SUITE(kallsyms_split);
+DECLARE_SUITE(hashmap);
 
 /*
  * PowerPC and S390 do not support creation of instruction breakpoints using the
diff --git a/tools/perf/util/hashmap.c b/tools/perf/util/hashmap.c
index f2d8beeac27a..f6bfaeaee9d7 100644
--- a/tools/perf/util/hashmap.c
+++ b/tools/perf/util/hashmap.c
@@ -35,7 +35,7 @@ static void __hashmap__del_entry(struct hashmap_entry **pprev,
 	entry->next = NULL;
 }
 
-void __hashmap__init(struct hashmap *map, hashmap_hash_fn hash_fn,
+void __hashmap__init(struct __hashmap *map, hashmap_hash_fn hash_fn,
 		     hashmap_equal_fn equal_fn, void *ctx)
 {
 	map->hash_fn = hash_fn;
@@ -48,11 +48,11 @@ void __hashmap__init(struct hashmap *map, hashmap_hash_fn hash_fn,
 	map->sz = 0;
 }
 
-struct hashmap *__hashmap__new(hashmap_hash_fn hash_fn,
-			       hashmap_equal_fn equal_fn,
-			       void *ctx)
+struct __hashmap *__hashmap__new(hashmap_hash_fn hash_fn,
+				 hashmap_equal_fn equal_fn,
+				 void *ctx)
 {
-	struct hashmap *map = malloc(sizeof(struct hashmap));
+	struct __hashmap *map = malloc(sizeof(*map));
 
 	if (!map) {
 		errno = ENOMEM;
@@ -62,7 +62,7 @@ struct hashmap *__hashmap__new(hashmap_hash_fn hash_fn,
 	return map;
 }
 
-void __hashmap__clear(struct hashmap *map)
+void __hashmap__clear(struct __hashmap *map)
 {
 	struct hashmap_entry *cur, *tmp;
 	size_t bkt;
@@ -75,7 +75,7 @@ void __hashmap__clear(struct hashmap *map)
 	map->cap = map->cap_bits = map->sz = 0;
 }
 
-void __hashmap__free(struct hashmap *map)
+void __hashmap__free(struct __hashmap *map)
 {
 	if (!map)
 		return;
@@ -84,23 +84,23 @@ void __hashmap__free(struct hashmap *map)
 	free(map);
 }
 
-size_t __hashmap__size(const struct hashmap *map)
+size_t __hashmap__size(const struct __hashmap *map)
 {
 	return map->sz;
 }
 
-size_t __hashmap__capacity(const struct hashmap *map)
+size_t __hashmap__capacity(const struct __hashmap *map)
 {
 	return map->cap;
 }
 
-static bool __hashmap__needs_to_grow(struct hashmap *map)
+static bool __hashmap__needs_to_grow(struct __hashmap *map)
 {
 	/* grow if empty or more than 75% filled */
 	return (map->cap == 0) || ((map->sz + 1) * 4 / 3 > map->cap);
 }
 
-static int __hashmap__grow(struct hashmap *map)
+static int __hashmap__grow(struct __hashmap *map)
 {
 	struct hashmap_entry **new_buckets;
 	struct hashmap_entry *cur, *tmp;
@@ -129,7 +129,7 @@ static int __hashmap__grow(struct hashmap *map)
 	return 0;
 }
 
-static bool __hashmap__find_entry(const struct hashmap *map,
+static bool __hashmap__find_entry(const struct __hashmap *map,
 				  const long key, size_t hash,
 				  struct hashmap_entry ***pprev,
 				  struct hashmap_entry **entry)
@@ -153,7 +153,7 @@ static bool __hashmap__find_entry(const struct hashmap *map,
 	return false;
 }
 
-int __hashmap__insert(struct hashmap *map, long key, long value,
+int __hashmap__insert(struct __hashmap *map, long key, long value,
 		      enum hashmap_insert_strategy strategy,
 		      void *old_key, void *old_value)
 {
@@ -205,7 +205,7 @@ int __hashmap__insert(struct hashmap *map, long key, long value,
 	return 0;
 }
 
-bool __hashmap__find(const struct hashmap *map, long key, void *value)
+bool __hashmap__find(const struct __hashmap *map, long key, void *value)
 {
 	struct hashmap_entry *entry;
 	size_t h;
@@ -219,7 +219,7 @@ bool __hashmap__find(const struct hashmap *map, long key, void *value)
 	return true;
 }
 
-bool __hashmap__delete(struct hashmap *map, long key,
+bool __hashmap__delete(struct __hashmap *map, long key,
 		       void *old_key, void *old_value)
 {
 	struct hashmap_entry **pprev, *entry;
diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
index 4dcc2cf3ef1a..bb85a65486be 100644
--- a/tools/perf/util/hashmap.h
+++ b/tools/perf/util/hashmap.h
@@ -8,10 +8,20 @@
 #ifndef __PERF_UTIL_HASHMAP_H
 #define __PERF_UTIL_HASHMAP_H
 
+#include <errno.h>
 #include <stdbool.h>
 #include <stddef.h>
+#include <stdlib.h>
 #include <limits.h>
+#include <linux/compiler.h>
 
+/**
+ * hash_bits() - Shuffle hash value and return requested number of upper bits.
+ * @h: Raw hash value.
+ * @bits: Number of bits to return (0 returns 0).
+ *
+ * Return: Multiplicative hash truncated to @bits bits.
+ */
 static inline size_t hash_bits(size_t h, int bits)
 {
 	/* shuffle bits and return requested number of upper bits */
@@ -28,7 +38,12 @@ static inline size_t hash_bits(size_t h, int bits)
 #endif
 }
 
-/* generic C-string hashing function */
+/**
+ * str_hash() - Generic C-string hashing function.
+ * @s: NUL-terminated string to hash.
+ *
+ * Return: Unshuffled hash value suitable for hash_bits().
+ */
 static inline size_t str_hash(const char *s)
 {
 	size_t h = 0;
@@ -40,22 +55,42 @@ static inline size_t str_hash(const char *s)
 	return h;
 }
 
+/**
+ * typedef hashmap_hash_fn - Hash callback computing a key's hash value.
+ * @key: Key value cast to long.
+ * @ctx: Optional user context pointer passed at hashmap initialization.
+ *
+ * Return: Hash value for @key (shuffled internally via hash_bits()).
+ */
 typedef size_t (*hashmap_hash_fn)(long key, void *ctx);
+
+/**
+ * typedef hashmap_equal_fn - Equality callback comparing two keys.
+ * @key1: First key value cast to long.
+ * @key2: Second key value cast to long.
+ * @ctx: Optional user context pointer passed at hashmap initialization.
+ *
+ * Return: true if @key1 and @key2 are equal, false otherwise.
+ */
 typedef bool (*hashmap_equal_fn)(long key1, long key2, void *ctx);
 
 /*
- * Hashmap interface is polymorphic, keys and values could be either
- * long-sized integers or pointers, this is achieved as follows:
- * - interface functions that operate on keys and values are hidden
- *   behind auxiliary macros, e.g. hashmap_insert <-> hashmap__insert;
- * - these auxiliary macros cast the key and value parameters as
- *   long or long *, so the user does not have to specify the casts explicitly;
- * - for pointer parameters (e.g. old_key) the size of the pointed
- *   type is verified by hashmap_cast_ptr using _Static_assert;
- * - when iterating using hashmap__for_each_* forms
- *   hasmap_entry->key should be used for integer keys and
- *   hasmap_entry->pkey should be used for pointer keys,
- *   same goes for values.
+ * Typed hashmap interface:
+ *
+ * Hashmaps are declared with DECLARE_HASHMAP(name, key_type, value_type),
+ * where key_type and value_type may be any integer, enum, bool, or pointer
+ * type with sizeof <= sizeof(long):
+ * - DECLARE_HASHMAP() defines 'struct <name>' along with '<name>__new()' and
+ *   '<name>__free()' allocation helpers;
+ * - phantom pointer members (__key, __value) in a union with the backing
+ *   struct __hashmap encode the declared key and value types at zero
+ *   runtime space cost and without altering struct size or alignment;
+ * - hashmap__* macros type-check keys, values, output pointers, and iteration
+ *   cursor variables against the declared types at compile time;
+ * - output parameters (value_ptr, old_key, old_value) are marshaled through
+ *   long temporaries and assigned via the declared types so sub-long types
+ *   (e.g. bool, int, pid_t) are safe from buffer overflows, endianness bugs,
+ *   and strict-aliasing violations.
  */
 struct hashmap_entry {
 	union {
@@ -69,7 +104,7 @@ struct hashmap_entry {
 	struct hashmap_entry *next;
 };
 
-struct hashmap {
+struct __hashmap {
 	hashmap_hash_fn hash_fn;
 	hashmap_equal_fn equal_fn;
 	void *ctx;
@@ -80,148 +115,564 @@ struct hashmap {
 	size_t sz;
 };
 
-void __hashmap__init(struct hashmap *map, hashmap_hash_fn hash_fn,
-		     hashmap_equal_fn equal_fn, void *ctx);
-struct hashmap *__hashmap__new(hashmap_hash_fn hash_fn,
-			       hashmap_equal_fn equal_fn,
-			       void *ctx);
-void __hashmap__clear(struct hashmap *map);
-void __hashmap__free(struct hashmap *map);
+/* Legacy untyped hashmap, kept while migrating callers to DECLARE_HASHMAP. */
+struct hashmap {
+	union {
+		struct __hashmap map;
+		struct {
+			hashmap_hash_fn hash_fn;
+			hashmap_equal_fn equal_fn;
+			void *ctx;
+
+			struct hashmap_entry **buckets;
+			size_t cap;
+			size_t cap_bits;
+			size_t sz;
+		};
+		long *__key;
+		long *__value;
+		char __untyped;
+	};
+};
 
-size_t __hashmap__size(const struct hashmap *map);
-size_t __hashmap__capacity(const struct hashmap *map);
+void __hashmap__init(struct __hashmap *map, hashmap_hash_fn hash_fn,
+		     hashmap_equal_fn equal_fn, void *ctx);
+struct __hashmap *__hashmap__new(hashmap_hash_fn hash_fn,
+				 hashmap_equal_fn equal_fn,
+				 void *ctx);
+void __hashmap__clear(struct __hashmap *map);
+void __hashmap__free(struct __hashmap *map);
 
-static inline void hashmap__init(struct hashmap *map, hashmap_hash_fn hash_fn,
-				 hashmap_equal_fn equal_fn, void *ctx)
-{
-	__hashmap__init(map, hash_fn, equal_fn, ctx);
-}
+size_t __hashmap__size(const struct __hashmap *map);
+size_t __hashmap__capacity(const struct __hashmap *map);
 
 static inline struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
 					   hashmap_equal_fn equal_fn,
 					   void *ctx)
 {
-	return __hashmap__new(hash_fn, equal_fn, ctx);
+	struct hashmap *map = malloc(sizeof(*map));
+
+	if (!map) {
+		errno = ENOMEM;
+		return NULL;
+	}
+	__hashmap__init(&map->map, hash_fn, equal_fn, ctx);
+	return map;
 }
 
-static inline void hashmap__clear(struct hashmap *map)
+/**
+ * enum hashmap_insert_strategy - Strategy for hashmap__insert().
+ * @HASHMAP_ADD: Only add key/value if key doesn't exist yet; returns -EEXIST
+ *               and optionally fills old_key/old_value if already present.
+ * @HASHMAP_SET: Add key/value pair if key doesn't exist yet; otherwise update
+ *               key/value and optionally return previous key/value.
+ * @HASHMAP_UPDATE: Update key/value if key already exists; otherwise do
+ *                  nothing and return -ENOENT.
+ * @HASHMAP_APPEND: Always add key/value pair, even if key already exists.
+ *                  Turns the hashmap into a multimap allowing multiple values
+ *                  associated with the same key. Read via
+ *                  hashmap__for_each_key(); hashmap__find() returns the most
+ *                  recently inserted entry for the key.
+ */
+enum hashmap_insert_strategy {
+	HASHMAP_ADD,
+	HASHMAP_SET,
+	HASHMAP_UPDATE,
+	HASHMAP_APPEND,
+};
+
+int __hashmap__insert(struct __hashmap *map, long key, long value,
+		      enum hashmap_insert_strategy strategy,
+		      void *old_key, void *old_value);
+bool __hashmap__delete(struct __hashmap *map, long key,
+		       void *old_key, void *old_value);
+bool __hashmap__find(const struct __hashmap *map, long key, void *value);
+
+/*
+ * Single-loop iterators used by hashmap__for_each* so 'break' exits the entire
+ * iteration and element deletion during iteration is safe.
+ */
+struct __hashmap_iter {
+	const struct __hashmap *map;
+	size_t bkt;
+	struct hashmap_entry *cur;
+	struct hashmap_entry *next;
+};
+
+static inline struct __hashmap_iter
+__hashmap_iter__init(const struct __hashmap *map)
 {
-	__hashmap__clear(map);
+	return (struct __hashmap_iter){
+		.map = map,
+		.bkt = 0,
+		.cur = NULL,
+		.next = (map && map->buckets && map->cap > 0) ? map->buckets[0] : NULL,
+	};
 }
 
-static inline void hashmap__free(struct hashmap *map)
+static inline struct hashmap_entry *
+__hashmap_iter__advance(struct __hashmap_iter *it)
 {
-	__hashmap__free(map);
+	if (!it->map || !it->map->buckets)
+		return NULL;
+
+	while (!it->next) {
+		it->bkt++;
+		if (it->bkt >= it->map->cap) {
+			it->cur = NULL;
+			return NULL;
+		}
+		it->next = it->map->buckets[it->bkt];
+	}
+	it->cur = it->next;
+	it->next = it->cur->next;
+	return it->cur;
 }
 
-static inline size_t hashmap__size(const struct hashmap *map)
+struct __hashmap_key_iter {
+	const struct __hashmap *map;
+	long key;
+	struct hashmap_entry *cur;
+	struct hashmap_entry *next;
+};
+
+static inline struct __hashmap_key_iter
+__hashmap_key_iter__init(const struct __hashmap *map, long key)
 {
-	return __hashmap__size(map);
+	struct hashmap_entry *first = NULL;
+
+	if (map && map->buckets) {
+		size_t h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
+
+		first = map->buckets[h];
+	}
+	return (struct __hashmap_key_iter){
+		.map = map,
+		.key = key,
+		.cur = NULL,
+		.next = first,
+	};
 }
 
-static inline size_t hashmap__capacity(const struct hashmap *map)
+static inline struct hashmap_entry *
+__hashmap_key_iter__advance(struct __hashmap_key_iter *it)
 {
-	return __hashmap__capacity(map);
+	while (it->next) {
+		struct hashmap_entry *entry = it->next;
+
+		it->next = entry->next;
+		if (it->map->equal_fn(entry->key, it->key, it->map->ctx)) {
+			it->cur = entry;
+			return entry;
+		}
+	}
+	it->cur = NULL;
+	return NULL;
 }
 
-/*
- * Hashmap insertion strategy:
- * - HASHMAP_ADD - only add key/value if key doesn't exist yet;
- * - HASHMAP_SET - add key/value pair if key doesn't exist yet; otherwise,
- *   update value;
- * - HASHMAP_UPDATE - update value, if key already exists; otherwise, do
- *   nothing and return -ENOENT;
- * - HASHMAP_APPEND - always add key/value pair, even if key already exists.
- *   This turns hashmap into a multimap by allowing multiple values to be
- *   associated with the same key. Most useful read API for such hashmap is
- *   hashmap__for_each_key_entry() iteration. If hashmap__find() is still
- *   used, it will return last inserted key/value entry (first in a bucket
- *   chain).
+/**
+ * DECLARE_HASHMAP() - Declare a type-safe hashmap struct and alloc helpers.
+ * @name: Struct tag to define (creates 'struct @name', '@name__new()', and
+ *        '@name__free()').
+ * @key_type: Type of keys stored in the map (sizeof(@key_type) <= sizeof(long)).
+ * @value_type: Type of values stored in the map
+ *              (sizeof(@value_type) <= sizeof(long)).
+ *
+ * '@name__new(hash_fn, equal_fn, ctx)' allocates and initializes a new
+ * 'struct @name *', returning NULL with errno = ENOMEM on allocation failure.
+ * '@name__free(hmap)' clears all bucket storage and frees @hmap (NULL-safe;
+ * does not free caller-owned pointees referenced by keys or values).
  */
-enum hashmap_insert_strategy {
-	HASHMAP_ADD,
-	HASHMAP_SET,
-	HASHMAP_UPDATE,
-	HASHMAP_APPEND,
-};
-
-#define hashmap_cast_ptr(p) ({								\
-	_Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) ||			\
-				sizeof(*(p)) == sizeof(long),				\
-		       #p " pointee should be a long-sized integer or a pointer");	\
-	(void *)(p);									\
-})
+#define DECLARE_HASHMAP(name, key_type, value_type)				\
+struct name {									\
+	union {									\
+		struct __hashmap map;					\
+		key_type *__key;						\
+		value_type *__value;						\
+		int __untyped;							\
+	};									\
+	_Static_assert(sizeof(key_type) <= sizeof(long),			\
+		       #name " key_type exceeds sizeof(long)");			\
+	_Static_assert(sizeof(value_type) <= sizeof(long),			\
+		       #name " value_type exceeds sizeof(long)");		\
+};										\
+static inline __maybe_unused struct name *					\
+name##__new(hashmap_hash_fn hash_fn, hashmap_equal_fn equal_fn, void *ctx)	\
+{										\
+	struct name *hmap = malloc(sizeof(*hmap));				\
+										\
+	if (!hmap) {								\
+		errno = ENOMEM;							\
+		return NULL;							\
+	}									\
+	__hashmap__init(&hmap->map, hash_fn, equal_fn, ctx);			\
+	return hmap;								\
+}										\
+static inline __maybe_unused void name##__free(struct name *hmap)		\
+{										\
+	if (!hmap)								\
+		return;								\
+	__hashmap__clear(&hmap->map);					\
+	free(hmap);								\
+}
 
 /*
- * hashmap__insert() adds key/value entry w/ various semantics, depending on
- * provided strategy value. If a given key/value pair replaced already
- * existing key/value pair, both old key and old value will be returned
- * through old_key and old_value to allow calling code do proper memory
- * management.
+ * For pointer key types (T *), allow const-qualified lookup keys (const T *);
+ * for non-pointer key types, preserve the exact declared key_type.
  */
-int __hashmap__insert(struct hashmap *map, long key, long value,
-		      enum hashmap_insert_strategy strategy,
-		      void *old_key, void *old_value);
-
-#define hashmap__insert(map, key, value, strategy, old_key, old_value) \
-	__hashmap__insert((map), (long)(key), (long)(value), (strategy), \
-			  hashmap_cast_ptr(old_key),			\
-			  hashmap_cast_ptr(old_value))
-
-#define hashmap__add(map, key, value) \
-	hashmap__insert((map), (key), (value), HASHMAP_ADD, NULL, NULL)
-
-#define hashmap__set(map, key, value, old_key, old_value) \
-	hashmap__insert((map), (key), (value), HASHMAP_SET, (old_key), (old_value))
+#define ___hashmap__lookup_key_type(hm)						\
+	typeof(__builtin_choose_expr(						\
+		__builtin_classify_type(*(hm)->__key) == 5,			\
+		(const typeof(*__builtin_choose_expr(				\
+			__builtin_classify_type(*(hm)->__key) == 5,		\
+			*(hm)->__key, (char *)NULL)) *)NULL,			\
+		*(hm)->__key))
+
+#define ___hashmap__choose(hm, untyped_expr, typed_expr)				\
+	__builtin_choose_expr(sizeof((hm)->__untyped) == 1,			\
+			      (untyped_expr), (typed_expr))
+
+#define ___hashmap__in_val(hm, expr) \
+	___hashmap__choose(hm, (long)(expr), (expr))
+
+#define ___hashmap__check_untyped_ptr(hm, ptr)					\
+	_Static_assert(sizeof((hm)->__untyped) != 1 ||				\
+		       (__builtin_constant_p((ptr)) ? (ptr) == NULL : 0) ||	\
+		       sizeof(*(ptr)) == sizeof(long),				\
+		       #ptr " pointee should be a long-sized integer or a pointer")
+
+/**
+ * hashmap__init() - Initialize an embedded/stack-allocated typed hashmap.
+ * @hmap: Pointer to a hashmap struct declared with DECLARE_HASHMAP().
+ * @hash_fn: Hash callback function.
+ * @equal_fn: Key equality callback function.
+ * @ctx: Optional user context pointer passed to @hash_fn and @equal_fn.
+ */
+#define hashmap__init(hmap, hash_fn, equal_fn, ctx) \
+	__hashmap__init(&(hmap)->map, (hash_fn), (equal_fn), (ctx))
 
-#define hashmap__update(map, key, value, old_key, old_value) \
-	hashmap__insert((map), (key), (value), HASHMAP_UPDATE, (old_key), (old_value))
+/**
+ * hashmap__clear() - Remove all entries from a typed hashmap and free buckets.
+ * @hmap: Pointer to a typed hashmap.
+ *
+ * Does not free @hmap itself or caller-owned memory referenced by keys/values.
+ */
+#define hashmap__clear(hmap) \
+	__hashmap__clear(&(hmap)->map)
+
+#define ___hashmap__free(hmap, hm)						\
+do {										\
+	typeof(hmap) hm = (hmap);						\
+	if (hm) {								\
+		__hashmap__clear(&(hm)->map);				\
+		free(hm);							\
+	}									\
+} while (0)
+
+/**
+ * hashmap__free() - Clear and free a heap-allocated typed hashmap.
+ * @hmap: Pointer to a typed hashmap allocated with <name>__new() (NULL-safe).
+ *
+ * Does not free caller-owned memory referenced by keys or values.
+ */
+#define hashmap__free(hmap) \
+	___hashmap__free(hmap, __PASTE(__hm_, __COUNTER__))
 
-#define hashmap__append(map, key, value) \
-	hashmap__insert((map), (key), (value), HASHMAP_APPEND, NULL, NULL)
+/**
+ * hashmap__size() - Return the number of entries currently in a hashmap.
+ * @hmap: Pointer to a typed hashmap (may be const).
+ *
+ * Return: Number of stored key/value entries.
+ */
+#define hashmap__size(hmap) \
+	__hashmap__size(&(hmap)->map)
 
-bool __hashmap__delete(struct hashmap *map, long key, void *old_key, void *old_value);
+/**
+ * hashmap__capacity() - Return the bucket count of a hashmap.
+ * @hmap: Pointer to a typed hashmap (may be const).
+ *
+ * Return: Number of allocated hash buckets.
+ */
+#define hashmap__capacity(hmap) \
+	__hashmap__capacity(&(hmap)->map)
+
+#define ___hashmap__insert(hmap, key, value, strategy, old_key, old_value,	\
+			   hm, k, v, okp, ovp, raw_ok, raw_ov, ok, ov, err)	\
+({										\
+	typeof(hmap) hm = (hmap);						\
+	typeof(*(hm)->__key) k = ___hashmap__in_val(hm, key);			\
+	typeof(*(hm)->__value) v = ___hashmap__in_val(hm, value);			\
+	long ok = 0, ov = 0;							\
+	typeof((hm)->__key) okp =						\
+		___hashmap__choose(hm, (long *)NULL, (old_key));			\
+	typeof((hm)->__value) ovp =						\
+		___hashmap__choose(hm, (long *)NULL, (old_value));		\
+	void *raw_ok = ___hashmap__choose(hm, (void *)(old_key),			\
+					(void *)(okp ? &ok : NULL));		\
+	void *raw_ov = ___hashmap__choose(hm, (void *)(old_value),		\
+					(void *)(ovp ? &ov : NULL));		\
+	int err;								\
+	___hashmap__check_untyped_ptr(hm, old_key);				\
+	___hashmap__check_untyped_ptr(hm, old_value);				\
+	err = __hashmap__insert(&(hm)->map, (long)k, (long)v, (strategy),	\
+				raw_ok, raw_ov);			\
+	if (okp)								\
+		*okp = (typeof(*(hm)->__key))ok;				\
+	if (ovp)								\
+		*ovp = (typeof(*(hm)->__value))ov;				\
+	err;									\
+})
 
-#define hashmap__delete(map, key, old_key, old_value) \
-	__hashmap__delete((map), (long)(key), \
-			  hashmap_cast_ptr(old_key),			\
-			  hashmap_cast_ptr(old_value))
+#define _hashmap__insert(hmap, key, value, strategy, old_key, old_value, u)	\
+	___hashmap__insert(hmap, key, value, strategy, old_key, old_value,	\
+			   __PASTE(__hm_, u), __PASTE(__k_, u), __PASTE(__v_, u),	\
+			   __PASTE(__okp_, u), __PASTE(__ovp_, u),	\
+			   __PASTE(__rok_, u), __PASTE(__rov_, u),	\
+			   __PASTE(__ok_, u), __PASTE(__ov_, u), __PASTE(__err_, u))
+
+/**
+ * hashmap__insert() - Insert a key/value entry using the specified strategy.
+ * @hmap: Pointer to a typed hashmap.
+ * @key: Key to insert (must be compatible with declared key_type).
+ * @value: Value to insert (must be compatible with declared value_type).
+ * @strategy: Insertion strategy (enum hashmap_insert_strategy).
+ * @old_key: Optional pointer to key_type receiving previous key on match (or
+ *           zeroed if no existing entry matched); may be NULL.
+ * @old_value: Optional pointer to value_type receiving previous value on match
+ *             (or zeroed if no existing entry matched); may be NULL.
+ *
+ * If a given key/value pair replaced or matched an existing entry, both old
+ * key and old value are returned through @old_key and @old_value so calling
+ * code can perform proper memory management.
+ *
+ * Return: 0 on success, -EEXIST if @strategy is HASHMAP_ADD and @key exists,
+ * -ENOENT if @strategy is HASHMAP_UPDATE and @key is absent, or -ENOMEM on
+ * allocation failure.
+ */
+#define hashmap__insert(hmap, key, value, strategy, old_key, old_value) \
+	_hashmap__insert(hmap, key, value, strategy, old_key, old_value, __COUNTER__)
+
+/**
+ * hashmap__add() - Add a new key/value entry only if the key does not exist.
+ * @hmap: Pointer to a typed hashmap.
+ * @key: Key to insert.
+ * @value: Value to insert.
+ *
+ * Return: 0 on success, -EEXIST if @key already exists, or -ENOMEM.
+ */
+#define hashmap__add(hmap, key, value) \
+	hashmap__insert(hmap, key, value, HASHMAP_ADD, NULL, NULL)
+
+/**
+ * hashmap__set() - Add a key/value entry or replace an existing one.
+ * @hmap: Pointer to a typed hashmap.
+ * @key: Key to insert or replace.
+ * @value: Value to insert or replace.
+ * @old_key: Optional pointer to key_type receiving replaced key (or zeroed if
+ *           newly inserted); may be NULL.
+ * @old_value: Optional pointer to value_type receiving replaced value (or
+ *             zeroed if newly inserted); may be NULL.
+ *
+ * Return: 0 on success, or -ENOMEM on allocation failure.
+ */
+#define hashmap__set(hmap, key, value, old_key, old_value) \
+	hashmap__insert(hmap, key, value, HASHMAP_SET, old_key, old_value)
+
+/**
+ * hashmap__update() - Update value for an existing key only.
+ * @hmap: Pointer to a typed hashmap.
+ * @key: Key to look up and replace.
+ * @value: New value to store.
+ * @old_key: Optional pointer to key_type receiving replaced key; may be NULL.
+ * @old_value: Optional pointer to value_type receiving replaced value; may be
+ *             NULL.
+ *
+ * Return: 0 on success, or -ENOENT if @key does not exist.
+ */
+#define hashmap__update(hmap, key, value, old_key, old_value) \
+	hashmap__insert(hmap, key, value, HASHMAP_UPDATE, old_key, old_value)
+
+/**
+ * hashmap__append() - Unconditionally append a key/value pair (multimap).
+ * @hmap: Pointer to a typed hashmap.
+ * @key: Key to append.
+ * @value: Value to append.
+ *
+ * Return: 0 on success, or -ENOMEM on allocation failure.
+ */
+#define hashmap__append(hmap, key, value) \
+	hashmap__insert(hmap, key, value, HASHMAP_APPEND, NULL, NULL)
+
+#define ___hashmap__find(hmap, key, value_ptr, hm, k, vp, raw_vp, v, found)	\
+({										\
+	typeof(hmap) hm = (hmap);						\
+	___hashmap__lookup_key_type(hm) k = ___hashmap__in_val(hm, key);		\
+	long v = 0;								\
+	typeof((hm)->__value) vp =						\
+		___hashmap__choose(hm, (long *)NULL, (value_ptr));		\
+	void *raw_vp = ___hashmap__choose(hm, (void *)(value_ptr),		\
+					(void *)(vp ? &v : NULL));		\
+	bool found;								\
+	___hashmap__check_untyped_ptr(hm, value_ptr);				\
+	found = __hashmap__find(&(hm)->map, (long)k, raw_vp);			\
+	if (found && vp)							\
+		*vp = (typeof(*(hm)->__value))v;				\
+	found;									\
+})
 
-bool __hashmap__find(const struct hashmap *map, long key, void *value);
+#define _hashmap__find(hmap, key, value_ptr, u)					\
+	___hashmap__find(hmap, key, value_ptr,					\
+			 __PASTE(__hm_, u), __PASTE(__k_, u), __PASTE(__vp_, u),	\
+			 __PASTE(__rvp_, u), __PASTE(__v_, u), __PASTE(__found_, u))
+
+/**
+ * hashmap__find() - Look up a key in a typed hashmap.
+ * @hmap: Pointer to a typed hashmap (may be const).
+ * @key: Key to search for (const-qualified pointer keys are accepted).
+ * @value_ptr: Optional pointer to value_type receiving the found value; may be
+ *             NULL to test membership only. Left unmodified if not found.
+ *
+ * Return: true if @key was found, false otherwise.
+ */
+#define hashmap__find(hmap, key, value_ptr) \
+	_hashmap__find(hmap, key, value_ptr, __COUNTER__)
+
+#define ___hashmap__delete(hmap, key, old_key, old_value,				\
+			   hm, k, okp, ovp, raw_ok, raw_ov, ok, ov, rem)	\
+({										\
+	typeof(hmap) hm = (hmap);						\
+	___hashmap__lookup_key_type(hm) k = ___hashmap__in_val(hm, key);		\
+	long ok = 0, ov = 0;							\
+	typeof((hm)->__key) okp =						\
+		___hashmap__choose(hm, (long *)NULL, (old_key));			\
+	typeof((hm)->__value) ovp =						\
+		___hashmap__choose(hm, (long *)NULL, (old_value));		\
+	void *raw_ok = ___hashmap__choose(hm, (void *)(old_key),			\
+					(void *)(okp ? &ok : NULL));		\
+	void *raw_ov = ___hashmap__choose(hm, (void *)(old_value),		\
+					(void *)(ovp ? &ov : NULL));		\
+	bool rem;								\
+	___hashmap__check_untyped_ptr(hm, old_key);				\
+	___hashmap__check_untyped_ptr(hm, old_value);				\
+	rem = __hashmap__delete(&(hm)->map, (long)k, raw_ok, raw_ov);		\
+	if (okp)								\
+		*okp = (typeof(*(hm)->__key))ok;				\
+	if (ovp)								\
+		*ovp = (typeof(*(hm)->__value))ov;				\
+	rem;									\
+})
 
-#define hashmap__find(map, key, value) \
-	__hashmap__find((map), (long)(key), hashmap_cast_ptr(value))
+#define _hashmap__delete(hmap, key, old_key, old_value, u)			\
+	___hashmap__delete(hmap, key, old_key, old_value,				\
+			   __PASTE(__hm_, u), __PASTE(__k_, u),		\
+			   __PASTE(__okp_, u), __PASTE(__ovp_, u),	\
+			   __PASTE(__rok_, u), __PASTE(__rov_, u),	\
+			   __PASTE(__ok_, u), __PASTE(__ov_, u), __PASTE(__rem_, u))
+
+/**
+ * hashmap__delete() - Remove an entry matching @key from a typed hashmap.
+ * @hmap: Pointer to a typed hashmap.
+ * @key: Key to delete (const-qualified pointer keys are accepted).
+ * @old_key: Optional pointer to key_type receiving removed key (or zeroed if
+ *           not found); may be NULL.
+ * @old_value: Optional pointer to value_type receiving removed value (or
+ *             zeroed if not found); may be NULL.
+ *
+ * Return: true if an entry was removed, false if @key was not found.
+ */
+#define hashmap__delete(hmap, key, old_key, old_value) \
+	_hashmap__delete(hmap, key, old_key, old_value, __COUNTER__)
+
+#define ___hashmap__for_each(hmap, key_var, val_var, it, hm)			\
+	for (struct __hashmap_iter it = ({					\
+		typeof(hmap) hm = (hmap);					\
+		__hashmap_iter__init(hm ? &(hm)->map : NULL);		\
+	     });								\
+	     __hashmap_iter__advance(&it) && ({				\
+		_Static_assert(sizeof(key_var) >= sizeof(*(hmap)->__key),	\
+			       "key_var narrower than key_type");		\
+		_Static_assert(sizeof(val_var) >= sizeof(*(hmap)->__value),	\
+			       "val_var narrower than value_type");		\
+		(key_var) = (typeof(*(hmap)->__key))it.cur->key;		\
+		(val_var) = (typeof(*(hmap)->__value))it.cur->value;		\
+		true;								\
+	     });)
+
+#define _hashmap__for_each(hmap, key_var, val_var, u)				\
+	___hashmap__for_each(hmap, key_var, val_var,				\
+			     __PASTE(__it_, u), __PASTE(__hm_, u))
+
+/**
+ * hashmap__for_each() - Iterate over all entries in a typed hashmap.
+ * @hmap: Pointer to a typed hashmap (may be const or NULL).
+ * @key_var: Loop cursor variable assigned each entry's key.
+ * @val_var: Loop cursor variable assigned each entry's value.
+ *
+ * Safe against deleting the current entry during iteration, and 'break' exits
+ * the entire loop across all buckets.
+ */
+#define hashmap__for_each(hmap, key_var, val_var) \
+	_hashmap__for_each(hmap, key_var, val_var, __COUNTER__)
+
+/**
+ * hashmap__for_each_safe() - Iterate over all entries in a typed hashmap, safe
+ * against removals.
+ * @hmap: Pointer to a typed hashmap (may be const or NULL).
+ * @key_var: Loop cursor variable assigned each entry's key.
+ * @val_var: Loop cursor variable assigned each entry's value.
+ */
+#define hashmap__for_each_safe(hmap, key_var, val_var) \
+	hashmap__for_each(hmap, key_var, val_var)
+
+#define ___hashmap__for_each_key(hmap, key, val_var, kit, hm, k)			\
+	for (struct __hashmap_key_iter kit = ({				\
+		typeof(hmap) hm = (hmap);					\
+		___hashmap__lookup_key_type(hm) k = (key);			\
+		__hashmap_key_iter__init(hm ? &(hm)->map : NULL, (long)k);	\
+	     });								\
+	     __hashmap_key_iter__advance(&kit) && ({				\
+		_Static_assert(sizeof(val_var) >= sizeof(*(hmap)->__value),	\
+			       "val_var narrower than value_type");		\
+		(val_var) = (typeof(*(hmap)->__value))kit.cur->value;		\
+		true;								\
+	     });)
+
+#define _hashmap__for_each_key(hmap, key, val_var, u)				\
+	___hashmap__for_each_key(hmap, key, val_var, __PASTE(__kit_, u),		\
+				 __PASTE(__hm_, u), __PASTE(__k_, u))
+
+/**
+ * hashmap__for_each_key() - Iterate over all values associated with @key.
+ * @hmap: Pointer to a typed hashmap (may be const or NULL).
+ * @key: Key to iterate entries for (const-qualified pointer keys accepted).
+ * @val_var: Loop cursor variable assigned each matching entry's value.
+ */
+#define hashmap__for_each_key(hmap, key, val_var) \
+	_hashmap__for_each_key(hmap, key, val_var, __COUNTER__)
+
+/**
+ * hashmap__for_each_key_safe() - Iterate over all values associated with @key,
+ * safe against removals.
+ * @hmap: Pointer to a typed hashmap (may be const or NULL).
+ * @key: Key to iterate entries for (const-qualified pointer keys accepted).
+ * @val_var: Loop cursor variable assigned each matching entry's value.
+ */
+#define hashmap__for_each_key_safe(hmap, key, val_var) \
+	hashmap__for_each_key(hmap, key, val_var)
 
 /*
- * hashmap__for_each_entry - iterate over all entries in hashmap
- * @map: hashmap to iterate
- * @cur: struct hashmap_entry * used as a loop cursor
- * @bkt: integer used as a bucket loop cursor
+ * Legacy entry iterators for unconverted struct hashmap callers.
  */
 #define hashmap__for_each_entry(map, cur, bkt)				    \
 	for (bkt = 0; bkt < (map)->cap; bkt++)				    \
 		for (cur = (map)->buckets[bkt]; cur; cur = cur->next)
 
-/*
- * hashmap__for_each_entry_safe - iterate over all entries in hashmap, safe
- * against removals
- * @map: hashmap to iterate
- * @cur: struct hashmap_entry * used as a loop cursor
- * @tmp: struct hashmap_entry * used as a temporary next cursor storage
- * @bkt: integer used as a bucket loop cursor
- */
 #define hashmap__for_each_entry_safe(map, cur, tmp, bkt)		    \
 	for (bkt = 0; bkt < (map)->cap; bkt++)				    \
 		for (cur = (map)->buckets[bkt];				    \
 		     cur && ({tmp = cur->next; true; });		    \
 		     cur = tmp)
 
-/*
- * hashmap__for_each_key_entry - iterate over entries associated with given key
- * @map: hashmap to iterate
- * @cur: struct hashmap_entry * used as a loop cursor
- * @key: key to iterate entries for
- */
 #define hashmap__for_each_key_entry(map, cur, _key)			    \
 	for (cur = (map)->buckets					    \
 		     ? (map)->buckets[hash_bits((map)->hash_fn((_key), (map)->ctx), (map)->cap_bits)] \
-- 
2.56.1.703.gf848ed807c-goog

