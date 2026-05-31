Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310153264EF
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780209487; cv=none; b=hUoF2JTRQzbONfm14yHHJ/5l43XhXc6eTh20+2SpQXiF4grJaW7pc3mOE3P/eKu3M6qzfD2u89pVyft99RmHB+7kpavX8TgegzWz0vrtLL6kESOyKHxCCcy5+ZlOSp+3gq7xQJMoYmZrrsJ4Wo9D+YC05xaXfhePj/AvfWymZNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780209487; c=relaxed/simple;
	bh=6wpV6ZG8xbGHmI641wtTAb3MvWrwDIn52g91rdhwLpw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OD7KxY3sRtFUxPbAlArA9jiBjDe5dL1t61969fSVbeUMIZ2KbQwNB0tNRsnfps2lfxj5FPBDbEBv4UJjykHWvD+ME2rr1TxfWyXOoF0c2YobYP71EXdIC2l5WvL/hr5fLow6Z1K37TMGtKmlxQA2outk4N50G8k5+2XdicWkGFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pl3b4MEa; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pl3b4MEa"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137d4309062so5734038c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 23:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780209485; x=1780814285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qTMya3cuRItiQI3FPtqv8gzI+D7T6xotJzqfQ95rr9o=;
        b=pl3b4MEa70JQ07vbj0DrNqRPKl+YaagVs3BcqEQL9v5bgA5CpntTgaHurmV2RYA771
         IZpEjJHFKLgdULVxBSfP9ee7DYT1iKTPl2a76Bb+IDufr66l+NOo/u1pvTabKvJLtbcG
         rSIMqZtzRd4OpQiI6+c9+hQKunjFRQ3ciOML3JO7hGoemUda6/NlEvL6YJywInChizCc
         XZKXHGNQLwqAJHa0n95fXALPatnHII6PsqN3SIZ3O3uaLOBTI/LX8XCTK5bRieV/1meV
         j/KsW2lp656gIJAmQGEmEWZjSpYSNpDd1+VRAy3CefdyulSB0PrWYEvjo6r67qPckNcw
         6xGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780209485; x=1780814285;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTMya3cuRItiQI3FPtqv8gzI+D7T6xotJzqfQ95rr9o=;
        b=hiVQUz2oARl4oLg1hBwQv5pAAoe/bo49bll591OYZqjxWA7CupQo5G1Z9NcNgLAetD
         kMw3VmyEIR4upssiUlJx8R+mrEIW+JRwDUlV3o4PS5LUrk6EemvKLK4/K2AqZURZ46u4
         zwEZZ+k0AymWfE52zQo5q7Uf8F0aIaDiY/DkSb1s0ee6Hsbwd2pnkNnkONl2Tycppe1w
         jeDd26tlbI6oSHBxfYwlAk2Wdl7gDa7nYY9K8naPkC9EtKffm0/OcCbUkSxu7Gecm91e
         J6zHLnv16nYbVHF2gYesn78zuQBrgOw6QHGGk2l8umnnnOEd6G4wSCiyxMYvTJLSeNZe
         xEDQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rVCTLysgP/PD8m7jatCVy750hiqpJiRb99qo+K0dkSGXSieWdype2rwdVPhsx0AqYwxA0klp9yT4sc6Fqc/Li@vger.kernel.org
X-Gm-Message-State: AOJu0YxA2xCriPZZGV2Y7XpBwso4MtCkgfP9rQvb7OI4750ZtbVpXYAg
	Hve3LaxWtklK1W2xdffvPd/Mso7MXlQ1ICDSwwARwpwQ/9Ooizk6Vp7d1ANG26UFFiKDWhDSqGU
	0A07dWy10eA==
X-Received: from dlbrl28.prod.google.com ([2002:a05:7022:f51c:b0:133:3081:bb33])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2601:b0:130:9b78:b18d
 with SMTP id a92af1059eb24-137d42839dfmr2751117c88.34.1780209484969; Sat, 30
 May 2026 23:38:04 -0700 (PDT)
Date: Sat, 30 May 2026 23:37:30 -0700
In-Reply-To: <20260531063736.871777-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531052740.796087-1-irogers@google.com> <20260531063736.871777-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531063736.871777-9-irogers@google.com>
Subject: [PATCH v3 08/14] perf test: Add summary reporting
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
index a29925656865..bd356249c70b 100644
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
@@ -975,6 +994,23 @@ static void cmd_test_sig_handler(int sig)
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
@@ -1052,9 +1088,12 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
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
 
@@ -1087,6 +1126,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 		for (size_t x = 0; x < num_tests; x++)
 			finish_test(child_tests, x, num_tests, width);
 	}
+	print_tests_summary();
 	free(global_pfds);
 	free(global_pfd_indices);
 	global_pfds = NULL;
-- 
2.54.0.823.g6e5bcc1fc9-goog

