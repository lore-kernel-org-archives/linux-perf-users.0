Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326E83DB33C;
	Mon, 12 Oct 2026 23:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849582; cv=none; b=SV4pOzVd/Lj3CDmk4WDVAmXwsZk6klRHBYI4XG1hiIItY4VqaN0yRrWhgA+uIiYH5VpD6Pig8T6/1tCJEBcVa3DHZPsGrxQHBZq4qWD2dtjAJO/PXoC62YlpUwPtOIGjB085wOtEN9DaboIl9lLC7uSBQtiISLYRBzUYNJsiD4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849582; c=relaxed/simple;
	bh=CffoGsk5VsPDvFh2FGbCbXr41DuAVHIn4S3HzQ4/Wjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUzixA6tsaLf9XVB5Vl+5tn2iWcwNii/RCTdMq0Wr+PN55VoyHdsT8PRCLDmtoe7v2KjH6dp0wv8oApeQQlr5HlZrNhzHvzAf1VERFpAlHB1YIVbmkhTBFQgPzQCvXDKR0ZvHx9zn1B8gx6iAzCqtM9XpGyXBMTF8HliJxgT8d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V15b+4fN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V15b+4fN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1DC1F008A2;
	Mon, 12 Oct 2026 23:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849580;
	bh=Tb1o/kZPADfHTw75sNwHhAeZgSWapOsqdi8t/ovF/Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V15b+4fN88++ep9H6dBkLbyv0IoOfqnlzXVy36EkBEv+yDa5TVX7/f2zeV73UkDjp
	 ViJMAf6omhCbR0jiXqtIeDywegnIn6k530Ga2cv1egKLQ+K2CI+eAsRCuKGONzCcA7
	 AB8ENWLnPWKtjjvhP4A2a+Ipny9u3TZ+OFfSwC5HjtSvtNgi8PifsfZp6Fy7RAgfhT
	 scgkgZFtCK1dzdBSodnsbw7E7j4erX3Or6Npf7TKdx3bXWKVpRekqjS+OFFssIuXNa
	 eucccv60mdW7SUa6u3pnWN9j1y1wuKTxj8VRLDgF9DQF69QpCAp5bXZ0JRHb3ielaH
	 VwPEl02un5iZA==
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
Subject: [PATCH v3 4/4] perf test: Update PE file test for other locations
Date: Mon, 12 Oct 2026 16:59:37 -0700
Message-ID: <20261012235938.87912-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012235938.87912-1-namhyung@kernel.org>
References: <20261012235938.87912-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test__pe_file_parsing() expects the test is in the tools/perf
directory, but it could be root or a separate build directory.  Let's
update the logic to try other paths like in the shell_tests__dir_fd().

Also add some debug messages to inform users why it's skipped.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/pe-file-parsing.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index 3979f38bf127c218..190520ffc3ad6d0c 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -74,17 +74,20 @@ static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
 {
 	struct stat st;
 	char path_dir[PATH_MAX];
-
-	/* First try development tree tests. */
-	if (!lstat("./tests", &st))
-		return run_dir("./tests");
-
-	/* Then installed path. */
+	const char * const tests_dirs[] = {
+		"./tools/perf/tests",
+		"./tests",
+		"./source/tests",
+		path_dir,
+	};
 	snprintf(path_dir, PATH_MAX, "%s/tests", get_argv_exec_path());
 
-	if (!lstat(path_dir, &st))
-		return run_dir(path_dir);
+	for (size_t i = 0; i < ARRAY_SIZE(tests_dirs); ++i) {
+		if (!lstat(tests_dirs[i], &st))
+			return run_dir(tests_dirs[i]);
+	}
 
+	pr_debug("cannot find the tests directory\n");
 	return TEST_SKIP;
 }
 
@@ -93,6 +96,7 @@ static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
 static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
 			  int subtest __maybe_unused)
 {
+	pr_debug("libbfd is not available\n");
 	return TEST_SKIP;
 }
 
-- 
2.56.0.385.gd3acb90ef8-goog

