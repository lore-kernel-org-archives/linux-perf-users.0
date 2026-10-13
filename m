Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F9E54CF68;
	Tue, 13 Oct 2026 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922513; cv=none; b=lACf+SnQptRtLPX1+O6dyKS8ZTiPTE+DYv9GW2P4OtTvXeKuZbRul+yEimxFHfmCHdnUpXMDzr1IAwAIWv3jpeNBHXk670s7QvIm2AVGbtCIBx+Nyu00lAsa2U9Z43j4hoHaHqDcW/8ba671N9xOEHjMFrTZym4A70bpqZQ1Syg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922513; c=relaxed/simple;
	bh=hB2DB9kzoRBu9oabdQ9udatPxaLJPNfl4WMCwmPilQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hk7IA9XTG8+Emk4qrAIW5SyMh7HlkLlhZloQiLoWZzIHvqRb3xZH2oVKWCJvwK2xPusxy6+8AbtRhCzhVOzMk7Ic+Qfz3AGPMTEj6hP9Z+aAXTcnSm0wZPNBjTBoDj3kBT3UW5NODULtCwGPCjgifqU5xAAJuoIbGpCWR9ARKdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUVpjsbB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUVpjsbB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433501F000FF;
	Tue, 13 Oct 2026 20:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922509;
	bh=SUOrTUSolageUUp0dKPh8t9keZKbictt5j8UHY6pocI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lUVpjsbBSYh0N+xU6klsGxWN/vH1057aFgopJJQ9cNEggKEBCKqTwBx8jHksqlrMz
	 wWRvnR2s0onSUjAJ8OYHLfixNEPdFK8TOT0mT+0HX2rnuWp+eDRDFCQQ5aP61rbHGn
	 NcZEY4aBlLcRRxZV3bwW4ffEnil3lfpp+3c+GknblnisZ8K2juHbx4UjlHW85Eq+gy
	 +cTj3jVWlo2wrTIWSm3FCjUQ5lt3PH6Lw5c7zix6cb3Y8z5OhiXxhojk2O0CC3EWlh
	 y5efzrE+gzv7c+JThT6xOhJlnjYdTBIHSIBAPmAV+7Kr62MBzItHnVUpVX5gsGOVlG
	 NNHfgso4P6c2Q==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 15/19] perf tests: Introduce a 'needs_mlock' suite flag
Date: Tue, 13 Oct 2026 17:14:10 -0300
Message-ID: <20261013201415.36428-16-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013201415.36428-1-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Each perf instance maps one ring buffer per CPU, all charged to the same
per user budget set in kernel.perf_event_mlock_kb, so suites that map
them need to be told apart from the ones that don't, to later have them
take turns using that budget while the other tests keep running in
parallel.

Add the flag to 'struct test_suite' and a DEFINE_SUITE_NEEDS_MLOCK()
variant for the suites using the DEFINE_SUITE() form.

Shell tests run perf, that maps ring buffers, so they are taken to need
room in that budget by default; the ones that don't map them waive it in
the requisites, a comma separated list in the parens ending their
description line, e.g.:

  # perf stat tests (no_mlock)

"exclusive" is the catch-all that keeps a test from running alongside
any other, so it runs alone, in sequence, and implies every other
requisite, "no_mlock" waives the default, and more keywords are to come,
each stating what a test needs, till the catch-all isn't needed anymore.

'perf test requisites' lists what each test needs, reusing the listing
routine and taking the same test name fragments and numbers as 'list'.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-test.txt | 28 +++++++++++++--
 tools/perf/tests/builtin-test.c        | 44 +++++++++++++++++++++---
 tools/perf/tests/tests-scripts.c       | 47 ++++++++++++++++++++++----
 tools/perf/tests/tests.h               | 17 ++++++++++
 4 files changed, 122 insertions(+), 14 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 859df74e62efc4b1..d3a7f7efaec705ed 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -8,7 +8,7 @@ perf-test - Runs sanity tests.
 SYNOPSIS
 --------
 [verse]
-'perf test [<options>] [{list <test-name-fragment>|[<test-name-fragments>|<test-numbers>]}]'
+'perf test [<options>] [{list|requisites} [<test-name-fragment>]|[<test-name-fragments>|<test-numbers>]]'
 
 DESCRIPTION
 -----------
@@ -18,9 +18,31 @@ also will look for a directory with more tests in the form of scripts.
 To get a list of available tests use 'perf test list', specifying a test name
 fragment will show all tests that have it.
 
+To get a list of what the tests need, i.e. of their requisites (see below), use
+'perf test requisites', that takes the same test name fragments and numbers as
+'list'.
+
 To run just specific tests, inform test name fragments or the numbers obtained
 from 'perf test list'.
 
+REQUISITES
+----------
+Shell tests run perf, that maps ring buffers, so they are taken to need room
+in the per user budget set in kernel.perf_event_mlock_kb, shared by the tests
+running at the same time, that take turns using it.  Tests state what they
+need, or waive, in a comma separated list in the parens ending their
+description line, e.g.:
+
+	# perf stat tests (no_mlock)
+
+"exclusive" is a catch-all: the test can't run alongside any other one, so
+it runs alone, in sequence, and implies every other requisite.  "no_mlock"
+waives the default, for tests that don't map ring buffers.  More keywords
+are to come, each stating what a test needs, till the catch-all isn't needed
+anymore.
+
+Use 'perf test requisites' to list what each test needs.
+
 OPTIONS
 -------
 -s::
@@ -36,8 +58,8 @@ OPTIONS
 
 -S::
 --sequential::
-	Run all tests one after the other. By default "exclusive"
-	tests are run sequentially, but other tests are run in
+	Run all tests one after the other. By default the tests asking to be
+	"exclusive" (see REQUISITES) run sequentially, but other tests run in
 	parallel to speed execution.
 
 -r::
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 98134b1c74cf80f4..acffa0d0d33d6d30 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -56,6 +56,8 @@ static struct strbuf junit_xml_buf = STRBUF_INIT;
 static bool dont_fork;
 /* Fork the tests in parallel and wait for their completion. */
 static bool sequential;
+/* List what each test needs, set by the "requisites" subcommand. */
+static bool list_requisites;
 /* Number of times each test is run. */
 static unsigned int runs_per_test = 1;
 /* Number of lines to include in failure snippet. */
@@ -283,6 +285,30 @@ static const char *test_description(const struct test_suite *t, int test_case)
 	return t->desc;
 }
 
+static void requisites__fprintf(FILE *fp, const struct test_suite *t, int test_case)
+{
+	bool needs_mlock = t->needs_mlock, exclusive;
+
+	if (test_case < 0)
+		test_case = test_suite__num_test_cases(t) == 1 ? 0 : -1;
+
+	if (test_case >= 0) {
+		exclusive = t->test_cases[test_case].exclusive;
+		/* The catch-all implies every other requisite. */
+		needs_mlock = needs_mlock || exclusive;
+	} else {
+		exclusive = false;
+	}
+
+	if (!exclusive && !needs_mlock)
+		return;
+
+	fprintf(fp, " (");
+	if (exclusive)
+		fprintf(fp, "exclusive, ");
+	fprintf(fp, "mlock)");
+}
+
 static test_fnptr test_function(const struct test_suite *t, int test_case)
 {
 	if (test_case <= 0)
@@ -1450,14 +1476,20 @@ static int perf_test__list(FILE *fp, struct test_suite **suites, int argc, const
 		if (!perf_test__matches(test_description(*t, -1), curr_suite, argc, argv))
 			continue;
 
-		fprintf(fp, "%3d: %s\n", curr_suite + 1, test_description(*t, -1));
+		fprintf(fp, "%3d: %s", curr_suite + 1, test_description(*t, -1));
+		if (list_requisites)
+			requisites__fprintf(fp, *t, /*test_case=*/-1);
+		fprintf(fp, "\n");
 
 		if (test_suite__num_test_cases(*t) <= 1)
 			continue;
 
 		test_suite__for_each_test_case(*t, curr_test_case) {
-			fprintf(fp, "%3d.%1d: %s\n", curr_suite + 1, curr_test_case + 1,
+			fprintf(fp, "%3d.%1d: %s", curr_suite + 1, curr_test_case + 1,
 				test_description(*t, curr_test_case));
+			if (list_requisites)
+				requisites__fprintf(fp, *t, curr_test_case);
+			fprintf(fp, "\n");
 		}
 	}
 	return 0;
@@ -1747,7 +1779,8 @@ static struct test_suite **build_suites(void)
 int cmd_test(int argc, const char **argv)
 {
 	const char *test_usage[] = {
-	"perf test [<options>] [{list <test-name-fragment>|[<test-name-fragments>|<test-numbers>]}]",
+	"perf test [<options>] [{list|requisites} [<test-name-fragment>]|"
+	"[<test-name-fragments>|<test-numbers>]]",
 	NULL,
 	};
 	const char *skip = NULL;
@@ -1776,7 +1809,7 @@ int cmd_test(int argc, const char **argv)
 			  "Generate junit XML output, default test.xml", "test.xml"),
 	OPT_END()
 	};
-	const char * const test_subcommands[] = { "list", NULL };
+	const char * const test_subcommands[] = { "list", "requisites", NULL };
 	struct intlist *skiplist = NULL;
 	struct test_suite **suites;
 	int ret;
@@ -1808,10 +1841,11 @@ int cmd_test(int argc, const char **argv)
 	setvbuf(stdout, NULL, _IONBF, 0);
 
 	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
-	if (argc >= 1 && !strcmp(argv[0], "list")) {
+	if (argc >= 1 && (!strcmp(argv[0], "list") || !strcmp(argv[0], "requisites"))) {
 		suites = build_suites();
 		if (!suites)
 			return errno ? -errno : -ENOMEM;
+		list_requisites = !strcmp(argv[0], "requisites");
 		ret = perf_test__list(stdout, suites, argc - 1, argv + 1);
 		free(suites);
 		return ret;
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index 0370bc7013737e31..03430cdb9a5cc14c 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -179,6 +179,42 @@ static int shell_test__run(struct test_suite *test, int subtest __maybe_unused)
 	return WEXITSTATUS(err) == 2 ? TEST_SKIP : TEST_FAIL;
 }
 
+/*
+ * The requisites are a comma separated list in the parens ending the
+ * description line, e.g. "perf stat tests (no_mlock)": "exclusive" is the
+ * catch-all, implying every other requisite, "no_mlock" waives the default of
+ * needing room in the per user budget set in kernel.perf_event_mlock_kb.
+ */
+static void shell_test__requisites(char *desc, bool *exclusive, bool *needs_mlock)
+{
+	char *lparen, *rparen, *requisites;
+
+	/* Only a list closing the description line is taken for requisites. */
+	rparen = strrchr(desc, ')');
+	if (rparen == NULL || rparen[1] != '\0')
+		return;
+
+	lparen = strrchr(desc, '(');
+	if (lparen == NULL || lparen > rparen)
+		return;
+
+	requisites = lparen + 1;
+	*exclusive = strstr(requisites, "exclusive") != NULL;
+	if (*exclusive) {
+		/* The catch-all implies every other requisite. */
+		*needs_mlock = true;
+	} else if (strstr(requisites, "no_mlock")) {
+		*needs_mlock = false;
+	} else if (!strstr(requisites, "mlock")) {
+		/* Unknown requisite: leave the parens in the description. */
+		return;
+	}
+
+	*lparen = '\0';
+	if (lparen > desc && isspace(lparen[-1]))
+		lparen[-1] = '\0';
+}
+
 static void append_script(int dir_fd, const char *name, char *desc,
 			  struct test_suite ***result,
 			  size_t *result_sz)
@@ -187,7 +223,8 @@ static void append_script(int dir_fd, const char *name, char *desc,
 	struct test_suite *test_suite, **result_tmp;
 	struct test_case *tests;
 	ssize_t len;
-	char *exclusive;
+	/* Shell tests run perf, that maps ring buffers, so they need the budget. */
+	bool exclusive = false, needs_mlock = true;
 
 	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
 	len = readlink(link, filename, sizeof(filename) - 1);
@@ -204,11 +241,8 @@ static void append_script(int dir_fd, const char *name, char *desc,
 		return;
 	}
 	tests[0].name = strdup_check(name);
-	exclusive = strstr(desc, " (exclusive)");
-	if (exclusive != NULL) {
-		tests[0].exclusive = true;
-		exclusive[0] = '\0';
-	}
+	shell_test__requisites(desc, &exclusive, &needs_mlock);
+	tests[0].exclusive = exclusive;
 	tests[0].desc = strdup_check(desc);
 	tests[0].run_case = shell_test__run;
 	test_suite = zalloc(sizeof(*test_suite));
@@ -220,6 +254,7 @@ static void append_script(int dir_fd, const char *name, char *desc,
 	test_suite->desc = desc;
 	test_suite->test_cases = tests;
 	test_suite->priv = strdup_check(filename);
+	test_suite->needs_mlock = needs_mlock;
 	/* Realloc is good enough, though we could realloc by chunks, not that
 	 * anyone will ever measure performance here */
 	result_tmp = realloc(*result, (*result_sz + 1) * sizeof(*result_tmp));
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index f379620069d34f3a..5982c4e62cd37206 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -46,6 +46,12 @@ struct test_suite {
 	struct test_case *test_cases;
 	void *priv;
 	int (*setup)(struct test_suite *suite);
+	/*
+	 * Set for the suites mapping perf ring buffers, that need room in the
+	 * per user budget set in kernel.perf_event_mlock_kb, see
+	 * shell_test__requisites() for the shell suites.
+	 */
+	bool needs_mlock;
 };
 
 #define DECLARE_SUITE(name) \
@@ -103,6 +109,17 @@ struct test_suite {
 		.test_cases = tests__##_name,		\
 	}
 
+#define DEFINE_SUITE_NEEDS_MLOCK(description, _name)	\
+	struct test_case tests__##_name[] = {           \
+		TEST_CASE(description, _name),		\
+		{	.name = NULL, }			\
+	};						\
+	struct test_suite suite__##_name = {		\
+		.desc = description,			\
+		.test_cases = tests__##_name,		\
+		.needs_mlock = true,			\
+	}
+
 /* Tests */
 DECLARE_SUITE(vmlinux_matches_kallsyms);
 DECLARE_SUITE(openat_syscall_event);
-- 
2.55.0

