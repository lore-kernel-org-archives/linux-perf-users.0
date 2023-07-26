Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FBDC001DF
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 Jul 2023 21:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjGZVxY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjGZVxX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Jul 2023 17:53:23 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9916326BC
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jul 2023 14:53:20 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40540a8a3bbso44181cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jul 2023 14:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690408399; x=1691013199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1R67OfT7Z4AyYJod0g5p68RDyLro/7P6TWFMrsP1O+0=;
        b=iUB2NrjLAqsYbE8QLB5B+MmHM6SAGdLKgnIO5k8CHvFWEIIIZu0D0lIO8xyDnWswxR
         dIFCmBCU8suAIarMXPOGuu5vYSbUCf0Civ6TxnQf/IaaBjHVgoPqRHkwTjjjX6p4eXAJ
         S3+bNuXj2XoComHSqfytDvG9vviFjZKsAjg6iLRWFV/WDbaLpt9xVbwfTbGvazhMFhw+
         qfIuEupY4WaORV7MIQ6OJQiop+YG9UwHzOjne0to+/2AVP7i70KwNYFB6g/okJMBRP/y
         rk1iXkBVK9ETLZ3OFEic2U9ypy0qDalMLoNvb4GT+ESVFJG/p3OqtwzTeanpfj6WZG4t
         1MxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690408399; x=1691013199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1R67OfT7Z4AyYJod0g5p68RDyLro/7P6TWFMrsP1O+0=;
        b=IOgy0+0tN/KtbbgwxaNN1kWGIPuc1qSWg83mTWXNPQnlYbzPLElnrpVFTlzCH+U4K2
         pxJxJMXzHhgd/y6pX2Jv8MdYEKpg+kEZjv4Mjw17sJ2Fal/eYzRKFumy+7clAxOTqhcj
         JyvwI1Dwk971w2RDh6DskIleIjF+F/KJ9AUN6VfcSc2XJig0IEsKrbIY5q88XcTbjnFF
         /3QQnE2SpaTK8cpQ1dkZla4t+9rieuWe6bLfC8YM41k8O6Asx+C4dUyVO4O9PjxHf+Z7
         XkNLqXXP7RF28LdB/+k8FnPsLwmxBbUzQx54mjVW2urKxRHX7SAjvIE8FjjFGaRdFuKz
         lK+A==
X-Gm-Message-State: ABy/qLY1pfgZySm9euZXqgjMY4qm7UucBehp/Y5SMZFisFytGWrs76J7
        jgVrQjWL0wuXJj4IUdhzKe6rbTFPyPHLXzfFVtElZ6/8EUJ/LjrGm1cMaA==
X-Google-Smtp-Source: APBJJlEbOyL+CRUuAbTj1OaeAM2Ym2WeyEOrj8tiScbsEIMFy/Q3yJcLE8g6i1n+Isr62ilnGX3wy1atqbGLUzRJUNM=
X-Received: by 2002:a05:622a:413:b0:403:aee3:64f7 with SMTP id
 n19-20020a05622a041300b00403aee364f7mr66873qtx.6.1690408399018; Wed, 26 Jul
 2023 14:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fU10YCxZfq=dOUUPR0dRusbq=vzp5CqsOuz1aLVY16KAw@mail.gmail.com>
 <CAP-5=fWOCE6+9MuiFziHz1o6Ej-FTDJa1fnkhYpifz7Rtazk8Q@mail.gmail.com>
 <CAP-5=fXf-FmKb=D4h5VgxQ=w3T3+Nn3AP4ExR9YjnKFB=4m7bA@mail.gmail.com>
 <CAP-5=fWSHpWx02+nB8joo0JbtNJXAEHFLBdY7n5W=tSbdpMGkg@mail.gmail.com>
 <CAP-5=fX9OXTiiojNp-ut-_LOD2=6+mEN8iAt=UUGfmDu4q+F3Q@mail.gmail.com>
 <CAP-5=fU6TWKQ8eDUM5UFfO2h6TgL9j7-43eWfZMTbwpRqHS6OA@mail.gmail.com> <CAP-5=fX4Fj3phsny8zPueJpUaxN0jEhvJarc3ghz46RCtu0C+A@mail.gmail.com>
In-Reply-To: <CAP-5=fX4Fj3phsny8zPueJpUaxN0jEhvJarc3ghz46RCtu0C+A@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 26 Jul 2023 14:53:07 -0700
Message-ID: <CAP-5=fV6f3NeSbKatG0_LCROUr=2xdcrC7PnC3D0YprtCDaTow@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Anup Sharma <anupnewsmail@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A reminder there is the usual office hours tomorrow. This is an
excellent opportunity to ask questions and hear the latest on Anup's
firefox profiler work.

Linux Perf Tool Office Hours
Thursday, July 27 =C2=B7 9:00 =E2=80=93 9:45am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/jds-asbo-day
Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 892=
=E2=80=AC#
More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983

Thanks,
Ian

On Wed, Jul 19, 2023 at 3:29=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> A reminder there is the usual office hours tomorrow:
>
> Linux Perf Tool Office Hours
> Thursday, July 20 =C2=B7 9:00 =E2=80=93 9:45am
> Time zone: America/Los_Angeles
> Google Meet joining info
> Video call link: https://meet.google.com/jds-asbo-day
> Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 892=
=E2=80=AC#
> More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983
>
> Thanks,
> Ian
>
> On Wed, Jul 12, 2023 at 3:42=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > A reminder there are office hours tomorrow. This is a particular
> > useful time to sync with Anup, the Linux Foundation Google
> > Summer-of-Code contributor this year.
> >
> > Linux Perf Tool Office Hours
> > Thursday, July 13 =C2=B7 9:00 =E2=80=93 9:45am
> > Time zone: America/Los_Angeles
> > Google Meet joining info
> > Video call link: https://meet.google.com/jds-asbo-day
> > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 8=
92=E2=80=AC#
> > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983
> >
> > Thanks!
> > Ian
> > On Thu, Jul 6, 2023 at 8:31=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > Hi,
> > >
> > > Sorry for the late notice. Office hours today in 30 minutes.
> > >
> > > Linux Perf Tool Office Hours
> > > Thursday, July 6 =C2=B7 9:00 =E2=80=93 9:45am
> > > Time zone: America/Los_Angeles
> > > Google Meet joining info
> > > Video call link: https://meet.google.com/jds-asbo-day
> > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018=
 892=E2=80=AC#
> > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983
> > >
> > > Thanks,
> > > Ian
> > >
> > > On Wed, Jun 21, 2023 at 3:15=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > Hi,
> > > >
> > > > Office hours reminder tomorrow. A chance to discuss any topics of t=
he
> > > > day and for
> > > > GSoC contributor sync.
> > > >
> > > > Linux Perf Tool Office Hours
> > > > Thursday, June 22 =C2=B7 9:00 =E2=80=93 9:45am
> > > > Time zone: America/Los_Angeles
> > > > Google Meet joining info
> > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 0=
18 892=E2=80=AC#
> > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D66292522569=
83
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > On Wed, Jun 14, 2023 at 10:01=E2=80=AFAM Ian Rogers <irogers@google=
.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > Office hours reminder. A chance to discuss topics of the day and =
for
> > > > > GSoC contributor sync.
> > > > >
> > > > > Linux Perf Tool Office Hours
> > > > > Thursday, June 15 =C2=B7 9:00 =E2=80=93 9:45am
> > > > > Time zone: America/Los_Angeles
> > > > > Google Meet joining info
> > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817=
 018 892=E2=80=AC#
> > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D662925225=
6983
> > > > >
> > > > > Thanks,
> > > > > Ian
> > > > >
> > > > > On Wed, Jun 7, 2023 at 9:14=E2=80=AFPM Ian Rogers <irogers@google=
.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Office hours and chance for GSoC contributor sync slightly earl=
ier at
> > > > > > 9am PT tomorrow:
> > > > > >
> > > > > > Linux Perf Tool Office Hours
> > > > > > Thursday, June 8 =C2=B7 9:00 =E2=80=93 9:45am
> > > > > > Time zone: America/Los_Angeles
> > > > > > Google Meet joining info
> > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA8=
17 018 892=E2=80=AC#
> > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252=
256983
> > > > > >
> > > > > > If you'd like to randomly drop in, feel free. An issue I'm keen=
 to
> > > > > > discuss is memory usage and memory leaks.
> > > > > >
> > > > > > Thanks,
> > > > > > Ian
> > > > > >
> > > > > > On Wed, May 31, 2023 at 10:00=E2=80=AFAM Ian Rogers <irogers@go=
ogle.com> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > On Monday the Google Summer-of-Code officially started and An=
up is
> > > > > > > this summer's contributor to the Linux perf tool! We've found=
 in the
> > > > > > > past [1] that having office hours is a good chance for contri=
butors to
> > > > > > > sync and also for those interested in the Linux perf tool to =
also
> > > > > > > connect and share their problems and experiences. As such we =
plan on
> > > > > > > running our first office hours for this summer tomorrow, the =
details
> > > > > > > are below:
> > > > > > >
> > > > > > > Linux Perf Tool Office Hours
> > > > > > > Thursday, June 1 =C2=B7 9:30 =E2=80=93 10:30am
> > > > > > > Time zone: America/Los_Angeles
> > > > > > > Google Meet joining info
> > > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=
=AA817 018 892=E2=80=AC#
> > > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D66292=
52256983
> > > > > > >
> > > > > > > Please ask me and I'll be more than happy to add you to the c=
alendar
> > > > > > > invite for this. Over the summer we can adjust the timing of =
the
> > > > > > > office hours to maximize participation, etc. so please reach =
out and
> > > > > > > share concerns.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Ian
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/linux-perf-users/CAP-5=3DfWiQHvYZ=
p5R=3Duw4xUwBiN1fBLBU8witPkYM+2r8tnYCOg@mail.gmail.com/
