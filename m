From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/4] perf events: Add realtime clock event and timehist
 option -v2
Date: Tue, 22 Feb 2011 08:41:58 +0100
Message-ID: <20110222074158.GA32322@elte.hu>
References: <1298322150-15505-1-git-send-email-daahern@cisco.com>
 <20110221213740.GC3583@nowhere>
 <4D62DC21.4070407@cisco.com>
 <20110221215533.GD3583@nowhere>
 <4D62E2B0.1070607@cisco.com>
 <20110221222104.GE3583@nowhere>
 <4D630E79.7030106@cisco.com>
 <20110222025001.GA5475@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:49734 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753831Ab1BVHmN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 22 Feb 2011 02:42:13 -0500
Content-Disposition: inline
In-Reply-To: <20110222025001.GA5475@nowhere>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: David Ahern <daahern@cisco.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, peterz@infradead.org, paulus@samba.org, tglx@linutronix.de


* Frederic Weisbecker <fweisbec@gmail.com> wrote:

> perf-script is not new, it was there in november already, although named perf 
> trace at that time.

Yes.

The new 'perf trace' utility - which might be the straightforward 'report a trace' 
utility that David is looking for is still WIP and can be found at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git tmp.perf/trace

Warning: the code is stale and needs much more work to become mergable. But 
displaying GTOD timestamps is very much something that looks sensible in the 'perf 
trace' context as well.

Thanks,

	Ingo
