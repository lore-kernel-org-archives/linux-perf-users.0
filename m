From: "Jin, Yao" <yao.jin@linux.intel.com>
Subject: Re: Feedback on: [RESEND PATCH v2 0/5] perf report: Show inline stack
Date: Mon, 9 Jan 2017 16:17:48 +0800
Message-ID: <6c7d4609-10c6-de26-3b60-d7bc5720e716@linux.intel.com>
References: <5135140.l86lTS2Zdn@agathebauer>
 <ded48f05-ab7f-d294-16aa-65d4ac8ee926@linux.intel.com>
 <1741616.SQg6AZICR4@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:20547 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751648AbdAIISL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2017 03:18:11 -0500
In-Reply-To: <1741616.SQg6AZICR4@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

Hi Wolff,

Thanks a lot for your test code!

I have updated my patch. The new output for your test code (binary name 
is inline) is:

# Overhead  Command  Shared Object        Symbol
# ........  .......  ................... ..................................
#
     56.76%  inline   inline               [.] main
             |
             ---main
                __libc_start_main
                _start

     40.54%  inline   libm-2.23.so         [.] __hypot_finite
             |
             ---__hypot_finite
                |
                 --40.09%--__hypot
                           main
                           __libc_start_main
                           _start

      1.30%  inline   libm-2.23.so         [.] __hypot
             |
             ---__hypot
                main
                |
                ---/usr/include/c++/5/bits/random.h:151 (inline)
                   /usr/include/c++/5/bits/random.h:332 (inline)
                   /usr/include/c++/5/bits/random.tcc:3328 (inline)
                   /usr/include/c++/5/bits/random.h:185 (inline)
                   /usr/include/c++/5/bits/random.h:1818 (inline)
                   /usr/include/c++/5/bits/random.h:1809 (inline)
/home/jinyao/skl-ws/perf-dev/lck-2867/test/inline.cpp:14 (inline)
                __libc_start_main
                _start

The inline entry is tagged with "(inline)". Is this result within 
expectation?

Thanks
Jin Yao

On 1/9/2017 4:02 PM, Milian Wolff wrote:
> On Monday, January 9, 2017 11:07:26 AM CET Jin, Yao wrote:
>> Hi Wolff,
>>
>> Thanks a lot for your feedback.
>>
>> Have you tested with the browser mode? I mean without the "--stdio" option.
> Yes, I have done that:
>
> ~~~~~~~~~~~~
> milian@milian-kdab2:/tmp$ g++ -O2 -g inline.cpp -o inline
> milian@milian-kdab2:/tmp$ perf record --call-graph dwarf ./inline
> 6.66016e+15
> [ perf record: Woken up 5 times to write data ]
> [ perf record: Captured and wrote 1.215 MB perf.data (149 samples) ]
> ~~~~~~~~~~~~
>
> Both with and without your patch (and passing --inline) I get:
>
> ~~~~~~~~~~~~
> milian@milian-kdab2:/tmp$ perf report --no-children --inline
> Samples: 149  of event 'cycles:ppp', Event count (approx.): 141334499
>    Overhead  Command  Shared Object     Symbol
> -   62.24%  inline   inline            [.] main
>       main
>       __libc_start_main
>       _start
> -   26.24%  inline   libm-2.24.so      [.] __hypot_finite
>     - __hypot_finite
>        - 25.56% hypot
>             main
>             __libc_start_main
>             _start
>          0.68% 0x40ead238ed1a2cf4
> -    6.85%  inline   libm-2.24.so      [.] hypot
>       hypot
>       main
>       __libc_start_main
>       _start
> ~~~~~~~~~~~~
>
>> Could you give your test binary then I can try to reproduce the issue? I
>> have tried with my tests but I could not reproduce.
> The following code should reproduce the issue:
>
> ~~~~~~~~~~~~
> #include <complex>
> #include <cmath>
> #include <random>
> #include <iostream>
>
> using namespace std;
>
> int main()
> {
>      uniform_real_distribution<double> uniform(-1E5, 1E5);
>      default_random_engine engine;
>      double s = 0;
>      for (int i = 0; i < 1000000; ++i) {
>          s += norm(complex<double>(uniform(engine), uniform(engine)));
>      }
>      cout << s << '\n';
>      return 0;
> }
> ~~~~~~~~~~~~
>
> Hope this helps
>
>> On 1/8/2017 4:13 AM, Milian Wolff wrote:
>>> Hey Jin,
>>>
>>> I have finally had the time to test your patch series. Sadly, I hit a
>>> fundamental issue with it early on in my testing:
>>>
>>> In my test case, I get with `perf report --no-children` e.g. the
> following:
>>>       42.50%  lab_mandelbrot   libm-2.24.so                [.]
>>>       __hypot_finite
>>>       
>>>               ---__hypot_finite
>>>               
>>>                  hypot
>>>                  main
>>>                  __libc_start_main
>>>                  _start
>>>
>>> Enabling --inline does not change the output, even though hypot is inlined
>>> into main.
>>>
>>> Looking at your code, it looks to me as if you are only trying to find
>>> inliners for root entries, cf. hist_entry__fprintf (stdio/hist.c), and
>>> only
>>> when unwinding failed (?, cf. (callchain_ret == 0)).
>>>
>>> Is this understanding correct, or should your patch also add inliners for
>>> nodes in the middle of the callstack?
>>>
>>> This approach makes the whole feature unusable for my use case. In my
>>> (really hacky) approach to adding inliners to the output of perf
>>> (https://github.com/
>>> milianw/linux/commit/71d031c9d679bfb4a4044226e8903dd80ea601b3) I decided
>>> to lookup inliners for _every_ callchain entry. The result then there is
>>> with my>
>>> branch and a `perf report -g srcline --stdio`:
>>>       42.50%  lab_mandelbrot   libm-2.24.so                [.]
>>>       __hypot_finite
>>>       
>>>               ---__hypot_finite +387
>>>               
>>>                  hypot +20
>>>                  std::__complex_abs complex:589
>>>                  std::abs<double> complex:597
>>>                  drawMandelbrot mandelbrot.h:39
>>>                  main main.cpp:55
>>>                  __libc_start_main +241
>>>                  _start +42
>>>
>>> Note the three inliner entries in the middle of the callstack. The way I
>>> did it, one will also see "proper" entries for inlined functions in a
>>> top-down `perf report --children` output.
>>>
>>> In general, your patch series looks much more polished than mine, so I
>>> would love to get it integrated. But with your approach, we will need
>>> lots of changes to the various browsers to get all features in. My hacky
>>> approach has the nice property that it simply adds "normal" callchain
>>> entries for inlined nodes - maybe you should do the same?
>>>
>>> Thanks a lot for your work, much appreciated.
>
