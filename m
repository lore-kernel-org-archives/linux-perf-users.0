From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: How to check perf commands are producing proper output or not?
Date: Fri, 28 Jan 2011 13:43:14 -0200
Message-ID: <20110128154314.GC6345@ghostprotocols.net>
References: <AANLkTikZc4L=-xzmOvqLC00qNHLuqCBOdcD3hofBNfFN@mail.gmail.com>
 <20110128134811.GB6345@ghostprotocols.net>
 <alpine.DEB.2.00.1101280929240.10620@cl320.eecs.utk.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36292 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab1A1PnW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 28 Jan 2011 10:43:22 -0500
Received: by ywe10 with SMTP id 10so1100949ywe.19
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jan 2011 07:43:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1101280929240.10620@cl320.eecs.utk.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vweaver1@eecs.utk.edu>
Cc: nelakurthi koteswararao <koteswararao18@gmail.com>, linux-perf-users@vger.kernel.org

Em Fri, Jan 28, 2011 at 09:37:03AM -0500, Vince Weaver escreveu:
> On Fri, 28 Jan 2011, Arnaldo Carvalho de Melo wrote:
> > 
> > So far I wrote some that generate tracepoint events, but I can envision
> > for instance, figuring out the size of the L2 processor cache, creating
> > an array that is of that size, then go on touching it till it trashes
> > the cache while measuring the relevant event.
> 
> Unfortunately it is harder to validate perf events than you might guess.

My expectation so far, for basic tests, is not to precisely detect each
and every event, but to make sure that if a big number of cache misses
is being provoked, a big number of cache misses is being detected, to
test the basic working of the system.

After basic tests are in place, we go on trying to make them more
precise as is practical.
 
> For your L2 example, most processors do hardware prefetch in very hard to 
> model way, so the "expected" value never matches anything that you get 
> with the counters.  This is even if you write the tests in assembly
> language to avoid any weird behavior from the C compilers (and there can 
> be, even on something as simple as an array walk).
> 
> Even things you might think are simple, like retired-instructions can vary 
> wildly.  There are enough differences caused by Linux and processor errata 
> with retired-instructions that I wrote a whole 10 page paper about the 
> differences you see.

Cool, can I get the paper URL? I'd love to read it
 
> I have started writing some validation tests, though they use the PAPI 
> library which runs on top of perf-events.  You can see that and other 
> validation work linked to here:
>    http://web.eecs.utk.edu/~vweaver1/projects/validation-tests/

Will look at it, thanks for the pointer, thanks for working on it!

- Arnaldo
