Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B50113E043
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731911544; cv=none; b=slvubKB68cxB+VnRT2Bxv4Rmk8W1tTtsr82IOFn0Kulmwza4mSqZKuwzTZGdw6Z/7eZ/ICWjdqti0NxpYK7zv2TOYwMJEhia1wNoUja5RHglPOcMmkHAzOB2+ia5lWR8rjCWrFTOuEr/tP7dUaP7HsxLJmiJiXUnn4tw2+Gz18Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731911544; c=relaxed/simple;
	bh=dJRchRmRYgthtvuvcBLt2Vhe4sZqokuTeEtXQ8LDXAU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YM7UOiXTZRURhcTm4iJKgNlVpUeZoTC8pkaEG4G0RYGmLZb2tOzBgpPeerr4Bz1tzIxN3GForZFrmuAHEtMuQIPgFYDXIYKHk4ZLMC2SICL18s/z/+owPcBYm25tHWs2RaYmM8t/X9sl4c73AHQqx2CrLSobZ4fsiI0pQeKgPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a76ee0008cso546075ab.0
        for <linux-perf-users@vger.kernel.org>; Sun, 17 Nov 2024 22:32:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731911542; x=1732516342;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vm8Ct2rJ7UDqhb71y0K+JC2zNhDJEGc1b4nOsxdZO40=;
        b=C3P3EGVV1dGicnJueRcBEgpN5re056iQ4hdPpPxzikQAbXyJL6wDj75za+ieaxiUWa
         j9kp/3HYsLuHbzyZpEBz3ZrQzCiZz5xdWnbOcXHx5sqFyLt608QTgbnuMtAw2EnG2ePK
         7n2cbwjw0OevqtWQas2qbGuzmD0U4t6FAeFqSoDu7XoLfOJp7RbXm0UPhqqKmR0v48h6
         DxNY4I/FkXd7/p1w4LlUHxGk8zREIWgnLH+X6jcF3l6VUw0zJALlTEmlBg6PR6xUC9Hx
         /3HCYxpHmFbVfXnxkycUcRN1KX4BCROdkB3AcnL+w0DwaJ5kfbwTPDbcFKrNtw75l+a7
         b/Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUzyf36Te0r1Rr85n4nGJF5nEIBiACh2Z32f4Zf/QM4WoAOqJIScge56hz8eQjRG8dRHFhWR5+/28S/NspHFZE6@vger.kernel.org
X-Gm-Message-State: AOJu0YyuuBPypB+UwhNjyT+fGBEpeMNzB5I+f9ldDnXSYzFdI2HdSQlT
	rq1pSP/V+SV6S2gVxRoQEiBgAl+bLMsgnKP1XMEAYiOZVnuLHlhWovtW2yWrW4Z0mHaPUL7zRVO
	1YjcWTU7hUlFMaYQbOewdGAccj9Kh5hdwfrLYhuf+GkkmFnMOyqipaVw=
X-Google-Smtp-Source: AGHT+IEM1IwMBD+3dis3nNq9riHetqXhtzWZh1Lwf0GLMJznD/AHYy89BODEV2skcYc69lytkmvR8gc4HcJ1IXwm0UlDsU2yxHQQ
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c7:b0:3a7:afb:7b36 with SMTP id
 e9e14a558f8ab-3a748092cc8mr91927765ab.22.1731911541794; Sun, 17 Nov 2024
 22:32:21 -0800 (PST)
Date: Sun, 17 Nov 2024 22:32:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673adf75.050a0220.87769.0024.GAE@google.com>
Subject: [syzbot] [perf?] INFO: task hung in _free_event
From: syzbot <syzbot+3c4321e10eea460eb606@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0a9b9d17f3a7 Merge tag 'pm-6.12-rc8' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b15df7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=3c4321e10eea460eb606
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a54b5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163a94c0580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-0a9b9d17.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b80dd0292210/vmlinux-0a9b9d17.xz
kernel image: https://storage.googleapis.com/syzbot-assets/42a07c5c6678/bzImage-0a9b9d17.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c4321e10eea460eb606@syzkaller.appspotmail.com

INFO: task syz-executor369:6029 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc7-syzkaller-00070-g0a9b9d17f3a7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor369 state:D stack:24376 pid:6029  tgid:6029  ppid:5328   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x184f/0x4c30 kernel/sched/core.c:6693
 __schedule_loop kernel/sched/core.c:6770 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6785
 perf_pending_task_sync kernel/events/core.c:5319 [inline]
 _free_event+0x178/0xf60 kernel/events/core.c:5326
 put_event kernel/events/core.c:5454 [inline]
 perf_event_release_kernel+0x7c1/0x850 kernel/events/core.c:5579
 perf_release+0x38/0x40 kernel/events/core.c:5589
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 get_signal+0x16a3/0x1740 kernel/signal.c:2918
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7fa88a3cf9
RSP: 002b:00007ffc8b3be618 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: 00000000000017af RBX: 0000000000000000 RCX: 00007f7fa88a3cf9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000c000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/25:
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
2 locks held by getty/5110:
 #0: ffff8880007e10a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000039b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 25 Comm: khungtaskd Not tainted 6.12.0-rc7-syzkaller-00070-g0a9b9d17f3a7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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
