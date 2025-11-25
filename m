Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C71D8DFB
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764086230; cv=none; b=Pw9lFY5pCkgTGS/PHaulQvO7dwTapt+mEfSidQQ5J2ErBJUkmGuVfaVZUj8CD6jHwK5l2ehPwyW7btfO7TFdDUtApxklk8CDmAb+GlAJQE8ZP9YgmLPnVRNNpiTuJwFFlxB0+Wyya4oOqieANgiVYOzUK9OFoIGo5RhL5tBPr/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764086230; c=relaxed/simple;
	bh=WvUjVbeAD2rXQhKibeIzcD5j5nzd5L4O0OO0537JkB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0pvmSSTtEAe/Moq7Nkm25oZFMTUkGNbKVGdozK0n9CM4mzbnkmj3fKnW2Bjcr3Dmx9N51d5asOcnUORwv8PN13dd8DNlyew2Wi3MR992OWFc8kiYqd4eW7kmmLx9Q57EwQWNK4ZsS8DpliP+eACHgq4x4wWTBivRxwjiAL3Spk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AIPifD9L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIPifD9L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764086226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIHb+QyYA6kBhSDAmIMpWomS7bSc6Q4IPPGmHWZFnGA=;
	b=AIPifD9L1hmR/k/oj668jpL4Zf2jYmZjjkWnsLnTG3WXwztN9Rjnpw8FQO3nl+7M/NlPp9
	4pF/gMJjX5YQtjsnPCv5jUvRRu6GZ52TcZAaMhX6938T3+XBpHB5z2TjoiA6+csCGugHXK
	Pe2R7Ay+DOSOhsWAkiAXEZ1eS4FcTEQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-0VlJIJCkMOClK2OMYQqJ9A-1; Tue,
 25 Nov 2025 10:57:03 -0500
X-MC-Unique: 0VlJIJCkMOClK2OMYQqJ9A-1
X-Mimecast-MFC-AGG-ID: 0VlJIJCkMOClK2OMYQqJ9A_1764086222
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 004C21956094;
	Tue, 25 Nov 2025 15:57:02 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25DB7180047F;
	Tue, 25 Nov 2025 15:56:59 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com,
	vmolnaro@redhat.com
Subject: [PATCH v5 4/7] perf test: Introduce storing logs for shell tests
Date: Tue, 25 Nov 2025 16:56:45 +0100
Message-ID: <20251125155648.197527-5-jbrnak@redhat.com>
In-Reply-To: <20251125155648.197527-1-jbrnak@redhat.com>
References: <20251125155648.197527-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Create temporary directories for storing log files for shell tests
that could help while debugging. The log files are necessary for
perftool testsuite test cases also. If the variable PERFTEST_KEEP_LOGS
is set keep the logs, else delete them.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Co-developed-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
 tools/perf/tests/builtin-test.c  | 91 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests-scripts.c |  3 ++
 tools/perf/tests/tests-scripts.h |  1 +
 3 files changed, 95 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 04114e6dc2d6..e5a4e86db644 100644
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
+						((struct shell_test_info *)((*t)->priv))->has_setup =
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
index 3703ad7b3b75..bf974e4b9051 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -272,6 +272,7 @@ static struct test_suite *prepare_test_suite(int dir_fd)
 
 	test_info->base_path = strdup_check(dirpath);		/* Absolute path to dir */
 	test_info->has_setup = NO_SETUP;
+	test_info->store_logs = false;
 
 	test_suite->priv = test_info;
 	test_suite->desc = NULL;
@@ -438,6 +439,8 @@ static void append_suites_in_dir(int dir_fd,
 			continue;
 		}
 
+		/* Store logs for testsuite is sub-directories */
+		((struct shell_test_info *)(test_suite->priv))->store_logs = true;
 		if (is_test_script(fd, SHELL_SETUP)) {	/* Check for setup existence */
 			char *desc = shell_test__description(fd, SHELL_SETUP);
 
diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-scripts.h
index 013031239883..05d403e9be31 100644
--- a/tools/perf/tests/tests-scripts.h
+++ b/tools/perf/tests/tests-scripts.h
@@ -16,6 +16,7 @@ enum shell_setup {
 struct shell_test_info {
 	const char *base_path;
 	enum shell_setup has_setup;
+	bool store_logs;
 };
 
 struct test_suite **create_script_test_suites(void);
-- 
2.51.1

