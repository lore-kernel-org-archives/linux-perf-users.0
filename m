From: David Ahern <dsahern@gmail.com>
Subject: Re: Using a new perf tool against an older kernel
Date: Thu, 23 Jun 2011 23:07:31 -0600
Message-ID: <4E041B93.9030302@gmail.com>
References: <4E026123.4060208@fb.com> <4E034C2C.30509@gmail.com> <4E03968A.5010008@fb.com> <20110624001100.GD8058@somewhere.redhat.com> <4E03DDB0.3050502@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61256 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab1FXFHg (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 24 Jun 2011 01:07:36 -0400
In-Reply-To: <4E03DDB0.3050502@fb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org



On 06/23/2011 06:43 PM, Arun Sharma wrote:
> On 6/23/11 5:11 PM, Frederic Weisbecker wrote:
> 
>>
>> I'm confused, you first said it happens with new tools on older kernel.
>>
>> Can you tell us which combination of kernel/user raises the error? and
>> which error.
>>

I tried to repeat your examples below using perf-core tip (3.0-rc3,
af07ce3e77).

> 
> perf-3.0 + 2.6.38
> 
> perf record -agR gives:
> 
> Can't find id 9's machine
> Found 1 unknown events!

This does not reproduce on 2.6.38.8-32.fc15.x86_64 running bare metal or
2.6.38 in a VM. If you are running bare metal try -e cpu-clock and see
if it is cycles related. I doubt it, but that should be the only
difference in the tests.

That said, I did see that message while working on the gettimeofday
patches a few weeks ago. I believe the root cause was the early mixture
of cycles and tracepoints -- something I fixed before sending out the
patches (sample_type hack as well as how the time-of-day trace events
were added to the event list).

> 
> perf-3.0 + 2.6.32
> 
> perf record -ag
> perf script
> 
> samples have bogus timestamps

I'm surprised by this one. I tried with an older Fedora 12 VM (2.6.32.21
kernel). I don't get timestamps with perf-script and perf-report -D
shows -1 which is what I expect given that SAMPLE_TIME attribute is not
set by default. One difference here is that VM's default to cpu-clock
for the event.

> 
> perf-3.0 + 2.6.32
> 
> perf record -agR
> perf script
> 
> error: Samples do not contain timestamps

And this one did not work out so well with the F-12 VM. It caused a
kernel panic - top line on console is perf_swevent_hrtimer (lines
scrolled off the top).

> 
> perf-3.0 + any kernel
> 
> perf record -agT
> perf script
> 
> is happy everywhere. Thanks!

Which is what I would expect. Glad to see my version of reality apply
elsewhere. ;-)

David

> 
>  -Arun
> 
