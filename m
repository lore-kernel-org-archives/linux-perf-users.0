From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v3 09/13] perf report: properly handle branch count in match_chain
Date: Wed,  6 Sep 2017 15:54:57 +0200
Message-ID: <20170906135501.306-10-milian.wolff@kdab.com>
References: <20170906135501.306-1-milian.wolff@kdab.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170906135501.306-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
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
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/callchain.c | 115 +++++++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 56 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 5c8aaa2c0123..9c355f02934f 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -659,77 +659,80 @@ static enum match_result match_chain_strings(const char *left,
 	return ret;
 }
 
+static enum match_result match_address(u64 left, u64 right)
+{
+	if (left == right)
+		return MATCH_EQ;
+	else if (left < right)
+		return MATCH_LT;
+	else
+		return MATCH_GT;
+}
+
 static enum match_result match_chain(struct callchain_cursor_node *node,
 				     struct callchain_list *cnode)
 {
-	struct symbol *sym = node->sym;
-	enum match_result match;
-	u64 left, right;
+	enum match_result match = MATCH_ERROR;
 
-	if (callchain_param.key == CCKEY_SRCLINE) {
+	switch (callchain_param.key) {
+	case CCKEY_SRCLINE:
 		match = match_chain_strings(cnode->srcline, node->srcline);
-
-		// if no srcline is available, fallback to symbol name
-		if (match == MATCH_ERROR && cnode->ms.sym && node->sym)
-			match = match_chain_strings(cnode->ms.sym->name,
-						    node->sym->name);
-
 		if (match != MATCH_ERROR)
-			return match;
-
-		// otherwise fall-back to IP-based comparison below
-	}
-
-	if (cnode->ms.sym && sym && callchain_param.key == CCKEY_FUNCTION) {
-		// compare inlined frames based on their symbol name because
-		// different inlined frames will have the same symbol start
-		if (cnode->ms.sym->inlined || node->sym->inlined)
-			return match_chain_strings(cnode->ms.sym->name,
-						   node->sym->name);
-
-		left = cnode->ms.sym->start;
-		right = sym->start;
-	} else {
-		left = cnode->ip;
-		right = node->ip;
+			break;
+		// else fall-through
+	case CCKEY_FUNCTION:
+		if (node->sym && cnode->ms.sym) {
+			// compare inlined frames based on their symbol name
+			// because different inlined frames will have the same
+			// symbol start. otherwise do a faster comparison based
+			// on the symbol start address
+			if (cnode->ms.sym->inlined || node->sym->inlined)
+				match = match_chain_strings(cnode->ms.sym->name,
+							    node->sym->name);
+			else
+				match = match_address(cnode->ms.sym->start,
+						      node->sym->start);
+			if (match != MATCH_ERROR)
+				break;
+		}
+		// else fall-through
+	case CCKEY_ADDRESS:
+	default:
+		match = match_address(cnode->ip, node->ip);
+		break;
 	}
 
-	if (left == right) {
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
2.14.1
