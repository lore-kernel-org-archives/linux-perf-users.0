Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A443D969
	for <linux-perf-users@vger.kernel.org>; Sat, 10 Aug 2024 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723321039; cv=none; b=Eo1fFqXE8evFMzdfD37ZnibRibKZfCBXJljzj2wZAppu1qNYnWOJg9i6kkSejKncR7o3qnWxN7YN5+OlcuNwa5LyyzC/ddlyM3kx1Joel5TykqoIPZvgRrIOaYAEoj9MhB0EfmxY0U98lf6qynkjN/fUStRo8c2e+vjRpOPMu3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723321039; c=relaxed/simple;
	bh=SXSi/3v8dh2NE9XUShMHnCDukg+r/hBbzhNAnHVRNKs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PWO9Au4FYGTIGwj05AJtyca/GeobBsyOxYF1oWHcv3WzP5LNoSkV9pFg18O85sW1OoiH+XtQpz2LFG50pveaXMpzuw1rynAlNHgc8MvOkEeLN4FD8nUyTpfAPhH7iT+Dznm+2kx+npefufto3tfwh1h2OaPhxK5N8j9vDoSl+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f8c780fe7so372251439f.1
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Aug 2024 13:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723321036; x=1723925836;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZSi5KSqNadG2aHlWrtGOVYVfQiq35d108U9w4ypE5I=;
        b=Djr4OAqGJO4NLtAAGhH1KtTptzOIL2nJBtbiKbXluccUYW3408OLg3vZrFpIwER8vR
         l83tlTUV814fUOp8W0uygwDSxnJm0hX2PO9i7+pDtmM9ondzx6fO5FsIk6mVO3gIs/57
         AlrGSWVJPqRP8bA1TZXv+JkfbY33Y/kuAPw4pUAyj3cqLTZmGEywohtHnPGZniMWJ5UH
         khbwPamkAbJKKLIDoiw9NU1tmR38dqCSLoG/691oKmvG3gDJd6Htx1DZPna+nmc+1d/7
         DINbWHmILkE8UCu0VHtyebnekDUmVmdCqneawGp4vPWFJufu4XBLWxFHBAk7byQqA9gc
         UYIg==
X-Forwarded-Encrypted: i=1; AJvYcCX7Sdz8Vgzs9WXZv6w5RSx2yRccPNEyvVt79GcA/hifbX0aZiobYRfm3/yfweA1I1UhuF0as7rmHVZthgNw0D9905C0MGObaYiwJEcSu7L+WA==
X-Gm-Message-State: AOJu0Yw+MlOtM697jxOBwCv5dWSaYqO6FTMmRztLNa/uZgg6mDFD2vNj
	RvjqFLDAJTMyPasWFmPxKiHCC3+3VYL+VG6PzhI6ifw4ZumVf+FCz1iieYQDJzHLTYzuh0icV0y
	NUEK5NiSupR0IVhaxI7axoAMFn5sL+iC2nO8R6QV9gbjGq5ivUc7oHLc=
X-Google-Smtp-Source: AGHT+IGkoJaqQw6OyIuK4kTeedHKxq+oWI5MGemm8fdASR7OVIWIZjYXM/CWhUrXKSbIrVvUPVFSDNR+43CVQWRLcQImAJYsq/lj
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:340b:b0:81f:7d7d:89fd with SMTP id
 ca18e2360f4ac-8225ecd9524mr19521639f.1.1723321036576; Sat, 10 Aug 2024
 13:17:16 -0700 (PDT)
Date: Sat, 10 Aug 2024 13:17:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000382d39061f59f2dd@google.com>
Subject: [syzbot] [perf?] KASAN: slab-use-after-free Read in __uprobe_unregister
From: syzbot <syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mark.rutland@arm.com, mhiramat@kernel.org, mingo@redhat.com, 
	namhyung@kernel.org, oleg@redhat.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6a0e38264012 Merge tag 'for-6.11-rc2-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d4fc91980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=505ed4a1dd93463a
dashboard link: https://syzkaller.appspot.com/bug?extid=f7a1c2c2711e4a780f19
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fd9755980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1546c4e5980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-6a0e3826.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dd9ba9302e4d/vmlinux-6a0e3826.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aa3ef19fbf4e/bzImage-6a0e3826.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com

R10: 0000000000000001 R11: 0000000000000246 R12: 00007f4aa48c4618
R13: 00007ffc0345d258 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
==================================================================
BUG: KASAN: slab-use-after-free in consumer_del kernel/events/uprobes.c:772 [inline]
BUG: KASAN: slab-use-after-free in __uprobe_unregister+0x210/0x260 kernel/events/uprobes.c:1087
Read of size 8 at addr ffff888025a498b8 by task syz-executor380/5333

CPU: 2 UID: 0 PID: 5333 Comm: syz-executor380 Not tainted 6.11.0-rc2-syzkaller-00027-g6a0e38264012 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 consumer_del kernel/events/uprobes.c:772 [inline]
 __uprobe_unregister+0x210/0x260 kernel/events/uprobes.c:1087
 uprobe_unregister+0x45/0x70 kernel/events/uprobes.c:1111
 bpf_uprobe_unregister+0xfb/0x1d0 kernel/trace/bpf_trace.c:3187
 bpf_uprobe_multi_link_release+0x6d/0x180 kernel/trace/bpf_trace.c:3197
 bpf_link_free+0x12c/0x2b0 kernel/bpf/syscall.c:3067
 bpf_link_put_direct kernel/bpf/syscall.c:3107 [inline]
 bpf_link_release+0x63/0x80 kernel/bpf/syscall.c:3114
 __fput+0x408/0xbb0 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2bb0 kernel/exit.c:882
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1040
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4aa48570e9
Code: Unable to access opcode bytes at 0x7f4aa48570bf.
RSP: 002b:00007ffc0345d048 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4aa48570e9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f4aa48ca350 R08: ffffffffffffffb8 R09: 00007f4aa48c0038
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f4aa48ca350
R13: 0000000000000000 R14: 00007f4aa48cada0 R15: 00007f4aa48211a0
 </TASK>

Allocated by task 5333:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4158 [inline]
 __kmalloc_node_noprof+0x211/0x430 mm/slub.c:4164
 __kvmalloc_node_noprof+0x9d/0x1a0 mm/util.c:650
 kvmalloc_array_node_noprof include/linux/slab.h:833 [inline]
 bpf_uprobe_multi_link_attach+0x45d/0xe20 kernel/trace/bpf_trace.c:3439
 link_create kernel/bpf/syscall.c:5319 [inline]
 __sys_bpf+0x41ff/0x4a20 kernel/bpf/syscall.c:5780
 __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5815
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5333:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4594
 kvfree+0x47/0x50 mm/util.c:696
 bpf_uprobe_multi_link_attach+0xaae/0xe20 kernel/trace/bpf_trace.c:3500
 link_create kernel/bpf/syscall.c:5319 [inline]
 __sys_bpf+0x41ff/0x4a20 kernel/bpf/syscall.c:5780
 __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5815
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888025a49880
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 56 bytes inside of
 freed 64-byte region [ffff888025a49880, ffff888025a498c0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25a49
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff8880158428c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080200020 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 11, tgid 11 (kworker/u32:0), ts 16060739565, free_ts 16025939467
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x1351/0x2e50 mm/page_alloc.c:3442
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4700
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x4e/0xf0 mm/slub.c:2321
 allocate_slab mm/slub.c:2484 [inline]
 new_slab+0x84/0x260 mm/slub.c:2537
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3723
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 __kmalloc_cache_node_noprof+0xf1/0x350 mm/slub.c:4197
 kmalloc_node_noprof include/linux/slab.h:704 [inline]
 __get_vm_area_node+0xe1/0x2d0 mm/vmalloc.c:3109
 __vmalloc_node_range_noprof+0x276/0x1520 mm/vmalloc.c:3801
 alloc_thread_stack_node kernel/fork.c:313 [inline]
 dup_task_struct kernel/fork.c:1113 [inline]
 copy_process+0x2f3b/0x8de0 kernel/fork.c:2204
 kernel_clone+0xfd/0x980 kernel/fork.c:2781
 user_mode_thread+0xb4/0xf0 kernel/fork.c:2859
 call_usermodehelper_exec_work kernel/umh.c:172 [inline]
 call_usermodehelper_exec_work+0xcb/0x170 kernel/umh.c:158
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
page last free pid 986 tgid 986 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2612
 vfree+0x181/0x7a0 mm/vmalloc.c:3364
 delayed_vfree_work+0x56/0x70 mm/vmalloc.c:3285
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888025a49780: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888025a49800: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
>ffff888025a49880: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                        ^
 ffff888025a49900: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888025a49980: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
