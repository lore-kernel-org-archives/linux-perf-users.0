Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2289326E658
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684034; cv=none; b=Dqr8iXJPfIYm2d8VP9rtneBLp0oo6xhzC+xq+BaoxTritgvLg9ZB3yQMFWXJSMPnDhUb2Al/rDb8TGj6Moeyl0eqn4jJDGKFJUVA9CzmxlyB6sxADfPjNXe/tprbesMhn1uOLgZYiwQgX09MadTNIbfDvUNdg5pq9ZNAVcxDjJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684034; c=relaxed/simple;
	bh=muK8R3PeeACTdWi+w57NbgOslHk1vi9AUhjFPQAv4zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hy53VlZxmFrTLB0nFeH83tr3ja+pVTF5DjnBXdgquMGsAWd/KQ5sz6IZ7jrnzCjnE1Xr82iukUiQ2yuhOv9qf1Af4ZWBDolYYJORtPgqbpvz9iwqeVxDzluP3UwrENwU96K9ByBPf7yIZV163xTsx0l0ntY3fTovUo9c3vySurc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4phlsC9p; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4phlsC9p"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abbdf897503so425970166b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 11:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740684030; x=1741288830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI22PJCjE69u15jcF6DMx11ran9huIwFOHAPNY3ci2c=;
        b=4phlsC9pVgM98GF5mIqwNtcI6haaDGJDKfizpwwlXoN9o737UEiMH229exg4pqNNnB
         FtdCFObtPQIPHErw3O69ZlIYBxWS0kps2c+3UKqBRc+WEdGWB4NyCfG75u1DiVBi5XBg
         D0Ge78gHES9684cTEPxfSvD+3xNDd5mWjhGk0F2PvkNCgQL7JMj9otBSZTSXbdbeQcAr
         M7U5JOmQxPs9/nMmGKQ8yHqUw2USo3R8gddJwu8+rwDC6K01yvtPIBD78aVToOyqawVA
         uqf5pON2CF9R7iEK/YwtY+tbRy1mSVunm3jJWmf6Wl7P97DzjUrMb7LCwpAucS8xhHiv
         gEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740684030; x=1741288830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OI22PJCjE69u15jcF6DMx11ran9huIwFOHAPNY3ci2c=;
        b=Sf5CD1eGOe2CAlU+PWus79KbduXQI/7gz19aucawv9UXOomdGh2SWPTzVg1aKx7P3M
         RFTPzY+ALnbissaRChG6CasHtUuCKecVh58oVoqaDyn619znyw9HGN22nEungNHww83U
         77+rk6L0PseA7XBHE47Q1Re5w/7TdJpfmI2hvvU31QeZjiUtxR+RbkaQu9/cijF9WtVU
         Ja+DA3UYMzA9YoKBJ+DuwqgfvS0zVu4IlgIRWcQRwQmQbwK3eJmfgMlQtcKmqNlA6Ta4
         xfAI3nJUS63BG5QhAuM7ldZD6cpZKiOzf8nMV+S0105Iyw9kXIxCX1rjg7gMuP05ZAmF
         GU+w==
X-Forwarded-Encrypted: i=1; AJvYcCXIalbaL8S9mfIQ5toUdkL3xgWS21w5ov0BrONzhOqJn/P1fu27/pyOmrZDPdSRUuCJJaSqVc7vtplXOFTeJhKJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw01049RD0AaLErKzgeuf72C5YIrRP1tT0V6/ta7sBKnh70D+vb
	G87RUVBdbKAmq3ATMO8aXaVaRl4dN5obMtY1GFWQDW4ZEEs7o7Qiwxe9UPcNPpLVcvGuceLIfpj
	Fr1fThqilV1IiKw5B83jAZrEnKXG8FFnePS2d
X-Gm-Gg: ASbGnctEEoObqkdlXJvT7Deub1iJt1F96n0oVtOmBca0CHkmXoym28XJVpYR77iqp+D
	UaDD19Q6iYPdBT2pUUccl1ESW2esyj/v+3DoQliBGRDcbKvLAggm8BvuLo5OH0u6gLQOiRJJA2S
	OtJhcOwkg+00Pbi1O7gt7g+0lKFvsdXt/dKXzNKRo=
X-Google-Smtp-Source: AGHT+IGAaEwnUOTxtjRJRgNU0Z7h1s0Z2DCfs0P6hAUc2eXS3R+/ssd58Ppp0FCTMZtMZ97KafEUW2W/8pRABGN1kAA=
X-Received: by 2002:a17:907:9723:b0:ab7:ca6d:171e with SMTP id
 a640c23a62f3a-abf2642f5d4mr62483366b.7.1740684030160; Thu, 27 Feb 2025
 11:20:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227003359.732948-1-ctshao@google.com> <EB79B75A-896E-42B6-B206-314BA137E257@linux.ibm.com>
In-Reply-To: <EB79B75A-896E-42B6-B206-314BA137E257@linux.ibm.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Thu, 27 Feb 2025 11:20:18 -0800
X-Gm-Features: AQ5f1JqstDaQClrlkYVyUTD4KjucpdQq68IUyRhBPNfGp0EuxpQ4ZtKJXQSNAj0
Message-ID: <CAJpZYjUvaXfmvMH5FjpAUSj4EiEgbMd4CyOobPXKoDhpzknvJQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Tracing contention lock owner call stack
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, nick.forrington@arm.com, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Athira!

On Thu, Feb 27, 2025 at 3:11=E2=80=AFAM Athira Rajeev <atrajeev@linux.ibm.c=
om> wrote:
>
>
>
> > On 27 Feb 2025, at 5:58=E2=80=AFAM, Chun-Tse Shao <ctshao@google.com> w=
rote:
> >
> > For perf lock contention, the current owner tracking (-o option) only
> > works with per-thread mode (-t option). Enabling call stack mode for
> > owner can be useful for diagnosing why a system running slow in
> > lock contention.
> >
> > Example output:
> >  $ sudo ~/linux/tools/perf/perf lock con -abvo -Y mutex -E16 perf bench=
 sched pipe
> >   ...
> >   contended   total wait     max wait     avg wait         type   calle=
r
> >
> >         171      1.55 ms     20.26 us      9.06 us        mutex   pipe_=
read+0x57
> >                          0xffffffffac6318e7  pipe_read+0x57
> >                          0xffffffffac623862  vfs_read+0x332
> >                          0xffffffffac62434b  ksys_read+0xbb
> >                          0xfffffffface604b2  do_syscall_64+0x82
> >                          0xffffffffad00012f  entry_SYSCALL_64_after_hwf=
rame+0x76
> >          36    193.71 us     15.27 us      5.38 us        mutex   pipe_=
write+0x50
> >                          0xffffffffac631ee0  pipe_write+0x50
> >                          0xffffffffac6241db  vfs_write+0x3bb
> >                          0xffffffffac6244ab  ksys_write+0xbb
> >                          0xfffffffface604b2  do_syscall_64+0x82
> >                          0xffffffffad00012f  entry_SYSCALL_64_after_hwf=
rame+0x76
> >           4     51.22 us     16.47 us     12.80 us        mutex   do_ep=
oll_wait+0x24d
> >                          0xffffffffac691f0d  do_epoll_wait+0x24d
> >                          0xffffffffac69249b  do_epoll_pwait.part.0+0xb
> >                          0xffffffffac693ba5  __x64_sys_epoll_pwait+0x95
> >                          0xfffffffface604b2  do_syscall_64+0x82
> >                          0xffffffffad00012f  entry_SYSCALL_64_after_hwf=
rame+0x76
> >           2     20.88 us     11.95 us     10.44 us        mutex   do_ep=
oll_wait+0x24d
> >                          0xffffffffac691f0d  do_epoll_wait+0x24d
> >                          0xffffffffac693943  __x64_sys_epoll_wait+0x73
> >                          0xfffffffface604b2  do_syscall_64+0x82
> >                          0xffffffffad00012f  entry_SYSCALL_64_after_hwf=
rame+0x76
> >           1      7.33 us      7.33 us      7.33 us        mutex   do_ep=
oll_ctl+0x6c1
> >                          0xffffffffac692e01  do_epoll_ctl+0x6c1
> >                          0xffffffffac6937e0  __x64_sys_epoll_ctl+0x70
> >                          0xfffffffface604b2  do_syscall_64+0x82
> >                          0xffffffffad00012f  entry_SYSCALL_64_after_hwf=
rame+0x76
> >           1      6.64 us      6.64 us      6.64 us        mutex   do_ep=
oll_ctl+0x3d4
> >                          0xffffffffac692b14  do_epoll_ctl+0x3d4
> >                          0xffffffffac6937e0  __x64_sys_epoll_ctl+0x70
> >                          0xfffffffface604b2  do_syscall_64+0x82
> >                          0xffffffffad00012f  entry_SYSCALL_64_after_hwf=
rame+0x76
> >
> >  =3D=3D=3D owner stack trace =3D=3D=3D
> >
> >           3     31.24 us     15.27 us     10.41 us        mutex   pipe_=
read+0x348
> >                          0xffffffffac631bd8  pipe_read+0x348
> >                          0xffffffffac623862  vfs_read+0x332
> >                          0xffffffffac62434b  ksys_read+0xbb
> >                          0xfffffffface604b2  do_syscall_64+0x82
> >                          0xffffffffad00012f  entry_SYSCALL_64_after_hwf=
rame+0x76
> >  ...
> >
> > v8:
> >  Fix compilation error found by Athira Rajeev and Namhyung Kim.
>
> Tested with v8 and compiles fine, thanks for addressing the issue.
>
> Tested-by: Athira Rajeev <atrajeev@linux.ibm.com>
>
> >
> > v7: lore.kernel.org/20250224184742.4144931-1-ctshao@google.com
> >  Remove duplicate contention records.
> >
> > v6: lore.kernel.org/20250219214400.3317548-1-ctshao@google.com
> >  Free allocated memory in error patch.
> >  Add description in man page.
> >
> > v5: lore.kernel.org/20250212222859.2086080-1-ctshao@google.com
> >  Move duplicated code into function.
> >  Remove code to retrieve undesired callstack at the end of `contention_=
end()`.
> >  Other minor fix based on Namhyung's review.
> >
> > v4: lore.kernel.org/20250130052510.860318-1-ctshao@google.com
> >  Use `__sync_fetch_and_add()` to generate owner stackid automatically.
> >  Use `__sync_fetch_and_add(..., -1)` to workaround compiler error from
> >    `__sync_fetch_and_sub()`
> >  Remove unnecessary include headers.
> >  Dedicate on C-style comment.
> >  Other minor fix based on Namhyung's review.
> >
> > v3: lore.kernel.org/20250129001905.619859-1-ctshao@google.com
> >  Rename/shorten multiple variables.
> >  Implement owner stackid.
> >  Add description for lock function return code in `contention_end()`.
> >  Other minor fix based on Namhyung's review.
> >
> > v2: lore.kernel.org/20250113052220.2105645-1-ctshao@google.com
> >  Fix logic deficit in v1 patch 2/4.
> >
> > v1: lore.kernel.org/20250110051346.1507178-1-ctshao@google.com
> >
> > Chun-Tse Shao (4):
> >  perf lock: Add bpf maps for owner stack tracing
> >  perf lock: Retrieve owner callstack in bpf program
> >  perf lock: Make rb_tree helper functions generic
> >  perf lock: Report owner stack in usermode
> >
> > tools/perf/Documentation/perf-lock.txt        |   5 +-
> > tools/perf/builtin-lock.c                     |  56 +++-
> > tools/perf/util/bpf_lock_contention.c         |  85 +++++-
> > .../perf/util/bpf_skel/lock_contention.bpf.c  | 245 +++++++++++++++++-
> > tools/perf/util/bpf_skel/lock_data.h          |   7 +
> > tools/perf/util/lock-contention.h             |   7 +
> > 6 files changed, 372 insertions(+), 33 deletions(-)
> >
> > --
> > 2.48.1.658.g4767266eb4-goog
> >
> >
>
