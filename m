From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH] perf report: distinguish between inliners in the same function
Date: Thu, 27 Apr 2017 23:59:50 +0200
Message-ID: <20170427215950.6649-1-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:56174 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034173AbdD0WAE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 Apr 2017 18:00:04 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Linux-kernel@vger.kernel.org
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
//--> slide
    uniform_real_distribution<double> uniform(-1E5, 1E5);
    default_random_engine engine;
    double s = 0;
    for (int i = 0; i < 10000000; ++i) {
        s += uniform(engine);
    }
//<-- slide
    cout << "random sum: " << s << '\n';
    return 0;
}
~~~~~

Building it with `g++ -O2 -g` and recording some samples with
`perf record --call-graph dwarf` yields for me:

~~~~~
$ perf report --stdio --inline --no-children
Failed to open [ext4], continuing without symbols
# To display the perf.data header info, please use --header/--header-only
options.
#
#
# Total Lost Samples: 0
#
# Samples: 499  of event 'cycles'
# Event count (approx.): 329354953
#
# Overhead  Command    Shared Object      Symbol
# ........  .........  .................  ................................
#
    96.70%  ex_random  ex_random          [.] main
|
            ---main
               __libc_start_main
               _start
...
~~~~~

Note how no inlined frames are actually shown, because the first
sample in main points to an IP that does not correspond to any
inlined frames.

With this patch applied, we instead get the following, much more
meaningful, report:

~~~~~
# Overhead  Command    Shared Object      Symbol
# ........  .........  .................  ................................
#
    96.70%  ex_random  ex_random          [.] main
            |
            |--47.19%--main
            |          std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator() (inline)
            |          std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inline)
            |          std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inline)
            |          main (inline)
            |          __libc_start_main
            |          _start
            |
            |--32.61%--main
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
            |--15.07%--main
            |          __libc_start_main
            |          _start
            |
             --1.84%--main
                       std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inline)
                       main (inline)
                       __libc_start_main
                       _start
...
~~~~~

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/callchain.c | 71 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 81fc29ac798f..9984dbda3e61 100644
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
 
@@ -636,19 +630,66 @@ static enum match_result match_chain_srcline(struct callchain_cursor_node *node,
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
 
+static const char *first_inlined_funcname(struct inline_node *node)
+{
+	struct inline_list *entry = NULL;
+
+	if (node)
+		entry = list_first_entry(&node->val, struct inline_list, list);
+	return entry ? entry->funcname : NULL;
+}
+
+static enum match_result match_chain_inliner(struct callchain_cursor_node *node,
+					     struct callchain_list *cnode)
+{
+	u64 left_ip = map__rip_2objdump(cnode->ms.map, cnode->ip);
+	u64 right_ip = map__rip_2objdump(node->map, node->ip);
+	struct inline_node *left_node = NULL;
+	struct inline_node *right_node = NULL;
+	const char *left_func = NULL;
+	const char *right_func = NULL;
+	enum match_result ret = MATCH_EQ;
+
+	left_node = dso__parse_addr_inlines(cnode->ms.map->dso, left_ip);
+	left_func = first_inlined_funcname(left_node);
+
+	right_node = dso__parse_addr_inlines(node->map->dso, right_ip);
+	right_func = first_inlined_funcname(right_node);
+
+	ret = match_chain_strings(left_func, right_func);
+
+	if (left_node)
+		inline_node__delete(left_node);
+	if (right_node)
+		inline_node__delete(right_node);
+	return ret;
+}
+
 static enum match_result match_chain(struct callchain_cursor_node *node,
 				     struct callchain_list *cnode)
 {
@@ -671,7 +712,13 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
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
