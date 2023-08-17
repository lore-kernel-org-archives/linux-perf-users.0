Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C80EB64DD
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Aug 2023 06:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348173AbjHQGQc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Aug 2023 02:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346827AbjHQGQ0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Aug 2023 02:16:26 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C449C2D57
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Aug 2023 23:16:24 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40a47e8e38dso138671cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Aug 2023 23:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692252984; x=1692857784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDK3QgInK2ykhbFYvpWIXxMDwcr9shwZ5/2llewg4bo=;
        b=0yu2qIRl9rYj5DxlBrU0LgnYY0FLdpN4UArInv8nKVe+Rm5wwCMrYOgeDcxYGmrXjl
         TRigoly3+thgHsgk1Dr7JVAIlmR9DQyteIj9SGhO4ZgRAPLZFnOBrNFHKYOfFrCavH1e
         CtJvWH1RHlQDnfuDhnFCKmYCj5fWldv4g3Dz3nChbl636ELNV8pN64D047vuOpDFm745
         Ji73aLAoMXwF9rRHKtjs9M+jq5cEcrUGS8fAu7x6rWtAWoSpb3R7mCxhg7FotLJHimnE
         GZ4FNiM/HPOl+DWBvh7Ni7leZtlWiQgNoRETst+sHNzjvcyhN5P8aFxu5uuUQR8uPpGE
         4J9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692252984; x=1692857784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDK3QgInK2ykhbFYvpWIXxMDwcr9shwZ5/2llewg4bo=;
        b=XXiMFXoNFEuL5v44kdUyHmK88iVgxyZ/vAE7WcKZdhBufsHUz32TFyYvAKiwk7TWlZ
         vY6TJQGdAUFY7VOyObcRvzMuiBPWf1iRKSDRRM7xWbkmFgN2xZpkwGxY4V8O7eXTknfN
         IFZ2vu/8EesKeitp33yX5nzTomeWetCjhLwUpDK9uxgNCbxVYR33nxbWwQitXqW33RAc
         23LvPIZ3JZl9jgkfCg1IFRN3ky99XrSPcqYIw3pNs1UrUOpisPolyqSstQZbRwGYTSaB
         Zzx8fq8bY6PMriXrlIMOrD2sExgDVhykOQGcHNLs6ak5EuSmzKbrJa7C54RDLnpw3UNF
         2ZUg==
X-Gm-Message-State: AOJu0Yzc+KWdHn4e2aCiICpnwBuze2d5g2tL2jTRNFUz67nUWVh1ILvn
        bw/wHQNMlO2fAIG9gjsp9DfA++DpeNL5f9On073pIZ4fq//mOT6Jd+TEt8khs4w=
X-Google-Smtp-Source: AGHT+IG6JVkduBKUcJMGKYxAmtvEPw2N2fE+eVFAwD48nCwVtvDNN1YPJ7Gz7+u7elnc0/SSdSoOoc5Nlmey7mzyH5o=
X-Received: by 2002:a05:622a:1a18:b0:3f9:56c:1129 with SMTP id
 f24-20020a05622a1a1800b003f9056c1129mr116759qtb.5.1692252983538; Wed, 16 Aug
 2023 23:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fU10YCxZfq=dOUUPR0dRusbq=vzp5CqsOuz1aLVY16KAw@mail.gmail.com>
 <CAP-5=fWOCE6+9MuiFziHz1o6Ej-FTDJa1fnkhYpifz7Rtazk8Q@mail.gmail.com>
 <CAP-5=fXf-FmKb=D4h5VgxQ=w3T3+Nn3AP4ExR9YjnKFB=4m7bA@mail.gmail.com>
 <CAP-5=fWSHpWx02+nB8joo0JbtNJXAEHFLBdY7n5W=tSbdpMGkg@mail.gmail.com>
 <CAP-5=fX9OXTiiojNp-ut-_LOD2=6+mEN8iAt=UUGfmDu4q+F3Q@mail.gmail.com>
 <CAP-5=fU6TWKQ8eDUM5UFfO2h6TgL9j7-43eWfZMTbwpRqHS6OA@mail.gmail.com>
 <CAP-5=fX4Fj3phsny8zPueJpUaxN0jEhvJarc3ghz46RCtu0C+A@mail.gmail.com>
 <CAP-5=fV6f3NeSbKatG0_LCROUr=2xdcrC7PnC3D0YprtCDaTow@mail.gmail.com>
 <CAP-5=fU2dPih+JPUOkoHyiFvMwd9KRHiKDtuNeatPsaE0VxbsQ@mail.gmail.com> <CAP-5=fWRELRNg3guvsXu-PJU4MfJ+tj3zZRWpSrmCK5AP39ANg@mail.gmail.com>
In-Reply-To: <CAP-5=fWRELRNg3guvsXu-PJU4MfJ+tj3zZRWpSrmCK5AP39ANg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 16 Aug 2023 23:16:11 -0700
Message-ID: <CAP-5=fVqbAej4aJV-BDsBSpgAnmad+RXC_0Z_81Ma8WZXUkNWg@mail.gmail.com>
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
Thursday, August 17 =C2=B7 9:00 =E2=80=93 9:45am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/jds-asbo-day
Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 892=
=E2=80=AC#
More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983

Thanks,
Ian

On Wed, Aug 9, 2023 at 1:32=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Hi,
>
> Just a heads up that we plan to skip office hours tomorrow.
>
> Thanks,
> Ian
>
> On Wed, Aug 2, 2023 at 1:09=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > First office hours of August tomorrow:
> >
> > Linux Perf Tool Office Hours
> > Thursday, August 3 =C2=B7 9:00 =E2=80=93 9:45am
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
> > On Wed, Jul 26, 2023 at 2:53=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > A reminder there is the usual office hours tomorrow. This is an
> > > excellent opportunity to ask questions and hear the latest on Anup's
> > > firefox profiler work.
> > >
> > > Linux Perf Tool Office Hours
> > > Thursday, July 27 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > On Wed, Jul 19, 2023 at 3:29=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > A reminder there is the usual office hours tomorrow:
> > > >
> > > > Linux Perf Tool Office Hours
> > > > Thursday, July 20 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > > On Wed, Jul 12, 2023 at 3:42=E2=80=AFPM Ian Rogers <irogers@google.=
com> wrote:
> > > > >
> > > > > A reminder there are office hours tomorrow. This is a particular
> > > > > useful time to sync with Anup, the Linux Foundation Google
> > > > > Summer-of-Code contributor this year.
> > > > >
> > > > > Linux Perf Tool Office Hours
> > > > > Thursday, July 13 =C2=B7 9:00 =E2=80=93 9:45am
> > > > > Time zone: America/Los_Angeles
> > > > > Google Meet joining info
> > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817=
 018 892=E2=80=AC#
> > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D662925225=
6983
> > > > >
> > > > > Thanks!
> > > > > Ian
> > > > > On Thu, Jul 6, 2023 at 8:31=E2=80=AFAM Ian Rogers <irogers@google=
.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Sorry for the late notice. Office hours today in 30 minutes.
> > > > > >
> > > > > > Linux Perf Tool Office Hours
> > > > > > Thursday, July 6 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > > > > On Wed, Jun 21, 2023 at 3:15=E2=80=AFPM Ian Rogers <irogers@goo=
gle.com> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > Office hours reminder tomorrow. A chance to discuss any topic=
s of the
> > > > > > > day and for
> > > > > > > GSoC contributor sync.
> > > > > > >
> > > > > > > Linux Perf Tool Office Hours
> > > > > > > Thursday, June 22 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > > > > > On Wed, Jun 14, 2023 at 10:01=E2=80=AFAM Ian Rogers <irogers@=
google.com> wrote:
> > > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > Office hours reminder. A chance to discuss topics of the da=
y and for
> > > > > > > > GSoC contributor sync.
> > > > > > > >
> > > > > > > > Linux Perf Tool Office Hours
> > > > > > > > Thursday, June 15 =C2=B7 9:00 =E2=80=93 9:45am
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
> > > > > > > > On Wed, Jun 7, 2023 at 9:14=E2=80=AFPM Ian Rogers <irogers@=
google.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > Office hours and chance for GSoC contributor sync slightl=
y earlier at
> > > > > > > > > 9am PT tomorrow:
> > > > > > > > >
> > > > > > > > > Linux Perf Tool Office Hours
> > > > > > > > > Thursday, June 8 =C2=B7 9:00 =E2=80=93 9:45am
> > > > > > > > > Time zone: America/Los_Angeles
> > > > > > > > > Google Meet joining info
> > > > > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=
=80=AA817 018 892=E2=80=AC#
> > > > > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6=
629252256983
> > > > > > > > >
> > > > > > > > > If you'd like to randomly drop in, feel free. An issue I'=
m keen to
> > > > > > > > > discuss is memory usage and memory leaks.
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Ian
> > > > > > > > >
> > > > > > > > > On Wed, May 31, 2023 at 10:00=E2=80=AFAM Ian Rogers <irog=
ers@google.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi,
> > > > > > > > > >
> > > > > > > > > > On Monday the Google Summer-of-Code officially started =
and Anup is
> > > > > > > > > > this summer's contributor to the Linux perf tool! We've=
 found in the
> > > > > > > > > > past [1] that having office hours is a good chance for =
contributors to
> > > > > > > > > > sync and also for those interested in the Linux perf to=
ol to also
> > > > > > > > > > connect and share their problems and experiences. As su=
ch we plan on
> > > > > > > > > > running our first office hours for this summer tomorrow=
, the details
> > > > > > > > > > are below:
> > > > > > > > > >
> > > > > > > > > > Linux Perf Tool Office Hours
> > > > > > > > > > Thursday, June 1 =C2=B7 9:30 =E2=80=93 10:30am
> > > > > > > > > > Time zone: America/Los_Angeles
> > > > > > > > > > Google Meet joining info
> > > > > > > > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > > > > > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =
=E2=80=AA817 018 892=E2=80=AC#
> > > > > > > > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=
=3D6629252256983
> > > > > > > > > >
> > > > > > > > > > Please ask me and I'll be more than happy to add you to=
 the calendar
> > > > > > > > > > invite for this. Over the summer we can adjust the timi=
ng of the
> > > > > > > > > > office hours to maximize participation, etc. so please =
reach out and
> > > > > > > > > > share concerns.
> > > > > > > > > >
> > > > > > > > > > Thanks,
> > > > > > > > > > Ian
> > > > > > > > > >
> > > > > > > > > > [1] https://lore.kernel.org/linux-perf-users/CAP-5=3DfW=
iQHvYZp5R=3Duw4xUwBiN1fBLBU8witPkYM+2r8tnYCOg@mail.gmail.com/
