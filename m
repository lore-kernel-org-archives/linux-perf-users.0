From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v2 08/14] perf report: compare symbol name for inlined frames when sorting
Date: Sun,  6 Aug 2017 23:24:40 +0200
Message-ID: <20170806212446.24925-9-milian.wolff@kdab.com>
References: <20170806212446.24925-1-milian.wolff@kdab.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170806212446.24925-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-perf-users.vger.kernel.org

Similar to the callstack frame matching, we also have to compare
the symbol name when sorting hist entries. The reason is twofold:
On one hand, multiple inlined functions will use the same symbol
start/end values of the parent, non-inlined symbol. As such, all
of these symbols often end up missing from top-level report, as
they get merged with the non-inlined frame. On the other hand,
multiple different functions may end up inlining the same function,
and we need to aggregate these values properly.

Before:

~~~~~
perf report --stdio --inline -g none
# Children      Self  Command       Shared Object     Symbol
# ........  ........  ............  ................  ...................................
#
   100.00%    39.69%  cpp-inlining  cpp-inlining      [.] main
   100.00%     0.00%  cpp-inlining  cpp-inlining      [.] _start
   100.00%     0.00%  cpp-inlining  libc-2.25.so      [.] __libc_start_main
    97.03%     0.00%  cpp-inlining  cpp-inlining      [.] std::norm<double> (inlined)
    59.53%     4.26%  cpp-inlining  libm-2.25.so      [.] hypot
    55.21%    55.08%  cpp-inlining  libm-2.25.so      [.] __hypot_finite
     0.52%     0.52%  cpp-inlining  libm-2.25.so      [.] cabs
~~~~~

After:

~~~~~
perf report --stdio --inline -g none
# Children      Self  Command       Shared Object     Symbol
# ........  ........  ............  ................  ...................................................................................................................................
#
   100.00%    39.69%  cpp-inlining  cpp-inlining      [.] main
   100.00%     0.00%  cpp-inlining  cpp-inlining      [.] _start
   100.00%     0.00%  cpp-inlining  libc-2.25.so      [.] __libc_start_main
    62.57%     0.00%  cpp-inlining  cpp-inlining      [.] std::_Norm_helper<true>::_S_do_it<double> (inlined)
    62.57%     0.00%  cpp-inlining  cpp-inlining      [.] std::__complex_abs (inlined)
    62.57%     0.00%  cpp-inlining  cpp-inlining      [.] std::abs<double> (inlined)
    62.57%     0.00%  cpp-inlining  cpp-inlining      [.] std::norm<double> (inlined)
    59.53%     4.26%  cpp-inlining  libm-2.25.so      [.] hypot
    55.21%    55.08%  cpp-inlining  libm-2.25.so      [.] __hypot_finite
    34.46%     0.00%  cpp-inlining  cpp-inlining      [.] std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inlined)
    32.39%     0.00%  cpp-inlining  cpp-inlining      [.] std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator() (inlined)
    32.39%     0.00%  cpp-inlining  cpp-inlining      [.] std::generate_canonical<double, 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inlined)
    12.29%     0.00%  cpp-inlining  cpp-inlining      [.] std::__detail::_Mod<unsigned long, 2147483647ul, 16807ul, 0ul, true, true>::__calc (inlined)
    12.29%     0.00%  cpp-inlining  cpp-inlining      [.] std::__detail::__mod<unsigned long, 2147483647ul, 16807ul, 0ul> (inlined)
    12.29%     0.00%  cpp-inlining  cpp-inlining      [.] std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>::operator() (inlined)
     0.52%     0.52%  cpp-inlining  libm-2.25.so      [.] cabs
~~~~~

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/sort.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 66fa841717fb..73752998beef 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -225,6 +225,9 @@ static int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
 	if (sym_l == sym_r)
 		return 0;
 
+	if (sym_l->inlined || sym_r->inlined)
+		return strcmp(sym_l->name, sym_r->name);
+
 	if (sym_l->start != sym_r->start)
 		return (int64_t)(sym_r->start - sym_l->start);
 
-- 
2.13.3
