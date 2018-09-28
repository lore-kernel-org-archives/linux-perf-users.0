From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf test: S390 does not support watchpoints in test 22
Date: Fri, 28 Sep 2018 09:43:17 +0200
Message-ID: <20180928074317.42893-1-tmricht@linux.ibm.com>
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
22: Watchpoint                                :
22.1: Read Only Watchpoint                    : Skip
22.2: Write Only Watchpoint                   : Skip
22.3: Read / Write Watchpoint                 : Skip
22.4: Modify Watchpoint                       : Skip
[root@s8360046 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/tests/builtin-test.c | 2 +-
 tools/perf/tests/wp.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 54ca7d87236f..e83c15a95c43 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -124,7 +124,7 @@ static struct test generic_tests[] = {
 		.desc = "Watchpoint",
 		.func = test__wp,
 		.subtest = {
-			.skip_if_fail	= false,
+			.skip_if_fail	= true,
 			.get_nr		= test__wp_subtest_get_nr,
 			.get_desc	= test__wp_subtest_get_desc,
 		},
diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index 017a99317f94..85c66f978732 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -162,7 +162,7 @@ static int wp_modify_test(void)
 
 static bool wp_ro_supported(void)
 {
-#if defined (__x86_64__) || defined (__i386__)
+#if defined(__x86_64__) || defined(__i386__) || defined(__s390x__)
 	return false;
 #else
 	return true;
@@ -171,7 +171,7 @@ static bool wp_ro_supported(void)
 
 static void wp_ro_skip_msg(void)
 {
-#if defined (__x86_64__) || defined (__i386__)
+#if defined(__x86_64__) || defined (__i386__) || defined(__s390x__)
 	pr_debug("Hardware does not support read only watchpoints.\n");
 #endif
 }
-- 
2.17.0
