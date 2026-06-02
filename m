Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835163FCB2F
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422128; cv=none; b=lCRc9G95B4Yyf+3iWzI3Y69Fi8myrzULtxP2oWM92ydyM9wwVH7FoflWVh4MfyTOVu249zlXCFDBKqkwU6IZa/ToxQUDxEwinmhWlf3mUezv2hloFbq6otPwUacVUaF4+qPFJY7lW1rpw1HoArVRWpDHDMZXBcDez+i7D/msGhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422128; c=relaxed/simple;
	bh=4IJxMEK+hyXcn6OSzSiBuIGhOwdl0zzy2rEy0ccnE/M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NGJhjSxoJEGxHbK03zKNNHoxTVwJhCJMDJVP8Pk+qYkaDtGrCSemPfySXD2xKRRv3wXIlrdl0iZGxHQyDk5QL+nt/aQ2MMKtRqEXwiAuQncBO+hToJKKH0KejTH6JQ9QmJADI4jnsGZdZNU4tUS3pFLu0axLaQyTtZixaJQfLrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EZyy5O6f; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EZyy5O6f"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304ec73b015so6935597eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780422126; x=1781026926; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LvR3HtlJKGXlGzBtjPSUAzDrGaqG0+LgPidiCb7Egrk=;
        b=EZyy5O6fw9r0rvWgdhgZKF3M2LOjZh47oRaqCfcBgzVwN2vTixlM3YaLNEbCHRo1pz
         v/1nb/2a3S6X6I1DTyxq8Xx5u3i5uv/yVK0rKemzFzYqpotOS5HApPJvkrUcZheGJwFn
         7ByzD8K4Ei6R6csoQ1E60hmjyCrvrp+1l6Odb44f5wRLcPyH1E4hArWZ13E6km1NAXyb
         xQSYaJpyixVXZR+CVQkTnVgZLkanTu07gC5WefCEiS97nFA/YBx6m1wWaij7aHY3tAMG
         GqMgA/XL2jP/yjNLvVc/CKrxMjuiI7n5RxabbTjhgr0yjyvhsObcyBAm6J2RN7FuzM2h
         CK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422126; x=1781026926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LvR3HtlJKGXlGzBtjPSUAzDrGaqG0+LgPidiCb7Egrk=;
        b=jA/tzI3pWKMbjHggAEqVOfZDqE+e6cIL7QwmLFzAzB0xYHxRrsltYndkCFYvadXOXC
         RNjk8wtQepOhA3siDUDisdqG8/uI+TeVGxOI3rWLNHt29XnzZBVuhcBtUUj+PqSPeYfu
         iAWm+MnknXgE5Z3Yk/j8I7ak7NZAtAq7Fua1AUR4kxBk1zq38DArknV9Bp9W4Xu9df3A
         NlWuqKcR0/2YhnzLw87PvgUns7MYEBuIY8L/GpJmnAOFw1zQFC3DeTYFewAfFypNjS3o
         d195zAyQem+B68qzYAC268zpGLReDY5sDRDH1SMBZunHZY+uqWqUkIZZ9Pq0y9Juw77J
         sH5A==
X-Forwarded-Encrypted: i=1; AFNElJ90W3FhBVKsYlDHj03qMm2pucB7QowN2TzUcW2iZjHut6zDrbpkbXbo6Qw1E7osZndbej1nieoALRMfIwnOGqk8@vger.kernel.org
X-Gm-Message-State: AOJu0YzflxgBlOpmmaoes1yNjLYSS6l7oFVpZxuX0WNQAl+Gv7VNCvcQ
	xNKBlwJnOCcdn7ocpwdjGoh7k7I0sL5fDiBA4iSNGi5yRZaLTrl6KlclOMopuq3gb4Zx50rr0/1
	en/vxdA/G/Q==
X-Received: from dycol2.prod.google.com ([2002:a05:7301:db82:b0:304:d4f5:64b1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d0a:b0:304:e6f8:7ccf
 with SMTP id 5a478bee46e88-304fa67a7eamr8882572eec.27.1780422125348; Tue, 02
 Jun 2026 10:42:05 -0700 (PDT)
Date: Tue,  2 Jun 2026 10:41:19 -0700
In-Reply-To: <20260602174129.3192312-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602073132.2653307-1-irogers@google.com> <20260602174129.3192312-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602174129.3192312-9-irogers@google.com>
Subject: [PATCH v8 08/18] perf test: Refactor parallel poll loop to drain all
 pipes simultaneously
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When running tests in parallel with verbose output (-v), child processes
write to pipes. If a test produces significant output (e.g. Granite
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
 tools/perf/tests/builtin-test.c | 267 +++++++++++++++++++++++++++++++-
 1 file changed, 259 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 485ff75ab880..0479184c3dda 100644
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
@@ -422,7 +430,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	 * Busy loop reading from the child's stdout/stderr that are set to be
 	 * non-blocking until EOF.
 	 */
-	if (err > 0)
+	if (err >= 0)
 		fcntl(err, F_SETFL, O_NONBLOCK);
 	if (verbose > 1) {
 		if (test_suite__num_test_cases(t) > 1)
@@ -476,7 +484,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 				if (len > 0) {
 					err_done = false;
 					buf[len] = '\0';
-					strbuf_addstr(&err_output, buf);
+					strbuf_addstr_safe(&err_output, buf);
 				}
 			}
 		}
@@ -484,13 +492,13 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 			err_done = check_if_command_finished(&child_test->process);
 	}
 	/* Drain any remaining data from the pipe. */
-	if (err > 0) {
+	if (err >= 0) {
 		char buf[512];
 		ssize_t len;
 
 		while ((len = read(err, buf, sizeof(buf) - 1)) > 0) {
 			buf[len] = '\0';
-			strbuf_addstr(&err_output, buf);
+			strbuf_addstr_safe(&err_output, buf);
 		}
 	}
 	if (perf_use_color_default && last_running != -1) {
@@ -499,16 +507,253 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
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
+	pthread_sigmask(SIG_BLOCK, &set, &oldset);
+	ret = strbuf_addstr(sb, s);
+	pthread_sigmask(SIG_SETMASK, &oldset, NULL);
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
+	sigset_t set, oldset;
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGINT);
+	sigaddset(&set, SIGTERM);
+
+	pthread_sigmask(SIG_BLOCK, &set, &oldset);
+	global_pfds = calloc(num_tests, sizeof(*pfds));
+	global_pfd_indices = calloc(num_tests, sizeof(*pfd_indices));
+	pfds = global_pfds;
+	pfd_indices = global_pfd_indices;
+	if (!pfds || !pfd_indices) {
+		free(pfds);
+		free(pfd_indices);
+		global_pfds = NULL;
+		global_pfd_indices = NULL;
+		pthread_sigmask(SIG_SETMASK, &oldset, NULL);
+		return -ENOMEM;
+	}
+	pthread_sigmask(SIG_SETMASK, &oldset, NULL);
+
+	for (i = 0; i < num_tests; i++) {
+		struct child_test *child = child_tests[i];
+
+		if (!child)
+			continue;
+		strbuf_init(&child->err_output, 0);
+		if (child->process.err >= 0)
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
+			if (child->process.err >= 0) {
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
+				if (child->process.err >= 0) {
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
+			pthread_sigmask(SIG_BLOCK, &set, &oldset);
+			strbuf_release(&child->err_output);
+			child_tests[next_to_print] = NULL;
+			zfree(&child);
+			pthread_sigmask(SIG_SETMASK, &oldset, NULL);
+			next_to_print++;
+		}
+	}
+
+	pthread_sigmask(SIG_BLOCK, &set, &oldset);
+	free(global_pfds);
+	free(global_pfd_indices);
+	global_pfds = NULL;
+	global_pfd_indices = NULL;
+	pthread_sigmask(SIG_SETMASK, &oldset, NULL);
+	return 0;
+}
+
 static int start_test(struct test_suite *test, int curr_suite, int curr_test_case,
 		struct child_test **child, int width, int pass)
 {
@@ -542,13 +787,14 @@ static int start_test(struct test_suite *test, int curr_suite, int curr_test_cas
 	(*child)->test_case_num = curr_test_case;
 	(*child)->process.pid = -1;
 	(*child)->process.no_stdin = 1;
+	(*child)->process.in = -1;
+	(*child)->process.out = -1;
+	(*child)->process.err = -1;
 	if (verbose <= 0) {
 		(*child)->process.no_stdout = 1;
 		(*child)->process.no_stderr = 1;
 	} else {
 		(*child)->process.stdout_to_stderr = 1;
-		(*child)->process.out = -1;
-		(*child)->process.err = -1;
 	}
 	(*child)->process.no_exec_cmd = run_test_child;
 	if (sequential || pass == 2) {
@@ -671,8 +917,9 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
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
@@ -683,6 +930,10 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
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
2.54.0.1013.g208068f2d8-goog

