Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF0430595D
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248586; cv=none; b=ngd+kD7Yq1GxnpHEKmBGCW+1js5OB4YGtGxQCBHwCJ6fYUKjgATiRkGMjBw18q2NEdAU88axXpvX0g2G457d/BCKHHaUksfHQUvqcbFX2AXFIlbDJ7ThIHBfAZoz8psdjIPUqdTVJGBQ/lVj85ANKLrcwSBB06U4L7WWkzZZs3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248586; c=relaxed/simple;
	bh=6Y36mwXTrd6fkwh6xn3OXP2uQiSd5ln6JR/rqzKdz+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkq52I5FujE7SCmH8k/+LuuXGymom9Ii9lqP/Zv8LqfDuWfL3hUvGkKOzjtpuyiDwd8gnSGgV9DhXnQUvjkXyepbUXmItJUEfuh+YI6WYV+iKZTJqkfGyGr/kX2+HFgtyNo/naOELInNXlKFqztDjQ4TaTEDEBDNi4GQfcxtHoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9jTvrvx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9jTvrvx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759248583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJOlcVLbAp2C3TpoB3UV9mVm78c7JvYLNVLnPMVIbgA=;
	b=K9jTvrvxHBfFy1AAcoFqfMn467fPePQTM7HhQ75SgVuGJUIEgeNC3kECMeuMPC1tZP37Mk
	6UfWXM9/WLZhvBiQ95W4DQPDPJcjynhvC/XJ48iqvBdOMFx+xwOW2bsaVObGzagmOaXerV
	26tK63o282fxbC7YWC7Z4uSbmViivdQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-nMwQi4JFMPuqbJMBXmTxxA-1; Tue,
 30 Sep 2025 12:09:39 -0400
X-MC-Unique: nMwQi4JFMPuqbJMBXmTxxA-1
X-Mimecast-MFC-AGG-ID: nMwQi4JFMPuqbJMBXmTxxA_1759248578
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3847E1956059;
	Tue, 30 Sep 2025 16:09:38 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.77])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C811A30002C5;
	Tue, 30 Sep 2025 16:09:35 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	acme@redhat.com,
	irogers@google.com,
	linux-perf-users@vger.kernel.org,
	mpetlan@redhat.com,
	vmolnaro@redhat.com
Subject: [PATCH v4 3/7] perf test: Provide setup for the shell test suite
Date: Tue, 30 Sep 2025 18:09:19 +0200
Message-ID: <20250930160923.13728-4-jbrnak@redhat.com>
In-Reply-To: <20250930160923.13728-1-jbrnak@redhat.com>
References: <20250930160923.13728-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
 tools/perf/tests/builtin-test.c  | 30 +++++++++++++++++++-----
 tools/perf/tests/tests-scripts.c | 39 +++++++++++++++++++++++++++++---
 tools/perf/tests/tests-scripts.h | 10 ++++++++
 tools/perf/tests/tests.h         |  8 ++++---
 4 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 85142dfb3e01..6fc031ef50ea 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -258,6 +258,22 @@ static test_fnptr test_function(const struct test_suite *t, int test_case)
 	return t->test_cases[test_case].run_case;
 }
 
+/* If setup fails, skip all test cases */
+static void check_shell_setup(const struct test_suite *t, int ret)
+{
+	struct shell_info *test_info;
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
@@ -347,10 +363,9 @@ static int run_test_child(struct child_process *process)
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
@@ -367,7 +382,8 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 	case TEST_OK:
 		pr_info(" Ok\n");
 		break;
-	case TEST_SKIP: {
+	case TEST_SKIP:
+	case TEST_SETUP_FAIL:{
 		const char *reason = skip_reason(t, curr_test_case);
 
 		if (reason)
@@ -482,6 +498,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	}
 	/* Clean up child process. */
 	ret = finish_command(&child_test->process);
+	check_shell_setup(t, ret);
 	if (verbose > 1 || (verbose == 1 && ret == TEST_FAIL))
 		fprintf(stderr, "%s", err_output.buf);
 
@@ -504,7 +521,8 @@ static int start_test(struct test_suite *test, int curr_suite, int curr_test_cas
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
index e47f7eb50a73..10aab7c19ffe 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -138,6 +138,12 @@ static bool is_test_script(int dir_fd, const char *name)
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
@@ -178,6 +184,7 @@ static void free_suite(struct test_suite *suite)
 
 static int shell_test__run(struct test_suite *test, int subtest)
 {
+	struct shell_info *test_info = test->priv;
 	const char *file;
 	int err;
 	char *cmd = NULL;
@@ -189,6 +196,23 @@ static int shell_test__run(struct test_suite *test, int subtest)
 		file = test->test_cases[0].name;
 	}
 
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
+			if (err)
+				return TEST_SETUP_FAIL;
+	} else if (test_info->has_setup == FAILED_SETUP) {
+		return TEST_SKIP; /* Skip test suite if setup failed */
+	}
+
 	if (asprintf(&cmd, "%s%s", file, verbose ? " -v" : "") < 0)
 		return TEST_FAIL;
 
@@ -230,6 +254,7 @@ static struct test_suite *prepare_test_suite(int dir_fd)
 	}
 
 	test_info->base_path = strdup_check(dirpath);		/* Absolute path to dir */
+	test_info->has_setup = NO_SETUP;
 
 	test_suite->priv = test_info;
 	test_suite->desc = NULL;
@@ -312,7 +337,7 @@ static void append_scripts_in_subdir(int dir_fd,
 	int n_dirs, i;
 
 	/* List files, sorted by alpha */
-	n_dirs = scandirat(dir_fd, ".", &entlist, NULL, alphasort);
+	n_dirs = scandirat(dir_fd, ".", &entlist, setup_filter, alphasort);
 	if (n_dirs == -1)
 		return;
 	for (i = 0; i < n_dirs && (ent = entlist[i]); i++) {
@@ -409,8 +434,16 @@ static void append_suites_in_dir(int dir_fd,
 			continue;
 		}
 
-		/* If no setup, set name to the directory */
-		test_suite->desc = strdup_check(ent->d_name);
+		if (is_test_script(fd, SHELL_SETUP)) {	/* Check for setup existence */
+			char *desc = shell_test__description(fd, SHELL_SETUP);
+
+			/* Set the suite name by the setup description */
+			test_suite->desc = desc;
+			((struct shell_info *)(test_suite->priv))->has_setup = RUN_SETUP;
+		} else {
+			/* If no setup, set name to the directory */
+			test_suite->desc = strdup_check(ent->d_name);
+		}
 
 		append_suite(result, result_sz, test_suite);
 		close(fd);
diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-scripts.h
index 60a1a19a45c9..da4dcd26140c 100644
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
index 97e62db8764a..9f3e3b90f1ac 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -6,9 +6,11 @@
 #include "util/debug.h"
 
 enum {
-	TEST_OK   =  0,
-	TEST_FAIL = -1,
-	TEST_SKIP = -2,
+	TEST_OK         =  0,
+	TEST_FAIL		= -1,
+	TEST_SKIP       = -2,
+	TEST_RUNNING	= -3,
+	TEST_SETUP_FAIL = -4,
 };
 
 #define TEST_ASSERT_VAL(text, cond)					 \
-- 
2.50.1

