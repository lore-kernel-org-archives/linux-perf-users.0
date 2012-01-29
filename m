From: Ingo Molnar <mingo@elte.hu>
Subject: Re: perf: prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect
Date: Sun, 29 Jan 2012 17:32:35 +0100
Message-ID: <20120129163235.GB23408@elte.hu>
References: <4F22D8D9.3010108@rgmadvisors.com>
 <20120128120151.GA10390@elte.hu>
 <4F248938.5030507@rgmadvisors.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:44871 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753030Ab2A2Qcp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 29 Jan 2012 11:32:45 -0500
Content-Disposition: inline
In-Reply-To: <4F248938.5030507@rgmadvisors.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andrew Steets <asteets@rgmadvisors.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>


* Andrew Steets <asteets@rgmadvisors.com> wrote:

> On 1/28/12 6:01 AM, Ingo Molnar wrote:
> 
> >> prctl(PR_TASK_PERF_EVENTS_DISABLE) doesn't appear to 
> >> disable perf event counters.  Here is a demonstration 
> >> program:
> >
> > btw., what's your usecase?
> 
> I'm trying to profile a small section of a long-running 
> program.  I ran into trouble using call-graph recording and I 
> thought this might be an alternative way of getting what I was 
> after.

That usecase indeed makes sense. Peter, could we allow this for 
privileged tasks, depending on the perf_paranoia settings or 
such?

Thanks,

	Ingo
