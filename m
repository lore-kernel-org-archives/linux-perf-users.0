Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3212C6FD19
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 16:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjCMQiy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 12:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCMQid (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 12:38:33 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89AA29E0B
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 09:38:22 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h7so7230739ila.5
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 09:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678725502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUBPIHS7V4Q1J3EDjJkhS4iBtdM7mneCmDYx2gD8EE4=;
        b=EYLuGvnXzray12IPhIFwaWr41OwuQ8LHrNB4RFiJKBMZw7DKHMGdZoqPQGab93b2My
         uGsYP2d1YF449FVNq4ipp9zwWu2qYiAyqcd/y9FuiRNkc/lBvi5tpFHe5B7pOuPPM0EN
         lDP8ajZc/RZ+S9p6NMA8xVr3LE3bmqAYeykLsCE56E7ujqa2QipVZJSK2rBEpmLWIdl5
         Ab+n56fZynvLZjtKjHMTMOdRH4DICNkPDN7ENMtpjGeeVWnWkcOx01n+jv3EsU8x0zHR
         NQ4KRnwW+mwl3ytV6fYEcTfseVL8BwgAO7RRBxOHCNaNAGkvi0TUvoU82TOYcQjfVqGl
         p1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678725502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUBPIHS7V4Q1J3EDjJkhS4iBtdM7mneCmDYx2gD8EE4=;
        b=FIhO9vbeEVjU5Lik+uzXXISmF3ZXiEj8pVsorwKYRfrAExTzHxFWHGoOmjLQhY8BX6
         MtuLs5WZd9XUYyJ/ammRmd/vcQvOSx5YZMmvT3MrlKZqBTuMabVxvVxlYC0ec0X7fYkU
         9FrRl6c5j7M/h/iRSFHFIvtKybEXjlNxlZsrBKg4P2KZYH3GiK00wud9IUzhF2P5vyBp
         rg9GvBDF8qcMxoP/Tp/3KEHSUk8ED27oo8YVotdKJD+y9Wxd4XHzHoHstBDrjRev1Z6K
         YdHbAhWCpnIa+tsJvdJyRHP1MvW0hG/TPa5EAdWbl3s9FlbnUpv4vmQOXCUmYiO341CM
         +GJg==
X-Gm-Message-State: AO0yUKW4hciXdA4wfkkaB2uemOchzPx31f1a3hHqg1Oj3PSD/YDLJt6n
        MlZzqNhwjYQDxhUWgVFEDy84qFwlaZCGm0q6n4Qp7g==
X-Google-Smtp-Source: AK7set//MiSR1y0fInfR6CmYoF+xGcuyeneWkLRWCEDxxFJo+xHqYWalC5eD2RviS7mBu1Ae0FMF4LD2qwwBmOhU5OE=
X-Received: by 2002:a92:cb49:0:b0:313:fa72:d9aa with SMTP id
 f9-20020a92cb49000000b00313fa72d9aamr193949ilq.0.1678725501894; Mon, 13 Mar
 2023 09:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fWxF6in4vQyGuh=0kpAYEXAYZN_KobXCY=TX2oxssZ+HQ@mail.gmail.com>
 <Y7w2qshoCEjKKVlz@kernel.org> <CAP-5=fUeC2nhUhFN69+sL687csSsoi5=ZEkRH70vUy+kTiF52g@mail.gmail.com>
 <CAP-5=fVaH0p4NkKiQSxaxZnT5zR=hbwSArO2n0L7tCNZwBumKQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVaH0p4NkKiQSxaxZnT5zR=hbwSArO2n0L7tCNZwBumKQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Mar 2023 09:38:10 -0700
Message-ID: <CAP-5=fXWDPzuFrrY+uKnfoa5gO9eEfGUsbCyXB8AS7Tz0ZX=jw@mail.gmail.com>
Subject: Re: Google Summer-of-Code 2023
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        paranlee <p4ranlee@gmail.com>,
        Madhu patel <patelmadhu06@gmail.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        Lukas Molleman <lukas.molleman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Feb 22, 2023 at 7:58=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> The Linux Foundation was selected as a GSoC organization for 2023!
> https://summerofcode.withgoogle.com/programs/2023/organizations/the-linux=
-foundation
>
> This means we're looking for contributors until March 19th:
> https://developers.google.com/open-source/gsoc/timeline

A reminder of the GSoC timeline. Applications open in a week;

* February 22 - March 19
Potential GSoC contributors discuss application ideas with mentoring
organizations

* March 20 - 18:00 UTC
GSoC contributor application period begins

* April 4 - 18:00 UTC
GSoC contributor application deadline

Thanks,
Ian

> Some project ideas are listed here:
> https://wiki.linuxfoundation.org/gsoc/2023-gsoc-perf
>
> Please help to share!
>
> Thanks,
> Ian
>
> (Resend in plain text because of LKML's HTML filters)
