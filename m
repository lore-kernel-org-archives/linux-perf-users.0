Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDD519E975;
	Mon, 23 Sep 2024 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727113386; cv=none; b=VoMxBX8JOYS1ik8RVaE0PgxhzUtFtGbnSNyBCVUpRW7kGoZOblTEr3LxGR2ChetQ/fZ76bCyDP39DGB5YbZuxRqh3VbIZinyRHwadxVpZoey3nvEvYafk+F4a8EQuorJaoQc61k3e9xHU/QqV64UMDwKbrAE/tRsehKGcCp+WQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727113386; c=relaxed/simple;
	bh=c/zZ+jK59OkeDabwYhHRg01Fejl8HXr5DVXMc0wdDoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Im6NYSLx27iP6SqwCyN+3zHAfa4nCsLmHrZPMazoKNr3BC0G0LJ+OgQafcPdiUAs9F17eNtLlzSM/Z37CQ0gonOY6+OOea5bG6hma5ZuDKGf3Z+qYgSJQkY2iEri+ny+TY9eoXLYrh96KCivJlmyyIanZv1U9wZ+fHb4BSEwciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MW3d/X3L; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MW3d/X3L"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6de05b9fd0bso37145457b3.1;
        Mon, 23 Sep 2024 10:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727113384; x=1727718184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HV35yrDqs6IEA7vN/SLaXJTsCjxf6FTblEThbAGOvDk=;
        b=MW3d/X3LY6G/2RwPTRBvUC7ohm6Jhk7vkgE9ZxeiyrfxyH+n2BED7FmEVb+/DEb2wn
         FiH8DO4HVcAIgJvM36XVlDbgfT8v0S52+pjP0v53/Tgacim6yyja37qpQ6S+ZuNnsWMS
         0EOpmV08bcPX0eussPv1T8oWcTQ9qPoZIpoOK0z9mXtZyAJZ9iVwpUSPddzLfEEGuy96
         YE8Y1annNzvfx25IWJqKH92jPpHc62nSJwMpFiiFijB87o8V8UPggN6tteljVrDpNJlK
         AkbkgJYUbz8om0oQeorI7ETTI2zlstAt8V74qqcsQNDdDVuKt0CU3u2OR5wADMF1LPDM
         FcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727113384; x=1727718184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HV35yrDqs6IEA7vN/SLaXJTsCjxf6FTblEThbAGOvDk=;
        b=UxA4J4jkQ36sdIoIo4VEsvsIKh5xVrvNcxR5JaDWlvTkaLgLve0IJpjKS9vzHhQRcm
         H85Vdh5fl4wUM2yUQKQX1iNJxmq8Q1SnTfa8Ro50EjbVFBtTx3aGx8Vpze+LKQ9x+WLF
         maaWbNuEpiYGUDOyywxFBFkwrJuWvk4jLLRXmW8KDI58acJy1D+UFn5985m8aLZooz2C
         bD85lSmszp+uzyVl/GYS6DhDnzD3bJEndSQOV5Rzq0z5ENK006nbdNz7Ac8MrTIbBvQw
         ZI+8z2I6l16YSNMIho7BXbJxmzRQLcn9AY7MiJ4bN9PM7NntdMie59haqMSWUpqEIkBv
         HrPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPbTDEFgZcpIpV/Ojrr8Y7vqo9YrmTF5NZQaXpcHAb2eN3idjmRIy8D3c/21jijR37TWw2gsC2vKDL8pE=@vger.kernel.org, AJvYcCXNPiRvjOiy7VtMrkkl6xmnL76r0LRVk7/wo5/e4Y8OLlqelLtQkyQ5IRbSoYCrLtMZmfgMeb3qoP1LW+pXNQNgew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoh/pQCSMElvcG+YRaBzBTW5mBD/6pJg17WLDE5irQcqYfmI0H
	K1k9VnUJLPKTwJCLhtjqRPBlLJDAdVy0QPR8v51oFWEwnw81fYKUd+EOURvmSGeBqIBycD2iyda
	WR/0IpjAUUtbBrSaiDcTnDGOM7m0=
X-Google-Smtp-Source: AGHT+IHI2PqpvPU+LuxNAZ4kn6oV30rrGz2a4w9mLcDDiRWDHaR9qWnL24LO/2GMidrwYPRa42VS6vqYfF6v9G7l5Dw=
X-Received: by 2002:a05:690c:89:b0:6b1:4948:f689 with SMTP id
 00721157ae682-6dff290379dmr87442667b3.34.1727113384234; Mon, 23 Sep 2024
 10:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuH8qhuZB6mr9JvR@x1> <CAH0uvog5akiwUp+28w5u7+-j_fYvQLWahJ6YvEzWjdCz3Ky9Wg@mail.gmail.com>
In-Reply-To: <CAH0uvog5akiwUp+28w5u7+-j_fYvQLWahJ6YvEzWjdCz3Ky9Wg@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 23 Sep 2024 10:42:53 -0700
Message-ID: <CAH0uvoj_2An0QQgCSenZiK8XubS=amyrxhAWK7ragAFfi+Hnqg@mail.gmail.com>
Subject: Re: perf trace: substruct BTF based pretty printing
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Sep 11, 2024 at 6:29=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hello Arnaldo,
>
> On Wed, Sep 11, 2024 at 1:25=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Hi Howard,
> >
> >         Not really a requirement on you to do work, just a some notes t=
o
> > add to our discussion/experiment on using BTF to pretty print syscall
> > (and tracepoints/whatever) arguments:
> >
> > root@number:~# perf trace -e setitimer -p 5444 |& head -5
> >      0.000 ( 0.017 ms): Xwayland/5444 setitimer(value: (struct __kernel=
_old_itimerval){})                   =3D 0
> >      0.050 ( 0.004 ms): Xwayland/5444 setitimer(value: (struct __kernel=
_old_itimerval){})                   =3D 0
> >      0.142 ( 0.005 ms): Xwayland/5444 setitimer(value: (struct __kernel=
_old_itimerval){})                   =3D 0
> >      0.174 ( 0.004 ms): Xwayland/5444 setitimer(value: (struct __kernel=
_old_itimerval){})                   =3D 0
> >      0.293 ( 0.004 ms): Xwayland/5444 setitimer(value: (struct __kernel=
_old_itimerval){})                   =3D 0

First of all I bypass the from_user check to make perf trace use BTF
output instead of just printing an address:

        for (i =3D 0, field =3D sc->args; field; ++i, field =3D field->next=
) {
                // XXX We're only collecting pointer payloads _from_ user s=
pace
                /*if (!sc->arg_fmt[i].from_user)*/
                        /*continue;*/

Got the bad output:

   500.218 ( 0.015 ms): a.out/112335 setitimer(value: (struct
__kernel_old_itimerval){})                   =3D 0

But after switching on emit_zeroes from btf_dump_type_data_opts:

dump_data_opts.compact   =3D true;
dump_data_opts.skip_names =3D !arg->trace->show_arg_names;
dump_data_opts.emit_zeroes =3D true; // this

My output is good:

 96058.828 ( 0.010 ms): a.out/104347 setitimer(value: (struct
__kernel_old_itimerval){.it_interval =3D (struct
__kernel_old_timeval){.tv_sec =3D (__kernel_long_t)0,.tv_usec =3D
(__kernel_long_t)500000,},.it_value =3D (struct
__kernel_old_timeval){.tv_sec =3D (__kernel_long_t)0,.tv_usec =3D
(__kernel_long_t)500000,},}) =3D 0

So I think this is btf_dump's problem... Because most of the time we
want to omit the zeroes, but that will have the side effect of not
being able to print the whole output. I'll figure something out.

Thanks,
Howard
>
> First glance, yes this is a substruct, but we should be able to
> collect those substruct data in BPF, since it is substruct, not
> substruct pointer. It seems to be the same -p problem we discussed
> here:
>
> Before:
> ```
> perf $ perf trace -e open -p 3792392
>          ? (         ):  ... [continued]: open())
>                        =3D -1 ENOENT (No such file or directory)
>          ? (         ):  ... [continued]: open())
>                        =3D -1 ENOENT (No such file or directory)
> ```
>
> We can see there's no output.
>
> After:
> ```
> perf $ perf trace -e open -p 3792392
>      0.000 ( 0.123 ms): a.out/3792392 open(filename: "DINGZHEN",
> flags: WRONLY)                             =3D -1 ENOENT (No such file
> or directory)
>   1000.398 ( 0.116 ms): a.out/3792392 open(filename: "DINGZHEN",
> flags: WRONLY)                             =3D -1 ENOENT (No such file
> or directory)
> ```
>
> I will test and fix it later.
>
> Thanks,
> Howard
>
> > root@number:~# strace -e setitimer -p 5444 |& head -5
> > strace: Process 5444 attached
> > setitimer(ITIMER_REAL, {it_interval=3D{tv_sec=3D0, tv_usec=3D5000}, it_=
value=3D{tv_sec=3D0, tv_usec=3D5000}}, NULL) =3D 0
> > setitimer(ITIMER_REAL, {it_interval=3D{tv_sec=3D0, tv_usec=3D0}, it_val=
ue=3D{tv_sec=3D0, tv_usec=3D0}}, NULL) =3D 0
> > setitimer(ITIMER_REAL, {it_interval=3D{tv_sec=3D0, tv_usec=3D5000}, it_=
value=3D{tv_sec=3D0, tv_usec=3D5000}}, NULL) =3D 0
> > setitimer(ITIMER_REAL, {it_interval=3D{tv_sec=3D0, tv_usec=3D0}, it_val=
ue=3D{tv_sec=3D0, tv_usec=3D0}}, NULL) =3D 0
> > root@number:~#
> > root@number:~#
> > root@number:~# grep -w value /sys/kernel/tracing/events/syscalls/sys_en=
ter_rseq/format
> > root@number:~# grep -w value /sys/kernel/tracing/events/syscalls/sys_en=
ter_setitimer/format
> >         field:struct __kernel_old_itimerval * value;    offset:24;     =
 size:8; signed:0;
> > print fmt: "which: 0x%08lx, value: 0x%08lx, ovalue: 0x%08lx", ((unsigne=
d long)(REC->which)), ((unsigned long)(REC->value)), ((unsigned long)(REC->=
ovalue))
> > root@number:~# pahole __kernel_old_itimerval
> > struct __kernel_old_itimerval {
> >         struct __kernel_old_timeval it_interval;         /*     0    16=
 */
> >         struct __kernel_old_timeval it_value;            /*    16    16=
 */
> >
> >         /* size: 32, cachelines: 1, members: 2 */
> >         /* last cacheline: 32 bytes */
> > };
> >
> > root@number:~# pahole -E __kernel_old_itimerval
> > struct __kernel_old_itimerval {
> >         struct __kernel_old_timeval {
> >                 /* typedef __kernel_long_t */ long int           tv_sec=
;                 /*     0     8 */
> >                 /* typedef __kernel_long_t */ long int           tv_use=
c;                /*     8     8 */
> >         } it_interval; /*     0    16 */
> >         struct __kernel_old_timeval {
> >                 /* typedef __kernel_long_t */ long int           tv_sec=
;                 /*    16     8 */
> >                 /* typedef __kernel_long_t */ long int           tv_use=
c;                /*    24     8 */
> >         } it_value; /*    16    16 */
> >
> >         /* size: 32, cachelines: 1, members: 2 */
> >         /* last cacheline: 32 bytes */
> > };
> >
> > root@number:~#
