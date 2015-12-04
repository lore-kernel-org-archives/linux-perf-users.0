From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 1/2] perf test: Adding an entry for the perftool-testsuite
Date: Fri, 04 Dec 2015 18:11:04 +0100
Message-ID: <1449249064.24573.184.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52227 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755217AbbLDRLG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Dec 2015 12:11:06 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, =?UTF-8?Q?=E5=B9=B3=E6=9D=BE=E9=9B=85=E5=B7=B3?= / =?UTF-8?Q?HIRAMATU=EF=BC=8CMASAMI?= <masami.hiramatsu.pt@hitachi.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

In order to be able to run the bash/subcommand-based testsuite directly
from perf test a new perf-test entry has been created for it.

The driver (suite.c) runs all the tests  that it finds in the testsuite
directory: tools/perf/testsuite/   (rather ./testsuite as it expects it
it being run from the perf's directory).

In case the testsuite is not found, the testcase is skipped. If this is
not the desired behaviour, some packaging will be needed.

Usage:
	./perf test suite

or
	./perf test suite -v

(for the verbose output)

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   4 ++
 tools/perf/tests/suite.c        | 143 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/suite.h        |  30 +++++++++
 tools/perf/tests/tests.h        |   1 +
 5 files changed, 179 insertions(+)
 create mode 100644 tools/perf/tests/suite.c
 create mode 100644 tools/perf/tests/suite.h

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index f41ebf8..af3bb23 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -34,6 +34,7 @@ perf-y += thread-map.o
 perf-y += llvm.o llvm-src-base.o llvm-src-kbuild.o
 perf-y += bpf.o
 perf-y += topology.o
+perf-y += suite.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 80c442e..f98e1ed 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -170,6 +170,10 @@ static struct test generic_tests[] = {
 		.func = test__bpf,
 	},
 	{
+		.desc = "Testsuite",
+		.func = test__suite,
+	},
+	{
 		.func = NULL,
 	},
 };
diff --git a/tools/perf/tests/suite.c b/tools/perf/tests/suite.c
new file mode 100644
index 0000000..9cf19b1
--- /dev/null
+++ b/tools/perf/tests/suite.c
@@ -0,0 +1,143 @@
+#include "suite.h"
+
+#define TESTSUITE_ROOT "./testsuite/"
+
+/* globals */
+int fatal_occured = 0;
+char *cwd;
+
+
+/* runs a shell script */
+int _run_shell(const char *script)
+{
+	int ret;
+	char *cmd = malloc(strlen(script) + 3 * sizeof(char));
+	strcpy(cmd, "./");
+	strcpy(cmd + 2, script);
+	ret = system(cmd);
+	if (ret == -1) {
+		fprintf(stderr, "FATAL: Could not run %s", cmd);
+		fatal_occured++;
+		return 1;
+	}
+	return ret;
+}
+
+
+/* checks for existence of a file and runs it */
+int run_shell(const char *script)
+{
+	struct stat sb;
+
+	if (stat(script, &sb) == -1) {
+		fatal_occured++;
+		return 1;
+	}
+
+	if (! (sb.st_mode & (S_IXUSR | S_IFREG))) {
+		fatal_occured++;
+		return 1;
+	}
+
+	return _run_shell(script);
+}
+
+
+/* if a script is available, run it, otherwise ignore it */
+int try_shell(const char *script)
+{
+	struct stat sb;
+
+	if (stat(script, &sb) == -1)
+		return 0;
+
+	if (! (sb.st_mode & (S_IXUSR | S_IFREG)))
+		return 0;
+
+	return _run_shell(script);
+}
+
+
+/* runs a group of tests ("base_something", ...) */
+int run_group(const char *path)
+{
+	DIR *dp;
+	struct dirent *ep;
+	int ret;
+
+	int failures = 0;
+	ret = chdir(path);
+
+	if (verbose)
+		printf("======== %s ========\n", path);
+
+	/* try to run setup */
+	failures += try_shell("setup.sh");
+
+	/* scan the dir and run tests */
+	dp = opendir("./");
+	if (dp != NULL) {
+		while ((ep = readdir(dp))) {
+			if (strncmp(ep->d_name, "test_", 5))
+				continue;
+			failures += run_shell(ep->d_name);
+		}
+		closedir(dp);
+	}
+	else
+		perror("Cannot open inner dir.");
+
+	/* try to do clean-up */
+	try_shell("cleanup.sh");
+
+	ret = chdir("..");
+	ret = ret;
+	if (verbose)
+		printf("\n");
+	return failures;
+}
+
+
+/* main test */
+int test__suite(void)
+{
+	DIR *dp;
+	struct dirent *ep;
+	int failures = 0;
+	int ret;
+	int test_status = TEST_OK;
+
+	if (verbose > 0)
+		setenv("TESTMODE_QUIET", "n", 1);
+	else
+		setenv("TESTMODE_QUIET", "y", 1);
+
+	cwd = getcwd(NULL, 0);
+	ret = chdir(TESTSUITE_ROOT);
+	if (ret != 0) {
+		free(cwd);
+		return TEST_SKIP;
+	}
+
+	dp = opendir("./");
+	if (dp != NULL) {
+
+		while ((ep = readdir(dp))) {
+			if (strncmp(ep->d_name, "base_", 5))
+				continue;
+			failures += run_group(ep->d_name);
+		}
+		closedir(dp);
+	}
+	else
+		test_status = TEST_SKIP;
+
+	ret = chdir(cwd);
+	ret = ret;
+	free(cwd);
+
+	if(failures || fatal_occured)
+		test_status = TEST_FAIL;
+
+	return test_status;
+}
diff --git a/tools/perf/tests/suite.h b/tools/perf/tests/suite.h
new file mode 100644
index 0000000..53c768b
--- /dev/null
+++ b/tools/perf/tests/suite.h
@@ -0,0 +1,30 @@
+#ifndef PERF_TEST_SUITE_H
+#define PERF_TEST_SUITE_H
+
+#include <linux/compiler.h>
+#include "tests.h"
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <dirent.h>
+#include <unistd.h>
+#include <string.h>
+
+
+/* verbosity */
+extern int verbose;
+
+/* runs a shell script */
+int _run_shell(const char *script);
+
+/* checks for existence of a file and runs it */
+int run_shell(const char *script);
+
+/* if a script is available, run it, otherwise ignore it */
+int try_shell(const char *script);
+
+/* runs a group of tests ("base_something", ...) */
+int run_group(const char *path);
+
+#endif
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 3c8734a..754ade3 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -68,6 +68,7 @@ int test__thread_map(void);
 int test__llvm(void);
 int test__bpf(void);
 int test_session_topology(void);
+int test__suite(void);
 
 #if defined(__arm__) || defined(__aarch64__)
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
