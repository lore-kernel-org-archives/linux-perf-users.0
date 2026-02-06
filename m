Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D0F314B6E
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770363275; cv=none; b=ZOlGnI0oxTWQ//rvF/QZbuQcnnKjzU/L4Z3O8pMZdmR1M58FbnIplKewPMGux+TstVUR7XLhilhnewbn8gmJGtRFSC24GcvWNlOzi47s86xrHeWPUBh665+Uajv06iqUXoWGEd4n/nI1TWiaCwiSWMhUMGLAM8/vw+1AWgCzg98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770363275; c=relaxed/simple;
	bh=Kp4498QLNmfK2CENtyJGX4EnK7PU2z/HA2kg+ZfYHTY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MnFE2e0uS5Eg828zWiV0LA3zMO17QW20qMGXbbFTKBfIYvb4b2kBDUVqEFaS0kZYKL1dBefF3YKMkGVgqW0OIQj2+Xhpwvt8RnIkYWntHPLhoZojq/h7sjJDajFOxyoZw0iKL7MAI7fdTrJyCMls2x3zDlf/UPL+Nrxl6afMT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-663006e4c3cso6445409eaf.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 23:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770363274; x=1770968074;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3kTvYB9PubGKsbSG4SV7nCcfBTsVFg92MFXjJGgdxA=;
        b=J3Mv2NbS41GsgBpb1vd1L66aFUOEV97l62IgWCR8LF7pp7P53E2We+zWUNiWXgPln4
         zBQnVlQ4ZGFZMaPm5n9+EwVhGyjTVhyRtpCYE2ONDKZp7No7BCablh45ctyJekvEWcLw
         wPIClVANcapV44Cc87R90cnPLruXgCtNs8Fo4ZhZ9c2eibgUFTNJ7FlAzyISyujVsRgy
         DFntBOj5nW/v+s9fm6utQAWlLNZcF+gJI304O6Ep48Kh7d0rUPUsi93UsCjhwv9Pj4M4
         j2Gq3DMxWYmccO0r1LSqON1RFj/9HZ3Dt7JMXnsmFtrbqQJqmc1Xyoc1sRH+1qXvd8UO
         jWsw==
X-Forwarded-Encrypted: i=1; AJvYcCXC+F3XuigCkrlg9y3oNMaIbY0iQbIO0+xAEt+zOOzBrfZ2pKjcI1UFdc9mItayYRJR02E6/pBU+rN5EGqQNAje@vger.kernel.org
X-Gm-Message-State: AOJu0YzOA+traRu5RnRiXih02NE0WhXeDZdaLob10m8gAVAgFDs1JZZ9
	WeONbOC1UOeZSYqJEFm0+xRGytGMtjw9S1Wa974NbOijwSJL3+E3cbs5DynifPByMF9xGgbowoz
	LxewhZtF+9dB/3y9qIFDWayRWMTjwbkJwjn9f2BqHvwibIlNiIplrwRuzGEE=
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4dc8:b0:659:9a49:904d with SMTP id
 006d021491bc7-66d0a37b727mr970006eaf.24.1770363273798; Thu, 05 Feb 2026
 23:34:33 -0800 (PST)
Date: Thu, 05 Feb 2026 23:34:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69859989.a00a0220.34fa92.0026.GAE@google.com>
Subject: [syzbot] [perf?] KCSAN: data-race in __perf_event_read_value /
 perf_event_set_state (6)
From: syzbot <syzbot+6d5529efa784dcc0b926@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5dbeeb268b63 Merge tag 'driver-core-6.19-rc7' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169a105a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c9e86480ac654d3
dashboard link: https://syzkaller.appspot.com/bug?extid=6d5529efa784dcc0b926
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8a4a5a3502b5/disk-5dbeeb26.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/65e86e2ad6af/vmlinux-5dbeeb26.xz
kernel image: https://storage.googleapis.com/syzbot-assets/050ae083081a/bzImage-5dbeeb26.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d5529efa784dcc0b926@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __perf_event_read_value / perf_event_set_state

write to 0xffff8881311a8538 of 8 bytes by task 13031 on cpu 1:
 __perf_update_times kernel/events/core.c:-1 [inline]
 perf_event_update_time kernel/events/core.c:735 [inline]
 perf_event_set_state+0x1c4/0x440 kernel/events/core.c:754
 event_sched_out+0x2d4/0x4d0 kernel/events/core.c:2391
 group_sched_out kernel/events/core.c:2415 [inline]
 __pmu_ctx_sched_out+0x3e7/0x530 kernel/events/core.c:3458
 ctx_sched_out+0x273/0x2d0 kernel/events/core.c:3539
 task_ctx_sched_out+0x4d/0x70 kernel/events/core.c:2859
 perf_event_context_sched_out kernel/events/core.c:3746 [inline]
 __perf_event_task_sched_out+0x2df/0x3c0 kernel/events/core.c:3846
 perf_event_task_sched_out include/linux/perf_event.h:1654 [inline]
 prepare_task_switch kernel/sched/core.c:5049 [inline]
 context_switch kernel/sched/core.c:5205 [inline]
 __schedule+0xbaa/0xc90 kernel/sched/core.c:6867
 __schedule_loop kernel/sched/core.c:6949 [inline]
 schedule+0x5e/0xd0 kernel/sched/core.c:6964
 futex_do_wait kernel/futex/waitwake.c:358 [inline]
 __futex_wait+0x121/0x260 kernel/futex/waitwake.c:687
 futex_wait+0x9c/0x1d0 kernel/futex/waitwake.c:715
 do_futex+0x2bf/0x380 kernel/futex/syscalls.c:130
 __do_sys_futex kernel/futex/syscalls.c:207 [inline]
 __se_sys_futex+0x2f6/0x370 kernel/futex/syscalls.c:188
 __x64_sys_futex+0x78/0x90 kernel/futex/syscalls.c:188
 x64_sys_call+0x2bc2/0x3000 arch/x86/include/generated/asm/syscalls_64.h:203
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff8881311a8538 of 8 bytes by task 13182 on cpu 0:
 __perf_event_read_value+0xb6/0x1d0 kernel/events/core.c:5894
 perf_read_one kernel/events/core.c:6049 [inline]
 __perf_read kernel/events/core.c:6102 [inline]
 perf_read+0x171/0x4f0 kernel/events/core.c:6119
 loop_rw_iter+0x2c6/0x3f0 include/linux/uio.h:-1
 io_iter_do_read io_uring/rw.c:836 [inline]
 __io_read+0xbf6/0xc50 io_uring/rw.c:950
 io_read+0x4a/0x190 io_uring/rw.c:1030
 __io_issue_sqe+0xfd/0x2d0 io_uring/io_uring.c:1793
 io_issue_sqe+0x56/0xa70 io_uring/io_uring.c:1816
 io_wq_submit_work+0x3f7/0x5f0 io_uring/io_uring.c:1928
 io_worker_handle_work+0x41e/0x950 io_uring/io-wq.c:650
 io_wq_worker+0x22d/0x860 io_uring/io-wq.c:704
 ret_from_fork+0x148/0x280 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

value changed: 0x000000004a891b66 -> 0x000000004a89847d

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 13182 Comm: iou-wrk-13031 Not tainted syzkaller #0 PREEMPT(voluntary) 
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
