From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: how to get a kernel callgraph starting from a syscall
Date: Sat, 23 Apr 2011 09:40:26 +0100
Message-ID: <BANLkTik0BPo4Tyo+RxLyKYFiEtr8QVhUHQ@mail.gmail.com>
References: <BANLkTikNDX4hYpLjgDnPx8SXFvsv8Syr9g@mail.gmail.com>
	<4DB04BF3.8080206@gmail.com>
	<BANLkTinvMLaL8vdDWiG5fDEEAXUNBsyrBQ@mail.gmail.com>
	<4DB08A5B.3060706@gmail.com>
	<BANLkTimZA6YA07d8hNKuxhoySvHpTmWjvw@mail.gmail.com>
	<4DB0D00F.3040706@gmail.com>
	<BANLkTinpcbuR7AKN9UWzU+cbA0Q3zjmh0w@mail.gmail.com>
	<BANLkTi=fyDoGY4XDuDZu9qSWVTU7rGYW3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45234 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614Ab1DWIk2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 23 Apr 2011 04:40:28 -0400
Received: by ywj3 with SMTP id 3so290963ywj.19
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Apr 2011 01:40:28 -0700 (PDT)
In-Reply-To: <BANLkTi=fyDoGY4XDuDZu9qSWVTU7rGYW3w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org

On Fri, Apr 22, 2011 at 12:46 PM, Francis Moreau <francis.moro@gmail.co=
m> wrote:
> On Fri, Apr 22, 2011 at 7:29 AM, Francis Moreau <francis.moro@gmail.c=
om> wrote:
>> On Fri, Apr 22, 2011 at 2:47 AM, David Ahern <dsahern@gmail.com> wro=
te:
>>> On 04/21/11 14:07, Francis Moreau wrote:
>>>> On Thu, Apr 21, 2011 at 9:49 PM, David Ahern <dsahern@gmail.com> w=
rote:
>>>>>
>>>>> You want the individual samples? if so, perf script dumps them an=
d you
>>>>> can see the callchain for each sys_read.
>>>>>
>>>>
>>>> hmm, I don't see what you mean by individual samples.
>>>>
>>>> I don't think sampling can help in my case (tracing the callchain =
of
>>>> one syscall).
>>>>
>>>> Could you give me an example of what you have in mind ?
>>>>
>>>> Thanks
>>>
>>> I think I get it now. 'perf record' for syscall event stops at sys_=
read
>>> as that is the point the event is generated. You want where the ker=
nel
>>> goes starting with sys_read. In that case you are limited to the
>>> pre-existing tracepoints (see 'perf list -e tracepoints') to trigge=
r an
>>> event and back trace, or if the read causes the processes to block =
you
>>> can you use the context-switch event or sched_switch trace point.
>>>
>>> You could also insert probe points using perf probe. Lin Ming poste=
d an
>>> example of this a couple of weeks ago:
>>> # ./perf probe -k ~/vmlinux -s ~/linux-2.6/ =A0find_get_page
>>> # ./perf record -e probe:find_get_page -f -g -a
>>>
>>
>> Thanks for you answer.
>>
>> I think I'll use probe.
>
>
> Thinking more about it, I think that both solution (probe or
> tracepoint) are not adapted.
>
> Because I'm interested in discovering the path taken by the kernel
> from a given syscall, therefore I don't know this path. However both
> solution imply that the path is known since you need to insert some
> 'probes' in this path to see it...

You can use "Dynamic ftrace with the function graph tracer"
(set_graph_function):
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
blob;f=3DDocumentation/trace/ftrace.txt;hb=3DHEAD#l1664

I don't know of way to do this using perf(1).

Stefan
