Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792707774;
	b=aMx/9pS4NO+kVPddtIfOers4w+rGKs3kcrpIkLeGgno+u0pSkpZpw3HrKFfUWIqAdUCv
	 eBeXiQAP5AzreX82oU5G9DABtrcdD1DkzOVa5IleBpKME7xgEEHJyLeGLPvgIsXqRB5cR
	 naiFv085huqID/JrHk/Qc3NK1sR64JRsrzTsH5wgkV1WJDck8fj6LRFMxcx8qDjqhDPTP
	 FA4KjU7G9PEUW5ENRQ1ja6zKo6N7hKnqFqPDsRcSPOfi+cFWZgkmde8ClTLGb3CT/hEos
	 Aga1vleRw0rnxoK7bFYiTcHgcTHI9r8nRlOgQToTlNIyCukgpsap7bMD4YzBduqzdIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792707774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=d9v8tf4KnUpaFCPeFiJmU4TywnzXvXYhrqMUiAWap84=;
	b=1LuIIxwSnFsydu4ztnO3umIQgxUmw5fwx2pk099AXdiGMZtk9E1YvM/nmSBOj8IcKhTs
	 UT7R4H64+Z1UsDRC1E8H6cdMm10ph5X4l+iMn1CtSAw8gQMAezi4omlBhYECkefwhLUq6
	 k0QKBjfF7DOeYVNewHSSVbN2lgZCfl8hMfqfLGEfe9d/2pXg1kOwlffNiugWVHsialj2D
	 seQXaW99bx92D1GAnGoUjSI76cHpDfOM6655E+4nGVZ+gR5rmTjMeZFSi7wxz83WNmZBU
	 hH1W88AI6yJYWcbkXKEMrQxW1u1WGAZ5e82IxPpZNAgsmI7tb53/HxLLgkK2clX7GdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NFOxjlR3;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D421A606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 22:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D421A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NFOxjlR3
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1665200f4c2so291206c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 15:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792707773; x=1793312573; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d9v8tf4KnUpaFCPeFiJmU4TywnzXvXYhrqMUiAWap84=;
        b=NFOxjlR3lEtJqEArycV8F7TS4JwdgDAYe5wnQo33H9QWSGTzzvZGdxKuyrj9XkPMNt
         bAJRcHZ9l8xJWq8pjLjUtZbRvy+03xeeFitQvygiTOMdkxvdRv4aKhA00stitNKhb8R+
         DUvZ408+775wVmq9bcaqP3HYV0A3Kdv1UrkTCdINGTYzL79iZFVuF5rezr4Ru6T7z2ov
         Kdp9IHxbSmiwnUxwicHTnMGK9IZBWJGWzlGb/1ObtnbH2ViF5bE9YfE+ishv7rp7XJ6R
         TlaNKRMX1I05Z+FpptWta9Sgeb96OdyaHqJ846TgsXRHd58zMCYeL+PfA08uLFU/nz91
         pqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792707773; x=1793312573;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d9v8tf4KnUpaFCPeFiJmU4TywnzXvXYhrqMUiAWap84=;
        b=2GzlURRPhCfQKl1e1nJUQ18T2mL2AJZYmZIPq+W34GnEHcJJxhxP/+++p+O4T7bCiV
         9vMqCwqLUeCFYu3jqHoOGqUyl1sNNiJD3ch6ShJy20NZHAyqA6kqB69qt7P9EtlrbKYu
         aiqfNYp7gsFdPq2BT4ipe08g83S48vQRx4eON4fg6Pjcxi+L+4Sr+pEa2imtNO2w1ySR
         yspuphFve62NH6gvKL11Re+7XJltahvy8iD6g7bBFvPKUwfAb2DqU507R/06mbt1zSHv
         4PyDbdMfeBBa42mrQPiajv64BEv/IEtNCphoCTJfjMIWmFHfUUP8m+F6idyJxY3RO6oS
         h22w==
X-Forwarded-Encrypted: i=1; AKwUvBxw8HMiT89dzXnDE6gZz+0IPyE6yLbZMv8M/soPn0pdGYiiJBce8K10hOe+20jXxRAttATx6pYtYUEX+oDlxRPj@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3pUU4XbWfQT0v+5hGFkJhRCQ3ebSzDmmm759kphDFo8JKc+rn
	m1k9O8WmDpgrdUZA9kagc5+s5kMbNImbP4wZwZxOnlMj0Fq02iWPFL0FC2/oP06cB7PcbrF7V+q
	N6a2e/p2veA==
X-Received: from dlep17-n1.prod.google.com ([2002:a05:701b:4591:10b0:191:503c:21bd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f512:b0:15d:f053:18b6
 with SMTP id a92af1059eb24-195c4f4f932mr565507c88.9.1792707772581; Thu, 22
 Oct 2026 15:22:52 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:22:43 -0700
In-Reply-To: <20261022222245.2064964-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022210753.1851597-1-irogers@google.com> <20261022222245.2064964-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022222245.2064964-2-irogers@google.com>
Subject: [PATCH v6 1/3] perf test: Add per-test timeout support
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When a test hangs in 'perf test', the entire test run hangs and makes it
difficult to inspect output from other tests.

Add a new TEST_TIMEOUT result category and a per-test timeout (default
120 seconds, configurable via '-t'/'--timeout', with 0 to disable). When
'-F' ('--dont-fork') is specified, timeouts are disabled.

To enforce the timeout:
- Place each forked test child into its own process group via
  setpgid(0, 0) in the child and setpgid(pid, pid) in the parent so any
  subprocesses spawned by shell or workload tests can be terminated
  together.
- Check elapsed child runtimes against test_timeout in the existing
  finish_test() and finish_tests_parallel() polling loops, sending
  SIGTERM first and escalating to SIGKILL after 1 second if the child
  process group has not exited.
- Report timed out tests in red ('TIMEOUT!'), track and display them in
  the test summary, and emit '<error message="TIMEOUT" type="timeout">'
  counted under the 'errors' attribute in JUnit XML output.
- Document '-t'/'--timeout' and '-F'/'--dont-fork' in perf-test.txt.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-test.txt |   7 +-
 tools/perf/tests/builtin-test.c        | 294 ++++++++++++++++++++++---
 tools/perf/tests/tests.h               |   7 +-
 3 files changed, 271 insertions(+), 37 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index f66ccd77bfe7..f85e9b561ac4 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -75,10 +75,15 @@ OPTIONS
 	Run each test the given number of times, by default once. This
 	option can be useful to determine if a test is flaky.
 
+-t::
+--timeout::
+	Timeout for each forked test in seconds, by default 120 seconds. Specify
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
index 0751d974a39a..61395b246afe 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -11,9 +11,11 @@
 #include <execinfo.h>
 #endif
 #include <setjmp.h>
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <time.h>
 
 #include "util/config.h"
 
@@ -68,6 +70,8 @@ static bool list_requisites;
 static unsigned int runs_per_test = 1;
 /* Number of lines to include in failure snippet. */
 static unsigned int failure_snippet_lines = 10;
+/* Timeout per test in seconds (0 for no timeout). */
+static unsigned int test_timeout = 120;
 /*
  * The tests mapping ring buffers take turns using their share of
  * kernel.perf_event_mlock_kb via this mutex, shared with the forked test
@@ -374,8 +378,11 @@ struct child_test {
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
@@ -412,6 +419,39 @@ static int run_test_case_mlocked(struct child_test *child)
 	return err;
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
@@ -419,14 +459,23 @@ static int run_test_child(struct child_process *process)
 	};
 	struct child_test *child = container_of(process, struct child_test, process);
 	bool needs_mlock = mlock_budget && child->test->needs_mlock;
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
 
@@ -445,20 +494,33 @@ static int run_test_child(struct child_process *process)
 
 	check_leaks();
 err_out:
-	fflush(NULL);
+	/*
+	 * SIGTERM and SIGINT are sent by the parent to the whole process group,
+	 * on timeout or interruption, so subprocesses were also signaled. Give
+	 * them a chance to finish cleaning up before restoring SIG_DFL. Other
+	 * failures don't signal subprocesses so don't wait for them.
+	 */
+	if (sig == SIGTERM || sig == SIGINT) {
+		signal(SIGTERM, SIG_IGN);
+		signal(SIGINT, SIG_IGN);
+		wait_for_test_subprocesses();
+	}
 	for (size_t i = 0; i < ARRAY_SIZE(signals); i++)
 		signal(signals[i], SIG_DFL);
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
@@ -574,6 +636,18 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 			color_fprintf(debug_file(), PERF_COLOR_YELLOW, " Skip\n");
 	}
 		break;
+	case TEST_TIMEOUT:
+		summary_tests_timed_out++;
+		if (test_suite__num_test_cases(t) > 1)
+			strbuf_addf_safe(&summary_timed_out_tests_buf, "  %3d.%1d: %s\n",
+					 curr_suite + 1, curr_test_case + 1,
+					 test_description(t, curr_test_case));
+		else
+			strbuf_addf_safe(&summary_timed_out_tests_buf, "  %3d: %s\n",
+					 curr_suite + 1,
+					 test_description(t, curr_test_case));
+		color_fprintf(debug_file(), PERF_COLOR_RED, " TIMEOUT!\n");
+		break;
 	case TEST_FAIL:
 	default:
 		summary_tests_failed++;
@@ -599,7 +673,11 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
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
@@ -628,7 +706,7 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 
 static const char * const fail_keywords[] = {
 	"error", "fail", "segv", "abort",
-	"signal", "fatal", "panic", "corrupt", NULL
+	"signal", "fatal", "panic", "corrupt", "timeout", NULL
 };
 
 static const char *find_next_keyword(const char *str, size_t max_len, size_t *kw_len)
@@ -876,6 +954,106 @@ static void print_test_failure_snippet(FILE *fp, const char *buf)
 	free(line_lens);
 }
 
+static void kill_child_process(pid_t pid, int sig)
+{
+	if (kill(-pid, sig) < 0)
+		kill(pid, sig);
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
+			kill_child_process(pid, SIGTERM);
+		}
+	} else if (!child->sigkill_sent) {
+		if (timespec_diff_secs(now, &child->timeout_time) >= TEST_KILL_GRACE_SECS) {
+			child->sigkill_sent = true;
+			pr_debug3("Sending SIGKILL to timed out test %d.%d (pid %d)\n",
+				  child->suite_num + 1, child->test_case_num + 1, pid);
+			kill_child_process(pid, SIGKILL);
+		}
+	}
+}
+
+/*
+ * Kill subprocesses of a timed out test that outlived the test process, such
+ * as ones that ignored SIGTERM. Must be called after check_if_command_finished()
+ * reports the test process exited (/proc/<pid>/status state 'Z' on Linux) but
+ * before finish_command() reaps it. The unreaped (zombie) test process still
+ * holds its pid as the process group ID, so the ID can't be reused and
+ * signaling -pid can't hit an unrelated group. If check_if_command_finished()
+ * fell back to waitpid() and already reaped the process, process.finished is
+ * set and signaling -pid is skipped as the PGID is no longer reserved.
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
@@ -925,13 +1103,19 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
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
@@ -965,12 +1149,26 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
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
+	}
+	if (perf_use_color_default && last_running != -1) {
+		/* Erase "Running (.. active)" line printed before poll/sleep. */
+		fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
 	}
+	/*
+	 * Clean up child process before draining the pipe so that any
+	 * surviving subprocesses in a timed out test's process group are
+	 * killed by kill_timed_out_group() before reading until EOF.
+	 */
+	ret = reap_child_test(child_test);
 	/* Drain any remaining data from the pipe. */
 	if (err >= 0) {
 		char buf[512];
@@ -981,13 +1179,6 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 			strbuf_addstr_safe(&err_output, buf);
 		}
 	}
-	if (perf_use_color_default && last_running != -1) {
-		/* Erase "Running (.. active)" line printed before poll/sleep. */
-		fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
-	}
-	/* Clean up child process. */
-	ret = finish_command(&child_test->process);
-	child_test->process.pid = 0;
 	if (child_test->err_output.len > 0) {
 		struct strbuf merged = STRBUF_INIT;
 
@@ -1000,7 +1191,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	}
 	if (verbose > 1)
 		fprintf(stderr, "%s", err_output.buf);
-	else if (verbose == 1 && ret == TEST_FAIL)
+	else if (verbose == 1 && (ret == TEST_FAIL || ret == TEST_TIMEOUT))
 		print_test_failure_snippet(stderr, err_output.buf);
 
 	clock_gettime(CLOCK_MONOTONIC, &end_time);
@@ -1087,6 +1278,9 @@ static void handle_child_pipe_activity(struct child_test *child, short revents)
 	if (!revents)
 		return;
 
+	if (child->timed_out && test_command_finished(child))
+		return;
+
 	drain_child_process_err(child);
 	/*
 	 * If the child closed its end of the pipe (EOF) or encountered
@@ -1146,6 +1340,7 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 	while (next_to_print < num_tests) {
 		size_t running_count = 0;
 		size_t p;
+		struct timespec now;
 
 		while (next_to_print < num_tests &&
 		       (!child_tests[next_to_print] || child_tests[next_to_print]->done))
@@ -1155,6 +1350,8 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 			break;
 
 		num_pfds = 0;
+		if (test_timeout > 0)
+			clock_gettime(CLOCK_MONOTONIC, &now);
 
 		for (i = next_to_print; i < num_tests; i++) {
 			struct child_test *child = child_tests[i];
@@ -1162,7 +1359,10 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 			if (!child || child->done)
 				continue;
 
-			if (!check_if_command_finished(&child->process))
+			if (test_timeout > 0)
+				check_child_timeout(child, &now);
+
+			if (!test_command_finished(child))
 				running_count++;
 
 			if (child->process.err >= 0) {
@@ -1218,14 +1418,13 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 			if (!child || child->done)
 				continue;
 
-			if (check_if_command_finished(&child->process)) {
+			if (test_command_finished(child)) {
+				child->result = reap_child_test(child);
 				if (child->process.err >= 0) {
 					drain_child_process_err(child);
 					close(child->process.err);
 					child->process.err = -1;
 				}
-				child->result = finish_command(&child->process);
-				child->process.pid = 0;
 				clock_gettime(CLOCK_MONOTONIC, &child->end_time);
 				child->done = true;
 			}
@@ -1269,7 +1468,8 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 
 			if (verbose > 1)
 				fprintf(stderr, "%s", child->err_output.buf);
-			else if (verbose == 1 && child->result == TEST_FAIL)
+			else if (verbose == 1 &&
+				 (child->result == TEST_FAIL || child->result == TEST_TIMEOUT))
 				print_test_failure_snippet(stderr, child->err_output.buf);
 
 			elapsed = (child->end_time.tv_sec - child->start_time.tv_sec) +
@@ -1346,14 +1546,20 @@ static int start_test(struct test_suite *test, int curr_suite, int curr_test_cas
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
@@ -1373,6 +1579,14 @@ static void print_tests_summary(void)
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
@@ -1393,12 +1607,15 @@ static void print_tests_summary(void)
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
@@ -1416,6 +1633,7 @@ static void print_tests_summary(void)
 		}
 	}
 	strbuf_release(&junit_xml_buf);
+	strbuf_release(&summary_timed_out_tests_buf);
 	strbuf_release(&summary_failed_tests_buf);
 }
 
@@ -1449,13 +1667,19 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
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
-			kill(child_test->process.pid, err);
+			kill_child_process(child_test->process.pid, err);
 		}
 		goto err_out;
 	}
@@ -1983,6 +2207,8 @@ int cmd_test(int argc, const char **argv)
 		    "Run the tests one after another rather than in parallel"),
 	OPT_UINTEGER('r', "runs-per-test", &runs_per_test,
 		     "Run each test the given number of times, default 1"),
+	OPT_UINTEGER('t', "timeout", &test_timeout,
+		     "Timeout for each test in seconds, default 120s (0 to disable)"),
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '--list-workloads' to list the available ones."),
 	OPT_STRING(0, "record-ctl", &workload_control, "fifo:ctl-fifo[,ack-fifo]",
 		   "Write enable to the fifo just before running the workload and disable after, with optional ack from ack-fifo"),
@@ -2046,8 +2272,10 @@ int cmd_test(int argc, const char **argv)
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
index 5982c4e62cd3..c9e5f2b2bc11 100644
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
2.56.0.307.g5fe7bd680c-goog

