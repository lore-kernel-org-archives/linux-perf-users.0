From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH 3/3] perf events: add timehist option to record and report
Date: Sat, 19 Feb 2011 12:38:25 -0200
Message-ID: <20110219143825.GA2729@ghostprotocols.net>
References: <1298008433-22911-1-git-send-email-daahern@cisco.com>
 <1298008433-22911-4-git-send-email-daahern@cisco.com>
 <20110218070657.GA11404@elte.hu>
 <4D5E8204.2090501@cisco.com>
 <20110218175926.GA3445@nowhere>
 <4D5EB564.6030504@cisco.com>
 <1298054399.5226.779.camel@laptop>
 <4D5EBE2C.7000701@cisco.com>
 <20110219093216.GA30331@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45878 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368Ab1BSOid (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 19 Feb 2011 09:38:33 -0500
Content-Disposition: inline
In-Reply-To: <20110219093216.GA30331@elte.hu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: David Ahern <daahern@cisco.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>

Em Sat, Feb 19, 2011 at 10:32:16AM +0100, Ingo Molnar escreveu:
> * David Ahern <daahern@cisco.com> wrote:
> 
> > On 01/23/11 at 03:45:67 a syslog event noted an application restart.
> > Checking the applications logs it went silent. Why? What does perf say?
> > 
> > Oh, 2 days have gone by before said event is reported to engineering,
> > and the server was been rebooted to 'clear' the problem - hence
> > resetting monotonic clock.
> 
> I think that's a valid usecase and the feature you are suggestion is very useful.
> 
> Why not extend the regular trace output to also (optionally) output GTOD timestamps?

That is how this this feature request/submission originally started.

David tried with an extra header, then a synthesized event, then after
some discussion with Peter I started working on a monotonic clock event,
but got sidetracked with other stuff, he tried picking up from where I
left and here we are.

I think the summary is: we need a clock_gettime like interface so that
users can pick and choose what clock matches best whatever app they're
trying to merge logs.

- Arnaldo
