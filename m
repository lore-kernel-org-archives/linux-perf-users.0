Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E9A3C9897
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713523; cv=none; b=IQcNn+eXtU3PKU0zdZ9MzfvYo5y59CTnO1E1pNxUqR4OSEppQVwgrtJEDw6KfPP4rQm5rnCs709v0eaO4wolVsaawMTfybJdeXHFNirb9Prr5vPItNfRO/Q6U+NznRcTyb9DSjJ+2NT6fsn+UuFHCmQZ9PjiRP9oAzPAtzr+rDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713523; c=relaxed/simple;
	bh=7driVH4/IP6U0Ygb4068xhtcASpAancWDaiLCbiDU6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fwX0+JBiE4AV7j2FPd/fsXNzAKIVzbhreEEDB/y5J2m0m+FXdfz3fn1swdnLRhTcmBdQbelsQkTThGqYuFvlwX7q6U3IdHa6nHZ6AGBxcuhT6qBH7E9K7ipBx3ifkYcIGhp4vnso7Sd7ZjsjsdBmt089lZYGOduhrtQ5XvJ4lP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gM2q06ta; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gM2q06ta"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc763c7256so107080735ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778713520; x=1779318320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xs2yyp18xyFTKxXtGXTVLk3ANXkwByq6r/9w1NkBNko=;
        b=gM2q06taaEzcmAeN5/XV9Q6NKw/HLtox9Cg2a+wzqBX/505f/MzEL6TA7pMu840m0L
         KDNtq+ADtfF6fLoftkp0gbYi7Qpq8szcbgAKV4dH/W4+/iwbDqA79yKC8/tUXKg7Am3S
         CJWL3XSviyP3imnh/NN7eye2z0ks91DXfVi+C5jwCZN4w4oBTyHwbbhX2MBccQ0AgHEC
         UpCbctlXz+3cxVmbI4K+IfMvS3RgtxIhpPOcL6M0lFg32rGCGypBCfKM+qd9xBI6TGoj
         XChGM2RlXTHlzapf8j0ex4hOlQklByj2SfJd76nfKEDelrCXM2ICSJDMXQ4oEbAHte+t
         Fbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778713520; x=1779318320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xs2yyp18xyFTKxXtGXTVLk3ANXkwByq6r/9w1NkBNko=;
        b=hTJKo3js/TX6fQ++COc2Un8EIaCmArElY66SBATP6ojAZd5ux/qL96sAyhNrVDqfHI
         nF7qEknGqPv2Eo8p63Vp23BEEWq55kpZzTmji0WnJZ6LWK9nOBAkVsOYgjr3wYG5MSfd
         CnEgQnFPVsZcEcajLxLJygdidGADnOaSXFu1hN4ub5oiwdnEcgPPux2aXFhR1DTMgkFJ
         KrVCFG8D6FOHRMeMY39RHGMLSVJsJVYTKKzNMjEmJ/Fw4ESqSf0RaSohF7TzhP05a7lx
         p9e+DxjAIu7U8e35DLRQDssmS6ygy9pDi6z6cqq1PtZ7riWTlg0OwyRAruOgQNghqJa1
         +/Pw==
X-Forwarded-Encrypted: i=1; AFNElJ/LvKxKUU4Vcgr5Y6Kku0xwjJiB/gsC/n/+vk1ejr8WOJd3NNY3Q43Q0X/aYwMKRAyd8N9CKuAzgiH0us0MALoI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9SbiFmjHktVS4a4EpfoiGaXUF4TjrcyssUDzWmSv+4UCQD5Fy
	XzvC3NUQGMbhJ0uV8FW6VWiHHU0CpHw5NVjAHDZYg77NwM3msBqob5x7prpZTuBbEC16C3rK5M0
	qAToI4j6lwA==
X-Received: from pldt9.prod.google.com ([2002:a17:903:40c9:b0:2b4:62bc:c2a9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:f90:b0:2bc:f38f:15ad
 with SMTP id d9443c01a7336-2bd27730036mr58459405ad.38.1778713520404; Wed, 13
 May 2026 16:05:20 -0700 (PDT)
Date: Wed, 13 May 2026 16:04:44 -0700
In-Reply-To: <20260513230450.529380-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513230450.529380-9-irogers@google.com>
Subject: [PATCH v1 08/14] perf test: Add summary reporting
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
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
 tools/perf/tests/builtin-test.c | 39 +++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 45c1afb9ad33..193a7dec6d5f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -360,6 +360,12 @@ static int run_test_child(struct child_process *process)
 
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
@@ -376,11 +382,16 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
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
@@ -389,6 +400,15 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
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
@@ -965,6 +985,22 @@ static void cmd_test_sig_handler(int sig)
 	siglongjmp(cmd_test_jmp_buf, sig);
 }
 
+static void print_tests_summary(void)
+{
+	pr_info("\n=== Test Summary ===\n");
+	pr_info("Passed main tests : %u\n", summary_tests_passed);
+	pr_info("Passed subtests   : %u\n", summary_subtests_passed);
+	pr_info("Skipped tests     : %u\n", summary_tests_skipped);
+	if (summary_tests_failed > 0) {
+		color_fprintf(stderr, PERF_COLOR_RED, "Failed tests      : %u\n", summary_tests_failed);
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
@@ -1045,6 +1081,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 				pr_info("%3d: %-*s:", curr_suite + 1, width,
 					test_description(*t, -1));
 				color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
+				summary_tests_skipped++;
 				continue;
 			}
 
@@ -1076,6 +1113,8 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 		pr_err("Internal test harness failure. Completing any started tests:\n:");
 		for (size_t x = 0; x < num_tests; x++)
 			finish_test(child_tests, x, num_tests, width);
+	} else {
+		print_tests_summary();
 	}
 	free(child_tests);
 	return err;
-- 
2.54.0.563.g4f69b47b94-goog

