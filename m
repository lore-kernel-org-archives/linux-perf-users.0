Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07355472769
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628511; cv=none; b=a4P06/szEbb4d3tg82fABcJnbcn2T6XlyYM9WqQXHLv/Ms4OgJfzaFxT1P+bFhCM69PszFgsNoCNoMraN0HSEpxfs+6NzOzmORWXVffWqLfDY65QfM3Fg122bVdXKJOUwAXlDDMgl/2desC0TQbbbeBJZIAP7KJvtevSfhrWpiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628511; c=relaxed/simple;
	bh=m0drLFA8fZj9XchC6nhNwZXNbRRsGjX1ymFrloCGWxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NpKNC3Rzm9ZjNYod3OCKQXD02D+8LsxR8coLSXa/UQxQVAmvIKqM1XqeJxt3Ge3HcveWb24z4TXJ4/gCfu9chZuTg0iIZf3FNq1z4n5+Ct1n8w/s6y6WDr7dBbP4Vk4Tr3FKBT5hFGAyF6zEWG3tl+pYcrfa1ulbaN+fexb8zco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a0JuG+Lu; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0JuG+Lu"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304ea42b025so37063eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 09:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781628509; x=1782233309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LfiOHRcHDNiJHCXY8qRbLBjpMusERhA7phXhCQOg00U=;
        b=a0JuG+LuVe3inNiORU35PTrRWyTPyaGNm0nVA9fFvtG2qNvaRk7YSIdZZNwSG1HJpk
         8hrbpq8b473c8OQYNVuTTqMjNg0rzMXu+er6bj2DqNu0qCipFKSibt+mmgHPIBiTCyqr
         GD6R13FEQ89zHfhiuuflvIYoEPVSs8oMpsPAt6jFv57sl9iDdbrYLO+Hgg3CvP0boqLD
         RLXVfgSyWaeHHi9XKsvNgWJKeZ+6ObCQXQ8d/oGyvueGxksbk3/ovqduq7h7l0de6M2G
         0HE2MvCydIl4T23k4rzCO1WqJ5f2uW6zxg9cMdUoTHo/cxJrHImBObeXeVjLyO3i61kZ
         xWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628509; x=1782233309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfiOHRcHDNiJHCXY8qRbLBjpMusERhA7phXhCQOg00U=;
        b=JfFBiJfpT616KfGNjwz3QfY0+e+t7e6V5ZzS/DKGgR7pqVoA1hf8k+3ixi5FDIfeLr
         CtRPqvh03EEJofMmD24sAVu87AIsfcnw2k3EknjQQ1iSD91vBy/t9K5U3iCvcekmtg8T
         q1ZCeMVdBBh/OeXHsgW1aHlik5bY02AprNzmTynLPHw9nzXKfAiYEx2O6j1HTBPhOvmI
         3nwHEoGK7NYZZnKdVg6jIp1qcK8d3k9VUPB4AifNSZJQxl1LRbYZylGU4bLSaAvQ/eRr
         37yWHpnVphKfgccltMKcty3HwHDEBGht7elaLfjhzMg5JnAY+A2ccLwSqdp1/qjEpmDp
         9swA==
X-Forwarded-Encrypted: i=1; AFNElJ+fw09Myj0pjv+bNpMo8XKy4EoW3MesvyyKxdnDSkMyrAhucC8PWZEdgUrAgnHN0neC4xLJXYwkIrqayErXuQFw@vger.kernel.org
X-Gm-Message-State: AOJu0YxGud0ohnKqcuTfmlEdAPxuLoteW+Y+/dDad0AXg2Bf5f44onlh
	miZzuP0+mdlgkoZE8M1EZ9klJWwVddgirwBNJOUcrxWvDBjfJFgOHh1Uhx0wBezbbOAsuJnwu5j
	Bolu3hV6MZA==
X-Received: from dybff20.prod.google.com ([2002:a05:7300:bf14:b0:304:5761:e0e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:588d:b0:30b:9b89:7ea6
 with SMTP id 5a478bee46e88-30ba3368bb8mr1943765eec.6.1781628508921; Tue, 16
 Jun 2026 09:48:28 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:48:07 -0700
In-Reply-To: <20260616164819.370939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616061404.41929-1-irogers@google.com> <20260616164819.370939-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616164819.370939-3-irogers@google.com>
Subject: [PATCH v3 02/13] perf test: Truncate test description to fit terminal width
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
 tools/perf/tests/builtin-test.c | 130 ++++++++++++++++++++++++--------
 1 file changed, 98 insertions(+), 32 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index afc06cec4954..1dcaeb8505b7 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -10,35 +10,39 @@
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
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
+#include <poll.h>
+#include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/time.h>
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
@@ -413,23 +417,73 @@ static char *xml_escape(const char *str)
 	return res ? res : strdup("");
 }
 
+static int get_term_width(void)
+{
+	struct winsize ws;
+	int cols = 80;
+	int term_width;
+
+	/*
+	 * If output is redirected to a file or piped, we don't need to wrap
+	 * or truncate at all. Use a massive virtually infinite terminal width
+	 * so descriptions are printed in full.
+	 */
+	if (!isatty(fileno(debug_file())))
+		return 10000;
+
+	get_term_dimensions(&ws);
+	if (ws.ws_col > 0)
+		cols = ws.ws_col;
+
+	/*
+	 * Limit description width to fit on a single line. We subtract 35
+	 * columns of headroom to allocate space for:
+	 * - The suite index prefix: e.g. " 10.100:" (9 characters).
+	 * - The colon separator and spaces: " : " (3 characters).
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
+}
+
 static int print_test_result(struct test_suite *t, int curr_suite, int curr_test_case,
 			     int result, int width, int running,
 			     const char *err_output, double elapsed)
 {
+	int pad_width = get_max_desc_width(width);
+	int term_width = get_term_width();
+
 	if (test_suite__num_test_cases(t) > 1) {
 		char prefix[32];
 		int len = snprintf(prefix, sizeof(prefix), "%3d.%1d:",
 				   curr_suite + 1, curr_test_case + 1);
-		int subw = len >= 4 ? width + 4 - len : width;
+		int pad = len >= 4 ? pad_width + 4 - len : pad_width;
+		int trunc = len >= 4 ? term_width + 4 - len : term_width;
 
-		pr_info("%s %-*s:", prefix, subw, test_description(t, curr_test_case));
-	} else
-		pr_info("%3d: %-*s:", curr_suite + 1, width, test_description(t, curr_test_case));
+		pr_info("%s %-*.*s:", prefix, pad, trunc,
+			test_description(t, curr_test_case));
+	} else {
+		pr_info("%3d: %-*.*s:", curr_suite + 1, pad_width, term_width,
+			test_description(t, curr_test_case));
+	}
 
 	switch (result) {
 	case TEST_RUNNING:
-		color_fprintf(stderr, PERF_COLOR_YELLOW, " Running (%d active)\n", running);
+		color_fprintf(debug_file(), PERF_COLOR_YELLOW, " Running (%d active)\n", running);
 		break;
 	case TEST_OK:
 		if (test_suite__num_test_cases(t) > 1)
@@ -443,9 +497,9 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 
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
@@ -459,7 +513,7 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 			strbuf_addf_safe(&summary_failed_tests_buf, "  %3d: %s\n",
 				    curr_suite + 1,
 				    test_description(t, curr_test_case));
-		color_fprintf(stderr, PERF_COLOR_RED, " FAILED!\n");
+		color_fprintf(debug_file(), PERF_COLOR_RED, " FAILED!\n");
 		break;
 	}
 
@@ -695,6 +749,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	int ret;
 	struct timespec end_time;
 	double elapsed;
+	width = get_max_desc_width(width);
 
 	if (child_test == NULL) {
 		/* Test wasn't started. */
@@ -709,7 +764,8 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	 * sub test names.
 	 */
 	if (test_suite__num_test_cases(t) > 1 && curr_test_case == 0)
-		pr_info("%3d: %-*s:\n", curr_suite + 1, width, test_description(t, -1));
+		pr_info("%3d: %-*.*s:\n", curr_suite + 1, width, width,
+			test_description(t, -1));
 
 	/*
 	 * Busy loop reading from the child's stdout/stderr that are set to be
@@ -917,6 +973,8 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 	int last_suite_printed = -1;
 	sigset_t set, oldset;
 
+	width = get_max_desc_width(width);
+
 	sigemptyset(&set);
 	sigaddset(&set, SIGINT);
 	sigaddset(&set, SIGTERM);
@@ -985,8 +1043,11 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 			if (next_child) {
 				if (test_suite__num_test_cases(next_child->test) > 1 &&
 				    last_suite_printed != next_child->suite_num) {
-					pr_info("%3d: %-*s:\n", next_child->suite_num + 1, width,
-						test_description(next_child->test, -1));
+					pr_info("%3d: %-*.*s:\n",
+						next_child->suite_num + 1,
+						width, width,
+						test_description(
+							next_child->test, -1));
 					last_suite_printed = next_child->suite_num;
 				}
 				print_test_result(next_child->test, next_child->suite_num,
@@ -1049,7 +1110,8 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 
 			if (test_suite__num_test_cases(child->test) > 1 &&
 			    last_suite_printed != child->suite_num) {
-				pr_info("%3d: %-*s:\n", child->suite_num + 1, width,
+				pr_info("%3d: %-*.*s:\n", child->suite_num + 1,
+					width, width,
 					test_description(child->test, -1));
 				last_suite_printed = child->suite_num;
 			}
@@ -1173,12 +1235,12 @@ static void print_tests_summary(void)
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
@@ -1296,9 +1358,13 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 
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
2.54.0.1189.g8c84645362-goog

