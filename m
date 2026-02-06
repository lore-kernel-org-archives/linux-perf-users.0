Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE23168E1
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770363393; cv=none; b=qh/6JJBSB5/Ysj5Cj34yR7xAc695Pvp75pagqPsMyq81hdafrjcLs0egAMvPKlylszKVQ8jtjqPQcfRlANQXTTI2KTFyf18nNZt/6mIDw9riaNaVVUhJXRrbRlsfnMav8aM/983K+i/6+kx4WU7zTBSJkFRgiNcTqLNP0yD6qTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770363393; c=relaxed/simple;
	bh=9FRWCuPiMkkrQ972rVMHLpsSw40yJDZ9OtQpWKj04rY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ynq8AC/btcvr+4TEQbnZWgj54eTiS8+GyStNG8n1CpkXXJwlyXVUkgueM8xyVaoMEBbnrPKh+Y9/OeHs/GKbtQIZnJqKHiycn5E1mICOuczDAcaD7PgfHDjw6HexnGc0TGlA+ndq7ch772Q+orLl6bS7q0dcb3qkInsyjYoKSDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-66b560fcc42so7611262eaf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 23:36:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770363392; x=1770968192;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rHyQDbOdo3dmXSaHfpXFy2nfDGyjWyiBXjkHRyFU+9w=;
        b=MkAWx6ssje+hczxqEgwBCN2d/NbQUphnVd4ct7QTHYBt0uIbllkRU8RjHPDjeCoxX1
         jWNAV+1lEtpSpddCpuhStwCVZzQ+W4gUTMgQ3G5eh44aGZwXnw7fzk+7mhFcyYDU27hS
         qrkXYVc9j11m6zXHjQXXB8V0AwJumgiGBUSVk8FIw3rs6dDZLVFYoe6edJvQY8sedACi
         du7Rs4v3ilP4rcOj7kuflkFczQXhtFLLSLzerc+Wyl6AyS2ua/nTcqIIqYIy/mvY5Lc2
         /VaRxBUppAz8OWPZaT0Hjnuvjk3uF85P+7es49cRSMj6LPa0EcRM++nBQwTYtdqduqao
         qBcA==
X-Forwarded-Encrypted: i=1; AJvYcCVTt0fTM6g7Lxwb7Pavwr2sAi8wxTDVaScHuA8uDZFY47PrPdlPRO7zlP9YBtI0Y94ue5aP1IQ4BI3bvYD1+0KI@vger.kernel.org
X-Gm-Message-State: AOJu0YziZhPEuzBVNSNrCtTamhZeMGFNMfrm870G4s/dz7i/CFIW9e9G
	RtDalN9jtyws7Rsg7jXrJ/4oxZGCCIxNT+6m+4AbGekb/g4gIMlOpLWNTzbNjXSMg1l4J9q05tF
	xclD+FY0VB+poEurqdvMeYLaKF+1uVWUvVjG95XM9NFcgzYui/lvimlQHfcY=
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4610:b0:663:1f2:3e1f with SMTP id
 006d021491bc7-66d32fdc188mr597246eaf.32.1770363392486; Thu, 05 Feb 2026
 23:36:32 -0800 (PST)
Date: Thu, 05 Feb 2026 23:36:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69859a00.a00a0220.34fa92.0028.GAE@google.com>
Subject: [syzbot] [perf?] KCSAN: data-race in perf_event_set_state / perf_mmap_rb
From: syzbot <syzbot+5334e6bdc43f6d1dcb7d@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c537e12daeec Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1133a5fc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c160236e1ef1e401
dashboard link: https://syzkaller.appspot.com/bug?extid=5334e6bdc43f6d1dcb7d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/036ac5d12a14/disk-c537e12d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/07ddd15f46f8/vmlinux-c537e12d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7866e67b7a58/bzImage-c537e12d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5334e6bdc43f6d1dcb7d@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in perf_event_set_state / perf_mmap_rb

write to 0xffff88812279f1a0 of 8 bytes by task 12011 on cpu 1:
 perf_event_update_time kernel/events/core.c:737 [inline]
 perf_mmap_rb+0x71c/0x910 kernel/events/core.c:7037
 perf_mmap+0x1ce/0x2f0 kernel/events/core.c:7164
 vfs_mmap include/linux/fs.h:2053 [inline]
 mmap_file mm/internal.h:167 [inline]
 __mmap_new_file_vma mm/vma.c:2421 [inline]
 __mmap_new_vma mm/vma.c:2484 [inline]
 __mmap_region mm/vma.c:2708 [inline]
 mmap_region+0x1045/0x1410 mm/vma.c:2786
 do_mmap+0x9b3/0xbe0 mm/mmap.c:558
 vm_mmap_pgoff+0x17a/0x2e0 mm/util.c:581
 ksys_mmap_pgoff+0x268/0x310 mm/mmap.c:604
 x64_sys_call+0x16bb/0x3000 arch/x86/include/generated/asm/syscalls_64.h:10
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xca/0x2b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88812279f1a0 of 8 bytes by task 12005 on cpu 0:
 __perf_update_times kernel/events/core.c:720 [inline]
 perf_event_update_time kernel/events/core.c:735 [inline]
 perf_event_set_state+0x153/0x440 kernel/events/core.c:754
 event_sched_out+0x2d4/0x4d0 kernel/events/core.c:2391
 group_sched_out kernel/events/core.c:2415 [inline]
 __pmu_ctx_sched_out+0x3e7/0x530 kernel/events/core.c:3458
 ctx_sched_out+0x273/0x2d0 kernel/events/core.c:3539
 task_ctx_sched_out+0x4d/0x70 kernel/events/core.c:2859
 perf_event_context_sched_out kernel/events/core.c:3746 [inline]
 __perf_event_task_sched_out+0x286/0x370 kernel/events/core.c:3846
 perf_event_task_sched_out include/linux/perf_event.h:1654 [inline]
 prepare_task_switch kernel/sched/core.c:5045 [inline]
 context_switch kernel/sched/core.c:5201 [inline]
 __schedule+0xbf0/0xcd0 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x5f/0xd0 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x4ff/0xe20 kernel/locking/mutex.c:776
 __mutex_lock_slowpath+0xa/0x10 kernel/locking/mutex.c:1065
 mutex_lock+0x89/0x90 kernel/locking/mutex.c:290
 perf_poll+0x180/0x1f0 kernel/events/core.c:6150
 vfs_poll include/linux/poll.h:82 [inline]
 select_poll_one fs/select.c:480 [inline]
 do_select+0x8f1/0xf40 fs/select.c:536
 core_sys_select+0x3dc/0x6e0 fs/select.c:677
 do_pselect fs/select.c:759 [inline]
 __do_sys_pselect6 fs/select.c:798 [inline]
 __se_sys_pselect6+0x213/0x280 fs/select.c:789
 __x64_sys_pselect6+0x78/0x90 fs/select.c:789
 x64_sys_call+0x2e98/0x3000 arch/x86/include/generated/asm/syscalls_64.h:271
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xca/0x2b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x000000000038c145 -> 0x00000000003929d3

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 12005 Comm: syz.4.2772 Tainted: G        W           syzkaller #0 PREEMPT(voluntary) 
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
