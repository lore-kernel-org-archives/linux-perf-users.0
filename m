From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/22] perf diff: Use llabs() with 64-bit values
Date: Thu, 28 Nov 2019 10:40:22 -0300
Message-ID: <20191128134027.23726-18-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Jin Yao <yao.jin@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To fix this build error on a debian mipsel cross build environment:

  builtin-diff.c: In function 'compute_cycles_diff':
  builtin-diff.c:649:10: error: absolute value function 'labs' given an argument of type 's64' {aka 'long long int'} but has parameter of type 'long int' which may cause truncation of value [-Werror=absolute-value]
    649 |    val = labs(pair->block_info->cycles_spark[i] -
        |          ^~~~

Fixes: cebf7d51a6c3 ("perf diff: Report noisy for cycles diff")
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pn7szy5uw384ntjgk6zckh6a@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index eae879376283..f8b6ae557d8b 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -646,7 +646,7 @@ static void compute_cycles_diff(struct hist_entry *he,
 			if (i >= he->block_info->num || i >= NUM_SPARKS)
 				break;
 
-			val = labs(pair->block_info->cycles_spark[i] -
+			val = llabs(pair->block_info->cycles_spark[i] -
 				     he->block_info->cycles_spark[i]);
 
 			update_spark_value(pair->diff.svals, NUM_SPARKS,
-- 
2.21.0
