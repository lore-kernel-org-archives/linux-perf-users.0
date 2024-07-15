Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBF161FFA
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721081953; cv=none; b=QHN/C6SCv4H4q+wop2L+LNjOCVtFKsdVh5h6y+mX62gPb4nkxzUluwJzrDhoxnKPtyZKxhAkN2j0TE/9V9blXDWraqxmnhEaPWSgnSMdzLLTM0n/J4ecSWX7M1wKxHWA+8RPAHGZ66Kh1I9WccrlgBSXO3jPlrvgb7oWLUN+2VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721081953; c=relaxed/simple;
	bh=q2iM3R4psEOOWq3s6QwTiuhDxUvFuopjDSuhDbdSLbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzGm+JT8xlWtpfNq0cPKXqju8IUIt1dH57hZr00t6ZGfUEzDuCTJcNUhynQS8/ETqXy14SAechrwPiUMB8Xx/5xsKzMHdUUnOyYYy8YjkHgl2x/LFo7YOoIO3JnAtdNuS++uc5A3rFRkuvSq5FG3djOiaHpRfd1abQjLS4pHkXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HQjOLlGd; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HQjOLlGd"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70af0684c2bso3165907b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 15:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1721081951; x=1721686751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTJuf0+j+ZAnr0Sm8e2FuiZ6M12xhnOZYRBdg8ooAms=;
        b=HQjOLlGdXDpmaZfS7lhJbmVXcVc/Noaiawi2ipQ7JFxOjapROl/4zbVWpCoouSLq+Z
         iIRUsMbaencXeMXQhxwc9Qh9YZDMsLJvCXZHDOkYPIzGP8XibIKDyP24osNe70+7ZUkR
         uKlGkY0FLQH51jQox+BUaGsBRcygggAxFZ2I78TsdUxPlP3MCHBtbZMmLx8vQNLlYqFB
         31cZkX0Yr3GmhG7saozY5UwVyfgay81UTGzYXMRvO8LfnjiiqelDdRmR9X1+ud03eSoT
         h6IfFSAs9XQLxGAMI7yVkL0zS9dMgYzHQ/OuYGCvtgNM5fZZp5PKr1OC9pmGKzcZh4Dk
         vNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721081951; x=1721686751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTJuf0+j+ZAnr0Sm8e2FuiZ6M12xhnOZYRBdg8ooAms=;
        b=Qyfydef1PUONudgmh1C9C05KQ2UueS12zJvQRhQBH5e8zp5oBhEUMFFw1uj6geW+wQ
         9gqLwP9xzxSpcqqDPNwKA+uj8/06cbxfsrsnfcJZ+pbHIAoZlLL4uw9VXyqiCEaD3UG9
         iIOvmOCWeIhWiqc2SNhrs2VKQwLNOnhWfIIgN3MStXLuGIt1+/xwqXhTRZR5N5lemQgZ
         tRmBC+n0Y1wCnWBYS3TpU2RJJUcvdFyZLz46rJ2FGVG3scYa+ZMB/K1IlFWZHOx6a90T
         cscgiiNOOt6UooK7/3e6w+2+HkissxD12iEZcj9OZP06/N69qu4WrlqzcA6LWCMmHzPt
         0YVg==
X-Gm-Message-State: AOJu0YyXctz4vDuiEAZP/n5/FyLKmkhPUsC7gon9MyRDhJeWYGl51BaE
	hOJnZOLoKxnz9j2jaTYs702Bq/bkPMMASHRuBOqs/s37OkGT9oR7vqvATXf91zgb9rMzO+bKoG0
	PDEmvNyQqnaQPucOX2Vd8+UStFKjliVEy2779+w==
X-Google-Smtp-Source: AGHT+IFp411zL3L036RPXUYXv37ipSy4egRSTUEbZXD6Ln3L0YzPOmfg9CoNlmIG7GGw7S7FokbRCAmW5/cmvvr8hs4=
X-Received: by 2002:a05:6a20:12c4:b0:1bd:233f:e60e with SMTP id
 adf61e73a8af0-1c3f1210945mr388234637.19.1721081951085; Mon, 15 Jul 2024
 15:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708232302.15267-1-cachen@purestorage.com>
 <20240708232302.15267-2-cachen@purestorage.com> <CAM9d7cisBvfLTzNp8=0SG6g3CA9zJFNayjopSEDX0fxRyG05UA@mail.gmail.com>
 <CALCePG0_PpwKK_=YrpCGr-j51dG8xtDP-yzBYGeLwphscFobRg@mail.gmail.com> <ZpGFfjebaW9LGNBo@google.com>
In-Reply-To: <ZpGFfjebaW9LGNBo@google.com>
From: Casey Chen <cachen@purestorage.com>
Date: Mon, 15 Jul 2024 15:19:00 -0700
Message-ID: <CALCePG0gUqXqz3nsK4JU3CdunzbXRKN0QnL1jinkKjKffKyCQw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tool: fix handling NULL al->maps returned from thread__find_map
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yzhong@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 12:35=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Wed, Jul 10, 2024 at 03:29:27PM -0700, Casey Chen wrote:
> > On Mon, Jul 8, 2024 at 10:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Hello,
> > >
> > > On Mon, Jul 8, 2024 at 4:23=E2=80=AFPM Casey Chen <cachen@purestorage=
.com> wrote:
> > > >
> > > > With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy function=
s"),
> > > > thread__find_map() would return with al->maps or al->map being NULL
> > > > when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
> > > > later deferencing on it would crash.
> > > >
> > > > Fix callers of thread__find_map() or thread__find_symbol() to handl=
e
> > > > this.
> > >
> > > It looks like you drop the callchain if it doesn't find a map/symbol.
> > > Can we keep the entries with raw hex numbers instead?
> > >
> > In add_callchain_ip(), my change let it return if either al.maps is
> > NULL or al.map is NULL after thread__find_symbol(), I'm not sure what
> > else can add_callchain_ip() could do to keep raw hex numbers. If it
> > proceeds, al.sym is NULL, the code inside 'if (al.sym !=3D NULL)' would
> > skip. callchain_srcline() would return NULL. chain_cursor_append()
> > would append a node whose ms.maps/ ms.map are NULL. Later
> > dereferencing them would cause trouble. But we could add other
> > information to the node, like ip, branch, nr_loop_iter, iter_cycles,
> > branch_from, are these information good to have ? but how to avoid
> > dereferencing NULL maps/map later.
>
> By checking if it's NULL?  I think it's normal to have NULL map or sym
> due to missing events, stripped binaries and so on.  The callchain code
> used to print raw ip address when it doesn't have symbols.  And srcline
> can/should do the same.
>

Could you help make a fix ? Actually I don't quite understand how it works.

> Thanks,
> Namhyung
>
> > >
> > > > ---
> > > >  tools/perf/arch/powerpc/util/skip-callchain-idx.c | 10 ++++++----
> > > >  tools/perf/util/machine.c                         |  5 +++++
> > > >  tools/perf/util/unwind-libdw.c                    |  6 ++++--
> > > >  3 files changed, 15 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/to=
ols/perf/arch/powerpc/util/skip-callchain-idx.c
> > > > index 5f3edb3004d8..25b0804df4c4 100644
> > > > --- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> > > > +++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> > > > @@ -255,13 +255,14 @@ int arch_skip_callchain_idx(struct thread *th=
read, struct ip_callchain *chain)
> > > >
> > > >         thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al)=
;
> > > >
> > > > -       if (al.map)
> > > > -               dso =3D map__dso(al.map);
> > > > +       if (!al.map)
> > > > +               goto out;
> > > > +
> > > > +       dso =3D map__dso(al.map);
> > > >
> > > >         if (!dso) {
> > > >                 pr_debug("%" PRIx64 " dso is NULL\n", ip);
> > > > -               addr_location__exit(&al);
> > > > -               return skip_slot;
> > > > +               goto out;
> > > >         }
> > > >
> > > >         rc =3D check_return_addr(dso, map__start(al.map), ip);
> > > > @@ -282,6 +283,7 @@ int arch_skip_callchain_idx(struct thread *thre=
ad, struct ip_callchain *chain)
> > > >                 skip_slot =3D 3;
> > > >         }
> > > >
> > > > +out:
> > > >         addr_location__exit(&al);
> > > >         return skip_slot;
> > > >  }
> > > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > > index 8477edefc299..fa4037d7f3d4 100644
> > > > --- a/tools/perf/util/machine.c
> > > > +++ b/tools/perf/util/machine.c
> > > > @@ -2098,7 +2098,12 @@ static int add_callchain_ip(struct thread *t=
hread,
> > > >                         }
> > > >                         goto out;
> > > >                 }
> > > > +
> > > >                 thread__find_symbol(thread, *cpumode, ip, &al);
> > > > +               if (!al.maps || !al.map) {
> > > > +                       err =3D 1;
> > > > +                       goto out;
> > > > +               }
> > > >         }
> > > >
> > > >         if (al.sym !=3D NULL) {
> > > > diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwin=
d-libdw.c
> > > > index b38d322734b4..fb038ef55be2 100644
> > > > --- a/tools/perf/util/unwind-libdw.c
> > > > +++ b/tools/perf/util/unwind-libdw.c
> > > > @@ -53,8 +53,10 @@ static int __report_module(struct addr_location =
*al, u64 ip,
> > > >          */
> > > >         thread__find_symbol(ui->thread, PERF_RECORD_MISC_USER, ip, =
al);
> > > >
> > > > -       if (al->map)
> > > > -               dso =3D map__dso(al->map);
> > > > +       if (!al->map)
> > > > +               return -1;
> > > > +
> > > > +       dso =3D map__dso(al->map);
> > > >
> > > >         if (!dso)
> > > >                 return 0;
> > > > --
> > > > 2.45.2
> > > >
> > > >
