Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C96D155A32
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Aug 2024 05:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724217078; cv=none; b=KOFSh2NzpPBOOw7vbWFNXwNgnuWeJLJTsEATS6RDbBQgKBCQPOf0+8QswwGTJtdFK/ko8P5BFhryvo9XWHEd1AGn7B22XHdrysS0ivFWKzR6tAdVoMsoVR6LoZZSX4Z84bSyYyZOZATf384M//MqEDQBQ7tu6AUvXOG05OjthJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724217078; c=relaxed/simple;
	bh=gFlBS35qcj+rFEXGs+xgpYxirv+Rwj2xxb5pK/QsPhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORBVjtKG+7yzTdU9+Hgm4LE7i+Xl0cHM7t+XlpVKteI9c4FIY+oNbgyUayqKYU+YoNqMtON4bXNHlu1X3pFIjMl6R/DsYL+nMRzUv1gTySUchz2K/gIjVIW5PHJ7IdfVXdYMdcXt27gu51VE+pOiC4IiBGef5ZSw2MxFPD49Z84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SpQQKnWO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpQQKnWO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724217075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BGCt3DrVugrCfa33u/KErLv8ZSFt2Jwl4ocgFJ7U6Q8=;
	b=SpQQKnWOGHDi5qZeNQozcgUxQ04t98MOLvY5kXZ9AWdyNU+w61MsmQCEUPnq4eYAtX6EUs
	Hg+hwNqHVkLhA40Oejg+SMGOVwy0/S2ngRi+c8IM4bX32YXycLwB0AdNCyTuihEyMOuKB3
	0y61liTkDJatcuRmjAOHerS/+SzuT7E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-01nKYROuPguVNlKhe8ENlQ-1; Wed,
 21 Aug 2024 01:11:11 -0400
X-MC-Unique: 01nKYROuPguVNlKhe8ENlQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E00F31955D48;
	Wed, 21 Aug 2024 05:11:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.52])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BC00B19560AA;
	Wed, 21 Aug 2024 05:11:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 21 Aug 2024 07:11:03 +0200 (CEST)
Date: Wed, 21 Aug 2024 07:10:55 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: syzbot <syzbot+b32fa80fe75273685f9c@syzkaller.appspotmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	jolsa@kernel.org, kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
	mhiramat@kernel.org, mingo@redhat.com, namhyung@kernel.org,
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] KASAN: slab-use-after-free Read in
 uprobe_unregister
Message-ID: <20240821051054.GA15751@redhat.com>
References: <000000000000e99e800620277ffa@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e99e800620277ffa@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

#syz dup: [syzbot] [perf?] KASAN: slab-use-after-free Read in __uprobe_unregister syzbot

https://lore.kernel.org/all/000000000000382d39061f59f2dd@google.com/

Hopefully fixed by
[PATCH tip/perf/core] bpf: fix use-after-free in bpf_uprobe_multi_link_attach()
https://lore.kernel.org/all/20240813152524.GA7292@redhat.com/

On 08/20, syzbot wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    367b5c3d53e5 Add linux-next specific files for 20240816
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=109d46a3980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
> dashboard link: https://syzkaller.appspot.com/bug?extid=b32fa80fe75273685f9c
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1099b7d3980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c513e5980000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0b1b4e3cad3c/disk-367b5c3d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5bb090f7813c/vmlinux-367b5c3d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6674cb0709b1/bzImage-367b5c3d.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b32fa80fe75273685f9c@syzkaller.appspotmail.com
>
> R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> ==================================================================
> BUG: KASAN: slab-use-after-free in consumer_del kernel/events/uprobes.c:772 [inline]
> BUG: KASAN: slab-use-after-free in uprobe_unregister+0x99/0x220 kernel/events/uprobes.c:1097
> Read of size 8 at addr ffff888022b9eb40 by task syz-executor227/5226
>
> CPU: 0 UID: 0 PID: 5226 Comm: syz-executor227 Not tainted 6.11.0-rc3-next-20240816-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  consumer_del kernel/events/uprobes.c:772 [inline]
>  uprobe_unregister+0x99/0x220 kernel/events/uprobes.c:1097
>  bpf_uprobe_unregister kernel/trace/bpf_trace.c:3119 [inline]
>  bpf_uprobe_multi_link_release+0x8c/0x1b0 kernel/trace/bpf_trace.c:3127
>  bpf_link_free+0xf5/0x250 kernel/bpf/syscall.c:2998
>  bpf_link_put_direct kernel/bpf/syscall.c:3038 [inline]
>  bpf_link_release+0x7b/0x90 kernel/bpf/syscall.c:3045
>  __fput+0x24b/0x890 fs/file_table.c:424
>  task_work_run+0x24f/0x310 kernel/task_work.c:228
>  exit_task_work include/linux/task_work.h:40 [inline]
>  do_exit+0xa2f/0x28e0 kernel/exit.c:939
>  do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>  __do_sys_exit_group kernel/exit.c:1099 [inline]
>  __se_sys_exit_group kernel/exit.c:1097 [inline]
>  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
>  x64_sys_call+0x26a8/0x26b0 arch/x86/include/generated/asm/syscalls_64.h:232
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f409a857c79
> Code: Unable to access opcode bytes at 0x7f409a857c4f.
> RSP: 002b:00007fff689d0b48 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f409a857c79
> RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
> RBP: 00007f409a8cb370 R08: ffffffffffffffb8 R09: 00000000000000a0
> R10: 0000000000000001 R11: 0000000000000246 R12: 00007f409a8cb370
> R13: 0000000000000000 R14: 00007f409a8cbdc0 R15: 00007f409a821340
>  </TASK>
>
> Allocated by task 5226:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
>  kasan_kmalloc include/linux/kasan.h:260 [inline]
>  __do_kmalloc_node mm/slub.c:4202 [inline]
>  __kmalloc_node_noprof+0x22a/0x440 mm/slub.c:4208
>  __kvmalloc_node_noprof+0x72/0x1b0 mm/util.c:658
>  kvmalloc_array_node_noprof include/linux/slab.h:835 [inline]
>  bpf_uprobe_multi_link_attach+0x43e/0xb90 kernel/trace/bpf_trace.c:3369
>  link_create+0x6e9/0x870 kernel/bpf/syscall.c:5236
>  __sys_bpf+0x4bc/0x810 kernel/bpf/syscall.c:5697
>  __do_sys_bpf kernel/bpf/syscall.c:5734 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5732 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5732
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 5226:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2295 [inline]
>  slab_free mm/slub.c:4517 [inline]
>  kfree+0x196/0x3e0 mm/slub.c:4665
>  bpf_uprobe_multi_link_attach+0xa7d/0xb90 kernel/trace/bpf_trace.c:3431
>  link_create+0x6e9/0x870 kernel/bpf/syscall.c:5236
>  __sys_bpf+0x4bc/0x810 kernel/bpf/syscall.c:5697
>  __do_sys_bpf kernel/bpf/syscall.c:5734 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5732 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5732
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The buggy address belongs to the object at ffff888022b9eb00
>  which belongs to the cache kmalloc-96 of size 96
> The buggy address is located 64 bytes inside of
>  freed 96-byte region [ffff888022b9eb00, ffff888022b9eb60)
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888022b9e400 pfn:0x22b9e
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> page_type: 0xfdffffff(slab)
> raw: 00fff00000000000 ffff888015841280 ffffea000061ec40 dead000000000004
> raw: ffff888022b9e400 000000008020001f 00000001fdffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4681, tgid 4681 (udevd), ts 17930004975, free_ts 17928166567
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1518
>  prep_new_page mm/page_alloc.c:1526 [inline]
>  get_page_from_freelist+0x3004/0x30c0 mm/page_alloc.c:3477
>  __alloc_pages_noprof+0x29e/0x780 mm/page_alloc.c:4744
>  __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>  alloc_slab_page+0x5f/0x120 mm/slub.c:2364
>  allocate_slab+0x5a/0x2f0 mm/slub.c:2527
>  new_slab mm/slub.c:2580 [inline]
>  ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3767
>  __slab_alloc+0x58/0xa0 mm/slub.c:3857
>  __slab_alloc_node mm/slub.c:3910 [inline]
>  slab_alloc_node mm/slub.c:4069 [inline]
>  __do_kmalloc_node mm/slub.c:4201 [inline]
>  __kmalloc_noprof+0x25a/0x400 mm/slub.c:4214
>  kmalloc_noprof include/linux/slab.h:685 [inline]
>  kzalloc_noprof include/linux/slab.h:807 [inline]
>  tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
>  tomoyo_encode+0x26f/0x540 security/tomoyo/realpath.c:80
>  tomoyo_realpath_from_path+0x59e/0x5e0 security/tomoyo/realpath.c:283
>  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>  tomoyo_check_open_permission+0x255/0x500 security/tomoyo/file.c:771
>  security_file_open+0x6a/0x750 security/security.c:2996
>  do_dentry_open+0x359/0x13f0 fs/open.c:946
>  vfs_open+0x3e/0x330 fs/open.c:1089
>  do_open fs/namei.c:3774 [inline]
>  path_openat+0x2c87/0x3590 fs/namei.c:3933
>  do_filp_open+0x235/0x490 fs/namei.c:3960
> page last free pid 4688 tgid 4688 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1099 [inline]
>  free_unref_page+0xc07/0xd90 mm/page_alloc.c:2652
>  __slab_free+0x31b/0x3d0 mm/slub.c:4428
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>  kasan_slab_alloc include/linux/kasan.h:250 [inline]
>  slab_post_alloc_hook mm/slub.c:4032 [inline]
>  slab_alloc_node mm/slub.c:4081 [inline]
>  __kmalloc_cache_noprof+0x132/0x2c0 mm/slub.c:4228
>  kmalloc_noprof include/linux/slab.h:681 [inline]
>  kzalloc_noprof include/linux/slab.h:807 [inline]
>  kernfs_fop_open+0x3e0/0xd10 fs/kernfs/file.c:623
>  do_dentry_open+0x928/0x13f0 fs/open.c:959
>  vfs_open+0x3e/0x330 fs/open.c:1089
>  do_open fs/namei.c:3774 [inline]
>  path_openat+0x2c87/0x3590 fs/namei.c:3933
>  do_filp_open+0x235/0x490 fs/namei.c:3960
>  do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
>  do_sys_open fs/open.c:1431 [inline]
>  __do_sys_openat fs/open.c:1447 [inline]
>  __se_sys_openat fs/open.c:1442 [inline]
>  __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Memory state around the buggy address:
>  ffff888022b9ea00: 00 00 00 00 00 00 00 00 00 00 00 06 fc fc fc fc
>  ffff888022b9ea80: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
> >ffff888022b9eb00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>                                            ^
>  ffff888022b9eb80: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
>  ffff888022b9ec00: 00 00 00 00 00 00 00 00 00 00 00 06 fc fc fc fc
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

