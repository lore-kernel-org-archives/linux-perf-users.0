Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876E5C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 12 May 2022 08:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351273AbiELIDR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 12 May 2022 04:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242321AbiELIDP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 12 May 2022 04:03:15 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D479A2016CB
        for <linux-perf-users@vger.kernel.org>; Thu, 12 May 2022 01:03:13 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id v65so5485335oig.10
        for <linux-perf-users@vger.kernel.org>; Thu, 12 May 2022 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ow3N/Wt3SjcXP2XMyxq5Q92GuEvGsl/1ipojjcBl5+8=;
        b=S1WtSL3bYyWs8HcGVZnIZ0MYBrIQB6thgqa2Nr6B9NSnnXspGr5wNa8llV9dvbFoCb
         RDGPz9qzI/W0a8x7keH53oOK/fXQHp+cWXIlIxz2G1OauMh25+xmagfmsqllJlNF0Np4
         kL8znIwyld7pa6aE+HxO64gT0sStjPa3pk3b6AX3zjyR8FJtmOmOsLKt0+urWblJjTqX
         kTXBUE2DLHCxpXXV1Z3tJgaIaYGMsHFl2M5K4lSfT2YyyX7DvBS0D5zJ0p2cmuEguXDT
         d2pONBe7tYaNDyns3NiDMYSneziSiVrma65fLIrZ1mg+S1CmjmHicuH1XcF/q1v1piIg
         Bqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ow3N/Wt3SjcXP2XMyxq5Q92GuEvGsl/1ipojjcBl5+8=;
        b=pbbNljbIZt5zMO2QcwtVN69tzEmUQo9XSh/P32WgyfKvOGgUQaD4tr+7AHi7BKlV37
         LxaMzE/UEVOULEiy8pcBBM/L5DdYikLEvY8/MTAn2cwiRlNAW9qqKGYvIgJiUoOPBMrQ
         fqS68UKOLdHbVYHEREeK007T9uwJaHTIQWnT7aIL3L636qO1esHvrTaWkZ1CLISGMwCB
         tXq8G8BB/IXzYVXdqgy4AjQhmfI7gkvK2mGcsjijhS7419OoFBUTTvAfaofqiCACTOI2
         mWtZB1yud+qN0unKgOj/ikChTpQccQ7XvSelnqGsh/ogdpsbNUDzTs1F/ot10S6eMtNB
         uCfA==
X-Gm-Message-State: AOAM533mOQrkLS1d89+ANQA53lTaCbYT0fyk7bK8hga7gxhGsJ96Moyr
        0dcS7CVmxdg43lrmzI9yUIIM9BrEQrXN2jaG/fJOMw==
X-Google-Smtp-Source: ABdhPJxxyn4CuW2shuA+dA8BmKhULsK5X1UjrwEngz4hZeTipgbkYH5ob75IqgwtRmfTpGVUe7f8mgkHfT1WhGFP0ss=
X-Received: by 2002:a05:6808:a93:b0:326:4a90:5e2a with SMTP id
 q19-20020a0568080a9300b003264a905e2amr4511379oij.211.1652342592843; Thu, 12
 May 2022 01:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220505155745.1690906-1-dvyukov@google.com> <CAP-5=fVDs-AQvhXbZM9ksRqMdfS00Mpn8LDRZUppJb76TCkrAg@mail.gmail.com>
 <Ynv7gkbBVd9dlJRh@kernel.org> <Ynv9mm4w9YfEU5j8@kernel.org>
In-Reply-To: <Ynv9mm4w9YfEU5j8@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 12 May 2022 10:03:01 +0200
Message-ID: <CACT4Y+YQ==eY6B264Sdugf-RH8EOtywzD=4qLxwcYkJfSXT21Q@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: add breakpoint benchmarks
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, elver@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, 11 May 2022 at 20:17, Arnaldo Carvalho de Melo <acme@kernel.org> wr=
ote:
> > >
> > > Acked-by: Ian Rogers <irogers@google.com>
> >
> > Thanks, applied.
>
> But I'll add some error checks, etc, running as !root, in a toolbox in
> Fedora Silverblue produces:

Thanks!

> =E2=AC=A2[acme@toolbox perf]$ perf bench breakpoint all
> # Running breakpoint/thread benchmark...
> # Created/joined 10 threads with 1 breakpoints and 1 parallelism
>      Total time: 0.000 [sec]
>
>       54.600000 usecs/op
>       54.600000 usecs/op/cpu
>
> # Running breakpoint/enable benchmark...
> # Enabled/disabled breakpoint 10 time with 0 passive and 0 active threads
>      Total time: 0.000 [sec]
>
>        1.100000 usecs/op
>
> =E2=AC=A2[acme@toolbox perf]$
>
> =E2=AC=A2[acme@toolbox perf]$ perf bench --repeat=3D20000 breakpoint enab=
le --passive=3D224 --active=3D0
> # Running 'breakpoint/enable' benchmark:
> # Enabled/disabled breakpoint 20000 time with 224 passive and 0 active th=
reads
>      Total time: 8.933 [sec]
>
>      446.674950 usecs/op
> =E2=AC=A2[acme@toolbox perf]$
>
> $ grep -m1 "model name" /proc/cpuinfo
> model name      : AMD Ryzen 9 5950X 16-Core Processor
>
> Diff:
>
> diff --git a/tools/perf/bench/breakpoint.c b/tools/perf/bench/breakpoint.=
c
> index 56936fea246d73c2..d2c074bba06a3d1f 100644
> --- a/tools/perf/bench/breakpoint.c
> +++ b/tools/perf/bench/breakpoint.c
> @@ -83,6 +83,9 @@ static void *breakpoint_thread(void *arg)
>         pthread_t *threads;
>
>         threads =3D calloc(thread_params.nthreads, sizeof(threads[0]));
> +       if (!threads)
> +               exit((perror("calloc"), EXIT_FAILURE));
> +
>         while (__atomic_fetch_sub(repeat, 1, __ATOMIC_RELAXED) > 0) {
>                 done =3D 0;
>                 for (i =3D 0; i < thread_params.nthreads; i++) {
> @@ -114,6 +117,9 @@ int bench_breakpoint_thread(int argc, const char **ar=
gv)
>         }
>         breakpoints =3D calloc(thread_params.nbreakpoints, sizeof(breakpo=
ints[0]));
>         parallel =3D calloc(thread_params.nparallel, sizeof(parallel[0]))=
;
> +       if (!breakpoints || !parallel)
> +               exit((perror("calloc"), EXIT_FAILURE));
> +
>         for (i =3D 0; i < thread_params.nbreakpoints; i++) {
>                 breakpoints[i].fd =3D breakpoint_setup(&breakpoints[i].wa=
tched);
>                 if (breakpoints[i].fd =3D=3D -1)
> @@ -194,6 +200,9 @@ int bench_breakpoint_enable(int argc, const char **ar=
gv)
>                 exit((perror("perf_event_open"), EXIT_FAILURE));
>         nthreads =3D enable_params.npassive + enable_params.nactive;
>         threads =3D calloc(nthreads, sizeof(threads[0]));
> +       if (!threads)
> +               exit((perror("calloc"), EXIT_FAILURE));
> +
>         for (i =3D 0; i < nthreads; i++) {
>                 if (pthread_create(&threads[i], NULL,
>                         i < enable_params.npassive ? passive_thread : act=
ive_thread, &done))
