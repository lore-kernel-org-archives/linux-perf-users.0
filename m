Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A634676F
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 06:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780209483; cv=none; b=qVUfw9MUVo4LmKZpJfa1ZaqOqvvQdNqNc7ZqYNpHFzdl2fU0/Dy0TYId3O7u0V1LLLWimCpJAJZtTHV+4xoAYIFtIG0cqVt3OBQr47dGKrRG6aTvuUafziq3+GKZfG1MHYBNrNl1f+bxiwyW96Kg2LhvSW58hgvCkX8Hjx8Ps+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780209483; c=relaxed/simple;
	bh=eIgwWDC25w+Uii+JpLNoUy+3whtuxhp0Za1cSTKXNuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AqVJgFhoPIGKseFBemOEV6pSuXWDcfI+UJ2Jl2xXcSxsWYobFcaRmhlnNrxPeP5qJWHZQcjX3y7+PkLxSSTWt+oi3lhNZLZCYCJi2+qFYaxWEH1/VdHHAJk8KpBFrCDfcz5t7xDmpVAqCB0CsqWiAGnsTaTbgvzHW/gKWSFNOK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ImLIAwcA; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ImLIAwcA"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304e3e3fba5so10448347eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 23:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780209481; x=1780814281; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cnSVwt7OGO6nDSab0gASgCcyvKSTSYoLNL/UchLUrpU=;
        b=ImLIAwcAZL0uLyNvCoZgnRu067KStLbiRSbdHTiPx7o6ZspnVVmMI9SfgUlZkBFLah
         yDX1OFOaJH6bJ2XbyKMOUJQJdgm+kkNOw07aNHVUnH88bRbNwbe8FM7FL4UGFWQi7Fyz
         QQb1f8Nq2n13gEjWU6JSuxesWhmRNSxLsNaNrZW5WufDXRa2C3TmWAMMCEpbhhxKyz9u
         3E9ngaxRelV6FlQeSoWkff7NWI+4aRD3CEykAJKvrWfkfAhQPxB3WCcXwMSyksp5P0sy
         +0NeptDlpI841NPjN9/IzEqKUKOdFvDcK2pbiDqTNsaJcaHQg7KMyuaJUMyAHktbQhxM
         PWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780209481; x=1780814281;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnSVwt7OGO6nDSab0gASgCcyvKSTSYoLNL/UchLUrpU=;
        b=YWWYFm5IR38k7YwJlbR1pAk66jb8zvjOpe7qPjo8G9fSZEhR+vH+kfK0U+VnhwikO8
         EJIif9VfN5O5Pq8NCPoU3vp1ryp6IpzF8HdC5FIpl54/l/pXvRBDgFffE3nHIcHvmFRy
         ymQSk39kQkVMnSMDhMJj02PlskuL3hGavefVEpC0gFImV2Cpc3XMUdqF/joIS8+4yCNG
         XSyXS+gaGtc7ZWtmqecPLkNl+NNbr69HrAlwAK3V8zagWztJMqsrorfv3bEGWHPTIxWm
         mmsHMBZgahM0C8hL0TwASAniXzedExvkkwD045R2C1swbBwDuvUv1T14ugMlgBHcPHMd
         Me+A==
X-Forwarded-Encrypted: i=1; AFNElJ9esTcO53eE1/B/CTnvw2pjPkEgZE2Wv1HRwBv2Llsw1Een46ORbjuILOcInJW/UQBkcj+8dAgN7utMrUGUD5/d@vger.kernel.org
X-Gm-Message-State: AOJu0YxlfkfIHGD8IYRGJkjDvxaYFYTYCUCx7Au5BHyMK4jPd2TTxjAB
	G3tszleVXM7Y/6r8cKG+UhdnGyYei7peUgNEufqxqTmX9L/Go0l9yJNmXz+gVyN25uI5Ze75oEF
	p+Q31q+2Clw==
X-Received: from dlan16-n1.prod.google.com ([2002:a05:7022:eb50:10b0:137:c9b:c045])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7e05:b0:137:dbc6:cb1d
 with SMTP id a92af1059eb24-137dbc6cc4dmr986596c88.24.1780209480939; Sat, 30
 May 2026 23:38:00 -0700 (PDT)
Date: Sat, 30 May 2026 23:37:28 -0700
In-Reply-To: <20260531063736.871777-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531052740.796087-1-irogers@google.com> <20260531063736.871777-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531063736.871777-7-irogers@google.com>
Subject: [PATCH v3 06/14] perf test: Refactor parallel poll loop to drain all
 pipes simultaneously
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When running tests in parallel with verbose output (-v), child processes
write to pipes. If a test produces significant output (e.g. Granite Rapids
metric parsing printing hundreds of lines), it fills the 64KB pipe buffer
and blocks.
Previously, the parent harness (finish_test) only polled the pipe of the
"current" test waiting to be printed. Other children blocked indefinitely
until the parent reached them, severely sequentializing execution.

Address this by implementing finish_tests_parallel() to poll and drain
output pipes from all running children simultaneously into per-child buffers.
Reaping occurs out of order as children finish, while final result printing
remains strictly in order.

This drops parallel verbose execution time for the PMU events suite from
~35 seconds down to ~5.9 seconds.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/run-command.c  |  47 +++++++-
 tools/perf/tests/builtin-test.c | 208 +++++++++++++++++++++++++++++++-
 2 files changed, 251 insertions(+), 4 deletions(-)

diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index b7510f83209a..e1341080dbae 100644
--- a/tools/lib/subcmd/run-command.c
+++ b/tools/lib/subcmd/run-command.c
@@ -146,6 +146,10 @@ int start_command(struct child_process *cmd)
 			close(cmd->out);
 		if (need_err)
 			close_pair(fderr);
+		cmd->pid = -1;
+		cmd->in = -1;
+		cmd->out = -1;
+		cmd->err = -1;
 		return err == ENOENT ?
 			-ERR_RUN_COMMAND_EXEC :
 			-ERR_RUN_COMMAND_FORK;
@@ -233,6 +237,8 @@ int check_if_command_finished(struct child_process *cmd)
 	char filename[6 + MAX_STRLEN_TYPE(typeof(cmd->pid)) + 7 + 1];
 	char status_line[256];
 	FILE *status_file;
+	int status;
+	pid_t waiting;
 
 	/*
 	 * Check by reading /proc/<pid>/status as calling waitpid causes
@@ -241,8 +247,45 @@ int check_if_command_finished(struct child_process *cmd)
 	sprintf(filename, "/proc/%u/status", cmd->pid);
 	status_file = fopen(filename, "r");
 	if (status_file == NULL) {
-		/* Open failed assume finish_command was called. */
-		return true;
+		/*
+		 * fopen() can fail with ENOENT if the process has been reaped.
+		 * It can also fail with EMFILE/ENFILE if RLIMIT_NOFILE is reached,
+		 * or with EINTR/ENOMEM. Use kill(pid, 0) as a robust fallback
+		 * to distinguish between active processes and dead ones without
+		 * consuming file descriptors.
+		 */
+		if (errno == ENOENT)
+			return 1;
+		waiting = waitpid(cmd->pid, &status, WNOHANG);
+		if (waiting == cmd->pid) {
+			int result;
+			int code;
+
+			cmd->finished = 1;
+			if (WIFSIGNALED(status)) {
+				result = -ERR_RUN_COMMAND_WAITPID_SIGNAL;
+			} else if (!WIFEXITED(status)) {
+				result = -ERR_RUN_COMMAND_WAITPID_NOEXIT;
+			} else {
+				code = WEXITSTATUS(status);
+				switch (code) {
+				case 127:
+					result = -ERR_RUN_COMMAND_EXEC;
+					break;
+				case 0:
+					result = 0;
+					break;
+				default:
+					result = -code;
+					break;
+				}
+			}
+			cmd->finish_result = result;
+			return 1;
+		}
+		if (waiting < 0 && errno == ECHILD)
+			return 1;
+		return 0;
 	}
 	while (fgets(status_line, sizeof(status_line), status_file) != NULL) {
 		char *p;
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

