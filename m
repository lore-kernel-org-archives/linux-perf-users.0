Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815CD2DCC15;
	Wed, 25 Jun 2025 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750883081; cv=none; b=rTVbeoXDqCTSOB+JGnryHO7KLT6NVTaXZAtVL4590vtC5iLcNHuxp6v9eCXR3NjQYPs5XNSykjgooK6Ih/najq8rdCt34+jE9tqxikoH3C6LHoTfIbcQ64Q2oul7qiiMgz1kIeq0WQloTJslj7kt3Pz0ZOAm3eOyVqgpgu9ZLvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750883081; c=relaxed/simple;
	bh=TjaJ7G/cawcsUsuao2hZug7YcOf/c622U4m0y3PXAYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MuNPF2vwoCjUUwDKuXBLDl9YmfSfupEFtxdky01k5Sr8Z/m733QLHN3Kv0DQd2KOMAOfws9BF7haq+miPiDkHrfDVZlIa7DKg4NukLJGo3dXBO/cgH1Uf2Uo/s6+pwFoP5Q5v9AvJqeJEPh6JzDtsbC75g/hX9tmPT5MGCmgjY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErBb6UGj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErBb6UGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25B3C4CEF1;
	Wed, 25 Jun 2025 20:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750883081;
	bh=TjaJ7G/cawcsUsuao2hZug7YcOf/c622U4m0y3PXAYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ErBb6UGjNP0J0vYvgECFcs0qeBU0cfF8oA0CbAqy+FB8OOPL28fJifwDVeics4WJ3
	 MmCDgYBsqFzcS9Tjdlu7pJfvk31bwq5DF3Wn6AIsjHdK+wyMURziKX3S07iwMEXBw6
	 3pnzqvTHb73LPhdo8M1ACyNn+iKCmxd5jaOIEr1Md1Kjdsm7OjblQ399MuRDtrof6J
	 Rhd8hO4tD8vXRSz9NDIjsQAJ+X5kxDfyrJTaQqw1G0MPYO81yXcZbi5UvxAmoLgBVC
	 kGKZqCXhvT53bp44lvze9MZ1dVelrIFpZDQw4NnliToCX6mqDfxtpq7auadA8J/LlZ
	 PqCXSOFVAE8Rg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Yuzhuo Jing <yuzhuo@google.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v3 2/4] perf util: add a basic SHA-1 implementation
Date: Wed, 25 Jun 2025 13:23:09 -0700
Message-ID: <20250625202311.23244-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625202311.23244-1-ebiggers@kernel.org>
References: <20250625202311.23244-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SHA-1 can be written in fewer than 100 lines of code.  Just add a basic
SHA-1 implementation so that there's no need to use an external library
or try to pull in the kernel's SHA-1 implementation.  The kernel's SHA-1
implementation is not really intended to be pulled into userspace
programs in the way that it was proposed to do so for perf
(https://lore.kernel.org/r/20250521225307.743726-3-yuzhuo@google.com/),
and it's also likely to undergo some refactoring in the future.  There's
no need to tie userspace tools to it.

Include a test for sha1() in the util test suite.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 tools/perf/tests/util.c | 45 ++++++++++++++++++-
 tools/perf/util/Build   |  1 +
 tools/perf/util/sha1.c  | 97 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/sha1.h  |  6 +++
 4 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/sha1.c
 create mode 100644 tools/perf/util/sha1.h

diff --git a/tools/perf/tests/util.c b/tools/perf/tests/util.c
index 6366db5cbf8ce..b273d287e1649 100644
--- a/tools/perf/tests/util.c
+++ b/tools/perf/tests/util.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "tests.h"
 #include "util/debug.h"
+#include "util/sha1.h"
 
 #include <linux/compiler.h>
 #include <stdlib.h>
 #include <string2.h>
 
@@ -14,18 +15,60 @@ static int test_strreplace(char needle, const char *haystack,
 
 	free(new);
 	return ret == 0;
 }
 
+#define MAX_LEN 512
+
+/* Test sha1() for all lengths from 0 to MAX_LEN inclusively. */
+static int test_sha1(void)
+{
+	u8 data[MAX_LEN];
+	size_t digests_size = (MAX_LEN + 1) * SHA1_DIGEST_SIZE;
+	u8 *digests;
+	u8 digest_of_digests[SHA1_DIGEST_SIZE];
+	/*
+	 * The correctness of this value was verified by running this test with
+	 * sha1() replaced by OpenSSL's SHA1().
+	 */
+	static const u8 expected_digest_of_digests[SHA1_DIGEST_SIZE] = {
+		0x74, 0xcd, 0x4c, 0xb9, 0xd8, 0xa6, 0xd5, 0x95, 0x22, 0x8b,
+		0x7e, 0xd6, 0x8b, 0x7e, 0x46, 0x95, 0x31, 0x9b, 0xa2, 0x43,
+	};
+	size_t i;
+
+	digests = malloc(digests_size);
+	TEST_ASSERT_VAL("failed to allocate digests", digests != NULL);
+
+	/* Generate MAX_LEN bytes of data. */
+	for (i = 0; i < MAX_LEN; i++)
+		data[i] = i;
+
+	/* Calculate a SHA-1 for each length 0 through MAX_LEN inclusively. */
+	for (i = 0; i <= MAX_LEN; i++)
+		sha1(data, i, &digests[i * SHA1_DIGEST_SIZE]);
+
+	/* Calculate digest of all digests calculated above. */
+	sha1(digests, digests_size, digest_of_digests);
+
+	free(digests);
+
+	/* Check for the expected result. */
+	TEST_ASSERT_VAL("wrong output from sha1()",
+			memcmp(digest_of_digests, expected_digest_of_digests,
+			       SHA1_DIGEST_SIZE) == 0);
+	return 0;
+}
+
 static int test__util(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
 {
 	TEST_ASSERT_VAL("empty string", test_strreplace(' ', "", "123", ""));
 	TEST_ASSERT_VAL("no match", test_strreplace('5', "123", "4", "123"));
 	TEST_ASSERT_VAL("replace 1", test_strreplace('3', "123", "4", "124"));
 	TEST_ASSERT_VAL("replace 2", test_strreplace('a', "abcabc", "ef", "efbcefbc"));
 	TEST_ASSERT_VAL("replace long", test_strreplace('a', "abcabc", "longlong",
 							"longlongbclonglongbc"));
 
-	return 0;
+	return test_sha1();
 }
 
 DEFINE_SUITE("util", util);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 7910d908c814f..70b6c5f045472 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -39,10 +39,11 @@ perf-util-y += rlimit.o
 perf-util-y += argv_split.o
 perf-util-y += rbtree.o
 perf-util-y += libstring.o
 perf-util-y += bitmap.o
 perf-util-y += hweight.o
+perf-util-y += sha1.o
 perf-util-y += smt.o
 perf-util-y += strbuf.o
 perf-util-y += string.o
 perf-util-y += strlist.o
 perf-util-y += strfilter.o
diff --git a/tools/perf/util/sha1.c b/tools/perf/util/sha1.c
new file mode 100644
index 0000000000000..7032fa4ff3fd0
--- /dev/null
+++ b/tools/perf/util/sha1.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SHA-1 message digest algorithm
+ *
+ * Copyright 2025 Google LLC
+ */
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/unaligned.h>
+#include <string.h>
+
+#include "sha1.h"
+
+#define SHA1_BLOCK_SIZE 64
+
+static const u32 sha1_K[4] = { 0x5A827999, 0x6ED9EBA1, 0x8F1BBCDC, 0xCA62C1D6 };
+
+#define SHA1_ROUND(i, a, b, c, d, e)                                          \
+	do {                                                                  \
+		if ((i) >= 16)                                                \
+			w[i] = rol32(w[(i) - 16] ^ w[(i) - 14] ^ w[(i) - 8] ^ \
+					     w[(i) - 3],                      \
+				     1);                                      \
+		e += w[i] + rol32(a, 5) + sha1_K[(i) / 20];                   \
+		if ((i) < 20)                                                 \
+			e += (b & (c ^ d)) ^ d;                               \
+		else if ((i) < 40 || (i) >= 60)                               \
+			e += b ^ c ^ d;                                       \
+		else                                                          \
+			e += (c & d) ^ (b & (c ^ d));                         \
+		b = rol32(b, 30);                                             \
+		/* The new (a, b, c, d, e) is the old (e, a, b, c, d). */     \
+	} while (0)
+
+#define SHA1_5ROUNDS(i)                             \
+	do {                                        \
+		SHA1_ROUND((i) + 0, a, b, c, d, e); \
+		SHA1_ROUND((i) + 1, e, a, b, c, d); \
+		SHA1_ROUND((i) + 2, d, e, a, b, c); \
+		SHA1_ROUND((i) + 3, c, d, e, a, b); \
+		SHA1_ROUND((i) + 4, b, c, d, e, a); \
+	} while (0)
+
+#define SHA1_20ROUNDS(i)                \
+	do {                            \
+		SHA1_5ROUNDS((i) + 0);  \
+		SHA1_5ROUNDS((i) + 5);  \
+		SHA1_5ROUNDS((i) + 10); \
+		SHA1_5ROUNDS((i) + 15); \
+	} while (0)
+
+static void sha1_blocks(u32 h[5], const u8 *data, size_t nblocks)
+{
+	while (nblocks--) {
+		u32 a = h[0];
+		u32 b = h[1];
+		u32 c = h[2];
+		u32 d = h[3];
+		u32 e = h[4];
+		u32 w[80];
+
+		for (int i = 0; i < 16; i++)
+			w[i] = get_unaligned_be32(&data[i * 4]);
+		SHA1_20ROUNDS(0);
+		SHA1_20ROUNDS(20);
+		SHA1_20ROUNDS(40);
+		SHA1_20ROUNDS(60);
+
+		h[0] += a;
+		h[1] += b;
+		h[2] += c;
+		h[3] += d;
+		h[4] += e;
+		data += SHA1_BLOCK_SIZE;
+	}
+}
+
+/* Calculate the SHA-1 message digest of the given data. */
+void sha1(const void *data, size_t len, u8 out[SHA1_DIGEST_SIZE])
+{
+	u32 h[5] = { 0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476,
+		     0xC3D2E1F0 };
+	u8 final_data[2 * SHA1_BLOCK_SIZE] = { 0 };
+	size_t final_len = len % SHA1_BLOCK_SIZE;
+
+	sha1_blocks(h, data, len / SHA1_BLOCK_SIZE);
+
+	memcpy(final_data, data + len - final_len, final_len);
+	final_data[final_len] = 0x80;
+	final_len = round_up(final_len + 9, SHA1_BLOCK_SIZE);
+	put_unaligned_be64((u64)len * 8, &final_data[final_len - 8]);
+
+	sha1_blocks(h, final_data, final_len / SHA1_BLOCK_SIZE);
+
+	for (int i = 0; i < 5; i++)
+		put_unaligned_be32(h[i], &out[i * 4]);
+}
diff --git a/tools/perf/util/sha1.h b/tools/perf/util/sha1.h
new file mode 100644
index 0000000000000..e92c9966e1d50
--- /dev/null
+++ b/tools/perf/util/sha1.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include <linux/types.h>
+
+#define SHA1_DIGEST_SIZE 20
+
+void sha1(const void *data, size_t len, u8 out[SHA1_DIGEST_SIZE]);
-- 
2.50.0

