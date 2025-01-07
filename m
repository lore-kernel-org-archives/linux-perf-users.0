Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5D819DF75
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736287320; cv=none; b=O7jqUoiz/TDmvDJQO56DnUkIO/Bsz/sAYgkLdg2EEg585YYDFzKqhb3VFh4z3kTD3494jZ+/XaeQslPfRx6Qy2BINoyZxDm/MZzAjajO82WHrPDZN+cctHJogHsVe89bYF9lmyMP23xLiPblhl0OrChFQ/DmNvJjsCvmWihm35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736287320; c=relaxed/simple;
	bh=oe8jug5TfATH6UqI+SDmWJVfhN4/Z1/tSDQisOCdIus=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KFukDobsXLPYOJr7foNy1XBWT/xeLNB/PgPQSGUkdy1P2ZTuwqbpGOa1Uu1gP4UwBNZ6xupevMe5XX9IPC3vE66oxT0lVtqYqY5YxD0WtgzkoBLIujRsR9+sWRdl/JGZuOaxdqav8kRRyRGwfqlRqMfD+71jXQ3AvLkxwI9dVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TrnhdXlO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TrnhdXlO"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e48beea5778so35082064276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 14:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736287317; x=1736892117; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rt3FANMhbwUxwhbrCeMm//1cFuRBbV1k6BaJKVQj2ZQ=;
        b=TrnhdXlOiYdQAQvhHfHNvJX6aygRQh2Mb3cW4fgq5hsrh+3x5EXP8hAGJKF5gJtUr6
         ngdv6Uu7BDd3G95KumyA62Q4TVVSAOxqW7zuJ5PO/j0c8Ahr533tdjeJEhBUgifSmior
         BXplMWaddThQtwzQNXlHPowdXS6f8Wdpj0bOO6mT5I8YQE8eW3+ivzexjm6cK8Gh6efo
         qzOyltXeWVL71AmvDxv3njiqS7GH5Q8P8LzAWMiLy/dWZSCyOu/3ytfZ95jpS9jBGe0D
         EEkmEMvQ4zTc3J9Dq6iYExd5+T2mnpoY5ZwWiJREI0/NKTngVcMOB3KAfyohkmXD0bwb
         YB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736287317; x=1736892117;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rt3FANMhbwUxwhbrCeMm//1cFuRBbV1k6BaJKVQj2ZQ=;
        b=afHJY0zODBaHLjXHCGzMah9thj6Q6v1KYPl65oA5xrGcOTNMmVjDgnMIMG9FBpenWl
         3u41869YfXwfyJhe7WfanB554SQ8C0WemAWO5+FFbIefY2e0Su75nG9lD2OLlhD+/qC6
         gOtOOVDCYxFIEyB5N37oy1L6m6N4Aa2Yc1DvOI6QcMh8I1RSEMeHxQPnIl7xZXqIJqN+
         Ey9MJu7ge/O65cWgu8FzaJGjPvY0CJeBYurXQ3tzoVhj7+U+07gj+7Iy5ledKcr9Q+te
         Eg3XM7IXin9g31QvBWuU4HdRTqAZFtLEdn09hZCsMob4T5pst3gQy4QlZrYRflruh/po
         ZmBw==
X-Forwarded-Encrypted: i=1; AJvYcCV9JpYIVQUkUj7YCm4ANiHvFcxQqpsDZVGKzB/vTy2GCr9WMlkhOnK3sItcavHNGVtXfRerV/vgI4CqnNnAinl3@vger.kernel.org
X-Gm-Message-State: AOJu0YwriAB6FChLPmEwZuDuDY3VaIMpaELnVew9ak/fPhZGLqUiai36
	eFgbOPKTwvj9sl33Ux+FDnLrdvhOAQyxzLVwaRkV9+WRolkT70zL4ol/2wGVVQCg6cUuKmvGsKc
	t+OHZSw==
X-Google-Smtp-Source: AGHT+IFsdGsWszeaH2lo56RdgKwjyEciPXbixsTmDkJMCQHpqooQogMJfc+S6jjCfXmtpY/dcBdzyWB+wUYr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ae:a887:5504:e3ca])
 (user=irogers job=sendgmr) by 2002:a25:ae44:0:b0:e4b:7d0c:7c63 with SMTP id
 3f1490d57ef6-e54eff2f037mr465276.4.1736287317674; Tue, 07 Jan 2025 14:01:57
 -0800 (PST)
Date: Tue,  7 Jan 2025 14:01:50 -0800
In-Reply-To: <20250107220152.1213959-1-irogers@google.com>
Message-Id: <20250107220152.1213959-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250107220152.1213959-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v2 1/3] perf test: Rename functions and variables for better clarity
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The relationship between subtests and test cases is somewhat
confusing, so let's do away with the notion of sub-tests and switch to
just working with some number of test cases. Add a
test_suite__for_each_test_case as in many cases, except the special
one test case situation, the iteration can just be on all test
cases. Switch variable names to be more intention revealing of what
their value is.

This work was motivated by discussion with Kan where it was noted the
code is becoming overly indented:
https://lore.kernel.org/lkml/20241109160219.49976-1-irogers@google.com/
Unifying more of the sub-test/no-sub-tests avoids one level of
indentation in a number of places.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 201 +++++++++++++++-----------------
 1 file changed, 93 insertions(+), 108 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index a5b9ccd0033a..c3e082efb7f4 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -149,58 +149,51 @@ static struct test_workload *workloads[] = {
 #define workloads__for_each(workload) \
 	for (unsigned i = 0; i < ARRAY_SIZE(workloads) && ({ workload = workloads[i]; 1; }); i++)
 
-static int num_subtests(const struct test_suite *t)
+#define test_suite__for_each_test_case(suite, idx)			\
+	for (idx = 0; (suite)->test_cases && (suite)->test_cases[idx].name != NULL; idx++)
+
+static int test_suite__num_test_cases(const struct test_suite *t)
 {
 	int num;
 
-	if (!t->test_cases)
-		return 0;
-
-	num = 0;
-	while (t->test_cases[num].name)
-		num++;
+	test_suite__for_each_test_case(t, num);
 
 	return num;
 }
 
-static bool has_subtests(const struct test_suite *t)
-{
-	return num_subtests(t) > 1;
-}
-
-static const char *skip_reason(const struct test_suite *t, int subtest)
+static const char *skip_reason(const struct test_suite *t, int test_case)
 {
 	if (!t->test_cases)
 		return NULL;
 
-	return t->test_cases[subtest >= 0 ? subtest : 0].skip_reason;
+	return t->test_cases[test_case >= 0 ? test_case : 0].skip_reason;
 }
 
-static const char *test_description(const struct test_suite *t, int subtest)
+static const char *test_description(const struct test_suite *t, int test_case)
 {
-	if (t->test_cases && subtest >= 0)
-		return t->test_cases[subtest].desc;
+	if (t->test_cases && test_case >= 0)
+		return t->test_cases[test_case].desc;
 
 	return t->desc;
 }
 
-static test_fnptr test_function(const struct test_suite *t, int subtest)
+static test_fnptr test_function(const struct test_suite *t, int test_case)
 {
-	if (subtest <= 0)
+	if (test_case <= 0)
 		return t->test_cases[0].run_case;
 
-	return t->test_cases[subtest].run_case;
+	return t->test_cases[test_case].run_case;
 }
 
-static bool test_exclusive(const struct test_suite *t, int subtest)
+static bool test_exclusive(const struct test_suite *t, int test_case)
 {
-	if (subtest <= 0)
+	if (test_case <= 0)
 		return t->test_cases[0].exclusive;
 
-	return t->test_cases[subtest].exclusive;
+	return t->test_cases[test_case].exclusive;
 }
 
-static bool perf_test__matches(const char *desc, int curr, int argc, const char *argv[])
+static bool perf_test__matches(const char *desc, int suite_num, int argc, const char *argv[])
 {
 	int i;
 
@@ -212,7 +205,7 @@ static bool perf_test__matches(const char *desc, int curr, int argc, const char
 		long nr = strtoul(argv[i], &end, 10);
 
 		if (*end == '\0') {
-			if (nr == curr + 1)
+			if (nr == suite_num + 1)
 				return true;
 			continue;
 		}
@@ -227,8 +220,8 @@ static bool perf_test__matches(const char *desc, int curr, int argc, const char
 struct child_test {
 	struct child_process process;
 	struct test_suite *test;
-	int test_num;
-	int subtest;
+	int suite_num;
+	int test_case_num;
 };
 
 static jmp_buf run_test_jmp_buf;
@@ -258,7 +251,7 @@ static int run_test_child(struct child_process *process)
 
 	pr_debug("--- start ---\n");
 	pr_debug("test child forked, pid %d\n", getpid());
-	err = test_function(child->test, child->subtest)(child->test, child->subtest);
+	err = test_function(child->test, child->test_case_num)(child->test, child->test_case_num);
 	pr_debug("---- end(%d) ----\n", err);
 
 err_out:
@@ -270,15 +263,16 @@ static int run_test_child(struct child_process *process)
 
 #define TEST_RUNNING -3
 
-static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width,
-			     int running)
+static int print_test_result(struct test_suite *t, int curr_suite, int curr_test_case,
+			     int result, int width, int running)
 {
-	if (has_subtests(t)) {
+	if (test_suite__num_test_cases(t) > 1) {
 		int subw = width > 2 ? width - 2 : width;
 
-		pr_info("%3d.%1d: %-*s:", i + 1, subtest + 1, subw, test_description(t, subtest));
+		pr_info("%3d.%1d: %-*s:", curr_suite + 1, curr_test_case + 1, subw,
+			test_description(t, curr_test_case));
 	} else
-		pr_info("%3d: %-*s:", i + 1, width, test_description(t, subtest));
+		pr_info("%3d: %-*s:", curr_suite + 1, width, test_description(t, curr_test_case));
 
 	switch (result) {
 	case TEST_RUNNING:
@@ -288,7 +282,7 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
 		pr_info(" Ok\n");
 		break;
 	case TEST_SKIP: {
-		const char *reason = skip_reason(t, subtest);
+		const char *reason = skip_reason(t, curr_test_case);
 
 		if (reason)
 			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (%s)\n", reason);
@@ -310,7 +304,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 {
 	struct child_test *child_test = child_tests[running_test];
 	struct test_suite *t;
-	int i, subi, err;
+	int curr_suite, curr_test_case, err;
 	bool err_done = false;
 	struct strbuf err_output = STRBUF_INIT;
 	int last_running = -1;
@@ -321,15 +315,15 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 		return;
 	}
 	t = child_test->test;
-	i = child_test->test_num;
-	subi = child_test->subtest;
+	curr_suite = child_test->suite_num;
+	curr_test_case = child_test->test_case_num;
 	err = child_test->process.err;
 	/*
 	 * For test suites with subtests, display the suite name ahead of the
 	 * sub test names.
 	 */
-	if (has_subtests(t) && subi == 0)
-		pr_info("%3d: %-*s:\n", i + 1, width, test_description(t, -1));
+	if (test_suite__num_test_cases(t) > 1 && curr_test_case == 0)
+		pr_info("%3d: %-*s:\n", curr_suite + 1, width, test_description(t, -1));
 
 	/*
 	 * Busy loop reading from the child's stdout/stderr that are set to be
@@ -338,10 +332,11 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	if (err > 0)
 		fcntl(err, F_SETFL, O_NONBLOCK);
 	if (verbose > 1) {
-		if (has_subtests(t))
-			pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_description(t, subi));
+		if (test_suite__num_test_cases(t) > 1)
+			pr_info("%3d.%1d: %s:\n", curr_suite + 1, curr_test_case + 1,
+				test_description(t, curr_test_case));
 		else
-			pr_info("%3d: %s:\n", i + 1, test_description(t, -1));
+			pr_info("%3d: %s:\n", curr_suite + 1, test_description(t, -1));
 	}
 	while (!err_done) {
 		struct pollfd pfds[1] = {
@@ -366,7 +361,8 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 					 */
 					fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
 				}
-				print_test_result(t, i, subi, TEST_RUNNING, width, running);
+				print_test_result(t, curr_suite, curr_test_case, TEST_RUNNING,
+						  width, running);
 				last_running = running;
 			}
 		}
@@ -404,14 +400,14 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 		fprintf(stderr, "%s", err_output.buf);
 
 	strbuf_release(&err_output);
-	print_test_result(t, i, subi, ret, width, /*running=*/0);
+	print_test_result(t, curr_suite, curr_test_case, ret, width, /*running=*/0);
 	if (err > 0)
 		close(err);
 	zfree(&child_tests[running_test]);
 }
 
-static int start_test(struct test_suite *test, int i, int subi, struct child_test **child,
-		int width, int pass)
+static int start_test(struct test_suite *test, int curr_suite, int curr_test_case,
+		struct child_test **child, int width, int pass)
 {
 	int err;
 
@@ -419,17 +415,18 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 	if (dont_fork) {
 		if (pass == 1) {
 			pr_debug("--- start ---\n");
-			err = test_function(test, subi)(test, subi);
+			err = test_function(test, curr_suite)(test, curr_test_case);
 			pr_debug("---- end ----\n");
-			print_test_result(test, i, subi, err, width, /*running=*/0);
+			print_test_result(test, curr_suite, curr_test_case, err, width,
+					  /*running=*/0);
 		}
 		return 0;
 	}
-	if (pass == 1 && !sequential && test_exclusive(test, subi)) {
+	if (pass == 1 && !sequential && test_exclusive(test, curr_test_case)) {
 		/* When parallel, skip exclusive tests on the first pass. */
 		return 0;
 	}
-	if (pass != 1 && (sequential || !test_exclusive(test, subi))) {
+	if (pass != 1 && (sequential || !test_exclusive(test, curr_test_case))) {
 		/* Sequential and non-exclusive tests were run on the first pass. */
 		return 0;
 	}
@@ -438,8 +435,8 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 		return -ENOMEM;
 
 	(*child)->test = test;
-	(*child)->test_num = i;
-	(*child)->subtest = subi;
+	(*child)->suite_num = curr_suite;
+	(*child)->test_case_num = curr_test_case;
 	(*child)->process.pid = -1;
 	(*child)->process.no_stdin = 1;
 	if (verbose <= 0) {
@@ -479,19 +476,15 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 	int err = 0;
 
 	for (struct test_suite **t = suites; *t; t++) {
-		int len = strlen(test_description(*t, -1));
+		int i, len = strlen(test_description(*t, -1));
 
 		if (width < len)
 			width = len;
 
-		if (has_subtests(*t)) {
-			for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
-				len = strlen(test_description(*t, subi));
-				if (width < len)
-					width = len;
-				num_tests++;
-			}
-		} else {
+		test_suite__for_each_test_case(*t, i) {
+			len = strlen(test_description(*t, i));
+			if (width < len)
+				width = len;
 			num_tests++;
 		}
 	}
@@ -510,7 +503,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 				continue;
 
 			pr_debug3("Killing %d pid %d\n",
-				  child_test->test_num + 1,
+				  child_test->suite_num + 1,
 				  child_test->process.pid);
 			kill(child_test->process.pid, err);
 		}
@@ -526,47 +519,43 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 	 */
 	for (int pass = 1; pass <= 2; pass++) {
 		int child_test_num = 0;
-		int i = 0;
+		int curr_suite = 0;
 
-		for (struct test_suite **t = suites; *t; t++) {
-			int curr = i++;
+		for (struct test_suite **t = suites; *t; t++, curr_suite++) {
+			int curr_test_case;
 
-			if (!perf_test__matches(test_description(*t, -1), curr, argc, argv)) {
+			if (!perf_test__matches(test_description(*t, -1), curr_suite, argc, argv)) {
 				/*
 				 * Test suite shouldn't be run based on
-				 * description. See if subtest should.
+				 * description. See if any test case should.
 				 */
 				bool skip = true;
 
-				for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
-					if (perf_test__matches(test_description(*t, subi),
-								curr, argc, argv))
+				test_suite__for_each_test_case(*t, curr_test_case) {
+					if (perf_test__matches(test_description(*t, curr_test_case),
+							       curr_suite, argc, argv)) {
 						skip = false;
+						break;
+					}
 				}
-
 				if (skip)
 					continue;
 			}
 
-			if (intlist__find(skiplist, i)) {
-				pr_info("%3d: %-*s:", curr + 1, width, test_description(*t, -1));
+			if (intlist__find(skiplist, curr_suite + 1)) {
+				pr_info("%3d: %-*s:", curr_suite + 1, width,
+					test_description(*t, -1));
 				color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
 				continue;
 			}
 
-			if (!has_subtests(*t)) {
-				err = start_test(*t, curr, -1, &child_tests[child_test_num++],
-						 width, pass);
-				if (err)
-					goto err_out;
-				continue;
-			}
-			for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
-				if (!perf_test__matches(test_description(*t, subi),
-							curr, argc, argv))
+			test_suite__for_each_test_case(*t, curr_test_case) {
+				if (!perf_test__matches(test_description(*t, curr_test_case),
+							curr_suite, argc, argv))
 					continue;
 
-				err = start_test(*t, curr, subi, &child_tests[child_test_num++],
+				err = start_test(*t, curr_suite, curr_test_case,
+						 &child_tests[child_test_num++],
 						 width, pass);
 				if (err)
 					goto err_out;
@@ -592,23 +581,22 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 
 static int perf_test__list(struct test_suite **suites, int argc, const char **argv)
 {
-	int i = 0;
+	int curr_suite = 0;
 
-	for (struct test_suite **t = suites; *t; t++) {
-		int curr = i++;
+	for (struct test_suite **t = suites; *t; t++, curr_suite++) {
+		int curr_test_case;
 
-		if (!perf_test__matches(test_description(*t, -1), curr, argc, argv))
+		if (!perf_test__matches(test_description(*t, -1), curr_suite, argc, argv))
 			continue;
 
-		pr_info("%3d: %s\n", i, test_description(*t, -1));
+		pr_info("%3d: %s\n", curr_suite + 1, test_description(*t, -1));
 
-		if (has_subtests(*t)) {
-			int subn = num_subtests(*t);
-			int subi;
+		if (test_suite__num_test_cases(*t) <= 1)
+			continue;
 
-			for (subi = 0; subi < subn; subi++)
-				pr_info("%3d:%1d: %s\n", i, subi + 1,
-					test_description(*t, subi));
+		test_suite__for_each_test_case(*t, curr_test_case) {
+			pr_info("%3d:%1d: %s\n", curr_suite + 1, curr_test_case + 1,
+				test_description(*t, curr_test_case));
 		}
 	}
 	return 0;
@@ -665,27 +653,24 @@ static struct test_suite **build_suites(void)
 	if (suites[2] == NULL)
 		suites[2] = create_script_test_suites();
 
-#define for_each_test(t)						\
+#define for_each_suite(suite)						\
 	for (size_t i = 0, j = 0; i < ARRAY_SIZE(suites); i++, j = 0)	\
-		while ((t = suites[i][j++]) != NULL)
+		while ((suite = suites[i][j++]) != NULL)
 
-	for_each_test(t)
+	for_each_suite(t)
 		num_suites++;
 
 	result = calloc(num_suites + 1, sizeof(struct test_suite *));
 
 	for (int pass = 1; pass <= 2; pass++) {
-		for_each_test(t) {
+		for_each_suite(t) {
 			bool exclusive = false;
+			int curr_test_case;
 
-			if (!has_subtests(t)) {
-				exclusive = test_exclusive(t, -1);
-			} else {
-				for (int subi = 0, subn = num_subtests(t); subi < subn; subi++) {
-					if (test_exclusive(t, subi)) {
-						exclusive = true;
-						break;
-					}
+			test_suite__for_each_test_case(t, curr_test_case) {
+				if (test_exclusive(t, curr_test_case)) {
+					exclusive = true;
+					break;
 				}
 			}
 			if ((!exclusive && pass == 1) || (exclusive && pass == 2))
@@ -693,7 +678,7 @@ static struct test_suite **build_suites(void)
 		}
 	}
 	return result;
-#undef for_each_test
+#undef for_each_suite
 }
 
 int cmd_test(int argc, const char **argv)
-- 
2.47.1.613.gc27f4b7a9f-goog

