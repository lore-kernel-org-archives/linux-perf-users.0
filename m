Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580013815DE
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780215783; cv=none; b=UM/Y+ch+Bl3nPntUZwflAPFFu/eupYvE59t0CA2oALoarvK8MeGGPCpQAEJN6km2NoOx1gIXK3A+um2hZ5xLSDcR579TfdQ3/+EkpiU3CxUenA2/n2D54cQJwzl+zBP+86VED9qGqJ4IqdJVXOJKhAq4eBK9vVd5uhK7OOR6v0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780215783; c=relaxed/simple;
	bh=2itQhvl3Mh8fh4HhTyTuffKngfm1WnmLT1c98hoSWfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hWRG4bHu2M9XOLPVUXdjzxEWZYp8tQ1wVs5SLrsrjAOxaH8I3rnxM5RZRuVR+zoUAleTHvxH+OVZO6dY3rJQfQgktwcQB0PyEjY40DsrlMhs7JOZtPZfJ7LTaha1W0X54d+spX0g4gEcU9I0tS65k5lWHorB+2Dd0kpHP9YesKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jgjc4oe2; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jgjc4oe2"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137dd5171feso492671c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 01:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780215781; x=1780820581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K8DNYmp3uFzR/H/LijUzHmTZB09FJqRr+eRhzsaPwcs=;
        b=jgjc4oe2XRvCn+J72bU26mIiCNbgj/B6wjexoIrGFZSKlE7odudadNUqKdL8Pw9nUO
         BobWwkSqEEPAp3VLY3Y343TPzupJZ7sieIL7cBkXv8bvDgj3KRDDGa2AgnVHB+P7a1u+
         NnBkBn0ooZaxVKmKSF6Exsqmd5JX4kGlyO3AWor4rss3xG1LnfpbQ9znSc0gBn/Phzl9
         1JEtSNS9iQIBZucs/IarN6CTE1es6GNzyzy4ke5VvlR9G7K7I45DOp9L9zkSJYs3c5R0
         zCxxAttkBncOKtbfi18sN/+uBDSZ5uXzTdt6mfzPUM8iNEVRnMu/cAlWAsQwAtZyRvF8
         aU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780215781; x=1780820581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8DNYmp3uFzR/H/LijUzHmTZB09FJqRr+eRhzsaPwcs=;
        b=oisA0V8vvz6rEX4RENH65IpMt2L7gdNGJg4NaPZwJlEQIQyKyqFqwR7jW9BDP/tvwz
         rwg+HcULBhraJXr2OeG+QCi+2GHDC1xikIgFxnLWSfeDMXIieTxuHHsYuQcIXiePQEvZ
         WwZ04kVAFc8Zrk6fb9J2Mrvel4U3U6g+WmxwIZvw5uDTgozo8UHj9RKFGHHywIdlB41h
         SohS3+d+f9RffZ1EGCBTZDUNe2/b48JNxfouXnPGbperkah0IPnOLCL39GQNw+ukeoiP
         2Wun+tnQHA+hnvdHxIRpEsCSSg4nPJhksNEd/eXpob5mHWGG60mIXWmGxB675K56GA7Y
         +ifw==
X-Forwarded-Encrypted: i=1; AFNElJ93Ak5UZVhbRsAAPkP4GjLdsBuN4UbpFWXxNxNpek+eQBEEd/y1lXLCRtq9LFVETn9TdN+/f+cTtzi9doubB03k@vger.kernel.org
X-Gm-Message-State: AOJu0YwOcO+P9xMb4Bzu60HQwfB58kK8u6W7tMdnaNvKH6JIyrTybmLA
	Qvyo1Tgvc6EZcoM2XPetXSUco1u1mE32uGcam3ldAj8iMIjqZ9OigfExbv8c2DV6TwL/5ZXOMnw
	KgBHJ8QiaPQ==
X-Received: from dlea10-n2.prod.google.com ([2002:a05:701b:420a:20b0:12c:8ccc:748c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b89:b0:12b:f8d6:d4bc
 with SMTP id a92af1059eb24-137d429c8cemr2939787c88.34.1780215781395; Sun, 31
 May 2026 01:23:01 -0700 (PDT)
Date: Sun, 31 May 2026 01:22:27 -0700
In-Reply-To: <20260531082235.940833-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531063736.871777-1-irogers@google.com> <20260531082235.940833-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531082235.940833-8-irogers@google.com>
Subject: [PATCH v4 07/15] perf test: Refactor parallel poll loop to drain all
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
output pipes from all running children simultaneously into per-child buffers.
Reaping occurs out of order as children finish, while final result printing
remains strictly in order.

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

