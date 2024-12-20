Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56061CAAC
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732245; cv=none; b=R1i3f9EXKnfIe4DXORXffgT5N864VvuL6etlVi8pp2D5TTEiu6NmEI2LOdi6w+Ru7+Qhf6vm92J4ZgV1RYuUr/a51dnsrGFfSR/2ytYKAK7fF5QN2xqvWCL/hUhXqlBWW16ZXhFsJkzcYPIC9fNbMDTQCkHiXdQ3dVXh7H6tz5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732245; c=relaxed/simple;
	bh=+pV+5rXxLYGzRQSk0lZ/EsVwIDcq748nzL/8/yfEHNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+IFQysysgTj6H33vKAKJrm0kgnXvRdI6gaMQUTi8juKOFsuGR57w7g6OgwXstSeX8+xbQ8czLRcIYyhYqWYykV22cTnG/u3NQ4YGRBAZySyq0lke80Feo2AAqeuPwHoatwHtavq2nEmeCyR2rolPFSFW7OkhGCPfnV10AFR4uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2VKobGs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2VKobGs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734732242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBF6l5DIUoMflSMQwM/h8aiINKEViumCqhLBUU5AnGc=;
	b=X2VKobGsfXgvuFii+VeVOeV4ohDYE/2LdTeuaTMCCwXucfZTkPVwbtNnzNof134KVaZtGY
	4TwNPoRZsGduoh+cAWSsJi9DS9PAkTVMYLBXyxgxVD+JxwfkDt2Hw1W5CxLja4awIUIyf+
	0AIQYY7xwO92WULgeWyfybUlK6YWK+Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-Iq4l6uwoNbWgQ8BO7hU85A-1; Fri,
 20 Dec 2024 17:03:59 -0500
X-MC-Unique: Iq4l6uwoNbWgQ8BO7hU85A-1
X-Mimecast-MFC-AGG-ID: Iq4l6uwoNbWgQ8BO7hU85A
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99C941955F66;
	Fri, 20 Dec 2024 22:03:58 +0000 (UTC)
Received: from telekom.ip.com (unknown [10.45.224.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DC9319560A2;
	Fri, 20 Dec 2024 22:03:56 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	namhyung@kernel.org,
	mpetlan@redhat.com
Cc: irogers@google.com
Subject: [PATCH 06/10] perf test: Provide setup for the shell test suite
Date: Fri, 20 Dec 2024 23:03:30 +0100
Message-ID: <20241220220334.69198-7-vmolnaro@redhat.com>
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
index d2cabaa8ad922d68..585613446d8a3c8d 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -193,6 +193,22 @@ static test_fnptr test_function(const struct test_suite *t, int subtest)
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
@@ -269,8 +285,6 @@ static int run_test_child(struct child_process *process)
 	return -err;
 }
 
-#define TEST_RUNNING -3
-
 static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width,
 			     int running)
 {
@@ -288,7 +302,8 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
 	case TEST_OK:
 		pr_info(" Ok\n");
 		break;
-	case TEST_SKIP: {
+	case TEST_SKIP:
+	case TEST_SETUP_FAIL:{
 		const char *reason = skip_reason(t, subtest);
 
 		if (reason)
@@ -401,6 +416,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	}
 	/* Clean up child process. */
 	ret = finish_command(&child_test->process);
+	check_shell_setup(t, ret);
 	if (verbose > 1 || (verbose == 1 && ret == TEST_FAIL))
 		fprintf(stderr, "%s", err_output.buf);
 
@@ -423,6 +439,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 			err = test_function(test, subi)(test, subi);
 			pr_debug("---- end ----\n");
 			print_test_result(test, i, subi, err, width, /*running=*/0);
+			check_shell_setup(test, err);
 		}
 		return 0;
 	}
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index 97f249ce0a36b03c..77a6b8d2213e6e74 100644
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
index af284dd47e5c7855..2c3fb03ad633be61 100644
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

