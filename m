From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Error reporting improvement (updated)
Date: Fri, 18 Apr 2014 10:41:04 +0200
Message-ID: <20140418084104.GB11096@twins.programming.kicks-ass.net>
References: <1397786443.3093.4.camel@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:59060 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbaDRIlT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Apr 2014 04:41:19 -0400
Content-Disposition: inline
In-Reply-To: <1397786443.3093.4.camel@beast>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Adrien BAK <adrien.bak@metascale.org>
Cc: linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, paulus@samba.org, mingo@redhat.com, acme@ghostprotocols.net, will.deacon@arm.com

On Fri, Apr 18, 2014 at 11:00:43AM +0900, Adrien BAK wrote:
> Update : I resend this patch due to my email client behaving. I added the

You should also add a subsystem tag in your $subject, something like:

Subject: [PATCH] perf,tools: Error reporting improvement (updated)
                 ^^^^^^^^^^^

That makes it clear what you're patching.
