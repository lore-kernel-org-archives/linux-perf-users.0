From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/75] perf report: Documentation average IPC and IPC coverage
Date: Thu,  6 Dec 2018 18:25:13 -0300
Message-ID: <20181206212602.20474-27-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Add explanations for new columns "IPC" and "IPC coverage" in perf
documentation.

 v5:
 ---
 Update the description according to Ingo's comments.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1543586097-27632-5-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 474a4941f65d..ed2bf37ab132 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -126,6 +126,14 @@ OPTIONS
 	And default sort keys are changed to comm, dso_from, symbol_from, dso_to
 	and symbol_to, see '--branch-stack'.
 
+	When the sort key symbol is specified, columns "IPC" and "IPC Coverage"
+	are enabled automatically. Column "IPC" reports the average IPC per function
+	and column "IPC coverage" reports the percentage of instructions with
+	sampled IPC in this function. IPC means Instruction Per Cycle. If it's low,
+	it indicates there may be a performance bottleneck when the function is
+	executed, such as a memory access bottleneck. If a function has high overhead
+	and low IPC, it's worth further analyzing it to optimize its performance.
+
 	If the --mem-mode option is used, the following sort keys are also available
 	(incompatible with --branch-stack):
 	symbol_daddr, dso_daddr, locked, tlb, mem, snoop, dcacheline.
-- 
2.19.2
