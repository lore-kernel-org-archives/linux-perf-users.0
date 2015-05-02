From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf uncore behavior
Date: Sat, 2 May 2015 14:16:11 +0200
Message-ID: <20150502121611.GK2366@two.firstfloor.org>
References: <CANFySvewjJTo7Cezq3e1SPAFFmRRRWADTJ50T5rubvcLrAV2xA@mail.gmail.com>
 <87618blpsr.fsf@tassilo.jf.intel.com>
 <CANFySvcwE52VTqPKc5vzkQkq+wAenFr=deaGX8ZxGQFTU1SjVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:45423 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbbEBMQN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 2 May 2015 08:16:13 -0400
Content-Disposition: inline
In-Reply-To: <CANFySvcwE52VTqPKc5vzkQkq+wAenFr=deaGX8ZxGQFTU1SjVg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Chris Freehill <cfreehill@utexas.edu>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

On Fri, May 01, 2015 at 09:31:58PM -0500, Chris Freehill wrote:
> A follow up...can  you define what  "sockets/nodes" means in this
> context? What is the relationship between sockets/nodes and CPU's.

In Linux terminology a CPU is a logical CPU thread. A socket
is a physical chip. 

> What is the distinction? For core events, they would be the same,
> right? Could you give an example of what "-a" would sum up when we are
> talking about uncore events?

It sums up events from all sockets

> 
> I think my main confusion is an assumption (up to now, anyway) that
> there is only one set of uncore events, for the multicore device, so
> it wouldn't make sense to sum up anything. 

There is one set per socket (or rather chip, if you talk about an
multi-chip-module)

> For core events, my
> understanding is that with no "-C<core id>" specified, perf sums up
> the core event counts and presents this as output. For uncore, the
> events are not per-core, so I'm not sure how to interpret that "sum".

It's the sum of all cores on that socket.

-Andi
