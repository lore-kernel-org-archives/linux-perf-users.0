Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7775E3B7A8
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 00:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272388; cv=none; b=jp0bmV0mUvmA5X8FujaxqF//V/Hx1mlGAdjf5bojK6fNIy1wZQVA6ofPEsi7g1NdgQ8wmflww0zB8UKvKvBFU03LheunNEiYFmhMxf7aEe/nzr9qG9o8x1TbdwaQTJXZTEfSQx908NOzTRz0tkOKQH0IHGrToPSYNoi2yz9UyOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272388; c=relaxed/simple;
	bh=o/QzDt9R+QNB3udbAk50xHc07p0mZUY7YmtlZDmcqoY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b6UfwT44+mwbKAJyG5EcU19ars5aM5yWfFpuZZZioPEuyYJQ+f/IduNK36wL3Ssq9tvWOEs865Rq9mha+/crUD2hyG2uBEqcnaTDSRvbyulMCrte+TA7gnY+j9qP/FojCpTa6un/FH//SUjEEFgd/qgbudADvC7KLtknDmjrjvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GpERBFtw; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GpERBFtw"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137276019cfso7545943c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 17:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780272375; x=1780877175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LtvPfep1fr0M+gY7fqvZAxaowS8R7DQW+O7p9BY2dgI=;
        b=GpERBFtwbSw40Ezxsn7+hMJhl5c7pKNmtGZn7qcGKSmTwcjYgIX7MFTwCATy5KWJXM
         S9F3aecy7u2dVvGwfu7u2lD7cLyHrsJhpDM/UUV905utBMPkg6f7buTedNVIpCRz07Ys
         tLzqwGtcppZtpXRp9WeX1q1UnKM98vSUgJOE5S4MW2G+2uAJyGADSp28rnt+rFRrMaF9
         wkUp6m87a+yf1CjrQHZMkn7wjynfs8UKbQdlcAAB00P+mQp5DqbECpk/7QDAANXlgk/d
         jm/xGHXBY6gDxyqMbOwwtaYtz06cMp95W0Xg++gAqgKk+dI2RFt998FnBGJTsiw89/BF
         38aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780272375; x=1780877175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LtvPfep1fr0M+gY7fqvZAxaowS8R7DQW+O7p9BY2dgI=;
        b=KRfvf/sLKofNHf0gC3RK2cNtHYZxL5we5n3bI4eEHySEjFgEDx6APfDYXw3+D50xCr
         +g8ZDODxkVzZ3W7nCOrEK4NSnunvkkh9FlOsmkqASPjxhzQ3uFFAs+vHczQZoJP7vn0j
         gGwnfB0I+LMyfSH/V8Yfcm5l0kdHMEpyYlCnPV82nHSsMFW/4YzAD0q79ABZ8rT0jd1m
         d6M4v1C7iRk5aU1V1+ph8/Vlw5sfnix6nVulHW8RPRG1QwLG6DzP9sdLsYyHezaQIGNa
         LtXel4sKqJ3hM4jmwjVozZqj3G20zp3yNqvryjLA6Gwk0SeRJbEhPVUiTH/KTAX0JDW6
         JXyw==
X-Forwarded-Encrypted: i=1; AFNElJ/63b14bxBBsA+sSvJHa18JPC5LyUEIrZ/eWYV0OVOyu+DrROBGbMdPD4lY+WjNmdww+wz8n4xzhaWxrXgoGrY+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz+vqKHOtGMxyVmY/Ws+wY6taNy2Epa3AKmQA5OGeliDvPwsXB
	vYVE9/MsUNBnW6Kr6G29XWE3FkpWutwL+LlRSlymQ7zwRzSifxFXB4BhZcoXlCObgQoqeX1lpan
	NE3roRK+5iA==
X-Received: from dlbsj5.prod.google.com ([2002:a05:7022:f905:b0:134:b02e:a831])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:38e:b0:136:6883:c4bf
 with SMTP id a92af1059eb24-137d3f0f5c6mr3701217c88.15.1780272374326; Sun, 31
 May 2026 17:06:14 -0700 (PDT)
Date: Sun, 31 May 2026 17:05:42 -0700
In-Reply-To: <20260601000548.1195604-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531082235.940833-1-irogers@google.com> <20260601000548.1195604-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601000548.1195604-10-irogers@google.com>
Subject: [PATCH 09/15] perf test: Add summary reporting
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

