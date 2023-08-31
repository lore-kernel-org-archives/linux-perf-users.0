Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FD9C83F10
	for <linux-perf-users@archiver.kernel.org>; Thu, 31 Aug 2023 06:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjHaGdr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346074AbjHaGdq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 31 Aug 2023 02:33:46 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BCDA4
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Aug 2023 23:33:39 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4036bd4fff1so221541cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Aug 2023 23:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693463618; x=1694068418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V42gyvfHWwg9jxXtqRfqUagL+DiZtd1NysOqo7oK+Co=;
        b=5bBkWnVevym5Mbs2a6M/GgJTbHxlg4LAvIUXsCn8YmpwowUW0Dha9GS2Cv1RB7xgZZ
         l+5pnMdPsLuPg2h3oR1P92Pz/HtMMJ22uIpfPIgOhdYw2vUCoi3PlqZ1DXR9AoCytnJy
         Wwq66JNV2M8aNM5iUDq9BcvWW9bwlcp+j2Q244vpQgY2dgmfp3s8CiT64CP27wDLfXp7
         wQgL9eI5Ef45gmJoioI/v89HLDkakPCflq5gzWM3jm6K3MybsTj3cgeDMY90nd4fJi6o
         017hQIeBp0zUIa81cGan5yP7DjmiF8tsVHYwF2woM1Anf8rRGri7Q8URQxHi4CZ1vSCe
         vPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693463618; x=1694068418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V42gyvfHWwg9jxXtqRfqUagL+DiZtd1NysOqo7oK+Co=;
        b=Yzy4xELE09j07a8W0X9YNcVFwzcjsgn8WjbCJbgOWQZMUdPzaWPyscjdSYTAcrAvjS
         TQxYrg287hFaA3a7mayX3+Tul4/hUr/g6CybhL762LQSC/FGwSnMlYPnJwTkGMBW6m5x
         2Uj5RKBSQze/YbobKlKAOBERaY8v4WlsRcmUZFOU8uCgO5gVKrP4OFhgAqLWmLBcZE92
         iYl7dcRZ+kK1JG5V4GSyKU9IL8aPiSzzmfbuEwk1t/9vwiCiHtcC334+wJmsShv52sED
         uPbVNdG+SjbJGprC+pQqewjyfL5QER7TpWtrXZ2MBV20JK5XyghU9ijiCAfwdXN9p7Yk
         S4zw==
X-Gm-Message-State: AOJu0Yw9HCXqANzRGWqg1Js66YRDKSI2LYDJo9g42cwIX5ysVt3yjV5I
        QC55DLjwIB0S2Cyu+X6VnmMQ6fNrPBbq8eZQhjmffEca7FsXyzQXHSSYHrJs
X-Google-Smtp-Source: AGHT+IHep9aa2bjKgEOxYenGo3QVr0JLwCDfN3ppaBUuAZ2fXr9qEIi1ABvfaLfRv6QnFEZ/E/s2gyw0HUD/kYNxc2Y=
X-Received: by 2002:ac8:7e8d:0:b0:410:a4cb:9045 with SMTP id
 w13-20020ac87e8d000000b00410a4cb9045mr181239qtj.18.1693463618068; Wed, 30 Aug
 2023 23:33:38 -0700 (PDT)
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
 <CAP-5=fWRELRNg3guvsXu-PJU4MfJ+tj3zZRWpSrmCK5AP39ANg@mail.gmail.com>
 <CAP-5=fVqbAej4aJV-BDsBSpgAnmad+RXC_0Z_81Ma8WZXUkNWg@mail.gmail.com> <CAP-5=fW38egHuXP+y1O=VFSW0vO79UqRxgsrOp94D+evaNb92g@mail.gmail.com>
In-Reply-To: <CAP-5=fW38egHuXP+y1O=VFSW0vO79UqRxgsrOp94D+evaNb92g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Aug 2023 23:33:25 -0700
Message-ID: <CAP-5=fU6sULkvAUtsNv_c_jns-OkVvwU4zkirfBX-1BGJysT_Q@mail.gmail.com>
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

It is the end of summer and the end of Google summer-of-code, as such
no office hours tomorrow. Please check out Anup's final report and
youtube video:
https://lore.kernel.org/linux-perf-users/ZOrsiZA+C0zbWEQS@yoga/

Thanks,
Ian

On Wed, Aug 23, 2023 at 9:41=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Office hours tomorrow:
>
> Linux Perf Tool Office Hours
> Thursday, August 24 =C2=B7 9:00 =E2=80=93 9:45am
> Time zone: America/Los_Angeles
> Google Meet joining info
> Video call link: https://meet.google.com/jds-asbo-day
> Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 892=
=E2=80=AC#
> More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983
>
> Next week is the end of Google summer-of-code 2023 and so this will be
> a chance to talk with Anup before he wraps up.
>
> Thanks,
> Ian
> On Wed, Aug 16, 2023 at 11:16=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Office hours tomorrow:
> >
> > Linux Perf Tool Office Hours
> > Thursday, August 17 =C2=B7 9:00 =E2=80=93 9:45am
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
> > On Wed, Aug 9, 2023 at 1:32=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > Hi,
> > >
> > > Just a heads up that we plan to skip office hours tomorrow.
> > >
> > > Thanks,
> > > Ian
> > >
> > > On Wed, Aug 2, 2023 at 1:09=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > > >
> > > > First office hours of August tomorrow:
> > > >
> > > > Linux Perf Tool Office Hours
> > > > Thursday, August 3 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > > On Wed, Jul 26, 2023 at 2:53=E2=80=AFPM Ian Rogers <irogers@google.=
com> wrote:
> > > > >
> > > > > A reminder there is the usual office hours tomorrow. This is an
> > > > > excellent opportunity to ask questions and hear the latest on Anu=
p's
> > > > > firefox profiler work.
> > > > >
> > > > > Linux Perf Tool Office Hours
> > > > > Thursday, July 27 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > > > On Wed, Jul 19, 2023 at 3:29=E2=80=AFPM Ian Rogers <irogers@googl=
e.com> wrote:
> > > > > >
> > > > > > A reminder there is the usual office hours tomorrow:
> > > > > >
> > > > > > Linux Perf Tool Office Hours
> > > > > > Thursday, July 20 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > > > > On Wed, Jul 12, 2023 at 3:42=E2=80=AFPM Ian Rogers <irogers@goo=
gle.com> wrote:
> > > > > > >
> > > > > > > A reminder there are office hours tomorrow. This is a particu=
lar
> > > > > > > useful time to sync with Anup, the Linux Foundation Google
> > > > > > > Summer-of-Code contributor this year.
> > > > > > >
> > > > > > > Linux Perf Tool Office Hours
> > > > > > > Thursday, July 13 =C2=B7 9:00 =E2=80=93 9:45am
> > > > > > > Time zone: America/Los_Angeles
> > > > > > > Google Meet joining info
> > > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=
=AA817 018 892=E2=80=AC#
> > > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D66292=
52256983
> > > > > > >
> > > > > > > Thanks!
> > > > > > > Ian
> > > > > > > On Thu, Jul 6, 2023 at 8:31=E2=80=AFAM Ian Rogers <irogers@go=
ogle.com> wrote:
> > > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > Sorry for the late notice. Office hours today in 30 minutes=
.
> > > > > > > >
> > > > > > > > Linux Perf Tool Office Hours
> > > > > > > > Thursday, July 6 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > > > > > > On Wed, Jun 21, 2023 at 3:15=E2=80=AFPM Ian Rogers <irogers=
@google.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > Office hours reminder tomorrow. A chance to discuss any t=
opics of the
> > > > > > > > > day and for
> > > > > > > > > GSoC contributor sync.
> > > > > > > > >
> > > > > > > > > Linux Perf Tool Office Hours
> > > > > > > > > Thursday, June 22 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > > > > > > > On Wed, Jun 14, 2023 at 10:01=E2=80=AFAM Ian Rogers <irog=
ers@google.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi,
> > > > > > > > > >
> > > > > > > > > > Office hours reminder. A chance to discuss topics of th=
e day and for
> > > > > > > > > > GSoC contributor sync.
> > > > > > > > > >
> > > > > > > > > > Linux Perf Tool Office Hours
> > > > > > > > > > Thursday, June 15 =C2=B7 9:00 =E2=80=93 9:45am
> > > > > > > > > > Time zone: America/Los_Angeles
> > > > > > > > > > Google Meet joining info
> > > > > > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =
=E2=80=AA817 018 892=E2=80=AC#
> > > > > > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=
=3D6629252256983
> > > > > > > > > >
> > > > > > > > > > Thanks,
> > > > > > > > > > Ian
> > > > > > > > > >
> > > > > > > > > > On Wed, Jun 7, 2023 at 9:14=E2=80=AFPM Ian Rogers <irog=
ers@google.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi,
> > > > > > > > > > >
> > > > > > > > > > > Office hours and chance for GSoC contributor sync sli=
ghtly earlier at
> > > > > > > > > > > 9am PT tomorrow:
> > > > > > > > > > >
> > > > > > > > > > > Linux Perf Tool Office Hours
> > > > > > > > > > > Thursday, June 8 =C2=B7 9:00 =E2=80=93 9:45am
> > > > > > > > > > > Time zone: America/Los_Angeles
> > > > > > > > > > > Google Meet joining info
> > > > > > > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =
=E2=80=AA817 018 892=E2=80=AC#
> > > > > > > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=
=3D6629252256983
> > > > > > > > > > >
> > > > > > > > > > > If you'd like to randomly drop in, feel free. An issu=
e I'm keen to
> > > > > > > > > > > discuss is memory usage and memory leaks.
> > > > > > > > > > >
> > > > > > > > > > > Thanks,
> > > > > > > > > > > Ian
> > > > > > > > > > >
> > > > > > > > > > > On Wed, May 31, 2023 at 10:00=E2=80=AFAM Ian Rogers <=
irogers@google.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi,
> > > > > > > > > > > >
> > > > > > > > > > > > On Monday the Google Summer-of-Code officially star=
ted and Anup is
> > > > > > > > > > > > this summer's contributor to the Linux perf tool! W=
e've found in the
> > > > > > > > > > > > past [1] that having office hours is a good chance =
for contributors to
> > > > > > > > > > > > sync and also for those interested in the Linux per=
f tool to also
> > > > > > > > > > > > connect and share their problems and experiences. A=
s such we plan on
> > > > > > > > > > > > running our first office hours for this summer tomo=
rrow, the details
> > > > > > > > > > > > are below:
> > > > > > > > > > > >
> > > > > > > > > > > > Linux Perf Tool Office Hours
> > > > > > > > > > > > Thursday, June 1 =C2=B7 9:30 =E2=80=93 10:30am
> > > > > > > > > > > > Time zone: America/Los_Angeles
> > > > > > > > > > > > Google Meet joining info
> > > > > > > > > > > > Video call link: https://meet.google.com/jds-asbo-d=
ay
> > > > > > > > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN=
: =E2=80=AA817 018 892=E2=80=AC#
> > > > > > > > > > > > More phone numbers: https://tel.meet/jds-asbo-day?p=
in=3D6629252256983
> > > > > > > > > > > >
> > > > > > > > > > > > Please ask me and I'll be more than happy to add yo=
u to the calendar
> > > > > > > > > > > > invite for this. Over the summer we can adjust the =
timing of the
> > > > > > > > > > > > office hours to maximize participation, etc. so ple=
ase reach out and
> > > > > > > > > > > > share concerns.
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks,
> > > > > > > > > > > > Ian
> > > > > > > > > > > >
> > > > > > > > > > > > [1] https://lore.kernel.org/linux-perf-users/CAP-5=
=3DfWiQHvYZp5R=3Duw4xUwBiN1fBLBU8witPkYM+2r8tnYCOg@mail.gmail.com/
