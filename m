Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC292AE97;
	Mon,  8 Sep 2025 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322334; cv=none; b=tqzNHuj/qG14MWYyEsRBBKsVwZ72StEkcTw4Yh+KP4IzbI4F8+hjzB3XP2IRx59OSbshyvKd7/DxeqAUhLcffku34AT6PWxR840McRJTiuMIvw/oTSDp++EiJgSfYGPs+ieYLQdnqorX83i5iBNC9XffCv5NFk3kzX8m7wzf52Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322334; c=relaxed/simple;
	bh=Sx44ypwiM/8mDLkLgip917e2o+WQJW8qcF3YZ4mm6TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZqu9UB7CKHWB7vZfCmAaLc3mEQYweGo2Q9tvNBBxWuPvqZjq0NGxxJ1TGccOmEOARZ8LH4GSeY5+Ups6V5AliQ94MKLeuoFaWy5kHFpuWkaUFmXbSmh9GD2tP7RNvDAoLksqT9kkmj/hc5XcrTTfGi4+Fj4UtHDEk56rZTy2Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wio1Yq9O; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wio1Yq9O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757322333; x=1788858333;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Sx44ypwiM/8mDLkLgip917e2o+WQJW8qcF3YZ4mm6TE=;
  b=Wio1Yq9OewU1R0uJud2MtRp7iNTo7n9J9dhGWoVGpDtN3IYPCzZOzNyR
   t8paCJdHOYyPYOz7ekU+hyVt2dbe+nspkQE2YU3Nl4q/OD5DBCGMOlnxJ
   Hsq7yED7BBnqqqPzuhj/gn+x/GGGgr+FitgWoDTUh/AUz9ImOSwNe7Ufz
   YMOMF1alLz6iZfOioytgChv/yfYkr7Rv03ywk4PNRDBl6jUcCSO0SErDX
   W7vITfZg25Tf+OYseR5X4wiRtGkGhHhmzK5Vww2h+C+cplFIQgWl0/gdw
   wHaYCrGsKSOZyXy6XxXzZZd63EMk/Vq3rgWxckaXV83i3ziAe0Xv7LgNu
   w==;
X-CSE-ConnectionGUID: nyGO5+iFQkuvycFNIarmdA==
X-CSE-MsgGUID: VEAWtJMOS/6KoGkIeheiKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="70672405"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="70672405"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 02:05:31 -0700
X-CSE-ConnectionGUID: WWJ3CZlkQeOsXDhTw5LW6w==
X-CSE-MsgGUID: fSuedluoR/CPjUaECagfzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="177058106"
Received: from unknown (HELO [10.238.3.254]) ([10.238.3.254])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 02:05:26 -0700
Message-ID: <e92a703d-6a92-474c-acba-b15176b97548@linux.intel.com>
Date: Mon, 8 Sep 2025 17:05:24 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v7 02/12] perf/x86/intel: Fix NULL event access and
 potential PEBS record loss
To: kernel test robot <oliver.sang@intel.com>
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
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <202509081646.d101cfb7-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/8/2025 4:43 PM, kernel test robot wrote:
> Hello,
>
> kernel test robot noticed "WARNING:at_arch/x86/events/intel/ds.c:#intel_pmu_drain_pebs_nhm" on:
>
> commit: a7138973beb1d124386472663cf50a571a2059ce ("[Patch v7 02/12] perf/x86/intel: Fix NULL event access and potential PEBS record loss")
> url: https://github.com/intel-lab-lkp/linux/commits/Dapeng-Mi/perf-x86-Remove-redundant-is_x86_event-prototype/20250828-094117
> patch link: https://lore.kernel.org/all/20250828013435.1528459-3-dapeng1.mi@linux.intel.com/
> patch subject: [Patch v7 02/12] perf/x86/intel: Fix NULL event access and potential PEBS record loss
>
> in testcase: phoronix-test-suite
> version: 
> with following parameters:
>
> 	test: stress-ng-1.11.0
> 	option_a: Socket Activity
> 	cpufreq_governor: performance
>
>
>
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202509081646.d101cfb7-lkp@intel.com
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250908/202509081646.d101cfb7-lkp@intel.com
>
>
> the dmesg in above link is not very clear, so we also attached one dmesg FYI,
> from which:
>
> [   41.225784][   C82] ------------[ cut here ]------------
> [   41.225786][   C82] WARNING: CPU: 82 PID: 3704 at arch/x86/events/intel/ds.c:2592 intel_pmu_drain_pebs_nhm+0x56b/0x630
> [   41.225791][   C82] Modules linked in: xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bridge stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio qrtr sg binfmt_misc loop fus
> e dm_mod overlay btrfs blake2b_generic xor raid6_pq intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_eda
> c_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irdma sd_mod ast irqbypass ice ipmi_ssif drm_client_lib snd_pcm ghash
> _clmulni_intel drm_shmem_helper snd_timer gnss rapl drm_kms_helper intel_cstate snd ahci ib_uverbs libahci mei_me soundcore acpi_power_meter i2c_i801 ioat
> dma drm ib_core pcspkr intel_uncore ipmi_si acpi_ipmi libata mei joydev i2c_smbus intel_pch_thermal lpc_ich dca wmi ipmi_devintf ipmi_msghandler acpi_pad
> [   41.225831][   C82] CPU: 82 UID: 0 PID: 3704 Comm: sleep Tainted: G S                  6.17.0-rc1-00052-ga7138973beb1 #1 VOLUNTARY
> [   41.225834][   C82] Tainted: [S]=CPU_OUT_OF_SPEC
> [   41.225835][   C82] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> [   41.225836][   C82] RIP: 0010:intel_pmu_drain_pebs_nhm+0x56b/0x630
> [   41.225839][   C82] Code: 48 e8 b9 cd fe ff 85 c0 0f 84 a9 00 00 00 41 f6 84 24 a4 01 00 00 80 0f 84 9a 00 00 00 4c 89 ef e8 1a 2a 34 00 e9 c7 fc ff ff
>  <0f> 0b e9 c0 fc ff ff 0f 0b e9 b9 fc ff ff 48 8b 04 cb 48 89 84 cc
> [   41.225841][   C82] RSP: 0018:fffffe00012f38c0 EFLAGS: 00010046
> [   41.225843][   C82] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [   41.225844][   C82] RDX: 0000000000000001 RSI: 0000000000000004 RDI: fffffe00012f3900
> [   41.225845][   C82] RBP: fffffe00013120c8 R08: 0000000000000000 R09: 0000000000000000
> [   20.931889][ T1340] Error: Driver 'pcspkr' is already registered, aborting...
> [   41.225846][   C82] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [   41.225847][   C82] R13: 0000000000000000 R14: fffffe00012f3c80 R15: 0000000000000000
> [   41.225848][   C82] FS:  0000000000000000(0000) GS:ffff88f027c62000(0000) knlGS:0000000000000000
> [   21.006859][ T1512] sd 6:0:0:0: Attached scsi generic sg0 type 0
> [   21.013583][ T1512] sd 7:0:0:0: Attached scsi generic sg1 type 0
> [   41.225849][   C82] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   41.225851][   C82] CR2: 00007ffe5571fe7c CR3: 00000040c5ae1003 CR4: 00000000007726f0
> [   41.225852][   C82] PKRU: 55555554
> [   41.225853][   C82] Call Trace:
> [   41.225855][   C82]  <NMI>
> [   41.225861][   C82]  handle_pmi_common+0x29b/0x430
> [   41.225865][   C82]  intel_pmu_handle_irq+0x109/0x2b0
> [   41.225867][   C82]  perf_event_nmi_handler+0x2a/0x70
> [   41.225870][   C82]  nmi_handle+0x53/0x130
> [   41.225873][   C82]  default_do_nmi+0x11d/0x170
> [   41.225876][   C82]  exc_nmi+0x106/0x1b0
> [   41.225878][   C82]  end_repeat_nmi+0xf/0x53
> [   41.225880][   C82] RIP: 0010:find_next_fd+0x2a/0xb0
> [   41.225883][   C82] Code: 0f 1f 44 00 00 41 54 89 f2 48 c7 c0 ff ff ff ff 49 89 fc 55 c1 ea 06 53 89 f3 48 8b 77 18 89 d9 48 d3 e0 48 f7 d0 48 0b 04 d6
>  <48> 83 f8 ff 74 0d 48 f7 d0 f3 48 0f bc c0 83 f8 3f 76 3a 41 8b 2c
> [   41.225885][   C82] RSP: 0018:ffffc90025283b90 EFLAGS: 00000206
> [   41.225886][   C82] RAX: 0000000000000017 RBX: 0000000000000003 RCX: 0000000000000003
> [   41.225887][   C82] RDX: 0000000000000000 RSI: ffff88f06d277150 RDI: ffff88f06d2770e8
> [   41.225888][   C82] RBP: 0000000000000400 R08: 8080808080808080 R09: 979c8d9e9a8cdfff
> [   41.225889][   C82] R10: fefefefefefefeff R11: 0000000000000000 R12: ffff88f06d2770e8
> [   41.225890][   C82] R13: 0000000000088000 R14: ffff88f06d2770c0 R15: ffff88f06d2770e8
> [   41.225893][   C82]  ? find_next_fd+0x2a/0xb0
> [   41.225896][   C82]  ? find_next_fd+0x2a/0xb0
> [   41.225899][   C82]  </NMI>
> [   41.225899][   C82]  <TASK>
> [   41.225900][   C82]  alloc_fd+0x55/0x130
> [   41.225902][   C82]  do_sys_openat2+0x5a/0xf0
> [   41.225905][   C82]  __x64_sys_openat+0x6d/0xb0
> [   41.225907][   C82]  do_syscall_64+0x7f/0x2b0
> [   41.225909][   C82]  ? vfs_statx+0x68/0x170
> [   41.225911][   C82]  ? strncpy_from_user+0x26/0xf0
> [   41.225914][   C82]  ? vfs_fstatat+0x75/0xb0
> [   41.225917][   C82]  ? __do_sys_newfstatat+0x25/0x70
> [   41.225919][   C82]  ? path_openat+0xb6/0x2b0
> [   41.225921][   C82]  ? do_syscall_64+0x7f/0x2b0
> [   41.225922][   C82]  ? do_filp_open+0xc3/0x170
> [   41.225924][   C82]  ? do_syscall_64+0x7f/0x2b0
> [   41.225925][   C82]  ? __cond_resched+0x1e/0x70
> [   41.225928][   C82]  ? check_heap_object+0x34/0x1b0
> [   41.225931][   C82]  ? __check_object_size+0x5c/0x130
> [   41.225933][   C82]  ? do_sys_openat2+0x8a/0xf0
> [   41.225936][   C82]  ? __x64_sys_openat+0x6d/0xb0
> [   41.225938][   C82]  ? clear_bhb_loop+0x30/0x80
> [   41.225940][   C82]  ? clear_bhb_loop+0x30/0x80
> [   41.225942][   C82]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   41.225944][   C82] RIP: 0033:0x7eff04bb9a2d
> [   41.225946][   C82] Code: 48 89 54 24 e0 41 83 e2 40 75 32 89 f0 25 00 00 41 00 3d 00 00 41 00 74 24 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05
>  <48> 3d 00 f0 ff ff 77 33 c3 66 2e 0f 1f 84 00 00 00 00 00 48 8d 44
> [   41.225947][   C82] RSP: 002b:00007ffe5571f7e8 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
> [   41.225949][   C82] RAX: ffffffffffffffda RBX: 0000558b3236dbe6 RCX: 00007eff04bb9a2d
> [   41.225950][   C82] RDX: 0000000000080000 RSI: 00007eff04bc20b1 RDI: 00000000ffffff9c
> [   41.225951][   C82] RBP: 00007eff04bcd1f8 R08: 0000000000000000 R09: 0000558b3236dbe6
> [   41.225952][   C82] R10: 0000000000000000 R11: 0000000000000287 R12: ffffffffffffffff
> [   41.225953][   C82] R13: 0000000000000001 R14: 00007eff04bcc020 R15: 00007eff04bcd6b8
> [   41.225954][   C82]  </TASK>
> [   41.225955][   C82] ---[ end trace 0000000000000000 ]---
>
>
It looks the warning is triggered in the  "error[i] != 0" case and lead to
the local events[] array is not initialized. Would fix it in next version.



