Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCD03F8712;
	Mon, 19 Oct 2026 05:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389214; cv=none; b=JDGICDNhfwxcYJ5KFeXRNLvWVWUgL9QfC35XsVzxp/FUXdEV77fe2OoXOcySwiAw8dZMdD6JVvSz3q/9zo0AtUMuoYF2FfX3/SL5I3BeteYqJc3PEZuTZmGiFqJ91eMpDPqmQVKvQm58cv8/q1qdcpiGj/bWas8RQZo6pQ80BhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389214; c=relaxed/simple;
	bh=UL4Z/hxV31NMtqFRd4xUUuqEJlb4VaFqF6vQnKsO4bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MB9PjetsgSUBy5uqU9nKukYarcOHaSH+tkfOO3fWgK4z3UVYuiQBWtlWVjwdKevIjV2zCzzpCYq6Gy2XLsWJbfSjR5SA+9O2IWgpOgbZ0NM2Q220HmuUqP1e3+Lwr9P/UqSX2gZk2dGqRiQ4M27NI7k0g41f1HnBhOlnx1Q/hsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkGM/izE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkGM/izE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB6C1F000CB;
	Mon, 19 Oct 2026 05:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792389135;
	bh=YhnBb+3XDTEAdov2rwlEXGMFNh/VYkxTntTKwyZ/RVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MkGM/izEbJ6Fogju4SVgHNEQoiKmahT2uHma8DsoKKN/ZVnzaDOvYwXtKFT23U28k
	 0Xkr3XmqiLDBT52nNMiNod0nIsGuyIqXdn9zcS9z3BV1hkGdHLJn4/n/zdxHmh7tse
	 BtA7qx24rnEE5zap3L3c2DcfwvfKGk4axJuDavHGVEfS9UjaPDUk3AE9E4kkHA+mIw
	 qcFQANfMGePFYNBzWLfwdZqcgZ3o51LtMjuY8LgaTWkA49eOvYAKBreu+uIpgxudEg
	 1i+i7H+k4XqAcH9LmzJpNA5TRrwNvHpO0eVOwcArJzOSx39eD1Y+hsNcQSTythGq1I
	 v7xKq7OQPfi5g==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 2/5] perf test: Make sure maps to have a machine
Date: Sun, 18 Oct 2026 22:52:04 -0700
Message-ID: <20261019055207.39325-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019055207.39325-1-namhyung@kernel.org>
References: <20261019055207.39325-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's be easier if we could guarantee that maps always have a machine.
IIUC this is true for all real use cases, but only the test code has
an exception.  Let's get rid of it and make sure they have machines.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/maps.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index 2c05d62f40dcdf72..ff6d25f9c043034b 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -1,12 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <inttypes.h>
+#include <unistd.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
-#include "tests.h"
+#include "debug.h"
+#include "dso.h"
+#include "env.h"
 #include "map.h"
 #include "maps.h"
-#include "dso.h"
-#include "debug.h"
+#include "tests.h"
 
 struct map_def {
 	const char *name;
@@ -100,8 +102,15 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 	};
 	struct map *map_kcore1, *map_kcore2, *map_kcore3;
 	int ret;
-	struct maps *maps = maps__new(NULL);
+	struct perf_env host_env;
+	struct machine *machine;
+	struct maps *maps;
 
+	perf_env__init(&host_env);
+	machine = machine__new_live(&host_env, /*kernel_maps=*/false, getpid());
+	maps = maps__new(machine);
+
+	TEST_ASSERT_VAL("failed to create machine", machine);
 	TEST_ASSERT_VAL("failed to create maps", maps);
 
 	for (i = 0; i < ARRAY_SIZE(bpf_progs); i++) {
@@ -159,6 +168,8 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 	map__zput(map_kcore1);
 	map__zput(map_kcore2);
 	map__zput(map_kcore3);
+	machine__delete(machine);
+	perf_env__exit(&host_env);
 	return TEST_OK;
 }
 
@@ -189,8 +200,15 @@ static int test__maps__fixup_overlap_and_insert(struct test_suite *t __maybe_unu
 	struct map *map_split, *map_eclipse;
 	int ret;
 	unsigned int i;
-	struct maps *maps = maps__new(NULL);
+	struct perf_env host_env;
+	struct machine *machine;
+	struct maps *maps;
+
+	perf_env__init(&host_env);
+	machine = machine__new_live(&host_env, /*kernel_maps=*/false, getpid());
+	maps = maps__new(machine);
 
+	TEST_ASSERT_VAL("failed to create machine", machine);
 	TEST_ASSERT_VAL("failed to create maps", maps);
 
 	for (i = 0; i < ARRAY_SIZE(initial_maps); i++) {
@@ -230,6 +248,8 @@ static int test__maps__fixup_overlap_and_insert(struct test_suite *t __maybe_unu
 	TEST_ASSERT_VAL("eclipse check failed", !ret);
 
 	maps__zput(maps);
+	machine__delete(machine);
+	perf_env__exit(&host_env);
 	return TEST_OK;
 }
 
-- 
2.56.0

