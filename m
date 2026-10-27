Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123774;
	b=Smb/NG0UMZ5efml+1qTIjhkxOTAxPeqWJ7huRazbeM+2heNaMqTcv8VBO0Y0ghXE6+Sg
	 soFfMRhTVrmzPZn9rSwkSnT4tVk2phGkv1CCa+rbVIA3vFwIU6RdZ5O0pUCDJJyJDKzDZ
	 Qul1bemNPMS53f39AXv/HO36kV4iM7UDXgl3rFHORo9+/CKfdgp3kvPVunNKGHFEG4/Av
	 q/7boxW5GNBr7s5ZQ9rdwP2k6fP0i/5sIA2rTXifXmmFmY3DGBwyiQWDsd9RreTo5mzZR
	 6OB7Oy3P6tuLjphRgbHaXth+vDdghFsVQ0iNgCDz8JXJClW98tMS0Ezg3Zv7447iV6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123774;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=TwZPhhWnOHsrM+akV6TsVz4l9xyPtmtL0e+mtnQvrZ0=;
	b=07tWaI6g3I61gbpS6O+2bqdZZDFqknwmZAM90dpbUzBWICqDBd05iS21rWJjqeFZY7Jp
	 nCL2mXPUDzgjMU3bGod3Jwmft4E/TaA3yYot7u05BfpmYZsKYSzVdIsCBiswqGaBLVmHk
	 dNx8KAkatvBKVlTyhxCBlIPt/oiIIeUymKJM1LzMfKEV0kVncVy42BbMXGSTkzmtkVMlp
	 mPo43L01Ph35v7WVjMJy2wzEiyb1ZKoh6xehjEcav+mt1QXP8VOTs40OY2lNqTD5oT+so
	 KvWfLO/cUJOJBVAl4HlP8MQRpXGxcRjaWgMnryxv2rbmnxBgtPcgVB2AQhJM8tSbi2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jjEFOtm+;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EEF606A31D;
	Tue, 27 Oct 2026 17:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53EEF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jjEFOtm+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793123773; x=1824659773;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CAoqhHX17Pd2Yh7QC3UEHgYwXp6Fy94qSaDW+iu08S8=;
  b=jjEFOtm+1wDiH90IdkuVgaGw1kKbmuO2dxJal/AdwxfBF+2rjLLyVNbZ
   s00PPRkEQVEEBJnPKaItbsYazrtuZzGJc2Q4FQ6vuPJzFXnkl9nsAdYA0
   kD/XyXIlmmEpUR8YQCu864S1ZCHx4vua+OPP7V+KpeOKpclUydV0W/PDt
   7BOYCj8axoyAyxnz+8HqrQfk8HegyASDNCMXxYwWx/IEOwjdKCzQm8lke
   juQ90vtnWTn0ztaCTK7I+7K/XrB+XlmUdN3cotdre/QPkiAd5NtAXp57N
   lyszL9R7lHaurL6SLrrswaunCR9YjKvo2kVz6XkaKHPPLRkYH3ZO/2JkS
   A==;
X-CSE-ConnectionGUID: tmrtbqcVSyizOksOJuafdQ==
X-CSE-MsgGUID: /DmjPFHxTRCIPcfvGOCOVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1722469"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1722469"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 10:56:13 -0700
X-CSE-ConnectionGUID: 6OL92qoLQTuGxG4VUX6WZQ==
X-CSE-MsgGUID: TmGw8tuhRnGjpDMBNlgoHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4668995"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 10:56:12 -0700
Message-ID: <a69eed6e-a812-43ad-bedc-3f0f68a47d0e@intel.com>
Date: Tue, 27 Oct 2026 12:56:11 -0500
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
Subject: Re: perf/uncore: activeboxes count TOCTOU lets PCI probe/remove run
 perf_pmu_register() and perf_pmu_unregister() concurrently on the same struct
 pmu
To: =?UTF-8?B?5b6Q5pmX57+U?= <xuhx@hust.edu.cn>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <78d9ba61.14c08.1a163e7b794.Coremail.xuhx@hust.edu.cn>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <78d9ba61.14c08.1a163e7b794.Coremail.xuhx@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Hanxiang,

Thanks for bringing up this long-standing uncore issue.

Yes, I agree that a lock is needed to serialize uncore PMU registration
and teardown.

It seems perf_pmu_{register,unregister}() expects individual PMU drivers
to manage the lifecycle of struct pmu and won't call
perf_pmu_{register,unregister}() concurrently on the same object.

During unregister's unlocked grace window, a concurrent
perf_pmu_register() reinitializes the PMU context, which the resuming
unregister tail then frees, corrupting the core state.

Intel Uncore is unique in implementing an N-to-1 model where multiple
PMON boxes across different dies share a single struct pmu instance.
Without a lock, concurrent probe and remove races across dies can happen.

I have been working on a series of uncore bug fixes, and this patch will
be included in the patch series that I will post to LKML shortly.

Thanks,
Zide


On 10/22/2026 8:58 AM, 徐晗翔 wrote:
> The uncore PCI driver decides "first active box registers the PMU" and
> "last active box unregisters the PMU" with nothing but the
> pmu->activeboxes counter -- the decision and the perf_pmu_register()/
> perf_pmu_unregister() execution are not serialized -- so on a multi-die
> platform whose same-typed boxes live on different dies, concurrently
> removing the last box of one die and probing a box of another die runs
> register and unregister on the SAME struct pmu at the same time; the
> unregister side's unlocked tail (two grace periods, then idr_remove()
> re-reading pmu->type and perf_pmu_free() reading pmu->dev and
> pmu->cpu_pmu_context) then consumes whatever the concurrent register
> just published, and the kernel oopses or leaves a PMU in the list
> holding freed per-CPU contexts.  The perf-core half of this is
> confirmed dynamically on mainline 7.3 (first concurrency round:
> page fault oops inside perf_pmu_unregister); the uncore-side trigger
> is source-proven on 7.3's current (recently refactored) code, which
> added box refcounting and a PMU_BROKEN state but still no
> serialization of this decision path.
> 
> Both decision sites are counter-only on 7.3 (arch/x86/events/intel/
> uncore.c): uncore_box_setup() at :1153 skips registration when
> atomic_inc_return(&pmu->activeboxes) > 1 (:1166), otherwise calls
> uncore_pmu_register() (:926); uncore_pci_pmu_unregister() at :1283
> calls uncore_pmu_unregister() (:960) when atomic_dec_return(...) == 0
> (:1291).  Meanwhile the perf core is asymmetric: perf_pmu_register()
> (kernel/events/core.c:12836) holds pmus_lock for its whole body
> (guard at :12841), while perf_pmu_unregister() (:13023) holds it only
> for the idr_cmpxchg/list_del section (:13025-13029) and for the final
> idr_remove (:13056-13057) -- between and after them the two
> synchronize_srcu()/synchronize_rcu() grace periods (:13042-13043),
> the idr_remove() that re-reads pmu->type, and perf_pmu_free()
> (:13068, reading pmu->dev/pmu->cpu_pmu_context and freeing them) all
> run unlocked for tens of milliseconds.  Triggering needs a multi-die
> host with id-table uncore PCI drivers (snbep/skx families) and
> concurrent sysfs unbind/rescan (or a hotplug/DPC event racing an
> admin operation) -- root actions, but each entirely legitimate.
> 
> The detailed description:
> 
> * Test environment / affected version
> 
>   Linux version 7.3.0 (gcc 13.3.0, GNU ld 2.42) #1 SMP PREEMPT_DYNAMIC
>   -- vanilla mainline 7.3 release tarball (kernel.org, unmodified),
>   rebuilt with CONFIG_PERF_EVENTS=y, CONFIG_PERF_EVENTS_INTEL_UNCORE=y,
>   KASAN enabled, QEMU/KVM x86_64 guest.  The perf-core functions
>   cited are byte-identical in 7.1.5 and 7.3; the uncore functions were
>   refactored during 7.3 (box refcounting, PMU_BROKEN stickiness,
>   WARN_ON_ONCE against double probe at :1206) -- the refactor did NOT
>   add any lock (the file's lock inventory is unchanged), and the
>   counter-only decision shape survives it.  Line numbers below are
>   from 7.3.
> 
> * Mechanism
> 
>   1. Counter-only decisions, no lock between decision and execution:
> 
>          uncore_box_setup()              /* uncore.c:1153 */
>              ...
>              if (atomic_inc_return(&pmu->activeboxes) > 1)   /* :1166 */
>                      return 0;
>              ret = uncore_pmu_register(pmu);                 /* first
>                                                                 box */
> 
>          uncore_pci_pmu_unregister()    /* uncore.c:1283 */
>              pmu->boxes[die] = NULL;
>              if (atomic_dec_return(&pmu->activeboxes) == 0)  /* :1291 */
>                      uncore_pmu_unregister(pmu);             /* last
>                                                                 box */
> 
>      Two different PCI devices' probe and remove callbacks (per-device
>      locks only; sysfs bind/unbind/rescan are not mutually exclusive)
>      can hold both decisions simultaneously: remove drops die0's last
>      box to 0 and decides "unregister" while probe brings die1's box
>      from 0 to 1 and decides "register" -- same struct intel_uncore_pmu
>      (type->pmus[] is shared across dies for id-table types).
> 
>   2. The register side rewrites the shared struct pmu from scratch:
>      uncore_pmu_register() (:926) assigns the whole template
>      (clearing ->dev, ->type, ->cpu_pmu_context) before calling
>      perf_pmu_register(), which then creates a NEW device, allocates a
>      NEW type id and a NEW percpu context array, and publishes them.
> 
>   3. The unregister side's unlocked tail reads what register just
>      published.  With A = remove(die0) and B = probe(die1):
> 
>        A: perf_pmu_unregister() locks pmus_lock, idr_cmpxchg + list_del
>           (:13025-13029), UNLOCKS, enters two grace periods
>           (:13042-13043)                            -- tens of ms
>        B: uncore_pmu_register() resets the struct, perf_pmu_register()
>           (holding pmus_lock the whole time) creates device D2, type
>           T2, contexts P2; INIT event list; publishes; returns 0
>        A: resumes: idr_remove(&pmu_idr, pmu->type)  /* :13056-13057,
>           re-reads pmu->type == T2 -> deletes B's fresh entry */
>           perf_pmu_free(pmu)                        /* :13068: reads
>           pmu->dev == D2 -> device_del/put; reads pmu->cpu_pmu_context
>           == P2 -> kfrees B's fresh contexts + free_percpu */
> 
>      End states: a PMU still on the pmus list whose IDR entry is gone
>      and whose contexts are freed (later perf_event_open() reaching
>      find_get_pmu_context() walks freed memory), or the mirror
>      interleaving where A's cmpxchg consumes B's registration wholesale
>      (the active PMU vanishes; event creation fails with ENODEV until
>      rebind).  uncore_pmu_unregister() (:960-967) also ignores
>      perf_pmu_unregister()'s return value, so the -EINVAL variant
>      leaves a half-torn state machine in place.
> 
> * Evidence (7.3)
> 
>   - Source-level, uncore side: the decision paths above contain no
>     serialization on current 7.3 (verified function-by-function; the
>     7.3 refactor touched exactly these functions without adding a
>     lock).  Real-hardware trigger: concurrent
>       echo <bdf0> > /sys/bus/pci/drivers/skx_uncore/unbind
>       echo 1     > /sys/bus/pci/rescan
>     on a multi-die host.
>   - Dynamic, perf-core half (reproducer attached, pmu_race.c): its
>     "race" action starts two kthreads faithfully mirroring both sides
>     -- an unregister loop and a register loop that performs the same
>     whole-struct reset uncore_pmu_register() does before each
>     perf_pmu_register(), on the same struct pmu.  On the 4-vCPU KASAN
>     VM the FIRST concurrency round (seconds into the run) ends in:
> 
>         CPU: 0 ... Comm: pmu_race_unreg
>         RIP: 0010:perf_pmu_unregister+0x1cb/0x620
>         #PF: supervisor read access ... address fffffffffffffe08
> 
>     reading a pointer derived from the concurrently rewritten pmu
>     fields; the unregister thread dies and the race never converges.
>     (Same signature on 7.1.5 at +0x1d3; the code between is
>     identical.)  Usage:
> 
>       insmod pmu_race.ko
>       echo "race 2000" > /sys/module/pmu_race/parameters/action
>       echo status > /sys/module/pmu_race/parameters/action
> 
>     QEMU provides no uncore PCI devices, which is why the uncore-side
>     trigger is presented source-level and the perf-core concurrency
>     (the half both sides funnel into) is what the reproducer drives.
> 
> 
> Thanks for taking a look.
> 
> 
> Regards,
> Hanxiang Xu
> xuhx@hust.edu.cn

