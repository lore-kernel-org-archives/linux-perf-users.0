From: Vince Weaver <vweaver1@eecs.utk.edu>
Subject: Re: Questions about cycle events
Date: Mon, 28 May 2012 09:04:17 -0400
Message-ID: <alpine.LRH.2.00.1205280901530.44209@ig.icl.utk.edu>
References: <CAB_n8zJ5DjXF=qbVYNWr8yHUhB2dNB3gHru=nJv490tcdtdfFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:29469
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754606Ab2E1NEV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 28 May 2012 09:04:21 -0400
In-Reply-To: <CAB_n8zJ5DjXF=qbVYNWr8yHUhB2dNB3gHru=nJv490tcdtdfFg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yipeng Huang <yipeng@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Mon, 28 May 2012, Yipeng Huang wrote:

> Have a couple questions about how the cycle events in Perf are defined.
> 
> 1. Is the perf stat -e cycles event a good equivalent for PAPI_TOT_CYC
> (PAPI's total cycles event)?

usually.

> 2. Is there an overlap in counting between the cycles event and the
> resource stall event r01a2 or are they distinct?

what processor is this full?  In general cycles only stops if the CPU is 
explicitly halted (with a halt instruction), it doesn't stop for stalls.

> 3. How can I find out how other particular events are defined? Is
> there a reference available?

do you mean how do you tell which events perf uses?  You need to check
the kernel sources. For example the AMD event definitions are in
  arch/x86/kernel/cpu/perf_event_amd.c

Vince
