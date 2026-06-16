Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6F0322C88
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573275; cv=none; b=Jnflnm73W23kLHpHUa+1rnloqKn5k3UufK6z5dOOelgvfBtMJmXoc0de4FhzZJcxJxc2uYjxUv1znBSys+vbk8Tn3+rv1qfPJRj+rsZVhGb1SJSVg9xTgxJedDBAP7QSBIO3ebsZLfXRcRClySB6FuEsokox29gBfKod/DMrYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573275; c=relaxed/simple;
	bh=ENH5hP9aGzKETqso2LBvAyTBhflFN1/U+GCJnpEfJcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dmeH8aPo8gDZopXA7IbCBDqxBH1iQ9frxO5SshytAs0LBMwDuSZih6b72xcfygDu22EQTeNof6z9pIukCC6sUZqy5TU6brbQvjA9FQkJBOhFabDAu/Le74xVxnXZCCW7Echt0fS+I3MAo7goBV96LeU2O6uOfOMyZfh2xbHxe2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ITAcgnNk; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITAcgnNk"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304e7fc90b1so4528122eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573273; x=1782178073; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cT6WG9kw9RfGQcCRsKkhgwBfCQ93XVJMyY7O3hVY3J4=;
        b=ITAcgnNkujXqjzRjih85l0fWRJXZ7roNJEdz1OEQmKXDJzgVx8PZHZDMpowzwknpu4
         kRcmizQ2RnV1+p1eLdiTp8B0QFcB9o3mZsTNhKveMMkw12QiLczxkqUUKTIqc1ezwEMm
         covcSNDxqg0pGbyAD91h39oph6UrS9E96aGe1TqmG8MoesDY6xVH3kkXXri3R7EGVkY9
         gkgkjA2HXmcpSay3Uf/EWx/08sS3EsSt/F2PU/YNvSPzci3DVmJsbvHutwZtGokvHv80
         4BRUBOgAxEjdKbD8VQKXrYoX70YqDWdegMP5zti82aEIJokVGFfaddyZ2MGTJWxtGLAU
         bD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573273; x=1782178073;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cT6WG9kw9RfGQcCRsKkhgwBfCQ93XVJMyY7O3hVY3J4=;
        b=rnVj9J5gBb1W3pV33obudNU8Lv6sh/mDYFZmx6RPy7LuOLibNmIEqT9GVb+rnrVziC
         ryxbXOq50q3mZ6b4UmWLoOuaMsKU10cRKV1jDM1Rj/unWwltNRzxDkcBYcKFO7q/YQ8f
         IX9RZx67MVGwOGVs+AK9GFgm9Xe4j3aBdn+9fvRIqLPuiNric5i7Rw6bYjkTxSV8oDSv
         K3y4inqfP5fZWZQWnRYaXr1DCq8Pw+XMwp0SdfN2aWQqyUF9G7B2PRvu07jLdq1o/Bcr
         skfqALob3mVH/BCkW9LS3Xj2VDHIfRfs002twP0zPRexQWGKUbdI2xh3dNpmFyPAi3/d
         dqrw==
X-Forwarded-Encrypted: i=1; AFNElJ+MM4izXkt7CkLa5F7FiI/TvbXdJbbA0lPeUmJpfIzkEmwSFw4mePrulm9Kn+xhbVhqYDdhjGtzappV4z/PLs/l@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZCW4FaQl0BAMVihA4m0Eqdl3Ou0DLICTD3h3AwIudLzZ4aF2
	tSjwiRQZPhSzufzFrwnhRZuY7/4vMwdPIigrDIf9FiVNKCURrBf10f0CVncCZaQymdv5aBa2Xkv
	hEoa88HpzEA==
X-Received: from dlbrh19.prod.google.com ([2002:a05:7022:f313:b0:137:ebca:4053])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:61a7:b0:136:6883:c4bf
 with SMTP id a92af1059eb24-1386f352332mr5075159c88.15.1781573272371; Mon, 15
 Jun 2026 18:27:52 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:27:34 -0700
In-Reply-To: <20260616012744.4049193-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012744.4049193-3-irogers@google.com>
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

