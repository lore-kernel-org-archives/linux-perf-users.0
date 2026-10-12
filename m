Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D70B340401;
	Mon, 12 Oct 2026 05:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783024; cv=none; b=M0HgxrpXvHH7zhMAGDHQhs2/cs6zvjtktIDGTkjj2ideBhXN7oa6cxrynMz0uHGH9Y6acrY6Nyl9VGTpDS6G6CgHtcz8xYlFJ2YAIZejyewA5uG556QCE+4CIj2jdeoCr6h29aNRSZxuYTTBu7v0PN7DcbO6L547gn4tn4i3qBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783024; c=relaxed/simple;
	bh=bchYMViCPgLf8/emFLtQafP62OpM7xagw/riDhisCQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lNnaVOVdoyyE+qdKj8Ex4/v82umDVkVQlwf4fQQB+1OBvkzUbPUo3Ehm0prdJhjT/XWiSdzGL6xNuhAIe1HvjfqeMbhjzSZkwXLRkvNG2CHqyrVIp0dm+MFlz0G2dQZ226TlP12UEpHnWMqYutUtq8Ny6XXqp9MBLo7tm4Etku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ox6T7ROB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ox6T7ROB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AA71F0089B;
	Mon, 12 Oct 2026 05:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783022;
	bh=o5BFS7PcluVFV6qS5mHOo/LEAAxmSHpXmbxmccFfv8Y=;
	h=From:To:Cc:Subject:Date;
	b=Ox6T7ROBSwfzoCo6VU8zg3gCq4IuhbSazKfTSZUPbvKtCuBB+Enj/zuFRvX10DMUg
	 49yCufpkRzgybPsYSdMr2j1XcI9qN8dcc2ECGrk8Rsp/t/Z+/o1JjNxQsQ35BL/hvz
	 geBSeVxbHgxP39EaahTucYi1ZAxCMP2G+Kv0WnKD997unjbXZmZU7NNkuPiAGC3Lwp
	 lXkBTwVTg0RvMlSLpCsL+ohc3XG1ogT9B20d4SBmhqLTNesXMNrrXfKw006NYYhXFN
	 5wqU2+I/YNUS+RbNc3kseXYBkL75AR7zYL266S2tL5tkPus9OPhSOEqvJi1u4a93UB
	 JZAIMrqUn+uUg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 1/4] perf symbol: Fix symbol loading from libbfd
Date: Sun, 11 Oct 2026 22:30:10 -0700
Message-ID: <20261012053013.14378-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dso__load() should return a positive number (number of symbols
loaded) when it succeded to load symbols.  But dso__load_bfd_symbols()
only returns 0 and it's hard to check if it actually loaded symbols or
not.  Let's return the value of dso__has_symbol() and check it in
dso__load() so that it can return 1 for success.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org
Fixes: eac9a4342e5447cad ("perf symbols: Try reading the symbol table with libbfd")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/pe-file-parsing.c | 2 +-
 tools/perf/util/libbfd.c           | 2 +-
 tools/perf/util/symbol.c           | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index 30c7da79e109b480..3979f38bf127c218 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -59,7 +59,7 @@ static int run_dir(const char *d)
 	TEST_ASSERT_VAL("Failed to get dso", dso);
 
 	ret = dso__load_bfd_symbols(dso, debugfile);
-	TEST_ASSERT_VAL("Failed to load symbols", ret == 0);
+	TEST_ASSERT_VAL("Failed to load symbols", ret > 0);
 
 	dso__sort_by_name(dso);
 	sym = dso__find_symbol_by_name(dso, "main", &idx);
diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index a907d7c1ac948808..a4dcb406c79e9cee 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -463,7 +463,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 	symbols__fixup_duplicate(dso__symbols(dso));
 	dso__set_adjust_symbols(dso, true);
 
-	err = 0;
+	err = dso__has_symbols(dso);
 out_free:
 	free(symbols);
 out_close:
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 5d98888d068c741a..a394e742f9b18812 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1930,8 +1930,8 @@ int dso__load(struct dso *dso, struct map *map)
 		if (nsexit)
 			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 
-		if (bfdrc == 0) {
-			ret = 0;
+		if (bfdrc > 0) {
+			ret = 1;
 			break;
 		}
 
-- 
2.55.0

