Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E4C392806
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770288137; cv=pass; b=t3uCwTd2hVlyA3fvnFgmgHuPwCAymMlzngyyeIG4Ji3uw0QKI5bPGJl0NqIxg990QckMJP0p1qWaY1i92WRaOj8NcRPkKCWz1D0X1/ir8HwX7/rGSW0oyH+xaua3W+9J+GVK/b4QqDJHXE2IGWz6afuirFYj4JY40d7C098BHx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770288137; c=relaxed/simple;
	bh=4WLZ46gxb1a++UKNEZJZyzZ38adoWRXlrScbc1PHRxA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cttlG6qXmkV830teY38yr/++Wj98OhFwpifZEMT3ZDsnznU+jRr8RwEr9HUrkZguHnoG9PtVJ8aoTm8jrzGa1ExkJX0PCcNM6Bgk6jKsj+F4gs/vP0cECJICFh/GxTWQualkJ+DFB+oyakS2Jx4xK7FyCNv06Am48Vn0o9fk7dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcsQYJj9; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcsQYJj9"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29f102b013fso8138165ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 02:42:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770288137; cv=none;
        d=google.com; s=arc-20240605;
        b=Qei0bkiIGnNUrEx7BBdBD6vVsgqSqaGicwDbfGcP3PUsQENuBLiLd2KSLxeEk9cHQX
         dJ8mUDukmJu8lmCkRIJBTkIZUOsLO2mTGE9q9adD8G45iazf4sB7xUyRlcdVau0qPb/V
         KYWKH1ImszgDruoZWKzt0mLrOqbn7bVMEaU/hdkv9JDgoqeeP83xGjVSE9gtzbMW0UV1
         Xm01ktUWjFIsplKKk2OQZ24j459fHx+FPiSiNp4lQebkAXXFc4vq3jYWCxN25L8Ju0WY
         rXR+yojNkuBmYs7kgc++Akbuia5iRzd49yRIxiYafC9LPMZDzvslEAT8SerXfvninKxJ
         51OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=4WLZ46gxb1a++UKNEZJZyzZ38adoWRXlrScbc1PHRxA=;
        fh=bUwele+r4JgqGc2MlCspueSCcWBghu+iBKpanpEpB3A=;
        b=HInJA5PPit4QcfVd4wq2URsrQJK0KuGP6WvVgoZtf7GbtXOHoV1o1VBB5EUoY5ZvkD
         6oTogREcRHOFzWaYn9FAazcWG6xgfJKuao8Gr80QVVdY9KJ8j+e2Vmcy3pp3QdLvjAiC
         bKjzm+saHlMicqcj9iHj39EBNWzC4cJm5Cy+mEQeRJo6h37YJUaslO5vkSqwVzHrGMAe
         XLWZyMvyDM0CKvAd36wZ8gSbwrnQAIqa3CIcfI+6jd7/9Id2eXB9VuQCRAFiynmYZQ13
         qjWg9ZIjXcpMTq3YlCBJ6ncsd04yfzyEbYcEdaV2dvgt8ehw3DOy8CXsLDqVVl0FMeJL
         l7yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770288137; x=1770892937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4WLZ46gxb1a++UKNEZJZyzZ38adoWRXlrScbc1PHRxA=;
        b=HcsQYJj9f2SNPbHhXnTLDeaM9buKl1y4fVbhTKWdyekQr9TCV/rT+JJDaQZTJKJbop
         9ykTv2khkvQ4YL6Nu3JVx2O6f/MMMWWHNO3QDNcGRjoM1sU5v99VD7sq7D5qQ7HLVTXo
         ngAXA4M9g+Cs8H7MbUUVSsJQTYPc+Vl5RtE1S00V6fQaKirl3V1sSKJ1vn2bTSXEKLNm
         hhB1C08AnT9EDkvmF2SW3xVyVRxzzrB35HJWuH4Y1qGoq0IygjpVwhQXd5+aR3ddsCph
         BEkRNbDNDA779RO1ROSJ1RkHMuIzPKWPY396xEW/okEIuHfMME4TNCE3p4FNgE3YRLx1
         bdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770288137; x=1770892937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WLZ46gxb1a++UKNEZJZyzZ38adoWRXlrScbc1PHRxA=;
        b=TU6c0ORK+erLAjRdJ0dPqUA2EZ7YstfPURKchWZpzF8IgWIFVbXVM/aNyP4g4Q4vLj
         3WmKJGO1WRe65a/zAmh9lR/sGx/WUJmcAuF9klxj22UwqHVDzd+NOLkMvDLXPKkbZeGR
         984Nq2YO2015n0H8WxgcrLDoWzSsQdESxIw7QiEfNDIUeOfawKHHrBqe199MAXj8A4A4
         zehjmdD80PFgn+hemUKxkLAhIssAN87gX2EgLDq0F+4CuJ1uVC/QtZ4/lz8QbnkazF+P
         ljpE5wNvHwIjH2F/cj/v9aQagLrjg3OHGebYpe2qIVLVNiTUENXWoWlDBtbhfyf/i8PC
         P9eg==
X-Gm-Message-State: AOJu0YyNWjswRSUNi9tTzpINzKQXWsOhpKsCLSRPByW9U70TwU8qB9t1
	TgW6t8ODgStFt75qjjSpaGVMUD8carFdN5Jf6f1QkQP7qyBgfgZAcVHb908XEEYPlqzZLrK2KUD
	lNB/izFWnX3rIPd2K8585Ez72vOqi8PFGiGikYAM=
X-Gm-Gg: AZuq6aJrMOYEL/N2DTVml7twwuCl2szAYYpTdFQrtFZMwvfnztmmmM4mXBBCsmH7byI
	+oCHj59NQ/HoBp1BZJuHsxuN1bBewCfRhragxLjq/9rl9RoXCORnJM4/gZcvkEfM6gKj+oMdEO1
	l7AJjLSAr+doXcJlKNv7Xqp020HL6QxtLW2zGrTQV89O3MU2nPWfcLewG+0oMgwPFBZ4dfkn2O7
	zUxritburT5l9czQirNnxQlIGUGv2k0aJZGGWojDiiKBnmMxkFHN83PgaxJhQKn+uVuDo4=
X-Received: by 2002:a17:903:2f0b:b0:2a7:8839:dda1 with SMTP id
 d9443c01a7336-2a933cda2e8mr67768665ad.13.1770288136521; Thu, 05 Feb 2026
 02:42:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zw Tang <shicenci@gmail.com>
Date: Thu, 5 Feb 2026 18:42:05 +0800
X-Gm-Features: AZwV_Qg3kLvGh8URfqTvCU32wQzJflOniy8brN-gVG8zzY9FSE0nVDy9AZjYx0Y
Message-ID: <CAPHJ_VK1t=pRw9zct9CNRET1=uH-efB9grAJ-kGJEN=PDk7z0w@mail.gmail.com>
Subject: [BUG] PREEMPT_RT: sleeping function called from invalid context in perf_event_wakeup()
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, mingo@redhat.com
Cc: boqun.feng@gmail.com, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, namhyung@kernel.org, will@kernel.org, 
	"peterz@infradead.org" <peterz@infradead.org>, juri.lelli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I am reporting a PREEMPT_RT =E2=80=9Csleeping function called from invalid
context=E2=80=9D bug triggered by a syzkaller reproducer on Linux 6.19.0-rc=
7.

The kernel reports:

BUG: sleeping function called from invalid context at
kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 1, preempt_count: 4

The splat points to perf=E2=80=99s wakeup path taking an RT spinlock while
running in an atomic/IRQs-disabled context:

merge_sched_in()
-> perf_event_wakeup()
-> __wake_up_common_lock()
-> rt_spin_lock()
-> __might_resched() (complains about sleeping in invalid context)

This suggests a locking semantic mismatch on PREEMPT_RT:
perf_event_wakeup() (via __wake_up_common_lock()) ends up taking a
lock that maps to rt_spin_lock(), which may sleep on RT kernels, but
the current context is explicitly atomic with IRQs disabled.

Reproducer:
C reproducer: https://pastebin.com/raw/NwDSxaU3
console output: https://pastebin.com/raw/yEEzYbx5
kernel config: https://pastebin.com/raw/LwALTGZ5

Kernel:
git tree: torvalds/linux
HEAD commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
kernel version: 6.19.0-rc7 #1 PREEMPT_{RT,(full)} (QEMU Ubuntu 24.10)


audit: type=3D1326 audit(2000000014.110:19630): auid=3D0 uid=3D0 gid=3D0 se=
s=3D3
pid=3D90430 comm=3D"syz.5.11565" exe=3D"/syz-executor" sig=3D31 arch=3Dc000=
003e
syscall=3D202 compat=3D0 ip=3D0x7f95e6baebe9 code=3D0x0
netlink: 80 bytes leftover after parsing attributes in process `syz.6.11576=
'.
BUG: sleeping function called from invalid context at
kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 90520, name: syz.2.1=
1583
preempt_count: 4, expected: 0
RCU nest depth: 2, expected: 2
CPU: 0 UID: 0 PID: 90520 Comm: syz.2.11583 Not tainted 6.19.0-rc7 #1
PREEMPT_{RT,(full)}
Hardware name: QEMU Ubuntu 24.10 PC (i440FX + PIIX, 1996), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xab/0xe0 lib/dump_stack.c:120
 __might_resched+0x2ae/0x430 kernel/sched/core.c:8829
 __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
 rt_spin_lock+0xc0/0x2c0 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 __wake_up_common_lock+0x1b/0x50 kernel/sched/wait.c:124
 ring_buffer_wakeup kernel/events/core.c:6662 [inline]
 perf_event_wakeup+0xde/0x230 kernel/events/core.c:7242
 merge_sched_in+0x786/0x10c0 kernel/events/core.c:4020
 visit_groups_merge.isra.0.constprop.0+0x889/0x10b0 kernel/events/core.c:39=
52
 pmu_groups_sched_in kernel/events/core.c:4038 [inline]
 __pmu_ctx_sched_in.isra.0+0x13f/0x180 kernel/events/core.c:4048
 ctx_sched_in+0x2d9/0x840 kernel/events/core.c:4095
 perf_event_sched_in+0x3d/0x90 kernel/events/core.c:2868
 perf_event_context_sched_in kernel/events/core.c:4148 [inline]
 __perf_event_task_sched_in+0x3ab/0x7e0 kernel/events/core.c:4177
 perf_event_task_sched_in include/linux/perf_event.h:1631 [inline]
 finish_task_switch+0x392/0x610 kernel/sched/core.c:5113
 context_switch kernel/sched/core.c:5263 [inline]
 __schedule+0x1293/0x38c0 kernel/sched/core.c:6867
 __schedule_loop kernel/sched/core.c:6949 [inline]
 schedule+0x66/0x180 kernel/sched/core.c:6964
 futex_do_wait+0x88/0x180 kernel/futex/waitwake.c:358
 __futex_wait+0x1af/0x2e0 kernel/futex/waitwake.c:687
 futex_wait+0xdc/0x180 kernel/futex/waitwake.c:715
 do_futex+0x2ec/0x360 kernel/futex/syscalls.c:130
 __do_sys_futex kernel/futex/syscalls.c:207 [inline]
 __se_sys_futex kernel/futex/syscalls.c:188 [inline]
 __x64_sys_futex+0x1c9/0x480 kernel/futex/syscalls.c:188
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xac/0x330 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7fa74e74ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa74d1b70e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007fa74e985fa8 RCX: 00007fa74e74ebe9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fa74e985fa8
RBP: 00007fa74e985fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa74e986038 R14: 00007fff7d0a70b0 R15: 00007fff7d0a7198
 </TASK>
