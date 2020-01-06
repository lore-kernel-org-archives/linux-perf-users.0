From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/20] perf tests bp_signal: Show expected versus obtained values
Date: Mon,  6 Jan 2020 13:06:50 -0300
Message-ID: <20200106160705.10899-6-acme@kernel.org>
References: <20200106160705.10899-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To help understand failures.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c951j3gvrgnrsyg7ki7pwkiz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bp_signal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 415903b48578..da8ec1e8e064 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -263,20 +263,20 @@ int test__bp_signal(struct test *test __maybe_unused, int subtest __maybe_unused
 		if (count1 == 11)
 			pr_debug("failed: RF EFLAG recursion issue detected\n");
 		else
-			pr_debug("failed: wrong count for bp1%lld\n", count1);
+			pr_debug("failed: wrong count for bp1: %lld, expected 1\n", count1);
 	}
 
 	if (overflows != 3)
-		pr_debug("failed: wrong overflow hit\n");
+		pr_debug("failed: wrong overflow (%d) hit, expected 3\n", overflows);
 
 	if (overflows_2 != 3)
-		pr_debug("failed: wrong overflow_2 hit\n");
+		pr_debug("failed: wrong overflow_2 (%d) hit, expected 3\n", overflows_2);
 
 	if (count2 != 3)
-		pr_debug("failed: wrong count for bp2\n");
+		pr_debug("failed: wrong count for bp2 (%lld), expected 3\n", count2);
 
 	if (count3 != 2)
-		pr_debug("failed: wrong count for bp3\n");
+		pr_debug("failed: wrong count for bp3 (%lld), expected 2\n", count3);
 
 	return count1 == 1 && overflows == 3 && count2 == 3 && overflows_2 == 3 && count3 == 2 ?
 		TEST_OK : TEST_FAIL;
-- 
2.21.1
