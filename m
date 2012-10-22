From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: perf top -z not working?
Date: Mon, 22 Oct 2012 07:45:52 -0700
Message-ID: <20121022144552.GB8775@ghostprotocols.net>
References: <507EA40D.60206@cs.utoronto.ca>
 <507EB776.9030304@core.kaist.ac.kr>
 <20121022014618.GA7924@ghostprotocols.net>
 <50853311.3040707@cs.utoronto.ca>
 <50854633.30206@gmail.com>
 <508553D1.8040603@cs.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:44853 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754737Ab2JVOp5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 22 Oct 2012 10:45:57 -0400
Received: by mail-gh0-f174.google.com with SMTP id g15so476732ghb.19
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Oct 2012 07:45:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <508553D1.8040603@cs.utoronto.ca>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
Cc: David Ahern <dsahern@gmail.com>, Chulmin Kim <cmkim@core.kaist.ac.kr>, linux-perf-users@vger.kernel.org

Em Mon, Oct 22, 2012 at 10:10:25AM -0400, Ryan Johnson escreveu:
> On 22/10/2012 9:12 AM, David Ahern wrote:
> >The kernel has nothing to do with the feature. From builtin-top.c,
> >this part is either not happening or more likely not happening
> >correctly.
> >
> >    if (top->zero)
> >        symbol__annotate_zero_histogram(symbol, top->sym_evsel->idx);
> >    else
> >        symbol__annotate_decay_histogram(symbol, top->sym_evsel->idx);
> >
> >I recall it working recently - last year or so. Can you try
> >different versions -- say 3.0, 3.2, 3.4 and latest? If you have a
> >copy of Linus' tree or Arnaldo's git tree it should not take much
> >time.
> Chulmin says his 3.0 version works. My 3.2.18 doesn't. I don't have
> a copy of the git tree on that machine, but I'll try building 3.4.x
> and tip when I get a chance. I have never built perf-tools before,
> though, so I'd appreciate tips on what might be different for
> building perf-tools compared to the kernel, and how to avoid
> building the standard kernel along the way. Hopefully it's just
> configure-make-install?

To build just the tools, on a /usr/src/linux or wherever you have the
newer kernel sources:

 make -C tools/perf install

Then make sure you use what is in your ~/bin/ before the standard path:

 export PATH=~/bin:$PATH
 hash -r

Then try perf top -z again.

- Arnaldo
