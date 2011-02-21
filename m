From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH 0/4] perf events: Add realtime clock event and timehist
 option -v2
Date: Mon, 21 Feb 2011 15:09:52 -0700
Message-ID: <4D62E2B0.1070607@cisco.com>
References: <1298322150-15505-1-git-send-email-daahern@cisco.com> <20110221213740.GC3583@nowhere> <4D62DC21.4070407@cisco.com> <20110221215533.GD3583@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-3.cisco.com ([171.71.176.72]:49959 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab1BUWJy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Feb 2011 17:09:54 -0500
In-Reply-To: <20110221215533.GD3583@nowhere>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, paulus@samba.org, tglx@linutronix.de



On 02/21/11 14:55, Frederic Weisbecker wrote:
> On Mon, Feb 21, 2011 at 02:41:53PM -0700, David Ahern wrote:
>>
>>
>> On 02/21/11 14:37, Frederic Weisbecker wrote:
>>
>>> The goal is actually to extend perf script to handle more than just raw data.
>>> So that it can handle the rest of what we can find in an event: time, ip, stacktraces...
>>>
>>> You've added 200 lines in perf report to add the dump support. It wouldn't
>>> require more to extend perf script to do that. And the result is going to be
>>> much more powerful.
>>>
>>> Look at struct scripting_ops::process_event().
>>
>> I actually have a draft of perf-script - essentially duplicating sample
>> processing done in perf-report. When it got to the point of having to
>> add a lot of code -- other features essentially -- just to get it to the
>> point of being ready for this feature I stopped.
> 
> 
> I don't understand why it's harder to extend print_event() rather than
> perf report.

All of the changes to perf-report are related strictly to this feature -
generating the timestamp and printing the sample including walking the
callchain.

perf-script needs to have features added to it:
  1. working with all samples,
  2. support for callchains,
  3. more?
Then it is ready for adding a timestring to the output.

Sure it can be done, but a series of patches unrelated to timehist are
needed first.

As part of looking at perf-script (the draft I mentioned) I actually
moved most of the perf-report changes into a util/timehist.c as it is
directly usable by both commands.

David
