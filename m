Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FB1C76196
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Apr 2023 15:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjDCP5m (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Apr 2023 11:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjDCP5b (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Apr 2023 11:57:31 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7F73C24
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Apr 2023 08:57:02 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3e392e10cc4so1211611cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Apr 2023 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680537420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RL7+7L2nykApN9Uu3qr1Vlz4J5VLm0XSe5hWatHC2UA=;
        b=RvusrN5Grx0iSSZ1EitY9Ozul7j3yF2w2pelTCj9ingDDaNXluye819rbmn54bduOy
         mb9J+2MPN30EHgXolrhZyxSskXx18K9q8K/YqVWTU6zXe80O+3TJ7exICT3C9bvUemLx
         1gg96EkQl5bJdaUikm2d3iAqpDk7TZ5BGU03x7CzPMzrE4M3fzkdAazrb9KvqcscI3MT
         soymh5l0VN9Elo5iEVyP+ovOoq0QHQPldydzgb2D9+D6SyIMKh5oZToeoXYg7npzaF5G
         DnFCTOyEkHH655GjFWG4pYCN6R0p52LEBZQjdAYVC6wfYXE453OO5h/aISmK3M7k6SjF
         i/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680537420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RL7+7L2nykApN9Uu3qr1Vlz4J5VLm0XSe5hWatHC2UA=;
        b=vwG4uZmIvNGTYlrFrCfWEgjoqXh6X/SuLvlZdcENzK4VDAD9JgDWZtz5CgLKB6q3ZB
         0CtEmHx+Inhm27mrA9gXCy70XLnABdnnoibmosOyT5K5F8O5fzBm1LrLrnvTxo3ZE+Ud
         PZ0ebNkN3sT4I/fFI2NkWq8FMivbwX9RKQFcIhmUWijMIfr1IHLxECQUYUpAx+zpKw8K
         LcaONb6/99fjQL44DsC6dc+ra0bNQZoFli5S7K+EGogvW72YZi3HAzVIsOtHKkLeGVRz
         QTzsXpQZnNX9SeYyPPM/4BGiRDX9uvLSUj7PACz7z/sWKd4svPvCCuLvHpT5vNx045Vv
         d4qg==
X-Gm-Message-State: AAQBX9dodcmhKMtc7B17JL3BzefKy0L6TO6f2M9QgFn32CsVBwdBQYJd
        ocKscb/qiG4inkSyY561oEW2pE/gCy0wWpmA9gRPF0b/JiqByd3Kysc=
X-Google-Smtp-Source: AKy350ap9pELEFkSHtmBKd6EJjD2gLVI9H1B0gyBQzpEjTNYD0Z/tjQrI1rxRpI/cJb66ymxQwqn8yZnd0JVjy9HOj4=
X-Received: by 2002:a05:622a:c:b0:3b9:f696:c759 with SMTP id
 x12-20020a05622a000c00b003b9f696c759mr638521qtw.10.1680537420407; Mon, 03 Apr
 2023 08:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fWxF6in4vQyGuh=0kpAYEXAYZN_KobXCY=TX2oxssZ+HQ@mail.gmail.com>
 <Y7w2qshoCEjKKVlz@kernel.org> <CAP-5=fUeC2nhUhFN69+sL687csSsoi5=ZEkRH70vUy+kTiF52g@mail.gmail.com>
 <CAP-5=fVaH0p4NkKiQSxaxZnT5zR=hbwSArO2n0L7tCNZwBumKQ@mail.gmail.com>
 <CAP-5=fXWDPzuFrrY+uKnfoa5gO9eEfGUsbCyXB8AS7Tz0ZX=jw@mail.gmail.com>
 <CAP-5=fVHK9VqMs=px3ZzKjinFG4t+oOZ8x2=65_jjds4DiSXLg@mail.gmail.com> <CAP-5=fUTAABzK2e_S3kFYV8jWCrHKfj10wPpTnthQjCLy7d2Gg@mail.gmail.com>
In-Reply-To: <CAP-5=fUTAABzK2e_S3kFYV8jWCrHKfj10wPpTnthQjCLy7d2Gg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 3 Apr 2023 08:56:47 -0700
Message-ID: <CAP-5=fXdgbJNms5Hy5tw_UxwAeaxn2QCtCphFc4nosEcA92tVw@mail.gmail.com>
Subject: Re: Google Summer-of-Code 2023
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        paranlee <p4ranlee@gmail.com>,
        Madhu patel <patelmadhu06@gmail.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        Lukas Molleman <lukas.molleman@gmail.com>,
        n2 h9 <n2h9z4@gmail.com>, can.kucukaslan@ug.bilkent.edu.tr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 27, 2023 at 3:00=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Mar 27, 2023 at 2:22=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Mon, Mar 13, 2023 at 9:38=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Wed, Feb 22, 2023 at 7:58=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > The Linux Foundation was selected as a GSoC organization for 2023!
> > > > https://summerofcode.withgoogle.com/programs/2023/organizations/the=
-linux-foundation
> > > >
> > > > This means we're looking for contributors until March 19th:
> > > > https://developers.google.com/open-source/gsoc/timeline
> > >
> > > A reminder of the GSoC timeline. Applications open in a week;
> > >
> > > * February 22 - March 19
> > > Potential GSoC contributors discuss application ideas with mentoring
> > > organizations
> > >
> > > * March 20 - 18:00 UTC
> > > GSoC contributor application period begins
> > >
> > > * April 4 - 18:00 UTC
> > > GSoC contributor application deadline
> > >
> > > Thanks,
> > > Ian
> >
> > A reminder that the application period closes in just over a week:
> > https://developers.google.com/open-source/gsoc/timeline
> > April 4 - 18:00 UTC
> > GSoC contributor application deadline
> >
> > Thanks,
> > Ian
>
> If you are looking for ideas on how to write a good proposal, PSF has
> a collection of previously accepted proposals:
> https://blogs.python-gsoc.org/en/
>
> You can also see the final report of Riccardo Mancini:
> https://lore.kernel.org/lkml/3c4f8dd64d07373d876990ceb16e469b4029363f.cam=
el@gmail.com/
>
> Thanks,
> Ian

A reminder that the GSoC application deadline is tomorrow.

Thanks,
Ian

>
>
> >
> > > > Some project ideas are listed here:
> > > > https://wiki.linuxfoundation.org/gsoc/2023-gsoc-perf
> > > >
> > > > Please help to share!
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > (Resend in plain text because of LKML's HTML filters)
