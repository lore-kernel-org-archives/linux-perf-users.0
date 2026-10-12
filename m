Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC5A3AFAEB;
	Mon, 12 Oct 2026 05:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783026; cv=none; b=MH8c1axJvAeAzEpyWIzMtWKdi3wfppSvYQgE06ZBhiDaPvYNYnFR5AsACDsavvvTKeQT3ML1Mb9dgHlNk0ANDVQBgVt6Ll87OFz+/PEbXO7Dcb/5AT9tHYwpt491ll+L+BBx1cxR6E05d2ShzB+RL0QZ37qIpJY0NCmFOmcP/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783026; c=relaxed/simple;
	bh=zb5AVh8eEBk+wRRW9sboxE4bAPt7x7gDN8J/tObzzr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oic118iraZBIN6h3Fl5JJMb6iM4G2hSftYRSFSOPsYzYVfWt7FbpdRxuWGS98JJphDfqy/72wkGLOwbX/9T1dGoNSX9Yg80u+Ljom2e2YklcW/UoJO16/yMDsA7Q2NAVB32h3LCizd0TSQ70598JG3UzPqlUGOXgRpbJIhnTauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqsemtW/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqsemtW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA5D1F0089E;
	Mon, 12 Oct 2026 05:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783024;
	bh=QAYisXDQy5jBiYCrbJyiSkAKeAW9yq/B3zR2JwCx6fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oqsemtW/7EEZSPQ7eoHXuNepwhUO690aJu8bsWX0zeLkAgqX9v4ylv6XivcLrE7ic
	 k7TYwIpx734K3YUjJpWysRT7G9OsoomocUKprt1pDpa+tmgUMdUaapv3LC65EpJzz5
	 3DJ3uJtrJfz11iGrOEKCJQY82ibdQOqx0XjrvR4/c4Vcd+Tqa0cdiAKq38QXrPSLO9
	 HhpoWSLDOmem6wggyhgeOQS/zlwsBPc6xj+L5IFIOmIa+a70ZKhd6FKe47OutDCNJ+
	 4iRLeyZL6aBrtdWskVidb/2st2jsvuegkL39OfEijYI8jRigB2XVbSMNMRlO02/pkp
	 +NeKSapD2xusA==
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
Subject: [PATCH v2 4/4] perf test: Update PE file test for other locations
Date: Sun, 11 Oct 2026 22:30:13 -0700
Message-ID: <20261012053013.14378-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012053013.14378-1-namhyung@kernel.org>
References: <20261012053013.14378-1-namhyung@kernel.org>
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
 tools/perf/tests/pe-file-parsing.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index 3979f38bf127c218..78dae7e43603b9f8 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -74,10 +74,17 @@ static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
 {
 	struct stat st;
 	char path_dir[PATH_MAX];
+	static const char * const tests_dirs[] = {
+		"./tools/perf/tests",
+		"./tests",
+		"./source/tests"
+	};
 
 	/* First try development tree tests. */
-	if (!lstat("./tests", &st))
-		return run_dir("./tests");
+	for (size_t i = 0; i < ARRAY_SIZE(tests_dirs); ++i) {
+		if (!lstat(tests_dirs[i], &st))
+			return run_dir(tests_dirs[i]);
+	}
 
 	/* Then installed path. */
 	snprintf(path_dir, PATH_MAX, "%s/tests", get_argv_exec_path());
@@ -85,6 +92,7 @@ static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
 	if (!lstat(path_dir, &st))
 		return run_dir(path_dir);
 
+	pr_debug("cannot find the tests directory\n");
 	return TEST_SKIP;
 }
 
@@ -93,6 +101,7 @@ static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
 static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
 			  int subtest __maybe_unused)
 {
+	pr_debug("libbfd is not available\n");
 	return TEST_SKIP;
 }
 
-- 
2.55.0

