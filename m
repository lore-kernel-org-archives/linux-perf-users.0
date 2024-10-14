Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC7C15697B
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898863; cv=none; b=eiWtkLqzL0bE0YTrG1MMcJ2M516CzVrnv57Ud5pOAY48fhJwC67dUQ8CI0FtgbLm0eKeqT9LNbrOPJbLB7F66Z702QkDZytyUW8s9Ayl1H0PPbFFPcNLiQO4AUofKGYb5IeXXPsrH2p3HjO/Hd1BC0KCKT/NLCjnGvEk32oSl50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898863; c=relaxed/simple;
	bh=7iBaXX3hsoGbDfO3EgnPA3gsM6qXWt169yOiJnYahDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xjy/8d3h02RylLtBFoT5yZA4ZvuNrzP2ABQj6PA6VGJm1kqUc3VlnBZbh8Ch+9dEjhx/RsYZM7qfgJNcGyH3vTiOQo9J+zwm0xWHu/O7Rckz4O/9gN9apv4tUMqFFZVyK9xSj6lKPuFmP1Gw9xyUv2pYEbEi+IfLkwHThG1tmyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dqvPFORE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dqvPFORE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c805a0753so32910385ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 02:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728898861; x=1729503661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FsjHjApHcN49dporjlCFgxa8mU/tCA7QE7zQPAQRHmI=;
        b=dqvPFOREiIK/wf+AkwkOwyu4aq/9EH1yELCNvTWlyYCUU9VNW6tI2rLGGTh5vHtWw4
         IeWXZjUB2D7Lyef8CsAnhRA0lkqDKGhZ860myR00lMnp1t7Qqkmv6Ej5yynwWOxo/iGY
         xaqiQb1sGDdiYA8JYZrgrEUvtpLgg/GbGs6wjdJRHRyk8Brsp6Oamhz4CnaMQwQ8cCXu
         dUp17NlPii0f/5arx3+dpymbKdZE7HEzlY/CTYCBhn6QJoKkE9MxRv9MFyj6LSfLxSDh
         LNcm4xG74+e4lwuYXakaB8O2Z9D9Qcd6FtCxeE4RMYkHb2hZ+VHYFXVpWuwl321HMIoV
         PjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898861; x=1729503661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsjHjApHcN49dporjlCFgxa8mU/tCA7QE7zQPAQRHmI=;
        b=kBUyIfCbqJIE3NQ1f8VMNp5wJOkXWhZLZzvKDX1equ19idz8XX7+60eePclyrMYP0E
         Kd649r0WQ7zBCM2+easItY2zzOUs3Kno3aKmVI6kRppkc2oV4fYdxtDsDh6gomIpjtll
         uM3s33faAieFkYCNKvJQP1VTTj5rVW4up/KoJjtxuwimPS2T6ZI8/zOcXmUj9uSLU70L
         +tb4S6ihMyEgloFh78iS+0HJwYi8Bi7aNUEILDg/uQSLSg0uyiKzTZayV3R+zuDSz8Xs
         soFteTVdWy8arlf709M9jvjfI6oUfPRmM3zKk77tlbN8W8MbkB1ZmNCGf4HojfFxVuCM
         eXjw==
X-Forwarded-Encrypted: i=1; AJvYcCXAxEQX2jH8ktS0M+yPL0ZP1Nf6nKm8DIitEn3c2UcLBJ7HDDUeywsJ1MURJgA1yRquaaqx+zFmIWPYtp1LlrJO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7veaLNjMI6oDoZnoexk7DK6ltnPH3gEsCSzHabsUShBzUgGvu
	iyv6mq4ZGVCAb8WfJkWnuM9O2bIHZi59WlypW2Muw5x4FiorGl+wCIxxt9k84JiTg8f6RqKb53f
	PqW3HkisbyyGnY8z3FuSVtpCcz2JNI4D8xkEQ
X-Google-Smtp-Source: AGHT+IF4L5Hd3fangx/44ARAUSu080w1slVh6TANg3o3P7Lj3N2sFofhu5NjvupF9SW2g/VvW2ZpNqr84DuYhdqHV+M=
X-Received: by 2002:a17:90b:3bc6:b0:2e0:8740:26d0 with SMTP id
 98e67ed59e1d1-2e2f09ee044mr13110157a91.2.1728898860787; Mon, 14 Oct 2024
 02:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <670cb595.050a0220.4cbc0.0043.GAE@google.com> <CACT4Y+ZQzOQZqGZ17KsPmsTNTtZx1k8iQDdpggdEhBqoWBo3qg@mail.gmail.com>
In-Reply-To: <CACT4Y+ZQzOQZqGZ17KsPmsTNTtZx1k8iQDdpggdEhBqoWBo3qg@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Mon, 14 Oct 2024 11:40:23 +0200
Message-ID: <CANpmjNP=7q2aX2O5_HVLvW9PnqAM79FpN-Oer-TbG_rAz5B5kA@mail.gmail.com>
Subject: Re: [syzbot] [perf?] KCSAN: data-race in _free_event /
 perf_pending_task (2)
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+e75157f5b04f8ff40e17@syzkaller.appspotmail.com>, acme@kernel.org, 
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	irogers@google.com, jolsa@kernel.org, kan.liang@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 10:30, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, 14 Oct 2024 at 08:09, syzbot
> <syzbot+e75157f5b04f8ff40e17@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    87d6aab2389e Merge tag 'for_linus' of git://git.kernel.org..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10104f9f980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a2f7ae2f221e9eae
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e75157f5b04f8ff40e17
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/cce40536bdc3/disk-87d6aab2.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/479edc06c8d8/vmlinux-87d6aab2.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/9d377c65ffca/bzImage-87d6aab2.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+e75157f5b04f8ff40e17@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in _free_event / perf_pending_task
> >
> > write to 0xffff8881155361e8 of 4 bytes by task 9574 on cpu 1:
> >  perf_pending_task+0xe8/0x220 kernel/events/core.c:6976
> >  task_work_run+0x13a/0x1a0 kernel/task_work.c:228
> >  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
> >  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
> >  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
> >  syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
> >  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > read to 0xffff8881155361e8 of 4 bytes by task 9573 on cpu 0:
> >  perf_pending_task_sync kernel/events/core.c:5302 [inline]
>
> +Marco, IIRC we assumed event->pending_work should only be accessed by
> the owner task.
> Here it's concurrently modified/changed. The other task calls
> task_work_cancel on current based on the valus of this field, this
> looks bad.

On freeing an event it can be any other task, AFAIK. There's this comment:

> * All accesses related to the event are within the same RCU section in
> * perf_pending_task(). The RCU grace period before the event is freed
> * will make sure all those accesses are complete by then.

So there is no risk of UAF.

All that may happen is that on concurrent free of an event with a
pending SIGTRAP, it's possible the SIGTRAP may or may not be
delivered. But I think that's perfectly reasonable if the event is in
the process of being closed.

Did I miss something?

Thanks,
-- Marco
