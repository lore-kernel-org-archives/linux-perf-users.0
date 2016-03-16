From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 1/9] perf test: Adding an entry for the perftool-testsuite
 - CORRECT
Date: Wed, 16 Mar 2016 15:05:08 +0100 (CET)
Message-ID: <alpine.LRH.2.20.1603161502460.13911@Rudolf-RHEL-7>
References: <cover.1458136740.git.mpetlan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59559 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966111AbcCPOFL (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Mar 2016 10:05:11 -0400
In-Reply-To: <cover.1458136740.git.mpetlan@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org, jolsa@redhat.com

THIS SHOULD BE CORRECT, please ignore the previous "[PATCH 1/9]".
-----------------------------------------------------------------------

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
     ./perf test suite -vv

(for the verbose output)

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
  tools/perf/tests/Build          |   1 +
  tools/perf/tests/builtin-test.c |   4 ++
  tools/perf/tests/suite.c        | 150 ++++++++++++++++++++++++++++++++++++++++
  tools/perf/tests/suite.h        |  30 ++++++++
  tools/perf/tests/tests.h        |   1 +
  5 files changed, 186 insertions(+)
  create mode 100644 tools/perf/tests/suite.c
  create mode 100644 tools/perf/tests/suite.h

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 1ba628e..c26fd8b 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -37,6 +37,7 @@ perf-y += topology.o
  perf-y += cpumap.o
  perf-y += stat.o
  perf-y += event_update.o
+perf-y += suite.o

  $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
  	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index f2b1dca..14246a1 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -204,6 +204,10 @@ static struct test generic_tests[] = {
  		.func = test__event_update,
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
index 0000000..17f6610
--- /dev/null
+++ b/tools/perf/tests/suite.c
@@ -0,0 +1,150 @@
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
+int test__suite(int subtest __maybe_unused)
+{
+	DIR *dp;
+	struct dirent *ep;
+	int failures = 0;
+	int ret;
+	int test_status = TEST_OK;
+	char verbosity_str[2];
+	int _verbose = (verbose > 9)? 9 : verbose;
+	char tempdir_template[24], *_tempdir_template;
+
+	/* set verbosity according to perf-test command line switches */
+	snprintf(verbosity_str, 2, "%i", _verbose);
+	setenv("TESTLOG_VERBOSITY", verbosity_str, 1);
+
+	/* always place all temp files and logs elsewhere */
+	strcpy(tempdir_template, "/tmp/perfsuite-XXXXXX");
+	_tempdir_template = mkdtemp(tempdir_template);
+	setenv("PERFSUITE_RUN_DIR", _tempdir_template, 1);
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
index 82b2b5e..af516de 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -85,6 +85,7 @@ int test__synthesize_stat_config(int subtest);
  int test__synthesize_stat(int subtest);
  int test__synthesize_stat_round(int subtest);
  int test__event_update(int subtest);
+int test__suite(int subtest);

  #if defined(__arm__) || defined(__aarch64__)
  #ifdef HAVE_DWARF_UNWIND_SUPPORT
-- 
1.8.3.1
