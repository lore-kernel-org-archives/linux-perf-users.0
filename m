From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Question about Perf's handling of in-use performance counters
Date: Fri, 28 Oct 2016 09:33:05 -0700
Message-ID: <20161028163305.GD26852@two.firstfloor.org>
References: <BN3PR0501MB14590BFC82C2B45B81E56C1BA3D40@BN3PR0501MB1459.namprd05.prod.outlook.com>
 <87r371k6gj.fsf@tassilo.jf.intel.com>
 <20161027210012.GN3102@twins.programming.kicks-ass.net>
 <20161028135325.GB26852@two.firstfloor.org>
 <20161028140354.GH3142@twins.programming.kicks-ass.net>
 <20161028154012.GC26852@two.firstfloor.org>
 <20161028162844.GJ3142@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:56109 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965925AbcJ1QdI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Oct 2016 12:33:08 -0400
Content-Disposition: inline
In-Reply-To: <20161028162844.GJ3142@twins.programming.kicks-ass.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <andi@firstfloor.org>, Taylor Andrews <andrewst@vmware.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

> But the thing is still racy, and therefore useless.

At least the Hypervisor case is not racy. The Hypervisor always
uses that counter.

-Andi
