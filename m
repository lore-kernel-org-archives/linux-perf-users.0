From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: how to get a kernel callgraph starting from a syscall
Date: Fri, 22 Apr 2011 13:46:49 +0200
Message-ID: <BANLkTi=fyDoGY4XDuDZu9qSWVTU7rGYW3w@mail.gmail.com>
References: <BANLkTikNDX4hYpLjgDnPx8SXFvsv8Syr9g@mail.gmail.com>
	<4DB04BF3.8080206@gmail.com>
	<BANLkTinvMLaL8vdDWiG5fDEEAXUNBsyrBQ@mail.gmail.com>
	<4DB08A5B.3060706@gmail.com>
	<BANLkTimZA6YA07d8hNKuxhoySvHpTmWjvw@mail.gmail.com>
	<4DB0D00F.3040706@gmail.com>
	<BANLkTinpcbuR7AKN9UWzU+cbA0Q3zjmh0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33703 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab1DVLqt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 22 Apr 2011 07:46:49 -0400
Received: by pzk9 with SMTP id 9so295077pzk.19
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Apr 2011 04:46:49 -0700 (PDT)
In-Reply-To: <BANLkTinpcbuR7AKN9UWzU+cbA0Q3zjmh0w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Fri, Apr 22, 2011 at 7:29 AM, Francis Moreau <francis.moro@gmail.com=
> wrote:
> On Fri, Apr 22, 2011 at 2:47 AM, David Ahern <dsahern@gmail.com> wrot=
e:
>> On 04/21/11 14:07, Francis Moreau wrote:
>>> On Thu, Apr 21, 2011 at 9:49 PM, David Ahern <dsahern@gmail.com> wr=
ote:
>>>>
>>>> You want the individual samples? if so, perf script dumps them and=
 you
>>>> can see the callchain for each sys_read.
>>>>
>>>
>>> hmm, I don't see what you mean by individual samples.
>>>
>>> I don't think sampling can help in my case (tracing the callchain o=
f
>>> one syscall).
>>>
>>> Could you give me an example of what you have in mind ?
>>>
>>> Thanks
>>
>> I think I get it now. 'perf record' for syscall event stops at sys_r=
ead
>> as that is the point the event is generated. You want where the kern=
el
>> goes starting with sys_read. In that case you are limited to the
>> pre-existing tracepoints (see 'perf list -e tracepoints') to trigger=
 an
>> event and back trace, or if the read causes the processes to block y=
ou
>> can you use the context-switch event or sched_switch trace point.
>>
>> You could also insert probe points using perf probe. Lin Ming posted=
 an
>> example of this a couple of weeks ago:
>> # ./perf probe -k ~/vmlinux -s ~/linux-2.6/ =A0find_get_page
>> # ./perf record -e probe:find_get_page -f -g -a
>>
>
> Thanks for you answer.
>
> I think I'll use probe.


Thinking more about it, I think that both solution (probe or
tracepoint) are not adapted.

Because I'm interested in discovering the path taken by the kernel
from a given syscall, therefore I don't know this path. However both
solution imply that the path is known since you need to insert some
'probes' in this path to see it...

--=20
=46rancis
