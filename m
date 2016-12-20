From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Inlined functions in perf report
Date: Tue, 20 Dec 2016 11:37:46 -0300
Message-ID: <20161220143746.GD32756@kernel.org>
References: <20161220115954.GA35897@sesse.net>
 <20161220121755.GL3124@twins.programming.kicks-ass.net>
 <2027151.EnbG4A8ymx@milian-kdab2>
 <20161220135450.GA32756@kernel.org>
 <20161220140822.GA10075@sesse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935677AbcLTOoP (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Dec 2016 09:44:15 -0500
Content-Disposition: inline
In-Reply-To: <20161220140822.GA10075@sesse.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, "Liang, Kan" <kan.liang@intel.com>, "Jin, Yao" <yao.jin@linux.intel.com>

Em Tue, Dec 20, 2016 at 03:08:22PM +0100, Steinar H. Gunderson escreveu:
> On Tue, Dec 20, 2016 at 10:54:50AM -0300, Arnaldo Carvalho de Melo wrote:
> > Have you guys looked at this:
> > 
> > http://lkml.kernel.org/r/1481121822-2537-1-git-send-email-yao.jin@linux.intel.com
> > 
> > I have to review it and maybe you will help me with that ;-)
> 
> Woot. Is this available in git somewhere? (Or if not, what do I apply it on
> top of?)

Normally you get it from tip, i.e. from:

git//git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core

As I sync frequently with Ingo, this way you would get more shielded
from rebases I sometimes do, but if you want the bleeding edge, the
place is:

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core

I hope to get back to this soon as I have something else in that area
(inlines) in the backburner, inline annotations, a screenshot I made
last time I touched this area:

http://vger.kernel.org/~acme/perf/inline_annotate/ipt_do_table.png

There are other examples in the same dir:

http://vger.kernel.org/~acme/perf/inline_annotate/

Idea is to highlight the assembly lines for different inlines.

- Arnaldo
