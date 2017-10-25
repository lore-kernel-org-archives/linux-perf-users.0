From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/15] perf report: Compare symbol name for inlined frames when sorting
Date: Wed, 25 Oct 2017 13:00:08 -0300
Message-ID: <20171025160013.11136-11-acme@kernel.org>
References: <20171025160013.11136-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171025160013.11136-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Yao Jin <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

Similar to the callstack frame matching, we also have to compare the
symbol name when sorting hist entries. The reason is twofold: On one
hand, multiple inlined functions will use the same symbol start/end
values of the parent, non-inlined symbol.

As such, all of these symbols often end up missing from top-level
report, as they get merged with the non-inlined frame. On the other
hand, multiple different functions may end up inlining the same
function, and we need to aggregate these values properly.

Before:

~~~~~
  perf report --stdio --inline -g none
  # Children     Self  Command       Shared Object Symbol
  # ........ ........  ............  ............. ...................................
  #
     100.00%   39.69%  cpp-inlining  cpp-inlining  [.] main
     100.00%    0.00%  cpp-inlining  cpp-inlining  [.] _start
     100.00%    0.00%  cpp-inlining  libc-2.25.so  [.] __libc_start_main
      97.03%    0.00%  cpp-inlining  cpp-inlining  [.] std::norm<double> (inlined)
      59.53%    4.26%  cpp-inlining  libm-2.25.so  [.] hypot
      55.21%   55.08%  cpp-inlining  libm-2.25.so  [.] __hypot_finite
       0.52%    0.52%  cpp-inlining  libm-2.25.so  [.] cabs
~~~~~

After:

~~~~~
  perf report --stdio --inline -g none
  # Children     Self  Command       Shared Object Symbol
  # ........ ........  ............  ............. ...................................................................................................................................
  #
     100.00%   39.69%  cpp-inlining  cpp-inlining  [.] main
     100.00%    0.00%  cpp-inlining  cpp-inlining  [.] _start
     100.00%    0.00%  cpp-inlining  libc-2.25.so  [.] __libc_start_main
      62.57%    0.00%  cpp-inlining  cpp-inlining  [.] std::_Norm_helper<true>::_S_do_it<double> (inlined)
      62.57%    0.00%  cpp-inlining  cpp-inlining  [.] std::__complex_abs (inlined)
      62.57%    0.00%  cpp-inlining  cpp-inlining  [.] std::abs<double> (inlined)
      62.57%    0.00%  cpp-inlining  cpp-inlining  [.] std::norm<double> (inlined)
      59.53%    4.26%  cpp-inlining  libm-2.25.so  [.] hypot
      55.21%   55.08%  cpp-inlining  libm-2.25.so  [.] __hypot_finite
      34.46%    0.00%  cpp-inlining  cpp-inlining  [.] std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inlined)
      32.39%    0.00%  cpp-inlining  cpp-inlining  [.] std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator() (inlined)
      32.39%    0.00%  cpp-inlining  cpp-inlining  [.] std::generate_canonical<double, 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inlined)
      12.29%    0.00%  cpp-inlining  cpp-inlining  [.] std::__detail::_Mod<unsigned long, 2147483647ul, 16807ul, 0ul, true, true>::__calc (inlined)
      12.29%    0.00%  cpp-inlining  cpp-inlining  [.] std::__detail::__mod<unsigned long, 2147483647ul, 16807ul, 0ul> (inlined)
      12.29%    0.00%  cpp-inlining  cpp-inlining  [.] std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>::operator() (inlined)
       0.52%    0.52%  cpp-inlining  libm-2.25.so  [.] cabs
~~~~~

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yao Jin <yao.jin@linux.intel.com>
Link: http://lkml.kernel.org/r/20171009203310.17362-11-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index acb9210fd18a..006d10a0dc96 100644
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
2.13.6
