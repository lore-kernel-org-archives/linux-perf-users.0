From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Question about Perf's handling of in-use performance counters
Date: Fri, 28 Oct 2016 08:40:12 -0700
Message-ID: <20161028154012.GC26852@two.firstfloor.org>
References: <BN3PR0501MB14590BFC82C2B45B81E56C1BA3D40@BN3PR0501MB1459.namprd05.prod.outlook.com>
 <87r371k6gj.fsf@tassilo.jf.intel.com>
 <20161027210012.GN3102@twins.programming.kicks-ass.net>
 <20161028135325.GB26852@two.firstfloor.org>
 <20161028140354.GH3142@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:55966 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754677AbcJ1PkQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Oct 2016 11:40:16 -0400
Content-Disposition: inline
In-Reply-To: <20161028140354.GH3142@twins.programming.kicks-ass.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <andi@firstfloor.org>, Taylor Andrews <andrewst@vmware.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

> No, it was about the (mis)guide-line having fundamental races and the
> belief that the BIOS has no business what so ever using these resources
> to begin with.

In this case it's not the BIOS, but a hypervisor who allocates the
counter. I believe there are valid use cases here. 

The same issue can also happen when people use user space perfmon
tools, like PCM or likwid, and potentially with other non BIOS users.

-Andi
