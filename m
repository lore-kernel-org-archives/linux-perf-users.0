From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH 3/3] perf events: add timehist option to record and report
Date: Fri, 18 Feb 2011 11:53:16 -0700
Message-ID: <4D5EC01C.1030108@cisco.com>
References: <1298008433-22911-1-git-send-email-daahern@cisco.com> <1298008433-22911-4-git-send-email-daahern@cisco.com> <20110218070657.GA11404@elte.hu> <4D5E8204.2090501@cisco.com> <20110218175926.GA3445@nowhere> <20110218184119.GC302@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:43299 "EHLO
	rtp-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab1BRSxU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Feb 2011 13:53:20 -0500
In-Reply-To: <20110218184119.GC302@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>



On 02/18/11 11:41, Arnaldo Carvalho de Melo wrote:
> 
> Think about tcpdump + networking tracepoints or 'perf probe' dynamic
> events in the network stack, he wants to merge those logs and correlate
> the tcpdump packet exchange with the tracepoints events in the network
> stack, etc.

I'm zoned in on ap logs, but tcpdump and network analysis is another
very good example. packets are tagged with realtime:

static inline void __net_timestamp(struct sk_buff *skb)
{
    skb->tstamp = ktime_get_real();
}


David
