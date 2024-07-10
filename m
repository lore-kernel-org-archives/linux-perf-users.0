Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB8D14AD3B
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jul 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720650581; cv=none; b=vAAhSx9LD+SDHoqMCTtiGXlSpaV0DcKSv7VAfUd3t9wY9o8p45gBjnRT9v2pN05bJMPF5P4T5qsxJhoRfknmtrHah6fd6JmxBv9/6lH2vf1rF/uOj5bEuO+2rNkpwi96gOKxfyIlctTeLO0QE6IsOb4GnanOcolLhrKcW9poaDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720650581; c=relaxed/simple;
	bh=rsM6wOIIuPtiTXHYi0ZYdEkTXszm2PRQO/8IL35wGpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3RSkbwe+El7ii9jMZIH71I+uv1mvwAalCS8lRCJlL1I2YjRyCIHzyjTGRQu/pq+nW+mda3de2paYUNxtbPslxwnWyIVTllUISthsD7WPcdIDotfkIQEkuP+GvRk1ZzmOuELM+LNnikBvviE6Vvh0CyKADrtIxSztey3eNJia/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=T6z+AU0s; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="T6z+AU0s"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb3cf78fbdso1528655ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jul 2024 15:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1720650579; x=1721255379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NTgih/I/qtspn9wPSsT5PQdbbKiYuSLrBWTOJWi/Yo=;
        b=T6z+AU0s8w6gBLmADCXNMWbBsHGbY+tyinUxuEH/OO0q6Wg9FiImX3vui2ZkY52XYR
         wWiDFDtWYaCfgTLpPuoTndyQ1H3OQ6FJq3XrLMTPwRdVoqhb3VUvEM+74iSgFLMA9J+1
         SK9SJFvC22mefOQz4eKZTJxqesD3Ej5lDMMmwARPCJgeOne4FP7n8vXLcZ36XmwAAwNS
         unRhQqWMH2LSDrhlNlVR5B/scKOSiQr5zz5h4zxMcZhkgK9WJ1vGhnfNmQZLd9/nTMZ6
         dD1DZaZYuPij2sCklOStYQz5FRDCMZU5LS3zf1sqpycORsqKxsvt1s698FlcY5eTZoAx
         /J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720650579; x=1721255379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NTgih/I/qtspn9wPSsT5PQdbbKiYuSLrBWTOJWi/Yo=;
        b=l5Okoxo7EJqShBUqc/NI+c1IrNEf1C5gMXlzTjlCLaMWWd3mzYet5GH9CacQqqMRjV
         rfOUP7sx4zFpqAmAKUhnnr1H61suZDejNNtE/oX/C5DXiD/wf9Vf+bwpAI8Ka2UdgurN
         Q/eLFr95mmXjLdPYu4bil/WYAAcB8OMWwezfLlgiQlGNQEVVxO14Fd5h0TRyzbJvF92i
         Bz59vYEvqtdaCkJu00zCYov/SyB/XSsLC+zDaS+b8WM4rn83lcHd1DitncEVm7DuqUzl
         NLwgGGZu6HDyIF6uc0jP7aUFgtw2I4zh+hPcEDtQQFrivZSg7rROra5azUyyIPe+sYMv
         /LNQ==
X-Gm-Message-State: AOJu0YyTtB4wBtyKDms6hj9hc64grjGMT3/LG7D75a//L0HNdFEFrqay
	hWp8OENjK1lIF0KPusR8wCThySgdKrtUwrAvAgpIlRQoL/SvBv18+WhdBqd344W3tpg/cifHX4D
	XwS5ic2XdzeUnzvZFtSLMdxMhaE3g77CXc/o6mA==
X-Google-Smtp-Source: AGHT+IEG0fJWzbKu94wc/lGrrWrq4ZTcQCHpdjfNmMcuIOCOrmIosFxlMKcxuEkUwIgTY3hOtUi5EqpS3gyOLgsysHw=
X-Received: by 2002:a17:90a:9a81:b0:2c9:60ea:2f11 with SMTP id
 98e67ed59e1d1-2ca35bd24a5mr5291639a91.1.1720650579090; Wed, 10 Jul 2024
 15:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708232302.15267-1-cachen@purestorage.com>
 <20240708232302.15267-2-cachen@purestorage.com> <CAM9d7cisBvfLTzNp8=0SG6g3CA9zJFNayjopSEDX0fxRyG05UA@mail.gmail.com>
In-Reply-To: <CAM9d7cisBvfLTzNp8=0SG6g3CA9zJFNayjopSEDX0fxRyG05UA@mail.gmail.com>
From: Casey Chen <cachen@purestorage.com>
Date: Wed, 10 Jul 2024 15:29:27 -0700
Message-ID: <CALCePG0_PpwKK_=YrpCGr-j51dG8xtDP-yzBYGeLwphscFobRg@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tool: fix handling NULL al->maps returned from thread__find_map
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yzhong@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 10:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Mon, Jul 8, 2024 at 4:23=E2=80=AFPM Casey Chen <cachen@purestorage.com=
> wrote:
> >
> > With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
> > thread__find_map() would return with al->maps or al->map being NULL
> > when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
> > later deferencing on it would crash.
> >
> > Fix callers of thread__find_map() or thread__find_symbol() to handle
> > this.
>
> It looks like you drop the callchain if it doesn't find a map/symbol.
> Can we keep the entries with raw hex numbers instead?
>
In add_callchain_ip(), my change let it return if either al.maps is
NULL or al.map is NULL after thread__find_symbol(), I'm not sure what
else can add_callchain_ip() could do to keep raw hex numbers. If it
proceeds, al.sym is NULL, the code inside 'if (al.sym !=3D NULL)' would
skip. callchain_srcline() would return NULL. chain_cursor_append()
would append a node whose ms.maps/ ms.map are NULL. Later
dereferencing them would cause trouble. But we could add other
information to the node, like ip, branch, nr_loop_iter, iter_cycles,
branch_from, are these information good to have ? but how to avoid
dereferencing NULL maps/map later.

Thanks
Casey

> Thanks,
> Namhyung
>
> > ---
> >  tools/perf/arch/powerpc/util/skip-callchain-idx.c | 10 ++++++----
> >  tools/perf/util/machine.c                         |  5 +++++
> >  tools/perf/util/unwind-libdw.c                    |  6 ++++--
> >  3 files changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/=
perf/arch/powerpc/util/skip-callchain-idx.c
> > index 5f3edb3004d8..25b0804df4c4 100644
> > --- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> > +++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> > @@ -255,13 +255,14 @@ int arch_skip_callchain_idx(struct thread *thread=
, struct ip_callchain *chain)
> >
> >         thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
> >
> > -       if (al.map)
> > -               dso =3D map__dso(al.map);
> > +       if (!al.map)
> > +               goto out;
> > +
> > +       dso =3D map__dso(al.map);
> >
> >         if (!dso) {
> >                 pr_debug("%" PRIx64 " dso is NULL\n", ip);
> > -               addr_location__exit(&al);
> > -               return skip_slot;
> > +               goto out;
> >         }
> >
> >         rc =3D check_return_addr(dso, map__start(al.map), ip);
> > @@ -282,6 +283,7 @@ int arch_skip_callchain_idx(struct thread *thread, =
struct ip_callchain *chain)
> >                 skip_slot =3D 3;
> >         }
> >
> > +out:
> >         addr_location__exit(&al);
> >         return skip_slot;
> >  }
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 8477edefc299..fa4037d7f3d4 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -2098,7 +2098,12 @@ static int add_callchain_ip(struct thread *threa=
d,
> >                         }
> >                         goto out;
> >                 }
> > +
> >                 thread__find_symbol(thread, *cpumode, ip, &al);
> > +               if (!al.maps || !al.map) {
> > +                       err =3D 1;
> > +                       goto out;
> > +               }
> >         }
> >
> >         if (al.sym !=3D NULL) {
> > diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-li=
bdw.c
> > index b38d322734b4..fb038ef55be2 100644
> > --- a/tools/perf/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw.c
> > @@ -53,8 +53,10 @@ static int __report_module(struct addr_location *al,=
 u64 ip,
> >          */
> >         thread__find_symbol(ui->thread, PERF_RECORD_MISC_USER, ip, al);
> >
> > -       if (al->map)
> > -               dso =3D map__dso(al->map);
> > +       if (!al->map)
> > +               return -1;
> > +
> > +       dso =3D map__dso(al->map);
> >
> >         if (!dso)
> >                 return 0;
> > --
> > 2.45.2
> >
> >
