From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH 0/4] perf events: Add realtime clock event and timehist
 option -v2
Date: Tue, 22 Feb 2011 01:07:17 -0700
Message-ID: <4D636EB5.3030605@cisco.com>
References: <1298322150-15505-1-git-send-email-daahern@cisco.com> <20110221213740.GC3583@nowhere> <4D62DC21.4070407@cisco.com> <20110221215533.GD3583@nowhere> <4D62E2B0.1070607@cisco.com> <20110221222104.GE3583@nowhere> <4D630E79.7030106@cisco.com> <20110222025001.GA5475@nowhere> <20110222074158.GA32322@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-3.cisco.com ([171.71.176.72]:34797 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992Ab1BVIHT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 22 Feb 2011 03:07:19 -0500
In-Reply-To: <20110222074158.GA32322@elte.hu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, peterz@infradead.org, paulus@samba.org, tglx@linutronix.de

On 02/22/11 00:41, Ingo Molnar wrote:
> 
> * Frederic Weisbecker <fweisbec@gmail.com> wrote:
> 
>> perf-script is not new, it was there in november already, although named perf 
>> trace at that time.
> 
> Yes.
> 
> The new 'perf trace' utility - which might be the straightforward 'report a trace' 
> utility that David is looking for is still WIP and can be found at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git tmp.perf/trace
> 
> Warning: the code is stale and needs much more work to become mergable. But 
> displaying GTOD timestamps is very much something that looks sensible in the 'perf 
> trace' context as well.

Ok. I'll look at moving the timehist option from perf-report to perf-script.

David

> 
> Thanks,
> 
> 	Ingo
