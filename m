From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH v4 12/15] perf tools: Add some new tips describing the new options
Date: Tue,  5 Mar 2019 06:47:55 -0800
Message-ID: <20190305144758.12397-13-andi@firstfloor.org>
References: <20190305144758.12397-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190305144758.12397-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---
v2:
Even more tips.
---
 tools/perf/Documentation/tips.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index 849599f39c5e..3cb9a59c58ba 100644
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
@@ -34,3 +35,8 @@ Show current config key-value pairs: perf config --list
 Show user configuration overrides: perf config --user --list
 To add Node.js USDT(User-Level Statically Defined Tracing): perf buildid-cache --add `which node`
 To report cacheline events from previous recording: perf c2c report
+To browse sample contexts use perf report --sample 10 and select in context menu
+To separate samples by time use perf report --sort time,overhead,sym
+To set sample time separation other than 100ms with --sort time use --time-quantum
+Add -I to perf report to sample register values visible in perf report context.
+To show IPC for sampling periods use perf record -e '{cycles,instructions}:S' and then browse context
-- 
2.20.1
