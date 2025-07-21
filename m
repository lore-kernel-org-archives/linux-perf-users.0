Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC92C327C
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104425; cv=none; b=YgLdCvKFbQ3yPH50OKZ2WHevtzp1NCVfh3oiW2sTDphv9VhvBKLgl5ONv+hHcaZl07wArFq0suCOo2ETL76BrsRB0Ugpvy3bQNdBkUy+Vdu7BhQhxaWEfMVeG6pMUdVUArVfFvVyetf8BCg6XUlUok9kgUpps6gLIgVvvNeLR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104425; c=relaxed/simple;
	bh=WvZ7PVIqGiAewtgI8zTjibuTUYrq7WZlcI1uQMwNSek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnBEHRxHrlfUaEE6CxViMZtg0xRlnzf7BEIn99iWe5hKNb/7KRwJkGqFl3z33S/TFuOPe0HQTzcR/DUtzaMoIiMl0j4Rjgk2+Wjhx0feSDOIzywYUB+ImZVKGmUUfD2I7ytJpKFtkE/QDR7dv5Favj7CM7aeINSav5eWYVdseVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAIUe2pu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAIUe2pu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753104423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lb8MzxlnPbCk6ZPMDPvQvB27UM7JfSeC386xGVQE1rA=;
	b=UAIUe2pu805PEwNmhLtUowVXOrErBVpifewSa4D4O8LfxgEsmciaU7PEvTjJHbwDSKfQRP
	QRVpaW2L1bW5WU+mGpFnkFq2d08BGgF5UjqP9M2MXmyaEKRk9EppnHvzwTKq7is0vwwbMU
	pSpd1l57M8Kou00lvTt/g/9uTtH9JWA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-rQBRnTe8PFSNKrgxnsbzMQ-1; Mon,
 21 Jul 2025 09:26:59 -0400
X-MC-Unique: rQBRnTe8PFSNKrgxnsbzMQ-1
X-Mimecast-MFC-AGG-ID: rQBRnTe8PFSNKrgxnsbzMQ_1753104418
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B244419560A7;
	Mon, 21 Jul 2025 13:26:58 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC0C319560A3;
	Mon, 21 Jul 2025 13:26:56 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: vmolnaro@redhat.com
Cc: acme@kernel.org,
	acme@redhat.com,
	irogers@google.com,
	linux-perf-users@vger.kernel.org,
	mpetlan@redhat.com,
	namhyung@kernel.org
Subject: [PATCH v3 5/7] perf test: Introduce storing logs for shell tests
Date: Mon, 21 Jul 2025 15:26:40 +0200
Message-ID: <20250721132642.40906-6-jbrnak@redhat.com>
In-Reply-To: <20250721132642.40906-1-jbrnak@redhat.com>
References: <20250113182605.130719-1-vmolnaro@redhat.com>
 <20250721132642.40906-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Veronika Molnarova <vmolnaro@redhat.com>

Create temporary directories for storing log files for shell tests
that could help while debugging. The log files are necessary for
perftool testsuite test cases also. If the variable KEEP_TEST_LOGS
is set keep the logs, else delete them.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
 tools/perf/tests/builtin-test.c  | 90 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests-scripts.c |  3 ++
 tools/perf/tests/tests-scripts.h |  1 +
 3 files changed, 94 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 4e3d2f779b01..89b180798224 100644
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
@@ -282,6 +283,86 @@ static bool test_exclusive(const struct test_suite *t, int test_case)
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
+	if (typeflag == FTW_D || typeflag == FTW_DP){
+		const char *dirname = fpath + ftwbuf->base;
+
+		if (strcmp(dirname, "logs") && strcmp(dirname, "examples") &&
+			strcmp(dirname, "header_tar") && strncmp(dirname, "perf_", 5)) {
+				pr_err("Unknown directory %s", dirname);
+				return rv;
+			 }
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
+static bool create_logs(struct test_suite *t, int pass){
+	bool store_logs = t->priv && ((struct shell_info*)(t->priv))->store_logs;
+	if (pass == 1 && (!test_exclusive(t, 0) || sequential || dont_fork)) {
+		/* Sequential and non-exclusive tests run on the first pass. */
+		return store_logs;
+	}
+	else if (pass != 1 && test_exclusive(t, 0) && !sequential && !dont_fork) {
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
+	else {
+		pr_err("Failed to create the temporary directory");
+	}
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
+		if (!keep_logs || strcmp(keep_logs, "y") != 0) {
+			nftw(dirname, delete_file, 8, FTW_DEPTH | FTW_PHYS);
+		}
+		free(dirname);
+	}
+
+	unsetenv("PERFSUITE_RUN_DIR");
+}
+
 static bool perf_test__matches(const char *desc, int suite_num, int argc, const char *argv[])
 {
 	int i;
@@ -626,6 +707,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 		for (struct test_suite **t = suites; *t; t++, curr_suite++) {
 			int curr_test_case;
 			bool suite_matched = false;
+			char *tmpdir = NULL;
 
 			if (!perf_test__matches(test_description(*t, -1), curr_suite, argc, argv)) {
 				/*
@@ -655,6 +737,13 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 			}
 
 			for (unsigned int run = 0; run < runs_per_test; run++) {
+				/* Setup temporary log directories for shell test suites */
+				if (create_logs(*t, pass)) {
+					tmpdir = setup_shell_logs((*t)->desc);
+
+					if (tmpdir == NULL)  /* Couldn't create log dir, skip test suite */
+						((struct shell_info*)((*t)->priv))->has_setup = FAILED_SETUP;
+				}
 				test_suite__for_each_test_case(*t, curr_test_case) {
 					if (!suite_matched &&
 					    !perf_test__matches(test_description(*t, curr_test_case),
@@ -667,6 +756,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 						goto err_out;
 				}
 			}
+			cleanup_shell_logs(tmpdir);
 		}
 		if (!sequential) {
 			/* Parallel mode starts tests but doesn't finish them. Do that now. */
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index d680a878800f..d4e382898a30 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -251,6 +251,7 @@ static struct test_suite* prepare_test_suite(int dir_fd)
 
 	test_info->base_path = strdup_check(dirpath);		/* Absolute path to dir */
 	test_info->has_setup = NO_SETUP;
+	test_info->store_logs = false;
 
 	test_suite->priv = test_info;
 	test_suite->desc = NULL;
@@ -427,6 +428,8 @@ static void append_suits_in_dir(int dir_fd,
 			continue;
 		}
 
+		/* Store logs for testsuite is sub-directories */
+		((struct shell_info*)(test_suite->priv))->store_logs = true;
 		if (is_test_script(fd, SHELL_SETUP)) {	/* Check for setup existance */
 			char *desc = shell_test__description(fd, SHELL_SETUP);
 			test_suite->desc = desc;	/* Set the suite name by the setup description */
diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-scripts.h
index da4dcd26140c..41da0a175e4e 100644
--- a/tools/perf/tests/tests-scripts.h
+++ b/tools/perf/tests/tests-scripts.h
@@ -16,6 +16,7 @@ enum shell_setup {
 struct shell_info {
 	const char *base_path;
 	enum shell_setup has_setup;
+	bool store_logs;
 };
 
 struct test_suite **create_script_test_suites(void);
-- 
2.50.1

