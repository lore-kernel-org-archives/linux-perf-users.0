Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B6A2FE58D
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769574365; cv=none; b=u7CmR4NpodDHZFBnZlc9mfS3pHqt6Ogj/uXBisluykQJaCbD0olLm/FFYR941YN1c3KQu0KjxrdfAegunH087H5eQZ7cID0BK/gJG8mzbbUnYoTDJc5Oruv7bmZuE/CQ6EiVJxWtRMxcOYj6xVKFdlhIOmd7Aprr1mdpFHHIaII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769574365; c=relaxed/simple;
	bh=6q2BY7BCsFeXluFzWctLz8UKtqBpiwKIbsWnV67LiYM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u+SpfydDZyaAIJ3mON73h9CLyx2aXYIgXZpjSa/c061c2IgNHfuaZoT9oA5kuzmA1c4h28A9Oiz98S0vwXvL1FtiBXqBEE0DbFnD23oRk9OSE5kYTgDXIdGjetDk2t4YbIm/VQrQNQH7CFtadsryCnEHMWZFysKlZYVPOnYwMIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d1872bbb5eso3208278a34.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 20:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769574362; x=1770179162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFiX9dgWtWSO0KafQQTiVfiDNQYdy+cwBHLlhTLTOUI=;
        b=hm8Y9Av4ZKqVYdwQ0y9OQ+PMWhXsm6Muqc1l4DJ03qRHevWPqXjMinW6JNLMQSRUDt
         mGgLCmtZHn3T8ZDmWg9466BN4rlgY2tRS3/Xl9wSN/qwN9lFENe9hnWMw4jpWwav9f1R
         XAGFvLRPPr+zchokeS+oIJ6DpU0dySo+DKlRuh8YlzXsEDm3mlQ4QQW8YXGRG64JIVIg
         o54C4Uvtrke97FFGAo57M5TThegT12XScnPlcgLtpllu7kMR5Bypvpyt32WWJ3pDCqec
         ze76PW3kyEZ+CnFHBBTY1Ot3kSFrZHhabr2GPsrtKrHfVcdMGChMCeOqQViRWXzj48ET
         bK1A==
X-Forwarded-Encrypted: i=1; AJvYcCV77HInSBZm8iASBKEHiCg30ACpPIgWSKTTv6C7Gcmuf00rj+ypx0j2BStZ+82XPT8Jfqy7CiMDBpaXri4wuO2h@vger.kernel.org
X-Gm-Message-State: AOJu0YyzpjJQ3Mq6+aeJJ6fio85/AA3Qr8DR2SrZ8U9a2HsBcPBFOfEM
	d4TVmT8DlEF5VQBTwuSMuX3Wri5LfhM/zL7RDMGBmYuf1np9xEybl0jFafxZmksyQAGR86szq1Y
	UIcfVfPP70sYgo0utEOwYpQ9PSd3ARZYkG9kQMgPlMfmpHtg22ydyiyhOqhI=
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4513:b0:662:c6ef:4e6 with SMTP id
 006d021491bc7-662f2064846mr1926785eaf.36.1769574362487; Tue, 27 Jan 2026
 20:26:02 -0800 (PST)
Date: Tue, 27 Jan 2026 20:26:02 -0800
In-Reply-To: <20260128035241.1839686-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69798fda.050a0220.c9109.0033.GAE@google.com>
Subject: Re: [syzbot] [perf?] WARNING: suspicious RCU usage in get_callchain_entry
From: syzbot <syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in bpf_prog_test_run_syscall

BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:201
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 6641, name: syz.0.17
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
1 lock held by syz.0.17/6641:
 #0: ffffffff8dbc77c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8dbc77c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8dbc77c0 (rcu_read_lock){....}-{1:3}, at: __bpf_get_stack+0x269/0xab0 kernel/bpf/stackmap.c:463
CPU: 1 UID: 0 PID: 6641 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x329/0x480 kernel/sched/core.c:8829
 __might_fault+0x76/0x130 mm/memory.c:7175
 _inline_copy_to_user include/linux/uaccess.h:201 [inline]
 _copy_to_user+0x2c/0xb0 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:236 [inline]
 bpf_prog_test_run_syscall+0x337/0x4c0 net/bpf/test_run.c:1642
 bpf_prog_test_run+0x2cd/0x340 kernel/bpf/syscall.c:4703
 __sys_bpf+0x5cb/0x920 kernel/bpf/syscall.c:6182
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6272
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efdae6faeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efdadd5e028 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007efdae975fa0 RCX: 00007efdae6faeb9
RDX: 000000000000000c RSI: 00002000000004c0 RDI: 000000000000000a
RBP: 00007efdae768c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007efdae976038 R14: 00007efdae975fa0 R15: 00007fffcdbbfb78
 </TASK>

=============================
[ BUG: Invalid wait context ]
syzkaller #0 Tainted: G        W          
-----------------------------
syz.0.17/6641 is trying to lock:
ffff88803daa5cf0 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0xaf/0x130 mm/memory.c:7177
other info that might help us debug this:
context-{5:5}
1 lock held by syz.0.17/6641:
 #0: ffffffff8dbc77c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8dbc77c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8dbc77c0 (rcu_read_lock){....}-{1:3}, at: __bpf_get_stack+0x269/0xab0 kernel/bpf/stackmap.c:463
stack backtrace:
CPU: 1 UID: 0 PID: 6641 Comm: syz.0.17 Tainted: G        W           syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4830 [inline]
 check_wait_context kernel/locking/lockdep.c:4902 [inline]
 __lock_acquire+0xec1/0x2cf0 kernel/locking/lockdep.c:5187
 lock_acquire+0x106/0x330 kernel/locking/lockdep.c:5868
 __might_fault+0xcb/0x130 mm/memory.c:7177
 _inline_copy_to_user include/linux/uaccess.h:201 [inline]
 _copy_to_user+0x2c/0xb0 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:236 [inline]
 bpf_prog_test_run_syscall+0x337/0x4c0 net/bpf/test_run.c:1642
 bpf_prog_test_run+0x2cd/0x340 kernel/bpf/syscall.c:4703
 __sys_bpf+0x5cb/0x920 kernel/bpf/syscall.c:6182
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6272
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efdae6faeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efdadd5e028 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007efdae975fa0 RCX: 00007efdae6faeb9
RDX: 000000000000000c RSI: 00002000000004c0 RDI: 000000000000000a
RBP: 00007efdae768c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007efdae976038 R14: 00007efdae975fa0 R15: 00007fffcdbbfb78
 </TASK>


Tested on:

commit:         1f97d9dc Merge tag 'vfio-v6.19-rc8' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1573a6ef980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=151a39927f1e10b4
dashboard link: https://syzkaller.appspot.com/bug?extid=72a43cdb78469f7fbad1
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14eb785a580000

