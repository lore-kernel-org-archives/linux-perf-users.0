Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1F63346A0
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294509; cv=none; b=YzSSoigmVeyBftXWnGBkQJuBTxWBYLVBXh+VrMvQF8mSBrIlJm3oDAbmbLnh1abeeR3XqYQICxHVAcmWX5J3frZ3cdTiXFqzI7UTj+fibf9PKxHkRDxpW7xnd2Lmk6Ac+PUxS3aIXlq6Tu2vUpJxGOFFUsXrYMv+/TgTqOyatBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294509; c=relaxed/simple;
	bh=8EEi8AAxLzEq+FVFCJ/o+xVxtGVNK6M4dZG6nw1hkGo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bsPhDTv0kqd0b692KhRtr2NkxhGwwN6VhgSORfEaXi5m23JQT8t4OI/2Wz2Qg5EZERmzSpZM7k85bIQMbqhww/Zb0ahK6EWCJj1EiiTGXt1DMIGhnsq7rw4PZOG/XU1KHsBQEa90LFPRrrYcQUEaoOV6LOG4AdsPQzN0Y9nCVGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hmXg+BYo; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hmXg+BYo"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135916eefa0so13316873c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 23:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780294506; x=1780899306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9DaJxqO7r63MHFIw+W5m8RQEQ+1tEQUbdA8e6OSMSk=;
        b=hmXg+BYoXzRELiGJIdANXArOShobW38VQgAZeL+rOiAr5DO7sdU9CERXAlS3LY9Nda
         FvviLVuKUzcidElQAL4tmWfYsspLPKWSEzoEZt+irahnKEIH5BzCzbjr/SxLIU9O5lBU
         tql/dA8bb5UVjej+EobbA/SZWkijfVoCE3ZG7lRlLLXrmsbgj/JygyHiDejbjmI4NZud
         x/HaPMBtGvtJ4oAI1gJZUGndBTBJQDLPxNpz4gnz6cVk3l3fqDc9YphCwTJfuM6Qke7G
         REDFI4vsGuBdbhBXnZlSNtR/PWjP3GFiwk8xIC+72wGKnYgMM9c3lReCmygfcTEWGC4E
         8bRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294506; x=1780899306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9DaJxqO7r63MHFIw+W5m8RQEQ+1tEQUbdA8e6OSMSk=;
        b=XgBBg7fU/JIBtHxU3cwDYVP/XvgFlHmtM2vMKb5hRtsFv+K/kAXd1cgKfnyjjVQ+/z
         P1+1Y0GjBwxzB2fPX2/IT4vZCHlvjzezbNY3njyARc8cYehksEsY5guoApohHF1DQ0eh
         RJxFNBgn5vsaRnGH9qtp0hwzuoptzi0j/VSLjY5WEiVoKtUIbHcCzF7OzBmyWANCuytT
         mbkYNamZwX+pnAV3mr0Z3ZvrmI9cZpiRYWl47EFNTcaihIQpDOs5FhwPHzuPtZyssnPY
         EkQbig9fzpSAOqsVRM8edqbfpJ5JN18JWNsF/YBsv6nmYriH8S5vk16HfNRwwydPfnqY
         nR6A==
X-Forwarded-Encrypted: i=1; AFNElJ+pS79C7PkPQ7kojIm4B5zi2k2aMXGBwhLNOJTEkilZlZnPMp32riiJT3XTkZ8DoFY1ASgQL+qQyjWNq4aOpXh0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa+hz6GPhtkP4l2RdBQ1AQbR3IZCGrSXnOW+xxe/cM6/zWCRIb
	4e0MsfwfUxWaDsKtd2QRykMBQkUIJyvG/7c1uDtZB0s7I7ZZcKSg84cPmqNm8ErWMuAHtxl0PrW
	P5Cih4XkMDQ==
X-Received: from dlec13-n1.prod.google.com ([2002:a05:701b:428d:10b0:136:1d52:aebc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:671e:b0:134:cbed:2b35
 with SMTP id a92af1059eb24-137d3f1515emr4647877c88.18.1780294505805; Sun, 31
 May 2026 23:15:05 -0700 (PDT)
Date: Sun, 31 May 2026 23:13:55 -0700
In-Reply-To: <20260601061401.1541457-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601000548.1195604-1-irogers@google.com> <20260601061401.1541457-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601061401.1541457-10-irogers@google.com>
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
 tools/perf/tests/builtin-test.c | 75 +++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 6d7b4a952e90..5d319b9da762 100644
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
@@ -728,10 +748,36 @@ static int strbuf_addstr_safe(struct strbuf *sb, const char *s)
 	sigaddset(&set, SIGTERM);
 	sigprocmask(SIG_BLOCK, &set, &oldset);
 	ret = strbuf_addstr(sb, s);
-	sigprocmask(SIG_SETMASK, &oldset, NULL);
 	return ret;
 }
 
+static int __printf(2, 3) strbuf_addf_safe(struct strbuf *sb, const char *fmt, ...)
+{
+	char buf[1024];
+	va_list ap;
+	int len;
+
+	va_start(ap, fmt);
+	len = vsnprintf(buf, sizeof(buf), fmt, ap);
+	va_end(ap);
+
+	if (len < 0)
+		return len;
+	if ((size_t)len >= sizeof(buf)) {
+		char *dynamic_buf = malloc(len + 1);
+		int ret;
+		if (!dynamic_buf)
+			return -ENOMEM;
+		va_start(ap, fmt);
+		vsnprintf(dynamic_buf, len + 1, fmt, ap);
+		va_end(ap);
+		ret = strbuf_addstr_safe(sb, dynamic_buf);
+		free(dynamic_buf);
+		return ret;
+	}
+	return strbuf_addstr_safe(sb, buf);
+}
+
 static void drain_child_process_err(struct child_test *child)
 {
 	char buf[512];
@@ -989,6 +1035,23 @@ static void cmd_test_sig_handler(int sig)
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
@@ -1066,9 +1129,12 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
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
 
@@ -1101,6 +1167,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 		for (size_t x = 0; x < num_tests; x++)
 			finish_test(child_tests, x, num_tests, width);
 	}
+	print_tests_summary();
 	free(global_pfds);
 	free(global_pfd_indices);
 	global_pfds = NULL;
-- 
2.54.0.823.g6e5bcc1fc9-goog

