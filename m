Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C7586255;
	Fri, 28 Jun 2024 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611872; cv=none; b=eDNtH+tz1TzGiYE7iz87LQUYVD2kqBfgzaW/5y4sRn3lQfFyCDC9BbVrsItkhDAl+OYYdrc3GxKP06/nZ3DtUH2k6byfDNls02guVU2KEww89Xsvfz0OR/tnJdyXFl6Q/TzkYTh0O4ZUF3MGuHoO3vVcYLdhIl5/XPQmTu55cUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611872; c=relaxed/simple;
	bh=sQWoZdouFGgGJyVce9TZ9u7xhn+//WZ7qPNM/DbfT7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f4V34B7h/Vnd5PXd4FLxL/jBKret2bx+suXffT7ZV+Gp7f+gBsLGiuRL3WGDW3JSrL5vyiWq5uJzN/z0jtQB3BQTBRhuAw0Wi5QKP7w0H08jjTGmaXQgp3KDtC0M42/HxZ81QkwgTBBZIUqpouZTRI9YPVRdO/wmMXXAI4p1bP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQvg/Poq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQvg/Poq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0388C116B1;
	Fri, 28 Jun 2024 21:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719611872;
	bh=sQWoZdouFGgGJyVce9TZ9u7xhn+//WZ7qPNM/DbfT7k=;
	h=From:To:Cc:Subject:Date:From;
	b=lQvg/PoqKno9nlrZcVlQuJ7OxCWobD1L2IVCayBjtKJ0ebQ5JSBrEGimqX7MLDwcE
	 CajgwHC3v8iL6ff0vW9UqvtBcFFWc/R9oTI2NqRaOEtGRfkREHazsxCrokMbGmAzFa
	 LZg3g7XIUcku/+6YJgXoZb4ssanHq8HbNzOEyycmsDgbb4sRvGQeTxiP25rPQuTqxe
	 j1uDJsbZSwfhTnDwmtI70BYT3afBAh2z3CPr+Px5nQQGSKlVsSVs39Zooydm4KKzBs
	 U1ZQ2vpt3BcUfhQWXfClpGMXcfOxIME65aNQpeeyiVHUMsRdSpCKS1XRxgV285S/b1
	 nWlJK0dzyADpw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf test: Print test description first
Date: Fri, 28 Jun 2024 14:57:50 -0700
Message-ID: <20240628215751.1512250-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently perf test prints the description of the test when it finishes
to run the test.  But sometimes it runs long and users want to see which
test it is running.  Change it to print the info in start_test() so that
we can see it right after the test.

No functional changes intended.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/builtin-test.c | 54 ++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c3d84b67ca8e..33defd3b7185 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -243,12 +243,17 @@ static int run_test_child(struct child_process *process)
 
 static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width)
 {
-	if (has_subtests(t)) {
-		int subw = width > 2 ? width - 2 : width;
+	/* If it printed other messages, print the header again. */
+	if (verbose > 1 || (verbose == 1 && result == TEST_FAIL)) {
+		if (has_subtests(t)) {
+			int subw = width > 2 ? width - 2 : width;
 
-		pr_info("%3d.%1d: %-*s:", i + 1, subtest + 1, subw, test_description(t, subtest));
-	} else
-		pr_info("%3d: %-*s:", i + 1, width, test_description(t, subtest));
+			pr_info("%3d.%1d: %-*s:", i + 1, subtest + 1, subw,
+				test_description(t, subtest));
+		} else {
+			pr_info("%3d: %-*s:", i + 1, width, test_description(t, -1));
+		}
+	}
 
 	switch (result) {
 	case TEST_OK:
@@ -282,25 +287,12 @@ static int finish_test(struct child_test *child_test, int width)
 	struct strbuf err_output = STRBUF_INIT;
 	int ret;
 
-	/*
-	 * For test suites with subtests, display the suite name ahead of the
-	 * sub test names.
-	 */
-	if (has_subtests(t) && subi == 0)
-		pr_info("%3d: %-*s:\n", i + 1, width, test_description(t, -1));
-
 	/*
 	 * Busy loop reading from the child's stdout/stderr that are set to be
 	 * non-blocking until EOF.
 	 */
 	if (!err_done)
 		fcntl(err, F_SETFL, O_NONBLOCK);
-	if (verbose > 1) {
-		if (has_subtests(t))
-			pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_description(t, subi));
-		else
-			pr_info("%3d: %s:\n", i + 1, test_description(t, -1));
-	}
 	while (!err_done) {
 		struct pollfd pfds[1] = {
 			{ .fd = err,
@@ -330,12 +322,8 @@ static int finish_test(struct child_test *child_test, int width)
 	/* Clean up child process. */
 	ret = finish_command(&child_test->process);
 	if (verbose == 1 && ret == TEST_FAIL) {
-		/* Add header for test that was skipped above. */
-		if (has_subtests(t))
-			pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_description(t, subi));
-		else
-			pr_info("%3d: %s:\n", i + 1, test_description(t, -1));
-		fprintf(stderr, "%s", err_output.buf);
+		/* It printed the header first, print messages in a new line */
+		fprintf(stderr, "\n%s", err_output.buf);
 	}
 	strbuf_release(&err_output);
 	print_test_result(t, i, subi, ret, width);
@@ -376,6 +364,24 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 		(*child)->process.err = -1;
 	}
 	(*child)->process.no_exec_cmd = run_test_child;
+
+	if (has_subtests(test)) {
+		int subw = width > 2 ? width - 2 : width;
+
+		/*
+		 * For test suites with subtests, display the suite name ahead of the
+		 * sub test names.
+		 */
+		if (has_subtests(test) && subi == 0)
+			pr_info("%3d: %-*s:\n", i + 1, width, test_description(test, -1));
+
+		pr_info("%3d.%1d: %-*s:", i + 1, subi + 1, subw, test_description(test, subi));
+	} else
+		pr_info("%3d: %-*s:", i + 1, width, test_description(test, -1));
+
+	if (verbose > 1)
+		pr_info("\n");
+
 	err = start_command(&(*child)->process);
 	if (err || !sequential)
 		return  err;
-- 
2.45.2.803.g4e1b14247a-goog

