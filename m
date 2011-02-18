From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH 3/3] perf events: add timehist option to record and report
Date: Fri, 18 Feb 2011 11:45:00 -0700
Message-ID: <4D5EBE2C.7000701@cisco.com>
References: <1298008433-22911-1-git-send-email-daahern@cisco.com>	 <1298008433-22911-4-git-send-email-daahern@cisco.com>	 <20110218070657.GA11404@elte.hu> <4D5E8204.2090501@cisco.com>	 <20110218175926.GA3445@nowhere>  <4D5EB564.6030504@cisco.com> <1298054399.5226.779.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-3.cisco.com ([171.71.176.72]:48371 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641Ab1BRSpC (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Feb 2011 13:45:02 -0500
In-Reply-To: <1298054399.5226.779.camel@laptop>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>, Arnaldo Carvalho de Melo <acme@redhat.com>



On 02/18/11 11:39, Peter Zijlstra wrote:
> On Fri, 2011-02-18 at 11:07 -0700, David Ahern wrote:
>> We want not only context-switch events, but the stack trace at the
>> switch. 
> 
> Both ftrace and perf can do that:
> 
>  perf record -ge sched:sched_switch -c 1

Yes, exactly. And that is what I am using -- well, -e cs -c 1.

> 
> or
> 
> echo 1 > /debug/tracing/options/stacktrace

> 
>> That data along with the gettimeofday timestamp has allowed us to
>> resolve performance issues such as a system call taking longer than
>> expected during a specific sequence of events or a process getting
>> preempted and not scheduled for N seconds. etc., etc.
> 
> Non of that seems to require GTOD stamps.

On 01/23/11 at 03:45:67 a syslog event noted an application restart.
Checking the applications logs it went silent. Why? What does perf say?

Oh, 2 days have gone by before said event is reported to engineering,
and the server was been rebooted to 'clear' the problem - hence
resetting monotonic clock.

Multiply that by 100's of processes.

David

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
