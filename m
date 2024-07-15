Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C234EB37
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721069542; cv=none; b=P5T7GjJjJ4RwUg2/3qDS/izQ/9cHOQxUaWRyZoicBj3pQL0qEbmdp71UDq14oO8xgh2WWDWjW+RieBLOHQwNBS637+KeUKILszhJPmIThK1up/E0paKFQk3C786g5PnXT/XEw0M7flfoIkAC7Me25/6tz9gXiDXlKjOruKHO6zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721069542; c=relaxed/simple;
	bh=KKAz7xvGJiJSriLkw5TQ+aGgZfPuzbIY0bgSuWXB7gg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bQxLeq+X1Qq/ApoX12afGkdH3u6b7aLyO1boHB2LqKxw2/bjxvzWdCq7yXJUv1yGu2RV+bcdHxCx2ib1mV/2FjGclgD55EqH8PCKztakwEr9qlAQIQgZHRLusTSZ6MMX1D80a+V/uCIXRaVJbwBg3di1UN+LcxwcwdZt3AF7cRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-381f1b3050bso49843855ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 11:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721069539; x=1721674339;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iWZmJfT2WTy+hyUXWk37v4aQr+mW/uWqlTbexPaz0EU=;
        b=C9OKs0Tgl4zzK+VIN9/5JqUW4BHsWsogr6cQQU+Cmneo66idqcgVVv4S16fwtdMi3B
         dEGKN9G1KLogf87rh9+LQUzFHoTPzdHxqRiWlUMQ0Vjh6GswGFRRqFvcZGrWEzCFVpBD
         1sMZjp0NkWlBhtd/QR9GCTNVtucQgXZYmqZdwqZh1FQHYBYmMYtYJz1VX1VtfzfMvcpv
         0vDkuJNNWjdQZ+ilYa5PXrZIEY3g1MRTd6fhEOsWFsjloiNcihEMzJI/Cuis4u8yjFHo
         EAlAZpgjtcu0veCycrsZBSIg7ysE2omXMNUfLHr0hqrYOSpQdIvHEk/BKIB0w1GhpmiR
         JUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcCBOMe1Tf+ueDoXPQO9R/N7IiXyOqFjHAOsO9i+F3Aj4ctuigWDEvwtm5+g5MCM2OyEZhl8wLaF2wmmStiomRLwv2/dOv1/wUpr5w/MZC9Q==
X-Gm-Message-State: AOJu0YwdnGAHKm0+6Dubjo689ZlINeboxVayGAyas7mQolsyuzSTFarA
	7RGQD/r5HWnb2uEHmZ6AhELbMFj7dQNFJuZ5XBZ1dWq6YjNrDgfPjdwGod8MOgpbZRAm6lerS/H
	qVQKuflEYpk60XAUr6x1UGXKD/cl44BvdfLY5rp05T9pFoVhmEW6z8sQ=
X-Google-Smtp-Source: AGHT+IFSLjXB99d684rNqu5EKxOXmDgBztQJCMBOI9Edg8TghskBm+qojiPldcJX6BQ/yva+uYHj+ASITIp7gmd/oiCP4HlsGgyx
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ef:b0:375:9f67:6e7d with SMTP id
 e9e14a558f8ab-393d3373449mr18065ab.4.1721069539520; Mon, 15 Jul 2024 11:52:19
 -0700 (PDT)
Date: Mon, 15 Jul 2024 11:52:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000898167061d4dbac9@google.com>
Subject: [syzbot] [perf?] KASAN: slab-use-after-free Read in filter_chain
From: syzbot <syzbot+772df6edd4e13e9e9bc5@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    528dd46d0fc3 Merge tag 'net-6.10-rc8-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1168bc2d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3456bae478301dc8
dashboard link: https://syzkaller.appspot.com/bug?extid=772df6edd4e13e9e9bc5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-528dd46d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e282f55fdf5f/vmlinux-528dd46d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/824cfb5d5809/bzImage-528dd46d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+772df6edd4e13e9e9bc5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in consumer_filter kernel/events/uprobes.c:869 [inline]
BUG: KASAN: slab-use-after-free in filter_chain+0xf6/0x110 kernel/events/uprobes.c:880
Read of size 8 at addr ffff88801a2b85b0 by task syz.1.1633/10836

CPU: 0 PID: 10836 Comm: syz.1.1633 Not tainted 6.10.0-rc7-syzkaller-00254-g528dd46d0fc3 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 consumer_filter kernel/events/uprobes.c:869 [inline]
 filter_chain+0xf6/0x110 kernel/events/uprobes.c:880
 uprobe_mmap+0x46b/0x1240 kernel/events/uprobes.c:1387
 mmap_region+0x1228/0x2760 mm/mmap.c:2987
 do_mmap+0xbc7/0xf60 mm/mmap.c:1397
 vm_mmap_pgoff+0x1ba/0x360 mm/util.c:573
 ksys_mmap_pgoff+0x332/0x5d0 mm/mmap.c:1443
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:79 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:79
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb371d75bd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb3717ff048 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fb371f03f60 RCX: 00007fb371d75bd9
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020000000
RBP: 00007fb371de4e60 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000012 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fb371f03f60 R15: 00007ffc20b151a8
 </TASK>

Allocated by task 5195:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc_node_noprof include/linux/slab.h:677 [inline]
 __get_vm_area_node+0xe1/0x2d0 mm/vmalloc.c:3108
 __vmalloc_node_range_noprof+0x276/0x1520 mm/vmalloc.c:3800
 __vmalloc_node_noprof mm/vmalloc.c:3905 [inline]
 vzalloc_noprof+0x6b/0x90 mm/vmalloc.c:3978
 alloc_counters net/ipv6/netfilter/ip6_tables.c:815 [inline]
 copy_entries_to_user net/ipv6/netfilter/ip6_tables.c:837 [inline]
 get_entries net/ipv6/netfilter/ip6_tables.c:1039 [inline]
 do_ip6t_get_ctl+0x6ba/0xaf0 net/ipv6/netfilter/ip6_tables.c:1677
 nf_getsockopt+0x79/0xe0 net/netfilter/nf_sockopt.c:116
 ipv6_getsockopt+0x1fd/0x2c0 net/ipv6/ipv6_sockglue.c:1494
 tcp_getsockopt+0x9e/0x100 net/ipv4/tcp.c:4406
 do_sock_getsockopt+0x2e5/0x760 net/socket.c:2374
 __sys_getsockopt+0x1a1/0x270 net/socket.c:2403
 __do_sys_getsockopt net/socket.c:2413 [inline]
 __se_sys_getsockopt net/socket.c:2410 [inline]
 __x64_sys_getsockopt+0xbd/0x160 net/socket.c:2410
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5195:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4438 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4559
 vfree+0x25a/0x7a0 mm/vmalloc.c:3368
 copy_entries_to_user net/ipv6/netfilter/ip6_tables.c:882 [inline]
 get_entries net/ipv6/netfilter/ip6_tables.c:1039 [inline]
 do_ip6t_get_ctl+0x8ec/0xaf0 net/ipv6/netfilter/ip6_tables.c:1677
 nf_getsockopt+0x79/0xe0 net/netfilter/nf_sockopt.c:116
 ipv6_getsockopt+0x1fd/0x2c0 net/ipv6/ipv6_sockglue.c:1494
 tcp_getsockopt+0x9e/0x100 net/ipv4/tcp.c:4406
 do_sock_getsockopt+0x2e5/0x760 net/socket.c:2374
 __sys_getsockopt+0x1a1/0x270 net/socket.c:2403
 __do_sys_getsockopt net/socket.c:2413 [inline]
 __se_sys_getsockopt net/socket.c:2410 [inline]
 __x64_sys_getsockopt+0xbd/0x160 net/socket.c:2410
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801a2b8580
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 48 bytes inside of
 freed 64-byte region [ffff88801a2b8580, ffff88801a2b85c0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88801a2b8100 pfn:0x1a2b8
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000200 ffff8880154428c0 ffffea000082fd90 ffffea0000b53010
raw: ffff88801a2b8100 000000000020001e 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 5044052246, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1473
 prep_new_page mm/page_alloc.c:1481 [inline]
 get_page_from_freelist+0x1353/0x2e50 mm/page_alloc.c:3425
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4683
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x56/0x110 mm/slub.c:2265
 allocate_slab mm/slub.c:2428 [inline]
 new_slab+0x84/0x260 mm/slub.c:2481
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3667
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3990 [inline]
 kmalloc_trace_noprof+0x2b4/0x300 mm/slub.c:4149
 kmalloc_noprof include/linux/slab.h:660 [inline]
 get_sparsemem_vmemmap_info fs/proc/kcore.c:164 [inline]
 kclist_add_private+0x7bb/0xd40 fs/proc/kcore.c:222
 walk_system_ram_range+0x132/0x1e0 kernel/resource.c:524
 kcore_ram_list fs/proc/kcore.c:248 [inline]
 kcore_update_ram.isra.0+0x310/0x980 fs/proc/kcore.c:268
 proc_kcore_init+0x212/0x270 fs/proc/kcore.c:703
 do_one_initcall+0x128/0x700 init/main.c:1267
 do_initcall_level init/main.c:1329 [inline]
 do_initcalls init/main.c:1345 [inline]
 do_basic_setup init/main.c:1364 [inline]
 kernel_init_freeable+0x69d/0xca0 init/main.c:1578
 kernel_init+0x1c/0x2b0 init/main.c:1467
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801a2b8480: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff88801a2b8500: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff88801a2b8580: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                     ^
 ffff88801a2b8600: 00 00 00 00 00 00 07 fc fc fc fc fc fc fc fc fc
 ffff88801a2b8680: 00 00 00 00 00 00 07 fc fc fc fc fc fc fc fc fc
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
