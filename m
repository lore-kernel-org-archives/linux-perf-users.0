Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE3515FA6B
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721844925; cv=none; b=Tm4g7nrh+dk0pZ+WJ6fSdiVld/GFeBaMSJA321mBYuNQex2T0zvn4WeuCdG/wRoH15Z2pFka0ff6nGH7LW9oH7bxv0a98hGb7bwQ+9QGqWUPK5RA22o5hZJKZqOePWeb8V76y2EwFUttX/CQJDFqMMRTlxZPiO5qZNTPz2NQrMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721844925; c=relaxed/simple;
	bh=HsYiD+BxlM3IKxCFUe1tHbySqCINmnrf1aGa1RdsBgw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Yhiz10Yx88uHgJtf1VeV3IVUueb9YWbaVV9/Ke/pU+l8ojn+eE4bqy2b7QNWgzJx7FagJ7WPfzo6F/2t+BkzN2AgLCK9jFwjzjfdSaSRMR74nLrXdUpf73ZrHSctyzkpDNhs7+nE1k6WQbZ/+yCNtMtvYM5ESE70DFUgKs8zKME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39827d07ca7so198115ab.3
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 11:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721844923; x=1722449723;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pq/aY1uZpcKlTSZw6vqPMwHKRw/VghNHj3yok+rymnE=;
        b=twj7fVAX23HTgu2NfPjstTUBnbj4Ckbo0yp8I/d+jkZUz/nDM98CepAmGCCJ+M9W/s
         GoQClJNgVaaB0nmcPQc7DEiIJaQov9G4MiACViq8NvAexKCS6o6znnLEhdh3CZDx0OC9
         SY2FJjbbA+1cyigx8OUjUKVNwZXMtgDreWxb4CVy44Rov2Snekuu3j4oBFv1HMEo4B2I
         oy2kIRUIs1/A/F22eVvaP8Ge/alNtxpv/wgaUvNDyvEvy3WgCOAuBpsDvZx8pW9vUfWP
         jn3tt5MbVyeXMwSH2KOEz9Q7nHf1JPRVbjnEpb0gdTkCRlh/m+wjol0MwVvaX5yP2j/N
         elFw==
X-Forwarded-Encrypted: i=1; AJvYcCWH3SswlNA2FQo9dsyBIPu260Ga0FlBClJ568JJXRPe+5yVN9RiEpxgJf23SuHImdJCo2dW2rWxzScddm9R5y6Q2bSGLppGzGl5IU7B8TSIaA==
X-Gm-Message-State: AOJu0YxcO198hTcXdZNFo4xggbJNHACDwsd+D6oPwjpQp4F3eCkmP3Oe
	YtLSM2613WZYvd++MbZni9m/kZfs6jgD0hoHt4vJ7jSm3ujRQNMdkyBFmkGHyqz3QIEm1PxLmVH
	skwoxIlInm81zMovYsU7lLhMAWD7quQbMkX7p4t7LEpVaZdNSZuY6kXs=
X-Google-Smtp-Source: AGHT+IEOYJVukyhHJOPwPePnIn6EyBGwEYmrGnlNkyr/Fm3lWthLg/m1nygm7RQQdYVeGFfSPnAewcAvd8mOqQlFWgyi0Tp9EOC+
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c89:b0:397:b509:6441 with SMTP id
 e9e14a558f8ab-39a217d29bemr565555ab.2.1721844922701; Wed, 24 Jul 2024
 11:15:22 -0700 (PDT)
Date: Wed, 24 Jul 2024 11:15:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9e66b061e024217@google.com>
Subject: [syzbot] [perf?] KASAN: slab-use-after-free Read in uprobe_mmap
From: syzbot <syzbot+ab687d3cbad90def4b18@syzkaller.appspotmail.com>
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

HEAD commit:    786c8248dbd3 Merge tag 'perf-tools-fixes-for-v6.11-2024-07..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a6f1f1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fd768013789223fa
dashboard link: https://syzkaller.appspot.com/bug?extid=ab687d3cbad90def4b18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d1499b23d099/disk-786c8248.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a2ccae57b0f3/vmlinux-786c8248.xz
kernel image: https://storage.googleapis.com/syzbot-assets/501a769c268d/bzImage-786c8248.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab687d3cbad90def4b18@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in consumer_filter kernel/events/uprobes.c:869 [inline]
BUG: KASAN: slab-use-after-free in filter_chain kernel/events/uprobes.c:880 [inline]
BUG: KASAN: slab-use-after-free in uprobe_mmap+0xb9a/0x11a0 kernel/events/uprobes.c:1387
Read of size 8 at addr ffff88805db85f30 by task syz.1.3317/17070

CPU: 0 UID: 0 PID: 17070 Comm: syz.1.3317 Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 consumer_filter kernel/events/uprobes.c:869 [inline]
 filter_chain kernel/events/uprobes.c:880 [inline]
 uprobe_mmap+0xb9a/0x11a0 kernel/events/uprobes.c:1387
 mmap_region+0x1891/0x2090 mm/mmap.c:3028
 do_mmap+0x8ad/0xfa0 mm/mmap.c:1438
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 ksys_mmap_pgoff+0x4f1/0x720 mm/mmap.c:1484
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f44e3d75f19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f44e4a78048 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f44e3f05f60 RCX: 00007f44e3d75f19
RDX: 0000000000000001 RSI: 0000000000004000 RDI: 0000000020000000
RBP: 00007f44e3de4e68 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000010012 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f44e3f05f60 R15: 00007fff70446248
 </TASK>

Allocated by task 16248:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4158 [inline]
 __kmalloc_noprof+0x1fc/0x400 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 lsm_task_alloc security/security.c:691 [inline]
 security_task_alloc+0x43/0x130 security/security.c:3038
 copy_process+0x169e/0x3dc0 kernel/fork.c:2356
 kernel_clone+0x226/0x8f0 kernel/fork.c:2781
 __do_sys_clone kernel/fork.c:2924 [inline]
 __se_sys_clone kernel/fork.c:2908 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2908
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 16:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x149/0x360 mm/slub.c:4594
 security_task_free+0xa0/0xc0 security/security.c:3059
 __put_task_struct+0xf9/0x290 kernel/fork.c:975
 put_task_struct include/linux/sched/task.h:138 [inline]
 delayed_put_task_struct+0x125/0x2f0 kernel/exit.c:228
 rcu_do_batch kernel/rcu/tree.c:2569 [inline]
 rcu_core+0xaff/0x1830 kernel/rcu/tree.c:2843
 handle_softirqs+0x2c6/0x970 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:928
 smpboot_thread_fn+0x546/0xa30 kernel/smpboot.c:164
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88805db85f00
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 48 bytes inside of
 freed 64-byte region [ffff88805db85f00, ffff88805db85f40)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88805db85f00 pfn:0x5db85
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000200 ffff8880150418c0 ffffea0001f2d550 ffffea000055f310
raw: ffff88805db85f00 000000000020001e 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5098, tgid 5098 (syz-executor), ts 78147194519, free_ts 78099329059
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3438
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4696
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2321
 allocate_slab+0x5a/0x2f0 mm/slub.c:2484
 new_slab mm/slub.c:2537 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
 __slab_alloc+0x58/0xa0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_noprof+0x25a/0x400 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 kobject_get_path+0xb8/0x230 lib/kobject.c:161
 kobject_uevent_env+0x2a5/0x8e0 lib/kobject_uevent.c:530
 netdev_queue_add_kobject net/core/net-sysfs.c:1797 [inline]
 netdev_queue_update_kobjects+0x2c4/0x5f0 net/core/net-sysfs.c:1838
 register_queue_kobjects net/core/net-sysfs.c:1900 [inline]
 netdev_register_kobject+0x265/0x320 net/core/net-sysfs.c:2140
 register_netdevice+0x12c5/0x1b00 net/core/dev.c:10435
 rtnl_newlink_create net/core/rtnetlink.c:3512 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
 rtnl_newlink+0x1728/0x20a0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x741/0xcf0 net/core/rtnetlink.c:6647
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2550
page last free pid 5139 tgid 5139 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_folios+0x103a/0x1b00 mm/page_alloc.c:2656
 folios_put_refs+0x76e/0x860 mm/swap.c:1039
 free_pages_and_swap_cache+0x2ea/0x690 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x44f/0xc80 mm/mmap.c:3395
 __mmput+0x115/0x390 kernel/fork.c:1345
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x27f0 kernel/exit.c:869
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x26c3/0x26d0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805db85e00: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
 ffff88805db85e80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
>ffff88805db85f00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                     ^
 ffff88805db85f80: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
 ffff88805db86000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
