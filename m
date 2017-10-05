From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/1] perf callchain: Compare dsos (as well) for CCKEY_FUNCTION
Date: Thu,  5 Oct 2017 14:59:13 -0300
Message-ID: <20171005175913.16513-2-acme@kernel.org>
References: <20171005175913.16513-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171005175913.16513-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Krister Johansen <kjlx@templeofstupid.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Yao Jin <yao.jin@linux.intel.com>, zhangmengting@huawei.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Two functions from different binaries can have same start address. Thus,
comparing only start address in match_chain() leads to inconsistent
callchains. Fix this by adding a check for dsos as well.

Ex, https://www.spinics.net/lists/linux-perf-users/msg04067.html

Reported-by: Alexander Pozdneev <pozdneyev@gmail.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yao Jin <yao.jin@linux.intel.com>
Cc: zhangmengting@huawei.com
Link: http://lkml.kernel.org/r/20171005091234.5874-1-ravi.bangoria@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index be09d77cade0..a971caf3759d 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -685,6 +685,8 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 {
 	struct symbol *sym = node->sym;
 	u64 left, right;
+	struct dso *left_dso = NULL;
+	struct dso *right_dso = NULL;
 
 	if (callchain_param.key == CCKEY_SRCLINE) {
 		enum match_result match = match_chain_srcline(node, cnode);
@@ -696,12 +698,14 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 	if (cnode->ms.sym && sym && callchain_param.key == CCKEY_FUNCTION) {
 		left = cnode->ms.sym->start;
 		right = sym->start;
+		left_dso = cnode->ms.map->dso;
+		right_dso = node->map->dso;
 	} else {
 		left = cnode->ip;
 		right = node->ip;
 	}
 
-	if (left == right) {
+	if (left == right && left_dso == right_dso) {
 		if (node->branch) {
 			cnode->branch_count++;
 
-- 
2.13.6
