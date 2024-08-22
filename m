Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BED1CCB4B;
	Thu, 22 Aug 2024 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347956; cv=none; b=lb6yWV/VnwbozOx826i9s0t2MtM1Mx8RXMFDMXqMB3YTbflF5/aJ9yxOAMp5+zxQrWd7b9hM6qGAJqMXZzXBL4/MsetkLetO7MHZXB6xIMUfsm8dggruO/xAufsDxJs1FhJfkjZqkbpO9QWyzik2ZzdgAgkGsZ9LTm2cNk5S0l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347956; c=relaxed/simple;
	bh=KqEy9a0cVctATAmn+Dpx0fyqBgFKWOx+lv8yPBlOcf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQSMdatLd1gn7AxgxkD1c0w4GiCkv2SSfSsMW94x2ikTeSml7p9+vsx3hUVI00yuA/EXXPPoKPL8WE0OjY6FJGIPZx27vWZqSabOaCXzieePCGVYywd2SRZ9g3z5oijgWynBVC7LbOknENvDO74mXHkW7A8kU5kEwM2r10QcNb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZKRgz6a; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZKRgz6a"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f3cd4ebf84so12765731fa.3;
        Thu, 22 Aug 2024 10:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724347952; x=1724952752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b1ajxmMCImhOILqCTIlNfWtYSVDFX5RKyWwmvdyA46g=;
        b=iZKRgz6aWZ5yAEQ/ws8ThUYxddyO99TDbFvIzcmBpSX7xo34F75NQeIKU84lWOKbqQ
         n31SSMbUff63cbW5mVXpNiZv4XTsSKkgXcCeEseAMSEGvxKI1HWDLjZRmbWJc0rws/fK
         jvcJAM/7/lnVFcwcnXGK8F6B2ND13UbXvwGzwQJpmHINeTTq200KzjuukqyohUGas8N8
         /rqt2ePVxgiS6t6meQIUsXlBP1lHx8Aayj96VdJRN9OIGRB7+BU7u0s0Agq/MfjlhdvS
         bhBbxLJJSJKfOb+rfj04P4omUTVZ8+SAx3y043pbOE9Cdg5LM1l0v8CRdUwh4vwpSIgG
         pZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347952; x=1724952752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1ajxmMCImhOILqCTIlNfWtYSVDFX5RKyWwmvdyA46g=;
        b=FVb6ReH3cIZ8YkkFpzHkMxM5y19m/4yL7h9tpJGBdXGmyfLWtwfI4zhTP6JmJ+ng/U
         eembaQtnvx/9r/z5PrRI1fobBxCenClOOWlWiBBU1HVBdixR9pBIIszvfVpjrWpE0Non
         ipTmuBCJ/AlS6OZzNsLFIXLh+t6kkIFSKIiphIdcHA03vnEvewTJUHFA4OOytvm+uF6i
         SDdLVmLQYG7lBhyQ+sckXnqycZJ9TyTqVSn2CqtgIGtIKyaO0Tpis206KdUeiBgSgCa6
         qyTBDXQjbKj/3R3sAvwS+wxLR9g8jTrfy7WAgxBqQ92ONR98Iw4auGHkn2HYv6obS0zL
         weTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGJnRIC42dCX0gKZ2vw490I/rXZGs63jjYn7kFp0QCQcBHvs7CR03iX9jUBRbzRgpl/I8G8bLuyMfO9BNs4u4f8A==@vger.kernel.org, AJvYcCWxyeeTozFhEUXJVM0J508CtQp13GV02rU8R/x60LGruLSj1RuKxE+hSymzYe3t2so5T2Cm8LBPh0uNFok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRfhyqFojIz14ReuCU+nHbqeU2Vl3PrX1ap23pu7Suvio63CzW
	rVKA/G0o7ticTKBmWPuKozerNNpcb4h8NSrdn3LueLupJk95ubzFr1ixR1jbHswdHw8eUg+nd2G
	WWoQKIJebuFIVIE1+JF6EcwCTDzmz1nhKNkM=
X-Google-Smtp-Source: AGHT+IE3XmhYamZ9CrZ3eNEXIDcL6FzB/72KGSJSc7RQKCe9Fydp5OVgKtyHiYDLovVbwCQvruhx96RWo1f6S3/QDt8=
X-Received: by 2002:a2e:e09:0:b0:2ef:265e:bb8b with SMTP id
 38308e7fff4ca-2f3f8862cbbmr38414261fa.18.1724347951536; Thu, 22 Aug 2024
 10:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com>
 <ZsdKhLaPy-uzKsuH@x1> <ZsdUxxBrpbuYxtXN@x1> <CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com>
 <ZsdxinrZP1kHINWT@x1> <ZsdzLmIFWRqsXeXD@x1>
In-Reply-To: <ZsdzLmIFWRqsXeXD@x1>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 22 Aug 2024 19:31:55 +0200
Message-ID: <CA+icZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 7:19=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Aug 22, 2024 at 02:12:46PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Aug 22, 2024 at 07:02:52PM +0200, Sedat Dilek wrote:
> > > On Thu, Aug 22, 2024 at 5:10=E2=80=AFPM Arnaldo Carvalho de Melo <acm=
e@kernel.org> wrote:
> > > > +++ b/tools/perf/util/setup.py
> > > > @@ -17,7 +17,7 @@ src_feature_tests  =3D getenv('srctree') + '/tool=
s/build/feature'
> >
> > > >  def clang_has_option(option):
> > > >      cc_output =3D Popen([cc, cc_options + option, path.join(src_fe=
ature_tests, "test-hello.c") ], stderr=3DPIPE).stderr.readlines()
> > > > -    return [o for o in cc_output if ((b"unknown argument" in o) or=
 (b"is not supported" in o))] =3D=3D [ ]
> > > > +    return [o for o in cc_output if ((b"unknown argument" in o) or=
 (b"is not supported" in o) or (b"unknown warning option" in o))] =3D=3D [ =
]
> > > >  if cc_is_clang:
> > > >      from sysconfig import get_config_vars
> > > > @@ -63,6 +63,8 @@ cflags =3D getenv('CFLAGS', '').split()
> > > >  cflags +=3D ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-u=
nused-parameter', '-Wno-redundant-decls' ]
> > > >  if cc_is_clang:
> > > >      cflags +=3D ["-Wno-unused-command-line-argument" ]
> > > > +    if clang_has_option("-Wno-cast-function-type-mismatch"):
> > > > +        cflags +=3D ["-Wno-cast-function-type-mismatch" ]
> > > >  else:
> > > >      cflags +=3D ['-Wno-cast-function-type' ]
> >
> > > I tried with your diff with SLIM LLVM toolchains 18 and 19.
> >
> > > Both work - see attached build-logs.
> >
> > > Yes, are right that LLVM/Clang v19 was first introducing:
> >
> > > -Wcast-function-type-mismatch / -Wno-cast-function-type-mismatch
> >
> > > [4] says for LLVM 18.1.8:
> >
> > > -Wcast-function-type
> > > -Wcast-function-type-strict
> >
> > > Feel free to add my Reported-by/Tested-by credentials if you sent a f=
ull patch.
> >
> > Thanks for the report and test of the fix, I'll add both tags,
>
> So below is the part that deals with disabling the warning if present,
> the other patch supporting checking warning options I merged as a prep
> patch.
>
> Thanks!
>
> - Arnaldo
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

Thanks for the patch, Arnanldo.

@Nathan Chancellor
What was the b4 magic to retrieve a patch included in a ML thread?

I tried:

link=3D"https://lore.kernel.org/all/CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5=
pUMUUhG-UVKQ@mail.gmail.com/"

b4 am $link
Grabbing thread from
lore.kernel.org/all/CA%2BicZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@m=
ail.gmail.com/t.mbox.gz
Analyzing 9 messages in the thread
No patches found.

-Sedat-
