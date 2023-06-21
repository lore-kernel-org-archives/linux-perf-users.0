Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE17EB64D7
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jun 2023 22:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFUWPT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jun 2023 18:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFUWPS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jun 2023 18:15:18 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0862E57
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 15:15:16 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40079620a83so27621cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 15:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687385716; x=1689977716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/V9hcfRDd+4fTtsHZ3DVg626x9WvevAdlF2CmwoQVrU=;
        b=H7B8TbgLuiB5ee1zf9eBM+j8mBfN+X5Qn7TFuHELbj2vlVHU74nURiMR/UQTd3CiZt
         PWV8ajw4mz8LGv7VYqIXOcfd2nJKDiHNYBOmgxPag7LHkmzTE47D8aIya4ErevxcRPck
         bRlWLmKzwZCOz6wc5DQLnIAxbxNlORG4homraypPCze6YDOXr0/xRphQgWIkGWHL8kb7
         lhlyAhEMJ/YkcfIiCV3eqAlgqHt3Uc2J0zNzoa6TzfpX0dSKbCqAJKyygXwRmb1+z55k
         okY0oeXqwS3AE52k/nY4Uwtn0D3WmOyyOOSQ+wPbGWP3Ny30EOPOIxUbXUrBO3goSAZ3
         tONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687385716; x=1689977716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/V9hcfRDd+4fTtsHZ3DVg626x9WvevAdlF2CmwoQVrU=;
        b=lTOaXsCnW0hBSslWYrlmm/3bKV02Y6bz8MRB1V/rxjskhtNP1T77azFVidMTsduKYp
         9Io4oM9FIgHjQGhgFTrRf1asEKHKAeUN9Ql2/yhiG9g9OlGFkwjKA5jqmiX/NxgyrjCJ
         bVVys5kNIqTUOfQGAHbWOxIiUyLEvJJrp6/bmVBZk7GRjJ9hyNBIDJ9r0mi4nxWR5unr
         nZV5DQAviSx7VP+HZx/jEUM7h7lDD6Nb1n+yA/AcfYxWeZL3CvaxpfUWUFZOEBoWSLgs
         nMMLc9RJ4n1i2VJb5X4Nb5eWd0llXoelXdr2eL1FhsIqXRdsiyb24qsVj1WUKvkUOrw8
         Ov4g==
X-Gm-Message-State: AC+VfDybF08+gvJJ9obUejuqTIRmYvRHnqg6S4HBQqrfLbTt8CY0dg4c
        Tjpz9yoQByYe6lOp4Tl5AVDVO0aoR2iN896sW4fxqytNqUaAS4ndXzfKFA==
X-Google-Smtp-Source: ACHHUZ5xWpxB+KTmYui62ndf8rL8JgqaovhT5HAaiLf2GwtWdTwHjcr6R8XfXi+Tc68DlIo0B73hKuC3Kk6Pvz/1zFA=
X-Received: by 2002:a05:622a:20a:b0:3f9:a78f:c527 with SMTP id
 b10-20020a05622a020a00b003f9a78fc527mr1228529qtx.21.1687385715668; Wed, 21
 Jun 2023 15:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fU10YCxZfq=dOUUPR0dRusbq=vzp5CqsOuz1aLVY16KAw@mail.gmail.com>
 <CAP-5=fWOCE6+9MuiFziHz1o6Ej-FTDJa1fnkhYpifz7Rtazk8Q@mail.gmail.com> <CAP-5=fXf-FmKb=D4h5VgxQ=w3T3+Nn3AP4ExR9YjnKFB=4m7bA@mail.gmail.com>
In-Reply-To: <CAP-5=fXf-FmKb=D4h5VgxQ=w3T3+Nn3AP4ExR9YjnKFB=4m7bA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 21 Jun 2023 15:15:04 -0700
Message-ID: <CAP-5=fWSHpWx02+nB8joo0JbtNJXAEHFLBdY7n5W=tSbdpMGkg@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Anup Sharma <anupnewsmail@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

Office hours reminder tomorrow. A chance to discuss any topics of the
day and for
GSoC contributor sync.

Linux Perf Tool Office Hours
Thursday, June 22 =C2=B7 9:00 =E2=80=93 9:45am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/jds-asbo-day
Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 892=
=E2=80=AC#
More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983

Thanks,
Ian

On Wed, Jun 14, 2023 at 10:01=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Hi,
>
> Office hours reminder. A chance to discuss topics of the day and for
> GSoC contributor sync.
>
> Linux Perf Tool Office Hours
> Thursday, June 15 =C2=B7 9:00 =E2=80=93 9:45am
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
> On Wed, Jun 7, 2023 at 9:14=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Hi,
> >
> > Office hours and chance for GSoC contributor sync slightly earlier at
> > 9am PT tomorrow:
> >
> > Linux Perf Tool Office Hours
> > Thursday, June 8 =C2=B7 9:00 =E2=80=93 9:45am
> > Time zone: America/Los_Angeles
> > Google Meet joining info
> > Video call link: https://meet.google.com/jds-asbo-day
> > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 8=
92=E2=80=AC#
> > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983
> >
> > If you'd like to randomly drop in, feel free. An issue I'm keen to
> > discuss is memory usage and memory leaks.
> >
> > Thanks,
> > Ian
> >
> > On Wed, May 31, 2023 at 10:00=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > Hi,
> > >
> > > On Monday the Google Summer-of-Code officially started and Anup is
> > > this summer's contributor to the Linux perf tool! We've found in the
> > > past [1] that having office hours is a good chance for contributors t=
o
> > > sync and also for those interested in the Linux perf tool to also
> > > connect and share their problems and experiences. As such we plan on
> > > running our first office hours for this summer tomorrow, the details
> > > are below:
> > >
> > > Linux Perf Tool Office Hours
> > > Thursday, June 1 =C2=B7 9:30 =E2=80=93 10:30am
> > > Time zone: America/Los_Angeles
> > > Google Meet joining info
> > > Video call link: https://meet.google.com/jds-asbo-day
> > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018=
 892=E2=80=AC#
> > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983
> > >
> > > Please ask me and I'll be more than happy to add you to the calendar
> > > invite for this. Over the summer we can adjust the timing of the
> > > office hours to maximize participation, etc. so please reach out and
> > > share concerns.
> > >
> > > Thanks,
> > > Ian
> > >
> > > [1] https://lore.kernel.org/linux-perf-users/CAP-5=3DfWiQHvYZp5R=3Duw=
4xUwBiN1fBLBU8witPkYM+2r8tnYCOg@mail.gmail.com/
