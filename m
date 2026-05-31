Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21F317153
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205283; cv=none; b=ZtwMHwcIxguDdEbkNmU/VOEPT27gHajz26LWatcSj3ufrCtzPFr6dtPa0QjyDIiocDr1uMbBFHiQcsxGi2xFUrqYUKBofPrwg0D9af+QL8IvMJ8I1ZhjhSmcudmF2s8AtQ4Kzl3WSrn7XSP/Y66t8wkDcJiTzQt7N23JgPdARhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205283; c=relaxed/simple;
	bh=WbOe/B8cYaB5gflSC5DpQGKgSbO97IQGZTVs3wbMGow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iJOh3ky3SSrX34ogikxKOoqhlT577TTwmgcmaIdhFFp33//tLYE9eCAxbocVHROUxQMFFYDabVgGgyQ2mVwVODG0eskKglHBkS7LBM/7vLBYQ+URSQVAHAmgH4IvnMtjvtlPMMJBfc7WpiQs3Zx4mpCf6nvHBMK6BtiuXcD0N2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U3pAzlpB; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3pAzlpB"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304efad654dso5933617eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 22:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780205280; x=1780810080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U6P/EKJgOplwFqD9Sm3rgNbfnmFzoNScOem7mWvgSeA=;
        b=U3pAzlpB7T19FozG97N09SBcCQJiPVwnr2wsPIsdVEWGS1q+m3p5vhRy0BpUnlx3m4
         ZTGP39D/DoLmaB7GXFlwUObSTQdmYLCniA2gcRM0VNTMhC6eI6uJREr1PPsscrH/DnJ5
         EoCxW+1l3KzFInd5AqaDe9KkqgpiU9wkHoX1LzHgVLnOWD0WoOm7oUMvayPIsPVPlD2s
         xTKp95+kOx770PHxVHEIFACQ8nUsHB6pRzPPpsfOmSFZPnLH2dpPsmQtla+jTk3c+BGa
         p/1EwUrw+Ya+yMW0M7Boywwt+z1QJymcTFwzW3j/NxCmv3SEyOwz/mh+I066jaCZbVlU
         Evrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780205280; x=1780810080;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6P/EKJgOplwFqD9Sm3rgNbfnmFzoNScOem7mWvgSeA=;
        b=NRJsAF1hZis4KmeD+1O0jAs8ZOdCYkf3db4JfPVop04Ti6AsSG8FJZ/NTC+Q36g3nl
         QOrqcjfxUCdLtTuTLbiiEfzU9Jbwm6zjHTbEUA19jlyzRXMzenGsO6n01z8D4zDZ/eGa
         26kLjNJZgMs2bexPbQ1xd5FcaA6QhXw4idQ5vNtwqBufv0CPObk+BX1LbM2j096pYlr0
         Pke0FCW7R3SCDuW85hEtMQSxwKBVkdKuK7MsTJoVphLSMrcXK+z5oEBuUVeejGOj7HVx
         zy1SCa4uaKrsnEAZ3/5Q1FRONofgxMqbKagjO+0kLruf56Utoc9xLMNuU0i+iqOJWyMv
         49Jg==
X-Forwarded-Encrypted: i=1; AFNElJ9//siVqVnUeb5teWqnZhBcGL7oA1Ixw+aHmJ8bs2Ex6fUK1mplsM5Rc6lsLzk3FRdhd5fQa80sypezAN/s8RUC@vger.kernel.org
X-Gm-Message-State: AOJu0YyDo4gzTWo7fFIOxOZYxEMxWwKz/MWKp+0rUaviK1dNHCaNZ5Gy
	bvfHYUq3AEpEgPf/Sr4IguDVSjnPMDE6zQQu40dbKr+sOUfdyirqczO7ySxKjL9KbvzhfMLNa/S
	eajp1Q7oieg==
X-Received: from dybsy7.prod.google.com ([2002:a05:7301:7007:b0:303:98b0:efec])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e12a:b0:2f2:8857:17f6
 with SMTP id 5a478bee46e88-304fa523a38mr2507511eec.4.1780205280208; Sat, 30
 May 2026 22:28:00 -0700 (PDT)
Date: Sat, 30 May 2026 22:27:34 -0700
In-Reply-To: <20260531052740.796087-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com> <20260531052740.796087-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531052740.796087-9-irogers@google.com>
Subject: [PATCH v2 08/14] perf test: Add summary reporting
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
 tools/perf/tests/builtin-test.c | 47 ++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index ec44b24d419c..dc04d3f60384 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -361,6 +361,12 @@ static int run_test_child(struct child_process *process)
 
 #define TEST_RUNNING -3
 
+static unsigned int summary_tests_passed;
+static unsigned int summary_subtests_passed;
+static unsigned int summary_tests_skipped;
+static unsigned int summary_tests_failed;
+static struct strbuf summary_failed_tests_buf = STRBUF_INIT;
+
 static int print_test_result(struct test_suite *t, int curr_suite, int curr_test_case,
 			     int result, int width, int running)
 {
@@ -377,11 +383,16 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
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
@@ -390,6 +401,15 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
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
@@ -968,6 +988,23 @@ static void cmd_test_sig_handler(int sig)
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
@@ -1045,9 +1082,12 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
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
 
@@ -1080,6 +1120,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 		for (size_t x = 0; x < num_tests; x++)
 			finish_test(child_tests, x, num_tests, width);
 	}
+	print_tests_summary();
 	free(child_tests);
 	return err;
 }
-- 
2.54.0.823.g6e5bcc1fc9-goog

