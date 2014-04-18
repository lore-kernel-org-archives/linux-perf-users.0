From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] Error reporting improvement (updated)
Date: Fri, 18 Apr 2014 12:25:40 +0200
Message-ID: <20140418102540.GB1914@krava.brq.redhat.com>
References: <1397786443.3093.4.camel@beast>
 <20140418084104.GB11096@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45973 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034AbaDRK0L (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Apr 2014 06:26:11 -0400
Content-Disposition: inline
In-Reply-To: <20140418084104.GB11096@twins.programming.kicks-ass.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Adrien BAK <adrien.bak@metascale.org>, linux-perf-users@vger.kernel.org, paulus@samba.org, mingo@redhat.com, acme@ghostprotocols.net, will.deacon@arm.com

On Fri, Apr 18, 2014 at 10:41:04AM +0200, Peter Zijlstra wrote:
> On Fri, Apr 18, 2014 at 11:00:43AM +0900, Adrien BAK wrote:
> > Update : I resend this patch due to my email client behaving. I added the
> 
> You should also add a subsystem tag in your $subject, something like:
> 
> Subject: [PATCH] perf,tools: Error reporting improvement (updated)
>                  ^^^^^^^^^^^
> 
> That makes it clear what you're patching.

no need to resend, I fixed that for you this time

jirka
