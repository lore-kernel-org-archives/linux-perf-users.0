Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794789924;
	b=pOO8ngB0Zaw/eMsbiMQr/5Zc5gibcB/uEUyGalhdJueexdo3E6IMOOE9CdBcrEG3lAJL
	 KrCSCCkv4sqCcjVpYlV6YBkncryVa3/oI2mMy2pPZEY8eLpE38Ht62wxvPBeQVDdx9eGy
	 +wkVohOetacqoZ+qOUTAJqzyj2YOAIec95cj6+Yf5PrrMkGEr+uM3ok6/lJD5GKKAdRpl
	 Ht+tNrEfdB52k0cOvFvO9pDjJNIzjLMBVb+VgkGtBEjKMPCoMq35d1dv960ArDIV1bexk
	 b4LLhqg44nZDUE6TFxY1W6x4MjWNI1tpS8+axKuW9l4b8KrRA89Im/ED/bgQtJt5Slg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794789924;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=CXHNPa2hA9naJ421ZRaoHh4iChNoH7xLEo1KiIC7n80=;
	b=FB7YaHfkDgNSldV7Tdzy4YeZev7lFx9MlBOexWicxPYQpb1s4wd5fdiBHAnqtXyJfm6R
	 LlJ5TwpW9SGKIVp4M8bER7Og/3gD/gs6p921TnsnErOFs/y63WfpOFuuosoiEsb2iTOw7
	 Aftws1FX/kIN4I6JYbrAhn4Lk1LDvtojoweFuyu/qZOkzdGudkJWLQV1V+r0+/PC2M+Ng
	 v3C4H47GfXmoQjTRRW2wdI3UongGUEbFUdtlaNBxZFsqTfgloBL6r+g792ckecX+/Pqof
	 ZZd1FTYgefmob2I4n95iI1+79S0McMLDwvmaLZCRcSGlJrQVVRpaC5WYQL40uYLj40w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.69
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66855606A88A
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 00:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66855606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-862b2e1885cso1044349a34.3
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 16:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794789923; x=1795394723;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CXHNPa2hA9naJ421ZRaoHh4iChNoH7xLEo1KiIC7n80=;
        b=bAnsB4SjqJBrpFUEltp5rohMymZIjSrL376zyxTi76A+AMETdwAhQ/M8Y+mz3s//Xq
         mJspN1onObgpY8M82NPOjCl/ayQOQysGeUquoFU2Nru0PauiOyw6OxVW8mQlJDjkt2au
         GG5WR8LOZGrMD0rxgDEHUMVkauqLhlp/nmAYtoOETeGyb/3ZpY/+aeZicrZb7QRzJ1zc
         FKUk4FrTxrVJnvmZaSY5+KOVZjGCdfLxF8vVrJ45Lu7s6pbjIeg6pOlbJYyE5eZDCkxP
         obL8RyGSnwcT7VKmscFraU81ujCOdxLYn4b093XLtWsPmeYE2XelzOJ6o+jFbckDt7Mw
         jlDw==
X-Forwarded-Encrypted: i=1; AL+hErET21G8wabLPW6+V2ROmqDSK/ITbWm/RNwgnAV1XOsoOTYeLcAZo4Ye8N1r8qjGpl+BkriVHJ0I8Lqpx3MePnYR@vger.kernel.org
X-Gm-Message-State: APuU4Z/4Z6nEVypIMqx6XpH5Mq8xvkSYzfpRxtZoANNrGjixnh/eGBoO
	yDU8Gi0pynLOWKWMBJZpOQxR9H5twrq9d9QYQCShCiXvTP2Kn7wj9ZZixxBNTJnXqyUr8wd/OGC
	CKDOBiJ1Z36fyUugXOyDtDhRyR+m5zdUGfDY/TvuIfgA2yb/JSGVfwfdUI7o=
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c210:b0:4e4:627a:e0a5 with SMTP id
 5614622812f47-56e643cccc4mr7518489b6e.40.1794789923369; Sun, 15 Nov 2026
 16:45:23 -0800 (PST)
Date: Sun, 15 Nov 2026 16:45:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6afa5223.78cd6c47.117a81.0013.GAE@google.com>
Subject: [syzbot] [perf?] KASAN: slab-use-after-free Read in put_ctx
From: syzbot <syzbot+56ad4cdaff8716472033@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, netdev@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    475a0cfd02f1 Merge branch 'bpf-sockmap-fixes-for-verdicts-..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=1501d4d9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d44b06612b68f56
dashboard link: https://syzkaller.appspot.com/bug?extid=56ad4cdaff8716472033
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/27c237a7a126/disk-475a0cfd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fe240926e3c0/vmlinux-475a0cfd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed961ae7e546/bzImage-475a0cfd.xz

AI-generated root cause summary:
In put_ctx() (kernel/events/core.c), when refcount_dec_and_test(&ctx->refcount)
returns false, the caller enters the else branch after already dropping its
reference to struct perf_event_context without holding an RCU read lock.
Concurrently, another thread (e.g., an exiting task in
perf_event_exit_task_context()) can drop the final reference, causing
call_rcu(&ctx->rcu_head, free_ctx) to be invoked. Once the RCU grace period
completes and free_ctx() frees the context via kfree(), any preempted or delayed
thread resuming in put_ctx() accesses ctx->task at line 1394 on already-freed
memory, triggering a slab-use-after-free.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=56ad4cdaff8716472033

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+56ad4cdaff8716472033@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in put_ctx+0xb4/0x1d0 kernel/events/core.c:1394
BUG: KASAN: slab-use-after-free in put_ctx+0xb4/0x1d0 kernel/events/core.c:1394
Read of size 8 at addr ffff88807abdfd28 by task syz.3.460/8324

CPU: 0 UID: 0 PID: 8324 Comm: syz.3.460 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 put_ctx+0xb4/0x1d0 kernel/events/core.c:1394
 __free_event+0x4f6/0x790 kernel/events/core.c:5817
 put_event kernel/events/core.c:5936 [inline]
 perf_event_release_kernel+0x40e/0x4c0 kernel/events/core.c:6046
 perf_release+0x38/0x50 kernel/events/core.c:6056
 __fput+0x408/0xa40 fs/file_table.c:512
 fput_close_sync+0x11f/0x240 fs/file_table.c:618
 filp_close_sync+0x6e/0xa0 fs/open.c:1573
 close_files fs/file.c:572 [inline]
 put_files_struct+0x230/0x3c0 fs/file.c:584
 do_exit+0x6f0/0x2360 kernel/exit.c:977
 __do_sys_exit kernel/exit.c:1090 [inline]
 __se_sys_exit kernel/exit.c:1088 [inline]
 __x64_sys_exit+0x40/0x40 kernel/exit.c:1088
 x64_sys_call+0x18b4/0x18d0 arch/x86/include/generated/asm/syscalls_64.h:61
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f38d41a8f19
Code: Unable to access opcode bytes at 0x7f38d41a8eef.
RSP: 002b:00007f38d4ff7fd8 EFLAGS: 00000246 ORIG_RAX: 000000000000003c
RAX: ffffffffffffffda RBX: 00007f38d4426090 RCX: 00007f38d41a8f19
RDX: 00007f38d4ff89c8 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f38d4237f6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f38d4426128 R14: 00007f38d4426090 R15: 00007ffce1039d08
 </TASK>

Allocated by task 8313:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:409 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:426
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x31c/0x600 mm/slub.c:5680
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 alloc_perf_context kernel/events/core.c:5082 [inline]
 find_get_context+0xc7/0x860 kernel/events/core.c:5152
 __do_sys_perf_event_open kernel/events/core.c:14200 [inline]
 __se_sys_perf_event_open+0xc40/0x1ee0 kernel/events/core.c:14031
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 8338:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:264 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:296
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2780 [inline]
 slab_free mm/slub.c:6630 [inline]
 kfree+0x1c5/0x650 mm/slub.c:6923
 rcu_do_batch kernel/rcu/tree.c:2650 [inline]
 rcu_core+0x92e/0x1230 kernel/rcu/tree.c:2919
 handle_softirqs+0x265/0x8d0 kernel/softirq.c:669
 __do_softirq kernel/softirq.c:703 [inline]
 invoke_softirq kernel/softirq.c:542 [inline]
 __irq_exit_rcu+0xc6/0x220 kernel/softirq.c:786
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:809
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3287 [inline]
 call_rcu+0x86/0x300 kernel/rcu/tree.c:3395
 perf_event_exit_task_context+0x68e/0x7c0 kernel/events/core.c:14819
 perf_event_exit_task+0x232/0x3a0 kernel/events/core.c:14848
 do_exit+0x69b/0x2360 kernel/exit.c:959
 do_group_exit+0x22d/0x2f0 kernel/exit.c:1123
 get_signal+0x136a/0x1430 kernel/signal.c:3113
 arch_do_signal_or_restart+0xbb/0x860 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
 exit_to_user_mode_loop+0x10e/0x770 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
 do_syscall_64+0x328/0x520 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807abdfc00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 296 bytes inside of
 freed 512-byte region [ffff88807abdfc00, ffff88807abdfe00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88807abdf800 pfn:0x7abdc
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88813ff28c80 ffffea00014a5110 ffffea000074ba10
raw: ffff88807abdf800 0000000000100008 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88813ff28c80 ffffea00014a5110 ffffea000074ba10
head: ffff88807abdf800 0000000000100008 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5277, tgid 5277 (S30dbus), ts 49489599498
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1856
 prep_new_page mm/page_alloc.c:1864 [inline]
 get_page_from_freelist+0x220f/0x2280 mm/page_alloc.c:3935
 __alloc_frozen_pages_noprof+0x1fe/0x410 mm/page_alloc.c:5444
 alloc_slab_page mm/slub.c:3384 [inline]
 allocate_slab+0x7d/0x5e0 mm/slub.c:3499
 new_slab mm/slub.c:3550 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7539
 refill_sheaf mm/slub.c:2917 [inline]
 __pcs_replace_empty_main+0x2c8/0x6c0 mm/slub.c:4811
 alloc_from_pcs mm/slub.c:4887 [inline]
 slab_alloc_node mm/slub.c:5021 [inline]
 __do_kmalloc_node mm/slub.c:5530 [inline]
 __kmalloc_noprof+0x476/0x710 mm/slub.c:5556
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 tomoyo_init_log+0x1a6b/0x1f60 security/tomoyo/audit.c:273
 tomoyo_supervisor+0x35f/0x1550 security/tomoyo/common.c:2232
 tomoyo_audit_path_number_log security/tomoyo/file.c:239 [inline]
 tomoyo_path_number_perm+0x463/0x5f0 security/tomoyo/file.c:739
 security_file_ioctl+0xc3/0x2a0 security/security.c:2533
 __do_sys_ioctl fs/ioctl.c:591 [inline]
 __se_sys_ioctl+0x47/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5003 tgid 5003 ts 41185611989 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1403 [inline]
 __free_frozen_pages+0xc97/0xd90 mm/page_alloc.c:2954
 __slab_free+0x269/0x2c0 mm/slub.c:5926
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:361
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4720 [inline]
 slab_alloc_node mm/slub.c:5033 [inline]
 kmem_cache_alloc_noprof+0x2b4/0x600 mm/slub.c:5047
 lsm_file_alloc security/security.c:172 [inline]
 security_file_alloc+0x34/0x310 security/security.c:2428
 init_file+0x90/0x2b0 fs/file_table.c:184
 alloc_empty_file+0x74/0x1d0 fs/file_table.c:266
 path_openat+0x96/0x20f0 fs/namei.c:5002
 do_file_open+0x23e/0x4a0 fs/namei.c:5045
 do_sys_openat2+0x115/0x200 fs/open.c:1442
 do_sys_open fs/open.c:1448 [inline]
 __do_sys_openat fs/open.c:1464 [inline]
 __se_sys_openat fs/open.c:1459 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1459
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807abdfc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807abdfc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807abdfd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88807abdfd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807abdfe00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
