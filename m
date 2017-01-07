From: Milian Wolff <milian.wolff@kdab.com>
Subject: Feedback on: [RESEND PATCH v2 0/5] perf report: Show inline stack
Date: Sat, 07 Jan 2017 21:13:39 +0100
Message-ID: <5135140.l86lTS2Zdn@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:33226 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936901AbdAGUNm (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 7 Jan 2017 15:13:42 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

Hey Jin,

I have finally had the time to test your patch series. Sadly, I hit a 
fundamental issue with it early on in my testing:

In my test case, I get with `perf report --no-children` e.g. the following:

    42.50%  lab_mandelbrot   libm-2.24.so                [.] __hypot_finite
            |
            ---__hypot_finite
               hypot
               main
               __libc_start_main
               _start

Enabling --inline does not change the output, even though hypot is inlined 
into main.

Looking at your code, it looks to me as if you are only trying to find 
inliners for root entries, cf. hist_entry__fprintf (stdio/hist.c), and only 
when unwinding failed (?, cf. (callchain_ret == 0)).

Is this understanding correct, or should your patch also add inliners for 
nodes in the middle of the callstack?

This approach makes the whole feature unusable for my use case. In my (really 
hacky) approach to adding inliners to the output of perf (https://github.com/
milianw/linux/commit/71d031c9d679bfb4a4044226e8903dd80ea601b3) I decided to 
lookup inliners for _every_ callchain entry. The result then there is with my 
branch and a `perf report -g srcline --stdio`:

    42.50%  lab_mandelbrot   libm-2.24.so                [.] __hypot_finite
            |
            ---__hypot_finite +387
               hypot +20
               std::__complex_abs complex:589
               std::abs<double> complex:597
               drawMandelbrot mandelbrot.h:39
               main main.cpp:55
               __libc_start_main +241
               _start +42

Note the three inliner entries in the middle of the callstack. The way I did 
it, one will also see "proper" entries for inlined functions in a top-down 
`perf report --children` output.

In general, your patch series looks much more polished than mine, so I would 
love to get it integrated. But with your approach, we will need lots of 
changes to the various browsers to get all features in. My hacky approach has 
the nice property that it simply adds "normal" callchain entries for inlined 
nodes - maybe you should do the same?

Thanks a lot for your work, much appreciated.

-- 
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
