Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134CDEB64D8
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jun 2023 17:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjFNRBX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jun 2023 13:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFNRBW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jun 2023 13:01:22 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023DA1FF7
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 10:01:21 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b1b51ec3e9so5085ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 10:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686762080; x=1689354080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2kXI5LNkO41mLohZbiucFhhM31sH24JRgQf7SGPXRE=;
        b=HeL+ntfJBTcOvMFFBDo57E27h5R0X1NWCpeV0apMB7D9d1l+gOHc9Ldtc5hc9UNTO7
         BJJt3gp13TgdGZ9RG1QZlDe6KCd4GxzT8y7r41xInAwyWQnfsTq7L9kCVee34CdoxfJ+
         MXnBQSZmBM5/CTrLivrhG+Uh5H0vEKR/KsbCc8QmRn6dPj7kTEdH3flTmkQoqRkqX8Xw
         MZ6A9SpMqL+MnTpvXT2TZofhajzPS3Ojf8VfGaIpNHLT+e3NcPLFFFffYAyGppzCyOd1
         fvhGH6Xnq1QNT4q+2Y8FS2evGsHAEdLcAtGhVjKyggRu98+4FM9iZ1dN/g5PhB6hI566
         pJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686762080; x=1689354080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2kXI5LNkO41mLohZbiucFhhM31sH24JRgQf7SGPXRE=;
        b=iMKTuDSBfm8Aqjk/oSroPiyBDMi/4tNsHqFcH67iAp5JVyf6VCgFrCRHUIL8QM2Ab3
         hbA+i42NROFUwRj64yczHVeRXtAzTKRR2VOoxjU4S4OCvwQWxzBRdYBDnuwIgHYlCb/E
         NuLWMxK1dXi2FkDbPVqkTghioW55fhr6Fguq2CVGd9Wl08llnJP6LDe3AnV4PS0KV/E7
         AmNNaY4thc8eur+fT3YxgLJr3kvh1KPCl6SfLwX1MOQYJC96jtaCPQovaIFaNUgv/4X6
         acRRs3fUcrJw86SvfiNUybjxqaWmGp3wuJtVpjGmp/c2P0sPFqRbYTCaCtFyeDa/syo/
         H15w==
X-Gm-Message-State: AC+VfDwr2j5xR8IZhSEmTgm8GcD/nDReFZbObnwv/F/KRo5BokW/MMVh
        8kDpGBnD3ZOvJl6oEauLVNqZYb1BAGSfBJqUM4hb+auR7+p1XCP99tHA4Q==
X-Google-Smtp-Source: ACHHUZ5B/DaAcV4fbckyJd2R9kDuCJQl5kiBRpKXLS4cacoS8fEKoxQaZSafsbtdtzWYpp0ekFVusA9NhZQclOHBsF0=
X-Received: by 2002:a17:903:18e:b0:1b0:cea:2952 with SMTP id
 z14-20020a170903018e00b001b00cea2952mr200942plg.25.1686762079696; Wed, 14 Jun
 2023 10:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fU10YCxZfq=dOUUPR0dRusbq=vzp5CqsOuz1aLVY16KAw@mail.gmail.com>
 <CAP-5=fWOCE6+9MuiFziHz1o6Ej-FTDJa1fnkhYpifz7Rtazk8Q@mail.gmail.com>
In-Reply-To: <CAP-5=fWOCE6+9MuiFziHz1o6Ej-FTDJa1fnkhYpifz7Rtazk8Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 10:01:08 -0700
Message-ID: <CAP-5=fXf-FmKb=D4h5VgxQ=w3T3+Nn3AP4ExR9YjnKFB=4m7bA@mail.gmail.com>
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

Office hours reminder. A chance to discuss topics of the day and for
GSoC contributor sync.

Linux Perf Tool Office Hours
Thursday, June 15 =C2=B7 9:00 =E2=80=93 9:45am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/jds-asbo-day
Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 892=
=E2=80=AC#
More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983

Thanks,
Ian

On Wed, Jun 7, 2023 at 9:14=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Hi,
>
> Office hours and chance for GSoC contributor sync slightly earlier at
> 9am PT tomorrow:
>
> Linux Perf Tool Office Hours
> Thursday, June 8 =C2=B7 9:00 =E2=80=93 9:45am
> Time zone: America/Los_Angeles
> Google Meet joining info
> Video call link: https://meet.google.com/jds-asbo-day
> Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 892=
=E2=80=AC#
> More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983
>
> If you'd like to randomly drop in, feel free. An issue I'm keen to
> discuss is memory usage and memory leaks.
>
> Thanks,
> Ian
>
> On Wed, May 31, 2023 at 10:00=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Hi,
> >
> > On Monday the Google Summer-of-Code officially started and Anup is
> > this summer's contributor to the Linux perf tool! We've found in the
> > past [1] that having office hours is a good chance for contributors to
> > sync and also for those interested in the Linux perf tool to also
> > connect and share their problems and experiences. As such we plan on
> > running our first office hours for this summer tomorrow, the details
> > are below:
> >
> > Linux Perf Tool Office Hours
> > Thursday, June 1 =C2=B7 9:30 =E2=80=93 10:30am
> > Time zone: America/Los_Angeles
> > Google Meet joining info
> > Video call link: https://meet.google.com/jds-asbo-day
> > Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 8=
92=E2=80=AC#
> > More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983
> >
> > Please ask me and I'll be more than happy to add you to the calendar
> > invite for this. Over the summer we can adjust the timing of the
> > office hours to maximize participation, etc. so please reach out and
> > share concerns.
> >
> > Thanks,
> > Ian
> >
> > [1] https://lore.kernel.org/linux-perf-users/CAP-5=3DfWiQHvYZp5R=3Duw4x=
UwBiN1fBLBU8witPkYM+2r8tnYCOg@mail.gmail.com/
