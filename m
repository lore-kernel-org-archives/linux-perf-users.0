From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH 6/7] perf report: mark inlined frames in output by " (inlined)" suffix
Date: Sat, 03 Jun 2017 15:51:02 +0200
Message-ID: <2569406.pAYQppI5ax@agathebauer>
References: <20170518193411.22380-1-milian.wolff@kdab.com> <20170518193411.22380-7-milian.wolff@kdab.com> <20170522124818.GE20009@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:43240 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750765AbdFCNvH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 3 Jun 2017 09:51:07 -0400
In-Reply-To: <20170522124818.GE20009@sejong>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com

On Montag, 22. Mai 2017 14:48:18 CEST Namhyung Kim wrote:
> On Thu, May 18, 2017 at 09:34:10PM +0200, Milian Wolff wrote:
> > The original patch that introduced inline frame output in the
> > various browsers used this suffix already. The new centralized
> > approach that uses fake symbols for inlined frames was missing
> > this approach so far.
> > 
> > Instead of changing the symbol name itself, we only print the
> > suffix where needed. This allows us to efficiently lookup
> > the symbol for a given name without first having to append the
> > suffix before the lookup.
> 
> You also need to do same thing for hist_entry__sym_snprintf().

Hey Namhyung,

I'm working on the next iteration of this patch series, the WIP can be found 
here: https://github.com/milianw/linux/tree/wip/distinguish-inliners.

I just stumbled upon another issue:

~~~~~
perf report --inline -s srcline -g srcline  --stdio -g none
    61.22%     0.00%  main+378
    61.22%     0.00%  std::_Norm_helper<true>::_S_do_it<double>+378
    61.22%     0.00%  std::__complex_abs+378
    61.22%     0.00%  std::abs<double>+378
    61.22%     0.00%  std::norm<double>+378
~~~~~

The problem here is that the srcline in the hist is detached from what we 
actually produce in the callchain nodes. We will have to somehow hand through 
the srcline from the callchain node to the hist entry, but this seems to be a 
super large invasive change - which is why I need your input on how to resolve 
this.

The current API seems to pass the data around mostly using the addr_location 
struct, which is usually constructed on the stack and not always memset to 
zero. As such, my initial plan of adding a srcline member there would require 
me to go through all the code to ensure that we memset the struct to zero...

Alternatively, I'd have to change the API of hist_iter_ops, to let the 
callback take another `const char **srcline` out parameter. This is also going 
to be quite a large invasive change.

Do you have any suggestions on how to make this work?

Thanks

-- 
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
