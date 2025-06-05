Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B7F18C06
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Jun 2025 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749145340; cv=none; b=o1vNb6ztNxfWVB/RUtA6FAMzwiOK3odR0X2ico50AFyvYECJVVZP5T0xxX/bLQObGHAp9NiZ9lqmNPQYK/XYA4RGK9ZWyMcRusBY4SDepjqxQ+viiVA1+6ujbs8VLKRRIKvg2nzu4kQi28N4feM9ljtXhCzB5CScT5gb4gWsHP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749145340; c=relaxed/simple;
	bh=dw3wtsMjp20gBnm4mNUfTzMV09HnfGeTqxoH0rVaRmg=;
	h=From:Date:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=VM++8RRt8y33GDQ3isjkO3O5qy8FoeyRo06lYfxJwNU9zk9B4Xho1UJGjM/83vcROlvTxJ0XhOOyJUkXPZo2WAQa7cnIy1a4sO4W55MEEIaItJsTDJyb3NCQgkrW51AcsKTYA7pNoKb9MStnYxaLAahYQ65FjW4rxXUjxgem3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=OHg1ZlHo; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="OHg1ZlHo"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fafd3cc8f9so20547076d6.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Jun 2025 10:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1749145337; x=1749750137; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TebToOeSbzbXVMh3N2Iju6YC9J+/AG5ACaRfFBZE/po=;
        b=OHg1ZlHojYMAlttKsGo41RxJZSwZGbOy/4mfFTi6p0G4bGgv2PFfM7iCfKFUap5pmN
         O6+T1BBZzcqFPEG/gRqDAqJLWQZC4QsXCPTHozl6RZimSDoYdNIoKUwr8wuOy6JDYQuL
         MshpIgngzzGZ0l5wFO0rIbpClQQXG1EOlBmjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749145337; x=1749750137;
        h=mime-version:message-id:subject:cc:to:date:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TebToOeSbzbXVMh3N2Iju6YC9J+/AG5ACaRfFBZE/po=;
        b=k9Viy9XieLQACVnN/3yQGl1fSQr8r+1v1OygTtsBx80q+ZGfKxv6miS6uak3IQmSHa
         Gx1tpcDqPKp3omXjxjh+Z6pIG2oLBOjxGUzg9iNtQZmUD4p1PPgIhAorPefxfXJzsq1D
         K8Knwgi+Kw1d0P6v6ITxUObVVQ0pnVPIcd07Q+mXdAOtSjYyxeGLCq+Dzd8BzSLS1ZKp
         FEEYIopJB8a6DOGXwkX4D1ovsCkDeQvKYwxYopKTWw4nmUhMptiItYDig08OnlPb5BHk
         KkaXgBhT3uVc9/+/H3FgSef9zy30ZUXjkgbQvtRLO/gVsF8kgRrir5VzggcPjjjpC5fq
         P1bA==
X-Forwarded-Encrypted: i=1; AJvYcCXXkERWkO1oIk8xOg7kqL9iqGdppEWEBklvY1g54m5DI5HDSS9VlNrdyVMstyXhu769v72pv+T23S13SonV/LtE@vger.kernel.org
X-Gm-Message-State: AOJu0YzYDlTKFj+eQV1nb6pE2LMZHqry1TRUqZzDLl7r7OIxsO6CNy/5
	/ltWQUL/1FAEmTgRLQd97e7VwN/bZa6+yT9O48DWuAEhSjdc6rvY8V/w+zxrCUfd8g==
X-Gm-Gg: ASbGncvcYMG8pCMjHBwd4P1BmgXzqu6h7hzlnS450z6Pzqe1RMuTcceaWEMcpkpptQS
	SBrhngA2GiZWFYX1vdhQYgTO+62Ldcaqts9J8PxFZyMgzGyr1MUqsxpLfRJ3W1OWtNyS/yPwrWK
	V0Dt8r+fBZQm9vcFY9vFvv7SLwTSJmbAVcV32qoMju4pMM5bHwsD8NojPuESkdRnTFgDDC8gtuO
	kGd71XwhZFv/nKQKvwXlIx79UzAZhSeaOv7kdRMGLTCrGPXic37EUShys2x2YNRiJeAsVRMmsXO
	D1rpFYrMAidEMN7oHn91TzBH4YR8BbjBkwqDr8GWM68at1mGnqIojRcVarnrG1GCfCc0pGU=
X-Google-Smtp-Source: AGHT+IFmyHF/gjcA9q/OL/D80i8EYbfwavZOUNVTOQRutIV9bumfG6qGAjfC+i1OKXSiVGCnhbDiUQ==
X-Received: by 2002:a05:6214:d64:b0:6fa:c5be:dad6 with SMTP id 6a1803df08f44-6fb08f6a016mr4597046d6.6.1749145336634;
        Thu, 05 Jun 2025 10:42:16 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d35186sm123524796d6.11.2025.06.05.10.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:42:15 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Thu, 5 Jun 2025 13:42:14 -0400 (EDT)
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, 
    "Liang, Kan" <kan.liang@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>, 
    Andrew Morton <akpm@linux-foundation.org>
Subject: [perf] fuzzer quickly crashes kernel, possibly memcg related
Message-ID: <4ce106d0-950c-aadc-0b6a-f0215cd39913@maine.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1320821239-1749145335=:502510"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1320821239-1749145335=:502510
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT

Hello

was running perf_fuzzer on a raptor-lake machine and getting a lot of 
issues, so tried on most recent .git tree

the system currently locks up very quickly with something like the 
following.  Maybe in "memcg" code somehow?  Keep seeing
"count_mcg_events()" in the traces.  Just checking if this was a 
known issue before trying to reproduce things (which is hard as when it 
crashes like this it crashes so hard I have to physically unplug the 
machine to reboot).

Vince

[  394.520299] watchdog: CPU3: Watchdog detected hard LOCKUP on cpu 3
[  394.520300] Modules linked in: qrtr binfmt_misc nls_ascii nls_cp437 vfat fat snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic soundwire_intel soundwire_generic_allocation platform_profile snd_sof_intel_hda_sdw_bpt snd_ctl_led snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_soc_acpi_intel_match intel_uncore_frequency snd_soc_acpi_intel_sdca_quirks snd_soc_acpi intel_uncore_frequency_common crc8 x86_pkg_temp_thermal intel_powerclamp soundwire_bus coretemp snd_soc_sdca snd_soc_avs kvm_intel snd_hda_codec_realtek snd_soc_hda_codec snd_hda_ext_core snd_hda_codec_generic snd_hda_scodec_component snd_soc_core snd_hda_codec_hdmi snd_compress snd_pcm_dmaengine kvm snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi irqbypass snd_hda_codec ghash_clmulni_intel sha512_ssse3 btusb sha1_ssse3 snd_hda_core processor_thermal_device_pci btrtl aesni_intel processor_thermal_device snd_hwdep btintel iwlwifi
[  394.520317]  dell_wmi processor_thermal_wt_hint btbcm rapl platform_temperature_control snd_pcm btmtk dell_smbios intel_cstate processor_thermal_rfim bluetooth dell_wmi_sysman mei_hdcp mei_wdt mei_pxp intel_rapl_msr iTCO_wdt snd_timer dcdbas dell_wmi_ddv processor_thermal_rapl intel_pmc_bxt intel_uncore dell_smm_hwmon battery dell_wmi_descriptor firmware_attributes_class cfg80211 ucsi_acpi iTCO_vendor_support wmi_bmof pcspkr snd intel_rapl_common mei_me processor_thermal_wt_req watchdog typec_ucsi soundcore processor_thermal_power_floor mei rfkill typec ie31200_edac processor_thermal_mbox roles intel_pmc_core int3403_thermal pmt_telemetry int340x_thermal_zone pmt_class intel_pmc_ssram_telemetry int3400_thermal acpi_thermal_rel intel_vsec intel_hid acpi_tad acpi_pad sparse_keymap evdev parport_pc ppdev lp parport dm_mod loop efi_pstore configfs efivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache hid_generic jbd2 usbhid hid i915 drm_buddy ttm i2c_algo_bit ahci drm_display_helper libahci rtsx_pci_sdmmc cec libata
[  394.520337]  mmc_core rc_core drm_client_lib xhci_pci xhci_hcd drm_kms_helper video nvme intel_lpss_pci i2c_i801 scsi_mod rtsx_pci intel_lpss usbcore drm e1000e nvme_core i2c_smbus usb_common scsi_common idma64 button wmi pinctrl_alderlake
[  394.520343] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 6.15.0+ #1 PREEMPT(voluntary) 
[  394.520344] Hardware name: Dell Inc. Precision 3660/0VJ7G2, BIOS 2.17.0 08/09/2024
[  394.520344] RIP: 0010:hrtimer_cancel+0x21/0x30
[  394.520349] Code: 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb 48 89 df e8 db fe ff ff 85 c0 78 06 5b c3 cc cc cc cc f3 90 <eb> ea 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90
[  394.520349] RSP: 0000:ffffa9ba405f4cc8 EFLAGS: 00000086
[  394.520350] RAX: 00000000ffffffff RBX: ffff965bce011668 RCX: 0000000000000018
[  394.520351] RDX: 0000000000000001 RSI: 0000000000000087 RDI: ffff96632f6e11c0
[  394.520351] RBP: ffff965bce011668 R08: 0000000000000000 R09: 0000000000000000
[  394.520352] R10: 0000000000000000 R11: ffffa9ba405f4ff8 R12: ffffa9ba405f4d80
[  394.520352] R13: ffff965bce011500 R14: 0000000000000000 R15: ffffa9ba401d3de8
[  394.520352] FS:  0000000000000000(0000) GS:ffff9663729b4000(0000) knlGS:0000000000000000
[  394.520353] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  394.520354] CR2: 00007fd230e133d8 CR3: 00000002cb424001 CR4: 0000000000f72ef0
[  394.520354] PKRU: 55555554
[  394.520355] Call Trace:
[  394.520356]  <IRQ>
[  394.520358]  cpu_clock_event_stop+0x68/0x70
[  394.520360]  __perf_event_account_interrupt+0xe6/0x1b0
[  394.520362]  __perf_event_overflow+0x45/0x380
[  394.520364]  perf_swevent_hrtimer+0xd7/0x140
[  394.520366]  ? __pfx_perf_swevent_hrtimer+0x10/0x10
[  394.520366]  __hrtimer_run_queues+0x126/0x2c0
[  394.520368]  hrtimer_interrupt+0xff/0x250
[  394.520370]  __sysvec_apic_timer_interrupt+0x52/0x120
[  394.520371]  sysvec_apic_timer_interrupt+0x6c/0x90
[  394.520373]  </IRQ>
[  394.520374]  <TASK>
[  394.520374]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  394.520375] RIP: 0010:cpuidle_enter_state+0xcc/0x420
[  394.520377] Code: 7a 15 43 ff e8 b5 f3 ff ff 8b 53 04 49 89 c5 0f 1f 44 00 00 31 ff e8 33 ff 41 ff 45 84 ff 0f 85 40 02 00 00 fb 0f 1f 44 00 00 <45> 85 f6 0f 88 81 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[  394.520378] RSP: 0000:ffffa9ba401d3e90 EFLAGS: 00000246
[  394.520378] RAX: ffff9663729b4000 RBX: ffffc9ba3f8c0e70 RCX: 000000000000001f
[  394.520378] RDX: 0000000000000003 RSI: 000000003c9b26c9 RDI: 0000000000000000
[  394.520379] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000008
[  394.520379] R10: 00000000ffffffff R11: ffffffffffffffff R12: ffffffffbc3bcf40
[  394.520380] R13: 0000005735b5dbc0 R14: 0000000000000001 R15: 0000000000000000
[  394.520381]  cpuidle_enter+0x2d/0x40
[  394.520383]  do_idle+0x1e1/0x240
[  394.520385]  cpu_startup_entry+0x29/0x30
[  394.520387]  start_secondary+0x119/0x140
[  394.520389]  common_startup_64+0x13e/0x141
[  394.520391]  </TASK>
[  395.559080] rcu: INFO: rcu_preempt self-detected stall on CPU
[  395.559096] rcu: 	10-....: (5249 ticks this GP) idle=1894/1/0x4000000000000000 softirq=22104/22104 fqs=2624
[  395.559105] rcu: 	(t=5250 jiffies g=56213 q=75 ncpus=24)
[  395.559110] Sending NMI from CPU 10 to CPUs 3:
[  395.559112] NMI backtrace for cpu 3
[  395.559112] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 6.15.0+ #1 PREEMPT(voluntary) 
[  395.559113] Hardware name: Dell Inc. Precision 3660/0VJ7G2, BIOS 2.17.0 08/09/2024
[  395.559113] RIP: 0010:hrtimer_cancel+0x21/0x30
[  395.559114] Code: 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb 48 89 df e8 db fe ff ff 85 c0 78 06 5b c3 cc cc cc cc f3 90 <eb> ea 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90
[  395.559115] RSP: 0000:ffffa9ba405f4cc8 EFLAGS: 00000086
[  395.559115] RAX: 00000000ffffffff RBX: ffff965bce011668 RCX: 0000000000000018
[  395.559116] RDX: 0000000000000001 RSI: 0000000000000087 RDI: ffff96632f6e11c0
[  395.559116] RBP: ffff965bce011668 R08: 0000000000000000 R09: 0000000000000000
[  395.559117] R10: 0000000000000000 R11: ffffa9ba405f4ff8 R12: ffffa9ba405f4d80
[  395.559117] R13: ffff965bce011500 R14: 0000000000000000 R15: ffffa9ba401d3de8
[  395.559117] FS:  0000000000000000(0000) GS:ffff9663729b4000(0000) knlGS:0000000000000000
[  395.559118] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  395.559118] CR2: 00007fd230e133d8 CR3: 00000002cb424001 CR4: 0000000000f72ef0
[  395.559119] PKRU: 55555554
[  395.559119] Call Trace:
[  395.559119]  <IRQ>
[  395.559119]  cpu_clock_event_stop+0x68/0x70
[  395.559120]  __perf_event_account_interrupt+0xe6/0x1b0
[  395.559121]  __perf_event_overflow+0x45/0x380
[  395.559123]  perf_swevent_hrtimer+0xd7/0x140
[  395.559125]  ? __pfx_perf_swevent_hrtimer+0x10/0x10
[  395.559125]  __hrtimer_run_queues+0x126/0x2c0
[  395.559127]  hrtimer_interrupt+0xff/0x250
[  395.559128]  __sysvec_apic_timer_interrupt+0x52/0x120
[  395.559129]  sysvec_apic_timer_interrupt+0x6c/0x90
[  395.559129]  </IRQ>
[  395.559130]  <TASK>
[  395.559130]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  395.559131] RIP: 0010:cpuidle_enter_state+0xcc/0x420
[  395.559132] Code: 7a 15 43 ff e8 b5 f3 ff ff 8b 53 04 49 89 c5 0f 1f 44 00 00 31 ff e8 33 ff 41 ff 45 84 ff 0f 85 40 02 00 00 fb 0f 1f 44 00 00 <45> 85 f6 0f 88 81 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[  395.559132] RSP: 0000:ffffa9ba401d3e90 EFLAGS: 00000246
[  395.559132] RAX: ffff9663729b4000 RBX: ffffc9ba3f8c0e70 RCX: 000000000000001f
[  395.559133] RDX: 0000000000000003 RSI: 000000003c9b26c9 RDI: 0000000000000000
[  395.559133] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000008
[  395.559133] R10: 00000000ffffffff R11: ffffffffffffffff R12: ffffffffbc3bcf40
[  395.559134] R13: 0000005735b5dbc0 R14: 0000000000000001 R15: 0000000000000000
[  395.559135]  cpuidle_enter+0x2d/0x40
[  395.559136]  do_idle+0x1e1/0x240
[  395.559137]  cpu_startup_entry+0x29/0x30
[  395.559138]  start_secondary+0x119/0x140
[  395.559140]  common_startup_64+0x13e/0x141
[  395.559141]  </TASK>
[  395.560104] CPU: 10 UID: 1000 PID: 5369 Comm: perf_fuzzer Not tainted 6.15.0+ #1 PREEMPT(voluntary) 
[  395.560105] Hardware name: Dell Inc. Precision 3660/0VJ7G2, BIOS 2.17.0 08/09/2024
[  395.560105] RIP: 0010:smp_call_function_single+0xf9/0x140
[  395.560108] Code: 15 c4 67 35 02 75 5d c9 c3 cc cc cc cc 48 89 e6 48 89 54 24 18 4c 89 44 24 10 e8 d2 fd ff ff 8b 54 24 08 83 e2 01 74 0b f3 90 <8b> 54 24 08 83 e2 01 75 f5 eb ba 8b 05 46 cf 3d 02 85 c0 0f 85 67
[  395.560108] RSP: 0018:ffffa9ba4c77bb20 EFLAGS: 00000202
[  395.560109] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000830
[  395.560110] RDX: 0000000000000001 RSI: 00000200000008fb RDI: 0000000000000830
[  395.560110] RBP: ffffa9ba4c77bb68 R08: ffffffffbab09a30 R09: 0000000000000000
[  395.560111] R10: 0000000000000000 R11: 0000000000000000 R12: ffff96632f6eba00
[  395.560111] R13: ffff965bce011500 R14: ffff965bde890eb0 R15: ffff965bc7959100
[  395.560112] FS:  00007f976c353740(0000) GS:ffff966372b74000(0000) knlGS:0000000000000000
[  395.560112] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  395.560113] CR2: 000055a23fda09b8 CR3: 000000011c649001 CR4: 0000000000f72ff0
[  395.560113] DR0: 0000002fbcafb742 DR1: 0000000000000000 DR2: 0000000000000000
[  395.560113] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[  395.560114] PKRU: 55555554
[  395.560114] Call Trace:
[  395.560115]  <TASK>
[  395.560116]  ? __pfx_remote_function+0x10/0x10
[  395.560117]  ? get_page_from_freelist+0x1737/0x19a0
[  395.560119]  event_function_call+0x1b8/0x1c0
[  395.560121]  ? __pfx___perf_event_disable+0x10/0x10
[  395.560122]  ? __pfx_event_function+0x10/0x10
[  395.560123]  perf_event_task_disable+0xb1/0x1a0
[  395.560125]  __do_sys_prctl+0x203/0xca0
[  395.560126]  do_syscall_64+0x84/0x2f0
[  395.560128]  ? mod_memcg_lruvec_state+0x1a2/0x1f0
[  395.560129]  ? __lruvec_stat_mod_folio+0x83/0xd0
[  395.560130]  ? __folio_mod_stat+0x26/0x80
[  395.560132]  ? set_ptes.constprop.0+0x36/0x80
[  395.560133]  ? do_wp_page+0x789/0xfa0
[  395.560134]  ? __handle_mm_fault+0xb10/0xfb0
[  395.560135]  ? count_memcg_events+0x143/0x180
[  395.560136]  ? handle_mm_fault+0xbf/0x300
[  395.560138]  ? do_user_addr_fault+0x212/0x6a0
[  395.560139]  ? syscall_exit_work+0x132/0x140
[  395.560141]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  395.560142] RIP: 0033:0x7f976c45f40d
[  395.560143] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 18 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 9d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 1b 48 8b 54 24 18 64 48 2b 14 25 28 00 00 00
[  395.560144] RSP: 002b:00007ffd7d70cce0 EFLAGS: 00000246 ORIG_RAX: 000000000000009d
[  395.560145] RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007f976c45f40d
[  395.560145] RDX: 0000000000000000 RSI: 00007ffd7d70cd14 RDI: 000000000000001f
[  395.560145] RBP: 00007ffd7d70cd50 R08: 00007f976c528204 R09: 00007f976c528260
[  395.560146] R10: 00007f976c5281f8 R11: 0000000000000246 R12: 0000000000000000
[  395.560146] R13: 00007ffd7d70f1a8 R14: 000055a23dbcddd8 R15: 00007f976c592020
[  395.560147]  </TASK>
--8323329-1320821239-1749145335=:502510--
