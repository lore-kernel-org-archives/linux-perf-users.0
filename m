Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158451850B5
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 05:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230455; cv=none; b=fJykMTctyZTIlVxLZp62Ax+PlQkGMUhaiKJxDTVWnkM+vk/8x64D3BOy3Rt6yJ+HOiTFWAb78Cpc9SkU3/Xn9MiSXnfH2gRaKVdwMULC0Doy9oesDVen6LrrJ+IX0rG+mxPUjInl5sSoni9EhUh9HcoM7n+jD2pHVOJKa3ao3L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230455; c=relaxed/simple;
	bh=fFas7LyqSjmG5V26rD2/CFaF2XrJIT7gW3QIZSxUtUU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SiGOiYDQ88d1eGZD1xvWXKriZo4/yQnViVT8iRnoQMjsdksef7UlVjIv45xRm9cBjQVsQhkCKBzlqwdrbfrAghMbmovKelkw0OVr7jOdhPPcDNZGiflAohB4oYqwr1l7i/vne6WMSEQxatxJms168UFpOTfTpmSv2pifuPzuyTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iz/SkRpt; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iz/SkRpt"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-690404fd230so36751677b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 22:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729230453; x=1729835253; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7H4716CUp7wRIu/vgNl/76x7htTbrKtb+Q2pljLbUoA=;
        b=Iz/SkRpt+y9leMN/kflJf+5cBQd0solzwWHd6EnoR8YWI2s6EB8kkd8CXD9dwj7Ty1
         KKMMGPDMp9k7SKXk5iHduGU0OjQVUhUDTzP7OihpVEvTUk4Ik60ooKWDvZJBx9By4mfC
         9++J/LA2IJRVQPqPsrhObDI4xNH7ICTsoNobtjl0SBVSiVnmHoF5iQJbFlCTkGN8ZnXO
         5YgNubzyqoWIhxMVvKRiLI7+GitZq2FMHjdKluvF7XBWN3wUWuET8pLuIsRnxJPfq7Vf
         1ipKv31w+Zbkqf7OwUl77oxonjGLGiD9L4XNtL7vBorZkOlnYDz+PKo4dsyTuepQVLVC
         7NHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230453; x=1729835253;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7H4716CUp7wRIu/vgNl/76x7htTbrKtb+Q2pljLbUoA=;
        b=TAmRkyrhwithSkfoRsn9SnjJSei6fImz1wWqrYCtzzss6VfCK5VyJY9yt5a8Q+SCai
         NmKr4G5paXu+cOpXKixVIds4qJaBp7sJIYPP0u/bB1JDfwg7GczccX/9QwlepJuNYP6c
         Wq1JUxK5FxvVkdkhY71qhsHdtfXuhODaonmlzkyH6OrZLuUVhDChzNnKU2IwAhZRxKUM
         I9L4iB8BhyIxmL7rwImQK3rabQM9rDKRsZKnt2aARE+9XwbCZCxl6XTj5HqsCyNEpy1X
         zylWR0RsZrtJHl/KClrx/fLX01MGSS7xvj9bLcIcY8aUgrECDenGFfdqPWUvOVDmA1C/
         saNw==
X-Forwarded-Encrypted: i=1; AJvYcCXxGaC9KFzqeJQhGkAJEJpfD1nXH0FWuM22zWxu5+yu52D02qNnXdDsT7TVY8h6/D5PsKiZ8hNvVkuQFSfa+JNx@vger.kernel.org
X-Gm-Message-State: AOJu0Yykob4wDhK2TOdQ/fEBgv75KARy2hJubmlcKzNpXvGGuaNnW6FU
	UbTXSGsFnyxPmwF0uUGktueshBlhtG9xCe2mXZ1NmS/q/W46HmpANnCiyvrthDaZhtlIRkF1HVP
	2RqVXoA==
X-Google-Smtp-Source: AGHT+IHrNwGQ65miZ1DrqGdwnyD++/1tfu2IOs+mARqDoQe1p6KCckIDzEp1Tmy2Msvr1EzURm1awJvJOTxP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:30c5:9d92:bcd:7977])
 (user=irogers job=sendgmr) by 2002:a05:690c:618a:b0:6e2:1713:bdb5 with SMTP
 id 00721157ae682-6e5bfd20ea6mr90897b3.5.1729230452936; Thu, 17 Oct 2024
 22:47:32 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:47:12 -0700
In-Reply-To: <20241018054719.1004128-1-irogers@google.com>
Message-Id: <20241018054719.1004128-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241018054719.1004128-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 2/9] perf test: Display number of active running tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Before polling or sleeping to wait for a test to complete, print out
": Running (<num> active)" where the number of active tests is
determined by iterating over the tests and seeing which return false
for check_if_command_finished. The line erasing and printing out only
occur if the number of runnings tests changes to avoid the line
flickering excessively. Knowing tests are running allows a user to
know a test is running and in parallel mode how many of the tests are
waiting to complete. If color mode is disabled then avoid displaying
the "Running" message as deleting the line isn't reliable.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 93 ++++++++++++++++++++++-----------
 tools/perf/util/color.h         |  1 +
 2 files changed, 63 insertions(+), 31 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 3b30f258c395..381363fc766a 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -243,7 +243,10 @@ static int run_test_child(struct child_process *process)
 	return -err;
 }
 
-static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width)
+#define TEST_RUNNING -3
+
+static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width,
+			     int running)
 {
 	if (has_subtests(t)) {
 		int subw = width > 2 ? width - 2 : width;
@@ -253,6 +256,9 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
 		pr_info("%3d: %-*s:", i + 1, width, test_description(t, subtest));
 
 	switch (result) {
+	case TEST_RUNNING:
+		color_fprintf(stderr, PERF_COLOR_YELLOW, " Running (%d active)\n", running);
+		break;
 	case TEST_OK:
 		pr_info(" Ok\n");
 		break;
@@ -274,14 +280,17 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
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
+	int last_running = -1;
 	int ret;
 
 	/*
@@ -295,7 +304,7 @@ static int finish_test(struct child_test *child_test, int width)
 	 * Busy loop reading from the child's stdout/stderr that are set to be
 	 * non-blocking until EOF.
 	 */
-	if (!err_done)
+	if (err > 0)
 		fcntl(err, F_SETFL, O_NONBLOCK);
 	if (verbose > 1) {
 		if (has_subtests(t))
@@ -309,38 +318,60 @@ static int finish_test(struct child_test *child_test, int width)
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
+			int running = 0;
+
+			for (int y = running_test; y < child_test_num; y++) {
+				if (check_if_command_finished(&child_tests[y]->process) == 0)
+					running++;
+			}
+			if (running != last_running) {
+				if (last_running != -1) {
+					/*
+					 * Erase "Running (.. active)" line
+					 * printed before poll/sleep.
+					 */
+					fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
+				}
+				print_test_result(t, i, subi, TEST_RUNNING, width, running);
+				last_running = running;
+			}
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
+	}
+	if (perf_use_color_default && last_running != -1) {
+		/* Erase "Running (.. active)" line printed before poll/sleep. */
+		fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
 	}
 	/* Clean up child process. */
 	ret = finish_command(&child_test->process);
-	if (verbose == 1 && ret == TEST_FAIL) {
-		/* Add header for test that was skipped above. */
-		if (has_subtests(t))
-			pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_description(t, subi));
-		else
-			pr_info("%3d: %s:\n", i + 1, test_description(t, -1));
+	if (verbose > 1 || (verbose == 1 && ret == TEST_FAIL))
 		fprintf(stderr, "%s", err_output.buf);
-	}
+
 	strbuf_release(&err_output);
-	print_test_result(t, i, subi, ret, width);
+	print_test_result(t, i, subi, ret, width, /*running=*/0);
 	if (err > 0)
 		close(err);
 	return 0;
@@ -356,7 +387,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 		pr_debug("--- start ---\n");
 		err = test_function(test, subi)(test, subi);
 		pr_debug("---- end ----\n");
-		print_test_result(test, i, subi, err, width);
+		print_test_result(test, i, subi, err, width, /*running=*/0);
 		return 0;
 	}
 
@@ -381,7 +412,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 	err = start_command(&(*child)->process);
 	if (err || !sequential)
 		return  err;
-	return finish_test(*child, width);
+	return finish_test(child, /*running_test=*/0, /*child_test_num=*/1, width);
 }
 
 #define for_each_test(j, k, t)					\
@@ -466,7 +497,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 	}
 	for (i = 0; i < child_test_num; i++) {
 		if (!sequential) {
-			int ret  = finish_test(child_tests[i], width);
+			int ret  = finish_test(child_tests, i, child_test_num, width);
 
 			if (ret)
 				return ret;
diff --git a/tools/perf/util/color.h b/tools/perf/util/color.h
index aecf56dae73f..dfc897a6fa20 100644
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
2.47.0.105.g07ac214952-goog

