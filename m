From: David Ahern <dsahern@gmail.com>
Subject: Re: Understanding timestamps in perf.data
Date: Wed, 2 Sep 2015 10:44:18 -0600
Message-ID: <55E72762.6030209@gmail.com>
References: <55E6C120.3030504@kit.edu> <55E6FCF9.60403@gmail.com>
 <55E71351.8010507@kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36423 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085AbbIBQoS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 2 Sep 2015 12:44:18 -0400
Received: by igcrk20 with SMTP id rk20so29424591igc.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Sep 2015 09:44:18 -0700 (PDT)
In-Reply-To: <55E71351.8010507@kit.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Dennis Gnad <dennis.gnad@kit.edu>, linux-perf-users@vger.kernel.org

On 9/2/15 9:18 AM, Dennis Gnad wrote:
> On 02.09.2015 15:43, David Ahern wrote:
>> On 9/2/15 3:28 AM, Dennis Gnad wrote:
>>> Hi,
>>>
>>> I am interested in timestamped performance counter data (with a
>>> specified sampling rate) as there is supposed to be saved in perf.data
>>> when I use "perf record -T".
>>>
>>> However, I don't understand the complete output of "perf report -D", and
>>> can't figure out which parts of it are the timestamps. Is there any
>>> documentation that I overlooked?
>>>
>>> Actually if it helps, I am only interested in the name/raw event, value,
>>> and timestamp, without any code/library information. Maybe the
>>> information on which CPU it is from (on a multicore) could be
>>> interesting as well.
>>>
>>> Do I need to start looking into the code? Any good place to start? I
>>> probably need to do this anyway, instead of parsing the really large
>>> perf report -D output.
>>>
>>
>> Use 'perf script' instead of 'perf report -D' to dump the samples.
>
> OK, I really overlooked this. Thank you!
>
> But now I am confused by that output. If I run for example:
>
> $ perf record -F 100 -T -e cycles,cache-misses ./my_code
>
> my understanding is, that at 100Hz, the values of the specified
> performance counters are read. But when I run:
>
> $ perf script -f time,event
> 2001301.016880: cycles:
> 2001301.016883: cycles:
> 2001301.016885: cycles:
> 2001301.016886: cache-misses:
> 2001301.016887: cache-misses:
> 2001301.016889: cache-misses:
> 2001301.016890: cycles:
> 2001301.016925: cache-misses:
> 2001301.017000: cycles:
> 2001301.031339: cycles:
> [..]
>
> I don't get the values of the events, only that they "happened", which
> isn't that helpful if it is only sampled at a certain frequency. I also
> tried other options, but don't seem to be able to get the actually
> sampled values of the counters.
>
> Any idea what am I missing? Much thanks in advance!

The counter values are not relevant for profiling. They are programmed 
to rollover and generate an NMI which causes the sample to be taken.

David
