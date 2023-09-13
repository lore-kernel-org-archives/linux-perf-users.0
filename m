Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F73EE0211
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Sep 2023 23:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjIMXYX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Sep 2023 19:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjIMXYW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Sep 2023 19:24:22 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705AE1BCC
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2023 16:24:18 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41761e9181eso10251cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2023 16:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694647457; x=1695252257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4L2DCL/mifd2+VI52Ilf7k2pafo1lSl/LHLgMOO83Q=;
        b=d9ppuansxCkeaqWdlOyVzh919PqnbFRP7j5RmlwgAHfqaJIdVS5/T9pUUF+jzd0xSa
         u9Q3mEl1hGF6b0Q8CA6Mui4YtZO0mRHCmpOYUEpUuRTmK5aVokH7OOtszusuVkdlwx7H
         1yoKpY+swupBtep2mJWDnrGVkYVJn1qoPpVVBu6qkzYzHjFQ6gE6eVXpIwgmmTciAQ6B
         ZSmwdkpejBG+JSdS754GxCKt6d/m0bwFCfkTvWTnHVIQ+o7967zpEM80D1WL993gdi69
         rNrBSoWdyXHIgtb4mWwUCKAgEzK5ah9zzudSlJoTONW1gmg/0WY2K5+0rWa3K4wxY+JW
         hIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694647457; x=1695252257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4L2DCL/mifd2+VI52Ilf7k2pafo1lSl/LHLgMOO83Q=;
        b=W2U4LNxNotyx+3eRnaOp/a/bQvbHKtRX0TQW9sbGXajlzxHtYeZjeca34RB5xN1OGd
         ZrlCmqoNvwjFWfb/Dca13Ilnh6VMAYPmwE2lJqbQzf1inJH1fSsKa3Bg4LKFKS/za0H0
         rNoMI54ZMd9Jt7YDv7JjernJ86bGC5BcX8XaaJdvvmIgpQmt4WH+HaaJbaB/if3qTNSa
         +gp+sBVo0qC4rkTTrHpCceRCAfw6Bad2I0udE0fNqdP3hKVfZxnTTkH4hAGGlmnTHS2X
         DYCUiTkKNN5b7sPZPGfqPWip9misRnSWZY9dWyFhNQz0eCP9UKhvAltZzO3aCOLecHGN
         4cRg==
X-Gm-Message-State: AOJu0YwsxB7tkpxjfbBQG+XvUqChkfSjh+0DEMjYenzBmzh4UDtJQA3A
        ZSTvJJEbvTrymCb7iV5ydmF91asy4wPiVNDU0Dlvtg==
X-Google-Smtp-Source: AGHT+IHltBTmYGbmbGfCXqJncsLjjkdbQXd1v3vr+uIrhuxi7JXc9CH2r7XXbJGJ0qUORK5lID309eZycS6JJ+RwxnQ=
X-Received: by 2002:ac8:7d56:0:b0:410:9af1:f9b4 with SMTP id
 h22-20020ac87d56000000b004109af1f9b4mr474796qtb.10.1694647457361; Wed, 13 Sep
 2023 16:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230908052216.566148-1-namhyung@kernel.org> <CAP-5=fUtEvW9h7N=w3vvYBB3vytnTXJsXrHDD6zLA2DzYFOBHQ@mail.gmail.com>
 <CAM9d7cj1rEjGy0QM2tkJhBn=hac-9Jya+ZJ4SNhBmB29u5KVMg@mail.gmail.com>
 <ad8a8d46151142a883d2d259c884acc0@AcuMS.aculab.com> <CAM9d7ciB-Rmsi4eTOU7n=mcEP2-JjDycL6f_8cKnKGKtqVT3UQ@mail.gmail.com>
In-Reply-To: <CAM9d7ciB-Rmsi4eTOU7n=mcEP2-JjDycL6f_8cKnKGKtqVT3UQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 13 Sep 2023 16:24:01 -0700
Message-ID: <CAP-5=fU=8RwHsd=nP6evT2oxCeOvXF4dfNF9MhBVk3y2WvH3MQ@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Add more x86 mov instruction cases
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 13, 2023 at 2:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Sep 11, 2023 at 1:12=E2=80=AFAM David Laight <David.Laight@aculab=
.com> wrote:
> >
> > From: Namhyung Kim
> > > Sent: 09 September 2023 00:56
> > >
> > > Hi Ian,
> > >
> > > On Thu, Sep 7, 2023 at 11:24=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > On Thu, Sep 7, 2023 at 10:22=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > Instructions with sign- and zero- extention like movsbl and movzw=
q were
> > > > > not handled properly.  As it can check different size suffix (-b,=
 -w, -l
> > > > > or -q) we can omit that and add the common parts even though some
> > > > > combinations are not possible.
> > > > >
> > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > ---
> > > > >  tools/perf/arch/x86/annotate/instructions.c | 9 ++++++---
> > > > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/arch/x86/annotate/instructions.c
> > > b/tools/perf/arch/x86/annotate/instructions.c
> > > > > index 5f4ac4fc7fcf..5cdf457f5cbe 100644
> > > > > --- a/tools/perf/arch/x86/annotate/instructions.c
> > > > > +++ b/tools/perf/arch/x86/annotate/instructions.c
> > > > > @@ -74,12 +74,15 @@ static struct ins x86__instructions[] =3D {
> > > > >         { .name =3D "movdqa",     .ops =3D &mov_ops,  },
> > > > >         { .name =3D "movdqu",     .ops =3D &mov_ops,  },
> > > > >         { .name =3D "movsd",      .ops =3D &mov_ops,  },
> > > > > -       { .name =3D "movslq",     .ops =3D &mov_ops,  },
> > > > >         { .name =3D "movss",      .ops =3D &mov_ops,  },
> > > > > +       { .name =3D "movsb",      .ops =3D &mov_ops,  },
> > > > > +       { .name =3D "movsw",      .ops =3D &mov_ops,  },
> > > > > +       { .name =3D "movsl",      .ops =3D &mov_ops,  },
> > > >
> > > > In Intel's manual some of these names are "Move Data From String to
> > > > String" operations, movsb and movsw in particular. These instructio=
ns
> > > > can be used to make simple memcpy loops. Could it be the past omiss=
ion
> > > > was deliberate due to the different way the addressing works in the
> > > > instructions?
> > >
> > > I don't know but in terms of instruction parsing, they are the same
> > > "MOVE" with two operands.  I'm not aware of anything in perf with
> > > the operands of these instructions.  So I guess it'd be fine to add
> > > these instructions even if they have different underlying behaviors.
> >
> > I'm pretty sure that 'rep movs[bwlq]' (aka while (cx--) *di++ =3D *si++=
)
> > is likely to be missing the memory argument parameters.
> > There is also 'fun and games' with one variant - iirc 'rep movsd'
> > what has been used for 64bit, but got hijacked by one of the SIMD sets.
>
> It seems perf annotate don't process the rep prefix yet.
> So I think there should be no functional change now.

Reading the code, I also think it should be okay. Doing:
```
$ objdump -d /usr/lib/x86_64-linux-gnu/libc.so.6 |grep rep
   2650a:       f3 ab                   rep stos %eax,%es:(%rdi)
   33b76:       f3 48 a5                rep movsq %ds:(%rsi),%es:(%rdi)
...
```
The mov parsing logic doesn't appear to care about src and dest, and
the formatting above matches other mov cases.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Thanks,
> Namhyung
