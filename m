Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F4198845
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732239; cv=none; b=U0sbh0ZGj6Fgntq52etGklr26M4q3g8j6dzFxTIdoYGXTHTBY5eWVhd0eZt2ZL5oq+Y0IPoxuaCv9eVj6L1V0rDVxV95xA7og8ilbzWXErVkmtXwMYeAn1nW3oRDS6nLBNwgEdAxMCO5yU+sqttwdHLfHwi+hbGeu5W+5Azwh3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732239; c=relaxed/simple;
	bh=xWvxlpSIb+l2PRY/3NEuymyck6BuKDezSqb9Zs+BXSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3gkPFIkIgcIMR5XVhsOmBc/n4LrDmiNhQ9wUyTdHORueqeALz2f0THGHB4wKmup54lVwOqpX3xfPHvE1y36Cl0D/xysHKR4OsudmmW1dhjnfD/hSopCDJm4PUBC0s7gUc5ueaJcTORmMjRZWkMRyFFNG695r3cbXmvlHy5ul/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g99D7eJ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g99D7eJ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734732236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=othYRxmVEryyrQtJmtNtLmeR/hwsMEYzk22pTGtSi6w=;
	b=g99D7eJ4yCF2saA3BmyXzRFfubVPOe4KxofAOEtPOnD+6TDsybGoD9bfpj5Wgy2FyPzMXD
	ZdqDnb0kRrBo4ODl5M448M4hS09QhLsoLS3f6/CGwKNGHbGtp2I4KuMeI+lF2jJgbE6kMC
	OfyKyIGOHItxUY7WHYEcLJUgPBCxUGU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-Z8-Mlop-NU6JSG5s0heCXQ-1; Fri,
 20 Dec 2024 17:03:54 -0500
X-MC-Unique: Z8-Mlop-NU6JSG5s0heCXQ-1
X-Mimecast-MFC-AGG-ID: Z8-Mlop-NU6JSG5s0heCXQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC7791955F3D;
	Fri, 20 Dec 2024 22:03:53 +0000 (UTC)
Received: from telekom.ip.com (unknown [10.45.224.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF9A419560A2;
	Fri, 20 Dec 2024 22:03:51 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	namhyung@kernel.org,
	mpetlan@redhat.com
Cc: irogers@google.com
Subject: [PATCH 04/10] perf tests: Create a structure for shell tests
Date: Fri, 20 Dec 2024 23:03:28 +0100
Message-ID: <20241220220334.69198-5-vmolnaro@redhat.com>
In-Reply-To: <20241220220334.69198-1-vmolnaro@redhat.com>
References: <20241220220334.69198-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Veronika Molnarova <vmolnaro@redhat.com>

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
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/tests/tests-scripts.c | 223 +++++++++++++++++++++++++------
 tools/perf/tests/tests-scripts.h |   4 +
 2 files changed, 189 insertions(+), 38 deletions(-)

diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index cf3ae0c1d871742b..97f249ce0a36b03c 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -151,14 +151,45 @@ static char *strdup_check(const char *str)
 	return newstr;
 }
 
-static int shell_test__run(struct test_suite *test, int subtest __maybe_unused)
+/* Free the whole structure of test_suite with its test_cases */
+static void free_suite(struct test_suite *suite) {
+	if (suite->test_cases){
+		int num = 0;
+		while (suite->test_cases[num].name){ /* Last case has name set to NULL */
+			free((void*) suite->test_cases[num].name);
+			free((void*) suite->test_cases[num].desc);
+			num++;
+		}
+		free(suite->test_cases);
+	}
+	if (suite->desc)
+		free((void*) suite->desc);
+	if (suite->priv){
+		struct shell_info *test_info = suite->priv;
+		free((void*) test_info->base_path);
+		free(test_info);
+	}
+
+	free(suite);
+}
+
+static int shell_test__run(struct test_suite *test, int subtest)
 {
-	const char *file = test->priv;
+	const char *file;
 	int err;
 	char *cmd = NULL;
 
+	/* Get absolute file path */
+	if (subtest >= 0) {
+		file = test->test_cases[subtest].name;
+	}
+	else {		/* Single test case */
+		file = test->test_cases[0].name;
+	}
+
 	if (asprintf(&cmd, "%s%s", file, verbose ? " -v" : "") < 0)
 		return TEST_FAIL;
+
 	err = system(cmd);
 	free(cmd);
 	if (!err)
@@ -167,63 +198,154 @@ static int shell_test__run(struct test_suite *test, int subtest __maybe_unused)
 	return WEXITSTATUS(err) == 2 ? TEST_SKIP : TEST_FAIL;
 }
 
-static void append_script(int dir_fd, const char *name, char *desc,
-			  struct test_suite ***result,
-			  size_t *result_sz)
+static struct test_suite* prepare_test_suite(int dir_fd)
 {
-	char filename[PATH_MAX], link[128];
-	struct test_suite *test_suite, **result_tmp;
-	struct test_case *tests;
+	char dirpath[PATH_MAX], link[128];
 	size_t len;
-	char *exclusive;
+	struct test_suite *test_suite = NULL;
+	struct shell_info *test_info;
 
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
+static void append_script_to_suite(int dir_fd, const char *name, char *desc,
+					struct test_suite *test_suite, size_t *tc_count)
+{
+	char file_name[PATH_MAX], link[128];
+	struct test_case *tests;
+	size_t len;
+	char *exclusive;
+
+	if (!test_suite)
+		return;
+
+	/* Requires an empty test case at the end */
+	tests = realloc(test_suite->test_cases, (*tc_count + 2) * sizeof(*tests));
+	if (!tests) {
+		pr_err("Out of memory while building script test suite list\n");
+		return;
+	}
+
+	/* Get path to the test script */
+	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
+	len = readlink(link, file_name, sizeof(file_name));
+	if (len < 0) {
+		pr_err("Failed to readlink %s", link);
+		return;
+	}
+	file_name[len++] = '/';
+	strcpy(&file_name[len], name);
+
+	tests[(*tc_count)].name = strdup_check(file_name);	/* Get path to the script from base dir */
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
+
+	test_suite->test_cases = tests;
+}
+
+static void append_scripts_in_subdir(int dir_fd,
+				  struct test_suite *suite,
+				  size_t *tc_count)
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
+
+		if (ent->d_name[0] == '.')
+			continue; /* Skip hidden files */
+		if (is_test_script(dir_fd, ent->d_name)) { /* It's a test */
+			char *desc = shell_test__description(dir_fd, ent->d_name);
+
+			if (desc) /* It has a desc line - valid script */
+				append_script_to_suite(dir_fd, ent->d_name, desc, suite, tc_count);
+			continue;
+		}
+
+		if (ent->d_type != DT_DIR) {
+			struct stat st;
+
+			if (ent->d_type != DT_UNKNOWN)
+				continue;
+			fstatat(dir_fd, ent->d_name, &st, 0);
+			if (!S_ISDIR(st.st_mode))
+				continue;
+		}
+
+		fd = openat(dir_fd, ent->d_name, O_PATH);
+
+		/* Recurse into the dir */
+		append_scripts_in_subdir(fd, suite, tc_count);
+	}
+	for (i = 0; i < n_dirs; i++) /* Clean up */
+		zfree(&entlist[i]);
+	free(entlist);
+}
+
+static void append_suits_in_dir(int dir_fd,
 				  struct test_suite ***result,
 				  size_t *result_sz)
 {
@@ -237,16 +359,27 @@ static void append_scripts_in_dir(int dir_fd,
 		return;
 	for (i = 0; i < n_dirs && (ent = entlist[i]); i++) {
 		int fd;
+		struct test_suite *test_suite;
+		size_t cases_count = 0;
 
 		if (ent->d_name[0] == '.')
 			continue; /* Skip hidden files */
 		if (is_test_script(dir_fd, ent->d_name)) { /* It's a test */
 			char *desc = shell_test__description(dir_fd, ent->d_name);
 
-			if (desc) /* It has a desc line - valid script */
-				append_script(dir_fd, ent->d_name, desc, result, result_sz);
+			if (desc) { /* It has a desc line - valid script */
+				test_suite = prepare_test_suite(dir_fd); /* Create a test suite with a single test case */
+				append_script_to_suite(dir_fd, ent->d_name, desc, test_suite, &cases_count);
+				test_suite->desc = strdup_check(desc);
+
+				if (cases_count)
+					append_suite(result, result_sz, test_suite);
+				else /* Wasn't able to create the test case */
+					free_suite(test_suite);
+			}
 			continue;
 		}
+
 		if (ent->d_type != DT_DIR) {
 			struct stat st;
 
@@ -258,8 +391,22 @@ static void append_scripts_in_dir(int dir_fd,
 		}
 		if (strncmp(ent->d_name, "base_", 5) == 0)
 			continue; /* Skip scripts that have a separate driver. */
+
+		/* Scan subdir for test cases*/
 		fd = openat(dir_fd, ent->d_name, O_PATH);
-		append_scripts_in_dir(fd, result, result_sz);
+		test_suite = prepare_test_suite(fd);	/* Prepare a testsuite with its path */
+		if (!test_suite)
+			continue;
+
+		append_scripts_in_subdir(fd, test_suite, &cases_count);
+		if (cases_count == 0){
+			free_suite(test_suite);
+			continue;
+		}
+
+		test_suite->desc = strdup_check(ent->d_name);	/* If no setup, set name to the directory */
+
+		append_suite(result, result_sz, test_suite);
 	}
 	for (i = 0; i < n_dirs; i++) /* Clean up */
 		zfree(&entlist[i]);
@@ -277,7 +424,7 @@ struct test_suite **create_script_test_suites(void)
 	 * length array.
 	 */
 	if (dir_fd >= 0)
-		append_scripts_in_dir(dir_fd, &result, &result_sz);
+		append_suits_in_dir(dir_fd, &result, &result_sz);
 
 	result_tmp = realloc(result, (result_sz + 1) * sizeof(*result_tmp));
 	if (result_tmp == NULL) {
diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-scripts.h
index b553ad26ea17642a..60a1a19a45c999f4 100644
--- a/tools/perf/tests/tests-scripts.h
+++ b/tools/perf/tests/tests-scripts.h
@@ -4,6 +4,10 @@
 
 #include "tests.h"
 
+struct shell_info {
+	const char *base_path;
+};
+
 struct test_suite **create_script_test_suites(void);
 
 #endif /* TESTS_SCRIPTS_H */
-- 
2.43.0

