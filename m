From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] perf stat: fix scale option
Date: Sun, 9 Jan 2011 21:54:42 +0100
Message-ID: <20110109205442.GA5186@elte.hu>
References: <1294595425-16791-1-git-send-email-daahern@cisco.com>
 <20110109194919.GC28554@elte.hu>
 <4D2A18AD.6020406@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:58099 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269Ab1AIUy7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 9 Jan 2011 15:54:59 -0500
Content-Disposition: inline
In-Reply-To: <4D2A18AD.6020406@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: a.p.zijlstra@chello.nl, paulus@samba.org, acme@ghostprotocols.net, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org


* David Ahern <daahern@cisco.com> wrote:

> On 01/09/11 12:49, Ingo Molnar wrote:
> > 
> > * David Ahern <daahern@cisco.com> wrote:
> > 
> >> The scale option defaults to true and the command line option only
> >> allows it to be set to true. ie. the option is a no-op.
> > 
> > Hm, the option parser should already allow --no-scale. Does that not work for you?
> > 
> > Thanks,
> > 
> > 	Ingo
> 
> Indeed it does work; I was not aware of that option. What about the '-c'
> option being a no-op?

Yeah, that's indeed inconsistent and we could flip the option around i suspect.

Thanks,

	Ingo
