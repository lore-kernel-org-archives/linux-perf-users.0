Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A64C71145
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Aug 2023 04:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbjHXEmH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Aug 2023 00:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239032AbjHXEmA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Aug 2023 00:42:00 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0037210E4
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 21:41:57 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40c72caec5cso197281cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 21:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692852117; x=1693456917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxyBUJq2Gx4AIxx0Qqtw7Y4mB6OKThVmzCJz6Skp9EY=;
        b=RCZf/7WGJzD+uQtolBZh7UPjVLH6LlQ4rNPv4aAYELfF5ufY2NUm+zWknMbq6n8utG
         ZyNmlPe3ytq+FRyKuL0jkJWszjZDHW+43GVeF9CeYak9ISLESQRpjZXrhyBRHRuvMtzD
         0Dvhbdkhor0EjjoQU2fL7falsXIa79kOzJ9iKVPo9EfzTWxEN+8U8KXkntLa6i6UySbD
         Th5YtjTfBtv7NiNEQ5FOE191oaEyu6QzYwzKgjPqwi+7VXQvBGa98TTsagrm90Ws3WoA
         op+C6mqDJxnQ3TeTx8sqA56e/uY4jO09CcqEjIsWgZEcSi4sqxgCOSuGu1irjUuRKUkh
         LHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692852117; x=1693456917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxyBUJq2Gx4AIxx0Qqtw7Y4mB6OKThVmzCJz6Skp9EY=;
        b=Kr4EYjveRP5lqPXEeWFzpN7q65gKTn4aPt7zVY9KoxyItQDC9BHUpEhdprrVIhfv4I
         wEVLmaNk8IO5Jq57uLxKHG70LuORGbaizKYNCIBJlPHfc10qcBPe2i4voY6MIbZpU8Gk
         aaLKBAOGG2Zsbe9XNXTmdcPFqO3AI0Z5Wa6dtLtUWSa88PQiRuHHS13WW/3eEp4o03UE
         TPjs5W8WrJqIbNa6+MacD2/2yuGTrGjphVE+blgF6aD7LmUDY6t2w2K5zY19oCUNZsOk
         8509if75GVoGQFEkHlP4T9HVkQPaZQa/9a3aggsenSCP5bj7G4DWabZQnlbPIePG3duP
         xy9w==
X-Gm-Message-State: AOJu0YymCI+SyOMSuU3QYuEB/d0f8CnTiaAM/JSLCR3w6Nf6X1y8I6fu
        c9qfxDBBap/M5eBgeXM/wpAQSSoLTNFjz3kwAJjiRzEdEYpaQPlG4urcOw==
X-Google-Smtp-Source: AGHT+IEoQEqv/hwLhsBZaFiWkqP3VwGk1S/bC6+96tve8JK8xHCrkoBxeu3CWX6ZQH24c9/bOyflriyorKMiO2d2FxY=
X-Received: by 2002:a05:622a:19a0:b0:410:916b:eb3f with SMTP id
 u32-20020a05622a19a000b00410916beb3fmr786091qtc.16.1692852116707; Wed, 23 Aug
 2023 21:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fU10YCxZfq=dOUUPR0dRusbq=vzp5CqsOuz1aLVY16KAw@mail.gmail.com>
 <CAP-5=fWOCE6+9MuiFziHz1o6Ej-FTDJa1fnkhYpifz7Rtazk8Q@mail.gmail.com>
 <CAP-5=fXf-FmKb=D4h5VgxQ=w3T3+Nn3AP4ExR9YjnKFB=4m7bA@mail.gmail.com>
 <CAP-5=fWSHpWx02+nB8joo0JbtNJXAEHFLBdY7n5W=tSbdpMGkg@mail.gmail.com>
 <CAP-5=fX9OXTiiojNp-ut-_LOD2=6+mEN8iAt=UUGfmDu4q+F3Q@mail.gmail.com>
 <CAP-5=fU6TWKQ8eDUM5UFfO2h6TgL9j7-43eWfZMTbwpRqHS6OA@mail.gmail.com>
 <CAP-5=fX4Fj3phsny8zPueJpUaxN0jEhvJarc3ghz46RCtu0C+A@mail.gmail.com>
 <CAP-5=fV6f3NeSbKatG0_LCROUr=2xdcrC7PnC3D0YprtCDaTow@mail.gmail.com>
 <CAP-5=fU2dPih+JPUOkoHyiFvMwd9KRHiKDtuNeatPsaE0VxbsQ@mail.gmail.com>
 <CAP-5=fWRELRNg3guvsXu-PJU4MfJ+tj3zZRWpSrmCK5AP39ANg@mail.gmail.com> <CAP-5=fVqbAej4aJV-BDsBSpgAnmad+RXC_0Z_81Ma8WZXUkNWg@mail.gmail.com>
In-Reply-To: <CAP-5=fVqbAej4aJV-BDsBSpgAnmad+RXC_0Z_81Ma8WZXUkNWg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Aug 2023 21:41:44 -0700
Message-ID: <CAP-5=fW38egHuXP+y1O=VFSW0vO79UqRxgsrOp94D+evaNb92g@mail.gmail.com>
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

Office hours tomorrow:

Linux Perf Tool Office Hours
Thursday, August 24 =C2=B7 9:00 =E2=80=93 9:45am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/jds-asbo-day
Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 892=
=E2=80=AC#
More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983

Next week is the end of Google summer-of-code 2023 and so this will be
a chance to talk with Anup before he wraps up.

Thanks,
Ian
On Wed, Aug 16, 2023 at 11:16=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Office hours tomorrow:
>
> Linux Perf Tool Office Hours
> Thursday, August 17 =C2=B7 9:00 =E2=80=93 9:45am
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
> On Wed, Aug 9, 2023 at 1:32=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Hi,
> >
> > Just a heads up that we plan to skip office hours tomorrow.
> >
> > Thanks,
> > Ian
> >
> > On Wed, Aug 2, 2023 at 1:09=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > First office hours of August tomorrow:
> > >
> > > Linux Perf Tool Office Hours
> > > Thursday, August 3 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > On Wed, Jul 26, 2023 at 2:53=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > A reminder there is the usual office hours tomorrow. This is an
> > > > excellent opportunity to ask questions and hear the latest on Anup'=
s
> > > > firefox profiler work.
> > > >
> > > > Linux Perf Tool Office Hours
> > > > Thursday, July 27 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > > On Wed, Jul 19, 2023 at 3:29=E2=80=AFPM Ian Rogers <irogers@google.=
com> wrote:
> > > > >
> > > > > A reminder there is the usual office hours tomorrow:
> > > > >
> > > > > Linux Perf Tool Office Hours
> > > > > Thursday, July 20 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > > > On Wed, Jul 12, 2023 at 3:42=E2=80=AFPM Ian Rogers <irogers@googl=
e.com> wrote:
> > > > > >
> > > > > > A reminder there are office hours tomorrow. This is a particula=
r
> > > > > > useful time to sync with Anup, the Linux Foundation Google
> > > > > > Summer-of-Code contributor this year.
> > > > > >
> > > > > > Linux Perf Tool Office Hours
> > > > > > Thursday, July 13 =C2=B7 9:00 =E2=80=93 9:45am
> > > > > > Time zone: America/Los_Angeles
> > > > > > Google Meet joining info
> > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA8=
17 018 892=E2=80=AC#
> > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252=
256983
> > > > > >
> > > > > > Thanks!
> > > > > > Ian
> > > > > > On Thu, Jul 6, 2023 at 8:31=E2=80=AFAM Ian Rogers <irogers@goog=
le.com> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > Sorry for the late notice. Office hours today in 30 minutes.
> > > > > > >
> > > > > > > Linux Perf Tool Office Hours
> > > > > > > Thursday, July 6 =C2=B7 9:00 =E2=80=93 9:45am
> > > > > > > Time zone: America/Los_Angeles
> > > > > > > Google Meet joining info
> > > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=
=AA817 018 892=E2=80=AC#
> > > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D66292=
52256983
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Ian
> > > > > > >
> > > > > > > On Wed, Jun 21, 2023 at 3:15=E2=80=AFPM Ian Rogers <irogers@g=
oogle.com> wrote:
> > > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > Office hours reminder tomorrow. A chance to discuss any top=
ics of the
> > > > > > > > day and for
> > > > > > > > GSoC contributor sync.
> > > > > > > >
> > > > > > > > Linux Perf Tool Office Hours
> > > > > > > > Thursday, June 22 =C2=B7 9:00 =E2=80=93 9:45am
> > > > > > > > Time zone: America/Los_Angeles
> > > > > > > > Google Meet joining info
> > > > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=
=AA817 018 892=E2=80=AC#
> > > > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D662=
9252256983
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Ian
> > > > > > > >
> > > > > > > > On Wed, Jun 14, 2023 at 10:01=E2=80=AFAM Ian Rogers <iroger=
s@google.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > Office hours reminder. A chance to discuss topics of the =
day and for
> > > > > > > > > GSoC contributor sync.
> > > > > > > > >
> > > > > > > > > Linux Perf Tool Office Hours
> > > > > > > > > Thursday, June 15 =C2=B7 9:00 =E2=80=93 9:45am
> > > > > > > > > Time zone: America/Los_Angeles
> > > > > > > > > Google Meet joining info
> > > > > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=
=80=AA817 018 892=E2=80=AC#
> > > > > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6=
629252256983
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Ian
> > > > > > > > >
> > > > > > > > > On Wed, Jun 7, 2023 at 9:14=E2=80=AFPM Ian Rogers <iroger=
s@google.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi,
> > > > > > > > > >
> > > > > > > > > > Office hours and chance for GSoC contributor sync sligh=
tly earlier at
> > > > > > > > > > 9am PT tomorrow:
> > > > > > > > > >
> > > > > > > > > > Linux Perf Tool Office Hours
> > > > > > > > > > Thursday, June 8 =C2=B7 9:00 =E2=80=93 9:45am
> > > > > > > > > > Time zone: America/Los_Angeles
> > > > > > > > > > Google Meet joining info
> > > > > > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =
=E2=80=AA817 018 892=E2=80=AC#
> > > > > > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=
=3D6629252256983
> > > > > > > > > >
> > > > > > > > > > If you'd like to randomly drop in, feel free. An issue =
I'm keen to
> > > > > > > > > > discuss is memory usage and memory leaks.
> > > > > > > > > >
> > > > > > > > > > Thanks,
> > > > > > > > > > Ian
> > > > > > > > > >
> > > > > > > > > > On Wed, May 31, 2023 at 10:00=E2=80=AFAM Ian Rogers <ir=
ogers@google.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi,
> > > > > > > > > > >
> > > > > > > > > > > On Monday the Google Summer-of-Code officially starte=
d and Anup is
> > > > > > > > > > > this summer's contributor to the Linux perf tool! We'=
ve found in the
> > > > > > > > > > > past [1] that having office hours is a good chance fo=
r contributors to
> > > > > > > > > > > sync and also for those interested in the Linux perf =
tool to also
> > > > > > > > > > > connect and share their problems and experiences. As =
such we plan on
> > > > > > > > > > > running our first office hours for this summer tomorr=
ow, the details
> > > > > > > > > > > are below:
> > > > > > > > > > >
> > > > > > > > > > > Linux Perf Tool Office Hours
> > > > > > > > > > > Thursday, June 1 =C2=B7 9:30 =E2=80=93 10:30am
> > > > > > > > > > > Time zone: America/Los_Angeles
> > > > > > > > > > > Google Meet joining info
> > > > > > > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =
=E2=80=AA817 018 892=E2=80=AC#
> > > > > > > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=
=3D6629252256983
> > > > > > > > > > >
> > > > > > > > > > > Please ask me and I'll be more than happy to add you =
to the calendar
> > > > > > > > > > > invite for this. Over the summer we can adjust the ti=
ming of the
> > > > > > > > > > > office hours to maximize participation, etc. so pleas=
e reach out and
> > > > > > > > > > > share concerns.
> > > > > > > > > > >
> > > > > > > > > > > Thanks,
> > > > > > > > > > > Ian
> > > > > > > > > > >
> > > > > > > > > > > [1] https://lore.kernel.org/linux-perf-users/CAP-5=3D=
fWiQHvYZp5R=3Duw4xUwBiN1fBLBU8witPkYM+2r8tnYCOg@mail.gmail.com/
