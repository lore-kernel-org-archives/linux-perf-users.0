Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+LyzHqg"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4011F198A
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Dec 2023 15:50:55 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d3cdd6f132so28705727b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Dec 2023 15:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701474654; x=1702079454; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MSt4UwYFqGHS91v6lOZ8HWzOgHoKPnUlRTloF7QFutQ=;
        b=F+LyzHqgB3tmNP4LKiK0+dsyPjB6RPWyLN3M32ayh9cij1Z35iKydPf+xilJlJJxE3
         LA223C0cnZeb1WTMSr2NmfDd9ZMPBWBh5+dgLCGl+Sej61TupkaI2iX/6zeBFSNKkKdt
         /5PeMCAy7PhIzoaFmmrJ63wKYll+pRTuJJPiq4sGZT7cWXeRuzADemTXVG0PHToGJDlX
         HT2nblKm92HVgpkJOIorn1znQxsGbISGK3JXvCoR3OzEQdlMNloop7pMSLTkmGyberN6
         Qp+z8SfM5qjjstqQdK49KvKVrN0f99MOa/zjGYBsAoq1QF/eptY6U45hP4VlljRj5hUl
         +p+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474654; x=1702079454;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSt4UwYFqGHS91v6lOZ8HWzOgHoKPnUlRTloF7QFutQ=;
        b=uYKjasJpaPDaUiw9cJafEItJ+leur4DxrS8jNEPKP67cr0djNBkCGRarEeyBIZqcK9
         xoe9iMexyHmMHI0rjLua7d7W7XERaYa699nINOQEYm3G3GAd0k8pXJzCcOlEGM5n0xUE
         vJrN+Q8XbL+UfgeyijAvjzNtkoQOEw14jGKGH2iPvdhy1Mye5Aav3flqa+uc8OZtxxjW
         Mwl3LYW3Hh6lJI/+U5oOgSBr5QLxBN1dyB2SmC2TFc1n1GYcXvwiHJjQ1WVkpvlV0xRh
         HbE6Ip8/awh/7ZDYmldkrNduvg1oo9Lir50lYDJqG+kBq06KyYjM0AvDnAtnifYKh0tg
         IoQg==
X-Gm-Message-State: AOJu0YyqDz+RNcm+jWdn7HQok2zmlczU8QxV1aUE3Rg38X9Nysqiinx5
	32uUJ3UOxE8WFFZyX5wKvqJSadcm/mCF
X-Google-Smtp-Source: AGHT+IEMCJDW5dGQvngcUvcPVq2Uf+AYu+oJZZiRRJo+YHBtlPknoTN8RXV/lyg03qrx9tqR6NyzjsHzUI5M
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:df3:224b:7b7f:efc5])
 (user=irogers job=sendgmr) by 2002:a81:be14:0:b0:5d1:7706:b886 with SMTP id
 i20-20020a81be14000000b005d17706b886mr513874ywn.0.1701474654227; Fri, 01 Dec
 2023 15:50:54 -0800 (PST)
Date: Fri,  1 Dec 2023 15:50:29 -0800
In-Reply-To: <20231201235031.475293-1-irogers@google.com>
Message-Id: <20231201235031.475293-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201235031.475293-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 7/9] perf tests: Run time generate shell test suites
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Rather than special shell test logic, do a single pass to create an
array of test suites. Hold the shell test file name in the test suite
priv field. This makes the special shell test logic in builtin-test.c
redundant so remove it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c  |  91 +----------------------
 tools/perf/tests/tests-scripts.c | 120 ++++++++++++++++++-------------
 tools/perf/tests/tests-scripts.h |  10 +--
 3 files changed, 74 insertions(+), 147 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 2669d1d66ed8..54b11c23e863 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -132,6 +132,7 @@ static struct test_suite *generic_tests[] = {
 static struct test_suite **tests[] = {
 	generic_tests,
 	arch_tests,
+	NULL, /* shell tests created at runtime. */
 };
 
 static struct test_workload *workloads[] = {
@@ -301,74 +302,12 @@ static int test_and_print(struct test_suite *t, int subtest)
 	return err;
 }
 
-struct shell_test {
-	const char *file;
-};
-
-static int shell_test__run(struct test_suite *test, int subdir __maybe_unused)
-{
-	int err;
-	struct shell_test *st = test->priv;
-	char *cmd;
-
-	asprintf(&cmd, "%s%s", st->file, verbose ? " -v" : "");
-	if (!cmd)
-		return TEST_FAIL;
-	err = system(cmd);
-	free(cmd);
-	if (!err)
-		return TEST_OK;
-
-	return WEXITSTATUS(err) == 2 ? TEST_SKIP : TEST_FAIL;
-}
-
-static int run_shell_tests(int argc, const char *argv[], int i, int width,
-				struct intlist *skiplist)
-{
-	struct shell_test st;
-	const struct script_file *files, *file;
-
-	files = list_script_files();
-	if (!files)
-		return 0;
-	for (file = files; file->file; file++) {
-		int curr = i++;
-		struct test_case test_cases[] = {
-			{
-				.desc = file->desc,
-				.run_case = shell_test__run,
-			},
-			{ .name = NULL, }
-		};
-		struct test_suite test_suite = {
-			.desc = test_cases[0].desc,
-			.test_cases = test_cases,
-			.priv = &st,
-		};
-		st.file = file->file;
-
-		if (test_suite.desc == NULL ||
-		    !perf_test__matches(test_suite.desc, curr, argc, argv))
-			continue;
-
-		pr_info("%3d: %-*s:", i, width, test_suite.desc);
-
-		if (intlist__find(skiplist, i)) {
-			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
-			continue;
-		}
-
-		test_and_print(&test_suite, 0);
-	}
-	return 0;
-}
-
 static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 {
 	struct test_suite *t;
 	unsigned int j, k;
 	int i = 0;
-	int width = list_script_max_width();
+	int width = 0;
 
 	for_each_test(j, k, t) {
 		int len = strlen(test_description(t, -1));
@@ -443,28 +382,6 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 			}
 		}
 	}
-
-	return run_shell_tests(argc, argv, i, width, skiplist);
-}
-
-static int perf_test__list_shell(int argc, const char **argv, int i)
-{
-	const struct script_file *files, *file;
-
-	files = list_script_files();
-	if (!files)
-		return 0;
-	for (file = files; file->file; file++) {
-		int curr = i++;
-		struct test_suite t = {
-			.desc = file->desc
-		};
-
-		if (!perf_test__matches(t.desc, curr, argc, argv))
-			continue;
-
-		pr_info("%3d: %s\n", i, t.desc);
-	}
 	return 0;
 }
 
@@ -491,9 +408,6 @@ static int perf_test__list(int argc, const char **argv)
 					test_description(t, subi));
 		}
 	}
-
-	perf_test__list_shell(argc, argv, i);
-
 	return 0;
 }
 
@@ -553,6 +467,7 @@ int cmd_test(int argc, const char **argv)
 	/* Unbuffered output */
 	setvbuf(stdout, NULL, _IONBF, 0);
 
+	tests[2] = create_script_test_suites();
 	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
 	if (argc >= 1 && !strcmp(argv[0], "list"))
 		return perf_test__list(argc - 1, argv + 1);
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index 9b3b66dd5508..b92a93c251c6 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -26,16 +26,6 @@
 #include "tests.h"
 #include "util/rlimit.h"
 
-
-/*
- * As this is a singleton built once for the run of the process, there is
- * no value in trying to free it and just let it stay around until process
- * exits when it's cleaned up.
- */
-static size_t files_num = 0;
-static struct script_file *files = NULL;
-static int files_max_width = 0;
-
 static int shell_tests__dir_fd(void)
 {
 	char path[PATH_MAX], *exec_path;
@@ -131,12 +121,31 @@ static char *strdup_check(const char *str)
 	return newstr;
 }
 
-static void append_script(int dir_fd, const char *name, char *desc)
+static int shell_test__run(struct test_suite *test, int subtest __maybe_unused)
+{
+	const char *file = test->priv;
+	int err;
+	char *cmd;
+
+	asprintf(&cmd, "%s%s", file, verbose ? " -v" : "");
+	if (!cmd)
+		return TEST_FAIL;
+	err = system(cmd);
+	free(cmd);
+	if (!err)
+		return TEST_OK;
+
+	return WEXITSTATUS(err) == 2 ? TEST_SKIP : TEST_FAIL;
+}
+
+static void append_script(int dir_fd, const char *name, char *desc,
+			  struct test_suite ***result,
+			  size_t *result_sz)
 {
 	char filename[PATH_MAX], link[128];
-	struct script_file *files_tmp;
-	size_t files_num_tmp, len;
-	int width;
+	struct test_suite *test_suite, **result_tmp;
+	struct test_case *tests;
+	size_t len;
 
 	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
 	len = readlink(link, filename, sizeof(filename));
@@ -146,33 +155,43 @@ static void append_script(int dir_fd, const char *name, char *desc)
 	}
 	filename[len++] = '/';
 	strcpy(&filename[len], name);
-	files_num_tmp = files_num + 1;
-	if (files_num_tmp >= SIZE_MAX) {
-		pr_err("Too many script files\n");
-		abort();
+
+	tests = calloc(2, sizeof(*tests));
+	if (!tests) {
+		pr_err("Out of memory while building script test suite list\n");
+		return;
+	}
+	tests[0].name = strdup_check(name);
+	tests[0].desc = strdup_check(desc);
+	tests[0].run_case = shell_test__run;
+
+	test_suite = zalloc(sizeof(*test_suite));
+	if (!test_suite) {
+		pr_err("Out of memory while building script test suite list\n");
+		free(tests);
+		return;
 	}
+	test_suite->desc = desc;
+	test_suite->test_cases = tests;
+	test_suite->priv = strdup_check(filename);
 	/* Realloc is good enough, though we could realloc by chunks, not that
 	 * anyone will ever measure performance here */
-	files_tmp = realloc(files,
-			    (files_num_tmp + 1) * sizeof(struct script_file));
-	if (files_tmp == NULL) {
-		pr_err("Out of memory while building test list\n");
-		abort();
+	result_tmp = realloc(*result, (*result_sz + 1) * sizeof(*result_tmp));
+	if (result_tmp == NULL) {
+		pr_err("Out of memory while building script test suite list\n");
+		free(tests);
+		free(test_suite);
+		return;
 	}
 	/* Add file to end and NULL terminate the struct array */
-	files = files_tmp;
-	files_num = files_num_tmp;
-	files[files_num - 1].file = strdup_check(filename);
-	files[files_num - 1].desc = desc;
-	files[files_num].file = NULL;
-	files[files_num].desc = NULL;
-
-	width = strlen(desc); /* Track max width of desc */
-	if (width > files_max_width)
-		files_max_width = width;
+	*result = result_tmp;
+	(*result)[*result_sz] = test_suite;
+	(*result_sz)++;
 }
 
-static void append_scripts_in_dir(int dir_fd)
+static void append_scripts_in_dir(int dir_fd,
+				  struct test_suite ***result,
+				  size_t *result_sz)
 {
 	struct dirent **entlist;
 	struct dirent *ent;
@@ -191,7 +210,7 @@ static void append_scripts_in_dir(int dir_fd)
 			char *desc = shell_test__description(dir_fd, ent->d_name);
 
 			if (desc) /* It has a desc line - valid script */
-				append_script(dir_fd, ent->d_name, desc);
+				append_script(dir_fd, ent->d_name, desc, result, result_sz);
 			continue;
 		}
 		if (ent->d_type != DT_DIR) {
@@ -204,32 +223,31 @@ static void append_scripts_in_dir(int dir_fd)
 				continue;
 		}
 		fd = openat(dir_fd, ent->d_name, O_PATH);
-		append_scripts_in_dir(fd);
+		append_scripts_in_dir(fd, result, result_sz);
 	}
 	for (i = 0; i < n_dirs; i++) /* Clean up */
 		zfree(&entlist[i]);
 	free(entlist);
 }
 
-const struct script_file *list_script_files(void)
+struct test_suite **create_script_test_suites(void)
 {
-	int dir_fd;
-
-	if (files)
-		return files; /* Singleton - we already know our list */
+	struct test_suite **result = NULL, **result_tmp;
+	size_t result_sz = 0;
+	int dir_fd = shell_tests__dir_fd(); /* Walk  dir */
 
-	dir_fd = shell_tests__dir_fd(); /* Walk  dir */
 	if (dir_fd < 0)
 		return NULL;
 
-	append_scripts_in_dir(dir_fd);
+	append_scripts_in_dir(dir_fd, &result, &result_sz);
+	result_tmp = realloc(result, (result_sz + 1) * sizeof(*result_tmp));
+	if (result_tmp == NULL) {
+		pr_err("Out of memory while building script test suite list\n");
+		abort();
+	}
+	/* NULL terminate the test suite array. */
+	result = result_tmp;
+	result[result_sz] = NULL;
 	close(dir_fd);
-
-	return files;
-}
-
-int list_script_max_width(void)
-{
-	list_script_files(); /* Ensure we have scanned all scripts */
-	return files_max_width;
+	return result;
 }
diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-scripts.h
index 3508a293aaf9..b553ad26ea17 100644
--- a/tools/perf/tests/tests-scripts.h
+++ b/tools/perf/tests/tests-scripts.h
@@ -2,14 +2,8 @@
 #ifndef TESTS_SCRIPTS_H
 #define TESTS_SCRIPTS_H
 
-struct script_file {
-	char *file;
-	char *desc;
-};
+#include "tests.h"
 
-/* List available script tests to run - singleton - never freed */
-const struct script_file *list_script_files(void);
-/* Get maximum width of description string */
-int list_script_max_width(void);
+struct test_suite **create_script_test_suites(void);
 
 #endif /* TESTS_SCRIPTS_H */
-- 
2.43.0.rc2.451.g8631bc7472-goog

