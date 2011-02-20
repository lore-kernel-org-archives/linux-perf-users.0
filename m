From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/3] perf events: Introduce realtime clock event
Date: Sun, 20 Feb 2011 13:49:34 +0100
Message-ID: <20110220124934.GB25700@elte.hu>
References: <1298008433-22911-1-git-send-email-daahern@cisco.com>
 <1298008433-22911-3-git-send-email-daahern@cisco.com>
 <1298027641.5226.666.camel@laptop>
 <4D5E84AC.4040104@cisco.com>
 <1298041106.5226.775.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:43265 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab1BTMtr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 20 Feb 2011 07:49:47 -0500
Content-Disposition: inline
In-Reply-To: <1298041106.5226.775.camel@laptop>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Ahern <daahern@cisco.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, paulus@samba.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> > Programs that generate time-of-day output are using gettimeofday which is tied 
> > to CLOCK_REALTIME. We want to be able to correlate a perf sample to an entry in 
> > an applications log file.
> 
> Well, you can argue those programs are broken :-), [...]

Then 99% of the world is broken as daylight saving time jumps are part of our lives.

> [...] Imagine the joys of trying to figure out wth happens when DST jumps the 
> clock back an hour and you have an hour of duplicate data.

DST means twice a year the clock jumps back and forth by exactly one hour, on a 
given Saturday night. People debugging logs on Saturday nights and not realizing 
that there's a (always highly publicized) DST switch going on *deserve* to be 
surprised twice a year! :-)

Really, i dont think it's a big issue - and timestamping in *real* time has very 
obvious advantages as its name already suggests.

Thanks,

	Ingo
