From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/15] perf callchain: Compare symbol name for inlined frames when matching
Date: Wed, 25 Oct 2017 13:00:07 -0300
Message-ID: <20171025160013.11136-10-acme@kernel.org>
References: <20171025160013.11136-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171025160013.11136-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Yao Jin <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

The fake symbols we create for inlined frames will represent different
functions but can use the symbol start address. This leads to issues
when different inline branches all lead to the same function.

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

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Yao Jin <yao.jin@linux.intel.com>
Link: http://lkml.kernel.org/r/20171009203310.17362-10-milian.wolff@kdab.com
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
[ Fix up conflict with c1fbc0cf81f1 ("perf callchain: Compare dsos (as well) for CCKEY_FUNCTION"), remove unneeded hunk ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 77031efdca5c..35a920f09503 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -690,6 +690,14 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 	}
 
 	if (cnode->ms.sym && sym && callchain_param.key == CCKEY_FUNCTION) {
+		/*
+		 * Compare inlined frames based on their symbol name because
+		 * different inlined frames will have the same symbol start
+		 */
+		if (cnode->ms.sym->inlined || node->sym->inlined)
+			return match_chain_strings(cnode->ms.sym->name,
+						   node->sym->name);
+
 		left = cnode->ms.sym->start;
 		right = sym->start;
 		left_dso = cnode->ms.map->dso;
-- 
2.13.6
