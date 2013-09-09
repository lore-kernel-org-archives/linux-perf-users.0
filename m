From: David Ahern <dsahern@gmail.com>
Subject: Re: perf cannot see call graph, visible in gdb
Date: Mon, 09 Sep 2013 07:05:25 -0700
Message-ID: <522DD5A5.70500@gmail.com>
References: <1309051629550.29229@wes.ijneb.com> <87ioydhgs1.fsf@tassilo.jf.intel.com> <1309091326270.22075@wes.ijneb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:46486 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605Ab3IIOFb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 Sep 2013 10:05:31 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp13so6246821pab.7
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Sep 2013 07:05:31 -0700 (PDT)
In-Reply-To: <1309091326270.22075@wes.ijneb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mark Hills <mark@pogo.org.uk>, Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

Adding Jiri.

On 9/9/13 5:59 AM, Mark Hills wrote:
> On Fri, 6 Sep 2013, Andi Kleen wrote:
>
>> Mark Hills <mark@pogo.org.uk> writes:
>>
>>> I have a pre-compiled .so library, which was given to me for profiling.
>>>
>>> gdb can see a complete call stack -- both the library and my own code,
>>> as expected.
>>>
>>> But in perf the callgraph for the library is not present. I'm using
>>> "perf record -g", and the callgraph for the other code is seen.
>>>
>>> In what cases could gdb see the stack, but perf cannot?
>>
>> No frame pointer.
>>
>> Recompile with -fno-omit-frame-pointer
>>
>> Or if you have a new enough perf, you can use -g dwarf to enable
>> dwarf backtracing, but it's very slow and also doesn't handle all
>> situations gdb handles.
>
> Thank you, much appreciated.
>
> A newer perf appears to need a newer kernel too, and it's not practical
> for me to break away from the RedHat kernel at the moment (currently on
> 2.6.32-358.14.1.el6)

Any updates to RHEL6 for dwarf callchains?

David

>
> Also I looked to cherry-pick the relevant patches, but it seems this is
> non-trivial.
>
> I'll speak to the author of the library in question but may have to
> re-visit the dwarf behaviour; omit-frame-pointer may have been used with
> performance in mind.
>
> Thanks
>
