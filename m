Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD2E2746B;
	Thu, 12 Dec 2024 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733968073; cv=none; b=ua64zChjDr1xfz3ntn1BupBUham85Sst/DrDakttK2U8D6xzJvkxJRdyHkEoEuWLMahtYuuEaA0NFJaRprfSumHw2r6g5XAuRWtUnfN5kHa9eN038vjqKnVY+SZUj4b/X9bVH+Rh+TO/I/dsFU3DcDK1c0jE3QidVlxqjzNdXs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733968073; c=relaxed/simple;
	bh=wUDRX1Cz5nIjftyAqN53Bs8hElIkNN9sDwndPoPkPVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZ8tEhgdEVX+Gi6AgsMNU+GjTkj901WqzyZMUZ4nkgspqBhV5g9iXSnSbgvUIFUbQqAdyoVJZSY/srBOc5+2sFzNDirahv63SmteeSmbQJD0E/L0ZUTyeoicsih8qgwX3mYfqpD6HQvnPuls/ySZ3WHhls33pYdDRdatlUpSVKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llPLJC+H; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llPLJC+H"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6efa5bf5202so813807b3.3;
        Wed, 11 Dec 2024 17:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733968070; x=1734572870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0HtzVwueR5GnNcN4RgYbJNVdlawrGYFmTzkDhMIhmM=;
        b=llPLJC+HAOEXWnlDKjP+cVnpvER9EudIeiQlSRBPSjXP+Lxs8852pp1ZO/joy8V13u
         eifZz+AqG6CibYjiEfz18iLZXlJuSLWrolKj8oR4MfXamJxSyAXjmWc7bjRF80wfqpCI
         2T44fKozDG2Gg4v2Fb+NYSJ4ajX5sBbxFPLsbTfhiz5S2uUMXDjWpNHYTpe69Suy8gV0
         OJf/Lw9IrWBw2jzRj5UPtgPXd3nODkTSfYfH0pi/GS5lgRVCsnebWvLlLvanzBtIpZA5
         BC49mK8+x01TwLAD2siCAiPFaiYKdIlsdgENQl1cln1sFg5h67UPoElNq4FbPsvEkQ2L
         Q7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733968070; x=1734572870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0HtzVwueR5GnNcN4RgYbJNVdlawrGYFmTzkDhMIhmM=;
        b=lvId9wA+ilM1wm+GRARxJpjK+eNxcj2rIwTdAWVk+Lcd47y+3KAJtRgdvqOvwxtJXa
         a76xUr04ZRaQsAVMTYXq+rDoS4yrWh/R70iNL0dac9m9dI+VW2IMeHmtDj4VmR/SIyn0
         Gz8MCySM8jD/jY5+FrBKEI8S0ANmwQ8qHulNfhDZGLM/AlDTkKntnGrlmiHaHpfJPEqY
         nNMR98/2PnEqwqP5cNmTkJc41rfUBPblJ0T+CwR81SXrh3B9lBXjxc8vaMT+kWC/0MHq
         Zaq1KwrREypOyl7MUYSWTIiALoY6J6pbBLB/jLylHuqYuLLYMwhZVX1EPeu22Wl4Mn8R
         96ww==
X-Forwarded-Encrypted: i=1; AJvYcCUFHFxCghUNpfqsBa4GtoKTxtFi/4MUUW5tUHeaPZRkPAWqLCOc/2+ACDwJUoU12fJNjdy0JOfDUJKwWYo=@vger.kernel.org, AJvYcCVmnOoIaYz8yIaLZd7RIwNmrfAGhmfD8LZYrxpwFVdWPULI5Y6jCVCayvUJndXOeXQVuZHfiTK5eWxmn3BliJ143w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOF7gkF5TvS12xRSW16FOBsHijWPxAIIDKgfPuDEmAQJt2tAqg
	IvU+IbRKRR+1Q8DV2jkcqxDioyYXkJyY92CgFHD6l0/XfffIwbXQ8gSkhArBLAMr5S8OZ9634Vr
	oc8/kiH2ihHUYmR9tkIh2Xbk3RpY=
X-Gm-Gg: ASbGnctJlw7Xqd28v0xohNhnixoJCLCAPns9eFwDTIn/6e7tYR7q44G8hip2qYYxKKE
	oBDNIPaWMoYInL+UHMcaE8z+NNyy4YY7Z22As
X-Google-Smtp-Source: AGHT+IHUB22sWR1v4hhXtVGBviLhoQIvBhG8bmkZD08wclx8UPtWzSgvoaoFMyfNFVD71+C2g19KIi98MiobZXO6MtU=
X-Received: by 2002:a05:690c:3501:b0:6ef:58f9:4c0d with SMTP id
 00721157ae682-6f19e871112mr16016857b3.39.1733968070298; Wed, 11 Dec 2024
 17:47:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211222110.2430610-1-namhyung@kernel.org> <Z1oXs1xjCG1Ee27p@x1>
 <CAP-5=fXYke_n7TDe+mB-webNH7vCvea7ZVPqfqygw7bTNd8G3g@mail.gmail.com>
In-Reply-To: <CAP-5=fXYke_n7TDe+mB-webNH7vCvea7ZVPqfqygw7bTNd8G3g@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 11 Dec 2024 17:47:39 -0800
Message-ID: <CAH0uvogs8EAzLemVQXq238KGFXJhD2TBhpXHQUnRYaQtcn_HPQ@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf trace: Add --syscall-period option
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On Wed, Dec 11, 2024 at 5:34=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Dec 11, 2024 at 2:52=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Wed, Dec 11, 2024 at 02:21:10PM -0800, Namhyung Kim wrote:
> > > This option is to implement the event sampling for system calls.
> > > The period is given in msec as it shows the time in msec.
> > >
> > >   # perf trace -C 0 --syscall-period 100 sleep 1
> > >            ? (         ): fleetspeakd/1828559  ... [continued]: futex=
())                                            =3D -1 ETIMEDOUT (Connection=
 timed out)
> > >        0.050 (100.247 ms): gnome-shell/572531 recvmsg(fd: 10<socket:[=
3355761]>, msg: 0x7ffef8b39d20)                =3D 40
> > >      100.357 (100.149 ms): pipewire-pulse/572245 read(fd: 5<anon_inod=
e:[eventfd]>, buf: 0x7ffc0b9dc8f0, count: 8)      =3D 8
> > >      200.553 (100.268 ms): NetworkManager/3424 epoll_wait(epfd: 19<an=
on_inode:[eventpoll]>, events: 0x5607b85bb880, maxevents: 6) =3D 0
> > >      300.876 (         ): mon/4932 poll(ufds: 0x7fa392784df0, nfds: 1=
, timeout_msecs: 100)            ...
> > >      400.901 ( 0.025 ms): TaskCon~ller #/620145 futex(uaddr: 0x7f3fc5=
96fa00, op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
> > >      300.876 (100.123 ms): mon/4932  ... [continued]: poll())        =
                                     =3D 0 (Timeout)
> > >      500.901 ( 0.012 ms): evdefer/2/2335122 futex(uaddr: 0x5640baac51=
98, op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
> > >      602.701 ( 0.017 ms): Compositor/1992200 futex(uaddr: 0x7f1a51dfd=
d40, op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
> > >      705.589 ( 0.017 ms): JS Watchdog/947933 futex(uaddr: 0x7f4cac1d4=
240, op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
> > >      812.667 ( 0.027 ms): fix/1985151 futex(uaddr: 0xc0008f7148, op: =
WAKE|PRIVATE_FLAG, val: 1)             =3D 1
> > >      912.807 ( 0.017 ms): Xorg/572315 setitimer(value: 0x7ffc375d6ba0=
)                                      =3D 0
> > >
> > > The timestamp is kept in a per-cpu array and the allowed task is save=
d
> > > in a hash map.
> >
> > Interesting concept, and one that is done just on the BPF part, so I
> > think we should at least warn a user that is running this on a build
> > without BPF skels.
> >
> > Will try it tomorrow,
> >
> > - Arnaldo
> >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/Documentation/perf-trace.txt       |  6 ++
> > >  tools/perf/builtin-trace.c                    |  5 ++
> > >  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 67 +++++++++++++++++=
+-
> > >  3 files changed, 76 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Doc=
umentation/perf-trace.txt
> > > index 6e0cc50bbc13fc7f..9f338a8c5357a67e 100644
> > > --- a/tools/perf/Documentation/perf-trace.txt
> > > +++ b/tools/perf/Documentation/perf-trace.txt
> > > @@ -241,6 +241,12 @@ the thread executes on the designated CPUs. Defa=
ult is to monitor all CPUs.
> > >       printing using the existing 'perf trace' syscall arg beautifier=
s to map integer
> > >       arguments to strings (pid to comm, syscall id to syscall name, =
etc).
> > >
> > > +--syscall-period::
> > > +     Trace a system call in the given period (in msec).  This implem=
ents
> > > +     sampling for syscalls in order to reduce the monitoring overhea=
d.
> > > +     For example, setting the sysall period to 100 (msec) means it w=
ill
> > > +     sample a syscall and next one after 100 msec.
>
> Is this similar to the -D/--delay option to perf-record? Perhaps share th=
e name?

I think this is more like a throttling for the perf trace output,
instead of a one-time delay or a range of enabled time like -D, as the
prev_ts here is continuously updated. This restricts the maximum
sampling frequency to 1 / syscall-period, meaning every syscall is
sampled just after the syscall-period has passed.

Thanks,
Howard
