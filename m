From: Vince Weaver <vweaver1@eecs.utk.edu>
Subject: Re: How to check perf commands are producing proper output or not?
Date: Fri, 28 Jan 2011 09:37:03 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1101280929240.10620@cl320.eecs.utk.edu>
References: <AANLkTikZc4L=-xzmOvqLC00qNHLuqCBOdcD3hofBNfFN@mail.gmail.com> <20110128134811.GB6345@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from leopard.mail.utk.edu ([160.36.0.85]:36226 "EHLO
	leopard.mail.utk.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518Ab1A1OyP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 28 Jan 2011 09:54:15 -0500
In-Reply-To: <20110128134811.GB6345@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: nelakurthi koteswararao <koteswararao18@gmail.com>, linux-perf-users@vger.kernel.org

On Fri, 28 Jan 2011, Arnaldo Carvalho de Melo wrote:
> 
> So far I wrote some that generate tracepoint events, but I can envision
> for instance, figuring out the size of the L2 processor cache, creating
> an array that is of that size, then go on touching it till it trashes
> the cache while measuring the relevant event.

Unfortunately it is harder to validate perf events than you might guess.

For your L2 example, most processors do hardware prefetch in very hard to 
model way, so the "expected" value never matches anything that you get 
with the counters.  This is even if you write the tests in assembly
language to avoid any weird behavior from the C compilers (and there can 
be, even on something as simple as an array walk).

Even things you might think are simple, like retired-instructions can vary 
wildly.  There are enough differences caused by Linux and processor errata 
with retired-instructions that I wrote a whole 10 page paper about the 
differences you see.

I have started writing some validation tests, though they use the PAPI 
library which runs on top of perf-events.  You can see that and other 
validation work linked to here:
   http://web.eecs.utk.edu/~vweaver1/projects/validation-tests/

Vince
