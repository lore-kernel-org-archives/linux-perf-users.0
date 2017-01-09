From: "Jin, Yao" <yao.jin@linux.intel.com>
Subject: Re: Feedback on: [RESEND PATCH v2 0/5] perf report: Show inline stack
Date: Mon, 9 Jan 2017 11:07:26 +0800
Message-ID: <ded48f05-ab7f-d294-16aa-65d4ac8ee926@linux.intel.com>
References: <5135140.l86lTS2Zdn@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41428 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751866AbdAIDH2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 8 Jan 2017 22:07:28 -0500
In-Reply-To: <5135140.l86lTS2Zdn@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

Hi Wolff,

Thanks a lot for your feedback.

Have you tested with the browser mode? I mean without the "--stdio" option.

Could you give your test binary then I can try to reproduce the issue? I 
have tried with my tests but I could not reproduce.

Thanks

Jin Yao

On 1/8/2017 4:13 AM, Milian Wolff wrote:
> Hey Jin,
>
> I have finally had the time to test your patch series. Sadly, I hit a
> fundamental issue with it early on in my testing:
>
> In my test case, I get with `perf report --no-children` e.g. the following:
>
>      42.50%  lab_mandelbrot   libm-2.24.so                [.] __hypot_finite
>              |
>              ---__hypot_finite
>                 hypot
>                 main
>                 __libc_start_main
>                 _start
>
> Enabling --inline does not change the output, even though hypot is inlined
> into main.
>
> Looking at your code, it looks to me as if you are only trying to find
> inliners for root entries, cf. hist_entry__fprintf (stdio/hist.c), and only
> when unwinding failed (?, cf. (callchain_ret == 0)).
>
> Is this understanding correct, or should your patch also add inliners for
> nodes in the middle of the callstack?
>
> This approach makes the whole feature unusable for my use case. In my (really
> hacky) approach to adding inliners to the output of perf (https://github.com/
> milianw/linux/commit/71d031c9d679bfb4a4044226e8903dd80ea601b3) I decided to
> lookup inliners for _every_ callchain entry. The result then there is with my
> branch and a `perf report -g srcline --stdio`:
>
>      42.50%  lab_mandelbrot   libm-2.24.so                [.] __hypot_finite
>              |
>              ---__hypot_finite +387
>                 hypot +20
>                 std::__complex_abs complex:589
>                 std::abs<double> complex:597
>                 drawMandelbrot mandelbrot.h:39
>                 main main.cpp:55
>                 __libc_start_main +241
>                 _start +42
>
> Note the three inliner entries in the middle of the callstack. The way I did
> it, one will also see "proper" entries for inlined functions in a top-down
> `perf report --children` output.
>
> In general, your patch series looks much more polished than mine, so I would
> love to get it integrated. But with your approach, we will need lots of
> changes to the various browsers to get all features in. My hacky approach has
> the nice property that it simply adds "normal" callchain entries for inlined
> nodes - maybe you should do the same?
>
> Thanks a lot for your work, much appreciated.
>
