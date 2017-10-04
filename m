From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [RFC] perf callchain: Compare dsos (as well) for CCKEY_FUNCTION
Date: Wed,  4 Oct 2017 11:43:08 +0530
Message-ID: <20171004061308.1246-1-ravi.bangoria@linux.vnet.ibm.com>
References: <CAE3E0fDuYbhSj_EESFh2OKzBUQS=oGKWm3+H7XJARi=m7CLxqQ@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE3E0fDuYbhSj_EESFh2OKzBUQS=oGKWm3+H7XJARi=m7CLxqQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: pozdneyev@gmail.com, acme@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kjlx@templeofstupid.com, milian.wolff@kdab.com, zhangmengting@huawei.com, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Two functions from different binaries can have same start
address. Thus, comparing only start address in match_chain()
leads to inconsistent callchains. Fix this by adding a check
for dsos as well.

Ex, https://www.spinics.net/lists/linux-perf-users/msg04067.html

Reported-by: Alexander Pozdneev <pozdneyev@gmail.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 tools/perf/util/callchain.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 510b513..6d5a483 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -678,6 +678,9 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 {
 	struct symbol *sym = node->sym;
 	u64 left, right;
+	struct dso *left_dso = NULL;
+	struct dso *right_dso = NULL;
+
 
 	if (callchain_param.key == CCKEY_SRCLINE) {
 		enum match_result match = match_chain_srcline(node, cnode);
@@ -689,12 +692,16 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 	if (cnode->ms.sym && sym && callchain_param.key == CCKEY_FUNCTION) {
 		left = cnode->ms.sym->start;
 		right = sym->start;
+		if (cnode->ms.map && node->map) {
+			left_dso = cnode->ms.map->dso;
+			right_dso = node->map->dso;
+		}
 	} else {
 		left = cnode->ip;
 		right = node->ip;
 	}
 
-	if (left == right) {
+	if (left == right && left_dso == right_dso) {
 		if (node->branch) {
 			cnode->branch_count++;
 
-- 
1.8.3.1
