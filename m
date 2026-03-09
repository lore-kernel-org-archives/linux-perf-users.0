Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98242765ED
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071868; cv=none; b=PxwFhpsuMal412KY98nE9E/07EjzBpaXlq4zEz7OLqcmqQ8XU2i5DK8S6zVIjBqmW8Wfecet41+iFEQwD9dGVHeoVl9c4UNZV3OOrcngExyWY/zyH0v589Mlp0+YCZ1lCcjaygUulO7+B7bkZo5JnmIrjYZfhjHZ6fUpuTCLoeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071868; c=relaxed/simple;
	bh=5rMmeTrCpI48SVadNHIZ6etSCDyOtblUnAffecmzFNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuYbwmBP3vOshVSWtpOVrpB8SXs4kPGnaZ6g5ElTdFSMsvqzRzCCz2PzupP0yizmamlzserRusQWJgEwTGka0RXWC9Vjri2QFM2IaPAC2u9nJzFGn+IL5lmHQoMQd8KyXZlNLC5tdZNCKRY/764Hw7sHPp7SswcjdUfKXlSMaYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0niW6NS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0niW6NS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773071865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2Cgj9T9UNOEymWawCeGfofMMUDEh0AECZsqGoKfj4g=;
	b=b0niW6NSzQ8uExys+4Il2posx4ru5cFyIi2LwLGzZ/ArWXQFJX0crFDqt0BsChPqPq1+Uo
	7k/TuJKOvSUaTKy8FyUhCth4XSiI5VDQ+OaLIC54f7QwAn8lVfptGZqPT68DmntMZ41wuF
	KGE4B8cZF+2377z7eAkiNMyhXDq0h64=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-mLAAp01bP0aoqnBUNlekTQ-1; Mon,
 09 Mar 2026 11:57:42 -0400
X-MC-Unique: mLAAp01bP0aoqnBUNlekTQ-1
X-Mimecast-MFC-AGG-ID: mLAAp01bP0aoqnBUNlekTQ_1773071861
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FDBD1956059;
	Mon,  9 Mar 2026 15:57:41 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC85330001A2;
	Mon,  9 Mar 2026 15:57:39 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com
Subject: [PATCH v6 4/7] perf test: Introduce storing logs for shell tests
Date: Mon,  9 Mar 2026 16:57:25 +0100
Message-ID: <20260309155728.98026-5-jbrnak@redhat.com>
In-Reply-To: <20260309155728.98026-1-jbrnak@redhat.com>
References: <20260309155728.98026-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Create temporary directories for storing log files for shell tests
that could help while debugging. The log files are necessary for
perftool testsuite test cases also. If the variable PERFTEST_KEEP_LOGS
is set keep the logs, else delete them.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Co-developed-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
 tools/perf/tests/builtin-test.c  | 103 +++++++++++++++++++++++++++++++
 tools/perf/tests/tests-scripts.c |   4 ++
 tools/perf/tests/tests-scripts.h |   3 +
 3 files changed, 110 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c1515fa8a947..70f4a61357ec 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -6,6 +6,7 @@
  */
 #include <ctype.h>
 #include <fcntl.h>
+#include <ftw.h>
 #include <errno.h>
 #ifdef HAVE_BACKTRACE_SUPPORT
 #include <execinfo.h>
@@ -51,6 +52,9 @@ static unsigned int runs_per_test = 1;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 
+/* Number of logged test suites. */
+size_t num_logged_suites;
+
 /*
  * List of architecture specific tests. Not a weak symbol as the array length is
  * dependent on the initialization, as such GCC with LTO complains of
@@ -288,6 +292,85 @@ static bool test_exclusive(const struct test_suite *t, int test_case)
 	return t->test_cases[test_case].exclusive;
 }
 
+static int delete_file(const char *fpath, const struct stat *sb __maybe_unused,
+						 int typeflag, struct FTW *ftwbuf)
+{
+	int rv = -1;
+
+	/* Stop traversal if going too deep */
+	if (ftwbuf->level > 5) {
+		pr_err("Tree traversal reached level %d, stopping.", ftwbuf->level);
+		return rv;
+	}
+
+	/* Remove only expected directories */
+	if (typeflag == FTW_D || typeflag == FTW_DP) {
+		const char *dirname = fpath + ftwbuf->base;
+
+		if (strcmp(dirname, "logs") && strcmp(dirname, "examples") &&
+		    strcmp(dirname, "header_tar") && strncmp(dirname, "perf_", 5)) {
+			pr_err("Unknown directory %s", dirname);
+			return rv;
+		}
+	}
+
+	/* Attempt to remove the file */
+	rv = remove(fpath);
+	if (rv)
+		pr_err("Failed to remove file: %s", fpath);
+
+	return rv;
+}
+
+static bool create_logs(struct test_suite *t, int pass)
+{
+	bool store_logs = t->priv && ((struct shell_test_info *)(t->priv))->store_logs;
+
+	if (pass == 1 && (!test_exclusive(t, 0) || sequential || dont_fork)) {
+		/* Sequential and non-exclusive tests run on the first pass. */
+		return store_logs;
+	} else if (pass != 1 && test_exclusive(t, 0) && !sequential && !dont_fork) {
+		/* Exclusive tests without sequential run on the second pass. */
+		return store_logs;
+	}
+	return false;
+}
+
+static char *setup_shell_logs(const char *name)
+{
+	char template[PATH_MAX];
+	char *temp_dir;
+
+	if (snprintf(template, PATH_MAX, "/tmp/perf_test_%s.XXXXXX", name) < 0) {
+		pr_err("Failed to create log dir template");
+		return NULL; /* Skip the testsuite */
+	}
+
+	temp_dir = mkdtemp(template);
+	if (temp_dir) {
+		setenv("PERFSUITE_RUN_DIR", temp_dir, 1);
+		return strdup(temp_dir);
+	}
+
+	pr_err("Failed to create the temporary directory");
+
+	return NULL; /* Skip the testsuite */
+}
+
+static void cleanup_shell_logs(char *dirname)
+{
+	char *keep_logs = getenv("PERFTEST_KEEP_LOGS");
+
+	/* Check if logs should be kept or do cleanup */
+	if (dirname) {
+		if (!keep_logs || strcmp(keep_logs, "y") != 0)
+			nftw(dirname, delete_file, 8, FTW_DEPTH | FTW_PHYS);
+		free(dirname);
+	}
+
+	unsetenv("PERFSUITE_RUN_DIR");
+}
+
 static bool perf_test__matches(const char *desc, int suite_num, int argc, const char *argv[])
 {
 	int i;
@@ -627,9 +710,12 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 	 * runs the exclusive tests sequentially. In other modes all tests are
 	 * run in pass 1.
 	 */
+
 	for (int pass = 1; pass <= 2; pass++) {
 		int child_test_num = 0;
 		int curr_suite = 0;
+		char *tmpdir[num_logged_suites * runs_per_test];
+		unsigned int logged_suites = 0;
 
 		for (struct test_suite **t = suites; *t; t++, curr_suite++) {
 			int curr_test_case;
@@ -663,6 +749,18 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 			}
 
 			for (unsigned int run = 0; run < runs_per_test; run++) {
+				/* Setup temporary log directories for shell test suites */
+				if (create_logs(*t, pass)) {
+					tmpdir[logged_suites] = setup_shell_logs((*t)->desc);
+					/* Couldn't create log dir, skip test suite */
+					if (tmpdir[logged_suites] == NULL) {
+						((struct shell_test_info *)((*t)->priv))->has_setup
+							= FAILED_SETUP;
+					} else {
+						logged_suites++;
+					}
+				}
+
 				test_suite__for_each_test_case(*t, curr_test_case) {
 					if (!suite_matched &&
 					    !perf_test__matches(test_description(*t, curr_test_case),
@@ -681,6 +779,9 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 			for (size_t x = 0; x < num_tests; x++)
 				finish_test(child_tests, x, num_tests, width);
 		}
+
+		for (size_t x = 0; x < logged_suites; x++)
+			cleanup_shell_logs(tmpdir[x]);
 	}
 err_out:
 	signal(SIGINT, SIG_DFL);
@@ -750,6 +851,8 @@ static int perf_test__config(const char *var, const char *value,
 	return 0;
 }
 
+
+
 static struct test_suite **build_suites(void)
 {
 	/*
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index 3703ad7b3b75..c45b41b5bf07 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -272,6 +272,7 @@ static struct test_suite *prepare_test_suite(int dir_fd)
 
 	test_info->base_path = strdup_check(dirpath);		/* Absolute path to dir */
 	test_info->has_setup = NO_SETUP;
+	test_info->store_logs = false;
 
 	test_suite->priv = test_info;
 	test_suite->desc = NULL;
@@ -438,6 +439,9 @@ static void append_suites_in_dir(int dir_fd,
 			continue;
 		}
 
+		/* Store logs for testsuite is sub-directories */
+		((struct shell_test_info *)(test_suite->priv))->store_logs = true;
+		num_logged_suites++;
 		if (is_test_script(fd, SHELL_SETUP)) {	/* Check for setup existence */
 			char *desc = shell_test__description(fd, SHELL_SETUP);
 
diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-scripts.h
index 013031239883..1dd91f1444e3 100644
--- a/tools/perf/tests/tests-scripts.h
+++ b/tools/perf/tests/tests-scripts.h
@@ -16,8 +16,11 @@ enum shell_setup {
 struct shell_test_info {
 	const char *base_path;
 	enum shell_setup has_setup;
+	bool store_logs;
 };
 
 struct test_suite **create_script_test_suites(void);
 
+extern size_t num_logged_suites;
+
 #endif /* TESTS_SCRIPTS_H */
-- 
2.52.0

