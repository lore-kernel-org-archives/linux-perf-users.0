Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D1F19D8BC
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338074; cv=none; b=rkNzGZTaj3u3g0++NzQhi6dzJeIRBymtYJBQmi8FVC0kelRnIoqjNx4ohWGaUceSBGjls0xpMauWJrxB7zonM8ZjP3QPogQQEH4TTJcF7H/RzUcCFgdYdbcKb24tFo7Ei4tMnBT1yppLSkQWIuOTZJUr7d5WjZ6kPhE2CYZAd9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338074; c=relaxed/simple;
	bh=2HZaIX4Yxe9EdHCUSc/BSMGBCqaAw4hhqXwP/5I1xWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwK+scLVUWCTbi6Fe133j2/CW/lKNtM8h7CHBfHhRlMtAQNYivA/Osom2JYWKuBtl7qVjso3KGsFclQbi01YdVdPfkzx/jIP7twsluqI1skUNzZk/mgDI2suOMdvIZMp8EoDtNRSvBSp3gS5oo/N6YrzpYw8a/Xw4f7t3b9G0nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7z9bAnT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7z9bAnT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776338072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DM5MEWxjDInKkqroZXm0ucUqGZl9U98G/+VGtt2NGTg=;
	b=Y7z9bAnT7UpRbLApFXNwf2bXBoEftX7ciSIHzDFIO4n/TMYWUFRRCiBAMzBvV+klLnFcX/
	4MCdbyFQEgI5/4QUYU+qdkbFdo+oTLTbY1tzDTNIFT4TxXtiaDzMMtDOw39MZR2Fl8XZrC
	7/AwUlkVaTI/PG+CYwGDfn0SK0nQdTE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-Muenod1sNjqA3vephSlmhw-1; Thu,
 16 Apr 2026 07:14:28 -0400
X-MC-Unique: Muenod1sNjqA3vephSlmhw-1
X-Mimecast-MFC-AGG-ID: Muenod1sNjqA3vephSlmhw_1776338067
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 592DA19560B4;
	Thu, 16 Apr 2026 11:14:27 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.44.34.208])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 387A518004AD;
	Thu, 16 Apr 2026 11:14:25 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com
Subject: [PATCH v7 1/7] perf tests: Create a structure for shell tests
Date: Thu, 16 Apr 2026 13:14:13 +0200
Message-ID: <20260416111419.385010-2-jbrnak@redhat.com>
In-Reply-To: <20260416111419.385010-1-jbrnak@redhat.com>
References: <20260416111419.385010-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The general structure of test suites with test cases has been implemented
for C tests for some time, while shell tests were just all put into a list
without any possible structuring.

Provide the same possibility of test suite structure for shell tests. The
suite is created for each subdirectory located in the 'perf/tests/shell'
directory that contains at least one test script. All of the deeper levels
of subdirectories will be merged with the first level of test cases.
The name of the test suite is the name of the subdirectory, where the test
cases are located. For all of the test scripts that are not in any
subdirectory, a test suite with a single test case is created as it has
been till now.

The new structure of the shell tests for 'perf test list':
    77: build id cache operations
    78: coresight
    78:1: CoreSight / ASM Pure Loop
    78:2: CoreSight / Memcpy 16k 10 Threads
    78:3: CoreSight / Thread Loop 10 Threads - Check TID
    78:4: CoreSight / Thread Loop 2 Threads - Check TID
    78:5: CoreSight / Unroll Loop Thread 10
    79: daemon operations
    80: perf diff tests

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Co-developed-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
 tools/perf/tests/tests-scripts.c | 319 ++++++++++++++++++++++++++-----
 tools/perf/tests/tests-scripts.h |   5 +
 2 files changed, 277 insertions(+), 47 deletions(-)

diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index f18c4cd337c8..680dfe650f14 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -1,4 +1,53 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Shell test suite infrastructure for perf test.
+ *
+ * Shell tests live under tools/perf/tests/shell/. The framework supports two
+ * layouts:
+ *
+ * 1) Standalone scripts: A .sh file placed directly in the shell/ directory
+ *    becomes a test suite with a single test case. The suite name is taken
+ *    from the script's description line (the second line, after the shebang).
+ *    Example: shell/record.sh -> "perf record tests"
+ *
+ * 2) Subdirectory suites: A subdirectory under shell/ containing .sh test
+ *    scripts becomes a test suite with multiple test cases. All scripts in
+ *    the subdirectory (and deeper levels) are merged into one suite. The
+ *    suite name defaults to the directory name.
+ *    Example: shell/coresight/ -> suite "coresight" with N test cases
+ *
+ * Setup scripts:
+ *    If a subdirectory contains a "setup.sh" file, it is executed before the
+ *    first test case. The description line of setup.sh overrides the suite
+ *    name. If setup fails, all test cases in the suite are skipped. Suites
+ *    with a setup script are marked exclusive (run sequentially, not in
+ *    parallel) to avoid interference between setup and test execution.
+ *    setup.sh is filtered out of the test case list -- it is not a test.
+ *
+ * Log directories:
+ *    For subdirectory suites, temporary log directories are created under
+ *    /tmp/perf_test_<sanitized_name>.XXXXXX where non-alphanumeric characters
+ *    in the suite name are replaced with underscores. The path is exported as
+ *    PERFSUITE_RUN_DIR. Test scripts can use this variable for storing
+ *    intermediate files and logs. Logs are removed after the suite completes
+ *    unless PERFTEST_KEEP_LOGS=y is set in the environment. On test harness
+ *    errors, logs are kept for debugging.
+ *
+ * Script conventions:
+ *    - Scripts must have a .sh extension and be executable.
+ *    - Scripts must start with a #! shebang (typically #!/bin/bash).
+ *    - The second line (after leading # and whitespace are stripped) is the
+ *      description shown by 'perf test list'.
+ *    - Appending " (exclusive)" to the description marks a test for
+ *      sequential execution.
+ *    - Exit code 0 = pass, 2 = skip, anything else = fail.
+ *
+ * Helper libraries:
+ *    shell/common/  - Shared initialization (init.sh), settings (settings.sh),
+ *                     pattern matching helpers, and result reporting functions.
+ *    shell/lib/     - Reusable shell and Python helpers for specific features
+ *                     (coresight, probes, stat output parsing, etc.).
+ */
 #include <dirent.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -151,14 +200,64 @@ static char *strdup_check(const char *str)
 	return newstr;
 }
 
-static int shell_test__run(struct test_suite *test, int subtest __maybe_unused)
+/* Check if dirent entry is a directory using file descriptor, handling DT_UNKNOWN case */
+static bool is_directory_fd(int dir_fd, struct dirent *ent)
 {
-	const char *file = test->priv;
+	struct stat st;
+
+	if (ent->d_type == DT_DIR)
+		return true;
+
+	if (ent->d_type != DT_UNKNOWN)
+		return false;
+
+	/* Need to stat the file to determine if it's a directory */
+	if (fstatat(dir_fd, ent->d_name, &st, 0) != 0)
+		return false;
+
+	return S_ISDIR(st.st_mode);
+}
+
+/* Free the whole structure of test_suite with its test_cases */
+static void free_suite(struct test_suite *suite)
+{
+	if (suite->test_cases) {
+		int num = 0;
+
+		while (suite->test_cases[num].name) { /* Last case has name set to NULL */
+			free((void *) suite->test_cases[num].name);
+			free((void *) suite->test_cases[num].desc);
+			num++;
+		}
+		free(suite->test_cases);
+	}
+	if (suite->desc)
+		free((void *) suite->desc);
+	if (suite->priv) {
+		struct shell_test_info *test_info = suite->priv;
+
+		free((void *) test_info->base_path);
+		free(test_info);
+	}
+
+	free(suite);
+}
+
+static int shell_test__run(struct test_suite *test, int subtest)
+{
+	const char *file;
 	int err;
 	char *cmd = NULL;
 
+	/* Get absolute file path */
+	if (subtest >= 0)
+		file = test->test_cases[subtest].name;
+	else	/* Single test case */
+		file = test->test_cases[0].name;
+
 	if (asprintf(&cmd, "%s%s", file, verbose ? " -v" : "") < 0)
 		return TEST_FAIL;
+
 	err = system(cmd);
 	free(cmd);
 	if (!err)
@@ -167,65 +266,117 @@ static int shell_test__run(struct test_suite *test, int subtest __maybe_unused)
 	return WEXITSTATUS(err) == 2 ? TEST_SKIP : TEST_FAIL;
 }
 
-static void append_script(int dir_fd, const char *name, char *desc,
-			  struct test_suite ***result,
-			  size_t *result_sz)
+static struct test_suite *prepare_test_suite(int dir_fd)
 {
-	char filename[PATH_MAX], link[128];
-	struct test_suite *test_suite, **result_tmp;
-	struct test_case *tests;
+	char dirpath[PATH_MAX], link[128];
 	ssize_t len;
-	char *exclusive;
+	struct test_suite *test_suite = NULL;
+	struct shell_test_info *test_info;
 
+	/* Get dir absolute path */
 	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
-	len = readlink(link, filename, sizeof(filename));
+	len = readlink(link, dirpath, sizeof(dirpath));
 	if (len < 0) {
 		pr_err("Failed to readlink %s", link);
-		return;
+		return NULL;
 	}
-	filename[len++] = '/';
-	strcpy(&filename[len], name);
+	dirpath[len++] = '/';
+	dirpath[len] = '\0';
 
-	tests = calloc(2, sizeof(*tests));
-	if (!tests) {
-		pr_err("Out of memory while building script test suite list\n");
-		return;
-	}
-	tests[0].name = strdup_check(name);
-	exclusive = strstr(desc, " (exclusive)");
-	if (exclusive != NULL) {
-		tests[0].exclusive = true;
-		exclusive[0] = '\0';
-	}
-	tests[0].desc = strdup_check(desc);
-	tests[0].run_case = shell_test__run;
 	test_suite = zalloc(sizeof(*test_suite));
 	if (!test_suite) {
 		pr_err("Out of memory while building script test suite list\n");
-		free(tests);
-		return;
+		return NULL;
 	}
-	test_suite->desc = desc;
-	test_suite->test_cases = tests;
-	test_suite->priv = strdup_check(filename);
+
+	test_info = zalloc(sizeof(*test_info));
+	if (!test_info) {
+		pr_err("Out of memory while building script test suite list\n");
+		free(test_suite);
+		return NULL;
+	}
+
+	test_info->base_path = strdup_check(dirpath);		/* Absolute path to dir */
+
+	test_suite->priv = test_info;
+	test_suite->desc = NULL;
+	test_suite->test_cases = NULL;
+
+	return test_suite;
+}
+
+static void append_suite(struct test_suite ***result,
+			  size_t *result_sz, struct test_suite *test_suite)
+{
+	struct test_suite **result_tmp;
+
 	/* Realloc is good enough, though we could realloc by chunks, not that
 	 * anyone will ever measure performance here */
 	result_tmp = realloc(*result, (*result_sz + 1) * sizeof(*result_tmp));
 	if (result_tmp == NULL) {
 		pr_err("Out of memory while building script test suite list\n");
-		free(tests);
-		free(test_suite);
+		free_suite(test_suite);
 		return;
 	}
+
 	/* Add file to end and NULL terminate the struct array */
 	*result = result_tmp;
 	(*result)[*result_sz] = test_suite;
 	(*result_sz)++;
 }
 
-static void append_scripts_in_dir(int dir_fd,
-				  struct test_suite ***result,
-				  size_t *result_sz)
+static void append_script_to_suite(int dir_fd, const char *name, char *desc,
+					struct test_suite *test_suite, size_t *tc_count)
+{
+	char file_name[PATH_MAX], link[128];
+	struct test_case *tests;
+	ssize_t len;
+	char *exclusive;
+
+	if (!test_suite) {
+		free(desc);
+		return;
+	}
+
+	/* Requires an empty test case at the end */
+	tests = realloc(test_suite->test_cases, (*tc_count + 2) * sizeof(*tests));
+	if (!tests) {
+		pr_err("Out of memory while building script test suite list\n");
+		free(desc);
+		return;
+	}
+	test_suite->test_cases = tests;
+	tests[*tc_count].name = NULL;	/* Ensure termination for early returns */
+
+	/* Get path to the test script */
+	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
+	len = readlink(link, file_name, sizeof(file_name));
+	if (len < 0) {
+		pr_err("Failed to readlink %s", link);
+		free(desc);
+		return;
+	}
+	file_name[len++] = '/';
+	strcpy(&file_name[len], name);
+
+	/* Get path to the script from base dir */
+	tests[(*tc_count)].name = strdup_check(file_name);
+	tests[(*tc_count)].exclusive = false;
+	exclusive = strstr(desc, " (exclusive)");
+	if (exclusive != NULL) {
+		tests[(*tc_count)].exclusive = true;
+		exclusive[0] = '\0';
+	}
+	tests[(*tc_count)].desc = desc;
+	tests[(*tc_count)].skip_reason = NULL;	/* Unused */
+	tests[(*tc_count)++].run_case = shell_test__run;
+
+	tests[(*tc_count)].name = NULL;		/* End the test cases */
+}
+
+static void append_scripts_in_subdir(int dir_fd,
+				  struct test_suite *suite,
+				  size_t *tc_count)
 {
 	struct dirent **entlist;
 	struct dirent *ent;
@@ -244,22 +395,96 @@ static void append_scripts_in_dir(int dir_fd,
 			char *desc = shell_test__description(dir_fd, ent->d_name);
 
 			if (desc) /* It has a desc line - valid script */
-				append_script(dir_fd, ent->d_name, desc, result, result_sz);
+				append_script_to_suite(dir_fd, ent->d_name, desc, suite, tc_count);
 			continue;
 		}
-		if (ent->d_type != DT_DIR) {
-			struct stat st;
-
-			if (ent->d_type != DT_UNKNOWN)
-				continue;
-			fstatat(dir_fd, ent->d_name, &st, 0);
-			if (!S_ISDIR(st.st_mode))
-				continue;
+
+		if (!is_directory_fd(dir_fd, ent))
+			continue;
+
+		fd = openat(dir_fd, ent->d_name, O_PATH);
+		if (fd < 0)
+			continue;
+
+		/* Recurse into the dir */
+		append_scripts_in_subdir(fd, suite, tc_count);
+		close(fd);
+	}
+	for (i = 0; i < n_dirs; i++) /* Clean up */
+		zfree(&entlist[i]);
+	free(entlist);
+}
+
+static void append_suites_in_dir(int dir_fd,
+				  struct test_suite ***result,
+				  size_t *result_sz)
+{
+	struct dirent **entlist;
+	struct dirent *ent;
+	int n_dirs, i;
+
+	/* List files, sorted by alpha */
+	n_dirs = scandirat(dir_fd, ".", &entlist, NULL, alphasort);
+	if (n_dirs == -1)
+		return;
+	for (i = 0; i < n_dirs && (ent = entlist[i]); i++) {
+		int fd;
+		struct test_suite *test_suite;
+		size_t cases_count = 0;
+
+		if (ent->d_name[0] == '.')
+			continue; /* Skip hidden files */
+		if (is_test_script(dir_fd, ent->d_name)) { /* It's a test */
+			char *desc = shell_test__description(dir_fd, ent->d_name);
+
+			if (desc) { /* It has a desc line - valid script */
+				/* Create a test suite with a single test case */
+				test_suite = prepare_test_suite(dir_fd);
+				if (!test_suite) {
+					free(desc);
+					continue;
+				}
+				append_script_to_suite(dir_fd, ent->d_name, desc,
+							       test_suite, &cases_count);
+
+				if (cases_count) {
+					test_suite->desc = strdup_check(
+							test_suite->test_cases[0].desc);
+					append_suite(result, result_sz, test_suite);
+				} else { /* Wasn't able to create the test case */
+					free_suite(test_suite);
+				}
+			}
+			continue;
 		}
+
+		if (!is_directory_fd(dir_fd, ent))
+			continue;
+
 		if (strncmp(ent->d_name, "base_", 5) == 0)
 			continue; /* Skip scripts that have a separate driver. */
+
+		/* Scan subdir for test cases */
 		fd = openat(dir_fd, ent->d_name, O_PATH);
-		append_scripts_in_dir(fd, result, result_sz);
+		if (fd < 0)
+			continue;
+		test_suite = prepare_test_suite(fd);	/* Prepare a testsuite with its path */
+		if (!test_suite) {
+			close(fd);
+			continue;
+		}
+
+		append_scripts_in_subdir(fd, test_suite, &cases_count);
+		if (cases_count == 0) {
+			free_suite(test_suite);
+			close(fd);
+			continue;
+		}
+
+		/* If no setup, set name to the directory */
+		test_suite->desc = strdup_check(ent->d_name);
+
+		append_suite(result, result_sz, test_suite);
 		close(fd);
 	}
 	for (i = 0; i < n_dirs; i++) /* Clean up */
@@ -278,7 +503,7 @@ struct test_suite **create_script_test_suites(void)
 	 * length array.
 	 */
 	if (dir_fd >= 0)
-		append_scripts_in_dir(dir_fd, &result, &result_sz);
+		append_suites_in_dir(dir_fd, &result, &result_sz);
 
 	result_tmp = realloc(result, (result_sz + 1) * sizeof(*result_tmp));
 	if (result_tmp == NULL) {
diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-scripts.h
index b553ad26ea17..1b849d4e70f4 100644
--- a/tools/perf/tests/tests-scripts.h
+++ b/tools/perf/tests/tests-scripts.h
@@ -4,6 +4,11 @@
 
 #include "tests.h"
 
+/* Additional information attached to shell tests */
+struct shell_test_info {
+	const char *base_path;
+};
+
 struct test_suite **create_script_test_suites(void);
 
 #endif /* TESTS_SCRIPTS_H */
-- 
2.52.0

