From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH 2/3] perf events: Introduce realtime clock event
Date: Fri, 18 Feb 2011 08:39:47 -0700
Message-ID: <4D5E92C3.70003@cisco.com>
References: <1298008433-22911-1-git-send-email-daahern@cisco.com>	 <1298008433-22911-3-git-send-email-daahern@cisco.com>	 <1298027641.5226.666.camel@laptop>  <4D5E84AC.4040104@cisco.com> <1298041106.5226.775.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-4.cisco.com ([171.68.10.86]:38390 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab1BRPjt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Feb 2011 10:39:49 -0500
In-Reply-To: <1298041106.5226.775.camel@laptop>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@ghostprotocols.net, paulus@samba.org



On 02/18/11 07:58, Peter Zijlstra wrote:
>>> I'm really not sure why you want CLOCK_REALTIME and I think
>>> CLOCK_MONOTONIC is more useful (I'd argue you want your system logs to
>>> contain both, every admin who's ever had to untangle what happened
>>> during DST switches will agree)
>>
>> I believe CLOCK_MONOTONIC is what perf_clock is tied to -- the
>> timestamps for PERF_SAMPLE_TIME -- so we already have that.
> 
> Its not (it mere _can_ be), it could be tied to the TSC which can
> significantly drift wrt CLOCK_MONOTONIC.

Ok, either way I would like correlation between perf_clock and the time
sample data and gettimeofday.

> 
>> Programs that generate time-of-day output are using gettimeofday which
>> is tied to CLOCK_REALTIME. We want to be able to correlate a perf sample
>> to an entry in an applications log file.
> 
> Well, you can argue those programs are broken :-), Imagine the joys of
> trying to figure out wth happens when DST jumps the clock back an hour
> and you have an hour of duplicate data.
> 

Luckily DST only happens twice a year. Of course reboots happen a little
more often and those reset the monotonic clock.

I can't change the known universe of programs that create pretty
HH:MM:SS MM/DD/YY time strings. What I do want is to know why a program
missed a heartbeat as noted by a log entry. Correlating with a perf
event and seeing the backtrace is quite handy.

David
