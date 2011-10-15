From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Profiling sleep times?
Date: Sat, 15 Oct 2011 19:00:46 +0200
Message-ID: <20111015170044.GB29782@elte.hu>
References: <4E8A0F53.7020408@fb.com>
 <1317673027.20367.41.camel@twins>
 <4E8A2EC5.1030901@fb.com>
 <1317717291.25926.13.camel@twins>
 <4E8E2417.2000903@fb.com>
 <4E8FAB3A.2040801@gmail.com>
 <4E933E65.1090207@fb.com>
 <20111012074113.GK18618@elte.hu>
 <4E98A75E.3010000@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:40947 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051Ab1JORC3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 15 Oct 2011 13:02:29 -0400
Content-Disposition: inline
In-Reply-To: <4E98A75E.3010000@fb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: avagin@gmail.com, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, acme@ghostprotocols.net, Stephane Eranian <eranian@google.com>, Frederic Weisbecker <fweisbec@gmail.com>


* Arun Sharma <asharma@fb.com> wrote:

> On 10/12/11 12:41 AM, Ingo Molnar wrote:
> >>Generally I'm happy with the direction of these patches. [...]
> >
> >Ok, will someone please send an updated series of all missing
> >patches, with all acks included, for potential v3.2 pickup?
> >
> >Sleep time profiling is obviously a very hot feature ...
> >
> 
> I acked two of Andrew's patches. The third one is the most 
> important one. I haven't had a chance to review that carefully yet 
> - although it's working well for me.
> 
> We still need to figure out what's the best way to munge all this 
> data in user space to implement wall clock profiling.

Well, if 'perf report' can show sleep time ordered entries just fine 
by default (if a proper perf record was done), which also works in 
call graph recording mode then i'm a happy camper.

Sleep time should really just be a different notion of 'cost of the 
function/callchain' and fit into the existing scheme, right?

Thanks,

	Ingo
