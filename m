From: "Jin, Yao" <yao.jin@linux.intel.com>
Subject: Re: Inlined functions in perf report
Date: Wed, 21 Dec 2016 08:53:33 +0800
Message-ID: <df263fe1-e1af-881b-311e-5329bb51db0e@linux.intel.com>
References: <20161220115954.GA35897@sesse.net>
 <20161220121755.GL3124@twins.programming.kicks-ass.net>
 <2027151.EnbG4A8ymx@milian-kdab2> <20161220135450.GA32756@kernel.org>
 <20161220140822.GA10075@sesse.net> <20161220143746.GD32756@kernel.org>
 <20161220170108.GA6467@sesse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58551 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934123AbcLUAxg (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Dec 2016 19:53:36 -0500
In-Reply-To: <20161220170108.GA6467@sesse.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, "Liang, Kan" <kan.liang@intel.com>

I just pull my repo with the latest perf/core branch, and apply the 
patch one by one (git am 0001/0002/.../0005), they can be applied. Maybe 
you have to do like that because the mails are probably coming out of 
order.

0000(https://marc.info/?l=linux-kernel&m=148109315020127&w=2)

0001(https://marc.info/?l=linux-kernel&m=148109316620129&w=2)

0002 (https://marc.info/?l=linux-kernel&m=148109313220124&w=2)

0003(https://marc.info/?l=linux-kernel&m=148109320020136&w=2)

0004(https://marc.info/?l=linux-kernel&m=148109316620130&w=2)

0005(https://marc.info/?l=linux-kernel&m=148109318620134&w=2)

I'm using the git 
(https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git) and 
branch (remotes/origin/perf/core).

Thanks

Jin Yao

On 12/21/2016 1:01 AM, Steinar H. Gunderson wrote:
> On Tue, Dec 20, 2016 at 11:37:46AM -0300, Arnaldo Carvalho de Melo wrote:
>>> Woot. Is this available in git somewhere? (Or if not, what do I apply it on
>>> top of?)
>> Normally you get it from tip, i.e. from:
>>
>> git//git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
> I suppose perf/core here means a branch named perf/core in that git
> repository, but it doesn't seem to contain the patches in question.
>
> I tried applying them on top of that branch by wget-ing down the right
> messages from marc.info, but somehow, I must have misapplied them
> (it was rather painful, especially since they seemingly come out-of-order
> in the archives), because the resulting tree didn't compile.
>
> /* Steinar */
