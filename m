Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2C6C001DF
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Aug 2023 20:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjHBUJs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Aug 2023 16:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjHBUJs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Aug 2023 16:09:48 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C421734
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Aug 2023 13:09:46 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40c72caec5cso75301cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Aug 2023 13:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691006985; x=1691611785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ya0m1tKt/mFRIo3/NRewO90bR7oOFXXfyZEWWmrNSxE=;
        b=vjY09EClOtT9vhvxFiOL0+0gV2pLgxgIxBL8FPDf2GmDOHnB22IqazdHYavwc1sopB
         u62GAqxw8OB872F5Ln3qw2Uk1sOTYc1hmmiI2CsGSNcxg3MamkhQR4wCxKFTmUKf9sa8
         exLVprGiS8aEnzILljayV0Os9wWLCMBt7o+AYw35nGdSFeYWGyRd+gn/SWo1xS28plH5
         YBVQJWZf5+iMoFO1VyfuX+3BP5ltLCJznmQ6AQH1YjjDRKmP+tdN6pXn+AZWeBoKVEgd
         YEWs87wp5dkSrfb2BJiqcPGfrQVvPvAhkhtAZzTirA2cOtxJZ3V4kA4j0O763TWRfGrn
         SCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691006985; x=1691611785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ya0m1tKt/mFRIo3/NRewO90bR7oOFXXfyZEWWmrNSxE=;
        b=bWkPDL29WK1LRrp2xXwyTQVnu3hSgwKXEDRz94XtvABa5OjwQLTYpANjgnLQHX5UJj
         l0fxp0iz8/HLwKGJ1uOYORofcM8cll57ak50VQvTQUScnEmMP0Hvn8kJ+U4BC9aHuODS
         39DO1QvZ/a0y9Q6EVS6y+EBemYadx9x6FR7MITBmR8Jr9a73akOJNnEhBDFlGQHQQLS3
         LuVEIgexZ8u27gg8xk7Qrjv4axyDzNTLkbOPbiWO1UGNOcPGnIVtbXtmC+16xXE9VU63
         XylkFVepxlwIYbOphxatC8uFMZ/OQd/n/PWQbVIK9x4yXDhuXt9B94RQe8iD2rB6YHL4
         MMHQ==
X-Gm-Message-State: ABy/qLYomPx9WT0n65xzHwg9cvHaC0/vW/Isz2Z2mxXb6856H5tXVcou
        DZwBEcAmmA8jc0WHaB/nwLxrK1OPWZAnqLf5o/pVxfvKoiQhsJrc0H0XJQ==
X-Google-Smtp-Source: APBJJlEjsC1TaahX9w7YOEL0NmG1Cuj3CP8aFoj2U1UtaFofJeixDxB5XjvdalZbEjxeaf448ehnlkfPGanxjt1aFTI=
X-Received: by 2002:a05:622a:5cb:b0:403:f5b8:2bd2 with SMTP id
 d11-20020a05622a05cb00b00403f5b82bd2mr987273qtb.9.1691006985436; Wed, 02 Aug
 2023 13:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fU10YCxZfq=dOUUPR0dRusbq=vzp5CqsOuz1aLVY16KAw@mail.gmail.com>
 <CAP-5=fWOCE6+9MuiFziHz1o6Ej-FTDJa1fnkhYpifz7Rtazk8Q@mail.gmail.com>
 <CAP-5=fXf-FmKb=D4h5VgxQ=w3T3+Nn3AP4ExR9YjnKFB=4m7bA@mail.gmail.com>
 <CAP-5=fWSHpWx02+nB8joo0JbtNJXAEHFLBdY7n5W=tSbdpMGkg@mail.gmail.com>
 <CAP-5=fX9OXTiiojNp-ut-_LOD2=6+mEN8iAt=UUGfmDu4q+F3Q@mail.gmail.com>
 <CAP-5=fU6TWKQ8eDUM5UFfO2h6TgL9j7-43eWfZMTbwpRqHS6OA@mail.gmail.com>
 <CAP-5=fX4Fj3phsny8zPueJpUaxN0jEhvJarc3ghz46RCtu0C+A@mail.gmail.com> <CAP-5=fV6f3NeSbKatG0_LCROUr=2xdcrC7PnC3D0YprtCDaTow@mail.gmail.com>
In-Reply-To: <CAP-5=fV6f3NeSbKatG0_LCROUr=2xdcrC7PnC3D0YprtCDaTow@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 2 Aug 2023 13:09:33 -0700
Message-ID: <CAP-5=fU2dPih+JPUOkoHyiFvMwd9KRHiKDtuNeatPsaE0VxbsQ@mail.gmail.com>
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

First office hours of August tomorrow:

Linux Perf Tool Office Hours
Thursday, August 3 =C2=B7 9:00 =E2=80=93 9:45am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/jds-asbo-day
Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 892=
=E2=80=AC#
More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983

Thanks,
Ian

On Wed, Jul 26, 2023 at 2:53=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> A reminder there is the usual office hours tomorrow. This is an
> excellent opportunity to ask questions and hear the latest on Anup's
> firefox profiler work.
>
> Linux Perf Tool Office Hours
> Thursday, July 27 =C2=B7 9:00 =E2=80=93 9:45am
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
> On Wed, Jul 19, 2023 at 3:29=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > A reminder there is the usual office hours tomorrow:
> >
> > Linux Perf Tool Office Hours
> > Thursday, July 20 =C2=B7 9:00 =E2=80=93 9:45am
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
> > On Wed, Jul 12, 2023 at 3:42=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > A reminder there are office hours tomorrow. This is a particular
> > > useful time to sync with Anup, the Linux Foundation Google
> > > Summer-of-Code contributor this year.
> > >
> > > Linux Perf Tool Office Hours
> > > Thursday, July 13 =C2=B7 9:00 =E2=80=93 9:45am
> > > Time zone: America/Los_Angeles
> > > Google Meet joining info
> > > Video call link: https://meet.google.com/jds-asbo-day
> > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018=
 892=E2=80=AC#
> > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983
> > >
> > > Thanks!
> > > Ian
> > > On Thu, Jul 6, 2023 at 8:31=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > > >
> > > > Hi,
> > > >
> > > > Sorry for the late notice. Office hours today in 30 minutes.
> > > >
> > > > Linux Perf Tool Office Hours
> > > > Thursday, July 6 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > > On Wed, Jun 21, 2023 at 3:15=E2=80=AFPM Ian Rogers <irogers@google.=
com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > Office hours reminder tomorrow. A chance to discuss any topics of=
 the
> > > > > day and for
> > > > > GSoC contributor sync.
> > > > >
> > > > > Linux Perf Tool Office Hours
> > > > > Thursday, June 22 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > > > On Wed, Jun 14, 2023 at 10:01=E2=80=AFAM Ian Rogers <irogers@goog=
le.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Office hours reminder. A chance to discuss topics of the day an=
d for
> > > > > > GSoC contributor sync.
> > > > > >
> > > > > > Linux Perf Tool Office Hours
> > > > > > Thursday, June 15 =C2=B7 9:00 =E2=80=93 9:45am
> > > > > > Time zone: America/Los_Angeles
> > > > > > Google Meet joining info
> > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA8=
17 018 892=E2=80=AC#
> > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252=
256983
> > > > > >
> > > > > > Thanks,
> > > > > > Ian
> > > > > >
> > > > > > On Wed, Jun 7, 2023 at 9:14=E2=80=AFPM Ian Rogers <irogers@goog=
le.com> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > Office hours and chance for GSoC contributor sync slightly ea=
rlier at
> > > > > > > 9am PT tomorrow:
> > > > > > >
> > > > > > > Linux Perf Tool Office Hours
> > > > > > > Thursday, June 8 =C2=B7 9:00 =E2=80=93 9:45am
> > > > > > > Time zone: America/Los_Angeles
> > > > > > > Google Meet joining info
> > > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=
=AA817 018 892=E2=80=AC#
> > > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D66292=
52256983
> > > > > > >
> > > > > > > If you'd like to randomly drop in, feel free. An issue I'm ke=
en to
> > > > > > > discuss is memory usage and memory leaks.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Ian
> > > > > > >
> > > > > > > On Wed, May 31, 2023 at 10:00=E2=80=AFAM Ian Rogers <irogers@=
google.com> wrote:
> > > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > On Monday the Google Summer-of-Code officially started and =
Anup is
> > > > > > > > this summer's contributor to the Linux perf tool! We've fou=
nd in the
> > > > > > > > past [1] that having office hours is a good chance for cont=
ributors to
> > > > > > > > sync and also for those interested in the Linux perf tool t=
o also
> > > > > > > > connect and share their problems and experiences. As such w=
e plan on
> > > > > > > > running our first office hours for this summer tomorrow, th=
e details
> > > > > > > > are below:
> > > > > > > >
> > > > > > > > Linux Perf Tool Office Hours
> > > > > > > > Thursday, June 1 =C2=B7 9:30 =E2=80=93 10:30am
> > > > > > > > Time zone: America/Los_Angeles
> > > > > > > > Google Meet joining info
> > > > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=
=AA817 018 892=E2=80=AC#
> > > > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D662=
9252256983
> > > > > > > >
> > > > > > > > Please ask me and I'll be more than happy to add you to the=
 calendar
> > > > > > > > invite for this. Over the summer we can adjust the timing o=
f the
> > > > > > > > office hours to maximize participation, etc. so please reac=
h out and
> > > > > > > > share concerns.
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Ian
> > > > > > > >
> > > > > > > > [1] https://lore.kernel.org/linux-perf-users/CAP-5=3DfWiQHv=
YZp5R=3Duw4xUwBiN1fBLBU8witPkYM+2r8tnYCOg@mail.gmail.com/
