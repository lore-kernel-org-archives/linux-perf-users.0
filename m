From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v4 06/15] perf report: fall-back to function name comparison for -g srcline
Date: Sun,  1 Oct 2017 16:30:51 +0200
Message-ID: <20171001143100.19988-7-milian.wolff@kdab.com>
References: <20171001143100.19988-1-milian.wolff@kdab.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171001143100.19988-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-perf-users.vger.kernel.org

When a callchain entry has no srcline available, we ended up
comparing the instruction pointer. I consider this to be not
too useful. Rather, I think we should group the entries by
function name, which this patch adds. For people who want to
split the data on the IP boundary, using `-g address` is the
correct choice.

Before:

~~~~~
   100.00%    38.86%  [.] main
            |
            |--61.14%--main inlining.cpp:14
            |          std::norm<double> complex:664
            |          std::_Norm_helper<true>::_S_do_it<double> complex:654
            |          std::abs<double> complex:597
            |          std::__complex_abs complex:589
            |          |
            |          |--56.03%--hypot
            |          |          |
            |          |          |--8.45%--__hypot_finite
            |          |          |
            |          |          |--7.62%--__hypot_finite
            |          |          |
            |          |          |--2.29%--__hypot_finite
            |          |          |
            |          |          |--2.24%--__hypot_finite
            |          |          |
            |          |          |--2.06%--__hypot_finite
            |          |          |
            |          |          |--1.81%--__hypot_finite
...
~~~~~

After:

~~~~~
   100.00%    38.86%  [.] main
            |
            |--61.14%--main inlining.cpp:14
            |          std::norm<double> complex:664
            |          std::_Norm_helper<true>::_S_do_it<double> complex:654
            |          std::abs<double> complex:597
            |          std::__complex_abs complex:589
            |          |
            |          |--60.29%--hypot
            |          |          |
            |          |           --56.03%--__hypot_finite
            |          |
            |           --0.85%--cabs
~~~~~

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/callchain.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index d1c5d1d422cb..b335fc805472 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -638,11 +638,9 @@ enum match_result {
 	MATCH_GT,
 };
 
-static enum match_result match_chain_srcline(struct callchain_cursor_node *node,
-					     struct callchain_list *cnode)
+static enum match_result match_chain_strings(const char *left,
+					     const char *right)
 {
-	const char *left = cnode->srcline;
-	const char *right = node->srcline;
 	enum match_result ret = MATCH_EQ;
 	int cmp;
 
@@ -652,10 +650,8 @@ static enum match_result match_chain_srcline(struct callchain_cursor_node *node,
 		cmp = 1;
 	else if (left && !right)
 		cmp = -1;
-	else if (cnode->ip == node->ip)
-		cmp = 0;
 	else
-		cmp = (cnode->ip < node->ip) ? -1 : 1;
+		return MATCH_ERROR;
 
 	if (cmp != 0)
 		ret = cmp < 0 ? MATCH_LT : MATCH_GT;
@@ -670,10 +666,18 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 	u64 left, right;
 
 	if (callchain_param.key == CCKEY_SRCLINE) {
-		enum match_result match = match_chain_srcline(node, cnode);
+		enum match_result match = match_chain_strings(cnode->srcline,
+							      node->srcline);
+
+		/* if no srcline is available, fallback to symbol name */
+		if (match == MATCH_ERROR && cnode->ms.sym && node->sym)
+			match = match_chain_strings(cnode->ms.sym->name,
+						    node->sym->name);
 
 		if (match != MATCH_ERROR)
 			return match;
+
+		/* otherwise fall-back to IP-based comparison below */
 	}
 
 	if (cnode->ms.sym && sym && callchain_param.key == CCKEY_FUNCTION) {
-- 
2.14.2
