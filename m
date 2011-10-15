From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Profiling sleep times?
Date: Sat, 15 Oct 2011 21:29:19 +0200
Message-ID: <1318706959.11898.1.camel@laptop>
References: <4E8A0F53.7020408@fb.com> <1317673027.20367.41.camel@twins>
	 <4E8A2EC5.1030901@fb.com> <1317717291.25926.13.camel@twins>
	 <4E8E2417.2000903@fb.com> <4E8FAB3A.2040801@gmail.com>
	 <4E933E65.1090207@fb.com> <20111012074113.GK18618@elte.hu>
	 <4E98A75E.3010000@fb.com>  <20111015170044.GB29782@elte.hu>
	 <1318706522.2664.8.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:49572 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610Ab1JOT3W (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 15 Oct 2011 15:29:22 -0400
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RF9v7-0004qQ-Ox
	for linux-perf-users@vger.kernel.org; Sat, 15 Oct 2011 19:29:21 +0000
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=dyad.programming.kicks-ass.net)
	by canuck.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1RF9v7-0004A9-FB
	for linux-perf-users@vger.kernel.org; Sat, 15 Oct 2011 19:29:21 +0000
In-Reply-To: <1318706522.2664.8.camel@laptop>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arun Sharma <asharma@fb.com>, avagin@gmail.com, linux-perf-users@vger.kernel.org, acme@ghostprotocols.net, Stephane Eranian <eranian@google.com>, Frederic Weisbecker <fweisbec@gmail.com>

On Sat, 2011-10-15 at 21:22 +0200, Peter Zijlstra wrote:

> > Sleep time should really just be a different notion of 'cost of the 
> > function/callchain' and fit into the existing scheme, right?
> 
> The problem with andrew's patches is that it wrecks the callchain
> semantics. The waittime tracepoint is in the wakeup path (and hence
> generates the wakee's callchain) whereas they really want the callchain
> of the woken task to show where it spend time.

We could of course try to move the tracepoint into the schedule path, so
we issue it the first time the task gets scheduled after the wakeup, but
I suspect that will just add more overhead, and we really could do
without that.
