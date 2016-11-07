From: Taylor Andrews <andrewst@vmware.com>
Subject: Re: Question about Perf's handling of in-use performance counters
Date: Mon, 7 Nov 2016 22:25:14 +0000
Message-ID: <BN3PR0501MB1459CDCF7F91C63015AD9A0CA3A70@BN3PR0501MB1459.namprd05.prod.outlook.com>
References: <BN3PR0501MB14590BFC82C2B45B81E56C1BA3D40@BN3PR0501MB1459.namprd05.prod.outlook.com>
 <87r371k6gj.fsf@tassilo.jf.intel.com>
 <20161027210012.GN3102@twins.programming.kicks-ass.net>
 <20161028135325.GB26852@two.firstfloor.org>
 <20161028140354.GH3142@twins.programming.kicks-ass.net>
 <20161028154012.GC26852@two.firstfloor.org>
 <20161028162844.GJ3142@twins.programming.kicks-ass.net>,<20161028163305.GD26852@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:50173 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752570AbcKGW03 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Nov 2016 17:26:29 -0500
In-Reply-To: <20161028163305.GD26852@two.firstfloor.org>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi Andi,

Do you know of any perf development-oriented mailing lists that may hold mo=
re information about this behavior of attempting to use in-use general purp=
ose performance counters? =20

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
