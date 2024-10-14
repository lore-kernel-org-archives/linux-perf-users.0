Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E211A0726
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728909769; cv=none; b=m6Hn10c8MLoGFvpOVu5bBwx2jJ749BPs2z8DINZK1Nzo5/GhUWDUqs9nwgMF8oBs2jas82E16XFJpW1wKHwNUXrty9svXzCXiQi4HhCRnYW2CxHeLtiU9/DhUixpQjFL+r8RY8vGKH76v/wtUdiYtRc+WUA/EIhHecEg2Ok8BdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728909769; c=relaxed/simple;
	bh=gJGl+8wX1EZ9yO8oCw96wVlkUots97NzABVWJYyJnq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nS5s4cPvzXp79nnr1/m9GAPLGSJhLAu+er7Y7Ob5pC4Y8086vp2fXJzY6mbOBDnPYaFutjxDQtQOWs5LR0PKuVdKsxkcgytaPODDSy97gqOgsF9dIs9yeau3IM5r9fp79ryGomqP4xzOj+zdfiDKPLKX2vyYvE3c4K69uP/0KKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Enr1Xx8T; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Enr1Xx8T"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c805a0753so34265335ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 05:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728909768; x=1729514568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gJGl+8wX1EZ9yO8oCw96wVlkUots97NzABVWJYyJnq0=;
        b=Enr1Xx8TBkG2p30Cp+qpmEyzShsjfQJpRR/Bfwot3q+GNOPkDoyxyOwsmU7f6qCltS
         0ItpdrmqEPDXc1ht4ylz0F0F4gQWNu0ZRVVa8XSM+6TqK51d1cyyXXqNv6xKaQh9M9em
         xooX5HkaGJVZl45yjAZsnOM4RjJIH6EeuxgISXY6NfYzgUcjshPy//kn/qE9wS0D4yGp
         f8CQmhvgmrnqxBA9pM7v8rI3KTAaagaaFmpW9KgJecqo9M2I9/ES7HJZgm8puRSZJgKe
         0ABqHvAPTNkQhh3lHCHoCyAEGAifQ3MN+chS8yKWOHuOnq07LgqsKrND6Bfr9mvKbmfF
         zSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728909768; x=1729514568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJGl+8wX1EZ9yO8oCw96wVlkUots97NzABVWJYyJnq0=;
        b=Vq60YownBciFz5/7ba9CN4sIzJNY2YWPcVBMwz2/dpUhH9N1Gva7bMunMpLeXtIOvG
         1ch9Nf6E+q3E7fWdGahLRWSIHDRKrhuoGzR9FYvWzEz7HzXFE6wLw0Iq3J8/47CiN3MC
         9LKsFuoyHfdFOKLLfRkV8IqTeQD/5S+vq6hmmIvGNJNpdb8botPJJCDheLAy2fYs6mAu
         sFqd/tG5fMGPbHiopfqIGpwH29yP1lQsMncx+dx/W2tS3EYJi8VEcZMb88vvcweOrUt9
         tv2dUfX0TNrcFDQ6hl8vSYx3pblz5PzLMx8z6PM4a6BGn12YmqoE899DlEOawD2ZKie5
         UYHw==
X-Forwarded-Encrypted: i=1; AJvYcCVl2pnjWYCiRnq8HQ63luitbddKGE/lmSGt4IyeyqJ/CkGOvSA4Krx1p0X3/C8Dg/L1DmNshXuFU8uzoS3D8N7o@vger.kernel.org
X-Gm-Message-State: AOJu0YxapT2zitncownlN0p5vK9jCGfPlPSXgYADSyHIW3mXjXsfrN+2
	DyIunASaGeibpkUsEiXw/nPh40My2FrzwNcvB+Fp0qj4uQ0C0yKz29PIJGZ3SfYCB1BuRhaXpnZ
	ddqUBW/KI1RxWnUauKLQHqYe1Hl5+47qFCUVJ
X-Google-Smtp-Source: AGHT+IHqsr/P4FQKdWTxi0rovMGf9JyEsX7S20eZuyXx2VDQ/rgWFXmVREgt+5mWhxTduWqegrfMu+idUtZLsLcHJU0=
X-Received: by 2002:a17:90a:5588:b0:2e2:d3e1:f863 with SMTP id
 98e67ed59e1d1-2e2f0a49376mr13518183a91.12.1728909767291; Mon, 14 Oct 2024
 05:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <670cb595.050a0220.4cbc0.0043.GAE@google.com> <CACT4Y+ZQzOQZqGZ17KsPmsTNTtZx1k8iQDdpggdEhBqoWBo3qg@mail.gmail.com>
 <CANpmjNP=7q2aX2O5_HVLvW9PnqAM79FpN-Oer-TbG_rAz5B5kA@mail.gmail.com> <CACT4Y+asVHVjKSC3YxwdeoAwxhWzp1K7hU4spdxQjN==N34+eQ@mail.gmail.com>
In-Reply-To: <CACT4Y+asVHVjKSC3YxwdeoAwxhWzp1K7hU4spdxQjN==N34+eQ@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Mon, 14 Oct 2024 14:42:07 +0200
Message-ID: <CANpmjNO9LKPvyPaebk8JcGEg5jjkm6iz3x6hPqsRLgOetkzSnA@mail.gmail.com>
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

On Mon, 14 Oct 2024 at 12:30, Dmitry Vyukov <dvyukov@google.com> wrote:
[...]
> But that task is later using 'current' to do something with regard to
> this event:
>
> /*
> * If the task is queued to the current task's queue, we
> * obviously can't wait for it to complete. Simply cancel it.
> */
> if (task_work_cancel(current, head)) {
>
> Is this current wrong here? So it may both not cancel it for the real
> owner, and cancel something else for itself (?).

That's fine - task_work_cancel() looks for the event in the passed
task_struct, and does nothing if not found. If the task_work is owned
by another task, task_work_cancel() will never find a match, and this
is a no-op. The later rcuwait_wait_event() will wait for the task_work
to complete in the other task.
