From: David Ahern <dsahern@gmail.com>
Subject: Re: How do the software events work in perf?
Date: Mon, 22 Jul 2013 18:09:16 -0600
Message-ID: <51EDC9AC.40002@gmail.com>
References: <CAEuYUeofoxasfFS+_oXggXEK5jDKz5S-z0_8Nt6r3bf+J7yE_w@mail.gmail.com> <CAFTL4hz1u3dvAJZmSLGg6C9p9A=+dxYZ6JUYwVPbOB3_uEiu6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:53213 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3GWAJT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 22 Jul 2013 20:09:19 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so7425623pde.37
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2013 17:09:19 -0700 (PDT)
In-Reply-To: <CAFTL4hz1u3dvAJZmSLGg6C9p9A=+dxYZ6JUYwVPbOB3_uEiu6g@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>, Peipei Wang <wangpeipei.90@gmail.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

On 7/22/13 5:51 PM, Frederic Weisbecker wrote:
> 2013/7/23 Peipei Wang <wangpeipei.90@gmail.com>:
>> Hi guys,
>> I am curious about how perf get the software events. While hardware
>> events are defined and can be found in architecture manuals, I don't
>> get any information or documentation about how perf get the software
>> events, or how they are collected.
>>
>> Thanks for your help.
>
> Hi,
>
> They are implemented using tracepoints. To summarize, tracepoints are callbacks
> that are called on any interesting point in the code.

Besides tracepoints there a few software events -- cpu-clock, 
task-clock, context-switches, page faults, cpu migrations, etc.

David

>
> For example in the context switch path we have a function call
> trace_sched_context_switch() that in turn calls a callback that then
> rely into the perf events susbsystem to record the event in the
> buffer.
>
> In practice it is a bit more complicated, there is a layer in the
> middle with the trace events subsystem.
>
> For more details on tracepoints: Documentation/tracepoints.txt and
> Documentation/events.txt
>
> But really, this is just about function calls that we put when we find
> some interesting code to trace. Like a very enhanced printk() :)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
