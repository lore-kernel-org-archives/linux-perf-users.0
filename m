From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v3 07/13] perf report: compare symbol name for inlined frames when matching
Date: Wed,  6 Sep 2017 15:54:55 +0200
Message-ID: <20170906135501.306-8-milian.wolff@kdab.com>
References: <20170906135501.306-1-milian.wolff@kdab.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170906135501.306-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-perf-users.vger.kernel.org

The fake symbols we create for inlined frames will represent
different functions but can use the symbol start address. This leads
to issues when different inline branches all lead to the same
function.

Before:
~~~~~
$ perf report -s sym -i perf.inlining.data --inline --stdio -g function
...
             --38.86%--_start
                       __libc_start_main
                       main
                       |
                        --37.57%--std::norm<double> (inlined)
                                  std::_Norm_helper<true>::_S_do_it<double> (inlined)
                                  |
                                   --36.36%--std::abs<double> (inlined)
                                             std::__complex_abs (inlined)
                                             |
                                              --12.24%--std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>::operator() (inlined)
                                                        std::__detail::__mod<unsigned long, 2147483647ul, 16807ul, 0ul> (inlined)
                                                        std::__detail::_Mod<unsigned long, 2147483647ul, 16807ul, 0ul, true, true>::__calc (inlined)
~~~~~

Note that this backtrace representation is completely bogus.
Complex abs does not call the linear congruential engine! It
is just a side-effect of a longer inlined stack being appended
to a shorter, different inlined stack, both of which originate
in the same function (main).

This patch fixes the issue:

~~~~~
$ perf report -s sym -i perf.inlining.data --inline --stdio -g function
...
             --38.86%--_start
                       __libc_start_main
                       main
                       |
                       |--35.59%--std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inlined)
                       |          std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inlined)
                       |          |
                       |           --34.37%--std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator() (inlined)
                       |                     std::generate_canonical<double, 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inlined)
                       |                     |
                       |                      --12.24%--std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>::operator() (inlined)
                       |                                std::__detail::__mod<unsigned long, 2147483647ul, 16807ul, 0ul> (inlined)
                       |                                std::__detail::_Mod<unsigned long, 2147483647ul, 16807ul, 0ul, true, true>::__calc (inlined)
                       |
                        --1.99%--std::norm<double> (inlined)
                                  std::_Norm_helper<true>::_S_do_it<double> (inlined)
                                  std::abs<double> (inlined)
                                  std::__complex_abs (inlined)
~~~~~

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/callchain.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 18362b23a976..5c8aaa2c0123 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -663,11 +663,11 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 				     struct callchain_list *cnode)
 {
 	struct symbol *sym = node->sym;
+	enum match_result match;
 	u64 left, right;
 
 	if (callchain_param.key == CCKEY_SRCLINE) {
-		enum match_result match = match_chain_strings(cnode->srcline,
-							      node->srcline);
+		match = match_chain_strings(cnode->srcline, node->srcline);
 
 		// if no srcline is available, fallback to symbol name
 		if (match == MATCH_ERROR && cnode->ms.sym && node->sym)
@@ -681,6 +681,12 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 	}
 
 	if (cnode->ms.sym && sym && callchain_param.key == CCKEY_FUNCTION) {
+		// compare inlined frames based on their symbol name because
+		// different inlined frames will have the same symbol start
+		if (cnode->ms.sym->inlined || node->sym->inlined)
+			return match_chain_strings(cnode->ms.sym->name,
+						   node->sym->name);
+
 		left = cnode->ms.sym->start;
 		right = sym->start;
 	} else {
-- 
2.14.1
