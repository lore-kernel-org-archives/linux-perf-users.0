From: William Cohen <wcohen@redhat.com>
Subject: Re: Why the need to do a perf_event_open syscall for each cpu on
 the system?
Date: Mon, 16 Mar 2015 10:47:22 -0400
Message-ID: <5506ECFA.40305@redhat.com>
References: <55033138.5010500@redhat.com> <CAL2Y34DEW+HvF6tsFH5qg-RxkAmstEcK=qYhkcRV6D8DCFG3kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56646 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756543AbbCPOrc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 16 Mar 2015 10:47:32 -0400
In-Reply-To: <CAL2Y34DEW+HvF6tsFH5qg-RxkAmstEcK=qYhkcRV6D8DCFG3kg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Elazar Leibovich <elazar.leibovich@ravellosystems.com>
Cc: linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>

On 03/15/2015 01:15 AM, Elazar Leibovich wrote:
> Hi,
> 
> Not an expert, but my understanding is that it's just technical
> difficulty. Performance metrics are being saved in per-cpu buffer.
> Having pid==-1 and cpu==-1 means that something would aggregate all
> buffers in multiple CPUs to a single buffer. That code must exist,
> either in userspace or in the kernel.
> 
> The kernel preferred that this code would be in userspace.

Hi Elazar,

I suspected the reasoning was something along those lines.  I was hoping that someone could point to archived email threads with earlier discussions showing the complications that would arise by having system-wide setup perf event setup and reading handled in the kernel. Looking through the earlier versions of perf see that pid==-1 and cpu=-1 were not allowed in the very early proposed patches (http://thread.gmane.org/gmane.linux.kernel.cross-arch/2578).  However, not much in the way explanation in the design tradeoffs in there.

Making user-space set up performance events for each cpu certainly simplifies the kernel code for system-wide monitoring. The cgroup support is essentially like system-wide monitoring with additional filtering on the cgroup and things get more complicated using the perf cgroup support when the cgroups are not pinned to a particular processor, O(cgroups*cpus) opens and reads.  If the cgroups is scaled up at the same rate as cpus, this would be O(cpus^2).  I am wondering if handling the system-wide case (pid==-1 and cpu==-1) in the kernel would make cgroup and system-wide monitoring more efficient or if the complications in the kernel are just too much.

-Will
>
> On Fri, Mar 13, 2015 at 8:49 PM, William Cohen <wcohen@redhat.com> wrote:
>> Hi All,
>>
>> I have a design question about the linux kernel perf support. A number of /proc statistics aggregate data across all the cpus in the system.  Why the does perf require the user-space application to enumerate all the processors and do a perf_event_open syscall for each of the processors?  Why not have a perf_event_open with pid=-1 and cpu=-1 mean system-wide event and aggregate it in the kernel when the value is read?  The line below from design.txt specifically say it is invalid.
>>
>> (Note: the combination of 'pid == -1' and 'cpu == -1' is not valid.)
>>
>> -Will
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
