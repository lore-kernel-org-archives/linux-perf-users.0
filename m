Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2A13ADB99
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385520; cv=none; b=ibF+SOLTsbIw6rQJDXAZZ88m5LmzE6mqqUF6nPQW6mIt9Nw4ej1gG0ZDyz0T/lBh6Hsa0++3R3vuLGa/onAKQub8daOLzxDNJpges9XiNFrPTfnnruomsAcVlG8yWlyBe54d2UYT8eHX3XfjXftSr3XBenOk2RgARviymDRhH/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385520; c=relaxed/simple;
	bh=4OF4CoTID6RNso9R76NGGFryDxCJQuD42DBxRoyx3vM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Aop0m50fQK+9BZUFCUfourzA4qzByXbn3GqNITeiHmferbzruGqDY8fVIe5Gkv9qaZpLokcR3MeSrxhcQk0WkiGyRZ7vCgAIDZczvLFVI7bLBuDkCtQ9Q66E5PZI1yB7hz3tc8TRkV+D9jPehn6HhZdS7CN9ShziOeBp7Hsn5mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MOVCwLSw; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOVCwLSw"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137dd5100c7so3689741c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 00:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780385516; x=1780990316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzzt1hK/sF2nYHHamiQNl90dUvzbnZsDg6tX+vvjQQk=;
        b=MOVCwLSw3QSf3YfYrgrbaqfnsU237U+ZxUJJVk9s9JuVmJ3FErCV/mq8Gsh+kx988G
         6ZM2NkOqWRJzrrowxBl7Fzz4pXHXLaTcw1NKIyDMj2TQa9hwjJbaSVmkpyqy5B9F2s0e
         yPsKFnUQX5hFfrrxmpRjDLlLHlKCdpI5LnBh+JKb5UjigZS7jPsaICwAu3Ce30GdKnKp
         NcCmk5EasLWYJjobDdVr89iyWkfVPLFD8R4kD4kxvw+8aOxwiXlpanbX/a8jz/RJ7CKR
         QVE9JZKAQTUSvhe1+BoH9qvAIHpjFidM2gz6WhcnmSIK70A5ahDzk5wMTE8VdX96beeA
         zwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780385516; x=1780990316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzzt1hK/sF2nYHHamiQNl90dUvzbnZsDg6tX+vvjQQk=;
        b=NFUaIrs9p/zIoe2BO2BnK6MCg7UTt8s9s9AoHuJLh7PySj70w7xBcxbLKmQQ3dbv7T
         HywPebM3UML7PdvyJrIK06wE3P/+U1/uLoz2nG2dXRTDhb9qHmSSR6FaDzTg8pnoePXz
         K+72U26e7A+/vwxgvD4o4oydthJtqVRilwjYUobEsV/K6pJkfTVDJopyEmhOXgmdo/g1
         uBcQsTTn+GrWqCeWZkxZSUZWHZiRx9kkPhWkrRO2Wi1c+4eGSFKOea1h3EKIeKTmAm6i
         Osk1oazWe5V7K2a6apVT7ib81WatnXrEK2BDK626CmPk7Hes/VC5rdDNcjXfOJMTt5e+
         cyLA==
X-Forwarded-Encrypted: i=1; AFNElJ+cumqMlVh76ul+lHX4AjHaT023YHgRoOMvim4/ykkrOn35D6oEUKgQuEzKyB3r8S8CIO+UAgAYJfpVENb7sKOS@vger.kernel.org
X-Gm-Message-State: AOJu0YwXTnu/VKOxRqdB1UNQJDGF6/Rv/vZVt+MbUl0cCdjR0psKp6Wb
	lndgcHXxkZybT3t5s7y2URkRAwqD7p5AkNqRGvmFGue1U7c/Ynxw2LqTich9kLPpYLYbLrXOzqa
	6/wyyvIaWnQ==
X-Received: from dlea3-n2.prod.google.com ([2002:a05:701b:4203:20b0:135:dd6a:be57])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:41a0:b0:137:ec47:8ff0
 with SMTP id a92af1059eb24-137ec479cefmr2004734c88.40.1780385515469; Tue, 02
 Jun 2026 00:31:55 -0700 (PDT)
Date: Tue,  2 Jun 2026 00:31:23 -0700
In-Reply-To: <20260602073132.2653307-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601061401.1541457-1-irogers@google.com> <20260602073132.2653307-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602073132.2653307-9-irogers@google.com>
Subject: [PATCH v7] perf test: Refactor parallel poll loop to drain all pipes simultaneously
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When running tests in parallel with verbose output (-v), child processes
write to pipes. If a test produces significant output (e.G. Granite
Rapids metric parsing printing hundreds of lines), it fills the 64KB
pipe buffer and blocks.

Previously, the parent harness (finish_test) only polled the pipe of the
current test waiting to be printed. Other children blocked indefinitely
until the parent reached them, severely sequentializing execution.

Address this by implementing finish_tests_parallel() to poll and drain
output pipes from all running children simultaneously into per-child
buffers, employing safe strbuf_addstr string operations alongside
thorough variable orderings for strict ISO C90 compliance. Reaping
occurs out of order as children finish, while final result printing
remains strictly in order.

This drops parallel verbose execution time for the PMU events suite from
~35 seconds down to ~5.9 seconds.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 242 +++++++++++++++++++++++++++++++-
 1 file changed, 240 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 2ccb52a776cc..0b33bc74826c 100644
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
@@ -356,6 +359,11 @@ static int run_test_child(struct child_process *process)
 
 #define TEST_RUNNING -3
 
+static struct pollfd *global_pfds;
+static size_t *global_pfd_indices;
+
+static int strbuf_addstr_safe(struct strbuf *sb, const char *s);
+
 static int print_test_result(struct test_suite *t, int curr_suite, int curr_test_case,
 			     int result, int width, int running)
 {
@@ -499,16 +507,241 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	}
 	/* Clean up child process. */
 	ret = finish_command(&child_test->process);
+	child_test->process.pid = 0;
+	if (child_test->err_output.len > 0) {
+		struct strbuf merged = STRBUF_INIT;
+
+		if (child_test->err_output.buf)
+			strbuf_addstr_safe(&merged, child_test->err_output.buf);
+		if (err_output.buf)
+			strbuf_addstr_safe(&merged, err_output.buf);
+		strbuf_release(&err_output);
+		err_output = merged;
+	}
 	if (verbose > 1 || (verbose == 1 && ret == TEST_FAIL))
 		fprintf(stderr, "%s", err_output.buf);
 
 	strbuf_release(&err_output);
+	strbuf_release(&child_test->err_output);
 	print_test_result(t, curr_suite, curr_test_case, ret, width, /*running=*/0);
 	if (err > 0)
 		close(err);
 	zfree(&child_tests[running_test]);
 }
 
+static int strbuf_addstr_safe(struct strbuf *sb, const char *s)
+{
+	sigset_t set, oldset;
+	int ret;
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGINT);
+	sigaddset(&set, SIGTERM);
+	sigprocmask(SIG_BLOCK, &set, &oldset);
+	ret = strbuf_addstr(sb, s);
+	sigprocmask(SIG_SETMASK, &oldset, NULL);
+	return ret;
+}
+
+static void drain_child_process_err(struct child_test *child)
+{
+	char buf[512];
+	ssize_t len;
+
+	while ((len = read(child->process.err, buf, sizeof(buf) - 1)) > 0) {
+		buf[len] = '\0';
+		strbuf_addstr_safe(&child->err_output, buf);
+	}
+}
+
+static void handle_child_pipe_activity(struct child_test *child, short revents)
+{
+	if (!revents)
+		return;
+
+	drain_child_process_err(child);
+	/*
+	 * If the child closed its end of the pipe (EOF) or encountered
+	 * an error, close the file descriptor immediately and set it
+	 * to -1. This removes it from the pfds array for subsequent
+	 * iterations, preventing a tight CPU busy-loop while waiting
+	 * for the process itself to exit.
+	 */
+	if (revents & (POLLHUP | POLLERR | POLLNVAL)) {
+		close(child->process.err);
+		child->process.err = -1;
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
+					size_t idx = pfd_indices[p];
+
+					handle_child_pipe_activity(child_tests[idx],
+								   pfds[p].revents);
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
+				child->process.pid = 0;
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
@@ -671,8 +904,9 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
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
@@ -683,6 +917,10 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
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
2.54.0.929.g9b7fa37559-goog

