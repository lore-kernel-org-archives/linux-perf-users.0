From: David Ahern <dsahern@gmail.com>
Subject: Re: Weird instruction profiling
Date: Wed, 18 Feb 2015 16:46:25 -0700
Message-ID: <54E52451.4030303@gmail.com>
References: <CAE40pddnqg-H-YqvyHodw1ME6W9_7et151+=O9y=S7sHB0an7w@mail.gmail.com> <87zj8bvzqn.fsf@tassilo.jf.intel.com> <54E5214B.5060408@gmail.com> <20150218233836.GB823@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:41848 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbbBRXq0 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 18 Feb 2015 18:46:26 -0500
Received: by iecrd18 with SMTP id rd18so5478412iec.8
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Feb 2015 15:46:25 -0800 (PST)
In-Reply-To: <20150218233836.GB823@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On 2/18/15 4:38 PM, Andi Kleen wrote:
> On Wed, Feb 18, 2015 at 04:33:31PM -0700, David Ahern wrote:
>> On 2/18/15 11:30 AM, Andi Kleen wrote:
>>
>>>> I think Andi mentioned this to me last year -- that instruction
>>>> profiling was no longer reliable.
>>>
>>> It never was.
>>
>> Why is that? What about profiling with other hardware counters?
>
> Practically all profiling has skid of some form.

ok, so you meant that only in the context of skid meaning the hit 
instruction is off a few (ie., squint backwards at the annotate output).

David
