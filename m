Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B1B1CFEA6;
	Thu, 22 Aug 2024 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724350655; cv=none; b=AOBpDjsy7nocvunJaVNLhQHYVp9LbHIe01yjcGItjsZWABuO2t0ecFc1V5edYFqmFnR9/o9tRJ6fC5no93g9/t3CeHRIqpWhS7IwuH9rihLGK/jX3N6hXJfTSqF6ElulL+eNumKuuIV2kHnDwz9P9FrJGIt3cl4pdudtzAXM4qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724350655; c=relaxed/simple;
	bh=oIL757S+ZAaqfiPhNnNK6Z5q+HKfPbSXx+FX5S0KDRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncstuW1YuUHjfR2NfFHOqXp6ExKdxEfO8T+79PAN40j80+34OY70gTKOcmXoOg7+ehGu7fZIC+f68MOsEabry0Kcf2KKZFYxeh38Z4UqfhqElVyxjGftUkvCLylKuiycSY+aemX4VV/3c69/7y8Eu0WQdV3Qf2xCj9m9J9tQNlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7b8884631c4so501228a12.2;
        Thu, 22 Aug 2024 11:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724350653; x=1724955453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voC3ud9jrqh/WEZjGXtEwA67mX5h/or/7kg4NJAK10g=;
        b=g+HuoI/vhkHwkKtWMFqYQ5mRcTW2iaz51mf0VKqvJ7eOKWf7pBHmoJkxptpJI7bijN
         nvSXg+urzlS7PfKkc7GV4rK2oYu3wqwtijEL1JtbOeZfFrKBZnLLEhWAMpmf038yAI/v
         cr/YgToth1fin8IYES79aQJ1XqoIk3A8RewdlirvwJAaTx74Z72fDAuuumO+z4XcvGEG
         XkCZaQ+DqCdF7kArAwCPN8IBXZiNUPssFTBf4YLCvafikeJ7LPRqKMD4iLb8WOMe1RmE
         gh/pO06Ud41SEOaJmV/LQr+XOKmtaK7fwQal8qtZKQ3zkXi06uOeDFrHLvjCNA6tyHcc
         93RQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1dNWLbdwpX4wjMCcFcT5m39JWwT43FItAjn46cnajmR1h3NeZ3FvX8qkzZpqgL+B2vlIruCU8r13CdcJy4kUt1g==@vger.kernel.org, AJvYcCXMTyb366vBIvnL2OaP3HGdjx4C/Se8clxjza8tBvBmVu3NPavtplEDZUkndigQYgamrUMm2Xucy0dBQ4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7whZTpL8pA4nHtEPKCufR8v2rMARlRhO4RIcdYU2K2a+D24Ew
	6HLIZ34y2YXu4FLybQscfPRzY2Em3cR2jNASE+OdYkx6Z6S5grvsc4XuOcBrc6by2ie/CxWMsoL
	Cf6yh95TdPrT6w3ZrA295wnQk5fo=
X-Google-Smtp-Source: AGHT+IENRiBt1YTrC76P387T5HLPnaB/4BaCeUF3JjX0EcMBrniVz9yrzOnmR32LbcnCnW3dSDPUFRK+6agNQaaQDrg=
X-Received: by 2002:a17:90a:c7d7:b0:2c4:aa78:b48b with SMTP id
 98e67ed59e1d1-2d5e9fc4d32mr7871669a91.38.1724350652428; Thu, 22 Aug 2024
 11:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com>
 <ZsdKhLaPy-uzKsuH@x1> <ZsdUxxBrpbuYxtXN@x1> <CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com>
 <ZsdxinrZP1kHINWT@x1> <ZsdzLmIFWRqsXeXD@x1> <CA+icZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com>
 <Zsd39zG9BuGpZ8aA@x1> <CA+icZUXGV9dMGcRwJiP7WLcYUaY5CRCcDw1HLFr+9Sn7CrRGDw@mail.gmail.com>
In-Reply-To: <CA+icZUXGV9dMGcRwJiP7WLcYUaY5CRCcDw1HLFr+9Sn7CrRGDw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 22 Aug 2024 11:17:21 -0700
Message-ID: <CAM9d7cgSR4OroaX0FuBvC_bPPMeEr7ThXJwqgMfAnj-Lfk8wNw@mail.gmail.com>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
To: sedat.dilek@gmail.com
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 10:59=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.com=
> wrote:
>
> On Thu, Aug 22, 2024 at 7:40=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Thu, Aug 22, 2024 at 07:31:55PM +0200, Sedat Dilek wrote:
> > > On Thu, Aug 22, 2024 at 7:19=E2=80=AFPM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Thu, Aug 22, 2024 at 02:12:46PM -0300, Arnaldo Carvalho de Melo =
wrote:
> > > > > On Thu, Aug 22, 2024 at 07:02:52PM +0200, Sedat Dilek wrote:
> > > > > > On Thu, Aug 22, 2024 at 5:10=E2=80=AFPM Arnaldo Carvalho de Mel=
o <acme@kernel.org> wrote:
> > > > > > > +++ b/tools/perf/util/setup.py
> > > > > > > @@ -17,7 +17,7 @@ src_feature_tests  =3D getenv('srctree') + =
'/tools/build/feature'
> > > > >
> > > > > > >  def clang_has_option(option):
> > > > > > >      cc_output =3D Popen([cc, cc_options + option, path.join(=
src_feature_tests, "test-hello.c") ], stderr=3DPIPE).stderr.readlines()
> > > > > > > -    return [o for o in cc_output if ((b"unknown argument" in=
 o) or (b"is not supported" in o))] =3D=3D [ ]
> > > > > > > +    return [o for o in cc_output if ((b"unknown argument" in=
 o) or (b"is not supported" in o) or (b"unknown warning option" in o))] =3D=
=3D [ ]
> > > > > > >  if cc_is_clang:
> > > > > > >      from sysconfig import get_config_vars
> > > > > > > @@ -63,6 +63,8 @@ cflags =3D getenv('CFLAGS', '').split()
> > > > > > >  cflags +=3D ['-fno-strict-aliasing', '-Wno-write-strings', '=
-Wno-unused-parameter', '-Wno-redundant-decls' ]
> > > > > > >  if cc_is_clang:
> > > > > > >      cflags +=3D ["-Wno-unused-command-line-argument" ]
> > > > > > > +    if clang_has_option("-Wno-cast-function-type-mismatch"):
> > > > > > > +        cflags +=3D ["-Wno-cast-function-type-mismatch" ]
> > > > > > >  else:
> > > > > > >      cflags +=3D ['-Wno-cast-function-type' ]
> > > > >
> > > > > > I tried with your diff with SLIM LLVM toolchains 18 and 19.
> > > > >
> > > > > > Both work - see attached build-logs.
> > > > >
> > > > > > Yes, are right that LLVM/Clang v19 was first introducing:
> > > > >
> > > > > > -Wcast-function-type-mismatch / -Wno-cast-function-type-mismatc=
h
> > > > >
> > > > > > [4] says for LLVM 18.1.8:
> > > > >
> > > > > > -Wcast-function-type
> > > > > > -Wcast-function-type-strict
> > > > >
> > > > > > Feel free to add my Reported-by/Tested-by credentials if you se=
nt a full patch.
> > > > >
> > > > > Thanks for the report and test of the fix, I'll add both tags,
> > > >
> > > > So below is the part that deals with disabling the warning if prese=
nt,
> > > > the other patch supporting checking warning options I merged as a p=
rep
> > > > patch.
> > > >
> > > > Thanks!
> > > >
> > > > - Arnaldo
> > > >
> > > > From 155212c965b5b23a90b8558449dbfd1c60dad934 Mon Sep 17 00:00:00 2=
001
> > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > Date: Thu, 22 Aug 2024 14:13:49 -0300
> > > > Subject: [PATCH 1/1] perf python: Disable -Wno-cast-function-type-m=
ismatch if
> > > >  present on clang
> > > >
> > > > The -Wcast-function-type-mismatch option was introduced in clang 19=
 and
> > > > its enabled by default, since we use -Werror, and python bindings d=
o
> > > > casts that are valid but trips this warning, disable it if present.
> > > >
> > > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > Cc: Ian Rogers <irogers@google.com>
> > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9=
uy3r2MzKXwTA5THtL7w@mail.gmail.com
> > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > ---
> > > >  tools/perf/util/setup.py | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> > > > index 26c0f2614fe92eb6..649550e9b7aa8c8f 100644
> > > > --- a/tools/perf/util/setup.py
> > > > +++ b/tools/perf/util/setup.py
> > > > @@ -63,6 +63,8 @@ cflags =3D getenv('CFLAGS', '').split()
> > > >  cflags +=3D ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-u=
nused-parameter', '-Wno-redundant-decls' ]
> > > >  if cc_is_clang:
> > > >      cflags +=3D ["-Wno-unused-command-line-argument" ]
> > > > +    if clang_has_option("-Wno-cast-function-type-mismatch"):
> > > > +        cflags +=3D ["-Wno-cast-function-type-mismatch" ]
> > > >  else:
> > > >      cflags +=3D ['-Wno-cast-function-type' ]
> > > >
> > > > --
> > > > 2.46.0
> > > >
> > >
> > > Thanks for the patch, Arnanldo.
> > >
> > > @Nathan Chancellor
> > > What was the b4 magic to retrieve a patch included in a ML thread?
> > >
> > > I tried:
> > >
> > > link=3D"https://lore.kernel.org/all/CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haF=
neX0C5pUMUUhG-UVKQ@mail.gmail.com/"
> > >
> > > b4 am $link
> > > Grabbing thread from
> > > lore.kernel.org/all/CA%2BicZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-=
UVKQ@mail.gmail.com/t.mbox.gz
> > > Analyzing 9 messages in the thread
> > > No patches found.
> >
> > I use:
> >
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers CA+i=
cZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com
> > Grabbing thread from lore.kernel.org/all/CA%2BicZUURwYd8nJSdMU7KW6nFjub=
i-VD2f-a5%2BzQNQGUxK7%2B2aw@mail.gmail.com/t.mbox.gz
> > Analyzing 10 messages in the thread
> > No patches found.
> > =E2=AC=A2[acme@toolbox perf-tools-next]$
> >
> > Using the Message-ID for your message, which normally is enough, but I
> > think I didn't separate the patch from the rest of the message with ---=
.
> >
> > Lemme try...
> >
> > ---
> >
> > From 155212c965b5b23a90b8558449dbfd1c60dad934 Mon Sep 17 00:00:00 2001
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date: Thu, 22 Aug 2024 14:13:49 -0300
> > Subject: [PATCH 1/1] perf python: Disable -Wno-cast-function-type-misma=
tch if
> >  present on clang
> >
> > The -Wcast-function-type-mismatch option was introduced in clang 19 and
> > its enabled by default, since we use -Werror, and python bindings do
> > casts that are valid but trips this warning, disable it if present.
> >
> > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r=
2MzKXwTA5THtL7w@mail.gmail.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Can we also add 'Fixes' tag to make this picked by stable kernels?

Thanks,
Namhyung

> > ---
> >  tools/perf/util/setup.py | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> > index 26c0f2614fe92eb6..649550e9b7aa8c8f 100644
> > --- a/tools/perf/util/setup.py
> > +++ b/tools/perf/util/setup.py
> > @@ -63,6 +63,8 @@ cflags =3D getenv('CFLAGS', '').split()
> >  cflags +=3D ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unuse=
d-parameter', '-Wno-redundant-decls' ]
> >  if cc_is_clang:
> >      cflags +=3D ["-Wno-unused-command-line-argument" ]
> > +    if clang_has_option("-Wno-cast-function-type-mismatch"):
> > +        cflags +=3D ["-Wno-cast-function-type-mismatch" ]
> >  else:
> >      cflags +=3D ['-Wno-cast-function-type' ]
> >
> > --
> > 2.46.0
> >
>
> Hmm, OK.
>
> My first posting:
> https://lore.kernel.org/all/CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUh=
G-UVKQ@mail.gmail.com/
>
> $ b4 am -ctsl --cc-trailers
> CA+icZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com
> Grabbing thread from
> lore.kernel.org/all/CA%2BicZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5%2BzQNQGUxK7%2=
B2aw@mail.gmail.com/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 11 messages in the thread
> No patches found.
>
> Did you drop that part by accident or intentionally from the patch?
>
>  def clang_has_option(option):
>     cc_output =3D Popen([cc, cc_options + option,
> path.join(src_feature_tests, "test-hello.c") ],
> stderr=3DPIPE).stderr.readlines()
> -    return [o for o in cc_output if ((b"unknown argument" in o) or
> (b"is not supported" in o))] =3D=3D [ ]
> +    return [o for o in cc_output if ((b"unknown argument" in o) or
> (b"is not supported" in o) or (b"unknown warning option" in o))] =3D=3D [
> ]
>
> Thank for all.
>
> -Sedat-
