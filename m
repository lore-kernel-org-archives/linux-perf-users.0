Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F86EB64DD
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 Jul 2023 22:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjGLWmn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Jul 2023 18:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjGLWmm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2023 18:42:42 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891B31991
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 15:42:41 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4036bd4fff1so60061cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 15:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689201760; x=1691793760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VQI7IHQ32fYOu1ctgLnM5TriIHYXUiZWWMPHZcv1Ic=;
        b=d8u5ZTPsNhRfL1Krkm/1jVnT58lf0TacfmwHOofwH/X41dT/hR/7IT+DbbEGbVrzMx
         QPLqzC+RYh0qV1HJEvR/6FKAb5TECshZkDV97eBJBXgk0gWMgfKxgbKzGdRAIVzoqR3z
         PmZ3F2zDS1NLHcQ11ZaVcaT8FdV8U0YIsf4jmZ2oREdLTUnEZDjriCoLwN/rEPn42HkP
         XG/CJ/LcIgbflh637HxT+i9fEirDc9Nwqog2cbyw0ueV8G1xEfuoPnGD6ewsWTjfnbiJ
         p44kd68P9KtNrpErL8A7N47Er0/bGV/MZWJ9J+mRHOZZhfx2m1ZCDVGUio274wXRYlVH
         DccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689201760; x=1691793760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VQI7IHQ32fYOu1ctgLnM5TriIHYXUiZWWMPHZcv1Ic=;
        b=foNyaP8+1trf8ipq1mohL79QVI6/UGGBAHY3qW/hvQY13is+80bSgTXMUVUGlBu972
         PqSM+9rGNEvKTEoYFnXDVOULUe5IAFcFNkza/cSFfAK3SLINER0Gh7oYjjptrN4KCIut
         m4aZswTncr3iBgl4cFyi0Am9V8lbhTldJ88Q8wYmhYjsbBlLD2w2eCi8tZwR1ECqIqj6
         3YUvBz659/NzdIu/ymoq856t576h/5y3ChfoBtTRgQxSn0BHI42I68TLgSSEKxOuaWrx
         LZnhf4D54EcgHy/I3NLrj6a7LJo1AJn0abApi3TfZeDbDMLB151CDY0ooQLKtB3i4Dam
         7jRQ==
X-Gm-Message-State: ABy/qLaYW0btHa0ybpjjWLrpgF3TAhkyVOCohDR57wxYp5uQE/bq1YoF
        Yi4EeI7aGczN8cJTBaZ6ewCr2HDyTMqYJkxwfUV+pHcMQ0B21ARpZhU=
X-Google-Smtp-Source: APBJJlHL1UrMUApJEmKutXDSS25NRkZ9XoLFAlVK0Y9Af1wEyX22Wf8KvJsx7eEGhtlNpQamD417QYRishOtYxTDVhg=
X-Received: by 2002:ac8:59ce:0:b0:3f8:8c06:c53b with SMTP id
 f14-20020ac859ce000000b003f88c06c53bmr469520qtf.0.1689201760021; Wed, 12 Jul
 2023 15:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fU10YCxZfq=dOUUPR0dRusbq=vzp5CqsOuz1aLVY16KAw@mail.gmail.com>
 <CAP-5=fWOCE6+9MuiFziHz1o6Ej-FTDJa1fnkhYpifz7Rtazk8Q@mail.gmail.com>
 <CAP-5=fXf-FmKb=D4h5VgxQ=w3T3+Nn3AP4ExR9YjnKFB=4m7bA@mail.gmail.com>
 <CAP-5=fWSHpWx02+nB8joo0JbtNJXAEHFLBdY7n5W=tSbdpMGkg@mail.gmail.com> <CAP-5=fX9OXTiiojNp-ut-_LOD2=6+mEN8iAt=UUGfmDu4q+F3Q@mail.gmail.com>
In-Reply-To: <CAP-5=fX9OXTiiojNp-ut-_LOD2=6+mEN8iAt=UUGfmDu4q+F3Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 15:42:28 -0700
Message-ID: <CAP-5=fU6TWKQ8eDUM5UFfO2h6TgL9j7-43eWfZMTbwpRqHS6OA@mail.gmail.com>
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

A reminder there are office hours tomorrow. This is a particular
useful time to sync with Anup, the Linux Foundation Google
Summer-of-Code contributor this year.

Linux Perf Tool Office Hours
Thursday, July 13 =C2=B7 9:00 =E2=80=93 9:45am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/jds-asbo-day
Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 892=
=E2=80=AC#
More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983

Thanks!
Ian
On Thu, Jul 6, 2023 at 8:31=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> Hi,
>
> Sorry for the late notice. Office hours today in 30 minutes.
>
> Linux Perf Tool Office Hours
> Thursday, July 6 =C2=B7 9:00 =E2=80=93 9:45am
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
> On Wed, Jun 21, 2023 at 3:15=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Hi,
> >
> > Office hours reminder tomorrow. A chance to discuss any topics of the
> > day and for
> > GSoC contributor sync.
> >
> > Linux Perf Tool Office Hours
> > Thursday, June 22 =C2=B7 9:00 =E2=80=93 9:45am
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
> > On Wed, Jun 14, 2023 at 10:01=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > Hi,
> > >
> > > Office hours reminder. A chance to discuss topics of the day and for
> > > GSoC contributor sync.
> > >
> > > Linux Perf Tool Office Hours
> > > Thursday, June 15 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > On Wed, Jun 7, 2023 at 9:14=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > > >
> > > > Hi,
> > > >
> > > > Office hours and chance for GSoC contributor sync slightly earlier =
at
> > > > 9am PT tomorrow:
> > > >
> > > > Linux Perf Tool Office Hours
> > > > Thursday, June 8 =C2=B7 9:00 =E2=80=93 9:45am
> > > > Time zone: America/Los_Angeles
> > > > Google Meet joining info
> > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 0=
18 892=E2=80=AC#
> > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D66292522569=
83
> > > >
> > > > If you'd like to randomly drop in, feel free. An issue I'm keen to
> > > > discuss is memory usage and memory leaks.
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > On Wed, May 31, 2023 at 10:00=E2=80=AFAM Ian Rogers <irogers@google=
.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Monday the Google Summer-of-Code officially started and Anup i=
s
> > > > > this summer's contributor to the Linux perf tool! We've found in =
the
> > > > > past [1] that having office hours is a good chance for contributo=
rs to
> > > > > sync and also for those interested in the Linux perf tool to also
> > > > > connect and share their problems and experiences. As such we plan=
 on
> > > > > running our first office hours for this summer tomorrow, the deta=
ils
> > > > > are below:
> > > > >
> > > > > Linux Perf Tool Office Hours
> > > > > Thursday, June 1 =C2=B7 9:30 =E2=80=93 10:30am
> > > > > Time zone: America/Los_Angeles
> > > > > Google Meet joining info
> > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817=
 018 892=E2=80=AC#
> > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D662925225=
6983
> > > > >
> > > > > Please ask me and I'll be more than happy to add you to the calen=
dar
> > > > > invite for this. Over the summer we can adjust the timing of the
> > > > > office hours to maximize participation, etc. so please reach out =
and
> > > > > share concerns.
> > > > >
> > > > > Thanks,
> > > > > Ian
> > > > >
> > > > > [1] https://lore.kernel.org/linux-perf-users/CAP-5=3DfWiQHvYZp5R=
=3Duw4xUwBiN1fBLBU8witPkYM+2r8tnYCOg@mail.gmail.com/
