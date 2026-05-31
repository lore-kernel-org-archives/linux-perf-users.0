Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D3D381AEB
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780215787; cv=none; b=N5C2rOIwGxClgpC7Csc7Lwqn13qsoH58JIgyTNvwBg0nyHSNsWm/lTxoyaiWlutOC6omSE/uXvY7bMMhkLn3hfGkMH55Lgrc/HotzcfDGUayXdnL0uNuExxBjc438NorMyNzKG97CqmTX440Tm3a5dTk2MxqoU/JGA06vhntIxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780215787; c=relaxed/simple;
	bh=o/QzDt9R+QNB3udbAk50xHc07p0mZUY7YmtlZDmcqoY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rAVbxiZToMGHJk/g7320oS5KefmlQR0XQbqekMFnc7Ss6QUV4eWVEbZFFMNQmNyLoSqo11uLTgTpm/CR/Yw6KgEuB+HXJUIebISikfi1kFytT0/uNhEJfLSz0wi4Pr4ZTdZogZIoRdhR6acsEtlSYa7AVrmZS3ejGZC4Ph81S5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HTeB3m1A; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HTeB3m1A"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13537722193so9711841c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 01:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780215785; x=1780820585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LtvPfep1fr0M+gY7fqvZAxaowS8R7DQW+O7p9BY2dgI=;
        b=HTeB3m1AU7oCq7MZXTDOwXRQ5wKOxh28g5qgNCNobXKZDMoBveo4ktaZLHgaHuMbpS
         51AdwQQwU0sFGOtw9ljC6U+TVznmhEP060g89d6d1Lr9mI9TgjxtBoz3vjdS0b3nQuse
         H7i3R9hb1ANRPDopYwsbw59V4CaV1F/O6FYR0qHSXdre02IvCuXkoE08fdNyrlcztd3A
         AsZX17cptI6wsFNJDctL+pXVMpdRmsj6Xz+LMW4T5mrlSBOo1/nCgg10KOkUEcBAALyF
         Jf8OQbUHwy4QQ061m2iUVKh9jo1kalyDkjONFy63mcf4JJAbEEM+n49kwtuTr13l5po4
         209Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780215785; x=1780820585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LtvPfep1fr0M+gY7fqvZAxaowS8R7DQW+O7p9BY2dgI=;
        b=jHPmeJTCAd7Td+Qr+sWbWQMwTRytIfNjXZr7gJ5VkzIYP7OyYNm3Kb4sWYAiMRcRXV
         VFjjFtVDG8CgldUGsMYUIEq69oC0zHZ5BpyFSmHSHdrTFjUd5gvzOIjahOzz6QkgkAJI
         2ghI6AxmuEDA3sGQBuiYo/dVIzeApbmWtAYvy8jK68vE8L9ZUx7he8epYsg3SL/E2/5L
         BRIrVL/0y8dId/Wn7/2j7zBgIuMNixaERo7LDDKYlMW/YpCDT3VmU52YOP8NeQQDS5Y3
         /600JARy4eNjRVid1yNv7irylpDDdKnvsdc9OvJVpUpE3wh/Yn7/eJBTq2FVkG4Niaoe
         sOeA==
X-Forwarded-Encrypted: i=1; AFNElJ/MffpwO0Dfv4BzxNKi37boaTCDV5CLu0j4uKY/ynOk5ZmMZkZuzUHJ5zlC5B/MUqUjYLxUhJcylpK7ned4J4So@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ZLdfpojc2USmTTb9mprrwBZpSnXx4WCgEVyGaoPGn5PtnJ6o
	wNVBMrfzjzkkLywdkvZMGw1y2OJiWzjhRHvikOWsIH9I4tNpjKflDZiieVJ7HRH3XU7saXjDcOk
	zes0uEAm9Yw==
X-Received: from dldnz9.prod.google.com ([2002:a05:701a:ca09:b0:136:420:2090])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:238c:b0:12b:ebb9:1c18
 with SMTP id a92af1059eb24-137d4243a4cmr2894633c88.31.1780215784651; Sun, 31
 May 2026 01:23:04 -0700 (PDT)
Date: Sun, 31 May 2026 01:22:29 -0700
In-Reply-To: <20260531082235.940833-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531063736.871777-1-irogers@google.com> <20260531082235.940833-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531082235.940833-10-irogers@google.com>
Subject: [PATCH v4 09/15] perf test: Add summary reporting
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Currently, when running test suites (perf test), users must scroll through
hundreds of lines of console output to manually tally the number of passed,
skipped, or failed test cases.

Introduce an automated, global execution summary printed at the absolute
tail of the test run:
1. Track counts mid-flight inside the print_test_result() accumulator,
   clearly separating pass counts into standalone main tests vs. individual
   subtests (where num_test_cases > 1).
2. Accumulate the precise descriptions of all failed test cases directly
   into a global string buffer, formatted with their suite indices (e.g.,
     3.1: Parse event definition strings) for effortless cross-referencing.
3. Define a summary printer function print_tests_summary() that emits a
   colored outline of the final pass, skip, and fail totals, followed by
   the explicit list of failed tests.
4. Invoke the summary printer right before freeing the test array at the
   absolute tail of __cmd_test(), guaranteeing that the summary is
   successfully printed even if an internal emergency signal cleanup occurs
   or if the user interrupts the run early.

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
 tools/perf/tests/builtin-test.c | 46 ++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index e00b0bffa67c..336d24105c9f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -363,6 +363,11 @@ static int run_test_child(struct child_process *process)
 
 static struct pollfd *global_pfds;
 static size_t *global_pfd_indices;
+static unsigned int summary_tests_passed;
+static unsigned int summary_subtests_passed;
+static unsigned int summary_tests_skipped;
+static unsigned int summary_tests_failed;
+static struct strbuf summary_failed_tests_buf = STRBUF_INIT;
 
 static int print_test_result(struct test_suite *t, int curr_suite, int curr_test_case,
 			     int result, int width, int running)
@@ -380,11 +385,16 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
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
@@ -393,6 +403,15 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 		break;
 	case TEST_FAIL:
 	default:
+		summary_tests_failed++;
+		if (test_suite__num_test_cases(t) > 1)
+			strbuf_addf(&summary_failed_tests_buf, "  %3d.%1d: %s\n",
+				    curr_suite + 1, curr_test_case + 1,
+				    test_description(t, curr_test_case));
+		else
+			strbuf_addf(&summary_failed_tests_buf, "  %3d: %s\n",
+				    curr_suite + 1,
+				    test_description(t, curr_test_case));
 		color_fprintf(stderr, PERF_COLOR_RED, " FAILED!\n");
 		break;
 	}
@@ -963,6 +982,23 @@ static void cmd_test_sig_handler(int sig)
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
@@ -1040,9 +1076,12 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 			}
 
 			if (intlist__find(skiplist, curr_suite + 1)) {
-				pr_info("%3d: %-*s:", curr_suite + 1, width,
-					test_description(*t, -1));
-				color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
+				if (pass == 1) {
+					pr_info("%3d: %-*s:", curr_suite + 1, width,
+						test_description(*t, -1));
+					color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
+					summary_tests_skipped++;
+				}
 				continue;
 			}
 
@@ -1075,6 +1114,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 		for (size_t x = 0; x < num_tests; x++)
 			finish_test(child_tests, x, num_tests, width);
 	}
+	print_tests_summary();
 	free(global_pfds);
 	free(global_pfd_indices);
 	global_pfds = NULL;
-- 
2.54.0.823.g6e5bcc1fc9-goog

