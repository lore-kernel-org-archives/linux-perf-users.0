Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C3817A597
	for <linux-perf-users@vger.kernel.org>; Sun, 24 Nov 2024 22:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732488564; cv=none; b=lRMhHa2N17b1ilJSsIGtTMXYdpDDU5Tz3RpQH5Aux8uVNn8eYVMeTUUC8iIIXNCD7o9LfY+T7T+VTcW1no4ok8axsbArSuJstWWe4GbtPLdOoxXEFqfV/CuAWnSSxigSHVw08eKBQ771Hn9wWut/T1QlztTQefbSdRIPFgSM42s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732488564; c=relaxed/simple;
	bh=gfnHJjwfgdKmCRW2N48UfWJk5ORO21VNu9CS8MFAIjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKWObaTtxsNtox1SykAPk9lg2twgZNnuzlnk4oIKbhfFE2UA7xTvqUeez0/XlJECVHHP0tc8/E7bjJj2kA9MW2Z/alwqW5a3WJ8e+Hn/k7GWGo0TpbN3nB3pxwr0K5yPw4OUKGgCvzBleYCYQc7htcw7hIevid3/svCGRzfkntE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9aku3O8; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9aku3O8"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-724e5fb3f9dso1818942b3a.3
        for <linux-perf-users@vger.kernel.org>; Sun, 24 Nov 2024 14:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732488562; x=1733093362; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zX0nE7NDEdfGZrNZGwPLqU9rN5UAwEYfOh7fGJZubFM=;
        b=q9aku3O8wNEEExJX+0bVdDkXZuHby/dpXe7BjFBdPHNRLd0xFeEzybjNuRDHtiNGu/
         3z+qqLSeBJjyqYUfbcUOjIucPGIIXSETKCn1IMacN3XTA+HS0Z/orqTx8BJbzCn027F4
         GS1GFB1zaho+b3SZb1+blK/sudbiElFVSOQOwP9q1jRF/z5DwDmfH8SRinZsANRoiPd9
         Ke1kePLih0prfBJ6JDGKzQGrF/amubh0eP1tgvRL1nOA+pXpwS8/dUhUuXmEqWnervr7
         4DL7EQc8y3bQLaGF34mQZM8pE6z1IZpxCATxHS6l5TvpatIiDc7KlrKOgrzVD/sJ1RC2
         8mAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732488562; x=1733093362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zX0nE7NDEdfGZrNZGwPLqU9rN5UAwEYfOh7fGJZubFM=;
        b=LG8DbnW8V7Uh8uU7wPgS6Px4GLLx8eT/raB+xEXvZa/tsrPnAt29yzrtHp2mIwB0hT
         qRxBi+drrdh9xmEuVcRWHx8sL4T4/WjSUwWjEsBidK5CboYI0Yp7vfinEi5bBQVkMUvE
         DoOLOVioKPTnLoNfXcZ0sUq1xdeCz9vt/l33dLdq/iszwh2F3RGFOOW+G7r/I2+390fC
         hak56iyUWZK0UscPXJ12mb25lUJ34yiZEaPbdYzeZNNMta4Gce9ItKV+mQPT9xLAJ5fl
         AgpXqpvR7/Q9XHZ3m9QTF9pe2oO7rFciTvbwEYzClc/WlBfMNHciaod8+ywj18UndJQi
         TfeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtvTaSBnviyRgMeFv1nd2YptHuGgwLAvmvBt4GL/4sqofOBtpdhDg54efv7dTf7818KfQFNfSz3rx0xr0NLY5x@vger.kernel.org
X-Gm-Message-State: AOJu0YyfY0MqFEjUdh5IhuSFvP0jNezbZMdQMQ/AwnFM62WCKucqkOlG
	403gD+hx8BXxbcLp/RMurRkp87FgPyJurve5k3Glc+mfBMXZAP66YmwDn/q9UREa3VYC/wqkVDr
	al9Bywdi+4O39SGwb6Q+Xp+teaQTFD4yFGgqf
X-Gm-Gg: ASbGncvuCQVR/7bpHI/X+l5CM/DdlVUIX0myQjNkHHg/mnH2HOisMPkNLxUJ2SeBDlt
	mQxMj1yrrzp7ru8VoCZKdtwLF4Bqm39rIY4AmvMZfBAeXV/u2kPYs0Pt+RzAVde8=
X-Google-Smtp-Source: AGHT+IGly1+z6aeNBztEpVOsbXsN+8Ek9BfoSxWOu5bkpC+Sbuna4B2/9T9dhULWPlo4Oyv5U12MRtr3xKrQOEwO3aE=
X-Received: by 2002:a05:6a00:c81:b0:720:36c5:b548 with SMTP id
 d2e1a72fcca58-724df684b57mr13854174b3a.16.1732488562364; Sun, 24 Nov 2024
 14:49:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6743acf4.050a0220.1cc393.004d.GAE@google.com>
In-Reply-To: <6743acf4.050a0220.1cc393.004d.GAE@google.com>
From: Marco Elver <elver@google.com>
Date: Sun, 24 Nov 2024 23:48:46 +0100
Message-ID: <CANpmjNMQ7ZVG0i9j1K7J0yKrtfrFfHi6kXaA7FLKmX5T4yWXTw@mail.gmail.com>
Subject: Re: [syzbot] [perf?] [trace?] KCSAN: assert: race in srcu_gp_start_if_needed
To: syzbot <syzbot+16a19b06125a2963eaee@syzkaller.appspotmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mark.rutland@arm.com, mhiramat@kernel.org, mingo@redhat.com, 
	namhyung@kernel.org, oleg@redhat.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, RCU <rcu@vger.kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"

+Cc RCU

On Sun, 24 Nov 2024 at 23:47, syzbot
<syzbot+16a19b06125a2963eaee@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    42d9e8b7ccdd Merge tag 'powerpc-6.13-1' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10a00778580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3d7fd5be0e73b8b
> dashboard link: https://syzkaller.appspot.com/bug?extid=16a19b06125a2963eaee
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ef231513adc7/disk-42d9e8b7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/54caaac5960b/vmlinux-42d9e8b7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/85b5a6566143/bzImage-42d9e8b7.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+16a19b06125a2963eaee@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: assert: race in srcu_get_delay kernel/rcu/srcutree.c:658 [inline]
> BUG: KCSAN: assert: race in srcu_funnel_gp_start kernel/rcu/srcutree.c:1089 [inline]
> BUG: KCSAN: assert: race in srcu_gp_start_if_needed+0x808/0x9f0 kernel/rcu/srcutree.c:1339
>
> race at unknown origin, with assert no writes to 0xffffffff8676ffc8 of 8 bytes by task 6285 on cpu 0:
>  srcu_get_delay kernel/rcu/srcutree.c:658 [inline]
>  srcu_funnel_gp_start kernel/rcu/srcutree.c:1089 [inline]
>  srcu_gp_start_if_needed+0x808/0x9f0 kernel/rcu/srcutree.c:1339
>  __call_srcu kernel/rcu/srcutree.c:1384 [inline]
>  __synchronize_srcu+0x114/0x150 kernel/rcu/srcutree.c:1432
>  synchronize_srcu+0x1ae/0x1d0
>  uprobe_unregister_sync+0x1a/0x20 kernel/events/uprobes.c:1328
>  __probe_event_disable kernel/trace/trace_uprobe.c:1138 [inline]
>  probe_event_disable+0x1f5/0x240 kernel/trace/trace_uprobe.c:1222
>  trace_uprobe_register+0xbb/0x3c0 kernel/trace/trace_uprobe.c:1512
>  perf_trace_event_unreg+0x6c/0x1a0 kernel/trace/trace_event_perf.c:162
>  perf_uprobe_destroy+0x6a/0xf0 kernel/trace/trace_event_perf.c:345
>  _free_event+0x7ca/0xa10 kernel/events/core.c:5357
>  put_event kernel/events/core.c:5454 [inline]
>  perf_event_release_kernel+0x61a/0x670 kernel/events/core.c:5579
>  perf_release+0x1f/0x30 kernel/events/core.c:5589
>  __fput+0x17a/0x6d0 fs/file_table.c:450
>  ____fput+0x1c/0x30 fs/file_table.c:478
>  task_work_run+0x13a/0x1a0 kernel/task_work.c:239
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0xa8/0x120 kernel/entry/common.c:218
>  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x0000000000000000 -> 0x0000000000000001
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 6285 Comm: syz.1.1056 Not tainted 6.12.0-syzkaller-08756-g42d9e8b7ccdd #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller-bugs/6743acf4.050a0220.1cc393.004d.GAE%40google.com.
