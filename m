Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4133DA7F4
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590455; cv=none; b=dTgFh9uIEmLgkKE2K4z++FTb9A3yDSbkLvrGI68aFZv8o/lelQh7eMvQONWxkDg46O/tDS04VYonG0yZpba/tvPPSF9pTqDs7D16czlNZ9Egrg3B2kRHjgWKNLcUNYDnmYZ4lKbZWILlv6vdpAEg4YQh5vPHsHC+BOJmjr25dy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590455; c=relaxed/simple;
	bh=pVqJOM/DCHjlsZkQ3Oa2H6oxFi0y0Eg3DnoU++nXCV8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VFCaHq8R534hj5hqjFwkRUhJ36AdHAr9Gw4uvKeI1RVpqJenpB3+X+JsuRIdyaS4EftgNdd0KKqI6DsysayaUacuX8w/4L5mbyS540gq6kDM1FfZBccF8+MtUtltyEn/tMd+NR/AwjNNtX39vvpZ+UrNyi6sPIgjUsumBMj/Y80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RLEivPRu; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RLEivPRu"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304b8d0ee63so6623457eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 23:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781590453; x=1782195253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u6VkjScT6W5m4kXmq5IK2WvFrGlCYmLr/PMN/qRKbpM=;
        b=RLEivPRuJXqGl9NEGd7TEje4tu0yOiD2JuCL6MQhRzyJAE/qGV69mv6JY2PEtfqIlP
         OO/I+21SL0ND/tGDP+R4Biet6Botg+Am0nLnEozX1ncnbSXDuUHXy8raCd84yR9Eui8/
         wNj16f7XaDgaotQruApS7c9O6WMA/OC19bAVqB9PTt10w7ED2PFL5Ajjknr2cN0cqE1R
         qY7ynH6Rh5vrDkygDXF4+zmhlTGW0TPEgE/sGyyiBMbngKXdE6kX0d980wmKNh4mlCsZ
         D9qjNGXnZ8mkftM3+3iAqR3QxJ8DrEnpW0h8LhOx3XHZ5XtB31sLIg/IPMIvzKXRAGn2
         sdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781590453; x=1782195253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6VkjScT6W5m4kXmq5IK2WvFrGlCYmLr/PMN/qRKbpM=;
        b=C1RErTfO7u9GddgS3PHa6VOcr6APj+tPfuZzXqjizPO+KLyvtx+aCkh1SBWbtqSPVm
         Nn2OYqi9CMBWried5rMtAQTZB623iaj+rzg3M8BRHBXjZiHHIRzMR4rtfsBmDeNG3U8L
         DU9nGQ5S+OsL1Z9Pkkfmqv4zDdgMwwYKYzzve+Lq5/KiikvIzQOSMM6cg627IrnD8Wpx
         I2w/dt2X16IBRjHT1QuixJL/ar0/6PZTo5nYnzv6oT4cwVip80TDiKhmzuRZ35qX0Wug
         booRmakPAvT8dh0MitTi+zjBIwaFaOKwtlNHEyAGrsZmUkQz9lYoIJtZb294c7TnTOjs
         rYrA==
X-Forwarded-Encrypted: i=1; AFNElJ8avvpiHrswF019y56wLjCQWkiKLPK5xntp6wXjjxddZ56faVoyKXJwCe2pMvWX+l6ex4iwve5WlLK00U9tbIrl@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe3auf6LX0ZvU4Ri/JWi12XwnX1BhwivzJt0VQFC6rQ00BqZpU
	R+IXd+0vtg5QjKyiUQV2/Z6PZMaI3qIPk5tJcCUih99ZzlaoMhSbUxyZZQ2vwxPRcF+Q0L3KtNv
	kSGWhmp5zZw==
X-Received: from dyju27.prod.google.com ([2002:a05:7300:7a9b:b0:304:cffc:fdf7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:68d4:b0:30a:e52d:fb27
 with SMTP id 5a478bee46e88-30ae52e0013mr4514093eec.11.1781590452292; Mon, 15
 Jun 2026 23:14:12 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:13:54 -0700
In-Reply-To: <20260616061404.41929-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com> <20260616061404.41929-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616061404.41929-3-irogers@google.com>
Subject: [PATCH v2 02/12] perf test: Truncate test description to fit terminal width
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
 tools/perf/tests/builtin-test.c | 110 ++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 25 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index afc06cec4954..65a2dc50ef55 100644
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
@@ -413,19 +417,64 @@ static char *xml_escape(const char *str)
 	return res ? res : strdup("");
 }
 
+static int get_term_width(void)
+{
+	struct winsize ws;
+	int cols = 80;
+	int term_width;
+
+	if (!isatty(1))
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
@@ -695,6 +744,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	int ret;
 	struct timespec end_time;
 	double elapsed;
+	width = get_max_desc_width(width);
 
 	if (child_test == NULL) {
 		/* Test wasn't started. */
@@ -709,7 +759,8 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	 * sub test names.
 	 */
 	if (test_suite__num_test_cases(t) > 1 && curr_test_case == 0)
-		pr_info("%3d: %-*s:\n", curr_suite + 1, width, test_description(t, -1));
+		pr_info("%3d: %-*.*s:\n", curr_suite + 1, width, width,
+			test_description(t, -1));
 
 	/*
 	 * Busy loop reading from the child's stdout/stderr that are set to be
@@ -917,6 +968,8 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 	int last_suite_printed = -1;
 	sigset_t set, oldset;
 
+	width = get_max_desc_width(width);
+
 	sigemptyset(&set);
 	sigaddset(&set, SIGINT);
 	sigaddset(&set, SIGTERM);
@@ -985,8 +1038,11 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
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
@@ -1049,7 +1105,8 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 
 			if (test_suite__num_test_cases(child->test) > 1 &&
 			    last_suite_printed != child->suite_num) {
-				pr_info("%3d: %-*s:\n", child->suite_num + 1, width,
+				pr_info("%3d: %-*.*s:\n", child->suite_num + 1,
+					width, width,
 					test_description(child->test, -1));
 				last_suite_printed = child->suite_num;
 			}
@@ -1296,7 +1353,10 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 
 			if (intlist__find(skiplist, curr_suite + 1)) {
 				if (pass == 1) {
-					pr_info("%3d: %-*s:", curr_suite + 1, width,
+					int pad_width = get_max_desc_width(width);
+					int term_width = get_term_width();
+
+					pr_info("%3d: %-*.*s:", curr_suite + 1, pad_width, term_width,
 						test_description(*t, -1));
 					color_fprintf(stderr, PERF_COLOR_YELLOW,
 						      " Skip (user override)\n");
-- 
2.54.0.1136.gdb2ca164c4-goog

