Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD4AC001B0
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Jul 2023 22:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjGSW3h (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Jul 2023 18:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjGSW3g (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jul 2023 18:29:36 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE901FF9
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Jul 2023 15:29:34 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-346099c6f43so51425ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Jul 2023 15:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689805773; x=1692397773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqoeu32/ubTfhfs6iCcSSOBQyyfVchKkhCCT1JC+XAk=;
        b=fhkFVSKo7vG2mHRskyY30qxwdiGCy6BwiQvXwBSODoJk8nERBLfkV4WFzEIBnuNnWu
         Uv/dG4CnBEjHgTrfySDCys5p3W2GCBox2oAL277y6RIbJivqLHKX0K/eRx/ElKoJLWUg
         pC1DXZVvvwPKyzPW4ZYmcdRqbd0SXsPjT9l0z8WjmkKHSfmCPOF73V+9kJ5X9u2P/cCB
         qmoCKkK83wZv7XIgZ+ecKa8teV7ChfoGVmKmrJztwCkD+qfeSeALdJ8JzyWSFBpncb/f
         Pm2v8BIQdc+kykfzZQH5ISC1aKoXubQ5ydXRuX04K+UaQOaPKXwu79UGsPaKbNYkmOnL
         Z6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689805773; x=1692397773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqoeu32/ubTfhfs6iCcSSOBQyyfVchKkhCCT1JC+XAk=;
        b=LVapvjsXE7ggiTYtuDWT6E1lmF6vfMfcE5+n1YkL42SKSUt9CnGyHJMVTGGtluyRUt
         Ju6f61Ih5j/VBbY17Rw138OX9EZf9lme7lpWV6NmLLFpLjzP+BKlNWzKgFB9gvJN6M/T
         nfLQuEbTidWgpr6MyWDr9r44T6i3jKQdDPOcr8tEmLlBCoVRZ8VSvqMztm9I/DfkSwVh
         aU0SsKrP0tJ4WN1lYMYKK/RCb1n7JIgDKfLFoAeO4OpZSbDWKSj+2r2zVqNlo+j5aMRj
         TeTVgrZXNw+SpY5eAU28pTfvrTsILeiJI6wPDwakkYE1Rp7DB+srYvBRpuTGzFUVbCYv
         L9zQ==
X-Gm-Message-State: ABy/qLaxOKy8aH/YDjjSvA2lQsdSRD/ZNl1VavOe5kztX5hRqy0DYhzd
        0wTXaG/RLWRvc8N06KL3ybVZbsUzISB+Dy94+j2LXjR6OiM4FKPclihS0Q==
X-Google-Smtp-Source: APBJJlHIgsdtyrAeyDIhRYnQ24HD/WjVFs8ko5K9ZxM8lpafShcrD0gfpVexu/lDsUJcqwEqJ0y7HCA9DYLgz2tgIgA=
X-Received: by 2002:a05:6e02:20c9:b0:340:57e1:2f7b with SMTP id
 9-20020a056e0220c900b0034057e12f7bmr34276ilq.5.1689805773098; Wed, 19 Jul
 2023 15:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fU10YCxZfq=dOUUPR0dRusbq=vzp5CqsOuz1aLVY16KAw@mail.gmail.com>
 <CAP-5=fWOCE6+9MuiFziHz1o6Ej-FTDJa1fnkhYpifz7Rtazk8Q@mail.gmail.com>
 <CAP-5=fXf-FmKb=D4h5VgxQ=w3T3+Nn3AP4ExR9YjnKFB=4m7bA@mail.gmail.com>
 <CAP-5=fWSHpWx02+nB8joo0JbtNJXAEHFLBdY7n5W=tSbdpMGkg@mail.gmail.com>
 <CAP-5=fX9OXTiiojNp-ut-_LOD2=6+mEN8iAt=UUGfmDu4q+F3Q@mail.gmail.com> <CAP-5=fU6TWKQ8eDUM5UFfO2h6TgL9j7-43eWfZMTbwpRqHS6OA@mail.gmail.com>
In-Reply-To: <CAP-5=fU6TWKQ8eDUM5UFfO2h6TgL9j7-43eWfZMTbwpRqHS6OA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jul 2023 15:29:20 -0700
Message-ID: <CAP-5=fX4Fj3phsny8zPueJpUaxN0jEhvJarc3ghz46RCtu0C+A@mail.gmail.com>
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

A reminder there is the usual office hours tomorrow:

Linux Perf Tool Office Hours
Thursday, July 20 =C2=B7 9:00 =E2=80=93 9:45am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/jds-asbo-day
Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 892=
=E2=80=AC#
More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983

Thanks,
Ian

On Wed, Jul 12, 2023 at 3:42=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> A reminder there are office hours tomorrow. This is a particular
> useful time to sync with Anup, the Linux Foundation Google
> Summer-of-Code contributor this year.
>
> Linux Perf Tool Office Hours
> Thursday, July 13 =C2=B7 9:00 =E2=80=93 9:45am
> Time zone: America/Los_Angeles
> Google Meet joining info
> Video call link: https://meet.google.com/jds-asbo-day
> Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 892=
=E2=80=AC#
> More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983
>
> Thanks!
> Ian
> On Thu, Jul 6, 2023 at 8:31=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Hi,
> >
> > Sorry for the late notice. Office hours today in 30 minutes.
> >
> > Linux Perf Tool Office Hours
> > Thursday, July 6 =C2=B7 9:00 =E2=80=93 9:45am
> > Time zone: America/Los_Angeles
> > Google Meet joining info
> > Video call link: https://meet.google.com/jds-asbo-day
> > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 8=
92=E2=80=AC#
> > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983
> >
> > Thanks,
> > Ian
> >
> > On Wed, Jun 21, 2023 at 3:15=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > Hi,
> > >
> > > Office hours reminder tomorrow. A chance to discuss any topics of the
> > > day and for
> > > GSoC contributor sync.
> > >
> > > Linux Perf Tool Office Hours
> > > Thursday, June 22 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > On Wed, Jun 14, 2023 at 10:01=E2=80=AFAM Ian Rogers <irogers@google.c=
om> wrote:
> > > >
> > > > Hi,
> > > >
> > > > Office hours reminder. A chance to discuss topics of the day and fo=
r
> > > > GSoC contributor sync.
> > > >
> > > > Linux Perf Tool Office Hours
> > > > Thursday, June 15 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > > On Wed, Jun 7, 2023 at 9:14=E2=80=AFPM Ian Rogers <irogers@google.c=
om> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > Office hours and chance for GSoC contributor sync slightly earlie=
r at
> > > > > 9am PT tomorrow:
> > > > >
> > > > > Linux Perf Tool Office Hours
> > > > > Thursday, June 8 =C2=B7 9:00 =E2=80=93 9:45am
> > > > > Time zone: America/Los_Angeles
> > > > > Google Meet joining info
> > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817=
 018 892=E2=80=AC#
> > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D662925225=
6983
> > > > >
> > > > > If you'd like to randomly drop in, feel free. An issue I'm keen t=
o
> > > > > discuss is memory usage and memory leaks.
> > > > >
> > > > > Thanks,
> > > > > Ian
> > > > >
> > > > > On Wed, May 31, 2023 at 10:00=E2=80=AFAM Ian Rogers <irogers@goog=
le.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Monday the Google Summer-of-Code officially started and Anup=
 is
> > > > > > this summer's contributor to the Linux perf tool! We've found i=
n the
> > > > > > past [1] that having office hours is a good chance for contribu=
tors to
> > > > > > sync and also for those interested in the Linux perf tool to al=
so
> > > > > > connect and share their problems and experiences. As such we pl=
an on
> > > > > > running our first office hours for this summer tomorrow, the de=
tails
> > > > > > are below:
> > > > > >
> > > > > > Linux Perf Tool Office Hours
> > > > > > Thursday, June 1 =C2=B7 9:30 =E2=80=93 10:30am
> > > > > > Time zone: America/Los_Angeles
> > > > > > Google Meet joining info
> > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA8=
17 018 892=E2=80=AC#
> > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252=
256983
> > > > > >
> > > > > > Please ask me and I'll be more than happy to add you to the cal=
endar
> > > > > > invite for this. Over the summer we can adjust the timing of th=
e
> > > > > > office hours to maximize participation, etc. so please reach ou=
t and
> > > > > > share concerns.
> > > > > >
> > > > > > Thanks,
> > > > > > Ian
> > > > > >
> > > > > > [1] https://lore.kernel.org/linux-perf-users/CAP-5=3DfWiQHvYZp5=
R=3Duw4xUwBiN1fBLBU8witPkYM+2r8tnYCOg@mail.gmail.com/
