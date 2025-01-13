Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388951C2DA2
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736792824; cv=none; b=Kzj+3z+yIOoxdvMjicNjnyft8+IonMz5hRtYflbsGSsdRpiR/u3H7cEMAY327FLmXKveO1lI/ad9l0+g8V6Z2/hhmU2rBenelVD1XO7xxIpsCgEZzQI94k34MYVdd/y3HaC1ifbNzacdExIkTUO217LCVhDvelGUqbNNm2pZ64M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736792824; c=relaxed/simple;
	bh=XK4W/sFwEU+X/oXYiZqvbQmjY7DSpIvNczRuiKnhZZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwjWHOqm5s47YfhuvAqdPvwnkxusQSl41YCanGhWYWZrDYIQyZQeVQrNeIPVzif6vvs4QMT3EcJQtO/NeoOGyciWn/XYqZEwvmKQXgGdUfTwClfMLPha9SMJcYmRCc+KQJRHwwjwuVvPVvEUwX3kRZf+cP6AyI0+lxATU2aOrEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUQGq+su; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUQGq+su"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736792822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8N/S0XJ7kKYo28KpXK4Fc7WAS6Tw/Klck0P07924b0=;
	b=QUQGq+surwPS9ZGxLuyMj5G6E0p6jEBg1nSPHIiRRgIJdhz4gVAaY2vGqg0wU7QMTs2lj4
	IT6QQsnx9xGsNBu24YP9SMMIT7PaQUEtZEJF5g5W3ok0SUEGoTBXB1e36CYnF+Cqb/kJAf
	SNxNe8hyKcPNO7/VODMUcszP4iyRsj4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-aF8ZEvTxPmS-6F592IzZnQ-1; Mon,
 13 Jan 2025 13:26:59 -0500
X-MC-Unique: aF8ZEvTxPmS-6F592IzZnQ-1
X-Mimecast-MFC-AGG-ID: aF8ZEvTxPmS-6F592IzZnQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 057D91955D82;
	Mon, 13 Jan 2025 18:26:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.147])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1B1519560AD;
	Mon, 13 Jan 2025 18:26:55 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	mpetlan@redhat.com,
	namhyung@kernel.org
Cc: irogers@google.com
Subject: [PATCH v2 08/10] perf test: Introduce storing logs for shell tests
Date: Mon, 13 Jan 2025 19:26:03 +0100
Message-ID: <20250113182605.130719-9-vmolnaro@redhat.com>
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
index 4a4dc86ebcf60d0d..d9c1453051e5c99c 100644
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
@@ -216,6 +217,86 @@ static bool test_exclusive(const struct test_suite *t, int subtest)
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
@@ -547,6 +628,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 
 		for (struct test_suite **t = suites; *t; t++) {
 			int curr = i++;
+			char *tmpdir = NULL;
 
 			if (!perf_test__matches(test_description(*t, -1), curr, argc, argv)) {
 				/*
@@ -571,23 +653,33 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
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
index fa8f18cbcd2ae2bc..91ef0b47d2a8425c 100644
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

