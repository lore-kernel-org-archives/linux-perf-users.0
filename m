Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CEA279329;
	Fri, 16 Oct 2026 00:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109972; cv=none; b=mfCSFIlFMW76RY3dMvmgNmnJvtCRg7v4WDGglACKM7O7H8xAA4HCD2Q7QVCsvRqZjSXwMT+Ityjo5GACs0PrcZOhbL+jpqpHqDFuGyVNFjJpXVqKWaQ/cUH7OieHl5d9C9KIdSxOFh6zf6Ou6gbuYimPceP1ZlRxnKZ4PNMiiI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109972; c=relaxed/simple;
	bh=gQKeZX8ZMQZxh1AN7NcPu7mfdslrdrr3HtktHuTdtng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRAHDb/NwhyINgnaSd4fNZuZjfIeYG2OMEJx4BReqO688dM1d2V7wfh1InHdbbepzZ6NNotMCMhlcVYsyHQBzhYVRIjRwpezWYQUHubjur58v4mp/Fem/klNsoUo982OidmqWRH/FIXBvGeGHcJDL1aWnKPJ2TX3a45Wk4q75wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOa8L/9K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOa8L/9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29C71F000C5;
	Fri, 16 Oct 2026 00:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109971;
	bh=mzxg/bvBf5b5VFLKivuApjX9b5H9Ys3cqxZGxAUNFjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iOa8L/9KUZOnsxW2zUYHGYN5zbdHBrOYTRY5SU5a4+3wgnzzRvlEiDW2E+ncni0Dc
	 obALNPj6uQTsspc1Nij1vCShOjPsOzllkeQVHSqbLRWVQUN/Hj5u+0Xt/8Uj3lLl+6
	 UCe1Ecu14L3MSGFavCRdWvrY7rf9eRQrAXvJmY/axiEeLHQ26dzCwkF+smaQIupR2o
	 ajRk4zreWcYsmX1CHN/uvjjdGrTZBknPKyOKrTk2Cp51kmeadpsdBL2b7nM7PojEuc
	 bdJZV/FhcFKmcRbJ75L/QBdPsUzt1aShpP1oY6IcWFncchkKgbOMVafe+lh5j/mgWR
	 7mMx1OHrJMMXA==
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
Subject: [PATCH v3 15/19] perf tests: Introduce a 'needs_mlock' suite flag
Date: Thu, 15 Oct 2026 21:18:39 -0300
Message-ID: <20261016001843.71978-16-acme@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016001843.71978-1-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
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
room in that budget by default; the requisites, a comma separated list in
the parens ending their description line, name what a test needs and take
a "no_" prefix to waive it, e.g.:

  # perf stat tests (no_mlock)

"mlock" is room in that budget, so stating it only spells the default
out, "no_mlock" waives it, and "exclusive" is the catch-all that keeps a
test from running alongside any other, so it runs alone, in sequence, and
implies every other requisite, which is why it can't be waived either.
More requisites are to come, each stating what a test needs, till the
catch-all isn't needed anymore.

'perf test requisites' lists what each test needs, reusing the listing
routine and taking the same test name fragments and numbers as 'list'.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-test.txt | 35 ++++++++++-
 tools/perf/tests/builtin-test.c        | 44 ++++++++++++--
 tools/perf/tests/tests-scripts.c       | 84 ++++++++++++++++++++++++--
 tools/perf/tests/tests.h               | 17 ++++++
 4 files changed, 166 insertions(+), 14 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 859df74e62efc4b1..156c6e8caa75f153 100644
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
@@ -18,9 +18,38 @@ also will look for a directory with more tests in the form of scripts.
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
+running at the same time.  Tests state what they need, or waive, in a comma
+separated list in the parens ending their description line, e.g.:
+
+	# perf stat tests (no_mlock)
+
+Each requisite is named in that list, "mlock" being room in the budget set in
+kernel.perf_event_mlock_kb, and takes a "no_" prefix to waive it: "(mlock)"
+states the default, "(no_mlock)" waives it, for tests that don't map ring
+buffers.  Leaving a requisite out states nothing about it, so what happens
+then is up to each kind of test: shell ones run perf, that maps ring buffers,
+so they are taken to need room in the budget unless they waive it, while C
+suites say which ones map, see DEFINE_SUITE_NEEDS_MLOCK() in tests.h.
+"exclusive" is a catch-all: the test can't run alongside any other one, so
+it runs alone, in sequence, and implies every other requisite; it can't be
+waived.  More requisites are to come, each stating what a test needs, till
+the catch-all isn't needed anymore.
+
+Use 'perf test requisites' to list what each test needs.  That listing states
+the needs, not the requisites form used in the scripts: a test listed as
+needing "mlock" is one whose script doesn't say "(no_mlock)".
+
 OPTIONS
 -------
 -s::
@@ -36,8 +65,8 @@ OPTIONS
 
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
index 0370bc7013737e31..0bc84372eae09abe 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -179,6 +179,79 @@ static int shell_test__run(struct test_suite *test, int subtest __maybe_unused)
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
+	char *lparen, *rparen, *requisites, *token, *tokp;
+	bool known = false;
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
+	/* Tokenize a copy: a list with nothing recognized leaves desc alone. */
+	requisites = strndup(lparen + 1, rparen - lparen - 1);
+	if (requisites == NULL) {
+		pr_err("Failed to copy the requisites of '%s'\n", desc);
+		return;
+	}
+
+	for (token = strtok_r(requisites, ",", &tokp); token;
+	     token = strtok_r(NULL, ",", &tokp)) {
+		char *end = token + strlen(token);
+		const char *requisite = token;
+		bool waived;
+
+		while (isspace(*token))
+			token++;
+		while (end > token && isspace(end[-1]))
+			end--;
+		*end = '\0';
+
+		/* A "no_" prefix waives the requisite named after it. */
+		waived = strncmp(token, "no_", sizeof("no_") - 1) == 0;
+		if (waived)
+			token += sizeof("no_") - 1;
+
+		if (!strcmp(token, "mlock")) {
+			*needs_mlock = !waived;
+		} else if (!strcmp(token, "exclusive") && !waived) {
+			*exclusive = true;
+		} else {
+			pr_debug("Ignoring %s requisite '%s' in '%s'\n",
+				 strcmp(token, "exclusive") == 0 ? "a waived" : "an unknown",
+				 requisite, desc);
+			continue;
+		}
+
+		known = true;
+	}
+
+	zfree(&requisites);
+
+	if (!known)
+		return;
+
+	/* Drop the list and the space before it from the description. */
+	*lparen = '\0';
+	if (lparen > desc && isspace(lparen[-1]))
+		lparen[-1] = '\0';
+
+	/* The catch-all implies every other requisite, whatever the order. */
+	if (*exclusive)
+		*needs_mlock = true;
+}
+
 static void append_script(int dir_fd, const char *name, char *desc,
 			  struct test_suite ***result,
 			  size_t *result_sz)
@@ -187,7 +260,8 @@ static void append_script(int dir_fd, const char *name, char *desc,
 	struct test_suite *test_suite, **result_tmp;
 	struct test_case *tests;
 	ssize_t len;
-	char *exclusive;
+	/* Shell tests run perf, that maps ring buffers, so they need the budget. */
+	bool exclusive = false, needs_mlock = true;
 
 	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
 	len = readlink(link, filename, sizeof(filename) - 1);
@@ -204,11 +278,8 @@ static void append_script(int dir_fd, const char *name, char *desc,
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
@@ -220,6 +291,7 @@ static void append_script(int dir_fd, const char *name, char *desc,
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

