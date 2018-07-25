From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/27] perf tools: Synthesize GROUP_DESC feature in pipe mode
Date: Wed, 25 Jul 2018 14:59:54 -0300
Message-ID: <20180725180001.15108-21-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, David Carrillo-Cisneros <davidcc@google.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Stephan reported, that pipe mode does not carry the group information
and thus the piped report won't display the grouped output for following
command:

  # perf record -e '{cycles,instructions,branches}' -a sleep 4 | perf report

It has no idea about the group setup, so it will display events
separately:

  # Overhead  Command          Shared Object             ...
  # ........  ...............  .......................
  #
       6.71%  swapper          [kernel.kallsyms]
       2.28%  offlineimap      libpython2.7.so.1.0
       0.78%  perf             [kernel.kallsyms]
  ...

Fix GROUP_DESC feature record to be synthesized in pipe mode, so the
report output is grouped if there are groups defined in record:

  #                 Overhead  Command          Shared    ...
  # ........................  ...............  .......
  #
       7.57%   0.16%   0.30%  swapper          [kernel
       1.87%   3.15%   2.46%  offlineimap      libpyth
       1.33%   0.00%   0.00%  perf             [kernel
  ...

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180712135202.14774-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 653ff65aa2c3..5af58aac91ad 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2587,7 +2587,7 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(NUMA_TOPOLOGY,	numa_topology,	true),
 	FEAT_OPN(BRANCH_STACK,	branch_stack,	false),
 	FEAT_OPR(PMU_MAPPINGS,	pmu_mappings,	false),
-	FEAT_OPN(GROUP_DESC,	group_desc,	false),
+	FEAT_OPR(GROUP_DESC,	group_desc,	false),
 	FEAT_OPN(AUXTRACE,	auxtrace,	false),
 	FEAT_OPN(STAT,		stat,		false),
 	FEAT_OPN(CACHE,		cache,		true),
-- 
2.14.4
