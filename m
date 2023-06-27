Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF7BEB64DD
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jun 2023 16:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjF0QnP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Jun 2023 12:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjF0QnO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jun 2023 12:43:14 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC390CA
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 09:43:12 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-34292a63a13so2745ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 09:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687884192; x=1690476192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd+gLHYQ1AoomQaxFmG+4g614Pp8bCTvfSrZgBja4D0=;
        b=s3I0ZZUq41/3bkANZ5KYntfmHbG4p0O/HfbuiWMRtN51MfnHUKnfW4oXgNxzv6DFw0
         5N40mdH9YD0X3dJCGJi6NB2OrwOoU6MX4PfoTvQ+R2+0WTQpIZkVQBsayH4I/O78+uUd
         zg8nnBTLnnEt1e9PHxLzw1HJ1tEg8ANTPlHUNfP/YN5IXTqALw1cOB3NewqEGTnsAq9M
         Gg7cL97mgOZbTWpXxWXV0p/JntnXhTLui/6uOlMKnBfqdmJ/9b2GOt6Vb3Sj5/btWjV9
         qyjxaHoilYa9DzTyKw8wP2BqqPmABCrB8mUONyNB9rggS1/edGy6/zQYYqIcsE4wWYUM
         ly4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687884192; x=1690476192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd+gLHYQ1AoomQaxFmG+4g614Pp8bCTvfSrZgBja4D0=;
        b=dLW+Sckq8HUL1epCMPe9rUvhJO4RZ35obrya9KgvA1LAlaos9O8UucWqLkeWDQ1iN5
         bLI2CR+QMFI5s68DrVuI39tht1Q9iSRJ+Vrs1g1p1rdVXs4NMGeHp1z94i1kSNyH3dtx
         MpBwj6lpIahn4YQHC0myZ23y2EKGZ/zB/8ZGSvSeOrMs97L/m3pfCk6tYpCvuNuPwvkF
         x+L+/tjOnsZexJYAIsmaHMWpJAj087Dz428q82XjZxAHFqzYIH6xivwACP4qAdXOt7Vk
         x1tK9cG3t691RJAY3Tw7+b+14xHyRiU1bVyUapqkCgYblz/1RAsQ/+LMfMHOpWD6f5Gz
         n+XQ==
X-Gm-Message-State: AC+VfDxp4hB1G9VAJGIjzDT12sU/VY+waI3+ijrpt5W65jKrcYvTBvAY
        cEy2mzL6R0iKoqZWWlUlp5DHC147MybGmDQbL4ujFQ==
X-Google-Smtp-Source: ACHHUZ4zf4Hxtt1rbBisEBTD69na8j98wh/gboVZ/9Jzb7K+VyWXv0MjEDalCiq5CrPIk8DoXi/IHgVVOQPGaGsI6lc=
X-Received: by 2002:a05:6e02:218b:b0:33d:8608:7596 with SMTP id
 j11-20020a056e02218b00b0033d86087596mr698518ila.15.1687884192170; Tue, 27 Jun
 2023 09:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230626161059.324046-1-james.clark@arm.com> <20230626161059.324046-3-james.clark@arm.com>
 <ZJonE3ZZ2cBUq0U8@google.com>
In-Reply-To: <ZJonE3ZZ2cBUq0U8@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 27 Jun 2023 09:42:58 -0700
Message-ID: <CAP-5=fX+FDAkFoMhQY27_+fiRp_UDruP8qWTdjvqU5-uE0SdWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf report: Don't add to histogram when there is no
 thread found
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 26, 2023 at 5:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Jun 26, 2023 at 05:10:58PM +0100, James Clark wrote:
> > thread__find_map() chooses to exit without assigning a thread to the
> > addr_location in some scenarios, for example when there are samples fro=
m
> > a guest and perf_guest =3D=3D false. This results in a segfault when ad=
ding
> > to the histogram because it uses unguarded accesses to the thread membe=
r
> > of the addr_location.
>
> Looking at the commit 0dd5041c9a0ea ("perf addr_location: Add
> init/exit/copy functions") that introduced the change, I'm not sure if
> it's the intend behavior.
>
> It might change maps and map, but not thread.  Then I think no reason
> to not set the al->thread at the beginning.
>
> How about this?  Ian?
> (I guess we can get rid of the duplicate 'al->map =3D NULL' part)

It seemed strange that we were failing to find a map (the function's
purpose) but then populating the address_location. The change below
brings back that somewhat odd behavior. I'm okay with reverting to the
old behavior, clearly there were users relying on it. We should
probably also copy maps and not just thread, as that was the previous
behavior.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> ---8<---
>
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 3860b0c74829..4cbb092e0684 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -581,15 +581,14 @@ struct map *thread__find_map(struct thread *thread,=
 u8 cpumode, u64 addr,
>         maps__zput(al->maps);
>         map__zput(al->map);
>         thread__zput(al->thread);
> +       al->thread =3D thread__get(thread);
>
>         al->addr =3D addr;
>         al->cpumode =3D cpumode;
>         al->filtered =3D 0;
>
> -       if (machine =3D=3D NULL) {
> -               al->map =3D NULL;
> +       if (machine =3D=3D NULL)
>                 return NULL;
> -       }
>
>         if (cpumode =3D=3D PERF_RECORD_MISC_KERNEL && perf_host) {
>                 al->level =3D 'k';
> @@ -605,7 +604,6 @@ struct map *thread__find_map(struct thread *thread, u=
8 cpumode, u64 addr,
>                 al->level =3D 'u';
>         } else {
>                 al->level =3D 'H';
> -               al->map =3D NULL;
>
>                 if ((cpumode =3D=3D PERF_RECORD_MISC_GUEST_USER ||
>                         cpumode =3D=3D PERF_RECORD_MISC_GUEST_KERNEL) &&
> @@ -619,7 +617,6 @@ struct map *thread__find_map(struct thread *thread, u=
8 cpumode, u64 addr,
>                 return NULL;
>         }
>         al->maps =3D maps__get(maps);
> -       al->thread =3D thread__get(thread);
>         al->map =3D map__get(maps__find(maps, al->addr));
>         if (al->map !=3D NULL) {
>                 /*
