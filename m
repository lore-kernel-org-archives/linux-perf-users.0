From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf trace report with time consumed
Date: Fri, 8 Apr 2016 10:01:21 -0300
Message-ID: <20160408130121.GM5945@kernel.org>
References: <1894563.GPSC8z33rH@agathebauer>
 <2600188.8x2NmCkWJL@agathebauer>
 <20160405083524.GB17232@krava.brq.redhat.com>
 <8811507.a6yccgC5Cj@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58769 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbcDHNBZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 8 Apr 2016 09:01:25 -0400
Content-Disposition: inline
In-Reply-To: <8811507.a6yccgC5Cj@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@redhat.com>, perf group <linux-perf-users@vger.kernel.org>

Em Wed, Apr 06, 2016 at 11:16:27PM +0200, Milian Wolff escreveu:
> On Dienstag, 5. April 2016 10:35:24 CEST Jiri Olsa wrote:
> > On Mon, Apr 04, 2016 at 11:17:11PM +0200, Milian Wolff wrote:
> > > Is there a way to increase the event buffer or something like that to not
> > > lose events when the costly dwarf unwinding happens for the first time?
> > > Consecutive unwinding is cached by libunwind and much faster.

> > not sure about perf trace, but there's -m option available for perf record
> > that allows you to increase the buffer size
 
> <snip>
 
> Yes, trace also knows the -m and even passing "-m 1M" already makes it the 
> above use-case work. What is the default value? Could/Should it maybe be 
> increased? 1M is not a lot of memory, sounds like a good trade-off to me?

I think we should do that and also use some heuristic based on the
target to bump the number of mmap data pages, i.e. is it system wide?
Does it contains callchains? What is the record_size for --call-graph
dwarf?

- Arnaldo
