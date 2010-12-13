From: "David S. Ahern" <daahern@cisco.com>
Subject: Re: [PATCH 1/2] perf tools: Add reference timestamp to perf header
Date: Mon, 13 Dec 2010 11:01:13 -0700
Message-ID: <4D065F69.7080707@cisco.com>
References: <1291773285-16254-1-git-send-email-daahern@cisco.com>	 <1291773285-16254-2-git-send-email-daahern@cisco.com>	 <20101212201613.GA1784@nowhere> <4D06301C.2090309@cisco.com>	 <20101213155451.GA1691@nowhere> <20101213164854.GL5407@ghostprotocols.net>	 <20101213170923.GB1691@nowhere> <1292260289.6803.297.camel@twins>	 <20101213171537.GC1691@nowhere> <1292260699.6803.305.camel@twins>	 <20101213172216.GB7417@ghostprotocols.net>	 <1292261716.6803.332.camel@twins> <1292262433.6803.351.camel@twins>	 <4D065CB2.7050104@cisco.com> <1292263024.6803.370.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-2.cisco.com ([171.71.176.71]:29223 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab0LMSBO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Dec 2010 13:01:14 -0500
In-Reply-To: <1292263024.6803.370.camel@twins>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org



On 12/13/10 10:57, Peter Zijlstra wrote:
>> What about creating a PERF_RECORD_TIME and generate an event when the
>> counter is opened? It contains a PERF_SAMPLE_TIME and say
>> PERF_SAMPLE_TOD (time-of-day)? We're not sending rockets to saturn; we
>> just need the timestamps to match other log files.
> 
> That's similar to the first thing I proposed. The problem is with long
> record sessions your drift can become quite significant, then when you
> merge sort your other log events stuff can get out of order. Which can
> lead to some serious head-scratching..

Gotcha. Missed that in the flury of emails.

Arnaldo: Are you ok with this option? This should append mode as well.

> 
> Another problem with this approach is things like flight-recorder mode
> where you constantly over-write your old data, you'd have to build some
> trigger to always output a new record before you over-write the old one,
> so there's always one consistent record around. Drift is an even more
> serious problem here since flight-record more could be running for days
> before (if ever) you dump it.

Ok. I was not aware flight-recorder mode was an option today.

David


> 
> 
