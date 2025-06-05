Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC1218CC15;
	Thu,  5 Jun 2025 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749147782; cv=none; b=bmDiQZKYOCjciNuGf51p7zlegyXDJWh53EWnv4XSAL7K9n2wmpKGDJ9qSOdChg6lfKsyTTbM9uecEIT9UGf8zITfazTBcWdZie26B5UDOnzQajlYFKu3XnB8deF9/zKBywAnt4k+XcTo94tW82SABG8jbvThw4Ox8YYc/Y7fP+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749147782; c=relaxed/simple;
	bh=CCTBO7qrRxjNile1Z+Ksu8wUzkLA1uQMT+meq7Dh2N8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WrrlMKEacm9LqwCwMUmKWqg/0hFYP2sBODcdbA7y9fdhEigfwzZSKmXS2crHOiwLcwIUPzcgXwJlYIO8XA9drfX6XTjc50fluy/3CeEXMqlxfDWLT1QjjBJ3cf0DreqOYRWrB1/dk0TDQBmvGRKOaXkhTyCjvlf2XXjD4EQrhL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iyel8uwc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iyel8uwc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749147780; x=1780683780;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CCTBO7qrRxjNile1Z+Ksu8wUzkLA1uQMT+meq7Dh2N8=;
  b=iyel8uwcjGJyC5XxwS8AdS79EqY/nT2a9old/NHw/C+tUC6N+DqF6UOm
   Y+iRYfgX18ULxSbVEWN7wGeaJwbEHOTcugaNbaaMN7M7r0xV/lgaukRGq
   4C14uUFpo9doqTepWeAhqfUK6Z9iXYLjr/IDnGg9Q88V7dl5pNpXOu2c2
   B4Cbh4v6EHmxBeueFUxRBkuP2yexadKZQUjc1VjvVdLkBPFNpVj0YNux6
   ZXKB8APPVU635+61NXdwcESSF3M8epFEwCICoklWY1JupYObaViuwD2Gf
   MHGgWV45I4zOWU+nK2Va0cmcwgI6s2p/7hjj8skoODImaRxEdNZpZy07u
   A==;
X-CSE-ConnectionGUID: 45ad9OSGQICurbtrhEYEOw==
X-CSE-MsgGUID: iubnrOcLRnq3wWCGN+RTCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="38914767"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="38914767"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 11:22:59 -0700
X-CSE-ConnectionGUID: HRCI5csRTkufvzVikDckEw==
X-CSE-MsgGUID: Co4coeYtTtmdko+jDSS8Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="146091338"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 11:23:00 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9068F20B5736;
	Thu,  5 Jun 2025 11:22:56 -0700 (PDT)
Message-ID: <b07f0716-c335-4b6d-bf49-26dd24015d10@linux.intel.com>
Date: Thu, 5 Jun 2025 14:22:55 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [perf] fuzzer quickly crashes kernel, possibly memcg related
To: Vince Weaver <vincent.weaver@maine.edu>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Chen Yu <yu.c.chen@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <4ce106d0-950c-aadc-0b6a-f0215cd39913@maine.edu>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <4ce106d0-950c-aadc-0b6a-f0215cd39913@maine.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 2025-06-05 1:42 p.m., Vince Weaver wrote:
> Hello
>=20
> was running perf_fuzzer on a raptor-lake machine and getting a lot of=20
> issues, so tried on most recent .git tree
>=20
> the system currently locks up very quickly with something like the=20
> following.  Maybe in "memcg" code somehow?  Keep seeing
> "count_mcg_events()" in the traces.  Just checking if this was a=20
> known issue before trying to reproduce things (which is hard as when it=
=20
> crashes like this it crashes so hard I have to physically unplug the=20
> machine to reboot).
>=20
> Vince
>=20
> [  394.520299] watchdog: CPU3: Watchdog detected hard LOCKUP on cpu 3
> [  394.520300] Modules linked in: qrtr binfmt_misc nls_ascii nls_cp437 =
vfat fat snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_ge=
neric soundwire_intel soundwire_generic_allocation platform_profile snd_s=
of_intel_hda_sdw_bpt snd_ctl_led snd_sof_intel_hda_common snd_soc_hdac_hd=
a snd_sof_intel_hda_mlink snd_sof_intel_hda soundwire_cadence snd_sof_pci=
 snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_soc_acpi_intel_match intel_=
uncore_frequency snd_soc_acpi_intel_sdca_quirks snd_soc_acpi intel_uncore=
_frequency_common crc8 x86_pkg_temp_thermal intel_powerclamp soundwire_bu=
s coretemp snd_soc_sdca snd_soc_avs kvm_intel snd_hda_codec_realtek snd_s=
oc_hda_codec snd_hda_ext_core snd_hda_codec_generic snd_hda_scodec_compon=
ent snd_soc_core snd_hda_codec_hdmi snd_compress snd_pcm_dmaengine kvm sn=
d_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi irqbypass snd_hda_codec g=
hash_clmulni_intel sha512_ssse3 btusb sha1_ssse3 snd_hda_core processor_t=
hermal_device_pci btrtl aesni_intel processor_therm
>  al_device snd_hwdep btintel iwlwifi
> [  394.520317]  dell_wmi processor_thermal_wt_hint btbcm rapl platform_=
temperature_control snd_pcm btmtk dell_smbios intel_cstate processor_ther=
mal_rfim bluetooth dell_wmi_sysman mei_hdcp mei_wdt mei_pxp intel_rapl_ms=
r iTCO_wdt snd_timer dcdbas dell_wmi_ddv processor_thermal_rapl intel_pmc=
_bxt intel_uncore dell_smm_hwmon battery dell_wmi_descriptor firmware_att=
ributes_class cfg80211 ucsi_acpi iTCO_vendor_support wmi_bmof pcspkr snd =
intel_rapl_common mei_me processor_thermal_wt_req watchdog typec_ucsi sou=
ndcore processor_thermal_power_floor mei rfkill typec ie31200_edac proces=
sor_thermal_mbox roles intel_pmc_core int3403_thermal pmt_telemetry int34=
0x_thermal_zone pmt_class intel_pmc_ssram_telemetry int3400_thermal acpi_=
thermal_rel intel_vsec intel_hid acpi_tad acpi_pad sparse_keymap evdev pa=
rport_pc ppdev lp parport dm_mod loop efi_pstore configfs efivarfs ip_tab=
les x_tables autofs4 ext4 crc16 mbcache hid_generic jbd2 usbhid hid i915 =
drm_buddy ttm i2c_algo_bit ahci drm_display_helper=20
>  libahci rtsx_pci_sdmmc cec libata
> [  394.520337]  mmc_core rc_core drm_client_lib xhci_pci xhci_hcd drm_k=
ms_helper video nvme intel_lpss_pci i2c_i801 scsi_mod rtsx_pci intel_lpss=
 usbcore drm e1000e nvme_core i2c_smbus usb_common scsi_common idma64 but=
ton wmi pinctrl_alderlake
> [  394.520343] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 6.15.0+=
 #1 PREEMPT(voluntary)=20
> [  394.520344] Hardware name: Dell Inc. Precision 3660/0VJ7G2, BIOS 2.1=
7.0 08/09/2024
> [  394.520344] RIP: 0010:hrtimer_cancel+0x21/0x30


This should be a known issue introduced by
9734e25fbf5a perf: Fix the throttle logic for a group

The patch can fix it.
https://lore.kernel.org/lkml/20250604171554.3909897-1-kan.liang@linux.int=
el.com/

Thanks,
Kan

> [  394.520349] Code: 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00=
 00 53 48 89 fb 48 89 df e8 db fe ff ff 85 c0 78 06 5b c3 cc cc cc cc f3 =
90 <eb> ea 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90
> [  394.520349] RSP: 0000:ffffa9ba405f4cc8 EFLAGS: 00000086
> [  394.520350] RAX: 00000000ffffffff RBX: ffff965bce011668 RCX: 0000000=
000000018
> [  394.520351] RDX: 0000000000000001 RSI: 0000000000000087 RDI: ffff966=
32f6e11c0
> [  394.520351] RBP: ffff965bce011668 R08: 0000000000000000 R09: 0000000=
000000000
> [  394.520352] R10: 0000000000000000 R11: ffffa9ba405f4ff8 R12: ffffa9b=
a405f4d80
> [  394.520352] R13: ffff965bce011500 R14: 0000000000000000 R15: ffffa9b=
a401d3de8
> [  394.520352] FS:  0000000000000000(0000) GS:ffff9663729b4000(0000) kn=
lGS:0000000000000000
> [  394.520353] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  394.520354] CR2: 00007fd230e133d8 CR3: 00000002cb424001 CR4: 0000000=
000f72ef0
> [  394.520354] PKRU: 55555554
> [  394.520355] Call Trace:
> [  394.520356]  <IRQ>
> [  394.520358]  cpu_clock_event_stop+0x68/0x70
> [  394.520360]  __perf_event_account_interrupt+0xe6/0x1b0
> [  394.520362]  __perf_event_overflow+0x45/0x380
> [  394.520364]  perf_swevent_hrtimer+0xd7/0x140
> [  394.520366]  ? __pfx_perf_swevent_hrtimer+0x10/0x10
> [  394.520366]  __hrtimer_run_queues+0x126/0x2c0
> [  394.520368]  hrtimer_interrupt+0xff/0x250
> [  394.520370]  __sysvec_apic_timer_interrupt+0x52/0x120
> [  394.520371]  sysvec_apic_timer_interrupt+0x6c/0x90
> [  394.520373]  </IRQ>
> [  394.520374]  <TASK>
> [  394.520374]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  394.520375] RIP: 0010:cpuidle_enter_state+0xcc/0x420
> [  394.520377] Code: 7a 15 43 ff e8 b5 f3 ff ff 8b 53 04 49 89 c5 0f 1f=
 44 00 00 31 ff e8 33 ff 41 ff 45 84 ff 0f 85 40 02 00 00 fb 0f 1f 44 00 =
00 <45> 85 f6 0f 88 81 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
> [  394.520378] RSP: 0000:ffffa9ba401d3e90 EFLAGS: 00000246
> [  394.520378] RAX: ffff9663729b4000 RBX: ffffc9ba3f8c0e70 RCX: 0000000=
00000001f
> [  394.520378] RDX: 0000000000000003 RSI: 000000003c9b26c9 RDI: 0000000=
000000000
> [  394.520379] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000=
000000008
> [  394.520379] R10: 00000000ffffffff R11: ffffffffffffffff R12: fffffff=
fbc3bcf40
> [  394.520380] R13: 0000005735b5dbc0 R14: 0000000000000001 R15: 0000000=
000000000
> [  394.520381]  cpuidle_enter+0x2d/0x40
> [  394.520383]  do_idle+0x1e1/0x240
> [  394.520385]  cpu_startup_entry+0x29/0x30
> [  394.520387]  start_secondary+0x119/0x140
> [  394.520389]  common_startup_64+0x13e/0x141
> [  394.520391]  </TASK>
> [  395.559080] rcu: INFO: rcu_preempt self-detected stall on CPU
> [  395.559096] rcu: 	10-....: (5249 ticks this GP) idle=3D1894/1/0x4000=
000000000000 softirq=3D22104/22104 fqs=3D2624
> [  395.559105] rcu: 	(t=3D5250 jiffies g=3D56213 q=3D75 ncpus=3D24)
> [  395.559110] Sending NMI from CPU 10 to CPUs 3:
> [  395.559112] NMI backtrace for cpu 3
> [  395.559112] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 6.15.0+=
 #1 PREEMPT(voluntary)=20
> [  395.559113] Hardware name: Dell Inc. Precision 3660/0VJ7G2, BIOS 2.1=
7.0 08/09/2024
> [  395.559113] RIP: 0010:hrtimer_cancel+0x21/0x30
> [  395.559114] Code: 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00=
 00 53 48 89 fb 48 89 df e8 db fe ff ff 85 c0 78 06 5b c3 cc cc cc cc f3 =
90 <eb> ea 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90
> [  395.559115] RSP: 0000:ffffa9ba405f4cc8 EFLAGS: 00000086
> [  395.559115] RAX: 00000000ffffffff RBX: ffff965bce011668 RCX: 0000000=
000000018
> [  395.559116] RDX: 0000000000000001 RSI: 0000000000000087 RDI: ffff966=
32f6e11c0
> [  395.559116] RBP: ffff965bce011668 R08: 0000000000000000 R09: 0000000=
000000000
> [  395.559117] R10: 0000000000000000 R11: ffffa9ba405f4ff8 R12: ffffa9b=
a405f4d80
> [  395.559117] R13: ffff965bce011500 R14: 0000000000000000 R15: ffffa9b=
a401d3de8
> [  395.559117] FS:  0000000000000000(0000) GS:ffff9663729b4000(0000) kn=
lGS:0000000000000000
> [  395.559118] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  395.559118] CR2: 00007fd230e133d8 CR3: 00000002cb424001 CR4: 0000000=
000f72ef0
> [  395.559119] PKRU: 55555554
> [  395.559119] Call Trace:
> [  395.559119]  <IRQ>
> [  395.559119]  cpu_clock_event_stop+0x68/0x70
> [  395.559120]  __perf_event_account_interrupt+0xe6/0x1b0
> [  395.559121]  __perf_event_overflow+0x45/0x380
> [  395.559123]  perf_swevent_hrtimer+0xd7/0x140
> [  395.559125]  ? __pfx_perf_swevent_hrtimer+0x10/0x10
> [  395.559125]  __hrtimer_run_queues+0x126/0x2c0
> [  395.559127]  hrtimer_interrupt+0xff/0x250
> [  395.559128]  __sysvec_apic_timer_interrupt+0x52/0x120
> [  395.559129]  sysvec_apic_timer_interrupt+0x6c/0x90
> [  395.559129]  </IRQ>
> [  395.559130]  <TASK>
> [  395.559130]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  395.559131] RIP: 0010:cpuidle_enter_state+0xcc/0x420
> [  395.559132] Code: 7a 15 43 ff e8 b5 f3 ff ff 8b 53 04 49 89 c5 0f 1f=
 44 00 00 31 ff e8 33 ff 41 ff 45 84 ff 0f 85 40 02 00 00 fb 0f 1f 44 00 =
00 <45> 85 f6 0f 88 81 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
> [  395.559132] RSP: 0000:ffffa9ba401d3e90 EFLAGS: 00000246
> [  395.559132] RAX: ffff9663729b4000 RBX: ffffc9ba3f8c0e70 RCX: 0000000=
00000001f
> [  395.559133] RDX: 0000000000000003 RSI: 000000003c9b26c9 RDI: 0000000=
000000000
> [  395.559133] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000=
000000008
> [  395.559133] R10: 00000000ffffffff R11: ffffffffffffffff R12: fffffff=
fbc3bcf40
> [  395.559134] R13: 0000005735b5dbc0 R14: 0000000000000001 R15: 0000000=
000000000
> [  395.559135]  cpuidle_enter+0x2d/0x40
> [  395.559136]  do_idle+0x1e1/0x240
> [  395.559137]  cpu_startup_entry+0x29/0x30
> [  395.559138]  start_secondary+0x119/0x140
> [  395.559140]  common_startup_64+0x13e/0x141
> [  395.559141]  </TASK>
> [  395.560104] CPU: 10 UID: 1000 PID: 5369 Comm: perf_fuzzer Not tainte=
d 6.15.0+ #1 PREEMPT(voluntary)=20
> [  395.560105] Hardware name: Dell Inc. Precision 3660/0VJ7G2, BIOS 2.1=
7.0 08/09/2024
> [  395.560105] RIP: 0010:smp_call_function_single+0xf9/0x140
> [  395.560108] Code: 15 c4 67 35 02 75 5d c9 c3 cc cc cc cc 48 89 e6 48=
 89 54 24 18 4c 89 44 24 10 e8 d2 fd ff ff 8b 54 24 08 83 e2 01 74 0b f3 =
90 <8b> 54 24 08 83 e2 01 75 f5 eb ba 8b 05 46 cf 3d 02 85 c0 0f 85 67
> [  395.560108] RSP: 0018:ffffa9ba4c77bb20 EFLAGS: 00000202
> [  395.560109] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000=
000000830
> [  395.560110] RDX: 0000000000000001 RSI: 00000200000008fb RDI: 0000000=
000000830
> [  395.560110] RBP: ffffa9ba4c77bb68 R08: ffffffffbab09a30 R09: 0000000=
000000000
> [  395.560111] R10: 0000000000000000 R11: 0000000000000000 R12: ffff966=
32f6eba00
> [  395.560111] R13: ffff965bce011500 R14: ffff965bde890eb0 R15: ffff965=
bc7959100
> [  395.560112] FS:  00007f976c353740(0000) GS:ffff966372b74000(0000) kn=
lGS:0000000000000000
> [  395.560112] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  395.560113] CR2: 000055a23fda09b8 CR3: 000000011c649001 CR4: 0000000=
000f72ff0
> [  395.560113] DR0: 0000002fbcafb742 DR1: 0000000000000000 DR2: 0000000=
000000000
> [  395.560113] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000600
> [  395.560114] PKRU: 55555554
> [  395.560114] Call Trace:
> [  395.560115]  <TASK>
> [  395.560116]  ? __pfx_remote_function+0x10/0x10
> [  395.560117]  ? get_page_from_freelist+0x1737/0x19a0
> [  395.560119]  event_function_call+0x1b8/0x1c0
> [  395.560121]  ? __pfx___perf_event_disable+0x10/0x10
> [  395.560122]  ? __pfx_event_function+0x10/0x10
> [  395.560123]  perf_event_task_disable+0xb1/0x1a0
> [  395.560125]  __do_sys_prctl+0x203/0xca0
> [  395.560126]  do_syscall_64+0x84/0x2f0
> [  395.560128]  ? mod_memcg_lruvec_state+0x1a2/0x1f0
> [  395.560129]  ? __lruvec_stat_mod_folio+0x83/0xd0
> [  395.560130]  ? __folio_mod_stat+0x26/0x80
> [  395.560132]  ? set_ptes.constprop.0+0x36/0x80
> [  395.560133]  ? do_wp_page+0x789/0xfa0
> [  395.560134]  ? __handle_mm_fault+0xb10/0xfb0
> [  395.560135]  ? count_memcg_events+0x143/0x180
> [  395.560136]  ? handle_mm_fault+0xbf/0x300
> [  395.560138]  ? do_user_addr_fault+0x212/0x6a0
> [  395.560139]  ? syscall_exit_work+0x132/0x140
> [  395.560141]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  395.560142] RIP: 0033:0x7f976c45f40d
> [  395.560143] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 18=
 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 9d 00 00 00 0f =
05 <48> 3d 00 f0 ff ff 77 1b 48 8b 54 24 18 64 48 2b 14 25 28 00 00 00
> [  395.560144] RSP: 002b:00007ffd7d70cce0 EFLAGS: 00000246 ORIG_RAX: 00=
0000000000009d
> [  395.560145] RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007f9=
76c45f40d
> [  395.560145] RDX: 0000000000000000 RSI: 00007ffd7d70cd14 RDI: 0000000=
00000001f
> [  395.560145] RBP: 00007ffd7d70cd50 R08: 00007f976c528204 R09: 00007f9=
76c528260
> [  395.560146] R10: 00007f976c5281f8 R11: 0000000000000246 R12: 0000000=
000000000
> [  395.560146] R13: 00007ffd7d70f1a8 R14: 000055a23dbcddd8 R15: 00007f9=
76c592020
> [  395.560147]  </TASK>

