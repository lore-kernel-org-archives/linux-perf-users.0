From: Tan Xiaojun <tanxiaojun@huawei.com>
Subject: [RFC v3 3/5] perf report: Add --spe options for arm-spe
Date: Sat, 23 Nov 2019 18:11:16 +0800
Message-ID: <20191123101118.12635-4-tanxiaojun@huawei.com>
References: <20191123101118.12635-1-tanxiaojun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191123101118.12635-1-tanxiaojun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, adrian.hunter@intel.com, yao.jin@linux.intel.com, tmricht@linux.ibm.com, brueckner@linux.ibm.com, songliubraving@fb.com, gregkh@linuxfoundation.org, kim.phillips@arm.com, James.Clark@arm.com, jeremy.linton@arm.com
Cc: gengdongjiu@huawei.com, wxf.wang@hisilicon.com, liwei391@huawei.com, tanxiaojun@huawei.com, huawei.libin@huawei.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

The previous patch added support in "perf report" for some arm-spe
events(llc-miss, tlb-miss, branch-miss, remote_access). This patch adds their help
instructions.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 tools/perf/Documentation/perf-report.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 7315f155803f..188a9477558b 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -462,6 +462,16 @@ include::itrace.txt[]
 
 	To disable decoding entirely, use --no-itrace.
 
+--spe::
+	Options for decoding arm-spe tracing data. The options are:
+
+		l	synthesize llc miss events
+		t	synthesize tlb miss events
+		b	synthesize branch miss events
+		r	synthesize remote access events
+
+	The default is all events i.e. the same as --spe=ltbr
+
 --full-source-path::
 	Show the full path for source files for srcline output.
 
-- 
2.17.1
