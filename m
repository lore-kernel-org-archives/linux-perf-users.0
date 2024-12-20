Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68494225A5D
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 22:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732250; cv=none; b=AEJpdjRcT9meGoJhBPxQj5we4txRWjfPHAtuWSjEZmz3ZBziMlgACJ21NfjIR+wf1pYTEtHTVH2hkmv4bE7UptYWxPk7zYjVHiykF8YlwSnXXC+IaK8duYcORq35Crb3ht0ANlbBNkXdZ+mQGS1by81wDQJtGCtjYGjrMvuPPtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732250; c=relaxed/simple;
	bh=80sN5nUm9zhOJX/fKEUIL55anvVyM2SW/2tu1mpSwCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tc4SIp6vGKAQG2D6REMswNtd7epTkTf4eAEcUSkS8QS/sMWluk7Oegt+udACpAh9erhsCoUbeAsXAfdc1OLJzCIlGx5PE3tttJtB7sAGVdrXU8xja3lLf1oEcSYBRPTfVx8th75VkRBM3z2rvj9WYrrvVI8+s6D+ZvDl1/HsVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V39TF93J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V39TF93J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734732246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8aFlpgYvk/x/Cufpg7QkIAdCwihMt4n24+jVkFrCsnY=;
	b=V39TF93J5+Ahw1RMOrQH4hzlr91wnEX2haqHqC9uvyETdFj6COo6wIGKpeZ0kRlplOT886
	wmUuzDhgsYxzzrLThg1kA5djr1rcgGMp23N8hjaF7H4fkNbdIkaOYw6qRMYKyCWvwa5wwD
	w5yLT3Oza+8p5ws1iJI/MfXkR9c8zmk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-7TW1zOUEMrunz9a9GgSSBQ-1; Fri,
 20 Dec 2024 17:04:05 -0500
X-MC-Unique: 7TW1zOUEMrunz9a9GgSSBQ-1
X-Mimecast-MFC-AGG-ID: 7TW1zOUEMrunz9a9GgSSBQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E9171956057;
	Fri, 20 Dec 2024 22:04:04 +0000 (UTC)
Received: from telekom.ip.com (unknown [10.45.224.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7DCC19560A2;
	Fri, 20 Dec 2024 22:04:01 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	namhyung@kernel.org,
	mpetlan@redhat.com
Cc: irogers@google.com
Subject: [PATCH 08/10] perf test: Introduce storing logs for shell tests
Date: Fri, 20 Dec 2024 23:03:32 +0100
Message-ID: <20241220220334.69198-9-vmolnaro@redhat.com>
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

Create temporary directories for storing log files for shell tests
that could help while debugging. The log files are necessary for
perftool testsuite test cases also. If the variable KEEP_TEST_LOGS
is set keep the logs, else delete them.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/tests/builtin-test.c  | 110 ++++++++++++++++++++++++++++---
 tools/perf/tests/tests-scripts.c |   3 +
 tools/perf/tests/tests-scripts.h |   1 +
 3 files changed, 105 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 585613446d8a3c8d..3458db9c41e370a5 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -5,6 +5,7 @@
  * Builtin regression testing command: ever growing number of sanity tests
  */
 #include <fcntl.h>
+#include <ftw.h>
 #include <errno.h>
 #include <poll.h>
 #include <unistd.h>
@@ -217,6 +218,86 @@ static bool test_exclusive(const struct test_suite *t, int subtest)
 	return t->test_cases[subtest].exclusive;
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
 static bool perf_test__matches(const char *desc, int curr, int argc, const char *argv[])
 {
 	int i;
@@ -548,6 +629,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 
 		for (struct test_suite **t = suites; *t; t++) {
 			int curr = i++;
+			char *tmpdir = NULL;
 
 			if (!perf_test__matches(test_description(*t, -1), curr, argc, argv)) {
 				/*
@@ -572,23 +654,33 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 				continue;
 			}
 
+			/* Setup temporary log directories for shell test suites */
+			if (create_logs(*t, pass)) {
+				tmpdir = setup_shell_logs((*t)->desc);
+
+				if (tmpdir == NULL)  /* Couldn't create log dir, skip test suite */
+					((struct shell_info*)((*t)->priv))->has_setup = FAILED_SETUP;
+			}
+
 			if (!has_subtests(*t)) {
 				err = start_test(*t, curr, -1, &child_tests[child_test_num++],
 						 width, pass);
 				if (err)
 					goto err_out;
-				continue;
 			}
-			for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
-				if (!perf_test__matches(test_description(*t, subi),
-							curr, argc, argv))
-					continue;
+			else {
+				for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
+					if (!perf_test__matches(test_description(*t, subi),
+								curr, argc, argv))
+						continue;
 
-				err = start_test(*t, curr, subi, &child_tests[child_test_num++],
-						 width, pass);
-				if (err)
-					goto err_out;
+					err = start_test(*t, curr, subi, &child_tests[child_test_num++],
+							width, pass);
+					if (err)
+						goto err_out;
+				}
 			}
+			cleanup_shell_logs(tmpdir);
 		}
 		if (!sequential) {
 			/* Parallel mode starts tests but doesn't finish them. Do that now. */
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index 77a6b8d2213e6e74..2dab7324ed05e7e9 100644
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
index da4dcd26140cdfd2..41da0a175e4e7033 100644
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
2.43.0

