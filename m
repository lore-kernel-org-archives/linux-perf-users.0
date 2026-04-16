Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814025A33F
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338076; cv=none; b=p5XCILGVn2OUuAYK0IcixscKW/XVNw5PaHFtxjzvvHeDStHPYhNZowVL8BNyxq6Q5WY1VzQSdL/iKP5Nb/ndRSpk9MDOrW3V8SVoA2K0J+u7Ou3y2aegpUR4Dmxbr30DLEDqfJgsALDoiBEVrWR51DrgPwQ8MK9WNu8FKqHJt+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338076; c=relaxed/simple;
	bh=T0ujICPP9O3QnXv98WDrVGjU/nb4EUbrg9LwlPiJHpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRjPZwhtee1dlqilxTce653/KF9OHxoI5QULXpJUbkPAIQEnQYnPc5C/pgyzHrXD/cRe7Na+TwW18zc7zsFzmMT2QxqmQ6aNLFhxhvelrcDhBuoEq4VKaedOEsk3LJ745hSce2+VgOFazGnxcqFqFXm5LM6VX4nXVlnW/t0Yvpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDmXPtqV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDmXPtqV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776338073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwYr9SR8GSlcHD7d3gip+6xdChiBb/9AOqgHh4cKCJo=;
	b=QDmXPtqV0/2AD6dKJ4xC7NwoTq+yLooEA/efmdPsd1CwcdX6AQ4rP2J8XINuGcrPWpBIKt
	DNRAN5CieGzaI5r29mS1SZtP1dasPSJ57aj8dpi6sMQtUAm078+DVwNWuB2DO6o7ObtrRd
	dx1E8OGU9ZVlTFlIhKZxeqyM1XlFcto=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-GWbKibj9MXSLQ5r4qF6_ZA-1; Thu,
 16 Apr 2026 07:14:30 -0400
X-MC-Unique: GWbKibj9MXSLQ5r4qF6_ZA-1
X-Mimecast-MFC-AGG-ID: GWbKibj9MXSLQ5r4qF6_ZA_1776338069
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FF7F195608F;
	Thu, 16 Apr 2026 11:14:29 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.44.34.208])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFAE9180047F;
	Thu, 16 Apr 2026 11:14:27 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com
Subject: [PATCH v7 2/7] perf test: Provide setup for the shell test suite
Date: Thu, 16 Apr 2026 13:14:14 +0200
Message-ID: <20260416111419.385010-3-jbrnak@redhat.com>
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

Some of the perftool-testsuite test cases require a setup to be done
beforehand as may be recording data, setting up cache or restoring sample
rate. The setup file also provides the possibility to set the name of
the test suite, if the name of the directory is not good enough.

Check for the existence of the "setup.sh" script for the shell test
suites and run it before the any of the test cases. If the setup fails,
skip all of the test cases of the test suite as the setup may be
required for the result to be valid.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Co-developed-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
 tools/perf/tests/builtin-test.c  | 30 ++++++++++++++++++-----
 tools/perf/tests/tests-scripts.c | 41 +++++++++++++++++++++++++++++---
 tools/perf/tests/tests-scripts.h | 11 ++++++++-
 tools/perf/tests/tests.h         |  8 ++++---
 4 files changed, 77 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 06507066213b..76fc37b440be 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -264,6 +264,22 @@ static test_fnptr test_function(const struct test_suite *t, int test_case)
 	return t->test_cases[test_case].run_case;
 }
 
+/* If setup fails, skip all test cases */
+static void check_shell_setup(const struct test_suite *t, int ret)
+{
+	struct shell_test_info *test_info;
+
+	if (!t->priv)
+		return;
+
+	test_info = t->priv;
+
+	if (ret == TEST_SETUP_FAIL)
+		test_info->has_setup = FAILED_SETUP;
+	else if (test_info->has_setup == RUN_SETUP)
+		test_info->has_setup = PASSED_SETUP;
+}
+
 static bool test_exclusive(const struct test_suite *t, int test_case)
 {
 	if (test_case <= 0)
@@ -353,10 +369,9 @@ static int run_test_child(struct child_process *process)
 	return -err;
 }
 
-#define TEST_RUNNING -3
-
-static int print_test_result(struct test_suite *t, int curr_suite, int curr_test_case,
-			     int result, int width, int running)
+static int print_test_result(struct test_suite *t, int curr_suite,
+			     int curr_test_case, int result, int width,
+			     int running)
 {
 	if (test_suite__num_test_cases(t) > 1) {
 		int subw = width > 2 ? width - 2 : width;
@@ -373,7 +388,8 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 	case TEST_OK:
 		pr_info(" Ok\n");
 		break;
-	case TEST_SKIP: {
+	case TEST_SKIP:
+	case TEST_SETUP_FAIL: {
 		const char *reason = skip_reason(t, curr_test_case);
 
 		if (reason)
@@ -488,6 +504,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	}
 	/* Clean up child process. */
 	ret = finish_command(&child_test->process);
+	check_shell_setup(t, ret);
 	if (verbose > 1 || (verbose == 1 && ret == TEST_FAIL))
 		fprintf(stderr, "%s", err_output.buf);
 
@@ -510,7 +527,8 @@ static int start_test(struct test_suite *test, int curr_suite, int curr_test_cas
 			err = test_function(test, curr_test_case)(test, curr_test_case);
 			pr_debug("---- end ----\n");
 			print_test_result(test, curr_suite, curr_test_case, err, width,
-					  /*running=*/0);
+				  /*running=*/0);
+			check_shell_setup(test, err);
 		}
 		return 0;
 	}
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index 680dfe650f14..33f1e46267f4 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -187,6 +187,12 @@ static bool is_test_script(int dir_fd, const char *name)
 	return is_shell_script(dir_fd, name);
 }
 
+/* Filter for scandir */
+static int setup_filter(const struct dirent *entry)
+{
+	return strcmp(entry->d_name, SHELL_SETUP);
+}
+
 /* Duplicate a string and fall over and die if we run out of memory */
 static char *strdup_check(const char *str)
 {
@@ -245,6 +251,7 @@ static void free_suite(struct test_suite *suite)
 
 static int shell_test__run(struct test_suite *test, int subtest)
 {
+	struct shell_test_info *test_info = test->priv;
 	const char *file;
 	int err;
 	char *cmd = NULL;
@@ -255,6 +262,23 @@ static int shell_test__run(struct test_suite *test, int subtest)
 	else	/* Single test case */
 		file = test->test_cases[0].name;
 
+	/* Run setup if needed */
+	if (test_info->has_setup == RUN_SETUP) {
+		char *setup_script;
+
+		if (asprintf(&setup_script, "%s%s%s", test_info->base_path,
+			     SHELL_SETUP, verbose ? " -v" : "") < 0)
+			return TEST_SETUP_FAIL;
+
+		err = system(setup_script);
+		free(setup_script);
+
+		if (err)
+			return TEST_SETUP_FAIL;
+	} else if (test_info->has_setup == FAILED_SETUP) {
+		return TEST_SKIP; /* Skip test suite if setup failed */
+	}
+
 	if (asprintf(&cmd, "%s%s", file, verbose ? " -v" : "") < 0)
 		return TEST_FAIL;
 
@@ -297,6 +321,7 @@ static struct test_suite *prepare_test_suite(int dir_fd)
 	}
 
 	test_info->base_path = strdup_check(dirpath);		/* Absolute path to dir */
+	test_info->has_setup = NO_SETUP;
 
 	test_suite->priv = test_info;
 	test_suite->desc = NULL;
@@ -383,7 +408,7 @@ static void append_scripts_in_subdir(int dir_fd,
 	int n_dirs, i;
 
 	/* List files, sorted by alpha */
-	n_dirs = scandirat(dir_fd, ".", &entlist, NULL, alphasort);
+	n_dirs = scandirat(dir_fd, ".", &entlist, setup_filter, alphasort);
 	if (n_dirs == -1)
 		return;
 	for (i = 0; i < n_dirs && (ent = entlist[i]); i++) {
@@ -481,8 +506,18 @@ static void append_suites_in_dir(int dir_fd,
 			continue;
 		}
 
-		/* If no setup, set name to the directory */
-		test_suite->desc = strdup_check(ent->d_name);
+		if (is_test_script(fd, SHELL_SETUP)) {	/* Check for setup existence */
+			char *desc = shell_test__description(fd, SHELL_SETUP);
+
+			/* Set the suite name by the setup description */
+			test_suite->desc = desc ? desc : strdup_check(ent->d_name);
+			((struct shell_test_info *)(test_suite->priv))->has_setup = RUN_SETUP;
+			for (size_t j = 0; j < cases_count; j++)
+				test_suite->test_cases[j].exclusive = true;
+		} else {
+			/* If no setup, set name to the directory */
+			test_suite->desc = strdup_check(ent->d_name);
+		}
 
 		append_suite(result, result_sz, test_suite);
 		close(fd);
diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-scripts.h
index 1b849d4e70f4..013031239883 100644
--- a/tools/perf/tests/tests-scripts.h
+++ b/tools/perf/tests/tests-scripts.h
@@ -4,9 +4,18 @@
 
 #include "tests.h"
 
-/* Additional information attached to shell tests */
+#define SHELL_SETUP "setup.sh"
+
+enum shell_setup {
+	NO_SETUP     = 0,
+	RUN_SETUP    = 1,
+	FAILED_SETUP = 2,
+	PASSED_SETUP = 3,
+};
+
 struct shell_test_info {
 	const char *base_path;
+	enum shell_setup has_setup;
 };
 
 struct test_suite **create_script_test_suites(void);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index f5f1238d1f7f..d8d4156e31de 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -6,9 +6,11 @@
 #include "util/debug.h"
 
 enum {
-	TEST_OK   =  0,
-	TEST_FAIL = -1,
-	TEST_SKIP = -2,
+	TEST_OK         =  0,
+	TEST_FAIL       = -1,
+	TEST_SKIP       = -2,
+	TEST_RUNNING    = -3,
+	TEST_SETUP_FAIL = -4,
 };
 
 #define TEST_ASSERT_VAL(text, cond)					 \
-- 
2.52.0

