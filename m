From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/23] perf jit: Move test functionality in to a test
Date: Tue,  3 Dec 2019 10:55:54 -0300
Message-ID: <20191203135606.24902-12-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexios Zavras <alexios.zavras@intel.com>, Allison Randal <allison@lohutok.net>, Florian Fainelli <f.fainelli@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Olsa <jolsa@redhat.com>, Kate Stewart <kstewart@linuxfoundation.org>, Leo Yan <leo.yan@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Song Liu <songliubraving@fb.>
List-Id: linux-perf-users.vger.kernel.org

From: Ian Rogers <irogers@google.com>

Adds a test for minimal jit_write_elf functionality.

Committer testing:

  # perf test jit
  61: Test jit_write_elf                                    : Ok
  #

  # perf test -v jit
  61: Test jit_write_elf                                    :
  --- start ---
  test child forked, pid 10460
  Writing jit code to: /tmp/perf-test-KqxURR
  test child finished with 0
  ---- end ----
  Test jit_write_elf: Ok
  #

Committer notes:

Fix up the case where HAVE_JITDUMP is no defined.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexios Zavras <alexios.zavras@intel.com>
Cc: Allison Randal <allison@lohutok.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20191126235913.41855-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build          |  1 +
 tools/perf/tests/builtin-test.c |  4 +++
 tools/perf/tests/genelf.c       | 51 +++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |  1 +
 tools/perf/util/genelf.c        | 46 -----------------------------
 5 files changed, 57 insertions(+), 46 deletions(-)
 create mode 100644 tools/perf/tests/genelf.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index a3c595fba943..1692529639b0 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -54,6 +54,7 @@ perf-y += unit_number__scnprintf.o
 perf-y += mem2node.o
 perf-y += maps.o
 perf-y += time-utils-test.o
+perf-y += genelf.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 82d19a8fcac7..5f05db75cdd8 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -301,6 +301,10 @@ static struct test generic_tests[] = {
 		.desc = "time utils",
 		.func = test__time_utils,
 	},
+	{
+		.desc = "Test jit_write_elf",
+		.func = test__jit_write_elf,
+	},
 	{
 		.desc = "maps__merge_in",
 		.func = test__maps__merge_in,
diff --git a/tools/perf/tests/genelf.c b/tools/perf/tests/genelf.c
new file mode 100644
index 000000000000..f797f9823e89
--- /dev/null
+++ b/tools/perf/tests/genelf.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/compiler.h>
+
+#include "debug.h"
+#include "tests.h"
+
+#ifdef HAVE_JITDUMP
+#include <libelf.h>
+#include "../util/genelf.h"
+#endif
+
+#define TEMPL "/tmp/perf-test-XXXXXX"
+
+int test__jit_write_elf(struct test *test __maybe_unused,
+			int subtest __maybe_unused)
+{
+#ifdef HAVE_JITDUMP
+	static unsigned char x86_code[] = {
+		0xBB, 0x2A, 0x00, 0x00, 0x00, /* movl $42, %ebx */
+		0xB8, 0x01, 0x00, 0x00, 0x00, /* movl $1, %eax */
+		0xCD, 0x80            /* int $0x80 */
+	};
+	char path[PATH_MAX];
+	int fd, ret;
+
+	strcpy(path, TEMPL);
+
+	fd = mkstemp(path);
+	if (fd < 0) {
+		perror("mkstemp failed");
+		return TEST_FAIL;
+	}
+
+	pr_info("Writing jit code to: %s\n", path);
+
+	ret = jit_write_elf(fd, 0, "main", x86_code, sizeof(x86_code),
+			NULL, 0, NULL, 0, 0);
+	close(fd);
+
+	unlink(path);
+
+	return ret ? TEST_FAIL : 0;
+#else
+	return TEST_SKIP;
+#endif
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 4f9ae6af78ec..9a160fef47c9 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -110,6 +110,7 @@ int test__unit_number__scnprint(struct test *test, int subtest);
 int test__mem2node(struct test *t, int subtest);
 int test__maps__merge_in(struct test *t, int subtest);
 int test__time_utils(struct test *t, int subtest);
+int test__jit_write_elf(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index f9f18b8b1df9..aed49806a09b 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -8,15 +8,12 @@
  */
 
 #include <sys/types.h>
-#include <stdio.h>
-#include <getopt.h>
 #include <stddef.h>
 #include <libelf.h>
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <inttypes.h>
-#include <limits.h>
 #include <fcntl.h>
 #include <err.h>
 #ifdef HAVE_DWARF_SUPPORT
@@ -31,8 +28,6 @@
 #define NT_GNU_BUILD_ID 3
 #endif
 
-#define JVMTI
-
 #define BUILD_ID_URANDOM /* different uuid for each run */
 
 #ifdef HAVE_LIBCRYPTO
@@ -511,44 +506,3 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
 
 	return retval;
 }
-
-#ifndef JVMTI
-
-static unsigned char x86_code[] = {
-    0xBB, 0x2A, 0x00, 0x00, 0x00, /* movl $42, %ebx */
-    0xB8, 0x01, 0x00, 0x00, 0x00, /* movl $1, %eax */
-    0xCD, 0x80            /* int $0x80 */
-};
-
-static struct options options;
-
-int main(int argc, char **argv)
-{
-	int c, fd, ret;
-
-	while ((c = getopt(argc, argv, "o:h")) != -1) {
-		switch (c) {
-		case 'o':
-			options.output = optarg;
-			break;
-		case 'h':
-			printf("Usage: genelf -o output_file [-h]\n");
-			return 0;
-		default:
-			errx(1, "unknown option");
-		}
-	}
-
-	fd = open(options.output, O_CREAT|O_TRUNC|O_RDWR, 0666);
-	if (fd == -1)
-		err(1, "cannot create file %s", options.output);
-
-	ret = jit_write_elf(fd, "main", x86_code, sizeof(x86_code));
-	close(fd);
-
-	if (ret != 0)
-		unlink(options.output);
-
-	return ret;
-}
-#endif
-- 
2.21.0
