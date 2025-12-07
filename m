Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3361A25F995
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Dec 2025 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765144473; cv=none; b=aHrHUpwy5OWw8uEx4N6bzOasggXZCoYc4p2E7kmXnjpxgakTg+bLUsR1etXWjDYnbrXbga+/kf3jHi4DSTl9WJJpoWfTkwX4Ro0uDkdHopwpwdNe472CI1i+9qI6ObP89V6cAzs7ir73M73yYg7BqHBzUJD/a7ABDGY4lyBBEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765144473; c=relaxed/simple;
	bh=iujy350RJrYxhfpG1rRAP7S7zmxRyfX7qOiQns8gvfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NueL3Qri4JH2HynZyFhyFf0fONqulDr3U810Dp1jY7wLo9+QW27f7+ngOB6DnUPbWat/XgXItEmYbkYn+NEw5h+g4cor0EOgIdp0l0NrIAlBnG4u0aoH5YWG7q0iKSErOC2Bsp2Oo2jaYrTtF5kL89EKaOQRdMplyksYqCGcdEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QuoZIxr3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QuoZIxr3"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29e0753e5d8so157375ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Dec 2025 13:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765144471; x=1765749271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sH05bUWp1SxMOAmP5mAV88WVV3/Ebdb8I+TyHktd/3Y=;
        b=QuoZIxr3fG5sKNl0ISRh1FRdqoX4MjJBNirr+FthVi1vOEeH7QrNJ+LSqByEHsuvve
         8G4lBUkosdiO2ufxSQ5Yd4aQt9jK1P2Im+s45D3nGVesgrbNaVZVWmisKy2pezeHHTEA
         r6XiEOlNixutAxEbE+Scaf1sZ/hS+OSwuMAPi5Fj2Z7FjRn3yrdUfdvUi4/XPS8hmaYx
         hE8z3iuWLLwP1Tu7c6nvuq4l9htxRqYbOI3NjZkRtdNAEdXpiLjoVVUNZsb6vFg3DWcU
         tkee/WDkdMVoQknXhIn1xCG364ZGnr4kC1BZ66Icyk9y+OW8o2K+ikTDmrUzBucjo1Ak
         MUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765144471; x=1765749271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sH05bUWp1SxMOAmP5mAV88WVV3/Ebdb8I+TyHktd/3Y=;
        b=fGajFiZ5nbLdaOYQ0f4uspA8OQSpUcK3KTfzr0bqoAoP73os5X24FqgvDGmmgjzJt2
         ooOdLnK9mg+dkgLWwgmFpVtuIAZv28hCvGSjNG6Cl/KlzA4N3UVuLHkM84iV+bg4fDTh
         gT8HDa24tagSFtEA08oXSdN7v/6tbgTuoCR4EZh5kYMtIHYynHgByohVtLspeYLd4Pg3
         jQsacOXvw+rwQ2FJ/sFIIz2HnpZ87dYWABdAtJQIxmQo/uh3jcc1rdDx29pnnveY+wIJ
         M1wQtEA7uDlcnSTe//Exu3r+q+C2yYga0xg0zz6gxLFAhXEnFLXBhj+fpAVGCpPlmaUc
         +qzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU25T1nd+1QW6+eWq2gvKLxaoZtMSvwrEngoHXzRDFEst4t+fnqFl1QlXc9I20XTDDrYYGH853BPUdVvGiVvUuM@vger.kernel.org
X-Gm-Message-State: AOJu0YxMWsNDitCgTSKvVzd0/eM3b0JQTZKs6nk0V8Csmk7Dv0wnNhhi
	cOnU0jrPn0+9wwFlUDauiCx9tN3GCwPQxDZfZo4DIRg6rV863HReSOEdBmY5CjW1T6bSTOOdorX
	O2NHHNTrAPdzpC98KfqSWZ6T87uW+3WFYGCAmWR+2
X-Gm-Gg: ASbGncuZ1z/2q8Vdi3IhIysCocLA5GcU2N+Xnc+zeEHbrZk8LNkso/6MXkaCHRgJTN2
	ddJlHLlHT5aQ2CsMmtINS96+Le2AQbNkVhsR+XDhIVdhg29wM2vNcT4d5/Z1od5N0VvxWRn50I+
	2UTvUVlPg1TQqUjEgvQu0GgXhvW5L5VuP8jtGiMdfRdyrfcZfwnoXOqSoBCGITEg4yus82PYGY1
	cBqbcSyOanZPOddXr7zYTSFcsDLCiDM8TsY9+J3/Mly93p+yYExxrf7fsc5wUZMy47+aBoG
X-Google-Smtp-Source: AGHT+IEe8Kf3r/n0+DaFAB1LAS9tcemR/ztMZLDcapjzmGLWCYmSTW08ANzhqxDq61X965DLeQPmfEf5GLIgbdV4LQw=
X-Received: by 2002:a17:902:eccd:b0:294:ecba:c8e with SMTP id
 d9443c01a7336-29df9571f4dmr2151805ad.3.1765144470952; Sun, 07 Dec 2025
 13:54:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701201027.1171561-3-namhyung@kernel.org> <20250909094953.106706-1-amadio@gentoo.org>
 <CAP-5=fVCeBz+hgCsctCe7BByaL7GqKVUbDcW4R=2th0C1O0m0w@mail.gmail.com>
 <aMF0iWh4yTK5KwcJ@gentoo.org> <CAP-5=fV8p7u9zfYAWJ8zt=Dq53u-b3pNzD9ve2HabJ9_qjymhw@mail.gmail.com>
 <aTXQw9dtP5df7LmP@gentoo.org>
In-Reply-To: <aTXQw9dtP5df7LmP@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 7 Dec 2025 13:54:19 -0800
X-Gm-Features: AQt7F2qceJQcXeE1ynV1-xo7d9u9ngn80b0X_4_iNFhRjB-t_VzEBLAqy9G68CU
Message-ID: <CAP-5=fUR3iKn5755UCBxq9EEyVdKiZyvdO_yZaZnBLBzHCQscw@mail.gmail.com>
Subject: Re: perf --help triggers an assertion
To: Guilherme Amadio <amadio@gentoo.org>, "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>
Cc: namhyung@kernel.org, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 11:08=E2=80=AFAM Guilherme Amadio <amadio@gentoo.org=
> wrote:
>
> Hi Ian,
>
> On Wed, Sep 10, 2025 at 08:04:42AM -0700, Ian Rogers wrote:
> > On Wed, Sep 10, 2025 at 5:52=E2=80=AFAM Guilherme Amadio <amadio@gentoo=
.org> wrote:
> > >
> > > On Tue, Sep 09, 2025 at 11:31:51AM -0700, Ian Rogers wrote:
> > > > On Tue, Sep 9, 2025 at 2:49=E2=80=AFAM Guilherme Amadio <amadio@gen=
too.org> wrote:
> > > > >
> > > > > Hi Namhyung,
> > > > >
> > > > > I was updating perf's package in Gentoo Linux and noticed some pr=
oblems
> > > > > which were not there before. I tested with the version below and =
the problem
> > > > > still seems to be there. perf --help triggers an assertion (see b=
elow).
> > > > > Looking in the list, it seems related to the patch below:
> > > > >
> > > > > https://lore.kernel.org/linux-perf-users/20250701201027.1171561-3=
-namhyung@kernel.org/
> > > > >
> > > > > Cheers,
> > > > > -Guilherme
> > > > >
> > > > > The problem:
> > > > >
> > > > > gentoo perf $ ./perf --help
> > > > > perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] =3D=3D=
 NULL' failed.
> > > > > Aborted                    (core dumped) ./perf --help
> > > > >
> > > > > Some extra information:
> > > > >
> > > > > gentoo perf $ ./perf version
> > > > > perf version 6.17.rc5.gf777d1112ee5
> > > > > gentoo perf $ ./perf test subcmd
> > > > >  69: libsubcmd help tests                                        =
    :
> > > > >  69.1: Load subcmd names                                         =
    : Ok
> > > > >  69.2: Uniquify subcmd names                                     =
    : Ok
> > > > >  69.3: Exclude duplicate subcmd names                            =
    : Ok
> > > > > gentoo perf $ ./perf bad-command
> > > > > perf: 'bad-command' is not a perf-command. See 'perf --help'.
> > > > > gentoo perf $ ./perf --help
> > > > > perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] =3D=3D=
 NULL' failed.
> > > > > Aborted                    (core dumped) ./perf --help
> > > > > gentoo perf $ gdb run --args ./perf --help
> > > > > GNU gdb (Gentoo 16.3 vanilla) 16.3
> > > > > Copyright (C) 2024 Free Software Foundation, Inc.
> > > > > License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licens=
es/gpl.html>
> > > > > This is free software: you are free to change and redistribute it=
.
> > > > > There is NO WARRANTY, to the extent permitted by law.
> > > > > Type "show copying" and "show warranty" for details.
> > > > > This GDB was configured as "x86_64-pc-linux-gnu".
> > > > > Type "show configuration" for configuration details.
> > > > > For bug reporting instructions, please see:
> > > > > <https://bugs.gentoo.org/>.
> > > > > Find the GDB manual and other documentation resources online at:
> > > > >     <http://www.gnu.org/software/gdb/documentation/>.
> > > > >
> > > > > For help, type "help".
> > > > > Type "apropos word" to search for commands related to "word"...
> > > > > Reading symbols from ./perf...
> > > > > (gdb) run
> > > > > Starting program: /home/amadio/src/linux/tools/perf/perf --help
> > > > > [Thread debugging using libthread_db enabled]
> > > > > Using host libthread_db library "/usr/lib64/libthread_db.so.1".
> > > > > perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] =3D=3D=
 NULL' failed.
> > > > >
> > > > > Program received signal SIGABRT, Aborted.
> > > > > __pthread_kill_implementation (threadid=3D<optimized out>, signo=
=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
> > > > > 44            return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SY=
SCALL_ERRNO (ret) : 0;
> > > > > (gdb) bt
> > > > > #0  __pthread_kill_implementation (threadid=3D<optimized out>, si=
gno=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
> > > > > #1  0x00007ffff74c1656 in __pthread_kill_internal (threadid=3D<op=
timized out>, signo=3Dsigno@entry=3D6) at pthread_kill.c:89
> > > > > #2  0x00007ffff74c166d in __GI___pthread_kill (threadid=3D<optimi=
zed out>, signo=3Dsigno@entry=3D6) at pthread_kill.c:100
> > > > > #3  0x00007ffff747509c in __GI_raise (sig=3Dsig@entry=3D6) at ../=
sysdeps/posix/raise.c:26
> > > > > #4  0x00007ffff747637e in __GI_abort () at abort.c:77
> > > > > #5  0x00007ffff746e023 in __assert_fail_base (fmt=3D<optimized ou=
t>, assertion=3Dassertion@entry=3D0x555555974d03 "cmds->names[ci] =3D=3D NU=
LL",
> > > > >     file=3Dfile@entry=3D0x555555974cfc "help.c", line=3Dline@entr=
y=3D104, function=3Dfunction@entry=3D0x555555974dc8 <__PRETTY_FUNCTION__.0>=
 "exclude_cmds")
> > > > >     at assert.c:118
> > > > > #6  0x00007ffff746e075 in __assert_fail (assertion=3D0x555555974d=
03 "cmds->names[ci] =3D=3D NULL", file=3D0x555555974cfc "help.c", line=3D10=
4,
> > > > >     function=3D0x555555974dc8 <__PRETTY_FUNCTION__.0> "exclude_cm=
ds") at assert.c:127
> > > > > #7  0x0000555555693813 in exclude_cmds (cmds=3D0x55555614e5e0 <ot=
her_cmds>, excludes=3D0x55555614e5c0 <main_cmds>) at help.c:104
> > > > > #8  0x0000555555693eb3 in load_command_list (prefix=3D0x555555954=
071 "perf-", main_cmds=3D0x55555614e5c0 <main_cmds>,
> > > > >     other_cmds=3D0x55555614e5e0 <other_cmds>) at help.c:252
> > > > > #9  0x00005555555e9987 in cmd_help (argc=3D1, argv=3D0x7fffffffd1=
a0) at builtin-help.c:458
> > > > > #10 0x0000555555685d45 in run_builtin (p=3D0x555556130de0 <comman=
ds+192>, argc=3D1, argv=3D0x7fffffffd1a0) at perf.c:349
> > > > > #11 0x0000555555685fe1 in handle_internal_command (argc=3D1, argv=
=3D0x7fffffffd1a0) at perf.c:401
> > > > > #12 0x0000555555686142 in run_argv (argcp=3D0x7fffffffcfac, argv=
=3D0x7fffffffcfa0) at perf.c:445
> > > > > #13 0x0000555555686493 in main (argc=3D1, argv=3D0x7fffffffd1a0) =
at perf.c:553
> > > > > (gdb) quit
> > > >
> > > > Thanks Guilherme,
> > > >
> > > > I tried to reproduce the same version with various options: DEBUG=
=3D1
> > > > -UNDEBUG in EXTRA_CFLAGS, -fsanitize=3Daddress. Being in various
> > > > directories with "perf-" prefixed files. I'm afraid I wasn't able t=
o
> > > > reproduce. The assert is trying to avoid a memory leak, so
> > > > non-critical, and I couldn't in a quick inspection eye-ball an issu=
e.
> > > > Without getting a reproduction I don't think I can make progress wi=
th
> > > > the issue.
>
> I had a look at this with gdb again while I was updating perf to 6.18 in =
Gentoo.
>
> BTW, I've followed your advice and turned off BUILD_NONDISTRO:
> https://gitweb.gentoo.org/repo/gentoo.git/commit/?id=3Db92c5b8bd89c70c40a=
84f86013c4ecf321f3132f
>
> It looks like the logic to exclude commands sometimes doesn't work as
> expected, and you reach a line where there is an assertion for
> cmds->names[ci] =3D=3D NULL, but it's not actually NULL. The difference w=
ith
> other setups is probably the installation of perf-read-vdso32 into a
> default path in our packaging. In gdb I saw that when running perf --help=
,
> I arrive at exclude_cmds() with the following:
>
> Breakpoint 1, exclude_cmds (cmds=3Dcmds@entry=3D0x55555605bd90 <other_cmd=
s>, excludes=3Dexcludes@entry=3D0x55555605bdb0 <main_cmds>) at help.c:74
> 74      {
> (gdb) p *cmds
> $1 =3D {alloc =3D 24, cnt =3D 1, names =3D 0x5555568fe180}
> (gdb) p *excludes
> $2 =3D {alloc =3D 24, cnt =3D 1, names =3D 0x5555568fe0c0}
> (gdb) p *cmds->names[0]
> $3 =3D {len =3D 11, name =3D 0x5555568db788 "read-vdso32"}
> (gdb) p *excludes->names[0]
> $4 =3D {len =3D 7, name =3D 0x555556890198 "archive"}
>
> I have /usr/bin/perf and /usr/bin/perf-read-vdso32, as well as this:
>
> $ ls /usr/libexec/perf-core/
> dlfilters  libperf-gtk.so  perf-archive  perf-iostat  scripts  tests
>
> If I remove /usr/bin/perf-read-vdso32, then perf --help works again:
>
> gentoo ~ $ sudo rm /usr/bin/perf-read-vdso32
> gentoo ~ $ perf version
> perf version 6.18
> gentoo ~ $ perf --help | head -3
>
>  usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]
>
> gentoo ~ $ touch ~/bin/perf-read-vdso32
> gentoo ~ $ chmod +x ~/bin/perf-read-vdso32
> gentoo ~ $ perf --help
> perf: help.c:107: exclude_cmds: Assertion `cmds->names[ci] =3D=3D NULL' f=
ailed.
> Aborted                    (core dumped) perf --help
>
> So, I think that if you don't have perf-read-vdso32 installed by default,
> you will likely be able to reproduce the problem like shown above. So,
> the assumption that cmds->names[0] =3D=3D NULL is not correct, since we h=
ave
> the "read-vdso32" command at position 0, and the excludes list only
> contained "archive". The patch below is my attempt to fix the issue:
>
> diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> index ddaeb4eb3e24..0c4ba87422e5 100644
> --- a/tools/lib/subcmd/help.c
> +++ b/tools/lib/subcmd/help.c
> @@ -102,10 +102,10 @@ void exclude_cmds(struct cmdnames *cmds, struct cmd=
names *excludes)
>                         cmds->names[cj++] =3D cmds->names[ci];
>                         cmds->names[ci++] =3D NULL;
>                 }
> +               for (ci =3D cj; ci < cmds->cnt; ci++)
> +                       assert(cmds->names[ci] =3D=3D NULL);
> +               cmds->cnt =3D cj;
>         }
> -       for (ci =3D cj; ci < cmds->cnt; ci++)
> -               assert(cmds->names[ci] =3D=3D NULL);
> -       cmds->cnt =3D cj;
>  }
>
> So, if there are no actual command exclusions, at the end of the while lo=
op
> we get out with ei > excludes->cnt, and ci =3D=3D cj, like the example ab=
ove,
> in which ci =3D=3D cj =3D=3D 0, and ei =3D=3D 1. So the assumption that
> cmds->names[0] =3D=3D NULL is wrong, since there's a valid "read-vdso32"
> command at position 0, and setting cmds->cnt =3D cj; is also wrong, since
> cnt should be 1 and is set to 0. The patch moves the asserts and the
> update of cmds->cnt inside the if(ci !=3D cj), which indicates something
> was actually excluded. If cmds was not modified, then the initial value
> of cmds->cnt was already correct. Please let me know if you'd like me
> to submit this properly as a patch, but since it's so simple, please
> feel free to just take this and apply yourself.

Thanks Guilherme,

This code is the gift that keeps on giving in terms of crashes. We did
have a recent and related patch sent to the list:
https://lore.kernel.org/lkml/20251202213632.2873731-1-sjayaram@akamai.com/
I need some time to get my head around the issue and the fixes. I
wandered into this code originally due to address/leak sanitizer
issues.

Thanks,
Ian

> Best regards,
> -Guilherme
