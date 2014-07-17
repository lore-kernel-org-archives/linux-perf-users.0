From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: kprobe string
Date: Thu, 17 Jul 2014 16:24:32 +0900
Message-ID: <8761iw30sv.fsf@sejong.aot.lge.com>
References: <CAE40pdfJpksb-LJghF+w4XZBagKo7wg6fh3irGPha5F9Uknb=A@mail.gmail.com>
	<53C753DE.6080306@gmail.com>
	<CAE40pdefmx7trDyWnix1tPXNQBeO-cE8-6-p68tojuXry-LGXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:59359 "EHLO
	lgemrelse7q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbaGQHYe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 17 Jul 2014 03:24:34 -0400
In-Reply-To: <CAE40pdefmx7trDyWnix1tPXNQBeO-cE8-6-p68tojuXry-LGXQ@mail.gmail.com>
	(Brendan Gregg's message of "Wed, 16 Jul 2014 23:29:10 -0700")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Ahern <dsahern@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

Hi Brendan,

On Wed, 16 Jul 2014 23:29:10 -0700, Brendan Gregg wrote:
> G'Day David,
>
> On Wed, Jul 16, 2014 at 9:41 PM, David Ahern <dsahern@gmail.com> wrote:
>>
>>
>> On 07/16/2014 06:51 PM, Brendan Gregg wrote:
>>>
>>> G'Day,
>>>
>>> I'm not sure where else to ask this; I don't think this functionality
>>> is in perf_events yet...
>>>
>>> kprobes is supposed to be able to handle string arguments, but I've
>>> not been able to find a single working example. I'm trying (on 3.16):
>>>
>>> # cd /sys/kernel/debug/tracing
>>> # echo 'r:getname getname $retval:string' > kprobe_events
>>> -bash: echo: write error: Invalid argument
>>> # echo 'p:myprobe do_sys_open %dx:string' > kprobe_events
>>> -bash: echo: write error: Invalid argument
>>>
>>> I'm following the syntax in Documentation/trace/kprobetrace.txt by
>>> Masami Hiramatsu, and it is recognizing "string". But I'm getting
>>> these errors:
>>>
>>> # dmesg | tail -4
>>> [98021.813560] string type has no corresponding fetch method.
>>> [98021.813564] Parse error at argument[0]. (-22)
>>> [98705.956199] string type has no corresponding fetch method.
>>> [98705.956203] Parse error at argument[0]. (-22)
>>>
>>> Anyone seen this work? I'm checking the source... Thanks in advance,
>>
>>
>> Have you seen this:
>> https://lkml.org/lkml/2014/6/19/698
>>
>
> Thanks! (I'm trying to keep up with all the perf messages on lkml, but
> missed this.)
>
> So, perf can already do this?? And it's the same syntax (":string") as kprobes?
>
> I just tried it out (on 3.14.5):
>
> # perf probe 'getname filename:string'
> Added new event:
> [...]
> # perf record -e probe:getname -a sleep 5
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.234 MB perf.data (~10241 samples) ]
> # perf script
>             perf 13587 [000] 3576718.127120: probe:getname:
> (ffffffff811bbd20)
> filename_string="/home/bgregg-testtest/libexec/perf-core/sleep"
>             perf 13587 [000] 3576718.127142: probe:getname:
> (ffffffff811bbd20) filename_string="/usr/local/sbin/sleep"
>             perf 13587 [000] 3576718.127151: probe:getname:
> (ffffffff811bbd20) filename_string="/usr/local/bin/sleep"
>             perf 13587 [000] 3576718.127159: probe:getname:
> (ffffffff811bbd20) filename_string="/usr/sbin/sleep"
>             perf 13587 [000] 3576718.127170: probe:getname:
> (ffffffff811bbd20) filename_string="/usr/bin/sleep"
>             perf 13587 [000] 3576718.127180: probe:getname:
> (ffffffff811bbd20) filename_string="/sbin/sleep"
>             perf 13587 [000] 3576718.127189: probe:getname:
> (ffffffff811bbd20) filename_string="/bin/sleep"
>            sleep 13587 [000] 3576718.162025: probe:getname:
> (ffffffff811bbd20) filename_string="/etc/ld.so.cache"
>            sleep 13587 [000] 3576718.162057: probe:getname:
> (ffffffff811bbd20) filename_string="/lib/x86_64-linux-gnu/libc.so.6"
> [...]
>
> Wow.
>
> Ok, so that's one solution! :-)
>
> It does need debuginfo, which is a bit of a problem here (the Netflix
> cloud, where instances are created and destroyed quickly, so they are
> optimized to be small).
>
> I did try just using the return value, which does work without
> debuginfo, however, the :string modifier doesn't work. Eg, trying:
>
> # perf probe 'getname%return $retval:string'
> Added new event:
> Failed to write event: Invalid argument
>   Error: Failed to add events. (-1)
>
>  $retval really is a string (well, it's a struct filename *, where the
> first member is a char *, so close enough), so perhaps perf could
> enhanced to allow this, and I'd be able to trace strings without
> debuginfo.  (Unless there's another workaround.)
>
> So tools/perf/Documentation/perf-probe.txt does at least explain when
> :string won't work: "You can specify 'string' type only for the local
> variable or structure member which is an array of or a pointer to
> 'char' or 'unsigned char' type." I wonder if kprobes has this
> restriction as well.

Currently, "retval" and "reg" (and some other) fetch methods don't support string
type.  But I guess it can be easily worked around by using "deref" method.
Have you tried something like below (untested)?

  # perf probe 'getname%return +0($retval):string'

Hmm.. maybe below (as you mentioned it's a char * in struct filename *).

  # perf probe 'getname%return +0(+0($retval)):string'


Thanks,
Namhyung
