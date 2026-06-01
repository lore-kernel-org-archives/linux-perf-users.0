Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CBD1E49F
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272372; cv=none; b=h09pW86EFGSEzcaFsiD5vOJAwIKYEgWpajJ78y+bas5pKg/KAnBaPZgzmeU7HTFaRUH4HWrPmf1Odx5qbRpYKjyLW6n0B8cEFL+F6+RA5SfDMbpef7MVyf69u7hjk/fZmWSuWLDfTCJDOfjRw/e+o42IF4s1NAkPt8Bq97/ggJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272372; c=relaxed/simple;
	bh=ShU0+5NDwIdqu42akgRhdB9yBzW9ywadThyTitrIftg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=htkQeSprpF/bF8aXXYJbR4c9P+Zre5NnheWQAs0YOzY+4aooNOWNQABVoLfJI2HW4AKIrS3JFZqHAhozTCE8p9UUL1zc2Yr1ra35KiA3RhtP+l0WNL1p7WKCR/CK96Az3BowReEDT9+bzraJwQurkvsXbMeBJsINUgxS7EOdYlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NLM8cL9V; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NLM8cL9V"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135de949041so16886874c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 17:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780272370; x=1780877170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2zzXoM3nWPPOJSUE2EQ9zC8AGB7vsbovTQNvCbNm3Y=;
        b=NLM8cL9VryOgWKy9OcCXkL/yn5NJ19TrNoCi4h5biEZfc5JxHwPanpC6GxZY5Rvefq
         SDOTBxNnKmhRj7X0R3cy9uHrL0AbJLWlRxphszjjg75nYXH7zaFz7Y7PEQJQk1Aspj19
         iGTLtQn+XJFKdX8WbAhIb92J7NEXQNwXHGQfx7uywG2bIyImdFIuYpb+kMqbPBZWSFkI
         R3ABy7chcEBudScVahvIZUqX3L6nuBsGNolQM9nTNyblB8SnpjYsLJ7rhpLmwbu5IZo1
         bPL0P6mlFh1UQSeOMjMKzn+gp4ddtKxaRY1HQ6kWt0sJvnLUQEIDSHdwTmnpFBji6Wi7
         xtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780272370; x=1780877170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2zzXoM3nWPPOJSUE2EQ9zC8AGB7vsbovTQNvCbNm3Y=;
        b=AdM5igTcA3XNVTTjXRua4Kut3AiZ3jgPaen4po0lq7LzV4Zpf1aGDzsHbNuFq6b2qP
         zBWDwcDML9leSHxUdzi9fhduMbPwqHMAIHtYuJN2CkX4O4eBPTZVuWVqMBlnS0ISjKpi
         etZ0xYU2J2FnL+IS5HdfyHXVlpW0SnoKoXgHpXda9E6dUbn13XtdQhL4hLaiwkSVG3Tm
         /GRwnEtFG/AsDNX28wltDZ2Mz+Ca+PRuKaNhZwIt7oi36LHKr7YtgVDAjU6v22ezkIR0
         /jmOkWYP2bkp+kTIS1k586dk+1qahJG6z609wDhxJQiEaiY5kzXI9gjDFTJREM+UYTlS
         VOVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9SbHsIBKVhU/Ay3Cd2DARaMTdawqMdw3JsYmyFwwiTn55StQ/zaaXPD5kzTQiTr0iRzkMwYm24Hmi45k8JnAj4@vger.kernel.org
X-Gm-Message-State: AOJu0YwTtpjv853w5wWgojAsPjEeAS6SBbReGJiON8viv7zbTA6HYPJm
	loRllm/lyBxJ4hLUct1SNTeHdz/1XN4HNmZxZMHz8X5MGdsVab2h3a08/cl9Nj5rhchv7tgM51h
	5Bm27kCy0ng==
X-Received: from dlbrh9.prod.google.com ([2002:a05:7022:f309:b0:12a:77b3:9893])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea2c:b0:137:64ad:a62e
 with SMTP id a92af1059eb24-137d4132657mr3143634c88.30.1780272370209; Sun, 31
 May 2026 17:06:10 -0700 (PDT)
Date: Sun, 31 May 2026 17:05:40 -0700
In-Reply-To: <20260601000548.1195604-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531082235.940833-1-irogers@google.com> <20260601000548.1195604-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601000548.1195604-8-irogers@google.com>
Subject: [PATCH 07/15] perf test: Refactor parallel poll loop to drain all
 pipes simultaneously
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When running tests in parallel with verbose output (-v), child processes
write to pipes. If a test produces significant output (e.G. Granite Rapids
metric parsing printing hundreds of lines), it fills the 64KB pipe buffer
and blocks.

Previously, the parent harness (finish_test) only polled the pipe of the
current test waiting to be printed. Other children blocked indefinitely
until the parent reached them, severely sequentializing execution.

Address this by implementing finish_tests_parallel() to poll and drain
output pipes from all running children simultaneously into per-child
buffers. Reaping occurs out of order as children finish, while final
result printing remains strictly in order.

This drops parallel verbose execution time for the PMU events suite from
~35 seconds down to ~5.9 seconds.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 208 +++++++++++++++++++++++++++++++-
 1 file changed, 206 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 2ccb52a776cc..9f71f11928c6 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -302,6 +302,9 @@ struct child_test {
 	struct test_suite *test;
 	int suite_num;
 	int test_case_num;
+	struct strbuf err_output;
+	int result;
+	bool done;
 };
 
 static jmp_buf run_test_jmp_buf;
@@ -356,6 +359,9 @@ static int run_test_child(struct child_process *process)
 
 #define TEST_RUNNING -3
 
+static struct pollfd *global_pfds;
+static size_t *global_pfd_indices;
+
 static int print_test_result(struct test_suite *t, int curr_suite, int curr_test_case,
 			     int result, int width, int running)
 {
@@ -503,12 +509,205 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 		fprintf(stderr, "%s", err_output.buf);
 
 	strbuf_release(&err_output);
+	strbuf_release(&child_test->err_output);
 	print_test_result(t, curr_suite, curr_test_case, ret, width, /*running=*/0);
 	if (err > 0)
 		close(err);
 	zfree(&child_tests[running_test]);
 }
 
+static void drain_child_process_err(struct child_test *child)
+{
+	char buf[512];
+	ssize_t len;
+
+	while ((len = read(child->process.err, buf, sizeof(buf) - 1)) > 0) {
+		buf[len] = '\0';
+		strbuf_addstr(&child->err_output, buf);
+	}
+}
+
+static int finish_tests_parallel(struct child_test **child_tests, size_t num_tests, int width)
+{
+	size_t next_to_print = 0;
+	struct pollfd *pfds;
+	size_t *pfd_indices;
+	size_t num_pfds = 0;
+	int last_running = -1;
+	size_t i;
+	int last_suite_printed = -1;
+
+	global_pfds = calloc(num_tests, sizeof(*pfds));
+	global_pfd_indices = calloc(num_tests, sizeof(*pfd_indices));
+	pfds = global_pfds;
+	pfd_indices = global_pfd_indices;
+	if (!pfds || !pfd_indices) {
+		free(pfds);
+		free(pfd_indices);
+		global_pfds = NULL;
+		global_pfd_indices = NULL;
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_tests; i++) {
+		struct child_test *child = child_tests[i];
+
+		if (!child)
+			continue;
+		strbuf_init(&child->err_output, 0);
+		if (child->process.err > 0)
+			fcntl(child->process.err, F_SETFL, O_NONBLOCK);
+	}
+
+	while (next_to_print < num_tests) {
+		size_t running_count = 0;
+		size_t p;
+
+		while (next_to_print < num_tests &&
+		       (!child_tests[next_to_print] || child_tests[next_to_print]->done))
+			next_to_print++;
+
+		if (next_to_print >= num_tests)
+			break;
+
+		num_pfds = 0;
+
+		for (i = next_to_print; i < num_tests; i++) {
+			struct child_test *child = child_tests[i];
+
+			if (!child || child->done)
+				continue;
+
+			if (!check_if_command_finished(&child->process))
+				running_count++;
+
+			if (child->process.err > 0) {
+				pfds[num_pfds].fd = child->process.err;
+				pfds[num_pfds].events = POLLIN | POLLERR | POLLHUP | POLLNVAL;
+				pfd_indices[num_pfds] = i;
+				num_pfds++;
+			}
+		}
+
+		if (perf_use_color_default && running_count != (size_t)last_running) {
+			struct child_test *next_child = child_tests[next_to_print];
+
+			if (last_running != -1)
+				fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
+
+			if (next_child) {
+				if (test_suite__num_test_cases(next_child->test) > 1 &&
+				    last_suite_printed != next_child->suite_num) {
+					pr_info("%3d: %-*s:\n", next_child->suite_num + 1, width,
+						test_description(next_child->test, -1));
+					last_suite_printed = next_child->suite_num;
+				}
+				print_test_result(next_child->test, next_child->suite_num,
+						  next_child->test_case_num, TEST_RUNNING, width,
+						  running_count);
+			}
+			last_running = running_count;
+		}
+
+		if (num_pfds == 0) {
+			if (running_count > 0)
+				usleep(10 * 1000);
+		} else {
+			int pret = poll(pfds, num_pfds, 100);
+
+			if (pret > 0) {
+				for (p = 0; p < num_pfds; p++) {
+					if (pfds[p].revents) {
+						size_t idx = pfd_indices[p];
+						struct child_test *child = child_tests[idx];
+
+						drain_child_process_err(child);
+						/*
+						 * If the child closed its end of the pipe (EOF) or encountered
+						 * an error, close the file descriptor immediately and set it
+						 * to -1. This removes it from the pfds array for subsequent
+						 * iterations, preventing a tight CPU busy-loop while waiting
+						 * for the process itself to exit.
+						 */
+						if (pfds[p].revents & (POLLHUP | POLLERR | POLLNVAL)) {
+							close(child->process.err);
+							child->process.err = -1;
+						}
+					}
+				}
+			}
+		}
+
+		for (i = next_to_print; i < num_tests; i++) {
+			struct child_test *child = child_tests[i];
+
+			if (!child || child->done)
+				continue;
+
+			if (check_if_command_finished(&child->process)) {
+				if (child->process.err > 0) {
+					drain_child_process_err(child);
+					close(child->process.err);
+					child->process.err = -1;
+				}
+				child->result = finish_command(&child->process);
+				child->done = true;
+			}
+		}
+
+		while (next_to_print < num_tests) {
+			struct child_test *child = child_tests[next_to_print];
+
+			if (!child) {
+				next_to_print++;
+				continue;
+			}
+			if (!child->done)
+				break;
+
+			if (perf_use_color_default && last_running != -1) {
+				fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
+				last_running = -1;
+			}
+
+			if (test_suite__num_test_cases(child->test) > 1 &&
+			    last_suite_printed != child->suite_num) {
+				pr_info("%3d: %-*s:\n", child->suite_num + 1, width,
+					test_description(child->test, -1));
+				last_suite_printed = child->suite_num;
+			}
+
+			if (verbose > 1) {
+				if (test_suite__num_test_cases(child->test) > 1) {
+					pr_info("%3d.%1d: %s:\n", child->suite_num + 1,
+						child->test_case_num + 1,
+						test_description(child->test,
+								 child->test_case_num));
+				} else {
+					pr_info("%3d: %s:\n", child->suite_num + 1,
+						test_description(child->test, -1));
+				}
+			}
+
+			if (verbose > 1 || (verbose == 1 && child->result == TEST_FAIL))
+				fprintf(stderr, "%s", child->err_output.buf);
+
+			print_test_result(child->test, child->suite_num, child->test_case_num,
+					  child->result, width, 0);
+			strbuf_release(&child->err_output);
+			child_tests[next_to_print] = NULL;
+			zfree(&child);
+			next_to_print++;
+		}
+	}
+
+	free(global_pfds);
+	free(global_pfd_indices);
+	global_pfds = NULL;
+	global_pfd_indices = NULL;
+	return 0;
+}
+
 static int start_test(struct test_suite *test, int curr_suite, int curr_test_case,
 		struct child_test **child, int width, int pass)
 {
@@ -671,8 +870,9 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 		}
 		if (!sequential) {
 			/* Parallel mode starts tests but doesn't finish them. Do that now. */
-			for (size_t x = 0; x < num_tests; x++)
-				finish_test(child_tests, x, num_tests, width);
+			err = finish_tests_parallel(child_tests, num_tests, width);
+			if (err)
+				goto err_out;
 		}
 	}
 err_out:
@@ -683,6 +883,10 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 		for (size_t x = 0; x < num_tests; x++)
 			finish_test(child_tests, x, num_tests, width);
 	}
+	free(global_pfds);
+	free(global_pfd_indices);
+	global_pfds = NULL;
+	global_pfd_indices = NULL;
 	free(child_tests);
 	return err;
 }
-- 
2.54.0.823.g6e5bcc1fc9-goog

