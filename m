Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63A418054;
	Mon, 23 Sep 2024 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115481; cv=none; b=gsDp8JkTORgtaCOYWJ1gHUOYPiSPoySw/Nru01nS/FP0UHWYRjKv1nY3O8cGlN3JPIFfN610+T3MnqJ6R21PXLlhpg8w6IqVGwIlrQd8uZIZVHrX4mz048IeN6ygbjmUVoAxx47h3ECYiyIW+POTbDKNnGXVG0aifXOqwgRW5e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115481; c=relaxed/simple;
	bh=OTcgGagByDmAq1xgkKc9MGaM+p/XaNHJCknjP+vYYdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suO5g01eh4XP2EQ/INPtOIENTWGIBSY2DCRZf3+S+grh0BmO9vk16R6No6qk1UKe5NV6Wlmy4K0wM0CcocDojp1jP0ERln55OqlpV8p7m5ShzxMhZxPGuEYLNDCSO9QsMo9JRcZaOi5oNAG75dT9WyXopl+/bytlWLA0mCjS0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfrfJElC; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfrfJElC"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1a74ee4c75so4007532276.3;
        Mon, 23 Sep 2024 11:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727115478; x=1727720278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPHbLsUciMoisbHksOYRgNERxa176twS9ytYk58G1Wk=;
        b=IfrfJElCojcryZo/F51Me82VrcvXkDtCAi/IP9A6rx8wP6VbRElbwgyI7XnuXq/zqJ
         PqDGAxpzYaEntJDMfvq3iZdETO4cwEP6m3NWK7o4xenOz6HkDILpPdzZJaPUoC2GWh0L
         RMKjfnaAGkHzcrUmGPCxkXEX/GDTX7GrFj1QykjA3qTa5VU7Hi58tYxjLJI5acbvE/3a
         jJBteva6SHg87DZ6M2OyeAAbU0u6/djbqQNqt06rdRSWfoDzzn0JMaUIIQm/+DPN2nQ+
         BcjAAm5oFMVIVqfi6afHXOHIPymqB+kxl38SuAjSl6YsK07qiHOtl1W97kLhbEaqKNBP
         Bt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727115478; x=1727720278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPHbLsUciMoisbHksOYRgNERxa176twS9ytYk58G1Wk=;
        b=YxXJtvzbGaJE97pjqAH4oU1+QRgQWR8vMxmAsKqjX+NMyykio2eryaBwU1m6yHkbKy
         Va+7w4o019vaG3d2qY54GHiFy5jlRtOyhrSStBR29LWfd+WU4LXN400H0LsbMm2SMJGE
         k1ODfygmybFjPoFdyrfVnvhmqrSvuhZZ67n/pg57edMVCkt7S1hHEtVU9sKimquEwMI9
         7JBAYcjknTTqVk0ZqDAtOYCFgvEEqgRIbiNpL3sLlLU8EATy/dP2immltUoRQw6CAlAy
         ZDea997zd3ivMW2UlZpeD2j4m7ASQCjQj9MbxNdSc5E95Jtz+C9EDwAGhAsKa52Z7Bk/
         B1NA==
X-Forwarded-Encrypted: i=1; AJvYcCVs6TdGwC+WJM63SWTvhNB9zaUwcJQHLSogmgYh4V2x+Z7JdySXRnRsPlqK/gLVCDROfNotUhUE8P8jbXU=@vger.kernel.org, AJvYcCWzWMLYDQvz71ioaDZsTIF1/FxMA2n3Qm9WxYVQHUELDddBw9jCE94bYTel8iFxZBHK8/tbPtOnLC0kviRgdWN9BA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVOnEiGg2y7YWVa5H4t0Gn54B8me8arGG7BaThxgwTW3V9cEtD
	13l595CAqJSIGiuETP32YDwtUka/dkBQjwfIbNjRzdDJhiW73jNqPWn/oY4q9J7GgH0ZkrqQdHW
	2bMY8sePf633qYFy+txw7U44TQbw=
X-Google-Smtp-Source: AGHT+IGGBMpMk5WqgdtJ2P5UcHz1zogtkgDfh7kuG9kbQZ/sMKxhVDgz0PYoDDwbzVf5Ieg7v/+oMB3gwNabGBP8tNI=
X-Received: by 2002:a05:6902:c0a:b0:e16:5177:7598 with SMTP id
 3f1490d57ef6-e2250c3bd55mr9524762276.16.1727115477886; Mon, 23 Sep 2024
 11:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuH8qhuZB6mr9JvR@x1> <CAH0uvog5akiwUp+28w5u7+-j_fYvQLWahJ6YvEzWjdCz3Ky9Wg@mail.gmail.com>
 <CAH0uvoj_2An0QQgCSenZiK8XubS=amyrxhAWK7ragAFfi+Hnqg@mail.gmail.com> <8ad3ada6-f719-43ca-bf16-0095be555302@oracle.com>
In-Reply-To: <8ad3ada6-f719-43ca-bf16-0095be555302@oracle.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 23 Sep 2024 11:17:47 -0700
Message-ID: <CAH0uvohqECsYgCkJKop6ubv3iOpRGEUyj7=LXLfJobisdMKfcw@mail.gmail.com>
Subject: Re: perf trace: substruct BTF based pretty printing
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Alan,

On Mon, Sep 23, 2024 at 10:48=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 23/09/2024 18:42, Howard Chu wrote:
> > Hello,
> >
> > On Wed, Sep 11, 2024 at 6:29=E2=80=AFPM Howard Chu <howardchu95@gmail.c=
om> wrote:
> >>
> >> Hello Arnaldo,
> >>
> >> On Wed, Sep 11, 2024 at 1:25=E2=80=AFPM Arnaldo Carvalho de Melo
> >> <acme@kernel.org> wrote:
> >>>
> >>> Hi Howard,
> >>>
> >>>         Not really a requirement on you to do work, just a some notes=
 to
> >>> add to our discussion/experiment on using BTF to pretty print syscall
> >>> (and tracepoints/whatever) arguments:
> >>>
> >>> root@number:~# perf trace -e setitimer -p 5444 |& head -5
> >>>      0.000 ( 0.017 ms): Xwayland/5444 setitimer(value: (struct __kern=
el_old_itimerval){})                   =3D 0
> >>>      0.050 ( 0.004 ms): Xwayland/5444 setitimer(value: (struct __kern=
el_old_itimerval){})                   =3D 0
> >>>      0.142 ( 0.005 ms): Xwayland/5444 setitimer(value: (struct __kern=
el_old_itimerval){})                   =3D 0
> >>>      0.174 ( 0.004 ms): Xwayland/5444 setitimer(value: (struct __kern=
el_old_itimerval){})                   =3D 0
> >>>      0.293 ( 0.004 ms): Xwayland/5444 setitimer(value: (struct __kern=
el_old_itimerval){})                   =3D 0
> >
> > First of all I bypass the from_user check to make perf trace use BTF
> > output instead of just printing an address:
> >
> >         for (i =3D 0, field =3D sc->args; field; ++i, field =3D field->=
next) {
> >                 // XXX We're only collecting pointer payloads _from_ us=
er space
> >                 /*if (!sc->arg_fmt[i].from_user)*/
> >                         /*continue;*/
> >
> > Got the bad output:
> >
> >    500.218 ( 0.015 ms): a.out/112335 setitimer(value: (struct
> > __kernel_old_itimerval){})                   =3D 0
> >
> > But after switching on emit_zeroes from btf_dump_type_data_opts:
> >
> > dump_data_opts.compact   =3D true;
> > dump_data_opts.skip_names =3D !arg->trace->show_arg_names;
> > dump_data_opts.emit_zeroes =3D true; // this
> >
> > My output is good:
> >
> >  96058.828 ( 0.010 ms): a.out/104347 setitimer(value: (struct
> > __kernel_old_itimerval){.it_interval =3D (struct
> > __kernel_old_timeval){.tv_sec =3D (__kernel_long_t)0,.tv_usec =3D
> > (__kernel_long_t)500000,},.it_value =3D (struct
> > __kernel_old_timeval){.tv_sec =3D (__kernel_long_t)0,.tv_usec =3D
> > (__kernel_long_t)500000,},}) =3D 0
> >
> > So I think this is btf_dump's problem... Because most of the time we
> > want to omit the zeroes, but that will have the side effect of not
> > being able to print the whole output. I'll figure something out.
> >
>
> One thing we could think about is if there's a way for BTF data dump to
> better represent the fact that a structure is all 0s; currently we will
> show "{}" since we skip emitting zeroed data, but maybe - at the
> toplevel only - "{ 0 }" would be more expressive? Thanks!

I think if the struct is filled with 0, showing "{ 0 }" is a really good id=
ea.

Thanks,
Howard
>
> Alan
>
> > Thanks,
> > Howard
> >>
> >> First glance, yes this is a substruct, but we should be able to
> >> collect those substruct data in BPF, since it is substruct, not
> >> substruct pointer. It seems to be the same -p problem we discussed
> >> here:
> >>
> >> Before:
> >> ```
> >> perf $ perf trace -e open -p 3792392
> >>          ? (         ):  ... [continued]: open())
> >>                        =3D -1 ENOENT (No such file or directory)
> >>          ? (         ):  ... [continued]: open())
> >>                        =3D -1 ENOENT (No such file or directory)
> >> ```
> >>
> >> We can see there's no output.
> >>
> >> After:
> >> ```
> >> perf $ perf trace -e open -p 3792392
> >>      0.000 ( 0.123 ms): a.out/3792392 open(filename: "DINGZHEN",
> >> flags: WRONLY)                             =3D -1 ENOENT (No such file
> >> or directory)
> >>   1000.398 ( 0.116 ms): a.out/3792392 open(filename: "DINGZHEN",
> >> flags: WRONLY)                             =3D -1 ENOENT (No such file
> >> or directory)
> >> ```
> >>
> >> I will test and fix it later.
> >>
> >> Thanks,
> >> Howard
> >>
> >>> root@number:~# strace -e setitimer -p 5444 |& head -5
> >>> strace: Process 5444 attached
> >>> setitimer(ITIMER_REAL, {it_interval=3D{tv_sec=3D0, tv_usec=3D5000}, i=
t_value=3D{tv_sec=3D0, tv_usec=3D5000}}, NULL) =3D 0
> >>> setitimer(ITIMER_REAL, {it_interval=3D{tv_sec=3D0, tv_usec=3D0}, it_v=
alue=3D{tv_sec=3D0, tv_usec=3D0}}, NULL) =3D 0
> >>> setitimer(ITIMER_REAL, {it_interval=3D{tv_sec=3D0, tv_usec=3D5000}, i=
t_value=3D{tv_sec=3D0, tv_usec=3D5000}}, NULL) =3D 0
> >>> setitimer(ITIMER_REAL, {it_interval=3D{tv_sec=3D0, tv_usec=3D0}, it_v=
alue=3D{tv_sec=3D0, tv_usec=3D0}}, NULL) =3D 0
> >>> root@number:~#
> >>> root@number:~#
> >>> root@number:~# grep -w value /sys/kernel/tracing/events/syscalls/sys_=
enter_rseq/format
> >>> root@number:~# grep -w value /sys/kernel/tracing/events/syscalls/sys_=
enter_setitimer/format
> >>>         field:struct __kernel_old_itimerval * value;    offset:24;   =
   size:8; signed:0;
> >>> print fmt: "which: 0x%08lx, value: 0x%08lx, ovalue: 0x%08lx", ((unsig=
ned long)(REC->which)), ((unsigned long)(REC->value)), ((unsigned long)(REC=
->ovalue))
> >>> root@number:~# pahole __kernel_old_itimerval
> >>> struct __kernel_old_itimerval {
> >>>         struct __kernel_old_timeval it_interval;         /*     0    =
16 */
> >>>         struct __kernel_old_timeval it_value;            /*    16    =
16 */
> >>>
> >>>         /* size: 32, cachelines: 1, members: 2 */
> >>>         /* last cacheline: 32 bytes */
> >>> };
> >>>
> >>> root@number:~# pahole -E __kernel_old_itimerval
> >>> struct __kernel_old_itimerval {
> >>>         struct __kernel_old_timeval {
> >>>                 /* typedef __kernel_long_t */ long int           tv_s=
ec;                 /*     0     8 */
> >>>                 /* typedef __kernel_long_t */ long int           tv_u=
sec;                /*     8     8 */
> >>>         } it_interval; /*     0    16 */
> >>>         struct __kernel_old_timeval {
> >>>                 /* typedef __kernel_long_t */ long int           tv_s=
ec;                 /*    16     8 */
> >>>                 /* typedef __kernel_long_t */ long int           tv_u=
sec;                /*    24     8 */
> >>>         } it_value; /*    16    16 */
> >>>
> >>>         /* size: 32, cachelines: 1, members: 2 */
> >>>         /* last cacheline: 32 bytes */
> >>> };
> >>>
> >>> root@number:~#
>
