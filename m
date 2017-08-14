From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/19] perf test: Add infrastructure to run shell based tests
Date: Mon, 14 Aug 2017 13:27:30 -0300
Message-ID: <20170814162741.6101-9-acme@kernel.org>
References: <20170814162741.6101-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814162741.6101-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To allow testing by directly using perf tools in scripts, checking that
the effects on the system are the ones expected and that the output
produced is as well the desired one.

For instance, adding a probe at a well known location with 'perf probe',
then checking that the results from using that probe to record are the
desired ones, etc.

The next csets will introduce tests using this new testing
infrastructure.

The scripts should return 0 for Ok, 1 for FAIL and 2 for SKIP.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-swbpn7amrjqffh83lsr39s9p@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 170 +++++++++++++++++++++++++++++++++++++++-
 tools/perf/tests/tests.h        |   1 +
 2 files changed, 170 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 0186abbad899..2bd158e3c02f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -6,7 +6,10 @@
 #include <errno.h>
 #include <unistd.h>
 #include <string.h>
+#include <sys/types.h>
+#include <dirent.h>
 #include <sys/wait.h>
+#include <sys/stat.h>
 #include "builtin.h"
 #include "hist.h"
 #include "intlist.h"
@@ -14,8 +17,10 @@
 #include "debug.h"
 #include "color.h"
 #include <subcmd/parse-options.h>
+#include "string2.h"
 #include "symbol.h"
 #include <linux/kernel.h>
+#include <subcmd/exec-cmd.h>
 
 static bool dont_fork;
 
@@ -383,12 +388,143 @@ static int test_and_print(struct test *t, bool force_skip, int subtest)
 	return err;
 }
 
+static const char *shell_test__description(char *description, size_t size,
+					   const char *path, const char *name)
+{
+	FILE *fp;
+	char filename[PATH_MAX];
+
+	path__join(filename, sizeof(filename), path, name);
+	fp = fopen(filename, "r");
+	if (!fp)
+		return NULL;
+
+	description = fgets(description, size, fp);
+	fclose(fp);
+
+	return description ? trim(description + 1) : NULL;
+}
+
+#define for_each_shell_test(dir, ent)		\
+	while ((ent = readdir(dir)) != NULL)	\
+		if (ent->d_type == DT_REG && ent->d_name[0] != '.')
+
+static const char *shell_tests__dir(char *path, size_t size)
+{
+	const char *devel_dirs[] = { "./tools/perf/tests", "./tests", };
+        char *exec_path;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(devel_dirs); ++i) {
+		struct stat st;
+		if (!lstat(devel_dirs[i], &st)) {
+			scnprintf(path, size, "%s/shell", devel_dirs[i]);
+			if (!lstat(devel_dirs[i], &st))
+				return path;
+		}
+	}
+
+        /* Then installed path. */
+        exec_path = get_argv_exec_path();
+        scnprintf(path, size, "%s/tests/shell", exec_path);
+	free(exec_path);
+	return path;
+}
+
+static int shell_tests__max_desc_width(void)
+{
+	DIR *dir;
+	struct dirent *ent;
+	char path_dir[PATH_MAX];
+	const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
+	int width = 0;
+
+	if (path == NULL)
+		return -1;
+
+	dir = opendir(path);
+	if (!dir)
+		return -1;
+
+	for_each_shell_test(dir, ent) {
+		char bf[256];
+		const char *desc = shell_test__description(bf, sizeof(bf), path, ent->d_name);
+
+		if (desc) {
+			int len = strlen(desc);
+
+			if (width < len)
+				width = len;
+		}
+	}
+
+	closedir(dir);
+	return width;
+}
+
+struct shell_test {
+	const char *dir;
+	const char *file;
+};
+
+static int shell_test__run(struct test *test, int subdir __maybe_unused)
+{
+	int err;
+	char script[PATH_MAX];
+	struct shell_test *st = test->priv;
+
+	path__join(script, sizeof(script), st->dir, st->file);
+
+	err = system(script);
+	if (!err)
+		return TEST_OK;
+
+	return WEXITSTATUS(err) == 2 ? TEST_SKIP : TEST_FAIL;
+}
+
+static int run_shell_tests(int argc, const char *argv[], int i, int width)
+{
+	DIR *dir;
+	struct dirent *ent;
+	char path_dir[PATH_MAX];
+	struct shell_test st = {
+		.dir = shell_tests__dir(path_dir, sizeof(path_dir)),
+	};
+
+	if (st.dir == NULL)
+		return -1;
+
+	dir = opendir(st.dir);
+	if (!dir)
+		return -1;
+
+	for_each_shell_test(dir, ent) {
+		int curr = i++;
+		char desc[256];
+		struct test test = {
+			.desc = shell_test__description(desc, sizeof(desc), st.dir, ent->d_name),
+			.func = shell_test__run,
+			.priv = &st,
+		};
+
+		if (!perf_test__matches(&test, curr, argc, argv))
+			continue;
+
+		st.file = ent->d_name;
+		pr_info("%2d: %-*s:", i, width, test.desc);
+		test_and_print(&test, false, -1);
+	}
+
+	closedir(dir);
+	return 0;
+}
+
 static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 {
 	struct test *t;
 	unsigned int j;
 	int i = 0;
-	int width = 0;
+	int width = shell_tests__max_desc_width();
 
 	for_each_test(j, t) {
 		int len = strlen(t->desc);
@@ -455,6 +591,36 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 		}
 	}
 
+	return run_shell_tests(argc, argv, i, width);
+}
+
+static int perf_test__list_shell(int argc, const char **argv, int i)
+{
+	DIR *dir;
+	struct dirent *ent;
+	char path_dir[PATH_MAX];
+	const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
+
+	if (path == NULL)
+		return -1;
+
+	dir = opendir(path);
+	if (!dir)
+		return -1;
+
+	for_each_shell_test(dir, ent) {
+		char bf[256];
+		const char *desc = shell_test__description(bf, sizeof(bf), path, ent->d_name);
+
+		++i;
+
+		if (argc > 1 && !strstr(desc, argv[1]))
+			continue;
+
+		pr_info("%2d: %s\n", i, desc);
+	}
+
+	closedir(dir);
 	return 0;
 }
 
@@ -473,6 +639,8 @@ static int perf_test__list(int argc, const char **argv)
 		pr_info("%2d: %s\n", i, t->desc);
 	}
 
+	perf_test__list_shell(argc, argv, i);
+
 	return 0;
 }
 
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index bc207ac48fde..c46ae818aac8 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -35,6 +35,7 @@ struct test {
 		const char *(*get_desc)(int subtest);
 	} subtest;
 	bool (*is_supported)(void);
+	void *priv;
 };
 
 /* Tests */
-- 
2.13.4
