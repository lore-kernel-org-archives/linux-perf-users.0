Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C498EB64D9
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Jul 2023 15:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjGFPbv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Jul 2023 11:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjGFPbu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Jul 2023 11:31:50 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BF7C1
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Jul 2023 08:31:49 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40371070eb7so287001cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Jul 2023 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688657508; x=1691249508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O2q26VvR+9VHhrpz69HbegFWYt8ptXV+CLcE4F4dy4=;
        b=vIaae8yWZ1g80QunpRprQHwT7ZMNc9kgFaglfyvo/wa8Pp26PkEzFZ1wG3wffhI4Ju
         5e9RwR4A/h/GvGkKMrKWvG6BS6XId3chBy/fog0fyRJ9u6Jd98MX5QcA5C3eTpQf/Dg4
         NT30WoH8phQWfVFVtvvYrkf6xEjjPPEPCcMByBu4uyHzPRWjKvCrRgZJsOodHg9iP/XE
         iVEZh3GwA9Zs7o4qnzLWxefDbXVoLzU/q5HirVQuj8HdAaytwHVzPHAvq60CLmak7G+B
         mgDWjfLoFgZyT01YfKZMz4XJBJdziZqqYIytLCqdqU+egGg44GuM6P5WAXc4PMNKSDd+
         Eq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688657508; x=1691249508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/O2q26VvR+9VHhrpz69HbegFWYt8ptXV+CLcE4F4dy4=;
        b=fagwE5uDRB1HfLj0SZjjrW2ycg9XeinNQaTIKfW9kQWDUsQ141hkX1BzXa13oDMBG5
         gr5S976hu8ftMCmbwkzLKKgDOoV2Lrd0Mqm3/8XjWSOhxSvtvVg71JjZQYYXGK7UPqUg
         KECIo/3Hk5WPvWh+YrQQOrbWYMchkRAifxV70BdxkX1PuQt61zAwtp3+q5PJeay5t+9T
         kbofE731chPnCTxZym1YtAIVMNZRCN/lOhaUkhL0SZhogQRuAIqdtAfOmzrmf76/dPbX
         xpmY6JS5IEuKx5P60vp/iEZNohAAGL05pqCkSza3i2LHq4m+2qnFktAgeqC3FpDrdjFt
         ejhQ==
X-Gm-Message-State: ABy/qLZmR8kOMtMJMgHuSUJCx4s4rV47mZxFEarUKhl8Flr+IQZpzwqt
        GXlEP4sF1CexS1eQPl8CSZdRNFpBHlyqvZfi57tbD9J2EPgi5Phwxqh8aw==
X-Google-Smtp-Source: APBJJlHP/JqaG9zQfVKUtFbNQbBLfrCriDdNQpIUL5J46GpNwetjLuXQ/klkyZ0FoaqAnQKb6KKL44hPuV+UadZsoMg=
X-Received: by 2002:a05:622a:1794:b0:3ef:3083:a437 with SMTP id
 s20-20020a05622a179400b003ef3083a437mr183165qtk.18.1688657508382; Thu, 06 Jul
 2023 08:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fU10YCxZfq=dOUUPR0dRusbq=vzp5CqsOuz1aLVY16KAw@mail.gmail.com>
 <CAP-5=fWOCE6+9MuiFziHz1o6Ej-FTDJa1fnkhYpifz7Rtazk8Q@mail.gmail.com>
 <CAP-5=fXf-FmKb=D4h5VgxQ=w3T3+Nn3AP4ExR9YjnKFB=4m7bA@mail.gmail.com> <CAP-5=fWSHpWx02+nB8joo0JbtNJXAEHFLBdY7n5W=tSbdpMGkg@mail.gmail.com>
In-Reply-To: <CAP-5=fWSHpWx02+nB8joo0JbtNJXAEHFLBdY7n5W=tSbdpMGkg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 6 Jul 2023 08:31:37 -0700
Message-ID: <CAP-5=fX9OXTiiojNp-ut-_LOD2=6+mEN8iAt=UUGfmDu4q+F3Q@mail.gmail.com>
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

Sorry for the late notice. Office hours today in 30 minutes.

Linux Perf Tool Office Hours
Thursday, July 6 =C2=B7 9:00 =E2=80=93 9:45am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/jds-asbo-day
Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 892=
=E2=80=AC#
More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983

Thanks,
Ian

On Wed, Jun 21, 2023 at 3:15=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Hi,
>
> Office hours reminder tomorrow. A chance to discuss any topics of the
> day and for
> GSoC contributor sync.
>
> Linux Perf Tool Office Hours
> Thursday, June 22 =C2=B7 9:00 =E2=80=93 9:45am
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
> On Wed, Jun 14, 2023 at 10:01=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Hi,
> >
> > Office hours reminder. A chance to discuss topics of the day and for
> > GSoC contributor sync.
> >
> > Linux Perf Tool Office Hours
> > Thursday, June 15 =C2=B7 9:00 =E2=80=93 9:45am
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
> > On Wed, Jun 7, 2023 at 9:14=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > Hi,
> > >
> > > Office hours and chance for GSoC contributor sync slightly earlier at
> > > 9am PT tomorrow:
> > >
> > > Linux Perf Tool Office Hours
> > > Thursday, June 8 =C2=B7 9:00 =E2=80=93 9:45am
> > > Time zone: America/Los_Angeles
> > > Google Meet joining info
> > > Video call link: https://meet.google.com/jds-asbo-day
> > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018=
 892=E2=80=AC#
> > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983
> > >
> > > If you'd like to randomly drop in, feel free. An issue I'm keen to
> > > discuss is memory usage and memory leaks.
> > >
> > > Thanks,
> > > Ian
> > >
> > > On Wed, May 31, 2023 at 10:00=E2=80=AFAM Ian Rogers <irogers@google.c=
om> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Monday the Google Summer-of-Code officially started and Anup is
> > > > this summer's contributor to the Linux perf tool! We've found in th=
e
> > > > past [1] that having office hours is a good chance for contributors=
 to
> > > > sync and also for those interested in the Linux perf tool to also
> > > > connect and share their problems and experiences. As such we plan o=
n
> > > > running our first office hours for this summer tomorrow, the detail=
s
> > > > are below:
> > > >
> > > > Linux Perf Tool Office Hours
> > > > Thursday, June 1 =C2=B7 9:30 =E2=80=93 10:30am
> > > > Time zone: America/Los_Angeles
> > > > Google Meet joining info
> > > > Video call link: https://meet.google.com/jds-asbo-day
> > > > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 0=
18 892=E2=80=AC#
> > > > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D66292522569=
83
> > > >
> > > > Please ask me and I'll be more than happy to add you to the calenda=
r
> > > > invite for this. Over the summer we can adjust the timing of the
> > > > office hours to maximize participation, etc. so please reach out an=
d
> > > > share concerns.
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > [1] https://lore.kernel.org/linux-perf-users/CAP-5=3DfWiQHvYZp5R=3D=
uw4xUwBiN1fBLBU8witPkYM+2r8tnYCOg@mail.gmail.com/
