From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf record of multiple events: disable callgraph for some events
Date: Fri, 9 Oct 2015 11:31:42 -0300
Message-ID: <20151009143142.GL14409@kernel.org>
References: <4930261.j7GqdZnq15@agathebauer>
 <20151004204059.GF20515@kernel.org>
 <1795032.7YQzqPdcGP@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45398 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756110AbbJIObq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 9 Oct 2015 10:31:46 -0400
Content-Disposition: inline
In-Reply-To: <1795032.7YQzqPdcGP@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

Em Fri, Oct 09, 2015 at 04:08:10PM +0200, Milian Wolff escreveu:
> On Sonntag, 4. Oktober 2015 17:40:59 CEST Arnaldo Carvalho de Melo wrote:
> > Em Sun, Oct 04, 2015 at 01:48:21PM +0200, Milian Wolff escreveu:

> > > would it be possible to add a feature to perf to only grab
> > > callgraphs for a certain selection of events? E.g. thinking about
> > > a lock contention profile of a Qt application, I'd listen to

> > > -e syscalls:sys_enter_futex,syscalls:sys_exit_futex

> > > Now, with the dwarf unwinder this easily produces huge data files in the
> > > order of gigabytes. This cost could easily be reduced by a factor of two,
> > > as one only needs the callgraphs for syscalls:sys_enter_futex - the TID
> > > should be enough to find the callgraph for the enter event from the exit
> > > trace point.

> > > Could someone guide me in implementing such a feature to make it possible
> > > to filter the events which trigger the collection of a callgraph? Or is
> > > that already possible somehow?

> > Can you please check if this suits you, it is already in the tree:
> > 
> > commit e637d17757a10732fa5d573c18f20b3cd4d31245
> > Author: He Kuang <hekuang@huawei.com>
> > Date:   Mon Sep 28 03:52:16 2015 +0000
 
> <snip>
 
> Perfect, Thanks Arnaldo for pointing me in that direction, and many thanks to 
> He for implementing it! Works like a charm.
> 
> Does anyone have a suggestion on where to put documentation for this? I'll try 
> to add that then next week, together with the other stuff I've noticed and 
> couldn't find before. Otherwise, I'll put it into the docs for `perf record`'s 
> `--call-graph`.

Works for me. Glad that it worked for you. :-)

- Arnaldo
