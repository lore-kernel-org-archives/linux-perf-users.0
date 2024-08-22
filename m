Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D946FB9;
	Thu, 22 Aug 2024 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349594; cv=none; b=fNxFfIVCzlIuNNDBzrA0/oC3cogGDNDUDjt58jju5sRQQePbj0tUx8BVeZ1T694iESBjqJWsAxCmhfj3JMsnxyuOIbrOcbU0y8NQmnz9RieD5BO3eRQBWcTxg3mJUZEVN9K3PKNUkqWiU9AnsjCWjIQrVmYL9wuGyenES5alx18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349594; c=relaxed/simple;
	bh=7rVIW7IMx9w7++WRw0BkF75OnYYNqvRHDpxgxeC6Qd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWPXJ/HrEpPoViHlOgl0k24i94uMEkzGgb4ftQSq5dJI4pHTF8ClH0Kki68k2hJnP8w+q3FNU2LwI++Ip8CW27N4ba7LFncqiDbewuQkLwSbeZAfgig7CZtb+JNSPqzLaBHidAEEPUhC9Ee/wLULG0VDiHfGt3n6SHrU2O3gnF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foo7cFCW; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foo7cFCW"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5334c4d6829so1489720e87.2;
        Thu, 22 Aug 2024 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724349590; x=1724954390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=57cklGDVnkv8uwWUWyzqQh1MVRQtAEfOjUoSrZ1n9ec=;
        b=foo7cFCWt0yKakKG0m5+EFuEyk3S7MRsTU2UDxsnnePdCFVGqTavRnCQ8+ChrgaNz7
         gv4XVSCXDdDhfSolD5WUMMG8YY3n1eHnsW51AJT+/lh7wFFi8oylaBWzO51scaE+qq2V
         8m3xXSM0dam42Xmd6yPgWo9n5iOilAGNmmMIhGVXRnvndVZ7HV1Uxj1M9MN65V0Q5SVv
         qBHVpn/AvMrnH3hvUyulV3DH46ViPGQual5TIg1K4OR9cIenB9+pLKqnBsllkiTARBWy
         Ysqj4XSDHShxdnq/ay4sv7Vr5mJie8MnvrTKLx1gq39ey2yVkgMFnJXKdB+IKUYRhTS+
         ftTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724349590; x=1724954390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57cklGDVnkv8uwWUWyzqQh1MVRQtAEfOjUoSrZ1n9ec=;
        b=Qpw41iCunEGkV44tNeDi3smVtlzGZR+qm+v5MxiJSHFsmELWh9b60bMtUhaigjf8QD
         bAzmxhbGPHZeQTypy0VslpCQuUSMXh/IO67/09xS3Y+4fOfjsE+rZWTY+KDUu7d1Rc1z
         C09REpi2xrQfxzfYx1l487Os3A37nXzECgTtSPCAP/VsjUcwSj2TVdXxnUqqaKmWru7z
         M9F1Jf2gFitlKDLtwZ0//Wk7vVAHOy9mJAThU9DuDFO2GhvAwOF5FO94906pme/80DnS
         V9WRjxBK3tY5Ts+3+2RmbrWFkmK3kRErySYYADba6nzE8rmgfRoHygr68y6N9P76Ww/N
         WUfg==
X-Forwarded-Encrypted: i=1; AJvYcCUHEU44XMilTtbW2XQkY6dzSN4TT/PVh5hEXI4L7Wvu5cuRTe1VK5ZvfHEVKx6PSIP/fCeDJ/wIzzp/LgM=@vger.kernel.org, AJvYcCVrKjAKjZgXlFs9A5MSuvzJYuC4eywx7kbcsOcNJFRhUVZatoom+qRRPXVEAUc4lEuHtmZjCBqfkzX/r6ZDQYHs/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrJVworYprleOTj1PvJk5OH0vszvsn1rioylSiI4bbLFzW+L6d
	XvFfFz0lDmDd6WmuvRQghEy9fl/60MCkrRFBjMgeVxOL9QE522dPBabYVIm3k4B46F+s/xv72J+
	VJsTBlWSuN3gVY7xAy75Mq8Oc8Hc=
X-Google-Smtp-Source: AGHT+IFx6VUsWhGx+Xq4Kp0jx81gmOwn+Nqab4uFvJOn1erJmFXX1OnBrG46e93xlCR1AZgqjABeVNXEifvNTUPczLQ=
X-Received: by 2002:a05:6512:3b88:b0:52c:d84b:eee6 with SMTP id
 2adb3069b0e04-53348590d45mr4369818e87.38.1724349590037; Thu, 22 Aug 2024
 10:59:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com>
 <ZsdKhLaPy-uzKsuH@x1> <ZsdUxxBrpbuYxtXN@x1> <CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com>
 <ZsdxinrZP1kHINWT@x1> <ZsdzLmIFWRqsXeXD@x1> <CA+icZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com>
 <Zsd39zG9BuGpZ8aA@x1>
In-Reply-To: <Zsd39zG9BuGpZ8aA@x1>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 22 Aug 2024 19:59:13 +0200
Message-ID: <CA+icZUXGV9dMGcRwJiP7WLcYUaY5CRCcDw1HLFr+9Sn7CrRGDw@mail.gmail.com>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 7:40=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Aug 22, 2024 at 07:31:55PM +0200, Sedat Dilek wrote:
> > On Thu, Aug 22, 2024 at 7:19=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Thu, Aug 22, 2024 at 02:12:46PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > On Thu, Aug 22, 2024 at 07:02:52PM +0200, Sedat Dilek wrote:
> > > > > On Thu, Aug 22, 2024 at 5:10=E2=80=AFPM Arnaldo Carvalho de Melo =
<acme@kernel.org> wrote:
> > > > > > +++ b/tools/perf/util/setup.py
> > > > > > @@ -17,7 +17,7 @@ src_feature_tests  =3D getenv('srctree') + '/=
tools/build/feature'
> > > >
> > > > > >  def clang_has_option(option):
> > > > > >      cc_output =3D Popen([cc, cc_options + option, path.join(sr=
c_feature_tests, "test-hello.c") ], stderr=3DPIPE).stderr.readlines()
> > > > > > -    return [o for o in cc_output if ((b"unknown argument" in o=
) or (b"is not supported" in o))] =3D=3D [ ]
> > > > > > +    return [o for o in cc_output if ((b"unknown argument" in o=
) or (b"is not supported" in o) or (b"unknown warning option" in o))] =3D=
=3D [ ]
> > > > > >  if cc_is_clang:
> > > > > >      from sysconfig import get_config_vars
> > > > > > @@ -63,6 +63,8 @@ cflags =3D getenv('CFLAGS', '').split()
> > > > > >  cflags +=3D ['-fno-strict-aliasing', '-Wno-write-strings', '-W=
no-unused-parameter', '-Wno-redundant-decls' ]
> > > > > >  if cc_is_clang:
> > > > > >      cflags +=3D ["-Wno-unused-command-line-argument" ]
> > > > > > +    if clang_has_option("-Wno-cast-function-type-mismatch"):
> > > > > > +        cflags +=3D ["-Wno-cast-function-type-mismatch" ]
> > > > > >  else:
> > > > > >      cflags +=3D ['-Wno-cast-function-type' ]
> > > >
> > > > > I tried with your diff with SLIM LLVM toolchains 18 and 19.
> > > >
> > > > > Both work - see attached build-logs.
> > > >
> > > > > Yes, are right that LLVM/Clang v19 was first introducing:
> > > >
> > > > > -Wcast-function-type-mismatch / -Wno-cast-function-type-mismatch
> > > >
> > > > > [4] says for LLVM 18.1.8:
> > > >
> > > > > -Wcast-function-type
> > > > > -Wcast-function-type-strict
> > > >
> > > > > Feel free to add my Reported-by/Tested-by credentials if you sent=
 a full patch.
> > > >
> > > > Thanks for the report and test of the fix, I'll add both tags,
> > >
> > > So below is the part that deals with disabling the warning if present=
,
> > > the other patch supporting checking warning options I merged as a pre=
p
> > > patch.
> > >
> > > Thanks!
> > >
> > > - Arnaldo
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
> > Thanks for the patch, Arnanldo.
> >
> > @Nathan Chancellor
> > What was the b4 magic to retrieve a patch included in a ML thread?
> >
> > I tried:
> >
> > link=3D"https://lore.kernel.org/all/CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFne=
X0C5pUMUUhG-UVKQ@mail.gmail.com/"
> >
> > b4 am $link
> > Grabbing thread from
> > lore.kernel.org/all/CA%2BicZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UV=
KQ@mail.gmail.com/t.mbox.gz
> > Analyzing 9 messages in the thread
> > No patches found.
>
> I use:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers CA+icZ=
UURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com
> Grabbing thread from lore.kernel.org/all/CA%2BicZUURwYd8nJSdMU7KW6nFjubi-=
VD2f-a5%2BzQNQGUxK7%2B2aw@mail.gmail.com/t.mbox.gz
> Analyzing 10 messages in the thread
> No patches found.
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> Using the Message-ID for your message, which normally is enough, but I
> think I didn't separate the patch from the rest of the message with ---.
>
> Lemme try...
>
> ---
>
> From 155212c965b5b23a90b8558449dbfd1c60dad934 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Thu, 22 Aug 2024 14:13:49 -0300
> Subject: [PATCH 1/1] perf python: Disable -Wno-cast-function-type-mismatc=
h if
>  present on clang
>
> The -Wcast-function-type-mismatch option was introduced in clang 19 and
> its enabled by default, since we use -Werror, and python bindings do
> casts that are valid but trips this warning, disable it if present.
>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2M=
zKXwTA5THtL7w@mail.gmail.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/setup.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index 26c0f2614fe92eb6..649550e9b7aa8c8f 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -63,6 +63,8 @@ cflags =3D getenv('CFLAGS', '').split()
>  cflags +=3D ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-=
parameter', '-Wno-redundant-decls' ]
>  if cc_is_clang:
>      cflags +=3D ["-Wno-unused-command-line-argument" ]
> +    if clang_has_option("-Wno-cast-function-type-mismatch"):
> +        cflags +=3D ["-Wno-cast-function-type-mismatch" ]
>  else:
>      cflags +=3D ['-Wno-cast-function-type' ]
>
> --
> 2.46.0
>

Hmm, OK.

My first posting:
https://lore.kernel.org/all/CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-=
UVKQ@mail.gmail.com/

$ b4 am -ctsl --cc-trailers
CA+icZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com
Grabbing thread from
lore.kernel.org/all/CA%2BicZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5%2BzQNQGUxK7%2B2=
aw@mail.gmail.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 11 messages in the thread
No patches found.

Did you drop that part by accident or intentionally from the patch?

 def clang_has_option(option):
    cc_output =3D Popen([cc, cc_options + option,
path.join(src_feature_tests, "test-hello.c") ],
stderr=3DPIPE).stderr.readlines()
-    return [o for o in cc_output if ((b"unknown argument" in o) or
(b"is not supported" in o))] =3D=3D [ ]
+    return [o for o in cc_output if ((b"unknown argument" in o) or
(b"is not supported" in o) or (b"unknown warning option" in o))] =3D=3D [
]

Thank for all.

-Sedat-
