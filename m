From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v7 1/5] perf report: properly handle branch count in match_chain
Date: Thu, 19 Oct 2017 13:38:32 +0200
Message-ID: <20171019113836.5548-2-milian.wolff@kdab.com>
References: <20171019113836.5548-1-milian.wolff@kdab.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171019113836.5548-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Some of the code paths I introduced before returned too early
without running the code to handle a node's branch count.
By refactoring match_chain to only have one exit point, this
can be remedied.

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/callchain.c | 132 +++++++++++++++++++++++---------------------
 1 file changed, 70 insertions(+), 62 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 35a920f09503..8901a95f2880 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -666,83 +666,91 @@ static enum match_result match_chain_strings(const char *left,
 	return ret;
 }
 
-static enum match_result match_chain(struct callchain_cursor_node *node,
-				     struct callchain_list *cnode)
+static enum match_result match_address_dso(struct map *left_map, u64 left_ip,
+					   struct map *right_map, u64 right_ip)
 {
-	struct symbol *sym = node->sym;
-	u64 left, right;
-	struct dso *left_dso = NULL;
-	struct dso *right_dso = NULL;
+	struct dso *left_dso = left_map ? left_map->dso : NULL;
+	struct dso *right_dso = right_map ? right_map->dso : NULL;
 
-	if (callchain_param.key == CCKEY_SRCLINE) {
-		enum match_result match = match_chain_strings(cnode->srcline,
-							      node->srcline);
+	if (left_dso == right_dso && left_ip == right_ip)
+		return MATCH_EQ;
+	else if (left_ip < right_ip)
+		return MATCH_LT;
+	else
+		return MATCH_GT;
+}
 
-		/* if no srcline is available, fallback to symbol name */
-		if (match == MATCH_ERROR && cnode->ms.sym && node->sym)
-			match = match_chain_strings(cnode->ms.sym->name,
-						    node->sym->name);
+static enum match_result match_chain(struct callchain_cursor_node *node,
+				     struct callchain_list *cnode)
+{
+	enum match_result match = MATCH_ERROR;
 
+	switch (callchain_param.key) {
+	case CCKEY_SRCLINE:
+		match = match_chain_strings(cnode->srcline, node->srcline);
 		if (match != MATCH_ERROR)
-			return match;
-
+			break;
+		/* otherwise fall-back to symbol-based comparison below */
+		__fallthrough;
+	case CCKEY_FUNCTION:
+		if (node->sym && cnode->ms.sym) {
+			/*
+			 * Compare inlined frames based on their symbol name
+			 * because different inlined frames will have the same
+			 * symbol start. Otherwise do a faster comparison based
+			 * on the symbol start address.
+			 */
+			if (cnode->ms.sym->inlined || node->sym->inlined)
+				match = match_chain_strings(cnode->ms.sym->name,
+							    node->sym->name);
+			else
+				match = match_address_dso(cnode->ms.map,
+							  cnode->ms.sym->start,
+							  node->map,
+							  node->sym->start);
+			if (match != MATCH_ERROR)
+				break;
+		}
 		/* otherwise fall-back to IP-based comparison below */
+		__fallthrough;
+	case CCKEY_ADDRESS:
+	default:
+		match = match_address_dso(cnode->ms.map, cnode->ip,
+					  node->map, node->ip);
+		break;
 	}
 
-	if (cnode->ms.sym && sym && callchain_param.key == CCKEY_FUNCTION) {
-		/*
-		 * Compare inlined frames based on their symbol name because
-		 * different inlined frames will have the same symbol start
-		 */
-		if (cnode->ms.sym->inlined || node->sym->inlined)
-			return match_chain_strings(cnode->ms.sym->name,
-						   node->sym->name);
-
-		left = cnode->ms.sym->start;
-		right = sym->start;
-		left_dso = cnode->ms.map->dso;
-		right_dso = node->map->dso;
-	} else {
-		left = cnode->ip;
-		right = node->ip;
-	}
-
-	if (left == right && left_dso == right_dso) {
-		if (node->branch) {
-			cnode->branch_count++;
+	if (match == MATCH_EQ && node->branch) {
+		cnode->branch_count++;
 
-			if (node->branch_from) {
-				/*
-				 * It's "to" of a branch
-				 */
-				cnode->brtype_stat.branch_to = true;
+		if (node->branch_from) {
+			/*
+			 * It's "to" of a branch
+			 */
+			cnode->brtype_stat.branch_to = true;
 
-				if (node->branch_flags.predicted)
-					cnode->predicted_count++;
+			if (node->branch_flags.predicted)
+				cnode->predicted_count++;
 
-				if (node->branch_flags.abort)
-					cnode->abort_count++;
+			if (node->branch_flags.abort)
+				cnode->abort_count++;
 
-				branch_type_count(&cnode->brtype_stat,
-						  &node->branch_flags,
-						  node->branch_from,
-						  node->ip);
-			} else {
-				/*
-				 * It's "from" of a branch
-				 */
-				cnode->brtype_stat.branch_to = false;
-				cnode->cycles_count +=
-					node->branch_flags.cycles;
-				cnode->iter_count += node->nr_loop_iter;
-				cnode->iter_cycles += node->iter_cycles;
-			}
+			branch_type_count(&cnode->brtype_stat,
+					  &node->branch_flags,
+					  node->branch_from,
+					  node->ip);
+		} else {
+			/*
+			 * It's "from" of a branch
+			 */
+			cnode->brtype_stat.branch_to = false;
+			cnode->cycles_count += node->branch_flags.cycles;
+			cnode->iter_count += node->nr_loop_iter;
+			cnode->iter_cycles += node->iter_cycles;
 		}
-
-		return MATCH_EQ;
 	}
 
-	return left > right ? MATCH_GT : MATCH_LT;
+	return match;
 }
 
 /*
-- 
2.14.2
