Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1DC6F06B;
	Wed, 23 Jul 2025 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268570; cv=none; b=pVx1KxdHqBf0ybOGKFitMQWnbv3YwRLZNmykNmcExSQbqfo+yT/2UiSOpdF5MiYWPDbiWcObJrr9Ch2j9q+zpBS+mJavvtaV2V0xuTY5PGuS13kxPpgUspOHW3XjwGQdkuNXEnGggudOhU+qEykJ9xe3/TXqkpkuWl+GctYZ674=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268570; c=relaxed/simple;
	bh=7TUTvKtalQdMgk4iybDHiIaixywXXBTmIw3de8n0g9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lzmrAX6ilvZs2xc6WfrTfemOxmk0HxXDyQgEaeArRQpvQttQ/KfD2KMyWFdT76BTDQmptfTXEsSjxEitDIVQqqtk4GuxAmgnb4uuMQpzAmJhE7AfUZhm/2rJCSqjYdU9x0OH24DZTOMLZpFCD5SHu6D2FsKCfP3dEC51fmyiHkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b3f2ea2f96fso322898a12.0;
        Wed, 23 Jul 2025 04:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753268568; x=1753873368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIaSs7Fhujj41mthw9JZxgIBsdS8g/yHvNODnq+JPvU=;
        b=cTBswxG5dBIXGNX/Jbeh/s/ruLmOn6lAvY6IkCshLatGAQ5rbgDVbnqT4p+K4sYQ/l
         0ZQoSA2eMy0xEDOF5cN8PUTVOuyFs8G+b1FuO4tSjgbBOcs/n1EDKYa6IBbYhHbx4e4y
         mE/rWN1HH2jCQD87/cyNT0cAVYnwZIeliugk6VWBEgWWYcAr/WNqnQrjAShbgfPLjElR
         k+S6MCQn9L0Qa6osdKBDZWg+VRweJVLN/Dcj5v9Ml61jizF7KzoF16ZwU4iIqYyHTFGX
         x14cDV3yyB5tQqej/vuTkyx2zVMRVn1Y+gQF1aH88pFl5q5c23PeVu8ZtiIVfCxoaiZL
         ZyZw==
X-Forwarded-Encrypted: i=1; AJvYcCUOd+3RwgeLJXD/RUrmzdacGacmZWM4XhOnEuP+HA06G61rYy0Pi2g+7KhrRyI/SGHeqdPPlsOGR1QPiTPdcvmlLw==@vger.kernel.org, AJvYcCUa1iDIGMK9b5jqBFB0qmHPYZSWPUabXqLhfy17AueKfhAfWLw6taVMwA5kTEeL4gNUd1xkkRZasOHDga8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAxtQa4Pg/zNFG7Y0bwVB1ax7kPDWzCNQx1OGskOS6VO4FPHmF
	i0Vc296TylWOj0VaiMhAj4kf18KaMaLTxXAjctiZm+XHXwZ2W+hcwPcl
X-Gm-Gg: ASbGncuf+WnS3DCp5p97/iuaktePmz8p4LMHoGcUoJXvYYpB5fwBF9UjOFUXQiuWVg+
	H44oBwTpAzBsl+RMYKm4R7bx30wvk5qJSQASdYEnfD4LeAe2ZXVOf0OS8MwkJvzLnWecaTt9PEi
	AN7IIKr2ctwgDxDvrag2tPmnF1d6kFaeyX/wau7O+zOcg85/HCGQCy2AMWXkRYpvXhw6W3qCP4p
	ev+dRxLP1g64Rac34tJzQSKPcbViztK3RDLY24eHIdIrDwOSesq7nf1d6658hI4YYbp3MoRI7NR
	hNDiiYcBpVfeSZD5ripidT2r/cyOnrhviehV4pTjW+fG5JKZEb9mRxFDbog0E+i/ycBMCTg98TJ
	M5h4v9NGlE8bc
X-Google-Smtp-Source: AGHT+IG2WnYfXBAsSOophfSvE8ZsJU3rbkH3GWiFlG4n7LRfHTdG8XzpOYxVzgOnCs7BXHCIpO4Q4A==
X-Received: by 2002:a05:6a20:158f:b0:220:839d:1d61 with SMTP id adf61e73a8af0-23d49198aafmr1604510637.9.1753268567669;
        Wed, 23 Jul 2025 04:02:47 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-75eb876df3csm3572462b3a.7.2025.07.23.04.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 04:02:47 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Hemendra Dassanayake <Hemendra.Dassanayake@arm.com>,
	Austin Kim <austindh.kim@gmail.com>,
	Michelle Jin <shjy180909@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	syzkaller@googlegroups.com
Subject: [PATCH] perf: arm_pmuv3: Fix kernel panic on UBSAN from negative hw.idx in armv8pmu_enable/disable_event()
Date: Wed, 23 Jul 2025 10:44:03 +0000
Message-ID: <20250723104359.364547-5-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When 'event->hw.idx' was negative in armv8pmu_enable/disable_event().

  UBSAN: shift-out-of-bounds in drivers/perf/arm_pmuv3.c:716:25
  shift exponent -1 is negative

  UBSAN: shift-out-of-bounds in drivers/perf/arm_pmuv3.c:658:13
  shift exponent -1 is negative

This occurred because a perf_event could reach armv8pmu event with a
negative idx, typically when a valid counter could not be allocated.

This issue was observed when running KVM on Radxa's Orion6 platform.

The issue was previously guarded indirectly by armv8pmu_event_is_chained(),
which internally warned and returned false for idx < 0. But since the
commit 29227d6ea157 ("arm64: perf: Clean up enable/disable calls"), this
check was removed.

To prevent undefined behavior, add an explicit guard to early return from
armv8pmu event if hw.idx < 0, similar to handling in other PMU drivers.
(e.g. intel_pmu_disable_event() on arch/x86/events/intel/core.c)

$ ./syz-execprog -executor=./syz-executor -repeat=0  -sandbox=none \
  -disable=binfmt_misc,cgroups,close_fds,devlink_pci,ieee802154,net_dev,net_reset,nic_vf,swap,sysctl,tun,usb,vhci,wifi \
  -procs=8 perf.syz

r0 = perf_event_open(&(0x7f0000000240)={
        0x0, 0x80, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
        0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
        0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
        0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
        0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
        @perf_config_ext
    }, 0x0, 0x0, 0xffffffffffffffff, 0x0)

perf_event_open(&(0x7f0000000280)={
        0x0, 0x80, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
        0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
        0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
        0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
        0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
        @perf_config_ext
    }, 0x0, 0x0, r0, 0x0)

perf_event_open(&(0x7f0000000540)={
        0x3, 0x80, 0x0, 0x0, 0x0, 0x0, 0x0, 0x4, 0x0, 0x0,
        0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
        0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
        0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
        0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x4,
        @perf_bp={0x0, 0x2}, 0x20, 0x0, 0x0, 0x0, 0x2,
        0x0, 0x0, 0x0, 0x0, 0x0, 0x81
    }, 0x0, 0x0, r0, 0x0)

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in drivers/perf/arm_pmuv3.c:716:25
shift exponent -1 is negative
CPU: 0 UID: 0 PID: 8405 Comm: syz.3.19 Tainted: G        W           6.16.0-rc2-g5982a539cdce #3 PREEMPT
Tainted: [W]=WARN
Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8 05/13/2025
Call trace:
 show_stack+0x2c/0x3c (C)
 __dump_stack+0x30/0x40
 dump_stack_lvl+0xd8/0x12c
 dump_stack+0x1c/0x28
 ubsan_epilogue+0x14/0x48
 __ubsan_handle_shift_out_of_bounds+0x2b0/0x34c
 armv8pmu_enable_event+0x3c4/0x4b0
 armpmu_start+0xc4/0x118
 perf_event_unthrottle_group+0x3a8/0x50c
 perf_adjust_freq_unthr_events+0x2f4/0x578
 perf_adjust_freq_unthr_context+0x278/0x46c
 perf_event_task_tick+0x394/0x5b0
 sched_tick+0x314/0x6cc
 update_process_times+0x374/0x4b0
 tick_nohz_handler+0x334/0x480
 __hrtimer_run_queues+0x3ec/0xb78
 hrtimer_interrupt+0x2b8/0xb50
 arch_timer_handler_virt+0x74/0x88
 handle_percpu_devid_irq+0x174/0x308
 generic_handle_domain_irq+0xe0/0x140
 gic_handle_irq+0x6c/0x190
 call_on_irq_stack+0x24/0x30
 do_interrupt_handler+0xd4/0x138
 el1_interrupt+0x34/0x54
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x6c/0x70
 generic_exec_single+0x2dc/0x304 (P)
 smp_call_function_single+0x308/0x530
 perf_install_in_context+0x4a0/0x798
 __arm64_sys_perf_event_open+0x184c/0x1d50
 invoke_syscall+0x98/0x2b8
 el0_svc_common+0x130/0x23c
 do_el0_svc+0x48/0x58
 el0_svc+0x58/0x17c
 el0t_64_sync_handler+0x78/0x108
 el0t_64_sync+0x198/0x19c
---[ end trace ]---
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in drivers/perf/arm_pmuv3.c:658:13
shift exponent -1 is negative
CPU: 0 UID: 0 PID: 8006 Comm: syz.0.19 Not tainted 6.16.0-rc2-g5982a539cdce #3 PREEMPT
Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8 05/13/2025
Call trace:
 show_stack+0x2c/0x3c (C)
 __dump_stack+0x30/0x40
 dump_stack_lvl+0xd8/0x12c
 dump_stack+0x1c/0x28
 ubsan_epilogue+0x14/0x48
 __ubsan_handle_shift_out_of_bounds+0x2b0/0x34c
 armv8pmu_disable_event+0x228/0x2f8
 armpmu_stop+0xa0/0x104
 perf_event_throttle_group+0x354/0x4cc
 __perf_event_account_interrupt+0x26c/0x290
 __perf_event_overflow+0xe8/0xd28
 perf_event_overflow+0x38/0x4c
 armv8pmu_handle_irq+0x244/0x320
 armpmu_dispatch_irq+0x6c/0x9c
 handle_percpu_devid_irq+0x174/0x308
 generic_handle_domain_irq+0xe0/0x140
 gic_handle_irq+0x6c/0x190
 call_on_irq_stack+0x24/0x30
 do_interrupt_handler+0xd4/0x138
 el1_interrupt+0x34/0x54
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x6c/0x70
 generic_exec_single+0x2dc/0x304 (P)
 smp_call_function_single+0x308/0x530
 perf_install_in_context+0x4a0/0x798
 __arm64_sys_perf_event_open+0x184c/0x1d50
 invoke_syscall+0x98/0x2b8
 el0_svc_common+0x130/0x23c
 do_el0_svc+0x48/0x58
 el0_svc+0x58/0x17c
 el0t_64_sync_handler+0x78/0x108
 el0t_64_sync+0x198/0x19c
---[ end trace ]---
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in drivers/perf/arm_pmuv3.c:730:26
shift exponent -1 is negative
CPU: 0 UID: 0 PID: 8006 Comm: syz.0.19 Not tainted 6.16.0-rc2-g5982a539cdce #3 PREEMPT
Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8 05/13/2025
Call trace:
 show_stack+0x2c/0x3c (C)
 __dump_stack+0x30/0x40
 dump_stack_lvl+0xd8/0x12c
 dump_stack+0x1c/0x28
 ubsan_epilogue+0x14/0x48
 __ubsan_handle_shift_out_of_bounds+0x2b0/0x34c
 armv8pmu_disable_event+0x298/0x2f8
 armpmu_stop+0xa0/0x104
 perf_event_throttle_group+0x354/0x4cc
 __perf_event_account_interrupt+0x26c/0x290
 __perf_event_overflow+0xe8/0xd28
 perf_event_overflow+0x38/0x4c
 armv8pmu_handle_irq+0x244/0x320
 armpmu_dispatch_irq+0x6c/0x9c
 handle_percpu_devid_irq+0x174/0x308
 generic_handle_domain_irq+0xe0/0x140
 gic_handle_irq+0x6c/0x190
 call_on_irq_stack+0x24/0x30
 do_interrupt_handler+0xd4/0x138
 el1_interrupt+0x34/0x54
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x6c/0x70
 generic_exec_single+0x2dc/0x304 (P)
 smp_call_function_single+0x308/0x530
 perf_install_in_context+0x4a0/0x798
 __arm64_sys_perf_event_open+0x184c/0x1d50
 invoke_syscall+0x98/0x2b8
 el0_svc_common+0x130/0x23c
 do_el0_svc+0x48/0x58
 el0_svc+0x58/0x17c
 el0t_64_sync_handler+0x78/0x108
 el0t_64_sync+0x198/0x19c
---[ end trace ]---

Fixes: 29227d6ea157 ("arm64: perf: Clean up enable/disable calls")
Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
Tested-by: Yunseong Kim <ysk@kzalloc.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: syzkaller@googlegroups.com
---
 drivers/perf/arm_pmuv3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 3db9f4ed17e8..846d69643fd8 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -795,6 +795,9 @@ static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
 
 static void armv8pmu_enable_event(struct perf_event *event)
 {
+	if (unlikely(event->hw.idx < 0))
+		return;
+
 	armv8pmu_write_event_type(event);
 	armv8pmu_enable_event_irq(event);
 	armv8pmu_enable_event_counter(event);
@@ -802,6 +805,9 @@ static void armv8pmu_enable_event(struct perf_event *event)
 
 static void armv8pmu_disable_event(struct perf_event *event)
 {
+	if (unlikely(event->hw.idx < 0))
+		return;
+
 	armv8pmu_disable_event_counter(event);
 	armv8pmu_disable_event_irq(event);
 }
-- 
2.50.0

