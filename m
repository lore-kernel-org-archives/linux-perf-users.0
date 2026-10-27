Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123933;
	b=MH+b8Dh9vZIiL2vw6m1IYOrmBamUS4Z5fXaL/b7z1WcU8NMtEO2i9WUBZl8EHEdtKod5
	 Lo3JHxj+PDiBnol6UET+qST7SeXw1Vxi3vFKBHxdlpD/dpCNZK6nflmDyT6jnPBrSNX1M
	 xSl5eot6auOmUFNsFO5BuaOJleGzrQ2Ij8o8bCcCTuZsl59NuAbj+zv9gOqxp8RHd2u6d
	 JVin/rcrJ+FRCNLkKIfajmQCPbjICriBLllImZ+z7Vsb2aSa84C+fPWBwLNNIVmfmX4Dt
	 poMBq/EXsK8vXOhbuqdI7dZg4K8Ozr2CCxODvOYGzAdV0277Eys4K+rbN3GKOYhQDuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123933;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=M8FcrobU4PWYnzF3J8Ti9CwzWUXYvw2NVyV3AaFVHkM=;
	b=1p8LzLqrOk7JjoFNlDdHMKmWec+wkT9fvgNtWB+jQVXq/MdRbWzizMh6X5sA6M5p2v0k
	 6gRAmTyswSdrj5M+LaNCPj9/cjEfsbgN/tulwe8NFEi3sBBUYKB2dMcc+QQucSPYzwGlP
	 RemdqyKvuKERwkGaY8TIJu9a+4j7SKzAb83iVpuJpCPF6Ql0qt1kWAsNMjzQZQ5bzNySJ
	 AHpaIU/yIdc4gwBS0bA46BUELM///kS8kiY0J8EuNRq2mzm2s9D+fXTJfs2VNvDK4gBHI
	 uNY57thMFiO3MFG/TJZ/9pOTZB7JrdoG0mtVtgaVCbomGhKCVAXKw0mTtKpTKaCHuEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LKpee6sr;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A40606A31A;
	Tue, 27 Oct 2026 17:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27A40606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LKpee6sr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793123932; x=1824659932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V5nk5TrDo3y7uwo5ofs90/ZobCzIgluhbPJ7QRc4l2U=;
  b=LKpee6srHthOt7bR+1lJNtky38C865SF1ZEepItX4FZ3cbTXstVgFohY
   yAyxoT5QaDx1qJvqX/7S/dtFQm6dnD5dwrEeAz2Dxcj78EsAyHzzLF/0F
   yQEEVp7tY0HmSbB6PkDR3Y2DTMX0PquuIudYWnDaMeagWioUyWHCut+T+
   jcxiYpCL9UqZWaZES14mtEJP7UvvWrmO83nQimjOILWHODCc8m04KekBP
   k5DXZQmEEwV+On4mp4TcMZ+kLA86qs4KYtSsYG2Itkxh6xZDRg2rUBsqk
   LIB4kgprMtAhTkkalMVW6t6uubMcNbIFiWEVYxpMn9jESRqZSDPa4v5Bw
   Q==;
X-CSE-ConnectionGUID: cGHdzeJ+S6KpSGAHKasYpw==
X-CSE-MsgGUID: vmwd13+TQg2r4D8vuCIXHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1722795"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1722795"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 10:58:52 -0700
X-CSE-ConnectionGUID: +0exPYOTTm6oOm+wGzbULw==
X-CSE-MsgGUID: kBC2SElbSbuJR2Lo2C3tlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4669236"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 10:58:51 -0700
Message-ID: <31371b32-b88a-4bc3-8f82-3d7f5be02100@intel.com>
Date: Tue, 27 Oct 2026 12:58:50 -0500
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: perf/uncore: CPU-hotplug box migration racing PCI box removal
 operates on a freed intel_uncore_box (no common lock, no reference on the
 hotplug side)
To: =?UTF-8?B?5b6Q5pmX57+U?= <xuhx@hust.edu.cn>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <51d7f699.14c14.1a163eaabac.Coremail.xuhx@hust.edu.cn>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <51d7f699.14c14.1a163eaabac.Coremail.xuhx@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Hanxiang,

Thank you for reporting another long-standing issue in uncore PCI handling.

On multi-die systems sharing uncore PMU boxes across dies, removing a
single die's PCI device unregisters that die's box and drops its PCI
device reference while surviving events on other dies remain active,
risking a Use-After-Free during hardware callback execution.

Additionally, CPU hotplug migration walks pmu->boxes[] without locking
against PCI device removal, leading to a Use-After-Free during context
migration.

Unlike MSR and MMIO boxes, which remain allocated until module exit, PCI
boxes are dynamically freed upon device removal.

Patches addressing both issues will be included in the uncore bug-fix
series that I will post to LKML shortly.

Thanks,
Zide


On 10/22/2026 9:01 AM, 徐晗翔 wrote:
> When a CPU goes offline (or online) on a multi-die host, the uncore
> hotplug callback walks every type's boxes through
> uncore_change_type_ctx(), which reads pmu->boxes[die], writes box
> fields, cancels the box hrtimer and calls perf_pmu_migrate_context()
> -- all without taking a reference on the box and without any lock in
> common with the PCI remove path, which on the "last box" transition
> NULLs the slot and kfrees the box.  The hotplug side can therefore
> hold and keep using a box the PCI side just freed: hrtimer_cancel()
> on a freed timer (its base pointer read leads to a spinlock on
> arbitrary memory), writes into freed slab, and a migration chain that
> may also dereference an unregistered PMU's freed per-CPU contexts.
> 7.3's recent box-refcounting refactor covered the PCI probe/remove
> pair but left the hotplug side unreferenced, so the race is fully
> present in current mainline; the perf-core half of the transmission
> chain, in contrast, I verified dynamically to be properly protected,
> which pins the defect squarely in the uncore layer.
> 
> The two paths share pmu->boxes[die] and the box object with nothing
> to serialize them (arch/x86/events/intel/uncore.c): the CPU hotplug
> callbacks take the cpu hotplug locks, the PCI remove callback takes
> its device's lock -- neither takes the other's, and unlike the probe
> path, PCI remove has no cpu_hotplug_disable() wrapper.  The box
> reference count that 7.3 introduced is taken by the PCI probe
> (atomic_inc(&box->refcnt), uncore.c:1215) and dropped by PCI remove
> (uncore.c:1293-1296), but the hotplug side's uncore_box_ref()/
> uncore_box_unref() iterate only the MSR and MMIO uncore arrays
> (uncore.c:1590-1591 on offline, :1692-1693 on online) -- the PCI
> types reach uncore_change_type_ctx() via
> uncore_change_context(uncore_pci_uncores, ...) (uncore.c:1608/1689)
> with no reference at all.  Triggering needs a multi-die host with
> id-table uncore PCI drivers and concurrent CPU offline/online plus
> PCI unbind/remove (administrator actions, or a hotplug event racing
> an admin operation).
> 
> The detailed description:
> 
> * Test environment / affected version
> 
>   Linux version 7.3.0 (gcc 13.3.0, GNU ld 2.42) #1 SMP PREEMPT_DYNAMIC
>   -- vanilla mainline 7.3 release tarball (kernel.org, unmodified),
>   rebuilt with CONFIG_PERF_EVENTS=y, CONFIG_PERF_EVENTS_INTEL_UNCORE=y,
>   CONFIG_HOTPLUG_CPU=y, KASAN enabled, QEMU/KVM x86_64 guest.  Line
>   numbers below are from 7.3 (the refactor that added box refcounting
>   and PMU_BROKEN is the current shape analyzed here).
> 
> * Mechanism
> 
>   H side -- CPU offline for this die (uncore_event_cpu_offline(),
>   uncore.c:1584):
> 
>       uncore_box_unref(uncore_msr_uncores, die);    /* :1590  msr/mmio
>       uncore_box_unref(uncore_mmio_uncores, die);   /* :1591  only!   */
>       ...
>       uncore_change_context(uncore_pci_uncores, cpu, target); /* :1608 */
>         -> uncore_change_type_ctx()                  /* :1514 */
>              box = pmu->boxes[die];                   /* :1523  no ref */
>              ... box->cpu / cpumask writes ...        /* :1531/:1538   */
>              uncore_pmu_cancel_hrtimer(box);          /* :1547         */
>              perf_pmu_migrate_context(&pmu->pmu, old_cpu, new_cpu);
>                                                       /* :1548, sleeps */
>              box->cpu = new_cpu;                      /* :1549  use of
>                                                          box AFTER the
>                                                          sleepable call */
>              cpumask_set_cpu(new_cpu, &pmu->cpu_mask);/* :1550         */
> 
>   P side -- PCI remove of that die's box (uncore_pci_pmu_unregister(),
>   uncore.c:1283):
> 
>       pmu->boxes[die] = NULL;                         /* :1289 */
>       if (atomic_dec_return(&pmu->activeboxes) == 0)
>               uncore_pmu_unregister(pmu);             /* :1291-1292 (the
>                                                          register/unreg
>                                                          race reported
>                                                          separately) */
>       if (atomic_dec_return(&box->refcnt) == 0) {     /* :1293: probe's
>                                                          ref is the only
>                                                          one -> 0 */
>               uncore_box_exit(box);
>               kfree(box);                             /* :1295 */
>       }
> 
>   Interleaving: H reads box at :1523, P NULLs the slot and drops the
>   refcount to zero and kfrees; H continues on freed memory:
>   - uncore_pmu_cancel_hrtimer() (uncore.c:356) -> hrtimer_cancel() ->
>     lock_hrtimer_base() reads the freed timer->base and then
>     raw_spin_locks whatever address that freed word now holds (GPF or
>     a lockup on reuse; KASAN would report the UAF read);
>   - perf_pmu_migrate_context() (kernel/events/core.c:14467) runs
>     while the PMU itself may be getting unregistered by the same
>     remove (its __perf_pmu_install_event() -> find_get_pmu_context()
>     dereferences pmu->cpu_pmu_context -- converging with the consumer
>     side of my previous report);
>   - :1549-1550 write box->cpu/cpumask into freed slab.
> 
>   Online variant: allocate_boxes() (:1612) checking and installing
>   pmu->boxes[die] races the same read-out/NULL/kfree on removal,
>   yielding a double box in one slot or a dangling slot; note that the
>   WARN_ON_ONCE against an occupied slot added by the 7.3 refactor
>   (:1206) guards the probe path, not this one.
> 
> * Evidence
> 
>   - Source-level: the analysis above is on current 7.3, function by
>     function; the lock inventory of uncore.c is unchanged by the
>     refactor (no serialization exists or was added between the hotplug
>     callbacks and the PCI callbacks), and the hotplug side demonstrably
>     takes no box reference for PCI types (its ref/unref helpers are
>     only invoked on the msr/mmio arrays).
>   - Dynamic, NEGATIVE (this is the half I could run without uncore
>     hardware): the perf-core transmission chain the migration funnels
>     into -- perf_pmu_migrate_context() vs concurrent
>     perf_pmu_unregister()/register() with in-flight event creation and
>     CPU hotplug -- was stress-tested on the KASAN kernel with the
>     attached module's migunreg/migopen actions (300 rounds each,
>     sequential unregister/register + migrate hammer + open/close
>     hammer + CPU offline/online loops): ZERO KASAN reports in both
>     configurations.  The existing SRCU + IDR/list removal ordering +
>     context locks protect the perf-core side; the unprotected part is
>     precisely the uncore-layer box lifetime this report describes.
>     (The third configuration with concurrent register churn reaches
>     the register/unregister race of my previous report first, as
>     expected.)
>   - Real-hardware trigger (root, multi-die, e.g. SKX):
> 
>       # terminal A: offline/online a collecting CPU of the die
>       while :; do
>         echo 0 > /sys/devices/system/cpu/cpuN/online
>         echo 1 > /sys/devices/system/cpu/cpuN/online
>       done
>       # terminal B: unbind/rebind the same die's uncore box
>       while :; do
>         echo <bdf> > /sys/bus/pci/drivers/skx_uncore/unbind
>         echo <bdf> > /sys/bus/pci/drivers/skx_uncore/bind
>       done
>       # expected with KASAN: use-after-free in
>       # uncore_change_type_ctx / uncore_pmu_cancel_hrtimer /
>       # lock_hrtimer_base; or a double box in pmu->boxes[die]
> 
>   My test environment provides no Intel uncore PCI devices, so the
>   H x P interleaving itself is source-proven, not dynamically
>   reproduced.
> 
> 
> Thanks for taking a look.
> 
> 
> Regards,
> Hanxiang Xu
> xuhx@hust.edu.cn

