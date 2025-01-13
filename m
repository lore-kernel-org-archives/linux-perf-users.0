Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A336A1C3F04
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736792817; cv=none; b=nOUBdg/5yOMO+H4TchitE9AQjEkYRJZLXZ1GQ7Av5MDQhnLwvUwAPUfj1TqaQ9PgHrHhmBMkXAUq3nx3mK9SBTdZUNR8bpJaSU2tvQlGGW9aRY4mjdXpPq9mGRk5PSBFvh/cjikaMlA3KdI/IVNCPYZhOwLLNrF31f41tn14eIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736792817; c=relaxed/simple;
	bh=ix9S2N9bOTtGpPTha57h1azqDsGSaPVSrdlVYDOpsn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tX+HrCP8RB8kIHEyEVpo2p45uE3i9U8go6gUXN7gC9WTHpR6cuWjefYBPVA5fiPVeM5vCMh/Py9EYwktFpoVWFLfHMXM1+1DJTjvopX4snM/3NwiajTcOvV/S6Tljmwn4groAJFrSzg1mbA5eTVxwt0nF2Ckz9uBsWLYzTf+m+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VMXzn5xL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMXzn5xL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736792814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/LjJtmPwr6gyEaXaYNIEgOeOZCA9+wdnYQL2EskBf8=;
	b=VMXzn5xL6G9QaeLl6Nx6fiGStllxPDpK2UKQMsqkfPXfic/HGUAEC2HMITMkNpAMn8vR8r
	A6afNzfRJrIDbQ+cY3U0VdD8h8RTaiNNmks0nZk4bcbJMiLrs2pgic/ajyd3+VzsIuXEG+
	Hj6x7ZaH5pCF90xuMU8HNkXAxl5TZmo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-a4z4fSAFMEynKzbmMHI6OA-1; Mon,
 13 Jan 2025 13:26:53 -0500
X-MC-Unique: a4z4fSAFMEynKzbmMHI6OA-1
X-Mimecast-MFC-AGG-ID: a4z4fSAFMEynKzbmMHI6OA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 999941954191;
	Mon, 13 Jan 2025 18:26:52 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.147])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E7CE19560AD;
	Mon, 13 Jan 2025 18:26:50 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	mpetlan@redhat.com,
	namhyung@kernel.org
Cc: irogers@google.com
Subject: [PATCH v2 06/10] perf test: Provide setup for the shell test suite
Date: Mon, 13 Jan 2025 19:26:01 +0100
Message-ID: <20250113182605.130719-7-vmolnaro@redhat.com>
In-Reply-To: <Z4UwHy-Kj9XDI9cf@x1>
References: <Z4UwHy-Kj9XDI9cf@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Veronika Molnarova <vmolnaro@redhat.com>

Some of the perftool-testsuite test cases require a setup to be done
beforehand as may be recording data, setting up cache or restoring sample
rate. The setup file also provides the possibility to set the name of
the test suite, if the name of the directory is not good enough.

Check for the existence of the "setup.sh" script for the shell test
suites and run it before the any of the test cases. If the setup fails,
skip all of the test cases of the test suite as the setup may be
required for the result to be valid.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/tests/builtin-test.c  | 23 ++++++++++++++++++---
 tools/perf/tests/tests-scripts.c | 34 ++++++++++++++++++++++++++++++--
 tools/perf/tests/tests-scripts.h | 10 ++++++++++
 tools/perf/tests/tests.h         |  8 +++++---
 4 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index a5b9ccd0033a8484..4a4dc86ebcf60d0d 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -192,6 +192,22 @@ static test_fnptr test_function(const struct test_suite *t, int subtest)
 	return t->test_cases[subtest].run_case;
 }
 
+/* If setup fails, skip all test cases */
+static void check_shell_setup(const struct test_suite *t, int ret)
+{
+	struct shell_info* test_info;
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
 static bool test_exclusive(const struct test_suite *t, int subtest)
 {
 	if (subtest <= 0)
@@ -268,8 +284,6 @@ static int run_test_child(struct child_process *process)
 	return -err;
 }
 
-#define TEST_RUNNING -3
-
 static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width,
 			     int running)
 {
@@ -287,7 +301,8 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
 	case TEST_OK:
 		pr_info(" Ok\n");
 		break;
-	case TEST_SKIP: {
+	case TEST_SKIP:
+	case TEST_SETUP_FAIL:{
 		const char *reason = skip_reason(t, subtest);
 
 		if (reason)
@@ -400,6 +415,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	}
 	/* Clean up child process. */
 	ret = finish_command(&child_test->process);
+	check_shell_setup(t, ret);
 	if (verbose > 1 || (verbose == 1 && ret == TEST_FAIL))
 		fprintf(stderr, "%s", err_output.buf);
 
@@ -422,6 +438,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 			err = test_function(test, subi)(test, subi);
 			pr_debug("---- end ----\n");
 			print_test_result(test, i, subi, err, width, /*running=*/0);
+			check_shell_setup(test, err);
 		}
 		return 0;
 	}
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index c742a3d0a6a26bb4..fa8f18cbcd2ae2bc 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -138,6 +138,11 @@ static bool is_test_script(int dir_fd, const char *name)
 	return is_shell_script(dir_fd, name);
 }
 
+/* Filter for scandir */
+static int setup_filter(const struct dirent *entry){
+	return strcmp(entry->d_name, SHELL_SETUP);
+}
+
 /* Duplicate a string and fall over and die if we run out of memory */
 static char *strdup_check(const char *str)
 {
@@ -175,6 +180,7 @@ static void free_suite(struct test_suite *suite) {
 
 static int shell_test__run(struct test_suite *test, int subtest)
 {
+	struct shell_info *test_info = test->priv;
 	const char *file;
 	int err;
 	char *cmd = NULL;
@@ -187,6 +193,22 @@ static int shell_test__run(struct test_suite *test, int subtest)
 		file = test->test_cases[0].name;
 	}
 
+	/* Run setup if needed */
+	if (test_info->has_setup == RUN_SETUP){
+		char *setup_script;
+		if (asprintf(&setup_script, "%s%s%s", test_info->base_path, SHELL_SETUP, verbose ? " -v" : "") < 0)
+			return TEST_SETUP_FAIL;
+
+		err = system(setup_script);
+		free(setup_script);
+
+		if (err)
+			return TEST_SETUP_FAIL;
+	}
+	else if (test_info->has_setup == FAILED_SETUP) {
+		return TEST_SKIP; /* Skip test suite if setup failed */
+	}
+
 	if (asprintf(&cmd, "%s%s", file, verbose ? " -v" : "") < 0)
 		return TEST_FAIL;
 
@@ -228,6 +250,7 @@ static struct test_suite* prepare_test_suite(int dir_fd)
 	}
 
 	test_info->base_path = strdup_check(dirpath);		/* Absolute path to dir */
+	test_info->has_setup = NO_SETUP;
 
 	test_suite->priv = test_info;
 	test_suite->desc = NULL;
@@ -309,7 +332,7 @@ static void append_scripts_in_subdir(int dir_fd,
 	int n_dirs, i;
 
 	/* List files, sorted by alpha */
-	n_dirs = scandirat(dir_fd, ".", &entlist, NULL, alphasort);
+	n_dirs = scandirat(dir_fd, ".", &entlist, setup_filter, alphasort);
 	if (n_dirs == -1)
 		return;
 	for (i = 0; i < n_dirs && (ent = entlist[i]); i++) {
@@ -404,7 +427,14 @@ static void append_suits_in_dir(int dir_fd,
 			continue;
 		}
 
-		test_suite->desc = strdup_check(ent->d_name);	/* If no setup, set name to the directory */
+		if (is_test_script(fd, SHELL_SETUP)) {	/* Check for setup existance */
+			char *desc = shell_test__description(fd, SHELL_SETUP);
+			test_suite->desc = desc;	/* Set the suite name by the setup description */
+			((struct shell_info*)(test_suite->priv))->has_setup = RUN_SETUP;
+		}
+		else {
+			test_suite->desc = strdup_check(ent->d_name);	/* If no setup, set name to the directory */
+		}
 
 		append_suite(result, result_sz, test_suite);
 	}
diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-scripts.h
index 60a1a19a45c999f4..da4dcd26140cdfd2 100644
--- a/tools/perf/tests/tests-scripts.h
+++ b/tools/perf/tests/tests-scripts.h
@@ -4,8 +4,18 @@
 
 #include "tests.h"
 
+#define SHELL_SETUP "setup.sh"
+
+enum shell_setup {
+	NO_SETUP     = 0,
+	RUN_SETUP    = 1,
+	FAILED_SETUP = 2,
+	PASSED_SETUP = 3,
+};
+
 struct shell_info {
 	const char *base_path;
+	enum shell_setup has_setup;
 };
 
 struct test_suite **create_script_test_suites(void);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 8aea344536b8ab7d..2c5e665d1805b908 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -5,9 +5,11 @@
 #include <stdbool.h>
 
 enum {
-	TEST_OK   =  0,
-	TEST_FAIL = -1,
-	TEST_SKIP = -2,
+	TEST_OK         =  0,
+	TEST_FAIL      	= -1,
+	TEST_SKIP       = -2,
+	TEST_RUNNING	= -3,
+	TEST_SETUP_FAIL = -4,
 };
 
 #define TEST_ASSERT_VAL(text, cond)					 \
-- 
2.43.0

