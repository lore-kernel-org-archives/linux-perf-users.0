Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A02A145B16;
	Tue, 30 Sep 2025 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759213174; cv=none; b=ZvLrN0uPrKw1sjHoW9H8M3Ex6HNmZbDG8vzw821DTlaKiimyXiPrSgEZNvZZQYM7b5oqd9ZpIcZHfgyKqmIB1X2GuunoOxnIlRGWpn9n36IZejQy6LRGPOnMoeTUekq7fPhgWexQDDnoZ1zWQUCHkLsDuzhuPoip6Ctk0mF9ZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759213174; c=relaxed/simple;
	bh=PPkxk9Ep+4bcuEH85FQbkyA99ebVVgKHjiMmQ6tF2QI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=VOaxcBqYQH7EzHmsJt2LEFebU1KtjI9t4/W7x4pRM88Dzy/rgXItgzTOQNv/B9F+IejEdWvRkpIp0lV+K46FOgxqlxrYvoDuuSYXFt1m+QCOpCdXJ7uBZABtSMqP2HmR27SVzhwiwx9hDDCeTqNkF5aPGpaubffSyirz853aD7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+JqQ7kg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+JqQ7kg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759213173; x=1790749173;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=PPkxk9Ep+4bcuEH85FQbkyA99ebVVgKHjiMmQ6tF2QI=;
  b=Y+JqQ7kgvJI50OH1gNDyek9QgN1OkTploEfIXmJyTw9rGBPiOgU6mJjV
   VjpUkyQZhS/bEkMq0YQ24HJU1NES0iiJuuV2nUCmwLh1pTlpiVlBwz6Eq
   E1k5W+VFEWVLcBzHuYmMGdv8STcogyIFsH7MDh+x5gSLGnpCRM8aY5pdr
   /cvAelzd2vE+NdMolWEdqcNBA3eVoUnt+beQ14lZG3y+HFq4uV4Hz8z+/
   I7guneyu6IyH9j93MmecAnUkVWil4tzIIiotVOfuajsw+9pbdtobBMno7
   8SF9P7ash3MW+c4dNo6PHlbULDONBnnBSFyYmXnSh8P111A8DLklTtSda
   w==;
X-CSE-ConnectionGUID: wtIP3UxtSeG4LVpf31/Kow==
X-CSE-MsgGUID: uxggPG5zSw+ep3Sm/9vJrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="65318461"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208,223";a="65318461"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 23:19:32 -0700
X-CSE-ConnectionGUID: eVkiAFdAR9SIbzTPTiUZJQ==
X-CSE-MsgGUID: 8q3deDqDTqGKaRWQYAqsSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208,223";a="178821060"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.209]) ([10.124.232.209])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 23:19:28 -0700
Content-Type: multipart/mixed; boundary="------------noBps4QEKNLJXvRP2Vz7n39u"
Message-ID: <6c4a3b2b-d207-466e-bd58-05566f36e1a4@linux.intel.com>
Date: Tue, 30 Sep 2025 14:19:25 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v7 02/12] perf/x86/intel: Fix NULL event access and
 potential PEBS record loss
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <202509081646.d101cfb7-lkp@intel.com>
 <e92a703d-6a92-474c-acba-b15176b97548@linux.intel.com>
 <bd48852d-e5d3-4d58-9d71-891a4e31dd5b@linux.intel.com>
 <aNtoZ3bJ5OmGAMT0@xsang-OptiPlex-9020>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aNtoZ3bJ5OmGAMT0@xsang-OptiPlex-9020>

This is a multi-part message in MIME format.
--------------noBps4QEKNLJXvRP2Vz7n39u
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/30/2025 1:19 PM, Oliver Sang wrote:
> hi, Dapeng,
>
> On Sun, Sep 28, 2025 at 02:00:28PM +0800, Mi, Dapeng wrote:
>> Hi Oliver,
>>
>> Could you please help to validate the attached patch? The patch should fix
>> this warning. (Please apply this patch on top of the whole patch series).
>> Thanks.
> the patch doesn't fix the warning [1]. one dmesg is attached FYI.
>
> BTW, I applied this patch on top of the patch set, and the patch set itself
> is applied upon f49e1be1954248. as below.
> if any problem, please let us know. thanks
>
> * f7171f90cc3a45 perf/x86/intel: Fix NULL event access waring from test robot
> * 81248d31dd384c perf/x86/intel: Add counter group support for arch-PEBS
> * c4dd1608098ec0 perf/x86/intel: Setup PEBS data configuration and enable legacy groups
> * de78881cd5ac79 perf/x86/intel: Update dyn_constranit base on PEBS event precise level
> * f560ef321b0632 perf/x86/intel: Allocate arch-PEBS buffer and initialize PEBS_BASE MSR
> * 5411e99084e21d perf/x86/intel: Process arch-PEBS records or record fragments
> * d721d0d90c7b30 perf/x86/intel/ds: Factor out PEBS group processing code to functions
> * 0cd78a2875e1ab perf/x86/intel/ds: Factor out PEBS record processing code to functions
> * cc5755ee9b8bb2 perf/x86/intel: Initialize architectural PEBS
> * 995af2a15982ff perf/x86/intel: Correct large PEBS flag check
> * fa9540afb72301 perf/x86/intel: Replace x86_pmu.drain_pebs calling with static call
> * a7138973beb1d1 perf/x86/intel: Fix NULL event access and potential PEBS record loss
> * 0c9567b36ae6f8 perf/x86: Remove redundant is_x86_event() prototype
> * f49e1be1954248 perf/x86: Print PMU counters bitmap in x86_pmu_show_pmu_cap()
>
> commit f7171f90cc3a45627643d4eadd204e2b8f45e540
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Date:   Sun Sep 28 13:50:47 2025 +0800
>
>     perf/x86/intel: Fix NULL event access waring from test robot
>
>     This patch fixes the warning about
>     https://lore.kernel.org/all/202509081646.d101cfb7-lkp@intel.com/.
>
>     Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 65908880f4244..ef32714cb1822 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2821,8 +2821,11 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>                  * If collision happened, the record will be dropped.
>                  */
>                 if (pebs_status != (1ULL << bit)) {
> -                       for_each_set_bit(i, (unsigned long *)&pebs_status, size)
> +                       for_each_set_bit(i, (unsigned long *)&pebs_status, size) {
>                                 error[i]++;
> +                               if (error[i] && !events[i])
> +                                       events[i] = cpuc->events[i];
> +                       }
>                         continue;
>                 }

Oops, it looks previous fix was incomplete. :(

Oliver, could you please verify the new attached patch (Please apply this
patch on top of the whole patch series)? Thanks a lot for your effort. 

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 65908880f424..3dedf7a0acf6 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2781,9 +2781,11 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs
*iregs, struct perf_sample_d
 
         /* PEBS v3 has more accurate status bits */
         if (x86_pmu.intel_cap.pebs_format >= 3) {
-            for_each_set_bit(bit, (unsigned long *)&pebs_status, size)
+            for_each_set_bit(bit, (unsigned long *)&pebs_status, size) {
                 counts[bit]++;
-
+                if (counts[bit] && !events[bit])
+                    events[bit] = cpuc->events[bit];
+            }
             continue;
         }
 
@@ -2821,8 +2823,11 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs
*iregs, struct perf_sample_d
          * If collision happened, the record will be dropped.
          */
         if (pebs_status != (1ULL << bit)) {
-            for_each_set_bit(i, (unsigned long *)&pebs_status, size)
+            for_each_set_bit(i, (unsigned long *)&pebs_status, size) {
                 error[i]++;
+                if (error[i] && !events[i])
+                    events[i] = cpuc->events[i];
+            }
             continue;
         }


>
>
>
>
> [1]
> [  101.198733][    C0] ------------[ cut here ]------------
> [  101.198737][    C0] WARNING: CPU: 0 PID: 2770 at arch/x86/events/intel/ds.c:2849 intel_pmu_drain_pebs_nhm+0x589/0x630
> [  101.198758][    C0] Modules linked in: xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bridge stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio qrtr sg binfmt_misc loop fus
> e dm_mod overlay btrfs blake2b_generic xor raid6_pq intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_eda
> c_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel irdma ice kvm sd_mod ast irqbypass snd_pcm gnss ghash_clmulni_intel drm_c
> lient_lib snd_timer drm_shmem_helper rapl ib_uverbs snd ipmi_ssif ahci drm_kms_helper intel_cstate soundcore libahci mei_me acpi_power_meter i2c_i801 ioat
> dma intel_uncore drm ib_core pcspkr libata ipmi_si acpi_ipmi mei joydev i2c_smbus intel_pch_thermal lpc_ich dca wmi ipmi_devintf ipmi_msghandler acpi_pad
> [  101.198862][    C0] CPU: 0 UID: 0 PID: 2770 Comm: perf Tainted: G S                  6.17.0-rc1-00063-gf7171f90cc3a #1 VOLUNTARY
> [  101.198871][    C0] Tainted: [S]=CPU_OUT_OF_SPEC
> [  101.198873][    C0] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> [  101.198877][    C0] RIP: 0010:intel_pmu_drain_pebs_nhm+0x589/0x630
> [  101.198885][    C0] Code: 48 e8 1b bd fe ff 85 c0 0f 84 a9 00 00 00 41 f6 84 24 a4 01 00 00 80 0f 84 9a 00 00 00 4c 89 ef e8 bc 29 34 00 e9 a9 fc ff ff
>  <0f> 0b e9 a2 fc ff ff 0f 0b e9 9b fc ff ff 48 8b 04 cb 48 89 84 cc
> [  101.198890][    C0] RSP: 0018:fffffe000000d8c0 EFLAGS: 00010046
> [  101.198895][    C0] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000001
> [  101.198898][    C0] RDX: 0000000000000001 RSI: 0000000000000004 RDI: fffffe000000d900
> [  101.198901][    C0] RBP: fffffe000002c0c8 R08: 0000000000000001 R09: 0000000000000000
> [  101.198904][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> [  101.198905][    C0] R13: 0000000000000000 R14: fffffe000000dc80 R15: 0000000000000001
> [  101.198908][    C0] FS:  00007f96c7747840(0000) GS:ffff88bffb7e0000(0000) knlGS:0000000000000000
> [  101.198913][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  101.198916][    C0] CR2: 00000000004ac270 CR3: 000000021df93005 CR4: 00000000007727f0
> [  101.198920][    C0] PKRU: 55555554
> [  101.198922][    C0] Call Trace:
> [  101.198927][    C0]  <NMI>
> [  101.198942][    C0]  handle_pmi_common+0x2e1/0x4b0
> [  101.198965][    C0]  intel_pmu_handle_irq+0x109/0x2b0
> [  101.198967][    C0]  perf_event_nmi_handler+0x2a/0x70
> [  101.198974][    C0]  nmi_handle+0x53/0x130
> [  101.198979][    C0]  default_do_nmi+0x11d/0x170
> [  101.198988][    C0]  exc_nmi+0x106/0x1b0
> [  101.198990][    C0]  end_repeat_nmi+0xf/0x53
> [  101.198995][    C0] RIP: 0010:clear_bhb_loop+0x5e/0x80
> [  101.198997][    C0] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>  <b8> 05 00 00 00 eb 01 90 83 e8 01 75 f8 83 e9 01 75 bb c3 cc cc cc
> [  101.198998][    C0] RSP: 0018:ffffc90025163f30 EFLAGS: 00000002
> [  101.199000][    C0] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000004
> [  101.199001][    C0] RDX: 0000000000000000 RSI: 0000000000000010 RDI: ffffc90025163f58
> [  101.199002][    C0] RBP: ffffc90025163f48 R08: 0000000000000000 R09: 0000000000000000
> [  101.199004][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [  101.199004][    C0] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  101.199007][    C0]  ? clear_bhb_loop+0x5e/0x80
> [  101.199010][    C0]  ? clear_bhb_loop+0x5e/0x80
> [  101.199011][    C0]  </NMI>
> [  101.199012][    C0]  <TASK>
> [  101.199012][    C0]  ? clear_bhb_loop+0x30/0x80
> [  101.199014][    C0]  ? clear_bhb_loop+0x30/0x80
> [  101.199016][    C0]  ? clear_bhb_loop+0xe/0x80
> [  101.199017][    C0]  ? entry_SYSCALL_64_after_hwframe+0x71/0x7e
> [  101.199020][    C0]  </TASK>
> [  101.199020][    C0] ---[ end trace 0000000000000000 ]---
>
>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 65908880f424..ef32714cb182 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -2821,8 +2821,11 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs
>> *iregs, struct perf_sample_d
>>                  * If collision happened, the record will be dropped.
>>                  */
>>                 if (pebs_status != (1ULL << bit)) {
>> -                       for_each_set_bit(i, (unsigned long *)&pebs_status,
>> size)
>> +                       for_each_set_bit(i, (unsigned long *)&pebs_status,
>> size) {
>>                                 error[i]++;
>> +                               if (error[i] && !events[i])
>> +                                       events[i] = cpuc->events[i];
>> +                       }
>>                         continue;
>>                 }
>>
>>
>> On 9/8/2025 5:05 PM, Mi, Dapeng wrote:
>>> On 9/8/2025 4:43 PM, kernel test robot wrote:
>>>> Hello,
>>>>
>>>> kernel test robot noticed "WARNING:at_arch/x86/events/intel/ds.c:#intel_pmu_drain_pebs_nhm" on:
>>>>
>>>> commit: a7138973beb1d124386472663cf50a571a2059ce ("[Patch v7 02/12] perf/x86/intel: Fix NULL event access and potential PEBS record loss")
>>>> url: https://github.com/intel-lab-lkp/linux/commits/Dapeng-Mi/perf-x86-Remove-redundant-is_x86_event-prototype/20250828-094117
>>>> patch link: https://lore.kernel.org/all/20250828013435.1528459-3-dapeng1.mi@linux.intel.com/
>>>> patch subject: [Patch v7 02/12] perf/x86/intel: Fix NULL event access and potential PEBS record loss
>>>>
>>>> in testcase: phoronix-test-suite
>>>> version: 
>>>> with following parameters:
>>>>
>>>> 	test: stress-ng-1.11.0
>>>> 	option_a: Socket Activity
>>>> 	cpufreq_governor: performance
>>>>
>>>>
>>>>
>>>> config: x86_64-rhel-9.4
>>>> compiler: gcc-12
>>>> test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
>>>>
>>>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>>>
>>>>
>>>>
>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>>> the same patch/commit), kindly add following tags
>>>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>>>> | Closes: https://lore.kernel.org/oe-lkp/202509081646.d101cfb7-lkp@intel.com
>>>>
>>>>
>>>>
>>>> The kernel config and materials to reproduce are available at:
>>>> https://download.01.org/0day-ci/archive/20250908/202509081646.d101cfb7-lkp@intel.com
>>>>
>>>>
>>>> the dmesg in above link is not very clear, so we also attached one dmesg FYI,
>>>> from which:
>>>>
>>>> [   41.225784][   C82] ------------[ cut here ]------------
>>>> [   41.225786][   C82] WARNING: CPU: 82 PID: 3704 at arch/x86/events/intel/ds.c:2592 intel_pmu_drain_pebs_nhm+0x56b/0x630
>>>> [   41.225791][   C82] Modules linked in: xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
>>>> xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bridge stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio qrtr sg binfmt_misc loop fus
>>>> e dm_mod overlay btrfs blake2b_generic xor raid6_pq intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_eda
>>>> c_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irdma sd_mod ast irqbypass ice ipmi_ssif drm_client_lib snd_pcm ghash
>>>> _clmulni_intel drm_shmem_helper snd_timer gnss rapl drm_kms_helper intel_cstate snd ahci ib_uverbs libahci mei_me soundcore acpi_power_meter i2c_i801 ioat
>>>> dma drm ib_core pcspkr intel_uncore ipmi_si acpi_ipmi libata mei joydev i2c_smbus intel_pch_thermal lpc_ich dca wmi ipmi_devintf ipmi_msghandler acpi_pad
>>>> [   41.225831][   C82] CPU: 82 UID: 0 PID: 3704 Comm: sleep Tainted: G S                  6.17.0-rc1-00052-ga7138973beb1 #1 VOLUNTARY
>>>> [   41.225834][   C82] Tainted: [S]=CPU_OUT_OF_SPEC
>>>> [   41.225835][   C82] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
>>>> [   41.225836][   C82] RIP: 0010:intel_pmu_drain_pebs_nhm+0x56b/0x630
>>>> [   41.225839][   C82] Code: 48 e8 b9 cd fe ff 85 c0 0f 84 a9 00 00 00 41 f6 84 24 a4 01 00 00 80 0f 84 9a 00 00 00 4c 89 ef e8 1a 2a 34 00 e9 c7 fc ff ff
>>>>  <0f> 0b e9 c0 fc ff ff 0f 0b e9 b9 fc ff ff 48 8b 04 cb 48 89 84 cc
>>>> [   41.225841][   C82] RSP: 0018:fffffe00012f38c0 EFLAGS: 00010046
>>>> [   41.225843][   C82] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>>>> [   41.225844][   C82] RDX: 0000000000000001 RSI: 0000000000000004 RDI: fffffe00012f3900
>>>> [   41.225845][   C82] RBP: fffffe00013120c8 R08: 0000000000000000 R09: 0000000000000000
>>>> [   20.931889][ T1340] Error: Driver 'pcspkr' is already registered, aborting...
>>>> [   41.225846][   C82] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>>> [   41.225847][   C82] R13: 0000000000000000 R14: fffffe00012f3c80 R15: 0000000000000000
>>>> [   41.225848][   C82] FS:  0000000000000000(0000) GS:ffff88f027c62000(0000) knlGS:0000000000000000
>>>> [   21.006859][ T1512] sd 6:0:0:0: Attached scsi generic sg0 type 0
>>>> [   21.013583][ T1512] sd 7:0:0:0: Attached scsi generic sg1 type 0
>>>> [   41.225849][   C82] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [   41.225851][   C82] CR2: 00007ffe5571fe7c CR3: 00000040c5ae1003 CR4: 00000000007726f0
>>>> [   41.225852][   C82] PKRU: 55555554
>>>> [   41.225853][   C82] Call Trace:
>>>> [   41.225855][   C82]  <NMI>
>>>> [   41.225861][   C82]  handle_pmi_common+0x29b/0x430
>>>> [   41.225865][   C82]  intel_pmu_handle_irq+0x109/0x2b0
>>>> [   41.225867][   C82]  perf_event_nmi_handler+0x2a/0x70
>>>> [   41.225870][   C82]  nmi_handle+0x53/0x130
>>>> [   41.225873][   C82]  default_do_nmi+0x11d/0x170
>>>> [   41.225876][   C82]  exc_nmi+0x106/0x1b0
>>>> [   41.225878][   C82]  end_repeat_nmi+0xf/0x53
>>>> [   41.225880][   C82] RIP: 0010:find_next_fd+0x2a/0xb0
>>>> [   41.225883][   C82] Code: 0f 1f 44 00 00 41 54 89 f2 48 c7 c0 ff ff ff ff 49 89 fc 55 c1 ea 06 53 89 f3 48 8b 77 18 89 d9 48 d3 e0 48 f7 d0 48 0b 04 d6
>>>>  <48> 83 f8 ff 74 0d 48 f7 d0 f3 48 0f bc c0 83 f8 3f 76 3a 41 8b 2c
>>>> [   41.225885][   C82] RSP: 0018:ffffc90025283b90 EFLAGS: 00000206
>>>> [   41.225886][   C82] RAX: 0000000000000017 RBX: 0000000000000003 RCX: 0000000000000003
>>>> [   41.225887][   C82] RDX: 0000000000000000 RSI: ffff88f06d277150 RDI: ffff88f06d2770e8
>>>> [   41.225888][   C82] RBP: 0000000000000400 R08: 8080808080808080 R09: 979c8d9e9a8cdfff
>>>> [   41.225889][   C82] R10: fefefefefefefeff R11: 0000000000000000 R12: ffff88f06d2770e8
>>>> [   41.225890][   C82] R13: 0000000000088000 R14: ffff88f06d2770c0 R15: ffff88f06d2770e8
>>>> [   41.225893][   C82]  ? find_next_fd+0x2a/0xb0
>>>> [   41.225896][   C82]  ? find_next_fd+0x2a/0xb0
>>>> [   41.225899][   C82]  </NMI>
>>>> [   41.225899][   C82]  <TASK>
>>>> [   41.225900][   C82]  alloc_fd+0x55/0x130
>>>> [   41.225902][   C82]  do_sys_openat2+0x5a/0xf0
>>>> [   41.225905][   C82]  __x64_sys_openat+0x6d/0xb0
>>>> [   41.225907][   C82]  do_syscall_64+0x7f/0x2b0
>>>> [   41.225909][   C82]  ? vfs_statx+0x68/0x170
>>>> [   41.225911][   C82]  ? strncpy_from_user+0x26/0xf0
>>>> [   41.225914][   C82]  ? vfs_fstatat+0x75/0xb0
>>>> [   41.225917][   C82]  ? __do_sys_newfstatat+0x25/0x70
>>>> [   41.225919][   C82]  ? path_openat+0xb6/0x2b0
>>>> [   41.225921][   C82]  ? do_syscall_64+0x7f/0x2b0
>>>> [   41.225922][   C82]  ? do_filp_open+0xc3/0x170
>>>> [   41.225924][   C82]  ? do_syscall_64+0x7f/0x2b0
>>>> [   41.225925][   C82]  ? __cond_resched+0x1e/0x70
>>>> [   41.225928][   C82]  ? check_heap_object+0x34/0x1b0
>>>> [   41.225931][   C82]  ? __check_object_size+0x5c/0x130
>>>> [   41.225933][   C82]  ? do_sys_openat2+0x8a/0xf0
>>>> [   41.225936][   C82]  ? __x64_sys_openat+0x6d/0xb0
>>>> [   41.225938][   C82]  ? clear_bhb_loop+0x30/0x80
>>>> [   41.225940][   C82]  ? clear_bhb_loop+0x30/0x80
>>>> [   41.225942][   C82]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>> [   41.225944][   C82] RIP: 0033:0x7eff04bb9a2d
>>>> [   41.225946][   C82] Code: 48 89 54 24 e0 41 83 e2 40 75 32 89 f0 25 00 00 41 00 3d 00 00 41 00 74 24 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05
>>>>  <48> 3d 00 f0 ff ff 77 33 c3 66 2e 0f 1f 84 00 00 00 00 00 48 8d 44
>>>> [   41.225947][   C82] RSP: 002b:00007ffe5571f7e8 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
>>>> [   41.225949][   C82] RAX: ffffffffffffffda RBX: 0000558b3236dbe6 RCX: 00007eff04bb9a2d
>>>> [   41.225950][   C82] RDX: 0000000000080000 RSI: 00007eff04bc20b1 RDI: 00000000ffffff9c
>>>> [   41.225951][   C82] RBP: 00007eff04bcd1f8 R08: 0000000000000000 R09: 0000558b3236dbe6
>>>> [   41.225952][   C82] R10: 0000000000000000 R11: 0000000000000287 R12: ffffffffffffffff
>>>> [   41.225953][   C82] R13: 0000000000000001 R14: 00007eff04bcc020 R15: 00007eff04bcd6b8
>>>> [   41.225954][   C82]  </TASK>
>>>> [   41.225955][   C82] ---[ end trace 0000000000000000 ]---
>>>>
>>>>
>>> It looks the warning is triggered in the  "error[i] != 0" case and lead to
>>> the local events[] array is not initialized. Would fix it in next version.
>>>
>>>
>>>
>>>
>> From 0afc076a7836433b455c8aff15d4a3ad9631ebc2 Mon Sep 17 00:00:00 2001
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Date: Sun, 28 Sep 2025 13:50:47 +0800
>> Subject: [PATCH] perf/x86/intel: Fix NULL event access waring from test robot
>>
>> This patch fixes the warning about
>> https://lore.kernel.org/all/202509081646.d101cfb7-lkp@intel.com/.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/ds.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 65908880f424..ef32714cb182 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -2821,8 +2821,11 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>>  		 * If collision happened, the record will be dropped.
>>  		 */
>>  		if (pebs_status != (1ULL << bit)) {
>> -			for_each_set_bit(i, (unsigned long *)&pebs_status, size)
>> +			for_each_set_bit(i, (unsigned long *)&pebs_status, size) {
>>  				error[i]++;
>> +				if (error[i] && !events[i])
>> +					events[i] = cpuc->events[i];
>> +			}
>>  			continue;
>>  		}
>>  
>> -- 
>> 2.34.1
>>
--------------noBps4QEKNLJXvRP2Vz7n39u
Content-Type: text/plain; charset=UTF-8;
 name="0001-Fixup-perf-x86-intel-Fix-NULL-event-access-waring-fr.patch"
Content-Disposition: attachment;
 filename*0="0001-Fixup-perf-x86-intel-Fix-NULL-event-access-waring-fr.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiMzZhNjMzNzVmOWVhNWY4NmE4ZGMzOTJhMTUzY2MyMDIwZTczNTUxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYXBlbmcgTWkgPGRhcGVuZzEubWlAbGludXguaW50
ZWwuY29tPgpEYXRlOiBTdW4sIDI4IFNlcCAyMDI1IDEzOjUwOjQ3ICswODAwClN1YmplY3Q6
IFtQQVRDSF0gRml4dXA6IHBlcmYveDg2L2ludGVsOiBGaXggTlVMTCBldmVudCBhY2Nlc3Mg
d2FyaW5nIGZyb20gdGVzdAogcm9ib3QKClRoaXMgcGF0Y2ggZml4ZXMgdGhlIHdhcm5pbmcg
YWJvdXQKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwOTA4MTY0Ni5kMTAxY2Zi
Ny1sa3BAaW50ZWwuY29tLy4KClNpZ25lZC1vZmYtYnk6IERhcGVuZyBNaSA8ZGFwZW5nMS5t
aUBsaW51eC5pbnRlbC5jb20+Ci0tLQogYXJjaC94ODYvZXZlbnRzL2ludGVsL2RzLmMgfCAx
MSArKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ldmVudHMvaW50ZWwvZHMuYyBiL2Fy
Y2gveDg2L2V2ZW50cy9pbnRlbC9kcy5jCmluZGV4IDY1OTA4ODgwZjQyNC4uM2RlZGY3YTBh
Y2Y2IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9ldmVudHMvaW50ZWwvZHMuYworKysgYi9hcmNo
L3g4Ni9ldmVudHMvaW50ZWwvZHMuYwpAQCAtMjc4MSw5ICsyNzgxLDExIEBAIHN0YXRpYyB2
b2lkIGludGVsX3BtdV9kcmFpbl9wZWJzX25obShzdHJ1Y3QgcHRfcmVncyAqaXJlZ3MsIHN0
cnVjdCBwZXJmX3NhbXBsZV9kCiAKIAkJLyogUEVCUyB2MyBoYXMgbW9yZSBhY2N1cmF0ZSBz
dGF0dXMgYml0cyAqLwogCQlpZiAoeDg2X3BtdS5pbnRlbF9jYXAucGVic19mb3JtYXQgPj0g
MykgewotCQkJZm9yX2VhY2hfc2V0X2JpdChiaXQsICh1bnNpZ25lZCBsb25nICopJnBlYnNf
c3RhdHVzLCBzaXplKQorCQkJZm9yX2VhY2hfc2V0X2JpdChiaXQsICh1bnNpZ25lZCBsb25n
ICopJnBlYnNfc3RhdHVzLCBzaXplKSB7CiAJCQkJY291bnRzW2JpdF0rKzsKLQorCQkJCWlm
IChjb3VudHNbYml0XSAmJiAhZXZlbnRzW2JpdF0pCisJCQkJCWV2ZW50c1tiaXRdID0gY3B1
Yy0+ZXZlbnRzW2JpdF07CisJCQl9CiAJCQljb250aW51ZTsKIAkJfQogCkBAIC0yODIxLDgg
KzI4MjMsMTEgQEAgc3RhdGljIHZvaWQgaW50ZWxfcG11X2RyYWluX3BlYnNfbmhtKHN0cnVj
dCBwdF9yZWdzICppcmVncywgc3RydWN0IHBlcmZfc2FtcGxlX2QKIAkJICogSWYgY29sbGlz
aW9uIGhhcHBlbmVkLCB0aGUgcmVjb3JkIHdpbGwgYmUgZHJvcHBlZC4KIAkJICovCiAJCWlm
IChwZWJzX3N0YXR1cyAhPSAoMVVMTCA8PCBiaXQpKSB7Ci0JCQlmb3JfZWFjaF9zZXRfYml0
KGksICh1bnNpZ25lZCBsb25nICopJnBlYnNfc3RhdHVzLCBzaXplKQorCQkJZm9yX2VhY2hf
c2V0X2JpdChpLCAodW5zaWduZWQgbG9uZyAqKSZwZWJzX3N0YXR1cywgc2l6ZSkgewogCQkJ
CWVycm9yW2ldKys7CisJCQkJaWYgKGVycm9yW2ldICYmICFldmVudHNbaV0pCisJCQkJCWV2
ZW50c1tpXSA9IGNwdWMtPmV2ZW50c1tpXTsKKwkJCX0KIAkJCWNvbnRpbnVlOwogCQl9CiAK
LS0gCjIuMzQuMQoK

--------------noBps4QEKNLJXvRP2Vz7n39u--
