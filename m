Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE6368;
	Tue, 13 Aug 2024 04:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723525114; cv=none; b=AxQkJPoJzwOyNwtKICwITu4s8xhXuO82+U/OkQCZSpWbLKnLereFnYA5O+Lfw34/X9HalsbXI7H+whKtiWZ2Jo3c/kz/9MvZZvjPI7uvb9IRBemYEomb7IL0SVJTNE5PZEbO1k7kEmh3WtrqO7yY6KkM8I5kO0T7gpt82/+2siU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723525114; c=relaxed/simple;
	bh=2CfDUbhyXgj/RTnKocx6hfDtCGLJIQ616+Oz5rkG2rA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BxPgxjNkPgpvxpf560MXqWn6T3QMnlxsAp/PTUqJM+yX20vNhHg0B//XAVs6WVql+RaonWZDzqTJXUxD6WOHa4mdr9PSv2LxEjCACGnr/yySiBpUEY6XghgWipgtc8USPRRn8VL3vmXlISHvkkUl92S8M/KFK2rdK5M3Nolr6R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjePrbAT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjePrbAT"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cb4c4de4cbso3274909a91.1;
        Mon, 12 Aug 2024 21:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723525112; x=1724129912; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GJBahlfHxB7fg2TnurLMUszDxk6biQqClDOD+DRsTPo=;
        b=XjePrbATJP9HuE7nIIZ/o6gIqCYbIX2IAzBsS2aGzy321BicthpPDhjkdfiwAzv9R3
         HNWWg/jsvRi2Q1B7Mpofzid8Ez5m4DKyJ7CaqLPqkwDKC1CmcqPI8OPjb1j6SjjvfX6U
         BLLiCW2BLV8X7jRgQLxCV1+ZeCMHzrPIRehjxGvxcBnS6tkHVbZ6wGvsYM3Wb7Dt3snF
         o/W4WRvTrjYYQkM2LirCMlgR/INEGVBuf8gH0T30ebJSeIOx/RiLkXWYHewxi6kcGtOl
         zidO74SCMDeKUHewoQOLfvhExdwUoTqb8xypg6mf75fA8VfwA06WuLYJycnmwOX6PEFe
         DCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723525112; x=1724129912;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJBahlfHxB7fg2TnurLMUszDxk6biQqClDOD+DRsTPo=;
        b=lmYnWJ7ftaLiwE/wJ86sSgpj6s4+RsdZ/iZp9eyS8z8iZZG28bFLaqgwVTVGCNcQB6
         0uASdTAz2d+KrdNrvx3sIdkX6+2Dhy3QRuDhnJ+KnMLkJmbqqqTXIZGGVA/aGxjWxjgD
         Z0UWRJeQOAlJsW/JNRYBGPxuEDhUSakMqtq3/1tzNH0V91ntHKQp48ijXjkivYtELSlf
         E0qxsib08kYu9ypjmug1ceXtV8QDs240JzjOfCt65vzh16dfb9OTJYiTDCqJQvlyVCPs
         QhBdoMrW31awzdJfWz4KdY7KGN3Cr/Uu3JdrJaPA1esL34BWnxOBQQv+sTg9FuBB5wfk
         arnw==
X-Forwarded-Encrypted: i=1; AJvYcCVVcHlsmhW94620pqzlcd9ub8xZKy/RiAkkIao6lqTEgRKYgvbs08qLj1RUsjf/APmzK/uTb/LqlvK5ItVi9I58IXcJZYfZ+jg1+QjTx7GabQ==
X-Gm-Message-State: AOJu0YxZEfQ4Xlz4vT55sz0AUWURO5Is8D6U2W2Ww/3rsxcowk83D25e
	bU+N6ivTjWiQ5dqZHG/Pj3gzqVlnLYY85CWDcKrDjC2N3b2XaqmEUDE3W12N/VBeoZ4MQIraBHS
	0cwol/cYXzvNs7/enRWa8/PzgzX81CdRU
X-Google-Smtp-Source: AGHT+IGAWU7Cuqp9X4v9+Ijiin10pbISGUN2+LUUNfqufjX5iQ/6+2mATD0Nf/xRMJs+E0dq08+IIdNWIjuoV9bMMfw=
X-Received: by 2002:a17:90a:fa8d:b0:2c9:7cf1:83a4 with SMTP id
 98e67ed59e1d1-2d392551402mr2450113a91.20.1723525112050; Mon, 12 Aug 2024
 21:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Aug 2024 21:58:20 -0700
Message-ID: <CAEf4BzZ=Z9kuXf-tAZpw3QTK4VA7vmCCP5nWJTV1L=x3wRhfKQ@mail.gmail.com>
Subject: New "using smp_processor_id() in preemptible" splat on tip/perf/core
To: Peter Ziljstra <peterz@infradead.org>
Cc: open list <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hey Peter,

I started getting a new splat on the latest tip/perf/core, I suspect
it's due to [0], which moved this_cpu_ptr() outside of
raw_spin_lock-protected area. Please take a look, thanks.

  [0] https://lore.kernel.org/linux-perf-users/20240807115550.138301094@infradead.org

[  139.529263] BUG: using smp_processor_id() in preemptible [00000000]
code: test_progs/2361
[  139.530412] caller is event_function_call+0x2f/0x180
[  139.531081] CPU: 10 UID: 0 PID: 2361 Comm: test_progs Tainted: G
       OE      6.11.0-rc1-00043-gb5e7663f6aac #217
[  139.532531] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  139.533246] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[  139.534789] Call Trace:
[  139.535123]  <TASK>
[  139.535417]  dump_stack_lvl+0x56/0x80
[  139.535906]  check_preemption_disabled+0xc6/0xe0
[  139.536526]  event_function_call+0x2f/0x180
[  139.537088]  ? preempt_count_add+0x6c/0xa0
[  139.537639]  perf_event_release_kernel+0x72/0x2b0
[  139.538263]  ? __rseq_handle_notify_resume+0x26e/0x4a0
[  139.538973]  perf_release+0x11/0x20
[  139.539451]  __fput+0xee/0x2c0
[  139.539872]  __x64_sys_close+0x38/0x80
[  139.540389]  do_syscall_64+0x47/0x100
[  139.540900]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  139.541601] RIP: 0033:0x7f4b043fea94
[  139.542095] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84
00 00 00 00 00 90 f3 0f 1e fa 80 3d d5 18 0e 00 00 74 13 b8 03 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 44 c3 0f 1f 00 48 83 ec 18 89 7c 24 0c
e8 c3
[  139.544656] RSP: 002b:00007ffc19703188 EFLAGS: 00000202 ORIG_RAX:
0000000000000003
[  139.545683] RAX: ffffffffffffffda RBX: 00007ffc19703748 RCX: 00007f4b043fea94
[  139.546609] RDX: 00000000ffffffff RSI: 0000000000000939 RDI: 0000000000000007
[  139.547548] RBP: 00007ffc19703270 R08: 0000000000000008 R09: 0000000000000000
[  139.548515] R10: 00000000ffffffff R11: 0000000000000202 R12: 0000000000000000
[  139.549486] R13: 00007ffc19703778 R14: 00007f4b0455b000 R15: 0000000001004d90
[  139.550449]  </TASK>

-- Andrii
