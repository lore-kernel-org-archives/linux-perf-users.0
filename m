From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH 3/6] perf script: move printing of 'common' data from
 print_event and rename
Date: Thu, 10 Mar 2011 09:45:44 -0700
Message-ID: <4D790038.502@cisco.com>
References: <1299734608-5223-1-git-send-email-daahern@cisco.com> <1299734608-5223-4-git-send-email-daahern@cisco.com> <20110310152053.GB12521@home.goodmis.org> <20110310155109.GB23555@ghostprotocols.net> <1299773135.15854.352.camel@gandalf.stny.rr.com> <20110310162038.GC23555@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ams-iport-2.cisco.com ([144.254.224.141]:34556 "EHLO
	ams-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab1CJQyz (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Mar 2011 11:54:55 -0500
In-Reply-To: <20110310162038.GC23555@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de



On 03/10/11 09:20, Arnaldo Carvalho de Melo wrote:
>>> I think the merge with the libraries you mention is something that is
>>> not a precondition to merging David's work.
>>>
>>> And his work is at least moving things in the trace parts of tools/,
>>> that was so far dormant.
>>
>> Note, I'm not saying that his work should be put on hold. I actually
>> want to start it up again. Maybe I worded this response wrong. It was
>> more about bringing David up to speed on what I want to do next than
>> saying not to do this work.
> 
> Right, I just wanted to make sure he doesn't spill his coffee with what
> could seem like yet another requirement to work on infrastructure to get
> his legitimate feature implementation merged :-)

I appreciate the clarification. Luckily, no coffee in hand.

I need to get the time-of-day strings done next, and someone else is
pushing the reverse callchain display (another local change I wanted to
get upstream). I could take a look at other requests - like common code
- as time allows.

David


> 
> - Arnaldo
