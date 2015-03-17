From: Stephane Eranian <eranian@google.com>
Subject: Re: Why the need to do a perf_event_open syscall for each cpu on the system?
Date: Mon, 16 Mar 2015 20:51:01 -0400
Message-ID: <CABPqkBRrQJn2BaQAWVwPOEVOqPr2+tQ82raX2xh9iLbWRvrnyg@mail.gmail.com>
References: <55033138.5010500@redhat.com>
	<CAL2Y34DEW+HvF6tsFH5qg-RxkAmstEcK=qYhkcRV6D8DCFG3kg@mail.gmail.com>
	<5506ECFA.40305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34820 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099AbbCQAvC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 16 Mar 2015 20:51:02 -0400
Received: by obfv9 with SMTP id v9so48694751obf.2
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2015 17:51:01 -0700 (PDT)
In-Reply-To: <5506ECFA.40305@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: Elazar Leibovich <elazar.leibovich@ravellosystems.com>, linux-perf-users@vger.kernel.org

On Mon, Mar 16, 2015 at 10:47 AM, William Cohen <wcohen@redhat.com> wrote:
> On 03/15/2015 01:15 AM, Elazar Leibovich wrote:
>> Hi,
>>
>> Not an expert, but my understanding is that it's just technical
>> difficulty. Performance metrics are being saved in per-cpu buffer.
>> Having pid==-1 and cpu==-1 means that something would aggregate all
>> buffers in multiple CPUs to a single buffer. That code must exist,
>> either in userspace or in the kernel.
>>
>> The kernel preferred that this code would be in userspace.
>
> Hi Elazar,
>
> I suspected the reasoning was something along those lines.  I was hoping that someone could point to archived email threads with earlier discussions showing the complications that would arise by having system-wide setup perf event setup and reading handled in the kernel. Looking through the earlier versions of perf see that pid==-1 and cpu=-1 were not allowed in the very early proposed patches (http://thread.gmane.org/gmane.linux.kernel.cross-arch/2578).  However, not much in the way explanation in the design tradeoffs in there.
>
The perf_event interface an an event-driven interface. Users
manipulate individual events. Events can be attached to a thread
(process mode)
 or a CPU (per-cpu mode).
To monitor all CPUs in a system, multiple instances of an event must
be created and attached to each monitored CPU.  The kernel does not
program a event across all CPUs at once.

To collect system-wide profiles for cycles on a 12-way machine, you
need to create 12 events with the cycle event encoding and attach each
to a CPU. Perf record/stat do this automatically for you. As for the
samples. There is a sampling buffer associated with each event. To
sample
of cycles across 12 CPU, then 12 per-cpu sampling buffers are created
and mapped into the tool. When a buffer fills up, perf record dumps
the content unmodified into the perf.data file. As such, the
aggregation of the samples is deferred until perf report/annotate are
used.

> Making user-space set up performance events for each cpu certainly simplifies the kernel code for system-wide monitoring. The cgroup support is essentially like system-wide monitoring with additional filtering on the cgroup and things get more complicated using the perf cgroup support when the cgroups are not pinned to a particular processor, O(cgroups*cpus) opens and reads.  If the cgroups is scaled up at the same rate as cpus, this would be O(cpus^2).  I am wondering if handling the system-wide case (pid==-1 and cpu==-1) in the kernel would make cgroup and system-wide monitoring more efficient or if the complications in the kernel are just too much.

As Will explained, cgroup is just a filtered from of per CPU
monitoring. You can filter occurrences of an event based on cgroup.
You can
say "monitor cycles on CPU0 only when a thread from cgroup foo is
running on CPU0". Usually in per-cpu mode, the event is programmed
into the PMU counter and remains there until monitoring stops
regardless of context switches. In cgroup mode, the event is
programmed on
the CPU and remains enabled as long as the current thread is from the
cgroup of interest. If it is not, the event is descheduled. It is
rescheduled
once a thread from the cgroup is active on that CPU again.


Hope this helps.

>
> -Will
>>
>> On Fri, Mar 13, 2015 at 8:49 PM, William Cohen <wcohen@redhat.com> wrote:
>>> Hi All,
>>>
>>> I have a design question about the linux kernel perf support. A number of /proc statistics aggregate data across all the cpus in the system.  Why the does perf require the user-space application to enumerate all the processors and do a perf_event_open syscall for each of the processors?  Why not have a perf_event_open with pid=-1 and cpu=-1 mean system-wide event and aggregate it in the kernel when the value is read?  The line below from design.txt specifically say it is invalid.
>>>
>>> (Note: the combination of 'pid == -1' and 'cpu == -1' is not valid.)
>>>
>>> -Will
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
