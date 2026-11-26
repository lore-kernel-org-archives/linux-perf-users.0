Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671945;
	b=CATsjF+l5re3E/XeHEAiwdZKX62flYOVwRUHG8PzGDTzZYExiyFJXKmgIUuCtcEYjKJ5
	 sRdGLWaPF+e07wj7wePEGMN0IqUqwmKRfZpaRvUPHv8jokLxAIDLPXNg4iAq0LudaXfxI
	 yMoIH4G9V6bub9lqDfoSacUKEKjD+Zd/DYfccMjCSAQz1ApzSLGe901OTSz+P59cOpTDe
	 22UUsI5A6BW9qx/GW35FezPbDTWWTGXC1umjPyh7guuyOigTPjRTNH7z4l6G6/F5kNdz+
	 eKtGj6WU0r8mSeEpwmGjf6RuV46+WwDTy3gnDijgX1kbR/PsixPcUOK0h0cauanzMxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671945;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=03Nb7Kzsq9louUoPIND+z0WVZSHyGQEpMaiOkBGcY6M=;
	b=aMiOa3WhyS0GS9Ck54U+2ZmL176jswXmVv9kB9sW2PiIZmf+1vPfJ0R4s9Rm+rg7IFTl
	 MoBiHc5f0Ur02qnZ7E/7mMw+MBowVSa11p/A2cxiN2An4nrVmqONlEYHXsbvNRbCxeIyI
	 Tb/0KiDc4BFJuaVy8qDlctF2fkLsHfUpleGMiP4ebvGlxFcGZ0MQx/hZYqipYpuroOdy2
	 NVFjW75Jdfl0kmszS7LjJh4Fg4+wlEy66lj0mzqNJoJ7uAguN3e+jRaOqyHnpQfrZlTzw
	 vU6yqTEdiu+0jtCAoduGbVvVRmybT5H5D+AOeSKl4TvSMhn5JEX46bkH4+hZc3Vj2/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mx7kxcqB;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1403606A31C;
	Thu, 26 Nov 2026 05:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1403606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mx7kxcqB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795671943; x=1827207943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1rJhgjMdHiazrsBwpW0tga4+YB9E4SgM64VWvPllPHA=;
  b=mx7kxcqB07Y+vM6LE+aIFSBncnc5aKrBw2tRd54FHmf8CeajdspRboxg
   P5njIxfjSH+48/7uYa8vuiD02+BMEZleGKG8xzGXzBGuKD48JsjlEYnWt
   KihPM2mkd3cJAlXB/5gJ/O1eAlzpiFOjkqzJv0fVqCzOKZN4ZZF63Kdvp
   PKoNEdJKELAtxpzHnZpQdA49Ez9emVhWyFNknWyU+bcWeK5I5bYzrmP0H
   cHS0JdV+qmYeeOxVIt8fR+a3IUlsbqaQlkdqkT4kNzwjpozclcXG6gIP/
   hUwoGzyRab/2yBD8h6eOLwebFGwiEcf6KqGN5uVcD+iYJbzAG51MhsI+G
   A==;
X-CSE-ConnectionGUID: dU+hqshKTL6d5xumRfW1lw==
X-CSE-MsgGUID: Y0PmkBbrQciBBdDub/eVpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4557453"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4557453"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 21:45:42 -0800
X-CSE-ConnectionGUID: AAI4hSyNTSeuLZhNgt4Y7g==
X-CSE-MsgGUID: LQ+iUwlCRYqOFRo47qAAwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="12576701"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 21:45:41 -0800
Date: Thu, 26 Nov 2026 13:45:37 +0800
From: kernel test robot <yi1.lai@intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [linus:master] [perf/x86/intel] 2721e8da2d:
 WARNING:at_arch/x86/events/intel/ds.c:#intel_pmu_drain_arch_pebs
Message-ID: <awfHgRvVM7HgM1fG@ly-workstation>
References: <202611260816.5432877c-lkp@intel.com>
 <33d3b7b8-df97-4db5-875f-3f39cd07672b@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33d3b7b8-df97-4db5-875f-3f39cd07672b@linux.intel.com>

On Thu, Nov 26, 2026 at 09:48:06AM +0800, Mi, Dapeng wrote:
> The warning looks triggered by below code.
> 
>         if (WARN_ON_ONCE(!header->size)) {
>             corrupted = true;
>             goto done;
>         }
> 
> Generally it indicates perf gets a PEBS record with 0 size which should be
> impossible in theory. 
> 
> Yi, how frequently did you see the issue? If it can be reproduced, I can
> find a DMR to debug the issue. Thanks.

I reran the case for 30 times. The reproduction rate is low - 1 out of
30.
 
> 
> 
> On 11/26/2026 9:03 AM, kernel test robot wrote:
> >
> > Hello,
> >
> > kernel test robot noticed "WARNING:at_arch/x86/events/intel/ds.c:#intel_pmu_drain_arch_pebs" on:
> >
> > commit: 2721e8da2de7271533ac36285332219f700d16ca ("perf/x86/intel: Allocate arch-PEBS buffer and initialize PEBS_BASE MSR") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > [test failed on linux-next/master 3dd8c790a7b7027abdd568e36db5e82ffaea7c77]
> >
> > in testcase: fxmark
> > version: fxmark-x86_64-63bcb4e-1_20260519 with following parameters:
> >
> > 	nr_threads: 2c
> > 	disk: 1SSD
> > 	media: ssd
> > 	test: DWSL
> > 	fstype: ext4
> > 	directio: bufferedio
> > 	cpufreq_governor: performance
> >
> >
> > config: x86_64-rhel-9.4
> > compiler: gcc-14
> > test machine: 32 threads 1 sockets Genuine Intel(R) 0000 CPU @ 1.1GHz (Diamond Rapids) with 128G memory
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <yi1.lai@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202611260816.5432877c-lkp@intel.com
> >
> >
> > kern  :warn  : [   89.997775] [      C0] ------------[ cut here ]------------
> > kern  :warn  : [   89.997777] [      C0] WARNING: CPU: 0 PID: 593 at arch/x86/events/intel/ds.c:2965 intel_pmu_drain_arch_pebs (x86/events/intel/ds.c:2984)
> > kern  :warn  : [   89.997792] [      C0] Modules linked in: intel_tpmi_power_domains isst_if_common x86_pkg_temp_thermal intel_powerclamp coretemp binfmt_misc kvm_intel snd_pcm ipmi_ssif ast cxl_pmem iaa_crypto snd_timer nvme drm_client_lib libnvdimm dax_hmem kvm snd drm_shmem_helper soundcore nvme_core idxd intel_th_gth drm_kms_helper irqbypass intel_th_pci ghash_clmulni_intel idxd_bus pcspkr cxl_acpi intel_th intel_vsec acpi_ipmi cxl_port cxl_core ipmi_si ipmi_devintf einj ipmi_msghandler joydev pfr_telemetry pfr_update fuse drm nfnetlink
> > kern  :warn  : [   89.997815] [      C0] CPU: 0 UID: 0 PID: 593 Comm: sed Not tainted 6.18.0-rc1+ #1 PREEMPTLAZY
> > kern  :warn  : [   89.997819] [      C0] RIP: 0010:intel_pmu_drain_arch_pebs (x86/events/intel/ds.c:2984)
> > kern  :warn  : [   89.997822] [      C0] Code: 85 d2 48 c7 c2 c0 09 3d 83 48 0f 44 c2 e9 f8 fc ff ff 48 8d 34 0b 66 85 c0 0f 84 49 fe ff ff 0f b7 06 48 89 f3 e9 24 fe ff ff <0f> 0b e9 43 fe ff ff e8 61 b6 fe ff 48 89 ef 85 c0 74 18 48 8b 54
> > All code
> > ========
> >    0:	85 d2                	test   %edx,%edx
> >    2:	48 c7 c2 c0 09 3d 83 	mov    $0xffffffff833d09c0,%rdx
> >    9:	48 0f 44 c2          	cmove  %rdx,%rax
> >    d:	e9 f8 fc ff ff       	jmp    0xfffffffffffffd0a
> >   12:	48 8d 34 0b          	lea    (%rbx,%rcx,1),%rsi
> >   16:	66 85 c0             	test   %ax,%ax
> >   19:	0f 84 49 fe ff ff    	je     0xfffffffffffffe68
> >   1f:	0f b7 06             	movzwl (%rsi),%eax
> >   22:	48 89 f3             	mov    %rsi,%rbx
> >   25:	e9 24 fe ff ff       	jmp    0xfffffffffffffe4e
> >   2a:*	0f 0b                	ud2		<-- trapping instruction
> >   2c:	e9 43 fe ff ff       	jmp    0xfffffffffffffe74
> >   31:	e8 61 b6 fe ff       	call   0xfffffffffffeb697
> >   36:	48 89 ef             	mov    %rbp,%rdi
> >   39:	85 c0                	test   %eax,%eax
> >   3b:	74 18                	je     0x55
> >   3d:	48                   	rex.W
> >   3e:	8b                   	.byte 0x8b
> >   3f:	54                   	push   %rsp
> >
> > Code starting with the faulting instruction ===========================================
> >    0:	0f 0b                	ud2
> >    2:	e9 43 fe ff ff       	jmp    0xfffffffffffffe4a
> >    7:	e8 61 b6 fe ff       	call   0xfffffffffffeb66d
> >    c:	48 89 ef             	mov    %rbp,%rdi
> >    f:	85 c0                	test   %eax,%eax
> >   11:	74 18                	je     0x2b
> >   13:	48                   	rex.W
> >   14:	8b                   	.byte 0x8b
> >   15:	54                   	push   %rsp
> > kern  :warn  : [   89.997823] [      C0] RSP: 0000:fffffe000000d950 EFLAGS: 00010046
> > kern  :warn  : [   89.997825] [      C0] RAX: 0000000000000000 RBX: ff110001017d0000 RCX: 00000000000003f5
> > kern  :warn  : [   89.997827] [      C0] RDX: ff1100203b618cc0 RSI: fffffe000000dc80 RDI: fffffe000000da80
> > kern  :warn  : [   89.997827] [      C0] RBP: 0000f0010000f000 R08: ff1100203b618cc0 R09: 0000000000000000
> > kern  :warn  : [   89.997828] [      C0] R10: ff1100203b618cc0 R11: 0000000000000000 R12: ff110001017df000
> > kern  :warn  : [   89.997829] [      C0] R13: fffffe000000dc80 R14: ff1100203b618cc0 R15: fffffe000000def8
> > kern  :warn  : [   89.997830] [      C0] FS:  00007f1067652840(0000) GS:ff110020b7817000(0000) knlGS:0000000000000000
> > kern  :warn  : [   89.997831] [      C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > kern  :warn  : [   89.997832] [      C0] CR2: 0000558b539e4000 CR3: 0000000106eac004 CR4: 0000000000f73ef0
> > kern  :warn  : [   89.997832] [      C0] PKRU: 55555554
> > kern  :warn  : [   89.997833] [      C0] Call Trace:
> > kern  :warn  : [   89.997837] [      C0]  <NMI>
> > kern  :warn  : [   89.997842] [      C0]  handle_pmi_common (x86/events/intel/core.c:3224)
> > kern  :warn  : [   89.997847] [      C0]  ? prb_read (printk/printk_ringbuffer.c:1940)
> > kern  :warn  : [   89.997854] [      C0]  ? _prb_read_valid (printk/printk_ringbuffer.c:2164)
> > kern  :warn  : [   89.997856] [      C0]  ? desc_update_last_finalized (printk/printk_ringbuffer.c:1531)
> > kern  :warn  : [   89.997858] [      C0]  ? flush_tlb_one_kernel (x86/include/asm/paravirt.h:85 x86/mm/tlb.c:1630 x86/mm/tlb.c:1585)
> > kern  :warn  : [   89.997862] [      C0]  ? native_set_fixmap (x86/mm/pgtable.c:581 x86/mm/pgtable.c:591)
> > kern  :warn  : [   89.997863] [      C0]  ? ghes_copy_tofrom_phys (x86/include/asm/fixmap.h:167 acpi/apei/ghes.c:193 acpi/apei/ghes.c:357)
> > kern  :warn  : [   89.997872] [      C0]  intel_pmu_handle_irq (x86/events/intel/core.c:3357)
> > kern  :warn  : [   89.997875] [      C0]  perf_event_nmi_handler (x86/events/core.c:1777 x86/events/core.c:1763)
> > kern  :warn  : [   89.997878] [      C0]  nmi_handle (x86/kernel/nmi.c:182)
> > kern  :warn  : [   89.997881] [      C0]  default_do_nmi (x86/kernel/nmi.c:437 x86/kernel/nmi.c:392)
> > kern  :warn  : [   89.997886] [      C0]  exc_nmi (x86/kernel/nmi.c:587)
> > kern  :warn  : [   89.997887] [      C0]  end_repeat_nmi (x86/entry/entry_64.S:1406)
> > kern  :warn  : [   89.997890] [      C0] RIP: 0010:io_serial_in (x86/kernel/early_printk.c:102)
> > kern  :warn  : [   89.997895] [      C0] Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 0f b6 8f c1 00 00 00 0f b7 57 08 d3 e6 01 f2 ec <0f> b6 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
> > All code
> > ========
> >    0:	00 90 90 90 90 90    	add    %dl,-0x6f6f6f70(%rax)
> >    6:	90                   	nop
> >    7:	90                   	nop
> >    8:	90                   	nop
> >    9:	90                   	nop
> >    a:	90                   	nop
> >    b:	90                   	nop
> >    c:	90                   	nop
> >    d:	90                   	nop
> >    e:	90                   	nop
> >    f:	90                   	nop
> >   10:	90                   	nop
> >   11:	f3 0f 1e fa          	endbr64
> >   15:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
> >   1a:	0f b6 8f c1 00 00 00 	movzbl 0xc1(%rdi),%ecx
> >   21:	0f b7 57 08          	movzwl 0x8(%rdi),%edx
> >   25:	d3 e6                	shl    %cl,%esi
> >   27:	01 f2                	add    %esi,%edx
> >   29:	ec                   	in     (%dx),%al
> >   2a:*	0f b6 c0             	movzbl %al,%eax		<-- trapping instruction
> >   2d:	c3                   	ret
> >   2e:	cc                   	int3
> >   2f:	cc                   	int3
> >   30:	cc                   	int3
> >   31:	cc                   	int3
> >   32:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
> >   39:	00 00 00 00 
> >   3d:	0f                   	.byte 0xf
> >   3e:	1f                   	(bad)
> >   3f:	40                   	rex
> >
> > Code starting with the faulting instruction ===========================================
> >    0:	0f b6 c0             	movzbl %al,%eax
> >    3:	c3                   	ret
> >    4:	cc                   	int3
> >    5:	cc                   	int3
> >    6:	cc                   	int3
> >    7:	cc                   	int3
> >    8:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
> >    f:	00 00 00 00 
> >   13:	0f                   	.byte 0xf
> >   14:	1f                   	(bad)
> >   15:	40                   	rex
> > kern  :warn  : [   89.997896] [      C0] RSP: 0000:ffa0000002363c78 EFLAGS: 00000002
> > kern  :warn  : [   89.997897] [      C0] RAX: ffffffff81c75500 RBX: 0000000000000000 RCX: 0000000000000000
> > kern  :warn  : [   89.997897] [      C0] RDX: 00000000000003fd RSI: 0000000000000005 RDI: ffffffff840b3ea0
> > kern  :warn  : [   89.997898] [      C0] RBP: 000000000000006c R08: 6465766965636572 R09: 20494d4e202e6875
> > kern  :warn  : [   89.997898] [      C0] R10: 696563657220494d R11: 4e202e6875686855 R12: 0000000000000020
> > kern  :warn  : [   89.997899] [      C0] R13: ffffffff840b3ea0 R14: 000000000000000b R15: 0000000000000001
> > kern  :warn  : [   89.997900] [      C0]  ? mem16_serial_in (tty/serial/8250/8250_port.c:370)
> > kern  :warn  : [   89.997902] [      C0]  ? io_serial_in (x86/kernel/early_printk.c:102)
> > kern  :warn  : [   89.997904] [      C0]  ? io_serial_in (x86/kernel/early_printk.c:102)
> > kern  :warn  : [   89.997905] [      C0]  </NMI>
> > kern  :warn  : [   89.997905] [      C0]  <TASK>
> > kern  :warn  : [   89.997905] [      C0]  wait_for_lsr (tty/serial/8250/8250.h:137 tty/serial/8250/8250.h:159 tty/serial/8250/8250_port.c:1961)
> > kern  :warn  : [   89.997908] [      C0]  serial8250_console_write (tty/serial/8250/8250_port.c:3234 tty/serial/8250/8250_port.c:3275 tty/serial/8250/8250_port.c:3342)
> > kern  :warn  : [   89.997912] [      C0]  console_flush_all (printk/printk.c:3111 printk/printk.c:3199)
> > kern  :warn  : [   89.997914] [      C0]  console_unlock (printk/printk.c:3258 printk/printk.c:3298)
> > kern  :warn  : [   89.997915] [      C0]  wake_up_klogd_work_func (printk/printk.c:4498)
> > kern  :warn  : [   89.997917] [      C0]  irq_work_run_list (irq_work.c:221 irq_work.c:252)
> > kern  :warn  : [   89.997924] [      C0]  update_process_times (time/timer.c:2476)
> > kern  :warn  : [   89.997930] [      C0]  tick_nohz_handler (time/tick-sched.c:276 (discriminator 1) time/tick-sched.c:297 (discriminator 1))
> > kern  :warn  : [   89.997934] [      C0]  ? __pfx_tick_nohz_handler (time/tick-sched.c:110)
> > kern  :warn  : [   89.997936] [      C0]  __hrtimer_run_queues (time/hrtimer.c:1777 time/hrtimer.c:1841)
> > kern  :warn  : [   89.997938] [      C0]  hrtimer_interrupt (time/hrtimer.c:1903)
> > kern  :warn  : [   89.997940] [      C0]  __sysvec_apic_timer_interrupt (x86/kernel/apic/apic.c:1041 x86/kernel/apic/apic.c:1058)
> > kern  :warn  : [   89.997945] [      C0]  sysvec_apic_timer_interrupt (x86/kernel/apic/apic.c:1052 (discriminator 1) x86/kernel/apic/apic.c:1052 (discriminator 1))
> > kern  :warn  : [   89.997948] [      C0]  asm_sysvec_apic_timer_interrupt (x86/include/asm/idtentry.h:697)
> > kern  :warn  : [   89.997950] [      C0] RIP: 0033:0x558b0c0ef99c
> > kern  :warn  : [   89.997951] [      C0] Code: f8 48 c1 e0 04 48 03 45 00 45 89 e8 44 23 40 08 74 24 48 8b 73 08 48 8b 00 48 89 f2 48 83 c6 01 48 c1 e2 04 48 03 13 48 89 02 <48> 89 73 08 44 89 42 08 48 8b 55 08 48 83 c7 01 49 39 4c 24 08 7e
> > All code
> > ========
> >    0:	f8                   	clc
> >    1:	48 c1 e0 04          	shl    $0x4,%rax
> >    5:	48 03 45 00          	add    0x0(%rbp),%rax
> >    9:	45 89 e8             	mov    %r13d,%r8d
> >    c:	44 23 40 08          	and    0x8(%rax),%r8d
> >   10:	74 24                	je     0x36
> >   12:	48 8b 73 08          	mov    0x8(%rbx),%rsi
> >   16:	48 8b 00             	mov    (%rax),%rax
> >   19:	48 89 f2             	mov    %rsi,%rdx
> >   1c:	48 83 c6 01          	add    $0x1,%rsi
> >   20:	48 c1 e2 04          	shl    $0x4,%rdx
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20261126/202611260816.5432877c-lkp@intel.com
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
