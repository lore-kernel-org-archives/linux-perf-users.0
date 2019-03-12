From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/30] perf tools: Add some new tips describing the new options
Date: Mon, 11 Mar 2019 23:02:01 -0300
Message-ID: <20190312020204.22092-28-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190311144502.15423-9-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/tips.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index 849599f39c5e..869965d629ce 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -15,6 +15,7 @@ To see callchains in a more compact form: perf report -g folded
 Show individual samples with: perf script
 Limit to show entries above 5% only: perf report --percent-limit 5
 Profiling branch (mis)predictions with: perf record -b / perf report
+To show assembler sample contexts use perf record -b / perf script -F +brstackinsn --xed
 Treat branches as callchains: perf report --branch-history
 To count events in every 1000 msec: perf stat -I 1000
 Print event counts in CSV format with: perf stat -x,
@@ -34,3 +35,9 @@ Show current config key-value pairs: perf config --list
 Show user configuration overrides: perf config --user --list
 To add Node.js USDT(User-Level Statically Defined Tracing): perf buildid-cache --add `which node`
 To report cacheline events from previous recording: perf c2c report
+To browse sample contexts use perf report --sample 10 and select in context menu
+To separate samples by time use perf report --sort time,overhead,sym
+To set sample time separation other than 100ms with --sort time use --time-quantum
+Add -I to perf report to sample register values visible in perf report context.
+To show IPC for sampling periods use perf record -e '{cycles,instructions}:S' and then browse context
+To show context switches in perf report sample context add --switch-events to perf record.
-- 
2.20.1
