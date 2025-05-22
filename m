Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C6A18CBFC;
	Thu, 22 May 2025 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747933848; cv=none; b=LauwmqW35f8qOmS3T+MnnQolUerX2ifo6KvCbx45KpZfJuyukZSX3ZVqc3SOdgo67JPl9vy5SAHvlEe/vFGqGH5W8CIe91V8tozkFviU+T8B8pKdeZhxHg12tBu9Hju8n5HlXWRa1VdrtvcjCay/n195ExCthlKPmwoG3vjovtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747933848; c=relaxed/simple;
	bh=2W7nHhHeBHw7mLAKUJLYYi0cLOAa6xE4gIsekZAm1uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FmYngDHD+AmCq21HxmrYHsUr8hUOFR8nJUaLnabRUFKNJcI6pWdkg0q53V4IXiCoqHa3BjtC4ecocJdKXaP/Hiy+6WZxy4HQZkxQsyhQrjYLs4rYs4D3sjcwHhJqB3FO4cIoDsDwUlz6GT4gRCM3B9/Jh9PhA9Q25lgL1ADLZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noGqWGn5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noGqWGn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68377C4CEE4;
	Thu, 22 May 2025 17:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747933847;
	bh=2W7nHhHeBHw7mLAKUJLYYi0cLOAa6xE4gIsekZAm1uY=;
	h=From:To:Cc:Subject:Date:From;
	b=noGqWGn5sP4FP3tT3xHO89s+4EBTJdP4wPGMmyV7PvfUayk0m3fUuJsiIAXZb+Yi0
	 XQzk9PjiAZIYyO8hAtTLf0vNKi6UWknb8+dhr1TewLfQnZ537771slfZxFFcQHzY0g
	 LAQdqSwZALtdTDGZrIqNznjAqbPSdA2sPslCmTFYxUh5n91kRJ5lYQuaytillr0jt0
	 N+Hd68gqewVfUakDV8+FvFhDc1U5GRG/G9ppDaXRGy02q1dyXXpfKsMhmB4320rg+8
	 UZMdBE0kXR21ihZlzytInBQgsKGCmztNTwU94orbGjDY8Y+/m61jdBb8g5Vbo3ak9r
	 1jQXFqRVv5QwA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] perf test: Support arch-specific shell tests
Date: Thu, 22 May 2025 10:10:42 -0700
Message-ID: <20250522171044.1075583-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.1164.gab81da1b16-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparation for shell tests belong to an arch.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/builtin-test.c  |  3 ++
 tools/perf/tests/tests-scripts.c | 73 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests-scripts.h |  1 +
 3 files changed, 77 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 45d3d8b3317a7c0a..b9a86631b34cac90 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -650,6 +650,7 @@ static struct test_suite **build_suites(void)
 		generic_tests,
 		arch_tests,
 		NULL,
+		NULL,
 	};
 	struct test_suite **result;
 	struct test_suite *t;
@@ -657,6 +658,8 @@ static struct test_suite **build_suites(void)
 
 	if (suites[2] == NULL)
 		suites[2] = create_script_test_suites();
+	if (suites[3] == NULL)
+		suites[3] = create_script_test_suites_arch();
 
 #define for_each_suite(suite)						\
 	for (size_t i = 0, j = 0; i < ARRAY_SIZE(suites); i++, j = 0)	\
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index 1d5759d08141749d..e6e6fab0c3c4bb8c 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -24,6 +24,7 @@
 #include "string2.h"
 #include "symbol.h"
 #include "tests.h"
+#include "util/env.h"
 #include "util/rlimit.h"
 #include "util/util.h"
 
@@ -75,6 +76,52 @@ static int shell_tests__dir_fd(void)
 	return open(path, O_PATH);
 }
 
+static int shell_tests__arch_dir_fd(void)
+{
+	struct stat st;
+	const char *arch;
+	char path[PATH_MAX], path2[PATH_MAX], *exec_path;
+	int fd;
+	char *p;
+
+	arch = perf_env__arch(NULL);
+	if (arch == NULL)
+		return -1;
+
+	scnprintf(path, sizeof(path), "./arch/%s/tests/shell", arch);
+	fd = open(path, O_PATH);
+	if (fd >= 0)
+		return fd;
+
+	/* Use directory of executable */
+	if (readlink("/proc/self/exe", path2, sizeof path2) < 0)
+		return -1;
+	/* Follow another level of symlink if there */
+	if (lstat(path2, &st) == 0 && (st.st_mode & S_IFMT) == S_IFLNK) {
+		scnprintf(path, sizeof(path), path2);
+		if (readlink(path, path2, sizeof path2) < 0)
+			return -1;
+	}
+	/* Get directory */
+	p = strrchr(path2, '/');
+	if (p)
+		*p = 0;
+	scnprintf(path, sizeof(path), "%s/arch/%s/tests/shell", path2, arch);
+	fd = open(path, O_PATH);
+	if (fd >= 0)
+		return fd;
+	scnprintf(path, sizeof(path), "%s/source/arch/%s/tests/shell", path2, arch);
+	fd = open(path, O_PATH);
+	if (fd >= 0)
+		return fd;
+
+	/* Then installed path. */
+	exec_path = get_argv_exec_path();
+	scnprintf(path, sizeof(path), "%s/arch/%s/tests/shell", exec_path, arch);
+	free(exec_path);
+	return open(path, O_PATH);
+}
+
 static char *shell_test__description(int dir_fd, const char *name)
 {
 	struct io io;
@@ -291,3 +338,29 @@ struct test_suite **create_script_test_suites(void)
 		close(dir_fd);
 	return result;
 }
+
+struct test_suite **create_script_test_suites_arch(void)
+{
+	struct test_suite **result = NULL, **result_tmp;
+	size_t result_sz = 0;
+	int dir_fd = shell_tests__arch_dir_fd(); /* Walk dir */
+
+	/*
+	 * Append scripts if fd is good, otherwise return a NULL terminated zero
+	 * length array.
+	 */
+	if (dir_fd >= 0)
+		append_scripts_in_dir(dir_fd, &result, &result_sz);
+
+	result_tmp = realloc(result, (result_sz + 1) * sizeof(*result_tmp));
+	if (result_tmp == NULL) {
+		pr_err("Out of memory while building script test suite list\n");
+		abort();
+	}
+	/* NULL terminate the test suite array. */
+	result = result_tmp;
+	result[result_sz] = NULL;
+	if (dir_fd >= 0)
+		close(dir_fd);
+	return result;
+}
diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-scripts.h
index b553ad26ea17642a..b03ee4a1ee63a25a 100644
--- a/tools/perf/tests/tests-scripts.h
+++ b/tools/perf/tests/tests-scripts.h
@@ -5,5 +5,6 @@
 #include "tests.h"
 
 struct test_suite **create_script_test_suites(void);
+struct test_suite **create_script_test_suites_arch(void);
 
 #endif /* TESTS_SCRIPTS_H */
-- 
2.49.0.1164.gab81da1b16-goog

