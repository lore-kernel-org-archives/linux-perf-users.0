From: Gleb Natapov <gleb@redhat.com>
Subject: Re: Experiments using perf support in arm kvm guest
Date: Wed, 2 Oct 2013 18:33:12 +0300
Message-ID: <20131002153312.GN17294@redhat.com>
References: <524063E4.6010100@redhat.com>
 <5240D796.3090109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5240D796.3090109@gmail.com>
Sender: kvm-owner@vger.kernel.org
To: David Ahern <dsahern@gmail.com>
Cc: William Cohen <wcohen@redhat.com>, PAPI list <ptools-perfapi@eecs.utk.edu>, linux-perf-users@vger.kernel.org, KVM <kvm@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Sep 23, 2013 at 06:06:46PM -0600, David Ahern wrote:
> [Added Gleb and kvm list]
> 
Sorry for the late answer.

> On 9/23/13 9:53 AM, William Cohen wrote:
> >Hi All,
> >
> >I was curious to see how well (or poorly) perf events work in a virtualizated environment.  As a little experiment I have tried building papi from the git repo in a fedora rawhide guest vm running on an Intel ivy bridge.   I also ran things on the f19 host to compare results of "make fulltest" between the raw and virtualized hardware.  Despite trying to copy the host machine processor information in the set up of the guest machine, the guest vm thinks it is a sandy bridge rather than the Intel Ivy Bridge, but it looks like the same events are used in papi_events.csb for both.  The papi "make fulltest" results look similar on the x86.
> >
> >There has been some work on arm cortex a15 to support hardware virtualization (http://osdir.com/ml/fedora-arm/2013-09/msg00011.html).  I have kvm hardware accelerated virtualization running on my Samsung ARM chromebook.  Both host and guest are running Fedora 19. The host is running a 3.11 kernel with a patch so that Samsung exynos 5250 boots up. The guest is running a stock Fedora 19 3.10.1-200 kernel.  For arm the guest papi "make fulltest" results are not so good.  It appears that access to the perf counters on the arm guest are not so good.  On the arm guest it looks like only the cycle count event is working::
> 
> to my knowledge a vPMU is only supported for kvm on x86. Perhaps
> Gleb / kvm list knows other wise.
> 

For x86 very limited set of features (architectural PMU only basically)
is supported on Intel only. Most of PMU is not virtualizable on x86. For
ARM you can ask arm mailing list kvmarm@lists.cs.columbia.edu.


> David
> 
> >
> >Performance counter stats for 'ls':
> >
> >           4.043500 task-clock                #    0.799 CPUs utilized
> >                  0 context-switches          #    0.000 K/sec
> >                  0 cpu-migrations            #    0.000 K/sec
> >                237 page-faults               #    0.059 M/sec
> >      2,147,483,647 cycles                    #  531.095 GHz
> >    <not supported> stalled-cycles-frontend
> >    <not supported> stalled-cycles-backend
> >      <not counted> instructions
> >      <not counted> branches
> >      <not counted> branch-misses
> >
> >        0.005059000 seconds time elapsed
> >
> >
> >On the arm host see:
> >
> >  Performance counter stats for 'ls':
> >
> >          19.259873 task-clock                #    0.777 CPUs utilized
> >                  2 context-switches          #    0.104 K/sec
> >                  0 cpu-migrations            #    0.000 K/sec
> >                242 page-faults               #    0.013 M/sec
> >          6,242,062 cycles                    #    0.324 GHz
> >    <not supported> stalled-cycles-frontend
> >    <not supported> stalled-cycles-backend
> >          3,479,441 instructions              #    0.56  insns per cycle
> >            644,120 branches                  #   33.444 M/sec
> >             37,372 branch-misses             #    5.80% of all branches
> >
> >        0.024776800 seconds time elapsed
> >
> >Are there reasons that the arm hardware cannot virtualize the performance counters like the x86 machines? Or is this something that just hasn't been implmented yet in the kernel? Or is this suppose to work and there is a bug?
> >
> >
> >-Will
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

--
			Gleb.
