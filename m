From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Question about Perf's handling of in-use performance counters
Date: Thu, 27 Oct 2016 11:11:24 -0700
Message-ID: <87r371k6gj.fsf@tassilo.jf.intel.com>
References: <BN3PR0501MB14590BFC82C2B45B81E56C1BA3D40@BN3PR0501MB1459.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:33870 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933792AbcJ0SL0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 Oct 2016 14:11:26 -0400
In-Reply-To: <BN3PR0501MB14590BFC82C2B45B81E56C1BA3D40@BN3PR0501MB1459.namprd05.prod.outlook.com>
        (Taylor Andrews's message of "Fri, 21 Oct 2016 21:59:49 +0000")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Taylor Andrews <andrewst@vmware.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, peterz@infradead.org


Taylor Andrews <andrewst@vmware.com> writes:

> First some background:
>
> VMware's virtual x86 performance counter implementation aims to expose
> in-use (unavailable) performance counters to the guest operating
> system in the hopes that software agents will recognize it as an
> "in-use" resource and follow the PMU sharing guidelines outlined in
> Intel's Performance Monitoring Unit Sharing Guide
> (https://software.intel.com/en-us/articles/performance-monitoring-unit-guidelines/).
> There is also a VMware-based mechanism to force virtual performance
> counters to be exposed to the guest operating system as in-use.
> "In-use" is defined in the sharing guidelines as the enable bits being
> found to be set, either in the general purpose PMC's event select MSR,
> or in the case of fixed function counters, in the Fixed Counter
> Control MSR.
>
> The Linux PMU driver looks like it currently complains about the BIOS
> being "broken" if it finds any counters are in-use by it, but it still
> successfully initializes:
> https://github.com/torvalds/linux/blob/a5ebe0ba3dff658c5286e8d5f20e4328f719d5a3/arch/x86/kernel/cpu/perf_event.c#L181
>

>
> By looking at these warnings, naively, it would appear perf is trying
> to use counters that are marked as in-use.

That's right. For generic counters perf doesn't really follow the
exclusion protocol. It just checks and warns, but they later
the "in use" information is not used in the scheduler.
It works for fixed counters.

> I would like to investigate if this is expected perf behavior, or
> unexpected perf behavior.

It's kind of expected, but could argue that it probably should be fixed.

For the VM of course you could implement it by taking counters from
the top of the range and limiting CPUID.

There are some other use cases (e.g. with user space users of perfmon)
where it would be helpful, so at some point it would be useful to fix.

I think it could be done by simply making the bios test update the
active_mask of the scheduler. But it would be somewhat expensive
to reread the enable registers all the time to do full exclusion
with run timer users.

It's also hard to test unfortunately.

-Andi
