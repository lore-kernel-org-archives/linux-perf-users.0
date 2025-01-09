Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D519E7F7
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448055; cv=none; b=fBG0JzkLcq9U0jcwfVeLvW9FzcczgXCXDJNG/omfGn7g8JHmLCghg6mvKt5joFdoxc5h7grIeXUjqH8pPZpu5G37FDq3D8W4zRLssjoFXzm3oxlJnUUTN+yL9QdEnUk449On86HFHPDJmEcDEF+AKresBrN3kDN/DZAnZXVVL8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448055; c=relaxed/simple;
	bh=oe8jug5TfATH6UqI+SDmWJVfhN4/Z1/tSDQisOCdIus=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JKGFL33aKpDe+p4Rbp9LOP0N8f/ZAMZnwdssFjubxYgq7LTyUXeCnARXlDlERV+Mmebz448Wkne8ex33vMlH+yIvw/BQlzo/bCjwHJ9EF6OlnGj4krX0RiIApu0oWxfj5+ZFFFR2HaTqtuVu6X2zyS19ayDmTleRt/SCvvZgmVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pFABiYZD; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pFABiYZD"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e5505f613e5so2333732276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 10:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736448051; x=1737052851; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rt3FANMhbwUxwhbrCeMm//1cFuRBbV1k6BaJKVQj2ZQ=;
        b=pFABiYZDdJk918INbKyWTu4V5c+DvS4cigTEab4II54v52IFTIkTccJiLQJSxnL8sD
         n2N6vMrGr6LNm6lFiTCxOW+d9FB52Cz7c0YULsYdiXms2aQV0NMuqLUYWiMvvndhi8JF
         UGSllrWPYltaye7foYmU6pwQ8fJW4oUVyz/T0IQv+u3q8hiL/NnLMuB928xslkCTSDez
         Ev3gHQzrhR+hQ7IuYBeV87zJQEfhXLarxvbNRUUij0m2EsycGracYgDdLdB/kThshzB0
         pZ4xECvPL+ExC1C5wWgobIA6EAeIJeaDgNAK/wrHSFgH8yNbE4//e6aC1++hyYN8qS/f
         a7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736448051; x=1737052851;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rt3FANMhbwUxwhbrCeMm//1cFuRBbV1k6BaJKVQj2ZQ=;
        b=FLeeRmpgMYbln8llHlLC+ZS1sPsKS6qFXAYMIPzQ1JBkGmfizqRqwmmTOKbhIrjDto
         K0VN2QaS7dXvxKZ57MpZAzpdgUgWipF/z9lWDZeUqAuc8bn2pvTF2c4TOZH71QErp1WK
         Y27muje00z5XXU9knVRDMH5vYUQwPCr7Be2m77sRAm/bbL+j2jP5c/IDnOC+XiFLeNrM
         yyPOB+S18t3nc5xmcBQIc2Trz+Ph6QLPJkmYTiq4YIKMAQROs4oVsltlHky6ssN27vOI
         U4n6IFu7tpHSBYuCzHnJvJTtS4hkBVcgEgKjEcnGk6VqTyH1ca6a5LR8aaoXbRC6mw2D
         XG3w==
X-Forwarded-Encrypted: i=1; AJvYcCVRpcSfYsVxL3LbXZDzi4eubiPU8hU178YHyYXhi0cVETNnUHpC/LMgj27Yo/riscWQiYXRkP+Yqr7nd/kBdsJm@vger.kernel.org
X-Gm-Message-State: AOJu0YxGJwZyXvotb/bNAtb0IUflTVQnG1wetiknX2TwZizTXkszcbTF
	Ti9wPvU/+TLapIIySB52+aEaZhBfxDq21xu32v4+xFy+aPLfOdKy6k3mC9JXxYM9Dmcg+cR/BCI
	oM06gog==
X-Google-Smtp-Source: AGHT+IH9UgRU4CWMXTaZxquWuFp+sw1dty/9wjdv4pye804lLFn0wbP4mpAGQoDdB8NGQA76faifi5HdBglV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a25:20c2:0:b0:e4d:c8d5:81ef with SMTP id
 3f1490d57ef6-e550136cda0mr16901276.0.1736448051590; Thu, 09 Jan 2025 10:40:51
 -0800 (PST)
Date: Thu,  9 Jan 2025 10:40:42 -0800
In-Reply-To: <20250109184046.193736-1-irogers@google.com>
Message-Id: <20250109184046.193736-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109184046.193736-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 1/5] perf test: Rename functions and variables for better clarity
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

