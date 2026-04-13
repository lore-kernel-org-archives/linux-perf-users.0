Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2173C9425
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776084699; cv=none; b=mQodHklzNGvKYmfT2oxlF0queJ2bdQOW3LuUIzk6cr4h/RAtjSbHt0k7UbpuZhrRP0kaG3hHDj2ukJCAthVV2lF8GpKxAe88457GibjfqoJu2SXTpo1Lh00WwIqV6HnTJFAHCc8BOUjO/I30tDc+xW/z2tE/cNMvLawAeoLHIs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776084699; c=relaxed/simple;
	bh=23inD9JIIZjzCV4/Xchyn5qBDzAOZr/JfA0i5oTHoRM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Vons7jG37dqj8fv1eF1Qzamlr04Y3wPh/G2Hl190++DJA6fgfmqZnTx4iMr40bCIwmPq0rQmV5wYsVsok43AzrpbdwZvcA06y3mNHugO3wAAFofdLyfITDd4mNIHhPbzebvJ1irwHi6hF6X48fLQveLANlr3rWPOt/Tg0hR74jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-46f083f82c7so6147625b6e.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 05:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776084697; x=1776689497;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jRIdr1VgrQYf+zTp1aY4GLpmv27r2Op9rfFRPV8Wt6k=;
        b=flkm3g3wGyPRdITBeNmu2VY+R1MzCwwG0OygoqDx+G/N789z9xvEWeDIoZhU9SzBwW
         y/zZxcD1lNYj4d0b5vytZn6tSXzv5Y2zHO3xy1LALNRbI7zUn2OSWG7sqJRHPGJHRO2N
         REQpjaeUdVM53F/GjvAaqrwbLjc5/DEm2IS5xMsQg27ttkPupL+gFkKPAU1F9UJmjmhG
         RNcxoS+N6UgtjZX+lXhgB3PChpEOgj4zyy38bhn2BDT9BfEbVMLDhxXfMDT8iT1ikTUm
         8vL5rKyjLlTGa3efp5FJMQ9QfeOF7A1qx0DIsj7yr0ukRBjdxtvt40ryrFL03QiwjaqL
         o2DA==
X-Forwarded-Encrypted: i=1; AFNElJ+3SDOE2w0+T1Z6ADMqYlnuzTzzyX9DgdyOX97Kcf6ep7xoTRxGLO1BbsHt+fw58c3ZDhluomBgL8rGOM+35/0J@vger.kernel.org
X-Gm-Message-State: AOJu0YxOQOKwEzNQTO5QQQATXdxcoXXMa95+asnGT3x0g2GYr3FvCmVL
	RsA51w8OPUcPfeLioUQB/gO/2CU8jC610Xv4QnNhnovKlctkH+vEYKpHbbY2TYg1AZwbn22LURE
	m5nRhpk2aw/TokYMTGmIefq/GqkAmjS73YJUZ3augWZztyIcvna8MIPBfpZE=
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4412:b0:686:f60b:dde8 with SMTP id
 006d021491bc7-68a6a5ba019mr6463135eaf.24.1776084697105; Mon, 13 Apr 2026
 05:51:37 -0700 (PDT)
Date: Mon, 13 Apr 2026 05:51:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69dce6d9.a00a0220.468cb.0046.GAE@google.com>
Subject: [syzbot] [perf?] KCSAN: data-race in event_sched_out / perf_mmap_rb
From: syzbot <syzbot+1f011f617ab8493f3fdd@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7c6c4ed80b87 Merge tag 'vfs-7.0-rc8.fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1129b302580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a78dd265deac3a9
dashboard link: https://syzkaller.appspot.com/bug?extid=1f011f617ab8493f3fdd
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/952ebc34a0d7/disk-7c6c4ed8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d3c6b295fa45/vmlinux-7c6c4ed8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6cbdb6b4817a/bzImage-7c6c4ed8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f011f617ab8493f3fdd@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in event_sched_out / perf_mmap_rb

read to 0xffff88810e381fd0 of 8 bytes by task 21833 on cpu 0:
 __perf_update_times kernel/events/core.c:749 [inline]
 perf_event_update_time kernel/events/core.c:762 [inline]
 perf_mmap_rb+0x71d/0x950 kernel/events/core.c:7333
 perf_mmap+0x1d7/0x300 kernel/events/core.c:7460
 vfs_mmap include/linux/fs.h:2070 [inline]
 mmap_file mm/internal.h:167 [inline]
 __mmap_new_file_vma mm/vma.c:2468 [inline]
 __mmap_new_vma mm/vma.c:2532 [inline]
 __mmap_region mm/vma.c:2759 [inline]
 mmap_region+0x195e/0x20c0 mm/vma.c:2844
 do_mmap+0x9b2/0xbd0 mm/mmap.c:559
 vm_mmap_pgoff+0x183/0x2d0 mm/util.c:581
 ksys_mmap_pgoff+0x267/0x310 mm/mmap.c:605
 x64_sys_call+0x14df/0x3020 arch/x86/include/generated/asm/syscalls_64.h:10
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

write to 0xffff88810e381fd0 of 8 bytes by task 21809 on cpu 1:
 __perf_update_times kernel/events/core.c:-1 [inline]
 perf_event_update_time kernel/events/core.c:762 [inline]
 perf_event_set_state kernel/events/core.c:781 [inline]
 event_sched_out+0x4c9/0x760 kernel/events/core.c:2484
 group_sched_out kernel/events/core.c:2508 [inline]
 __pmu_ctx_sched_out+0x3e7/0x530 kernel/events/core.c:3555
 ctx_sched_out+0x279/0x2e0 kernel/events/core.c:3646
 task_ctx_sched_out+0x4d/0x70 kernel/events/core.c:2955
 perf_event_context_sched_out kernel/events/core.c:3853 [inline]
 __perf_event_task_sched_out+0x474/0x710 kernel/events/core.c:3953
 perf_event_task_sched_out include/linux/perf_event.h:1662 [inline]
 prepare_task_switch kernel/sched/core.c:5086 [inline]
 context_switch kernel/sched/core.c:5243 [inline]
 __schedule+0xd3b/0xd40 kernel/sched/core.c:6911
 preempt_schedule_common+0x11/0x30 kernel/sched/core.c:7095
 preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:179 [inline]
 _raw_spin_unlock_irqrestore+0x27/0x30 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:407 [inline]
 __wake_up_common_lock kernel/sched/wait.c:127 [inline]
 __wake_up+0x88/0xb0 kernel/sched/wait.c:146
 audit_log_end+0x1e0/0x250 kernel/audit.c:2804
 audit_seccomp+0xdb/0x100 kernel/auditsc.c:2955
 seccomp_log kernel/seccomp.c:1048 [inline]
 __seccomp_filter+0x8ec/0x1350 kernel/seccomp.c:1344
 __secure_computing+0x81/0x150 kernel/seccomp.c:1404
 syscall_trace_enter include/linux/entry-common.h:112 [inline]
 syscall_enter_from_user_mode_work include/linux/entry-common.h:156 [inline]
 syscall_enter_from_user_mode include/linux/entry-common.h:187 [inline]
 do_syscall_64+0xd3/0x370 arch/x86/entry/syscall_64.c:90
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000003d41894 -> 0x0000000003d477ec

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 21809 Comm: syz.0.5496 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
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
