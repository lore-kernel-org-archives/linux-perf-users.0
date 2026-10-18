Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9046F3E314F;
	Sun, 18 Oct 2026 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341473; cv=none; b=Ls8K0t8o3CmRTExBrqMRYyKwN6I+GaSSKAw2lEXDuMnKNMyWFaSEg/H3cJL7CQgeQCNOHuDsSg3mUwbLksDYDet6clyPyO39jUri58qMdsvZ81S9ziBTpqxEE5lS+jJMuqTxrphlU4GujzGC3qbcSudXqTNWXXUxZOT67Rk/ctA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341473; c=relaxed/simple;
	bh=VLOC7s2vZ126HP+HsozWcND40OG36A9v49hm/ZnfWzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUhjDfwOClIaOIkhQnnYFYJwGgUIiOCuNsCyuAbwoLoCFRqelRgBEmGyh2GxkvVqsMtuc59Ccd4qpegd9X+9/zUoPpJj3cSH5x5lwl2wWKs36MsinOOov/incsvryJOQxvc4i2omzz1ztRQfnCqywM9d/3Gg2kyx17rQaoP0Geg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WisCdaWt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WisCdaWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5B61F000C6;
	Sun, 18 Oct 2026 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792341464;
	bh=egoN54MtzIwfzURS5gbf9sFimCcDID6/noW/ADY3+sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WisCdaWtWC5vDst5Jl3A5QDVWSmQYi9ZfuNlE7JukCJFD/QlLGQWC7vqgCOQ4vgId
	 2/RXE6hJUGl9/bBXZvbME0XTyzCrfsGl9siAc3LGb7hotlbpYCx6o5fEB/JI7oNMNW
	 5qwsedXcVnjyztMBu/i/fEMRZEbAxzah7yC8x2R7tNJobkajmsKVV5MDUW0YW9QXKQ
	 IjLZwuClOfxpg+yLaTd3L8r865FvP4wWQ8LP7cuAu3/R+XMF5dXicPr3vD0MobVAiq
	 afUaeDMZu6A8vfa67gZ1IqP6OOYReQg6qzQA/P+O1QAmObGH9kyIF6Hj5q+l0wtZYV
	 FKtHk6rzcZE1w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v1 2/5] perf test: Make sure maps to have a machine
Date: Sun, 18 Oct 2026 09:37:38 -0700
Message-ID: <20261018163741.850434-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261018163741.850434-1-namhyung@kernel.org>
References: <20261018163741.850434-1-namhyung@kernel.org>
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
 tools/perf/tests/maps.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index 2c05d62f40dcdf72..f40b68f5fa5fe2c1 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <inttypes.h>
+#include <unistd.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include "tests.h"
@@ -100,8 +101,12 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 	};
 	struct map *map_kcore1, *map_kcore2, *map_kcore3;
 	int ret;
-	struct maps *maps = maps__new(NULL);
+	struct machine *machine = machine__new_live(/*host_env=*/NULL,
+						    /*kernel_maps=*/false,
+						    getpid());
+	struct maps *maps = maps__new(machine);
 
+	TEST_ASSERT_VAL("failed to create machine", machine);
 	TEST_ASSERT_VAL("failed to create maps", maps);
 
 	for (i = 0; i < ARRAY_SIZE(bpf_progs); i++) {
@@ -159,6 +164,7 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 	map__zput(map_kcore1);
 	map__zput(map_kcore2);
 	map__zput(map_kcore3);
+	machine__delete(machine);
 	return TEST_OK;
 }
 
@@ -189,8 +195,12 @@ static int test__maps__fixup_overlap_and_insert(struct test_suite *t __maybe_unu
 	struct map *map_split, *map_eclipse;
 	int ret;
 	unsigned int i;
-	struct maps *maps = maps__new(NULL);
+	struct machine *machine = machine__new_live(/*host_env=*/NULL,
+						    /*kernel_maps=*/false,
+						    getpid());
+	struct maps *maps = maps__new(machine);
 
+	TEST_ASSERT_VAL("failed to create machine", machine);
 	TEST_ASSERT_VAL("failed to create maps", maps);
 
 	for (i = 0; i < ARRAY_SIZE(initial_maps); i++) {
@@ -230,6 +240,7 @@ static int test__maps__fixup_overlap_and_insert(struct test_suite *t __maybe_unu
 	TEST_ASSERT_VAL("eclipse check failed", !ret);
 
 	maps__zput(maps);
+	machine__delete(machine);
 	return TEST_OK;
 }
 
-- 
2.56.0.176.g3575e65682-goog

