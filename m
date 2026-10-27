Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102604;
	b=QHuVNbmgkEUkzuHGmJ9Gkl7iL8IoomT74fSaVwXa2RBy9uDQqLfxAgKAW3YVUUfXr9Y6
	 nEorHl968M0AjNyXC2GQW8ZxJFPLvAcbIZ0wT4Oi55/tulO6SAVHaydZBY5ubOcnCp0cV
	 qvv+B1SDJKTXoN8LIkM0dBlwzT/jOAYsQ0pLZbDSj9PDrtvo3tniNTI3ilgjJeDuulhXh
	 IMWrW0inMWXyiseiCAh1cF7FEJGk/HOZekq+JJalkMPChtLBeJ3leAmJh3ZZDGWQ5Jt6E
	 Le+EOVdRTh+IWdmpwO3DhlVXYPUrYUTtaiCBBR8MC+2WyHIOn1gr+F1/W3sTazeeE0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102604;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=StGIwkSlbsvFpESfZoYYNmkaJJMniuExQndwnG+ei5o=;
	b=hlM7/O9suVML7ujfQfkeliuDfFQ/71GjbjSoxPqUh7SKoN951AIHA9NAx3Mwa3Z/HxSA
	 iieWEhrXlXwFiHV2fjF51pRw7q4PbjIWztLGstDzPWwMCplVFMtpVspgtpTliX3f2UMEm
	 If+HWgKk4c+0b+90oGiV8FBkGDg0BCA5Sz3schTbrtMK5BUMvixxFHxzNsBQkY1Jj3fqE
	 AzR87NcFisU/YP1tXuDsRPm9GdxdG+vWujwHvlkXsaQ9doOeCJpZqCoSrwbdgLlsa5VPa
	 2YqTSi9p2ngX+z2IR060CYoS7I/b9Tla7HewP7z6orIi0A2CQYqwAoIDpbcCBqnKicA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OPqYh83d;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D243660A3822;
	Tue, 27 Oct 2026 12:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D243660A3822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OPqYh83d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793102604; x=1824638604;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=StGIwkSlbsvFpESfZoYYNmkaJJMniuExQndwnG+ei5o=;
  b=OPqYh83dSp0QxmvENU/j/5xwVB0IE1viVjg6wWJtP81GvUtdWRksIirY
   8mJAkXu64+qyaCI4sDlj5xjHepITCOPSzmBERqTnPTWv8HrdYjPhufNON
   deSmrdOhIX4qAojbtyd6mAS62rq3A9Y3kfebhe8e30gd9DaYPns0XbZfT
   7afXI0WLJIhnru1JjgUMerjdtk0VHu199Z4nTqBfhe/M7+Klbx36LiZFH
   Y+6dIkxMivyPFG63OhqrB9f+5EuD7LFBxwUdzDUJ6GCYhf9IleLBD4E33
   WmD34vgdgDaTs5UN1+XAVAoFIPDrvq6lmat63JQIbmC1E0QP6UBz+r0QN
   A==;
X-CSE-ConnectionGUID: v0v63rDCSwq9sYMQoGfazA==
X-CSE-MsgGUID: EIeQMqQvT9Kj0VWFbvUbvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1681180"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1681180"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:03:23 -0700
X-CSE-ConnectionGUID: 9TXP2Om7TXCg3dEKLNyiZg==
X-CSE-MsgGUID: Lycma6y2SjKZYJo0hswuiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4864656"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:03:21 -0700
Message-ID: <62005e0e-8963-4565-bdcd-cfcd5e925674@linux.intel.com>
Date: Tue, 27 Oct 2026 20:03:17 +0800
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
Subject: Re: perf: perf_pmu_free() kfree()s struct perf_cpu_pmu_context while
 its mux hrtimer is still queued (use-after-free)
To: =?UTF-8?B?5b6Q5pmX57+U?= <xuhx@hust.edu.cn>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ca4f133.14714.1a162b8654c.Coremail.xuhx@hust.edu.cn>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <ca4f133.14714.1a162b8654c.Coremail.xuhx@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/22/2026 4:26 PM, 徐晗翔 wrote:
> perf_pmu_free() frees every non-embedded struct perf_cpu_pmu_context
> with a plain kfree() without cancelling cpc->hrtimer first, so
> unregistering a PMU whose multiplexing hrtimers are queued leaves live
> hrtimers linked into the per-CPU timer rbtree pointing into freed
> memory -- a use-after-free (confirmed by KASAN) that is reachable with
> two sequential root operations and no scheduling race at all.
> perf_pmu_free() in kernel/events/core.c releases the per-CPU PMU
> contexts without any hrtimer quiescence, while several ordinary code
> paths leave cpc->hrtimer queued on CPUs without any event attached.
>
>
> Unregistering the PMU then frees the cpc objects under the queued
> timers: every later hrtimer insertion/removal on the affected CPUs
> reads and writes freed rbtree nodes, and at expiry __run_hrtimer()
> calls perf_mux_hrtimer_handler() on the freed cpc, taking the freed
> cpc->hrtimer_lock and writing cpc->hrtimer_active. Verified and
> reproduced on mainline 7.3 with KASAN; the involved code is unchanged
> since at least 7.1. Triggering requires only root sysfs writes plus a
> runtime PMU unregister (unloadable PMU driver module or, on matching
> hardware, Intel uncore PCI unbind).
>
>
> The detailed description:
>
>
> * Test environment / affected version
>
> Linux version 7.3.0 (gcc 13.3.0, GNU ld 2.42) #1 SMP PREEMPT_DYNAMIC
> -- vanilla mainline 7.3 release tarball (kernel.org, unmodified),
> rebuilt with CONFIG_KASAN_GENERIC=y, CONFIG_KASAN_OUTLINE=y,
> CONFIG_KASAN_VMALLOC=y, CONFIG_PERF_EVENTS=y, CONFIG_MODULES=y,
> CONFIG_HZ_1000=y, CONFIG_HOTPLUG_CPU=y, booted in QEMU/KVM on x86_64
> (4 vCPU). The same defect code is present and identical in 7.1.5
> (verified by function-level diff); the 7.3 line numbers below are
> from the 7.3 tarball.
>
>
> * Mechanism
>
> 1. Writing /sys/bus/event_source/devices/<pmu>/perf_event_mux_interval_ms
> takes the perf_event_mux_interval_ms_store() path
> (kernel/events/core.c:12615). For every online CPU it stores the
> new interval into cpc->hrtimer_interval and then calls
> cpu_function_call(cpu, perf_mux_hrtimer_restart_ipi, cpc)
> (core.c:12643). perf_mux_hrtimer_restart_ipi() ->
> perf_mux_hrtimer_restart() arms cpc->hrtimer based solely on
> hrtimer_active(), regardless of whether the PMU has any events:
> an *idle* PMU ends up with a queued mux hrtimer on every online
> CPU after one ordinary sysfs write.
>
>
> 2. Unregistering the PMU (perf_pmu_unregister() ->
> perf_pmu_free(), core.c:12805) walks all possible CPUs and frees
> the contexts:
>
> cpc = *per_cpu_ptr(pmu->cpu_pmu_context, cpu);
> if (!cpc)
> continue;
> if (cpc->epc.embedded) { /* refcount managed */
> put_pmu_ctx(&cpc->epc);
> continue;
> }
> kfree(cpc);
>
> There is no hrtimer_cancel() (or any hrtimer call at all) in
> perf_pmu_free(), perf_pmu_unregister(), or anywhere else on the
> unregister path. The queued cpc->hrtimer stays linked in each
> CPU's MONOTONIC rbtree after the kfree().
>
>
> 3. Consequences, both observed:
> - Immediately after the free: any hrtimer queued on an affected
> CPU walks/rotates the rbtree through the freed node; KASAN
> reports slab-use-after-free in rb_erase/rb_insert_color/
> timerqueue_add/__remove_hrtimer (reads *and writes of freed
> memory, corrupting both the timer tree and the slab's new
> owner).
> - At expiry (interval after the free): __run_hrtimer() reads
> timer->function from freed memory and runs
> perf_mux_hrtimer_handler() (core.c:1278) on the freed cpc: it
> calls perf_rotate_context(), takes the freed cpc->hrtimer_lock
> and writes cpc->hrtimer_active. KASAN reports the UAF in hard
> IRQ context (swapper/N).
> The embedded variant (put_pmu_ctx() at core.c:5277 ->
> free_cpc_rcu() at core.c:5262) defers the kfree by one RCU grace
> period but equally never cancels the timer, so the window merely
> shifts; the plain-kfree path above needs no events to have ever
> been opened on the PMU.
>
>
> * How to reproduce (deterministic, ~30 seconds)
>
> A minimal PMU driver registered through the exported perf core API
> (perf_pmu_register/perf_pmu_unregister, EXPORT_SYMBOL_GPL) -- the
> same lifecycle an unloadable PMU provider module or an Intel uncore
> PCI driver (arch/x86/events/intel/uncore.c, uncore_pci_pmu_
> unregister() in 7.3) goes through. Module source is inlined at the
> end of this mail; usage:
>
> # build against the kernel under test
> make -C <kernel-build-dir> M=$PWD modules
>
> # in the guest (root):
> insmod r6_repro.ko
> echo register > /sys/module/r6_repro/parameters/action
> echo 10000 > /sys/bus/event_source/devices/r6pmu/perf_event_mux_interval_ms
> echo unregister > /sys/module/r6_repro/parameters/action
> # wait up to 10 s for expiry (or just keep the system busy);
> # KASAN splats start immediately after 'unregister'
>
>
> There is no interleaving window: register -> sysfs write ->
> unregister is purely sequential. On the 4-vCPU KASAN VM this
> produced 72 KASAN slab-use-after-free reports within ~10 seconds of
> the unregister (histogram: rb_insert_color 19, rb_erase 18,
> perf_mux_hrtimer_handler 12, timerqueue_linked_add 5,
> rb_erase_linked 5, __hrtimer_run_queues 4, _raw_spin_lock/unlock 6,
> __remove_hrtimer 2, hrtimer_start_range_ns 1).
>
>
> * KASAN report (expiry-path witness, one of 72)
>
> BUG: KASAN: slab-use-after-free in perf_mux_hrtimer_handler+0x8b/0x5e0
> Read of size 8 at addr ff11000001d09600 by task swapper/2/0
> CPU: 2 UID: 0 PID: 0 Comm: swapper/2 ... 7.3.0 #1 PREEMPT(lazy)
> <IRQ>
> perf_mux_hrtimer_handler+0x8b/0x5e0
> __hrtimer_run_queues+0x166/0x340
> hrtimer_interrupt+0x1d2/0x320
> __sysvec_apic_timer_interrupt+0x62/0x1a0
> sysvec_apic_timer_interrupt+0x66/0x80
> </IRQ>
>
>
> Allocated by task 29:
> __kmalloc_cache_node_noprof+0x17c/0x3a0
> perf_pmu_register+0x196/0x5a0
> action_workfn+0x17b/0x230 [r6_repro]
>
>
> Freed by task 48:
> kfree+0x121/0x390
> perf_pmu_free+0xc2/0x190
> perf_pmu_unregister+0x497/0x620
> action_workfn+0x217/0x230 [r6_repro]
>
>
> The object is a struct perf_cpu_pmu_context (kmalloc-256, KASAN
> tracks the allocation inside the per-CPU loop of
> perf_pmu_register()). The full serial log (72 reports, all three
> stacks for each) is available on request.
> Thanks for taking a look.

The analysis looks reasonable, we need to cancel the hrtimer before freeing
the cpc for each cpu if the corresponding hrtimer is active.

Would post a patch to fix the issue later. Thanks.


>
