From: William Cohen <wcohen@redhat.com>
Subject: Re: Why the need to do a perf_event_open syscall for each cpu on
 the system?
Date: Tue, 17 Mar 2015 11:30:48 -0400
Message-ID: <550848A8.10003@redhat.com>
References: <55033138.5010500@redhat.com>	<CAL2Y34DEW+HvF6tsFH5qg-RxkAmstEcK=qYhkcRV6D8DCFG3kg@mail.gmail.com>	<5506ECFA.40305@redhat.com> <87twxjvg92.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36221 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753901AbbCQPat (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 17 Mar 2015 11:30:49 -0400
In-Reply-To: <87twxjvg92.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Elazar Leibovich <elazar.leibovich@ravellosystems.com>, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>

On 03/17/2015 10:40 AM, Andi Kleen wrote:
> William Cohen <wcohen@redhat.com> writes:
>>
>> Making user-space set up performance events for each cpu certainly
>> simplifies the kernel code for system-wide monitoring. The cgroup
>> support is essentially like system-wide monitoring with additional
>> filtering on the cgroup and things get more complicated using the perf
>> cgroup support when the cgroups are not pinned to a particular
>> processor, O(cgroups*cpus) opens and reads.  If the cgroups is scaled
>> up at the same rate as cpus, this would be O(cpus^2).  I am wondering
> 
> Using O() notation here is misleading because a perf event 
> is not an algorithmic step. It's just a data structure in memory,
> associated with a file descriptor.  But the number of active
> events at a time is always limited by the number of counters
> in the CPU (ignoring software events here) and is comparable
> small.
> 
> The memory usage is not a significant problem, it is dwarfed by other
> data structures per CPU.  Usually the main problem people run into is
> running out of file descriptors because most systems still run with a
> ulimit -n default of 1024, which is easy to reach with even a small
> number of event groups on a system with a moderate number of CPUs.
> 
> However ulimit -n can be easily fixed: just increase it. Arguably
> the distribution defaults should probably be increased.
> 
> -Andi
> 

Hi Andi,

O() notation can be used to describe both time and space, Reading the perf counters is O(cpu^2) in time. As mentioned the number of file descriptors required is going to be grow pretty large quickly as the number of cpus/cgroups increase. 32 cpus and 32 cgroups would be 1024 file descriptors; 80 cpus and 80 cgroups would 6400 file descriptors.  There are machines more than 80 processors.  Does it make sense to have multiple thousands of file descriptors for performance monitoring?

Making the user-space responsible opening and reading the counters from each processor simplifies the kernel code.  However, is making user-space do this a better solution than doing this system-wide setup and aggregation in the kernel?  How much overhead is there for all the user-space/kernel-space transitions to read out 100's of values from the kernel versus doing that in the kernel?

-Will
