Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4E6C6FD1D
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Mar 2023 22:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjC0WBI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Mar 2023 18:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjC0WBH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Mar 2023 18:01:07 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1C5D9
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Mar 2023 15:01:03 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3e390e23f83so868561cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Mar 2023 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679954463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljMdSk6TRD4PdNBBNsA9kpOni7PadRiImhPkkq/5oQw=;
        b=raHYuL8rzqzir790Wa0FgG2LuJQZii5jB6zN0hnOIT/s0Uo3c6jKsXpmPmBXyQDwaY
         DZASmT0xukitec8FeBpZqicRTbpJ+zB+SS9JWvQmWgUDY5T6KGVc/KuOY5BfQgM19yCL
         zBAI1ZC0/y1wN1Ipr7yF+kU8pyf3Zik+OHqL30TVx3VdqaZq4Iz3nRjfWoU4E6cXl+T4
         EH939wWeesArtZJZFs8vMOmEYFT6I0TGsjeS0Kg1Ta30iwyInqWJQB7uOMoEyRrmvIEq
         3ewF5QW4ClnGXSAkaGGXiFrFX77S/VOokOo7DcSkj9ZPYYc06CA9QetIsAUrc/21b/o1
         tIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679954463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljMdSk6TRD4PdNBBNsA9kpOni7PadRiImhPkkq/5oQw=;
        b=a8IsV1GxnA4kgtkQJ4Zo6raStavOz6LwtU+OFNYFJdcbg7YNibB/xE9VUJuziUKKZL
         2DN+UTN1br/dDpkgizHpxjZWb4NnqAp2aRG2aHVo+/+vTRqExMwIPIq7zuDok3ca6I5/
         wVQrMHfHAV+ZDGPALRVh7Jkil8niQSxMejAfDs57KiQXe137CIA45t2KiTqc3zsKtEi3
         J+vxJukQj+cbKEYpljpv/HC3Lq+Zk6F2mlxbDaPRlP1RZmGZjKrQG7M9nNiVSQZqtQNu
         lRWBq7tfp+aYj/lkuDPWkJPFZb9mB0kVLhQSE3rq1FRZuWosWNAogNZwvTJVBhhPV46m
         qwMw==
X-Gm-Message-State: AAQBX9ewQZCn5VIDW6s68RxfebtcmybVuVBetatazM2fweHetDvSyCdb
        tJjJ13Un4Sp6LmvWa2OmFEupOhwhuriHNyZ9Jo/UIA==
X-Google-Smtp-Source: AKy350bnbESywCEKdiHHoXo8xFGgMILXuYrMroNzZ2OMqAfB5rCSDiwCXYT/SgSs09hip74fuanGuy+n0jVH7E8UsPU=
X-Received: by 2002:ac8:58ca:0:b0:3db:1c01:9d95 with SMTP id
 u10-20020ac858ca000000b003db1c019d95mr150860qta.4.1679954462837; Mon, 27 Mar
 2023 15:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fWxF6in4vQyGuh=0kpAYEXAYZN_KobXCY=TX2oxssZ+HQ@mail.gmail.com>
 <Y7w2qshoCEjKKVlz@kernel.org> <CAP-5=fUeC2nhUhFN69+sL687csSsoi5=ZEkRH70vUy+kTiF52g@mail.gmail.com>
 <CAP-5=fVaH0p4NkKiQSxaxZnT5zR=hbwSArO2n0L7tCNZwBumKQ@mail.gmail.com>
 <CAP-5=fXWDPzuFrrY+uKnfoa5gO9eEfGUsbCyXB8AS7Tz0ZX=jw@mail.gmail.com> <CAP-5=fVHK9VqMs=px3ZzKjinFG4t+oOZ8x2=65_jjds4DiSXLg@mail.gmail.com>
In-Reply-To: <CAP-5=fVHK9VqMs=px3ZzKjinFG4t+oOZ8x2=65_jjds4DiSXLg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Mar 2023 15:00:51 -0700
Message-ID: <CAP-5=fUTAABzK2e_S3kFYV8jWCrHKfj10wPpTnthQjCLy7d2Gg@mail.gmail.com>
Subject: Re: Google Summer-of-Code 2023
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        paranlee <p4ranlee@gmail.com>,
        Madhu patel <patelmadhu06@gmail.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        Lukas Molleman <lukas.molleman@gmail.com>,
        n2 h9 <n2h9z4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 27, 2023 at 2:22=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Mar 13, 2023 at 9:38=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Wed, Feb 22, 2023 at 7:58=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > The Linux Foundation was selected as a GSoC organization for 2023!
> > > https://summerofcode.withgoogle.com/programs/2023/organizations/the-l=
inux-foundation
> > >
> > > This means we're looking for contributors until March 19th:
> > > https://developers.google.com/open-source/gsoc/timeline
> >
> > A reminder of the GSoC timeline. Applications open in a week;
> >
> > * February 22 - March 19
> > Potential GSoC contributors discuss application ideas with mentoring
> > organizations
> >
> > * March 20 - 18:00 UTC
> > GSoC contributor application period begins
> >
> > * April 4 - 18:00 UTC
> > GSoC contributor application deadline
> >
> > Thanks,
> > Ian
>
> A reminder that the application period closes in just over a week:
> https://developers.google.com/open-source/gsoc/timeline
> April 4 - 18:00 UTC
> GSoC contributor application deadline
>
> Thanks,
> Ian

If you are looking for ideas on how to write a good proposal, PSF has
a collection of previously accepted proposals:
https://blogs.python-gsoc.org/en/

You can also see the final report of Riccardo Mancini:
https://lore.kernel.org/lkml/3c4f8dd64d07373d876990ceb16e469b4029363f.camel=
@gmail.com/

Thanks,
Ian



>
> > > Some project ideas are listed here:
> > > https://wiki.linuxfoundation.org/gsoc/2023-gsoc-perf
> > >
> > > Please help to share!
> > >
> > > Thanks,
> > > Ian
> > >
> > > (Resend in plain text because of LKML's HTML filters)
