From: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH 4/6] perf record: add time-of-day option
Date: Fri, 17 Jun 2011 08:23:01 -0600
Message-ID: <4DFB6345.3080007@gmail.com>
References: <1307490806-24548-1-git-send-email-dsahern@gmail.com> <1307490964-24714-1-git-send-email-dsahern@gmail.com> <20110617141425.GD25197@somewhere.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44086 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756962Ab1FQOXE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 17 Jun 2011 10:23:04 -0400
In-Reply-To: <20110617141425.GD25197@somewhere.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, paulus@samba.org, tglx@linutronix.de

On 06/17/2011 08:14 AM, Frederic Weisbecker wrote:
> 
> So I feel uncomfortable with this tod_sample_type hack. I think we can't really continue
> with this fixed sample_type per session given the kind of hacks that involves.
> 
> One thing we could do is to split session->sample_type into an array with one sample
> type per event type (hardware, breakpoint, software, tracepoint).
> 
> And then each builtin tool can provide their constraints on top of these values:
> 
> - builtin-report wants sample_type[HARDWARE] == sample_type[SOFTWARE] == sample_type[TRACEPOINT] == sample_type[BREAKPOINT]
>   although that may be tunable by the time but we can start with that.
> - builtin-script has no specific constraints, except that sample_type[i] meets what the user passed as a parameter
> - etc..
> 
> Constraints can probably default to sample_type[i] == sample_type[i+1] to mimic the current behaviour. Then tools
> can override that.
> 
> What do you think?

I started working on sample_type refactoring right after sending this
patchset (though I got sidetracked). Each evsel in the list has a
perf_attr struct which has a sample_type. Why not use that which allows
events to have their own sample type - versus a type per event type?

I'll see if I can get back to it in the next few days and get a better
idea of the pain involved with the refactoring.

David
