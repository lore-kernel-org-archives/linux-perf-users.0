Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C6928850C
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769471428; cv=none; b=QGzp6QHwF2IKdvRyPE/r+sRnoEC3ywJx26Dt/Gl6aO+lp/CCgXANMTGGzs2MACJpDQNuUfIXqifEETkwJ9+p0wbfr5i/QMcfprcfi//45oSQi1GCerJ2I2+yjwwLpElU/uzrdVUoM8IsKPogncDEnsgqHAubveSeB9QKquGJeZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769471428; c=relaxed/simple;
	bh=Hhn8L4ofSaef94JjOllTZj2cG/+x/ZB1E3HHPE7Kf5s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UDSvlSUuefpah5v19xyxum/uWXI0s3Fk2FUxbDbTZIS5LzTehz8dWSXikz2urD6+jyejvgTkwE4n5oyHCr2k9VwuYZcjGuHs9bvTTKEUrUa24a+yb/AfHl6GVirbYxm7wWvLOUnopXp+SyuCiT57/hWXhb+FidgqQ1G/hGfsoJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-662ca77e1fcso16181120eaf.2
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 15:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471426; x=1770076226;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OUcT7xREhnX/IAt16z2c9wkexZW/jShkkRyrsVh2wUw=;
        b=LEOx9fvro1HaXHnPjzrsYyT5OWQIsemupcYK83Kkv5i9kBfQg6GPEfl4nURymoFsoG
         HQWUSBLcgg4nwdzwuSSIjF10W7O8krZzuGI8RTXnWGm7zpGX2KOraEtxce5YiD1R/27k
         o4iSM57W1L+bnHIa4OGqTk0xoV1ck2nRKa5YkR+6TMcQmOr6x9D1an9NWGVmgqzHoZXh
         tsd25J8LqB0IbgxPA4/XQDih2gP1wgfhHAtpMauaYTEF3SiXlRpbs2GTyCU7h+ZRsxzZ
         qu4errCosP6r6zqSMJQXtHVtcJEmBZt26alTvbORODArPdRn6ai0Rh2x8iz4gSryLn9Z
         X5jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpv9aQdQcRihSUmlrHC9JoJhPhWrNcLoC4VsOE7v+f6huWIjWMniTct7ZNCHRA5o3Upp9uPt1XFvqKiqflNzed@vger.kernel.org
X-Gm-Message-State: AOJu0YxGkila5nn6PRWiInvAeJ6bhVp+0tDe9XOISXnC8k/vZNlU0pjE
	aTAQ5YwIUEIG4IBztXa8elvC2lV18KZG89nol/gW/l/JRd6ysH+/ZBnIKrFulOhE9ILeGsivMQI
	YFeDnZhrPZK/PvsO5iRPIDvVeyTXLIYpidy9LhaNUDwKD9kk8OnqPsaoVx1s=
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:206:b0:662:c105:f781 with SMTP id
 006d021491bc7-662e02cfd54mr2783776eaf.13.1769471425822; Mon, 26 Jan 2026
 15:50:25 -0800 (PST)
Date: Mon, 26 Jan 2026 15:50:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6977fdc1.050a0220.c9109.0007.GAE@google.com>
Subject: [syzbot] [perf?] KCSAN: data-race in __perf_event_overflow / __perf_event_set_bpf_prog
From: syzbot <syzbot+2a077cb788749964cf68@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    023777797472 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12540a44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183
dashboard link: https://syzkaller.appspot.com/bug?extid=2a077cb788749964cf68
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7a5f13477745/disk-02377779.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/526049e9cfef/vmlinux-02377779.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1da969a6e6f0/bzImage-02377779.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a077cb788749964cf68@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __perf_event_overflow / __perf_event_set_bpf_prog

write to 0xffff88811b219168 of 8 bytes by task 13065 on cpu 0:
 perf_event_set_bpf_handler kernel/events/core.c:10352 [inline]
 __perf_event_set_bpf_prog+0x418/0x470 kernel/events/core.c:11303
 _perf_ioctl kernel/events/core.c:6376 [inline]
 perf_ioctl+0x92e/0x15d0 kernel/events/core.c:6436
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xce/0x140 fs/ioctl.c:583
 __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:583
 x64_sys_call+0x14b0/0x3000 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811b219168 of 8 bytes by interrupt on cpu 1:
 __perf_event_overflow+0x252/0x920 kernel/events/core.c:10410
 perf_swevent_hrtimer+0x28d/0x310 kernel/events/core.c:11865
 __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
 __hrtimer_run_queues+0x20f/0x590 kernel/time/hrtimer.c:1841
 hrtimer_interrupt+0x269/0x810 kernel/time/hrtimer.c:1903
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1045 [inline]
 __sysvec_apic_timer_interrupt+0x5f/0x1d0 arch/x86/kernel/apic/apic.c:1062
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0x6f/0x80 arch/x86/kernel/apic/apic.c:1056
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
 __tsan_read8+0x12/0x190 kernel/kcsan/core.c:1025
 ma_dead_node lib/maple_tree.c:572 [inline]
 mtree_range_walk lib/maple_tree.c:2580 [inline]
 mas_state_walk+0x485/0x650 lib/maple_tree.c:3298
 mt_find+0x11d/0x3b0 lib/maple_tree.c:6497
 find_vma+0x6c/0xa0 mm/mmap.c:906
 lock_mm_and_find_vma+0x5f/0x400 mm/mmap_lock.c:453
 do_user_addr_fault+0x277/0x1050 arch/x86/mm/fault.c:1357
 handle_page_fault arch/x86/mm/fault.c:1474 [inline]
 exc_page_fault+0x62/0xa0 arch/x86/mm/fault.c:1527
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
 fault_in_readable+0xad/0x170 mm/gup.c:-1
 fault_in_iov_iter_readable+0x129/0x210 lib/iov_iter.c:106
 generic_perform_write+0x3ce/0x490 mm/filemap.c:4363
 shmem_file_write_iter+0xc5/0xf0 mm/shmem.c:3490
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5a6/0x9f0 fs/read_write.c:686
 ksys_write+0xdc/0x1a0 fs/read_write.c:738
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __x64_sys_write+0x40/0x50 fs/read_write.c:746
 x64_sys_call+0x2847/0x3000 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000000000 -> 0xffffc900032a7000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 13062 Comm: syz.1.2487 Tainted: G        W           syzkaller #0 PREEMPT(voluntary) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
