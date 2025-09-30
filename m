Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3458230595D
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248590; cv=none; b=Qtn0B+DlU4t/4o0FQ9OkeWXHA4uYHy35f13vgwsrRpdkI2rtK1sixFLLsflwOxCFih/sQta6vYjaiD7UzJxwrWAsI/ZPtOvB4w497b0nvErCAo13V78rDxsO+0EeY3pt12PT1/pDMW0GSrJfkP10l443kN9+8LhoBdGi8wzcu78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248590; c=relaxed/simple;
	bh=mcYwHK+12/VsQ8DW8cKXoCmHsaUtTqoZN1JpoIOjEZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWhbUza70p6dI1f75cNB/NDVmAt9lFYhd7nlKgyIQrbwE7wjNmXdpShmaj/upZ7oBNVscjfkQzpshU6cYqnStWeHD0S0S886gcQ1t+RwOCBte3O0jMDSnGvwsancnrq/WL0CmcL6H8QJHcitm+b3NlDlBeImH4iSiaE15LEVq7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0V3jJbG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0V3jJbG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759248588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C9rxFQp5RiMwzfa+Tt+nqdH10bWqrL9ap7si3heAehI=;
	b=b0V3jJbGnn9DeHIP/VffewrxUVQLQ01BcHjREiDGT8W9HTjZon5A590s08e8/Bx7N/E8sr
	X7maWDQ5aJ5NWFE4qQkRwQhpVqj5Dq7v0PanjX7YH05JcDBbkUvKOgZj0j/2Qjtf3S/GnW
	R+Gj4qSnuUgodD4VZZiU1qWyaHgaCZg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-WG1pQVBLNHKjb7oEVNAy0A-1; Tue,
 30 Sep 2025 12:09:44 -0400
X-MC-Unique: WG1pQVBLNHKjb7oEVNAy0A-1
X-Mimecast-MFC-AGG-ID: WG1pQVBLNHKjb7oEVNAy0A_1759248583
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A63D5180035C;
	Tue, 30 Sep 2025 16:09:43 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.77])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CAF430002C5;
	Tue, 30 Sep 2025 16:09:41 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	acme@redhat.com,
	irogers@google.com,
	linux-perf-users@vger.kernel.org,
	mpetlan@redhat.com,
	vmolnaro@redhat.com
Subject: [PATCH v4 5/7] perf test: Introduce storing logs for shell tests
Date: Tue, 30 Sep 2025 18:09:21 +0200
Message-ID: <20250930160923.13728-6-jbrnak@redhat.com>
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

Create temporary directories for storing log files for shell tests
that could help while debugging. The log files are necessary for
perftool testsuite test cases also. If the variable PERFTEST_KEEP_LOGS
is set keep the logs, else delete them.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
 tools/perf/tests/builtin-test.c  | 91 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests-scripts.c |  3 ++
 tools/perf/tests/tests-scripts.h |  1 +
 3 files changed, 95 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 6fc031ef50ea..a943f66cbac0 100644
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
@@ -282,6 +283,85 @@ static bool test_exclusive(const struct test_suite *t, int test_case)
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
+	bool store_logs = t->priv && ((struct shell_info *)(t->priv))->store_logs;
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
@@ -628,6 +708,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 		for (struct test_suite **t = suites; *t; t++, curr_suite++) {
 			int curr_test_case;
 			bool suite_matched = false;
+			char *tmpdir = NULL;
 
 			if (!perf_test__matches(test_description(*t, -1), curr_suite, argc, argv)) {
 				/*
@@ -657,6 +738,15 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 			}
 
 			for (unsigned int run = 0; run < runs_per_test; run++) {
+				/* Setup temporary log directories for shell test suites */
+				if (create_logs(*t, pass)) {
+					tmpdir = setup_shell_logs((*t)->desc);
+
+					/* Couldn't create log dir, skip test suite */
+					if (tmpdir == NULL)
+						((struct shell_info *)((*t)->priv))->has_setup =
+							FAILED_SETUP;
+				}
 				test_suite__for_each_test_case(*t, curr_test_case) {
 					if (!suite_matched &&
 					    !perf_test__matches(test_description(*t, curr_test_case),
@@ -669,6 +759,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 						goto err_out;
 				}
 			}
+			cleanup_shell_logs(tmpdir);
 		}
 		if (!sequential) {
 			/* Parallel mode starts tests but doesn't finish them. Do that now. */
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index 10aab7c19ffe..9b4782bc1767 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -255,6 +255,7 @@ static struct test_suite *prepare_test_suite(int dir_fd)
 
 	test_info->base_path = strdup_check(dirpath);		/* Absolute path to dir */
 	test_info->has_setup = NO_SETUP;
+	test_info->store_logs = false;
 
 	test_suite->priv = test_info;
 	test_suite->desc = NULL;
@@ -434,6 +435,8 @@ static void append_suites_in_dir(int dir_fd,
 			continue;
 		}
 
+		/* Store logs for testsuite is sub-directories */
+		((struct shell_info *)(test_suite->priv))->store_logs = true;
 		if (is_test_script(fd, SHELL_SETUP)) {	/* Check for setup existence */
 			char *desc = shell_test__description(fd, SHELL_SETUP);
 
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

