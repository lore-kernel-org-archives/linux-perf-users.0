Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C59D1B2184
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2024 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755227; cv=none; b=V/NVr9Pyuk5bgTyPOLmTmZwPcdjrsepKXHHW4utnTLbcmAIjwlEhy/NE6G617HdLJ0fix986+6GSO2Ft7WkRSjXZVqZ3zNFyPK4G8d79Wg3P2yUrFwalnEYxtHPz3/Z30z+WfDO/JmSoSM3EqBsAPX3b5CtIY+sLLAE3taKteCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755227; c=relaxed/simple;
	bh=h+S7lvjznO6aeDproo7dQHdVN5YR74SQ/ZENnLj7+oI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=EJ9BnarXlxhGGdXtOklTCWYKcVcKOi61N99iwugu055yWa9dJn4j08NJxTxn8dc8UPPy8gk5HClzXu0OQ0p887WEk09eIUaiWN8z39+CIigpYtUzyEP1AH1ON24QdmXMKIwTrKJhg9Qlji/dBo9cMBjrc7x6g2qjLgezfSnvuz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MEcxbvpt; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MEcxbvpt"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e32b43e053so9516927b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2024 00:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729755223; x=1730360023; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7hM2wwF2vu4Jxi4L+kQlwZyT/L+0QugQwYnGtLXglM=;
        b=MEcxbvptkA8T3+xeJh9pRL/vh7F6kc2tr5fZXGR92wBsNXUpXOfpXWiCu8igtQpDVI
         7wpJpvnX0FqGHOuGtKmvYH1tpjEjJPu4gyMGkJ7Z8relp7OP6XjbJB4lEuDnn7KzqpYU
         5HIg8H38tzpv/WY9+HMui3xSHRODFejghu1I7Or7DCsFUZVeBQXdjT6Qdk05Z3swMom/
         Bx26zpc4/dhq5Igk6sy6mgjCi8kvR838EZLCtz5JnXIxRL0zPIMNrr8k9ZsgCL7flKD6
         4YLEQoYQ9Z2AlBJSEIH2kqxbVTDZ+eZufRDqVNBgbfyXf800uj/bESFYE72H1PDZ1EkM
         AQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729755223; x=1730360023;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7hM2wwF2vu4Jxi4L+kQlwZyT/L+0QugQwYnGtLXglM=;
        b=RqIW0bqUQ7fkBGD2e7cM5oDbOsFubWYPfebguTQ/ns5uxw9Xcw9dI71XBKn4HuDiL5
         a0wi0TigIAQAGO0faZus3F7aTXO8l1o9KqlXh48KjkuqYNgKqbfZE7xslYlcfpJ8Teo2
         dwpgPKKyslm6VeFrzyxgiXwig11HRFw9bnxjHvQFW+jfrgnk+kOC0n0E1S48lN1OUvl6
         PvfKe+q8k/8xK1yOn7ib/1uqehLV7RYZ2dc5sYGdylkPgv3pMSra3n8v1T7sOODXhfWL
         mH9/6bFM4N6+imlcWjxn5ZjZD2Ss6CwLAzNmpNDnBEupxC18PVtR7gOLYm3j7XrSyC80
         2orw==
X-Forwarded-Encrypted: i=1; AJvYcCWe5f4GDyKMvZA9NKoB6ziLXpkh5K+3TQvoEX3AijEuqfXh/PYc5G6bInEyUTPCrpv2WuE4BHInSj71hhgsY7gt@vger.kernel.org
X-Gm-Message-State: AOJu0YzbghPYbmgISDfIvx+He9SXXmDfypWbb3M5bNBEQ0yAyfkAImjD
	YALbbLVoeP2gjUVE7xIHeB8VAykde4czZ00i2jkHcOeCb7g/O4jZNjODNprQ/tkXVMwc+dRKb6L
	l4DA6wQ==
X-Google-Smtp-Source: AGHT+IFR1hSJGp+PtSCO+wqdiDMALECfN1b8oV82snaVHd952V/BD1M+iklsAG3xBjIi+4d6azzSc8MqlfDn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2391:e0be:5394:f85d])
 (user=irogers job=sendgmr) by 2002:a05:690c:3605:b0:6e2:1ab6:699a with SMTP
 id 00721157ae682-6e8701db190mr376087b3.7.1729755223437; Thu, 24 Oct 2024
 00:33:43 -0700 (PDT)
Date: Thu, 24 Oct 2024 00:33:21 -0700
In-Reply-To: <20241024073324.1513433-1-irogers@google.com>
Message-Id: <20241024073324.1513433-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024073324.1513433-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 07/10] perf test: Run parallel tests in two passes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In pass 1 run all tests that succeed when run in parallel. In pass 2
sequentially run all remaining tests that are flagged as
"exclusive". Sequential and dont_fork tests keep to run in pass 1.
Read the exclusive flag from the shell test descriptions, but remove
from display to avoid >100 characters. Add error handling to finish
tests if starting a later test fails. Mark the task-exit test as
exclusive due to issues reported-by James Clark.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c  | 157 +++++++++++++++++++------------
 tools/perf/tests/task-exit.c     |   9 +-
 tools/perf/tests/tests-scripts.c |   7 +-
 tools/perf/tests/tests.h         |   9 ++
 4 files changed, 121 insertions(+), 61 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 8a720ddb0396..b997d0a68ca2 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -199,6 +199,14 @@ static test_fnptr test_function(const struct test_suite *t, int subtest)
 	return t->test_cases[subtest].run_case;
 }
 
+static bool test_exclusive(const struct test_suite *t, int subtest)
+{
+	if (subtest <= 0)
+		return t->test_cases[0].exclusive;
+
+	return t->test_cases[subtest].exclusive;
+}
+
 static bool perf_test__matches(const char *desc, int curr, int argc, const char *argv[])
 {
 	int i;
@@ -242,7 +250,7 @@ static int run_test_child(struct child_process *process)
 	const int signals[] = {
 		SIGABRT, SIGBUS, SIGFPE, SIGILL, SIGINT, SIGPIPE, SIGQUIT, SIGSEGV, SIGTERM,
 	};
-	static struct child_test *child;
+	struct child_test *child = container_of(process, struct child_test, process);
 	int err;
 
 	err = sigsetjmp(run_test_jmp_buf, 1);
@@ -252,7 +260,6 @@ static int run_test_child(struct child_process *process)
 		goto err_out;
 	}
 
-	child = container_of(process, struct child_test, process);
 	for (size_t i = 0; i < ARRAY_SIZE(signals); i++)
 		signal(signals[i], child_test_sig_handler);
 
@@ -305,19 +312,25 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
 	return 0;
 }
 
-static int finish_test(struct child_test **child_tests, int running_test, int child_test_num,
-		       int width)
+static void finish_test(struct child_test **child_tests, int running_test, int child_test_num,
+		int width)
 {
 	struct child_test *child_test = child_tests[running_test];
-	struct test_suite *t = child_test->test;
-	int i = child_test->test_num;
-	int subi = child_test->subtest;
-	int err = child_test->process.err;
+	struct test_suite *t;
+	int i, subi, err;
 	bool err_done = false;
 	struct strbuf err_output = STRBUF_INIT;
 	int last_running = -1;
 	int ret;
 
+	if (child_test == NULL) {
+		/* Test wasn't started. */
+		return;
+	}
+	t = child_test->test;
+	i = child_test->test_num;
+	subi = child_test->subtest;
+	err = child_test->process.err;
 	/*
 	 * For test suites with subtests, display the suite name ahead of the
 	 * sub test names.
@@ -347,6 +360,8 @@ static int finish_test(struct child_test **child_tests, int running_test, int ch
 			int running = 0;
 
 			for (int y = running_test; y < child_test_num; y++) {
+				if (child_tests[y] == NULL)
+					continue;
 				if (check_if_command_finished(&child_tests[y]->process) == 0)
 					running++;
 			}
@@ -399,23 +414,32 @@ static int finish_test(struct child_test **child_tests, int running_test, int ch
 	print_test_result(t, i, subi, ret, width, /*running=*/0);
 	if (err > 0)
 		close(err);
-	return 0;
+	zfree(&child_tests[running_test]);
 }
 
 static int start_test(struct test_suite *test, int i, int subi, struct child_test **child,
-		      int width)
+		int width, int pass)
 {
 	int err;
 
 	*child = NULL;
 	if (dont_fork) {
-		pr_debug("--- start ---\n");
-		err = test_function(test, subi)(test, subi);
-		pr_debug("---- end ----\n");
-		print_test_result(test, i, subi, err, width, /*running=*/0);
+		if (pass == 1) {
+			pr_debug("--- start ---\n");
+			err = test_function(test, subi)(test, subi);
+			pr_debug("---- end ----\n");
+			print_test_result(test, i, subi, err, width, /*running=*/0);
+		}
+		return 0;
+	}
+	if (pass == 1 && !sequential && test_exclusive(test, subi)) {
+		/* When parallel, skip exclusive tests on the first pass. */
+		return 0;
+	}
+	if (pass != 1 && (sequential || !test_exclusive(test, subi))) {
+		/* Sequential and non-exclusive tests were run on the first pass. */
 		return 0;
 	}
-
 	*child = zalloc(sizeof(**child));
 	if (!*child)
 		return -ENOMEM;
@@ -434,10 +458,14 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 		(*child)->process.err = -1;
 	}
 	(*child)->process.no_exec_cmd = run_test_child;
-	err = start_command(&(*child)->process);
-	if (err || !sequential)
-		return  err;
-	return finish_test(child, /*running_test=*/0, /*child_test_num=*/1, width);
+	if (sequential || pass == 2) {
+		err = start_command(&(*child)->process);
+		if (err)
+			return err;
+		finish_test(child, /*running_test=*/0, /*child_test_num=*/1, width);
+		return 0;
+	}
+	return start_command(&(*child)->process);
 }
 
 #define for_each_test(j, k, t)					\
@@ -447,12 +475,11 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 {
 	struct test_suite *t;
-	unsigned int j, k;
-	int i = 0;
 	int width = 0;
+	unsigned int j, k;
 	size_t num_tests = 0;
 	struct child_test **child_tests;
-	int child_test_num = 0;
+	int err = 0;
 
 	for_each_test(j, k, t) {
 		int len = strlen(test_description(t, -1));
@@ -475,62 +502,73 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 	if (!child_tests)
 		return -ENOMEM;
 
-	for_each_test(j, k, t) {
-		int curr = i++;
-
-		if (!perf_test__matches(test_description(t, -1), curr, argc, argv)) {
-			bool skip = true;
+	/*
+	 * In parallel mode pass 1 runs non-exclusive tests in parallel, pass 2
+	 * runs the exclusive tests sequentially. In other modes all tests are
+	 * run in pass 1.
+	 */
+	for (int pass = 1; pass <= 2; pass++) {
+		int child_test_num = 0;
+		int i = 0;
+
+		for_each_test(j, k, t) {
+			int curr = i++;
+
+			if (!perf_test__matches(test_description(t, -1), curr, argc, argv)) {
+				/*
+				 * Test suite shouldn't be run based on
+				 * description. See if subtest should.
+				 */
+				bool skip = true;
+
+				for (int subi = 0, subn = num_subtests(t); subi < subn; subi++) {
+					if (perf_test__matches(test_description(t, subi),
+								curr, argc, argv))
+						skip = false;
+				}
 
-			for (int subi = 0, subn = num_subtests(t); subi < subn; subi++) {
-				if (perf_test__matches(test_description(t, subi),
-							curr, argc, argv))
-					skip = false;
+				if (skip)
+					continue;
 			}
 
-			if (skip)
+			if (intlist__find(skiplist, i)) {
+				pr_info("%3d: %-*s:", curr + 1, width, test_description(t, -1));
+				color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
 				continue;
-		}
-
-		if (intlist__find(skiplist, i)) {
-			pr_info("%3d: %-*s:", curr + 1, width, test_description(t, -1));
-			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
-			continue;
-		}
-
-		if (!has_subtests(t)) {
-			int err = start_test(t, curr, -1, &child_tests[child_test_num++], width);
+			}
 
-			if (err) {
-				/* TODO: if !sequential waitpid the already forked children. */
-				free(child_tests);
-				return err;
+			if (!has_subtests(t)) {
+				err = start_test(t, curr, -1, &child_tests[child_test_num++],
+						 width, pass);
+				if (err)
+					goto err_out;
+				continue;
 			}
-		} else {
 			for (int subi = 0, subn = num_subtests(t); subi < subn; subi++) {
-				int err;
-
 				if (!perf_test__matches(test_description(t, subi),
 							curr, argc, argv))
 					continue;
 
 				err = start_test(t, curr, subi, &child_tests[child_test_num++],
-						 width);
+						 width, pass);
 				if (err)
-					return err;
+					goto err_out;
 			}
 		}
-	}
-	for (i = 0; i < child_test_num; i++) {
 		if (!sequential) {
-			int ret  = finish_test(child_tests, i, child_test_num, width);
-
-			if (ret)
-				return ret;
+			/* Parallel mode starts tests but doesn't finish them. Do that now. */
+			for (size_t x = 0; x < num_tests; x++)
+				finish_test(child_tests, x, num_tests, width);
 		}
-		free(child_tests[i]);
+	}
+err_out:
+	if (err) {
+		pr_err("Internal test harness failure. Completing any started tests:\n:");
+		for (size_t x = 0; x < num_tests; x++)
+			finish_test(child_tests, x, num_tests, width);
 	}
 	free(child_tests);
-	return 0;
+	return err;
 }
 
 static int perf_test__list(int argc, const char **argv)
@@ -656,6 +694,7 @@ int cmd_test(int argc, const char **argv)
 	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.try_vmlinux_path = true;
 
+
 	if (symbol__init(NULL) < 0)
 		return -1;
 
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index d33d0952025c..8e328bbd509d 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -152,4 +152,11 @@ static int test__task_exit(struct test_suite *test __maybe_unused, int subtest _
 	return err;
 }
 
-DEFINE_SUITE("Number of exit events of a simple workload", task_exit);
+struct test_case tests__task_exit[] = {
+	TEST_CASE_EXCLUSIVE("Number of exit events of a simple workload", task_exit),
+	{	.name = NULL, }
+};
+struct test_suite suite__task_exit = {
+	.desc = "Number of exit events of a simple workload",
+	.test_cases = tests__task_exit,
+};
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index ed114b044293..cf3ae0c1d871 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -175,6 +175,7 @@ static void append_script(int dir_fd, const char *name, char *desc,
 	struct test_suite *test_suite, **result_tmp;
 	struct test_case *tests;
 	size_t len;
+	char *exclusive;
 
 	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
 	len = readlink(link, filename, sizeof(filename));
@@ -191,9 +192,13 @@ static void append_script(int dir_fd, const char *name, char *desc,
 		return;
 	}
 	tests[0].name = strdup_check(name);
+	exclusive = strstr(desc, " (exclusive)");
+	if (exclusive != NULL) {
+		tests[0].exclusive = true;
+		exclusive[0] = '\0';
+	}
 	tests[0].desc = strdup_check(desc);
 	tests[0].run_case = shell_test__run;
-
 	test_suite = zalloc(sizeof(*test_suite));
 	if (!test_suite) {
 		pr_err("Out of memory while building script test suite list\n");
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 1ed76d4156b6..af284dd47e5c 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -36,6 +36,7 @@ struct test_case {
 	const char *desc;
 	const char *skip_reason;
 	test_fnptr run_case;
+	bool exclusive;
 };
 
 struct test_suite {
@@ -62,6 +63,14 @@ struct test_suite {
 		.skip_reason = _reason,			\
 	}
 
+#define TEST_CASE_EXCLUSIVE(description, _name)		\
+	{						\
+		.name = #_name,				\
+		.desc = description,			\
+		.run_case = test__##_name,		\
+		.exclusive = true,			\
+	}
+
 #define DEFINE_SUITE(description, _name)		\
 	struct test_case tests__##_name[] = {           \
 		TEST_CASE(description, _name),		\
-- 
2.47.0.163.g1226f6d8fa-goog

