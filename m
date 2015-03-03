From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: address output in 'perf script' does not work for addr2line
Date: Tue, 3 Mar 2015 17:50:26 -0300
Message-ID: <20150303205026.GN5187@kernel.org>
References: <CAJh9x3pz1aLQP_vvfN_Y_BwF4ekcU1mqvZFJz7x7X6QqLkK1jg@mail.gmail.com>
 <20150303162322.GK5187@kernel.org>
 <CAJh9x3rwvAdjXJ67wvNjWjy451zWy1a_7JjDKQacJkwWWL031A@mail.gmail.com>
 <54F61172.4050002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:53773 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756076AbbCCUz3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 3 Mar 2015 15:55:29 -0500
Content-Disposition: inline
In-Reply-To: <54F61172.4050002@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Yuanfang Chen <cyfmxc@gmail.com>, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>

Em Tue, Mar 03, 2015 at 12:54:26PM -0700, David Ahern escreveu:
> On 3/3/15 12:27 PM, Yuanfang Chen wrote:
> >On Tue, Mar 3, 2015 at 11:23 AM, Arnaldo Carvalho de Melo wrote:
> >>Em Tue, Mar 03, 2015 at 11:07:18AM -0500, Yuanfang Chen escreveu:
> >>>Recently after updating perf package, I found the 'ip' in 'perf
> >>>script' like below is shorter than before. Also feeding that address
> >>>(like 57e below) to addr2line does not output filename:lineno
> >>>information anymore.  How do I fix this issue? Is this a bug?

> >>Yeah, I tried using it with addr2line and it didn't work :-\ So what
> >>you're saying is that in the past it worked like that?

> >>If so, could you please 'git bisect' it to find out when it got broken?

> >Yeah, it worked in the past.
> >commit 5550171b2a9f8df26ff483051d060db06376b26d  change ip into
> >relative address ( not sure relative to which address), which makes
> >addr2line unable to parse.

> That's Andi's commit.

Oh well, that, IIRC, was done to make the srcline sort key to work, but
broke the perf script output, so perhaps its time to change the perf
script output to use that code and show srcline:lineno, will see.

- Arnaldo
