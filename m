From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Link between Intel documentation events and perf list events
Date: Tue, 02 Jul 2013 15:33:18 +0200
Message-ID: <51D2D69E.9020207@gmail.com>
References: <51D1AA04.7060403@insa-lyon.fr> <8761wt62f8.fsf@tassilo.jf.intel.com> <51D286E0.2070500@insa-lyon.fr> <CAGz0_-3uWqVqPLwKvpiuveBJo1DT3B5TynK9ebdBZuw5ZGe3nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:36412 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985Ab3GBNdV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 2 Jul 2013 09:33:21 -0400
Received: by mail-ee0-f41.google.com with SMTP id d17so2745331eek.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jul 2013 06:33:20 -0700 (PDT)
In-Reply-To: <CAGz0_-3uWqVqPLwKvpiuveBJo1DT3B5TynK9ebdBZuw5ZGe3nQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andreas Hollmann <hollmann@in.tum.de>
Cc: Manuel Selva <manuel.selva@insa-lyon.fr>, Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

Thanks again for the help.Your answer suggests that events listed as 
Hardware event by perf listare what is called Architecural Events for 
Intel processors, isn't it ?

On my Sandy Bridge core i5-2520M, perf list reports 10 hardware events, 
where as they are only 7 entriesin the table 18-1 of Intel documentation 
you mentioned. So I am wondering what are these 3 additional events;

event=0x00,umask=0x03 (ref-cycles)
event=0xb1,umask=0x01,inv,cmask=0x01 (stalled-cycles-backend)
event=0x0e,umask=0x01,inv,cmask=0x01 (stalled-cycles-frontend)

Looking at table 19-7 in the same Intel document, I can see non 
architectural events for my core i5-2xxx. In this table I can see that:

ref-cycles                       ==> Can't find it
stalled-cycles-backend ==> Counts total number of uops to be dispatched 
per- thread each cycle. Set Cmask = 1, INV =1 to count stall cycles.
stalled-cycles-frontend ==> Increments each cycle the # of Uops issued 
by the RAT to RS.Set Cmask = 1, Inv = 1, Any= 1to count stalled cycles 
of this core.

So my question is what is ref-cycles andwhat is the common property of 
event displayed as Hardware Event by perf ?

Manu

On 07/02/2013 02:39 PM, Andreas Hollmann wrote:
> Hi,
>
> since Kernel version 3.7 you can lookup the used raw event in
> /sys/device/cpu/events and compare it
> to Table 18-1 SDM Volume 3B: System Programming Guide, Part 2.
>
> $ cd /sys/devices/cpu/events/
> $ echo *; cat *
> branch-instructions branch-misses cache-misses cache-references
> cpu-cycles instructions
> event=0xc4
> event=0xc5
> event=0x2e,umask=0x41
> event=0x2e,umask=0x4f
> event=0x3c
> event=0xc0
>
> Here is commit from Jiri Olsa that makes it possible.
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=a47473939db20e3961b200eb00acf5fcf084d755
>
> Regards,
> Andreas
>
>
>
> 2013/7/2 Manuel Selva <manuel.selva@insa-lyon.fr>:
>> Thanks for the answer Andi.
>>
>> On a more general sense, how one can link perf events (as reported by perf
>> list) to hardware documentation ? Is there some document explaining that or
>> should I dig into the perf code source code in the Linux kernel ?
>>
>> Manu
>>
>>
>> On 07/02/2013 05:55 AM, Andi Kleen wrote:
>>> Manuel Selva<manuel.selva@insa-lyon.fr>  writes:
>>>
>>>> My question is about the link between events reported in Intel
>>>> documentation and events listed by perf list. Is the perf list
>>>> cache-misses event the same than the one mentioned as Last-level cache
>>>> missesin Intel documentation ?
>>> Yes it is
>>>
>>> (at least currently, perf events are not particularly well defined
>>> and have changed in the past. However this one is proably not likely
>>> to change)
>>>
>>> -Andi
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-perf-users"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
