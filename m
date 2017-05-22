From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 0/7] generate full callchain cursor entries for inlined
 frames
Date: Mon, 22 May 2017 21:09:22 +0900
Message-ID: <20170522120922.GB20009@sejong>
References: <20170518193411.22380-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:56543 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753008AbdEVMJ0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2017 08:09:26 -0400
Content-Disposition: inline
In-Reply-To: <20170518193411.22380-1-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kernel-team@lge.com

On Thu, May 18, 2017 at 09:34:04PM +0200, Milian Wolff wrote:
> This series of patches completely reworks the way inline frames are handled.
> Instead of querying for the inline nodes on-demand in the individual tools,
> we now create proper callchain nodes for inlined frames. The advantages this
> approach brings are numerous:
> 
> - less duplicated code in the individual browser
> - aggregated cost for inlined frames for the --children top-down list
> - various bug fixes that arose from querying for a srcline/symbol based on
>   the IP of a sample, which will always point to the last inlined frame
>   instead of the corresponding non-inlined frame
> - overall much better support for visualizing cost for heavily-inlined C++
>   code, which simply was confusing and unreliably before
> - srcline honors the global setting as to whether full paths or basenames
>   should be shown
> 
> For comparison, below lists the output before and after for `perf script`
> and `perf report`. The example file I used to generate the perf data is:
> 
> ~~~~~
> $ cat inlining.cpp
> #include <complex>
> #include <cmath>
> #include <random>
> #include <iostream>
> 
> using namespace std;
> 
> int main()
> {
>     uniform_real_distribution<double> uniform(-1E5, 1E5);
>     default_random_engine engine;
>     double s = 0;
>     for (int i = 0; i < 10000000; ++i) {
>         s += norm(complex<double>(uniform(engine), uniform(engine)));
>     }
>     cout << s << '\n';
>     return 0;
> }
> $ g++ -O2 -g -o inlining inlining.cpp
> $ perf record --call-graph dwarf ./inlining
> ~~~~~
> 
> Now, the (broken) status-quo looks like this. Look for "NOTE:" to see some
> of my comments that outline the various issues I'm trying to solve by this
> patch series.
> 
> ~~~~~
> $ perf script --inline
> ...
> inlining 11083 97459.356656:      33680 cycles:
>                    214f7 __hypot_finite (/usr/lib/libm-2.25.so)
>                     ace3 hypot (/usr/lib/libm-2.25.so)
>                      a4a main (/home/milian/projects/src/perf-tests/inlining)
>                          std::__complex_abs
>                          std::abs<double>
>                          std::_Norm_helper<true>::_S_do_it<double>
>                          std::norm<double>
>                          main
>                    20510 __libc_start_main (/usr/lib/libc-2.25.so)
>                      bd9 _start (/home/milian/projects/src/perf-tests/inlining)
> # NOTE: the above inlined stack is confusing: the a4a is an address into main,
> #       which is the non-inlined symbol. the entry with the address should be
> #       at the end of the stack, where it's actually duplicated once more but
> #       there it's missing the address

Omitting address was to distinguish inlined entries from others.  I
didn't think it's a problem by itself (missed inter-operability below),
but duplicated entries should be removed.

> ...
> $ perf report -s sym -g srcline -i perf.inlining.data --inline --stdio
> ...
>              --38.86%--_start
>                        __libc_start_main
>                        |
>                        |--15.68%--main random.tcc:3326
>                        |          /home/milian/projects/src/perf-tests/inlining.cpp:14 (inline)
>                        |          /usr/include/c++/6.3.1/bits/random.h:1809 (inline)
>                        |          /usr/include/c++/6.3.1/bits/random.h:1818 (inline)
>                        |          /usr/include/c++/6.3.1/bits/random.h:185 (inline)
>                        |          /usr/include/c++/6.3.1/bits/random.tcc:3326 (inline)
>                        |
>                        |--10.36%--main random.h:143
>                        |          /home/milian/projects/src/perf-tests/inlining.cpp:14 (inline)
>                        |          /usr/include/c++/6.3.1/bits/random.h:1809 (inline)
>                        |          /usr/include/c++/6.3.1/bits/random.h:1818 (inline)
>                        |          /usr/include/c++/6.3.1/bits/random.h:185 (inline)
>                        |          /usr/include/c++/6.3.1/bits/random.tcc:3332 (inline)
>                        |          /usr/include/c++/6.3.1/bits/random.h:332 (inline)
>                        |          /usr/include/c++/6.3.1/bits/random.h:151 (inline)
>                        |          /usr/include/c++/6.3.1/bits/random.h:143 (inline)
>                        |
>                        |--5.66%--main random.tcc:3332
>                        |          /home/milian/projects/src/perf-tests/inlining.cpp:14 (inline)
>                        |          /usr/include/c++/6.3.1/bits/random.h:1809 (inline)
>                        |          /usr/include/c++/6.3.1/bits/random.h:1818 (inline)
>                        |          /usr/include/c++/6.3.1/bits/random.h:185 (inline)
>                        |          /usr/include/c++/6.3.1/bits/random.tcc:3332 (inline)
> ...
> # NOTE: the grouping is totally off because the first and last frame of the
>         inline nodes is completely bogus, since the IP is used to find the sym/srcline
>         which is different from the actual inlined sym/srcline.
>         also, the code currently displays either the inlined function name or
>         the corresponding filename (but in full length, instead of just the basename).

Yes, inlined nodes should have correct IP for later use.


> 
> $ perf report -s sym -g srcline -i perf.inlining.data --inline --stdio --no-children
> ...
>     38.86%  [.] main
>             |
>             |--15.68%--main random.tcc:3326
>             |          /usr/include/c++/6.3.1/bits/random.tcc:3326 (inline)
>             |          /usr/include/c++/6.3.1/bits/random.h:185 (inline)
>             |          /usr/include/c++/6.3.1/bits/random.h:1818 (inline)
>             |          /usr/include/c++/6.3.1/bits/random.h:1809 (inline)
>             |          /home/milian/projects/src/perf-tests/inlining.cpp:14 (inline)
>             |          __libc_start_main
>             |          _start
> ...
> # NOTE: the srcline for main is wrong, it should be inlining.cpp:14,
>         i.e. what is displayed in the line below (see also perf script issue above)

OK.


> ~~~~~
> 
> Afterwards, all of the above issues are resolved:
> 
> ~~~~~
> $ perf script --inline
> ...
> inlining 11083 97459.356656:      33680 cycles:
>                    214f7 __hypot_finite (/usr/lib/libm-2.25.so)
>                     ace3 hypot (/usr/lib/libm-2.25.so)
>                      a4a std::__complex_abs (inlined)
>                      a4a std::abs<double> (inlined)
>                      a4a std::_Norm_helper<true>::_S_do_it<double> (inlined)
>                      a4a std::norm<double> (inlined)
>                      a4a main (/home/milian/projects/src/perf-tests/inlining)
>                    20510 __libc_start_main (/usr/lib/libc-2.25.so)
>                      bd9 _start (/home/milian/projects/src/perf-tests/inlining)
> ...
> # NOTE: only one main entry, at the correct position.
>         we do display the (repeated) instruction pointer as that ensures
>         interoperability with e.g. the stackcollapse-perf.pl script

Looks good.


> 
> $ perf report -s sym -g srcline -i perf.inlining.data --inline --stdio
> ...
>    100.00%    38.86%  [.] main
>             |
>             |--61.14%--main inlining.cpp:14
>             |          std::norm<double> complex:664 (inlined)
>             |          std::_Norm_helper<true>::_S_do_it<double> complex:654 (inlined)
>             |          std::abs<double> complex:597 (inlined)
>             |          std::__complex_abs complex:589 (inlined)
>             |          |
>             |          |--60.29%--hypot
>             |          |          |
>             |          |           --56.03%--__hypot_finite
>             |          |
>             |           --0.85%--cabs
>             |
>              --38.86%--_start
>                        __libc_start_main
>                        |
>                        |--38.19%--main inlining.cpp:14
>                        |          |
>                        |          |--35.59%--std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > random.h:1809 (inlined)
>                        |          |          std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > random.h:1818 (inlined)
>                        |          |          |
>                        |          |           --34.37%--std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator() random.h:185 (inlined)
>                        |          |                     |
>                        |          |                     |--17.91%--std::generate_canonical<double, 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > random.tcc:3332 (inlined)
>                        |          |                     |          |
>                        |          |                     |           --12.24%--std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>::operator() random.h:332 (inlined)
>                        |          |                     |                     std::__detail::__mod<unsigned long, 2147483647ul, 16807ul, 0ul> random.h:151 (inlined)
>                        |          |                     |                     |
>                        |          |                     |                     |--10.36%--std::__detail::_Mod<unsigned long, 2147483647ul, 16807ul, 0ul, true, true>::__calc random.h:143 (inlined)
>                        |          |                     |                     |
>                        |          |                     |                      --1.88%--std::__detail::_Mod<unsigned long, 2147483647ul, 16807ul, 0ul, true, true>::__calc random.h:141 (inlined)
>                        |          |                     |
>                        |          |                     |--15.68%--std::generate_canonical<double, 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > random.tcc:3326 (inlined)
>                        |          |                     |
>                        |          |                      --0.79%--std::generate_canonical<double, 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > random.tcc:3335 (inlined)
>                        |          |
>                        |           --1.99%--std::norm<double> complex:664 (inlined)
>                        |                     std::_Norm_helper<true>::_S_do_it<double> complex:654 (inlined)
>                        |                     std::abs<double> complex:597 (inlined)
>                        |                     std::__complex_abs complex:589 (inlined)
>                        |
>                         --0.67%--main inlining.cpp:13
> ...
> 
> # NOTE: still somewhat confusing due to the _start and __libc_start_main frames
>         that actually are *above* the main frame. But at least the stuff below
>         properly splits up and shows that mutiple functions got inlined into
>         inlining.cpp:14, not just one as before.

Right.  Current callchain mode has the problem.  It shows a mix of
callchains of a sample and children of the sample.  I proposed a patch
[1] to handle it but I failed to find time to update it as Jiri
suggested.

[1] https://lkml.org/lkml/2014/8/14/49


> 
> $ perf report -s sym -g srcline -i perf.inlining.data --inline --stdio --no-children
> ...
>     38.86%  [.] main
>             |
>             |--15.68%--std::generate_canonical<double, 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > random.tcc:3326 (inlined)
>             |          std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator() random.h:185 (inlined)
>             |          std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > random.h:1818 (inlined)
>             |          std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > random.h:1809 (inlined)
>             |          main inlining.cpp:14
>             |          __libc_start_main
>             |          _start
> ...
> # NOTE: the first and last entry of the inline stack have the correct symbol and srcline now
>         both function and srcline is shown, as well as the (inlined) suffix
>         only the basename of the srcline is shown

Nice work!

But I found some problems in both of your patch and current code
during testing (mostly for the children mode).  I'll send a fix soon.

Thanks,
Namhyung


> ~~~~~
> 
> Milian Wolff (7):
>   perf report: remove code to handle inline frames from browsers
>   perf util: take elf_name as const string in dso__demangle_sym
>   perf report: create real callchain entries for inlined frames
>   perf report: use srcline from inlined frames
>   perf report: fall-back to function name comparison for -g srcline
>   perf report: mark inlined frames in output by " (inlined)" suffix
>   perf script: mark inlined frames and do not print DSO for them
> 
>  tools/perf/ui/browsers/hists.c   | 183 +++------------------------------------
>  tools/perf/ui/stdio/hist.c       |  80 +----------------
>  tools/perf/util/callchain.c      |  52 +++++------
>  tools/perf/util/callchain.h      |   5 +-
>  tools/perf/util/dso.c            |   2 +
>  tools/perf/util/dso.h            |   1 +
>  tools/perf/util/evsel_fprintf.c  |  37 +-------
>  tools/perf/util/hist.c           |   5 --
>  tools/perf/util/machine.c        |  54 +++++++++++-
>  tools/perf/util/sort.h           |   1 -
>  tools/perf/util/srcline.c        | 183 ++++++++++++++++++++++++++++++---------
>  tools/perf/util/srcline.h        |  19 +++-
>  tools/perf/util/symbol-elf.c     |   2 +-
>  tools/perf/util/symbol-minimal.c |   2 +-
>  tools/perf/util/symbol.h         |   3 +-
>  15 files changed, 264 insertions(+), 365 deletions(-)
> 
> -- 
> 2.13.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
