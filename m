Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1C8378806
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573143; cv=none; b=WDpkChcq0eCVnCdcoK756+7yYl3f/oDSfENb1/1w8zhLXhcywQuX0SoPTSpZ5rOX0CXzkfsy2y35mQLzACseP3idNhQkb4EXMi1P8eJoqH3mE/3P3F8c1QgPRZ8ZtNqVkFa8jbPcSHQfbTERzW9T8BDpX5QovVVUjmgs0rVeeYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573143; c=relaxed/simple;
	bh=UzdIExalqgMBl+qFX8/M8Rngawk3KjIUSLugpUFlZA8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lDyBxzP1VEch+W4vNx6S1kSK+0FIaY1QIWlqeBf5W7VN8l1ZJ4nxCxJaTFA338SsGcVQFdjAhtf24ijYvSZkiGsMoJ8TRwhvulCkvnDe3bHWLa124JcZTbljXP2UhnzoLyieoM+ejvJskEBLP+gz5Oi4FENQEMJClRn5AXx7Upo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t20h8T3b; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t20h8T3b"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13967c19ac6so7811548c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573141; x=1782177941; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JlRoBVJHRYK5bu2ZeezJDPsCPj7kTX7KAale6/6pVpA=;
        b=t20h8T3bxhSNkNpHGMfD0MDegPpV+W5peR0RIfvMXdcvh4hJMNZ9sxpiUeLgEIfe+o
         pJz8T2yNS+dD/S4k8qIz68J1EMOCDokMo3tVRhf6Co1P5cpMcokLXPDC6UlwBlZI8fsx
         K4dXtHrxH7jW5eXk0d9Zq+6wRDCc7fkqEgddXXNp5oI0o948PYcOblqjDSQh7EMv7i6Q
         HYfB/v9n74IxBOw91IAmQS90pfXs9FKlux49gOUifND2szJscwzy1+DuuZ40hRmVgMlk
         NqD5JecVPcH2CmzXl+J+rfKdAmvVZl4L+A5TMQ7YIvVNmUJagJN13mzJzROuSLQ/c/gE
         lk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573141; x=1782177941;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JlRoBVJHRYK5bu2ZeezJDPsCPj7kTX7KAale6/6pVpA=;
        b=pvGrU5xrCJwhrqcLvFxn9l3loBowjwY7eQxJMSTWavWhb4OoFdeJHQ27OUyXC0lqGL
         6Imo1TsMopDIPhJU9tkbh+KutPSXE0Admwu0ofwnHdd+p+tO7cfhH6chyTdyBvlxkJfb
         /0mFtlvJFl7tOa96bhO39VYunlRYz6ccs7+GqJFdl7lO419yUZyed0s/LFdGNBa/ktvZ
         FQEheErjU/WywFle/nRUauBGDjMsIQiGCQKOL4GPFKX7cauK2GT2XXINCOXfhAUKT4nL
         S4QIpwk0OB5TdbybXQEda1S9WSzDWilMBfFbzv/j66IhUensAxJhLQMml4hnsTNcUJ42
         G91Q==
X-Forwarded-Encrypted: i=1; AFNElJ8VcsWOMJ5CjU0pz0XIcjy5OBuQzMjjjxa7W2Xi4pdbMTq1SSf7BQb6Dkd1bVjVLUgmegcwD3jk1Erx+Yr9BLNX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz70S0CyNt1nDx2kjuGYkrNs4VjzqoquiXBErDvHqGdPscvtjSz
	mqcVK/8P5zFXrF4u2GzRaVbGjfC0ib+r/xXElFlOD8Jk6qmz1WTOINLt0hJybMpyIyrRVoQYjjb
	WQ1yh7VPDtA==
X-Received: from dybcr37.prod.google.com ([2002:a05:7300:aca5:b0:2d8:1265:1a34])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:62db:b0:30b:9e57:1e6b
 with SMTP id 5a478bee46e88-30b9e571f98mr1452984eec.17.1781573141094; Mon, 15
 Jun 2026 18:25:41 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:25:11 -0700
In-Reply-To: <20260616012521.4045202-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012521.4045202-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012521.4045202-3-irogers@google.com>
Subject: [PATCH v1 02/12] perf test: Truncate test description to fit terminal width
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Leo Yan <leo.yan@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The parallel test harness uses the carriage return delete escape sequence
`PERF_COLOR_DELETE_LINE` ("\033[A\33[2K\r") to erase and update the
"Running (X active)" progress lines.

However, if a test description is longer than the terminal width, the line
wraps around. When this happens, the cursor up escape sequence `\033[A` only
moves the cursor to the last wrapped row, leaving the top half of the description
printed on the previous line. This leads to name duplication and output corruption
spilling over multiple rows on consoles narrower than the maximum description length
(e.g., 101 columns wide).

Fix this by dynamically querying the terminal width using `get_term_dimensions`
and truncating the printed test descriptions using the `%-*.*s` printf format.
We reserve 35 characters for prefix, status, and spacing metrics to guarantee
the progress line never wraps.

Fixes: 0e036dcad4e6 ("perf test: Display number of active running tests")
Signed-off-by: Ian Rogers <irogers@google.com>
TAG=agy
CONV=7e7ee33a-e940-4a8a-8e64-878da6a68b59
---
 tools/perf/tests/builtin-test.c | 95 ++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 24 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index afc06cec4954..51484e84d7c1 100644
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
@@ -413,19 +417,52 @@ static char *xml_escape(const char *str)
 	return res ? res : strdup("");
 }
 
+static int get_max_desc_width(int width)
+{
+	struct winsize ws;
+	int cols = 80;
+	int max_desc_width;
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
+	max_desc_width = cols - 35;
+	if (max_desc_width < 10)
+		max_desc_width = 10;
+
+	return width > max_desc_width ? max_desc_width : width;
+}
+
 static int print_test_result(struct test_suite *t, int curr_suite, int curr_test_case,
 			     int result, int width, int running,
 			     const char *err_output, double elapsed)
 {
+	width = get_max_desc_width(width);
+
 	if (test_suite__num_test_cases(t) > 1) {
 		char prefix[32];
 		int len = snprintf(prefix, sizeof(prefix), "%3d.%1d:",
 				   curr_suite + 1, curr_test_case + 1);
 		int subw = len >= 4 ? width + 4 - len : width;
 
-		pr_info("%s %-*s:", prefix, subw, test_description(t, curr_test_case));
-	} else
-		pr_info("%3d: %-*s:", curr_suite + 1, width, test_description(t, curr_test_case));
+		pr_info("%s %-*.*s:", prefix, subw, subw,
+			test_description(t, curr_test_case));
+	} else {
+		pr_info("%3d: %-*.*s:", curr_suite + 1, width, width,
+			test_description(t, curr_test_case));
+	}
 
 	switch (result) {
 	case TEST_RUNNING:
@@ -695,6 +732,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	int ret;
 	struct timespec end_time;
 	double elapsed;
+	width = get_max_desc_width(width);
 
 	if (child_test == NULL) {
 		/* Test wasn't started. */
@@ -709,7 +747,8 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	 * sub test names.
 	 */
 	if (test_suite__num_test_cases(t) > 1 && curr_test_case == 0)
-		pr_info("%3d: %-*s:\n", curr_suite + 1, width, test_description(t, -1));
+		pr_info("%3d: %-*.*s:\n", curr_suite + 1, width, width,
+			test_description(t, -1));
 
 	/*
 	 * Busy loop reading from the child's stdout/stderr that are set to be
@@ -917,6 +956,8 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 	int last_suite_printed = -1;
 	sigset_t set, oldset;
 
+	width = get_max_desc_width(width);
+
 	sigemptyset(&set);
 	sigaddset(&set, SIGINT);
 	sigaddset(&set, SIGTERM);
@@ -985,8 +1026,11 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
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
@@ -1049,7 +1093,8 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 
 			if (test_suite__num_test_cases(child->test) > 1 &&
 			    last_suite_printed != child->suite_num) {
-				pr_info("%3d: %-*s:\n", child->suite_num + 1, width,
+				pr_info("%3d: %-*.*s:\n", child->suite_num + 1,
+					width, width,
 					test_description(child->test, -1));
 				last_suite_printed = child->suite_num;
 			}
@@ -1296,7 +1341,9 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 
 			if (intlist__find(skiplist, curr_suite + 1)) {
 				if (pass == 1) {
-					pr_info("%3d: %-*s:", curr_suite + 1, width,
+					int max_width = get_max_desc_width(width);
+
+					pr_info("%3d: %-*.*s:", curr_suite + 1, max_width, max_width,
 						test_description(*t, -1));
 					color_fprintf(stderr, PERF_COLOR_YELLOW,
 						      " Skip (user override)\n");
-- 
2.54.0.1136.gdb2ca164c4-goog

