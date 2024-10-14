Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D86E1527BB
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728901852; cv=none; b=YFA+a4cb85l9/kjl7FJRcHIDD3mVF1XZ9lDJ05mMD7hDkoaHsXz2hGAxC7qNzHTr2kmcjIYgdvpnWCrK//AlOvpHjpTrIzPY94l1OHppdnTB/bZtktQPSqCbUctNlPlDpOfD7rbT7D/H9anIXQ1OReh6MlAggcEtYe6SylBwKqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728901852; c=relaxed/simple;
	bh=rpvuXrvRr4//uCUvY95pj2LgNDIGGKmQHBnPsBpGWZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8mMwXnBB5h0p3i8tHz3uEEiP7qOO4CRbFxrGcsCEYmLwD0ogTbRhno35FO3BcwTZUGYmj5YWasupedLrKSzNfcmSkbtjtRTdimiUBvhxuiz5Nd5A1MRiUMPa/JvhZ/yQz0VE8bddV3f8s7UfyScSauboRsVxM+Yck+n0ZVuA+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=REEWkd0b; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="REEWkd0b"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb56cb61baso2283841fa.1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 03:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728901849; x=1729506649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3j3CT4e29Wa6bMmt4qsURtu3xAM86L4gd5WtQj9z6/8=;
        b=REEWkd0bFen9APfRcMFgV3vnpLlyTHmo6fX4yqiJksHIgdpa/V6U/r1UVc7LBt5YRp
         wHBzHVS2bpS/4ynWqj3N4uD9Y2EXEg/7G6VOuTkl61NgJoG3A1R7UGhKJa0WWcYaXo4X
         uURgaFpCWjmuvtNpaVaj3jq5KXgLaemWJIvF5aBVj0QM1LwPs2eNhOI4U73zpkwNUCZz
         8NKhG+LejKZkcrEyL8CYTcJYWxmsZT05BpJASM44NAOOHk/nkTgIKl/q+EoWcFIWj7kt
         SSb/ZWHWmQ2HJ6drrcFlV8H0THagnNhbYe1OACNpUAoEUrVzqUwMe5/CipX7XmFpE8Jf
         K0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728901849; x=1729506649;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3j3CT4e29Wa6bMmt4qsURtu3xAM86L4gd5WtQj9z6/8=;
        b=hy6jiBE+35qq+DiyfzF1KJakC86dFvtMWsk9GNMrclSMo55bcpUMCMaarmzaiF7geD
         0raC0LnNXMzDF2vTBjFEO8swy+s+6UophDwBIkOJEnp2Xy2uyIcN94JtC5H0QeX9tErZ
         St9IWqKuB6+NJxwKqPouIENnf2r+ws8W/C+L4oLDls0G1D1mXn78gfMPJD8+zMREUu7X
         srTXar3k9VwN9a4VJkFJDIlUXdW5dSgn5E0bJAyq+XFUle9V/sHHK+cdWVj2Ya7+0Fcj
         sYW/OxnNfI9Ofm6R76pa3YN2HdbM3fj9dq/PZmzxkPH3xS3sbcQ4/Zr2Pbm0YwFtUpT2
         PeKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj8rFhwns3X8qcnaZpSs512WQDFSqqgSor1ytMzNX+eso7nyFTrvkRtodqxp2gZBwv/FqVDqlUpcHXDfzr3n7F@vger.kernel.org
X-Gm-Message-State: AOJu0YzqtazWzA4/0lJl6vte5S5Fie3frQFHBNKDgaX5U3LrMWDI5Cof
	BSIh43i2EluCCGfDhvepCMweC9qGZN4B7i8PfBvYSlI10OGOFVfxBHWtCMXqpfEcUxJ2c3mqs9G
	2Cqg9L6K/L6rPjdhHi7rKQM8JS9H8IwnyDfos7bF0vIr1YCZFVHv2
X-Google-Smtp-Source: AGHT+IEOvjYTiW2P+zWYcakBgwi8n5DXV1DD1oHdg2+1AAtihEHUYlZTYNfLwQ6CzrBLwsP/b0tN6awt89vNby1H9jQ=
X-Received: by 2002:a05:651c:1990:b0:2fb:4f0c:e3d8 with SMTP id
 38308e7fff4ca-2fb4f0cea31mr12438521fa.27.1728901848500; Mon, 14 Oct 2024
 03:30:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <670cb595.050a0220.4cbc0.0043.GAE@google.com> <CACT4Y+ZQzOQZqGZ17KsPmsTNTtZx1k8iQDdpggdEhBqoWBo3qg@mail.gmail.com>
 <CANpmjNP=7q2aX2O5_HVLvW9PnqAM79FpN-Oer-TbG_rAz5B5kA@mail.gmail.com>
In-Reply-To: <CANpmjNP=7q2aX2O5_HVLvW9PnqAM79FpN-Oer-TbG_rAz5B5kA@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 14 Oct 2024 12:30:37 +0200
Message-ID: <CACT4Y+asVHVjKSC3YxwdeoAwxhWzp1K7hU4spdxQjN==N34+eQ@mail.gmail.com>
Subject: Re: [syzbot] [perf?] KCSAN: data-race in _free_event /
 perf_pending_task (2)
To: Marco Elver <elver@google.com>
Cc: syzbot <syzbot+e75157f5b04f8ff40e17@syzkaller.appspotmail.com>, acme@kernel.org, 
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	irogers@google.com, jolsa@kernel.org, kan.liang@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 11:41, Marco Elver <elver@google.com> wrote:
>
> On Mon, 14 Oct 2024 at 10:30, Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Mon, 14 Oct 2024 at 08:09, syzbot
> > <syzbot+e75157f5b04f8ff40e17@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    87d6aab2389e Merge tag 'for_linus' of git://git.kernel.org..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=10104f9f980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a2f7ae2f221e9eae
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=e75157f5b04f8ff40e17
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/cce40536bdc3/disk-87d6aab2.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/479edc06c8d8/vmlinux-87d6aab2.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/9d377c65ffca/bzImage-87d6aab2.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+e75157f5b04f8ff40e17@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KCSAN: data-race in _free_event / perf_pending_task
> > >
> > > write to 0xffff8881155361e8 of 4 bytes by task 9574 on cpu 1:
> > >  perf_pending_task+0xe8/0x220 kernel/events/core.c:6976
> > >  task_work_run+0x13a/0x1a0 kernel/task_work.c:228
> > >  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
> > >  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
> > >  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
> > >  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
> > >  syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
> > >  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > read to 0xffff8881155361e8 of 4 bytes by task 9573 on cpu 0:
> > >  perf_pending_task_sync kernel/events/core.c:5302 [inline]
> >
> > +Marco, IIRC we assumed event->pending_work should only be accessed by
> > the owner task.
> > Here it's concurrently modified/changed. The other task calls
> > task_work_cancel on current based on the valus of this field, this
> > looks bad.
>
> On freeing an event it can be any other task, AFAIK. There's this comment:
>
> > * All accesses related to the event are within the same RCU section in
> > * perf_pending_task(). The RCU grace period before the event is freed
> > * will make sure all those accesses are complete by then.
>
> So there is no risk of UAF.
>
> All that may happen is that on concurrent free of an event with a
> pending SIGTRAP, it's possible the SIGTRAP may or may not be
> delivered. But I think that's perfectly reasonable if the event is in
> the process of being closed.
>
> Did I miss something?

I have not recap all logic, but what looked suspicious on the first glance:

The task doing _free_event->perf_pending_task_sync is not the owner of
the event (the other task is the owner?).

But that task is later using 'current' to do something with regard to
this event:

/*
* If the task is queued to the current task's queue, we
* obviously can't wait for it to complete. Simply cancel it.
*/
if (task_work_cancel(current, head)) {

Is this current wrong here? So it may both not cancel it for the real
owner, and cancel something else for itself (?).
