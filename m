Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971E632FA30
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Mar 2026 06:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772866404; cv=none; b=aSvOSSXQTOXN3o1gk4Srfc8+F27+6hXKJrjrDU5HnRxuJBZIGX6KKAMY8xb7het/Ur1gCOEePvpk9zkeYNTWr4yyh/+8+o70/WFo14Ym7GbOwVvs6/bJa1TJDj4G5iAyI0ouOMZSqqNFS/CjLdp8YmLZq1WkGRynayg7vVx2FJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772866404; c=relaxed/simple;
	bh=qWwsuARZXBpHnM5BsyZJl3amqOnMpNokU/N3qjr8ktg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s8T80kY2KFAxlT/1lAAKUVz5Y8YUs3XNlQBICF9o9vZTEn0CQa9CdQrPHvJKNTA7py2RLQI4KjtQhL1oZgKaKpPdT/oYocvbiuPPdVDycq/CClS9wWXHITUv8m9KsnwO2PrQ1FD8m2kOXlmragwXgV+RN093W/nwAypUyvO0+SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d4be1dee67so101881790a34.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 22:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772866401; x=1773471201;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dXPezScixS4+jFrKemIKeiQCq5FHaj7MwHRLhJUMIZw=;
        b=e7qSiGlZT+nCl6SPpaIprVqUOeRvv11srFpztBcHgCcMo1Yb4C5+ZGLQfjTPu2LR+f
         TALGrtT2zqh6CO89oRXOqwSz4uviMmzfzeDfQbIp1J8Glz5E0bzAmaplU2ZTePX38AOj
         88B1tulE95F6nAQ+o3oEUeZq8tYIi/0H192jJXI2xDbqrNzY4eVHEB8ahFQzNaYHOCEo
         c4iEQCRUrV0pLcsuUOzI0Csf3O3I8+P/9Q/cb1rQldVnJ40w7TBOnY3Na7VlQX4GUbSx
         tmih+LvhqUG3chuPl/841XHSz69UUlxltZpIOIB6kIcQOW5/9KzVuxjFuSTp/lnelz9D
         lJfg==
X-Forwarded-Encrypted: i=1; AJvYcCUeLXjjIDGaT0CbAJcxxgQ/CNuDItEAMep+zjQeexGeqHJpxqAecAIaI+5jvWDsk7Ywi0udi4kZlq6ippNbndkr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2upoIXtSD8az2Nq2p8M65zZh5qZ4sB7F0nq2DJSN9fdGIU/3g
	2ipAfjv5F4XUVfEb1owE1o44q2OuEr34rkDsWTJAzNSY5ye5ZEuBUj/pTAaBbAA72EwHhm+5+HN
	2a9RAj/cWLtTvfdpHbNv3YH1Q5stVtJ8DVqG6393upc9rdvMHET0WRBMp/FU=
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:80f:b0:67a:1d3d:a295 with SMTP id
 006d021491bc7-67b9bb70413mr2959795eaf.0.1772866401657; Fri, 06 Mar 2026
 22:53:21 -0800 (PST)
Date: Fri, 06 Mar 2026 22:53:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69abcb61.050a0220.13f275.0040.GAE@google.com>
Subject: [syzbot] [perf?] possible deadlock in refcount_dec_and_mutex_lock (2)
From: syzbot <syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5ee8dbf54602 Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101d5b5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5c49ee0942d1cdb
dashboard link: https://syzkaller.appspot.com/bug?extid=196a82fd904572696b3c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b888ba580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f758d6580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-5ee8dbf5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3cd4daffdac9/vmlinux-5ee8dbf5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a6fec327094/bzImage-5ee8dbf5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com

R10: 0000000000000013 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ff784215fac R14: 00007ff784215fa0 R15: 00007ff784215fa0
 </TASK>
============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.0.17/5460 is trying to acquire lock:
ffff88801f26c9e0 (&event->mmap_mutex){+.+.}-{4:4}, at: refcount_dec_and_mutex_lock+0x30/0xa0 lib/refcount.c:118

but task is already holding lock:
ffff88801f26c9e0 (&event->mmap_mutex){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:253 [inline]
ffff88801f26c9e0 (&event->mmap_mutex){+.+.}-{4:4}, at: perf_mmap+0x1bb/0x4b0 kernel/events/core.c:7453

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&event->mmap_mutex);
  lock(&event->mmap_mutex);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.0.17/5460:
 #0: ffff888011a94080 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:554 [inline]
 #0: ffff888011a94080 (&mm->mmap_lock){++++}-{4:4}, at: vm_mmap_pgoff+0x234/0x4f0 mm/util.c:579
 #1: ffff88801f26c9e0 (&event->mmap_mutex){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:253 [inline]
 #1: ffff88801f26c9e0 (&event->mmap_mutex){+.+.}-{4:4}, at: perf_mmap+0x1bb/0x4b0 kernel/events/core.c:7453

stack backtrace:
CPU: 0 UID: 0 PID: 5460 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x253f/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/mutex.c:614 [inline]
 __mutex_lock+0x19f/0x1300 kernel/locking/mutex.c:776
 refcount_dec_and_mutex_lock+0x30/0xa0 lib/refcount.c:118
 perf_mmap_close+0x953/0xf90 kernel/events/core.c:7064
 perf_mmap+0x418/0x4b0 kernel/events/core.c:7488
 vfs_mmap include/linux/fs.h:2070 [inline]
 mmap_file mm/internal.h:167 [inline]
 __mmap_new_file_vma mm/vma.c:2468 [inline]
 __mmap_new_vma mm/vma.c:2532 [inline]
 __mmap_region mm/vma.c:2759 [inline]
 mmap_region+0x18fe/0x2240 mm/vma.c:2837
 do_mmap+0xc39/0x10c0 mm/mmap.c:559
 vm_mmap_pgoff+0x2c9/0x4f0 mm/util.c:581
 ksys_mmap_pgoff+0x51e/0x760 mm/mmap.c:605
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff783f9c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeef4c8518 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007ff784215fa0 RCX: 00007ff783f9c799
RDX: 0000000001000008 RSI: 0000000000002000 RDI: 0000200000ffe000
RBP: 00007ffeef4c8580 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000013 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ff784215fac R14: 00007ff784215fa0 R15: 00007ff784215fa0
 </TASK>


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
