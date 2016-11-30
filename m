From: Taylor Andrews <andrewst@vmware.com>
Subject: Re: Question about Perf's handling of in-use performance counters
Date: Wed, 30 Nov 2016 15:44:57 +0000
Message-ID: <BN3PR0501MB14597261479AD30C8081CBA2A38C0@BN3PR0501MB1459.namprd05.prod.outlook.com>
References: <BN3PR0501MB14590BFC82C2B45B81E56C1BA3D40@BN3PR0501MB1459.namprd05.prod.outlook.com>
 <87r371k6gj.fsf@tassilo.jf.intel.com>
 <20161027210012.GN3102@twins.programming.kicks-ass.net>
 <20161028135325.GB26852@two.firstfloor.org>
 <20161028140354.GH3142@twins.programming.kicks-ass.net>
 <20161028154012.GC26852@two.firstfloor.org>
 <20161028162844.GJ3142@twins.programming.kicks-ass.net>,<20161028163305.GD26852@two.firstfloor.org>,<BN3PR0501MB145957823C655728020392F3A3AD0@BN3PR0501MB1459.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-bl2nam02on0051.outbound.protection.outlook.com ([104.47.38.51]:43552
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758336AbcK3RTO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Nov 2016 12:19:14 -0500
In-Reply-To: <BN3PR0501MB145957823C655728020392F3A3AD0@BN3PR0501MB1459.namprd05.prod.outlook.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>, Peter Zijlstra <peterz@infradead.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alok Kataria <akataria@vmware.com>

Hi,

Friendly ping as this discussion seems to have stalled.

For the full discussion please see http://www.spinics.net/lists/linux-perf-=
users/msg03168.html

Thanks,
Taylor

________________________________________
From: Taylor Andrews
Sent: Friday, October 28, 2016 2:28 PM
To: Andi Kleen; Peter Zijlstra
Cc: linux-perf-users@vger.kernel.org
Subject: Re: Question about Perf's handling of in-use performance counters

Hi Andi, Peter,

Thanks so much for the responses.

Hi Peter,

> No, it was about the (mis)guide-line having fundamental races and the
> belief that the BIOS has no business what so ever using these resources
> to begin with.

Can you please describe what fundamental races you are talking about?

Why do you believe the BIOS should never be using performance counters?

Even if you discount the BIOS use case (despite Intel considering it legiti=
mate), we still have the scenario of a Hypervisor exposing some virtual per=
formance counters as in-use and unavailable.  What was the rationale that t=
he PMU cooperative sharing guidelines outlined by Intel should be intention=
ally ignored, and that perf should attempt to take over all generic perform=
ance counters, regardless of if they are marked in-use?

It should be noted that this design decision degrades the experience of usi=
ng perf in x86 VMware VMs and has confused perf users.  If one or more virt=
ual generic counters are not available, attempted writes to them are droppe=
d by the Hypervisor so as not to corrupt other entities that are using the =
real PMU hardware.  This attempted use of in-use counters results in report=
ed event counts of zero from perf with no errors or warnings that could bet=
ter inform the user of the real issue - that there is a lack of available P=
MU resources to complete the requested profiling.

Thanks,
Taylor

________________________________________
From: Andi Kleen <andi@firstfloor.org>
Sent: Friday, October 28, 2016 12:33 PM
To: Peter Zijlstra
Cc: Andi Kleen; Taylor Andrews; linux-perf-users@vger.kernel.org
Subject: Re: Question about Perf's handling of in-use performance counters

> But the thing is still racy, and therefore useless.

At least the Hypervisor case is not racy. The Hypervisor always
uses that counter.

-Andi
