From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Question about Perf's handling of in-use performance counters
Date: Wed, 30 Nov 2016 19:17:42 +0100
Message-ID: <20161130181742.GS3092@twins.programming.kicks-ass.net>
References: <BN3PR0501MB14590BFC82C2B45B81E56C1BA3D40@BN3PR0501MB1459.namprd05.prod.outlook.com>
 <87r371k6gj.fsf@tassilo.jf.intel.com>
 <20161027210012.GN3102@twins.programming.kicks-ass.net>
 <20161028135325.GB26852@two.firstfloor.org>
 <20161028140354.GH3142@twins.programming.kicks-ass.net>
 <20161028154012.GC26852@two.firstfloor.org>
 <20161028162844.GJ3142@twins.programming.kicks-ass.net>
 <20161028163305.GD26852@two.firstfloor.org>
 <BN3PR0501MB145957823C655728020392F3A3AD0@BN3PR0501MB1459.namprd05.prod.outlook.com>
 <BN3PR0501MB14597261479AD30C8081CBA2A38C0@BN3PR0501MB1459.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BN3PR0501MB14597261479AD30C8081CBA2A38C0@BN3PR0501MB1459.namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Taylor Andrews <andrewst@vmware.com>
Cc: Andi Kleen <andi@firstfloor.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alok Kataria <akataria@vmware.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Nov 30, 2016 at 03:44:57PM +0000, Taylor Andrews wrote:

> > No, it was about the (mis)guide-line having fundamental races and the
> > belief that the BIOS has no business what so ever using these resources
> > to begin with.
> 
> Can you please describe what fundamental races you are talking about?

The protocol does a RDMSR to see if the counter is configured or not, if
not, then it can proceed with the WRMSR.

Since these are two separate instructions, there is nothing that
prevents a vCPU preemption or SMI to come in between and invalidate the
state we just read.

> Why do you believe the BIOS should never be using performance counters?

The BIOS's job is to boot the system and then stay the heck away.
Runtime services are not what its for.

Now I know some hardware vendors like to (ab)use SMM for
fail^Wfeature-add, and that is exactly the kind of crap we don't need.
BIOS monkeys always get it wrong and BIOS code is _never_ updated, so
then you're stuck with wreckage.

> Even if you discount the BIOS use case (despite Intel considering it
> legitimate), we still have the scenario of a Hypervisor exposing some
> virtual performance counters as in-use and unavailable.  What was the
> rationale that the PMU cooperative sharing guidelines outlined by
> Intel should be intentionally ignored, and that perf should attempt to
> take over all generic performance counters, regardless of if they are
> marked in-use?

See the thread here:

  https://lkml.org/lkml/2011/3/24/608
