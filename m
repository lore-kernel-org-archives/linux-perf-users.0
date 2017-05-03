From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v2] perf report: distinguish between inliners in the same function
Date: Wed,  3 May 2017 23:35:36 +0200
Message-ID: <20170503213536.13905-1-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:38710 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750912AbdECVfs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 May 2017 17:35:48 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>

When different functions get inlined into the same function, we
want to show them individually in the reports. But when we group by
function, we would aggregate all IPs and would only keep the first
one in that function. E.g. for C++ code like the following:

~~~~~
#include <cmath>
#include <random>
#include <iostream>

using namespace std;

int main()
{
    uniform_real_distribution<double> uniform(-1E5, 1E5);
    default_random_engine engine;
    double s = 0;
    for (int i = 0; i < 10000000; ++i) {
        s += uniform(engine);
    }
    cout << "random sum: " << s << '\n';
    return 0;
}
~~~~~

Building it with `g++ -O2 -g` and recording some samples with
`perf record --call-graph dwarf` yields for me:

~~~~~
$ perf report --stdio --inline
# Overhead  Command    Shared Object      Symbol
# ........  .........  .................  ................................
#
    99.40%    99.11%  a.out    a.out                [.] main
            |
             --99.11%--_start
                       __libc_start_main
                       main
...
~~~~~

Note how no inlined frames are actually shown, because the first
sample in main points to an IP that does not correspond to any
inlined frames.

With this patch applied, we instead get the following, much more
meaningful, reports.

~~~~~
$ perf report --stdio --inline --no-children
# Overhead  Command    Shared Object      Symbol
# ........  .........  .................  ................................
#
    99.11%  a.out    a.out             [.] main
            |
            |--48.15%--main
            |          std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator() (inline)
            |          std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inline)
            |          std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inline)
            |          main (inline)
            |          __libc_start_main
            |          _start
            |
            |--47.61%--main
            |          std::__detail::__mod<unsigned long, 2147483647ul, 16807ul, 0ul> (inline)
            |          std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>::operator() (inline)
            |          std::generate_canonical<double, 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inline)
            |          std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator() (inline)
            |          std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inline)
            |          std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inline)
            |          main (inline)
            |          __libc_start_main
            |          _start
            |
             --3.35%--main
                       std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inline)
                       main (inline)
                       __libc_start_main
                       _start
...

$ perf report --stdio --inline
# Children      Self  Command  Shared Object        Symbol
# ........  ........  .......  ...................  ........................................................
#
    99.40%    99.11%  a.out    a.out                [.] main
            |
             --99.11%--_start
                       __libc_start_main
                       |
                       |--70.51%--main
                       |          main (inline)
                       |          std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inline)
                       |          std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inline)
                       |          std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator() (inline)
                       |
                       |--25.25%--main
                       |          main (inline)
                       |          std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inline)
                       |          std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inline)
                       |          std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator() (inline)
                       |          std::generate_canonical<double, 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inline)
                       |          std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>::operator() (inline)
                       |          std::__detail::__mod<unsigned long, 2147483647ul, 16807ul, 0ul> (inline)
                       |
                        --3.35%--main
                                  main (inline)
                                  std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inline)
~~~~~

Note that the latter top-down call graphs require us to traverse the
full inliner call chain when comparing for equality. Without it,
we would potentially combine the three distinct branches again, since
they share an equal first inline frame "main (inline)".

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
v2:
- compare the full stack of inlined frames to distinguish different branches
  in top-down call-stack views which start with the same inlined frame(s)

 tools/perf/util/callchain.c | 87 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 75 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 81fc29ac798f..9ab68682c6d0 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -618,15 +618,9 @@ enum match_result {
 	MATCH_GT,
 };
 
-static enum match_result match_chain_srcline(struct callchain_cursor_node *node,
-					     struct callchain_list *cnode)
+static enum match_result match_chain_strings(const char *left,
+					     const char *right)
 {
-	char *left = get_srcline(cnode->ms.map->dso,
-				 map__rip_2objdump(cnode->ms.map, cnode->ip),
-				 cnode->ms.sym, true, false);
-	char *right = get_srcline(node->map->dso,
-				  map__rip_2objdump(node->map, node->ip),
-				  node->sym, true, false);
 	enum match_result ret = MATCH_EQ;
 	int cmp;
 
@@ -636,19 +630,82 @@ static enum match_result match_chain_srcline(struct callchain_cursor_node *node,
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
 
+	return ret;
+}
+
+static enum match_result match_chain_srcline(struct callchain_cursor_node *node,
+					     struct callchain_list *cnode)
+{
+	char *left = get_srcline(cnode->ms.map->dso,
+				 map__rip_2objdump(cnode->ms.map, cnode->ip),
+				 cnode->ms.sym, true, false);
+	char *right = get_srcline(node->map->dso,
+				  map__rip_2objdump(node->map, node->ip),
+				  node->sym, true, false);
+	enum match_result ret = match_chain_strings(left, right);
+
 	free_srcline(left);
 	free_srcline(right);
 	return ret;
 }
 
+static enum match_result match_chain_inliner(struct callchain_cursor_node *node,
+					     struct callchain_list *cnode)
+{
+	u64 left_ip = map__rip_2objdump(cnode->ms.map, cnode->ip);
+	u64 right_ip = map__rip_2objdump(node->map, node->ip);
+	struct inline_node *left_node = NULL;
+	struct inline_node *right_node = NULL;
+	struct inline_list *left_entry = NULL;
+	struct inline_list *right_entry = NULL;
+	struct inline_list *left_last_entry = NULL;
+	struct inline_list *right_last_entry = NULL;
+	enum match_result ret = MATCH_EQ;
+
+	left_node = dso__parse_addr_inlines(cnode->ms.map->dso, left_ip);
+	if (!left_node)
+		return MATCH_ERROR;
+
+	right_node = dso__parse_addr_inlines(node->map->dso, right_ip);
+	if (!right_node) {
+		inline_node__delete(left_node);
+		return MATCH_ERROR;
+	}
+
+	left_entry = list_first_entry(&left_node->val,
+				      struct inline_list, list);
+	left_last_entry = list_last_entry(&left_node->val,
+					  struct inline_list, list);
+	right_entry = list_first_entry(&right_node->val,
+				       struct inline_list, list);
+	right_last_entry = list_last_entry(&right_node->val,
+					  struct inline_list, list);
+	while (ret == MATCH_EQ && (left_entry || right_entry)) {
+		ret = match_chain_strings(left_entry ? left_entry->funcname : NULL,
+					  right_entry ? right_entry->funcname : NULL);
+
+		if (left_entry && left_entry != left_last_entry)
+			left_entry = list_next_entry(left_entry, list);
+		else
+			left_entry = NULL;
+
+		if (right_entry && right_entry != right_last_entry)
+			right_entry = list_next_entry(right_entry, list);
+		else
+			right_entry = NULL;
+	}
+
+	inline_node__delete(left_node);
+	inline_node__delete(right_node);
+	return ret;
+}
+
 static enum match_result match_chain(struct callchain_cursor_node *node,
 				     struct callchain_list *cnode)
 {
@@ -671,7 +728,13 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 	}
 
 	if (left == right) {
-		if (node->branch) {
+		if (symbol_conf.inline_name && cnode->ip != node->ip) {
+			enum match_result match = match_chain_inliner(node,
+								      cnode);
+
+			if (match != MATCH_ERROR)
+				return match;
+		} else if (node->branch) {
 			cnode->branch_count++;
 
 			if (node->branch_flags.predicted)
-- 
2.12.2
