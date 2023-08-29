Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9801BC71153
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Aug 2023 19:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbjH2TDw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Aug 2023 15:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239598AbjH2TDj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Aug 2023 15:03:39 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596381BE
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Aug 2023 12:03:36 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-407db3e9669so55761cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Aug 2023 12:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693335815; x=1693940615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iyjv+xG6FAuUSXvFBzJTJDnPCJ6wikudc5tFgMXi6Ws=;
        b=kS79yL5vMJ195sjJkASsPZ6h5ATRB6wqDL9o0jpo+MoqR6cBXTIsU5Um7NVCd9ZJv2
         pWqEwJbJOS3VlfkmEgSBHrIn0ZcBmzBFURxBemfFd/530+uTIfDlDZjgcDw8ANGMuVDV
         P+kEzNIXlQfkEU21XCoGiRzkumdPWZAV9Nl1faSke8W1go9SednzdRBW05VvkeyHmomU
         23sEN9M3uUZG742snr+aFzdeLvtTKU6BNdVHh+QZHR6Zikucty27hWc63LMuNbdufX0i
         hRfnEExo6RYmHHOSH+zLvogy2UsBrTsSJvdTpISItRZlDtBfbsLGuK2xVefkULT4+Agv
         GVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693335815; x=1693940615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iyjv+xG6FAuUSXvFBzJTJDnPCJ6wikudc5tFgMXi6Ws=;
        b=KUQw1v5zq817ZgC/8jjH+Gr4L/8nXYSK/edL+j0Mtpu4PnWD9WhbVTwe0+r8kEEdFP
         mg6Xp24cVGPlZwe3hpdhHDcCHXHKDqtxHXihK74ccK7wSudSC7XKbMOGuXl15MWR6Syv
         zDs9b5pxSfR+R4i4HTAXAHLcPE9iVxudTodUK3KM51q7/qydsO9+N6qrFbb02GEa4rNS
         jhfGXTnpoRsC2lUkwnUchLbtrvoOohBvp5yq+dV8n0/leQ5n0IarNvya6iCd2t1auvOC
         JcBa6muRTobYfG1FZpXsdv36cpP3VOzHWBiNRzeqqKnXjot7fm8xjh0V7aFnRcQzDjwn
         i8gQ==
X-Gm-Message-State: AOJu0YyesTBhsE4k/Wh7g4lfS60xglHg6PswuaZ3X1UnqwwnI+Kle+u8
        oA9NcWYVYtsbT1iBuCA/64GaA23uI7MDpdSXS32XFg==
X-Google-Smtp-Source: AGHT+IH7E4oasKJ8MWoXSX/tKk5h3C+ddbq3aUKGPCVerr3qfoXNPlz94HgHqpifcB3kF42EmZX2rWY2IQcvBcLhZeU=
X-Received: by 2002:a05:622a:1a23:b0:3ef:5f97:258f with SMTP id
 f35-20020a05622a1a2300b003ef5f97258fmr337091qtb.16.1693335815362; Tue, 29 Aug
 2023 12:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230823075103.190565-1-kjain@linux.ibm.com> <CUZVDJPWI4GL.NVVOJTWE6U5S@naverao1-tp>
In-Reply-To: <CUZVDJPWI4GL.NVVOJTWE6U5S@naverao1-tp>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 29 Aug 2023 12:03:23 -0700
Message-ID: <CAP-5=fVOq2Md3SgtkBqn7q2ydCqe_=mFwF18+hR8Ex+=phJacw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip perf bench breakpoint run if no
 breakpoints available
To:     Naveen N Rao <naveen@kernel.org>
Cc:     Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        disgoel@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com,
        Disha Goel <disgoel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 23, 2023 at 4:00=E2=80=AFAM Naveen N Rao <naveen@kernel.org> wr=
ote:
>
> Hi Kajol,
>
> On Wed Aug 23, 2023 at 1:21 PM IST, Kajol Jain wrote:
> > Based on commit 7d54a4acd8c1 ("perf test: Skip watchpoint
> > tests if no watchpoints available"), hardware breakpoints
> > are not available for power9 platform and because of that
> > perf bench breakpoint run fails on power9 platform.
> > Add code to check for the return value of perf_event_open()
> > in breakpoint run and skip the perf bench breakpoint run,
> > if hardware breakpoints are not available.
> >
> > Result on power9 system before patch changes:
> > [command]# perf bench breakpoint thread
> > perf_event_open: No such device
> >
> > Result on power9 system after patch changes:
> > [command]# ./perf bench breakpoint thread
> > Skipping perf bench breakpoint thread: No hardware support
> >
> > Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
> > Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> > ---
> >  tools/perf/bench/breakpoint.c | 24 +++++++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
>
> Thanks for fixing this to not report an error. A minor nit below, but
> otherwise:
> Acked-by: Naveen N Rao <naveen@kernel.org>
>
> >
> > diff --git a/tools/perf/bench/breakpoint.c b/tools/perf/bench/breakpoin=
t.c
> > index 41385f89ffc7..dfd18f5db97d 100644
> > --- a/tools/perf/bench/breakpoint.c
> > +++ b/tools/perf/bench/breakpoint.c
> > @@ -47,6 +47,7 @@ struct breakpoint {
> >  static int breakpoint_setup(void *addr)
> >  {
> >       struct perf_event_attr attr =3D { .size =3D 0, };
> > +     int fd;
> >
> >       attr.type =3D PERF_TYPE_BREAKPOINT;
> >       attr.size =3D sizeof(attr);
> > @@ -56,7 +57,12 @@ static int breakpoint_setup(void *addr)
> >       attr.bp_addr =3D (unsigned long)addr;
> >       attr.bp_type =3D HW_BREAKPOINT_RW;
> >       attr.bp_len =3D HW_BREAKPOINT_LEN_1;
> > -     return syscall(SYS_perf_event_open, &attr, 0, -1, -1, 0);
> > +     fd =3D syscall(SYS_perf_event_open, &attr, 0, -1, -1, 0);
> > +
> > +     if (fd < 0)
> > +             fd =3D -errno;
> > +
> > +     return fd;
> >  }
> >
> >  static void *passive_thread(void *arg)
> > @@ -122,8 +128,14 @@ int bench_breakpoint_thread(int argc, const char *=
*argv)
> >
> >       for (i =3D 0; i < thread_params.nbreakpoints; i++) {
> >               breakpoints[i].fd =3D breakpoint_setup(&breakpoints[i].wa=
tched);
> > -             if (breakpoints[i].fd =3D=3D -1)
> > +
> > +             if (breakpoints[i].fd < 0) {
> > +                     if (breakpoints[i].fd =3D=3D -ENODEV) {
> > +                             printf("Skipping perf bench breakpoint th=
read: No hardware support\n");
> > +                             return 0;
>
> Should we instead do 'exit(0)' here to stop further benchmarks? Perhaps:
>   err(EXIT_SUCCESS, "Skipping perf bench breakpoint thread: No hardware s=
upport");
>
> EXIT_SUCCESS looks weird, but should help document that this is not an
> error.

In tools/perf/tests/tests.h is:

enum {
       TEST_OK   =3D  0,
       TEST_FAIL =3D -1,
       TEST_SKIP =3D -2,
};

So I think the EXIT_SUCCESS/0 should really be TEST_OK, but I think it
would clearer if these cases were TEST_SKIP.

Thanks,
Ian

> > +                     }
> >                       exit((perror("perf_event_open"), EXIT_FAILURE));
> > +             }
> >       }
> >       gettimeofday(&start, NULL);
> >       for (i =3D 0; i < thread_params.nparallel; i++) {
> > @@ -196,8 +208,14 @@ int bench_breakpoint_enable(int argc, const char *=
*argv)
> >               exit(EXIT_FAILURE);
> >       }
> >       fd =3D breakpoint_setup(&watched);
> > -     if (fd =3D=3D -1)
> > +
> > +     if (fd < 0) {
> > +             if (fd =3D=3D -ENODEV) {
> > +                     printf("Skipping perf bench breakpoint enable: No=
 hardware support\n");
> > +                     return 0;
>
> Here too.
>
> - Naveen
>
> > +             }
> >               exit((perror("perf_event_open"), EXIT_FAILURE));
> > +     }
> >       nthreads =3D enable_params.npassive + enable_params.nactive;
> >       threads =3D calloc(nthreads, sizeof(threads[0]));
> >       if (!threads)
>
