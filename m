From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v3] perf test: S390 does not support watchpoints in test 22
Date: Fri, 28 Sep 2018 12:53:35 +0200
Message-ID: <20180928105335.67179-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

S390 does not support the perf_event_open system call for
attribute type PERF_TYPE_BREAKPOINT. This results in test
failure for test 22:

[root@s8360046 perf]# ./perf test 22
22: Watchpoint                                :
22.1: Read Only Watchpoint                    : FAILED!
22.2: Write Only Watchpoint                   : FAILED!
22.3: Read / Write Watchpoint                 : FAILED!
22.4: Modify Watchpoint                       : FAILED!
[root@s8360046 perf]#

Add s390 support to avoid these tests being executed on
s390 platform:

[root@s8360046 perf]# ./perf test 22
[root@s8360046 perf]# ./perf test -v 22
22: Watchpoint                                : Disabled
[root@s8360046 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/builtin-test.c |  1 +
 tools/perf/tests/tests.h        |  1 +
 tools/perf/tests/wp.c           | 12 ++++++++++++
 3 files changed, 14 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 54ca7d87236f..12c09e0ece71 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -123,6 +123,7 @@ static struct test generic_tests[] = {
 	{
 		.desc = "Watchpoint",
 		.func = test__wp,
+		.is_supported = test__wp_is_supported,
 		.subtest = {
 			.skip_if_fail	= false,
 			.get_nr		= test__wp_subtest_get_nr,
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 8e26a4148f30..b82f55fcc294 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -109,6 +109,7 @@ int test__unit_number__scnprint(struct test *test, int subtest);
 int test__mem2node(struct test *t, int subtest);
 
 bool test__bp_signal_is_supported(void);
+bool test__wp_is_supported(void);
 
 #if defined(__arm__) || defined(__aarch64__)
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index 017a99317f94..f89e6806557b 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -227,3 +227,15 @@ int test__wp(struct test *test __maybe_unused, int i)
 
 	return !wp_testcase_table[i].target_func() ? TEST_OK : TEST_FAIL;
 }
+
+/* The s390 so far does not have support for
+ * instruction breakpoint using the perf_event_open() system call.
+ */
+bool test__wp_is_supported(void)
+{
+#if defined(__s390x__)
+	return false;
+#else
+	return true;
+#endif
+}
-- 
2.17.0
