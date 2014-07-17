From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: kprobe string
Date: Thu, 17 Jul 2014 01:23:15 -0700
Message-ID: <CAE40pdfdrUOdkrV6WWZ-0PjwzVoWYo3cSe3SysKwN+PtVtV45w@mail.gmail.com>
References: <CAE40pdfJpksb-LJghF+w4XZBagKo7wg6fh3irGPha5F9Uknb=A@mail.gmail.com>
	<53C753DE.6080306@gmail.com>
	<CAE40pdefmx7trDyWnix1tPXNQBeO-cE8-6-p68tojuXry-LGXQ@mail.gmail.com>
	<8761iw30sv.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:58921 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754743AbaGQIXQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 17 Jul 2014 04:23:16 -0400
Received: by mail-qc0-f172.google.com with SMTP id l6so1823035qcy.3
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2014 01:23:15 -0700 (PDT)
In-Reply-To: <8761iw30sv.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: David Ahern <dsahern@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

G'Day Namhyung,

On Thu, Jul 17, 2014 at 12:24 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> Hi Brendan,
>
> On Wed, 16 Jul 2014 23:29:10 -0700, Brendan Gregg wrote:
>> G'Day David,
>>
>> On Wed, Jul 16, 2014 at 9:41 PM, David Ahern <dsahern@gmail.com> wrote:
>>>
>>>
>>> On 07/16/2014 06:51 PM, Brendan Gregg wrote:
>>>>
>>>> G'Day,
>>>>
>>>> I'm not sure where else to ask this; I don't think this functionality
>>>> is in perf_events yet...
>>>>
>>>> kprobes is supposed to be able to handle string arguments, but I've
>>>> not been able to find a single working example. I'm trying (on 3.16):
>>>>
[...]
>> Ok, so that's one solution! :-)
>>
>> It does need debuginfo, which is a bit of a problem here (the Netflix
>> cloud, where instances are created and destroyed quickly, so they are
>> optimized to be small).
>>
>> I did try just using the return value, which does work without
>> debuginfo, however, the :string modifier doesn't work. Eg, trying:
>>
>> # perf probe 'getname%return $retval:string'
>> Added new event:
>> Failed to write event: Invalid argument
>>   Error: Failed to add events. (-1)
>>
>>  $retval really is a string (well, it's a struct filename *, where the
>> first member is a char *, so close enough), so perhaps perf could
>> enhanced to allow this, and I'd be able to trace strings without
>> debuginfo.  (Unless there's another workaround.)
>>
>> So tools/perf/Documentation/perf-probe.txt does at least explain when
>> :string won't work: "You can specify 'string' type only for the local
>> variable or structure member which is an array of or a pointer to
>> 'char' or 'unsigned char' type." I wonder if kprobes has this
>> restriction as well.
>
> Currently, "retval" and "reg" (and some other) fetch methods don't support string
> type.  But I guess it can be easily worked around by using "deref" method.
> Have you tried something like below (untested)?
>
>   # perf probe 'getname%return +0($retval):string'
>
> Hmm.. maybe below (as you mentioned it's a char * in struct filename *).
>
>   # perf probe 'getname%return +0(+0($retval)):string'
>

Excellent, thanks!

And this is also working syntax for kprobes!

Here's 3.2, when getname() returned a char *:

# echo 'r:myprobe getname +0($retval):string' > kprobe_events
# echo 1 > events/kprobes/enable
# tail trace
        postgres-2421  [000] 1507756.012578: myprobe:
(do_sys_open+0xc3/0x240 <- getname) arg1="global/pg_filenode.map"
        postgres-2421  [000] 1507756.012629: myprobe:
(do_sys_open+0xc3/0x240 <- getname) arg1="global/pg_internal.init"
        postgres-2421  [000] 1507756.013443: myprobe:
(do_sys_open+0xc3/0x240 <- getname) arg1="base/16384/PG_VERSION"
        postgres-2421  [000] 1507756.013507: myprobe:
(do_sys_open+0xc3/0x240 <- getname) arg1="base/16384/pg_filenode.map"
[...]
# echo 0 > events/kprobes/enable

And 3.16, where getname() is the struct filename *:

# echo 'r:myprobe getname +0(+0($retval)):string' > kprobe_events
# echo 1 > events/kprobes/myprobe/enable
# tail trace
       supervise-1684  [001] d... 6157863.184014: myprobe:
(user_path_parent+0x2e/0x80 <- getname) arg1="supervise/status.new"
       supervise-1684  [001] d... 6157863.184016: myprobe:
(user_path_parent+0x2e/0x80 <- getname) arg1="supervise/status"
       supervise-1694  [000] d... 6157863.184016: myprobe:
(user_path_parent+0x2e/0x80 <- getname) arg1="supervise/status"
       supervise-16964 [001] d... 6157863.184242: myprobe:
(SyS_execve+0x20/0x40 <- getname) arg1="./run"
[...]
# echo 0 > events/kprobes/myprobe/enable

Wow... So now I know perf can do this, and, I have working examples of
kprobes via ftrace if needed (I am trying to use perf first, due to
the way it buffers, error handling, and concurrent usage).

Thanks!

Brendan

-- 
http://www.brendangregg.com
