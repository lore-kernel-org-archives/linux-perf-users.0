Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88E32DEA68
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 02:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650437; cv=none; b=cGKeFkwRnSJXFD76YuYGOa+Wwz6MDooRgNcLKuQ/CsdDJcjuRc9D4quQmLlGrzzZ44iiPmQOw21t78xuC+IWJKmeGzqOqT0A5X9C8amKbcBGUSfIZ2r7ZktFodlVCbTFgtcz4FG1u6vybVzQvc6wHUUq86+IEIm2dTQ9ynFbhzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650437; c=relaxed/simple;
	bh=WdWe44Z2xtvNFV10iko8r00XqbgPtHJlASPG04N3nc0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nSCUyYVZB4W6G+CwTVrQaZLdNadVZoBkOpDVGBV1Ob+lYzik0pUz3ozf+Mc3B6IOgjLEMztwSKGdb8pvtPU0czDu0a/2NmlfTQP2ZUYjX88tTwqZGI2tUUiB8lU+NHABmfywR6+VHUWYU0CdsjFXOiEDQaX36xtlMf+BLNwBSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OWF6me/u; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OWF6me/u"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-14318be7d79so143989c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 19:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790650433; x=1791255233; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c4auCV6Kvojh0a2ynmdbUe85NaoF72UNtpfK9Ugrld0=;
        b=OWF6me/u5DCy2Xj5SKcZboA05Juz++axawWupDhKLeEJWDbtSYVrzoLh3cTzFJAvcf
         hfTkIApeAEd7qYgrdOzikxBSeO/kYJduArX9bbBaexRXxY5wXwYF13ZFGj05AbW/Luwc
         VPKJcz4DErPm7N+HFyDSnQG9H/6cGGHJHa84yMYThQ+LlinrvojhIhLKd9pHNReDimFq
         DefpwN/MrdmoYf30bS+xk2nnFmUXVtigbzfYGQjb0qIPQDBxO40f+afaKSGib10Y44WI
         NeICOVqN5PJxdDlnpSNPisuH69J1U6rLF87tQr0uTBjr48/UvI9/cDP+v+E87UNfK6gq
         CPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790650433; x=1791255233;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c4auCV6Kvojh0a2ynmdbUe85NaoF72UNtpfK9Ugrld0=;
        b=WfRoGToAXpJ6PScMRmFLtezPyRwc3fTNHDCz+SL6gQlqBCMdSI+U18sPBoj5f6X6wD
         pG48JxgjHywlrsUOrG9Ce2hqXfL26DzcqIIenlEkbIwi+vC6891p1Rzapya2BWWbVyAi
         LzGs1UJn/HnhMKZD4yS58713Z8a8ps8ZL7DQjArmMuZ1TydD+rPXdC5QtVyfwME16tlY
         vhD611AitRUPKgQCljuByyKu/E7tnaXx4or26iaBYRVkQTotlNng3GLgVjZszDWy3K7Z
         TQfe1XDuUgmj4/eFDakv+nucPtS6Y0lT+Et5bDUs2sNj1u0b49LZKhjBk+Ztxr4S/3Zt
         5TkA==
X-Forwarded-Encrypted: i=1; AKwUvBwYiUSLaGgJ4MnTFev/5P77l6T4lVIJFWndx840YSRu6S/EyqC7D5XgfTt9skGnCWCMB2KO5ktSu+b4x3BP4Zsd@vger.kernel.org
X-Gm-Message-State: AFuF++kzRjyRRwaYmA5pcQ7e+FKXHOUx5cmADZSgM8yPYbUT9Qx/XrLl
	d5Pax6Lr4zlYG7d/A9objX2eu0Q/HTCZDOgDK5MWxMdsAyeYuNoZGz7AjRvZgd1vM3ngaxNdep7
	tSLV1sMZHkQ==
X-Received: from dlx9.prod.google.com ([2002:a05:7022:89:b0:144:d025:68b5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:21cd:b0:145:4ef:e8e5
 with SMTP id a92af1059eb24-146ce492db4mr12419768c88.18.1790650432344; Mon, 28
 Sep 2026 19:53:52 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:53:44 -0700
In-Reply-To: <20260929011837.4157334-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929011837.4157334-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929025345.88829-1-irogers@google.com>
Subject: [PATCH v3 1/2] perf test: Add per-test timeout support
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When a test hangs in 'perf test', the entire test run hangs and makes it
difficult to inspect output from other tests.

Add a new TEST_TIMEOUT result category and a per-test timeout (default
60 seconds, configurable via '-t'/'--timeout', with 0 to disable). When
'-F' ('--dont-fork') is specified, timeouts are disabled.

To enforce the timeout:
- Place each forked test child into its own process group via
  setpgid(0, 0) in the child and setpgid(pid, pid) in the parent so any
  subprocesses spawned by shell or workload tests can be terminated
  together.
- Arm an ITIMER_REAL periodic timer with a SIGALRM handler (using
  SA_RESTART so /proc status reads in check_if_command_finished() are
  not interrupted by EINTR while poll()/usleep() waits still wake up).
- Check elapsed child runtimes against test_timeout in finish_test() and
  finish_tests_parallel(), sending SIGTERM first and escalating to
  SIGKILL after 1 second if the child process group has not exited.
- Report timed out tests in red ('TIMEOUT!'), track and display them in
  the test summary, and emit '<error message="TIMEOUT" type="timeout">'
  counted under the 'errors' attribute in JUnit XML output.
- Document '-t'/'--timeout' and '-F'/'--dont-fork' in perf-test.txt.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
v3: Address Sashiko review of v2:
 - Block SIGINT/SIGTERM while a test process may be reaped (in
   check_if_command_finished() and finish_command()) and until its pid is
   cleared, and skip already reaped tests in the signal path, so a stale
   pid or process group ID can never be signaled.

v2: Address Sashiko review of v1:
 - Reset SIGALRM to SIG_DFL in the forked test child so tests relying on
   default alarm() behaviour aren't affected by the parent's no-op handler.
 - Replace the blocking waitpid(-1) loop with a bounded, non-blocking wait
   that only runs when the test was interrupted by SIGTERM/SIGINT, avoiding
   hangs on normal test failures.
 - Ensure the SIGKILL escalation reaches the whole process group even when
   the direct child exits after SIGTERM, by killing the group before the
   zombie is reaped (so the PGID can't be reused).
 - Factor out timespec_diff_secs() and TEST_KILL_GRACE_SECS.
---
 tools/perf/Documentation/perf-test.txt |   7 +-
 tools/perf/tests/builtin-test.c        | 297 ++++++++++++++++++++++---
 tools/perf/tests/tests.h               |   7 +-
 3 files changed, 280 insertions(+), 31 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 859df74e62ef..16d940e8d221 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -45,10 +45,15 @@ OPTIONS
 	Run each test the given number of times, by default once. This
 	option can be useful to determine if a test is flaky.
 
+-t::
+--timeout::
+	Timeout for each forked test in seconds, by default 60 seconds. Specify
+	0 to disable the timeout. Ignored when -F/--dont-fork is used.
+
 -F::
 --dont-fork::
 	Do not fork child for each test, run all tests within single process, this
-	sets sequential mode.
+	sets sequential mode and disables the per-test timeout.
 
 --dso::
 	Specify a DSO for the "Symbols" test.
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d2f594921e25..f6cbca0bc71d 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -11,8 +11,11 @@
 #include <execinfo.h>
 #endif
 #include <setjmp.h>
+#include <signal.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <time.h>
 
 #include "util/config.h"
 
@@ -60,6 +63,8 @@ static bool sequential;
 static unsigned int runs_per_test = 1;
 /* Number of lines to include in failure snippet. */
 static unsigned int failure_snippet_lines = 10;
+/* Timeout per test in seconds (0 for no timeout). */
+static unsigned int test_timeout = 60;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 static const char *workload_control;
@@ -330,8 +335,11 @@ struct child_test {
 	struct strbuf err_output;
 	int result;
 	bool done;
+	bool timed_out;
+	bool sigkill_sent;
 	struct timespec start_time;
 	struct timespec end_time;
+	struct timespec timeout_time;
 };
 
 static jmp_buf run_test_jmp_buf;
@@ -351,20 +359,68 @@ static void child_test_sig_handler(int sig)
 	siglongjmp(run_test_jmp_buf, sig);
 }
 
+/* Grace period between SIGTERM and SIGKILL for a timed out test. */
+#define TEST_KILL_GRACE_SECS 1.0
+
+static double timespec_diff_secs(const struct timespec *end, const struct timespec *start)
+{
+	return (end->tv_sec - start->tv_sec) + (end->tv_nsec - start->tv_nsec) / 1000000000.0;
+}
+
+/*
+ * Reap subprocesses of the test, such as shell scripts running trap cleanup
+ * handlers, for at most TEST_KILL_GRACE_SECS. The wait is bounded so that
+ * subprocesses that ignore the signal can't hang the test, the parent kills
+ * any that remain.
+ */
+static void wait_for_test_subprocesses(void)
+{
+	struct timespec start, now;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	for (;;) {
+		pid_t pid = waitpid(-1, NULL, WNOHANG);
+
+		if (pid > 0)
+			continue;
+		if (pid < 0 && errno != EINTR)
+			break; /* ECHILD, no subprocesses remain. */
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		if (timespec_diff_secs(&now, &start) >= TEST_KILL_GRACE_SECS)
+			break;
+		usleep(10 * 1000);
+	}
+}
+
 static int run_test_child(struct child_process *process)
 {
 	const int signals[] = {
 		SIGABRT, SIGBUS, SIGFPE, SIGILL, SIGINT, SIGPIPE, SIGQUIT, SIGSEGV, SIGTERM,
 	};
 	struct child_test *child = container_of(process, struct child_test, process);
-	int err;
+	int err, sig;
 
+	/*
+	 * Place the forked test into its own process group (pgid == pid) so
+	 * that any subprocesses it spawns (e.g. shell tests running via
+	 * system() and their child perf/workload processes) inherit this
+	 * process group. On timeout or interruption, signaling -pid kills the
+	 * entire test process tree without leaving orphaned background
+	 * processes or affecting the parent perf process and other tests.
+	 */
+	setpgid(0, 0);
+	/*
+	 * The parent's no-op SIGALRM handler, used to wake it for timeout
+	 * checks, is inherited across fork (interval timers aren't). Restore
+	 * the default so tests using alarm() still terminate.
+	 */
+	signal(SIGALRM, SIG_DFL);
 	close_parent_fds();
 
-	err = sigsetjmp(run_test_jmp_buf, 1);
-	if (err) {
+	sig = sigsetjmp(run_test_jmp_buf, 1);
+	if (sig) {
 		/* Received signal. */
-		err = err > 0 ? -err : -1;
+		err = TEST_FAIL;
 		goto err_out;
 	}
 
@@ -378,20 +434,30 @@ static int run_test_child(struct child_process *process)
 
 	check_leaks();
 err_out:
-	fflush(NULL);
 	for (size_t i = 0; i < ARRAY_SIZE(signals); i++)
 		signal(signals[i], SIG_DFL);
+	/*
+	 * SIGTERM and SIGINT are sent by the parent to the whole process group,
+	 * on timeout or interruption, so subprocesses were also signaled. Give
+	 * them a chance to finish cleaning up. Other failures don't signal
+	 * subprocesses so don't wait for them.
+	 */
+	if (sig == SIGTERM || sig == SIGINT)
+		wait_for_test_subprocesses();
+	fflush(NULL);
 	return -err;
 }
 
-#define TEST_RUNNING -3
+#define TEST_RUNNING -4
 
 static struct pollfd *global_pfds;
 static size_t *global_pfd_indices;
 static unsigned int summary_tests_passed;
 static unsigned int summary_subtests_passed;
 static unsigned int summary_tests_skipped;
+static unsigned int summary_tests_timed_out;
 static unsigned int summary_tests_failed;
+static struct strbuf summary_timed_out_tests_buf = STRBUF_INIT;
 static struct strbuf summary_failed_tests_buf = STRBUF_INIT;
 
 static int strbuf_addstr_safe(struct strbuf *sb, const char *s);
@@ -507,6 +573,18 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 			color_fprintf(debug_file(), PERF_COLOR_YELLOW, " Skip\n");
 	}
 		break;
+	case TEST_TIMEOUT:
+		summary_tests_timed_out++;
+		if (test_suite__num_test_cases(t) > 1)
+			strbuf_addf_safe(&summary_timed_out_tests_buf, "  %3d.%1d: %s\n",
+				    curr_suite + 1, curr_test_case + 1,
+				    test_description(t, curr_test_case));
+		else
+			strbuf_addf_safe(&summary_timed_out_tests_buf, "  %3d: %s\n",
+				    curr_suite + 1,
+				    test_description(t, curr_test_case));
+		color_fprintf(debug_file(), PERF_COLOR_RED, " TIMEOUT!\n");
+		break;
 	case TEST_FAIL:
 	default:
 		summary_tests_failed++;
@@ -532,7 +610,11 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 		strbuf_addf(&junit_xml_buf,
 			    "    <testcase classname=\"%s\" name=\"%s\" time=\"%.2f\">\n",
 			    escaped_class, escaped_test, elapsed);
-		if (result != TEST_OK && result != TEST_SKIP) {
+		if (result == TEST_TIMEOUT) {
+			strbuf_addf(&junit_xml_buf,
+				    "      <error message=\"TIMEOUT\" type=\"timeout\">\n%s\n      </error>\n",
+				    escaped_err);
+		} else if (result != TEST_OK && result != TEST_SKIP) {
 			strbuf_addf(&junit_xml_buf,
 				    "      <failure message=\"FAILED\">\n%s\n      </failure>\n",
 				    escaped_err);
@@ -561,7 +643,7 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 
 static const char * const fail_keywords[] = {
 	"error", "fail", "segv", "abort",
-	"signal", "fatal", "panic", "corrupt", NULL
+	"signal", "fatal", "panic", "corrupt", "timeout", NULL
 };
 
 static const char *find_next_keyword(const char *str, size_t max_len, size_t *kw_len)
@@ -748,6 +830,103 @@ static void print_test_failure_snippet(FILE *fp, const char *buf)
 	free(line_lens);
 }
 
+static void cmd_test_alarm_handler(int sig __maybe_unused)
+{
+}
+
+static void check_child_timeout(struct child_test *child, const struct timespec *now)
+{
+	pid_t pid;
+
+	/*
+	 * Once the test process has exited, kill_timed_out_group() handles any
+	 * remaining members of the process group before the test is reaped.
+	 */
+	if (!test_timeout || !child || child->done || child->process.finished)
+		return;
+
+	pid = child->process.pid;
+	if (pid <= 0)
+		return;
+
+	if (!child->timed_out) {
+		if (timespec_diff_secs(now, &child->start_time) >= test_timeout) {
+			child->timed_out = true;
+			child->timeout_time = *now;
+			pr_debug3("Timeout (%us) for test %d.%d (pid %d), sending SIGTERM\n",
+				  test_timeout, child->suite_num + 1,
+				  child->test_case_num + 1, pid);
+			kill(-pid, SIGTERM);
+			kill(pid, SIGTERM);
+		}
+	} else if (!child->sigkill_sent) {
+		if (timespec_diff_secs(now, &child->timeout_time) >= TEST_KILL_GRACE_SECS) {
+			child->sigkill_sent = true;
+			pr_debug3("Sending SIGKILL to timed out test %d.%d (pid %d)\n",
+				  child->suite_num + 1, child->test_case_num + 1, pid);
+			kill(-pid, SIGKILL);
+			kill(pid, SIGKILL);
+		}
+	}
+}
+
+/*
+ * Kill subprocesses of a timed out test that outlived the test process, such
+ * as ones that ignored SIGTERM. Must be called after check_if_command_finished()
+ * reports the test process exited but before finish_command() reaps it. The
+ * unreaped (zombie) test process still holds its pid as the process group ID,
+ * so the ID can't be reused and signaling -pid can't hit an unrelated group.
+ */
+static void kill_timed_out_group(struct child_test *child)
+{
+	if (!child->timed_out || child->process.finished || child->process.pid <= 0)
+		return;
+
+	pr_debug3("Sending SIGKILL to remaining processes of timed out test %d.%d (pgid %d)\n",
+		  child->suite_num + 1, child->test_case_num + 1, child->process.pid);
+	kill(-child->process.pid, SIGKILL);
+}
+
+/*
+ * Reaping a test process frees its pid, and so its process group ID, for
+ * reuse. SIGINT and SIGTERM are blocked while a test process may be reaped so
+ * that cmd_test_sig_handler() can't run between the reap and the update of
+ * process.finished/pid, and then signal a reused pid or process group.
+ */
+static void block_term_signals(sigset_t *oldset)
+{
+	sigset_t set;
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGINT);
+	sigaddset(&set, SIGTERM);
+	sigprocmask(SIG_BLOCK, &set, oldset);
+}
+
+static int test_command_finished(struct child_test *child)
+{
+	sigset_t oldset;
+	int ret;
+
+	block_term_signals(&oldset);
+	ret = check_if_command_finished(&child->process);
+	sigprocmask(SIG_SETMASK, &oldset, NULL);
+	return ret;
+}
+
+static int reap_child_test(struct child_test *child)
+{
+	sigset_t oldset;
+	int ret;
+
+	block_term_signals(&oldset);
+	kill_timed_out_group(child);
+	ret = finish_command(&child->process);
+	child->process.pid = 0;
+	sigprocmask(SIG_SETMASK, &oldset, NULL);
+	return child->timed_out ? TEST_TIMEOUT : ret;
+}
+
 static void finish_test(struct child_test **child_tests, int running_test, int child_test_num,
 		int width)
 {
@@ -797,13 +976,19 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 			  .events = POLLIN | POLLERR | POLLHUP | POLLNVAL,
 			},
 		};
+		if (test_timeout > 0) {
+			struct timespec now;
+
+			clock_gettime(CLOCK_MONOTONIC, &now);
+			check_child_timeout(child_test, &now);
+		}
 		if (perf_use_color_default) {
 			int running = 0;
 
 			for (int y = running_test; y < child_test_num; y++) {
 				if (child_tests[y] == NULL)
 					continue;
-				if (check_if_command_finished(&child_tests[y]->process) == 0)
+				if (test_command_finished(child_tests[y]) == 0)
 					running++;
 			}
 			if (running != last_running) {
@@ -837,11 +1022,15 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 					err_done = false;
 					buf[len] = '\0';
 					strbuf_addstr_safe(&err_output, buf);
+				} else if (pfds[0].revents & (POLLHUP | POLLERR | POLLNVAL)) {
+					close(err);
+					err = -1;
+					child_test->process.err = -1;
 				}
 			}
 		}
-		if (err_done)
-			err_done = check_if_command_finished(&child_test->process);
+		if (err_done || child_test->timed_out)
+			err_done = test_command_finished(child_test);
 	}
 	/* Drain any remaining data from the pipe. */
 	if (err >= 0) {
@@ -858,8 +1047,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 		fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
 	}
 	/* Clean up child process. */
-	ret = finish_command(&child_test->process);
-	child_test->process.pid = 0;
+	ret = reap_child_test(child_test);
 	if (child_test->err_output.len > 0) {
 		struct strbuf merged = STRBUF_INIT;
 
@@ -872,7 +1060,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	}
 	if (verbose > 1)
 		fprintf(stderr, "%s", err_output.buf);
-	else if (verbose == 1 && ret == TEST_FAIL)
+	else if (verbose == 1 && (ret == TEST_FAIL || ret == TEST_TIMEOUT))
 		print_test_failure_snippet(stderr, err_output.buf);
 
 	clock_gettime(CLOCK_MONOTONIC, &end_time);
@@ -1018,6 +1206,7 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 	while (next_to_print < num_tests) {
 		size_t running_count = 0;
 		size_t p;
+		struct timespec now;
 
 		while (next_to_print < num_tests &&
 		       (!child_tests[next_to_print] || child_tests[next_to_print]->done))
@@ -1027,6 +1216,8 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 			break;
 
 		num_pfds = 0;
+		if (test_timeout > 0)
+			clock_gettime(CLOCK_MONOTONIC, &now);
 
 		for (i = next_to_print; i < num_tests; i++) {
 			struct child_test *child = child_tests[i];
@@ -1034,7 +1225,10 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 			if (!child || child->done)
 				continue;
 
-			if (!check_if_command_finished(&child->process))
+			if (test_timeout > 0)
+				check_child_timeout(child, &now);
+
+			if (!test_command_finished(child))
 				running_count++;
 
 			if (child->process.err >= 0) {
@@ -1090,14 +1284,13 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 			if (!child || child->done)
 				continue;
 
-			if (check_if_command_finished(&child->process)) {
+			if (test_command_finished(child)) {
 				if (child->process.err >= 0) {
 					drain_child_process_err(child);
 					close(child->process.err);
 					child->process.err = -1;
 				}
-				child->result = finish_command(&child->process);
-				child->process.pid = 0;
+				child->result = reap_child_test(child);
 				clock_gettime(CLOCK_MONOTONIC, &child->end_time);
 				child->done = true;
 			}
@@ -1141,7 +1334,8 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 
 			if (verbose > 1)
 				fprintf(stderr, "%s", child->err_output.buf);
-			else if (verbose == 1 && child->result == TEST_FAIL)
+			else if (verbose == 1 &&
+				 (child->result == TEST_FAIL || child->result == TEST_TIMEOUT))
 				print_test_failure_snippet(stderr, child->err_output.buf);
 
 			elapsed = (child->end_time.tv_sec - child->start_time.tv_sec) +
@@ -1218,14 +1412,20 @@ static int start_test(struct test_suite *test, int curr_suite, int curr_test_cas
 		(*child)->process.stdout_to_stderr = 1;
 	}
 	(*child)->process.no_exec_cmd = run_test_child;
+	clock_gettime(CLOCK_MONOTONIC, &(*child)->start_time);
+	err = start_command(&(*child)->process);
+	if (err)
+		return err;
+	/*
+	 * Also set the child's process group in the parent to avoid a race if
+	 * the parent signals -pid before the child executes setpgid(0, 0).
+	 */
+	setpgid((*child)->process.pid, (*child)->process.pid);
 	if (sequential || pass == 2) {
-		err = start_command(&(*child)->process);
-		if (err)
-			return err;
 		finish_test(child, /*running_test=*/0, /*child_test_num=*/1, width);
 		return 0;
 	}
-	return start_command(&(*child)->process);
+	return 0;
 }
 
 /* State outside of __cmd_test for the sake of the signal handler. */
@@ -1245,6 +1445,14 @@ static void print_tests_summary(void)
 	pr_info("Passed main tests : %u\n", summary_tests_passed);
 	pr_info("Passed subtests   : %u\n", summary_subtests_passed);
 	pr_info("Skipped tests     : %u\n", summary_tests_skipped);
+	if (summary_tests_timed_out > 0) {
+		color_fprintf(debug_file(), PERF_COLOR_RED, "Timed out tests   : %u\n",
+			      summary_tests_timed_out);
+		pr_info("List of timed out tests:\n");
+		pr_info("%s", summary_timed_out_tests_buf.buf);
+	} else {
+		color_fprintf(debug_file(), PERF_COLOR_GREEN, "Timed out tests   : 0\n");
+	}
 	if (summary_tests_failed > 0) {
 		color_fprintf(debug_file(), PERF_COLOR_RED, "Failed tests      : %u\n",
 			      summary_tests_failed);
@@ -1265,12 +1473,15 @@ static void print_tests_summary(void)
 				unsigned int total = summary_tests_passed +
 						     summary_subtests_passed +
 						     summary_tests_skipped +
+						     summary_tests_timed_out +
 						     summary_tests_failed;
 				fprintf(fp, "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");
 				fprintf(fp, "<testsuites>\n");
 				fprintf(fp,
-					"  <testsuite name=\"perf-tests\" tests=\"%u\" failures=\"%u\" skipped=\"%u\">\n",
-					total, summary_tests_failed,
+					"  <testsuite name=\"perf-tests\" tests=\"%u\" failures=\"%u\" errors=\"%u\" skipped=\"%u\">\n",
+					total,
+					summary_tests_failed,
+					summary_tests_timed_out,
 					summary_tests_skipped);
 				fprintf(fp, "%s", junit_xml_buf.buf);
 				fprintf(fp, "  </testsuite>\n");
@@ -1288,6 +1499,7 @@ static void print_tests_summary(void)
 		}
 	}
 	strbuf_release(&junit_xml_buf);
+	strbuf_release(&summary_timed_out_tests_buf);
 	strbuf_release(&summary_failed_tests_buf);
 }
 
@@ -1321,18 +1533,39 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 		for (size_t x = 0; x < num_tests; x++) {
 			struct child_test *child_test = child_tests[x];
 
-			if (!child_test || child_test->process.pid <= 0)
+			/*
+			 * Reaped tests have finished set, or pid cleared, as
+			 * reaping is done with SIGINT/SIGTERM blocked. Don't
+			 * signal them as their pid/pgid may have been reused.
+			 */
+			if (!child_test || child_test->process.pid <= 0 ||
+			    child_test->process.finished)
 				continue;
 
 			pr_debug3("Killing %d pid %d\n",
 				  child_test->suite_num + 1,
 				  child_test->process.pid);
+			kill(-child_test->process.pid, err);
 			kill(child_test->process.pid, err);
 		}
 		goto err_out;
 	}
 	signal(SIGINT, cmd_test_sig_handler);
 	signal(SIGTERM, cmd_test_sig_handler);
+	if (!dont_fork && test_timeout > 0) {
+		struct sigaction sa = {
+			.sa_handler = cmd_test_alarm_handler,
+			.sa_flags = SA_RESTART,
+		};
+		struct itimerval timer = {
+			.it_interval = { .tv_sec = 1, .tv_usec = 0 },
+			.it_value = { .tv_sec = 1, .tv_usec = 0 },
+		};
+
+		sigemptyset(&sa.sa_mask);
+		sigaction(SIGALRM, &sa, NULL);
+		setitimer(ITIMER_REAL, &timer, NULL);
+	}
 
 	/*
 	 * In parallel mode pass 1 runs non-exclusive tests in parallel, pass 2
@@ -1430,6 +1663,12 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 		for (size_t x = 0; x < num_tests; x++)
 			finish_test(child_tests, x, num_tests, width);
 	}
+	if (!dont_fork && test_timeout > 0) {
+		struct itimerval timer = {};
+
+		setitimer(ITIMER_REAL, &timer, NULL);
+		signal(SIGALRM, SIG_DFL);
+	}
 	print_tests_summary();
 	free(global_pfds);
 	free(global_pfd_indices);
@@ -1762,6 +2001,8 @@ int cmd_test(int argc, const char **argv)
 		    "Run the tests one after another rather than in parallel"),
 	OPT_UINTEGER('r', "runs-per-test", &runs_per_test,
 		     "Run each test the given number of times, default 1"),
+	OPT_UINTEGER('t', "timeout", &test_timeout,
+		     "Timeout for each test in seconds, default 60s (0 to disable)"),
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '--list-workloads' to list the available ones."),
 	OPT_STRING(0, "record-ctl", &workload_control, "fifo:ctl-fifo[,ack-fifo]",
 		   "Write enable to the fifo just before running the workload and disable after, with optional ack from ack-fifo"),
@@ -1824,8 +2065,10 @@ int cmd_test(int argc, const char **argv)
 		return 0;
 	}
 
-	if (dont_fork)
+	if (dont_fork) {
 		sequential = true;
+		test_timeout = 0;
+	}
 
 	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.try_vmlinux_path = true;
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 9c96f33483d1..2de66dc2e701 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -6,9 +6,10 @@
 #include "util/debug.h"
 
 enum {
-	TEST_OK   =  0,
-	TEST_FAIL = -1,
-	TEST_SKIP = -2,
+	TEST_OK      =  0,
+	TEST_FAIL    = -1,
+	TEST_SKIP    = -2,
+	TEST_TIMEOUT = -3,
 };
 
 #define TEST_ASSERT_VAL(text, cond)					 \
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

