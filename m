Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA123E7BB2;
	Sun, 18 Oct 2026 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341477; cv=none; b=BLYWxs7ojrszYr4QWRlCr7rJIZd8y5vvJl6WP3B1/d2jHYDAHUDDMVmNkYGstDEGARsw4JX5a68tu8WVD2hHCKhP5A+OekXIBMYWcPTJxfcrbxC6YRmCBl5EOz3ip3RNbIgNQ8UeKmM0bJowGtiVXJFTRTHo2b+Ob4u+goP3frk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341477; c=relaxed/simple;
	bh=OL7XdJljnYykZ6cGJygqKILHqIpHMQsHB66PjADmr6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AG01bNZocV/K81i/S3tCRzTMoQT9ap7fZh4NHNHTcAwfNd3iCUS6C797x7gtaDTYO+yHB5XuZYaTTIKQ1p9AvXcgg2H/cPY84KAR6eBFnwDvm5ksYc+f08HPfZ1e2bdsD7HIHxVg/BVNjTvVDwehakawlCl9b/6QTRTQ6TydTEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj1YOlZA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj1YOlZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C45D1F000C4;
	Sun, 18 Oct 2026 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792341464;
	bh=nqhII2yqgaJn4OHee6C9EiqMArA3HDYaoMptyZzOhkg=;
	h=From:To:Cc:Subject:Date;
	b=Fj1YOlZAbMm5BLHyyNev/1uZF2pldGWKlyEJNTEJbEc5PiSOwK8aFVMXfJTOe/UCO
	 eC+xJK8BGaIAuFhq4V6ldLIoLP+waa3Mcaelcjxqg6G/LGtZBlcEWegbR5la5IWwFu
	 7/Xu6jP/EpKlUYNwkZ+RJBEV4DN4BSYeO+nS6VF9un/7F38wXG53z9dCdR3ehAogo+
	 pqL0fjuLHg0B9t2qmFv0s6BPGjfkzyoa8iBZ/10Nj3zwaOzDWA5YxklhMhmMd+H1W3
	 i0BCisO3TGP6jExwSQJFelnSnr8YAyawYY/ygBQAvi32dt5bcv1qMHW8Pz6GmmOSW1
	 s1fwEeSzuTffg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v1 1/5] perf test: Fix a memory leak in PE file parsing test
Date: Sun, 18 Oct 2026 09:37:37 -0700
Message-ID: <20261018163741.850434-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
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
2.56.0.176.g3575e65682-goog

