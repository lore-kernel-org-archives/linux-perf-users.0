Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A551C84D6
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 19:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750791694; cv=none; b=AXftP0N7KxJRfw97M/MuDrezlmz0mhO72iA50IPJsLasuiVt+92CYOytO/y2NVaO7QPaD/XRS/dAs5KPGEJBn3h3vpTx30jHrH8RoD6SuP0ezXClYZic+lpHCZCRoiLvEhO3dypM9mMmo3no0dVa9RCkdGAwDQYQkCJw0FqiDyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750791694; c=relaxed/simple;
	bh=aLbjzGn3hzN5Fq6w7CtCUl1BXq0gsouE4GYG1t0lspk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y2RfI1J0OG4bXDW2iKds89OPdqvoQFGlzhgjMmeYasnAKrL8BdraDdjgRTUvJU7ATdqL1cnL7SPJ9fFYYqighN9x+muwFDtCMEGQ3UKIk6bPTtNhVaQLnTPoF+/e8LICNE+vSLsyE/lfpUqBLiVJdcE7uqEf3JkEEU9DENdpwmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-8730ca8143eso17560639f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 12:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750791690; x=1751396490;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IOvYSfw98Ac/jQWJsoM3q6nQovEyYvJrIRvActnfmmM=;
        b=C/TrhTAm/TrwEcJHxNQsAJqBU6p4I7jdE4FCmMokkQJCErlZ/CSl5eXbIfPNDZxJpW
         4K+PBqdPawDyPXO90DRthAEij/JltXWE/TwUT3T0flHx9wQ9625vNIE1UDvtPF/rXFkS
         hMDvMJZKgeHWukiN8UHpPjYii/iHfApsiD99BJ73vQih2/7zOgSH0O/RHT0uVx3w9pXw
         AzmAk6D1qTv8HkGQ54FNxohLYhnSrEWayiGa4+QTuQBWVOWLDft5enXYeVePOe73M0Pc
         F/XgqAH6VJ1gbdoB5tzDlPqDyNNoTQg5P+TI7m+FZk0B+iBw9Gt5yMoU6+DOqCtQckd+
         oRSw==
X-Forwarded-Encrypted: i=1; AJvYcCVEoHTnzqGW9v+VpHzIRtu9B7o9Ga23kfMTv/DjbBwWzL1qXtrb6V8dN5MKIiTDxuU197L1YwK/zwwmoJRcMSR+@vger.kernel.org
X-Gm-Message-State: AOJu0YztjQONqLGmc05iDuLia8uVAnEJupWyBF1ilxeiLwcrN7ooWqAD
	bC2PwS8uW83nfeihX3x/VPX176pUj6+Q3KF70gXKQMWaycpzorqIZEj3fNfb5NIl/o7gQGfq9a/
	QcFG6t/VNoBoMah51nmddeAf786nLUMnwdJStR710p27iQLAaVPbH6yAzvwE=
X-Google-Smtp-Source: AGHT+IG7+GPURfTvJJvK9gYGxwEVHE4cSiZVyXneCEvyulhlT45YXEg683sFuig0o1SoRqAzQF83kBYJ3rutPqVBjZx+yD7zze0z
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214d:b0:3dc:7b3d:6a45 with SMTP id
 e9e14a558f8ab-3df32a29005mr1897865ab.0.1750791690607; Tue, 24 Jun 2025
 12:01:30 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:01:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685af60a.a00a0220.2e5631.0092.GAE@google.com>
Subject: [syzbot] [perf?] WARNING in perf_pending_task
From: syzbot <syzbot+2fe61cb2a86066be6985@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b67ec639010f Merge tag 'i2c-for-6.16-rc3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17715b0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d11f52d3049c3790
dashboard link: https://syzkaller.appspot.com/bug?extid=2fe61cb2a86066be6985
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f15b0c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1692ab0c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b67ec639.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3bcb2b262d02/vmlinux-b67ec639.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f5d4477f1e2e/bzImage-b67ec639.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2fe61cb2a86066be6985@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5309 at kernel/events/core.c:7211 perf_sigtrap kernel/events/core.c:7211 [inline]
WARNING: CPU: 0 PID: 5309 at kernel/events/core.c:7211 perf_pending_task+0x319/0x400 kernel/events/core.c:7325
Modules linked in:
CPU: 0 UID: 0 PID: 5309 Comm: syz-executor122 Not tainted 6.16.0-rc2-syzkaller-00378-gb67ec639010f #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:perf_sigtrap kernel/events/core.c:7211 [inline]
RIP: 0010:perf_pending_task+0x319/0x400 kernel/events/core.c:7325
Code: 85 8f 00 00 00 41 fe 4d 00 eb 05 e8 21 4f cd ff 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 4e 34 76 09 cc e8 08 4f cd ff 90 <0f> 0b 90 41 80 3c 1c 00 0f 85 02 ff ff ff e9 05 ff ff ff 44 89 e1
RSP: 0018:ffffc9000d41f9d0 EFLAGS: 00010293
RAX: ffffffff81f2fe18 RBX: dffffc0000000000 RCX: ffff888032cbc880
RDX: 0000000000000000 RSI: 0000000074971a36 RDI: 0000000000000000
RBP: 0000000074971a36 R08: ffffffff8fa10af7 R09: 1ffffffff1f4215e
R10: dffffc0000000000 R11: ffffffff81f2fb00 R12: 1ffff110035f390f
R13: ffff888032cbc880 R14: ffff88801af9cad8 R15: ffff88801af9c878
FS:  0000000000000000(0000) GS:ffff88808d251000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000018 CR3: 000000000df38000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6b5/0x22e0 kernel/exit.c:964
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1105
 get_signal+0x1286/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:111
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9ae420dab9
Code: Unable to access opcode bytes at 0x7f9ae420da8f.
RSP: 002b:00007ffd20a313c8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00007f9ae420dab9
RDX: ffffffffffffffff RSI: 0000000000000000 RDI: 0000200000000000
RBP: 00007f9ae42805f0 R08: 0000000000000000 R09: 0000000000000006
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
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
