Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6BD1D048D;
	Thu, 22 Aug 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724350831; cv=none; b=eYDUmjBoaDJ825w+jwMKeQmLB8ClMhOMgM8+vGGfFVaE52DO4XELgySSCH40ibdsh4Si6z9ENfs1VrmOaUOvZIXq+VmaUXPue0Un0BGv0ETV63ITBW8VbxAFkBp85WjIYXC1OL0cSMBmQmylVSfA8cxB/bYzXaltwMk2wneJCP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724350831; c=relaxed/simple;
	bh=L1VMlC+RWrZp5xmgG4d5elu6uVjT5ssQf1WJQU/D0U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWyIKXEYoKlOBa1ahvhhz7N3mgeiXU4vF3iIil8cY2oJdG/5h8EdHEeGv8wTxT5Phw/HlO8RKcPXwFjvv9JOTffq2vJPrlNQhdzv84WoHaef1Hkp2RalCHUuRXpi071Wy+kszaZsU+dFaThmDoSJ3dyLdlX2dyV7KM5MsC/E9Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYoOJYnU; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYoOJYnU"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef2c56da6cso9711261fa.1;
        Thu, 22 Aug 2024 11:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724350828; x=1724955628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lSGS7WlqvNRD/ah2sexwN/Nml8PW3G7Ib5naklwJyeM=;
        b=iYoOJYnUx3HQ6TXoXacOX6g7kCCvlnrGMCDp6FrQIzRksVvRtNqonIRp9yUXGeMPlo
         wyerNOEEZ96dQdsB8f/XRVQOdcSykXS+iHtGu4lK9hC2Y2YwY0GYF8U0OENeSJrwF2KW
         Mj7czFikkvfFBF6jLfzmgk4gQJy6HDuMkqkxgE4kEoxCJAfSeUpgdBtNzTdwRXR+aXGA
         pIG7I49vtR9Bpc/tLjy63bZPvdFu+svrEuWy2SZMwYvkbyrwinMGvFiR0Z7tua/QuLj/
         BW87ztJySzQPI7iGjd4ix/tVe0csNeBxCPhtL8C5slvjrNg9LJuOcD2VFKKRyu2XQa9o
         0L8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724350828; x=1724955628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lSGS7WlqvNRD/ah2sexwN/Nml8PW3G7Ib5naklwJyeM=;
        b=PBTWGo3mJ2ZMceHZC0LOz0zRzw8zgqfT6tpiayoG3Us4oD08rJ06jb8OKXSTk6csgp
         aEe+AM9oyJ/PHm6wVy8XcajCDJlRSV+n5AW4OFdzM9wgQyi0mlPEBtdzBE1XCZn57ExT
         A3jONiXb7/pVGlMRcQu569VklRkO15D3tUBq0SKIIpo3aMulIbuglKZ5mMsc3hneW1my
         xoR8saGqzR6Xv4iHwqkn4td5X26gDHSIJHfYkXZobbJtFjN8VYq3/kPObVL4uFa2lguk
         exIeYJdW9f83zGMeG82TyxLQufcUtHVOV0RLNJ0WXY/D5c0pryPluyWM7eHL02eLZNV6
         +J1w==
X-Forwarded-Encrypted: i=1; AJvYcCUzlnWGlrpjgj/KAJCiSrccVuwSD+P7Ix79ffGb5tYoD4jXoYtUK7SbZ9mNBaelxDyyqNnaA2lalN4UUBp/yxKJOQ==@vger.kernel.org, AJvYcCVgR+DptwFucbRQnyXk2Qpp6I17hYBf2J6d7wHKv99BwDckd3ghzBky/bF4L3XeORH/T6DYuCOkLMXfzSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQH5ni7SKg9UEYscBGS0pT0M1gOLf2lUStQMiGEEa6c3tmjcg+
	wZUy3N9jFV5lV1WLf2WizUtk4Lmht9TJPpp3tbCr3UD10KSHqthKumpvu28jG7BFMhwXfXVV64j
	BXyWGH0+j0Gh2xCImta09HWV0Mq3rh4blhI0=
X-Google-Smtp-Source: AGHT+IGNC03mQ9IOTkN4t7U40PUkteF4UtTHd8HjTmw4jzhdbC6fkVA6Mhr7j5Ajo+GBj82KNQ8hkvh/bokRXkQsJ5E=
X-Received: by 2002:a2e:6a14:0:b0:2f3:eddb:5030 with SMTP id
 38308e7fff4ca-2f3f893f403mr33714101fa.39.1724350827355; Thu, 22 Aug 2024
 11:20:27 -0700 (PDT)
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
 <ZseAuZelNHgcchGj@x1>
In-Reply-To: <ZseAuZelNHgcchGj@x1>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 22 Aug 2024 20:19:50 +0200
Message-ID: <CA+icZUUfk6bMCo+JXUy=5g-4qt20rDNR3b=HC9Ln_47UozXEDQ@mail.gmail.com>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 8:17=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Aug 22, 2024 at 07:59:13PM +0200, Sedat Dilek wrote:
> > On Thu, Aug 22, 2024 at 7:40=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Thu, Aug 22, 2024 at 07:31:55PM +0200, Sedat Dilek wrote:
> > > > On Thu, Aug 22, 2024 at 7:19=E2=80=AFPM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > On Thu, Aug 22, 2024 at 02:12:46PM -0300, Arnaldo Carvalho de Mel=
o wrote:
> > > > > > On Thu, Aug 22, 2024 at 07:02:52PM +0200, Sedat Dilek wrote:
> > > > > > > On Thu, Aug 22, 2024 at 5:10=E2=80=AFPM Arnaldo Carvalho de M=
elo <acme@kernel.org> wrote:
> > > > > > > > +++ b/tools/perf/util/setup.py
> > > > > > > > @@ -17,7 +17,7 @@ src_feature_tests  =3D getenv('srctree') =
+ '/tools/build/feature'
> > > > > >
> > > > > > > >  def clang_has_option(option):
> > > > > > > >      cc_output =3D Popen([cc, cc_options + option, path.joi=
n(src_feature_tests, "test-hello.c") ], stderr=3DPIPE).stderr.readlines()
> > > > > > > > -    return [o for o in cc_output if ((b"unknown argument" =
in o) or (b"is not supported" in o))] =3D=3D [ ]
> > > > > > > > +    return [o for o in cc_output if ((b"unknown argument" =
in o) or (b"is not supported" in o) or (b"unknown warning option" in o))] =
=3D=3D [ ]
> > > > > > > >  if cc_is_clang:
> > > > > > > >      from sysconfig import get_config_vars
> > > > > > > > @@ -63,6 +63,8 @@ cflags =3D getenv('CFLAGS', '').split()
> > > > > > > >  cflags +=3D ['-fno-strict-aliasing', '-Wno-write-strings',=
 '-Wno-unused-parameter', '-Wno-redundant-decls' ]
> > > > > > > >  if cc_is_clang:
> > > > > > > >      cflags +=3D ["-Wno-unused-command-line-argument" ]
> > > > > > > > +    if clang_has_option("-Wno-cast-function-type-mismatch"=
):
> > > > > > > > +        cflags +=3D ["-Wno-cast-function-type-mismatch" ]
> > > > > > > >  else:
> > > > > > > >      cflags +=3D ['-Wno-cast-function-type' ]
> > > > > >
> > > > > > > I tried with your diff with SLIM LLVM toolchains 18 and 19.
> > > > > >
> > > > > > > Both work - see attached build-logs.
> > > > > >
> > > > > > > Yes, are right that LLVM/Clang v19 was first introducing:
> > > > > >
> > > > > > > -Wcast-function-type-mismatch / -Wno-cast-function-type-misma=
tch
> > > > > >
> > > > > > > [4] says for LLVM 18.1.8:
> > > > > >
> > > > > > > -Wcast-function-type
> > > > > > > -Wcast-function-type-strict
> > > > > >
> > > > > > > Feel free to add my Reported-by/Tested-by credentials if you =
sent a full patch.
> > > > > >
> > > > > > Thanks for the report and test of the fix, I'll add both tags,
> > > > >
> > > > > So below is the part that deals with disabling the warning if pre=
sent,
> > > > > the other patch supporting checking warning options I merged as a=
 prep
> > > > > patch.
> > > > >
> > > > > Thanks!
> > > > >
> > > > > - Arnaldo
> > > > >
> > > > > From 155212c965b5b23a90b8558449dbfd1c60dad934 Mon Sep 17 00:00:00=
 2001
> > > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > Date: Thu, 22 Aug 2024 14:13:49 -0300
> > > > > Subject: [PATCH 1/1] perf python: Disable -Wno-cast-function-type=
-mismatch if
> > > > >  present on clang
> > > > >
> > > > > The -Wcast-function-type-mismatch option was introduced in clang =
19 and
> > > > > its enabled by default, since we use -Werror, and python bindings=
 do
> > > > > casts that are valid but trips this warning, disable it if presen=
t.
> > > > >
> > > > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > Cc: Ian Rogers <irogers@google.com>
> > > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8=
U9uy3r2MzKXwTA5THtL7w@mail.gmail.com
> > > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > ---
> > > > >  tools/perf/util/setup.py | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> > > > > index 26c0f2614fe92eb6..649550e9b7aa8c8f 100644
> > > > > --- a/tools/perf/util/setup.py
> > > > > +++ b/tools/perf/util/setup.py
> > > > > @@ -63,6 +63,8 @@ cflags =3D getenv('CFLAGS', '').split()
> > > > >  cflags +=3D ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno=
-unused-parameter', '-Wno-redundant-decls' ]
> > > > >  if cc_is_clang:
> > > > >      cflags +=3D ["-Wno-unused-command-line-argument" ]
> > > > > +    if clang_has_option("-Wno-cast-function-type-mismatch"):
> > > > > +        cflags +=3D ["-Wno-cast-function-type-mismatch" ]
> > > > >  else:
> > > > >      cflags +=3D ['-Wno-cast-function-type' ]
> > > > >
> > > > > --
> > > > > 2.46.0
> > > > >
> > > >
> > > > Thanks for the patch, Arnanldo.
> > > >
> > > > @Nathan Chancellor
> > > > What was the b4 magic to retrieve a patch included in a ML thread?
> > > >
> > > > I tried:
> > > >
> > > > link=3D"https://lore.kernel.org/all/CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2h=
aFneX0C5pUMUUhG-UVKQ@mail.gmail.com/"
> > > >
> > > > b4 am $link
> > > > Grabbing thread from
> > > > lore.kernel.org/all/CA%2BicZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUh=
G-UVKQ@mail.gmail.com/t.mbox.gz
> > > > Analyzing 9 messages in the thread
> > > > No patches found.
> > >
> > > I use:
> > >
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers CA=
+icZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com
> > > Grabbing thread from lore.kernel.org/all/CA%2BicZUURwYd8nJSdMU7KW6nFj=
ubi-VD2f-a5%2BzQNQGUxK7%2B2aw@mail.gmail.com/t.mbox.gz
> > > Analyzing 10 messages in the thread
> > > No patches found.
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$
> > >
> > > Using the Message-ID for your message, which normally is enough, but =
I
> > > think I didn't separate the patch from the rest of the message with -=
--.
> > >
> > > Lemme try...
> > >
> > > ---
> > >
> > > From 155212c965b5b23a90b8558449dbfd1c60dad934 Mon Sep 17 00:00:00 200=
1
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Date: Thu, 22 Aug 2024 14:13:49 -0300
> > > Subject: [PATCH 1/1] perf python: Disable -Wno-cast-function-type-mis=
match if
> > >  present on clang
> > >
> > > The -Wcast-function-type-mismatch option was introduced in clang 19 a=
nd
> > > its enabled by default, since we use -Werror, and python bindings do
> > > casts that are valid but trips this warning, disable it if present.
> > >
> > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy=
3r2MzKXwTA5THtL7w@mail.gmail.com
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > >  tools/perf/util/setup.py | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> > > index 26c0f2614fe92eb6..649550e9b7aa8c8f 100644
> > > --- a/tools/perf/util/setup.py
> > > +++ b/tools/perf/util/setup.py
> > > @@ -63,6 +63,8 @@ cflags =3D getenv('CFLAGS', '').split()
> > >  cflags +=3D ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unu=
sed-parameter', '-Wno-redundant-decls' ]
> > >  if cc_is_clang:
> > >      cflags +=3D ["-Wno-unused-command-line-argument" ]
> > > +    if clang_has_option("-Wno-cast-function-type-mismatch"):
> > > +        cflags +=3D ["-Wno-cast-function-type-mismatch" ]
> > >  else:
> > >      cflags +=3D ['-Wno-cast-function-type' ]
> > >
> > > --
> > > 2.46.0
> > >
> >
> > Hmm, OK.
> >
> > My first posting:
> > https://lore.kernel.org/all/CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMU=
UhG-UVKQ@mail.gmail.com/
> >
> > $ b4 am -ctsl --cc-trailers
> > CA+icZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com
> > Grabbing thread from
> > lore.kernel.org/all/CA%2BicZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5%2BzQNQGUxK7=
%2B2aw@mail.gmail.com/t.mbox.gz
> > Checking for newer revisions
> > Grabbing search results from lore.kernel.org
> > Analyzing 11 messages in the thread
> > No patches found.
> >
> > Did you drop that part by accident or intentionally from the patch?
>
> I mentioned that:
>
> > > > > the other patch supporting checking warning options I merged as a=
 prep
> > > > > patch.
>
> Please take a look at tmp.perf-tools-next at:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git log perf-tools-next/tmp.perf=
-tools-next -2 --oneline
> 155212c965b5b23a (perf-tools-next/tmp.perf-tools-next, perf-tools-next.ko=
rg/tmp.perf-tools-next, acme.korg/tmp.perf-tools-next) perf python: Disable=
 -Wno-cast-function-type-mismatch if present on clang
> b81162302001f411 perf python: Allow checking for the existence of warning=
 options in clang
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> One patch introduces a mechanism, the other uses it.
>
> - Arnaldo

OK, I see.

$ git log --oneline tags/v6.11-rc4..
eb942ec78d54 (HEAD -> for-6.11/perf-python-clang19-fixes-acme) perf
python: Disable -Wno-cast-function-type-mismatch if present on clang
579d6e9735d4 perf python: Allow checking for the existence of warning
options in clang

-Sedat-
