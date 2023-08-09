Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0075DC001E0
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Aug 2023 20:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjHIUdC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjHIUc7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Aug 2023 16:32:59 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB352111
        for <linux-perf-users@vger.kernel.org>; Wed,  9 Aug 2023 13:32:58 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-407db3e9669so12201cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Aug 2023 13:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691613177; x=1692217977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uxEA70Qpn19mpeD2IsqL/c/90TXAqEJ1FrvLFSCaYU=;
        b=T6svRFN/mBHZ47SLJUO36cUQKf2a/CBB6QK95SmqvLnOlZTppYrbT66sJ0rniq2iNV
         y8zZWZyssehYuimT2nIoHgq+OV+XDkmRgKadhvmzLeMtQX1zUZBE/Qjfn5Sxq9dJ7X6g
         Q+gX2IrSoqgz0QP2zNV98Dra1gcgyBcj1HnSun3Iq+OcNDXbkSitMRkvP+jGE3zqVT/V
         KOo+wrkqMi+uXeL9T5YPP/O4f+lUleeyrN1HCJj8SRRfEPj0O1I6+ve1ijQE+9BPxTob
         aasmZ0iWHJlXhEPr5Hw++Hns6G7llc7NvX44jCN/3mFMTrpw8VxMNC7WhmQZDF0wk3Xu
         4AOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691613177; x=1692217977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uxEA70Qpn19mpeD2IsqL/c/90TXAqEJ1FrvLFSCaYU=;
        b=bPSmPmu0sfbzmzMvFw5/1rqqzV8KaF7JNIcN3W5mdYpu8qVr1Pix5LjpG1tI/2EXx6
         +47Acbry4LPbUz6w+/pGrTjDnEI9eywr/617u4F2uQSZ84va/tJEfd+HILrMgT2teoWM
         aze8buuvDR+PFawV2lLHixpd5rRnEfczEebjXpTULUhuHL5wc3VBf92MrlwruAC1FOVH
         s4C+6iyldXCI0z9UnJ1XUrQ4j/M4+0RnK+mRV3BoHOEm8lSEZTIdM1RaLuoipLqzPrIp
         YE8Dx3Y3ZdWvfsBYLSkD+YFE91cyQjUZkECH1SdEVk8SS8vY95a9lx3sUtKfKkHyfBap
         HMbQ==
X-Gm-Message-State: AOJu0Yw56n+0AGlusHpPHegBPuHQFZiWZdCFzO2inhfd4axzQG0Ofi/J
        oZUe1kSMPr+5rkxSV4q9G+g81XR2n/bUBlOGaSyt7PHX67Glrn+ghSjKXw==
X-Google-Smtp-Source: AGHT+IGeFJEZv9B22XLwThnF0HuyuOnNzKHMOqPy21ZBhN+U8yqT+W8FfR4r1C8WcfAGvYevUAjdjKqogwYRYmB4cIc=
X-Received: by 2002:ac8:7f86:0:b0:403:dcd4:b9b1 with SMTP id
 z6-20020ac87f86000000b00403dcd4b9b1mr206583qtj.18.1691613177356; Wed, 09 Aug
 2023 13:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fU10YCxZfq=dOUUPR0dRusbq=vzp5CqsOuz1aLVY16KAw@mail.gmail.com>
 <CAP-5=fWOCE6+9MuiFziHz1o6Ej-FTDJa1fnkhYpifz7Rtazk8Q@mail.gmail.com>
 <CAP-5=fXf-FmKb=D4h5VgxQ=w3T3+Nn3AP4ExR9YjnKFB=4m7bA@mail.gmail.com>
 <CAP-5=fWSHpWx02+nB8joo0JbtNJXAEHFLBdY7n5W=tSbdpMGkg@mail.gmail.com>
 <CAP-5=fX9OXTiiojNp-ut-_LOD2=6+mEN8iAt=UUGfmDu4q+F3Q@mail.gmail.com>
 <CAP-5=fU6TWKQ8eDUM5UFfO2h6TgL9j7-43eWfZMTbwpRqHS6OA@mail.gmail.com>
 <CAP-5=fX4Fj3phsny8zPueJpUaxN0jEhvJarc3ghz46RCtu0C+A@mail.gmail.com>
 <CAP-5=fV6f3NeSbKatG0_LCROUr=2xdcrC7PnC3D0YprtCDaTow@mail.gmail.com> <CAP-5=fU2dPih+JPUOkoHyiFvMwd9KRHiKDtuNeatPsaE0VxbsQ@mail.gmail.com>
In-Reply-To: <CAP-5=fU2dPih+JPUOkoHyiFvMwd9KRHiKDtuNeatPsaE0VxbsQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 9 Aug 2023 13:32:44 -0700
Message-ID: <CAP-5=fWRELRNg3guvsXu-PJU4MfJ+tj3zZRWpSrmCK5AP39ANg@mail.gmail.com>
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

Hi,

Just a heads up that we plan to skip office hours tomorrow.

Thanks,
Ian

On Wed, Aug 2, 2023 at 1:09=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> First office hours of August tomorrow:
>
> Linux Perf Tool Office Hours
> Thursday, August 3 =C2=B7 9:00 =E2=80=93 9:45am
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
> On Wed, Jul 26, 2023 at 2:53=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > A reminder there is the usual office hours tomorrow. This is an
> > excellent opportunity to ask questions and hear the latest on Anup's
> > firefox profiler work.
> >
> > Linux Perf Tool Office Hours
> > Thursday, July 27 =C2=B7 9:00 =E2=80=93 9:45am
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
> > On Wed, Jul 19, 2023 at 3:29=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > A reminder there is the usual office hours tomorrow:
> > >
> > > Linux Perf Tool Office Hours
> > > Thursday, July 20 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > On Wed, Jul 12, 2023 at 3:42=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > A reminder there are office hours tomorrow. This is a particular
> > > > useful time to sync with Anup, the Linux Foundation Google
> > > > Summer-of-Code contributor this year.
> > > >
> > > > Linux Perf Tool Office Hours
> > > > Thursday, July 13 =C2=B7 9:00 =E2=80=93 9:45am
> > > > Time zone: America/Los_Angeles
> > > > Google Meet joining info
> > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 0=
18 892=E2=80=AC#
> > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D66292522569=
83
> > > >
> > > > Thanks!
> > > > Ian
> > > > On Thu, Jul 6, 2023 at 8:31=E2=80=AFAM Ian Rogers <irogers@google.c=
om> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > Sorry for the late notice. Office hours today in 30 minutes.
> > > > >
> > > > > Linux Perf Tool Office Hours
> > > > > Thursday, July 6 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > > > On Wed, Jun 21, 2023 at 3:15=E2=80=AFPM Ian Rogers <irogers@googl=
e.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Office hours reminder tomorrow. A chance to discuss any topics =
of the
> > > > > > day and for
> > > > > > GSoC contributor sync.
> > > > > >
> > > > > > Linux Perf Tool Office Hours
> > > > > > Thursday, June 22 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > > > > On Wed, Jun 14, 2023 at 10:01=E2=80=AFAM Ian Rogers <irogers@go=
ogle.com> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > Office hours reminder. A chance to discuss topics of the day =
and for
> > > > > > > GSoC contributor sync.
> > > > > > >
> > > > > > > Linux Perf Tool Office Hours
> > > > > > > Thursday, June 15 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > > > > > On Wed, Jun 7, 2023 at 9:14=E2=80=AFPM Ian Rogers <irogers@go=
ogle.com> wrote:
> > > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > Office hours and chance for GSoC contributor sync slightly =
earlier at
> > > > > > > > 9am PT tomorrow:
> > > > > > > >
> > > > > > > > Linux Perf Tool Office Hours
> > > > > > > > Thursday, June 8 =C2=B7 9:00 =E2=80=93 9:45am
> > > > > > > > Time zone: America/Los_Angeles
> > > > > > > > Google Meet joining info
> > > > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=
=AA817 018 892=E2=80=AC#
> > > > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D662=
9252256983
> > > > > > > >
> > > > > > > > If you'd like to randomly drop in, feel free. An issue I'm =
keen to
> > > > > > > > discuss is memory usage and memory leaks.
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Ian
> > > > > > > >
> > > > > > > > On Wed, May 31, 2023 at 10:00=E2=80=AFAM Ian Rogers <iroger=
s@google.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > On Monday the Google Summer-of-Code officially started an=
d Anup is
> > > > > > > > > this summer's contributor to the Linux perf tool! We've f=
ound in the
> > > > > > > > > past [1] that having office hours is a good chance for co=
ntributors to
> > > > > > > > > sync and also for those interested in the Linux perf tool=
 to also
> > > > > > > > > connect and share their problems and experiences. As such=
 we plan on
> > > > > > > > > running our first office hours for this summer tomorrow, =
the details
> > > > > > > > > are below:
> > > > > > > > >
> > > > > > > > > Linux Perf Tool Office Hours
> > > > > > > > > Thursday, June 1 =C2=B7 9:30 =E2=80=93 10:30am
> > > > > > > > > Time zone: America/Los_Angeles
> > > > > > > > > Google Meet joining info
> > > > > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=
=80=AA817 018 892=E2=80=AC#
> > > > > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6=
629252256983
> > > > > > > > >
> > > > > > > > > Please ask me and I'll be more than happy to add you to t=
he calendar
> > > > > > > > > invite for this. Over the summer we can adjust the timing=
 of the
> > > > > > > > > office hours to maximize participation, etc. so please re=
ach out and
> > > > > > > > > share concerns.
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Ian
> > > > > > > > >
> > > > > > > > > [1] https://lore.kernel.org/linux-perf-users/CAP-5=3DfWiQ=
HvYZp5R=3Duw4xUwBiN1fBLBU8witPkYM+2r8tnYCOg@mail.gmail.com/
