From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Omit test 68 for s390.
Date: Wed,  4 Nov 2020 09:29:54 +0100
Message-ID: <20201104082954.57338-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Commit ed21d6d7c48e6e ("perf tests: Add test for PE binary format support")
adds a WINDOWS EXE file named tests/pe-file.exe, which is
examined by the test case 'PE file support'.

This test reads the buildid from the file tests/pe-file.exe,
which is a Portable Executable (PE) binary file used by the
Windows operating system.

Since s390 does not support PE files, omit this test.

Output before:
[root@t35lp46 perf]# ./perf test -F 68
68: PE file support                               : Failed!
[root@t35lp46 perf]#

Output after:
[root@t35lp46 perf]# ./perf test -F 68
68: PE file support                               : Skip
[root@t35lp46 perf]#


Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/pe-file-parsing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index 58b90c42eb38..4e45178c50f6 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -18,7 +18,7 @@
 
 #include "tests.h"
 
-#ifdef HAVE_LIBBFD_SUPPORT
+#if defined(HAVE_LIBBFD_SUPPORT) && !defined(__s390x__)
 
 static int run_dir(const char *d)
 {
-- 
2.26.2
