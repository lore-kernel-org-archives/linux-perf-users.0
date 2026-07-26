Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E930274D
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 03:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785038249; cv=none; b=OwJQE0nFH8a6jwkgCR9DXzKBUlzMa3lPpKYHq9/EHQ4zU7gQCUOfOiKmunfRZLdiG/WSSzwUQxdAhDCrS3RTex7Wo4mWw3knvUXBxoSAsPd1lNHt2C0A5Ruka7PWD2jtr37iEsZpo7OZnKzjdFvzvvQCij74nZJ6jJ9nW4OZpQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785038249; c=relaxed/simple;
	bh=7NPtkPgLh0dM8SIQLyni9v0/4PGYOp+shiNKq8k636E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XrYgLd9Bt7j1dbi6ZlhOPaXfS5EHUUvmegmFt5e7CKSoQL9IxjT2WVNNpxWSzUzuBFlxYnG7b6gbK/DUA68qGXGNqC2ltOCqPouBWnGm7GN/DqUzr0sZCpeccFAI0160Mhj2GDtTQcJPcu5ci9QG5U5WvxvKiBe4jy1IAKOmVkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4ab260600easo3359532b6e.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 20:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785038246; x=1785643046;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nCKY24Xkq1IpAIbMlq4qRioewj6ovYd2DdymO71rPEw=;
        b=r++RoK/mcKLCR6413dD/zoYY5jJlV345u6FnhDapHSKKCfNrMq34xpbDNoeJUvTqfO
         1CFi5fAqYzK++cCDS08v/KRdaV67EOk4Jq66oPrFVc58ZRE0K5GSWaU7xgERknsAJSj5
         HHRhys1qUORFJw8z2K82AdAFbOBUN65XzC/qozkeZWvhQxx/882fe4tiQU12tZhVl6l/
         QJPHubdTCok60RatxAsOdkjSliHgUJEWKWZSVDQMz49UG0A55R0mUAID/aKb+ptP7u6E
         TIDtqqXKsIAjWxiN5djtj45HUPT4l5/dTDLAQDrYKnhMiL3XCHbXAb9ZG1wKBSTQUYFs
         FRTw==
X-Forwarded-Encrypted: i=1; AHgh+Rrdzd2pfB8DyK6rlqayE+4HVBBodixe8cm0biF+HLNXle4+Z6vflxfjxgIVu2Xua5Bfe7FlCzJOabjsXMrtbTVy@vger.kernel.org
X-Gm-Message-State: AOJu0YypW3Jdy1Fvz/iwU9mHIvEhdsgXtBCAIEauOKZXWTTM1OSBDSNn
	SX5p1dZa3iDpBlS0iZZnBu5qk4hstoWeWuTye5ijpOLkZVfPSleokJeY18GiFg3q4QI5tfIGZR3
	hJlCIv9lSshzZXY+Gpcc5xfNZ1/+H/AwJGqnoFRlHixXV6Z4j3yX+zB7o7YU=
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f90:b0:495:f0ac:8297 with SMTP id
 5614622812f47-4ab5e61edb2mr5183901b6e.33.1785038246356; Sat, 25 Jul 2026
 20:57:26 -0700 (PDT)
Date: Sat, 25 Jul 2026 20:57:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6585a6.073198cf.94f0f.0020.GAE@google.com>
Subject: [syzbot] [perf?] KCSAN: data-race in __perf_event_overflow /
 __perf_event_set_bpf_prog (2)
From: syzbot <syzbot+d2b7abb7919cbc9a984f@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0ce37745d4bf Merge tag 'block-7.2-20260724' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1410388e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84b3039e8461eef5
dashboard link: https://syzkaller.appspot.com/bug?extid=d2b7abb7919cbc9a984f
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82454ebb316b/disk-0ce37745.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/728ae5f54b86/vmlinux-0ce37745.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4ce26f3067dd/bzImage-0ce37745.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d2b7abb7919cbc9a984f@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __perf_event_overflow / __perf_event_set_bpf_prog

write to 0xffff88811ac6a2a8 of 8 bytes by task 23981 on cpu 0:
 perf_event_set_bpf_handler kernel/events/core.c:10711 [inline]
 __perf_event_set_bpf_prog+0x46b/0x4d0 kernel/events/core.c:11697
 _perf_ioctl kernel/events/core.c:6662 [inline]
 perf_ioctl+0x8e4/0x1590 kernel/events/core.c:6722
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xce/0x140 fs/ioctl.c:583
 __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:583
 x64_sys_call+0x1563/0x3020 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x136/0x3c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811ac6a2a8 of 8 bytes by interrupt on cpu 1:
 __perf_event_overflow+0x230/0x940 kernel/events/core.c:10769
 perf_event_overflow kernel/events/core.c:10853 [inline]
 perf_swevent_hrtimer+0x28d/0x310 kernel/events/core.c:12273
 __run_hrtimer kernel/time/hrtimer.c:2032 [inline]
 __hrtimer_run_queues+0x1f8/0x510 kernel/time/hrtimer.c:2096
 hrtimer_interrupt+0x257/0x810 kernel/time/hrtimer.c:2215
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1051 [inline]
 __sysvec_apic_timer_interrupt+0x5f/0x1c0 arch/x86/kernel/apic/apic.c:1068
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0x6f/0x80 arch/x86/kernel/apic/apic.c:1062
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
 __sanitizer_cov_trace_pc+0x8/0x70 kernel/kcov.c:213
 chacha_permute+0x39a/0x510 lib/crypto/chacha-block-generic.c:24
 chacha_block_generic+0x47/0x310 lib/crypto/chacha-block-generic.c:83
 chacha20_block include/crypto/chacha.h:45 [inline]
 get_random_bytes_user+0xf7/0x2b0 drivers/char/random.c:458
 __do_sys_getrandom drivers/char/random.c:1406 [inline]
 __se_sys_getrandom drivers/char/random.c:1380 [inline]
 __x64_sys_getrandom+0xcf/0x1a0 drivers/char/random.c:1380
 x64_sys_call+0x2a28/0x3020 arch/x86/include/generated/asm/syscalls_64.h:319
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x136/0x3c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000000000 -> 0xffffc9000511d000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 23978 Comm: syz.3.7094 Tainted: G        W           syzkaller #0 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
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
