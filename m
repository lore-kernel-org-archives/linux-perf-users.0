From: Tan Xiaojun <tanxiaojun@huawei.com>
Subject: [RFC PATCH 3/3] perf report: add --spe options for arm-spe
Date: Fri, 2 Aug 2019 17:40:13 +0800
Message-ID: <1564738813-10944-4-git-send-email-tanxiaojun@huawei.com>
References: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, adrian.hunter@intel.com, yao.jin@linux.intel.com, tmricht@linux.ibm.com, brueckner@linux.ibm.com, songliubraving@fb.com, gregkh@linuxfoundation.org, kim.phillips@arm.com
Cc: gengdongjiu@huawei.com, wxf.wang@hisilicon.com, liwei391@huawei.com, tanxiaojun@huawei.com, huawei.libin@huawei.com, linux-kernel@vger.kernel.org, jeremy.linton@arm.com, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

The previous patch added support in "perf report" for some arm-spe
events(llc-miss, tlb-miss, branch-miss). This patch adds their help
instructions.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 tools/perf/Documentation/perf-report.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 987261d..d998d4b 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -445,6 +445,15 @@ include::itrace.txt[]
 
 	To disable decoding entirely, use --no-itrace.
 
+--spe::
+	Options for decoding arm-spe tracing data. The options are:
+
+		l	synthesize llc miss events
+		t	synthesize tlb miss events
+		b	synthesize branch miss events
+
+	The default is all events i.e. the same as --spe=ltb
+
 --full-source-path::
 	Show the full path for source files for srcline output.
 
-- 
2.7.4
