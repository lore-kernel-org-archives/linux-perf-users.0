From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/46] perf test: Use header file util/debug.h
Date: Tue,  5 Jun 2018 14:50:10 -0300
Message-ID: <20180605175030.32549-27-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Use the header file util/debug.h instead of declaration of verbose
variable.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180528134817.36643-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/python-use.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.c
index 5d2df65ada6a..40ab72149ce1 100644
--- a/tools/perf/tests/python-use.c
+++ b/tools/perf/tests/python-use.c
@@ -7,8 +7,7 @@
 #include <stdlib.h>
 #include <linux/compiler.h>
 #include "tests.h"
-
-extern int verbose;
+#include "util/debug.h"
 
 int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-- 
2.14.3
