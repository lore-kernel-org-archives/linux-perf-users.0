Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ED9EB64D9
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Jul 2023 15:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjGFP6N (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Jul 2023 11:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjGFP6M (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Jul 2023 11:58:12 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192F01BD0
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Jul 2023 08:58:10 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40371070eb7so295391cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Jul 2023 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688659089; x=1691251089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/q3P7CS9uJYb3EpqCqB4dU/m8Tw67KDptXeIckI6/I=;
        b=qOVVnvz1Y7U8AnM0HlDDFWVHldI36d4YXweD21ynFw1Sgrz7XkG4iz6bvnuAzbqMvU
         AeGPJdTQ/rcAzZfVig9JPhJiA42Hx5k6+z0lifS0Xg44ppSAYakqfsVJrBJwXRXn3Dbu
         kISCU8SzAS2sMhbgl43Q0zMvUhHfbbu0UcyIbEtdU0lpNjSpTvSVrn86ymR/aX8Jug9U
         1/UFyAWajx7SjWeeWaSyTh8pNyVXS1VbJBGT5l3cY1gcmLaMbbiQ7G2OQrZVipgL1aP7
         oHk6KqLJ63PjD0OdkP3SGn3QSW3aYbgkhupplcOmSDe4wHahgcOJt0eLQlAs0HFNjYJl
         xqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688659089; x=1691251089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/q3P7CS9uJYb3EpqCqB4dU/m8Tw67KDptXeIckI6/I=;
        b=VKWxwamT5wue54KYmInNSFPrhAOO6QkpQI/ooNiLJwfGZ1JtaOjUR+ruy5XJ3qhVsQ
         Gb4vhuYyqquRlS9WRvtRNk0LCEGY48aICvMUknnEC3y6fXjTQ8isqruDt3UOhQL4ekTn
         CNh9QaUYSehfw6avcPSxFpBPkWOuWJQX3jEoHkS0iJ/kLGNCiOtqNKQJD0wm7k1bwPyk
         bGXEmfIcQnYVoGxMEfwC74mYWJOpMACr+nwN2KEmkbjKM3iJEn5B+N5/2o+p4D63O6Cl
         A/b88N4Zk8r1ntWLK4P0lN9COY1R9Zuxf4uD7LQDzSxJcAuB2N6cn53NLr56deKn3F92
         nE9Q==
X-Gm-Message-State: ABy/qLY3+jgbIVIdnSaUdbml1SOUOYsou/H+XQPTatvy3rRH1LgPxS1X
        Cmd65FBZKXvKCat4LcuZSMYDuA6m9UHuo990RefXTQ==
X-Google-Smtp-Source: APBJJlEamxJvcPH3ytPHOCsBY9gPtDu/+sjexDcIF/Pjl5o/bPOpa+l1OGJzteQPkUyXknGHwfUp30kVY4KcCASP0Fs=
X-Received: by 2002:a05:622a:15ca:b0:403:58e8:2d96 with SMTP id
 d10-20020a05622a15ca00b0040358e82d96mr143699qty.7.1688659089064; Thu, 06 Jul
 2023 08:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687375189.git.anupnewsmail@gmail.com> <4d0ac80521ebd44322a360ac331ce2443a1f0f26.1687375189.git.anupnewsmail@gmail.com>
 <CAM9d7cgAfvzrGiU0QiEigTAYKMe+OEP0b3o3Xd-0VhXX5Wkx1g@mail.gmail.com> <ZKXMJFckLMcGcVkP@yoga>
In-Reply-To: <ZKXMJFckLMcGcVkP@yoga>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 6 Jul 2023 08:57:57 -0700
Message-ID: <CAP-5=fUhC7NOxvE=gJFVFU3HtsMe2Jr2uR8ftmozaGtbWn0Ajg@mail.gmail.com>
Subject: Re: [PATCH 7/9] scripts: python: implement get or create frame function
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 5, 2023 at 1:01=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.com>=
 wrote:
>
> On Fri, Jun 23, 2023 at 05:04:56PM -0700, Namhyung Kim wrote:
> > On Wed, Jun 21, 2023 at 12:45=E2=80=AFPM Anup Sharma <anupnewsmail@gmai=
l.com> wrote:
> > >
> > > The CATEGORIES list and the USER_CATEGORY_INDEX and
> > > KERNEL_CATEGORY_INDEX constants has been introduced.
> > >
> > > The get_or_create_frame function is responsible for retrieving or
> > > creating a frame based on the provided frameString. If the frame
> > > corresponding to the frameString is found in the frameMap, it is
> > > returned. Otherwise, a new frame is created by appending relevant
> > > information to the frameTable's 'data' array and adding the
> > > frameString to the stringTable.
> > >
> > > The index of the newly created frame is added to the frameMap.
> > >
> > > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> > > ---
> > >  .../scripts/python/firefox-gecko-converter.py | 38 +++++++++++++++++=
++
> > >  1 file changed, 38 insertions(+)
> > >
> > > diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/t=
ools/perf/scripts/python/firefox-gecko-converter.py
> > > index 30fc542cfdeb..866751e5d1ce 100644
> > > --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> > > +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> > > @@ -15,6 +15,13 @@ def isPerfScriptFormat(profile):
> > >      firstLine =3D profile[:profile.index('\n')]
> > >      return bool(re.match(r'^\S.*?\s+(?:\d+/)?\d+\s+(?:\d+\d+\s+)?[\d=
.]+:', firstLine))
> > >
> > > +CATEGORIES =3D [
> > > +{'name': 'User', 'color': 'yellow', 'subcategories': ['Other']},
> > > +{'name': 'Kernel', 'color': 'orange', 'subcategories': ['Other']}
> > > +]
> > > +USER_CATEGORY_INDEX =3D 0
> > > +KERNEL_CATEGORY_INDEX =3D 1
> > > +
> > >  def convertPerfScriptProfile(profile):
> > >      def _createtread(name, pid, tid):
> > >          markers =3D {
> > > @@ -70,6 +77,37 @@ def convertPerfScriptProfile(profile):
> > >                  stackMap[key] =3D stack
> > >              return stack
> > >
> > > +        frameMap =3D dict()
> > > +        def get_or_create_frame(frameString):
> > > +            frame =3D frameMap.get(frameString)
> > > +            if frame is None:
> > > +                frame =3D len(frameTable['data'])
> > > +                location =3D len(stringTable)
> > > +                stringTable.append(frameString)
> > > +
> > > +                category =3D KERNEL_CATEGORY_INDEX if frameString.fi=
nd('kallsyms') !=3D -1 or frameString.find('/vmlinux') !=3D -1 or frameStri=
ng.endswith('.ko)') else USER_CATEGORY_INDEX
> >
> > This line is too long, we usually don't allow long lines
> > over 100 characters.
>
> Thanks for your suggestion. I have taken care in latest version.
> Is there any way to add such checks in editor itself ? I used checkpatch.=
pl
> scripts, however it didnt catch this.

Unfortunately checkpatch.pl doesn't work for python code yet. I think
using mypy types would be useful:
https://github.com/python/mypy
Also having docstring on functions would be useful. Some of the code
has some fairly complex indirection and it'd be nice to understand
why.

Thanks,
Ian

> > Thanks,
> > Namhyung
> >
> >
> > > +                implementation =3D None
> > > +                optimizations =3D None
> > > +                line =3D None
> > > +                relevantForJS =3D False
> > > +                subcategory =3D None
> > > +                innerWindowID =3D 0
> > > +                column =3D None
> > > +
> > > +                frameTable['data'].append([
> > > +                    location,
> > > +                    relevantForJS,
> > > +                    innerWindowID,
> > > +                    implementation,
> > > +                    optimizations,
> > > +                    line,
> > > +                    column,
> > > +                    category,
> > > +                    subcategory,
> > > +                ])
> > > +                frameMap[frameString] =3D frame
> > > +            return frame
> > > +
> > >          def addSample(threadName, stackArray, time):
> > >              nonlocal name
> > >              if name !=3D threadName:
> > > --
> > > 2.34.1
> > >
