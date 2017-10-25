From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/15] perf report: Fall-back to function name comparison for -g srcline
Date: Wed, 25 Oct 2017 13:00:04 -0300
Message-ID: <20171025160013.11136-7-acme@kernel.org>
References: <20171025160013.11136-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbdJYQAq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Oct 2017 12:00:46 -0400
In-Reply-To: <20171025160013.11136-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Yao Jin <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Milian Wolff <milian.wolff@kdab.com>

When a callchain entry has no srcline available, we ended up comparing
the instruction pointer. I consider this to be not too useful. Rather, I
think we should group the entries by function name, which this patch
adds. For people who want to split the data on the IP boundary, using
`-g address` is the correct choice.

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

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yao Jin <yao.jin@linux.intel.com>
Link: http://lkml.kernel.org/r/20171009203310.17362-7-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index e7ee794d1e5b..0f2ba493a7a3 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -645,11 +645,9 @@ enum match_result {
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
 
@@ -659,10 +657,8 @@ static enum match_result match_chain_srcline(struct callchain_cursor_node *node,
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
@@ -679,10 +675,18 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 	struct dso *right_dso = NULL;
 
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
2.13.6
