From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH v7 1/5] perf report: properly handle branch count in match_chain
Date: Thu, 19 Oct 2017 13:42:18 +0200
Message-ID: <1895125.rrirNAUR4a@agathebauer>
References: <20171019113836.5548-1-milian.wolff@kdab.com> <20171019113836.5548-2-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:36644 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752742AbdJSLmV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Oct 2017 07:42:21 -0400
In-Reply-To: <20171019113836.5548-2-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org
Cc: jolsa@kernel.org, namhyung@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

On Donnerstag, 19. Oktober 2017 13:38:32 CEST Milian Wolff wrote:
> Some of the code paths I introduced before returned too early
> without running the code to handle a node's branch count.
> By refactoring match_chain to only have one exit point, this
> can be remedied.

Note: I tested this with some of the code I have available, but I'm unsure I'm 
doing it right. On my system, I never get avg_cycles != 0. I tried:

perf record -b --call-graph dwarf <some binary>
perf report --branch-history --no-children --stdio

I see predicted and iter values as before, so I think nothing is breaking. But 
I'm somewhat unsure. Can someone paste an example source code and the perf 
commands to get some meaningful avg_cycles? Or does this depend on a newer 
Intel CPU? I have currently only a Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz 
available.

Cheers

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
