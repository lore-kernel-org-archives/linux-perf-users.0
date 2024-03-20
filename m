Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990834F206
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947593; cv=none; b=astM2EoOEHY/cf9RhJ5p+XoyBORJHbfwl66i/Ztjr7Iy92P3z0vCfBLc/PPs/TkGfOzH7KjKXm3wYQ3tB59QPythAJ6bOTvzkbJzLTATqog9ZjGfryuZh6DVR4bzSrt9dSe63mC3GM8w8lyn7Tyjy4vfs/EYic/s3eK95iQi1To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947593; c=relaxed/simple;
	bh=m9OPYIu+QyrTH8BWbr0XWwVVNmSf9KYn3EcQnz1bmt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGvVtA+QSngAGba8BB0x/ndEIZml/0pjWtvtkZtcw0ksfc/aYiM6hoIlCAELSbbd5PV4lhwmflqbvnSAVGUopiD4HYPcUNPX4j2Ut6w2554oUyycGLjfzBF2pVQSXfUwFpU7z0ATNb4EyS6jadckdBMBRV4fvE5Cl5RR19FOd8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LPNXjGu4; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPNXjGu4"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36849db2578so134745ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 08:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710947590; x=1711552390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m73wGiqzdBJkICS2Dfzy+2irDr2Zv+TJxkjsujiC7nc=;
        b=LPNXjGu4tTKEoe8loHcdy1wzObq2oH/cgJZvBz83qBwScx0J/iezBIWD0wZuD0fP83
         9JueySU8xnXkojoQPTn+3W9tojJ5teq7NRODqjbo1QdIWHmpavyFErIOyVkvyDzjuJTZ
         OoPTmbMTJPxNo6CZzRI9lxIdBlq4JhIzoUEbE5cFJwKZi9GWO9O81tI9Laz61UtSuOMO
         OlFO1MRbMtEMO0beCorf1EvpKj7LXIREe4i84wbFzZC/ywVEfd69rms04QRpFy1PJd0X
         RCeXyh77fFf539ylt97pbnKxwEnohMQdfUNfkiSO7AA+xNtMOv0DWw3lBZ8/qTkQsg87
         9HYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710947590; x=1711552390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m73wGiqzdBJkICS2Dfzy+2irDr2Zv+TJxkjsujiC7nc=;
        b=JCDXce6fvapyvUCj2iRO1K9OMCINCo6E6R2Ye+Kd8TvrW/JNgsZkvRGhTKXUQHCiJ5
         pUUsztTK625M/WMehTaBkCoYWuPFD/Si9BwV3jPYukLW+mE5KUV/AcDUI9qvsBp9aFnu
         lbJ5F8VWpPqN9OjpADdHLj9cjdoihplMZeZkFPP0LpRQ6tDRxDCK4JsNhymbMtZmGl7E
         v6CprwQtVHATsBfn8cPormoD59zjIyeD0K5RIETpCbitSPJLaDI2JTi9QQ0xnTYXkZs2
         iOKfIptxwz2Wl7T1w4U4sE0P+mtiDahPixLCB0Yytj2a7augTPAFwCEuqbvFa4vUtANB
         A7aw==
X-Forwarded-Encrypted: i=1; AJvYcCVmlKhV4uiTkKZ5TmUDk194/tOa6d1joop+0TY/Gd6gDhzkS/fVGjFU19vnz1WVfqeP9OGMA8fZOEsfQHvxQMw6y7VNjF99wwYvhgALI6ooEg==
X-Gm-Message-State: AOJu0YyZx50U1XA0evoAn5KY3L7mH7qURh8RSJMap9hw4WzkC9Uo1+mD
	DzKD4oIWO1cEOMu4JM/dy6Rhc4aPDpERbBmGHB60nLRDQwMVclmaQpK1Mi6wGegv5Xu9emVw1qT
	6yHWevLFyRVpOqwGSeHhmAAmiDbA9o4cHRE08
X-Google-Smtp-Source: AGHT+IHhzD7rWhP/rASzVqdjNRMPtc4CdkNESAN0qWC0nidrRdWCR7Fg3vwNaOCuSmxvy8dTSgunF4MZSs4aJjm+pRo=
X-Received: by 2002:a05:6e02:1d92:b0:368:5254:dc3c with SMTP id
 h18-20020a056e021d9200b003685254dc3cmr252833ila.1.1710947590485; Wed, 20 Mar
 2024 08:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301201306.2680986-1-irogers@google.com> <Zfr4jX_b8FCOG_x_@x1>
 <Zfr5__Ej3-0C8sJj@x1>
In-Reply-To: <Zfr5__Ej3-0C8sJj@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Mar 2024 08:12:56 -0700
Message-ID: <CAP-5=fXXrJRH=Dto2ajD_TUDE1YmkkJZO5Ey2pq5YB0wbVAzeg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf: Suggest inbuilt commands for unknown command
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 8:00=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Mar 20, 2024 at 11:54:09AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Mar 01, 2024 at 12:13:05PM -0800, Ian Rogers wrote:
> > > The existing unknown command code looks for perf scripts like
> > > perf-archive.sh and perf-iostat.sh, however, inbuilt commands aren't
> > > suggested. Add the inbuilt commands so they may be suggested too.
> > >
> > > Before:
> > > ```
> > > $ perf reccord
> > > perf: 'reccord' is not a perf-command. See 'perf --help'.
> > > ```
> > >
> > > After:
> > > ```
> > > $ perf reccord
> > > perf: 'reccord' is not a perf-command. See 'perf --help'.
> > >
> > > Did you mean this?
> > >         record
> > > ```
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > > v2. Drops a merged patch and rebases. No functional change. Arnaldo
> > >     reported the patch not working for him, but I've not found a
> >
> > Not working:
> >
> > root@number:~# perf reccord
> > Failed to run command 'reccord': No such file or directory
> > root@number:~#
> >
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ git log --oneline -1
> > a65ef8052854ba75 (HEAD) perf: Suggest inbuilt commands for unknown comm=
and
> > =E2=AC=A2[acme@toolbox perf-tools-next]$
> >
> > I use O=3D with install-bin, trying:
> >
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ make -C  tools/perf install-bi=
n
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ perf raccord
> > Failed to run command 'raccord': No such file or directory
> > =E2=AC=A2[acme@toolbox perf-tools-next]$
> >
> > Also didn't work
> >
> > Trying to figure this out...
>
> It somehow gets done_help set to 32767, and this will not run help_unknow=
n_cmd(), continuing after a conf call...
>
> (gdb) p *argv
> $7 =3D 0x7fffffffe4c5 "raccord"
> (gdb) s
> run_argv (argcp=3D0x7fffffffdfbc, argv=3D0x7fffffffdfb0) at perf.c:445
> 445     {
> (gdb) n
> 447             handle_internal_command(*argcp, *argv);
> (gdb) n
> 450             execv_dashed_external(*argv);
> (gdb) p *argv
> $8 =3D (const char **) 0x7fffffffe1d0
> (gdb) p **argv
> $9 =3D 0x7fffffffe4c5 "raccord"
> (gdb) n
> [Detaching after fork from child process 3245070]
> 451             return 0;
> (gdb) n
> 452     }
> (gdb) n
> main (argc=3D1, argv=3D0x7fffffffe1d0) at perf.c:565
> 565                     if (errno !=3D ENOENT)
> (gdb) p; errno
> Invalid character ';' in expression.
> (gdb) p errno
> $10 =3D 2
> (gdb) n
> 568                     if (!done_help) {
> (gdb) p done_help
> $11 =3D 32767
> (gdb) list
> 563                     run_argv(&argc, &argv);
> 564
> 565                     if (errno !=3D ENOENT)
> 566                             break;
> 567
> 568                     if (!done_help) {
> 569                             struct cmdnames main_cmds;
> 570
> 571                             for (unsigned int i =3D 0; i < ARRAY_SIZE=
(commands); i++) {
> 572                                     add_cmdname(&main_cmds,
> (gdb)
> 573                                                 commands[i].cmd,
> 574                                                 strlen(commands[i].cm=
d));
> 575                             }
> 576                             cmd =3D argv[0] =3D help_unknown_cmd(cmd,=
 &main_cmds);
> 577                             clean_cmdnames(&main_cmds);
> 578                             done_help =3D 1;
> 579                             if (!cmd)
> 580                                     break;
> 581                     } else
> 582                             break;
> (gdb)

Ah, the change:

-               static int done_help;
+               int done_help;

created an uninitialized use. Compiler warning/sanitizers? Anyway,
done_help needs hoisting out of the loop and initializing to zero, or
being made static again (ugh).

Thanks,
Ian
