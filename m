Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8D47FB03;
	Mon, 19 Oct 2026 05:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389215; cv=none; b=cxkKrgJWDvldbnVzoHXcMldrvu/iTO6Ytna/2Ox6Y/91SkU9KfoLr8jhG/KqK/qxfECxGVgJvsle3kTKLZskMLHMGuVUYgvJ5WkauBEFdS6AhpRLWvqymzifF+1FHHZBTLnuzKMnz+w64VHQASPoyvXJ/KP3BjzIesoUJAkD2tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389215; c=relaxed/simple;
	bh=LMG43NqcQfJ148dhWlyjibA5KAuInktHbpK8fPMBNtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNgopf6lYUax9lTAaMj3Xm/sYqLXbtMmn+cq38txy766FD5TSHcvXa8oAB12GerEZTHP2mlfb1FGx5fDV+BHNy8H/rM2nJzdFtj2dZR1sExUlzu1gOghGGSx9czlCWWZJNq09ASnDsxWFsXrW2XE8hHBR1FfAyZ6UeJV5sBF/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVRabffd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVRabffd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905EB1F000CA;
	Mon, 19 Oct 2026 05:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792389135;
	bh=y5Wy01xpK8hobA0iInohLJNNLk/FC76Ixr2R8ArYJUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QVRabffdAbW1iF3OiTm7AYdCU7ErbCVa4hQCPiibRM0uTmsUtVppTcL/wzAKTHv1n
	 lkBzquvUMzcT3k4/xq4NWne1vZh8e0c+z0pwxLmsg0Dv5scbn4cRBSW43kNIxidM/y
	 j5qCT00xYxGZUKEpv9DW5wKB/PzI1ycadSlQdK7I9AyQ9P6rf/QBrr0gPATriA//8p
	 xVhjXTZyVsuLl4IjwvT1PCBTsqcxzJfCJiyr+oVqutqz8GMA4CxYOsMvmmBxyhO5nC
	 sQT54DuceW/dFAWiBwrAKpKVzDxbPJdFfM58rCy6CB+KWL6tx2IFqwSXDQ1cRR5xkn
	 ThFUou+3+NO9g==
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
Subject: [PATCH v2 1/5] perf test: Fix a memory leak in PE file parsing test
Date: Sun, 18 Oct 2026 22:52:03 -0700
Message-ID: <20261019055207.39325-2-namhyung@kernel.org>
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

The get_argv_exec_path() returns a dynamically allocated string so it
should be freed.  Let's check the return value first so that it
doesn't crash snprintf().

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-168781@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/pe-file-parsing.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index 190520ffc3ad6d0c..ed95aa5d8ca2af92 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -74,19 +74,26 @@ static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
 {
 	struct stat st;
 	char path_dir[PATH_MAX];
-	const char * const tests_dirs[] = {
+	static const char * const tests_dirs[] = {
 		"./tools/perf/tests",
 		"./tests",
 		"./source/tests",
-		path_dir,
 	};
-	snprintf(path_dir, PATH_MAX, "%s/tests", get_argv_exec_path());
+	char *exec_path;
 
 	for (size_t i = 0; i < ARRAY_SIZE(tests_dirs); ++i) {
 		if (!lstat(tests_dirs[i], &st))
 			return run_dir(tests_dirs[i]);
 	}
 
+	exec_path = get_argv_exec_path();
+	TEST_ASSERT_VAL("Failed to allocate exec_path", exec_path);
+	snprintf(path_dir, PATH_MAX, "%s/tests", exec_path);
+	free(exec_path);
+
+	if (!lstat(path_dir, &st))
+		return run_dir(path_dir);
+
 	pr_debug("cannot find the tests directory\n");
 	return TEST_SKIP;
 }
-- 
2.56.0

