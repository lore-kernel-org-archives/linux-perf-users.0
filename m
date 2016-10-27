From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Question about Perf's handling of in-use performance counters
Date: Thu, 27 Oct 2016 23:00:12 +0200
Message-ID: <20161027210012.GN3102@twins.programming.kicks-ass.net>
References: <BN3PR0501MB14590BFC82C2B45B81E56C1BA3D40@BN3PR0501MB1459.namprd05.prod.outlook.com>
 <87r371k6gj.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:42152 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933832AbcJ0VAk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 Oct 2016 17:00:40 -0400
Content-Disposition: inline
In-Reply-To: <87r371k6gj.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Taylor Andrews <andrewst@vmware.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Thu, Oct 27, 2016 at 11:11:24AM -0700, Andi Kleen wrote:
> 
> Taylor Andrews <andrewst@vmware.com> writes:
> 
> > First some background:
> >
> > VMware's virtual x86 performance counter implementation aims to expose
> > in-use (unavailable) performance counters to the guest operating
> > system in the hopes that software agents will recognize it as an
> > "in-use" resource and follow the PMU sharing guidelines outlined in
> > Intel's Performance Monitoring Unit Sharing Guide
> > (https://software.intel.com/en-us/articles/performance-monitoring-unit-guidelines/).

I would have to dig out the thread, but that wasn't followed on purpose
and is unlikely to ever be followed.
