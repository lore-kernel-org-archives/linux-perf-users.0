From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/91] perf tests expr: Added test for runtime param in metric expression
Date: Wed,  6 May 2020 12:21:22 -0300
Message-ID: <20200506152234.21977-20-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kajol Jain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jin Yao <yao.jin@linux.intel.com>, Joe Mario <jmario@redhat.com>, Kan Liang <kan.liang@linux.intel.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Michael Petlan <mpetlan@red>
List-Id: linux-perf-users.vger.kernel.org

From: Kajol Jain <kjain@linux.ibm.com>

Added test case for parsing  "?" in metric expression.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lore.kernel.org/lkml/20200401203340.31402-6-kjain@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/expr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 516504cf0ea5..f9e8e5628836 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -59,6 +59,14 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	TEST_ASSERT_VAL("find other", !strcmp(other[2], "BOZO"));
 	TEST_ASSERT_VAL("find other", other[3] == NULL);
 
+	TEST_ASSERT_VAL("find other",
+			expr__find_other("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@", NULL,
+				   &other, &num_other, 3) == 0);
+	TEST_ASSERT_VAL("find other", num_other == 2);
+	TEST_ASSERT_VAL("find other", !strcmp(other[0], "EVENT1,param=3/"));
+	TEST_ASSERT_VAL("find other", !strcmp(other[1], "EVENT2,param=3/"));
+	TEST_ASSERT_VAL("find other", other[2] == NULL);
+
 	for (i = 0; i < num_other; i++)
 		zfree(&other[i]);
 	free((void *)other);
-- 
2.21.1
