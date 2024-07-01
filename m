Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0984344C81
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jul 2024 04:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719808967; cv=none; b=tKK35IKkGCuifbWvudoGL79h6fxvPRrwhjB41CDseU1I9mC0NQP8rJ9JmCHsyhCycdRtBNXfggTtzx7wbWHi79xh/LJZfbUbgQBwT0Os6amMHEYn0soQp8jiy5qoRsI3utg4cASUXxgkI6vGaXO+y5COGhppnNa2gj4SzVleYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719808967; c=relaxed/simple;
	bh=E1yTNX0dXLqWoEgNrMX++wv2NEf2cNCY9AWmz0zGb1c=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qSO5VaDVN++ibThSYlQ2VCEW7l2ItPjKvlmGG243gCErwF7ZeQUtrIWq8djAv5KPJI27z/Lk0rJ0BVrnShY912ckXmvxpRlBV+Fi+nCpxz/gCW64+am6pKNzEyazZ0k3WgwqmaxCivu8qjk60anPerGKKJsGM3lyOOyvi4ukDn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JYbkvPCT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYbkvPCT"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-721d20a0807so2394859a12.1
        for <linux-perf-users@vger.kernel.org>; Sun, 30 Jun 2024 21:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719808964; x=1720413764; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpc0+W6wY0DZse4YqiD5xoHyNTb+DGq1jJFsO9RewJY=;
        b=JYbkvPCTS25KAdGLH7pVkhPjjAlkzYr+WpMIU9qPHMnUhZ4ICf12TFmz0lWmmAuLqH
         kGkZh3KAU6VKrNel271GmhsdxKdNHLYGMT5cI5smfbwfNBJjbUXHgQB1dPArvXSRMBZu
         r6L7hltK7lQWwtJH0Y3yeI6tOfzVfCUFaYq9SKYRqqT3XpHd4GvPLrCTmf+KZmoDQQR3
         stc/BE6tM4gEeQRzzxkAIUglRjy6NzARTQZ9jesrmI8gf7wq4M49hITNfU+ZQbUb1vS3
         axaTgVtBWfvupEAO1OaCI1HChUq/6h2wXWgOW51Spl/iKd2p+amudR5hQdmqRPr/OLMJ
         Mv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719808964; x=1720413764;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpc0+W6wY0DZse4YqiD5xoHyNTb+DGq1jJFsO9RewJY=;
        b=K0UOF1oqCfCRXQhI5aSz+ArI9MQIBVDULcdj1cYvJAHWffqUWD0h5sNIydxG/NDLlL
         1/lrrJP4yWCbO0vJdSzx4slL258H1UngAi645kme9mGpTBELWAB1Jg/c2PotYaGOd1gX
         jKDlY5PEaCntM1c23Javh3xthPKAyMnvR3G8xNaUVjAsTdJaIo8G8Ln/O93pErpD50ib
         4SDcCWHKyL2CiHMLKNgZUNONV3+a9D+Tn9NZcAZX/Iw52F+elOC4bj2IVAIS2FuhhAKX
         COeTSRQB8AOznGw4zRGP1NDCL/U7znj6BHQfnaBqEH2GmdNAlajDKuIU2PATJKJMGIMd
         Thlw==
X-Forwarded-Encrypted: i=1; AJvYcCVVbPhCHhwzV6qcrRsPY8RpT73roJT9Yi6yHW/TrDRarU3rKBB44vL0EDpOxVA33dPskidkU8rfO5tNUaY4NWF900nk5QWcw3A3++mYvMnPEQ==
X-Gm-Message-State: AOJu0YzaKaAcMEjDfnjOTQYhtIIgJSTLhEsVxSKV5YSuinvxluoW26Yi
	Q2cpkci2LlNk/FVtcwxnxIK1+Cd9svGHCelGlDqVwHFX4LpYpmr9O4GD0uOqmr0kBY0hYA2CA7+
	KQYo2JA==
X-Google-Smtp-Source: AGHT+IGw+TlXIzVyrzKmNehwKL4ocMvf8JKml3ao1L9vvx3M6JYQQgnsvntxw6Ya/r18frr7R0Xwpt5wJqkL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7bcd:6ae9:263e:82ff])
 (user=irogers job=sendgmr) by 2002:a63:2b48:0:b0:6bc:b210:c1dd with SMTP id
 41be03b00d2f7-73cfd125c80mr17613a12.8.1719808964338; Sun, 30 Jun 2024
 21:42:44 -0700 (PDT)
Date: Sun, 30 Jun 2024 21:42:36 -0700
In-Reply-To: <20240701044236.475098-1-irogers@google.com>
Message-Id: <20240701044236.475098-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240701044236.475098-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v2 2/2] perf test: Display number of remaining tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Before polling or sleeping to wait for a test to complete, print out
": Running (<num> remaining)" where the number of remaining tests is
determined by iterating over the remaining tests and seeing which
return true for check_if_command_finished. After the delay, erase the
line and either update it with the new number of remaining tests, or
print the test's result. This allows a user to know a test is running
and in parallel mode (default) how many of the tests are waiting to
complete. If color mode is disabled then avoid displaying the
"Running" message.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 77 ++++++++++++++++++++++-----------
 tools/perf/util/color.h         |  1 +
 2 files changed, 53 insertions(+), 25 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c3d84b67ca8e..23be9139f229 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -241,7 +241,10 @@ static int run_test_child(struct child_process *process)
 	return -err;
 }
 
-static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width)
+#define TEST_RUNNING -3
+
+static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width,
+			     int remaining)
 {
 	if (has_subtests(t)) {
 		int subw = width > 2 ? width - 2 : width;
@@ -251,6 +254,9 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
 		pr_info("%3d: %-*s:", i + 1, width, test_description(t, subtest));
 
 	switch (result) {
+	case TEST_RUNNING:
+		color_fprintf(stderr, PERF_COLOR_YELLOW, " Running (%d remaining)\n", remaining);
+		break;
 	case TEST_OK:
 		pr_info(" Ok\n");
 		break;
@@ -272,13 +278,15 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
 	return 0;
 }
 
-static int finish_test(struct child_test *child_test, int width)
+static int finish_test(struct child_test **child_tests, int running_test, int child_test_num,
+		       int width)
 {
+	struct child_test *child_test = child_tests[running_test];
 	struct test_suite *t = child_test->test;
 	int i = child_test->test_num;
 	int subi = child_test->subtest;
 	int err = child_test->process.err;
-	bool err_done = err <= 0;
+	bool err_done = false;
 	struct strbuf err_output = STRBUF_INIT;
 	int ret;
 
@@ -293,7 +301,7 @@ static int finish_test(struct child_test *child_test, int width)
 	 * Busy loop reading from the child's stdout/stderr that are set to be
 	 * non-blocking until EOF.
 	 */
-	if (!err_done)
+	if (err > 0)
 		fcntl(err, F_SETFL, O_NONBLOCK);
 	if (verbose > 1) {
 		if (has_subtests(t))
@@ -307,29 +315,48 @@ static int finish_test(struct child_test *child_test, int width)
 			  .events = POLLIN | POLLERR | POLLHUP | POLLNVAL,
 			},
 		};
-		char buf[512];
-		ssize_t len;
-
-		/* Poll to avoid excessive spinning, timeout set for 100ms. */
-		poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/100);
-		if (!err_done && pfds[0].revents) {
-			errno = 0;
-			len = read(err, buf, sizeof(buf) - 1);
-
-			if (len <= 0) {
-				err_done = errno != EAGAIN;
-			} else {
-				buf[len] = '\0';
-				if (verbose > 1)
-					fprintf(stdout, "%s", buf);
-				else
+		if (perf_use_color_default) {
+			int tests_in_progress = running_test;
+
+			for (int y = running_test; y < child_test_num; y++) {
+				if (check_if_command_finished(&child_tests[y]->process))
+					tests_in_progress++;
+			}
+			print_test_result(t, i, subi, TEST_RUNNING, width,
+					  child_test_num - tests_in_progress);
+		}
+
+		err_done = true;
+		if (err <= 0) {
+			/* No child stderr to poll, sleep for 10ms for child to complete. */
+			usleep(10 * 1000);
+		} else {
+			/* Poll to avoid excessive spinning, timeout set for 100ms. */
+			poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/100);
+			if (pfds[0].revents) {
+				char buf[512];
+				ssize_t len;
+
+				len = read(err, buf, sizeof(buf) - 1);
+
+				if (len > 0) {
+					err_done = false;
+					buf[len] = '\0';
 					strbuf_addstr(&err_output, buf);
+				}
 			}
 		}
+		if (err_done)
+			err_done = check_if_command_finished(&child_test->process);
+
+		if (perf_use_color_default) {
+			/* Erase "Running (.. remaining)" line printed before poll/sleep. */
+			fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
+		}
 	}
 	/* Clean up child process. */
 	ret = finish_command(&child_test->process);
-	if (verbose == 1 && ret == TEST_FAIL) {
+	if (verbose > 1 || (verbose == 1 && ret == TEST_FAIL)) {
 		/* Add header for test that was skipped above. */
 		if (has_subtests(t))
 			pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_description(t, subi));
@@ -338,7 +365,7 @@ static int finish_test(struct child_test *child_test, int width)
 		fprintf(stderr, "%s", err_output.buf);
 	}
 	strbuf_release(&err_output);
-	print_test_result(t, i, subi, ret, width);
+	print_test_result(t, i, subi, ret, width, /*remaining=*/0);
 	if (err > 0)
 		close(err);
 	return 0;
@@ -354,7 +381,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 		pr_debug("--- start ---\n");
 		err = test_function(test, subi)(test, subi);
 		pr_debug("---- end ----\n");
-		print_test_result(test, i, subi, err, width);
+		print_test_result(test, i, subi, err, width, /*remaining=*/0);
 		return 0;
 	}
 
@@ -379,7 +406,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 	err = start_command(&(*child)->process);
 	if (err || !sequential)
 		return  err;
-	return finish_test(*child, width);
+	return finish_test(child, /*running_test=*/0, /*child_test_num=*/1, width);
 }
 
 #define for_each_test(j, k, t)					\
@@ -464,7 +491,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 	}
 	for (i = 0; i < child_test_num; i++) {
 		if (!sequential) {
-			int ret  = finish_test(child_tests[i], width);
+			int ret  = finish_test(child_tests, i, child_test_num, width);
 
 			if (ret)
 				return ret;
diff --git a/tools/perf/util/color.h b/tools/perf/util/color.h
index 01f7bed21c9b..4b9f8d5d4439 100644
--- a/tools/perf/util/color.h
+++ b/tools/perf/util/color.h
@@ -22,6 +22,7 @@
 #define MIN_GREEN	0.5
 #define MIN_RED		5.0
 
+#define PERF_COLOR_DELETE_LINE	"\033[A\33[2K\r"
 /*
  * This variable stores the value of color.ui
  */
-- 
2.45.2.803.g4e1b14247a-goog

