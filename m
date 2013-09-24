From: David Ahern <dsahern@gmail.com>
Subject: Re: Experiments using perf support in arm kvm guest
Date: Mon, 23 Sep 2013 18:06:46 -0600
Message-ID: <5240D796.3090109@gmail.com>
References: <524063E4.6010100@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:46218 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab3IXAGy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 23 Sep 2013 20:06:54 -0400
In-Reply-To: <524063E4.6010100@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: PAPI list <ptools-perfapi@eecs.utk.edu>, linux-perf-users@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>

[Added Gleb and kvm list]

On 9/23/13 9:53 AM, William Cohen wrote:
> Hi All,
>
> I was curious to see how well (or poorly) perf events work in a virtualizated environment.  As a little experiment I have tried building papi from the git repo in a fedora rawhide guest vm running on an Intel ivy bridge.   I also ran things on the f19 host to compare results of "make fulltest" between the raw and virtualized hardware.  Despite trying to copy the host machine processor information in the set up of the guest machine, the guest vm thinks it is a sandy bridge rather than the Intel Ivy Bridge, but it looks like the same events are used in papi_events.csb for both.  The papi "make fulltest" results look similar on the x86.
>
> There has been some work on arm cortex a15 to support hardware virtualization (http://osdir.com/ml/fedora-arm/2013-09/msg00011.html).  I have kvm hardware accelerated virtualization running on my Samsung ARM chromebook.  Both host and guest are running Fedora 19. The host is running a 3.11 kernel with a patch so that Samsung exynos 5250 boots up. The guest is running a stock Fedora 19 3.10.1-200 kernel.  For arm the guest papi "make fulltest" results are not so good.  It appears that access to the perf counters on the arm guest are not so good.  On the arm guest it looks like only the cycle count event is working::

to my knowledge a vPMU is only supported for kvm on x86. Perhaps Gleb / 
kvm list knows other wise.

David

>
> Performance counter stats for 'ls':
>
>            4.043500 task-clock                #    0.799 CPUs utilized
>                   0 context-switches          #    0.000 K/sec
>                   0 cpu-migrations            #    0.000 K/sec
>                 237 page-faults               #    0.059 M/sec
>       2,147,483,647 cycles                    #  531.095 GHz
>     <not supported> stalled-cycles-frontend
>     <not supported> stalled-cycles-backend
>       <not counted> instructions
>       <not counted> branches
>       <not counted> branch-misses
>
>         0.005059000 seconds time elapsed
>
>
> On the arm host see:
>
>   Performance counter stats for 'ls':
>
>           19.259873 task-clock                #    0.777 CPUs utilized
>                   2 context-switches          #    0.104 K/sec
>                   0 cpu-migrations            #    0.000 K/sec
>                 242 page-faults               #    0.013 M/sec
>           6,242,062 cycles                    #    0.324 GHz
>     <not supported> stalled-cycles-frontend
>     <not supported> stalled-cycles-backend
>           3,479,441 instructions              #    0.56  insns per cycle
>             644,120 branches                  #   33.444 M/sec
>              37,372 branch-misses             #    5.80% of all branches
>
>         0.024776800 seconds time elapsed
>
> Are there reasons that the arm hardware cannot virtualize the performance counters like the x86 machines? Or is this something that just hasn't been implmented yet in the kernel? Or is this suppose to work and there is a bug?
>
>
> -Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
