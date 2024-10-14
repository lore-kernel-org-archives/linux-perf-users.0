Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0979B155C8A
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894650; cv=none; b=PJmz2ZOcmDtP/tkozQiL2aqcbypVENAqUacBPPFI/hmi09x9NiCXdP/MVAHjPkLUZAp0bP6IaExeaVUjKicb5nmYIudkziqXTwGcbNt7d/t6/QE/fuPs3k5oeAzzt7ceMm0jC4JLUJd6r5a5cHZV1vBHllAYIEAqJUkA4REG8io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894650; c=relaxed/simple;
	bh=oCZCPO1nwlZwVo7GHBA6GNZcZvm0cf8KNmQFmVoJ5/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nclU72aVffBXW7fy47j50CA63k1L2pbLRZ4pynF6qQPnLyTQpchr+o4Si130t4xhvmB4xMBy0kZplfSfKlWGmMZG9D1bZthuyRU1Qg0nfuf8NujSZdDfcDIuPxuXXp5E5eb3+pOsE2qtxg8jDTFMpYHSgz66Z3xgp92KMThZVOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rQM+ygcA; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rQM+ygcA"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fac3f1287bso35229381fa.1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 01:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728894647; x=1729499447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Zp8WLi7DGJx+e84KGtKjrVedsMWIQpQqNPQAsDX7M8=;
        b=rQM+ygcAoFTkVmQGBCYaffZCaZm8cc2AyjoZIV7jvvfYkvg6wIjB9F2oqzotTgwEv+
         ZY/dJBeZbd/bcIhD2PZEMtNI2Wr1ipeQ3B+6O7mx7Z3uPhLYyNy0gR5I6eMetXTqhEPw
         6y1Q6GD1+bCF9ZpmDPf1ynvGeO/e6pgBAx2/kGl4huXXJqYCS+35nPdM+Rje3tIsAISe
         ocwqapI3ay88nEZup6kv6xwXfvD4MgPh6dGTHx5q8wqaDhnpo6IMsSBrs6RlAr8oQJvN
         ILnMiJ74oPId4JBewLty3GGBrXPCtIrcCJtT0FlsHlhTwxEnbv/CVyWsmM645dQutLKZ
         6Xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728894647; x=1729499447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Zp8WLi7DGJx+e84KGtKjrVedsMWIQpQqNPQAsDX7M8=;
        b=mSVwCa5kKaluFlRf59oRmIj5bT19wHdrvW4K7IjFVY7n3nX/Mdvy6U1v/73terIHm5
         BvveAT/hH+uyN3HenqIjRtp49RkoijxWgcdWQ9Oo+KI/1jG1mYy9pSfdBghKEu+vNuGD
         xuN8amCuU2lJhP1LJMvBf/cHq5coSV1Bi9POOwSfe8H8sQDZZJzwfgkXoM0P22THC7gn
         jPXh5ABK+c8NNUtZbjGktjEa1u1JRtsOk2X9D67jknLNLhT3Gwr9F9+v3MpfHyWTNtT8
         wjXR+3OegzaTAv1RAd07rxPI4Zbs5gV5BYjX+KUhopHX3TrtjMJiCgZDrNlXEjOCILMV
         J3vw==
X-Forwarded-Encrypted: i=1; AJvYcCUidY6HXIHLRnHztvlm9qROfVyBRJu/pEMRHZEx8hFNr229S/t3epAl05z08MyqZ5vpxT0OhfoJ/7x9DrQybK/I@vger.kernel.org
X-Gm-Message-State: AOJu0YzO2reQs1rgDlOnbkybjIGVXdUvsxBlqGMSyUQXYWcquSCoQmbh
	tK23nkt0yZcaxGemJTJ2vrou/UmazqzxAJj4z0xdgqbl3VHdv7Xb0WQKNMX/yuWojn1ZXOz7DI2
	4fMqR+TEQAZ6RT7pyEyxMXRaKarp1dpUD1Rwi
X-Google-Smtp-Source: AGHT+IHavC14X/E0AoU7HQMbC/VV9BE7wlcw5cUAbgYL5XITdprDX9nD24jZVy3VIu7QW5852bqN6ZxBjm54AB5gttw=
X-Received: by 2002:a2e:702:0:b0:2fa:d67a:ada7 with SMTP id
 38308e7fff4ca-2fb3f1b764amr23927741fa.23.1728894646902; Mon, 14 Oct 2024
 01:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <670cb595.050a0220.4cbc0.0043.GAE@google.com>
In-Reply-To: <670cb595.050a0220.4cbc0.0043.GAE@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 14 Oct 2024 10:30:35 +0200
Message-ID: <CACT4Y+ZQzOQZqGZ17KsPmsTNTtZx1k8iQDdpggdEhBqoWBo3qg@mail.gmail.com>
Subject: Re: [syzbot] [perf?] KCSAN: data-race in _free_event /
 perf_pending_task (2)
To: syzbot <syzbot+e75157f5b04f8ff40e17@syzkaller.appspotmail.com>, 
	Marco Elver <elver@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 08:09, syzbot
<syzbot+e75157f5b04f8ff40e17@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    87d6aab2389e Merge tag 'for_linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10104f9f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a2f7ae2f221e9eae
> dashboard link: https://syzkaller.appspot.com/bug?extid=e75157f5b04f8ff40e17
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cce40536bdc3/disk-87d6aab2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/479edc06c8d8/vmlinux-87d6aab2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9d377c65ffca/bzImage-87d6aab2.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e75157f5b04f8ff40e17@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in _free_event / perf_pending_task
>
> write to 0xffff8881155361e8 of 4 bytes by task 9574 on cpu 1:
>  perf_pending_task+0xe8/0x220 kernel/events/core.c:6976
>  task_work_run+0x13a/0x1a0 kernel/task_work.c:228
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
>  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff8881155361e8 of 4 bytes by task 9573 on cpu 0:
>  perf_pending_task_sync kernel/events/core.c:5302 [inline]

+Marco, IIRC we assumed event->pending_work should only be accessed by
the owner task.
Here it's concurrently modified/changed. The other task calls
task_work_cancel on current based on the valus of this field, this
looks bad.

>  _free_event+0x3d/0xa10 kernel/events/core.c:5326
>  put_event kernel/events/core.c:5454 [inline]
>  perf_event_release_kernel+0x61a/0x670 kernel/events/core.c:5579
>  perf_release+0x1f/0x30 kernel/events/core.c:5589
>  __fput+0x17a/0x6d0 fs/file_table.c:431
>  ____fput+0x1c/0x30 fs/file_table.c:459
>  task_work_run+0x13a/0x1a0 kernel/task_work.c:228
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
>  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x7ad100bf -> 0x00000000
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 9573 Comm: syz.3.2265 Tainted: G        W          6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
> Tainted: [W]=WARN
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/670cb595.050a0220.4cbc0.0043.GAE%40google.com.
