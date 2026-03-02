Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E438B7D6
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Mar 2026 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442016; cv=pass; b=EcAbet4tA2vYhkft2xHg1A1+YF73nEitw6aVaPeLyuTxvNgD44CwWW69OcauhkINXrVRF+4BQ0R2AjIa7ZOyz77J7IalDRxYN6XyXWX0N8Evf4O6SkHXWRfE7Wylz+Gxd0zLyCLhFiNi1HgV0wNRG4y/Xc1DwFXoD0wJNPWm0+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442016; c=relaxed/simple;
	bh=Wqm4M8zpADdnGjbRnJfT5476S4B2fTnEXmWXq+lRGIo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=C6B75ulReMpd6hUTbrjrCugi9xECmIMXZ54kkJDVA4/SVfOQhHuFrScw65pmYsc5xwVTN99iCHZ4o91/dCMJ5TxHK/RfEyGgSdKT9uCalh1haOnfO3xYIivjLSOV0OMSqOievRIJKgxst6qaUe12tKwJwKfQMF/d7rru4P17fiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wk4XQeJm; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wk4XQeJm"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aaf5d53eaaso28736895ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Mar 2026 01:00:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772442014; cv=none;
        d=google.com; s=arc-20240605;
        b=BfCbInTftPhWVJdmyWfNMZhEoOZyIv0cH+vBkTb+nXt746J6Y0zCPrpDdFFxg9xdp3
         S+penbMhqQeXKBif+qZBT8vXYpxesml/jdkMN5aB87BiZIip+Pvo5bjSJfi5y392f17M
         oYpNc7b8S92s2b5xaU7D9uIUvstxXF5NFqiJyog6STOXYffR8rYlaezyR8coiVfX20Fo
         +JU1v8oD0dSPuNvPkiKv1kmi654hYFlGbE0gXFSkQ2IF205gQpomNVn/+89P6n7b5cKl
         b+rDGe7xHKct0hxmIEXDdPq7B3sobOEbXAwd5f8UWBemtNPOnBGhPA8HIaYXTgpLFtao
         izyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=tyfQqvmOLhXYF1eqzHxusoyHZKTXWx+8q/n4jqqrR/Q=;
        fh=6kqVUsGsbGOF+WzrKI2cAp9TRf9ZHgqwL762dYWVvI0=;
        b=VzU4JqUPzd/QfKZMybnFS6Qh8Huf5u3vidD6bV3O/WYsiOD6Evj/TvgwlSQEypQozL
         WZkGhV8Kvm85JnQ41rGwp2POoWIsPHxRIGnPidvqhnNTLLqaHfUE0GXfqRo1h22kGWvE
         1BE/axP6Q1CmJW28qgYeWzpC08L56R9cDZDlFnSeomV4lOYImKIyCRlrJ54focrkTVXQ
         IEUzbc6YuvW44/wt++cOUdC9/V8V2KraVlsatX3zc97RsoCPu68geFhNuOgJvIhfOqog
         e0doLAwNhjNzurrgC7eCJXLWt8hzz18vSmxttJui0SKvxKJy00d8+I9L4UHPSDEzUNsP
         DcwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772442014; x=1773046814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tyfQqvmOLhXYF1eqzHxusoyHZKTXWx+8q/n4jqqrR/Q=;
        b=Wk4XQeJmUPEmNcVIdijyFXc5OUj5Q+swOX0YN+fTXTPSO728LkUnISJAH1zZqTrn09
         Stf82G4Wr+Nn4+CyjAHKr2okleT9t5dfdM7Wb3lj7BALT7I847MjOa5yTdMU2A+Aw14I
         c8MXqSpxZxwioew/tLBqmZNs1MUlipoWOwUVJzBhCsJc6t7dtz3TovY/fheRfAF8QRjs
         du6rAYHsaTk7WATeyUeuzf0Op6nh0wdG1ksa8YEreJJ8CmHG/fhb4jWdpzbwjjG5pBAj
         +jDJpp4oQjdoiEwVd76YqszxeqT6mAZNwFWT9sXOwzgQdKuZSKEzfLwFMAcFb9bnLtFp
         Mfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772442014; x=1773046814;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyfQqvmOLhXYF1eqzHxusoyHZKTXWx+8q/n4jqqrR/Q=;
        b=GgAQFrqne7MelHTwufgIiJKIqn3Oo1cjjM7gssDuAEoofYPhBwx2L9mIbN7r7/Bobv
         Wnhrsxoscu0RF8zhAjY97qmEHOSY8+kLRHYzxB7b9HllLeOS7YIGOfWTNAMxjeXh7HhZ
         OMDT3Lf0VEWPaD/7JLBP4CK2xhgejc+NHUWtl9aqYYfzzmMc274JaIE4LareZVyOp/C2
         6U0r/GD+FWLKZ8GK/O2kDNt+/mgdRfqJk6GKayD8GfvRiXKS/iF7rYYOfJyn42D3fE/s
         ZxYViCzMYsQHNJmlZnQ0MU/ZnJzyNhRwtqlFHRcM5CSTH/J8Jb2Jls40QkJY2imVXuDy
         Mb6A==
X-Forwarded-Encrypted: i=1; AJvYcCX74H7z9ThmydiDECzivVHom9vkoCQ61Y/4YO2TUbn3vM32EAQTFIwGy3eEogKo7h5wIsKl6QSpKWPLxfaJ27Wq@vger.kernel.org
X-Gm-Message-State: AOJu0YwYPdSS7qb1gE3miRhkkhM4uqUWyVfg5e1TbuuJsjA/RgTTePDG
	9tX0GRoEK/7dZyX7oSaS9bYZuvq5e7rcdfwGlubkULn94WC0YDZc3BfARYxgYlLxbT7Y2FAgAB3
	OJrfaC96NhjrCcJHUfKyfeRESQQkhCfo=
X-Gm-Gg: ATEYQzx9PXJZfwq2XRocvbiBdDKuXg2tdfbb+WkMiE0EXTYXpFHGyg7UTeZDOCqqX1q
	I1tVM8XdVSyydLsk2sQAUnrVIvzOddegz+VjLJkYK4yMnDGExD5uf1dnevtYCnBagGfhU6qQ6/3
	WE44SaKEInnZSJ7sDFqDcLA6dPN6z4pM/lnTO9hI30pBkB2rN3gyAwgf7e8DYhIJW2ZhGBPe3aQ
	LtEltzD9Sd4urKQS3f4WGFbNkoBA2Op2+I9oCjtGfkKVRjL0uuzNagqKRV2qOkG1CUgZ7xDndBr
	BDa9IrY=
X-Received: by 2002:a17:903:2312:b0:2ad:ca65:a37b with SMTP id
 d9443c01a7336-2ae2e4d981bmr98832565ad.51.1772442011208; Mon, 02 Mar 2026
 01:00:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zw Tang <shicenci@gmail.com>
Date: Mon, 2 Mar 2026 17:00:00 +0800
X-Gm-Features: AaiRm52LxVr7Zn_98ChAawTy5LR0CBOsuRmpYtY5TgVAjctWqI6-OSX4Ywa369A
Message-ID: <CAPHJ_V+J6YDb_wX2nhXU6kh466Dt_nyDSas-1i_Y8s7tqY-Mzw@mail.gmail.com>
Subject: [BUG] kprobes: WARNING in __arm_kprobe_ftrace when kprobe-ftrace
 arming fails with -ENOMEM under fault injection
To: Naveen N Rao <naveen@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I am reporting a WARNING triggered by a syzkaller reproducer on Linux 7.0.0-rc1.

The kernel hits a WARN in kprobes while trying to arm a kprobe via ftrace:

Failed to arm kprobe-ftrace at __split_text_end+0x4/0x11 (error -12)
WARNING: kernel/kprobes.c:1147 at __arm_kprobe_ftrace()

This seems to be triggered through perf_event_open() -> trace_kprobe
-> kprobes. The reproducer enables systematic fault injection and
injects a failure (nth=7), and the arming path returns -ENOMEM (-12).
Instead of cleanly failing, kprobes emits a WARNING.

This is reproducible only with fault injection enabled.

Reproducer:
C reproducer: https://pastebin.com/raw/casZvuLe
console output: https://pastebin.com/raw/1xkwRUmc
kernel config: https://pastebin.com/raw/8Er8SZz0

Kernel:
git tree: torvalds/linux
commit: 4d349ee5c7782f8b27f6cb550f112c5e26fff38d
kernel version: 7.0.0-rc1-00301-g4d349ee5c778 #5 PREEMPT_RT (lazy)
hardware: QEMU Ubuntu 24.10



[   92.516728] WARNING: kernel/kprobes.c:1147 at
arm_kprobe+0x563/0x620, CPU#0: syz.1.94/783
[   92.516766] Modules linked in:
[   92.516809] CPU: 0 UID: 0 PID: 783 Comm: syz.1.94 Not tainted
7.0.0-rc1-00301-g4d349ee5c778 #5 PREEMPT_{RT,(lazy)}
0b4dbcd6f14740930e77a74387d10aec6dbca841
[   92.516842] Hardware name: QEMU Ubuntu 24.10 PC (i440FX + PIIX,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   92.516855] RIP: 0010:arm_kprobe+0x56a/0x620
[   92.516885] Code: ff 4c 89 fa 48 b8 00 00 00 00 00 fc ff df 48 c1
ea 03 80 3c 02 00 0f 85 a8 00 00 00 48 8d 3d cd d3 8d 06 48 8b 75 28
44 89 e2 <67> 48 0f b9 3a e9 81 fc ff ff e8 87 8c ff ff 48 8d 3d c0 d3
8d 06
[   92.516905] RSP: 0018:ffff88800faf7a48 EFLAGS: 00010246
[   92.516924] RAX: dffffc0000000000 RBX: ffffffff89f46b40 RCX: 0000000000000000
[   92.516939] RDX: 00000000fffffff4 RSI: ffffffff81200004 RDI: ffffffff88481300
[   92.516955] RBP: ffff88800c566a18 R08: 0000000000000000 R09: fffffbfff108bacb
[   92.516969] R10: fffffbfff108baca R11: ffffffff8845d657 R12: 00000000fffffff4
[   92.516984] R13: ffffffff8845dc20 R14: ffff88800c566a90 R15: ffff88800c566a40
[   92.517002] FS:  00007f42ed38f6c0(0000) GS:ffff8880e224e000(0000)
knlGS:0000000000000000
[   92.517023] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   92.517041] CR2: 00007fe44aa68710 CR3: 000000000e340000 CR4: 0000000000350ef0
[   92.517057] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   92.517073] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[   92.517090] Call Trace:
[   92.517099]  <TASK>
[   92.517126]  enable_kprobe+0x1fc/0x2c0
[   92.517173]  enable_trace_kprobe+0x227/0x4b0
[   92.517240]  kprobe_register+0x84/0xc0
[   92.517279]  perf_trace_event_init+0x527/0xa20
[   92.517329]  perf_kprobe_init+0x156/0x200
[   92.517367]  perf_kprobe_event_init+0x101/0x1c0
[   92.517406]  perf_try_init_event+0x145/0xa10
[   92.517458]  perf_event_alloc+0x1f91/0x5390
[   92.517509]  ? perf_event_alloc+0x1e4d/0x5390
[   92.517586]  ? perf_event_mmap_output+0xf00/0xf00
[   92.517709]  __do_sys_perf_event_open+0x557/0x2d50
[   92.517762]  ? write_comp_data+0x29/0x80
[   92.517788]  ? irqentry_exit+0x157/0xb20
[   92.517822]  ? perf_release+0x50/0x50
[   92.517848]  ? irqentry_exit+0x157/0xb20
[   92.517897]  ? __split_text_end+0x4/0x11
[   92.517956]  ? tracer_hardirqs_on+0x80/0x3b0
[   92.517986]  ? do_syscall_64+0x94/0x1160
[   92.518022]  ? __sanitizer_cov_trace_pc+0x20/0x50
[   92.518072]  do_syscall_64+0x129/0x1160
[   92.518118]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   92.518142] RIP: 0033:0x7f42ee92ebe9
[   92.518164] Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89
01 48
[   92.518184] RSP: 002b:00007f42ed38f038 EFLAGS: 00000246 ORIG_RAX:
000000000000012a
[   92.518207] RAX: ffffffffffffffda RBX: 00007f42eeb65fa0 RCX: 00007f42ee92ebe9
[   92.518222] RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000200000000140
[   92.518248] RBP: 00007f42ed38f090 R08: 0000000000000008 R09: 0000000000000000
[   92.518262] R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000001
[   92.518277] R13: 00007f42eeb66038 R14: 00007f42eeb65fa0 R15: 00007fff172e7218
[   92.518358]  </TASK>



Notes:

The reproducer sets up fault injection (/proc/thread-self/fail-nth,
failslab/fail_page_alloc knobs) and injects nth=7 before calling
perf_event_open().

The failure is reported as -ENOMEM when arming kprobe-ftrace, and the
WARN is triggered in __arm_kprobe_ftrace().


Thanks,
Zw Tang
