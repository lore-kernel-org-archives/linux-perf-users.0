From: Christopher Covington <cov@codeaurora.org>
Subject: Re: Some event modifiers missing from output and desire option to
 compute value based on measurements
Date: Fri, 21 Mar 2014 08:49:38 -0400
Message-ID: <532C3562.1010706@codeaurora.org>
References: <5321E3AC.8050600@redhat.com> <87siqmf1kc.fsf@tassilo.jf.intel.com> <5321FB46.5020003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:42290 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343AbaCUMtk (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 21 Mar 2014 08:49:40 -0400
In-Reply-To: <5321FB46.5020003@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

Hi Will,

On 03/13/2014 02:39 PM, William Cohen wrote:
> On 03/13/2014 01:30 PM, Andi Kleen wrote:
>> William Cohen <wcohen@redhat.com> writes:
>>
>>> When experimenting with perf I wanted to have separate counts for events in userspace and the kernel.  I used:
>>>
>>> $ perf stat   -e instructions:u -e instructions:k -e cycles:u -e cycles:k -e cache-misses:u -e cache-misses:k make
>>>
>>> The associated  output below includes the event modifiers for all the events, but the 3.06 and 0.37 insns per cycles look off.  Shouldn't that instructions:u/cycles:u and instructions:k/cycles:k be the values reported for "insns per cycle"?
>>
>> Yes the event match code currently assumes there's only a single event
>> each and always uses the last.
>>
>>> It appears that the output is listing the measurements in the same
>>> order they are specified on the command line, but it would be nice if
>>> the output was clearer on the events being measured.  If I am reading
>>> the output correctly, the L1-icache-load-misses per instruction is
>>> pretty poor for kernel-space.  Much of the time I am looking at ratios
>>> of events and it would be nice if "perf stat" had a way to have it
>>> compute the ratios directly. Maybe a "-m, --math" option allowing
>>> algebraic expressions where you could do:
> 
> Hi Andi,
> 
> So the missing event modifier is still a problem.  The events begins passed into the perf are not going to match the names on the output.  Also a script using the output perf is not going to be able to distinguish between the same event with different modifiers.
> 
>>
>> Most people just use -x, and load the result into a spread sheet or
>> other script that does the compuations. At some point you usually want
>> to plot the data or do other more complex manipulations than your
>> simple facility would provide.
>>
>> You may also find this script useful
>>
>> https://github.com/andikleen/pmu-tools/blob/master/interval-normalize.py
>>
>> -Andi
>>
> 
> Thanks for the pointer to the interval-normalize.py script.
> 
> Yes, many people are probably using other more sophisticated tools such as
> spread sheets to analyze the data from perf. However, something like a "-m,
> --math" option would give a bit more insight than the basic "perf stat"
> without having to resort to more sophisticated tools. "perf stat" is already
> generating all sorts of derived numbers such as IPC, events/second, and
> perccent of cache misses it seems like a small step to provide some
> flexibility for the user to specify exactly what to compute.

I don't know how useful a reference this is, but here's an out-of-tree
"periodic" command with math flag support.

https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.10/tree/tools/perf/builtin-periodic.c?h=LNX.LA.3.6_rb1.1&id=4235d779be748291ed2ec5581dd64e7d1a529297

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
