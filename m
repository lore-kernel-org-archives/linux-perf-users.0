Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9097D3A0B13
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338079; cv=none; b=PNCY4MkeKj4816yP32vx2v5HcLj9Wni5+WVkcLzOt2D3IHAx1XZmV14NVyHPzGujKf9eW57bTd5CTIVu+5LA6Z8OX9k9t3tn/C+xyqqEeNqxZ3JWWEF8ov3RmuIATQMFOoJj85/xSnWL2bEJBOlQPB5zf6TvNWy1iPwVNB2djaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338079; c=relaxed/simple;
	bh=mMUo4zwfD28wmecXxYD4pZKTCuHbTxkjDp31JtXqme8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9kGYfGhodhi5kdBKTGuIImbW+nCVoibudB2aCOC1GEA04Bwcnv2P+i9NR5g2HSuqn82WUXbz8wX71RScDT3HzDth5Bpf8X8ygf+Nsy2YE5Eir68soino/goX4Pcsyg8S1UVHR72MR7KPyxRkgRQ6fy1sWi/CICnN/KEaYp6ADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ROncudSk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROncudSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776338076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLHK64Nmp1hcJCXiwxQaac1s2cyHKtXU/oFQPUNRYXQ=;
	b=ROncudSkViN6jxqMLWWZ/SfV2w+s006wqONzlCDKw3cqm0FK3FFfCNlHeu/RGsCVYx5o42
	aLtO++aP9mFcvoGNDrkER1yECguo/grKvRnfzkZuc9ZQskknimx/f0lqG374FEY5fCeGlu
	gXD1SaB+pJX5OM+z7yftrV059ZpNNng=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-YoEMmQVDMPqulz_li3-gtA-1; Thu,
 16 Apr 2026 07:14:35 -0400
X-MC-Unique: YoEMmQVDMPqulz_li3-gtA-1
X-Mimecast-MFC-AGG-ID: YoEMmQVDMPqulz_li3-gtA_1776338074
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 024651956055;
	Thu, 16 Apr 2026 11:14:34 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.44.34.208])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FCE5180047F;
	Thu, 16 Apr 2026 11:14:32 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com
Subject: [PATCH v7 4/7] perf test: Introduce storing logs for shell tests
Date: Thu, 16 Apr 2026 13:14:16 +0200
Message-ID: <20260416111419.385010-5-jbrnak@redhat.com>
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

Create temporary directories for storing log files for shell tests
that could help while debugging. The log files are necessary for
perftool testsuite test cases also. If the variable PERFTEST_KEEP_LOGS
is set keep the logs, else delete them.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Co-developed-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
 tools/perf/tests/builtin-test.c  | 133 ++++++++++++++++++++++++++++++-
 tools/perf/tests/tests-scripts.c |   4 +
 tools/perf/tests/tests-scripts.h |   3 +
 3 files changed, 136 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 76fc37b440be..306ecfe5e22f 100644
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
@@ -288,6 +292,91 @@ static bool test_exclusive(const struct test_suite *t, int test_case)
 	return t->test_cases[test_case].exclusive;
 }
 
+static int delete_file(const char *fpath, const struct stat *sb __maybe_unused,
+		       int typeflag, struct FTW *ftwbuf)
+{
+	/* Stop traversal if going too deep */
+	if (ftwbuf->level > 5) {
+		pr_err("Tree traversal reached level %d, stopping.", ftwbuf->level);
+		return 1;
+	}
+
+	/* Remove only expected directories */
+	if (typeflag == FTW_D || typeflag == FTW_DP) {
+		const char *dirname = fpath + ftwbuf->base;
+
+		if (strcmp(dirname, "logs") && strcmp(dirname, "examples") &&
+		    strcmp(dirname, "header_tar") && strncmp(dirname, "perf_", 5)) {
+			pr_err("Unknown directory %s", dirname);
+			return 0;
+		}
+	}
+
+	/* Attempt to remove the file, continue on failure */
+	if (remove(fpath))
+		pr_err("Failed to remove file: %s", fpath);
+
+	return 0;
+}
+
+static bool create_logs(struct test_suite *t, int pass)
+{
+	bool store_logs = t->priv && ((struct shell_test_info *)(t->priv))->store_logs;
+	bool exclusive = false;
+	int tc;
+
+	test_suite__for_each_test_case(t, tc) {
+		if (test_exclusive(t, tc)) {
+			exclusive = true;
+			break;
+		}
+	}
+
+	if (pass == 1 && (!exclusive || sequential || dont_fork)) {
+		/* Sequential and non-exclusive tests run on the first pass. */
+		return store_logs;
+	} else if (pass != 1 && exclusive && !sequential && !dont_fork) {
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
+	if (snprintf(template, PATH_MAX, "/tmp/perf_test_%s.XXXXXX", name) >= PATH_MAX) {
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
@@ -627,9 +716,19 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 	 * runs the exclusive tests sequentially. In other modes all tests are
 	 * run in pass 1.
 	 */
+
 	for (int pass = 1; pass <= 2; pass++) {
 		int child_test_num = 0;
 		int curr_suite = 0;
+		size_t tmpdir_sz = num_logged_suites * runs_per_test;
+		char **tmpdir = tmpdir_sz ? calloc(tmpdir_sz, sizeof(*tmpdir)) : NULL;
+		unsigned int logged_suites = 0;
+
+		if (tmpdir_sz && !tmpdir) {
+			pr_err("Out of memory while allocating log directories\n");
+			err = -ENOMEM;
+			goto err_out;
+		}
 
 		for (struct test_suite **t = suites; *t; t++, curr_suite++) {
 			int curr_test_case;
@@ -663,16 +762,37 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 			}
 
 			for (unsigned int run = 0; run < runs_per_test; run++) {
+				/* Setup temporary log directories for shell test suites */
+				if (create_logs(*t, pass)) {
+					struct shell_test_info *info = (*t)->priv;
+
+					tmpdir[logged_suites] = setup_shell_logs((*t)->desc);
+					/* Couldn't create log dir, skip test suite */
+					if (tmpdir[logged_suites] == NULL) {
+						if (info->has_setup != NO_SETUP)
+							info->has_setup = FAILED_SETUP;
+					} else {
+						logged_suites++;
+						if (info->has_setup == PASSED_SETUP ||
+						    info->has_setup == FAILED_SETUP)
+							info->has_setup = RUN_SETUP;
+					}
+				}
+
 				test_suite__for_each_test_case(*t, curr_test_case) {
 					if (!suite_matched &&
 					    !perf_test__matches(test_description(*t, curr_test_case),
 								curr_suite, argc, argv))
 						continue;
-					err = start_test(*t, curr_suite, curr_test_case,
-							 &child_tests[child_test_num++],
-							 width, pass);
-					if (err)
+				err = start_test(*t, curr_suite, curr_test_case,
+						 &child_tests[child_test_num++],
+						 width, pass);
+					if (err) {
+						for (size_t x = 0; x < logged_suites; x++)
+							free(tmpdir[x]);
+						free(tmpdir);
 						goto err_out;
+					}
 				}
 			}
 		}
@@ -681,6 +801,11 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 			for (size_t x = 0; x < num_tests; x++)
 				finish_test(child_tests, x, num_tests, width);
 		}
+
+		/* Cleanup logs; on err_out logs are intentionally kept for debugging */
+		for (size_t x = 0; x < logged_suites; x++)
+			cleanup_shell_logs(tmpdir[x]);
+		free(tmpdir);
 	}
 err_out:
 	signal(SIGINT, SIG_DFL);
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index 33f1e46267f4..fc5e1b835ecc 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -322,6 +322,7 @@ static struct test_suite *prepare_test_suite(int dir_fd)
 
 	test_info->base_path = strdup_check(dirpath);		/* Absolute path to dir */
 	test_info->has_setup = NO_SETUP;
+	test_info->store_logs = false;
 
 	test_suite->priv = test_info;
 	test_suite->desc = NULL;
@@ -506,6 +507,9 @@ static void append_suites_in_dir(int dir_fd,
 			continue;
 		}
 
+		/* Store logs for testsuites in sub-directories */
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

