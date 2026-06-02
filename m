Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D903FE649
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422135; cv=none; b=rcuP8ySzDv1dPpbOwarh4VeFp7ZiiqBpCACv5XlxOJHCZuN9NQ7Yyu28bOVABuDgTQF/XG/3aMHUAyZUHIjhN8xepwwJjT/gNhvU6tyWC4cN6FuLeKEtDAbjb24VaRmNmmYKvBfe3T7ROMjFxePC/ABW3PcJV01ZnypUuABSqQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422135; c=relaxed/simple;
	bh=VjirqZ8bJKCgeVT/snissnwGGa6AX8Gr1iu9yGTuRMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bp0lHScez08R9ZKaC2+TXSBYTDRdr1sNR5WtinjKaQET640ZvdFxiXS8Ao1INHcBmkwlSlLwgCJJ10lIVvdbgqgOVSHjQzip8KajEuc3HbyKRBFIQWS+snecfULzFRvSvmm6lU1OE1QfoILqeMMnUC1tu1eYAsbsNt3+rZGvdD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GePN7PAG; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GePN7PAG"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304dd917645so4980876eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780422133; x=1781026933; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ir42RfooPBS04NZA6xa9OZAzp6iTYLZrHT1xocN7xxs=;
        b=GePN7PAGfzgiAny1jqexba99lyOcJwc/V/mO0AJdlPlQgop2ovn0tJL18sV6XURkIn
         YXTn6tDIU0VdiGx8HvI4wHTBk3TQcJkWQNuWVhZQr9FUM0Zg5LQeNH7owgXhVUQr52FQ
         bvomMnDAsyDFRwkVDNOnHCF5SK7rLQgBgjZ3RYqaROzzq1Wgrpwf2LnvSkqQHl1EFTnT
         bwe2jeWhMJyNgyaUHBZLdmOFXL3lhW9/EMqYEbc5lvB/F3Dvx5tyn89tbkzS4CPQTy9q
         KNtYFb6cp45FhVeYOKCYM6aDFutwqHa8CoZT3/j3rw9oa1+vVgh7bg3sYJsSkU46A/a7
         Lg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422133; x=1781026933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ir42RfooPBS04NZA6xa9OZAzp6iTYLZrHT1xocN7xxs=;
        b=IO71h6+eRqmtmcpf0EjffgBeRbG1NcUAXHTO5IcH2a4tusAbfhIGaz9vJtlneS6HJy
         8rgon+KReCk27tLr4MbcUCtWVAppf/fWpU3/or1bxkSz/s7+5kVITHVHAT8/gpLbLq4Q
         mJsYRh6E4VlNzFsgaAParNx9ZfrHgiX5k7gj2GxiwfIxdq5ICTP4D/5wyMxQ/prLPUGH
         j43dL5wJq87/E5hG9Q04vqc4N13yRJsQB23RutMpbeY7Od6ewQYK+mGtKWr+ErwOD3ra
         Sacb+wCVK/0yNWkDLIv6rlpk898e3HC4hc37I4FW5xnyjnu34fQ49xYYQtNitZf4/80D
         8X1A==
X-Forwarded-Encrypted: i=1; AFNElJ+j7oL5gWOld0x33ltUWShMNcpHp9VIE32ALI6IzpkN1m+LM01MKsVdmDofcfbpiDRZKepmvuuzH7/mH8vLFWTF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy6WaQLxOP2HjVVx+Lniul25k2BPNsAZV6i6diPaQN8cCLJyA2
	WvjvcKp81w3BebPvsf/Z7+CcWGpV+GbH/zT64jBGfK5dUI5UjrhzBTitU/RjY13qiNz4ZVSp9y1
	LOFik1s1VLQ==
X-Received: from dycol2.prod.google.com ([2002:a05:7301:db82:b0:304:d4f5:64b1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ad2d:b0:304:bce8:fa30
 with SMTP id 5a478bee46e88-304fa4cae17mr7786325eec.5.1780422133378; Tue, 02
 Jun 2026 10:42:13 -0700 (PDT)
Date: Tue,  2 Jun 2026 10:41:21 -0700
In-Reply-To: <20260602174129.3192312-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602073132.2653307-1-irogers@google.com> <20260602174129.3192312-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602174129.3192312-11-irogers@google.com>
Subject: [PATCH v8 10/18] perf test: Add summary reporting
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
index 3401d79a1d24..8883d4744057 100644
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
@@ -1013,6 +1074,23 @@ static void cmd_test_sig_handler(int sig)
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
@@ -1090,9 +1168,13 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
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
 
@@ -1125,6 +1207,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 		for (size_t x = 0; x < num_tests; x++)
 			finish_test(child_tests, x, num_tests, width);
 	}
+	print_tests_summary();
 	free(global_pfds);
 	free(global_pfd_indices);
 	global_pfds = NULL;
-- 
2.54.0.1013.g208068f2d8-goog

