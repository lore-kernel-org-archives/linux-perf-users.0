Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3474A3B2D0A
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385526; cv=none; b=Vxj2DQyOj0DaH4LmcjGPDncK0EvPqbNXATSAC+xLVb6nts/hSOWvwUKj/JnwriADETkihtDpMyQ4JkXS5hnG5nJcIhKStgD2Bv2qnMilbxSWs5yEJbJ59BfUqY+yRogreR6DwIojQiTti0lXKfINyEDI9JENW32Hd/kwka+Q6nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385526; c=relaxed/simple;
	bh=4fY1yfWgVQtOI0AlES3Hj2CsxGXr3jeSvx3DV10LzvE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m0G9M5nZHNFhS8YntkfeV7rrXkmo3VaBzYdI6Y7ndiNWf9L1nQ07KUG0VD8qUWcb2NAE6ONc5GPZ/9LnhAl/bEvUwp9ciguWQz4p8Mhkif1I8Ae27t2pOWDzZ7L8EdZQz06B3rakw70+BYLBpZkRg5Y72ApprDbkEXkH8Mz6YV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mNgIwdyG; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNgIwdyG"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304efad654dso4885368eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 00:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780385520; x=1780990320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YXRwQI6Rwpjg72xBsfEBn04NQ/gqzR0BgPsrJJPkFvY=;
        b=mNgIwdyGU7VxaNLzlu3Wcy8MNLfLnpnxqqcImzoszvouurUMf9anwnfPVkYicIYJQl
         2/VttQMEviaYItKXa0a6A7bUOzR5wh2GegxFTQTTZvCqPe+7ISDdYi50h4lNet3nL7tF
         6bsNgRQNRhqYdSdKpleey9gpC75+aIFeVXWJSI6yho2G2hMelypAjzdrodeVWdz3HuVl
         q0SOxmHx4Jl//pJAfMlEgQyewYy88fvHwGgaYHZ6+Gz2iSEVJCcp9F+uYvtkpQgJPWys
         XvUkWoipE1hoAO2gyq/TD19zp+Qvpns7ZLIvABtoz2g5o5MCcbTZHJ/ouM2hlUoM5vnU
         4LnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780385520; x=1780990320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXRwQI6Rwpjg72xBsfEBn04NQ/gqzR0BgPsrJJPkFvY=;
        b=YUOOg0z7QOyg1cHtXAcZ+3q5/AdLWPxxmV1MWfcSFLJForR4YSM+nts/CfjV4tSwF/
         nLePBMjeTrv+WaSxA5yi4MUfc/4Ign5BmJbPlCRww6q7m5mn2yfeGE0jiKYwCo//cK1x
         z1J/7NfPnQyCZ6YNrtFU+EmDk4GUQaHXtg1PzcMdq0IjdAWnJrDitw0RF+AJA+nMJOtZ
         kfYji1Y5f6Ooa5mWvdml5UG/TXF8g+HRwDv9CYzx8hg6UkZiHNA34Q71zq61awmgo6LB
         6zzSg0IcdvmryCVYClwkflRULNOvc+zct+XQtLUtWPgeFaQEXrsJxJN981VtfMTfQwW4
         ThsQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ixNG5qyfcg8268ew9TI4QRlxfSbBCFktE51/Qckuvq4xNY+NsE3OOB2F4kWKZ6B48yLNjFJiNgewRh6qVqY7N@vger.kernel.org
X-Gm-Message-State: AOJu0YyyyBrDbMwgJRYRr/QuW2xnkmnJHtu91L2B8YzuWbxngNL41/BI
	zFZzKcbMZ2oAZMBa3+8P9j6gKc0Ki96fSeLKaqFqw9lwVprgImyMgB6eHWARvMCrr7hVNe4z364
	aMDA6FCQUjw==
X-Received: from dybvq12.prod.google.com ([2002:a05:7301:77cc:b0:2da:2af9:bfe2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6ca7:b0:2f5:5dd3:1fcf
 with SMTP id 5a478bee46e88-304fa546879mr6410501eec.10.1780385519887; Tue, 02
 Jun 2026 00:31:59 -0700 (PDT)
Date: Tue,  2 Jun 2026 00:31:25 -0700
In-Reply-To: <20260602073132.2653307-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601061401.1541457-1-irogers@google.com> <20260602073132.2653307-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602073132.2653307-11-irogers@google.com>
Subject: [PATCH v7] perf test: Add summary reporting
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Currently, when running test suites (perf test), users must scroll
through hundreds of lines of console output to manually tally the
number of passed, skipped, or failed test cases.

Introduce an automated, global execution summary printed at the
absolute tail of the test run:
1. Track counts mid-flight inside the print_test_result() accumulator,
   clearly separating pass counts into standalone main tests vs.
   individual subtests (where num_test_cases > 1).
2. Accumulate the precise descriptions of all failed test cases
   directly into a global string buffer, formatted with their suite
   indices (e.g., 3.1: Parse event definition strings) for effortless
   cross-referencing.
3. Define a summary printer function print_tests_summary() that
   emits a colored outline of the final pass, skip, and fail totals,
   followed by the explicit list of failed tests.
4. Invoke the summary printer right before freeing the test array at
   the absolute tail of __cmd_test(), guaranteeing that the summary is
   successfully printed even if an internal emergency signal cleanup
   occurs or if the user interrupts the run early.

Example output:
```
$ sudo perf test -v
  1: vmlinux symtab matches kallsyms                                 : Skip
  2: Detect openat syscall event                                     : Ok
  3: Detect openat syscall event on all cpus                         : Ok
...
163: perf trace summary                                              : Ok

=== Test Summary ===
Passed main tests : 123
Passed subtests   : 145
Skipped tests     : 22
Failed tests      : 6
List of failed tests:
   92: perf kvm tests
   95: kernel lock contention analysis test
  120: perf metrics value validation
  124: Check branch stack sampling
  143: perftool-testsuite_probe
  158: test Intel TPEBS counting mode
```

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 89 +++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 7480cec6cda6..f6bb876a271d 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -363,8 +363,14 @@ static int run_test_child(struct child_process *process)
 
 static struct pollfd *global_pfds;
 static size_t *global_pfd_indices;
+static unsigned int summary_tests_passed;
+static unsigned int summary_subtests_passed;
+static unsigned int summary_tests_skipped;
+static unsigned int summary_tests_failed;
+static struct strbuf summary_failed_tests_buf = STRBUF_INIT;
 
 static int strbuf_addstr_safe(struct strbuf *sb, const char *s);
+static int __printf(2, 3) strbuf_addf_safe(struct strbuf *sb, const char *fmt, ...);
 
 static int print_test_result(struct test_suite *t, int curr_suite, int curr_test_case,
 			     int result, int width, int running)
@@ -382,11 +388,16 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 		color_fprintf(stderr, PERF_COLOR_YELLOW, " Running (%d active)\n", running);
 		break;
 	case TEST_OK:
+		if (test_suite__num_test_cases(t) > 1)
+			summary_subtests_passed++;
+		else
+			summary_tests_passed++;
 		pr_info(" Ok\n");
 		break;
 	case TEST_SKIP: {
 		const char *reason = skip_reason(t, curr_test_case);
 
+		summary_tests_skipped++;
 		if (reason)
 			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (%s)\n", reason);
 		else
@@ -395,6 +406,15 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 		break;
 	case TEST_FAIL:
 	default:
+		summary_tests_failed++;
+		if (test_suite__num_test_cases(t) > 1)
+			strbuf_addf_safe(&summary_failed_tests_buf, "  %3d.%1d: %s\n",
+				    curr_suite + 1, curr_test_case + 1,
+				    test_description(t, curr_test_case));
+		else
+			strbuf_addf_safe(&summary_failed_tests_buf, "  %3d: %s\n",
+				    curr_suite + 1,
+				    test_description(t, curr_test_case));
 		color_fprintf(stderr, PERF_COLOR_RED, " FAILED!\n");
 		break;
 	}
@@ -736,6 +756,47 @@ static int strbuf_addstr_safe(struct strbuf *sb, const char *s)
 	return ret;
 }
 
+static int __printf(2, 3) strbuf_addf_safe(struct strbuf *sb, const char *fmt, ...)
+{
+	char buf[1024];
+	va_list ap;
+	int len;
+	sigset_t set, oldset;
+	int ret;
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGINT);
+	sigaddset(&set, SIGTERM);
+	sigprocmask(SIG_BLOCK, &set, &oldset);
+
+	va_start(ap, fmt);
+	len = vsnprintf(buf, sizeof(buf), fmt, ap);
+	va_end(ap);
+
+	if (len < 0) {
+		sigprocmask(SIG_SETMASK, &oldset, NULL);
+		return len;
+	}
+	if ((size_t)len >= sizeof(buf)) {
+		char *dynamic_buf = malloc(len + 1);
+
+		if (!dynamic_buf) {
+			sigprocmask(SIG_SETMASK, &oldset, NULL);
+			return -ENOMEM;
+		}
+		va_start(ap, fmt);
+		vsnprintf(dynamic_buf, len + 1, fmt, ap);
+		va_end(ap);
+		ret = strbuf_addstr(sb, dynamic_buf);
+		free(dynamic_buf);
+	} else {
+		ret = strbuf_addstr(sb, buf);
+	}
+
+	sigprocmask(SIG_SETMASK, &oldset, NULL);
+	return ret;
+}
+
 static void drain_child_process_err(struct child_test *child)
 {
 	char buf[512];
@@ -1000,6 +1061,23 @@ static void cmd_test_sig_handler(int sig)
 	siglongjmp(cmd_test_jmp_buf, sig);
 }
 
+static void print_tests_summary(void)
+{
+	pr_info("\n=== Test Summary ===\n");
+	pr_info("Passed main tests : %u\n", summary_tests_passed);
+	pr_info("Passed subtests   : %u\n", summary_subtests_passed);
+	pr_info("Skipped tests     : %u\n", summary_tests_skipped);
+	if (summary_tests_failed > 0) {
+		color_fprintf(stderr, PERF_COLOR_RED, "Failed tests      : %u\n",
+			      summary_tests_failed);
+		pr_info("List of failed tests:\n");
+		pr_info("%s", summary_failed_tests_buf.buf);
+	} else {
+		color_fprintf(stderr, PERF_COLOR_GREEN, "Failed tests      : 0\n");
+	}
+	strbuf_release(&summary_failed_tests_buf);
+}
+
 static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 		      struct intlist *skiplist)
 {
@@ -1077,9 +1155,13 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 			}
 
 			if (intlist__find(skiplist, curr_suite + 1)) {
-				pr_info("%3d: %-*s:", curr_suite + 1, width,
-					test_description(*t, -1));
-				color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
+				if (pass == 1) {
+					pr_info("%3d: %-*s:", curr_suite + 1, width,
+						test_description(*t, -1));
+					color_fprintf(stderr, PERF_COLOR_YELLOW,
+						      " Skip (user override)\n");
+					summary_tests_skipped++;
+				}
 				continue;
 			}
 
@@ -1112,6 +1194,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 		for (size_t x = 0; x < num_tests; x++)
 			finish_test(child_tests, x, num_tests, width);
 	}
+	print_tests_summary();
 	free(global_pfds);
 	free(global_pfd_indices);
 	global_pfds = NULL;
-- 
2.54.0.929.g9b7fa37559-goog

