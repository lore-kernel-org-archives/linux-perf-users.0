From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Why the need to do a perf_event_open syscall for each cpu on the system?
Date: Tue, 17 Mar 2015 07:40:57 -0700
Message-ID: <87twxjvg92.fsf@tassilo.jf.intel.com>
References: <55033138.5010500@redhat.com>
	<CAL2Y34DEW+HvF6tsFH5qg-RxkAmstEcK=qYhkcRV6D8DCFG3kg@mail.gmail.com>
	<5506ECFA.40305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:27836 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457AbbCQOk6 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 17 Mar 2015 10:40:58 -0400
In-Reply-To: <5506ECFA.40305@redhat.com> (William Cohen's message of "Mon, 16
	Mar 2015 10:47:22 -0400")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: Elazar Leibovich <elazar.leibovich@ravellosystems.com>, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>

William Cohen <wcohen@redhat.com> writes:
>
> Making user-space set up performance events for each cpu certainly
> simplifies the kernel code for system-wide monitoring. The cgroup
> support is essentially like system-wide monitoring with additional
> filtering on the cgroup and things get more complicated using the perf
> cgroup support when the cgroups are not pinned to a particular
> processor, O(cgroups*cpus) opens and reads.  If the cgroups is scaled
> up at the same rate as cpus, this would be O(cpus^2).  I am wondering

Using O() notation here is misleading because a perf event 
is not an algorithmic step. It's just a data structure in memory,
associated with a file descriptor.  But the number of active
events at a time is always limited by the number of counters
in the CPU (ignoring software events here) and is comparable
small.

The memory usage is not a significant problem, it is dwarfed by other
data structures per CPU.  Usually the main problem people run into is
running out of file descriptors because most systems still run with a
ulimit -n default of 1024, which is easy to reach with even a small
number of event groups on a system with a moderate number of CPUs.

However ulimit -n can be easily fixed: just increase it. Arguably
the distribution defaults should probably be increased.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only
