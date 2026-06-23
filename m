Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88093384CCE
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 01:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178089; cv=none; b=Lbv3UtFHh/BwZl4QNAcccCLLXCpUmOcMQivrfUJx/PRcJX73UllfFllrOoV3svLyP82A4lMmvnkxEfSpNsPT44qMCIftLuAZX4gubpATWfjBtlxXqvZnLcX9g22Qn7VuibfGn6np96kT1Q4ZuK43duG66JOkAER/h6VfYBNrq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178089; c=relaxed/simple;
	bh=cYu6UAO5IHu+AUntYH4a+F/AVjy80jEERVVlsXmadT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RtSid0yOJp7l1rKVjBFrj1yVeqXrtVpxx3jjVvxxpEezJEmahjLR2FRnSVf6QxqyrfY8DLBem68Adx2XdgNIPoOJxLWbmNtd2wT9UoJE8p/S30jFd6noF1tbpp7XRFNDindVa+pKnJrLRhnQvx8DBdhZE2pYtN0G9VPICgPR9oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=juPe55wB; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="juPe55wB"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30c1f6c5559so6156258eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 18:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782178086; x=1782782886; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LGVID2s/5CLQQtWxfisYRAY+6mUEuBvGAkUbioZfLg4=;
        b=juPe55wBD+eY9qBq+f6dQ/Rr+DEysI38VMHKtxHK2B54lwvO2oVpvO91Ps9qY43DDQ
         byTkvtqTr3z5VeiDZaRHjgzHMB5HNXZnP0MxZttmEo0AZCSZenXDUADxw3En+An2bIdr
         eIfJI/yBGYVnlrWY5kHfEa9i8CMqS2sgDue2SOzVC3yDNahrMUXPmnE4pQxufxgh2M0c
         6Afc/Gme/etM0s2dDzrN6DsA8CLQsvjO4TrIB43fQvprhBfUycn8CsXWDddBWhFJZvXR
         uYl4X/iJSEBZIMRs4lHULRNXlxY3OYVfrg5RI/V0ZhXBV1hdtGnvNlZlI7X9MTRfx5GJ
         2D8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782178086; x=1782782886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGVID2s/5CLQQtWxfisYRAY+6mUEuBvGAkUbioZfLg4=;
        b=oV4ok1k07cjgQmLKtYR7S0Pvu2sDji1V7vB3dnkNMYX2+bHeRXraMX4WhuW6LGzjO0
         eE9Bp7YFODOmnMUeH2pncr1zoUdcNr29MJ0CyAdUiybTq5yq/xdE9WMgcYDUzuNEliv4
         ZkK9ewgKIE16rZs+XS5lQLDde3xT9Z+q/EYF5IERcZYD93t7cWi7yn8f+DCFebQWkiFF
         JMFdwczjAe5+W9CsCEZyxw5uwx9N9qcM3y0hWOpWVJdNKEjRPmM189BR48X2jyvsP9GX
         6gM+xYV7xpmCh2igwNqhBTfonIBu7u+YAaYkx3c2igkRyNf9Vt1EUKi6ZQgnW3MJxu/Y
         jkfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9gafX0ySMgZl4rvPg5ev/w+dSeuSRDoee20Z9KRN4zeZPkbTMXl1hmzBvX2ETEIvK8PPtPnA5qInirKzkeflfa@vger.kernel.org
X-Gm-Message-State: AOJu0YwFJ57R/zrgs/mej34cg2ltpAo3CFXb4HnevClCW2koWRB++8D1
	jk82bifnfTmyZNvxTlmbJUZKMIxldM0o9uKFaAZOLWb59BEBmtUE0Zs3pR5lCQEMdiGwxfsIl0T
	32mxPujRcrg==
X-Received: from dlec12-n1.prod.google.com ([2002:a05:701b:428c:10b0:138:7d2:f099])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:b0a:b0:136:b370:64de
 with SMTP id a92af1059eb24-139c6f53460mr232236c88.32.1782178086237; Mon, 22
 Jun 2026 18:28:06 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:27:47 -0700
In-Reply-To: <20260623012758.2291858-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616164819.370939-1-irogers@google.com> <20260623012758.2291858-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623012758.2291858-3-irogers@google.com>
Subject: [PATCH v4 02/13] perf test: Truncate test description to fit terminal width
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The parallel test harness uses the carriage return delete escape sequence
`PERF_COLOR_DELETE_LINE` ("\033[A\33[2K\r") to erase and update the
"Running (X active)" progress lines.

However, if a test description is longer than the terminal width, the line
wraps around. When this happens, the cursor up escape sequence `\033[A`
only moves the cursor to the last wrapped row, leaving the top half of the
description printed on the previous line. This leads to name duplication
and output corruption spilling over multiple rows on consoles narrower
than the maximum description length (e.g., 101 columns wide).

Fix this by dynamically querying the terminal width using
`get_term_dimensions` and truncating the printed test descriptions using
the `%-*.*s` printf format. We reserve 35 characters for prefix, status,
and spacing metrics to guarantee the progress line never wraps.

Fixes: 0e036dcad4e6 ("perf test: Display number of active running tests")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 163 +++++++++++++++++---------------
 1 file changed, 89 insertions(+), 74 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 7e75f590f225..8b8f63f706d9 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -10,37 +10,40 @@
 #ifdef HAVE_BACKTRACE_SUPPORT
 #include <execinfo.h>
 #endif
-#include <poll.h>
-#include <unistd.h>
 #include <setjmp.h>
-#include <string.h>
 #include <stdlib.h>
-#include <sys/types.h>
+#include <string.h>
+
 #include <dirent.h>
-#include <sys/wait.h>
+#include "util/term.h"
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
+#include <poll.h>
+#include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/time.h>
-#include <sys/ioctl.h>
-#include "util/term.h"
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <subcmd/exec-cmd.h>
+#include <subcmd/parse-options.h>
+#include <subcmd/run-command.h>
+
 #include "builtin.h"
+#include "color.h"
 #include "config.h"
+#include "debug.h"
 #include "hist.h"
 #include "intlist.h"
-#include "tests.h"
-#include "debug.h"
-#include "color.h"
-#include <subcmd/parse-options.h>
-#include <subcmd/run-command.h>
 #include "string2.h"
 #include "symbol.h"
+#include "tests-scripts.h"
+#include "tests.h"
 #include "util/rlimit.h"
 #include "util/strbuf.h"
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <subcmd/exec-cmd.h>
-#include <linux/zalloc.h>
-
-#include "tests-scripts.h"
+#include "util/term.h"
 
 static const char *junit_filename;
 static struct strbuf junit_xml_buf = STRBUF_INIT;
@@ -415,73 +418,73 @@ static char *xml_escape(const char *str)
 	return res ? res : strdup("");
 }
 
-static const char *format_test_description(const char *desc, int max_desc_width,
-					  char *buf, size_t buf_sz)
+static int get_term_width(void)
 {
-	int len = strlen(desc);
+	struct winsize ws;
+	int cols = 80;
+	int term_width;
 
 	/*
-	 * Clamp to buf_sz to prevent GCC format-truncation warnings
-	 * when terminal width is very large.
+	 * If output is redirected to a file or piped, we don't need to wrap
+	 * or truncate at all. Use a massive virtually infinite terminal width
+	 * so descriptions are printed in full.
 	 */
-	if (max_desc_width >= (int)buf_sz)
-		max_desc_width = buf_sz - 1;
+	if (!isatty(fileno(debug_file())))
+		return 10000;
 
-	if (len > max_desc_width) {
-		snprintf(buf, buf_sz, "%.*s...", max_desc_width - 3, desc);
-		return buf;
-	}
-	return desc;
+	get_term_dimensions(&ws);
+	if (ws.ws_col > 0)
+		cols = ws.ws_col;
+
+	/*
+	 * Limit description width to fit on a single line. We subtract 35
+	 * columns of headroom to allocate space for:
+	 * - The suite index prefix: e.g. " 10.100:" (8 characters) plus 1 space separator.
+	 * - The trailing colon (1 character) and space before status (1 character).
+	 * - The longest status results: e.g. "Skip (some metrics failed)" (26 characters)
+	 *   or "Running (XX active)" (20 characters).
+	 *
+	 * A minimum description width of 10 is enforced to ensure names are
+	 * legible even on very narrow consoles.
+	 */
+	term_width = cols - 35;
+	if (term_width < 10)
+		term_width = 10;
+
+	return term_width;
+}
+
+static int get_max_desc_width(int width)
+{
+	int term_width = get_term_width();
+
+	return width > term_width ? term_width : width;
 }
 
 static int print_test_result(struct test_suite *t, int curr_suite, int curr_test_case,
 			     int result, int width, int running,
 			     const char *err_output, double elapsed)
 {
-	char desc_buf[256];
-	const char *desc = test_description(t, curr_test_case);
-	struct winsize ws;
-	int max_desc_area_width;
-	int target_desc_area_width;
-	int desc_padding;
-
-	get_term_dimensions(&ws);
-	/*
-	 * Total terminal columns minus space for status e.g. " Running (12 active)"
-	 * which is 20 chars, plus a margin of 3 chars = 23 chars.
-	 */
-	max_desc_area_width = ws.ws_col - 23;
-	if (max_desc_area_width < 40)
-		max_desc_area_width = 40;
-
-	/* Standard test has prefix "%3d: " which is 5 chars */
-	target_desc_area_width = width + 5;
-	if (target_desc_area_width > max_desc_area_width)
-		target_desc_area_width = max_desc_area_width;
+	int pad_width = get_max_desc_width(width);
+	int term_width = get_term_width();
 
 	if (test_suite__num_test_cases(t) > 1) {
 		char prefix[32];
 		int len = snprintf(prefix, sizeof(prefix), "%3d.%1d:",
 				   curr_suite + 1, curr_test_case + 1);
+		int pad = len >= 4 ? pad_width + 4 - len : pad_width;
+		int trunc = len >= 4 ? term_width + 4 - len : term_width;
 
-		desc_padding = target_desc_area_width - (len + 1);
-		if (desc_padding < 20)
-			desc_padding = 20;
-
-		desc = format_test_description(desc, desc_padding, desc_buf, sizeof(desc_buf));
-		pr_info("%s %-*s:", prefix, desc_padding, desc);
+		pr_info("%s %-*.*s:", prefix, pad, trunc,
+			test_description(t, curr_test_case));
 	} else {
-		desc_padding = target_desc_area_width - 5;
-		if (desc_padding < 20)
-			desc_padding = 20;
-
-		desc = format_test_description(desc, desc_padding, desc_buf, sizeof(desc_buf));
-		pr_info("%3d: %-*s:", curr_suite + 1, desc_padding, desc);
+		pr_info("%3d: %-*.*s:", curr_suite + 1, pad_width, term_width,
+			test_description(t, curr_test_case));
 	}
 
 	switch (result) {
 	case TEST_RUNNING:
-		color_fprintf(stderr, PERF_COLOR_YELLOW, " Running (%d active)\n", running);
+		color_fprintf(debug_file(), PERF_COLOR_YELLOW, " Running (%d active)\n", running);
 		break;
 	case TEST_OK:
 		if (test_suite__num_test_cases(t) > 1)
@@ -495,9 +498,9 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 
 		summary_tests_skipped++;
 		if (reason)
-			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (%s)\n", reason);
+			color_fprintf(debug_file(), PERF_COLOR_YELLOW, " Skip (%s)\n", reason);
 		else
-			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip\n");
+			color_fprintf(debug_file(), PERF_COLOR_YELLOW, " Skip\n");
 	}
 		break;
 	case TEST_FAIL:
@@ -511,7 +514,7 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 			strbuf_addf_safe(&summary_failed_tests_buf, "  %3d: %s\n",
 				    curr_suite + 1,
 				    test_description(t, curr_test_case));
-		color_fprintf(stderr, PERF_COLOR_RED, " FAILED!\n");
+		color_fprintf(debug_file(), PERF_COLOR_RED, " FAILED!\n");
 		break;
 	}
 
@@ -747,6 +750,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	int ret;
 	struct timespec end_time;
 	double elapsed;
+	width = get_max_desc_width(width);
 
 	if (child_test == NULL) {
 		/* Test wasn't started. */
@@ -761,7 +765,8 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	 * sub test names.
 	 */
 	if (test_suite__num_test_cases(t) > 1 && curr_test_case == 0)
-		pr_info("%3d: %s:\n", curr_suite + 1, test_description(t, -1));
+		pr_info("%3d: %-*.*s:\n", curr_suite + 1, width, width,
+			test_description(t, -1));
 
 	/*
 	 * Busy loop reading from the child's stdout/stderr that are set to be
@@ -969,6 +974,8 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 	int last_suite_printed = -1;
 	sigset_t set, oldset;
 
+	width = get_max_desc_width(width);
+
 	sigemptyset(&set);
 	sigaddset(&set, SIGINT);
 	sigaddset(&set, SIGTERM);
@@ -1037,8 +1044,11 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 			if (next_child) {
 				if (test_suite__num_test_cases(next_child->test) > 1 &&
 				    last_suite_printed != next_child->suite_num) {
-					pr_info("%3d: %s:\n", next_child->suite_num + 1,
-						test_description(next_child->test, -1));
+					pr_info("%3d: %-*.*s:\n",
+						next_child->suite_num + 1,
+						width, width,
+						test_description(
+							next_child->test, -1));
 					last_suite_printed = next_child->suite_num;
 				}
 				print_test_result(next_child->test, next_child->suite_num,
@@ -1101,7 +1111,8 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 
 			if (test_suite__num_test_cases(child->test) > 1 &&
 			    last_suite_printed != child->suite_num) {
-				pr_info("%3d: %s:\n", child->suite_num + 1,
+				pr_info("%3d: %-*.*s:\n", child->suite_num + 1,
+					width, width,
 					test_description(child->test, -1));
 				last_suite_printed = child->suite_num;
 			}
@@ -1225,12 +1236,12 @@ static void print_tests_summary(void)
 	pr_info("Passed subtests   : %u\n", summary_subtests_passed);
 	pr_info("Skipped tests     : %u\n", summary_tests_skipped);
 	if (summary_tests_failed > 0) {
-		color_fprintf(stderr, PERF_COLOR_RED, "Failed tests      : %u\n",
+		color_fprintf(debug_file(), PERF_COLOR_RED, "Failed tests      : %u\n",
 			      summary_tests_failed);
 		pr_info("List of failed tests:\n");
 		pr_info("%s", summary_failed_tests_buf.buf);
 	} else {
-		color_fprintf(stderr, PERF_COLOR_GREEN, "Failed tests      : 0\n");
+		color_fprintf(debug_file(), PERF_COLOR_GREEN, "Failed tests      : 0\n");
 	}
 
 	if (junit_filename) {
@@ -1348,9 +1359,13 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 
 			if (intlist__find(skiplist, curr_suite + 1)) {
 				if (pass == 1) {
-					pr_info("%3d: %-*s:", curr_suite + 1, width,
+					int pad_width = get_max_desc_width(width);
+					int term_width = get_term_width();
+
+					pr_info("%3d: %-*.*s:", curr_suite + 1,
+						pad_width, term_width,
 						test_description(*t, -1));
-					color_fprintf(stderr, PERF_COLOR_YELLOW,
+					color_fprintf(debug_file(), PERF_COLOR_YELLOW,
 						      " Skip (user override)\n");
 					summary_tests_skipped++;
 					if (junit_filename) {
-- 
2.55.0.rc0.786.g65d90a0328-goog

