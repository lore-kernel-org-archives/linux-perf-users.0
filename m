Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC590C76195
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Mar 2023 21:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjC0VXN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Mar 2023 17:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjC0VXM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Mar 2023 17:23:12 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AB1199C
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Mar 2023 14:23:11 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3e392e10cc4so809281cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Mar 2023 14:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679952190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjRoI5smDFcoeZZZLdNHqVEYnBY/pAEqR5TzMEq1Ja0=;
        b=d0C1QJhxVGJvSRtxxrBiw882FquqwJ8ESdpihycnd/cED5wuPSWQLWj8zMGG2wFbS8
         F4fGpRkYIfF+ylNbvVKnc0j8tPkHJ3Lm6PQO2fCnVydVqiNv3zjkvM9KEde2aDNccZJI
         hEYYkHO1b7hkQbmrss5BAtu7KlOHxPS5RZ0TwPhuFF8EI8saj0rL5FNVPoXetDu6Okd4
         iriTtRwgbfs9duYcF8OkKU4JDLTvQDQObG8OcKO5t6aw9HgV1fJq2Yk5/oYzf/Zuc0Cs
         o62LZeYkkQlCQ/J+fszUWHB0HMnGtTuPzlkm2QbLnKpSqmsnqSLkJH+KxTPCUf0cpPQX
         EYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679952190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjRoI5smDFcoeZZZLdNHqVEYnBY/pAEqR5TzMEq1Ja0=;
        b=t/BR4T9ZlEcanEf44KEigookYjsQsW3pvYEWaNFv0hzXxGvKIek2wCOjzdVkJdARwE
         rGvRdztGROra8TSoBkcM0eidVkbMq4nryUu1nnwIyjlVL8Z9Y13CkFzHKx0XFQIX36y3
         gX9d/hVBTNbnnkVKCC7mk9z5ePSeFV3gVvP+tqjAZAMirLCSFJtIoqj3sCN1jQKZt1T8
         fJeVz40KzNOx9GNBUKTMlrBcgOaHlAVU49GuBnmu5sdQiAcCPQz+03O4wZlsMzWNAFXH
         B66Rstk80Ke/751SYiQzUNMzvmuu6Idk3sJ2Tw8mWiOM6hck/zcvyIT5vGsYOPiRgaYW
         bHmQ==
X-Gm-Message-State: AAQBX9eXXF8Cfqyu9KGb/KgLP8iNoKU1fI0qkA8NigIWEWZXZyxwhPw8
        tc4PPZGvh4MBdOkItct4xcgk+n+dKJJYX8GWIhlMAQ==
X-Google-Smtp-Source: AKy350YnG7dIX3ATo3pOzQrzA/7ZJe1GUpq+j/VnTHyhvOPL1K45I5s+ivw9P5fWw0reDB/db57jAbCiwV44HaQGbFk=
X-Received: by 2002:ac8:7f14:0:b0:3d3:fd80:b06a with SMTP id
 f20-20020ac87f14000000b003d3fd80b06amr89323qtk.13.1679952190034; Mon, 27 Mar
 2023 14:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fWxF6in4vQyGuh=0kpAYEXAYZN_KobXCY=TX2oxssZ+HQ@mail.gmail.com>
 <Y7w2qshoCEjKKVlz@kernel.org> <CAP-5=fUeC2nhUhFN69+sL687csSsoi5=ZEkRH70vUy+kTiF52g@mail.gmail.com>
 <CAP-5=fVaH0p4NkKiQSxaxZnT5zR=hbwSArO2n0L7tCNZwBumKQ@mail.gmail.com> <CAP-5=fXWDPzuFrrY+uKnfoa5gO9eEfGUsbCyXB8AS7Tz0ZX=jw@mail.gmail.com>
In-Reply-To: <CAP-5=fXWDPzuFrrY+uKnfoa5gO9eEfGUsbCyXB8AS7Tz0ZX=jw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Mar 2023 14:22:58 -0700
Message-ID: <CAP-5=fVHK9VqMs=px3ZzKjinFG4t+oOZ8x2=65_jjds4DiSXLg@mail.gmail.com>
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

On Mon, Mar 13, 2023 at 9:38=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Feb 22, 2023 at 7:58=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > The Linux Foundation was selected as a GSoC organization for 2023!
> > https://summerofcode.withgoogle.com/programs/2023/organizations/the-lin=
ux-foundation
> >
> > This means we're looking for contributors until March 19th:
> > https://developers.google.com/open-source/gsoc/timeline
>
> A reminder of the GSoC timeline. Applications open in a week;
>
> * February 22 - March 19
> Potential GSoC contributors discuss application ideas with mentoring
> organizations
>
> * March 20 - 18:00 UTC
> GSoC contributor application period begins
>
> * April 4 - 18:00 UTC
> GSoC contributor application deadline
>
> Thanks,
> Ian

A reminder that the application period closes in just over a week:
https://developers.google.com/open-source/gsoc/timeline
April 4 - 18:00 UTC
GSoC contributor application deadline

Thanks,
Ian


> > Some project ideas are listed here:
> > https://wiki.linuxfoundation.org/gsoc/2023-gsoc-perf
> >
> > Please help to share!
> >
> > Thanks,
> > Ian
> >
> > (Resend in plain text because of LKML's HTML filters)
