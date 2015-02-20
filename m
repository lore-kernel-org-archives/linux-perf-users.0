From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: Weird instruction profiling
Date: Fri, 20 Feb 2015 11:04:59 -0800
Message-ID: <CAE40pddr1g8Rukr97n+CPH13FAy6atzYvhOW7pcftJV_L2sZVg@mail.gmail.com>
References: <CAE40pddnqg-H-YqvyHodw1ME6W9_7et151+=O9y=S7sHB0an7w@mail.gmail.com>
 <87zj8bvzqn.fsf@tassilo.jf.intel.com> <54E5214B.5060408@gmail.com>
 <20150218233836.GB823@two.firstfloor.org> <54E52451.4030303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:46796 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172AbbBTTFU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 20 Feb 2015 14:05:20 -0500
Received: by iecvy18 with SMTP id vy18so10037917iec.13
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Feb 2015 11:05:19 -0800 (PST)
In-Reply-To: <54E52451.4030303@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Wed, Feb 18, 2015 at 3:46 PM, David Ahern <dsahern@gmail.com> wrote:
> On 2/18/15 4:38 PM, Andi Kleen wrote:
>>
>> On Wed, Feb 18, 2015 at 04:33:31PM -0700, David Ahern wrote:
>>>
>>> On 2/18/15 11:30 AM, Andi Kleen wrote:
>>>
>>>>> I think Andi mentioned this to me last year -- that instruction
>>>>> profiling was no longer reliable.
>>>>
>>>>
>>>> It never was.
>>>
>>>
>>> Why is that? What about profiling with other hardware counters?
>>
>>
>> Practically all profiling has skid of some form.
>
>
> ok, so you meant that only in the context of skid meaning the hit
> instruction is off a few (ie., squint backwards at the annotate output).
>

Thanks Andi and David,

There's skid, but I was noticing what I thought was a different
artifact in the profile: where only every 4th instruction is seen.
Wouldn't this effect be more due to the IP pointing to the next
instruction while a group of 4 are executed in parallel? Then there's
skid on top of that....

Brendan
