From: David Ahern <dsahern@gmail.com>
Subject: Re: timing information with perf
Date: Thu, 12 Nov 2015 16:19:39 -0700
Message-ID: <56451E8B.7020504@gmail.com>
References: <94D0C06D-C3A7-4BD1-9898-124EE0AA923D@netapp.com>
 <20151112215728.GD7160@kernel.org> <20151112220417.GE7160@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:33298 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932557AbbKLXTl (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Nov 2015 18:19:41 -0500
Received: by iouu10 with SMTP id u10so73907031iou.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2015 15:19:40 -0800 (PST)
In-Reply-To: <20151112220417.GE7160@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
Cc: linux-perf-users@vger.kernel.org

On 11/12/15 3:04 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 12, 2015 at 06:57:28PM -0300, Arnaldo Carvalho de Melo es=
creveu:
>> Em Thu, Nov 12, 2015 at 09:07:20PM +0000, Kornievskaia, Olga escreve=
u:
>
>>> Can somebody tell me if perf can do =E2=80=9Ctiming-of-operation=E2=
=80=9D type of
>>> measurement? By that I mean, say there are two tracepoints
>>> =E2=80=9Cfoobar_enter=E2=80=9D and =E2=80=9Cfoobar_exit=E2=80=9D. E=
ach tracepoint logs a timestamp.
>>> I=E2=80=99d like to be able to say that on average it takes that ma=
ny
>>> time-units between =E2=80=9Center=E2=80=9D and =E2=80=9Cexit=E2=80=9D=
 tracepoints. I haven=E2=80=99t been
>>> able to find something like that with =E2=80=9Cperf=E2=80=9D.
>
>> Well, you can do:
>>
>>    # perf record -a -e sched:*waking*,sched:*wakeup* sleep 2
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 0.199 MB perf.data (156 samples=
) ]
>>    # perf script -g python
>>    generated Python script: perf-script.py
>>    # grep '^def ' perf-script.py
>>    def trace_begin():
>>    def trace_end():
>>    def sched__sched_wakeup_new(event_name, context, common_cpu,
>>    def sched__sched_wakeup(event_name, context, common_cpu,
>>    def sched__sched_waking(event_name, context, common_cpu,
>>    def trace_unhandled(event_name, context, event_fields_dict):
>>    def print_header(event_name, cpu, secs, nsecs, pid, comm):
>>    #
>>
>> The prototype for sched__sched_wakeup(), for instance is:
>>
>> def sched__sched_wakeup(event_name, context, common_cpu,
>>          common_secs, common_nsecs, common_pid, common_comm,
>>          common_callchain, comm, pid, prio, success,
>>          target_cpu):
>>
>> Then do some minimal coding for what you want, because you need
>> to match it using some key, i.e. same pid is enough for some cases, =
for
>> others you need pid + fd, etc.
>
> If you do not change that script, then running it will produce:
>
>    # perf script -s perf-script.p
>    in trace_begin
>    sched__sched_waking 2 09156.170326579 16181 perf comm=3Dperf, pid=3D=
16182, prio=3D120, success=3D1, target_cpu=3D3
>    sched__sched_wakeup 2 09156.170329797 16181 perf comm=3Dperf, pid=3D=
16182, prio=3D120, success=3D1, target_cpu=3D3
>    sched__sched_waking 3 09156.170446653 16182 perf comm=3Dmigration/=
3, pid=3D28, prio=3D0, success=3D1, target_cpu=3D3
> <SNIP>
>    in trace_end

I think he wants to average the time difference between 2 tracepoints.=20
You should be able to run the output of perf script through an awk=20
script to get it.
