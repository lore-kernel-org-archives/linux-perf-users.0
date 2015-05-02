From: Chris Freehill <cfreehill@utexas.edu>
Subject: Re: perf uncore behavior
Date: Fri, 1 May 2015 21:31:58 -0500
Message-ID: <CANFySvcwE52VTqPKc5vzkQkq+wAenFr=deaGX8ZxGQFTU1SjVg@mail.gmail.com>
References: <CANFySvewjJTo7Cezq3e1SPAFFmRRRWADTJ50T5rubvcLrAV2xA@mail.gmail.com>
	<87618blpsr.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:35019 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbbEBCb7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 1 May 2015 22:31:59 -0400
Received: by wgyo15 with SMTP id o15so104416072wgy.2
        for <linux-perf-users@vger.kernel.org>; Fri, 01 May 2015 19:31:58 -0700 (PDT)
In-Reply-To: <87618blpsr.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

Thanks Andi.

A follow up...can  you define what  "sockets/nodes" means in this
context? What is the relationship between sockets/nodes and CPU's.
What is the distinction? For core events, they would be the same,
right? Could you give an example of what "-a" would sum up when we are
talking about uncore events?

I think my main confusion is an assumption (up to now, anyway) that
there is only one set of uncore events, for the multicore device, so
it wouldn't make sense to sum up anything. For core events, my
understanding is that with no "-C<core id>" specified, perf sums up
the core event counts and presents this as output. For uncore, the
events are not per-core, so I'm not sure how to interpret that "sum".

Chris

On Fri, May 1, 2015 at 8:40 PM, Andi Kleen <andi@firstfloor.org> wrote:
> Chris Freehill <cfreehill@utexas.edu> writes:
>>
>> Here are some examples:
>>
>> 1. $ perf stat -a -e "uncore_cbox_0/clockticks/" sleep 1
>>
>> 2. $ perf stat  -e "uncore_cbox_0/clockticks/" sleep 1
>>
>> 3. $ perf stat -a -C0 -e "uncore_cbox_0/clockticks/" sleep 1
>>
>> It appears #2 is not supported. If it was supported, I would take it
>> to mean the number of uncore events counted while the process was
>> active, regardless of which processor it was running on. Right?  Is
>> there any reason it's not implemented (for example it's nonsensical)
>> or it just has been tackled yet?
>
> It's non sensical.  Uncore does not support per process measurements.
>
>> Are 1 and 3 effectively the same, since uncore events are not specific
>> to a core? I would think they would be the same. If not, what is the
>> difference?
>
> 1. will sum up events from all sockets/nodes.
> 3. will only print from the socket/node associated with CPU 0.
>
> -andi
>
> --
> ak@linux.intel.com -- Speaking for myself only
