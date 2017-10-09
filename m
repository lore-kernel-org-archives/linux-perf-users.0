From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v5 00/16] generate full callchain cursor entries for inlined frames
Date: Mon,  9 Oct 2017 22:32:54 +0200
Message-ID: <20171009203310.17362-1-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:48330 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754098AbdJIUdV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Oct 2017 16:33:21 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>

This series of patches completely reworks the way inline frames are handled.
Instead of querying for the inline nodes on-demand in the individual tools,
we now create proper callchain nodes for inlined frames. The advantages this
approach brings are numerous:

- less duplicated code in the individual browser
- aggregated cost for inlined frames for the --children top-down list
- various bug fixes that arose from querying for a srcline/symbol based on
  the IP of a sample, which will always point to the last inlined frame
  instead of the corresponding non-inlined frame
- overall much better support for visualizing cost for heavily-inlined C++
  code, which simply was confusing and unreliably before
- srcline honors the global setting as to whether full paths or basenames
  should be shown
- caches for inlined frames and srcline information, which allow us to
  enable inline frame handling by default

For comparison, below lists the output before and after for `perf script`
and `perf report`. The example file I used to generate the perf data is:

~~~~~
$ cat inlining.cpp
#include <complex>
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
        s += norm(complex<double>(uniform(engine), uniform(engine)));
    }
    cout << s << '\n';
    return 0;
}
$ g++ -O2 -g -o inlining inlining.cpp
$ perf record --call-graph dwarf ./inlining
~~~~~

Now, the (broken) status-quo looks like this. Look for "NOTE:" to see some
of my comments that outline the various issues I'm trying to solve by this
patch series.

~~~~~
$ perf script --inline
...
inlining 11083 97459.356656:      33680 cycles:
                   214f7 __hypot_finite (/usr/lib/libm-2.25.so)
                    ace3 hypot (/usr/lib/libm-2.25.so)
                     a4a main (/home/milian/projects/src/perf-tests/inlining)
                         std::__complex_abs
                         std::abs<double>
                         std::_Norm_helper<true>::_S_do_it<double>
                         std::norm<double>
                         main
                   20510 __libc_start_main (/usr/lib/libc-2.25.so)
                     bd9 _start (/home/milian/projects/src/perf-tests/inlining)
# NOTE: the above inlined stack is confusing: the a4a is an address into main,
#       which is the non-inlined symbol. the entry with the address should be
#       at the end of the stack, where it's actually duplicated once more but
#       there it's missing the address
...
$ perf report -s sym -g srcline -i perf.inlining.data --inline --stdio
...
             --38.86%--_start
                       __libc_start_main
                       |
                       |--15.68%--main random.tcc:3326
                       |          /home/milian/projects/src/perf-tests/inlining.cpp:14 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:1809 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:1818 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:185 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.tcc:3326 (inline)
                       |
                       |--10.36%--main random.h:143
                       |          /home/milian/projects/src/perf-tests/inlining.cpp:14 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:1809 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:1818 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:185 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.tcc:3332 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:332 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:151 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:143 (inline)
                       |
                       |--5.66%--main random.tcc:3332
                       |          /home/milian/projects/src/perf-tests/inlining.cpp:14 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:1809 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:1818 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.h:185 (inline)
                       |          /usr/include/c++/6.3.1/bits/random.tcc:3332 (inline)
...
# NOTE: the grouping is totally off because the first and last frame of the
        inline nodes is completely bogus, since the IP is used to find the sym/srcline
        which is different from the actual inlined sym/srcline.
        also, the code currently displays either the inlined function name or
        the corresponding filename (but in full length, instead of just the basename).

$ perf report -s sym -g srcline -i perf.inlining.data --inline --stdio --no-children
...
    38.86%  [.] main
            |
            |--15.68%--main random.tcc:3326
            |          /usr/include/c++/6.3.1/bits/random.tcc:3326 (inline)
            |          /usr/include/c++/6.3.1/bits/random.h:185 (inline)
            |          /usr/include/c++/6.3.1/bits/random.h:1818 (inline)
            |          /usr/include/c++/6.3.1/bits/random.h:1809 (inline)
            |          /home/milian/projects/src/perf-tests/inlining.cpp:14 (inline)
            |          __libc_start_main
            |          _start
...
# NOTE: the srcline for main is wrong, it should be inlining.cpp:14,
        i.e. what is displayed in the line below (see also perf script issue above)
~~~~~

Afterwards, all of the above issues are resolved (and inlined frames are
displayed by default):

~~~~~
$ perf script
...
inlining 11083 97459.356656:      33680 cycles:
                   214f7 __hypot_finite (/usr/lib/libm-2.25.so)
                    ace3 hypot (/usr/lib/libm-2.25.so)
                     a4a std::__complex_abs (inlined)
                     a4a std::abs<double> (inlined)
                     a4a std::_Norm_helper<true>::_S_do_it<double> (inlined)
                     a4a std::norm<double> (inlined)
                     a4a main (/home/milian/projects/src/perf-tests/inlining)
                   20510 __libc_start_main (/usr/lib/libc-2.25.so)
                     bd9 _start (/home/milian/projects/src/perf-tests/inlining)
...
# NOTE: only one main entry, at the correct position.
        we do display the (repeated) instruction pointer as that ensures
        interoperability with e.g. the stackcollapse-perf.pl script

$ perf report -s sym -g srcline -i perf.inlining.data --stdio
...
   100.00%    38.86%  [.] main
            |
            |--61.14%--main inlining.cpp:14
            |          std::norm<double> complex:664 (inlined)
            |          std::_Norm_helper<true>::_S_do_it<double> complex:654 (inlined)
            |          std::abs<double> complex:597 (inlined)
            |          std::__complex_abs complex:589 (inlined)
            |          |
            |          |--60.29%--hypot
            |          |          |
            |          |           --56.03%--__hypot_finite
            |          |
            |           --0.85%--cabs
            |
             --38.86%--_start
                       __libc_start_main
                       |
                       |--38.19%--main inlining.cpp:14
                       |          |
                       |          |--35.59%--std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > random.h:1809 (inlined)
                       |          |          std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > random.h:1818 (inlined)
                       |          |          |
                       |          |           --34.37%--std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator() random.h:185 (inlined)
                       |          |                     |
                       |          |                     |--17.91%--std::generate_canonical<double, 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > random.tcc:3332 (inlined)
                       |          |                     |          |
                       |          |                     |           --12.24%--std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>::operator() random.h:332 (inlined)
                       |          |                     |                     std::__detail::__mod<unsigned long, 2147483647ul, 16807ul, 0ul> random.h:151 (inlined)
                       |          |                     |                     |
                       |          |                     |                     |--10.36%--std::__detail::_Mod<unsigned long, 2147483647ul, 16807ul, 0ul, true, true>::__calc random.h:143 (inlined)
                       |          |                     |                     |
                       |          |                     |                      --1.88%--std::__detail::_Mod<unsigned long, 2147483647ul, 16807ul, 0ul, true, true>::__calc random.h:141 (inlined)
                       |          |                     |
                       |          |                     |--15.68%--std::generate_canonical<double, 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > random.tcc:3326 (inlined)
                       |          |                     |
                       |          |                      --0.79%--std::generate_canonical<double, 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > random.tcc:3335 (inlined)
                       |          |
                       |           --1.99%--std::norm<double> complex:664 (inlined)
                       |                     std::_Norm_helper<true>::_S_do_it<double> complex:654 (inlined)
                       |                     std::abs<double> complex:597 (inlined)
                       |                     std::__complex_abs complex:589 (inlined)
                       |
                        --0.67%--main inlining.cpp:13
...

# NOTE: still somewhat confusing due to the _start and __libc_start_main frames
        that actually are *above* the main frame. But at least the stuff below
        properly splits up and shows that mutiple functions got inlined into
        inlining.cpp:14, not just one as before.

$ perf report -s sym -g srcline -i perf.inlining.data --stdio --no-children
...
    38.86%  [.] main
            |
            |--15.68%--std::generate_canonical<double, 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > random.tcc:3326 (inlined)
            |          std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator() random.h:185 (inlined)
            |          std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > random.h:1818 (inlined)
            |          std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > random.h:1809 (inlined)
            |          main inlining.cpp:14
            |          __libc_start_main
            |          _start
...
# NOTE: the first and last entry of the inline stack have the correct symbol and srcline now
        both function and srcline is shown, as well as the (inlined) suffix
        only the basename of the srcline is shown

v5 attends to Namhyung's code review. Most notably, it fixes a use-after-free
   crash. Additionally, srcline resolution for hist entries now also works
   correctly, when inline frame resolution is disabled.

v4 splits the patch to create full callchain nodes for inline frames up further
   as suggested by Jiri. It also removes C99 comments and initializes the
   rb_root properly.

v3 splits the initial patch up into two to simplify reviewing. It also adds a
   comment to clarify the lifetime handling of fake symbols and aliased non-fake
   symbols, based on the feedback by Namhyung.

v2 fixes some issues reported by Namhyung or found by me in further
testing, adds caching and enables inline frames by default.

Milian Wolff (16):
  perf report: remove code to handle inline frames from browsers
  perf util: store srcline in callchain_cursor_node
  perf util: refactor inline_list to operate on symbols
  perf util: refactor inline_list to store srcline string directly
  perf report: create real callchain entries for inlined frames
  perf report: fall-back to function name comparison for -g srcline
  perf report: mark inlined frames in output by " (inlined)" suffix
  perf script: mark inlined frames and do not print DSO for them
  perf report: compare symbol name for inlined frames when matching
  perf report: compare symbol name for inlined frames when sorting
  perf report: properly handle branch count in match_chain
  perf report: cache failed lookups of inlined frames
  perf report: cache srclines for callchain nodes
  perf report: use srcline from callchain for hist entries
  perf util: enable handling of inlined frames by default
  perf util: use correct IP mapping to find srcline for hist entry

 tools/perf/Documentation/perf-report.txt |   3 +-
 tools/perf/Documentation/perf-script.txt |   3 +-
 tools/perf/ui/browsers/hists.c           | 180 ++-------------------
 tools/perf/ui/stdio/hist.c               |  77 +--------
 tools/perf/util/callchain.c              | 152 +++++++++---------
 tools/perf/util/callchain.h              |   6 +-
 tools/perf/util/dso.c                    |   7 +
 tools/perf/util/dso.h                    |   2 +
 tools/perf/util/event.c                  |   1 +
 tools/perf/util/evsel_fprintf.c          |  37 +----
 tools/perf/util/hist.c                   |   7 +-
 tools/perf/util/machine.c                |  65 +++++++-
 tools/perf/util/sort.c                   |   8 +-
 tools/perf/util/sort.h                   |   1 -
 tools/perf/util/srcline.c                | 268 +++++++++++++++++++++++++------
 tools/perf/util/srcline.h                |  26 ++-
 tools/perf/util/symbol.c                 |   1 +
 tools/perf/util/symbol.h                 |   2 +
 18 files changed, 426 insertions(+), 420 deletions(-)

-- 
2.14.2
