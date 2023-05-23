Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F66C7EE23
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 May 2023 15:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbjEWP6l (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 May 2023 11:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjEWP6k (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 May 2023 11:58:40 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10488E
        for <linux-perf-users@vger.kernel.org>; Tue, 23 May 2023 08:58:39 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-33164ec77ccso194415ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 May 2023 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684857519; x=1687449519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNkJynt8qDKBfQ/oFx50TB7QMzJm3azmQ7NoIooJQy8=;
        b=YZM11sWvc76h7ZrCTPscqzsAAzgrWNxhLbQMqlf6cZZK7w8jDavW1i4e2N3VoIFFD1
         8aYtigM693xiIa7YPiUXRoYs8Yj365X+4ghMfycyr5o48ZIVT3Pj+JuDYw9wG6SggD/A
         ve9OSikJL6WEf1L2DR0TnN/pKob+kZsbA6qbyo5DyYcWqKa2Ji56ppdRMi0UY04Jus21
         WxJDUU/gKgMrn+A7sREm85s16WpN6g8paONF/S4G+RBMH18XqXjU9AuT8B1yQ7vNi0d/
         FsfJkW09pBT8+R1MV1NYXlklNhVyNDAlB9693gDU2+V6X+egb6YPXjilso6q+Ff/mUD7
         0CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684857519; x=1687449519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNkJynt8qDKBfQ/oFx50TB7QMzJm3azmQ7NoIooJQy8=;
        b=KeeD8PMAADP2jcme4+dLmgjMUjuUzzPjcvSlyfTk/0OSJ3s0KDXOUHFMxcidwgfbv3
         uHO+kO7Vgm59n+BmsmK1G5sSSFbiCyaKUUjN9ljI4cWQgQRWFlJY70hBI0uUvmBkZ7o3
         ctsTuqHXeNl1edHhabZ58Zmyq3cAt69OEoaV+DByFuXSW89sufxb8/1wbTZx6YNfaSHC
         9P86kpaBs6IxuU5miXIvmJlnZcGmaYWCyIB2Rec9XhI4BYlzPtO4MzHpHTkoilwMkOTT
         XyCGw0VnqRTiJ2RezmnLSIbaqGJBC9lnT5M+qjNnXbCw4eFTnN7k2yidy8wZMLRfGuQo
         LY4A==
X-Gm-Message-State: AC+VfDyZvqWYj7MZS+LLYpnIrccjEgnhjicJyCjUQEzr9YLojtfOxkOR
        iRi1dWscdVyKJZOjhNh8nHdYIZMGqnEDy0WmBXW9aw==
X-Google-Smtp-Source: ACHHUZ5gaAp5Kz27B7HqGcDH9jesRpudZLW5fQcRS1IQa1QZX3FlgQzlnKR3Vd8LxgZrhUcR/nUW28EWAOYFn3fHis8=
X-Received: by 2002:a05:6e02:18c7:b0:335:5940:5ca6 with SMTP id
 s7-20020a056e0218c700b0033559405ca6mr212858ilu.13.1684857518825; Tue, 23 May
 2023 08:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230517173805.602113-1-irogers@google.com> <20230517173805.602113-15-irogers@google.com>
 <ZGzYroXZUsPTNZVE@kernel.org>
In-Reply-To: <ZGzYroXZUsPTNZVE@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 23 May 2023 08:58:25 -0700
Message-ID: <CAP-5=fXKvhqySuomqHU5FMh17N=R-TVoJgLEWU=UgM+HVhSdLQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] perf jevents: Add support for metricgroup descriptions
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 23, 2023 at 8:16=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, May 17, 2023 at 10:38:03AM -0700, Ian Rogers escreveu:
> > Metrics have a field where the groups they belong to are listed like
> > the following from
> > tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json:
> >
> >         "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> >         "MetricName": "tma_frontend_bound",
>
>   LD      /tmp/build/perf-tools-next/util/perf-in.o
>   LD      /tmp/build/perf-tools-next/perf-in.o
>   CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
> In file included from /var/home/acme/git/perf-tools-next/tools/include/li=
nux/bitmap.h:9,
>                  from /var/home/acme/git/perf-tools-next/tools/perf/util/=
header.h:10,
>                  from /tmp/build/perf-tools-next/pmu-events/pmu-events.c:=
3:
> /tmp/build/perf-tools-next/pmu-events/pmu-events.c: In function =E2=80=98=
describe_metricgroup=E2=80=99:
> /var/home/acme/git/perf-tools-next/tools/include/linux/kernel.h:102:25: e=
rror: overflow in conversion from =E2=80=98long unsigned int=E2=80=99 to =
=E2=80=98int=E2=80=99 changes value from =E2=80=9818446744073709551615=E2=
=80=99 to =E2=80=98-1=E2=80=99 [-Werror=3Doverflow]
>   102 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_=
be_array(arr))
>       |                         ^
> /tmp/build/perf-tools-next/pmu-events/pmu-events.c:61603:29: note: in exp=
ansion of macro =E2=80=98ARRAY_SIZE=E2=80=99
> 61603 |         int low =3D 0, high =3D ARRAY_SIZE(metricgroups) - 1;
>       |                             ^~~~~~~~~~
> cc1: all warnings being treated as errors
> make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.bui=
ld:98: /tmp/build/perf-tools-next/pmu-events/pmu-events.o] Error 1
> make[2]: *** [Makefile.perf:679: /tmp/build/perf-tools-next/pmu-events/pm=
u-events-in.o] Error 2
> make[1]: *** [Makefile.perf:236: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'
>
>  Performance counter stats for 'make -k BUILD_BPF_SKEL=3D1 CORESIGHT=3D1 =
O=3D/tmp/build/perf-tools-next -C tools/perf install-bin':
>
>       241752971879      cycles:u
>       296060193784      instructions:u                   #    1.22  insn =
per cycle
>
>        6.129451072 seconds time elapsed
>
>       59.018259000 seconds user
>       12.132871000 seconds sys
>
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ fg
> git rebase -i HEAD~15
>
> [1]+  Stopped                 git rebase -i HEAD~15
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git log --oneline -1
> 995a2beaa64deb7b (HEAD) perf jevents: Add support for metricgroup descrip=
tions
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> Applied 1-13, pushing to tmp.perf-tools-next,
>
> - Arnaldo

Thanks, there's a missing (int) cast on ARRAY_SIZE. It doesn't make
sense to resend the entire series so I'll wait to rebase, add the cast
and then resend in v2 - that's unless you beat me to it ;-)

Ian
